<?php
/**
 * 限时折扣管理
 *
 *
 *
 *
 *  
 
 * @
 */



defined('INSYSVIEW') or exit('Access Invalid!');
class promotion_xianshiControl extends SystemControl{

    public function __construct(){
        parent::__construct();

        //读取语言包
        Language::read('promotion_xianshi');

        //检查审核功能是否开启
        if (intval($_GET['promotion_allow']) !== 1 && intval(C('promotion_allow')) !== 1){
            $url = array(
                array(
                    'url'=>'index.php?app=promotion_xianshi&promotion_allow=1',
                    'msg'=>Language::get('open'),
                ),
                array(
                    'url'=>'index.php?app=setting',
                    'msg'=>Language::get('close'),
                ),
            );
            showMessage(Language::get('promotion_unavailable'),$url,'html','succ',1,6000);
        }

        //自动开启限时折扣
        if (intval($_GET['promotion_allow']) === 1){
            $model_setting = Model('setting');
            $update_array = array();
            $update_array['promotion_allow'] = 1;
            $model_setting->updateSetting($update_array);
        }
    }

    /**
     * 默认Op
     */
    public function indexFeiwa() {

        $this->xianshi_listFeiwa();

    }

    /**
     * 活动列表
     */
    public function xianshi_listFeiwa()
    {
        $model_xianshi = Model('p_xianshi');
        Tpl::output('xianshi_state_array', $model_xianshi->getXianshiStateArray());

        $this->show_menu('xianshi_list');
		Tpl::setDirquna('mall');
        Tpl::showpage('promotion_xianshi.list');
    }

    /**
     * 活动列表
     */
    public function xianshi_list_xmlFeiwa()
    {
        $condition = array();

        if ($_REQUEST['advanced']) {
            if (strlen($q = trim((string) $_REQUEST['xianshi_name']))) {
                $condition['xianshi_name'] = array('like', '%' . $q . '%');
            }
            if (strlen($q = trim((string) $_REQUEST['store_name']))) {
                $condition['store_name'] = array('like', '%' . $q . '%');
            }
            if (($q = (int) $_REQUEST['state']) > 0) {
                $condition['state'] = $q;
            }

            $pdates = array();
            if (strlen($q = trim((string) $_REQUEST['pdate1'])) && ($q = strtotime($q . ' 00:00:00'))) {
                $pdates[] = "end_time >= {$q}";
            }
            if (strlen($q = trim((string) $_REQUEST['pdate2'])) && ($q = strtotime($q . ' 00:00:00'))) {
                $pdates[] = "start_time <= {$q}";
            }
            if ($pdates) {
                $condition['pdates'] = array(
                    'exp',
                    implode(' or ', $pdates),
                );
            }

        } else {
            if (strlen($q = trim($_REQUEST['query']))) {
                switch ($_REQUEST['qtype']) {
                    case 'xianshi_name':
                        $condition['xianshi_name'] = array('like', '%'.$q.'%');
                        break;
                    case 'store_name':
                        $condition['store_name'] = array('like', '%'.$q.'%');
                        break;
                }
            }
        }

        $model_xianshi = Model('p_xianshi');
        $xianshi_list = (array) $model_xianshi->getXianshiList($condition, $_REQUEST['rp'], 'state desc, end_time desc');

        $flippedOwnMallIds = array_flip(Model('store')->getOwnMallIds());

        $data = array();
        $data['now_page'] = $model_xianshi->shownowpage();
        $data['total_num'] = $model_xianshi->gettotalnum();

        foreach ($xianshi_list as $val) {
            $o  = '<a class="btn red confirm-on-click" href="javascript:;" data-href="' . urlAdminMall('promotion_xianshi', 'xianshi_del', array(
                'xianshi_id' => $val['xianshi_id'],
            )) . '"><i class="fa fa-trash-o"></i>删除</a>';

            $o .= '<span class="btn"><em><i class="fa fa-cog"></i>设置<i class="arrow"></i></em><ul>';
			
			 if ($val['recommended'] == '1') {
                $o .= '<li><a href="javascript:;" data-href="' . urlAdminMall('promotion_xianshi', 'xianshi_rec', array(
                    'xianshi_id' => $val['xianshi_id'],
                    'rec' => 0,
                )) . '">取消推荐</a></li>';
            } else {
                $o .= '<li><a href="javascript:;" data-href="' . urlAdminMall('promotion_xianshi', 'xianshi_rec', array(
                    'xianshi_id' => $val['xianshi_id'],
                    'rec' => 1,
                )) . '">推荐活动</a></li>';
            }

            if ($val['editable']) {
                $o .= '<li><a class="confirm-on-click" href="javascript:;" data-href="' . urlAdminMall('promotion_xianshi', 'xianshi_cancel', array(
                    'xianshi_id' => $val['xianshi_id'],
                )) . '">取消活动</a></li>';
            }

            $o .= '<li><a class="confirm-on-click" href="' . urlAdminMall('promotion_xianshi', 'xianshi_detail', array(
                'xianshi_id' => $val['xianshi_id'],
            )) . '">活动详细</a></li>';

            $o .= '</ul></span>';

            $i = array();
            $i['operation'] = $o;
            $i['xianshi_name'] = $val['xianshi_name'];
            $i['store_name'] = '<a target="_blank" href="' . urlMall('show_store', 'index', array(
                'store_id'=>$val['store_id'],
            )) . '">' . $val['store_name'] . '</a>';

            if (isset($flippedOwnMallIds[$val['store_id']])) {
                $i['store_name'] .= '<span class="ownmall">[自营]</span>';
            }

            $i['start_time_text'] = date('Y-m-d H:i', $val['start_time']);
            $i['end_time_text'] = date('Y-m-d H:i', $val['end_time']);

            $i['lower_limit'] = $val['lower_limit'];
            $i['xianshi_state_text'] = $val['xianshi_state_text'];

            $data['list'][$val['xianshi_id']] = $i;
        }

        echo Tpl::flexigridXML($data);
        exit;
    }

