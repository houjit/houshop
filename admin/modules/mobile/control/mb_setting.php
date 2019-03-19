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
class mb_settingControl extends SystemControl{
    public function __construct(){
        parent::__construct();
//         Language::read('mobile');
    }

    public function indexFeiwa(){
        $model_setting = Model('setting');
        if (chksubmit()){
            $update_array = array();
            $update_array['signin_isuse']   = $_POST['signin_isuse'];
            $update_array['points_signin']   = $_POST['points_signin'];
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
        Tpl::output('mobile_wx',$mobile_wx);
        Tpl::setDirquna('mobile');
        Tpl::showpage('mb_setting.index');
    }
}
