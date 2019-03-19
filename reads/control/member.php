<?php
/**
 * APP会员
 *
 *
 * * 
 *
 * 
 *  
 */



defined('INSYSVIEW') or exit('Access Invalid!');

class memberControl{

    public function __construct(){
        require_once(BASE_PATH.'/framework/function/client.php');
    }

    public function infoFeiwa(){
        if (!empty($_GET['uid'])){
            $member_info = feiwa_member_info($_GET['uid'],'uid');
        }elseif(!empty($_GET['user_name'])){
            $member_info = feiwa_member_info($_GET['user_name'],'user_name');
        }
        return $member_info;
    }
}
