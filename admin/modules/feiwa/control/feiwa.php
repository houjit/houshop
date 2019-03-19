<?php
/**
 *运营控件管理
 *客服QQ
 */
defined('INSYSVIEW') or exit('Access Invalid!');
class feiwaControl extends SystemControl{
	 private $links = array(
	    array('url'=>'app=feiwa&feiwa=base','lang'=>'sys_set'),
        array('url'=>'app=feiwa&feiwa=banner','lang'=>'top_set'),
        array('url'=>'app=feiwa&feiwa=lc','lang'=>'lc_set'),
		array('url'=>'app=feiwa&feiwa=sms','lang'=>'sms_set'),
		array('url'=>'app=feiwa&feiwa=rc','lang'=>'rc_set'),
		array('url'=>'app=feiwa&feiwa=city','lang'=>'city_set'),
		array('url'=>'app=feiwa&feiwa=webchat','lang'=>'webchat_set'),
		array('url'=>'app=feiwa&feiwa=crontab','lang'=>'crontab'),
        
    );
	public function __construct(){
		parent::__construct();
		Language::read('feiwa,setting');
	}
	    public function indexFeiwa() {
        $this->baseFeiwa();
    }
		 /**
     * 基本信息
     */
    public function baseFeiwa(){
        $model_setting = Model('setting');
        if (chksubmit()){
            $list_setting = $model_setting->getListSetting();
            $update_array = array();
            $update_array['feiwa_stitle'] = $_POST['feiwa_stitle'];
            $update_array['feiwa_phone'] = $_POST['feiwa_phone'];
            $update_array['feiwa_time'] = $_POST['feiwa_time'];
			$update_array['feiwa_index_brand'] = $_POST['feiwa_index_brand'];
			$update_array['feiwa_index_store'] = $_POST['feiwa_index_store'];
			$update_array['feiwa_index_goods'] = $_POST['feiwa_index_goods'];
			$update_array['feiwa_default_city'] = $_POST['feiwa_default_city'];
			$update_array['feiwa_invite2'] = $_POST['feiwa_invite2'];
			$update_array['feiwa_invite3'] = $_POST['feiwa_invite3'];
            $result = $model_setting->updateSetting($update_array);
            if ($result === true){
                $this->log(L('feiwa_edit,feiwa_set'),1);
                showMessage(L('feiwa_common_save_succ'));
            }else {
                $this->log(L('feiwa_edit,feiwa_set'),0);
                showMessage(L('feiwa_common_save_fail'));
            }
        }
        $list_setting = $model_setting->getListSetting();

        Tpl::output('list_setting',$list_setting);

        //输出子菜单
        Tpl::output('top_link',$this->sublink($this->links,'base'));
		
		Tpl::setDirquna('feiwa');
        Tpl::showpage('feiwa.base');
    }
	 /**
     * 顶部广告信息
     */
    public function bannerFeiwa(){
        $model_setting = Model('setting');
        if (chksubmit()){
			 if (!empty($_FILES['feiwa_top_banner_pic']['name'])){
                $upload = new UploadFile();
                $upload->set('default_dir',ATTACH_COMMON);
                $result = $upload->upfile('feiwa_top_banner_pic');
                if ($result){
                    $_POST['feiwa_top_banner_pic'] = $upload->file_name;
                }else {
                    showMessage($upload->error,'','','error');
                }
            }
            $list_setting = $model_setting->getListSetting();
            $update_array = array();
            $update_array['feiwa_top_banner_name'] = $_POST['top_banner_name'];
            $update_array['feiwa_top_banner_url'] = $_POST['top_banner_url'];
            $update_array['feiwa_top_banner_color'] = $_POST['top_banner_color'];
            $update_array['feiwa_top_banner_status'] = $_POST['top_banner_status'];
			if (!empty($_POST['feiwa_top_banner_pic'])){
                $update_array['feiwa_top_banner_pic'] = $_POST['feiwa_top_banner_pic'];
            }
            $result = $model_setting->updateSetting($update_array);
			if ($result === true){
                //判断有没有之前的图片，如果有则删除
                if (!empty($list_setting['feiwa_top_banner_pic']) && !empty($_POST['feiwa_top_banner_pic'])){
                    @unlink(BASE_UPLOAD_PATH.DS.ATTACH_COMMON.DS.$list_setting['feiwa_top_banner_pic']);
                }
                $this->log(L('feiwa_edit,top_set'),1);
                showMessage(L('feiwa_common_save_succ'));
            }else {
                $this->log(L('feiwa_edit,top_set'),0);
                showMessage(L('feiwa_common_save_fail'));
            }
        }
         
        $list_setting = $model_setting->getListSetting();

        Tpl::output('list_setting',$list_setting);

        //输出子菜单
        Tpl::output('top_link',$this->sublink($this->links,'banner'));
		
		Tpl::setDirquna('feiwa');
        Tpl::showpage('feiwa.banner');
    }
	
