<?php
/**
 * 我的购物车
 *
 *
 *
 *
 * 
 *
 * @link       #
 * @since      File available since Release v1.1
 */



defined('INSYSVIEW') or exit('Access Invalid!');

class member_cartControl extends mobileMemberControl {

    public function __construct() {
        parent::__construct();
    }

    /**
     * 购物车列表
     */
    public function cart_listFeiwa() {
        $model_cart = Model('cart');

        $condition = array('buyer_id' => $this->member_info['member_id']);
        $cart_list  = $model_cart->listCart('db', $condition);

        // 购物车列表 [得到最新商品属性及促销信息]
        $logic_buy_1 = logic('buy_1');
        $cart_list = $logic_buy_1->getGoodsCartList($cart_list);

        //购物车商品以店铺ID分组显示,并计算商品小计,店铺小计与总价由JS计算得出
        $store_cart_list = array();
        $sum = 0;
        foreach ($cart_list as $cart) {
            if (!empty($cart['gift_list'])) {
                foreach ($cart['gift_list'] as $key => $val) {
                    $cart['gift_list'][$key]['goods_image_url'] = cthumb($val['gift_goodsimage'], $cart['store_id']);
                }
                $cart['gift_list'] = array_values($cart['gift_list']);
            }
            $store_cart_list[$cart['store_id']]['store_id'] = $cart['store_id'];
            $store_cart_list[$cart['store_id']]['store_name'] = $cart['store_name'];
            $cart['goods_image_url'] = cthumb($cart['goods_image'], $cart['store_id']);
            $cart['goods_total'] = ncPriceFormat($cart['goods_price'] * $cart['goods_num']);
            $cart['xianshi_info'] = $cart['xianshi_info'] ? $cart['xianshi_info'] : array();
            $cart['groupbuy_info'] = $cart['groupbuy_info'] ? $cart['groupbuy_info'] : array();
			$cart['ifpf'] = Model('goods')->getifpf($cart['goods_id'],$cart['goods_price']);
            $store_cart_list[$cart['store_id']]['goods'][] = $cart;
            $sum += $cart['goods_total'];
			
        }
        
        // 店铺优惠券
        $condition = array();
        $condition['voucher_t_gettype'] = 3;
        $condition['voucher_t_state'] = 1;
        $condition['voucher_t_end_date'] = array('gt', time());
        $condition['voucher_t_mgradelimit'] = array('elt', $this->member_info['level']);
        $condition['voucher_t_store_id'] = array('in', array_keys($store_cart_list));
        $voucher_template = Model('voucher')->getVoucherTemplateList($condition);
        if (!empty($voucher_template)) {
            foreach ($voucher_template as $val) {
                $param = array();
                $param['voucher_t_id'] = $val['voucher_t_id'];
                $param['voucher_t_price'] = $val['voucher_t_price'];
                $param['voucher_t_limit'] = $val['voucher_t_limit'];
                $param['voucher_t_end_date'] = date('Y年m月d日', $val['voucher_t_end_date']);
                $store_cart_list[$val['voucher_t_store_id']]['voucher'][] = $param;
            }
        }
        
        //取得店铺级活动 - 可用的满即送活动
        $mansong_rule_list = $logic_buy_1->getMansongRuleList(array_keys($store_cart_list));
        if (!empty($mansong_rule_list)) {
            foreach ($mansong_rule_list as $key => $val) {
                $store_cart_list[$key]['mansong'] = $val;
            }
        }
        
        //取得哪些店铺有满免运费活动
        $free_freight_list = $logic_buy_1->getFreeFreightactiveList(array_keys($store_cart_list));
        if (!empty($free_freight_list)) {
            foreach ($free_freight_list as $key => $val) {
                $store_cart_list[$key]['free_freight'] = $val;
            }
        }

        output_data(array('cart_list' => array_values($store_cart_list), 'sum' => ncPriceFormat($sum), 'cart_count' => count($cart_list)));
    }

    /**
     * 购物车列表
     */
    public function cart_list_oldFeiwa() {
        $model_cart = Model('cart');
    
        $condition = array('buyer_id' => $this->member_info['member_id']);
        $cart_list  = $model_cart->listCart('db', $condition);
    
        // 购物车列表 [得到最新商品属性及促销信息]
        $cart_list = logic('buy_1')->getGoodsCartList($cart_list, $jjgObj);
        $sum = 0;
        foreach ($cart_list as $key => $value) {
            $cart_list[$key]['goods_image_url'] = cthumb($value['goods_image'], $value['store_id']);
            $cart_list[$key]['goods_sum'] = ncPriceFormat($value['goods_price'] * $value['goods_num']);
            $sum += $cart_list[$key]['goods_sum'];
        }
    
        output_data(array('cart_list' => $cart_list, 'sum' => ncPriceFormat($sum)));
    }

