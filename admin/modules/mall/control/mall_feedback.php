<?php
/**
 */

defined('INSYSVIEW') or exit('Access Invalid!');
class mall_feedbackControl extends SystemControl{
    public function __construct(){
       // parent::__construct();
       // Language::read('mobile');
    }

    public function indexFeiwa() {
        $this->flistFeiwa();
    }
    /**
     * 意见反馈
     */
    public function flistFeiwa(){
        $model_mall_feedback = Model('mall_feedback');
        $list = $model_mall_feedback->getMallFeedbackList(array(), 10);

        Tpl::output('list', $list);
        Tpl::output('page', $model_mall_feedback->showpage());
        Tpl::setDirquna('mall');
        Tpl::showpage('mall_feedback.index');
    }

    /**
     * 输出XML数据
     */
    public function get_xmlFeiwa() {
        $model_mall_feedback = Model('mall_feedback');
        $condition = array();
        $condition['type'] = 2;
        if ($_POST['query'] != '') {
            $condition[$_POST['qtype']] = array('like', '%' . $_POST['query'] . '%');
        }
        $order = '';
        $param = array('id', 'content', 'ftime', 'member_name', 'member_id');
        $param = array();
        if (in_array($_POST['sortname'], $param) && in_array($_POST['sortorder'], array('asc', 'desc'))) {
            $order = $_POST['sortname'] . ' ' . $_POST['sortorder'];
        }
        $page = $_POST['rp'];
        $inform_list = $model_mall_feedback->getMallFeedbackList($condition, $page, $order);

        $data = array();
        $data['now_page'] = $model_mall_feedback->shownowpage();
        $data['total_num'] = $model_mall_feedback->gettotalnum();
        foreach ($inform_list as $value) {
            $param = array();
            $param['operation'] = "<a class='btn red' href=\"javascript:void(0);\" onclick=\"fg_del('".$value['id']."')\"><i class='fa fa-trash-o'></i>删除</a>";
            $param['id'] = $value['id'];
            $param['title'] = "<span title='{$value['title']}'>{$value['title']}</span>";
            $param['content'] = "<span title='{$value['content']}'>{$value['content']}</span>";
            $param['ftime'] = date('Y-m-d H:i:s', $value['ftime']);
            $param['member_name'] = $value['member_name'];
            $param['member_id'] = $value['member_id'];
            $data['list'][$value['id']] = $param;
        }
        echo Tpl::flexigridXML($data);exit();
    }

    /**
     * 删除
     */
    public function delFeiwa(){
        $ids = explode(',', $_GET['id']);
        if (count($ids) == 0){
            exit(json_encode(array('state'=>false,'msg'=>L('wrong_argument'))));
        }
        $model_mall_feedback = Model('mall_feedback');
        $result = $model_mall_feedback->delMallFeedback($ids);
        if ($result){
            exit(json_encode(array('state'=>true,'msg'=>'删除成功')));
        }else {
            exit(json_encode(array('state'=>false,'msg'=>'删除失败')));
        }
    }
}
