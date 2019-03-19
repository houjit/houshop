<?php
/**
 * 入口
 */
$site_url = strtolower('http://'.$_SERVER['HTTP_HOST'].substr($_SERVER['PHP_SELF'], 0, strrpos($_SERVER['PHP_SELF'], '/index.php')).'/mall/index.php');
//@header('Location: '.$site_url);
include('mall/index.php');
