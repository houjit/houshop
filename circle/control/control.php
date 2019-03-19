<?php
/**
 * 圈子父类
 *
 * * 
 
 * @
 *  
 */



defined('INSYSVIEW') or exit('Access Invalid!');

/********************************** 前台control父类 **********************************************/

class BaseCircleControl{
    protected $identity = 0;    // 身份 0游客 1圈主 2管理 3成员 4申请中 5申请失败 6禁言
    protected $c_id = 0;        // 圈子id
    protected $cm_info = array();   // Members of the information
    protected $m_readperm = 0;  // Members read permissions
    protected $super = 0;
	
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
		Tpl::output('index_signs', 'circle');
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
     * 构造函数
     */
    public function __construct(){
    	
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
         * 验证圈子是否开启
         */
        if (C('circle_isuse') != '1'){
            @header('location: '.MALL_SITE_URL);die;
        }
        /**
         * 读取通用、布局的语言包
         */
        Language::read('common');
        /**
         * 设置布局文件内容
         */
        Tpl::setLayout('circle_layout');
        /**
         * 查询是否是超管
         */
        $this->checkSuper();
        /**
         * 获取导航
         */
        Tpl::output('nav_list', rkcache('nav',true));
    }
    private function checkSuper() {
        if($_SESSION['is_login']){
            $super = Model('circle_member')->getSuperInfo(array('member_id' => $_SESSION['member_id']));
            $this->super = empty($super) ? 0 : 1;
        }
        Tpl::output('super', $this->super);
    }
    /**
     * 圈子信息
     */
    protected function circleInfo(){
        $this->circle_info = Model()->table('circle')->where(array('circle_id'=>$this->c_id))->find();

        if(empty($this->circle_info)){
            showMessage(L('circle_group_not_exists'), '', '', 'error');
        }
        Tpl::output('circle_info', $this->circle_info);
    }
    /**
     * 圈主和管理信息
     */
    protected function manageList(){
        $prefix = 'circle_managelist';
        $info = rcache($this->c_id, $prefix);
        if (empty($info)) {
            $manager_list = Model()->table('circle_member')->where(array('circle_id'=>$this->c_id, 'is_identity'=>array('in', array(1,2))))->select();
            $manager_list = array_under_reset($manager_list, 'is_identity', 2);
            $manager_list[2] = array_under_reset($manager_list[2], 'member_id', 1);
            $info['info'] = serialize($manager_list);
            wcache($this->c_id, $info, $prefix, 60);
        }
        $manager_list = unserialize($info['info']);
        Tpl::output('creator', $manager_list[1][0]);
        Tpl::output('manager_list', $manager_list[2]);
    }
    /**
     * 会员信息
     */
    protected function memberInfo(){
        if($_SESSION['is_login']){
            $this->cm_info = Model()->table('circle_member')->where(array('circle_id'=>$this->c_id, 'member_id'=>$_SESSION['member_id']))->find();
            if(!empty($this->cm_info)){
                switch (intval($this->cm_info['cm_state'])){
                    case 1:
                        $this->identity = intval($this->cm_info['is_identity']);
                        break;
                    case 0:
                        $this->identity = 4;
                        break;
                    case 2:
                        $this->identity = 5;
                        break;
                }
                // 禁言
                if($this->cm_info['is_allowspeak'] == 0){
                    $this->identity = 6;
                }
            }
            Tpl::output('cm_info', $this->cm_info);
        }
        Tpl::output('identity', $this->identity);
    }
    /**
     * sidebar相关信息
     */
    protected function sidebar(){
        $prefix = 'circle_sidebar';
        $data = rcache($this->c_id, $prefix);
        if (empty($data)) {
            // 圈子所属分类
            $data['class_info'] = Model()->table('circle_class')->where(array('class_id'=>$this->circle_info['class_id']))->find();

            // 明星圈友
            $data['star_member'] = Model()->table('circle_member')->where(array('cm_state'=>1, 'circle_id'=>$this->c_id, 'is_star'=>1))->order('rand()')->limit(5)->select();

            // 最新加入
            $data['newest_member'] = Model()->table('circle_member')->where(array('cm_state'=>1, 'circle_id'=>$this->c_id))->order('cm_jointime desc')->limit(5)->select();
			
			// 热门话题
            $data['hots_themelist'] = Model()->table('circle_theme')->where(array('is_closed'=>0,'circle_id'=>$this->c_id))->order('theme_browsecount desc')->limit(10)->select();
			if(!empty($data['hots_themelist'])){
            $data['hots_themelist'] = array_under_reset($data['hots_themelist'], 'theme_id'); 
            $themeid_array = array_keys($data['hots_themelist']);
            // 附件
            $affix_list = Model()->table('circle_affix')->field('theme_id, min(affix_filethumb) affix_filethumb')->where(array('theme_id'=>array('in', $themeid_array), 'affix_type'=>1))->group('theme_id')->select();
            if(!empty($affix_list)) $affix_list = array_under_reset($affix_list, 'theme_id');
            foreach ($data['hots_themelist'] as $key=>$val){
            	if(!empty($affix_list[$val['theme_id']]['affix_filethumb'])){
					 $data['hots_themelist'][$key]['affix'] = themeImageUrl($affix_list[$val['theme_id']]['affix_filethumb']);
				}else{
					$data['hots_themelist'][$key]['affix']=themeImageUrl('default.jpg');
				}
            }

           Tpl::output('hots_themelist', $data['hots_themelist']);
        }
        
		//商品分享

        $cmid_lists  = Model()->table('circle_member')->field('member_id')->where(array('circle_id'=>$this->c_id, 'cm_state'=>1))->select();
        $cmid_lists  = array_under_reset($cmid_lists, 'member_id'); $cmid_array = array_keys($cmid_lists);
        $count      = Model()->table('sns_sharegoods')->where(array('share_memberid'=>array('in', $cmid_array)))->count();
        $goods_lists = Model()->table('sns_sharegoods,sns_goods')->join('left')->on('sns_sharegoods.share_goodsid=sns_goods.snsgoods_goodsid')
                        ->where(array('sns_sharegoods.share_memberid'=>array('in', $cmid_array), 'share_isshare|share_islike'=>1))->order('share_id desc')->limit(5)->select();
        if(!empty($goods_lists)){
            if($_SESSION['is_login'] == '1'){
                foreach ($goods_lists as $k=>$v){
                    if (!empty($v['snsgoods_likemember'])){
                        $v['snsgoods_likemember_arr'] = explode(',',$v['snsgoods_likemember']);
                        $v['snsgoods_havelike'] = in_array($_SESSION['member_id'],$v['snsgoods_likemember_arr'])?1:0;
                    }
                    $goods_lists[$k] = $v;
                }
            }
            $goods_lists = array_under_reset($goods_lists, 'share_id'); $shareid_array = array_keys($goods_lists);
            Tpl::output('goods_lists', $goods_lists);
		}

            // 友情圈子
            $data['friendship_list'] = Model()->table('circle_fs')->where(array('circle_id'=>$this->c_id, 'friendship_status'=>1))->order('friendship_sort asc')->select();
			
			foreach ($data['friendship_list'] as $k=>$v){
				$circlesinfo = Model()->table('circle')->where(array('circle_id'=>$this->c_id))->find();
                $data['friendship_list'][$k]['friendship_desc']=$circlesinfo['circle_desc'];
				$data['friendship_list'][$k]['friendship_count']=Model()->table('circle_theme')->where(array('theme_addtime'=>array('gt', $now), 'circle_id'=>$this->c_id, 'is_closed'=>0))->count();
        }

		//	foreach ($data['friendship_list'] as $val){
		//		$circlesinfo = $model->table('circle')->where(array('circle_id'=>$this->c_id))->find();
			//	$data['friendship_list']['friendship_desc']=$circlesinfo['circle_desc'];
		//	}
        }
        Tpl::output('class_info', $data['class_info']);
        Tpl::output('star_member', $data['star_member']);
        Tpl::output('newest_member', $data['newest_member']);
        Tpl::output('friendship_list', $data['friendship_list']);
    }
    /**
     * 最新话题/热门话题/人气回复
     */
    protected function themeTop(){
        $prefix = 'circle_themetop';
        $info = rcache('circle', $prefix);
        if (empty($info)) {
            $model = Model();
            // 最新话题
            $data['new_themelist'] = $model->table('circle_theme')->where(array('is_closed'=>0))->order('theme_id desc')->limit(10)->select();
            // 热门话题
            $data['hot_themelist'] = $model->table('circle_theme')->where(array('is_closed'=>0))->order('theme_browsecount desc')->limit(10)->select();
            // 人气回复
            $data['reply_themelist'] = $model->table('circle_theme')->where(array('is_closed'=>0))->order('theme_commentcount desc')->limit(10)->select();
            $info['info'] = serialize($data);
            wcache('circle', $info, $prefix, 60);
        }
        $data = unserialize($info['info']);
        Tpl::output('new_themelist', $data['new_themelist']);
        Tpl::output('hot_themelist', $data['hot_themelist']);
        Tpl::output('reply_themelist', $data['reply_themelist']);
    }
    /**
     * SEO
     */
    protected function circleSEO($title= '') {
        Tpl::output('html_title',$title.' '.C('').' - Powered by  ');
        Tpl::output('seo_keywords',C(''));
        Tpl::output('seo_description',C(''));
    }

