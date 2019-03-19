<?php
/**
 * 商品列表
 *
 * * 
 *
 * @
  
 */



defined('INSYSVIEW') or exit('Access Invalid!');

class promotionControl extends BaseHomeControl {
	
	public function __construct() {
        parent::__construct() ;

       Tpl::output('index_sign', 'promotion');

    }
	
    const PAGESIZE = 16;
    public function indexFeiwa() {
        $model_xianshi_goods = Model('p_xianshi_goods');
        $model_goods = Model('goods');

        $condition = array();
        $condition['state'] = 1;
        $condition['start_time'] = array('elt',TIMESTAMP);
        $condition['end_time'] = array('gt',TIMESTAMP);
        $condition['xianshi_id'] = intval($_GET['id']);

        $xs_info = Model('p_xianshi')->getXianshiInfoByID($condition['xianshi_id']);
        if(!$xs_info){
            showMessage(不存在,'index.php','html','error');
        }
			
        $goods_list = $model_xianshi_goods->getXianshiGoodsExtendList($condition,self::PAGESIZE,'xianshi_goods_id desc');
        $total_page = pagecmd('gettotalpage');
        if (intval($_GET['curpage'] > $total_page)) {
            exit();
        }
        $xs_goods_list = array();
        foreach ($goods_list as $k => $goods_info) {
            $xs_goods_list[$goods_info['goods_id']] = $goods_info;
            $xs_goods_list[$goods_info['goods_id']]['image_url_240'] = cthumb($goods_info['goods_image'], 240, $goods_info['store_id']);
            $xs_goods_list[$goods_info['goods_id']]['down_price'] = $goods_info['goods_price'] - $goods_info['xianshi_price'];
        }
        $condition = array('goods_id' => array('in',array_keys($xs_goods_list)));
        $goods_list = $model_goods->getGoodsOnlineList($condition, 'goods_id,gc_id_1,evaluation_good_star,store_id,store_name', 0, '', self::PAGESIZE, null, false);
        foreach ($goods_list as $k => $goods_info) {
            $xs_goods_list[$goods_info['goods_id']]['evaluation_good_star'] = $goods_info['evaluation_good_star'];
            $xs_goods_list[$goods_info['goods_id']]['store_name'] = $goods_info['store_name'];
            if ($xs_goods_list[$goods_info['goods_id']]['gc_id_1'] != $goods_info['gc_id_1']) {
                //兼容以前版本，如果限时商品表没有保存一级分类ID，则马上保存
                $model_xianshi_goods->editXianshiGoods(array('gc_id_1'=>$goods_info['gc_id_1']),array('xianshi_goods_id'=>$xs_goods_list[$goods_info['goods_id']]['xianshi_goods_id']));
            }
        }

        //查询商品评分信息
        $goodsevallist = Model("evaluate_goods")->getEvaluateGoodsList(array('geval_goodsid'=>array('in',array_keys($xs_goods_list))));
        $eval_list = array();
        if (!empty($goodsevallist)) {
            foreach ($goodsevallist as $v) {
                if($v['geval_content'] == '' || count($eval_list[$v['geval_goodsid']]) >=2) continue;
                $eval_list[$v['geval_goodsid']][] = $v;
            }
        }
        Tpl::output('goodsevallist',$eval_list);
		
		$goods_lists = Model('p_xianshi_goods')->getXianshiGoodsExtendList($condition,'','xianshi_goods_id desc');
		$xianshi_discount = array();
    	foreach($goods_lists as $value) {
    		$xianshi_discount[] = floatval($value['xianshi_discount']);
    	}
        $new_xianshi_discount = array_search(min($xianshi_discount), $xianshi_discount);
		
        $xs_info['xianshi_discount']=$xianshi_discount[$new_xianshi_discount];
        Tpl::output('xs_info',$xs_info);
        Tpl::output('goods_list', $xs_goods_list);
        if (!empty($_GET['curpage'])) {
            Tpl::showpage('promotion.item','null_layout');
        } else {



            //查询商品分类
            $goods_class = Model('p_xianshi_class')->getTreeList(0);
            Tpl::output('goods_class', $goods_class);
            Tpl::output('total_page',pagecmd('gettotalpage'));
            Tpl::showpage('promotion');
        }
    }
/*
 * 获取淘特卖列表
 */