    /**
     * 限时折扣活动取消
     **/
    public function xianshi_cancelFeiwa() {
        $xianshi_id = intval($_REQUEST['xianshi_id']);
        $model_xianshi = Model('p_xianshi');
        $result = $model_xianshi->cancelXianshi(array('xianshi_id' => $xianshi_id));
        if($result) {
            $this->log('取消限时折扣活动，活动编号'.$xianshi_id);

            $this->jsonOutput();
        } else {
            $this->jsonOutput('操作失败');
        }
    }

    /**
     * 限时折扣活动删除
     **/
    public function xianshi_delFeiwa() {
        $xianshi_id = intval($_REQUEST['xianshi_id']);
        $model_xianshi = Model('p_xianshi');
        $result = $model_xianshi->delXianshi(array('xianshi_id' => $xianshi_id));
        if($result) {
            $this->log('删除限时折扣活动，活动编号'.$xianshi_id);

            $this->jsonOutput();
        } else {
            $this->jsonOutput('操作失败');
        }
    }
	
	
	    /**
     * 推荐
     */
    public function xianshi_recFeiwa()
    {
        $model= Model('p_xianshi');
        $update_array['recommended'] = $_GET['rec'] == '1' ? 1 : 0;
        $where_array['xianshi_id'] = $_GET['xianshi_id'];
        $result = $model->editXianshi($update_array, $where_array);

        if ($result) {
            $this->jsonOutput();
        } else {
            $this->jsonOutput('操作失败');
        }
    }
	

    /**
     * 活动详细信息
     **/
    public function xianshi_detailFeiwa() {
        $xianshi_id = intval($_GET['xianshi_id']);

        $model_xianshi = Model('p_xianshi');
        $model_xianshi_goods = Model('p_xianshi_goods');

        $xianshi_info = $model_xianshi->getXianshiInfoByID($xianshi_id);
        if(empty($xianshi_info)) {
            showMessage(L('param_error'));
        }
        Tpl::output('xianshi_info',$xianshi_info);

        //获取限时折扣商品列表
        $condition = array();
        $condition['xianshi_id'] = $xianshi_id;
        $xianshi_goods_list = $model_xianshi_goods->getXianshiGoodsExtendList($condition);
        Tpl::output('list',$xianshi_goods_list);

        $this->show_menu('xianshi_detail');
		Tpl::setDirquna('mall');
        Tpl::showpage('promotion_xianshi.detail');
    }

