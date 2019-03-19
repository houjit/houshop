<?php
/**
 * 菜单
 *
 *  
 
 * @
 */
defined('INSYSVIEW') or exit('Access Invalid!');
$_menu['reads'] = array (
        'name' => $lang['sys_reads'],
        'child' => array(
                array(
                        'name' => $lang['sys_config'],
                        'child' => array(
                                'reads_manage' => $lang['sys_reads_manage'],
                                'reads_index' => $lang['sys_reads_index_manage'],
                                'reads_navigation' => $lang['sys_reads_navigation_manage'],
                                'reads_tag' => $lang['sys_reads_tag_manage'],
                                'reads_comment' => $lang['sys_reads_comment_manage']
                        )
                ),
                array(
                        'name' => '专题',
                        'child' => array(
                                'reads_special' => $lang['sys_reads_special_manage']
                        )
                ),
                array(
                        'name' => '文章',
                        'child' => array(
                                'reads_article_class' => '文章分类',
                                'reads_article' => '文章管理'
                        )
                ),
                array(
                        'name' => '画报',
                        'child' => array(
                                'reads_picture_class' => '画报分类',
                                'reads_picture' => '画报管理'
                        )
                )
));