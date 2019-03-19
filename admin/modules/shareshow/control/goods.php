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
class goodsControl extends SystemControl{

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
       $this->goods_manageFeiwa();
    }

    /**
     * 随心看管理
     */
    public function goods_manageFeiwa()
    {
        Tpl::setDirquna('shareshow');
Tpl::showpage('shareshow_goods.manage');
    }

    /**
     * 随心看管理XML
     */
    public function goods_manage_xmlFeiwa()
    {
        $condition = array();

        if ($_REQUEST['advanced']) {
            if (strlen($q = trim((string) $_REQUEST['commend_id']))) {
                $condition['commend_id'] = (int) $q;
            }
            if (strlen($q = trim((string) $_REQUEST['member_name']))) {
                $condition['member_name'] = $q;
            }
            if (strlen($q = trim((string) $_REQUEST['commend_goods_name']))) {
                $condition['commend_goods_name'] = array('like', '%' . $q . '%');
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
                    case 'commend_id':
                        $condition['commend_id'] = (int) $q;
                        break;
                    case 'member_name':
                        $condition['member_name'] = $q;
                        break;
                    case 'commend_goods_name':
                        $condition['commend_goods_name'] = array('like', '%' . $q . '%');
                        break;
                }
            }
        }

        $model_shareshow_goods = Model('micro_goods');
        $field = 'micro_goods.*,member.member_name,member.member_avatar';
        $list = (array) $model_shareshow_goods->getListWithUserInfo($condition, $_REQUEST['rp'],
            'commend_time desc', $field);

        $data = array();
        $data['now_page'] = $model_shareshow_goods->shownowpage();
        $data['total_num'] = $model_shareshow_goods->gettotalnum();

        foreach ($list as $val) {
            $o = '<a class="btn red confirm-del-on-click" href="index.php?app=goods&feiwa=goods_drop&commend_id=' .
                $val['commend_id'] .
                '"><i class="fa fa-trash-o"></i>删除</a>';

            $o .= '<span class="btn"><em><i class="fa fa-cog"></i>设置<i class="arrow"></i></em><ul>';

            if ($val['shareshow_commend'] == '1') {
                $o .= '<li><a href="javascript:;" data-ie-column="shareshow_commend" data-ie-value="0">取消推荐</a></li>';
            } else {
                $o .= '<li><a href="javascript:;" data-ie-column="shareshow_commend" data-ie-value="1">推荐商品</a></li>';
            }

            $o .= '<li><a target="_blank" href="' .
                    SHARESHOW_SITE_URL.DS.'index.php?app=goods&feiwa=detail&goods_id=' .
                    $val['commend_id'] .
                    '">查看商品</a></li>';

            $o .= '</ul></span>';

            $i = array();
            $i['operation'] = $o;
            $i['commend_id'] = $val['commend_id'];

            $i['shareshow_sort'] = '<span class="editable" title="可编辑" style="width:50px;" data-live-inline-edit="shareshow_sort">' .
                $val['shareshow_sort'] . '</span>';

            $i['commend_state'] = $val['shareshow_commend'] == 1
                ? '<span class="yes"><i class="fa fa-check-circle"></i>是</span>'
                : '<span class="no"><i class="fa fa-ban"></i>否</span>';

            $i['member_name'] = '<a target="_blank" href="' .
                SHARESHOW_SITE_URL.DS.'index.php?app=home&member_id='.$val['commend_member_id'] .
                '">' .
                $val['member_name'] .
                '</a>';

            $img = cthumb($val['commend_goods_image'], 240, $val['commend_goods_store_id']);
            $i['commend_goods_image'] = <<<EOB
<a href="javascript:;" class="pic-thumb-tip" onMouseOut="toolTip()" onMouseOver="toolTip('<img src=\'{$img}\'>')">
<i class='fa fa-picture-o'></i></a>
EOB;

            $i['commend_goods_name'] = $val['commend_goods_name'];

            $i['commend_message'] = $val['commend_message'];
            $i['commend_time_text'] = date('Y-m-d', $val['commend_time']);

            $data['list'][$val['commend_id']] = $i;
        }

        echo Tpl::flexigridXML($data);
        exit;
    }

    /**
     * 随心看删除
     */
    public function goods_dropFeiwa()
    {
        $model = Model('micro_goods');
        $condition = array();
        $condition['commend_id'] = array('in',trim($_REQUEST['commend_id']));

        //删除随心看图片
        $list = $model->getList($condition);
        if(!empty($list)) {
            foreach ($list as $info) {
                //计数
                $model_micro_member_info = Model('micro_member_info');
                $model_micro_member_info->updateMemberGoodsCount($info['commend_member_id'],'-');
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
     * 更新分享秀随心看排序
     */
    public function goods_sort_updateFeiwa() {
        if(intval($_GET['id']) <= 0) {
            echo json_encode(array('result'=>FALSE,'message'=>Language::get('param_error')));
            die;
        }
        $new_sort = intval($_GET['value']);
        if ($new_sort > 255){
            echo json_encode(array('result'=>FALSE,'message'=>Language::get('shareshow_sort_error')));
            die;
        } else {
            $model_class = Model('micro_goods');
            $result = $model_class->modify(array('shareshow_sort'=>$new_sort),array('commend_id'=>$_GET['id']));
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
        //随心看推荐
        if($_GET['branch'] == 'goods_commend') {
            if(intval($_GET['id']) > 0) {
                $model= Model('micro_goods');
                $condition['commend_id'] = intval($_GET['id']);
                $update[$_GET['column']] = trim($_GET['value']);
                $model->modify($update,$condition);
                echo 'true';die;
            } else {
                echo 'false';die;
            }
        }
    }
}
