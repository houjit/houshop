<?php
/**
 * 店铺卖家注销
 *
 *
 *
 * * 
 *
 * @
  
 */



defined('INSYSVIEW') or exit('Access Invalid!');

class seller_logoutControl extends BaseSellerControl {

    public function __construct() {
        parent::__construct();
    }

    public function indexFeiwa() {
        $this->logoutFeiwa();
    }

    public function logoutFeiwa() {
        $this->recordSellerLog('注销成功');
        // 清除店铺消息数量缓存
        setNcCookie('storemsgnewnum'.$_SESSION['seller_id'],0,-3600);
        session_destroy();
        redirect('index.php?app=seller_login');
    }

}