    public function listFeiwa() {
    	$model_xianshi = Model('p_xianshi');
		$condition = array();
        $condition['state'] = 1;
        $condition['start_time'] = array('elt',TIMESTAMP);
        $condition['end_time'] = array('gt',TIMESTAMP);
		if($_GET['class_id']){
			$condition['class_id'] = intval($_GET['class_id']);
		}
		$xianshi_list = $model_xianshi->getXianshiList($condition, 10, 'state desc, end_time asc');

        
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
        Tpl::output('list', $xianshi_list);
        Tpl::output('show_page', $model_xianshi->showpage());
		
	    $conditions = array();
		if($_GET['class_id']){
			$xianshi_lists = Model('p_xianshi')->getXianshiList($condition, '', 'state desc, end_time asc');
			foreach ($xianshi_lists as $k => $v) {
            $xianshi_slist[$v['xianshi_id']] = $v;
           
        }
		$conditions = array('xianshi_id' => array('in',array_keys($xianshi_slist)),'state'=>'1','xianshi_recommend'=>'1','end_time'=>array('gt',TIMESTAMP),'start_time'=>array('elt',TIMESTAMP));
		}else{
		$conditions['state'] = 1;
        $conditions['start_time'] = array('elt',TIMESTAMP);
        $conditions['end_time'] = array('gt',TIMESTAMP);
		$conditions['xianshi_recommend'] = 1;	
		}
        $goods_list = Model('p_xianshi_goods')->getXianshiGoodsExtendList($conditions,10,'start_time desc');
		
        $xs_goods_list = array();
        foreach ($goods_list as $k => $goods_info) {
            $xs_goods_list[$goods_info['goods_id']] = $goods_info;
            $xs_goods_list[$goods_info['goods_id']]['image_url_240'] = cthumb($goods_info['goods_image'], 240, $goods_info['store_id']);
        }
        $conditione = array('goods_id' => array('in',array_keys($xs_goods_list)));
        $goods_list = Model('goods')->getGoodsOnlineList($conditione, 'goods_id,goods_salenum,store_id,store_name', 10, 'goods_salenum asc', 10, null, 10);
		
        foreach ($goods_list as $k => $goods_info) {
            $xs_goods_list[$goods_info['goods_id']]['evaluation_good_star'] = $goods_info['evaluation_good_star'];
            $xs_goods_list[$goods_info['goods_id']]['store_name'] = $goods_info['store_name'];
            $xs_goods_list[$goods_info['goods_id']]['goods_salenum']= $goods_info['goods_salenum'];
        }
        
		Tpl::output('goods_list', $xs_goods_list);
		
		
		//获取当前分类推荐品牌特卖
		$data = array();
        $data['state'] = 1;
		$data['recommended'] = 1;
        $data['start_time'] = array('elt',TIMESTAMP);
        $data['end_time'] = array('gt',TIMESTAMP);
		if($_GET['class_id']){
			$data['class_id'] = intval($_GET['class_id']);
		}
		$xianshi_rec = Model('p_xianshi')->getXianshiList($data, 7, 'state desc, end_time desc');
		Tpl::output('list_rec', $xianshi_rec);
		

		//查询淘特卖分类
        $goods_class = Model('p_xianshi_class')->getTreeList();
        Tpl::output('goods_class', $goods_class);
		// 首页幻灯
        $loginpic = unserialize(C('promotion_xspic'));
        Tpl::output('loginpic', $loginpic);
		Tpl::showpage('promotion.list');
	}

}