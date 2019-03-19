<?php
/**
 * 分享秀店铺街
 *
 *
 * * 
 *
 * 
 *  
 */



defined('INSYSVIEW') or exit('Access Invalid!');
class storeControl extends ShareShowControl{

    public function __construct() {
        parent::__construct();
        Tpl::output('index_sign','store');
    }

    public function indexFeiwa(){
        $this->store_listFeiwa();
    }

    /**
     * 店铺列表
     */
    public function store_listFeiwa() {
        $model_store = Model('store');
        $model_shareshow_store = Model('micro_store');
        $condition = array();
        $store_list = $model_shareshow_store->getListWithStoreInfo($condition,30,'shareshow_sort asc');
        Tpl::output('list',$store_list);
        Tpl::output('show_page',$model_store->showpage(2));
        //广告位
        self::get_shareshow_adv('store_list');
        Tpl::output('html_title',Language::get('feiwa_shareshow_store').'-'.Language::get('feiwa_shareshow').'-'.C('site_name'));
        Tpl::showpage('store_list');
    }

    /**
     * 店铺详细页
     */
    public function detailFeiwa() {
        $store_id = intval($_GET['store_id']);
        if($store_id <= 0) {
            header('location: '.SHARESHOW_SITE_URL);die;
        }
        $model_store = Model('store');
        $model_goods = Model('goods');
        $model_shareshow_store = Model('micro_store');

        $store_info = $model_shareshow_store->getOneWithStoreInfo(array('shareshow_store_id'=>$store_id));
        if(empty($store_info)) {
            header('location: '.SHARESHOW_SITE_URL);
        }

        //点击数加1
        $update = array();
        $update['click_count'] = array('exp','click_count+1');
        $model_shareshow_store->modify($update,array('shareshow_store_id'=>$store_id));

        Tpl::output('detail',$store_info);

        $condition = array();
        $condition['store_id'] = $store_info['mall_store_id'];
        $goods_list = $model_goods->getGoodsListByColorDistinct($condition, 'goods_id,store_id,goods_name,goods_image,goods_price,goods_salenum', 'goods_id asc', 39);
        Tpl::output('comment_type','store');
        Tpl::output('comment_id',$store_id);
        Tpl::output('list',$goods_list);
        Tpl::output('show_page',$model_goods->showpage());
        //获得分享app列表
        self::get_share_app_list();
        Tpl::output('html_title',$store_info['store_name'].'-'.Language::get('feiwa_shareshow_store').'-'.Language::get('feiwa_shareshow').'-'.C('site_name'));
        Tpl::showpage('store_detail');
    }

}
