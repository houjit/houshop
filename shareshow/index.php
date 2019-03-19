<?php
/**
 * 商城板块初始化文件
 *
 * 商城板块初始化文件，引用框架初始化文件
 *
 *
 *  
 *
 *  
 */
define('APP_ID','shareshow');
define('BASE_PATH',str_replace('\\','/',dirname(__FILE__)));

require __DIR__ . '/../inport.php';

define('APP_SITE_URL', SHARESHOW_SITE_URL);
define('SHARESHOW_IMG_URL',UPLOAD_SITE_URL.DS.ATTACH_SHARESHOW);
define('TPL_NAME',TPL_SHARESHOW_NAME);
define('SHARESHOW_RESOURCE_SITE_URL',SHARESHOW_SITE_URL.'/resource');
define('SHARESHOW_TEMPLATES_URL',SHARESHOW_SITE_URL.'/templates/'.TPL_NAME);
define('SHARESHOW_BASE_TPL_PATH',dirname(__FILE__).'/templates/'.TPL_NAME);

//define('SHARESHOW_SEO_KEYWORD',$config['seo_keywords']);
//define('SHARESHOW_SEO_DESCRIPTION',$config['seo_description']);

define('SHARESHOW_SEO_KEYWORD',C('seo_keywords'));
define('SHARESHOW_SEO_DESCRIPTION',C('seo_description'));

//分享秀框架扩展
require(BASE_PATH.'/framework/function/function.php');

if (!@include(BASE_PATH.'/control/control.php')) exit('control.php isn\'t exists!');
Base::run();
