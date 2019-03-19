<?php
/**
 * 商家注销
 *
  * 
 *
 */



defined('INSYSVIEW') or exit('Access Invalid!');

class seller_logoutControl extends mobileSellerControl {

    public function __construct(){
        parent::__construct();
    }

    /**
     * 注销
     */
    public function indexFeiWa(){
        if(empty($_POST['seller_name']) || !in_array($_POST['client'], $this->client_type_array)) {
            output_error('参数错误');
        }

        $model_mb_seller_token = Model('mb_seller_token');

        if($this->seller_info['seller_name'] == $_POST['seller_name']) {
            $condition = array();
            $condition['seller_id'] = $this->seller_info['seller_id'];
            $model_mb_seller_token->delSellerToken($condition);
            output_data('1');
        } else {
            output_error('参数错误');
        }
    }

}
