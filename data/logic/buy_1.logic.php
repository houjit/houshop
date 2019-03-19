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
class buy_1Logic
{
    public function getGoodsCartList($cart_list, StdClass $jjgObj = NULL)
    {
        $cart_list = $this->_getOnlineCartList($cart_list);
        $this->_getBookCartList($cart_list);
        $this->_getBundlingCartList($cart_list);
        $this->getMbSoleCartList($cart_list);
        $this->getGroupbuyCartList($cart_list);
        $this->getXianshiCartList($cart_list);
        $this->getPfCartList($cart_list);
        $this->_getGiftCartList($cart_list);
        if ($jjgObj)
        {
            $jjgSkus = array();
            foreach ((array) $cart_list as $cart )
            {
                if ((int) $cart['bl_id'] === 0)
                {
                    $jjgSkus[$cart['goods_id']] = NULL;
                }
            }
            $jjgSkus = array_keys($jjgSkus);
            $jjgDetails = NULL;
            if ($jjgSkus)
            {
                $jjgIdFilter = NULL;
                if (isset($jjgObj->jjgPostData) && is_array($jjgObj->jjgPostData))
                {
                    $jjgIdFilter = array_keys($jjgObj->jjgPostData);
                }
                $jjgDetails = Model('p_cou')->getRelationalCouDetailBySku($jjgSkus, $jjgIdFilter);
            }
            $jjgObj->details = $jjgDetails;
            foreach ($cart_list as &$cartRef )
            {
                $rank = -1;
                if (0 < $cartRef['bl_id'])
                {
                    $rank = 0;
                }
                else if (isset($jjgDetails['couMap'][$cartRef['goods_id']]))
                {
                    $rank = (int) $jjgDetails['couMap'][$cartRef['goods_id']];
                }
                $cartRef['jjgRank'] = $rank;
            }
            usort($cart_list, function($a, $b)
            {
                return (-$a['jjgRank']) + $b['jjgRank'];
            }
            );
        }
        return $cart_list;
    }
    public function getGoodsOnlineInfo($goods_id, $quantity)
    {
        $goods_info = $this->_getGoodsOnlineInfo($goods_id, $quantity);
        $this->getBookInfo($goods_info);
        if (!($goods_info['is_book']))
        {
            $this->getMbSoleInfo($goods_info);
            $this->getGroupbuyInfo($goods_info);
            $this->getXianshiInfo($goods_info, $goods_info['goods_num']);
        }
        $this->_getGoodsGiftList($goods_info);
        $this->getPfInfo($goods_info, $goods_info['goods_num']);
        return $goods_info;
    }
    public function calcCartList($store_cart_list)
    {
        if (empty($store_cart_list) || !(is_array($store_cart_list)))
        {
            return array( $store_cart_list, array(), 0 );
        }
        $store_goods_total = array();
        $order_goods_total = 0;
        foreach ($store_cart_list as $store_id => $store_cart )
        {
            $tmp_amount = 0;
            foreach ($store_cart as $key => $cart_info )
            {
                $store_cart[$key]['goods_total'] = ncPriceFormat($cart_info['goods_price'] * $cart_info['goods_num']);
                $store_cart[$key]['goods_image_url'] = cthumb($store_cart[$key]['goods_image']);
                $tmp_amount += $store_cart[$key]['goods_total'];
            }
            $store_cart_list[$store_id] = $store_cart;
            $store_goods_total[$store_id] = ncPriceFormat($tmp_amount);
        }
        return array($store_cart_list, $store_goods_total);
    }
    public function parseZhekou(&$goods_list, $store_order_discount = array())
    {
        if (empty($store_order_discount))
        {
            return;
        }
        if (array_key_exists('store_id', $goods_list))
        {
            if (array_key_exists($goods_list['store_id'], $store_order_discount))
            {
                if (!($goods_list['is_book']))
                {
                    $goods_list['goods_price'] = ncPriceFormat(($goods_list['goods_price'] * $store_order_discount[$goods_list['store_id']]) / 100);
                    $goods_list['zkj'] = true;
                    return;
                }
            }
        }
        else
        {
            foreach ($goods_list as $k => $goods_info )
            {
                if (array_key_exists($goods_info['store_id'], $store_order_discount))
                {
                    $orderdiscount = $store_order_discount[$goods_info['store_id']];
                    if (is_array($goods_info['bl_goods_list']) && !(empty($goods_info['bl_goods_list'])))
                    {
                        foreach ($goods_info['bl_goods_list'] as $kk => $vv )
                        {
                            $goods_list[$k]['bl_goods_list'][$kk]['bl_goods_price'] = ncPriceFormat(($vv['bl_goods_price'] * $orderdiscount) / 100);
                            $goods_list[$k]['bl_goods_list'][$kk]['zkj'] = true;
                        }
                    }
                    $goods_list[$k]['goods_price'] = ncPriceFormat(($goods_info['goods_price'] * $orderdiscount) / 100);
                    $goods_list[$k]['zkj'] = true;
                }
            }
        }
    }
    public function getMansongRuleCartListByTotal($store_goods_total)
    {
        if (!(C('promotion_allow')) || empty($store_goods_total) || !(is_array($store_goods_total)))
        {
            return array( array(), array() );
        }
        $model_mansong = Model('p_mansong');
        $model_goods = Model('goods');
        $premiums_list = array();
        $mansong_rule_list = array();
        foreach ($store_goods_total as $store_id => $goods_total )
        {
            $rule_info = $model_mansong->getMansongRuleByStoreID($store_id, $goods_total);
            if (is_array($rule_info) && !(empty($rule_info)))
            {
                if (empty($rule_info['discount']) && empty($rule_info['mansong_goods_name']))
                {
                    continue;
                }
                $rule_info['desc'] = $this->_parseMansongRuleDesc($rule_info);
                $rule_info['discount'] = ncPriceFormat($rule_info['discount']);
                $mansong_rule_list[$store_id] = $rule_info;
                if (!(empty($rule_info['mansong_goods_name'])) && !(empty($rule_info['goods_storage'])))
                {
                    $data = array();
                    $data['goods_id'] = $rule_info['goods_id'];
                    $data['goods_name'] = $rule_info['mansong_goods_name'];
                    $data['goods_num'] = 1;
                    $data['goods_price'] = 0;
                    $data['goods_image'] = $rule_info['goods_image'];
                    $data['goods_image_url'] = cthumb($rule_info['goods_image']);
                    $data['goods_storage'] = $rule_info['goods_storage'];
                    $premiums_list[$store_id][] = $data;
                }
            }
        }
        return array($premiums_list, $mansong_rule_list);
    }
    public function reCalcGoodsTotal($store_goods_total, $preferential_array = array(), $preferential_type)
    {
        $deny = empty($store_goods_total) || !(is_array($store_goods_total)) || empty($preferential_array) || !(is_array($preferential_array));
        if ($deny)
        {
            return $store_goods_total;
        }
        switch ($preferential_type)
        {
            case 'mansong': if (!(C('promotion_allow')))
            {
                return $store_goods_total;
            }
                foreach ($preferential_array as $store_id => $rule_info )
                {
                    if (is_array($rule_info) && (0 < $rule_info['discount']))
                    {
                        $store_goods_total[$store_id] -= $rule_info['discount'];
                    }
                }
                break;
            case 'voucher': if (!(C('voucher_allow')))
            {
                return $store_goods_total;
            }
                foreach ($preferential_array as $store_id => $voucher_info )
                {
                    $store_goods_total[$store_id] -= $voucher_info['voucher_price'];
                }
                break;
            case 'rpt': foreach ($store_goods_total as $store_id => $goods_total )
            {
                if (array_key_exists($store_id, $preferential_array))
                {
                    $store_goods_total[$store_id] = ncPriceFormat(($store_goods_total[$store_id] * $preferential_array[$store_id]) / 100);
                }
            }
                break;
            case 'freight': foreach ($preferential_array as $store_id => $freight_total )
            {
                $store_goods_total[$store_id] += $freight_total;
            }
                break;
        }
        return $store_goods_total;
    }
    public function getStoreAvailableVoucherList($store_goods_total, $member_id)
    {
        if (!(C('voucher_allow')))
        {
            return array();
        }
        $voucher_list = array();
        $model_voucher = Model('voucher');
        foreach ($store_goods_total as $store_id => $goods_total )
        {
            $condition = array();
            $condition['voucher_store_id'] = $store_id;
            $condition['voucher_owner_id'] = $member_id;
            $voucher_list[$store_id] = $model_voucher->getCurrentAvailableVoucher($condition, $goods_total, (APP_ID == 'mobile' ? 'voucher_limit desc' : ''));
        }
        return $voucher_list;
    }
    public function getStoreAvailableRptList($member_id, $goods_total = 0, $order = '')
    {
        if (!(C('redpacket_allow')))
        {
            return array();
        }
        $condition = array();
        $condition['rpacket_owner_id'] = $member_id;
        return Model('redpacket')->getCurrentAvailableRpt($condition, $goods_total, $order);
    }
    public function reParseRptInfo($input_rpt_info, $order_total, $member_id)
    {
        if (empty($input_rpt_info))
        {
            return array();
        }
        $condition = array();
        $condition['rpacket_owner_id'] = $member_id;
        $condition['rpacket_t_id'] = $input_rpt_info['rpacket_t_id'];
        $info = Model('redpacket')->getCurrentAvailableRpt($condition, $order_total);
        if ($info)
        {
            return $info[$input_rpt_info['rpacket_t_id']];
        }
        return array();
    }
    public function parseOrderRpt($store_order_total = array(), $rpt_total = 0)
    {
        if (empty($store_order_total) || ($rpt_total <= 0))
        {
            return array( $store_order_total, array() );
        }
        $all_order_total = array_sum($store_order_total);
        $rpt_rate = abs(number_format($rpt_total / $all_order_total, 5));
        if ($rpt_rate <= 1)
        {
            $rpt_rate = floatval(substr($rpt_rate, 0, 5));
        }
        else
        {
            $rpt_rate = 0;
        }
        $rpt_sum = 0;
        $store_rpt_total = array();
        foreach ($store_order_total as $store_id => $order_total )
        {
            $rpt_value = floor($order_total * $rpt_rate);
            $store_order_total[$store_id] -= $rpt_value;
            $store_rpt_total[$store_id] = $rpt_value;
            $rpt_sum += $rpt_value;
        }
        if ($rpt_sum < $rpt_total)
        {
            foreach ($store_order_total as $store_id => $order_total )
            {
                while (0 < $order_total)
                {
                    $store_order_total[$store_id] -= $rpt_total - $rpt_sum;
                    $store_rpt_total[$store_id] += $rpt_total - $rpt_sum;
                    break;
                }
            }
        }
        return array($store_order_total, $store_rpt_total);
    }
    public function reCalcStorePromotionTotal($store_promotion_total, $store_freight_total, $store_rpt_total)
    {
        if (!(is_array($store_rpt_total)) || empty($store_rpt_total))
        {
            return $store_promotion_total;
        }
        foreach ($store_rpt_total as $store_id => $rpt_total )
        {
            $ptotal = $rpt_total - $store_freight_total[$store_id];
            if (0 < $ptotal)
            {
                $store_promotion_total[$store_id] += $ptotal;
            }
        }
        return $store_promotion_total;
    }
    public function reParseVoucherList($input_voucher_list = array(), $store_goods_total = array(), $member_id)
    {
        if (empty($input_voucher_list) || !(is_array($input_voucher_list)))
        {
            return array();
        }
        $store_voucher_list = $this->getStoreAvailableVoucherList($store_goods_total, $member_id);
        foreach ($input_voucher_list as $store_id => $voucher )
        {
            $tmp = $store_voucher_list[$store_id];
            if (is_array($tmp) && isset($tmp[$voucher['voucher_t_id']]))
            {
                $input_voucher_list[$store_id]['voucher_id'] = $tmp[$voucher['voucher_t_id']]['voucher_id'];
                $input_voucher_list[$store_id]['voucher_code'] = $tmp[$voucher['voucher_t_id']]['voucher_code'];
                $input_voucher_list[$store_id]['voucher_owner_id'] = $tmp[$voucher['voucher_t_id']]['voucher_owner_id'];
            }
            else
            {
                unset($input_voucher_list[$store_id]);
            }
        }
        return $input_voucher_list;
    }
    public function getXianshiInfo(&$goods_info, $quantity)
    {
        if (empty($quantity))
        {
            $quantity = 1;
        }
        if (!(C('promotion_allow')) || empty($goods_info['xianshi_info']) || !(empty($goods_info['groupbuy_info'])) || $goods_info['ifsole'])
        {
            return;
        }
        $goods_info['xianshi_info']['down_price'] = ncPriceFormat($goods_info['goods_price'] - $goods_info['xianshi_info']['xianshi_price']);
        if ($goods_info['xianshi_info']['lower_limit'] <= $quantity)
        {
            $goods_info['goods_yprice'] = $goods_info['goods_price'];
            $goods_info['goods_price'] = $goods_info['xianshi_info']['xianshi_price'];
            $goods_info['promotions_id'] = $goods_info['xianshi_info']['xianshi_id'];
            $goods_info['ifxianshi'] = true;
        }
    }
    public function getPfInfo($goods_info, $quantity)
    {
        return $goods_info['goods_price'] = Model('goods')->getpf($goods_info['goods_id'], $quantity);
    }
    public function getOfflineGoodsPay($buy_list)
    {
        $buy_goods_list = array();
        $offline_pay = Model('payment')->getPaymentOpenInfo(array('payment_code' => 'offline'));
        if ($offline_pay)
        {
            $offline_store_id_array = model('store')->getOwnMallIds();
            foreach ($buy_list as $value )
            {
                if (in_array($value['store_id'], $offline_store_id_array))
                {
                    $buy_goods_list['offline'][] = $value;
                }
                else
                {
                    $buy_goods_list['online'][] = $value;
                }
            }
        }
        if ($buy_list[0]['is_book'])
        {
            unset($buy_goods_list['offline']);
        }
        return $buy_goods_list;
    }
    public function getStorePromotionTotal($store_goods_total, $store_freight_total, $store_final_goods_total)
    {
        if (!(is_array($store_goods_total)) || !(is_array($store_freight_total)) || !(is_array($store_final_goods_total)))
        {
            return array();
        }
        $store_promotion_total = array();
        foreach ($store_goods_total as $store_id => $goods_total )
        {
            $store_promotion_total[$store_id] = ($goods_total + $store_freight_total[$store_id]) - $store_final_goods_total[$store_id];
        }
        return $store_promotion_total;
    }
    public function getStoreFreightDescList($store_goods_total)
    {
        if (empty($store_goods_total) || !(is_array($store_goods_total)))
        {
            return array( array(), array() );
        }
        $need_calc_sid_array = array();
        $cancel_calc_sid_array = array();
        $condition = array( 'store_id' => array('in', array_keys($store_goods_total)) );
        $store_list = Model('store')->getStoreOnlineList($condition, NULL, '', 'store_id,store_free_price');
        foreach ($store_list as $store_info )
        {
            $limit_price = floatval($store_info['store_free_price']);
            if (($limit_price == 0) || ($store_goods_total[$store_info['store_id']] < $limit_price))
            {
                $need_calc_sid_array[] = $store_info['store_id'];
            }
            else
            {
                $cancel_calc_sid_array[$store_info['store_id']]['free_price'] = $limit_price;
                $cancel_calc_sid_array[$store_info['store_id']]['desc'] = sprintf('满%s免运费', $limit_price);
            }
        }
        return $cancel_calc_sid_array;
    }
    public function getStoreFreightList($buy_list = array(), $free_freight_sid_list)
    {
        $return = array();
        $freight_list = array();
        if (!(empty($free_freight_sid_list)) && is_array($free_freight_sid_list))
        {
            foreach ($free_freight_sid_list as $store_id )
            {
                $freight_list[$store_id] = 0;
            }
        }
        $return['free_sid_list'] = array_values($free_freight_sid_list);
        $store_bl_goods_freight = array();
        foreach ($buy_list as $key => $goods_info )
        {
            if (in_array($goods_info['store_id'], $free_freight_sid_list))
            {
                if (!($goods_info['transport_id']))
                {
                    unset($buy_list[$key]);
                    continue;
                }
            }
            if (intval($goods_info['bl_id']))
            {
                unset($buy_list[$key]);
                $store_bl_goods_freight[$goods_info['store_id']][] = $goods_info['bl_id'];
                continue;
            }
            if (!(intval($goods_info['transport_id'])) && !(in_array($goods_info['store_id'], $free_freight_sid_list)))
            {
                $freight_list[$goods_info['store_id']] += $goods_info['goods_freight'];
                unset($buy_list[$key]);
            }
        }
        if (!(empty($store_bl_goods_freight)))
        {
            $model_bl = Model('p_bundling');
            foreach ($store_bl_goods_freight as $store_id => $bl_list )
            {
                foreach (array_unique($bl_list) as $bl_id )
                {
                    $bl_info = $model_bl->getBundlingInfo(array('bl_id' => $bl_id));
                    if (!(empty($bl_info)) && !(in_array($store_id, $return['free_sid_list'])))
                    {
                        $freight_list[$store_id] += $bl_info['bl_freight'];
                    }
                }
            }
        }
        $return['iscalced'] = $freight_list;
        $freight_list = array();
        foreach ($buy_list as $goods_info )
        {
            $freight_list[$goods_info['store_id']][] = $goods_info['transport_id'];
        }
        foreach ($freight_list as $store_id => $v )
        {
            $freight_list[$store_id] = array_unique($v);
        }
        $return['tpl_ids'] = $freight_list;
        return $return;
    }
    public function calcStoreFreight($freight_list, $city_id)
    {
        if (!(is_array($freight_list)) || empty($freight_list) || empty($city_id))
        {
            return;
        }
        $no_send_tpl_ids = array();
        $return_list = $freight_list['iscalced'];
        $free_sid_list = $freight_list['free_sid_list'];
        $tpl_ids_list = $freight_list['tpl_ids'];
        if (!(empty($tpl_ids_list)) && is_array($tpl_ids_list))
        {
            $model_transport = Model('transport');
            foreach ($tpl_ids_list as $store_id => $transport_id_list )
            {
                foreach ($transport_id_list as $transport_id )
                {
                    $freight_total = $model_transport->calc_transport($transport_id, $city_id);
                    if ($freight_total === false)
                    {
                        if (!(in_array($transport_id, $no_send_tpl_ids)))
                        {
                            $no_send_tpl_ids[] = $transport_id;
                        }
                    }
                    else if (!(in_array($store_id, $free_sid_list)))
                    {
                        if (empty($return_list[$store_id]))
                        {
                            $return_list[$store_id] = $freight_total;
                        }
                        else
                        {
                            $return_list[$store_id] += $freight_total;
                        }
                    }
                }
            }
        }
        return array($return_list, $no_send_tpl_ids);
    }
    public function appendPremiumsToCartList($store_cart_list, $store_premiums_list = array(), $store_mansong_rule_list = array(), $member_id)
    {
        if (empty($store_cart_list))
        {
            return array();
        }
        foreach ($store_cart_list as $store_id => $cart_list )
        {
            foreach ($cart_list as $cart_info )
            {
                if (empty($cart_info['gift_list']))
                {
                    continue;
                }
                if (!(is_array($store_premiums_list)))
                {
                    $store_premiums_list = array();
                }
                if (!(array_key_exists($store_id, $store_premiums_list)))
                {
                    $store_premiums_list[$store_id] = array();
                }
                $zenpin_info = array();
                foreach ($cart_info['gift_list'] as $gift_info )
                {
                    $zenpin_info['goods_id'] = $gift_info['gift_goodsid'];
                    $zenpin_info['goods_name'] = $gift_info['gift_goodsname'];
                    $zenpin_info['goods_image'] = $gift_info['gift_goodsimage'];
                    $zenpin_info['goods_storage'] = $gift_info['goods_storage'];
                    $zenpin_info['goods_num'] = $cart_info['goods_num'] * $gift_info['gift_amount'];
                    $store_premiums_list[$store_id][] = $zenpin_info;
                }
            }
        }
        $goods_storage_quantity = $this->_getEachGoodsStorageQuantity($store_cart_list, $store_premiums_list);
        $goods_buy_quantity = $this->_getEachGoodsBuyQuantity($store_cart_list);
        foreach ($goods_buy_quantity as $goods_id => $quantity )
        {
            while ($goods_storage_quantity[$goods_id] < 0)
            {
                $goods_storage_quantity[$goods_id] -= $quantity;
                return false;
            }
        }
        if (is_array($store_premiums_list))
        {
            foreach ($store_premiums_list as $store_id => $goods_list )
            {
                $zp_list = array();
                $gift_desc = '';
                foreach ($goods_list as $goods_info )
                {
                    if ($goods_storage_quantity[$goods_info['goods_id']] == 0)
                    {
                        $gift_desc = '，赠品库存不足，未能全部送出 ';
                        continue;
                    }
                    $new_data = array();
                    $new_data['buyer_id'] = $member_id;
                    $new_data['store_id'] = $store_id;
                    $new_data['store_name'] = $store_cart_list[$store_id][0]['store_name'];
                    $new_data['goods_id'] = $goods_info['goods_id'];
                    $new_data['goods_name'] = $goods_info['goods_name'];
                    $new_data['goods_price'] = 0;
                    $new_data['goods_image'] = $goods_info['goods_image'];
                    $new_data['bl_id'] = 0;
                    $new_data['state'] = true;
                    $new_data['storage_state'] = true;
                    $new_data['gc_id'] = 0;
                    $new_data['transport_id'] = 0;
                    $new_data['goods_freight'] = 0;
                    $new_data['goods_vat'] = 0;
                    $new_data['goods_total'] = 0;
                    $new_data['ifzengpin'] = true;
                    if (0 <= $goods_storage_quantity[$goods_info['goods_id']] - $goods_info['goods_num'])
                    {
                        $goods_buy_quantity[$goods_info['goods_id']] += $goods_info['goods_num'];
                        $goods_storage_quantity[$goods_info['goods_id']] -= $goods_info['goods_num'];
                        $new_data['goods_num'] = $goods_info['goods_num'];
                    }
                    else
                    {
                        $new_data['goods_num'] = $goods_storage_quantity[$goods_info['goods_id']];
                        $goods_buy_quantity[$goods_info['goods_id']] += $goods_storage_quantity[$goods_info['goods_id']];
                        $goods_storage_quantity[$goods_info['goods_id']] = 0;
                    }
                    if (array_key_exists($goods_info['goods_id'], $zp_list))
                    {
                        $zp_list[$goods_info['goods_id']]['goods_num'] += $new_data['goods_num'];
                    }
                    else
                    {
                        $zp_list[$goods_info['goods_id']] = $new_data;
                    }
                }
                sort($zp_list);
                $store_cart_list[$store_id] = array_merge($store_cart_list[$store_id], $zp_list);
                if ($gift_desc != '')
                {
                    if (is_string($store_mansong_rule_list[$store_id]['desc']))
                    {
                        $store_mansong_rule_list[$store_id]['desc'] .= $gift_desc;
                        $store_mansong_rule_list[$store_id]['desc'] = trim($store_mansong_rule_list[$store_id]['desc'], '，');
                    }
                }
            }
        }
        return array($store_cart_list, $goods_buy_quantity, $store_mansong_rule_list);
    }
    public function rcbPay($order_list, $input, $buyer_info)
    {
        $member_id = $buyer_info['member_id'];
        $member_name = $buyer_info['member_name'];
        $available_rcb_amount = floatval(ncPriceFormat($buyer_info['available_rc_balance']));
        if ($available_rcb_amount <= 0)
        {
            return $order_list;
        }
        $model_order = Model('order');
        $model_pd = Model('predeposit');
        foreach ($order_list as $key => $order_info )
        {
            if ($order_info['payment_code'] == 'offline')
            {
                continue;
            }
            $order_amount = floatval($order_info['order_amount']);
            $data_pd = array();
            $data_pd['member_id'] = $member_id;
            $data_pd['member_name'] = $member_name;
            $data_pd['amount'] = $order_info['order_amount'];
            $data_pd['order_sn'] = $order_info['order_sn'];
            if ($order_amount <= $available_rcb_amount)
            {
                $model_pd->changeRcb('order_pay', $data_pd);
                $available_rcb_amount -= $order_amount;
                $available_rcb_amount = floatval(ncPriceFormat($available_rcb_amount));
                $data = array();
                $data['order_id'] = $order_info['order_id'];
                $data['log_role'] = 'buyer';
                $data['log_msg'] = '支付订单';
                $data['log_orderstate'] = ORDER_STATE_PAY;
                $insert = $model_order->addOrderLog($data);
                if (!($insert))
                {
                    throw new Exception('记录订单充值卡支付日志出现错误');
                }
                $data_order = array();
                $order_list[$key]['order_state'] = $data_order['order_state'] = ORDER_STATE_PAY;
                $order_list[$key]['payment_time'] = $data_order['payment_time'] = TIMESTAMP;
                $order_list[$key]['payment_code'] = $data_order['payment_code'] = 'predeposit';
                if ($order_info['order_type'] == 2)
                {
                    $order_list[$key]['rcb_amount'] = $data_order['rcb_amount'] = ncPriceFormat(floatval($order_info['original_rcb_amount']) + $order_amount);
                }
                else
                {
                    $order_list[$key]['rcb_amount'] = $data_order['rcb_amount'] = $order_amount;
                }
                $result = $model_order->editOrder($data_order, array('order_id' => $order_info['order_id']));
                if (!($result))
                {
                    throw new Exception('订单更新失败');
                }
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
                            throw new Exception('门店自提订单更新提货码失败');
                        }
                        $param = array();
                        $param['chain_code'] = $_code;
                        $param['order_sn'] = $order_info['order_sn'];
                        $param['buyer_phone'] = $order_info['buyer_phone'];
                        QueueClient::push('sendChainCode', $param);
                    }
                }
            }
            else if (0 < $available_rcb_amount)
            {
                $data_pd['amount'] = $available_rcb_amount;
                if ($order_info['order_type'] != 2)
                {
                    $model_pd->changeRcb('order_freeze', $data_pd);
                }
                else
                {
                    $model_pd->changeRcb('order_pay', $data_pd);
                }
                $data_order = array();
                if ($order_info['order_type'] == 2)
                {
                    $order_list[$key]['rcb_amount'] = $data_order['rcb_amount'] = ncPriceFormat(floatval($order_info['original_rcb_amount']) + $available_rcb_amount);
                }
                else
                {
                    $order_list[$key]['rcb_amount'] = $data_order['rcb_amount'] = $available_rcb_amount;
                }
                $result = $model_order->editOrder($data_order, array('order_id' => $order_info['order_id']));
                $available_rcb_amount = 0;
                if (!($result))
                {
                    throw new Exception('订单更新失败');
                }
            }
        }
        return $order_list;
    }
    public function pdPay($order_list, $input, $buyer_info)
    {
        $member_id = $buyer_info['member_id'];
        $member_name = $buyer_info['member_name'];
        $available_pd_amount = floatval(ncPriceFormat($buyer_info['available_predeposit']));
        if ($available_pd_amount <= 0)
        {
            return $order_list;
        }
        $model_order = Model('order');
        $model_pd = Model('predeposit');
        foreach ($order_list as $key => $order_info )
        {
            if ($order_info['payment_code'] == 'offline')
            {
                continue;
            }
            $order_amount = floatval($order_info['order_amount']) - floatval($order_info['rcb_amount']);
            $order_amount = floatval(ncPriceFormat($order_amount));
            $data_pd = array();
            $data_pd['member_id'] = $member_id;
            $data_pd['member_name'] = $member_name;
            $data_pd['amount'] = $order_amount;
            $data_pd['order_sn'] = $order_info['order_sn'];
            if ($order_amount <= $available_pd_amount)
            {
                $model_pd->changePd('order_pay', $data_pd);
                $available_pd_amount -= $order_amount;
                $available_pd_amount = floatval(ncPriceFormat($available_pd_amount));
                $rcb_amount = floatval($order_info['rcb_amount']);
                if ((0 < $rcb_amount) && ($order_info['order_type'] != 2))
                {
                    $data_pd = array();
                    $data_pd['member_id'] = $member_id;
                    $data_pd['member_name'] = $member_name;
                    $data_pd['amount'] = $rcb_amount;
                    $data_pd['order_sn'] = $order_info['order_sn'];
                    $model_pd->changeRcb('order_comb_pay', $data_pd);
                }
                $data = array();
                $data['order_id'] = $order_info['order_id'];
                $data['log_role'] = 'buyer';
                $data['log_msg'] = '支付订单';
                $data['log_orderstate'] = ORDER_STATE_PAY;
                $insert = $model_order->addOrderLog($data);
                if (!($insert))
                {
                    throw new Exception('记录订单预存款支付日志出现错误');
                }
                $data_order = array();
                $order_list[$key]['order_state'] = $data_order['order_state'] = ORDER_STATE_PAY;
                $order_list[$key]['payment_time'] = $data_order['payment_time'] = TIMESTAMP;
                $order_list[$key]['payment_code'] = $data_order['payment_code'] = 'predeposit';
                if ($order_info['order_type'] == 2)
                {
                    $order_list[$key]['pd_amount'] = $data_order['pd_amount'] = ncPriceFormat(floatval($order_info['original_pd_amount']) + $order_amount);
                }
                else
                {
                    $order_list[$key]['pd_amount'] = $data_order['pd_amount'] = $order_amount;
                }
                $result = $model_order->editOrder($data_order, array('order_id' => $order_info['order_id']));
                if (!($result))
                {
                    throw new Exception('订单更新失败');
                }
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
                            throw new Exception('门店自提订单更新提货码失败');
                        }
                        $param = array();
                        $param['chain_code'] = $_code;
                        $param['order_sn'] = $order_info['order_sn'];
                        $param['buyer_phone'] = $order_info['buyer_phone'];
                        QueueClient::push('sendChainCode', $param);
                    }
                }
            }
            else if (0 < $available_pd_amount)
            {
                $data_pd['amount'] = $available_pd_amount;
                if ($order_info['order_type'] != 2)
                {
                    $model_pd->changePd('order_freeze', $data_pd);
                }
                else
                {
                    $model_pd->changePd('order_pay', $data_pd);
                }
                $data_order = array();
                if ($order_info['order_type'] == 2)
                {
                    $order_list[$key]['pd_amount'] = $data_order['pd_amount'] = ncPriceFormat(floatval($order_info['original_pd_amount']) + $available_pd_amount);
                }
                else
                {
                    $order_list[$key]['pd_amount'] = $data_order['pd_amount'] = $available_pd_amount;
                }
                $result = $model_order->editOrder($data_order, array('order_id' => $order_info['order_id']));
                $available_pd_amount = 0;
                if (!($result))
                {
                    throw new Exception('订单更新失败');
                }
            }
        }
        return $order_list;
    }
    public function makePaySn($member_id)
    {
        return mt_rand(10, 99) . sprintf('%010d', time() - 946656000) . sprintf('%03d', (double) microtime() * 1000) . sprintf('%03d', (int) $member_id % 1000);
    }
    public function makeOrderSn($pay_id)
    {
        static $num;
        if (empty($num))
        {
            $num = 1;
        }
        else
        {
            ++$num;
        }
        return ((date('y', time()) % 9) + 1) . sprintf('%013d', $pay_id) . sprintf('%02d', $num);
    }
    public function editGoodsNum($buy_items)
    {
        foreach ($buy_items as $goods_id => $buy_num )
        {
            $data = array( 'goods_storage' => array('exp', 'goods_storage-' . $buy_num), 'goods_salenum' => array('exp', 'goods_salenum+' . $buy_num) );
            $result = Model('goods')->editGoods($data, array('goods_id' => $goods_id));
            if (!($result))
            {
                throw new Exception(L('cart_step2_submit_fail'));
            }
        }
    }
    public function getMansongRuleList($store_id_array)
    {
        if (!(C('promotion_allow')) || empty($store_id_array) || !(is_array($store_id_array)))
        {
            return array();
        }
        $model_mansong = Model('p_mansong');
        $mansong_rule_list = array();
        foreach ($store_id_array as $store_id )
        {
            $store_mansong_rule = $model_mansong->getMansongInfoByStoreID($store_id);
            if (!(empty($store_mansong_rule['rules'])) && is_array($store_mansong_rule['rules']))
            {
                foreach ($store_mansong_rule['rules'] as $rule_info )
                {
                    if (!(empty($rule_info['discount'])) || (!(empty($rule_info['mansong_goods_name'])) && !(empty($rule_info['goods_storage']))))
                    {
                        $_tmp = $this->_parseMansongRuleDesc($rule_info);
                        if ($_tmp)
                        {
                            $mansong_rule_list[$store_id][] = $_tmp;
                        }
                    }
                }
            }
        }
        return $mansong_rule_list;
    }
    public function getFreeFreightactiveList($store_id_array)
    {
        if (empty($store_id_array) || !(is_array($store_id_array)))
        {
            return array();
        }
        $store_free_freight_active = array();
        $condition = array( 'store_id' => array('in', $store_id_array) );
        $store_list = Model('store')->getStoreOnlineList($condition, NULL, '', 'store_id,store_free_price');
        foreach ($store_list as $store_info )
        {
            $limit_price = floatval($store_info['store_free_price']);
            if (0 < $limit_price)
            {
                $store_free_freight_active[$store_info['store_id']] = sprintf('满%s免运费', $limit_price);
            }
        }
        return $store_free_freight_active;
    }
    public function getReciverAddr($address_info = array())
    {
        if (intval($address_info['dlyp_id']))
        {
            $reciver_info['phone'] = trim($address_info['dlyp_mobile'] . (($address_info['dlyp_telephony'] ? ',' . $address_info['dlyp_telephony'] : NULL)), ',');
            $reciver_info['tel_phone'] = $address_info['dlyp_telephony'];
            $reciver_info['mob_phone'] = $address_info['dlyp_mobile'];
            $reciver_info['address'] = $address_info['dlyp_area_info'] . ' ' . $address_info['dlyp_address'];
            $reciver_info['area'] = $address_info['dlyp_area_info'];
            $reciver_info['street'] = $address_info['dlyp_address'];
            $reciver_info['dlyp'] = 1;
            $reciver_str = serialize($reciver_info);
            $reciver_name = $address_info['dlyp_address_name'];
        }
        else
        {
            $reciver_info['phone'] = trim($address_info['mob_phone'] . (($address_info['tel_phone'] ? ',' . $address_info['tel_phone'] : NULL)), ',');
            $reciver_info['mob_phone'] = $address_info['mob_phone'];
            $reciver_info['tel_phone'] = $address_info['tel_phone'];
            $reciver_info['address'] = $address_info['area_info'] . ' ' . $address_info['address'];
            $reciver_info['area'] = $address_info['area_info'];
            $reciver_info['street'] = $address_info['address'];
            $reciver_str = serialize($reciver_info);
            $reciver_name = $address_info['true_name'];
        }
        return array($reciver_str, $reciver_name, $reciver_info['mob_phone']);
    }
    public function createInvoiceData($invoice_info)
    {
        $inv = array();
        if ($invoice_info['inv_state'] == 1)
        {
            $inv['类型'] = '普通发票 ';
            $inv['抬头'] = (($invoice_info['inv_title_select'] == 'person' ? '个人' : $invoice_info['inv_title']));
            $inv['内容'] = $invoice_info['inv_content'];
        }
        else if (!(empty($invoice_info)))
        {
            $inv['单位名称'] = $invoice_info['inv_company'];
            $inv['纳税人识别号'] = $invoice_info['inv_code'];
            $inv['注册地址'] = $invoice_info['inv_reg_addr'];
            $inv['注册电话'] = $invoice_info['inv_reg_phone'];
            $inv['开户银行'] = $invoice_info['inv_reg_bname'];
            $inv['银行账户'] = $invoice_info['inv_reg_baccount'];
            $inv['收票人姓名'] = $invoice_info['inv_rec_name'];
            $inv['收票人手机号'] = $invoice_info['inv_rec_mobphone'];
            $inv['收票人省份'] = $invoice_info['inv_rec_province'];
            $inv['送票地址'] = $invoice_info['inv_goto_addr'];
        }
        return (!(empty($inv)) ? serialize($inv) : serialize(array()));
    }
    public function getStorePayTypeList($store_id_array, $if_offpay, $pay_name)
    {
        $store_pay_type_list = array();
        if ($_POST['pay_name'] == 'online')
        {
            foreach ($store_id_array as $store_id )
            {
                $store_pay_type_list[$store_id] = 'online';
            }
        }
        else
        {
            $offline_pay = Model('payment')->getPaymentOpenInfo(array('payment_code' => 'offline'));
            if ($offline_pay)
            {
                $offline_store_id_array = model('store')->getOwnMallIds();
                foreach ($store_id_array as $store_id )
                {
                    if (in_array($store_id, $offline_store_id_array))
                    {
                        $store_pay_type_list[$store_id] = 'offline';
                    }
                    else
                    {
                        $store_pay_type_list[$store_id] = 'online';
                    }
                }
            }
        }
        return $store_pay_type_list;
    }
    public function extendInPay($order_list)
    {
        if ($order_list[0]['order_type'] == 2)
        {
            $model_order_book = Model('order_book');
            $order_info = $order_list[0];
            $data = array();
            if (!(empty($order_info['rcb_amount'])))
            {
                $data['book_rcb_amount'] = $order_info['rcb_amount'] - $order_info['original_rcb_amount'];
            }
            if (!(empty($order_info['pd_amount'])))
            {
                $data['book_pd_amount'] = $order_info['pd_amount'] - $order_info['original_pd_amount'];
            }
            if (empty($order_info['rcb_amount']) && empty($order_info['pd_amount']))
            {
                return callback(true);
            }
            if ($order_info['order_state'] == ORDER_STATE_PAY)
            {
                $data['book_pay_time'] = TIMESTAMP;
                $data['book_pay_name'] = '站内余额支付';
                $order_goods_info = Model('order')->getOrderGoodsInfo(array('order_id' => $order_info['order_id']), 'goods_id', 'rec_id asc');
                $update = Model('goods')->editGoods(array( 'book_buyers' => array('exp', 'book_buyers+1') ), array('goods_id' => $order_goods_info['goods_id']));
                if (!($update))
                {
                    throw new Exception('更新商品预定人数失败');
                }
            }
            $condition = array();
            $condition['book_order_id'] = $order_info['order_id'];
            if (empty($order_info['book_list'][0]['book_pay_time']))
            {
                $condition['book_id'] = $order_info['book_list'][0]['book_id'];
            }
            else
            {
                $condition['book_id'] = $order_info['book_list'][1]['book_id'];
            }
            $update = $model_order_book->editOrderBook($data, $condition);
            if (!($update))
            {
                throw new Exception('更新站内余额失败');
            }
        }
        return callback(true);
    }
    private function _getGoodsOnlineInfo($goods_id, $quantity)
    {
        $model_goods = Model('goods');
        $goods_info = $model_goods->getGoodsOnlineInfoAndPromotionById($goods_id);
        if (empty($goods_info))
        {
            return;
        }
        $goods_list = $model_goods->getGoodsContract(array($goods_info));
        $goods_info = $goods_list[0];
        $new_array = array();
        $new_array['goods_num'] = (($goods_info['is_fcode'] ? 1 : $quantity));
        $new_array['goods_id'] = $goods_id;
        $new_array['goods_commonid'] = $goods_info['goods_commonid'];
        $new_array['gc_id'] = $goods_info['gc_id'];
        $new_array['store_id'] = $goods_info['store_id'];
        $new_array['goods_name'] = $goods_info['goods_name'];
        if (!(empty($goods_info['pf'])))
        {
            $pf = unserialize($goods_info['pf']);
            if ((intval($pf['q3']) <= $quantity) && (0 < intval($pf['q3'])))
            {
                $new_array['goods_price'] = ncPriceFormat($pf['f3']);
                $new_array['ifpf'] = true;
            }
            else if ((intval($pf['q2']) <= $quantity) && (0 < intval($pf['q2'])))
            {
                $new_array['goods_price'] = ncPriceFormat($pf['f2']);
                $new_array['ifpf'] = true;
            }
            else if ((intval($pf['q1']) <= $quantity) && (0 < intval($pf['q1'])))
            {
                $new_array['goods_price'] = ncPriceFormat($pf['f1']);
                $new_array['ifpf'] = true;
            }
            else
            {
                $new_array['goods_price'] = $goods_info['goods_price'];
            }
        }
        else
        {
            $new_array['goods_price'] = $goods_info['goods_price'];
        }
        $new_array['store_name'] = $goods_info['store_name'];
        $new_array['goods_image'] = $goods_info['goods_image'];
        $new_array['transport_id'] = $goods_info['transport_id'];
        $new_array['goods_freight'] = $goods_info['goods_freight'];
        $new_array['goods_vat'] = $goods_info['goods_vat'];
        $new_array['goods_storage'] = $goods_info['goods_storage'];
        $new_array['goods_storage_alarm'] = $goods_info['goods_storage_alarm'];
        $new_array['is_fcode'] = $goods_info['is_fcode'];
        $new_array['have_gift'] = $goods_info['have_gift'];
        $new_array['state'] = true;
        $new_array['storage_state'] = ((intval($goods_info['goods_storage']) < intval($quantity) ? false : true));
        $new_array['groupbuy_info'] = $goods_info['groupbuy_info'];
        $new_array['xianshi_info'] = $goods_info['xianshi_info'];
        $new_array['is_chain'] = $goods_info['is_chain'];
        if (($goods_info['is_vip'] == 1) && empty($goods_info['xianshi_info']) && empty($goods_info['groupbuy_info']))
        {
            $v_condition = array();
            $v_condition['member_id'] = $_SESSION['member_id'];
            $v_condition['store_id'] = $new_array['store_id'];
            $v_condition['vip_state'] = 1;
            $vip_member = Model('store_vip_member')->getvipmemberByinfo($v_condition);
            $vip_m_commit = $vip_member['member_commit'];
            $new_array['vip_m_info'] = $vip_member;
        }
        $new_array['is_book'] = $goods_info['is_book'];
        $new_array['book_down_payment'] = $goods_info['book_down_payment'];
        $new_array['book_final_payment'] = $goods_info['book_final_payment'];
        $new_array['book_down_time'] = $goods_info['book_down_time'];
        $new_array['cart_id'] = $goods_id;
        $new_array['bl_id'] = 0;
        $_tmp_name = unserialize($goods_info['spec_name']);
        $_tmp_value = unserialize($goods_info['goods_spec']);
        if (is_array($_tmp_name) && is_array($_tmp_value))
        {
            $_tmp_name = array_values($_tmp_name);
            $_tmp_value = array_values($_tmp_value);
            foreach ($_tmp_name as $sk => $sv )
            {
                $new_array['goods_spec'] .= $sv . '：' . $_tmp_value[$sk] . '，';
            }
            $new_array['goods_spec'] = rtrim($new_array['goods_spec'], '，');
        }
        if (array_key_exists('sole_info', $goods_info))
        {
            $new_array['sole_info'] = $goods_info['sole_info'];
        }
        $new_array['contractlist'] = $goods_info['contractlist'];
        return $new_array;
    }
    public function getGroupbuyInfo(&$goods_info = array())
    {
        if (!(C('groupbuy_allow')) || empty($goods_info['groupbuy_info']) || $goods_info['ifsole'])
        {
            return;
        }
        $groupbuy_info = $goods_info['groupbuy_info'];
        $goods_info['goods_price'] = $groupbuy_info['groupbuy_price'];
        if ($groupbuy_info['upper_limit'] && ($groupbuy_info['upper_limit'] < $goods_info['goods_num']))
        {
            $goods_info['goods_num'] = $groupbuy_info['upper_limit'];
        }
        $goods_info['upper_limit'] = $groupbuy_info['upper_limit'];
        $goods_info['promotions_id'] = $goods_info['groupbuy_id'] = $groupbuy_info['groupbuy_id'];
        $goods_info['ifgroupbuy'] = true;
    }
    public function getMbSoleInfo(&$goods_info = array())
    {
        if (!(C('promotion_allow')) || empty($goods_info['sole_info']))
        {
            return;
        }
        $sole_info = $goods_info['sole_info'];
        $goods_info['goods_price'] = $sole_info['sole_price'];
        $goods_info['ifsole'] = true;
    }
    public function getBookInfo(&$goods_info = array())
    {
        if (empty($goods_info['is_book']))
        {
            return;
        }
        if (!(C('promotion_allow')) || ($goods_info['book_down_time'] < TIMESTAMP))
        {
            $goods_info['is_book'] = 0;
            return;
        }
        $goods_info['goods_price'] = $goods_info['book_down_payment'] + $goods_info['book_final_payment'];
    }
    private function _getGoodsGiftList(&$goods_info)
    {
        if (!($goods_info['have_gift']))
        {
            return;
        }
        $gift_list = Model('goods_gift')->getGoodsGiftListByGoodsId($goods_info['goods_id']);
        if (empty($gift_list))
        {
            return array();
        }
        $model_goods = Model('goods');
        foreach ($gift_list as $k => $v )
        {
            $goods_online_info = $model_goods->getGoodsOnlineInfoByID($v['gift_goodsid'], 'goods_storage');
            if (empty($goods_online_info))
            {
                unset($gift_list[$k]);
            }
            else
            {
                $gift_list[$k]['goods_storage'] = $goods_online_info['goods_storage'];
            }
        }
        $goods_info['gift_list'] = $gift_list;
    }
    private function _getOnlineCartList($cart_list)
    {
        if (empty($cart_list) || !(is_array($cart_list)))
        {
            return $cart_list;
        }
        $goods_id_array = array();
        foreach ($cart_list as $key => $cart_info )
        {
            if (!(intval($cart_info['bl_id'])))
            {
                $goods_id_array[] = $cart_info['goods_id'];
            }
        }
        $model_goods = Model('goods');
        $goods_online_list = $model_goods->getGoodsOnlineListAndPromotionByIdArray($goods_id_array);
        $goods_online_list = $model_goods->getGoodsContract($goods_online_list);
        $goods_online_array = array();
        foreach ($goods_online_list as $goods )
        {
            $goods_online_array[$goods['goods_id']] = $goods;
        }
        foreach ((array) $cart_list as $key => $cart_info )
        {
            if (intval($cart_info['bl_id']))
            {
                continue;
            }
            $cart_list[$key]['state'] = true;
            $cart_list[$key]['storage_state'] = true;
            if (in_array($cart_info['goods_id'], array_keys($goods_online_array)))
            {
                $goods_online_info = $goods_online_array[$cart_info['goods_id']];
                $cart_list[$key]['goods_commonid'] = $goods_online_info['goods_commonid'];
                $cart_list[$key]['goods_name'] = $goods_online_info['goods_name'];
                $cart_list[$key]['gc_id'] = $goods_online_info['gc_id'];
                $cart_list[$key]['goods_image'] = $goods_online_info['goods_image'];
                $cart_list[$key]['transport_id'] = $goods_online_info['transport_id'];
                $cart_list[$key]['goods_freight'] = $goods_online_info['goods_freight'];
                $cart_list[$key]['goods_vat'] = $goods_online_info['goods_vat'];
                $cart_list[$key]['goods_storage'] = $goods_online_info['goods_storage'];
                $cart_list[$key]['goods_storage_alarm'] = $goods_online_info['goods_storage_alarm'];
                $cart_list[$key]['is_fcode'] = $goods_online_info['is_fcode'];
                $cart_list[$key]['have_gift'] = $goods_online_info['have_gift'];
                if ($goods_online_info['goods_storage'] < $cart_info['goods_num'])
                {
                    $cart_list[$key]['storage_state'] = false;
                }
                $cart_list[$key]['groupbuy_info'] = $goods_online_info['groupbuy_info'];
                $cart_list[$key]['xianshi_info'] = $goods_online_info['xianshi_info'];
                $cart_list[$key]['is_vip'] = $goods_online_info['is_vip'];
                $cart_list[$key]['pf_tinfo'] = $goods_online_info['is_pf'];
                $cart_list[$key]['pf_price1'] = $goods_online_info['pf_price1'];
                $cart_list[$key]['pf_price2'] = $goods_online_info['pf_price2'];
                $cart_list[$key]['pf_price3'] = $goods_online_info['pf_price3'];
                $cart_list[$key]['pf_num1'] = $goods_online_info['pf_num1'];
                $cart_list[$key]['pf_num2'] = $goods_online_info['pf_num2'];
                $cart_list[$key]['pf_num3'] = $goods_online_info['pf_num3'];
                if (($goods_online_info['is_vip'] == 1) && empty($goods_online_info['xianshi_info']) && empty($goods_online_info['groupbuy_info']))
                {
                    $conditions = array();
                    $conditions['member_id'] = $_SESSION['member_id'];
                    $conditions['store_id'] = $goods_online_info['store_id'];
                    $conditions['vip_state'] = 1;
                    $vip_members = Model('store_vip_member')->getvipmemberByinfo($conditions);
                    $vip_m_commits = $vip_members['member_commit'];
                    $cart_list[$key]['vip_mt_info'] = $vip_members;
                }
                if (($goods_online_info['is_pf'] == 1) && ($goods_online_info['pf_num1'] <= $cart_info['goods_num']))
                {
                    if (0 < $goods_online_info['pf_num3'])
                    {
                        if (($goods_online_info['pf_num1'] <= $cart_info['goods_num']) && ($cart_info['goods_num'] <= $goods_online_info['pf_num2']))
                        {
                            if (!(empty($cart_list[$key]['vip_mt_info'])))
                            {
                                $cart_list[$key]['goods_old_price'] = $goods_online_info['pf_price1'];
                                $cart_list[$key]['goods_price'] = ncPriceFormat(($goods_online_info['pf_price1'] * $vip_m_commits) / 100);
                            }
                            else
                            {
                                $cart_list[$key]['goods_price'] = $goods_online_info['pf_price1'];
                            }
                        }
                        else if (($goods_online_info['pf_num2'] <= $cart_info['goods_num']) && ($cart_info['goods_num'] <= $goods_online_info['pf_num3']))
                        {
                            if (!(empty($cart_list[$key]['vip_mt_info'])))
                            {
                                $cart_list[$key]['goods_old_price'] = $goods_online_info['pf_price2'];
                                $cart_list[$key]['goods_price'] = ncPriceFormat(($goods_online_info['pf_price2'] * $vip_m_commits) / 100);
                            }
                            else
                            {
                                $cart_list[$key]['goods_price'] = $goods_online_info['pf_price2'];
                            }
                        }
                        else if ($goods_online_info['pf_num3'] <= $cart_info['goods_num'])
                        {
                            if (!(empty($cart_list[$key]['vip_mt_info'])))
                            {
                                $cart_list[$key]['goods_old_price'] = $goods_online_info['pf_price3'];
                                $cart_list[$key]['goods_price'] = ncPriceFormat(($goods_online_info['pf_price3'] * $vip_m_commits) / 100);
                            }
                            else
                            {
                                $cart_list[$key]['goods_price'] = $goods_online_info['pf_price3'];
                            }
                        }
                    }
                    else if (0 < $goods_online_info['pf_num2'])
                    {
                        if (($goods_online_info['pf_num1'] <= $cart_info['goods_num']) && ($cart_info['goods_num'] <= $goods_online_info['pf_num2']))
                        {
                            if (!(empty($cart_list[$key]['vip_mt_info'])))
                            {
                                $cart_list[$key]['goods_old_price'] = $goods_online_info['pf_price1'];
                                $cart_list[$key]['goods_price'] = ncPriceFormat(($goods_online_info['pf_price1'] * $vip_m_commits) / 100);
                            }
                            else
                            {
                                $cart_list[$key]['goods_price'] = $goods_online_info['pf_price1'];
                            }
                        }
                        else if ($goods_online_info['pf_num2'] <= $cart_info['goods_num'])
                        {
                            if (!(empty($cart_list[$key]['vip_mt_info'])))
                            {
                                $cart_list[$key]['goods_old_price'] = $goods_online_info['pf_price2'];
                                $cart_list[$key]['goods_price'] = ncPriceFormat(($goods_online_info['pf_price2'] * $vip_m_commits) / 100);
                            }
                            else
                            {
                                $cart_list[$key]['goods_price'] = $goods_online_info['pf_price2'];
                            }
                        }
                    }
                    $cart_list[$key]['pf_tinfo'] = 1;
                }
                else if (!(empty($cart_list[$key]['vip_mt_info'])))
                {
                    $cart_list[$key]['goods_old_price'] = $goods_online_info['goods_price'];
                    $cart_list[$key]['goods_price'] = ncPriceFormat(($goods_online_info['goods_price'] * $vip_m_commits) / 100);
                }
                else
                {
                    $cart_list[$key]['goods_price'] = $goods_online_info['goods_price'];
                }
                if (($cart_info['bl_id'] == 0) && ($goods_online_info['goods_promotion_type'] == 0))
                {
                    $cart_list[$key]['goods_price'] = Model('goods')->getpf($cart_info['goods_id'], $cart_info['goods_num']);
                }
                $cart_list[$key]['is_book'] = $goods_online_info['is_book'];
                $cart_list[$key]['book_down_payment'] = $goods_online_info['book_down_payment'];
                $cart_list[$key]['book_final_payment'] = $goods_online_info['book_final_payment'];
                $cart_list[$key]['book_down_time'] = $goods_online_info['book_down_time'];
                $cart_list[$key]['is_chain'] = $goods_online_info['is_chain'];
                $_tmp_name = unserialize($goods_online_info['spec_name']);
                $_tmp_value = unserialize($goods_online_info['goods_spec']);
                if (is_array($_tmp_name) && is_array($_tmp_value))
                {
                    $_tmp_name = array_values($_tmp_name);
                    $_tmp_value = array_values($_tmp_value);
                    foreach ($_tmp_name as $sk => $sv )
                    {
                        $cart_list[$key]['goods_spec'] .= $sv . '：' . $_tmp_value[$sk] . '，';
                    }
                    $cart_list[$key]['goods_spec'] = rtrim($cart_list[$key]['goods_spec'], '，');
                }
                if (array_key_exists('sole_info', $goods_online_info))
                {
                    $cart_list[$key]['sole_info'] = $goods_online_info['sole_info'];
                }
                $cart_list[$key]['contractlist'] = $goods_online_info['contractlist'];
            }
            else
            {
                $cart_list[$key]['state'] = false;
                $cart_list[$key]['storage_state'] = false;
            }
        }
        return $cart_list;
    }
    public function getGroupbuyCartList(&$cart_list)
    {
        if (!(C('groupbuy_allow')) || empty($cart_list))
        {
            return;
        }
        foreach ($cart_list as $key => $cart_info )
        {
            if (intval($cart_info['bl_id']) || empty($cart_info['groupbuy_info']) || $cart_info['ifsole'])
            {
                continue;
            }
            $this->getGroupbuyInfo($cart_info);
            $cart_list[$key] = $cart_info;
        }
    }
    public function getMbSoleCartList(&$cart_list)
    {
        foreach ($cart_list as $key => $cart_info )
        {
            if (intval($cart_info['bl_id']) || empty($cart_info['sole_info']))
            {
                continue;
            }
            $this->getMbSoleInfo($cart_info);
            $cart_list[$key] = $cart_info;
        }
    }
    public function getXianshiCartList(&$cart_list)
    {
        if (!(C('promotion_allow')) || empty($cart_list))
        {
            return;
        }
        foreach ($cart_list as $key => $cart_info )
        {
            if (intval($cart_info['bl_id']) || empty($cart_info['xianshi_info']) || !(empty($cart_info['groupbuy_info'])) || $cart_info['ifsole'])
            {
                continue;
            }
            $this->getXianshiInfo($cart_info, $cart_info['goods_num']);
            $cart_list[$key] = $cart_info;
        }
    }
    public function getpfCartList(&$cart_list)
    {
        if (empty($cart_list))
        {
            return;
        }
        foreach ($cart_list as $key => $cart_info )
        {
            if (($cart_info['bl_id'] == 0) || !(empty($cart_info['xianshi_info'])) || !(empty($cart_info['groupbuy_info'])))
            {
                continue;
            }
            if (($cart_info['bl_id'] == 0) && empty($cart_info['xianshi_info']) && empty($cart_info['groupbuy_info']))
            {
                $this->getPfInfo($cart_info, $cart_info['goods_num']);
            }
            $cart_list[$key] = $cart_info;
        }
    }
    private function _getGiftCartList(&$cart_list)
    {
        foreach ($cart_list as $k => $cart_info )
        {
            if ($cart_info['bl_id'])
            {
                continue;
            }
            $this->_getGoodsGiftList($cart_info);
            $cart_list[$k] = $cart_info;
        }
    }
    private function _getBookCartList(&$cart_list)
    {
        if (!(C('promotion_allow')) || empty($cart_list))
        {
            return;
        }
        foreach ($cart_list as $key => $cart_info )
        {
            if (intval($cart_info['bl_id']))
            {
                continue;
            }
            $this->getBookInfo($cart_info);
            if ($cart_info['is_book'])
            {
                $cart_info['state'] = false;
            }
            $cart_list[$key] = $cart_info;
        }
    }
    private function _getBundlingCartList(&$cart_list)
    {
        if (!(C('promotion_allow')) || empty($cart_list))
        {
            return;
        }
        $model_bl = Model('p_bundling');
        $model_goods = Model('goods');
        foreach ($cart_list as $key => $cart_info )
        {
            if (!(intval($cart_info['bl_id'])))
            {
                continue;
            }
            $cart_list[$key]['state'] = true;
            $cart_list[$key]['storage_state'] = true;
            $bl_info = $model_bl->getBundlingInfo(array('bl_id' => $cart_info['bl_id']));
            if (empty($bl_info) || !(intval($bl_info['bl_state'])))
            {
                $cart_list[$key]['state'] = false;
            }
            $cart_list[$key]['bl_goods_list'] = $model_bl->getBundlingGoodsList(array('bl_id' => $cart_info['bl_id']));
            $goods_id_array = array();
            foreach ($cart_list[$key]['bl_goods_list'] as $goods_info )
            {
                $goods_id_array[] = $goods_info['goods_id'];
            }
            $goods_list = $model_goods->getGoodsOnlineListAndPromotionByIdArray($goods_id_array);
            $goods_list = $model_goods->getGoodsContract($goods_list);
            $goods_online_list = array();
            foreach ($goods_list as $goods_info )
            {
                $goods_online_list[$goods_info['goods_id']] = $goods_info;
            }
            unset($goods_list);
            $total_down_price = 0;
            $cart_list[$key]['is_chain'] = true;
            foreach ($cart_list[$key]['bl_goods_list'] as $k => $goods_info )
            {
                if (array_key_exists($goods_info['goods_id'], $goods_online_list))
                {
                    $goods_online_info = $goods_online_list[$goods_info['goods_id']];
                    if ($goods_online_info['goods_storage'] < $cart_info['goods_num'])
                    {
                        $cart_list[$key]['storage_state'] = false;
                    }
                    $cart_list[$key]['bl_goods_list'][$k]['goods_id'] = $goods_online_info['goods_id'];
                    $cart_list[$key]['bl_goods_list'][$k]['goods_commonid'] = $goods_online_info['goods_commonid'];
                    $cart_list[$key]['bl_goods_list'][$k]['store_id'] = $goods_online_info['store_id'];
                    $cart_list[$key]['bl_goods_list'][$k]['goods_name'] = $goods_online_info['goods_name'];
                    $cart_list[$key]['bl_goods_list'][$k]['goods_image'] = $goods_online_info['goods_image'];
                    $cart_list[$key]['bl_goods_list'][$k]['goods_storage'] = $goods_online_info['goods_storage'];
                    $cart_list[$key]['bl_goods_list'][$k]['goods_storage_alarm'] = $goods_online_info['goods_storage_alarm'];
                    $cart_list[$key]['bl_goods_list'][$k]['gc_id'] = $goods_online_info['gc_id'];
                    $cart_list[$key]['bl_goods_list'][$k]['is_chain'] = $goods_online_info['is_chain'];
                    $_tmp_name = unserialize($goods_online_info['spec_name']);
                    $_tmp_value = unserialize($goods_online_info['goods_spec']);
                    if (is_array($_tmp_name) && is_array($_tmp_value))
                    {
                        $_tmp_name = array_values($_tmp_name);
                        $_tmp_value = array_values($_tmp_value);
                        foreach ($_tmp_name as $sk => $sv )
                        {
                            $cart_list[$key]['bl_goods_list'][$k]['goods_spec'] .= $sv . '：' . $_tmp_value[$sk] . '，';
                        }
                        $cart_list[$key]['bl_goods_list'][$k]['goods_spec'] = rtrim($cart_list[$key]['bl_goods_list'][$k]['goods_spec'], '，');
                    }
                    if (!($goods_online_info['is_chain']))
                    {
                        $cart_list[$key]['is_chain'] = false;
                    }
                    $cart_list[$key]['bl_goods_list'][$k]['contractlist'] = $goods_online_info['contractlist'];
                    $total_down_price += $cart_list[$key]['bl_goods_list'][$k]['down_price'] = ncPriceFormat($goods_online_info['goods_price'] - $goods_info['bl_goods_price']);
                }
                else
                {
                    $cart_list[$key]['state'] = false;
                    $cart_list[$key]['storage_state'] = false;
                }
            }
            $cart_list[$key]['down_price'] = ncPriceFormat($total_down_price);
        }
    }
    private function _getEachGoodsStorageQuantity($store_cart_list, $store_premiums_list = array())
    {
        if (empty($store_cart_list) || !(is_array($store_cart_list)))
        {
            return array();
        }
        $goods_storage_quangity = array();
        foreach ($store_cart_list as $store_cart )
        {
            foreach ($store_cart as $cart_info )
            {
                if (!(intval($cart_info['bl_id'])))
                {
                    $goods_storage_quangity[$cart_info['goods_id']] = $cart_info['goods_storage'];
                }
                else if (!(empty($cart_info['bl_goods_list'])) && is_array($cart_info['bl_goods_list']))
                {
                    foreach ($cart_info['bl_goods_list'] as $goods_info )
                    {
                        $goods_storage_quangity[$goods_info['goods_id']] = $goods_info['goods_storage'];
                    }
                }
            }
        }
        if (is_array($store_premiums_list))
        {
            foreach ($store_premiums_list as $store_id => $goods_list )
            {
                foreach ($goods_list as $goods_info )
                {
                    if (!(isset($goods_storage_quangity[$goods_info['goods_id']])))
                    {
                        $goods_storage_quangity[$goods_info['goods_id']] = $goods_info['goods_storage'];
                    }
                }
            }
        }
        return $goods_storage_quangity;
    }
    private function _getEachGoodsBuyQuantity($store_cart_list)
    {
        if (empty($store_cart_list) || !(is_array($store_cart_list)))
        {
            return array();
        }
        $goods_buy_quangity = array();
        foreach ($store_cart_list as $store_cart )
        {
            foreach ($store_cart as $cart_info )
            {
                if (!(intval($cart_info['bl_id'])))
                {
                    $goods_buy_quangity[$cart_info['goods_id']] += $cart_info['goods_num'];
                }
                else if (!(empty($cart_info['bl_goods_list'])) && is_array($cart_info['bl_goods_list']))
                {
                    foreach ($cart_info['bl_goods_list'] as $goods_info )
                    {
                        $goods_buy_quangity[$goods_info['goods_id']] += $cart_info['goods_num'];
                    }
                }
            }
        }
        return $goods_buy_quangity;
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
                    $buy_items[$match[1][0]] = $match[2][0];
                }
            }
        }
        return $buy_items;
    }
    private function _parseMansongRuleDesc($rule_info)
    {
        if (empty($rule_info) || !(is_array($rule_info)))
        {
            return;
        }
        $discount_desc = ((!(empty($rule_info['discount'])) ? '，立减' . $rule_info['discount'] . '元' : ''));
        if (APP_ID == 'mobile')
        {
            $_tmp = array();
            $_tmp['desc'] = '单笔订单满' . $rule_info['price'] . '元' . $discount_desc;
            if (!(empty($rule_info['mansong_goods_name'])))
            {
                $_tmp['goods_name'] = $rule_info['mansong_goods_name'];
                $_tmp['url'] = cthumb($rule_info['goods_image'], 60);
            }
            return $_tmp;
        }
        if (!(empty($rule_info['mansong_goods_name'])))
        {
            $goods_desc = ' 送<a href=\'' . urlMall('goods', 'index', array('goods_id' => $rule_info['goods_id'])) . '\' title=\'' . $rule_info['mansong_goods_name'] . '\' target=\'_blank\'>[赠品]</a>';
            $goods_desc .= '<a class="ncc-store-gift" title="' . $rule_info['mansong_goods_name'] . '" target="_blank" href="' . urlMall('goods', 'index', array('goods_id' => $rule_info['goods_id'])) . '"><img alt="' . $rule_info['mansong_goods_name'] . '" src="' . cthumb($rule_info['goods_image'], 60) . '"></a>';
        }
        return sprintf('满%s%s%s', $rule_info['price'], $discount_desc, $goods_desc);
    }
}
?>