	 /**
     * 楼层快速直达列表
     */
    public function lcFeiwa() {
        $model_setting = Model('setting');
        $lc_info = $model_setting->getRowSetting('feiwa_lc');
        if ($lc_info !== false) {
            $lc_list = @unserialize($lc_info['value']);
        }
        if (!$lc_list && !is_array($lc_list)) {
            $lc_list = array();
        }
        Tpl::output('lc_list',$lc_list);
        Tpl::output('top_link',$this->sublink($this->links,'lc'));
		Tpl::setDirquna('feiwa');
        Tpl::showpage('feiwa.lc');
    }

    /**
     * 楼层快速直达添加
     */
    public function lc_addFeiwa() {
        $model_setting = Model('setting');
        $lc_info = $model_setting->getRowSetting('feiwa_lc');
        if ($lc_info !== false) {
            $lc_list = @unserialize($lc_info['value']);
        }
        if (!$lc_list && !is_array($lc_list)) {
            $lc_list = array();
        }
        if (chksubmit()) {
            if (count($lc_list) >= 8) {
                showMessage('最多可设置8个楼层','index.php?app=feiwa&feiwa=lc');
            }
            if ($_POST['lc_name'] != '' && $_POST['lc_value'] != '') {
                $data = array('name'=>stripslashes($_POST['lc_name']),'value'=>stripslashes($_POST['lc_value']));
                array_unshift($lc_list, $data);
            }
            $result = $model_setting->updateSetting(array('feiwa_lc'=>serialize($lc_list)));
            if ($result){
                showMessage('保存成功','index.php?app=feiwa&feiwa=lc');
            }else {
                showMessage('保存失败');
            }
        }
		Tpl::setDirquna('feiwa');

        Tpl::showpage('feiwa.lc_add');
    }

    /**
     * 删除
     */
    public function lc_delFeiwa() {
        $model_setting = Model('setting');
        $lc_info = $model_setting->getRowSetting('feiwa_lc');
        if ($lc_info !== false) {
            $lc_list = @unserialize($lc_info['value']);
        }
        if (!empty($lc_list) && is_array($lc_list) && intval($_GET['id']) >= 0) {
            unset($lc_list[intval($_GET['id'])]);
        }
        if (!is_array($lc_list)) {
            $lc_list = array();
        }
        $result = $model_setting->updateSetting(array('feiwa_lc'=>serialize(array_values($lc_list))));
        if ($result){
            showMessage('删除成功');
        }
        showMessage('删除失败');
    }

