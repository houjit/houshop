<?php
/**
 * 资讯首页
 *
 *
 *
 * 
 *
 * @link       #
 * @since      File available since Release v1.1
 */



defined('INSYSVIEW') or exit('Access Invalid!');
class indexControl extends mobileHomeControl{

    public function __construct() {
        parent::__construct();
    }

    /**
     * 首页
     */
    public function indexFeiwa() {
        $model_mb_special = Model('mb_special');
        $data = $model_mb_special->getMbSpecialIndex();
        $this->_output_special($data, $_GET['type']);
    }
	
	/**
	 * 调用公告
	 */
	 
	 public function getggFeiwa(){
	 	
        $model_article_class    = Model('article_class');
        $model_article  = Model('article');
        $show_article = array();//商城公告
        $article_list   = array();//下方文章
        $notice_class   = array('notice');
        $code_array = array('member','payment','sold','service','about');
        $notice_limit   = 5;
        $faq_limit  = 5;

        $class_condition    = array();
        $class_condition['home_index'] = 'home_index';
        $class_condition['order'] = 'ac_sort asc';
        $article_class  = $model_article_class->getClassList($class_condition);
        $class_list = array();
        if(!empty($article_class) && is_array($article_class)){
            foreach ($article_class as $key => $val){
                $ac_code = $val['ac_code'];
                $ac_id = $val['ac_id'];
                $val['list']    = array();//文章
                $class_list[$ac_id] = $val;
            }
        }

        $condition  = array();
        $condition['article_show'] = '1';
        $condition['field'] = 'article.article_id,article.ac_id,article.article_url,article_class.ac_code,article.article_position,article.article_title,article.article_time,article_class.ac_name,article_class.ac_parent_id';
        $condition['order'] = 'article_sort asc,article_time desc';
        $condition['limit'] = '300';
        $article_array  = $model_article->getJoinList($condition);
        if(!empty($article_array) && is_array($article_array)){
            foreach ($article_array as $key => $val){
                if ($val['ac_code'] == 'notice' && !in_array($val['article_position'],array(ARTICLE_POSIT_MALL,ARTICLE_POSIT_ALL))) continue;
                $ac_id = $val['ac_id'];
                $ac_parent_id = $val['ac_parent_id'];
                if($ac_parent_id == 0) {//顶级分类
                    $class_list[$ac_id]['list'][] = $val;
                } else {
                    $class_list[$ac_parent_id]['list'][] = $val;
                }
            }
        }
        if(!empty($class_list) && is_array($class_list)){
            foreach ($class_list as $key => $val){
                $ac_code = $val['ac_code'];
                if(in_array($ac_code,$notice_class)) {
                    $list = $val['list'];
                    array_splice($list, $notice_limit);
                    $val['list'] = $list;
                    $show_article[$ac_code] = $val;
                }
                if (in_array($ac_code,$code_array)){
                    $list = $val['list'];
                    $val['class']['ac_name']    = $val['ac_name'];
                    array_splice($list, $faq_limit);
                    $val['list'] = $list;
                    $article_list[] = $val;
                }
            }
        }
        if (C('cache_open')) {
            wkcache('index/article', array(
                'show_article' => $show_article,
                'article_list' => $article_list,
            ));
        } else {
            $string = "<?php\n\$show_article=".var_export($show_article,true).";\n";
            $string .= "\$article_list=".var_export($article_list,true).";\n?>";
            file_put_contents(BASE_DATA_PATH.'/cache/index/article.php',($string));
        }
        output_data($show_article);

	 	
	 }

    /**
     * 单篇文章显示页面
     */
    public function reads_showFeiwa(){
         $article_id = intval($_GET['article_id']);
		 
        if(empty($article_id)){
            output_error('缺少参数，文章编号不对');
        }
        /**
         * 根据文章编号获取文章信息
         */
        $article_model  = Model('article');
        $article    = $article_model->getOneArticle($article_id);
        if(empty($article) || !is_array($article) || $article['article_show']=='0'){
        	 output_error('文章不存在');
        }
         output_data($article);
	}

    /**
     * 专题
     */
    public function specialFeiwa() {
        $model_mb_special = Model('mb_special');
        $info = $model_mb_special->getMbSpecialInfoByID($_GET['special_id']);
        $list = $model_mb_special->getMbSpecialItemUsableListByID($_GET['special_id']);
        $data = array_merge($info, array('list' => $list));
        $this->_output_special($data, $_GET['type'], $_GET['special_id']);
    }

    /**
     * 输出专题
     */
    private function _output_special($data, $type = 'json', $special_id = 0) {
        $model_special = Model('mb_special');
        if($_GET['type'] == 'html') {
            $html_path = $model_special->getMbSpecialHtmlPath($special_id);
            if(!is_file($html_path)) {
                ob_start();
                Tpl::output('list', $data);
                Tpl::showpage('mb_special');
                file_put_contents($html_path, ob_get_clean());
            }
            header('Location: ' . $model_special->getMbSpecialHtmlUrl($special_id));
            die;
        } else {
            output_data($data);
        }
    }

    /**
     * android客户端版本号
     */
    public function apk_versionFeiwa() {
        $version = C('mobile_apk_version');
        $url = C('mobile_apk');
        if(empty($version)) {
           $version = '';
        }
        if(empty($url)) {
            $url = '';
        }

        output_data(array('version' => $version, 'url' => $url));
    }

    /**
     * 默认搜索词列表
     */
    public function search_key_listFeiwa() {
        $list = @explode(',',C('hot_search'));
        if (!$list || !is_array($list)) { 
            $list = array();
        }
        if ($_COOKIE['hisSearch'] != '') {
            $his_search_list = explode('~', $_COOKIE['hisSearch']);
        }
        if (!$his_search_list || !is_array($his_search_list)) {
            $his_search_list = array();
        }
        output_data(array('list'=>$list,'his_list'=>$his_search_list));
    }

    /**
     * 热门搜索列表
     */
    public function search_hot_infoFeiwa() {
        if (C('rec_search') != '') {
            $rec_search_list = @unserialize(C('rec_search'));
        }
        $rec_search_list = is_array($rec_search_list) ? $rec_search_list : array();
        $result = $rec_search_list[array_rand($rec_search_list)];
        output_data(array('hot_info'=>$result ? $result : array()));
    }

    /**
     * 高级搜索
     */
    public function search_advFeiwa() {
        $area_list = Model('area')->getAreaList(array('area_deep'=>1),'area_id,area_name');
        if (C('contract_allow') == 1) {
            $contract_list = Model('contract')->getContractItemByCache();
            $_tmp = array();$i = 0;
            foreach ($contract_list as $k => $v) {
                $_tmp[$i]['id'] = $v['cti_id'];
                $_tmp[$i]['name'] = $v['cti_name'];
                $i++;
            }
        }
        output_data(array('area_list'=>$area_list ? $area_list : array(),'contract_list'=>$_tmp));
    }
    public function site_name(){
        $site_name = C('site_name');
        output_data(array('site_name' => $site_name, 'url' => $url));
    }

}
