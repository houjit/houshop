<?php
/**
 * 默认展示页面
 *
 *
 * * 
 *
 * 
 *  
 */



defined('INSYSVIEW') or exit('Access Invalid!');
class albumControl extends ShareShowControl{

    public function __construct() {
        parent::__construct();
        Tpl::output('index_sign','album');
    }

    //首页
    public function indexFeiwa(){
        Tpl::showpage('album');
    }
}
