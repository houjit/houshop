<?php
/**
 * 前台control父类,店铺control父类,会员control父类
 *
 * * 
 *
 * 
 *  
 */



defined('INSYSVIEW') or exit('Access Invalid!');

/********************************** 前台control父类 **********************************************/

class READSControl{
	 /**
     * 检查短消息数量
     *
     */
    protected function checkMessage() {
        if($_SESSION['member_id'] == '') return ;
        //判断cookie是否存在
        $cookie_name = 'msgnewnum'.$_SESSION['member_id'];
        if (cookie($cookie_name) != null){
            $countnum = intval(cookie($cookie_name));
        }else {
            $message_model = Model('message');
            $countnum = $message_model->countNewMessage($_SESSION['member_id']);
            setNcCookie($cookie_name,"$countnum",2*3600);//保存2小时
        }
        Tpl::output('message_num',$countnum);
    }

    /**
     *  输出头部的公用信息
     *
     */
    protected function showLayout() {
        $this->checkMessage();//短消息检查
        $this->article();//文章输出

        $this->showCartCount();

        //热门搜索
        Tpl::output('hot_search',@explode(',',C('hot_search')));
        if (C('rec_search') != '') {
            $rec_search_list = @unserialize(C('rec_search'));
        }
        Tpl::output('rec_search_list',is_array($rec_search_list) ? $rec_search_list : array());
		
		//城市切换
		 if (C('feiwa_city') != '') {
            $citys_list = @unserialize(C('feiwa_city'));
        }
        Tpl::output('citys_list',is_array($citys_list) ? $citys_list : array());
        
        //历史搜索
        if (cookie('his_sh') != '') {
            $his_search_list = explode('~', cookie('his_sh'));
        }
        Tpl::output('his_search_list',is_array($his_search_list) ? $his_search_list : array());

        $model_class = Model('goods_class');
        $goods_class = $model_class->get_all_category();
        Tpl::output('show_goods_class',$goods_class);//商品分类

        //获取导航
        Tpl::output('nav_list', rkcache('nav',true));
		Tpl::output('index_signs', 'reads');
        //查询保障服务项目
        Tpl::output('contract_list',Model('contract')->getContractItemByCache());
    }

    /**
     * 显示购物车数量
     */
    protected function showCartCount() {
        if (cookie('cart_goods_num') != null){
            $cart_num = intval(cookie('cart_goods_num'));
        }else {
            //已登录状态，存入数据库,未登录时，优先存入缓存，否则存入COOKIE
            if($_SESSION['member_id']) {
                $save_type = 'db';
            } else {
                $save_type = 'cookie';
            }
            $cart_num = Model('cart')->getCartNum($save_type,array('buyer_id'=>$_SESSION['member_id']));//查询购物车商品种类
        }
        Tpl::output('cart_goods_num',$cart_num);
    }
    
    /**
     * 系统公告
     */
    protected function system_notice() {
        $model_message  = Model('article');
        $condition = array();
        $condition['ac_id'] = 1;
        $condition['article_position_in'] = ARTICLE_POSIT_ALL.','.ARTICLE_POSIT_BUYER;
        $condition['limit'] = 5;
        $article_list  = $model_message->getArticleList($condition);
        Tpl::output('system_notice',$article_list);
    }

    /**
     * 输出会员等级
     * @param bool $is_return 是否返回会员信息，返回为true，输出会员信息为false
     */
    protected function getMemberAndGradeInfo($is_return = false){
        $member_info = array();
        //会员详情及会员级别处理
        if($_SESSION['member_id']) {
            $model_member = Model('member');
            $member_info = $model_member->getMemberInfoByID($_SESSION['member_id']);
            if ($member_info){
                $member_gradeinfo = $model_member->getOneMemberGrade(intval($member_info['member_exppoints']));
                $member_info = array_merge($member_info,$member_gradeinfo);
                $member_info['voucher_count'] = Model('voucher')->getCurrentAvailableVoucherCount($_SESSION['member_id']);
                $member_info['redpacket_count'] = Model('redpacket')->getCurrentAvailableRedpacketCount($_SESSION['member_id']);
                $member_info['security_level'] = $model_member->getMemberSecurityLevel($member_info);
            }
        }
        if ($is_return == true){//返回会员信息
            return $member_info;
        } else {//输出会员信息
            Tpl::output('member_info',$member_info);
        }
    }

