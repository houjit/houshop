<?php
/**
 * 会员店铺
 *
 *
 *
 * * 
 *
 * 
  
 */



defined('INSYSVIEW') or exit('Access Invalid!');

class show_chainControl extends BaseChainControl {
    public function __construct(){
        parent::__construct();
    }
    /**
     * 展示门店
     */
    public function indexFeiwa() {
        $chain_id = intval($_GET['chain_id']);
        $chain_info = Model('chain')->getChainInfo(array('chain_id' => $chain_id));
        Tpl::output('chain_info', $chain_info);
        Tpl::showpage('show_chain');
    }
}
