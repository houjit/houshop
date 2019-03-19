<?php
/**
 * 会员中心——账户概览
 *
 *
 *
 * * 
 *
 * 
 *  
 */



defined('INSYSVIEW') or exit('Access Invalid!');

class memberControl extends BaseMemberControl{

    /**
     * 我的商城
     */
    public function homeFeiwa() {
        $model_consume = Model('consume');
        $consume_list = $model_consume->getConsumeList(array('member_id' => $_SESSION['member_id']), '*', 0, 10);
        Tpl::output('consume_list', $consume_list);
        Tpl::showpage('member_home');
    }
}
