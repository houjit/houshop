<?php
/**
 * 问答展示模块
 *
 *
 *
 *  
 
 * @
 */


defined('INSYSVIEW') or exit('Access Invalid!');
class consultControl extends BaseHomeControl{
	
	 /**
     * 产品咨询
     */
    public function indexFeiwa() {
Tpl::output('hidden_nctoolbar', 1);

        //得到商品咨询信息
        $model_consult = Model('consult');
        $where = array();
        if (intval($_GET['ctid']) > 0) {
            $where['ct_id']  = intval($_GET['ctid']);
        }
        $consult_list = $model_consult->getConsultList($where, '*', 0, 20);
		
		foreach($consult_list as $k=>$v){
			$store=Model('store')->getStoreInfoByID($v['store_id']);
			$consult_list[$k]['store_domain']=$store['store_domain'];
			$consult_list[$k]['store_avatar']=$store['store_avatar'];
		}
        Tpl::output('consult_list',$consult_list);
        Tpl::output('show_page', $model_consult->showpage());
		
		//获取最新三条回答咨询
		$wheres=array();
		$wheres['consult_reply']!="";
		$consult_lists = $model_consult->getConsultList($wheres, '*', 3,0);
		Tpl::output('consult_lists',$consult_lists);

        // 咨询类型
        $consult_type = rkcache('consult_type', true);
        Tpl::output('consult_type', $consult_type);
		
		//获取店铺数量
		$where=array();
		$consults['stores']=Model('store')->getStoreCount($where);
		$consults['consults']=Model('consult')->getConsultCount($where);
		Tpl::output('consults', $consults);
		
		//热门收藏店铺
		$store_list=Model('store')->getStoreOnlineList($conition,'0','store_collect DESC','*',6);
		Tpl::output('store_list', $store_list);
		
		//推荐店铺
		$storeids='1,3,4,5';
		$store_lists = Model('store')->getStoreMemberIDLists($storeids);
		$store_lists = Model('store')->getStoreSearchList($store_lists);
		Tpl::output('store_lists',$store_lists);

        $seo_param = array ();
        $seo_param['name'] = '产品咨询回答问总';
        $seo_param['key'] = '产品咨询回答问总';
        $seo_param['description'] = '产品咨询回答问总';
        Model('seo')->type('product')->param($seo_param)->show();

        Tpl::output('index_sign','consult');
        Tpl::showpage('consult');
    }

    /**
     * 产品咨询
     */
    public function consultingFeiwa() {
        $consult_id = intval($_GET['consult_id']);
        $model_consult = Model('consult');
		$wheres=array();
		$wheres['consult_id']=$consult_id;
		$consult_info=$model_consult->getConsultInfo($wheres);

		$store=Model('store')->getStoreInfoByID($consult_info['store_id']);
		$consult_info['store_domain']=$store['store_domain'];
		$consult_info['store_avatar']=$store['store_avatar'];
		

        // 当前位置导航
        //$nav_link_list = Model('goods_class')->getGoodsClassNav($goods_info['gc_id'], 0);
        $nav_link_list[] = array('title' => '商家应答', 'link' => urlMall('consult', 'index'));
        $nav_link_list[] = array('title' => $consult_info['consult_content']);
        Tpl::output('nav_link_list', $nav_link_list);
		
		//获取当前咨询商品信息
		$count=array();
		$count['goods_id']=$consult_info['goods_id'];
		$goodsinfo=Model('goods')->getGoodsInfo($count);
		Tpl::output('goods', $goodsinfo);
		

		
		// 获取当前咨询产品分类
        $gc_ids = Model('goods_class')->getGoodsClassNavs($goodsinfo['gc_id'], 0);
        Tpl::output('gc_ids', $gc_ids);
		
		// 分类 含所有父级分类
                $gcIds = array();
                $gcIds[(int) $goodsinfo['gc_id_1']] = null;
                $gcIds[(int) $goodsinfo['gc_id_2']] = null;
                $gcIds[(int) $goodsinfo['gc_id_3']] = null;
                unset($gcIds[0]);
                $gcIds = array_keys($gcIds);
         // 同分类下销量排行商品
                $mrs_hot_sales = null;
                if ($gcIds) {
                    $mrs_hot_sales = Model('goods')->getGoodsOnlineList(array(
                        'gc_id' => array('in', $gcIds),
                        'goods_id' => array('neq', $goodsinfo['goods_id']),
                    ), '*', 0, 'goods_salenum desc', 6);
                }
                Tpl::output('mrs_hot_sales', $mrs_hot_sales);

        // 相关同产品咨询问题
        $where = array();
		$where['goods_id']=$consult_info['goods_id'];
        $consult_list = $model_consult->getConsultList($where, '*', 8, 0);
		
		foreach($consult_list as $k=>$v){
			$store=Model('store')->getStoreInfoByID($v['store_id']);
			$consult_list[$k]['store_domain']=$store['store_domain'];
			$consult_list[$k]['store_avatar']=$store['store_avatar'];
		}
        Tpl::output('consult_list',$consult_list);

        $seo_param = array ();
        $seo_param['name'] = $consult_info['consult_content'].'-的疑问解答';
        $seo_param['key'] = $consult_info['consult_content'];
        $seo_param['description'] = $consult_info['consult_content'];
        Model('seo')->type('product')->param($seo_param)->show();

        Tpl::output('consult_info',$consult_info);
        Tpl::showpage('consult_info');
    }
    }
