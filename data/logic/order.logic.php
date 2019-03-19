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
class orderLogic
{
    public function changeOrderStateCancel($order_info, $role, $user = '', $msg = '', $if_update_account = true, $cancel_condition = array())
    {
        try
        {
            $model_order = Model('order');
            $model_order->beginTransaction();
            $order_id = $order_info['order_id'];
            $goods_list = $model_order->getOrderGoodsList(array('order_id' => $order_id));
            $data = array();
            foreach ($goods_list as $goods )
            {
                $data[$goods['goods_id']] = $goods['goods_num'];
            }
            $result = Logic('queue')->cancelOrderUpdateStorage($data);
            if (!($result['state']))
            {
                throw new Exception('还原库存失败');
            }
            if ($order_info['chain_id'])
            {
                $result = Logic(queue)->cancelOrderUpdateChainStorage($data, $order_info['chain_id']);
                if (!($result['state']))
                {
                    throw new Exception('还原门店库存失败');
                }
            }
            if ($if_update_account)
            {
                $model_pd = Model('predeposit');
                $rcb_amount = floatval($order_info['rcb_amount']);
                if (0 < $rcb_amount)
                {
                    $data_pd = array();
                    $data_pd['member_id'] = $order_info['buyer_id'];
                    $data_pd['member_name'] = $order_info['buyer_name'];
                    $data_pd['amount'] = $rcb_amount;
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
            }
            $update_order = array('order_state' => ORDER_STATE_CANCEL);
            $cancel_condition['order_id'] = $order_id;
            $update = $model_order->editOrder($update_order, $cancel_condition);
            if (!($update))
            {
                throw new Exception('保存失败');
            }
            $data = array();
            $data['order_id'] = $order_id;
            $data['log_role'] = $role;
            $data['log_msg'] = '取消了订单';
            $data['log_user'] = $user;
            if ($msg)
            {
                $data['log_msg'] .= ' ( ' . $msg . ' )';
            }
            $data['log_orderstate'] = ORDER_STATE_CANCEL;
            $model_order->addOrderLog($data);
            $model_order->commit();
            return callback(true, '操作成功');
        }
        catch (Exception $e)
        {
            $model_order->rollback();
            return callback(false, '操作失败');
        }
        $model_order->rollback();
        return callback(false, '操作失败');
    }
    public function changeOrderStateReceive($order_info, $role, $user = '', $msg = '')
    {
        try
        {
            $order_id = $order_info['order_id'];
            $model_order = Model('order');
            $update_order = array();
            $update_order['finnshed_time'] = TIMESTAMP;
            $update_order['order_state'] = ORDER_STATE_SUCCESS;
            $update = $model_order->editOrder($update_order, array('order_id' => $order_id));
            if (!($update))
            {
                throw new Exception('保存失败');
            }
            $data = array();
            $data['order_id'] = $order_id;
            $data['log_role'] = $role;
            $data['log_msg'] = $msg;
            $data['log_user'] = $user;
            $data['log_orderstate'] = ORDER_STATE_SUCCESS;
            $model_order->addOrderLog($data);
            if ((0 < $order_info['buyer_id']) && (0 < $order_info['order_amount']))
            {
                if (C('points_isuse') == 1)
                {
                    Model('points')->savePointsLog('order', array('pl_memberid' => $order_info['buyer_id'], 'pl_membername' => $order_info['buyer_name'], 'orderprice' => $order_info['order_amount'], 'order_sn' => $order_info['order_sn'], 'order_id' => $order_info['order_id']), true);
                }
                Model('exppoints')->saveExppointsLog('order', array('exp_memberid' => $order_info['buyer_id'], 'exp_membername' => $order_info['buyer_name'], 'orderprice' => $order_info['order_amount'], 'order_sn' => $order_info['order_sn'], 'order_id' => $order_info['order_id']), true);
                $this->addStoreMony($order_info);
                $this->addInviteRate($order_info);
            }
            return callback(true, '操作成功');
        }
        catch (Exception $e)
        {
            return callback(false, '操作失败');
        }
        return callback(false, '操作失败');
    }
    public function changeOrderShipPrice($order_info, $role, $user = '', $price)
    {
        try
        {
            $order_id = $order_info['order_id'];
            $model_order = Model('order');
            $data = array();
            $data['shipping_fee'] = abs(floatval($price));
            $data['order_amount'] = array('exp', 'goods_amount+' . $data['shipping_fee']);
            $update = $model_order->editOrder($data, array('order_id' => $order_id));
            if (!($update))
            {
                throw new Exception('保存失败');
            }
            $data = array();
            $data['order_id'] = $order_id;
            $data['log_role'] = $role;
            $data['log_user'] = $user;
            $data['log_msg'] = '修改了运费' . '( ' . $price . ' )';
            $data['log_orderstate'] = (($order_info['payment_code'] == 'offline' ? ORDER_STATE_PAY : ORDER_STATE_NEW));
            $model_order->addOrderLog($data);
            return callback(true, '操作成功');
        }
        catch (Exception $e)
        {
            return callback(false, '操作失败');
        }
        return callback(false, '操作失败');
    }
    public function changeOrderSpayPrice($order_info, $role, $user = '', $price)
    {
        try
        {
            $order_id = $order_info['order_id'];
            $model_order = Model('order');
            $data = array();
            $data['goods_amount'] = abs(floatval($price));
            $data['order_amount'] = array('exp', 'shipping_fee+' . $data['goods_amount']);
            $update = $model_order->editOrder($data, array('order_id' => $order_id));
            if (!($update))
            {
                throw new Exception('保存失败');
            }
            $data = array();
            $data['order_id'] = $order_id;
            $data['log_role'] = $role;
            $data['log_user'] = $user;
            $data['log_msg'] = '修改了价格' . '( ' . $price . ' )';
            $data['log_orderstate'] = (($order_info['payment_code'] == 'offline' ? ORDER_STATE_PAY : ORDER_STATE_NEW));
            $model_order->addOrderLog($data);
            return callback(true, '操作成功');
        }
        catch (Exception $e)
        {
            return callback(false, '操作失败');
        }
        return callback(false, '操作失败');
    }
    public function changeOrderStateRecycle($order_info, $role, $state_type)
    {
        $order_id = $order_info['order_id'];
        $model_order = Model('order');
        $state = str_replace(array('delete', 'drop', 'restore'), array(ORDER_DEL_STATE_DELETE, ORDER_DEL_STATE_DROP, ORDER_DEL_STATE_DEFAULT), $state_type);
        $update = $model_order->editOrder(array('delete_state' => $state), array('order_id' => $order_id));
        if (!($update))
        {
            return callback(false, '操作失败');
        }
        return callback(true, '操作成功');
    }
    public function changeOrderSend($order_info, $role, $user = '', $post = array())
    {
        $order_id = $order_info['order_id'];
        $model_order = Model('order');
        try
        {
            $model_order->beginTransaction();
            $data = array();
            if (!(empty($post['reciver_name'])))
            {
                $data['reciver_name'] = $post['reciver_name'];
            }
            if (!(empty($post['reciver_info'])))
            {
                $data['reciver_info'] = $post['reciver_info'];
            }
            $data['deliver_explain'] = $post['deliver_explain'];
            $data['daddress_id'] = intval($post['daddress_id']);
            $data['shipping_express_id'] = intval($post['shipping_express_id']);
            $data['shipping_time'] = TIMESTAMP;
            $condition = array();
            $condition['order_id'] = $order_id;
            $condition['store_id'] = $order_info['store_id'];
            $update = $model_order->editOrderCommon($data, $condition);
            if (!($update))
            {
                throw new Exception('操作失败');
            }
            $data = array();
            $data['shipping_code'] = $post['shipping_code'];
            $data['order_state'] = ORDER_STATE_SEND;
            $data['delay_time'] = TIMESTAMP;
            $update = $model_order->editOrder($data, $condition);
            if (!($update))
            {
                throw new Exception('操作失败');
            }
            $model_order->commit();
        }
        catch (Exception $e)
        {
            $model_order->rollback();
            return callback(false, $e->getMessage());
        }
        if ($post['shipping_express_id'] && $order_info['extend_order_common']['reciver_info']['dlyp'])
        {
            $data = array();
            $data['shipping_code'] = $post['shipping_code'];
            $data['order_sn'] = $order_info['order_sn'];
            $express_info = Model('express')->getExpressInfo(intval($post['shipping_express_id']));
            $data['express_code'] = $express_info['e_code'];
            $data['express_name'] = $express_info['e_name'];
            Model('delivery_order')->editDeliveryOrder($data, array('order_id' => $order_info['order_id']));
        }
        $data = array();
        $data['order_id'] = $order_id;
        $data['log_role'] = 'seller';
        $data['log_user'] = $user;
        $data['log_msg'] = '发出货物(编辑信息)';
        $data['log_orderstate'] = ORDER_STATE_SEND;
        $model_order->addOrderLog($data);
        $param = array();
        $param['code'] = 'order_deliver_success';
        $param['member_id'] = $order_info['buyer_id'];
        $param['param'] = array('order_sn' => $order_info['order_sn'], 'order_url' => urlMall('member_order', 'show_order', array('order_id' => $order_id)));
        QueueClient::push('sendMemberMsg', $param);
        return callback(true, '操作成功');
    }
    public function changeOrderReceivePay($order_list, $role, $user = '', $post = array())
    {
        $model_order = Model('order');
        try
        {
            $model_order->beginTransaction();
            $model_pd = Model('predeposit');
            foreach ($order_list as $order_info )
            {
                $order_id = $order_info['order_id'];
                if (!(in_array($order_info['order_state'], array(ORDER_STATE_NEW))))
                {
                    continue;
                }
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
                $result = $this->_changeOrderReceivePayExtend($order_info, $post);
                if (!($result['state']))
                {
                    throw new Exception($result['msg']);
                }
                $data = array();
                $data['order_id'] = $order_id;
                $data['log_role'] = $role;
                $data['log_user'] = $user;
                $data['log_msg'] = '收到货款(外部交易号:' . $post['trade_no'] . ')';
                $data['log_orderstate'] = ORDER_STATE_PAY;
                $insert = $model_order->addOrderLog($data);
                if (!($insert))
                {
                    throw new Exception('操作失败');
                }
                $update_order = array();
                $update_order['order_state'] = ORDER_STATE_PAY;
                $update_order['payment_time'] = (($post['payment_time'] ? strtotime($post['payment_time']) : TIMESTAMP));
                $update_order['payment_code'] = $post['payment_code'];
                if ($post['trade_no'] != '')
                {
                    $update_order['trade_no'] = $post['trade_no'];
                }
                $condition = array();
                $condition['order_id'] = $order_info['order_id'];
                $condition['order_state'] = ORDER_STATE_NEW;
                $update = $model_order->editOrder($update_order, $condition);
                if (!($update))
                {
                    throw new Exception('操作失败');
                }
            }
            $data = array();
            $data['api_pay_state'] = 1;
            $update = $model_order->editOrderPay($data, array('pay_sn' => $order_info['pay_sn']));
            if (!($update))
            {
                throw new Exception('更新支付单状态失败');
            }
            $model_order->commit();
        }
        catch (Exception $e)
        {
            $model_order->rollback();
            return callback(false, $e->getMessage());
        }
        foreach ($order_list as $order_info )
        {
            $order_id = $order_info['order_id'];
            $param = array();
            $param['code'] = 'order_payment_success';
            $param['member_id'] = $order_info['buyer_id'];
            $param['param'] = array('order_sn' => $order_info['order_sn'], 'order_url' => urlMall('member_order', 'show_order', array('order_id' => $order_info['order_id'])));
            QueueClient::push('sendMemberMsg', $param);
            if (($order_info['order_type'] != 2) || $order_info['if_send_store_msg_pay_success'])
            {
                $param = array();
                $param['code'] = 'new_order';
                $param['store_id'] = $order_info['store_id'];
                $param['param'] = array('order_sn' => $order_info['order_sn']);
                QueueClient::push('sendStoreMsg', $param);
                if ($order_info['order_type'] == 3)
                {
                    $_code = rand(100000, 999999);
                    $result = $model_order->editOrder(array('chain_code' => $_code), array('order_id' => $order_info['order_id']));
                    if (!($result))
                    {
                        throw new Exception('订单更新失败');
                    }
                    $param = array();
                    $param['chain_code'] = $_code;
                    $param['order_sn'] = $order_info['order_sn'];
                    $param['buyer_phone'] = $order_info['buyer_phone'];
                    QueueClient::push('sendChainCode', $param);
                }
            }
        }
        return callback(true, '操作成功');
    }
    private function _changeOrderReceivePayExtend($order_info, $post)
    {
        if ($order_info['order_type'] == 2)
        {
            $result = Logic('order_book')->changeBookOrderReceivePay($order_info, $post);
        }
        return callback(true);
    }
    public function getMemberOrderInfo($order_id, $member_id)
    {
        $order_id = intval($order_id);
        $member_id = intval($member_id);
        if ($order_id <= 0)
        {
            return callback(false, '订单不存在');
        }
        $model_order = Model('order');
        $condition = array();
        $condition['order_id'] = $order_id;
        $condition['buyer_id'] = $member_id;
        $order_info = $model_order->getOrderInfo($condition, array('order_goods', 'order_common', 'store'));
        if (empty($order_info) || ($order_info['delete_state'] == ORDER_DEL_STATE_DROP))
        {
            return callback(false, '订单不存在');
        }
        $model_refund_return = Model('refund_return');
        $order_list = array();
        $order_list[$order_id] = $order_info;
        $order_list = $model_refund_return->getGoodsRefundList($order_list, 1);
        $order_info = $order_list[$order_id];
        $refund_all = $order_info['refund_list'][0];
        if (!(empty($refund_all)) && ($refund_all['seller_state'] < 3))
        {
        }
        else
        {
            $refund_all = array();
        }
        $order_info['if_lock'] = $model_order->getOrderOperateState('lock', $order_info);
        $order_info['if_buyer_cancel'] = $model_order->getOrderOperateState('buyer_cancel', $order_info);
        $order_info['if_refund_cancel'] = $model_order->getOrderOperateState('refund_cancel', $order_info);
        $order_info['if_complain'] = $model_order->getOrderOperateState('complain', $order_info);
        $order_info['if_receive'] = $model_order->getOrderOperateState('receive', $order_info);
        $order_info['if_deliver'] = $model_order->getOrderOperateState('deliver', $order_info);
        $order_info['if_evaluation'] = $model_order->getOrderOperateState('evaluation', $order_info);
        $order_info['if_share'] = $model_order->getOrderOperateState('share', $order_info);
        if ($order_info['order_state'] == ORDER_STATE_NEW)
        {
            $order_info['order_cancel_day'] = $order_info['add_time'] + (ORDER_AUTO_CANCEL_TIME * 3600);
        }
        if ($order_info['shipping_code'] != '')
        {
            $express = rkcache('express', true);
            $order_info['express_info']['e_code'] = $express[$order_info['extend_order_common']['shipping_express_id']]['e_code'];
            $order_info['express_info']['e_name'] = $express[$order_info['extend_order_common']['shipping_express_id']]['e_name'];
            $order_info['express_info']['e_url'] = $express[$order_info['extend_order_common']['shipping_express_id']]['e_url'];
        }
        if ($order_info['order_state'] == ORDER_STATE_SEND)
        {
            $order_info['order_confirm_day'] = $order_info['delay_time'] + (ORDER_AUTO_RECEIVE_DAY * 24 * 3600);
        }
        if ($order_info['order_state'] == ORDER_STATE_CANCEL)
        {
            $order_info['close_info'] = $model_order->getOrderLogInfo(array('order_id' => $order_info['order_id']), 'log_id desc');
        }
        if (C('contract_allow') == 1)
        {
            $contract_item = Model('contract')->getContractItemByCache();
        }
        foreach ($order_info['extend_order_goods'] as $value )
        {
            $value['image_60_url'] = cthumb($value['goods_image'], 60, $value['store_id']);
            $value['image_240_url'] = cthumb($value['goods_image'], 240, $value['store_id']);
            $value['goods_type_cn'] = orderGoodsType($value['goods_type']);
            $value['goods_url'] = urlMall('goods', 'index', array('goods_id' => $value['goods_id']));
            $value['refund'] = (($value['refund'] ? 1 : 0));
            if (trim($value['goods_contractid']) && $contract_item)
            {
                $goods_contractid_arr = explode(',', $value['goods_contractid']);
                foreach ((array) $goods_contractid_arr as $gcti_v )
                {
                    $value['contractlist'][] = $contract_item[$gcti_v];
                }
            }
            if ($value['goods_type'] == 5)
            {
                $order_info['zengpin_list'][] = $value;
            }
            else
            {
                $order_info['goods_list'][] = $value;
            }
        }
        if (empty($order_info['zengpin_list']))
        {
            $order_info['zengpin_list'] = array();
            $order_info['goods_count'] = count($order_info['goods_list']);
        }
        else
        {
            $order_info['goods_count'] = count($order_info['goods_list']) + 1;
        }
        $model_order->getOrderExtendInfo($order_info);
        if (!(empty($order_info['extend_order_common']['daddress_id'])))
        {
            $daddress_info = Model('daddress')->getAddressInfo(array('address_id' => $order_info['extend_order_common']['daddress_id']));
        }
        else
        {
            $daddress_info = array();
        }
        return callback(true, '', array('order_info' => $order_info, 'refund_all' => $refund_all, 'daddress_info' => $daddress_info));
    }
    public function addInviteRate($order_info)
    {
        $model_order = Model('order');
        $invite_info = Model('member')->table('member')->where(array('member_id' => $order_info['buyer_id']))->find();
        $invite_money = 0;
        $field = 'SUM(ROUND(goods_num*invite_rates)) as commis_amount';
        $order_goods_condition['order_id'] = $order_info['order_id'];
        $order_goods_condition['buyer_id'] = $order_info['buyer_id'];
        $order_goods_info = $model_order->getOrderGoodsInfo($order_goods_condition, $field);
        $commis_rate_totals_array[] = $order_goods_info['commis_amount'];
        $commis_amount_sum = floatval(array_sum($commis_rate_totals_array));
        if (0 < $commis_amount_sum)
        {
            $invite_money = $commis_amount_sum;
            $invite_money2 = ceil($commis_amount_sum * $GLOBALS['setting_config']['feiwa_invite2'] * 0.01);
            $invite_money3 = ceil($commis_amount_sum * $GLOBALS['setting_config']['feiwa_invite3'] * 0.01);
        }
        $is_offline = $order_info['payment_code'] == 'offline';
        $model_member = Model('member');
        $invite_one_id = $model_member->table('member')->getfby_member_id($invite_info['member_id'], 'invite_one');
        $invite_one_name = $model_member->table('member')->getfby_member_id($invite_one_id, 'member_name');
        $invite_two_id = $model_member->table('member')->getfby_member_id($invite_info['member_id'], 'invite_two');
        $invite_two_name = $model_member->table('member')->getfby_member_id($invite_two_id, 'member_name');
        $invite_three_id = $model_member->table('member')->getfby_member_id($invite_info['member_id'], 'invite_three');
        $invite_three_name = $model_member->table('member')->getfby_member_id($invite_three_id, 'member_name');
        if ((0 < $invite_money) && ($is_offline == false))
        {
            $all_invite_money = floatval($invite_money) + floatval($invite_money2) + floatval($invite_money3);
            $storeinfo = Model('store')->getStoreInfoByID($order_info['store_id']);
            if (empty($storeinfo))
            {
                return;
            }
            $insert_data = array();
            $insert_data['cost_store_id'] = $order_info['store_id'];
            $insert_data['cost_state'] = 0;
            $insert_data['cost_time'] = time();
            $insert_data['cost_seller_id'] = $storeinfo['member_id'];
            $insert_data['cost_price'] = $all_invite_money;
            $insert_data['cost_remark'] = '订单：' . $order_info['order_sn'] . '分销提成费用';
            $rt = Model('store_cost')->addStoreCost($insert_data);
            $model_pd = Model('predeposit');
            if ($invite_one_id != 0)
            {
                $data = array();
                $data['invite_member_id'] = $order_info['buyer_id'];
                $data['member_id'] = $invite_one_id;
                $data['member_name'] = $invite_one_name;
                $data['amount'] = $invite_money;
                $data['order_sn'] = $order_info['order_sn'];
                $model_pd->changePd('order_invite', $data);
            }
            if ($invite_two_id != 0)
            {
                $data_pd = array();
                $data_pd['invite_member_id'] = $order_info['buyer_id'];
                $data_pd['member_id'] = $invite_two_id;
                $data_pd['member_name'] = $invite_two_name;
                $data_pd['amount'] = $invite_money2;
                $data_pd['order_sn'] = $order_info['order_sn'];
                $model_pd->changePd('order_invite', $data_pd);
            }
            if ($invite_three_id != 0)
            {
                $datas = array();
                $datas['invite_member_id'] = $order_info['buyer_id'];
                $datas['member_id'] = $invite_three_id;
                $datas['member_name'] = $invite_three_name;
                $datas['amount'] = $invite_money3;
                $datas['order_sn'] = $order_info['order_sn'];
                $model_pd->changePd('order_invite', $datas);
            }
        }
    }
    public function addStoreMony($order_info)
    {
        $model_order = Model('order');
        $store_info = Model('store')->table('store')->where(array('store_id' => $order_info['store_id']))->find();
        $seller_info = Model('member')->table('member')->where(array('member_id' => $store_info['member_id']))->find();
        $refund = Model('refund_return')->table('refund_return')->where(array('order_id' => $order_info['order_id'], 'refund_state' => 3))->find();
        $seller_money = 0;
        if ($refund)
        {
            $seller_money = $order_info['order_amount'] - $refund['refund_amount'];
        }
        else
        {
            $seller_money = $order_info['order_amount'];
        }
        $field = 'SUM(ROUND(goods_pay_price*commis_rate/100,2)) as commis_amount';
        $order_goods_condition['order_id'] = $order_info['order_id'];
        $order_goods_condition['buyer_id'] = $order_info['buyer_id'];
        $order_goods_info = $model_order->getOrderGoodsInfo($order_goods_condition, $field);
        $commis_rate_totals_array[] = $order_goods_info['commis_amount'];
        $commis_amount_sum = floatval(array_sum($commis_rate_totals_array));
        if (0 < $commis_amount_sum)
        {
            $seller_money = $seller_money - $commis_amount_sum;
        }
        $is_offline = $order_info['payment_code'] == 'offline';
        if ((0 < $seller_money) && ($is_offline == false))
        {
            $model_pd = Model('predeposit');
            $data = array();
            $data['msg'] = '';
            if (0 < $commis_amount_sum)
            {
                $data['msg'] = $commis_amount_sum;
            }
            $data['member_id'] = $store_info['member_id'];
            $data['member_name'] = $store_info['member_name'];
            $data['amount'] = $seller_money;
            $data['pdr_sn'] = $order_info['order_sn'];
            $model_pd->changePd('seller_money', $data);
        }
    }
}
?>