    /**
     * 编辑
     */
    public function lc_editFeiwa() {
        $model_setting = Model('setting');
        $lc_info = $model_setting->getRowSetting('feiwa_lc');
        if ($lc_info !== false) {
            $lc_list = @unserialize($lc_info['value']);
        }
        if (!is_array($lc_list)) {
            $lc_list = array();
        }
        if (!chksubmit()) {
            if (!empty($lc_list) && is_array($lc_list) && intval($_GET['id']) >= 0) {
                $current_info = $lc_list[intval($_GET['id'])];
            }
            Tpl::output('current_info',is_array($current_info) ? $current_info : array());
			Tpl::setDirquna('feiwa');
            Tpl::showpage('feiwa.lc_add');
        } else {
            if ($_POST['lc_name'] != '' && $_POST['lc_value'] != '' && $_POST['id'] != '' && intval($_POST['id']) >= 0) {
                $lc_list[intval($_POST['id'])] = array('name'=>stripslashes($_POST['lc_name']),'value'=>stripslashes($_POST['lc_value']));
            }
            $result = $model_setting->updateSetting(array('feiwa_lc'=>serialize($lc_list)));
            if ($result){
                showMessage('编辑成功','index.php?app=feiwa&feiwa=lc');
            }
            showMessage('编辑失败');
        }


    }
	
	/**
     * 首页热门关键词链接
     */
    public function rcFeiwa() {
        $model_setting = Model('setting');
        $rc_info = $model_setting->getRowSetting('feiwa_rc');
        if ($rc_info !== false) {
            $rc_list = @unserialize($rc_info['value']);
        }
        if (!$rc_list && !is_array($rc_list)) {
            $rc_list = array();
        }
        Tpl::output('rc_list',$rc_list);
        Tpl::output('top_link',$this->sublink($this->links,'rc'));
		Tpl::setDirquna('feiwa');
        Tpl::showpage('feiwa.rc');
    }

    /**
     * 楼层快速直达添加
     */
    public function rc_addFeiwa() {
        $model_setting = Model('setting');
        $rc_info = $model_setting->getRowSetting('feiwa_rc');
        if ($rc_info !== false) {
            $rc_list = @unserialize($rc_info['value']);
        }
        if (!$rc_list && !is_array($rc_list)) {
            $rc_list = array();
        }
        if (chksubmit()) {
            if (count($rc_list) >= 8) {
                showMessage('最多可设置8个楼层','index.php?app=feiwa&feiwa=rc');
            }
            if ($_POST['rc_name'] != '' && $_POST['rc_value'] != '' && $_POST['rc_blod'] != '') {
                $data = array('name'=>stripslashes($_POST['rc_name']),'value'=>stripslashes($_POST['rc_value']),'is_blod'=>stripslashes($_POST['rc_blod']));
                array_unshift($rc_list, $data);
            }
            $result = $model_setting->updateSetting(array('feiwa_rc'=>serialize($rc_list)));
            if ($result){
                showMessage('保存成功','index.php?app=feiwa&feiwa=rc');
            }else {
                showMessage('保存失败');
            }
        }
		Tpl::setDirquna('feiwa');

        Tpl::showpage('feiwa.rc_add');
    }

    /**
     * 删除
     */
    public function rc_delFeiwa() {
        $model_setting = Model('setting');
        $rc_info = $model_setting->getRowSetting('feiwa_rc');
        if ($rc_info !== false) {
            $rc_list = @unserialize($rc_info['value']);
        }
        if (!empty($rc_list) && is_array($rc_list) && intval($_GET['id']) >= 0) {
            unset($rc_list[intval($_GET['id'])]);
        }
        if (!is_array($rc_list)) {
            $rc_list = array();
        }
        $result = $model_setting->updateSetting(array('feiwa_rc'=>serialize(array_values($rc_list))));
        if ($result){
            showMessage('删除成功');
        }
        showMessage('删除失败');
    }

    /**
     * 编辑
     */
    public function rc_editFeiwa() {
        $model_setting = Model('setting');
        $rc_info = $model_setting->getRowSetting('feiwa_rc');
        if ($rc_info !== false) {
            $rc_list = @unserialize($rc_info['value']);
        }
        if (!is_array($rc_list)) {
            $rc_list = array();
        }
        if (!chksubmit()) {
            if (!empty($rc_list) && is_array($rc_list) && intval($_GET['id']) >= 0) {
                $current_info = $rc_list[intval($_GET['id'])];
            }
            Tpl::output('current_info',is_array($current_info) ? $current_info : array());
			Tpl::setDirquna('feiwa');
            Tpl::showpage('feiwa.rc_add');
        } else {
            if ($_POST['rc_name'] != '' && $_POST['rc_value'] != '' && $_POST['rc_blod'] != '' && $_POST['id'] != '' && intval($_POST['id']) >= 0) {
                $rc_list[intval($_POST['id'])] = array('name'=>stripslashes($_POST['rc_name']),'value'=>stripslashes($_POST['rc_value']),'is_blod'=>stripslashes($_POST['rc_blod']));
            }
            $result = $model_setting->updateSetting(array('feiwa_rc'=>serialize($rc_list)));
            if ($result){
                showMessage('编辑成功','index.php?app=feiwa&feiwa=rc');
            }
            showMessage('编辑失败');
        }


    }



