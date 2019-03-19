<?php
/**
 * 资讯专题
 *
 *
 * * 
 *
 * 
 *  
 */



defined('INSYSVIEW') or exit('Access Invalid!');
class specialControl extends READSHomeControl{

    public function __construct() {
        parent::__construct();
        Tpl::output('index_sign','special');
    }

    public function indexFeiwa() {
        $this->special_listFeiwa();
    }

    /**
     * 专题列表
     */
    public function special_listFeiwa() {
        $conition = array();
        $conition['special_state'] = 2;
        $model_special = Model('reads_special');
        $special_list = $model_special->getREADSList($conition, 10, 'special_id desc');
        Tpl::output('show_page', $model_special->showpage(2));
        Tpl::output('special_list', $special_list);
        Tpl::showpage('special_list');
    }

    /**
     * 专题详细页
     */
    public function special_detailFeiwa() {
        $special_file = getREADSSpecialHtml($_GET['special_id']);
        if($special_file) {
            Tpl::output('special_file', $special_file);
            Tpl::output('index_sign', 'special');
            Tpl::showpage('special_detail');
        } else {
            showMessage('专题不存在', '', '', 'error');
        }
    }
}
