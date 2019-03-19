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
class vr_orderLogic
{
    public function changeOrderStateCancel($order_info, $role, $msg, $if_queue = true)
    {
        try
        {
            $model_vr_order = Model('vr_order');
            $model_vr_order->beginTransaction();
            $result = Logic('queue')->cancelOrderUpdateStorage(array($order_info['goods_id'] => $order_info['goods_num']));
            if (!($result['state']))
            {
                throw new Exception('还原库存失败');
            }
            $model_pd = Model('predeposit');
            $pd_amount = floatval($order_info['rcb_amount']);
            if (0 < $pd_amount)
            {
                $data_pd = array();
                $data_pd['member_id'] = $order_info['buyer_id'];
                $data_pd['member_name'] = $order_info['buyer_name'];
                $data_pd['amount'] = $pd_amount;
                $data_pd['order_sn'] = $order_info['order_sn'];
                $model_pd->changeRcb('order_cancel', $data_pd);
            }
            $pd_amount = floatval($order_info['pd_amount']);
            if (0 < $pd_amount)
            {
                $data_pd = array();
                $data_pd['member_id'] = $order_info['buyer_id'];
                $data_pd['member_name'] = $order_info['buyer_name'];
                $data_pd['amount'] = $pd_amount;
                $data_pd['order_sn'] = $order_info['order_sn'];
                $model_pd->changePd('order_cancel', $data_pd);
            }
            $update_order = array('order_state' => ORDER_STATE_CANCEL, 'pd_amount' => 0, 'close_time' => TIMESTAMP, 'close_reason' => $msg);
            $update = $model_vr_order->editOrder($update_order, array('order_id' => $order_info['order_id']));
            if (!($update))
            {
                throw new Exception('保存失败');
            }
            $model_vr_order->commit();
            return callback(true, '更新成功');
        }
        catch (Exception $e)
        {
            $model_vr_order->rollback();
            return callback(false, $e->getMessage());
        }
        $model_vr_order->rollback();
        return callback(false, $e->getMessage());
    }
    public function changeOrderStatePay($order_info, $role, $post)
    {
        try
        {
            $model_vr_order = Model('vr_order');
            $model_vr_order->beginTransaction();
            $model_pd = Model('predeposit');
            $rcb_amount = floatval($order_info['rcb_amount']);
            if (0 < $rcb_amount)
            {
                $data_pd = array();
                $data_pd['member_id'] = $order_info['buyer_id'];
                $data_pd['member_name'] = $order_info['buyer_name'];
                $data_pd['amount'] = $rcb_amount;
                $data_pd['order_sn'] = $order_info['order_sn'];
                $model_pd->changeRcb('order_comb_pay', $data_pd);
            }
            $pd_amount = floatval($order_info['pd_amount']);
            if (0 < $pd_amount)
            {
                $data_pd = array();
                $data_pd['member_id'] = $order_info['buyer_id'];
                $data_pd['member_name'] = $order_info['buyer_name'];
                $data_pd['amount'] = $pd_amount;
                $data_pd['order_sn'] = $order_info['order_sn'];
                $model_pd->changePd('order_comb_pay', $data_pd);
            }
            $update_order = array();
            $update_order['order_state'] = ORDER_STATE_PAY;
            $update_order['payment_time'] = (($post['payment_time'] ? strtotime($post['payment_time']) : TIMESTAMP));
            $update_order['payment_code'] = $post['payment_code'];
            $update_order['trade_no'] = $post['trade_no'];
            $update = $model_vr_order->editOrder($update_order, array('order_id' => $order_info['order_id'], 'order_state' => ORDER_STATE_NEW));
            if (!($update))
            {
                throw new Exception(L('feiwa_common_save_fail'));
            }
            $insert = $model_vr_order->addOrderCode($order_info);
            if (!($insert))
            {
                throw new Exception('兑换码生成失败');
            }
            $param = array();
            $param['code'] = 'order_payment_success';
            $param['member_id'] = $order_info['buyer_id'];
            $param['param'] = array('order_sn' => $order_info['order_sn'], 'order_url' => urlMall('member_vr_order', 'show_order', array('order_id' => $order_info['order_id'])));
            QueueClient::push('sendMemberMsg', $param);
            $param = array();
            $param['code'] = 'new_order';
            $param['store_id'] = $order_info['store_id'];
            $param['param'] = array('order_sn' => $order_info['order_sn']);
            QueueClient::push('sendStoreMsg', $param);
            $param = array('order_id' => $order_info['order_id'], 'buyer_id' => $order_info['buyer_id'], 'buyer_phone' => $order_info['buyer_phone']);
            QueueClient::push('sendVrCode', $param);
            $model_vr_order->commit();
            return callback(true, '更新成功');
        }
        catch (Exception $e)
        {
            $model_vr_order->rollback();
            return callback(false, $e->getMessage());
        }
        $model_vr_order->rollback();
        return callback(false, $e->getMessage());
    }
    public function changeOrderStateSuccess($order_id)
    {
        $model_vr_order = Model('vr_order');
        $condition = array();
        $condition['vr_state'] = 0;
        $condition['refund_lock'] = array( 'in', array(0, 1) );
        $condition['order_id'] = $order_id;
        $condition['vr_indate'] = array('gt', TIMESTAMP);
        $order_code_info = $model_vr_order->getOrderCodeInfo($condition, '*', true);
        if (empty($order_code_info))
        {
            $update = $model_vr_order->editOrder(array('order_state' => ORDER_STATE_SUCCESS, 'finnshed_time' => TIMESTAMP), array('order_id' => $order_id));
            if (!($update))
            {
                callback(false, '更新失败');
            }
            $order_info = $model_vr_order->getOrderInfo(array('order_id' => $order_id));
            if (C('points_isuse') == 1)
            {
                Model('points')->savePointsLog('order', array('pl_memberid' => $order_info['buyer_id'], 'pl_membername' => $order_info['buyer_name'], 'orderprice' => $order_info['order_amount'], 'order_sn' => $order_info['order_sn'], 'order_id' => $order_info['order_id']), true);
            }
            Model('exppoints')->saveExppointsLog('order', array('exp_memberid' => $order_info['buyer_id'], 'exp_membername' => $order_info['buyer_name'], 'orderprice' => $order_info['order_amount'], 'order_sn' => $order_info['order_sn'], 'order_id' => $order_info['order_id']), true);
        }
        return callback(true, '更新成功');
    }
}
?>