	/**
     * 城市开通列表
     */
    public function cityFeiwa() {
        $model_setting = Model('setting');
        $city_info = $model_setting->getRowSetting('feiwa_city');
        if ($city_info !== false) {
            $city_list = @unserialize($city_info['value']);
        }
        if (!$city_list && !is_array($city_list)) {
            $city_list = array();
        }
        Tpl::output('city_list',$city_list);
        Tpl::output('top_link',$this->sublink($this->links,'city'));
		Tpl::setDirquna('feiwa');
        Tpl::showpage('feiwa.city');
    }

    /**
     * 楼层快速直达添加
     */
    public function city_addFeiwa() {
        $model_setting = Model('setting');
        $city_info = $model_setting->getRowSetting('feiwa_city');
        if ($city_info !== false) {
            $city_list = @unserialize($city_info['value']);
        }
        if (!$city_list && !is_array($city_list)) {
            $city_list = array();
        }
        if (chksubmit()) {
            if (count($city_list) >= 20) {
                showMessage('最多可设置20个城市','index.php?app=feiwa&feiwa=city');
            }
            if ($_POST['city_name'] != '' && $_POST['city_value'] != '' && $_POST['city_url'] != '') {
                $data = array('name'=>stripslashes($_POST['city_name']),'value'=>stripslashes($_POST['city_value']),'curl'=>stripslashes($_POST['city_url']));
                array_unshift($city_list, $data);
            }
            $result = $model_setting->updateSetting(array('feiwa_city'=>serialize($city_list)));
            if ($result){
                showMessage('保存成功','index.php?app=feiwa&feiwa=city');
            }else {
                showMessage('保存失败');
            }
        }
		Tpl::setDirquna('feiwa');

        Tpl::showpage('feiwa.city_add');
    }

    /**
     * 删除
     */
    public function city_delFeiwa() {
        $model_setting = Model('setting');
        $city_info = $model_setting->getRowSetting('feiwa_city');
        if ($city_info !== false) {
            $city_list = @unserialize($city_info['value']);
        }
        if (!empty($city_list) && is_array($city_list) && intval($_GET['id']) >= 0) {
            unset($city_list[intval($_GET['id'])]);
        }
        if (!is_array($city_list)) {
            $city_list = array();
        }
        $result = $model_setting->updateSetting(array('feiwa_city'=>serialize(array_values($city_list))));
        if ($result){
            showMessage('删除成功');
        }
        showMessage('删除失败');
    }

    /**
     * 编辑
     */
    public function city_editFeiwa() {
        $model_setting = Model('setting');
        $city_info = $model_setting->getRowSetting('feiwa_city');
        if ($city_info !== false) {
            $city_list = @unserialize($city_info['value']);
        }
        if (!is_array($city_list)) {
            $city_list = array();
        }
        if (!chksubmit()) {
            if (!empty($city_list) && is_array($city_list) && intval($_GET['id']) >= 0) {
                $current_info = $city_list[intval($_GET['id'])];
            }
            Tpl::output('current_info',is_array($current_info) ? $current_info : array());
			Tpl::setDirquna('feiwa');
            Tpl::showpage('feiwa.city_add');
        } else {
            if ($_POST['city_name'] != '' && $_POST['city_value'] != '' && $_POST['city_url'] != '' && $_POST['id'] != '' && intval($_POST['id']) >= 0) {
                $city_list[intval($_POST['id'])] = array('name'=>stripslashes($_POST['city_name']),'value'=>stripslashes($_POST['city_value']),'curl'=>stripslashes($_POST['city_url']));
            }
            $result = $model_setting->updateSetting(array('feiwa_city'=>serialize($city_list)));
            if ($result){
                showMessage('编辑成功','index.php?app=feiwa&feiwa=city');
            }
            showMessage('编辑失败');
        }


    }

