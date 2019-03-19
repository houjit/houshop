<?php
/**
 * 入口文件
 */
require 'version.php';//版本号
error_reporting(E_ALL & ~E_NOTICE);
define('BASE_ROOT_PATH',str_replace('\\','/',dirname(__FILE__)));
define('BASE_CORE_PATH',BASE_ROOT_PATH.'/core');
define('BASE_DATA_PATH',BASE_ROOT_PATH.'/data');
define("BASE_UPLOAD_PATH", BASE_ROOT_PATH . "/data/upload");
define("BASE_RESOURCE_PATH", BASE_ROOT_PATH . "/data/resource");

/**
 * 安装判断
 */
if (!is_file(BASE_ROOT_PATH."/mall/install/lock") && is_file(BASE_ROOT_PATH."/mall/install/index.php")){
    if (ProjectName != 'mall'){
        @header("location: ../mall/install/index.php");
    }else{
        @header("location: install/index.php");
    }
    exit;
}

/**
 * 初始化
 */
define('DS','/');
define('INSYSVIEW',true);
define('StartTime',microtime(true));
define('TIMESTAMP',time());
define('DIR_MALL','mall');
define('DIR_MBMBER','member');
define('DIR_READS','reads');
define('DIR_CB','cb');
define('DIR_CIRCLE','circle');
define('DIR_SHARESHOW','shareshow');
define('DIR_ADMIN','admin');
define('DIR_API','api');
define('DIR_MOBILE','mobile');
define('DIR_WAP','wap');
define('DIR_RESOURCE','data/resource');
define('DIR_UPLOAD','data/upload');

define('ATTACH_PATH','mall');
define('ATTACH_COMMON','mall/common');
define('ATTACH_AVATAR','mall/avatar');
define('ATTACH_EDITOR','mall/editor');
define('ATTACH_MEMBERTAG','mall/membertag');
define('ATTACH_STORE','mall/store');
define('ATTACH_GOODS','mall/store/goods');
define('ATTACH_STORE_DECORATION','mall/store/decoration');
define('ATTACH_LOGIN','mall/login');
define('ATTACH_ARTICLE','mall/article');
define('ATTACH_BRAND','mall/brand');
define('ATTACH_GOODS_CLASS','mall/goods_class');
define('ATTACH_ADV','mall/adv');
define('ATTACH_activity','mall/activity');
define('ATTACH_WATERMARK','mall/watermark');
define('ATTACH_POINTPROD','mall/pointprod');
define('ATTACH_GROUPBUY','mall/groupbuy');
define('ATTACH_TTM','mall/ttm');
define('ATTACH_SLIDE','mall/store/slide');
define('ATTACH_VOUCHER','mall/voucher');
define('ATTACH_REDPACKET','mall/redpacket');
define('ATTACH_STORE_JOININ','mall/store_joinin');
define('ATTACH_REC_POSITION','mall/rec_position');
define('ATTACH_CONTRACTICON','mall/contracticon');
define('ATTACH_CONTRACTPAY','mall/contractpay');
define('ATTACH_WAYBILL','mall/waybill');
define('ATTACH_MOBILE','mobile');
define('ATTACH_CIRCLE','circle');
define('ATTACH_READS','reads');
define('ATTACH_CB','cb');
define('ATTACH_LIVE','live');
define('ATTACH_MALBUM','mall/member');
define('ATTACH_SHARESHOW','shareshow');
define('ATTACH_DELIVERY','delivery');
define('ATTACH_CHAIN', 'chain');
define('ATTACH_ADMIN_AVATAR','admin/avatar');
define('TPL_MALL_NAME','default');
define('TPL_CIRCLE_NAME', 'default');
define('TPL_SHARESHOW_NAME', 'default');
define('TPL_READS_NAME', 'default');
define('TPL_CB_NAME', 'default');
define('TPL_ADMIN_NAME', 'default');
define('TPL_DELIVERY_NAME', 'default');
define('TPL_CHAIN_NAME', 'default');
define('TPL_MEMBER_NAME', 'default');
define('ADMIN_MODULES_SYSTEM', 'modules/system');
define('ADMIN_MODULES_MALL', 'modules/mall');
define('ADMIN_MODULES_READS', 'modules/reads');
define('ADMIN_MODULES_CIECLE', 'modules/circle');
define('ADMIN_MODULES_FEIWA', 'modules/feiwa');
define('ADMIN_MODULES_MICEOMALL', 'modules/shareshow');
define('ADMIN_MODULES_MOBILE', 'modules/mobile');
/*
 * 商家入驻状态定义
 */