    /**
     * 购物车添加
     */
    public function cart_addFeiwa() {
        $goods_id = intval($_POST['goods_id']);
        $quantity = intval($_POST['quantity']);
        if($goods_id <= 0 || $quantity <= 0) {
            output_error('参数错误');
        }

        $model_goods = Model('goods');
        $model_cart = Model('cart');
        $logic_buy_1 = Logic('buy_1');

        $goods_info = $model_goods->getGoodsOnlineInfoAndPromotionById($goods_id);

        //验证是否可以购买
        if(empty($goods_info)) {
            output_error('商品已下架或不存在');
        }

        //团购
        $logic_buy_1->getGroupbuyInfo($goods_info);
        if ($goods_info['ifgroupbuy']) {
            if ($goods_info['upper_limit'] && $quantity > $goods_info['upper_limit']) {
                output_error('团购商品购买超限，最多可购买'.$goods_info['upper_limit']."个");
            }
        }

        //限时折扣
        $logic_buy_1->getXianshiInfo($goods_info,$quantity);

        if ($goods_info['store_id'] == $this->member_info['store_id']) {
            output_error('不能购买自己发布的商品');
        }
        if(intval($goods_info['goods_storage']) < 1 || intval($goods_info['goods_storage']) < $quantity) {
            output_error('库存不足');
        }

        if ($goods_info['is_virtual'] || $goods_info['is_fcode'] || $goods_info['is_book']) {
            output_error('该商品不允许加入购物车，请直接购买');
        }

        $param = array();
        $param['buyer_id']  = $this->member_info['member_id'];
        $param['store_id']  = $goods_info['store_id'];
        $param['goods_id']  = $goods_info['goods_id'];
        $param['goods_name'] = $goods_info['goods_name'];
        $param['goods_price'] = $goods_info['goods_price'];
        $param['goods_image'] = $goods_info['goods_image'];
        $param['store_name'] = $goods_info['store_name'];

        $result = $model_cart->addCart($param, 'db', $quantity);
        if($result) {
            output_data('1');
        } else {
            output_error('收藏失败');
        }
    }

    /**
     * 购物车删除
     */
    public function cart_delFeiwa() {
        $cart_id = intval($_POST['cart_id']);

        $model_cart = Model('cart');

        if($cart_id > 0) {
            $condition = array();
            $condition['buyer_id'] = $this->member_info['member_id'];
            $condition['cart_id'] = $cart_id;

            $model_cart->delCart('db', $condition);
        }

        output_data('1');
    }

    /**
     * 更新购物车购买数量
     */
    

	public function cart_edit_quantityFeiwa() {
        $cart_id = intval(abs($_POST['cart_id']));
        $quantity = intval(abs($_POST['quantity']));
        if(empty($cart_id) || empty($quantity)) {
            output_error('参数错误');
        }

		$model_cart = Model('cart');
		$model_goods= Model('goods');
		$logic_buy_1 = logic('buy_1');

		//存放返回信息
		$return = array();

		$cart_info = $model_cart->getCartInfo(array('cart_id'=>$cart_id,'buyer_id'=>$this->member_info['member_id']));

		if ($cart_info['bl_id'] == '0') {

		    //普通商品
		    $goods_id = intval($cart_info['goods_id']);
		    $goods_info	= $logic_buy_1->getGoodsOnlineInfo($goods_id,$quantity);
		    if(empty($goods_info)) {
		        $return['state'] = 'invalid';
		        $return['msg'] = '商品已被下架';
		        $return['subtotal'] = 0;
		        QueueClient::push('delCart', array('buyer_id'=>$this->member_info['member_id'],'cart_ids'=>array($cart_id)));
		        output_error('商品已被下架');
		    }

		    //抢购
		    $logic_buy_1->getGroupbuyInfo($goods_info);

		    //限时折扣
		    $logic_buy_1->getXianshiInfo($goods_info,$quantity);

		    $quantity = $goods_info['goods_num'];

		    if(intval($goods_info['goods_storage']) < $quantity) {
		        $return['state'] = 'shortage';
		        $return['msg'] = '库存不足';
		        $return['goods_num'] = $goods_info['goods_num'];
		        $return['goods_price'] = $goods_info['goods_price'];
		        $return['subtotal'] = $goods_info['goods_price'] * $quantity;
		        $model_cart->editCart(array('goods_num'=>$goods_info['goods_storage']),array('cart_id'=>$cart_id,'buyer_id'=>$this->member_info['member_id']));
		        output_error('库存不足');
		    }
		} else {

		    //优惠套装商品
		    $model_bl = Model('p_bundling');
		    $bl_goods_list = $model_bl->getBundlingGoodsList(array('bl_id'=>$cart_info['bl_id']));
		    $goods_id_array = array();
		    foreach ($bl_goods_list as $goods) {
		        $goods_id_array[] = $goods['goods_id'];
		    }
		    $goods_list = $model_goods->getGoodsOnlineListAndPromotionByIdArray($goods_id_array);

		    //如果其中有商品下架，删除
		    if (count($goods_list) != count($goods_id_array)) {
		        $return['state'] = 'invalid';
		        $return['msg'] = '该优惠套装已经无效，建议您购买单个商品';
		        $return['subtotal'] = 0;
		        QueueClient::push('delCart', array('buyer_id'=>$this->member_info['member_id'],'cart_ids'=>array($cart_id)));
		        output_error('该优惠套装已经无效，建议您购买单个商品');
		    }

		    //如果有商品库存不足，更新购买数量到目前最大库存
		    foreach ($goods_list as $goods_info) {
		        if ($quantity > $goods_info['goods_storage']) {
		            $return['state'] = 'shortage';
		            $return['msg'] = '该优惠套装部分商品库存不足，建议您降低购买数量或购买库存足够的单个商品';
		            $return['goods_num'] = $goods_info['goods_storage'];
		            $return['goods_price'] = $cart_info['goods_price'];
		            $return['subtotal'] = $cart_info['goods_price'] * $quantity;
		            $model_cart->editCart(array('goods_num'=>$goods_info['goods_storage']),array('cart_id'=>$cart_id,'buyer_id'=>$this->member_info['member_id']));
		            output_error('该优惠套装部分商品库存不足，建议您降低购买数量或购买库存足够的单个商品');
		            break;
		        }
		    }
		    $goods_info['goods_price'] = $cart_info['goods_price'];
		}

		$data = array();
        $data['goods_num'] = $quantity;
        $data['goods_price'] = $goods_info['goods_price'];
        $update = $model_cart->editCart($data,array('cart_id'=>$cart_id,'buyer_id'=>$this->member_info['member_id']));
		if ($update) {
		    $return = array();
			$return['state'] = 'true';
			$return['subtotal'] = $goods_info['goods_price'] * $quantity;
			$return['goods_price'] = $goods_info['goods_price'];
			$return['goods_num'] = $quantity;
			$return['ifpf']=Model('goods')->getifpf($goods_info['goods_id'],$goods_info['goods_price']);
		} else {
			output_error('修改失败');
		}
		 output_data($return);
    }

