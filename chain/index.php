<?php
/**
 *
 *
 *  
 
 * @ 
 */
define('APP_ID','chain');
define('BASE_PATH',str_replace('\\','/',dirname(__FILE__)));

require __DIR__ . '/../inport.php';

define('APP_SITE_URL', CHAIN_SITE_URL);
define('CHAIN_TEMPLATES_URL', CHAIN_SITE_URL.'/templates/'.TPL_CHAIN_NAME);
define('BASE_CHAIN_TEMPLATES_URL', dirname(__FILE__).'/templates/'.TPL_CHAIN_NAME);
define('CHAIN_RESOURCE_SITE_URL',CHAIN_SITE_URL.'/resource');
define('TPL_NAME', TPL_CHAIN_NAME);
define('MALL_TEMPLATES_URL',MALL_SITE_URL.'/templates/'.TPL_NAME);
if (!@include(BASE_PATH.'/control/control.php')) exit('control.php isn\'t exists!');
Base::run();
