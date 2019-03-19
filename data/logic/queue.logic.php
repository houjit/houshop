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
class queueLogic
{
    public function addPoint($member_info)
    {
        $points_model = Model('points');
        $points_model->savePointsLog('login', array('pl_memberid' => $member_info['member_id'], 'pl_membername' => $member_info['member_name']), true);
        return callback(true);
    }
    public function addExppoint($member_info)
    {
        $exppoints_model = Model('exppoints');
        $exppoints_model->saveExppointsLog('login', array('exp_memberid' => $member_info['member_id'], 'exp_membername' => $member_info['member_name']), true);
        return callback(true);
    }
    public function editGroupbuySaleCount($groupbuy_info)
    {
        $model_groupbuy = Model('groupbuy');
        $data = array();
        $data['buyer_count'] = array('exp', 'buyer_count+1');
        $data['buy_quantity'] = array('exp', 'buy_quantity+' . $groupbuy_info['quantity']);
        $update = $model_groupbuy->editGroupbuy($data, array('groupbuy_id' => $groupbuy_info['groupbuy_id']));
        if (!($update))
        {
            return callback(false, '更新团购信息失败groupbuy_id:' . $groupbuy_info['groupbuy_id']);
        }
        return callback(true);
    }
    public function editVoucherState($voucher_list)
    {
        $model_voucher = Model('voucher');
        $send = new sendMemberMsg();
        foreach ($voucher_list as $store_id => $voucher_info )
        {
            $update = $model_voucher->editVoucher(array('voucher_state' => 2), array('voucher_id' => $voucher_info['voucher_id']), $voucher_info['voucher_owner_id']);
            if ($update)
            {
                $update = $model_voucher->editVoucherTemplate(array('voucher_t_id' => $voucher_info['voucher_t_id']), array( 'voucher_t_used' => array('exp', 'voucher_t_used+1') ));
                if ($update)
                {
                    $send->set('member_id', $voucher_info['voucher_owner_id']);
                    $send->set('code', 'voucher_use');
                    $param = array();
                    $param['voucher_code'] = $voucher_info['voucher_code'];
                    $param['voucher_url'] = urlMember('member_voucher', 'index');
                    $send->send($param);
                }
                else
                {
                    return callback(false, '更新代金券状态失败tpl:' . $voucher_info['voucher_t_id']);
                }
            }
            else
            {
                return callback(false, '更新代金券状态失败vcode:' . $voucher_info['voucher_code']);
            }
        }
        return callback(true);
    }
    public function editRptState($input_rpt_info, $pay_sn)
    {
        $model_rpt = Model('redpacket');
        $update = $model_rpt->editRedpacket(array('rpacket_id' => $input_rpt_info['rpacket_id']), array('rpacket_state' => 2, 'rpacket_order_id' => $pay_sn), $input_rpt_info['rpacket_owner_id']);
        if ($update)
        {
            $update = $model_rpt->editRptTemplate(array('rpacket_t_id' => $input_rpt_info['rpacket_t_id']), array( 'rpacket_t_used' => array('exp', 'rpacket_t_used+1') ));
            if ($update)
            {
                $send = new sendMemberMsg();
                $send->set('member_id', $input_rpt_info['rpacket_owner_id']);
                $send->set('code', 'rpt_use');
                $param = array();
                $param['rpacket_code'] = $input_rpt_info['rpacket_code'];
                $param['rpacket_url'] = urlMember('member_redpacket', 'index');
                $send->send($param);
            }
            else
            {
                return callback(false, '更新红包状态失败tpl:' . $input_rpt_info['rpacket_t_id']);
            }
        }
        else
        {
            return callback(false, '更新红包状态失败vcode:' . $input_rpt_info['rpacket_code']);
        }
        return callback(true);
    }
    public function createOrderUpdateStorage($goods_buy_quantity)
    {
        $model_goods = Model('goods');
        foreach ($goods_buy_quantity as $goods_id => $quantity )
        {
            while (!($result))
            {
                $data = array();
                $data['goods_storage'] = array('exp', 'goods_storage-' . $quantity);
                $data['goods_salenum'] = array('exp', 'goods_salenum+' . $quantity);
                $result = $model_goods->editGoodsById($data, $goods_id);
                break;
            }
        }
        if (!($result))
        {
            return callback(false, '变更商品库存与销量失败');
        }
        return callback(true);
    }
    public function createOrderUpdateChainStorage($goods_buy_quantity, $chain_id)
    {
        $model_chain = Model('chain_stock');
        $condition = array();
        $condition['chain_id'] = $chain_id;
        foreach ($goods_buy_quantity as $goods_id => $quantity )
        {
            while (!($result))
            {
                $data = array();
                $data['stock'] = array('exp', 'stock-' . $quantity);
                $condition['goods_id'] = $goods_id;
                $result = $model_chain->editChainStock($data, $condition);
                break;
            }
        }
        if (!($result))
        {
            return callback(false, '变更门店自提点商品库存失败');
        }
        return callback(true);
    }
    public function cancelOrderUpdateStorage($goods_buy_quantity)
    {
        $model_goods = Model('goods');
        foreach ($goods_buy_quantity as $goods_id => $quantity )
        {
            while (!($result))
            {
                $data = array();
                $data['goods_storage'] = array('exp', 'goods_storage+' . $quantity);
                $data['goods_salenum'] = array('exp', 'goods_salenum-' . $quantity);
                $result = $model_goods->editGoodsById($data, $goods_id);
                break;
            }
        }
        if (!($result))
        {
            return callback(false, '变更商品库存与销量失败');
        }
        return callback(true);
    }
    public function cancelOrderUpdateChainStorage($goods_buy_quantity, $chain_id)
    {
        $model_chain = Model('chain_stock');
        $condition = array();
        $condition['chain_id'] = $chain_id;
        foreach ($goods_buy_quantity as $goods_id => $quantity )
        {
            while (!($result))
            {
                $data = array();
                $data['stock'] = array('exp', 'stock+' . $quantity);
                $condition['goods_id'] = $goods_id;
                $result = $model_chain->editChainStock($data, $condition);
                break;
            }
        }
        if (!($result))
        {
            return callback(false, '变更门店自提点商品库存失败');
        }
        return callback(true);
    }
    public function updateGoodsFCode($fc_id)
    {
        $update = Model('goods_fcode')->editGoodsFCode(array('fc_state' => 1), array('fc_id' => $fc_id));
        if (!($update))
        {
            return callback(false, '更新F码使用状态失败fc_id:' . $fc_id);
        }
        return callback(true);
    }
    public function delCart($cart)
    {
        if (!(is_array($cart['cart_ids'])) || empty($cart['buyer_id']))
        {
            return callback(true);
        }
        $del = Model('cart')->delCart('db', array( 'buyer_id' => $cart['buyer_id'], 'cart_id' => array('in', $cart['cart_ids']) ));
        if (!($del))
        {
            return callback(false, '删除购物车数据失败');
        }
        return callback(true);
    }
    public function updateGoodsPromotionPriceByGoodsId($goods_id)
    {
        $update = Model('goods')->editGoodsPromotionPrice(array( 'goods_id' => array('in', $goods_id) ));
        if (!($update))
        {
            return callback(false, '根据商品ID更新促销价格失败');
        }
        return callback(true);
    }
    public function updateGoodsPromotionPriceByGoodsCommonId($goods_commonid)
    {
        $update = Model('goods')->editGoodsPromotionPrice(array( 'goods_commonid' => array('in', $goods_commonid) ));
        if (!($update))
        {
            return callback(false, '根据商品公共id更新促销价格失败');
        }
        return callback(true);
    }
    public function sendStoreMsg($param)
    {
        $send = new sendStoreMsg();
        $send->set('code', $param['code']);
        $send->set('store_id', $param['store_id']);
        $send->send($param['param']);
        return callback(true);
    }
    public function sendMemberMsg($param)
    {
        $send = new sendMemberMsg();
        $send->set('code', $param['code']);
        $send->set('member_id', $param['member_id']);
        if (!(empty($param['number']['mobile'])))
        {
            $send->set('mobile', $param['number']['mobile']);
        }
        if (!(empty($param['number']['email'])))
        {
            $send->set('email', $param['number']['email']);
        }
        $send->send($param['param']);
        return callback(true);
    }
    public function createGoodsFCode($param)
    {
        $insert = array();
        $i = 0;
        while ($i < $param['fc_count'])
        {
            $array = array();
            $array['goods_id'] = $param['goods_id'];
            $array['fc_code'] = strtoupper($param['fc_prefix']) . mt_rand(100000, 999999);
            $insert[$array['fc_code']] = $array;
            ++$i;
        }
        if (!(empty($insert)))
        {
            $insert = array_values($insert);
            $insert = Model('goods_fcode')->addGoodsFCodeAll($insert);
            if (!($insert))
            {
                return callback(false, '生成商品F码失败goods_id:' . $param['goods_id']);
            }
        }
        return callback(true);
    }
    public function createGoodsQRCode($param)
    {
        if (empty($param['goodsid_array']))
        {
            return callback(true);
        }
        require_once BASE_RESOURCE_PATH . DS . 'phpqrcode' . DS . 'index.php';
        $PhpQRCode = new PhpQRCode();
        $PhpQRCode->set('pngTempDir', BASE_UPLOAD_PATH . DS . ATTACH_STORE . DS . $param['store_id'] . DS);
        foreach ($param['goodsid_array'] as $goods_id )
        {
            $PhpQRCode->set('date', WAP_SITE_URL . DS . tmpl . DS . product_detail . '.' . html . '?' . goods_id . '=' . $goods_id);
            $PhpQRCode->set('pngTempName', $goods_id . '.png');
            $PhpQRCode->init();
            $logo = BASE_UPLOAD_PATH . DS . ATTACH_STORE . DS . 'small-logo.png';
            $QR = BASE_UPLOAD_PATH . DS . ATTACH_STORE . DS . $param['store_id'] . DS . $goods_id . '.png';
            if ($logo !== false)
            {
                $QR = imagecreatefromstring(file_get_contents($QR));
                $logo = imagecreatefromstring(file_get_contents($logo));
                $QR_width = imagesx($QR);
                $QR_height = imagesy($QR);
                $logo_width = imagesx($logo);
                $logo_height = imagesy($logo);
                $logo_qr_width = $QR_width / 5;
                $scale = $logo_width / $logo_qr_width;
                $logo_qr_height = $logo_height / $scale;
                $from_width = ($QR_width - $logo_qr_width) / 2;
                imagecopyresampled($QR, $logo, $from_width, $from_width, 0, 0, $logo_qr_width, $logo_qr_height, $logo_width, $logo_height);
            }
            imagepng($QR, BASE_UPLOAD_PATH . DS . ATTACH_STORE . DS . $param['store_id'] . DS . $goods_id . '.png');
        }
        return callback(true);
    }
    public function clearSpecialGoodsPromotion($param)
    {
        Model('groupbuy')->delGroupbuy(array('goods_commonid' => $param['goods_commonid']));
        Model('p_xianshi_goods')->delXianshiGoods(array( 'goods_id' => array('in', $param['goodsid_array']) ));
        Model('p_bundling')->delBundlingGoods(array( 'goods_id' => array('in', $param['goodsid_array']) ));
        Model('goods')->editGoods(array( 'goods_promotion_price' => array('exp', 'goods_price'), 'goods_promotion_type' => 0 ), array('goods_commonid' => $param['goods_commonid']));
        return callback(true);
    }
    public function delOrderCountCache($order_info)
    {
        if (empty($order_info))
        {
            return callback(true);
        }
        $model_order = Model('order');
        if ($order_info['order_id'])
        {
            $order_info = $model_order->getOrderInfo(array('order_id' => $order_info['order_id']), array(), 'buyer_id,store_id');
        }
        $model_order->delOrderCountCache('buyer', $order_info['buyer_id']);
        $model_order->delOrderCountCache('store', $order_info['store_id']);
        return callback(true);
    }
    public function sendVrCode($param)
    {
        if (empty($param) && !(is_array($param)))
        {
            return callback(true);
        }
        $condition = array();
        $condition['order_id'] = $param['order_id'];
        $condition['buyer_id'] = $param['buyer_id'];
        $condition['vr_state'] = 0;
        $condition['refund_lock'] = 0;
        $code_list = Model('vr_order')->getOrderCodeList($condition, 'vr_code,vr_indate');
        if (empty($code_list))
        {
            return callback(true);
        }
        $content = '';
        foreach ($code_list as $v )
        {
            $content .= $v['vr_code'] . ',';
        }
        $tpl_info = Model('mail_templates')->getTplInfo(array('code' => 'send_vr_code'));
        $data = array();
        $data['site_name'] = C('site_name');
        $data['vr_code'] = rtrim($content, ',');
        $message = ncReplaceText($tpl_info['content'], $data);
        $sms = new Sms();
        $result = $sms->send($param['buyer_phone'], $message);
        if (!($result))
        {
            return callback(false, '兑换码发送失败order_id:' . $param['order_id']);
        }
        return callback(true);
    }
    public function saveDeliveryOrder($param)
    {
        if (!(is_array($param['order_sn_list'])))
        {
            return callback(true);
        }
        $data = array();
        $model_delivery_order = Model('delivery_order');
        foreach ($param['order_sn_list'] as $order_id => $v )
        {
            while (!($insert))
            {
                $data['order_id'] = $order_id;
                $data['order_sn'] = $v['order_sn'];
                $data['addtime'] = $v['add_time'];
                $data['dlyp_id'] = $param['dlyp_id'];
                $data['reciver_name'] = $param['reciver_name'];
                $data['reciver_telphone'] = $param['tel_phone'];
                $data['reciver_mobphone'] = $param['mob_phone'];
                $insert = $model_delivery_order->addDeliveryOrder($data);
                return callback(false, '保存自提站订单信息失败order_sn:' . $v['order_sn']);
            }
        }
        return callback(true);
    }
    public function sendPickupcode($param)
    {
        $dorder_info = Model('delivery_order')->getDeliveryOrderInfo(array('order_id' => $param['order_id']), 'reciver_mobphone');
        $tpl_info = Model('mail_templates')->getTplInfo(array('code' => 'send_pickup_code'));
        $data = array();
        $data['site_name'] = C('site_name');
        $data['pickup_code'] = $param['pickup_code'];
        $message = ncReplaceText($tpl_info['content'], $data);
        $sms = new Sms();
        $result = $sms->send($dorder_info['reciver_mobphone'], $message);
        if (!($result))
        {
            return callback(false, '发送提货码短信消息失败order_id:' . $param['order_id']);
        }
        return callback(true);
    }
    public function sendChainCode($order_info)
    {
        $tpl_info = Model('mail_templates')->getTplInfo(array('code' => 'send_chain_code'));
        $data = array();
        $data['site_name'] = C('site_name');
        $data['chain_code'] = $order_info['chain_code'];
        $data['order_sn'] = $order_info['order_sn'];
        $message = ncReplaceText($tpl_info['content'], $data);
        $sms = new Sms();
        $result = $sms->send($order_info['buyer_phone'], $message);
        if (!($result))
        {
            return callback(false, '发送门店提货码短信消息失败order_sn:' . $order_info['order_sn']);
        }
        return callback(true);
    }
    public function flushIndexer()
    {
        try
        {
            require_once BASE_DATA_PATH . '/api/xs/lib/XS.php';
            $obj_doc = new XSDocument();
            $obj_xs = new XS(C('fullindexer.appname'));
            $obj_xs->index->flushIndex();
            return;
        }
        catch (XSException $e)
        {
            if (C('debug'))
            {
                showMessage('全文搜索出现异常', '', 'html', 'error');
                return;
            }
            Log::record('search\\index' . $e->getMessage() . "\r\n", Log::RUN);
            return false;
        }
        showMessage('全文搜索出现异常', '', 'html', 'error');
        return;
        Log::record('search\\index' . $e->getMessage() . "\r\n", Log::RUN);
        return false;
    }
    public function build_pwdvoucher($t_id)
    {
        $t_id = intval($t_id);
        if ($t_id <= 0)
        {
            return callback(false, '参数错误');
        }
        $model_voucher = Model('voucher');
        $where = array();
        $where['voucher_t_id'] = $t_id;
        $gettype_arr = $model_voucher->getVoucherGettypeArray();
        $where['voucher_t_gettype'] = $gettype_arr['pwd']['sign'];
        $where['voucher_t_isbuild'] = 0;
        $where['voucher_t_state'] = 1;
        $t_info = $model_voucher->getVoucherTemplateInfo($where);
        $t_total = intval($t_info['voucher_t_total']);
        if ($t_total <= 0)
        {
            return callback(false, '代金券模板信息错误');
        }
        while (0 < $t_total)
        {
            $is_succ = false;
            $insert_arr = array();
            $step = ((1000 < $t_total ? 1000 : $t_total));
            $t = 0;
            while ($t < $step)
            {
                $voucher_code = $model_voucher->get_voucher_code(0);
                if (!($voucher_code))
                {
                    continue;
                }
                $voucher_pwd_arr = $model_voucher->create_voucher_pwd($t_info['voucher_t_id']);
                if (!($voucher_pwd_arr))
                {
                    continue;
                }
                $tmp = array();
                $tmp['voucher_code'] = $voucher_code;
                $tmp['voucher_t_id'] = $t_info['voucher_t_id'];
                $tmp['voucher_title'] = $t_info['voucher_t_title'];
                $tmp['voucher_desc'] = $t_info['voucher_t_desc'];
                $tmp['voucher_start_date'] = $t_info['voucher_t_start_date'];
                $tmp['voucher_end_date'] = $t_info['voucher_t_end_date'];
                $tmp['voucher_price'] = $t_info['voucher_t_price'];
                $tmp['voucher_limit'] = $t_info['voucher_t_limit'];
                $tmp['voucher_store_id'] = $t_info['voucher_t_store_id'];
                $tmp['voucher_state'] = 1;
                $tmp['voucher_active_date'] = time();
                $tmp['voucher_owner_id'] = 0;
                $tmp['voucher_owner_name'] = '';
                $tmp['voucher_order_id'] = 0;
                $tmp['voucher_pwd'] = $voucher_pwd_arr[0];
                $tmp['voucher_pwd2'] = $voucher_pwd_arr[1];
                $insert_arr[] = $tmp;
                --$t_total;
                ++$t;
            }
            $result = $model_voucher->addVoucherBatch($insert_arr);
            if ($result && ($is_succ == false))
            {
                $is_succ = true;
            }
        }
        if ($is_succ)
        {
            $model_voucher->editVoucherTemplate(array('voucher_t_id' => $t_info['voucher_t_id']), array('voucher_t_isbuild' => 1));
            return callback(true);
        }
        return callback(false);
    }
    public function build_pwdRedpacket($t_id)
    {
        $t_id = intval($t_id);
        if ($t_id <= 0)
        {
            return callback(false, '参数错误');
        }
        $model_redpacket = Model('redpacket');
        $gettype_arr = $model_redpacket->getGettypeArr();
        $redpacket_state_arr = $model_redpacket->getRedpacketState();
        $where = array();
        $where['rpacket_t_id'] = $t_id;
        $where['rpacket_t_gettype'] = $gettype_arr['pwd']['sign'];
        $where['rpacket_t_isbuild'] = 0;
        $where['rpacket_t_state'] = 1;
        $t_info = $model_redpacket->getRptTemplateInfo($where);
        $t_total = intval($t_info['rpacket_t_total']);
        if ($t_total <= 0)
        {
            return callback(false, '红包模板信息错误');
        }
        while (0 < $t_total)
        {
            $is_succ = false;
            $insert_arr = array();
            $step = ((1000 < $t_total ? 1000 : $t_total));
            $t = 0;
            while ($t < $step)
            {
                $code = $model_redpacket->get_rpt_code(0);
                if (!($code))
                {
                    continue;
                }
                $pwd_arr = $model_redpacket->create_rpt_pwd($t_info['rpacket_t_id']);
                if (!($pwd_arr))
                {
                    continue;
                }
                $tmp = array();
                $tmp['rpacket_code'] = $code;
                $tmp['rpacket_t_id'] = $t_info['rpacket_t_id'];
                $tmp['rpacket_title'] = $t_info['rpacket_t_title'];
                $tmp['rpacket_desc'] = $t_info['rpacket_t_desc'];
                $tmp['rpacket_start_date'] = $t_info['rpacket_t_start_date'];
                $tmp['rpacket_end_date'] = $t_info['rpacket_t_end_date'];
                $tmp['rpacket_price'] = $t_info['rpacket_t_price'];
                $tmp['rpacket_limit'] = $t_info['rpacket_t_limit'];
                $tmp['rpacket_state'] = $redpacket_state_arr['unused']['sign'];
                $tmp['rpacket_active_date'] = 0;
                $tmp['rpacket_owner_id'] = 0;
                $tmp['rpacket_owner_name'] = '';
                $tmp['rpacket_order_id'] = 0;
                $tmp['rpacket_pwd'] = $pwd_arr[0];
                $tmp['rpacket_pwd2'] = $pwd_arr[1];
                $tmp['rpacket_customimg'] = $t_info['rpacket_t_customimg'];
                $insert_arr[] = $tmp;
                --$t_total;
                ++$t;
            }
            $result = $model_redpacket->addRedpacketBatch($insert_arr);
            if ($result && ($is_succ == false))
            {
                $is_succ = true;
            }
        }
        if ($is_succ)
        {
            $model_redpacket->editRptTemplate(array('rpacket_t_id' => $t_info['rpacket_t_id']), array('rpacket_t_isbuild' => 1));
            return callback(true);
        }
        return callback(false);
    }
    public function updateStoreGoodsContract($param)
    {
        $store_id = intval($param['store_id']);
        $item_id = intval($param['item_id']);
        if (($store_id <= 0) || ($item_id <= 0))
        {
            return callback(false, '参数错误');
        }
        $model_contract = Model('contract');
        $where = array();
        $where['ct_storeid'] = $store_id;
        $where['ct_itemid'] = $item_id;
        $c_info = $model_contract->getContractInfo($where);
        if (!($c_info))
        {
            return callback(false, '店铺保障服务信息错误');
        }
        $goods_contractstate_arr = $model_contract->getGoodsContractState();
        $update_arr = array();
        if (($c_info['ct_joinstate_key'] == 'added') && ($c_info['ct_closestate_key'] == 'open'))
        {
            $update_arr['contract_' . $item_id] = $goods_contractstate_arr['open']['sign'];
        }
        else
        {
            $update_arr['contract_' . $item_id] = $goods_contractstate_arr['close']['sign'];
        }
        $model_goods = Model('goods');
        $goods_count = $model_goods->getGoodsCount(array('store_id' => $store_id));
        if ($goods_count <= 0)
        {
            return callback(true);
        }
        $eachnum = 1000;
        $i = 0;
        while ($i < $goods_count)
        {
            $goods_list = $model_goods->getGoodsList(array('store_id' => $store_id), 'goods_id', '', 'goods_id asc', $i . ',' . $eachnum);
            if (empty($goods_list))
            {
                break;
            }
            $goodsid_array = array();
            foreach ($goods_list as $value )
            {
                $goodsid_array[] = $value['goods_id'];
            }
            $model_goods->editGoodsById($update_arr, $goodsid_array);
            $i += $eachnum;
        }
    }
    public function createSphot($order_id_list = array())
    {
        $goods_list = Model('order')->getOrderGoodsList(array( 'order_id' => array('in', $order_id_list) ), 'rec_id,goods_id');
        if ($goods_list)
        {
            $model_sp = Model('order_snapshot');
            foreach ($goods_list as $goods_info )
            {
                $model_sp->createSphot($goods_info['rec_id'], $goods_info['goods_id']);
            }
        }
    }
    public function createVrSphot($order_info = array())
    {
        return Model('vr_order_snapshot')->createSphot($order_info['order_id'], $order_info['goods_id']);
    }
    public function updateXS($goods_ids)
    {
        try
        {
            require_once BASE_DATA_PATH . '/api/xs/lib/XS.php';
            $obj_doc = new XSDocument();
            $obj_xs = new XS(C('fullindexer.appname'));
            $obj_xs->index->del($goods_ids);
            $obj_xs->index->flushIndex();
            return;
        }
        catch (XSException $e)
        {
            if (C('debug'))
            {
                showMessage('全文搜索出现异常', '', 'html', 'error');
                return;
            }
            Log::record('search\\index' . $e->getMessage() . "\r\n", Log::RUN);
            return false;
        }
        showMessage('全文搜索出现异常', '', 'html', 'error');
        return;
        Log::record('search\\index' . $e->getMessage() . "\r\n", Log::RUN);
        return false;
    }
    public function addConsume($data)
    {
        if (Model('consume')->addConsume($data))
        {
            return callback(true);
        }
        return callback(false);
    }
}
?>