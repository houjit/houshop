<?php
/**
 * 默认展示页面
 * @
 */
defined('INSYSVIEW') or exit('Access Invalid!');
class indexControl extends BaseHomeControl{
    public function indexFeiwa(){
        //echo "<h1 style='text-align: center; margin-top:10em; color:#333333'>PC官网开发中，请先使用APP或小程序<h1>";exit;

        Language::read('home_index_index');
        Tpl::output('index_sign','index');

        //抢购专区
        Language::read('member_groupbuy');
        $model_groupbuy = Model('groupbuy');
        $group_list = $model_groupbuy->getGroupbuyCommendedList(3);
        Tpl::output('group_list', $group_list);
		
		//专题获取

        $model_special = Model('reads_special');
        $special_list = $model_special->getMallindexList($conition);
        Tpl::output('special_list', $special_list);
		
        //限时折扣
        $condition = array();
        $condition['state'] = 1;
		$condition['recommended'] = 1;
        $condition['start_time'] = array('elt',TIMESTAMP);
        $condition['end_time'] = array('gt',TIMESTAMP);
		$xianshi_list = Model('p_xianshi')->getXianshiList($condition, 6, 'state desc, end_time asc');
		foreach($xianshi_list as $k=>$v){
        $conditions = array();
		$conditions['xianshi_id'] = intval($v['xianshi_id']);
		$conditions['state'] = 1;
        $conditions['start_time'] = array('elt',TIMESTAMP);
        $conditions['end_time'] = array('gt',TIMESTAMP);
        $goods_list = Model('p_xianshi_goods')->getXianshiGoodsExtendList($conditions,'','xianshi_goods_id desc');
		
		$xianshi_discount = array();
    	foreach($goods_list as $value) {
    		$xianshi_discount[] = floatval($value['xianshi_discount']);
    	}
        $new_xianshi_discount = array_search(min($xianshi_discount), $xianshi_discount);
        $xianshi_list[$k]['xianshi_discount']=$xianshi_discount[$new_xianshi_discount];
		}
        Tpl::output('xianshi_item', $xianshi_list);
		
		//直达楼层信息
        if (C('feiwa_lc') != '') {
            $lc_list = @unserialize(C('feiwa_lc'));
        }
        Tpl::output('lc_list',is_array($lc_list) ? $lc_list : array());
		
        //首页推荐词链接
        if (C('feiwa_rc') != '') {
            $rc_list = @unserialize(C('feiwa_rc'));
        }
        Tpl::output('rc_list',is_array($rc_list) ? $rc_list : array());

        //推荐品牌
        $brands=C(feiwa_index_brand);
        $brand_r_list = Model('brand')->getBrandIDList($brands);
        Tpl::output('brand_r',$brand_r_list);
		
		//推荐店铺
		$storeids=C(feiwa_index_store);
		$store_list = Model('store')->getStoreMemberIDLists($storeids);
		Tpl::output('store_list',$store_list);
		
		//推荐商品
		$goodsids=C(feiwa_index_goods);
		$goods_list = Model('goods')->getGoodsIDList($goodsids);
		Tpl::output('goods_list',$goods_list);
		
		
		//评价信息
        $goods_evaluate_info = Model('evaluate_goods')->getEvaluateGoodsList('',10);
        Tpl::output('goods_evaluate_info', $goods_evaluate_info);

        //板块信息
        $model_web_config = Model('web_config');
        $web_html = $model_web_config->getWebHtml('index');
        Tpl::output('web_html',$web_html);
        Model('seo')->type('index')->show();
        Tpl::showpage('index');
    }

