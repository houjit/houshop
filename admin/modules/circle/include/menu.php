<?php
/**
 * 菜单
 *
 *  
 
 * @
 */
defined('INSYSVIEW') or exit('Access Invalid!');
$_menu['circle'] = array (
        'name' => $lang['sys_circle'],
        'child' => array (
                array (
                        'name' => $lang['sys_config'],
                        'child' => array(
                                'circle_setting' => $lang['sys_circle_setting'],
                                'circle_adv' => '首页幻灯'
                        )
                ),
                array (
                        'name' => '成员',
                        'child' => array(
                                'circle_member' => $lang['sys_circle_membermanage'],
                                'circle_memberlevel' => '成员头衔'
                        )
                ),
                array (
                        'name' => '圈子',
                        'child' => array(
                                'circle_manage' => $lang['sys_circle_manage'],
                                'circle_class' => $lang['sys_circle_classmanage'],
                                'circle_theme' => $lang['sys_circle_thememanage'],
                                'circle_inform' => '举报管理'
                        )
                )
        ) 
);