		/**
	 * 短信平台设置 
	 */
	public function smsFeiwa(){
		$model_setting = Model('setting');
		if (chksubmit()){
			$update_array = array();
			$update_array['feiwa_sms_type'] 	= $_POST['feiwa_sms_type'];
			$update_array['feiwa_sms_tgs'] 	= $_POST['feiwa_sms_tgs'];
			$update_array['feiwa_sms_zh'] 	= $_POST['feiwa_sms_zh'];
			$update_array['feiwa_sms_pw'] 	= $_POST['feiwa_sms_pw'];
			$update_array['feiwa_sms_key'] 	= $_POST['feiwa_sms_key'];
			$update_array['feiwa_sms_signature'] 		= $_POST['feiwa_sms_signature'];
			$update_array['feiwa_sms_bz'] 	= $_POST['feiwa_sms_bz'];
			$result = $model_setting->updateSetting($update_array);
			if ($result === true){
				$this->log(L('feiwa_edit,sms_set'),1);
				showMessage(L('feiwa_common_save_succ'));
			}else {
				$this->log(L('feiwa_edit,sms_set'),0);
				showMessage(L('feiwa_common_save_fail'));
			}
		}
		$list_setting = $model_setting->getListSetting();
		Tpl::output('list_setting',$list_setting);
		
        Tpl::output('top_link',$this->sublink($this->links,'sms'));
		Tpl::setDirquna('feiwa');
        Tpl::showpage('feiwa.sms');
	}
			/**
	 * 默认微信公众号设置 
	 */
	public function webchatFeiwa(){
		$model_setting = Model('setting');
		if (chksubmit()){
			$update_array = array();
			$update_array['feiwa_webchat_appid'] 	= $_POST['feiwa_webchat_appid'];
			$update_array['feiwa_webchat_appsecret'] 	= $_POST['feiwa_webchat_appsecret'];
			$result = $model_setting->updateSetting($update_array);
			if ($result === true){
				$this->log(L('feiwa_edit,sms_set'),1);
				showMessage(L('feiwa_common_save_succ'));
			}else {
				$this->log(L('feiwa_edit,sms_set'),0);
				showMessage(L('feiwa_common_save_fail'));
			}
		}
		$list_setting = $model_setting->getListSetting();
		Tpl::output('list_setting',$list_setting);
		
        Tpl::output('top_link',$this->sublink($this->links,'webchat'));
		Tpl::setDirquna('feiwa');
        Tpl::showpage('feiwa.webchat');
	}
	
	/**
     * 计划任务
     */
    public function crontabFeiwa() {
        $model_setting = Model('setting');
        $crontab_info = $model_setting->getRowSetting('feiwa_crontab');
        
        //判断数据库是否存在该数据，不存在自动执行写入
        if(!$crontab_info){
         TPL::output('is_crontab','1');
        }
        
        if ($crontab_info !== false) {
            $crontab_list = @unserialize($crontab_info['value']);
        }
        if (!$crontab_list && !is_array($crontab_list)) {
            $crontab_list = array();
        }
        Tpl::output('crontab_list',$crontab_list);
        Tpl::output('top_link',$this->sublink($this->links,'crontab'));
		Tpl::setDirquna('feiwa');
        Tpl::showpage('feiwa.crontab');
    }
    
