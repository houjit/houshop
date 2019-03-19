<?php
/**
 * 手机端微信公众账号二维码设置
 *
 *
 *
 ** 
 */

//;

defined('INSYSVIEW') or exit('Access Invalid!');
class mb_connectControl extends SystemControl{
	    private $links = array(
		array('url'=>'app=mb_connect&feiwa=wx','text'=>'微信登录'),
		array('url'=>'app=mb_connect&feiwa=wap_wx','text'=>'WAP微信登录'),
        array('url'=>'app=mb_connect&feiwa=qq','text'=>'QQ互联'),
        array('url'=>'app=mb_connect&feiwa=sina','text'=>'新浪微博'),
    );
    public function __construct(){
        parent::__construct();
//         Language::read('mobile');
 Language::read('setting');
    }
	    public function indexFeiwa() {
        $this->wxFeiwa();
    }

       /**
     * QQ互联
     */
    public function qqFeiwa(){
        $model_setting = Model('setting');
        if (chksubmit()){
            $obj_validate = new Validate();
            if (trim($_POST['app_qq_isuse']) == '1'){
                $obj_validate->validateparam = array(
                    array("input"=>$_POST["app_qq_akey"], "require"=>"true","message"=>Language::get('qq_appid_error')),
                    array("input"=>$_POST["app_qq_skey"], "require"=>"true","message"=>Language::get('qq_appkey_error'))
                );
            }
            $error = $obj_validate->validate();
            if ($error != ''){
                showMessage($error);
            }else {
                $update_array = array();
                $update_array['app_qq_isuse']   = $_POST['app_qq_isuse'];
                $update_array['app_qq_akey']   = $_POST['app_qq_akey'];
                $update_array['app_qq_skey']  = $_POST['app_qq_skey'];
                $result = $model_setting->updateSetting($update_array);
                if ($result === true){
                    $this->log(L('feiwa_edit,qqSettings'),1);
                    showMessage(Language::get('feiwa_common_save_succ'));
                }else {
                    $this->log(L('feiwa_edit,qqSettings'),0);
                    showMessage(Language::get('feiwa_common_save_fail'));
                }
            }
        }

        $list_setting = $model_setting->getListSetting();
        Tpl::output('list_setting',$list_setting);

        //输出子菜单
        Tpl::output('top_link',$this->sublink($this->links,'qq'));
		Tpl::setDirquna('mobile');
        Tpl::showpage('mb_connect.qq_setting');
    }

    /**
     * sina微博设置
     */
    public function sinaFeiwa(){
        $model_setting = Model('setting');
        if (chksubmit()){
            $obj_validate = new Validate();
            if (trim($_POST['app_sina_isuse']) == '1'){
                $obj_validate->validateparam = array(
                    array("input"=>$_POST["app_sina_akey"], "require"=>"true","message"=>Language::get('sina_wb_akey_error')),
                    array("input"=>$_POST["app_sina_skey"], "require"=>"true","message"=>Language::get('sina_wb_skey_error'))
                );
            }
            $error = $obj_validate->validate();
            if ($error != ''){
                showMessage($error);
            }else {
                $update_array = array();
                $update_array['app_sina_isuse']     = $_POST['app_sina_isuse'];
                $update_array['app_sina_akey']   = $_POST['app_sina_akey'];
                $update_array['app_sina_skey']   = $_POST['app_sina_skey'];
                $result = $model_setting->updateSetting($update_array);
                if ($result === true){
                    $this->log(L('feiwa_edit,sinaSettings'),1);
                    showMessage(Language::get('feiwa_common_save_succ'));
                }else {
                    $this->log(L('feiwa_edit,sinaSettings'),0);
                    showMessage(Language::get('feiwa_common_save_fail'));
                }
            }
        }
        $is_exist = function_exists('curl_init');
        if ($is_exist){
            $list_setting = $model_setting->getListSetting();
            Tpl::output('list_setting',$list_setting);
        }
        Tpl::output('is_exist',$is_exist);

        //输出子菜单
        Tpl::output('top_link',$this->sublink($this->links,'sina'));
        Tpl::setDirquna('mobile');
        Tpl::showpage('mb_connect.sina_setting');
    }

    /**
     * 微信登录设置
     */
    public function wxFeiwa(){
        $model_setting = Model('setting');
        if (chksubmit()){
            $update_array = array();
            $update_array['app_weixin_isuse']   = $_POST['app_weixin_isuse'];
            $update_array['app_weixin_appid']   = $_POST['app_weixin_appid'];
            $update_array['app_weixin_secret']  = $_POST['app_weixin_secret'];
            $result = $model_setting->updateSetting($update_array);
            if ($result){
                $this->log('编辑账号同步，微信登录设置');
                showMessage(Language::get('feiwa_common_save_succ'));
            }else {
                showMessage(Language::get('feiwa_common_save_fail'));
            }
        }
        $list_setting = $model_setting->getListSetting();
        Tpl::output('list_setting',$list_setting);
        //输出子菜单
        Tpl::output('top_link',$this->sublink($this->links,'wx'));
        Tpl::setDirquna('mobile');
        Tpl::showpage('mb_connect.wx_setting');
    }
	
	 /**
     * 微信登录设置
     */
    public function wap_wxFeiwa(){
        $model_setting = Model('setting');
        if (chksubmit()){
            $update_array = array();
            $update_array['wap_weixin_isuse']   = $_POST['wap_weixin_isuse'];
            $update_array['wap_weixin_appid']   = $_POST['wap_weixin_appid'];
            $update_array['wap_weixin_secret']  = $_POST['wap_weixin_secret'];
            $result = $model_setting->updateSetting($update_array);
            if ($result){
                $this->log('编辑账号同步，WAP微信登录设置');
                showMessage(Language::get('feiwa_common_save_succ'));
            }else {
                showMessage(Language::get('feiwa_common_save_fail'));
            }
        }
        $list_setting = $model_setting->getListSetting();
        Tpl::output('list_setting',$list_setting);
        //输出子菜单
        Tpl::output('top_link',$this->sublink($this->links,'wap_wx'));
        Tpl::setDirquna('mobile');
        Tpl::showpage('mb_connect.wap_wx_setting');
    }
}
