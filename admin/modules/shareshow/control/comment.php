<?php
/**
 * 分享秀
 *
 *
 *
 *
 *  
 
 * @
 */

//;

defined('INSYSVIEW') or exit('Access Invalid!');
class commentControl extends SystemControl{

    const GOODS_FLAG = 1;
    const PERSONAL_FLAG = 2;
    const ALBUM_FLAG = 3;
    const STORE_FLAG = 4;

    public function __construct(){
        parent::__construct();
        Language::read('store');
        Language::read('shareshow');
    }

    public function indexFeiwa() {
       $this->comment_manageFeiwa();
    }


    /**
     * 评论管理
     */
    public function comment_manageFeiwa()
    {
        $this->get_channel_array();
        Tpl::setDirquna('shareshow');
Tpl::showpage('shareshow_comment.manage');
    }

    /**
     * 评论管理XML
     */
    public function comment_manage_xmlFeiwa()
    {
        $condition = array();

        if ($_REQUEST['advanced']) {
            if (strlen($q = trim((string) $_REQUEST['comment_id']))) {
                $condition['comment_id'] = (int) $q;
            }
            if (strlen($q = trim((string) $_REQUEST['member_name']))) {
                $condition['member_name'] = array('like', '%' . $q . '%');
            }
            if (strlen($q = trim((string) $_REQUEST['comment_type']))) {
                $condition['comment_type'] = (int) $q;
            }
            if (strlen($q = trim((string) $_REQUEST['comment_object_id']))) {
                $condition['comment_object_id'] = (int) $q;
            }
            if (strlen($q = trim((string) $_REQUEST['comment_message']))) {
                $condition['comment_message'] = array('like', '%' . $q . '%');
            }
        } else {
            if (strlen($q = trim($_REQUEST['query'])) > 0) {
                switch ($_REQUEST['qtype']) {
                    case 'comment_id':
                        $condition['comment_id'] = (int) $q;
                        break;
                    case 'member_name':
                        $condition['member_name'] = array('like', '%' . $q . '%');
                        break;
                    case 'comment_object_id':
                        $condition['comment_object_id'] = (int) $q;
                        break;
                    case 'comment_message':
                        $condition['comment_message'] = array('like', '%' . $q . '%');
                        break;
                }
            }
        }

        $model_comment = Model("micro_comment");
        $list = (array) $model_comment->getListWithUserInfo($condition, $_REQUEST['rp'], 'comment_time desc');

        $data = array();
        $data['now_page'] = $model_comment->shownowpage();
        $data['total_num'] = $model_comment->gettotalnum();

        $channel_array = $this->get_channel_array();

        foreach ($list as $val) {
            $channel = $channel_array[$val['comment_type']];
            $o = '<a class="btn red confirm-del-on-click" href="index.php?app=comment&feiwa=comment_drop&comment_id=' .
                    $val['comment_id'] .
                    '"><i class="fa fa-trash"></i>删除</a>';

            $o .= '<a class="btn green" target="_blank" href="' .
                SHARESHOW_SITE_URL.DS.'index.php?app=' .
                $channel['key'] .
                '&feiwa=detail&' .
                $channel['key'] .
                '_id=' .
                $val['comment_object_id'] .
                '"><i class="fa fa-list-alt"></i>查看</a>';

            $i = array();
            $i['operation'] = $o;
            $i['comment_id'] = $val['comment_id'];

            $i['member_name'] = '<a href="' .
                SHARESHOW_SITE_URL.DS.'index.php?app=home&member_id=' .
                $val['comment_member_id'] .
                '" target="_blank">' .
                $val['member_name'] .
                '</a>';

            $i['comment_type'] = $channel['name'];
            $i['comment_object_id'] = $val['comment_object_id'];
            $i['comment_message'] = parsesmiles($val['comment_message']);

            $data['list'][$val['comment_id']] = $i;
        }

        echo Tpl::flexigridXML($data);
        exit;
    }

    /**
     * 评论删除
     */
    public function comment_dropFeiwa() {
        $model = Model('micro_comment');
        $condition = array();
        $condition['comment_id'] = array('in',trim($_REQUEST['comment_id']));
        $result = $model->drop($condition);
        if($result) {
            showMessage(Language::get('feiwa_common_del_succ'),'');
        } else {
            showMessage(Language::get('feiwa_common_del_fail'),'','','error');
        }
    }

    /**
     * 获取频道数组
     */
    private function get_channel_array() {
        $channel_array = array();
        $channel_array[self::GOODS_FLAG] = array('name'=>Language::get('feiwa_shareshow_goods'),'key'=>'goods');
        $channel_array[self::PERSONAL_FLAG] = array('name'=>Language::get('feiwa_shareshow_personal'),'key'=>'personal');
        $channel_array[self::STORE_FLAG] = array('name'=>Language::get('feiwa_shareshow_store'),'key'=>'store');
        Tpl::output('channel_array', $channel_array);

        return $channel_array;
    }
}
