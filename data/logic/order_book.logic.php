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
class order_bookLogic
{
    public function buy($order_data = array(), $post_data = array())
    {
        $model_order_book = Model('order_book');
        $order_info = current($order_data['order_list']);
        $goods_info = current($order_data['goods_list']);
        if ($post_data['book_pay_type'] == 'part')
        {
            $data = array();
            $data['book_order_id'] = key($order_data['order_list']);
            $data['book_step'] = 1;
            $data['book_amount'] = $goods_info['book_down_payment'] * $goods_info['goods_num'];
            $data['book_end_time'] = TIMESTAMP + (ORDER_AUTO_CANCEL_TIME * 3600);
            $data['book_store_id'] = $order_info['store_id'];
            $insert = $model_order_book->addOrderBook($data);
            if (!($insert))
            {
                throw new Exception('订单保存失败[预定时段出现异常]');
            }
            unset($data['book_store_id']);
            $data['book_step'] = 2;
            $data['book_amount'] = $order_info['order_amount'] - $data['book_amount'];
            $data['book_end_time'] = $goods_info['book_down_time'] + (BOOK_AUTO_END_TIME * 3600);
            $data['book_buyer_phone'] = $post_data['buyer_phone'];
            $insert = $model_order_book->addOrderBook($data);
            if (!($insert))
            {
                throw new Exception('订单保存失败[预定时段出现异常]');
            }
        }
        else
        {
            $data = array();
            $data['book_order_id'] = key($order_data['order_list']);
            $data['book_step'] = 0;
            $data['book_amount'] = $order_info['order_amount'];
            $data['book_end_time'] = TIMESTAMP + (ORDER_AUTO_CANCEL_TIME * 3600);
            $data['book_deposit_amount'] = $goods_info['book_down_payment'] * $goods_info['goods_num'];
            $data['book_store_id'] = $order_info['store_id'];
            $insert = $model_order_book->addOrderBook($data);
            if (!($insert))
            {
                throw new Exception('订单保存失败[预定时段出现异常]');
            }
        }
        return callback(true);
    }
    public function getOrderBookInfo($order_info)
    {
        $book_list = Model('order_book')->getOrderBookList(array('book_order_id' => $order_info['order_id']));
        $pay_sn = $order_info['pay_sn'];
        if (!($book_list[0]['book_step']))
        {
            $book_list[0]['book_step'] = '全款支付(定金+尾款+运费)';
            if (empty($book_list[0]['book_pay_time']))
            {
                if (TIMESTAMP < $book_list[0]['book_end_time'])
                {
                    if ($order_info['order_state'] == ORDER_STATE_CANCEL)
                    {
                        $book_list[0]['book_state'] = '已取消';
                        $book_list[0]['book_operate'] = '-';
                    }
                    else
                    {
                        $_fen = ceil(($book_list[0]['book_end_time'] - TIMESTAMP) / 60);
                        $book_list[0]['book_state'] = '须在' . $_fen . '分钟内付款';
                        $book_list[0]['book_operate'] = '<a class="ncm-btn ncm-btn-orange fr mr15" href="index.php?app=buy&feiwa=pay&pay_sn=' . $pay_sn . '">付款</a>';
                        $order_info['if_buyer_pay'] = true;
                    }
                    $order_info['pay_amount'] = $book_list[0]['book_amount'];
                    $order_info['pd_amount'] = $book_list[0]['book_pd_amount'];
                    $order_info['rcb_amount'] = $book_list[0]['book_rcb_amount'];
                    $order_info['api_pay_amount'] = $book_list[0]['book_amount'] - $book_list[0]['book_pd_amount'] - $book_list[0]['book_rcb_amount'];
                    if ($book_list[0]['book_rcb_amount'] || $book_list[0]['book_pd_amount'])
                    {
                        $order_info['if_buyer_pay_lock'] = true;
                    }
                    $book_list[0]['book_amount_ext'] = '(含定金' . ncPriceFormat($book_list[0]['book_deposit_amount']) . ')';
                }
                else
                {
                    $book_list[0]['book_state'] = '未完成';
                    $book_list[0]['book_operate'] = '未按时支付全款取消订单';
                    $order_info['state_desc'] = '已取消';
                    $order_info['if_buyer_cancel'] = false;
                    if ($order_info['order_state'] != ORDER_STATE_CANCEL)
                    {
                        $this->changeOrderStateCancel($order_info, 'system', '系统', '超期未支付全款系统自动关闭订单');
                    }
                }
                $order_info['if_send_store_msg_pay_success'] = true;
            }
            else
            {
                $book_list[0]['book_state'] = ((TIMESTAMP < $book_list[0]['book_end_time'] ? '已支付' : '已完成'));
                $book_list[0]['book_operate'] = '已于' . date('Y-m-d H:i', $book_list[0]['book_pay_time']) . '付款';
                if ($order_info['order_state'] == ORDER_STATE_PAY)
                {
                    $order_info['state_desc'] = '待发货';
                }
                $order_info['if_buyer_cancel'] = false;
                $book_list[0]['book_amount_ext'] = '(含定金' . ncPriceFormat($book_list[0]['book_deposit_amount']) . ')';
            }
        }
        else
        {
            $book_list[0]['book_step'] = '阶段1：付定金';
            $book_list[1]['book_step'] = '阶段2：付尾款';
            if (empty($book_list[0]['book_pay_time']))
            {
                if (TIMESTAMP < $book_list[0]['book_end_time'])
                {
                    if ($order_info['order_state'] == ORDER_STATE_CANCEL)
                    {
                        $book_list[0]['book_state'] = '已取消';
                        $book_list[0]['book_operate'] = '-';
                        $book_list[1]['book_state'] = '已取消';
                    }
                    else
                    {
                        $_fen = ceil(($book_list[0]['book_end_time'] - TIMESTAMP) / 60);
                        $book_list[0]['book_state'] = '须在' . $_fen . '分钟内付款';
                        $book_list[0]['book_operate'] = '<a class="ncm-btn ncm-btn-orange fr mr15" href="index.php?app=buy&feiwa=pay&pay_sn=' . $pay_sn . '">付款</a>';
                        $order_info['if_buyer_pay'] = true;
                        $book_list[1]['book_state'] = '未开始';
                    }
                    $book_list[1]['book_operate'] = '';
                    $order_info['pd_amount'] = $book_list[0]['book_pd_amount'];
                    $order_info['rcb_amount'] = $book_list[0]['book_rcb_amount'];
                    $order_info['pay_amount'] = $book_list[0]['book_amount'];
                    $order_info['api_pay_amount'] = $book_list[0]['book_amount'] - $book_list[0]['book_pd_amount'] - $book_list[0]['book_rcb_amount'];
                    if ($book_list[0]['book_rcb_amount'] || $book_list[0]['book_pd_amount'])
                    {
                        $order_info['if_buyer_pay_lock'] = true;
                    }
                }
                else
                {
                    $book_list[0]['book_state'] = '未完成';
                    $book_list[0]['book_operate'] = '未按时支付定金取消订单';
                    $book_list[1]['book_amount'] = '未生成';
                    $book_list[1]['book_state'] = $book_list[1]['book_operate'] = '';
                    $order_info['state_desc'] = '已取消';
                    $order_info['if_buyer_cancel'] = false;
                    $order_info['if_system_cancel'] = false;
                    $order_info['if_store_cancel'] = false;
                    if ($order_info['order_state'] != ORDER_STATE_CANCEL)
                    {
                        $this->changeOrderStateCancel($order_info, 'system', '系统', '超期未支付全款系统自动关闭订单');
                    }
                }
                $order_info['system_receive_pay_op_name'] = '收到定金';
            }
            else
            {
                $book_list[0]['book_state'] = ((TIMESTAMP < $book_list[0]['book_end_time'] ? '已支付' : '已完成'));
                $book_list[0]['book_operate'] = '已于' . date('Y-m-d H:i', $book_list[0]['book_pay_time']) . '付款';
                if (empty($book_list[1]['book_pay_time']))
                {
                    if (TIMESTAMP < $book_list[1]['book_end_time'])
                    {
                        if ($order_info['order_state'] == ORDER_STATE_CANCEL)
                        {
                            $book_list[1]['book_state'] = '已取消';
                            $book_list[1]['book_operate'] = '';
                        }
                        else
                        {
                            $book_list[1]['book_state'] = '须在' . date('Y-m-d H:i', $book_list[1]['book_end_time'] + 1) . '之前付款';
                            $book_list[1]['book_operate'] = '<a class="ncm-btn ncm-btn-orange fr mr15" href="index.php?app=buy&feiwa=pay&pay_sn=' . $pay_sn . '">付款</a>';
                            $order_info['state_desc'] = '待付尾款';
                            $order_info['if_buyer_repay'] = true;
                            $order_info['if_store_cancel'] = true;
                            $order_info['if_system_cancel'] = true;
                        }
                        $order_info['if_refund_cancel'] = false;
                        $order_info['if_buyer_pay'] = true;
                        $order_info['pd_amount'] = $book_list[1]['book_pd_amount'];
                        $order_info['rcb_amount'] = $book_list[1]['book_rcb_amount'];
                        $order_info['pay_amount'] = $book_list[1]['book_amount'];
                        $order_info['api_pay_amount'] = $book_list[1]['book_amount'] - $book_list[1]['book_pd_amount'] - $book_list[1]['book_rcb_amount'];
                        if ($book_list[1]['book_rcb_amount'] || $book_list[1]['book_pd_amount'])
                        {
                            $order_info['if_buyer_pay_lock'] = true;
                        }
                        $order_info['if_store_send'] = false;
                    }
                    else
                    {
                        $book_list[1]['book_state'] = '未完成';
                        $book_list[1]['book_operate'] = '未按时支付尾款取消订单';
                        $order_info['state_desc'] = '已取消';
                        $order_info['if_refund_cancel'] = false;
                        $order_info['if_buyer_cancel'] = false;
                        $order_info['if_system_cancel'] = false;
                        if ($order_info['order_state'] != ORDER_STATE_CANCEL)
                        {
                            $this->changeOrderStateCancel($order_info, 'system', '系统', '超期未支付全款系统自动关闭订单');
                        }
                    }
                    $order_info['if_system_receive_pay'] = ($order_info['order_state'] == ORDER_STATE_PAY) && (TIMESTAMP < ($book_list[1]['book_end_time'] + 604800));
                    $order_info['system_receive_pay_op_name'] = '收到尾款';
                    $order_info['if_send_store_msg_pay_success'] = true;
                }
                else
                {
                    $book_list[1]['book_state'] = ((TIMESTAMP < $book_list[1]['book_end_time'] ? '已支付' : '已完成'));
                    $book_list[1]['book_operate'] = '已于' . date('Y-m-d H:i', $book_list[1]['book_pay_time']) . '付款';
                    if ($order_info['order_state'] == ORDER_STATE_PAY)
                    {
                        $order_info['state_desc'] = '待发货';
                    }
                    $order_info['if_buyer_cancel'] = false;
                    $order_info['if_system_cancel'] = false;
                    $order_info['if_system_receive_pay'] = false;
                }
            }
        }
        $order_info['if_modify_price'] = false;
        $order_info['book_list'] = $book_list;
        return callback(true, '', $order_info);
    }
    public function changeBookOrderReceivePay($order_info, $post)
    {
        $model_book = Model('order_book');
        $condition = array();
        $condition['book_order_id'] = $order_info['order_id'];
        $book_list = $model_book->getOrderBookList($condition);
        if ($book_list[0]['book_step'])
        {
            if (empty($book_list[0]['book_pay_time']))
            {
                $condition['book_step'] = 1;
                $order_goods_info = Model('order')->getOrderGoodsInfo(array('order_id' => $order_info['order_id']), 'goods_id', 'rec_id asc');
                Model('goods')->editGoods(array( 'book_buyers' => array('exp', 'book_buyers+1') ), array('goods_id' => $order_goods_info['goods_id']));
            }
            else
            {
                $condition['book_step'] = 2;
            }
        }
        else
        {
            $order_goods_info = Model('order')->getOrderGoodsInfo(array('order_id' => $order_info['order_id']), 'goods_id', 'rec_id asc');
            Model('goods')->editGoods(array( 'book_buyers' => array('exp', 'book_buyers+1') ), array('goods_id' => $order_goods_info['goods_id']));
        }
        $data = array();
        $data['book_pay_time'] = TIMESTAMP;
        $data['book_pay_name'] = orderPaymentName($post['payment_code']);
        $data['book_trade_no'] = $post['trade_no'];
        $update = $model_book->editOrderBook($data, $condition);
        return callback($update, '更新订单预定信息失败');
    }
    public function changeOrderStateCancel($order_info, $role, $user = '', $msg = '')
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
            if (in_array($role, array('seller', 'admin')))
            {
                $order_info = $this->_calcSellerCancelAmount($order_info);
            }
            else
            {
                $order_info = $this->_calcMemberCancelAmount($order_info);
            }
            $this->_editPdAndRcb($order_info);
            if (!(empty($order_info['real_pay'])))
            {
                $condition = array();
                $condition['book_order_id'] = $order_info['order_id'];
                $condition['book_step'] = array( 'in', array(0, 1) );
                $data = array();
                $data['book_real_pay'] = $order_info['real_pay'];
                $data['book_cancel_time'] = time();
                $update = Model('order_book')->editOrderBook($data, $condition);
                if (!($update))
                {
                    throw new Exception('保存失败');
                }
                $update = $model_order->editOrder(array('shipping_fee' => 0), array('order_id' => $order_info['order_id']));
                if (!($update))
                {
                    throw new Exception('保存失败');
                }
            }
            $update_order = array('order_state' => ORDER_STATE_CANCEL);
            $update = $model_order->editOrder($update_order, array('order_id' => $order_id));
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
    public function getDepositAmount($order_info = array())
    {
        if ($order_info['order_type'] != 2)
        {
            return 0;
        }
        $condition = array();
        $condition['book_order_id'] = $order_info['order_id'];
        $condition['book_step'] = array( 'in', array(0, 1) );
        $book_info = Model('order_book')->getOrderBookInfo(array('book_order_id' => $order_info['order_id']), '', 'book_id asc');
        if ($book_info['book_step'] == 1)
        {
            return $book_info['book_amount'];
        }
        return $book_info['book_deposit_amount'];
    }
    private function _calcSellerCancelAmount($order_info)
    {
        $book_list = Model('order_book')->getOrderBookList(array('book_order_id' => $order_info['order_id']));
        if (!($book_list[0]['book_step']))
        {
            if (empty($book_list[0]['book_pay_time']))
            {
                if ((0 < $book_list[0]['book_pd_amount']) || (0 < $book_list[0]['book_rcb_amount']))
                {
                    $order_info['cancel_pd_amount'] = $book_list[0]['book_pd_amount'];
                    $order_info['cancel_rcb_amount'] = $book_list[0]['book_rcb_amount'];
                }
            }
            else
            {
                $order_info['cancel_pd_amount'] = $book_list[0]['book_amount'];
            }
        }
        else if (empty($book_list[0]['book_pay_time']))
        {
            if ((0 < $book_list[0]['book_pd_amount']) || (0 < $book_list[0]['book_rcb_amount']))
            {
                $order_info['cancel_pd_amount'] = $book_list[0]['book_pd_amount'];
                $order_info['cancel_rcb_amount'] = $book_list[0]['book_rcb_amount'];
            }
        }
        else if (empty($book_list[1]['book_pay_time']))
        {
            if (0 < $book_list[0]['book_rcb_amount'])
            {
                $order_info['cancel_rcb_amount'] = $book_list[0]['book_rcb_amount'];
                $order_info['cancel_pd_amount'] = $book_list[0]['book_amount'] - $book_list[0]['book_rcb_amount'];
            }
            else
            {
                $order_info['cancel_pd_amount'] = $book_list[0]['book_amount'];
            }
            if ((0 < $book_list[1]['book_pd_amount']) || (0 < $book_list[1]['book_rcb_amount']))
            {
                $order_info['cancel_pd_amount'] += $book_list[1]['book_pd_amount'];
                $order_info['cancel_rcb_amount'] += $book_list[1]['book_rcb_amount'];
            }
        }
        return $order_info;
    }
    private function _calcMemberCancelAmount($order_info)
    {
        $book_list = Model('order_book')->getOrderBookList(array('book_order_id' => $order_info['order_id']));
        if (!($book_list[0]['book_step']))
        {
            if (empty($book_list[0]['book_pay_time']))
            {
                if ((0 < $book_list[0]['book_pd_amount']) || (0 < $book_list[0]['book_rcb_amount']))
                {
                    $order_info['cancel_pd_amount'] = $book_list[0]['book_pd_amount'];
                    $order_info['cancel_rcb_amount'] = $book_list[0]['book_rcb_amount'];
                }
            }
        }
        else if (empty($book_list[0]['book_pay_time']))
        {
            if ((0 < $book_list[0]['book_pd_amount']) || (0 < $book_list[0]['book_rcb_amount']))
            {
                $order_info['cancel_pd_amount'] = $book_list[0]['book_pd_amount'];
                $order_info['cancel_rcb_amount'] = $book_list[0]['book_rcb_amount'];
            }
        }
        else
        {
            $order_info['real_pay'] = $book_list[0]['book_amount'];
            if (empty($book_list[1]['book_pay_time']))
            {
                $order_info['cancel_pd_amount'] = $book_list[1]['book_pd_amount'];
                $order_info['cancel_rcb_amount'] = $book_list[1]['book_rcb_amount'];
            }
        }
        return $order_info;
    }
    private function _editPdAndRcb($order_info)
    {
        $model_pd = Model('predeposit');
        $rcb_amount = floatval($order_info['cancel_rcb_amount']);
        if (0 < $rcb_amount)
        {
            $data_pd = array();
            $data_pd['member_id'] = $order_info['buyer_id'];
            $data_pd['member_name'] = $order_info['buyer_name'];
            $data_pd['amount'] = $rcb_amount;
            $data_pd['order_sn'] = $order_info['order_sn'];
            $model_pd->changeRcb('order_book_cancel', $data_pd);
        }
        $pd_amount = floatval($order_info['cancel_pd_amount']);
        if (0 < $pd_amount)
        {
            $data_pd = array();
            $data_pd['member_id'] = $order_info['buyer_id'];
            $data_pd['member_name'] = $order_info['buyer_name'];
            $data_pd['amount'] = $pd_amount;
            $data_pd['order_sn'] = $order_info['order_sn'];
            $model_pd->changePd('order_book_cancel', $data_pd);
        }
    }
}
?>
