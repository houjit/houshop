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
defined('INSYSVIEW') or exit ('Access Invalid!');
class buyLogic
{
    private $_member_info = array();
    private $_order_data = array();
    private $_post_data = array();
    private $_logic_buy_1;
    public function __construct()
    {
        $this->_logic_buy_1 = Logic('buy_1');
    }
    public function buyStep1($cart_id, $ifcart, $member_id, $store_id, $jjg = NULL, $orderdiscount = 0, $member_level = 0, $ifchain = NULL)
    {
        $orderdiscount = 0;
        if (0 < $orderdiscount)
        {
            $own_mall_ids = Model('store')->getOwnMallIds();
            $orderdiscounts = array();
            foreach ($own_mall_ids as $store_id )
            {
                $orderdiscounts[$store_id] = $orderdiscount;
            }
        }
        if ($ifcart)
        {
            $result = $this->getCartList($cart_id, $member_id, $jjg, $orderdiscounts);
        }
        else
        {
            $result = $this->getGoodsList($cart_id, $member_id, $store_id, $orderdiscounts);
        }
        if (!($result['state']))
        {
            return $result;
        }
        $result = $this->getBuyStep1Data($member_id, $result['data'], $orderdiscount);
        if (!($ifcart) && (count($result['data']['store_cart_list']) == 1))
        {
            $goods_info = current($result['data']['store_cart_list']);
            if ($goods_info[0]['is_chain'])
            {
                $ifchain = 1;
            }
        }
        if ($ifchain && (count($result['data']['store_cart_list']) == 1))
        {
            $result['data']['ifchain'] = true;
            $result['data']['ifshow_chainpay'] = true;
            $result['data']['chain_store_id'] = key($result['data']['store_cart_list']);
        }
        $result['data']['zk_list'] = array();
        return $result;
    }
    public function getCartList($cart_id, $member_id, $jjg = NULL, $orderdiscounts = array())
    {
        $model_cart = Model('cart');
        $buy_items = $this->_parseItems($cart_id);
        if (empty($buy_items))
        {
            return callback(false, '所购商品无效');
        }
        if (50 < count($buy_items))
        {
            return callback(false, '一次最多只可购买50种商品');
        }
        $condition = array( 'cart_id' => array('in', array_keys($buy_items)), 'buyer_id' => $member_id );
        $cart_list = $model_cart->listCart('db', $condition);
        $jjgObj = NULL;
        if ($jjg && is_array($jjg))
        {
            $jjgObj = new StdClass();
            $jjgObj->jjgPostData = $this->jjgPostDataParser($jjg);
        }
        $cart_list = $this->_logic_buy_1->getGoodsCartList($cart_list, $jjgObj);
        $jjgCosts = array();
        $jjgStores = array();
        foreach ($cart_list as $cart )
        {
            $jjgId = (int) $cart['jjgRank'];
            if ((0 < $jjgId) && isset($jjgObj->jjgPostData[$jjgId]))
            {
                $jjgItemCost = $cart['goods_price'] * $cart['goods_num'];
                if (isset($jjgCosts[$jjgId]))
                {
                    $jjgCosts[$jjgId] += $jjgItemCost;
                }
                else
                {
                    $jjgCosts[$jjgId] = $jjgItemCost;
                }
                $jjgStores[$jjgId] = $cart['store_id'];
            }
        }
        $jjgValidSkus = array();
        $jjgStoreCosts = array();
        foreach ((array) $jjgObj->jjgPostData as $jjgId => $v )
        {
            foreach ((array) $v as $levelId => $vv )
            {
                $itemCounter = 0;
                foreach ((array) $vv as $skuId => $vvv )
                {
                    if (isset($jjgObj->details['cou'][$jjgId]['levels'][$levelId]) && isset($jjgObj->details['cou'][$jjgId]['levelSkus'][$levelId][$skuId]))
                    {
                        $mincost = $jjgObj->details['cou'][$jjgId]['levels'][$levelId]['mincost'];
                        $maxcou = $jjgObj->details['cou'][$jjgId]['levels'][$levelId]['maxcou'];
                        $itemPrice = $jjgObj->details['cou'][$jjgId]['levelSkus'][$levelId][$skuId]['price'];
                        if ((0 < $maxcou) && ($maxcou <= $itemCounter))
                        {
                            break;
                        }
                        if (($mincost - $jjgCosts[$jjgId]) < 0.01)
                        {
                            ++$itemCounter;
                            $g = $jjgObj->details['items'][$skuId];
                            $g['jjgId'] = $jjgId;
                            $g['jjgLevel'] = $levelId;
                            $g['jjgPrice'] = $itemPrice;
                            $jjgValidSkus[$jjgId][$skuId] = $g;
                            $jjgStoreCosts[$jjgStores[$jjgId]] += $itemPrice;
                        }
                    }
                }
            }
        }
        $goods_list = $this->_getGoodsList($cart_list);
        $store_cart_list = $this->_getStoreCartList($cart_list);
        if (empty($store_cart_list) || !(is_array($store_cart_list)))
        {
            return callback(false, '提交数据错误');
        }
        return callback(true, '', array('goods_list' => $goods_list, 'store_cart_list' => $store_cart_list, 'jjgValidSkus' => $jjgValidSkus, 'jjgStoreCosts' => $jjgStoreCosts));
    }
    protected function jjgPostDataParser($jjg)
    {
        $r = array();
        foreach ((array) $jjg as $j )
        {
            if (preg_match('/^(\\d+)\\|(\\d+)\\|(\\d+)$/', $j, $m))
            {
                $r[$m[1]][$m[2]][$m[3]] = 1;
            }
        }
        return $r;
    }
    public function getGoodsList($cart_id, $member_id, $store_id, $orderdiscounts = array())
    {
        $buy_items = $this->_parseItems($cart_id);
        if (empty($buy_items))
        {
            return callback(false, '所购商品无效');
        }
        $goods_id = key($buy_items);
        $quantity = current($buy_items);
        $goods_info = $this->_logic_buy_1->getGoodsOnlineInfo($goods_id, intval($quantity));
        if (empty($goods_info))
        {
            return callback(false, '商品已下架或不存在');
        }
        if ($goods_info['store_id'] == $store_id)
        {
            return callback(false, '不能购买自己店铺的商品');
        }
        if (!($goods_info['is_book']))
        {
        }
        $store_cart_list = array();
        $goods_list = array();
        $goods_list[0] = $store_cart_list[$goods_info['store_id']][0] = $goods_info;
        return callback(true, '', array('goods_list' => $goods_list, 'store_cart_list' => $store_cart_list, 'is_book' => $goods_info['is_book']));
    }
    public function getBuyStep1Data($member_id, $data, $orderdiscount = 0)
    {
        $goods_list = $data['goods_list'];
        $store_cart_list = $data['store_cart_list'];
        list($store_cart_list, $store_goods_total) = $this->_logic_buy_1->calcCartList($store_cart_list);
        $jjgValidSkus = $data['jjgValidSkus'];
        $jjgStoreCosts = $data['jjgStoreCosts'];
        foreach ((array) $store_goods_total as $k => $v )
        {
            if (isset($jjgStoreCosts[$k]))
            {
                $v += $jjgStoreCosts[$k];
                $store_goods_total[$k] = ncPriceFormat($v);
            }
        }
        $result = array();
        $result['jjgValidSkus'] = $jjgValidSkus;
        $result['jjgStoreCosts'] = $jjgStoreCosts;
        $result['store_cart_list'] = $store_cart_list;
        $result['store_goods_total'] = $store_goods_total;
        if (!($data['is_book']))
        {
            list($store_premiums_list, $store_mansong_rule_list) = $this->_logic_buy_1->getMansongRuleCartListByTotal($store_goods_total);
            $result['store_premiums_list'] = $store_premiums_list;
            $result['store_mansong_rule_list'] = $store_mansong_rule_list;
            $store_goods_total = $this->_logic_buy_1->reCalcGoodsTotal($store_goods_total, $store_mansong_rule_list, 'mansong');
            if (APP_ID == 'mobile')
            {
                $result['store_goods_total_1'] = $store_goods_total;
            }
            $result['store_voucher_list'] = $this->_logic_buy_1->getStoreAvailableVoucherList($store_goods_total, $member_id);
            $result['rpt_list'] = $this->_logic_buy_1->getStoreAvailableRptList($member_id);
            $result['rpt_list'] = array_values($result['rpt_list']);
        }
        else
        {
            $result['store_premiums_list'] = $result['store_mansong_rule_list'] = $result['store_voucher_list'] = $result['rpt_list'] = array();
        }
        $cancel_calc_sid_list = $this->_logic_buy_1->getStoreFreightDescList($store_goods_total);
        $result['cancel_calc_sid_list'] = $cancel_calc_sid_list;
        $freight_list = $this->_logic_buy_1->getStoreFreightList($goods_list, array_keys($cancel_calc_sid_list));
        $result['freight_list'] = $this->buyEncrypt($freight_list, $member_id);
        $result['address_info'] = Model('address')->getDefaultAddressInfo(array('member_id' => $member_id));
        $pay_goods_list = $this->_logic_buy_1->getOfflineGoodsPay($goods_list);
        if (!(empty($pay_goods_list['offline'])))
        {
            $result['pay_goods_list'] = $pay_goods_list;
            $result['ifshow_offpay'] = true;
        }
        else
        {
            $result['deny_edit_payment'] = true;
        }
        foreach ($goods_list as $goods )
        {
            while (!(intval($goods['goods_vat'])))
            {
                $vat_deny = true;
                break;
            }
        }
        $result['vat_deny'] = $vat_deny;
        $result['vat_hash'] = $this->buyEncrypt(($result['vat_deny'] ? 'deny_vat' : 'allow_vat'), $member_id);
        $inv_info = Model('invoice')->getDefaultInvInfo(array('member_id' => $member_id));
        if (($inv_info['inv_state'] == '2') && !($vat_deny))
        {
            $inv_info['content'] = '增值税发票 ' . $inv_info['inv_company'] . ' ' . $inv_info['inv_code'] . ' ' . $inv_info['inv_reg_addr'];
        }
        else if (($inv_info['inv_state'] == '2') && $vat_deny)
        {
            $inv_info = array();
            $inv_info['content'] = '不需要发票';
        }
        else if (!(empty($inv_info)))
        {
            $inv_info['content'] = '普通发票 ' . $inv_info['inv_title'] . ' ' . $inv_info['inv_content'];
        }
        else
        {
            $inv_info = array();
            $inv_info['content'] = '不需要发票';
        }
        $result['inv_info'] = $inv_info;
        if (APP_ID == 'mobile')
        {
            $buyer_info = Model('member')->getMemberInfoByID($member_id);
            if (0 < floatval($buyer_info['available_predeposit']))
            {
                $result['available_predeposit'] = $buyer_info['available_predeposit'];
            }
            if (0 < floatval($buyer_info['available_rc_balance']))
            {
                $result['available_rc_balance'] = $buyer_info['available_rc_balance'];
            }
            $result['member_paypwd'] = (($buyer_info['member_paypwd'] ? true : false));
        }
        return callback(true, '', $result);
    }
    public function buyStep2($post, $member_id, $member_name, $member_email, $orderdiscount = 0, $member_level = 0)
    {
        $this->_member_info['member_id'] = $member_id;
        $this->_member_info['member_name'] = $member_name;
        $this->_member_info['member_email'] = $member_email;
        $this->_member_info['orderdiscount'] = $orderdiscount;
        $this->_member_info['member_level'] = $member_level = 0;
        $this->_post_data = $post;
        try
        {
            $model = Model('order');
            $model->beginTransaction();
            $this->_createOrderStep1();
            $this->_createOrderStep2();
            $this->_createOrderStep3();
            $this->_createOrderStep4();
            $this->_createOrderStep5();
            $this->_createOrderStep6();
            $model->commit();
            return callback(true, '', $this->_order_data);
        }
        catch (Exception $e)
        {
            $model->rollback();
            return callback(false, $e->getMessage());
        }
        $model->rollback();
        return callback(false, $e->getMessage());
    }
    public function delCart($ifcart, $member_id, $cart_ids)
    {
        if (!($ifcart) || !(is_array($cart_ids)))
        {
            return;
        }
        $cart_id_str = implode(',', $cart_ids);
        if (preg_match('/^[\\d,]+$/', $cart_id_str))
        {
            Logic('queue')->delCart(array('buyer_id' => $member_id, 'cart_ids' => $cart_ids));
        }
    }
    public function changeChain($chain_id = 0, $product = '')
    {
        $chain_id = intval($chain_id);
        if ($chain_id <= 0)
        {
            return;
        }
        if (strpos($product, '-') !== false)
        {
            $product = explode('-', $product);
        }
        else
        {
            $product = array($product);
        }
        if (empty($product) || !(is_array($product)))
        {
            return;
        }
        $product = $this->_parseItems($product);
        $condition = array();
        $condition['goods_id'] = array('in', array_keys($product));
        $condition['chain_id'] = $chain_id;
        $list = Model('chain_stock')->getChainStockList($condition);
        if ($list)
        {
            $_tmp = array();
            foreach ($list as $v )
            {
                $_tmp[$v['goods_id']] = $v['stock'];
            }
            foreach ($product as $goods_id => $num )
            {
                if ($num <= $_tmp[$goods_id])
                {
                    unset($product[$goods_id]);
                }
            }
        }
        $data = array();
        $data['state'] = 'success';
        $data['product'] = array_keys($product);
        return $data;
    }
    public function changeAddr($freight_hash, $city_id, $area_id, $member_id)
    {
        $city_id = intval($city_id);
        $area_id = intval($area_id);
        if (($city_id <= 0) || ($area_id <= 0))
        {
            return;
        }
        $freight_list = $this->buyDecrypt($freight_hash, $member_id);
        list($store_freight_list, $no_send_tpl_ids) = $this->_logic_buy_1->calcStoreFreight($freight_list, $city_id);
        $data = array();
        $data['state'] = ((empty($store_freight_list) && empty($no_send_tpl_ids) ? 'fail' : 'success'));
        $data['content'] = $store_freight_list;
        $data['no_send_tpl_ids'] = $no_send_tpl_ids;
        $offline_store_id_array = Model('store')->getOwnMallIds();
        $offline_pay = Model('payment')->getPaymentOpenInfo(array('payment_code' => 'offline'));
        if ($offline_store_id_array && $offline_pay)
        {
            $allow_offpay_batch = Model('offpay_area')->checkSupportOffpayBatch($area_id, array_values($offline_store_id_array));
            $data['allow_offpay'] = ((array_filter($allow_offpay_batch) ? '1' : '0'));
            $data['allow_offpay_batch'] = $allow_offpay_batch;
        }
        else
        {
            $data['allow_offpay'] = '0';
            $data['allow_offpay_batch'] = array();
        }
        $data['offpay_hash'] = $this->buyEncrypt(($data['allow_offpay'] ? 'allow_offpay' : 'deny_offpay'), $member_id);
        $data['offpay_hash_batch'] = $this->buyEncrypt($data['allow_offpay_batch'], $member_id);
        return $data;
    }
    public function checkFcode($goods_id, $fcode)
    {
        $fcode_info = Model('goods_fcode')->getGoodsFCode(array('goods_id' => $goods_id, 'fc_code' => $fcode, 'fc_state' => 0));
        if ($fcode_info)
        {
            return callback(true, '', $fcode_info);
        }
        return callback(false, 'F码错误');
    }
    private function _createOrderStep1()
    {
        $post = $this->_post_data;
        $input_buy_items = $this->_parseItems($post['cart_id']);
        if (empty($input_buy_items))
        {
            throw new Exception('所购商品无效');
        }
        if (!($post['chain']['id']))
        {
            $input_address_id = intval($post['address_id']);
            if ($input_address_id <= 0)
            {
                throw new Exception('请选择收货地址');
            }
            else
            {
                $input_address_info = Model('address')->getAddressInfo(array('address_id' => $input_address_id));
                if ($input_address_info['member_id'] != $this->_member_info['member_id'])
                {
                    throw new Exception('请选择收货地址');
                }
                if ($input_address_info['dlyp_id'])
                {
                    $input_dlyp_id = $input_address_info['dlyp_id'];
                }
            }
            $input_city_id = intval($input_address_info['city_id']);
        }
        else
        {
            $chain_info = Model('chain')->getChainInfo(array('chain_id' => intval($post['chain']['id'])));
            if ($chain_info)
            {
                $input_address_info = array();
                $input_address_info['city_id'] = $chain_info['area_id_2'];
                $input_address_info['area_id'] = $chain_info['area_id'];
                $input_address_info['area_info'] = $chain_info['area_info'];
                $input_address_info['address'] = $chain_info['chain_name'] . '(' . $chain_info['chain_address'] . ')';
                $input_address_info['tel_phone'] = $post['chain']['tel_phone'];
                $input_address_info['mob_phone'] = $post['chain']['mob_phone'];
                $input_address_info['true_name'] = $post['chain']['buyer_name'];
                $input_city_id = $chain_info['area_id_2'];
                $input_chain_id = $chain_info['chain_id'];
            }
            else
            {
                throw new Exception('门店地址错误');
            }
        }
        $input_if_vat = $this->buyDecrypt($post['vat_hash'], $this->_member_info['member_id']);
        if (!(in_array($input_if_vat, array('allow_vat', 'deny_vat'))))
        {
            throw new Exception('订单保存出现异常[增值税发票出现错误]，请重试');
        }
        (($input_if_vat == 'allow_vat' ? true : false));
        if (!($post['chain']['id']))
        {
            $input_if_offpay = $this->buyDecrypt($post['offpay_hash'], $this->_member_info['member_id']);
            if (!(in_array($input_if_offpay, array('allow_offpay', 'deny_offpay'))))
            {
                throw new Exception('订单保存出现异常[货到付款验证错误]，请重试');
            }
            (($input_if_offpay == 'allow_offpay' ? true : false));
            $input_if_offpay_batch = $this->buyDecrypt($post['offpay_hash_batch'], $this->_member_info['member_id']);
            if (!(is_array($input_if_offpay_batch)))
            {
                throw new Exception('订单保存出现异常[部分店铺付款方式出现异常]，请重试');
            }
        }
        else
        {
            $input_if_offpay = false;
            $input_if_offpay_batch = array();
        }
        if (!(in_array($post['pay_name'], array('online', 'offline', 'chain'))))
        {
            throw new Exception('付款方式错误，请重新选择');
        }
        $input_pay_name = $post['pay_name'];
        if (!(empty($post['invoice_id'])))
        {
            $input_invoice_id = intval($post['invoice_id']);
            if (0 < $input_invoice_id)
            {
                $input_invoice_info = Model('invoice')->getinvInfo(array('inv_id' => $input_invoice_id));
                if ($input_invoice_info['member_id'] != $this->_member_info['member_id'])
                {
                    throw new Exception('请正确填写发票信息');
                }
            }
        }
        $input_voucher_list = array();
        if (!(empty($post['voucher'])) && is_array($post['voucher']))
        {
            foreach ($post['voucher'] as $store_id => $voucher )
            {
                if (preg_match_all('/^(\\d+)\\|(\\d+)\\|([\\d.]+)$/', $voucher, $matchs))
                {
                    if (0 < floatval($matchs[3][0]))
                    {
                        $input_voucher_list[$store_id]['voucher_t_id'] = $matchs[1][0];
                        $input_voucher_list[$store_id]['voucher_price'] = $matchs[3][0];
                    }
                }
            }
        }
        $input_rpt_info = array();
        if ($post['rpt'])
        {
            if (preg_match_all('/^(\\d+)\\|([\\d.]+)$/', $post['rpt'], $matchs))
            {
                if (0 < floatval($matchs[2][0]))
                {
                    $input_rpt_info['rpacket_t_id'] = $matchs[1][0];
                    $input_rpt_info['rpacket_price'] = $matchs[2][0];
                }
            }
        }
        $orderdiscounts = array();
        if (!($post['is_book']) && (0 < $this->_member_info['orderdiscount']))
        {
            $own_mall_ids = Model('store')->getOwnMallIds();
            foreach ($own_mall_ids as $store_id )
            {
                $orderdiscounts[$store_id] = $this->_member_info['orderdiscount'];
            }
        }
        $this->_order_data['input_buy_items'] = $input_buy_items;
        $this->_order_data['input_city_id'] = $input_city_id;
        $this->_order_data['input_pay_name'] = $input_pay_name;
        $this->_order_data['input_if_offpay'] = $input_if_offpay;
        $this->_order_data['input_if_offpay_batch'] = $input_if_offpay_batch;
        $this->_order_data['input_pay_message'] = $post['pay_message'];
        $this->_order_data['input_address_info'] = $input_address_info;
        $this->_order_data['input_dlyp_id'] = $input_dlyp_id;
        $this->_order_data['input_chain_id'] = $input_chain_id;
        $this->_order_data['input_invoice_info'] = $input_invoice_info;
        $this->_order_data['input_voucher_list'] = $input_voucher_list;
        $this->_order_data['input_rpt_info'] = $input_rpt_info;
        $this->_order_data['order_from'] = (($post['order_from'] == 2 ? 2 : 1));
        $this->_order_data['orderdiscount'] = $orderdiscounts;
        $this->_order_data['input_is_book'] = $post['is_book'];
    }
    private function _createOrderStep2()
    {
        $post = $this->_post_data;
        $input_buy_items = $this->_order_data['input_buy_items'];
        $input_is_book = $this->_order_data['input_is_book'];
        if ($post['ifcart'])
        {
            $model_cart = Model('cart');
            $condition = array( 'cart_id' => array('in', array_keys($input_buy_items)), 'buyer_id' => $this->_member_info['member_id'] );
            $cart_list = $model_cart->listCart('db', $condition);
            $jjgObj = NULL;
            $jjgPostData = $this->jjgPostDataParser((array) $this->_post_data['jjg']);
            if ($jjgPostData)
            {
                $jjgObj = new StdClass();
                $jjgObj->jjgPostData = $jjgPostData;
            }
            $cart_list = $this->_logic_buy_1->getGoodsCartList($cart_list, $jjgObj);
            foreach ($cart_list as $key => $vv )
            {
                if (($vv['bl_id'] == 0) && empty($vv['xianshi_info']) && empty($vv['groupbuy_info']))
                {
                    $cart_list[$key]['goods_price'] = Model('goods')->getpf($vv['goods_id'], $vv['goods_num']);
                }
            }
            $jjgCosts = array();
            $jjgStores = array();
            foreach ($cart_list as $cart )
            {
                $jjgId = (int) $cart['jjgRank'];
                if ((0 < $jjgId) && isset($jjgObj->jjgPostData[$jjgId]))
                {
                    $jjgItemCost = $cart['goods_price'] * $cart['goods_num'];
                    if (isset($jjgCosts[$jjgId]))
                    {
                        $jjgCosts[$jjgId] += $jjgItemCost;
                    }
                    else
                    {
                        $jjgCosts[$jjgId] = $jjgItemCost;
                    }
                    $jjgStores[$jjgId] = $cart['store_id'];
                }
            }
            $jjgValidSkus = array();
            $jjgStoreCosts = array();
            foreach ((array) $jjgObj->jjgPostData as $jjgId => $v )
            {
                foreach ((array) $v as $levelId => $vv )
                {
                    $itemCounter = 0;
                    foreach ((array) $vv as $skuId => $vvv )
                    {
                        if (isset($jjgObj->details['cou'][$jjgId]['levels'][$levelId]) && isset($jjgObj->details['cou'][$jjgId]['levelSkus'][$levelId][$skuId]))
                        {
                            $mincost = $jjgObj->details['cou'][$jjgId]['levels'][$levelId]['mincost'];
                            $maxcou = $jjgObj->details['cou'][$jjgId]['levels'][$levelId]['maxcou'];
                            $itemPrice = $jjgObj->details['cou'][$jjgId]['levelSkus'][$levelId][$skuId]['price'];
                            if ((0 < $maxcou) && ($maxcou <= $itemCounter))
                            {
                                break;
                            }
                            if (($mincost - $jjgCosts[$jjgId]) < 0.01)
                            {
                                ++$itemCounter;
                                $g = $jjgObj->details['items'][$skuId];
                                $g['jjgId'] = $jjgId;
                                $g['jjgLevel'] = $levelId;
                                $g['jjgPrice'] = $itemPrice;
                                $jjgValidSkus[$jjgId][$skuId] = $g;
                                $jjgStoreCosts[$jjgStores[$jjgId]] += $itemPrice;
                            }
                        }
                    }
                }
            }
            $goods_list = $this->_getGoodsList($cart_list);
            $store_cart_list = $this->_getStoreCartList($cart_list);
            $input_is_book = false;
        }
        else
        {
            $goods_id = key($input_buy_items);
            $quantity = current($input_buy_items);
            $goods_info = $this->_logic_buy_1->getGoodsOnlineInfo($goods_id, intval($quantity));
            if (empty($goods_info))
            {
                throw new Exception('商品已下架或不存在');
            }
            if ($input_is_book && $goods_info['is_book'])
            {
                $input_is_book = true;
            }
            else
            {
                $input_is_book = false;
            }
            $this->_order_data['input_is_book'] = $input_is_book;
            $store_cart_list = array();
            $goods_list = array();
            $goods_list[0] = $store_cart_list[$goods_info['store_id']][0] = $goods_info;
        }
        $fc_id = $this->_checkFcode($goods_list, $post['fcode']);
        if (!($fc_id))
        {
            throw new Exception('F码商品验证错误');
        }
        $this->_order_data['goods_list'] = $goods_list;
        $this->_order_data['store_cart_list'] = $store_cart_list;
        if (0 < $fc_id)
        {
            $this->_order_data['fc_id'] = $fc_id;
        }
        $this->_order_data['jjgValidSkus'] = $jjgValidSkus;
        $this->_order_data['jjgStoreCosts'] = $jjgStoreCosts;
        if ($this->_order_data['input_chain_id'])
        {
            if ((1 < count($store_cart_list)) || !($this->_checkChain(current($store_cart_list))))
            {
                $this->_order_data['input_chain_id'] = NULL;
            }
        }
    }
    private function _createOrderStep3()
    {
        $goods_list = $this->_order_data['goods_list'];
        $store_cart_list = $this->_order_data['store_cart_list'];
        $input_voucher_list = $this->_order_data['input_voucher_list'];
        $input_city_id = $this->_order_data['input_city_id'];
        $input_rpt_info = $this->_order_data['input_rpt_info'];
        $input_is_book = $this->_order_data['input_is_book'];
        list($store_cart_list, $store_goods_total) = $this->_logic_buy_1->calcCartList($store_cart_list);
        foreach ((array) $store_goods_total as $k => $v )
        {
            if (isset($this->_order_data['jjgStoreCosts'][$k]))
            {
                $v += $this->_order_data['jjgStoreCosts'][$k];
                $store_goods_total[$k] = ncPriceFormat($v);
            }
        }
        if (!($input_is_book))
        {
            list($store_premiums_list, $store_mansong_rule_list) = $this->_logic_buy_1->getMansongRuleCartListByTotal($store_goods_total);
            $store_final_goods_total = $this->_logic_buy_1->reCalcGoodsTotal($store_goods_total, $store_mansong_rule_list, 'mansong');
            if ($this->_order_data['input_chain_id'])
            {
                $store_freight_total[key($store_final_goods_total)] = 0;
            }
            else
            {
                $cancel_calc_sid_list = $this->_logic_buy_1->getStoreFreightDescList($store_final_goods_total);
                $freight_list = $this->_logic_buy_1->getStoreFreightList($goods_list, array_keys($cancel_calc_sid_list));
                list($store_freight_total, $no_send_tpl_ids) = $this->_logic_buy_1->calcStoreFreight($freight_list, $input_city_id);
            }
            $input_voucher_list = $this->_logic_buy_1->reParseVoucherList($input_voucher_list, $store_final_goods_total, $this->_member_info['member_id']);
            $store_final_goods_total = $this->_logic_buy_1->reCalcGoodsTotal($store_final_goods_total, $input_voucher_list, 'voucher');
            $store_final_order_total = $this->_logic_buy_1->reCalcGoodsTotal($store_final_goods_total, $store_freight_total, 'freight');
            $store_promotion_total = $this->_logic_buy_1->getStorePromotionTotal($store_goods_total, $store_freight_total, $store_final_order_total);
            $input_rpt_info = $this->_logic_buy_1->reParseRptInfo($input_rpt_info, array_sum($store_final_order_total), $this->_member_info['member_id']);
            list($store_final_order_total, $store_rpt_total) = $this->_logic_buy_1->parseOrderRpt($store_final_order_total, $input_rpt_info['rpacket_price']);
            $store_promotion_total = $this->_logic_buy_1->reCalcStorePromotionTotal($store_promotion_total, $store_freight_total, $store_rpt_total);
            $append_premiums_to_cart_list = $this->_logic_buy_1->appendPremiumsToCartList($store_cart_list, $store_premiums_list, $store_mansong_rule_list, $this->_member_info['member_id']);
            if ($append_premiums_to_cart_list === false)
            {
                throw new Exception('抱歉，您购买的商品库存不足，请重购买');
            }
            else
            {
                $store_mansong_rule_list = $append_premiums_to_cart_list[2];
                $goods_buy_quantity = $append_premiums_to_cart_list[1];
                $store_cart_list = $append_premiums_to_cart_list[0];
            }
            foreach ((array) $this->_order_data['jjgValidSkus'] as $k => $v )
            {
                foreach ((array) $v as $kk => $vv )
                {
                    $goods_buy_quantity[$kk] += 1;
                }
            }
        }
        else
        {
            $cancel_calc_sid_list = $this->_logic_buy_1->getStoreFreightDescList($store_goods_total);
            $freight_list = $this->_logic_buy_1->getStoreFreightList($goods_list, array_keys($cancel_calc_sid_list));
            list($store_freight_total, $no_send_tpl_ids) = $this->_logic_buy_1->calcStoreFreight($freight_list, $input_city_id);
            $store_final_order_total = $this->_logic_buy_1->reCalcGoodsTotal($store_goods_total, $store_freight_total, 'freight');
            $store_promotion_total = $store_mansong_rule_list = $input_voucher_list = $input_rpt_info = $store_rpt_total = array();
            $goods_buy_quantity = array($goods_list[0]['goods_id'] => $goods_list[0]['goods_num']);
        }
        if (is_array($no_send_tpl_ids) && !(empty($no_send_tpl_ids)))
        {
            throw new Exception('抱歉，您购买的部分商品无货，请重购买');
        }
        $this->_order_data['store_goods_total'] = $store_goods_total;
        $this->_order_data['store_final_order_total'] = $store_final_order_total;
        $this->_order_data['store_freight_total'] = $store_freight_total;
        $this->_order_data['store_promotion_total'] = $store_promotion_total;
        $this->_order_data['store_mansong_rule_list'] = $store_mansong_rule_list;
        $this->_order_data['store_cart_list'] = $store_cart_list;
        $this->_order_data['goods_buy_quantity'] = $goods_buy_quantity;
        $this->_order_data['input_voucher_list'] = $input_voucher_list;
        $this->_order_data['input_rpt_info'] = $input_rpt_info;
        $this->_order_data['store_rpt_total'] = $store_rpt_total;
    }
    private function _createOrderStep4()
    {
        extract($this->_order_data);
        $member_id = $this->_member_info['member_id'];
        $member_name = $this->_member_info['member_name'];
        $member_email = $this->_member_info['member_email'];
        $member_level = $this->_member_info['member_level'];
        $model_order = Model('order');
        $order_list = array();
        $notice_list = array();
        if (($input_pay_name == 'chain') && $input_chain_id)
        {
            $store_pay_type_list = array(key($store_cart_list) => 'chain');
        }
        else
        {
            $store_pay_type_list = $this->_logic_buy_1->getStorePayTypeList(array_keys($store_cart_list), $input_if_offpay, $input_pay_name);
            foreach ($store_pay_type_list as $k => $v )
            {
                if (empty($input_if_offpay_batch[$k]))
                {
                    $store_pay_type_list[$k] = 'online';
                }
            }
        }
        $pay_sn = $this->_logic_buy_1->makePaySn($member_id);
        $order_pay = array();
        $order_pay['pay_sn'] = $pay_sn;
        $order_pay['buyer_id'] = $member_id;
        $order_pay_id = $model_order->addOrderPay($order_pay);
        if (!($order_pay_id))
        {
            throw new Exception('订单保存失败[未生成支付单]');
        }
        list($reciver_info, $reciver_name, $reciver_phone) = $this->_logic_buy_1->getReciverAddr($input_address_info);
        $jjgValidStoreSkus = array();
        foreach ((array) $this->_order_data['jjgValidSkus'] as $v )
        {
            foreach ((array) $v as $vv )
            {
                $jjgValidStoreSkus[$vv['store_id']][] = $vv;
            }
        }
        foreach ($store_cart_list as $store_id => $goods_list )
        {
            $promotion_total = ((!(empty($store_promotion_total[$store_id])) ? $store_promotion_total[$store_id] : 0));
            $should_goods_total = $store_goods_total[$store_id];
            $promotion_rate = abs(number_format($promotion_total / $should_goods_total, 5));
            if ($promotion_rate <= 1)
            {
                $promotion_rate = floatval(substr($promotion_rate, 0, 5));
            }
            else
            {
                $promotion_rate = 0;
            }
            $promotion_sum = 0;
            $order = array();
            $order_common = array();
            $order_goods = array();
            $order['order_sn'] = $this->_logic_buy_1->makeOrderSn($order_pay_id);
            $order['pay_sn'] = $pay_sn;
            $order['store_id'] = $store_id;
            $order['store_name'] = $goods_list[0]['store_name'];
            $order['buyer_id'] = $member_id;
            $order['buyer_name'] = $member_name;
            $order['buyer_email'] = $member_email;
            $order['buyer_phone'] = ((is_numeric($reciver_phone) ? $reciver_phone : 0));
            $order['add_time'] = TIMESTAMP;
            $order['payment_code'] = $store_pay_type_list[$store_id];
            $order['order_state'] = (($store_pay_type_list[$store_id] == 'offline' ? ORDER_STATE_PAY : ORDER_STATE_NEW));
            $order['order_amount'] = $store_final_order_total[$store_id];
            $order['shipping_fee'] = $store_freight_total[$store_id];
            $order['goods_amount'] = ($order['order_amount'] - $order['shipping_fee']) + $store_rpt_total[$store_id];
            $order['order_from'] = $order_from;
            $order['order_type'] = (($input_chain_id ? 3 : (($goods_list[0]['is_book'] ? 2 : 1))));
            $order['chain_id'] = (($input_chain_id ? $input_chain_id : 0));
            $order['rpt_amount'] = ((empty($store_rpt_total[$store_id]) ? 0 : $store_rpt_total[$store_id]));
            $order_id = $model_order->addOrder($order);
            if (!($order_id))
            {
                throw new Exception('订单保存失败[未生成订单数据]');
            }
            $order['order_id'] = $order_id;
            $order_list[$order_id] = $order;
            $order_common['order_id'] = $order_id;
            $order_common['store_id'] = $store_id;
            $order_common['order_message'] = ((isset($input_pay_message[$store_id]) ? $input_pay_message[$store_id] : ''));
            if (isset($input_voucher_list[$store_id]))
            {
                $order_common['voucher_price'] = $input_voucher_list[$store_id]['voucher_price'];
                $order_common['voucher_code'] = $input_voucher_list[$store_id]['voucher_code'];
            }
            $order_common['promotion_total'] = $promotion_total;
            $order_common['reciver_info'] = $reciver_info;
            $order_common['reciver_name'] = $reciver_name;
            $order_common['reciver_city_id'] = $input_city_id;
            $order_common['invoice_info'] = $this->_logic_buy_1->createInvoiceData($input_invoice_info);
            $order_common['promotion_info'] = array();
            if (is_array($store_mansong_rule_list[$store_id]))
            {
                if (APP_ID != 'mobile')
                {
                    $order_common['promotion_info'][] = array('满即送', $store_mansong_rule_list[$store_id]['desc']);
                }
                else
                {
                    $order_common['promotion_info'][] = array('满即送', $store_mansong_rule_list[$store_id]['desc']['desc']);
                }
            }
            if ($store_rpt_total[$store_id])
            {
                $order_common['promotion_info'][] = array('平台红包', sprintf('使用%s元红包 编码：%s', $store_rpt_total[$store_id], $input_rpt_info['rpacket_code']));
            }
            if (isset($input_voucher_list[$store_id]))
            {
                $order_common['promotion_info'][] = array('店铺代金券', sprintf('使用%s元代金券 编码：%s', $input_voucher_list[$store_id]['voucher_price'], $input_voucher_list[$store_id]['voucher_code']));
            }
            $order_common['promotion_info'] = (($order_common['promotion_info'] ? serialize($order_common['promotion_info']) : ''));
            $insert = $model_order->addOrderCommon($order_common);
            if (!($insert))
            {
                throw new Exception('订单保存失败[未生成订单扩展数据]');
            }
            $log_data = array();
            $log_data['order_id'] = $order_id;
            $log_data['log_role'] = '买家';
            $log_data['log_msg'] = '生成订单';
            $log_data['log_user'] = $member_name;
            $log_data['log_orderstate'] = ORDER_STATE_NEW;
            $model_order->addOrderLog($log_data);
            $i = 0;
            foreach ($goods_list as $goods_info )
            {
                if (!($goods_info['state']) || !($goods_info['storage_state']))
                {
                    throw new Exception('抱歉，部分商品存在下架、变更销售方式或库存不足的情况，请重新选择');
                }
                $goods_invit = Model('goods')->getGoodsInfo(array('goods_id' => $goods_info['goods_id']));
                if (!(intval($goods_info['bl_id'])))
                {
                    $order_goods[$i]['order_id'] = $order_id;
                    $order_goods[$i]['goods_id'] = $goods_info['goods_id'];
                    $order_goods[$i]['store_id'] = $store_id;
                    $order_goods[$i]['goods_name'] = $goods_info['goods_name'];
                    $order_goods[$i]['goods_price'] = $goods_info['goods_price'];
                    $order_goods[$i]['goods_num'] = $goods_info['goods_num'];
                    $order_goods[$i]['goods_image'] = $goods_info['goods_image'];
                    $order_goods[$i]['goods_spec'] = $goods_info['goods_spec'];
                    $order_goods[$i]['invite_rates'] = $goods_invit['invite_rate'];
                    $order_goods[$i]['buyer_id'] = $member_id;
                    if ($goods_info['ifgroupbuy'])
                    {
                        $ifgroupbuy = true;
                        $order_goods[$i]['goods_type'] = 2;
                    }
                    else if ($goods_info['ifxianshi'])
                    {
                        $order_goods[$i]['goods_type'] = 3;
                    }
                    else if ($goods_info['ifzengpin'])
                    {
                        $order_goods[$i]['goods_type'] = 5;
                    }
                    else if (0 < $goods_info['jjgRank'])
                    {
                        $order_goods[$i]['goods_type'] = 8;
                    }
                    else
                    {
                        $order_goods[$i]['goods_type'] = 1;
                    }
                    $order_goods[$i]['promotions_id'] = (($goods_info['promotions_id'] ? $goods_info['promotions_id'] : 0));
                    if (0 < $goods_info['jjgRank'])
                    {
                        $order_goods[$i]['promotions_id'] = $goods_info['jjgRank'];
                    }
                    $order_goods[$i]['commis_rate'] = 200;
                    $order_goods[$i]['gc_id'] = $goods_info['gc_id'];
                    $contract_itemid_arr = (($goods_info['contractlist'] ? array_keys($goods_info['contractlist']) : array()));
                    $order_goods[$i]['goods_contractid'] = (($contract_itemid_arr ? implode(',', $contract_itemid_arr) : ''));
                    $goods_total = $goods_info['goods_price'] * $goods_info['goods_num'];
                    $promotion_value = floor($goods_total * $promotion_rate);
                    $order_goods[$i]['goods_pay_price'] = ((($goods_total - $promotion_value) < 0 ? 0 : $goods_total - $promotion_value));
                    $promotion_sum += $promotion_value;
                    ++$i;
                    if (($goods_info['goods_storage'] - $goods_info['goods_num']) <= $goods_info['goods_storage_alarm'])
                    {
                        $param = array();
                        $param['common_id'] = $goods_info['goods_commonid'];
                        $param['sku_id'] = $goods_info['goods_id'];
                        $notice_list['goods_storage_alarm'][$goods_info['store_id']] = $param;
                    }
                }
                else if (!(empty($goods_info['bl_goods_list'])) && (($goods_info['goods_storage'] - $goods_info['goods_num']) <= $goods_info['goods_storage_alarm']))
                {
                    foreach ($goods_info['bl_goods_list'] as $bl_goods_info )
                    {
                        $bl_goods_invit = Model('goods')->getGoodsInfo(array('goods_id' => $bl_goods_info['goods_id']));
                        $order_goods[$i]['order_id'] = $order_id;
                        $order_goods[$i]['goods_id'] = $bl_goods_info['goods_id'];
                        $order_goods[$i]['store_id'] = $store_id;
                        $order_goods[$i]['goods_name'] = $bl_goods_info['goods_name'];
                        $order_goods[$i]['goods_price'] = $bl_goods_info['bl_goods_price'];
                        $order_goods[$i]['goods_num'] = $goods_info['goods_num'];
                        $order_goods[$i]['goods_image'] = $bl_goods_info['goods_image'];
                        $order_goods[$i]['goods_spec'] = $bl_goods_info['goods_spec'];
                        $order_goods[$i]['buyer_id'] = $member_id;
                        $order_goods[$i]['goods_type'] = 4;
                        $order_goods[$i]['promotions_id'] = $bl_goods_info['bl_id'];
                        $order_goods[$i]['commis_rate'] = 200;
                        $order_goods[$i]['invite_rates'] = $bl_goods_invit['invite_rate'];
                        $order_goods[$i]['gc_id'] = $bl_goods_info['gc_id'];
                        $contract_itemid_arr = (($bl_goods_info['contractlist'] ? array_keys($bl_goods_info['contractlist']) : array()));
                        $order_goods[$i]['goods_contractid'] = (($contract_itemid_arr ? implode(',', $contract_itemid_arr) : ''));
                        $goods_total = $bl_goods_info['bl_goods_price'] * $goods_info['goods_num'];
                        $promotion_value = floor($goods_total * $promotion_rate);
                        $order_goods[$i]['goods_pay_price'] = ((($goods_total - $promotion_value) < 0 ? 0 : $goods_total - $promotion_value));
                        $promotion_sum += $promotion_value;
                        ++$i;
                        if (($bl_goods_info['goods_storage'] - $goods_info['goods_num']) <= $bl_goods_info['goods_storage_alarm'])
                        {
                            $param = array();
                            $param['common_id'] = $bl_goods_info['goods_commonid'];
                            $param['sku_id'] = $bl_goods_info['goods_id'];
                            $notice_list['goods_storage_alarm'][$bl_goods_info['store_id']] = $param;
                        }
                    }
                }
            }
            foreach ((array) $jjgValidStoreSkus[$store_id] as $goods_info )
            {
                if ($goods_info['storage'] < 1)
                {
                    throw new Exception('抱歉，部分商品存在下架或库存不足的情况，请重新选择');
                }
                $ml_goods_invit = Model('goods')->getGoodsInfo(array('goods_id' => $goods_info['id']));
                $order_goods[$i]['order_id'] = $order_id;
                $order_goods[$i]['goods_id'] = $goods_info['id'];
                $order_goods[$i]['store_id'] = $store_id;
                $order_goods[$i]['goods_name'] = $goods_info['name'];
                $order_goods[$i]['goods_price'] = $goods_info['jjgPrice'];
                $order_goods[$i]['goods_num'] = 1;
                $order_goods[$i]['goods_image'] = $goods_info['goods_image'];
                $order_goods[$i]['goods_spec'] = $goods_info['goods_spec'];
                $order_goods[$i]['buyer_id'] = $member_id;
                $order_goods[$i]['goods_type'] = 9;
                $order_goods[$i]['promotions_id'] = $goods_info['jjgId'];
                $order_goods[$i]['commis_rate'] = 200;
                $order_goods[$i]['invite_rates'] = $ml_goods_invit['invite_rate'];
                $order_goods[$i]['gc_id'] = $goods_info['gc_id'];
                $contract_itemid_arr = (($goods_info['contractlist'] ? array_keys($goods_info['contractlist']) : array()));
                $order_goods[$i]['goods_contractid'] = (($contract_itemid_arr ? implode(',', $contract_itemid_arr) : ''));
                $goods_total = $goods_info['jjgPrice'] * 1;
                $promotion_value = floor($goods_total * $promotion_rate);
                $order_goods[$i]['goods_pay_price'] = ((($goods_total - $promotion_value) < 0 ? 0 : $goods_total - $promotion_value));
                $promotion_sum += $promotion_value;
                ++$i;
                if (($goods_info['goods_storage'] - 1) <= $goods_info['goods_storage_alarm'])
                {
                    $param = array();
                    $param['common_id'] = $goods_info['goods_commonid'];
                    $param['sku_id'] = $goods_info['id'];
                    $notice_list['goods_storage_alarm'][$goods_info['store_id']] = $param;
                }
            }
            if ($promotion_sum < $promotion_total)
            {
                --$i;
                while (0 <= $i)
                {
                    if (0 < floatval($order_goods[$i]['goods_price']))
                    {
                        $order_goods[$i]['goods_pay_price'] -= $promotion_total - $promotion_sum;
                        break;
                    }
                    --$i;
                }
            }
            $insert = $model_order->addOrderGoods($order_goods);
            if (!($insert))
            {
                throw new Exception('订单保存失败[未生成商品数据]');
            }
            if ($store_pay_type_list[$store_id] == 'offline')
            {
                $notice_list['new_order'][$order['store_id']] = array('order_sn' => $order['order_sn']);
            }
        }
        $this->_order_data['pay_sn'] = $pay_sn;
        $this->_order_data['order_list'] = $order_list;
        $this->_order_data['notice_list'] = $notice_list;
        $this->_order_data['ifgroupbuy'] = $ifgroupbuy;
        $this->_order_data['ifbook'] = $goods_list[0]['is_book'] == 1;
    }
    private function _createOrderStep5()
    {
        if (empty($this->_post_data['password']))
        {
            return;
        }
        $buyer_info = Model('member')->getMemberInfoByID($this->_member_info['member_id']);
        if (($buyer_info['member_paypwd'] == '') || ($buyer_info['member_paypwd'] != md5($this->_post_data['password'])))
        {
            return;
        }
        if (!(empty($this->_post_data['rcb_pay'])))
        {
            $order_list = $this->_logic_buy_1->rcbPay($this->_order_data['order_list'], $this->_post_data, $buyer_info);
        }
        if (!(empty($this->_post_data['pd_pay'])))
        {
            $this->_logic_buy_1->pdPay(($order_list ? $order_list : $this->_order_data['order_list']), $this->_post_data, $buyer_info);
        }
    }
    private function _createOrderStep6()
    {
        $ifcart = $this->_post_data['ifcart'];
        $goods_buy_quantity = $this->_order_data['goods_buy_quantity'];
        $input_voucher_list = $this->_order_data['input_voucher_list'];
        $input_rpt_info = $this->_order_data['input_rpt_info'];
        $store_cart_list = $this->_order_data['store_cart_list'];
        $input_buy_items = $this->_order_data['input_buy_items'];
        $order_list = $this->_order_data['order_list'];
        $input_address_info = $this->_order_data['input_address_info'];
        $notice_list = $this->_order_data['notice_list'];
        $fc_id = $this->_order_data['fc_id'];
        $ifgroupbuy = $this->_order_data['ifgroupbuy'];
        $ifbook = $this->_order_data['ifbook'];
        $pay_sn = $this->_order_data['pay_sn'];
        $input_dlyp_id = $this->_order_data['input_dlyp_id'];
        $input_chain_id = $this->_order_data['input_chain_id'];
        $result = Logic('queue')->createOrderUpdateStorage($goods_buy_quantity);
        if (!($result['state']))
        {
            throw new Exception('订单保存失败[变更库存销量失败]');
        }
        if ($input_chain_id)
        {
            $result = Logic('queue')->createOrderUpdateChainStorage($goods_buy_quantity, $input_chain_id);
            if (!($result['state']))
            {
                throw new Exception('订单保存失败[变更自提门店库存销量失败]');
            }
        }
        if (!(empty($input_voucher_list)) && is_array($input_voucher_list))
        {
            $result = Logic('queue')->editVoucherState($input_voucher_list);
            if (!($result['state']))
            {
                throw new Exception('订单保存失败[代金券处理失败]');
            }
        }
        if (!(empty($input_rpt_info)) && is_array($input_rpt_info))
        {
            $result = Logic('queue')->editRptState($input_rpt_info, $pay_sn);
            if (!($result['state']))
            {
                throw new Exception('订单保存失败[平台红包处理失败]');
            }
        }
        if ($fc_id)
        {
            $result = Logic('queue')->updateGoodsFCode($fc_id);
            if (!($result['state']))
            {
                throw new Exception('订单保存失败[F码处理失败]');
            }
        }
        if ($ifgroupbuy)
        {
            foreach ($store_cart_list as $goods_list )
            {
                foreach ($goods_list as $goods_info )
                {
                    if ($goods_info['ifgroupbuy'] && $goods_info['groupbuy_id'])
                    {
                        $groupbuy_info = array();
                        $groupbuy_info['groupbuy_id'] = $goods_info['groupbuy_id'];
                        $groupbuy_info['quantity'] = $goods_info['goods_num'];
                        QueueClient::push('editGroupbuySaleCount', $groupbuy_info);
                    }
                }
            }
        }
        if ($ifbook)
        {
            Logic('order_book')->buy($this->_order_data, $this->_post_data);
        }
        $this->delCart($ifcart, $this->_member_info['member_id'], array_keys($input_buy_items));
        @setNcCookie('cart_goods_num', '', -3600);
        if ($input_dlyp_id)
        {
            $data = array();
            $data['mob_phone'] = $input_address_info['mob_phone'];
            $data['tel_phone'] = $input_address_info['tel_phone'];
            $data['reciver_name'] = $input_address_info['true_name'];
            $data['dlyp_id'] = $input_address_info['dlyp_id'];
            foreach ($order_list as $v )
            {
                $data['order_sn_list'][$v['order_id']]['order_sn'] = $v['order_sn'];
                $data['order_sn_list'][$v['order_id']]['add_time'] = $v['add_time'];
            }
            QueueClient::push('saveDeliveryOrder', $data);
        }
        if (!(empty($notice_list)))
        {
            foreach ($notice_list as $code => $value )
            {
                QueueClient::push('sendStoreMsg', array('code' => $code, 'store_id' => key($value), 'param' => current($value)));
            }
        }
        if ($input_chain_id)
        {
            $order_info = current($order_list);
            if ($order_info['payment_code'] == 'chain')
            {
                $_code = rand(100000, 999999);
                $result = Model('order')->editOrder(array('chain_code' => $_code), array('order_id' => $order_info['order_id']));
                if (!($result))
                {
                    throw new Exception('门店自提订单更新提货码失败');
                }
                $param = array();
                $param['chain_code'] = $_code;
                $param['order_sn'] = $order_info['order_sn'];
                $param['buyer_phone'] = $order_info['buyer_phone'];
                QueueClient::push('sendChainCode', $param);
            }
        }
        $order_id_list = array();
        foreach ($order_list as $order_info )
        {
            $order_id_list[] = $order_info['order_id'];
        }
        QueueClient::push('createSphot', $order_id_list);
    }
    public function buyEncrypt($string, $member_id)
    {
        $buy_key = sha1(md5($member_id . '&' . MD5_KEY));
        if (is_array($string))
        {
            $string = serialize($string);
        }
        else
        {
            $string = strval($string);
        }
        return encrypt(base64_encode($string), $buy_key);
    }
    public function buyDecrypt($string, $member_id, $ttl = 0)
    {
        $buy_key = sha1(md5($member_id . '&' . MD5_KEY));
        if (empty($string))
        {
            return;
        }
        $string = base64_decode(decrypt(strval($string), $buy_key, $ttl));
        return (($tmp = @unserialize($string)) !== false ? $tmp : $string);
    }
    private function _parseItems($cart_id)
    {
        $buy_items = array();
        if (is_array($cart_id))
        {
            foreach ($cart_id as $value )
            {
                if (preg_match_all('/^(\\d{1,10})\\|(\\d{1,6})$/', $value, $match))
                {
                    if (0 < intval($match[2][0]))
                    {
                        $buy_items[$match[1][0]] = $match[2][0];
                    }
                }
            }
        }
        return $buy_items;
    }
    private function _getGoodsList($cart_list)
    {
        if (empty($cart_list) || !(is_array($cart_list)))
        {
            return $cart_list;
        }
        $goods_list = array();
        $i = 0;
        foreach ($cart_list as $key => $cart )
        {
            if (!($cart['state']) || !($cart['storage_state']))
            {
                continue;
            }
            $quantity = $cart['goods_num'];
            if (!(intval($cart['bl_id'])))
            {
                $goods_list[$i]['goods_num'] = $quantity;
                $goods_list[$i]['goods_id'] = $cart['goods_id'];
                $goods_list[$i]['store_id'] = $cart['store_id'];
                $goods_list[$i]['gc_id'] = $cart['gc_id'];
                $goods_list[$i]['goods_name'] = $cart['goods_name'];
                $goods_list[$i]['goods_price'] = $cart['goods_price'];
                $goods_list[$i]['store_name'] = $cart['store_name'];
                $goods_list[$i]['goods_image'] = $cart['goods_image'];
                $goods_list[$i]['transport_id'] = $cart['transport_id'];
                $goods_list[$i]['goods_freight'] = $cart['goods_freight'];
                $goods_list[$i]['goods_vat'] = $cart['goods_vat'];
                $goods_list[$i]['is_fcode'] = $cart['is_fcode'];
                $goods_list[$i]['bl_id'] = 0;
                ++$i;
            }
            else
            {
                foreach ($cart['bl_goods_list'] as $bl_goods )
                {
                    $goods_list[$i]['goods_num'] = $quantity;
                    $goods_list[$i]['goods_id'] = $bl_goods['goods_id'];
                    $goods_list[$i]['store_id'] = $cart['store_id'];
                    $goods_list[$i]['gc_id'] = $bl_goods['gc_id'];
                    $goods_list[$i]['goods_name'] = $bl_goods['goods_name'];
                    $goods_list[$i]['goods_price'] = $bl_goods['goods_price'];
                    $goods_list[$i]['store_name'] = $bl_goods['store_name'];
                    $goods_list[$i]['goods_image'] = $bl_goods['goods_image'];
                    $goods_list[$i]['transport_id'] = $bl_goods['transport_id'];
                    $goods_list[$i]['goods_freight'] = $bl_goods['goods_freight'];
                    $goods_list[$i]['goods_vat'] = $bl_goods['goods_vat'];
                    $goods_list[$i]['bl_id'] = $cart['bl_id'];
                    ++$i;
                }
            }
        }
        return $goods_list;
    }
    private function _getStoreCartList($cart_list)
    {
        if (empty($cart_list) || !(is_array($cart_list)))
        {
            return $cart_list;
        }
        $new_array = array();
        foreach ($cart_list as $cart )
        {
            $new_array[$cart['store_id']][] = $cart;
        }
        return $new_array;
    }
    private function _checkFcode($goods_list, $fcode)
    {
        foreach ($goods_list as $k => $v )
        {
            while ($v['is_fcode'] == 1)
            {
                $is_fcode = true;
                break;
            }
        }
        if (!($is_fcode))
        {
            return true;
        }
        if (empty($fcode) || (1 < count($goods_list)))
        {
            return false;
        }
        $goods_info = $goods_list[0];
        $fcode_info = $this->checkFcode($goods_info['goods_id'], $fcode);
        if ($fcode_info['state'])
        {
            return intval($fcode_info['data']['fc_id']);
        }
        return false;
    }
    private function _checkChain($goods_list)
    {
        if (empty($goods_list) || !(is_array($goods_list)))
        {
            return false;
        }
        $_flag = true;
        foreach ($goods_list as $goods_info )
        {
            while (!($goods_info['is_chain']))
            {
                $_flag = false;
                break;
            }
        }
        return $_flag;
    }
}
?>