    /**
     * 套餐管理
     */
    public function xianshi_quotaFeiwa()
    {
        $this->show_menu('xianshi_quota');
		Tpl::setDirquna('mall');
        Tpl::showpage('promotion_xianshi_quota.list');
    }

    /**
     * 套餐管理XML
     */
    public function xianshi_quota_xmlFeiwa()
    {
        $condition = array();

        if (strlen($q = trim($_REQUEST['query']))) {
            switch ($_REQUEST['qtype']) {
                case 'store_name':
                    $condition['store_name'] = array('like', '%'.$q.'%');
                    break;
            }
        }

        $model_xianshi_quota = Model('p_xianshi_quota');
        $list = (array) $model_xianshi_quota->getXianshiQuotaList($condition, $_REQUEST['rp'], 'end_time desc');

        $data = array();
        $data['now_page'] = $model_xianshi_quota->shownowpage();
        $data['total_num'] = $model_xianshi_quota->gettotalnum();

        foreach ($list as $val) {
            $i = array();
            $i['operation'] = '<span>--</span>';

            $i['store_name'] = '<a target="_blank" href="' . urlMall('show_store', 'index', array(
                'store_id' => $val['store_id'],
            )) . '">' . $val['store_name'] . '</a>';

            $i['start_time_text'] = date("Y-m-d", $val['start_time']);
            $i['end_time_text'] = date("Y-m-d", $val['end_time']);

            $data['list'][$val['quota_id']] = $i;
        }

        echo Tpl::flexigridXML($data);
        exit;
    }

   /**
     * 淘特卖类别列表
     */
    public function class_listFeiwa() {

        $model_xianshi_class = Model('p_xianshi_class');
        $param = array();
        $param['order'] = 'sort asc';
        $xianshi_class_list = $model_xianshi_class->getTreeList($param);

        $this->show_menu('class_list');
        Tpl::output('list',$xianshi_class_list);
		    	
		Tpl::setDirquna('mall');
        Tpl::showpage('promotion_xianshi_class.list');
    }

    /**
     * 添加淘特卖分类页面
     */
    public function class_addFeiwa() {

        $model_xianshi_class = Model('p_xianshi_class');
        $param = array();
        $param['order'] = 'sort asc';
        $xianshi_class_list = $model_xianshi_class->getList($param);
        Tpl::output('list',$xianshi_class_list);

        $this->show_menu('class_add');
		
		Tpl::setDirquna('mall');
        Tpl::showpage('promotion_xianshi_class.add');

    }

    /**
     * 保存添加的淘特卖类别
     */
    public function class_saveFeiwa() {

        $class_id = intval($_POST['class_id']);
        $param = array();
        $param['class_name'] = trim($_POST['input_class_name']);
        if(empty($param['class_name'])) {
            showMessage(Language::get('class_name_error'),'');
        }
        $param['sort'] = intval($_POST['input_sort']);

        $model_xianshi_class = Model('p_xianshi_class');

        if(empty($class_id)) {
            //新增
            if ($class_id = $model_xianshi_class->save($param)) {
                $this->log('新增成功'.'[ID:'.$class_id.']', null);
                showMessage(新增成功,'index.php?app=promotion_xianshi&feiwa=class_list');
            }
            else {
                showMessage(新增失败,'index.php?app=promotion_xianshi&feiwa=class_list');
            }
        }
        else {
            //编辑
            if($model_xianshi_class->updates($param,array('class_id'=>$class_id))) {
                $this->log(L('groupbuy_class_edit_success').'[ID:'.$class_id.']', null);
                showMessage('编辑成功','index.php?app=promotion_xianshi&feiwa=class_list');
            }
            else {
                showMessage('编辑失败','index.php?app=promotion_xianshi&feiwa=class_list');
            }
        }

    }

