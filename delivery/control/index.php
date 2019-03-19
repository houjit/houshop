<?php
/**
 * 物流自提服务站首页
 *
 * * 
 
 * @
 *  
 */



defined('INSYSVIEW') or exit('Access Invalid!');

class indexControl extends BaseDeliveryControl{
    public function __construct(){
        parent::__construct();
        @header('location: index.php?app=login');die;
    }
}