//新申请
define('STORE_JOIN_STATE_NEW', 10);
//完成付款
define('STORE_JOIN_STATE_PAY', 11);
//初审成功
define('STORE_JOIN_STATE_VERIFY_SUCCESS', 20);
//初审失败
define('STORE_JOIN_STATE_VERIFY_FAIL', 30);
//付款审核失败
define('STORE_JOIN_STATE_PAY_FAIL', 31);
//开店成功
define('STORE_JOIN_STATE_FINAL', 40);

//默认颜色规格id(前台显示图片的规格)
define('DEFAULT_SPEC_COLOR_ID', 1);


/**
 * 商品图片
 */
define('GOODS_IMAGES_WIDTH', '60,240,360,1280');
define('GOODS_IMAGES_HEIGHT', '60,240,360,12800');
define('GOODS_IMAGES_EXT', '_60,_240,_360,_1280');

/**
 *  订单状态
 */
//已取消
define('ORDER_STATE_CANCEL', 0);
//已产生但未支付
define('ORDER_STATE_NEW', 10);
//已支付
define('ORDER_STATE_PAY', 20);
//已发货
define('ORDER_STATE_SEND', 30);
//已收货，交易成功
define('ORDER_STATE_SUCCESS', 40);
//订单超过N小时未支付自动取消
define('ORDER_AUTO_CANCEL_TIME', 1);
//订单超过N天未收货自动收货
define('ORDER_AUTO_RECEIVE_DAY', 10);

//预订尾款支付期限(小时)
define('BOOK_AUTO_END_TIME', 72);

//门店支付订单支付提货期限(天)
define('CHAIN_ORDER_PAYPUT_DAY', 7);
/**
 * 订单删除状态
 */
//默认未删除
define('ORDER_DEL_STATE_DEFAULT', 0);
//已删除
define('ORDER_DEL_STATE_DELETE', 1);
//彻底删除
define('ORDER_DEL_STATE_DROP', 2);

/**
 * 文章显示位置状态,1默认网站前台,2买家,3卖家,4全站
 * @var unknown
 */
define('ARTICLE_POSIT_MALL', 1);
define('ARTICLE_POSIT_BUYER', 2);
define('ARTICLE_POSIT_SELLER', 3);
define('ARTICLE_POSIT_ALL', 4);

//兑换码过期后可退款时间，15天
define('CODE_INVALID_REFUND', 15);
/**
 * 初始化
 */
if($_GET['app']=='seccode'|| $_GET['feiwa']=='qrcode'){
	//print_r($_GET);
}else{
    //包含config/config.ini.php文件验证不能使用
    if (!@include(BASE_DATA_PATH.'/config/config.ini.php')) exit('config.ini.php isn\'t exists!');
    if (file_exists(BASE_PATH.'/config/config.ini.php')){
        include(BASE_PATH.'/config/config.ini.php');
    }
    global $config;
}
//默认平台店铺id
define('DEFAULT_PLATFORM_STORE_ID', $config['default_store_id']);

