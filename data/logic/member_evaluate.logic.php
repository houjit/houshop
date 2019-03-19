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
class member_evaluateLogic
{
    public function validation($order_id, $member_id)
    {
        if (!($order_id))
        {
            return callback(false, '参数错误');
        }
        $model_order = Model('order');
        $model_store = Model('store');
        $order_info = $model_order->getOrderInfo(array('order_id' => $order_id));
        if ($order_info['buyer_id'] != $member_id)
        {
            return callback(false, '参数错误');
        }
        $order_info['evaluate_able'] = $model_order->getOrderOperateState('evaluation', $order_info);
        if (empty($order_info) || !($order_info['evaluate_able']))
        {
            return callback(false, '订单信息错误');
        }
        $store_info = $model_store->getStoreInfoByID($order_info['store_id']);
        if (empty($store_info))
        {
            return callback(false, '店铺信息错误');
        }
        $order_goods = $model_order->getOrderGoodsList(array('order_id' => $order_id));
        if (empty($order_goods))
        {
            return callback(false, '订单信息错误');
        }
        $i = 0;
        $j = count($order_goods);
        while ($i < $j)
        {
            $order_goods[$i]['goods_image_url'] = cthumb($order_goods[$i]['goods_image'], 240, $store_info['store_id']);
            ++$i;
        }
        $date = array('order_info' => $order_info, 'store_info' => $store_info, 'order_goods' => $order_goods);
        return callback(true, '', $date);
    }
    public function save($date, $order_info, $store_info, $order_goods, $member_id, $member_name)
    {
        $model_order = Model('order');
        $model_evaluate_goods = Model('evaluate_goods');
        $model_evaluate_store = Model('evaluate_store');
        $evaluate_goods_array = array();
        $goodsid_array = array();
        foreach ($order_goods as $value )
        {
            $evaluate_score = intval($date['goods'][$value['rec_id']]['score']);
            if (($evaluate_score <= 0) || (5 < $evaluate_score))
            {
                $evaluate_score = 5;
            }
            $evaluate_comment = $date['goods'][$value['rec_id']]['comment'];
            if (empty($evaluate_comment))
            {
                $evaluate_comment = '不错哦';
            }
            $geval_image = '';
            if (isset($date['goods'][$value['rec_id']]['evaluate_image']) && is_array($date['goods'][$value['rec_id']]['evaluate_image']))
            {
                foreach ($date['goods'][$value['rec_id']]['evaluate_image'] as $val )
                {
                    if (!(empty($val)))
                    {
                        $geval_image .= $val . ',';
                    }
                }
            }
            $geval_image = rtrim($geval_image, ',');
            $evaluate_goods_info = array();
            $evaluate_goods_info['geval_orderid'] = $order_info['order_id'];
            $evaluate_goods_info['geval_orderno'] = $order_info['order_sn'];
            $evaluate_goods_info['geval_ordergoodsid'] = $value['rec_id'];
            $evaluate_goods_info['geval_goodsid'] = $value['goods_id'];
            $evaluate_goods_info['geval_goodsname'] = $value['goods_name'];
            $evaluate_goods_info['geval_goodsprice'] = $value['goods_price'];
            $evaluate_goods_info['geval_goodsimage'] = $value['goods_image'];
            $evaluate_goods_info['geval_scores'] = $evaluate_score;
            $evaluate_goods_info['geval_content'] = $evaluate_comment;
            $evaluate_goods_info['geval_isanonymous'] = (($date['goods'][$value['rec_id']]['anony'] ? 1 : 0));
            $evaluate_goods_info['geval_addtime'] = TIMESTAMP;
            $evaluate_goods_info['geval_storeid'] = $store_info['store_id'];
            $evaluate_goods_info['geval_storename'] = $store_info['store_name'];
            $evaluate_goods_info['geval_frommemberid'] = $member_id;
            $evaluate_goods_info['geval_frommembername'] = $member_name;
            $evaluate_goods_info['geval_image'] = $geval_image;
            $evaluate_goods_info['geval_content_again'] = '';
            $evaluate_goods_info['geval_image_again'] = '';
            $evaluate_goods_info['geval_explain_again'] = '';
            $evaluate_goods_array[] = $evaluate_goods_info;
            $goodsid_array[] = $value['goods_id'];
        }
        $model_evaluate_goods->addEvaluateGoodsArray($evaluate_goods_array, $goodsid_array);
        if (!($store_info['is_own_mall']))
        {
            $store_desccredit = intval($date['store_desccredit']);
            if (($store_desccredit <= 0) || (5 < $store_desccredit))
            {
                $store_desccredit = 5;
            }
            $store_servicecredit = intval($date['store_servicecredit']);
            if (($store_servicecredit <= 0) || (5 < $store_servicecredit))
            {
                $store_servicecredit = 5;
            }
            $store_deliverycredit = intval($date['store_deliverycredit']);
            if (($store_deliverycredit <= 0) || (5 < $store_deliverycredit))
            {
                $store_deliverycredit = 5;
            }
            $evaluate_store_info = array();
            $evaluate_store_info['seval_orderid'] = $order_info['order_id'];
            $evaluate_store_info['seval_orderno'] = $order_info['order_sn'];
            $evaluate_store_info['seval_addtime'] = time();
            $evaluate_store_info['seval_storeid'] = $store_info['store_id'];
            $evaluate_store_info['seval_storename'] = $store_info['store_name'];
            $evaluate_store_info['seval_memberid'] = $member_id;
            $evaluate_store_info['seval_membername'] = $member_name;
            $evaluate_store_info['seval_desccredit'] = $store_desccredit;
            $evaluate_store_info['seval_servicecredit'] = $store_servicecredit;
            $evaluate_store_info['seval_deliverycredit'] = $store_deliverycredit;
        }
        $model_evaluate_store->addEvaluateStore($evaluate_store_info);
        $state = $model_order->editOrder(array('evaluation_state' => 1), array('order_id' => $order_info['order_id']));
        if ($state)
        {
            $model_order->editOrderCommon(array('evaluation_time' => TIMESTAMP), array('order_id' => $order_info['order_id']));
            $data = array();
            $data['order_id'] = $order_info['order_id'];
            $data['log_role'] = 'buyer';
            $data['log_msg'] = L('order_log_eval');
            $model_order->addOrderLog($data);
        }
        if (C('points_isuse') == 1)
        {
            $points_model = Model('points');
            $points_model->savePointsLog('comments', array('pl_memberid' => $member_id, 'pl_membername' => $member_name));
        }
        Model('exppoints')->saveExppointsLog('comments', array('exp_memberid' => $member_id, 'exp_membername' => $member_name));
        return callback(true);
    }
    public function validationAgain($order_id, $member_id)
    {
        if (!($order_id))
        {
            return callback(false, '参数错误');
        }
        $model_order = Model('order');
        $model_store = Model('store');
        $model_evaluate_goods = Model('evaluate_goods');
        $order_info = $model_order->getOrderInfo(array('order_id' => $order_id));
        if ($order_info['buyer_id'] != $member_id)
        {
            return callback(false, '参数错误');
        }
        $order_info['evaluation_again'] = $model_order->getOrderOperateState('evaluation_again', $order_info);
        if (empty($order_info) || !($order_info['evaluation_again']))
        {
            return callback(false, '订单信息错误');
        }
        $store_info = $model_store->getStoreInfoByID($order_info['store_id']);
        if (empty($store_info))
        {
            return callback(false, '店铺信息错误');
        }
        $evaluate_goods = $model_evaluate_goods->getEvaluateGoodsList(array('geval_orderid' => $order_id));
        if (empty($evaluate_goods))
        {
            return callback(false, '订单信息错误');
        }
        $i = 0;
        $j = count($evaluate_goods);
        while ($i < $j)
        {
            $evaluate_goods[$i]['geval_goodsimage'] = cthumb($evaluate_goods[$i]['geval_goodsimage'], 240, $store_info['geval_storeid']);
            ++$i;
        }
        $date = array('order_info' => $order_info, 'store_info' => $store_info, 'evaluate_goods' => $evaluate_goods);
        return callback(true, '', $date);
    }
    public function saveAgain($date, $order_info, $evaluate_goods)
    {
        $model_order = Model('order');
        $model_evaluate_goods = Model('evaluate_goods');
        $model_evaluate_store = Model('evaluate_store');
        $goodsid_array = array();
        foreach ($evaluate_goods as $value )
        {
            $evaluate_comment = $date['goods'][$value['geval_id']]['comment'];
            if (empty($evaluate_comment))
            {
                $evaluate_comment = '不错哦';
            }
            $geval_image = '';
            if (!(empty($date['goods'][$value['geval_id']]['evaluate_image'])))
            {
                foreach ($date['goods'][$value['geval_id']]['evaluate_image'] as $val )
                {
                    if (!(empty($val)))
                    {
                        $geval_image .= $val . ',';
                    }
                }
            }
            $geval_image = rtrim($geval_image, ',');
            $evaluate_goods_info = array();
            $evaluate_goods_info['geval_content_again'] = $evaluate_comment;
            $evaluate_goods_info['geval_addtime_again'] = TIMESTAMP;
            $evaluate_goods_info['geval_image_again'] = $geval_image;
            $model_evaluate_goods->editEvaluateGoods($evaluate_goods_info, array('geval_id' => $value['geval_id']));
        }
        $state = $model_order->editOrder(array('evaluation_again_state' => 1), array('order_id' => $order_info['order_id']));
        if ($state)
        {
            $data = array();
            $data['order_id'] = $order_info['order_id'];
            $data['log_role'] = 'buyer';
            $data['log_msg'] = '追加评价';
            $model_order->addOrderLog($data);
        }
        return callback(true);
    }
    public function validationVr($order_id, $member_id)
    {
        if (!($order_id))
        {
            return callback(false, '参数错误');
        }
        $model_order = Model('vr_order');
        $model_store = Model('store');
        $order_info = $model_order->getOrderInfo(array('order_id' => $order_id));
        if ($order_info['buyer_id'] != $member_id)
        {
            return callback(false, '参数错误');
        }
        $order_info['evaluate_able'] = $model_order->getOrderOperateState('evaluation', $order_info);
        if (!($order_info['evaluate_able']))
        {
            return callback(false, '订单信息错误');
        }
        $store_info = $model_store->getStoreInfoByID($order_info['store_id']);
        if (empty($store_info))
        {
            return callback(false, '店铺信息错误');
        }
        $order_info['goods_image_url'] = cthumb($order_info['goods_image'], 60, $order_info['store_id']);
        $date = array('order_info' => $order_info, 'store_info' => $store_info);
        return callback(true, '', $date);
    }
    public function saveVr($date, $order_info, $store_info, $member_id, $member_name)
    {
        $evaluate_score = intval($date['goods'][$order_info['goods_id']]['score']);
        if (($evaluate_score <= 0) || (5 < $evaluate_score))
        {
            $evaluate_score = 5;
        }
        $evaluate_comment = $date['goods'][$order_info['goods_id']]['comment'];
        if (empty($evaluate_comment))
        {
            $evaluate_comment = '不错哦';
        }
        $evaluate_goods_info = array();
        $evaluate_goods_info['geval_orderid'] = $order_info['order_id'];
        $evaluate_goods_info['geval_orderno'] = $order_info['order_sn'];
        $evaluate_goods_info['geval_ordergoodsid'] = $order_info['order_id'];
        $evaluate_goods_info['geval_goodsid'] = $order_info['goods_id'];
        $evaluate_goods_info['geval_goodsname'] = $order_info['goods_name'];
        $evaluate_goods_info['geval_goodsprice'] = $order_info['goods_price'];
        $evaluate_goods_info['geval_goodsimage'] = $order_info['goods_image'];
        $evaluate_goods_info['geval_scores'] = $evaluate_score;
        $evaluate_goods_info['geval_content'] = $evaluate_comment;
        $evaluate_goods_info['geval_isanonymous'] = (($date['goods'][$order_info['goods_id']]['anony'] ? 1 : 0));
        $evaluate_goods_info['geval_addtime'] = TIMESTAMP;
        $evaluate_goods_info['geval_storeid'] = $store_info['store_id'];
        $evaluate_goods_info['geval_storename'] = $store_info['store_name'];
        $evaluate_goods_info['geval_frommemberid'] = $member_id;
        $evaluate_goods_info['geval_frommembername'] = $member_name;
        $evaluate_goods_array[] = $evaluate_goods_info;
        $goodsid_array[] = $order_info['goods_id'];
        Model('evaluate_goods')->addEvaluateGoodsArray($evaluate_goods_array, $goodsid_array);
        $model_order = Model('vr_order');
        $state = $model_order->editOrder(array('evaluation_state' => 1, 'evaluation_time' => TIMESTAMP), array('order_id' => $order_info['order_id']));
        if (C('points_isuse') == 1)
        {
            $points_model = Model('points');
            $points_model->savePointsLog('comments', array('pl_memberid' => $member_id, 'pl_membername' => $member_name));
        }
        Model('exppoints')->saveExppointsLog('comments', array('exp_memberid' => $member_id, 'exp_membername' => $member_name));
        return callback(true);
    }
    public function evaluateListDity($goods_eval_list)
    {
        if (empty($goods_eval_list))
        {
            return array();
        }
        foreach ($goods_eval_list as $key => $val )
        {
            $val['member_avatar'] = getMemberAvatarForID($val['geval_frommemberid']);
            if ($val['geval_isanonymous'] == 1)
            {
                $val['geval_frommembername'] = str_cut($val['geval_frommembername'], 2) . '***';
            }
            $geval_image_240 = array();
            $geval_image_1024 = array();
            if (!(empty($val['geval_image'])))
            {
                $image_array = explode(',', $val['geval_image']);
                foreach ($image_array as $value )
                {
                    $geval_image_240[] = snsThumb($value, 240);
                    $geval_image_1024[] = snsThumb($value, 1024);
                }
            }
            $val['geval_addtime_date'] = date('Y-m-d', $val['geval_addtime']);
            $val['geval_image_240'] = $geval_image_240;
            $val['geval_image_1024'] = $geval_image_1024;
            $geval_image_again_240 = array();
            $geval_image_again_1024 = array();
            if (!(empty($val['geval_image_again'])))
            {
                $image_array = explode(',', $val['geval_image_again']);
                foreach ($image_array as $value )
                {
                    $geval_image_again_240[] = snsThumb($value, 240);
                    $geval_image_again_1024[] = snsThumb($value, 1024);
                }
            }
            $val['geval_addtime_again_date'] = date('Y-m-d', $val['geval_addtime_again']);
            $val['geval_image_again_240'] = $geval_image_again_240;
            $val['geval_image_again_1024'] = $geval_image_again_1024;
            unset($val['geval_id'], $val['geval_orderid'], $val['geval_orderno'], $val['geval_ordergoodsid'], $val['geval_goodsid'], $val['geval_goodsname'], $val['geval_goodsprice'], $val['geval_goodsimage'], $val['geval_isanonymous'], $val['geval_storeid'], $val['geval_storename'], $val['geval_image'], $val['geval_image_again']);
            $goods_eval_list[$key] = $val;
        }
        return $goods_eval_list;
    }
}
?>