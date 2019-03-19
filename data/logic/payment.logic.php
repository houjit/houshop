<?php
// +----------------------------------------------------------------------
// | HOUCMS [ 厚典科技 专注建站 APP PC 微站 小程序 WAP ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006~2017 http://www.houjit.com All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: Amos <447107108@qq.com> http://www.houjit.com
// +----------------------------------------------------------------------
// | 后台控制器
// +----------------------------------------------------------------------
defined('INSYSVIEW') or exit('Access Invalid!');
class paymentLogic
{
    public function getRealOrderInfo($pay_sn, $member_id = NULL)
    {
        $model_order = Model('order');
        $condition = array();
        $condition['pay_sn'] = $pay_sn;
        if (!(empty($member_id)))
        {
            $condition['buyer_id'] = $member_id;
        }
        $order_pay_info = $model_order->getOrderPayInfo($condition, true);
        if (empty($order_pay_info))
        {
            return callback(false, '该支付单不存在');
        }
        $order_pay_info['subject'] = '实物订单_' . $order_pay_info['pay_sn'];
        $order_pay_info['order_type'] = 'real_order';
        $condition = array();
        $condition['pay_sn'] = $pay_sn;
        $condition['order_state'] = array( 'in', array(ORDER_STATE_NEW, ORDER_STATE_PAY) );
        $order_list = $model_order->getOrderList($condition, '', '*', '', '', array(), true);
        $result = $this->getOrderExtendList($order_list);
        if (!($result['state']))
        {
            return $result;
        }
        $order_pay_info['order_list'] = $order_list;
        $order_pay_info['if_buyer_repay'] = $result['data']['if_buyer_repay'];
        return callback(true, '', $order_pay_info);
    }
    public function getOrderExtendList(&$order_list, $role = '')
    {
        if ($order_list[0]['order_type'] == 2)
        {
            $order_info = $order_list[0];
            $result = Logic('order_book')->getOrderBookInfo($order_info);
            if (!($result['data']['if_buyer_pay']) && ($role != 'admin'))
            {
                return callback(false, '未找到需要支付的订单');
            }
            $order_list[0] = $result['data'];
            $order_list[0]['order_amount'] = $order_list[0]['pay_amount'];
            if ($result['data']['if_buyer_repay'])
            {
                $order_list[0]['order_state'] = ORDER_STATE_NEW;
            }
            if (!($order_list[0]['if_buyer_pay_lock']))
            {
                $order_list[0]['pd_amount'] = $order_list[0]['rcb_amount'] = 0;
            }
        }
        return callback(true);
    }
    public function getVrOrderInfo($order_sn, $member_id = NULL)
    {
        $model_order = Model('vr_order');
        $condition = array();
        $condition['order_sn'] = $order_sn;
        if (!(empty($member_id)))
        {
            $condition['buyer_id'] = $member_id;
        }
        $condition['order_state'] = array( 'in', array(ORDER_STATE_NEW, ORDER_STATE_PAY) );
        $order_info = $model_order->getOrderInfo($condition);
        if (empty($order_info))
        {
            return callback(false, '该订单不存在');
        }
        $order_info['subject'] = '虚拟订单_' . $order_sn;
        $order_info['order_type'] = 'vr_order';
        $order_info['pay_sn'] = $order_sn;
        return callback(true, '', $order_info);
    }
    public function getPdOrderInfo($pdr_sn, $member_id = NULL)
    {
        $model_pd = Model('predeposit');
        $condition = array();
        $condition['pdr_sn'] = $pdr_sn;
        if (!(empty($member_id)))
        {
            $condition['pdr_member_id'] = $member_id;
        }
        $order_info = $model_pd->getPdRechargeInfo($condition);
        if (empty($order_info))
        {
            return callback(false, '该订单不存在');
        }
        $order_info['subject'] = '预存款充值_' . $order_info['pdr_sn'];
        $order_info['order_type'] = 'pd_order';
        $order_info['pay_sn'] = $order_info['pdr_sn'];
        $order_info['api_pay_amount'] = $order_info['pdr_amount'];
        return callback(true, '', $order_info);
    }
    public function getPaymentInfo($payment_code)
    {
        if (in_array($payment_code, array('offline', 'predeposit')) || empty($payment_code))
        {
            return callback(false, '系统不支持选定的支付方式');
        }
        $model_payment = Model('payment');
        $condition = array();
        $condition['payment_code'] = $payment_code;
        $payment_info = $model_payment->getPaymentOpenInfo($condition);
        if (empty($payment_info))
        {
            return callback(false, '系统不支持选定的支付方式');
        }
        $ifeiwa_file = BASE_PATH . DS . 'api' . DS . 'payment' . DS . $payment_info['payment_code'] . DS . $payment_info['payment_code'] . '.php';
        if (!(file_exists($ifeiwa_file)))
        {
            return callback(false, '系统不支持选定的支付方式');
        }
        require_once $ifeiwa_file;
        $payment_info['payment_config'] = unserialize($payment_info['payment_config']);
        return callback(true, '', $payment_info);
    }
    public function updateRealOrder($out_trade_no, $payment_code, $order_list, $trade_no)
    {
        $post['payment_code'] = $payment_code;
        $post['trade_no'] = $trade_no;
        return Logic('order')->changeOrderReceivePay($order_list, 'system', '系统', $post);
    }
    public function updateVrOrder($out_trade_no, $payment_code, $order_info, $trade_no)
    {
        $post['payment_code'] = $payment_code;
        $post['trade_no'] = $trade_no;
        return Logic('vr_order')->changeOrderStatePay($order_info, 'system', $post);
    }
    public function updatePdOrder($out_trade_no, $trade_no, $payment_info, $recharge_info)
    {
        $condition = array();
        $condition['pdr_sn'] = $recharge_info['pdr_sn'];
        $condition['pdr_payment_state'] = 0;
        $update = array();
        $update['pdr_payment_state'] = 1;
        $update['pdr_payment_time'] = TIMESTAMP;
        $update['pdr_payment_code'] = $payment_info['payment_code'];
        $update['pdr_payment_name'] = $payment_info['payment_name'];
        $update['pdr_trade_sn'] = $trade_no;
        $model_pd = Model('predeposit');
        try
        {
            $model_pd->beginTransaction();
            $state = $model_pd->editPdRecharge($update, $condition);
            if (!($state))
            {
                throw new Exception('更新充值状态失败');
            }
            $data = array();
            $data['member_id'] = $recharge_info['pdr_member_id'];
            $data['member_name'] = $recharge_info['pdr_member_name'];
            $data['amount'] = $recharge_info['pdr_amount'];
            $data['pdr_sn'] = $recharge_info['pdr_sn'];
            $model_pd->changePd('recharge', $data);
            $model_pd->commit();
            return callback(true);
        }
        catch (Exception $e)
        {
            $model_pd->rollback();
            return callback(false, $e->getMessage());
        }
        $model_pd->rollback();
        return callback(false, $e->getMessage());
    }
}
?>