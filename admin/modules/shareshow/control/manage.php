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
class manageControl extends SystemControl{

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
       $this->manageFeiwa();
    }

    /**
     * 分享秀管理
     */
    public function manageFeiwa() {
        $model_setting = Model('setting');
        $setting_list = $model_setting->getListSetting();
        Tpl::output('setting',$setting_list);
        Tpl::setDirquna('shareshow');
Tpl::showpage('shareshow_manage');
    }

    /**
     * 分享秀管理保存
     */
    public function manage_saveFeiwa() {
        $model_setting = Model('setting');
        $update_array = array();
        $update_array['shareshow_isuse'] = intval($_POST['shareshow_isuse']);
        $update_array['shareshow_style'] = trim($_POST['shareshow_style']);
        $update_array['shareshow_personal_limit'] = intval($_POST['shareshow_personal_limit']);
        $old_image = array();
        if(!empty($_FILES['shareshow_logo']['name'])) {
            $upload = new UploadFile();
            $upload->set('default_dir',ATTACH_SHARESHOW);
            $result = $upload->upfile('shareshow_logo');
            if(!$result) {
                showMessage($upload->error);
            }
            $update_array['shareshow_logo'] = $upload->file_name;
            $old_image[] = BASE_UPLOAD_PATH.DS.ATTACH_SHARESHOW.DS.C('shareshow_logo');
        }
        if(!empty($_FILES['shareshow_header_pic']['name'])) {
            $upload = new UploadFile();
            $upload->set('default_dir',ATTACH_SHARESHOW);
            $result = $upload->upfile('shareshow_header_pic');
            if(!$result) {
                showMessage($upload->error);
            }
            $update_array['shareshow_header_pic'] = $upload->file_name;
            $old_image[] = BASE_UPLOAD_PATH.DS.ATTACH_SHARESHOW.DS.C('shareshow_header_pic');
        }
        $update_array['shareshow_seo_keywords'] = $_POST['shareshow_seo_keywords'];
        $update_array['shareshow_seo_description'] = $_POST['shareshow_seo_description'];

        $result = $model_setting->updateSetting($update_array);
        if ($result === true){
            if(!empty($old_image)) {
                foreach ($old_image as $value) {
                    if(is_file($value)) {
                        unlink($value);
                    }
                }
            }
            showMessage(Language::get('feiwa_common_save_succ'));
        }else {
            showMessage(Language::get('feiwa_common_save_fail'));
        }
    }
}
