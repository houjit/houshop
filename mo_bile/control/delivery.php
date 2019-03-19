<?php
/**
 * 商家首页
 *
 * 
 *
 * @link       #
 * @since      File available since Release v1.1
 */



defined('INSYSVIEW') or exit('Access Invalid!');

class deliveryControl extends mobileDeliveryControl {

    public function __construct(){
        parent::__construct();
    }

    public function centerFeiWa() {
        $model = Model();
        $condition['dlyp_id'] = $this->delivery_info['dlyp_id'];
        if(!empty($_POST['key_word'])){
            $condition['order_sn'] = array("like","%".$_POST['key_word']."%");
        }
        $order_list = $model->table('delivery_order')->where($condition)->order('order_id desc')->page(10)->select();
        $count = $model->table('delivery_order')->where($condition)->order('order_id desc')->count();
        $nums = $count/10+1;
        foreach ($order_list as $key => $value){
            $order_list[$key]['addtime'] = date("Y-m-d H:i:s",$value['addtime']);
        }
        //print_r($order_list);exit;
        $count = $model->table('delivery_order')->where($condition)->count();

        output_data(array('order_list' => $order_list,'curpage' => $nums));
    }
    
    public function infoFeiWa() {
        $info = $this->delivery_info;
 
        if($info['dlyp_state']==0){
            $info['dlyp_state']='关闭';
        }elseif($info['dlyp_state']==1){
            $info['dlyp_state']='开启';
        }elseif($info['dlyp_state']==10){
            $info['dlyp_state']='等待审核';
        }elseif($info['dlyp_state']==20){
            $info['dlyp_state']='审核失败';
        }
        $info['area'] = $info['dlyp_area_info']." ".$info['dlyp_address'];
        output_data(array('info' =>$info));
    }
    
    /**
     * 取件通知
     */
    public function arrive_pointFeiWa() {
        $order_id = $_POST['order_id'];
        if ($order_id <= 0) {
            output_error("参数错误");
        }
        $pickup_code = $this->createPickupCode();
        // 更新提货订单表数据
        $update = array();
        $update['dlyo_pickup_code'] = $pickup_code;

        Model('delivery_order')->editDeliveryOrderArrive($update, array('order_id' => $order_id, 'dlyp_id' => $this->delivery_info['dlyp_id']));
        // 更新订单扩展表数据
        Model('order')->editOrderCommon($update, array('order_id' => $order_id));
        // 发送短信提醒
//        $logic_send_sms = Logic('queue');
//        $param['order_id'] = $order_id;
//        $param['pickup_code'] = $pickup_code;
//        $logic_send_sms->sendPickupcode($param);
        QueueClient::push('sendPickupcode', array('pickup_code' => $pickup_code, 'order_id' => $order_id));
        output_data('操作成功');
    }
    /**
     * 提货验证
     */
    public function pickup_parcelFeiWa() {
        $order_id = intval($_POST['order_id']);
        $pickup_code = intval($_POST['pickup_code']);
        if ($order_id <= 0 || $pickup_code <= 0) {
            output_error('参数错误');
        }
        $model_do = Model('delivery_order');
        $dorder_info = $model_do->getDeliveryOrderInfo(array('order_id' => $order_id, 'dlyp_id' => $this->delivery_info['dlyp_id'], 'dlyo_pickup_code' => $pickup_code));
        if (empty($dorder_info)) {
            output_error('提货码错误');
        }
        $result = $model_do->editDeliveryOrderPickup(array(), array('order_id' => $order_id, 'dlyp_id' => $this->delivery_info['dlyp_id'], 'dlyo_pickup_code' => $pickup_code));
        if ($result) {
            // 更新订单状态
            $order_info = Model('order')->getOrderInfo(array('order_id' => $order_id));
            if ($order_info['order_state'] != ORDER_STATE_SUCCESS) {
                Logic('order')->changeOrderStateReceive($order_info, 'buyer', '物流自提服务站', '物流自提服务站确认收货');
            }
            output_data(array('msg'=>'提货成功'));
        } else {
            output_error('操作失败');
        }
        
    }
    /**
     * 生成提货码
     */
    private function createPickupCode() {
        return rand(1, 9) . rand(0, 9) . rand(0, 9) . rand(0, 9) . rand(0, 9) . rand(0, 9);
    }
    
    /**
     * 修改密码
     */
    public function change_passwordFeiWa() {

        if ($_POST['password'] != $_POST['passwd_confirm']) {
            output_error('新密码与确认密码填写不同');
        }
        $model_dp = Model('delivery_point');
        $where = array();
        $where['dlyp_id'] = $this->delivery_info['dlyp_id'];
        $where['dlyp_passwd'] = md5($_POST['old_password']);
        $dp_info = $model_dp->getDeliveryPointInfo($where);
        if (empty($dp_info)) {
            output_error('原密码填写错误');
        }
        $model_dp->editDeliveryPoint(array('dlyp_passwd' => md5($_POST['password'])), $where);

//            unset($_SESSION['delivery_login']);
//            unset($_SESSION['dlyp_id']);
//            unset($_SESSION['dlyp_name']);
        output_data('修改成功');

    }
    
    /**
     * 物流跟踪
     */
    public function search_deliverFeiWa(){
        $order_id   = intval($_POST['order_id']);
        if ($order_id <= 0) {
            output_error('订单不存在');
        }

        $model_order    = Model('order');
        $condition['order_id'] = $order_id;
        //$condition['buyer_id'] = $this->member_info['member_id'];
        $order_info = $model_order->getOrderInfo($condition,array('order_common','order_goods'));
        
        $dlyp_where['order_id'] = $order_id;
        $delivery_check = Model('delivery_order')->where($dlyp_where)->find();
        
        if (empty($order_info) || $delivery_check['dlyp_id']!=$this->delivery_info['dlyp_id']) {
            output_error('订单不存在');
        }

        $express = rkcache('express',true);
        
        $e_code = $express[$order_info['extend_order_common']['shipping_express_id']]['e_code'];
        
        $e_name = $express[$order_info['extend_order_common']['shipping_express_id']]['e_name'];

        $deliver_info = $this->_get_express($e_code, $order_info['shipping_code']);
        output_data(array('express_name' => $e_name, 'shipping_code' => $order_info['shipping_code'], 'deliver_info' => $deliver_info));
    }
    /**
     * 从第三方取快递信息
     *
     */
    public function _get_express($e_code, $shipping_code){

        $content = Model('express')->get_express($e_code, $shipping_code);
        if (empty($content)) {
            output_error('物流信息查询失败');
        }
        $output = array();
        foreach ($content as $k=>$v) {
            if ($v['time'] == '') continue;
            $output[]= $v['time'].'&nbsp;&nbsp;'.$v['context'];
        }

        return $output;
    }
  

    
}
