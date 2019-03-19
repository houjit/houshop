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
class storeControl extends SystemControl{

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
       $this->store_manageFeiwa();
    }



    /**
     * 店铺管理
     */
    public function store_manageFeiwa()
    {
        $this->show_menu_store('store_manage');
        Tpl::setDirquna('shareshow');
Tpl::showpage('shareshow_store.manage');
    }

    /**
     * 店铺管理
     */
    public function store_manage_xmlFeiwa()
    {
        $condition = array();
        if (strlen($q = trim($_REQUEST['query'])) > 0) {
            switch ($_REQUEST['qtype']) {
                case 'store_name':
                    $condition['store_name'] = array('like', '%' . $q . '%');
                    break;
                case 'member_name':
                    $condition['member_name'] = array('like', '%' . $q . '%');
                    break;
            }
        }

        $model_store = Model('micro_store');
        $list = (array) $model_store->getListWithStoreInfo($condition, $_REQUEST['rp']);

        $data = array();
        $data['now_page'] = $model_store->shownowpage();
        $data['total_num'] = $model_store->gettotalnum();

        foreach ($list as $val) {
            $o = '<a class="btn red confirm-del-on-click" href="index.php?app=store&feiwa=store_drop_save&store_id=' .
                $val['store_id'] .
                '"><i class="fa fa-trash"></i>删除</a>';

            if ($val['shareshow_commend'] == 1) {
                $o .= '<a class="btn green" href="javascript:;" data-ie-column="shareshow_commend" data-ie-value="0"><i class="fa fa-thumbs-o-down"></i>取消推荐</a>';
            } else {
                $o .= '<a class="btn green" href="javascript:;" data-ie-column="shareshow_commend" data-ie-value="1"><i class="fa fa-thumbs-o-up"></i>推荐店铺</a>';
            }

            $i = array();
            $i['operation'] = $o;

            $i['shareshow_sort'] = '<span class="editable" title="可编辑" style="width:50px;" data-live-inline-edit="shareshow_sort">' .
                $val['shareshow_sort'] . '</span>';

            $i['store_name'] = '<a target="_blank" href="' .
                SHARESHOW_SITE_URL.DS.
                'index.php?app=store&feiwa=detail&store_id=' .
                $val['store_id'] .
                '">' .
                $val['store_name'] .
                '</a>';

            $i['member_name'] = '<a href="' .
                SHARESHOW_SITE_URL.DS.
                'index.php?app=home&member_id=' .
                $val['member_id'] .
                '">' .
                $val['member_name'] .
                '</a>';

            $i['area_info'] = $val['area_info'];

            $i['store_end_time_text'] = $val['store_end_time'] > 0
                ? date('Y-m-d H:i:s', $val['store_end_time'])
                : L('no_limit');

            $i['added_state'] = $val['shareshow_commend'] == 1
                ? '<span class="yes"><i class="fa fa-check-circle"></i>是</span>'
                : '<span class="no"><i class="fa fa-ban"></i>否</span>';

            $data['list'][$val['store_id']] = $i;
        }

        echo Tpl::flexigridXML($data);
        exit;
    }


    /**
     * 店铺街添加列表
     */
    public function store_addFeiwa()
    {
        $this->show_menu_store('store_add');
        Tpl::setDirquna('shareshow');
Tpl::showpage('shareshow_store.add');
    }

    /**
     * 店铺街添加列表
     */
    public function store_add_xmlFeiwa()
    {
        $model_store = Model('store');
        $model_shareshow_store = Model('micro_store');

        $shareshow_store_list = $model_shareshow_store->getList(TRUE);
        $shareshow_store_array = array();
        if (!empty($shareshow_store_list)) {
            foreach ($shareshow_store_list as $value) {
                $shareshow_store_array[] = $value['mall_store_id'];
            }
        }

        $condition = array();
        if (strlen($q = trim($_REQUEST['query'])) > 0) {
            switch ($_REQUEST['qtype']) {
                case 'store_name':
                    $condition['store_name'] = array('like', '%' . $q . '%');
                    break;
                case 'member_name':
                    $condition['member_name'] = array('like', '%' . $q . '%');
                    break;
            }
        }

        $list = (array) $model_store->getStoreOnlineList($condition, $_REQUEST['rp']);

        $data = array();
        $data['now_page'] = $model_store->shownowpage();
        $data['total_num'] = $model_store->gettotalnum();

        foreach ($list as $val) {
            $addedState = in_array($val['store_id'], $shareshow_store_array);

            if ($addedState) {
                $o = '--';
            } else {
                $o = '<a class="btn green" href="index.php?app=store&feiwa=store_add_save&store_id=' .
                    $val['store_id'] .
                    '"><i class="fa fa-plus"></i>添加</a>';
            }

            $i = array();
            $i['operation'] = $o;
            $i['store_name'] = '<a href="' .
                urlMall('show_store', 'index', array('store_id' => $val['store_id'])) .
                '">' .
                $val['store_name'] .
                '</a>';

            $i['member_name'] = $val['member_name'];
            $i['area_info'] = $val['area_info'];

            $i['store_end_time_text'] = $val['store_end_time'] > 0
                ? date('Y-m-d H:i:s', $val['store_end_time'])
                : L('no_limit');

            $i['added_state'] = $addedState
                ? '<span class="yes"><i class="fa fa-check-circle"></i>是</span>'
                : '<span class="no"><i class="fa fa-ban"></i>否</span>';

            $data['list'][$val['store_id']] = $i;
        }

        echo Tpl::flexigridXML($data);
        exit;
    }

    /**
     * 店铺街添加保存
     */
    public function store_add_saveFeiwa()
    {
        $store_id_array = explode(',', $_REQUEST['store_id']);
        $param = array();
        if(!empty($store_id_array)) {
            foreach ($store_id_array as $value) {
                if(intval($value) > 0) {
                    $shareshow_store['mall_store_id'] = $value;
                    $shareshow_store['shareshow_sort'] = 255;
                    $shareshow_store['shareshow_commend'] = 0;
                    $param[] = $shareshow_store;
                }
            }
        }
        $model_store = Model('micro_store');
        $result = $model_store->saveAll($param);
        if($result) {
            showMessage(Language::get('feiwa_common_op_succ'),'');
        } else {
            showMessage(Language::get('feiwa_common_op_fail'),'','','error');
        }
    }

    /**
     * 店铺街删除保存
     */
    public function store_drop_saveFeiwa() {
        $model_store = Model('micro_store');
        $condition = array();
        $condition['mall_store_id'] = array('in',trim($_REQUEST['store_id']));
        $result = $model_store->drop($condition);
        if($result) {
            showMessage(Language::get('feiwa_common_del_succ'),'');
        } else {
            showMessage(Language::get('feiwa_common_del_fail'),'','','error');
        }
    }

    /**
     * 更新分享秀店铺排序
     */
    public function store_sort_updateFeiwa() {
        if(intval($_GET['id']) <= 0) {
            echo json_encode(array('result'=>FALSE,'message'=>Language::get('param_error')));
            die;
        }
        $new_sort = intval($_GET['value']);
        if ($new_sort > 255){
            echo json_encode(array('result'=>FALSE,'message'=>Language::get('shareshow_sort_error')));
            die;
        } else {
            $model_class = Model('micro_store');
            $result = $model_class->modify(array('shareshow_sort'=>$new_sort),array('mall_store_id'=>$_GET['id']));
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
        //店铺街推荐
        if ($_GET['branch'] == 'store_commend') {
            if(intval($_GET['id']) > 0) {
                $model= Model('micro_store');
                $condition['mall_store_id'] = intval($_GET['id']);
                $update[$_GET['column']] = trim($_GET['value']);
                $model->modify($update,$condition);
                echo 'true';die;
            } else {
                echo 'false';die;
            }
        }
    }
    private function show_menu_store($menu_key) {
        $menu_array = array(
                'store_manage'=>array('menu_type'=>'link','menu_name'=>Language::get('feiwa_manage'),'menu_url'=>'index.php?app=store&feiwa=store_manage'),
                'store_add'=>array('menu_type'=>'link','menu_name'=>Language::get('feiwa_new'),'menu_url'=>'index.php?app=store&feiwa=store_add'),
        );
        $menu_array[$menu_key]['menu_type'] = 'text';
        Tpl::output('menu',$menu_array);
    }
}