    /**
     * 删除抢购类别
     */
    public function class_dropFeiwa() {

        $class_id = trim($_POST['class_id']);
        if(empty($class_id)) {
            showMessage(Language::get('param_error'),'');
        }

        $model_xianshi_class = Model('p_xianshi_class');
        //获得所有下级类别编号
        $all_class_id = $model_groupbuy_class->getAllClassId(explode(',',$class_id));
        $param = array();
        $param['in_class_id'] = implode(',',$all_class_id);
        if($model_xianshi_class->drop($param)) {


            $this->log(L('groupbuy_class_drop_success').'[ID:'.$param['in_class_id'].']',null);
            showMessage(Language::get('groupbuy_class_drop_success'),'');
        }
        else {
            showMessage(123,'');
        }

    }

   public function class_sort_updateFeiwa()
    {
        $update_array = array();
        $where_array = array();

        $model= Model('p_xianshi_class');
        $update_array['sort'] = $_GET['value'];
        $where_array['class_id'] = $_GET['id'];
        $result = $model->updates($update_array, $where_array);

        $this->jsonOutput();
    }

    public function class_name_updateFeiwa()
    {
        $update_array = array();
        $where_array = array();

        $model= Model('p_xianshi_class');
        $update_array['class_name'] = $_GET['value'];
        $where_array['class_id'] = $_GET['id'];
        $result = $model->updates($update_array, $where_array);

        $this->log(L('groupbuy_class_edit_success').'[ID:'.$_GET['id'].']', null);

        $this->jsonOutput();
    }

    /**
     * 设置
     **/
    public function xianshi_settingFeiwa() {

        $model_setting = Model('setting');
        $setting = $model_setting->GetListSetting();
        Tpl::output('setting',$setting);

        $this->show_menu('xianshi_setting');
		Tpl::setDirquna('mall');
        Tpl::showpage('promotion_xianshi.setting');
    }

    public function xianshi_setting_saveFeiwa() {

        $promotion_xianshi_price = intval($_POST['promotion_xianshi_price']);
        if($promotion_xianshi_price < 0) {
            $promotion_xianshi_price = 20;
        }

        $model_setting = Model('setting');
        $update_array = array();
        $update_array['promotion_xianshi_price'] = $promotion_xianshi_price;

        $result = $model_setting->updateSetting($update_array);
        if ($result){
            $this->log('修改限时折扣价格为'.$promotion_xianshi_price.'元');
            showMessage(Language::get('setting_save_success'),'');
        }else {
            showMessage(Language::get('setting_save_fail'),'');
        }
    }
	/*
	 * 限时折扣幻灯
	 */
	  public function adv_manageFeiwa(){
        $model_setting = Model('setting');
        if (chksubmit()){
            $input = array();
            //上传图片
            $upload = new UploadFile();
            $upload->set('default_dir',ATTACH_LOGIN);
            $upload->set('thumb_ext',   '');
            $upload->set('file_name','p1.jpg');
            $upload->set('ifremove',false);
            if (!empty($_FILES['adv_pic1']['name'])){
                $result = $upload->upfile('adv_pic1');
                if (!$result){
                    showMessage($upload->error,'','','error');
                }else{
                    $input[1]['pic'] = $upload->file_name;
                    $input[1]['url'] = $_POST['adv_url1'];
                }
            }elseif ($_POST['old_adv_pic1'] != ''){
                $input[1]['pic'] = $_POST['old_adv_pic1'];
                $input[1]['url'] = $_POST['adv_url1'];
            }

            $upload->set('default_dir',ATTACH_LOGIN);
            $upload->set('thumb_ext',   '');
            $upload->set('file_name','p2.jpg');
            $upload->set('ifremove',false);
            if (!empty($_FILES['adv_pic2']['name'])){
                $result = $upload->upfile('adv_pic2');
                if (!$result){
                    showMessage($upload->error,'','','error');
                }else{
                    $input[2]['pic'] = $upload->file_name;
                    $input[2]['url'] = $_POST['adv_url2'];
                }
            }elseif ($_POST['old_adv_pic2'] != ''){
                $input[2]['pic'] = $_POST['old_adv_pic2'];
                $input[2]['url'] = $_POST['adv_url2'];
            }

            $upload->set('default_dir',ATTACH_LOGIN);
            $upload->set('thumb_ext', '');
            $upload->set('file_name', 'p3.jpg');
            $upload->set('ifremove', false);
            if (!empty($_FILES['adv_pic3']['name'])){
                $result = $upload->upfile('adv_pic3');
                if (!$result){
                    showMessage($upload->error,'','','error');
                }else{
                    $input[3]['pic'] = $upload->file_name;
                    $input[3]['url'] = $_POST['adv_url3'];
                }
            }elseif ($_POST['old_adv_pic3'] != ''){
                $input[3]['pic'] = $_POST['old_adv_pic3'];
                $input[3]['url'] = $_POST['adv_url3'];
            }

            $update_array = array();
            if (count($input) > 0){
                $update_array['promotion_xspic'] = serialize($input);
            }

            $result = $model_setting->updateSetting($update_array);
            if ($result === true){
                $this->log(L('feiwa_edit,loginSettings'),1);
                showMessage(L('feiwa_common_save_succ'));
            }else {
                $this->log(L('feiwa_edit,loginSettings'),0);
                showMessage(L('feiwa_common_save_fail'));
            }
        }
        $list_setting = $model_setting->getListSetting();
        if ($list_setting['promotion_xspic'] != ''){
            $list = unserialize($list_setting['promotion_xspic']);
        }
        Tpl::output('list', $list);
        $this->show_menu('adv_manage'); 
       Tpl::setDirquna('mall');
       Tpl::showpage('promotion_xs_adv.setting');
    }

