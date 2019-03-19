<?php
/**
 * 入口文件
 *
 * 统一入口，进行初始化信息
 *
 *
 * @copyright  Copyright (c) 2007-2015 MALLNC   
 * @打造专业团队服务 专注电商开发/
 * @MALLNC /
 * @为了您的网站安全，请务必认准MALLNC原版源码，本源码经过严格测试绝无后门，如购买倒卖源码导致网站损失本人概不负责。
 */
define('BASE_PATH', str_replace('\\', '/', dirname(__FILE__)));
require __DIR__ . '/../inport.php';

session_save_path(BASE_DATA_PATH.DS.'session');
require_once(BASE_DATA_PATH.DS.'config/config.ini.php');
$site_url = $config['mall_site_url'];
$version = $config['version'];
$setup_date = $config['setup_date'];
$gip = $config['gip'];
$dbtype = $config['dbdriver'];
$dbcharset = $config['db']['1']['dbcharset'];
$dbserver = $config['db']['1']['dbhost'];
$dbserver_port = $config['db']['1']['dbport'];
$dbname = $config['db']['1']['dbname'];
$db_pre = $config['tablepre'];
$dbuser = $config['db']['1']['dbuser'];
$dbpasswd = $config['db']['1']['dbpwd'];
$lang_type = $config['lang_type'];
$cookie_pre = $config['cookie_pre'];
unset($config);

if($_GET['app'] == 'adv'){
    define('ATTACH_ADV','mall/adv');
    //define('MALL_SITE_URL',$site_url);
    $advshow_classfile = BASE_PATH.DS.'control/adv.php';
    if(is_file($advshow_classfile)){
        include_once ($advshow_classfile);
        $advshow = new advControl();
        $advshow->advshowFeiwa();
    }else{
        echo "Adv System Inner Error!";
    }

}elseif ($_GET['app'] == 'toqq'){
    //define('MALL_SITE_URL',$site_url);
    if ($_GET['feiwa'] == 'g'){
        include 'api/qq/oauth/qq_callback.php';
    }else{
        include 'api/qq/oauth/qq_login.php';
    }
}elseif ($_GET['app'] == 'tosina'){
    //define('MALL_SITE_URL',$site_url);
    if ($_GET['feiwa'] == 'g'){
        include 'api/sina/callback.php';
    }else{
        include 'api/sina/index.php';
    }
}elseif ($_GET['app'] == 'get_session'){
    //session_start();
    $key = $_GET['key'];
    $val = '';
    if (!empty($_SESSION[$key])) $val = $_SESSION[$key];
    echo $val;
    exit;
}elseif ($_GET['app'] == 'sharebind'){
    //define('MALL_SITE_URL',$site_url);
    if($_GET['type'] == 'qqzone'){
        include BASE_DATA_PATH.DS.'api/snsapi/qqzone/oauth/qq_login.php';
    }elseif ($_GET['type'] == 'sinaweibo'){
        include BASE_DATA_PATH.DS.'api/snsapi/sinaweibo/index.php';
    }elseif ($_GET['type'] == 'qqweibo'){
        include BASE_DATA_PATH.DS.'api/snsapi/qqweibo/index.php';
    }
}
