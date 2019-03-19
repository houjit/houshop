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
class personalControl extends SystemControl{

    const SHARESHOW_CLASS_LIST = 'index.php?app=goods_class&feiwa=goodsclass_list';
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
       $this->personal_manageFeiwa();
    }

    /**
     * 个人秀管理
     */
    public function personal_manageFeiwa()
    {
        Tpl::setDirquna('shareshow');
Tpl::showpage('shareshow_personal.manage');
    }

    /**
     * 个人秀管理XML
     */
    public function personal_manage_xmlFeiwa()
    {
        $condition = array();

        if ($_REQUEST['advanced']) {
            if (strlen($q = trim((string) $_REQUEST['personal_id']))) {
                $condition['personal_id'] = (int) $q;
            }
            if (strlen($q = trim((string) $_REQUEST['member_name']))) {
                $condition['member_name'] = $q;
            }
            if (strlen($q = trim((string) $_REQUEST['shareshow_commend']))) {
                $condition['shareshow_commend'] = (int) $q;
            }

            $sdate = (int) strtotime($_GET['sdate']);
            $edate = (int) strtotime($_GET['edate']);
            if ($sdate > 0 || $edate > 0) {
                $condition['commend_time'] = array(
                    'time',
                    array($sdate, $edate, ),
                );
            }

        } else {
            if (strlen($q = trim($_REQUEST['query'])) > 0) {
                switch ($_REQUEST['qtype']) {
                    case 'personal_id':
                        $condition['personal_id'] = (int) $q;
                        break;
                    case 'member_name':
                        $condition['member_name'] = $q;
                        break;
                }
            }
        }

        $model_personal = Model('micro_personal');
        $field = 'micro_personal.*,member.member_name,member.member_avatar';
        $list = (array) $model_personal->getListWithUserInfo($condition, $_REQUEST['rp'],
            'shareshow_sort, commend_time desc', $field);

        $data = array();
        $data['now_page'] = $model_personal->shownowpage();
        $data['total_num'] = $model_personal->gettotalnum();

        foreach ($list as $val) {
            $o = '<a class="btn red confirm-del-on-click" href="index.php?app=personal&feiwa=personal_drop&personal_id=' .
                $val['personal_id'] .
                '"><i class="fa fa-trash-o"></i>删除</a>';

            $o .= '<span class="btn"><em><i class="fa fa-cog"></i>设置<i class="arrow"></i></em><ul>';

            if ($val['shareshow_commend'] == '1') {
                $o .= '<li><a href="javascript:;" data-ie-column="shareshow_commend" data-ie-value="0">取消推荐</a></li>';
            } else {
                $o .= '<li><a href="javascript:;" data-ie-column="shareshow_commend" data-ie-value="1">推荐内容</a></li>';
            }

            $u = SHARESHOW_SITE_URL.DS.'index.php?app=personal&feiwa=detail&personal_id=' . $val['personal_id'];
            $o .= '<li><a target="_blank" href="' . $u . '">查看内容</a></li>';

            $o .= '</ul></span>';

            $i = array();
            $i['operation'] = $o;

            $i['shareshow_sort'] = '<span class="editable" title="可编辑" style="width:50px;" data-live-inline-edit="shareshow_sort">' .
                $val['shareshow_sort'] . '</span>';

            $i['personal_id'] = $val['personal_id'];

            $personal_image_array_240 = getShareShowPersonalImageUrl($val, 'list');

            $imgs = '';
            foreach ((array) $personal_image_array_240 as $imgUrl) {
                $imgs .= <<<EOB
<a href="javascript:;" class="pic-thumb-tip" onMouseOut="toolTip()" onMouseOver="toolTip('<img src=\'{$imgUrl}\'>')">
<i class='fa fa-picture-o'></i></a>
EOB;
            }
            $i['imgs'] = $imgs;

            $i['member_name'] = '<a href="' .
                SHARESHOW_SITE_URL.DS.'index.php?app=home&member_id=' . $val['commend_member_id'] .
                '" target="_blank">' .
                $val['member_name'] .
                '</a>';

            $i['commend_message'] = $val['commend_message'];
            $i['commend_time_text'] = date('Y-m-d', $val['commend_time']);
            $i['shareshow_commend'] = $val['shareshow_commend'] == '1'
                ? '<span class="yes"><i class="fa fa-check-circle"></i>是</span>'
                : '<span class="no"><i class="fa fa-ban"></i>否</span>';

            $data['list'][$val['personal_id']] = $i;
        }

        echo Tpl::flexigridXML($data);
        exit;
    }

    /**
     * 个人秀删除
     */
    public function personal_dropFeiwa() {
        $model = Model('micro_personal');
        $condition = array();
        $condition['personal_id'] = array('in',trim($_REQUEST['personal_id']));

        //删除随心看图片
        $list = $model->getList($condition);
        if(!empty($list)) {
            foreach ($list as $personal_info) {
                //计数
                $model_micro_member_info = Model('micro_member_info');
                $model_micro_member_info->updateMemberPersonalCount($personal_info['commend_member_id'],'-');

                $image_array = explode(',',$personal_info['commend_image']);
                foreach ($image_array as $value) {
                    //删除原始图片
                    $image_name = BASE_UPLOAD_PATH.DS.ATTACH_SHARESHOW.DS.$personal_info['commend_member_id'].DS.$value;
                    if(is_file($image_name)) {
                        unlink($image_name);
                    }
                    //删除列表图片
                    $ext = explode('.', $value);
                    $ext = $ext[count($ext) - 1];
                    $image_name = BASE_UPLOAD_PATH.DS.ATTACH_SHARESHOW.DS.$personal_info['commend_member_id'].DS.$value.'_list.'.$ext;
                    if(is_file($image_name)) {
                        unlink($image_name);
                    }
                    $image_name = BASE_UPLOAD_PATH.DS.ATTACH_SHARESHOW.DS.$personal_info['commend_member_id'].DS.$value.'_tiny.'.$ext;
                    if(is_file($image_name)) {
                        unlink($image_name);
                    }
                }
            }
        }

        $result = $model->drop($condition);
        if($result) {
            showMessage(Language::get('feiwa_common_del_succ'),'');
        } else {
            showMessage(Language::get('feiwa_common_del_fail'),'','','error');
        }
    }

    /**
     * 更新分享秀个人秀排序
     */
    public function personal_sort_updateFeiwa() {
        if(intval($_GET['id']) <= 0) {
            echo json_encode(array('result'=>FALSE,'message'=>Language::get('param_error')));
            die;
        }
        $new_sort = intval($_GET['value']);
        if ($new_sort > 255){
            echo json_encode(array('result'=>FALSE,'message'=>Language::get('shareshow_sort_error')));
            die;
        } else {
            $model_class = Model('micro_personal');
            $result = $model_class->modify(array('shareshow_sort'=>$new_sort),array('personal_id'=>$_GET['id']));
            if($result) {
                echo json_encode(array('result'=>TRUE,'message'=>'feiwa_common_op_succ'));
                die;
            } else {
                echo json_encode(array('result'=>FALSE,'message'=>Language::get('feiwa_common_op_fail')));
                die;
            }
        }
    }

    /**
     * ajax操作
     */
    public function ajaxFeiwa(){
        if ($_GET['branch'] == 'personal_commend') {
            if(intval($_GET['id']) > 0) {
                $model= Model('micro_personal');
                $condition['personal_id'] = intval($_GET['id']);
                $update[$_GET['column']] = trim($_GET['value']);
                $model->modify($update,$condition);
                echo 'true';die;
            } else {
                echo 'false';die;
            }
        }
    }
}
