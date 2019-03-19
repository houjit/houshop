<?php
/**
 * 前台分类
 *
 *
 *
 * * 
 
 * @
  
 */



defined('INSYSVIEW') or exit('Access Invalid!');

class categoryControl extends BaseHomeControl {
    /**
     * 分类列表
     */
    public function indexFeiwa(){
        Language::read('home_category_index');
        $lang   = Language::getLangContent();
        //导航
        $nav_link = array(
            '0'=>array('title'=>$lang['homepage'],'link'=>MALL_SITE_URL),
            '1'=>array('title'=>$lang['category_index_goods_class'])
        );
        Tpl::output('nav_link_list',$nav_link);

        Tpl::output('html_title',C('site_name').' - '.Language::get('category_index_goods_class'));
        Tpl::showpage('category');
    }
}
