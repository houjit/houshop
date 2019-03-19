<?php
/**
 * 客户端商家令牌模型
 *
 *
 *
 *
 * @copyright  Copyright (c) 2007-2012 FEIWA   (#)
 
 * @link       #
 * @since      File available since Release v1.1
 */

defined('INSYSVIEW') or exit('Access Invalid!');

class mb_delivery_tokenModel extends Model{
    public function __construct(){
        parent::__construct('mb_delivery_token');
    }

    /**
     * 查询
     *
     * @param array $condition 查询条件
     * @return array
     */
    public function getDeliveryTokenInfo($condition) {
        return $this->where($condition)->find();
    }

    public function getDeliveryTokenInfoByToken($token) {
        if(empty($token)) {
            return null;
        }
        return $this->getDeliveryTokenInfo(array('token' => $token));
    }

    /**
     * 新增
     *
     * @param array $param 参数内容
     * @return bool 布尔类型的返回结果
     */
    public function addDeliveryToken($param){
        return $this->insert($param);
    }

    /**
     * 删除
     *
     * @param int $condition 条件
     * @return bool 布尔类型的返回结果
     */
    public function delDeliveryToken($condition){
        return $this->where($condition)->delete();
    }
}
