<?php
/**
 * 聊天记录查询
 *
 *
 *
 *
 *  
 
 * @
 */



defined('INSYSVIEW') or exit('Access Invalid!');
class realnamecontrol extends SystemControl{
    public function __construct(){
        parent::__construct();
        Language::read('store,store_grade');
    }

    public function indexFeiWa() {
        $this->real_nameFeiWa();
    }
    /**
     * 实名认证
     */
    public function real_nameFeiWa(){
        //认证列表
        Tpl::setDirquna('mall');
        Tpl::showpage('realname');
    }
    /**
     * 输出XML数据
     */
    public function get_xmlFeiWa() {
        $model = Model();
        // 设置页码参数名称
        $condition = array();
        if ($_GET['member_name'] != '') {
            $condition['member_name'] = array('like', '%' . $_GET['member_name'] . '%');
        }
        if ($_GET['member_id'] != '') {
            $condition['member_id'] = array('like', '%' . $_GET['member_id'] . '%');
        }
        if ($_GET['real_cardnumber'] != '') {
            $condition['real_cardnumber'] = $_GET['real_cardnumber'];
        }
        if ($_POST['query'] != '') {
            $condition[$_POST['qtype']] = array('like', '%' . $_POST['query'] . '%');
        }
        $condition['real_check'] = array('gt',0);
        $param = array('member_id','member_name','real_name','real_cardnumber','real_birthday','real_sex','real_minzu','real_address','real_jiguan');
        $page = $_POST['rp'];

        $order = 'member_id asc';
        $real = $model->table('member')->where($condition)->order($order)->select();
        $count = $model->table('member')->where($condition)->order($order)->count();
        //认证列表
        
        $data = array();
        $data['now_page'] = ceil($count/$page);
        $data['total_num'] = $count;
        foreach ($real as $value) {
            $param = array();

            if($value['real_check']!='1') {
                $operation = "<a class='btn orange' href=\"index.php?app=realname&feiwa=real_detail&member_id=". $value['member_id'] ."\"><i class=\"fa fa-check-circle\"></i>审核</a>";
            } else {
                $operation = "<a class='btn green' href=\"index.php?app=realname&feiwa=real_detail&member_id=". $value['member_id'] ."\"><i class=\"fa fa-list-alt\"></i>查看</a>";
            }
            $param['operation'] = $operation;
            $param['member_id'] = $value['member_id'];
            $param['member_name'] = $value['member_name'];
            $param['real_name'] = $value['real_name'];
            $param['real_cardnumber'] = $value['real_cardnumber'];
            $param['real_birthday'] = date("Y-m-d",$value['real_birthday']);
            $param['real_sex'] = $value['real_sex'];
            $param['real_minzu'] = $value['real_minzu'];
            $param['real_address'] = $value['real_address'];
            $param['real_jiguan'] = $value['real_jiguan'];
            $param['real_youxiaoqi'] = date("Y-m-d",$value['real_timestart'])."至".date("Y-m-d",$value['real_timeend']);

            $data['list'][$value['member_id']] = $param;
        }
        echo Tpl::flexigridXML($data);exit();
    }
    public function real_name_checkFeiWa(){
        //待审核
        Tpl::setDirquna('mall');
        Tpl::showpage('realname_check');
    }
    /**
     * 输出XML数据
     */
    public function get_xml_checkFeiWa() {
        $model = Model();
        // 设置页码参数名称
        $condition = array();
        if ($_GET['member_name'] != '') {
            $condition['member_name'] = array('like', '%' . $_GET['member_name'] . '%');
        }
        if ($_GET['member_id'] != '') {
            $condition['member_id'] = array('like', '%' . $_GET['member_id'] . '%');
        }
        if ($_GET['real_cardnumber'] != '') {
            $condition['real_cardnumber'] = $_GET['real_cardnumber'];
        }
        if ($_POST['query'] != '') {
            $condition[$_POST['qtype']] = array('like', '%' . $_POST['query'] . '%');
        }
        $condition['real_check'] = array('gt',1);
        $param = array('member_id','member_name','real_name','real_cardnumber');
        $page = $_POST['rp'];

        $order = 'member_id asc';
        $real = $model->table('member')->where($condition)->order($order)->select();
        //认证列表
        
        $data = array();
        $data['now_page'] = $model->shownowpage();
        $data['total_num'] = $model->gettotalnum();
        foreach ($real as $value) {
            $param = array();

            if($value['real_check']!='1') {
                $operation = "<a class='btn orange' href=\"index.php?app=realname&feiwa=real_detail&member_id=". $value['member_id'] ."\"><i class=\"fa fa-check-circle\"></i>审核</a>";
            } else {
                $operation = "<a class='btn green' href=\"index.php?app=realname&feiwa=real_detail&member_id=". $value['member_id'] ."\"><i class=\"fa fa-list-alt\"></i>查看</a>";
            }
            $param['operation'] = $operation;
            $param['member_id'] = $value['member_id'];
            $param['member_name'] = $value['member_name'];
            $param['real_name'] = $value['real_name'];
            $param['real_cardnumber'] = $value['real_cardnumber'];
            
            $data['list'][$value['member_id']] = $param;
        }
        echo Tpl::flexigridXML($data);exit();
    }
    public function real_detailFeiWa(){
        $model = Model();
        $member = $model->table('member')->where("member_id=".$_GET["member_id"])->find();
        Tpl::output('member',$member);
        Tpl::setDirquna('mall');
        Tpl::showpage('real_detail');
    }
    public function real_checkFeiWa(){
        $model = Model();
        $datas['member_id'] = $_POST['member_id'];
        $datas['real_check'] = $_POST['real_check'];
        $datas['real_text'] = $_POST['real_text'];
        $update = $model->table('member')->update($datas);
        if($update){
            showMessage('审核成功','index.php?app=realname');
        }
    }


}
