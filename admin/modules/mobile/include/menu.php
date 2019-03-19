<?php
/**
 * 菜单
 *
 *  
 
 * @
 */
defined('INSYSVIEW') or exit('Access Invalid!');
$_menu['mobile'] = array (
        'name'=>$lang['sys_mobile'],
        'child'=>array(
                array(
                        'name'=>'设置',
                        'child' => array(
						        'mb_setting' => '手机端设置',
                                'mb_special' => '模板设置',
                                'mb_category' => $lang['sys_mobile_catepic'],
                                'mb_app' => '应用安装',
                                'mb_feedback' => $lang['sys_mobile_feedback'],
                                'mb_payment' => '手机支付',
                                'mb_wx' => '微信二维码',
								'mb_connect' => '第三方登入',
                        )
                )
        )
);