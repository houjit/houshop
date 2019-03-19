<?php
/**
 * 资讯专题模型
 *
 *
 *
 *
 * @copyright  Copyright (c) 2007-2012 FeiWa   (#)
 
 * @link       #
 * @since      File available since Release v1.1
 */
defined('INSYSVIEW') or exit('Access Invalid!');
class reads_specialModel extends Model{

    const SPECIAL_TYPE_READS = 1;
    const SPECIAL_TYPE_MALL = 2;

    private $special_type_array = array(
        self::SPECIAL_TYPE_READS => '资讯',
        self::SPECIAL_TYPE_MALL => '商城',
    );

    public function __construct(){
        parent::__construct('reads_special');
    }

    /**
     * 读取列表
     * @param array $condition
     *
     */
    public function getList($condition, $page=null, $order='', $field='*', $limit=''){
        $list = $this->field($field)->where($condition)->page($page)->order($order)->limit($limit)->select();
        foreach ($list as $key => $value) {
            $list[$key]['special_type_text'] = $this->special_type_array[$value['special_type']];
            if($value['special_type'] == self::SPECIAL_TYPE_MALL) {
                $list[$key]['special_link'] = getMallSpecialUrl($value['special_id']);
            } else {
                $list[$key]['special_link'] = getREADSSpecialUrl($value['special_id']);
            }
        }
        return $list;
    }

    public function getREADSList($condition, $page=null, $order='', $field='*', $limit=''){
        $condition['special_type'] = self::SPECIAL_TYPE_READS;
        return $this->getList($condition, $page=null, $order='', $field='*', $limit='');
    }

    public function getMallList($condition, $page=null, $order='', $field='*', $limit='2'){
        $condition['special_type'] = self::SPECIAL_TYPE_MALL;
        return $this->getList($condition, $page=null, $order='special_id desc', $field='*', $limit='');
    }
	/**
	*获取首页显示专题
	**/
	 public function getMallindexList($condition, $page=null, $order='', $field='*', $limit=''){
        $condition['special_type'] = self::SPECIAL_TYPE_MALL;
        return $this->getList($condition, $page=null, $order='special_id desc', $field='*', $limit='3');
    }

    /**
     * 读取单条记录
     * @param array $condition
     *
     */
    public function getOne($condition,$order=''){
        $result = $this->where($condition)->order($order)->find();
        return $result;
    }
	
	    /*
     *   根据id获取举报详细信息
     */
    public function getonlyOne($special_id) {   $param = array() ;  $param['table'] = 'reads_special'; $param['field'] = 'special_id' ; $param['value'] = intval($special_id);return Db::getRow($param) ;}


    /**
     * 获取类型列表
     */
    public function getSpecialTypeArray() {
        return $this->special_type_array;
    }

    /*
     *  判断是否存在
     *  @param array $condition
     *
     */
    public function isExist($condition) {
        $result = $this->getOne($condition);
        if(empty($result)) {
            return FALSE;
        }
        else {
            return TRUE;
        }
    }

    /*
     * 增加
     * @param array $param
     * @return bool
     */
    public function save($param){
        return $this->insert($param);
    }

    /*
     * 更新
     * @param array $update
     * @param array $condition
     * @return bool
     */
    public function modify($update, $condition){
        return $this->where($condition)->update($update);
    }

    /*
     * 删除
     * @param array $condition
     * @return bool
     */
    public function drop($condition){
        return $this->where($condition)->delete();
    }

}
