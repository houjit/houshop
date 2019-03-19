<?php
/**
 * 物流自提服务站首页
 *
 * * 
 
 * @
 *  
 */



defined('INSYSVIEW') or exit('Access Invalid!');

class indexControl extends BaseChainCenterControl{
    public function __construct(){
        parent::__construct();
        redirect('index.php?app=goods');
    }

}