    /**
     * Read permissions
     */
    protected function readPermissions($cm_info){
        $data = rkcache('circle_level', true);
        $rs = array();
        $rs[0] = 0;
        $rs[0] = L('circle_no_limit');
        foreach ($data as $v){
            $rs[$v['mld_id']]   = $v['mld_name'];
        }
        switch ($cm_info['is_identity']){
            case 1:
            case 2:
                $rs['255'] = L('circle_administrator');
                $this->m_readperm = 255;
                return $rs;
                break;
            case 3:
                $rs = array_slice($rs, 0, intval($cm_info['cm_level'])+1, true);
                $this->m_readperm = $cm_info['cm_level'];
                return $rs;
                break;
        }
    }
    /**
     * breadcrumb navigation
     */
    protected function breadcrumd($param = ''){
        $crumd = array(
            0=>array(
                'link'=>CIRCLE_SITE_URL,
                'title'=>L('feiwa_index')
            ),
            1=>array(
                'link'=>CIRCLE_SITE_URL.'/index.php?app=group&c_id='.$this->c_id,
                'title'=>$this->circle_info['circle_name']
            ),
        );
        if(!empty($this->theme_info)){
            $crumd[2] = array(
                'link'=>CIRCLE_SITE_URL.'/index.php?app=theme&feiwa=theme_detail&c_id='.$this->c_id.'&t_id='.$this->t_id,
                'title'=>$this->theme_info['theme_name']
            );
        }
        if(empty($param)){
            unset($crumd[(count($crumd)-1)]['link']);
        }else{
            $crumd[]['title'] = $param;
        }
        Tpl::output('breadcrumd', $crumd);
    }
}
class BaseCircleThemeControl extends BaseCircleControl{
    protected $circle_info = array();   // 圈子详细信息
    protected $t_id = 0;        // 话题id
    protected $theme_info = array();    // 话题详细信息
    protected $r_id = 0;        // 回复id
    protected $reply_info = array();    // reply info
    protected $cm_info = array();       // Members of the information
    public function __construct(){
        parent::__construct();
        Language::read('circle');

        $this->c_id = intval($_GET['c_id']);
        if($this->c_id <= 0){
            @header("location: ".CIRCLE_SITE_URL);
        }
        Tpl::output('c_id', $this->c_id);
    }

