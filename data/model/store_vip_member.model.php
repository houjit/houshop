<?php
/**
 * 店铺会员模型管理
 *
 *
 *
 * * 
 
 * @
 *  
 */
defined('INSYSVIEW') or exit('Access Invalid!');
class store_vip_memberModel extends Model {

    public function __construct() {
        parent::__construct('store_vip_member');
    }

    /**
     * 查询店铺会员列表
     *
     * @param array $condition 查询条件
     * @param int $page 分页数
     * @param string $order 排序
     * @param string $field 字段
     * @param string $limit 取多少条
     * @return array
     */
    public function getStorevipmemberList($condition, $page = null, $order = '', $field = '*', $limit = '') {
        $result = $this->field($field)->where($condition)->order($order)->limit($limit)->page($page)->select();
        return $result;
    }

    /**
     * 查询有效店铺会员列表
     *
     * @param array $condition 查询条件
     * @param int $page 分页数
     * @param string $order 排序
     * @param string $field 字段
     * @return array
     */
    public function getStoreOpvipmemberList($condition, $page = null, $order = '', $field = '*') {
        $condition['vip_state'] = 1;
        return $this->getStorevipmemberList($condition, $page, $order, $field);
    }
	
	/**
	 * 根据店铺会员ID查找有效的店铺会员信息
	 */
	 
	 public function getvipmemberByinfo($condition, $field = '*', $master = false){
	 	$condition['vip_state'] = 1;
	 	return $this->table('store_vip_member')->field($field)->where($condition)->master($master)->find();
	 }

    /**
     * 会员数量
     * @param array $condition
     * @return int
     */
    public function getStorevipCount($condition) {
        return $this->where($condition)->count();
    }

    /*
     * 添加店铺会员
     *
     * @param array $param 店铺信息
     * @return bool
     */
    public function addStorevipmember($param){
        return $this->insert($param);
    }

    /*
     * 编辑店铺会员
     *
     * @param array $update 更新信息
     * @param array $condition 条件
     * @return bool
     */
    public function editStorevipmember($update, $condition){
        //清空缓存
        $store_list = $this->getStorevipmemberList($condition);
        foreach ($store_list as $value) {
            dcache($value['store_id'], 'store_info');
        }

        return $this->where($condition)->update($update);
    }

    /*
     * 删除店铺会员
     *
     * @param array $condition 条件
     * @return bool
     */
    public function delStorevip($condition){
        return $this->where($condition)->delete();
    }
	
	/**
     * 查询店铺会员等级列表
     */
    public function getvipcardlist($where = array(), $field = '*', $limit = 0, $page = 0, $order = '', $group = '') {
$list =$this->table('store_vip_item')->field($field)->where($where)->limit($limit)->page($page)->order($order)->group($group)->select();
        return $list;
    }
	
	/*
	 * 查询店铺对应店铺会员等级信息
	 */
	 
	 public function getVipStorelist($svip_id,$store_id,$state){
	 	$where=array();
		$where['svip_id']=$svip_id;
		$where['store_id']=$store_id;
		$where['ls_state']=$state;
	 	return $list=$this->table('store_vip_list')->where($where)->find();
	 }
	
	/**
     * 增加保障项目申请日志
     */
    public function addViplist($insert_arr){
        return $this->table('store_vip_item')->insert($insert_arr);
    }
	
	/**
     * 通过ID删除店铺会员等级
     *
     * @param int|array $id 表字增ID(s)
     *
     * @return boolean
     */
    public function delViplistById($id)
    {
        return $this->table('store_vip_item')->where(array(
            'svip_id' => array('in', (array) $id),
        ))->delete();
    }
	
}
