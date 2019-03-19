<?php
/**
 */
defined('INSYSVIEW') or exit('Access Invalid!');
class member_feedbackControl extends BaseMemberControl {
    public function __construct() {
        parent::__construct();
    }

    /**
     * 平台客服咨询首页
     */
    public function index(){
        // 咨询列表
        $model_mallconsult = Model('mall_feedback');
        $consult_list = $model_mallconsult->getConsultList(array('type'=>2,'member_id' => $_SESSION['member_id']), '*', '10');
        
        Tpl::output('consult_list', $consult_list);
        Tpl::output('show_page', $model_mallconsult->showpage());

        // 回复状态
        $this->typeState();

        $this->profile_menu('consult_list');
        Tpl::showpage('member_feedback.list');
    }

    /**
     * 详细
     */
    public function info() {
        $id = intval($_GET['id']);
        if ($id <= 0) {
            showMessage(L('wrong_argument'), '', '', 'error');
        }
        // 咨询详细信息
        $consult_info = Model('mall_feedback')->getConsultInfo(array('id' => $id, 'member_id' => $_SESSION['member_id']));
        Tpl::output('consult_info', $consult_info);

        // 咨询类型列表
        $type_list = Model('mall_consult_type')->getMallConsultTypeList(array(), 'mct_id,mct_name', 'mct_id');
        Tpl::output('type_list', $type_list);

        // 回复状态
        $this->typeState();

        Tpl::showpage('member_feedback.info');
    }

    /**
     * 添加平台客服咨询
     */
    public function add() {
        // 咨询类型列表
        $type_list = Model('mall_consult_type')->getMallConsultTypeList(array());
        Tpl::output('type_list', $type_list);
        if ($_GET['inajax']) {
            Tpl::showpage('member_mallconsult.add_inajax', 'null_layout');
        } else {
            Tpl::showpage('member_feedback.add');
        }
    }

    /**
     * 保存
     */
    public function save_fb() {
        if (!chksubmit()) {
            showDialog(L('wrong_argument'), 'reload');
        }

        //验证表单信息
        $obj_validate = new Validate();
        $obj_validate->validateparam = array(
           // array("input"=>$_POST["type_id"],"require"=>"true","validator"=>"Number","message"=>"请选择咨询类型"),
            array("input"=>$_POST["consult_content"],"require"=>"true","message"=>"请填写咨询内容")
        );
        $error = $obj_validate->validate();
     
        if ($error != ''){
            showDialog($error);
        }

        $insert = array();
        //$insert['mct_id'] = $_POST['type_id'];
        $insert['member_id'] = $_SESSION['member_id'];
        $insert['title'] = $_POST['title'];
        $insert['member_name'] = $_SESSION['member_name'];
        $insert['content'] = $_POST['consult_content'];
        $insert['type'] = 2;
        

        $result = Model('mall_feedback')->addConsult($insert);
        if ($result) {
            showDialog(L('feiwa_common_op_succ'), 'reload', 'succ');
        } else {
            showDialog(L('feiwa_common_op_fail'), 'reload');
        }
    }

    /**
     * 删除
     */
    public function del() {
        $id = intval($_GET['id']);
        if ($id <= 0) {
            showDialog(L('wrong_argument'));
        }

        $result = Model('mall_feedback')->delConsult(array('id' => $id, 'member_id' => $_SESSION['member_id']));
        if ($result) {
            showDialog(L('feiwa_common_del_succ'), 'reload', 'succ');
        } else {
            showDialog(L('feiwa_common_del_fail'));
        }
    }

    /**
     * 咨询的回复状态
     */
    private function typeState() {
        $state = array('0'=>'未回复', '1'=>'已回复');
        Tpl::output('state', $state);
    }

    /**
     * 用户中心右边，小导航
     *
     * @param string $menu_key  当前导航的menu_key
     * @return
     */
    private function profile_menu($menu_key='') {
        $menu_array = array(
            1=>array('menu_key'=>'consult_list', 'menu_name'=>'意见反馈', 'menu_url'=>urlMall('member_mallconsult', 'index')),
        );
        Tpl::output('member_menu',$menu_array);
        Tpl::output('menu_key',$menu_key);
    }
}