    /**
     * 验证会员是否登录
     *
     */
    protected function checkLogin(){
        if ($_SESSION['is_login'] !== '1'){
            $ref_url = request_uri();
            if ($_GET['inajax']){
                showDialog('','','js',"login_dialog();",200);
            }else {
                @header("location: " . urlLogin('login', 'index', array('ref_url' => $ref_url)));
            }
            exit;
        }
    }

    //文章输出
    protected function article() {

        if (C('cache_open')) {
            if ($article = rkcache("index/article")) {
                Tpl::output('show_articles', $article['show_article']);
                Tpl::output('article_lists', $article['article_list']);
                return;
            }
        } else {
            if (file_exists(BASE_DATA_PATH.'/cache/index/article.php')){
                include(BASE_DATA_PATH.'/cache/index/article.php');
                Tpl::output('show_articles', $show_article);
                Tpl::output('article_lists', $article_list);
                return;
            }
        }

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
            'show_articles' => $show_article,
            'article_lists' => $article_list,
            ));
        } else {
            $string = "<?php\n\$show_articles=".var_export($show_article,true).";\n";
            $string .= "\$article_lists=".var_export($article_list,true).";\n?>";
            file_put_contents(BASE_DATA_PATH.'/cache/index/article.php',($string));
        }

        Tpl::output('show_articles',$show_article);
        Tpl::output('article_lists',$article_list);
    }
    
    /**
     * 自动登录
     */ 
    protected function auto_login() {
        $data = cookie('auto_login');
        if (empty($data)) {
            return false;
        }
        $model_member = Model('member');
        if ($_SESSION['is_login']) {
            $model_member->auto_login();
        }
        $member_id = intval(decrypt($data, MD5_KEY));
        if ($member_id <= 0) {
            return false;
        }
        $member_info = $model_member->getMemberInfoByID($member_id);
        $model_member->createSession($member_info);
    }

    //文章状态草稿箱
    const ARTICLE_STATE_DRAFT = 1;
    //文章状态待审核
    const ARTICLE_STATE_VERIFY = 2;
    //文章状态已发布
    const ARTICLE_STATE_PUBLISHED = 3;
    //文章状态回收站
    const ARTICLE_STATE_RECYCLE = 4;
    //推荐
    const COMMEND_FLAG_TRUE = 1;
    //文章评论类型
    const ARTICLE = 1;
    const PICTURE = 2;
    //用户中心文章列表页
    const READS_MEMBER_ARTICLE_URL = 'index.php?app=member_article&feiwa=article_list';
    const READS_MEMBER_PICTURE_URL = 'index.php?app=member_picture&feiwa=picture_list';

    protected $publisher_name = '';
    protected $publisher_id = 0;
    protected $publisher_type = 0;
    protected $attachment_path = '';
    protected $publish_state;


    /**
     * 构造函数
     */
    public function __construct(){
        /**
         * 资讯开关判断
         */
        if(intval(C('reads_isuse')) !== 1) {
            header('location: '.MALL_SITE_URL);die;
        }
        /**
         * 读取通用、布局的语言包
         */
        Language::read('common');
        Language::read('reads');
        /**
         * 设置布局文件内容
         */
        Tpl::setLayout('reads_layout');
        /**
         * 转码
         */
        if ($_GET['column'] && strtoupper(CHARSET) == 'GBK'){
            $_GET = Language::getGBK($_GET);
        }
		
				//输出头部的公用信息
        $this->showLayout();
		
		 //获得会员信息
        $this->member_info = $this->getMemberAndGradeInfo(true);
        Tpl::output('member_info', $this->member_info);

		
		// 系统消息
        $this->system_notice();
        /**
         * 文章
         */
        $this->article();
		
        /**
         * 获取导航
         */
        Tpl::output('nav_list', rkcache('nav',true));

        /**
         * 系统状态检查
         */
        if(!C('site_status')) halt(C('closed_reason'));

        /**
         * seo
         */
        Tpl::output('html_title',C('').'-'.C('site_name').' - Powered by ');
        Tpl::output('seo_keywords',C(''));
        Tpl::output('seo_description',C(''));


        /**
         * 判断是不是管理员
         */
        if(!empty($_SESSION['member_name'])) {
            $this->publisher_name = $_SESSION['member_name'];
            $this->publisher_id = $_SESSION['member_id'];
            //早期有后台管理员直接发布功能，由于权限判断过于复杂现在已经取消，目前为固定值1
            $this->publisher_type = 1;
            $this->publisher_avatar = $_SESSION['avatar'];
            $this->attachment_path = $_SESSION['member_id'];
        }

        //发布状态，管理员直接发布，投稿如果后台开启审核未待审核状态
        if(intval(C('reads_submit_verify_flag')) === 1) {
            $this->publish_state = self::ARTICLE_STATE_VERIFY;
        } else {
            $this->publish_state = self::ARTICLE_STATE_PUBLISHED;
        }

    }

    protected function check_login() {
        if(!isset($_SESSION['is_login'])) {
            $ref_url = READS_SITE_URL.request_uri();
            @header("location: " . urlLogin('login', 'index', array('ref_url' => getRefUrl())));die;
        }
    }

    /**
     * 获取文章状态列表
     */
    protected function get_article_state_list() {
        $array = array();
        $array[self::ARTICLE_STATE_DRAFT] = Language::get('reads_text_draft');
        $array[self::ARTICLE_STATE_VERIFY] = Language::get('reads_text_verify');
        $array[self::ARTICLE_STATE_PUBLISHED] = Language::get('reads_text_published');
        $array[self::ARTICLE_STATE_RECYCLE] = Language::get('reads_text_recycle');
        return $array;
    }

    /**
     * 获取文章相关文章
     */
    protected function get_article_link_list($article_link) {
        $article_link_list = array();
        if(!empty($article_link)) {
            $model_article = Model('reads_article');
            $condition = array();
            $condition['article_id'] = array('in',$article_link);
            $condition['article_state'] = self::ARTICLE_STATE_PUBLISHED;
            $article_link_list = $model_article->getList($condition , NULL, 'article_id desc');
        }
        return $article_link_list;
    }

    /**
     * 返回json状态
     */
    protected function return_json($message,$result='true') {
        $data = array();
        $data['result'] = $result;
        $data['message'] = $message;
        self::echo_json($data);
    }

    protected function echo_json($data) {
        if (strtoupper(CHARSET) == 'GBK'){
            $data = Language::getUTF8($data);//网站GBK使用编码时,转换为UTF-8,防止json输出汉字问题
        }
        echo json_encode($data);die;
    }

    /**
     * 获取主域名
     */
    protected function get_url_domain($url) {
        $url_parse_array = parse_url($url);
        $host = $url_parse_array['host'];
        $host_names = explode(".", $host);
        $bottom_host_name = $host_names[count($host_names)-2] . "." . $host_names[count($host_names)-1];
        return $bottom_host_name;
    }

    //获得分享列表
    protected function get_share_app_list() {
        $app_mall = array();
        $app_array = array();
        if (C('share_isuse') == 1 && isset($_SESSION['member_id'])){
            //站外分享接口
            $model = Model('sns_binding');
            $app_array = $model->getUsableApp($_SESSION['member_id']);
        }
        Tpl::output('app_arr',$app_array);
    }

    protected function share_app_publish($publish_info=array()) {
        $param = array();
        $param['comment'] = "'".$_SESSION['member_name']."'".Language::get('reads_text_zai').C('reads_seo_title').Language::get('share_article');
        $param['title'] = "'".$_SESSION['member_name']."'".Language::get('reads_text_zai').C('reads_seo_title').Language::get('share_article');
        $param['url'] = $publish_info['url'];
        $param['title'] = $publish_info['share_title'];
        $param['image'] = $publish_info['share_image'];
        $param['content'] = self::get_share_app_content($param);
        $param['images'] = '';

        //分享应用
        $app_items = array();
        foreach ($_POST['share_app_items'] as $val) {
            if($val != '') {
                $app_items[$val] = TRUE;
            }
        }

        if (C('share_isuse') == 1 && !empty($app_items)){
            $model = Model('sns_binding');
            //查询该用户的绑定信息
            $bind_list = $model->getUsableApp($_SESSION['member_id']);
            //商城
            if (isset($app_items['mall'])){

                $model_member = Model('member');
                $member_info = $model_member->getMemberInfoByID($_SESSION['member_id']);

                $tracelog_model = Model('sns_tracelog');
                $insert_arr = array();
                $insert_arr['trace_originalid'] = '0';
                $insert_arr['trace_originalmemberid'] = '0';
                $insert_arr['trace_memberid'] = $_SESSION['member_id'];
                $insert_arr['trace_membername'] = $_SESSION['member_name'];
                $insert_arr['trace_memberavatar'] = $member_info['member_avatar'];
                $insert_arr['trace_title'] = $publish_info['commend_message'];
                $insert_arr['trace_content'] = $param['content'];
                $insert_arr['trace_addtime'] = time();
                $insert_arr['trace_state'] = '0';
                $insert_arr['trace_privacy'] = 0;
                $insert_arr['trace_commentcount'] = 0;
                $insert_arr['trace_copycount'] = 0;
                $insert_arr['trace_from'] = '4';
                $result = $tracelog_model->tracelogAdd($insert_arr);

            }
            //腾讯微博
            if (isset($app_items['qqweibo']) && $bind_list['qqweibo']['isbind'] == true){
                $model->addQQWeiboPic($bind_list['qqweibo'],$param);
            }
            //新浪微博
            if (isset($app_items['sinaweibo']) && $bind_list['sinaweibo']['isbind'] == true){
                $model->addSinaWeiboUpload($bind_list['sinaweibo'],$param);
            }
        }
    }

    //资讯sns内容结构
    protected function get_share_app_content($info) {
        $content_str = "
            <div class='fd-media'>
            <div class='goodsimg'><a target=\"_blank\" href=\"{$info['url']}\"><img src=\"".$info['image']."\" onload=\"javascript:DrawImage(this,120,120);\"></a></div>
            <div class='goodsinfo'>
            <dl>
            <dt><a target=\"_blank\" href=\"{$info['url']}\">{$info['title']}</a></dt>
            <dd>{$info['comment']}<a target=\"_blank\" href=\"{$info['url']}\">".Language::get('feiwa_common_goto')."</a></dd>
            </dl>
            </div>
            </div>
            ";
        return $content_str;
    }

}

