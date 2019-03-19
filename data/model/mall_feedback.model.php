<?php
/**
 */
defined('INSYSVIEW') or exit('Access Invalid!');
class mall_feedbackModel extends Model{
    public function __construct() {
        parent::__construct('mb_feedback');
    }

    /**
     * 列表
     *
     * @param array $condition
     * @param string $field
     * @param string $order
     * @return array
     */
    public function getConsultList($condition, $field = '*', $page = 0, $order = 'id desc') {
        return $this->where($condition)->field($field)->order($order)->page($page)->select();
    }

    /**
     * 数量
     *
     * @param array $condition
     * @param string $field
     * @param string $order
     * @return array
     */
    public function getConsultCount($condition) {
        return $this->where($condition)->count();
    }

    /**
     * 单条
     *
     * @param unknown $condition
     * @param string $field
     */
    public function getConsultInfo($condition, $field = '*') {
        return $this->where($condition)->field($field)->find();
    }

    /**
     * 详细信息
     *
     * @param unknown $mc_id
     * @return boolean|multitype:
     */
    public function getConsultDetail($mc_id) {
        $consult_info = $this->getConsultInfo(array('mc_id' => $mc_id));
        if (empty($consult_info)) {
            return false;
        }

        $type_info = Model('mall_consult_type')->getConsultTypeInfo(array('mct_id' => $consult_info['mct_id']), 'mct_name');
        return array_merge($consult_info, $type_info);
    }

    /**
     * 添加
     * @param array $insert
     * @return int
     */
    public function addConsult($insert) {
        $insert['ftime'] = TIMESTAMP;
        return $this->insert($insert);
    }

    /**
     * 编辑
     * @param array $condition
     * @param array $update
     * @return boolean
     */
    public function editConsult($condition, $update) {
        return $this->where($condition)->update($update);
    }

    /**
     * 删除
     *
     * @param array $condition
     * @return boolean
     */
    public function delConsult($condition) {
        return $this->where($condition)->delete();
    }
    
    
    
    /*
     * 后台后台
     */
        /**
     * 列表
     *
     * @param array $condition 查询条件
     * @param int $page 分页数
     * @param string $order 排序
     * @return array
     */
    public function getMallFeedbackList($condition, $page = null, $order = 'id desc'){
        $list = $this->where($condition)->page($page)->order($order)->select();
        return $list;
    }

    /**
     * 新增
     *
     * @param array $param 参数内容
     * @return bool 布尔类型的返回结果
     */
    public function addMallFeedback($param){
        return $this->insert($param);
    }

    /**
     * 删除
     *
     * @param int $id 记录ID
     * @return bool 布尔类型的返回结果
     */
    public function delMallFeedback($id){
        $condition = array('id' => array('in', $id));
        return $this->where($condition)->delete();
    }
}