    //json输出商品分类
    public function josn_classFeiwa() {
        /**
         * 实例化商品分类模型
         */
        $model_class        = Model('goods_class');
        $goods_class        = $model_class->getGoodsClassListByParentId(intval($_GET['gc_id']));
        $array              = array();
        if(is_array($goods_class) and count($goods_class)>0) {
            foreach ($goods_class as $val) {
                $array[$val['gc_id']] = array('gc_id'=>$val['gc_id'],'gc_name'=>htmlspecialchars($val['gc_name']),'gc_parent_id'=>$val['gc_parent_id'],'commis_rate'=>$val['commis_rate'],'gc_sort'=>$val['gc_sort']);
            }
        }
        /**
         * 转码
         */
        if (strtoupper(CHARSET) == 'GBK'){
            $array = Language::getUTF8(array_values($array));//网站GBK使用编码时,转换为UTF-8,防止json输出汉字问题
        } else {
            $array = array_values($array);
        }
        echo $_GET['callback'].'('.json_encode($array).')';
    }

    /**
     * json输出地址数组 原data/resource/js/area_array.js
     */
    public function json_areaFeiwa()
    {
        $_GET['src'] = $_GET['src'] != 'db' ? 'cache' : 'db';
        echo $_GET['callback'].'('.json_encode(Model('area')->getAreaArrayForJson($_GET['src'])).')';
    }

    /**
     * 根据ID返回所有父级地区名称
     */
    public function json_area_showFeiwa()
    {
        $area_info['text'] = Model('area')->getTopAreaName(intval($_GET['area_id']));
        echo $_GET['callback'].'('.json_encode($area_info).')';
    }

    //判断是否登录
    public function loginFeiwa(){
        echo ($_SESSION['is_login'] == '1')? '1':'0';
    }

/*
 * 存储当前选择城市
 */

	public function save_cityFeiwa(){
	  	setcookie("city",'',time()-3600*1);		
		setcookie("city",$_GET['city'], time()+3600*24);
		$url = MALL_SITE_URL;
		if (C('feiwa_city') != '') {
            $citys_list = @unserialize(C('feiwa_city'));
        }
		foreach($citys_list as $k=>$v){
			if($_GET['city']==$v['name']){
			$url = $url.'/'.$v['curl'];
		}
		}

		header("Location: ".$url.""); 
	}

    /**
     * 头部最近浏览的商品
     */
    public function viewed_infoFeiwa(){
        $info = array();
        if ($_SESSION['is_login'] == '1') {
            $member_id = $_SESSION['member_id'];
            $info['m_id'] = $member_id;
            if (C('voucher_allow') == 1) {
                $time_to = time();//当前日期
                $info['voucher'] = Model()->table('voucher')->where(array('voucher_owner_id'=> $member_id,'voucher_state'=> 1,
                'voucher_start_date'=> array('elt',$time_to),'voucher_end_date'=> array('egt',$time_to)))->count();
            }
            $time_to = strtotime(date('Y-m-d'));//当前日期
            $time_from = date('Y-m-d',($time_to-60*60*24*7));//7天前
            $info['consult'] = Model()->table('consult')->where(array('member_id'=> $member_id,
            'consult_reply_time'=> array(array('gt',strtotime($time_from)),array('lt',$time_to+60*60*24),'and')))->count();
        }
        $goods_list = Model('goods_browse')->getViewedGoodsList($_SESSION['member_id'],5);
        if(is_array($goods_list) && !empty($goods_list)) {
            $viewed_goods = array();
            foreach ($goods_list as $key => $val) {
                $goods_id = $val['goods_id'];
                $val['url'] = urlMall('goods', 'index', array('goods_id' => $goods_id));
                $val['goods_image'] = thumb($val, 60);
                $viewed_goods[$goods_id] = $val;
            }
            $info['viewed_goods'] = $viewed_goods;
        }
        if (strtoupper(CHARSET) == 'GBK'){
            $info = Language::getUTF8($info);
        }
        echo json_encode($info);
    }
    /**
     * 查询每月的周数组
     */
    public function getweekofmonthFeiwa(){
        import('function.datehelper');
        $year = $_GET['y'];
        $month = $_GET['m'];
        $week_arr = getMonthWeekArr($year, $month);
        echo json_encode($week_arr);
        die;
    }
}
