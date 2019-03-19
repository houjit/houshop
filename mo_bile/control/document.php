<?php
/**
 * 前台品牌分类
 *
 *
 *
 *
 * 
 *
 * @link       #
 * @since      File available since Release v1.1
 */



defined('INSYSVIEW') or exit('Access Invalid!');
class documentControl extends mobileHomeControl {
    public function __construct() {
        parent::__construct();
    }

    public function agreementFeiwa() {
        $doc = Model('document')->getOneByCode('agreement');
        output_data($doc);
    }
}