    /**
     * ajax修改团购信息
     */
    public function ajaxFeiwa(){
        $result = true;
        $update_array = array();
        $where_array = array();

        switch ($_GET['branch']){
         case 'recommend':
            $model= Model('p_xianshi_goods');
            $update_array['xianshi_recommend'] = $_GET['value'];
            $where_array['xianshi_goods_id'] = $_GET['id'];
            $result = $model->editXianshiGoods($update_array, $where_array);
            break;
        }

        if($result) {
            echo 'true';exit;
        } else {
            echo 'false';exit;
        }

    }


    /*
     * 发送消息
     */
    private function send_message($member_id,$member_name,$message) {
        $param = array();
        $param['from_member_id'] = 0;
        $param['member_id'] = $member_id;
        $param['to_member_name'] = $member_name;
        $param['message_type'] = '1';//表示为系统消息
        $param['msg_content'] = $message;
        $model_message = Model('message');
        return $model_message->saveMessage($param);
    }

    /**
     * 页面内导航菜单
     *
     * @param string    $menu_key   当前导航的menu_key
     * @param array     $array      附加菜单
     * @return
     */
    private function show_menu($menu_key) {
        $menu_array = array(
            'xianshi_list'=>array('menu_type'=>'link','menu_name'=>Language::get('xianshi_list'),'menu_url'=>'index.php?app=promotion_xianshi&feiwa=xianshi_list'),
            'xianshi_detail'=>array('menu_type'=>'link','menu_name'=>Language::get('xianshi_detail'),'menu_url'=>'index.php?app=promotion_xianshi&feiwa=xianshi_detail'),
            'xianshi_quota'=>array('menu_type'=>'link','menu_name'=>Language::get('xianshi_quota'),'menu_url'=>'index.php?app=promotion_xianshi&feiwa=xianshi_quota'),
            'xianshi_setting'=>array('menu_type'=>'link','menu_name'=>Language::get('xianshi_setting'),'menu_url'=>'index.php?app=promotion_xianshi&feiwa=xianshi_setting'),
            'adv_manage'=>array('menu_type'=>'link','menu_name'=>'淘特卖幻灯','menu_url'=>'index.php?app=promotion_xianshi&feiwa=adv_manage'),
            'class_list'=>array('menu_type'=>'link','menu_name'=>'淘特卖分类','menu_url'=>'index.php?app=promotion_xianshi&feiwa=class_list'),
        );
        if($menu_key != 'xianshi_detail') unset($menu_array['xianshi_detail']);
        $menu_array[$menu_key]['menu_type'] = 'text';
        Tpl::output('menu',$menu_array);
    }

}
