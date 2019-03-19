<?php
/**
 * 自提站登录
 *
 *
 * 
 *
 * @link       #
 * @since      File available since Release v1.1
 */


defined('INSYSVIEW') or exit('Access Invalid!');

class delivery_loginControl extends mobileHomeControl {

    public function __construct(){
        parent::__construct();
    }

    /**
     * 登录
     */
    public function indexFeiWa(){
        if(empty($_POST['dname']) || empty($_POST['dpasswd']) || !in_array($_POST['client'], $this->client_type_array)) {
            output_error('用户名密码不能为空');
        }

        $where = array();
        $where['dlyp_name'] = $_POST['dname'];
        $where['dlyp_passwd'] = md5($_POST['dpasswd']);
        
        $dp_info = Model('delivery_point')->getDeliveryPointInfo($where);
        //print_r($dp_info);exit;
        if (empty($dp_info)) {
            output_error('登录失败');
        }
        
        //生成登录令牌
        $token = $this->_get_token($dp_info['dlyp_id'], $dp_info['dlyp_name'], $_POST['client']);
       // print_r($token);exit;
        if($token) {
            output_data(array('dlyp_id' => $dp_info['dlyp_id'], 'dlyp_name' => $dp_info['dlyp_name'], 'key' => $token));
        } else {
            output_error('登录失败');
        }
    }

    /**
     * 登录生成token
     */
    private function _get_token($dlyp_id, $dlyp_name, $client) {
        $model_mb_delivery_token = Model('mb_delivery_token');

        //重新登录后以前的令牌失效
        $condition = array();
        $condition['dlyp_id'] = $dlyp_id;
        $model_mb_delivery_token->delDeliveryToken($condition);

        //生成新的token
        $mb_delivery_token_info = array();
        $token = md5($dlyp_name. strval(TIMESTAMP) . strval(rand(0,999999)));
        $mb_delivery_token_info['dlyp_id'] = $dlyp_id;
        $mb_delivery_token_info['dlyp_name'] = $dlyp_name;
        $mb_delivery_token_info['token'] = $token;
        $mb_delivery_token_info['login_time'] = TIMESTAMP;
        $mb_delivery_token_info['client_type'] = $client;
        
        $result = $model_mb_delivery_token->addDeliveryToken($mb_delivery_token_info);
        
        if($result) {
            return $token;
        } else {
            return null;
        }
    }
	
}