class READSHomeControl extends READSControl{

    public function __construct() {
        parent::__construct();
        $model_navigation = Model('reads_navigation');
        $navigation_list = $model_navigation->getList(TRUE, null, 'navigation_sort asc');
        Tpl::output('navigation_list', $navigation_list);

        $model_article_class = Model('reads_article_class');
        $article_class_list = $model_article_class->getList(TRUE, null, 'class_sort asc');
        $article_class_list = array_under_reset($article_class_list, 'class_id');
        Tpl::output('article_class_list', $article_class_list);


        $model_picture_class = Model('reads_picture_class');
        $picture_class_list = $model_picture_class->getList(TRUE, null, 'class_sort asc');
        $picture_class_list = array_under_reset($picture_class_list, 'class_id');
        Tpl::output('picture_class_list', $picture_class_list);

        Tpl::output('index_sign','index');
        Tpl::output('top_function_block',TRUE);
    }

    /**
     * 推荐文章
     */
    protected function get_article_comment() {

        $model_article = Model('reads_article');
        $condition = array();
        $condition['article_commend_flag'] = 1;
        $article_commend_list = $model_article->getListWithClassName($condition, NULL, 'article_id desc', '*', 9);
        Tpl::output('article_commend_list', $article_commend_list);

    }

}

class READSMemberControl extends READSControl{

