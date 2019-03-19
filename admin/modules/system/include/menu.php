<?php
/**
 * 菜单
 *
 *  
 
 * @
 */
defined('INSYSVIEW') or exit('Access Invalid!');
$_menu['system'] = array (
        'name' => '平台',
        'child' => array (
                array(
                        'name' => $lang['sys_config'],
                        'child' => array(
                                'setting' => $lang['sys_web_set'],
                                'upload' => $lang['sys_upload_set'],
                                'message' => '邮件设置',
                                'taobao_api' => '淘宝接口',
                                'admin' => '权限设置',
                                'admin_log' => $lang['sys_admin_log'],
                                'area' => '地区设置',
                                'cache' => $lang['sys_admin_clear_cache'],
								
                        )
                ),
                array(
                        'name' => $lang['sys_member'],
                        'child' => array(
                                
                                'account' => $lang['sys_web_account_syn']
                        )
                ),
                array(
                        'name' => $lang['sys_website'],
                        'child' => array(
                                'article_class' => $lang['sys_article_class'],
                                'article' => $lang['sys_article_manage'],
                                'document' => $lang['sys_document'],
                                'navigation' => $lang['sys_navigation'],
                                'adv' => $lang['sys_adv_manage'],
                                'rec_position' => $lang['sys_admin_res_position'],
                        )
                ),
        ) 
);