    /**
     * 检查库存是否充足
     */
    private function _check_goods_storage(& $cart_info, $quantity, $member_id) {
        $model_goods= Model('goods');
        $model_bl = Model('p_bundling');
        $logic_buy_1 = Logic('buy_1');

        if ($cart_info['bl_id'] == '0') {
            //普通商品
            $goods_info = $model_goods->getGoodsOnlineInfoAndPromotionById($cart_info['goods_id']);

            //手机专享
            $logic_buy_1->getMbSoleInfo($goods_info);
            
            //团购
            $logic_buy_1->getGroupbuyInfo($goods_info);
            if ($goods_info['ifgroupbuy']) {
                if ($goods_info['upper_limit'] && $quantity > $goods_info['upper_limit']) {
                    return false;
                }
            }

            //限时折扣
            $logic_buy_1->getXianshiInfo($goods_info,$quantity);

            if(intval($goods_info['goods_storage']) < $quantity) {
                return false;
            }
            $goods_info['cart_id'] = $cart_info['cart_id'];
            $cart_info = $goods_info;
        } else {
            //优惠套装商品
            $bl_goods_list = $model_bl->getBundlingGoodsList(array('bl_id' => $cart_info['bl_id']));
            $goods_id_array = array();
            foreach ($bl_goods_list as $goods) {
                $goods_id_array[] = $goods['goods_id'];
            }
            $bl_goods_list = $model_goods->getGoodsOnlineListAndPromotionByIdArray($goods_id_array);

            //如果有商品库存不足，更新购买数量到目前最大库存
            foreach ($bl_goods_list as $goods_info) {
                if (intval($goods_info['goods_storage']) < $quantity) {
                    return false;
                }
            }
        }
        return true;
    }
    
    /**
     * 查询购物车商品数量
     */
    function cart_countFeiwa() {
        $param['cart_count'] = Model('cart')->countCartByMemberId($this->member_info['member_id']);
        output_data($param);
    }

    /**
     * 批量添加购物车
     * cartlist 格式为goods_id1,num1|goods_id2,num2
     */
    public function cart_batchaddFeiwa(){
        $param = $_POST;
        $cartlist_str = trim($param['cartlist']);
        $cartlist_arr = $cartlist_str?explode('|',$cartlist_str):array();
        if(!$cartlist_arr) {
            output_error('参数错误');
        }

        $cartlist_new =  array();
        foreach($cartlist_arr as $k=>$v){
            $tmp = $v?explode(',',$v):array();
            if (!$tmp) {
                continue;
            }
            $cartlist_new[$tmp[0]]['goods_num'] = $tmp[1];
        }
        Model('cart')->batchAddCart($cartlist_new, $this->member_info['member_id'], $this->member_info['store_id']);
        output_data('1');
    }
}
