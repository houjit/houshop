<?php
/**
 * 控制台
 *
 *
 *
*/



defined('INSYSVIEW') or exit('Access Invalid!');

class aboutusControl extends SystemControl{
    public function __construct(){
        parent::__construct();
        Language::read('dashboard');
    }

    public function indexFeiwa() {
        $this->aboutusFeiwa();
    }

    /**
     * 关于我们
     */
    public function aboutusFeiwa(){
        $version = C('version');
        $v_date = substr($version,0,4).".".substr($version,4,2);
        $s_date = substr(C('setup_date'),0,10);
        Tpl::output('v_date',$v_date);
        Tpl::output('s_date',$s_date);
        Tpl::showpage('aboutus', 'null_layout');
    }

}
