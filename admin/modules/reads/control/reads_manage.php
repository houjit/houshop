<?php
/**
 * 资讯管理
 *
 *
 *
 *
 *  
 
 * @
 */

//;

defined('INSYSVIEW') or exit('Access Invalid!');
class reads_manageControl extends SystemControl{

    public function __construct(){
        parent::__construct();
        Language::read('reads');
    }

    public function indexFeiwa() {
        $this->reads_manageFeiwa();
    }

    /**
     * 资讯设置
     */
    public function reads_manageFeiwa() {
        $model_setting = Model('setting');
        $setting_list = $model_setting->getListSetting();
        Tpl::output('setting',$setting_list);
        Tpl::setDirquna('reads');
Tpl::showpage('reads_manage');
    }

    /**
     * 资讯设置保存
     */
    public function reads_manage_saveFeiwa() {
        $model_setting = Model('setting');
        $update_array = array();
        $update_array['reads_isuse'] = intval($_POST['reads_isuse']);
        if(!empty($_FILES['reads_logo']['name'])) {
            $upload = new UploadFile();
            $upload->set('default_dir',ATTACH_READS);
            $result = $upload->upfile('reads_logo');
            if(!$result) {
                showMessage($upload->error);
            }
            $update_array['reads_logo'] = $upload->file_name;
            $old_image = BASE_UPLOAD_PATH.DS.ATTACH_READS.DS.C('shareshow_logo');
            if(is_file($old_image)) {
                unlink($old_image);
            }
        }
        $update_array['reads_submit_verify_flag'] = intval($_POST['reads_submit_verify_flag']);
        $update_array['reads_comment_flag'] = intval($_POST['reads_comment_flag']);
        $update_array['reads_attitude_flag'] = intval($_POST['reads_attitude_flag']);
        $update_array['reads_seo_title'] = $_POST['reads_seo_title'];
        $update_array['reads_seo_keywords'] = $_POST['reads_seo_keywords'];
        $update_array['reads_seo_description'] = $_POST['reads_seo_description'];

        $result = $model_setting->updateSetting($update_array);
        if ($result === true){
            $this->log(Language::get('reads_log_manage_save'), 0);
            showMessage(Language::get('feiwa_common_save_succ'));
        }else {
            $this->log(Language::get('reads_log_manage_save'), 0);
            showMessage(Language::get('feiwa_common_save_fail'));
        }
    }


}
