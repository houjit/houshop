<?php
/* * 
 * 功能：支付宝页面跳转同步通知页面
 */

$_GET['app'] = 'payment';
$_GET['feiwa']	= 'return';
$_GET['payment_code']	= 'alipay';
require_once(dirname(__FILE__).'/../../../index.php');
?>
