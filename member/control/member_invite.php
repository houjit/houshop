<?php
/**
 * 邀请注册
 */

defined('INSYSVIEW') or exit('Access Invalid!');
class member_inviteControl extends BaseMemberControl {
    public function __construct(){
        parent::__construct();
    }
    /**
     * 分享绑定列表
     */
    public function indexFeiwa(){
        $member_id = '/#V1';
        $member_id .= base64_encode(intval($_SESSION['member_id'])*1);
        Tpl::output('member_id','http://'.$_SERVER['HTTP_HOST'].$member_id);
        Tpl::output('points',$GLOBALS['setting_config']['points_invite']);
        self::profile_menu('sns_binding');
        Tpl::showpage('member_invite');
        
    }
    private function profile_menu($menu_key='',$array=array()) {
        $menu_array     = array();
        $menu_array = array(
            1=>array('menu_key'=>'sns_binding', 'menu_name'=>'邀请注册',    'menu_url'=> urlMember('member_sharemanage', 'index')),
        );
        if(!empty($array)) {
            $menu_array[] = $array;
        }
        Tpl::output('member_menu',$menu_array);
        Tpl::output('menu_key',$menu_key);
    }
}