    public function is_crontabFeiwa(){
    	    $data = array();
            
    	    $insert=array();
        	$insert['name']='feiwa_crontab';
            $insert['value']='a:3:{i:0;a:3:{s:4:"name";s:3:"600";s:5:"value";s:27:"/crontab/index.php?app=date";s:10:"crontab_is";s:1:"2";}i:1;a:3:{s:4:"name";s:3:"600";s:5:"value";s:27:"/crontab/index.php?app=hour";s:10:"crontab_is";s:1:"2";}i:2;a:3:{s:4:"name";s:3:"600";s:5:"value";s:30:"/crontab/index.php?app=minutes";s:10:"crontab_is";s:1:"2";}}';
			$add=Db::insert('setting',$insert);
        	if($add){
        		$data['result'] = TRUE;
        		$data['message'] ='安装成功';
        	}else{
        		$data['result'] = FALSE;
        		$data['message'] ='安装失败';
        	}
        	echo json_encode($data);die;
    }

    /**
     * 楼层快速直达添加
     */
    public function crontab_addFeiwa() {
        $model_setting = Model('setting');
        $crontab_info = $model_setting->getRowSetting('feiwa_crontab');
        if ($crontab_info !== false) {
            $crontab_list = @unserialize($crontab_info['value']);
        }
        if (!$crontab_list && !is_array($crontab_list)) {
            $crontab_list = array();
        }
        if (chksubmit()) {
            if ($_POST['crontab_name'] != '' && $_POST['crontab_value'] != '' && $_POST['crontab_is'] != '') {
                $data = array('name'=>stripslashes($_POST['crontab_name']),'value'=>stripslashes($_POST['crontab_value']),'crontab_is'=>stripslashes($_POST['crontab_is']));
                array_unshift($crontab_list, $data);
            }
            $result = $model_setting->updateSetting(array('feiwa_crontab'=>serialize($crontab_list)));
            if ($result){
                showMessage('保存成功','index.php?app=feiwa&feiwa=crontab');
            }else {
                showMessage('保存失败');
            }
        }
		Tpl::setDirquna('feiwa');

        Tpl::showpage('feiwa.crontab_add');
    }

    /**
     * 删除
     */
    public function crontab_delFeiwa() {
        $model_setting = Model('setting');
        $crontab_info = $model_setting->getRowSetting('feiwa_crontab');
        if ($crontab_info !== false) {
            $crontab_list = @unserialize($crontab_info['value']);
        }
        if (!empty($crontab_list) && is_array($crontab_list) && intval($_GET['id']) >= 0) {
            unset($crontab_list[intval($_GET['id'])]);
        }
        if (!is_array($crontab_list)) {
            $crontab_list = array();
        }
        $result = $model_setting->updateSetting(array('feiwa_crontab'=>serialize(array_values($crontab_list))));
        if ($result){
            showMessage('删除成功');
        }
        showMessage('删除失败');
    }

    /**
     * 编辑
     */
    public function crontab_editFeiwa() {
        $model_setting = Model('setting');
        $crontab_info = $model_setting->getRowSetting('feiwa_crontab');
        if ($crontab_info !== false) {
            $crontab_list = @unserialize($crontab_info['value']);
        }
        if (!is_array($crontab_list)) {
            $crontab_list = array();
        }
        if (!chksubmit()) {
            if (!empty($crontab_list) && is_array($crontab_list) && intval($_GET['id']) >= 0) {
                $current_info = $crontab_list[intval($_GET['id'])];
            }
            Tpl::output('current_info',is_array($current_info) ? $current_info : array());
			Tpl::setDirquna('feiwa');
            Tpl::showpage('feiwa.crontab_add');
        } else {
            if ($_POST['crontab_name'] != '' && $_POST['crontab_value'] != '' && $_POST['crontab_is'] != '' && $_POST['id'] != '' && intval($_POST['id']) >= 0) {
                $crontab_list[intval($_POST['id'])] = array('name'=>stripslashes($_POST['crontab_name']),'value'=>stripslashes($_POST['crontab_value']),'crontab_is'=>stripslashes($_POST['crontab_is']));
            }
            $result = $model_setting->updateSetting(array('feiwa_crontab'=>serialize($crontab_list)));
            if ($result){
                showMessage('编辑成功','index.php?app=feiwa&feiwa=crontab');
            }
            showMessage('编辑失败');
        }


    }
}