    /**
     * 话题信息
     */
    protected function themeInfo(){
        $this->t_id = intval($_GET['t_id']);
        if($this->t_id <= 0){
            @header("location: ".CIRCLE_SITE_URL);
        }
        Tpl::output('t_id', $this->t_id);

        $this->theme_info = Model()->table('circle_theme')->where(array('circle_id'=>$this->c_id, 'theme_id'=>$this->t_id))->find();
        if(empty($this->theme_info)){
            showMessage(L('circle_theme_not_exists'), '', '', 'error');
        }
        Tpl::output('theme_info', $this->theme_info);
    }
    /**
     * 验证回复
     */
    protected function checkReplySelf(){
        $this->t_id = intval($_GET['t_id']);
        if($this->t_id <= 0){
            showDialog(L('wrong_argument'));
        }
        Tpl::output('t_id', $this->t_id);

        $this->r_id = intval($_GET['r_id']);
        if($this->r_id <= 0){
            showDialog(L('wrong_argument'));
        }
        Tpl::output('r_id', $this->r_id);

        $this->reply_info = Model()->table('circle_threply')->where(array('theme_id'=>$this->t_id, 'reply_id'=>$this->r_id, 'member_id'=>$_SESSION['member_id']))->find();
        if(empty($this->reply_info)){
            showDialog(L('wrong_argument'));
        }
        Tpl::output('reply_info', $this->reply_info);
    }
    /**
     * 验证话题
     */
    protected function checkThemeSelf(){
        $this->t_id = intval($_GET['t_id']);
        if($this->t_id <= 0){
            showDialog(L('wrong_argument'));
        }
        Tpl::output('t_id', $this->t_id);

        $this->theme_info = Model()->table('circle_theme')->where(array('theme_id'=>$this->t_id, 'member_id'=>$_SESSION['member_id']))->find();
        if(empty($this->theme_info)){
            showDialog(L('wrong_argument'));
        }
        Tpl::output('theme_info', $this->theme_info);
    }
}
class BaseCircleManageControl extends BaseCircleControl{
    protected $circle_info = array();   // 圈子详细信息
    protected $t_id = 0;        // 话题id
    protected $theme_info = array();    // 话题详细信息
    protected $identity = 0;    // 身份 0游客 1圈主 2管理 3成员
    protected $cm_info = array();   // 会员信息
    public function __construct(){
        parent::__construct();
        $this->c_id = intval($_GET['c_id']);
        if($this->c_id <= 0){
            @header("location: ".CIRCLE_SITE_URL);
        }
        Tpl::output('c_id', $this->c_id);
    }
    /**
     * 圈子信息
     */
    protected function circleInfo(){
        // 圈子信息
        $this->circle_info = Model()->table('circle')->where(array('circle_id'=>$this->c_id))->find();
        if(empty($this->circle_info)) @header("location: ".CIRCLE_SITE_URL);
        Tpl::output('circle_info', $this->circle_info);
    }
    /**
     * 会员信息
     */
    protected function circleMemberInfo(){
        // 会员信息
        $this->cm_info = Model()->table('circle_member')->where(array('circle_id'=>$this->c_id, 'member_id'=>$_SESSION['member_id']))->find();
        if(!empty($this->cm_info)){
            $this->identity = $this->cm_info['is_identity'];
            Tpl::output('cm_info', $this->cm_info);
        }
        if(in_array($this->identity, array(0,3))){
            @header("location: ".CIRCLE_SITE_URL);
        }
        Tpl::output('identity', $this->identity);
    }
    /**
     * 去除圈主
     */
    protected function removeCreator($array){
        return array_diff($array, array($this->cm_info['member_id']));
    }
    /**
     * 去除圈主和管理
     */
    protected function removeManager($array){
        $where = array();
        $where['is_identity']   = array('in', array(1,2));
        $where['circle_id']     = $this->c_id;
        $cm_info = Model()->table('circle_member')->where($where)->select();
        if(empty($cm_info)){
            return $array;
        }
        foreach ($cm_info as $val){
            $array = array_diff($array, array($val['member_id']));
        }
        return $array;
    }
    /**
     * 身份验证
     */
    protected function checkIdentity($type){        // c圈主 m管理 cm圈主和管理
        $this->cm_info = Model()->table('circle_member')->where(array('circle_id'=>$this->c_id, 'member_id'=>$_SESSION['member_id']))->find();
        $identity = intval($this->cm_info['is_identity']); $sign = false;
        switch ($type){
            case 'c':
                if($identity != 1) $sign = true;
                break;
            case 'm':
                if($identity != 2) $sign = true;
                break;
            case 'cm':
                if($identity != 1 && $identity != 2) $sign = true;
                break;
            default:
                $sign = true;
                break;
        }
        if ($this->super) {
            $sign = false;
        }
        if($sign){
            return L('circle_permission_denied');
        }
    }
    /**
     * 会员加入的圈子
     */
    protected function memberJoinCircle(){
        // 所属圈子信息
        $circle_array = Model()->table('circle,circle_member')->field('circle.*,circle_member.is_identity')
                        ->join('inner')->on('circle.circle_id=circle_member.circle_id')
                        ->where(array('circle_member.member_id'=>$_SESSION['member_id']))->select();
        Tpl::output('circle_array', $circle_array);
    }
    /**
     * Top Navigation
     */
    protected  function sidebar_menu($sign, $child_sign=''){
        $menu = array(
                    'index'=>array('menu_name'=>L('circle_basic_setting'), 'menu_url'=>'index.php?app=manage&c_id='.$this->c_id),
                    'member'=>array('menu_name'=>L('circle_member_manage'), 'menu_url'=>'index.php?app=manage&feiwa=member_manage&c_id='.$this->c_id),
                    'applying'=>array('menu_name'=>L('circle_wait_apply'), 'menu_url'=>'index.php?app=manage&feiwa=applying&c_id='.$this->c_id),
                    'level'=>array('menu_name'=>L('circle_member_level'), 'menu_url'=>'index.php?app=manage_level&feiwa=level&c_id='.$this->c_id),
                    'class'=>array('menu_name'=>L('circle_tclass'), 'menu_url'=>'index.php?app=manage&feiwa=class&c_id='.$this->c_id),
                    'inform'=>array(
                                'menu_name'=>L('circle_inform'),
                                'menu_url'=>'index.php?app=manage_inform&feiwa=inform&c_id='.$this->c_id,
                                'menu_child'=>array(
                                            'untreated'=>array('name'=>L('circle_inform_untreated'), 'url'=>'index.php?app=manage_inform&feiwa=inform&c_id='.$this->c_id),
                                            'treated'=>array('name'=>L('circle_inform_treated'), 'url'=>'index.php?app=manage_inform&feiwa=inform&type=treated&c_id='.$this->c_id)
                                        ),
                            ),
                    'managerapply'=>array('menu_name'=>L('circle_mapply'), 'menu_url'=>'index.php?app=manage_mapply&c_id='.$this->c_id),
                    'friendship'=>array('menu_name'=>L('fcircle'), 'menu_url'=>'index.php?app=manage&feiwa=friendship&c_id='.$this->c_id)
                );
        if($this->identity == 2){
            unset($menu['index']);unset($menu['member']);unset($menu['level']);unset($menu['class']);unset($menu['friendship']);
            unset($menu['inform']['menu_child']['untreated']);unset($menu['managerapply']);
        }
        Tpl::output('sidebar_menu', $menu);
        Tpl::output('sidebar_sign', $sign);
        Tpl::output('sidebar_child_sign', $child_sign);
    }
}
class BaseCirclePersonalControl extends BaseCircleControl{
    protected  $m_id = 0;   // memeber ID
    public function __construct(){
        parent::__construct();
        if(!$_SESSION['is_login']){
            @header("location: ".CIRCLE_SITE_URL);
        }
        $this->m_id = $_SESSION['member_id'];

        // member information
        $this->circleMemberInfo();
    }
    /**
     * member information
     */
    protected function circleMemberInfo(){
        // member information list
        $circlemember_list = Model()->table('circle_member')->where(array('member_id'=>$this->m_id))->select();

        $data = array();
        $data['cm_thcount']     = 0;
        $data['cm_comcount']    = 0;
        $data['member_id']      = $_SESSION['member_id'];
        $data['member_name']    = $_SESSION['member_name'];
        if(!empty($circlemember_list)){
            foreach ($circlemember_list as $val){
                $data['cm_thcount']     += $val['cm_thcount'];
                $data['cm_comcount']    += $val['cm_comcount'];
            }
        }
        Tpl::output('cm_info', $data);
    }

}
