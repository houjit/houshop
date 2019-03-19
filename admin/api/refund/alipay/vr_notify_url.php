<?php
/**
 * 支付宝服务器异步通知页面
 *
 * 
 *  
 
 * @
 */
$_GET['app']	= 'notify_refund';
$_GET['feiwa']		= 'alipay';
$_GET['refund']		= 'vr';//虚拟订单退款
require_once(dirname(__FILE__).'/../../../index.php');
?>