    public function __construct() {
        parent::__construct();
        if(empty($this->publisher_name)) {
            @header('Location: index.php');die;
        }

        //发布人信息
        Tpl::output('publisher_info', array('name'=>$this->publisher_name,
                                            'id'=>$this->publisher_id,
                                            'type'=>$this->publisher_type,
                                            'avatar'=>$this->publisher_avatar,
                                        )
        );
    }

    protected function check_article_auth($article_id) {
        if($article_id > 0) {
            $model_article = Model('reads_article');
            $article_detail = $model_article->getOne(array('article_id'=>$article_id));
            if(!empty($article_detail)) {
                if($article_detail['article_publisher_id'] == $this->publisher_id) {
                    return $article_detail;
                }
            }
        }
        return FALSE;
    }

    protected function check_picture_auth($picture_id) {
        if($picture_id > 0) {
            $model_picture = Model('reads_picture');
            $picture_detail = $model_picture->getOne(array('picture_id'=>$picture_id));
            if(!empty($picture_detail)) {
                if($picture_detail['picture_publisher_id'] == $this->publisher_id) {
                    return $picture_detail;
                }
            }
        }
        return FALSE;
    }

    /**
     * 删除图片
     */
    protected function drop_image($attachment_path, $image_name) {
        $image = BASE_UPLOAD_PATH.DS.ATTACH_READS.DS.$attachment_path.DS.$image_name;
        if(is_file($image)) {
            unlink($image);
        }
    }


}
