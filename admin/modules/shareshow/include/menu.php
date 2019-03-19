<?php
/**
 * 菜单
 *
 *  
 
 * @
 */
defined('INSYSVIEW') or exit('Access Invalid!');
$_menu['shareshow'] = array (
        'name' => '分享秀',
        'child' => array(
                array(
                        'name' => $lang['sys_config'], 
                        'child' => array(
                                'manage' => $lang['sys_shareshow_manage'],
                                'comment' => $lang['sys_shareshow_comment_manage'],
                                'adv' => $lang['sys_shareshow_adv_manage']
                        )
                ),
                array(
                        'name' => '随心看', 
                        'child' => array(
                                'goods' => $lang['sys_shareshow_goods_manage'],
                                'goods_class' => $lang['sys_shareshow_goods_class']
                        )
                ),
                array(
                        'name' => '个人秀', 
                        'child' => array(
                                'personal' => $lang['sys_shareshow_personal_manage'],
                                'personal_class' => $lang['sys_shareshow_personal_class']
                        )
                        
                ),
                array(
                        'name' => '店铺街',
                        'child' => array(
                                'store' => $lang['sys_shareshow_store_manage']
                        )
                )
        )
);