define('URL_MODEL',$config['url_model']);
//$auto_site_url = strtolower('http://'.$_SERVER['HTTP_HOST'].implode('/',$tmp_array));
define(SUBDOMAIN_SUFFIX, $config['subdomain_suffix']);
define('BASE_SITE_URL', $config['base_site_url']);
define('MALL_SITE_URL', $config['mall_site_url']);
define('READS_SITE_URL', $config['reads_site_url']);
define('READS_modules_URL', $config['reads_modules_url']);
define('CIRCLE_SITE_URL', $config['circle_site_url']);
define('CIRCLE_modules_URL', $config['circle_modules_url']);
define('SHARESHOW_SITE_URL', $config['shareshow_site_url']);
define('SHARESHOW_modules_URL', $config['shareshow_modules_url']);
define('ADMIN_SITE_URL', $config['admin_site_url']);
define('ADMIN_modules_URL', $config['admin_modules_url']);
define('MOBILE_SITE_URL', $config['mobile_site_url']);
define('MOBILE_modules_URL', $config['mobile_modules_url']);
define('WAP_SITE_URL', $config['wap_site_url']);
define('UPLOAD_SITE_URL',$config['upload_site_url']);
define('RESOURCE_SITE_URL',$config['resource_site_url']);
define('DELIVERY_SITE_URL',$config['delivery_site_url']);
define('LOGIN_SITE_URL',$config['member_site_url']);
define('BASE_DATA_PATH',BASE_ROOT_PATH.'/data');
define('BASE_UPLOAD_PATH',BASE_DATA_PATH.'/upload');
define('BASE_RESOURCE_PATH',BASE_DATA_PATH.'/resource');
define('RESOURCE_SITE_URL_HTTPS',$config['resource_site_url']);
define('CHAIN_SITE_URL', $config['chain_site_url']);
define('MEMBER_SITE_URL', $config['member_site_url']);
define('LOGIN_RESOURCE_SITE_URL',MEMBER_SITE_URL.'/resource');
define('UPLOAD_SITE_URL_HTTPS', $config['upload_site_url']);
define('CHAT_SITE_URL', $config['chat_site_url']);
define('NODE_SITE_URL', $config['node_site_url']);


define('CHARSET',$config['db'][1]['dbcharset']);
define('DBDRIVER',$config['dbdriver']);
define('SESSION_EXPIRE',$config['session_expire']);
define('LANG_TYPE',$config['lang_type']);
define('COOKIE_PRE',$config['cookie_pre']);

define('DBPRE',$config['tablepre']);
define('DBNAME',$config['db'][1]['dbname']);
$_GET['app'] = is_string($_GET['app']) ? strtolower($_GET['app']) : (is_string($_POST['app']) ? strtolower($_POST['app']) : null);
$_GET['feiwa'] = is_string($_GET['feiwa']) ? strtolower($_GET['feiwa']) : (is_string($_POST['feiwa']) ? strtolower($_POST['feiwa']) : null);

if (empty($_GET['app'])){
    require_once(BASE_CORE_PATH.'/framework/core/route.php');
    new Route($config);
}
//统一action
$_GET['app'] = preg_match('/^[\w]+$/i',$_GET['app']) ? $_GET['app'] : 'index';
$_GET['feiwa'] = preg_match('/^[\w]+$/i',$_GET['feiwa']) ? $_GET['feiwa'] : 'index';

//对GET POST接收内容进行过滤,$ignore内的下标不被过滤
$ignore = array('article_content','pgoods_body','doc_content','content','sn_content','g_body','store_description','p_content','xianshi_intro','groupbuy_intro','remind_content','note_content','adv_pic_url','adv_word_url','adv_slide_url','appcode','mail_content', 'message_content','member_gradedesc');
if (!class_exists('Security')) require(BASE_CORE_PATH.'/framework/libraries/security.php');
$_GET = !empty($_GET) ? Security::getAddslashesForInput($_GET,$ignore) : array();
$_POST = !empty($_POST) ? Security::getAddslashesForInput($_POST,$ignore) : array();
$_REQUEST = !empty($_REQUEST) ? Security::getAddslashesForInput($_REQUEST,$ignore) : array();
$_SERVER = !empty($_SERVER) ? Security::getAddSlashes($_SERVER) : array();
//启用ZIP压缩
if ($config['gzip'] == 1 && function_exists('ob_gzhandler') && $_GET['inajax'] != 1){
	ob_start('ob_gzhandler');
}else {
	ob_start();
}

require_once(BASE_CORE_PATH.'/framework/libraries/queue.php');
require_once(BASE_CORE_PATH.'/framework/function/core.php');
require_once(BASE_CORE_PATH.'/framework/core/base.php');

require_once(BASE_CORE_PATH.'/framework/function/goods.php');

if(function_exists('spl_autoload_register')) {
	spl_autoload_register(array('Base', 'autoload'));
} else {
	function __autoload($class) {
		return Base::autoload($class);
	}
}
