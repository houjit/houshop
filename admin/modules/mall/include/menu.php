<?php
/**
 * 菜单
 * @
 */
defined('INSYSVIEW') or exit('Access Invalid!');

$_menu['mall'] = array(
    'name' => '商城',
    'child' => array(
        array(
            'name' => '设置',
            'child' => array(
                'setting' => '商城设置',
                'upload' => '图片设置',
                'search' => '搜索设置',
                'seo' => $lang['sys_seo_set'],
                'message' => $lang['sys_message_set'],
                'payment' => $lang['sys_pay_method'],
                'express' => $lang['sys_admin_express_set'],
                'waybill' => '运单模板',
                'web_config' => '首页管理',
                'web_channel' => '频道管理',
                'clearpic' => '图片清理'
            )),
        array(
            'name' => $lang['sys_goods'],
            'child' => array(
                'goods' => $lang['sys_goods_manage'],
                'goods_class' => $lang['sys_class_manage'],
                'brand' => $lang['sys_brand_manage'],
                'type' => $lang['sys_type_manage'],
                'spec' => $lang['sys_spec_manage'],
                'goods_album' => $lang['sys_album_manage'],
                'goods_recommend' => '商品推荐'
            )),
        array(
            'name' => $lang['sys_store'],
            'child' => array(
                'store' => $lang['sys_store_manage'],
                'store_grade' => $lang['sys_store_grade'],
                'store_class' => $lang['sys_store_class'],
                'domain' => $lang['sys_domain_manage'],
                'sns_strace' => $lang['sys_s_snstrace'],
                'help_store' => '店铺帮助',
                'store_joinin' => '商家入驻',
                'ownmall' => '自营店铺'
            )),
        array(
            'name' => $lang['sys_member'],
            'child' => array(
                'member' => $lang['sys_member_manage'],
                'member_exp' => '等级经验值',
                'notice' => '站内信',
                'points' => $lang['sys_member_pointsmanage'],
                'sns_sharesetting' => $lang['sys_binding_manage'],
                'sns_malbum' => $lang['sys_member_album_manage'],
                'snstrace' => $lang['sys_snstrace'],
                'sns_member' => $lang['sys_member_tag'],
                'predeposit' => $lang['sys_member_predepositmanage'],
                'chat_log' => '聊天记录',
                'realname' => '会员认证'
            )),
        array(
            'name' => $lang['sys_trade'],
            'child' => array(
                'order' => $lang['sys_order_manage'],
                'vr_order' => '虚拟订单',
                'refund' => '退款管理',
                'return' => '退货管理',
                'vr_refund' => '虚拟订单退款',
                'consulting' => $lang['sys_consult_manage'],
                'inform' => $lang['sys_inform_config'],
                'evaluate' => $lang['sys_goods_evaluate'],
                'complain' => $lang['sys_complain_config']
            )),
        array(
            'name' => $lang['sys_operation'],
            'child' => array(
                'operating' => '运营设置',
                'bill' => $lang['sys_bill_manage'],
                'vr_bill' => '虚拟订单结算',
                'mall_consult' => '平台客服',
                'mall_feedback' => '意见反馈',
                'rechargecard' => '平台充值卡',
                'delivery' => '物流自提服务站',
                'contract' => '消费者保障服务'
            )),
        array(
            'name' => '促销',
            'child' => array(
                'operation' => '促销设定',
                'groupbuy' => $lang['sys_groupbuy_manage'],
                'vr_groupbuy' => '虚拟团购设置',
                'promotion_cou' => '加价购',
                'promotion_xianshi' => $lang['sys_promotion_xianshi'],
                'promotion_mansong' => $lang['sys_promotion_mansong'],
                'promotion_bundling' => $lang['sys_promotion_bundling'],
                'promotion_booth' => '推荐展位',
                'promotion_book' => '预售商品',
                'promotion_fcode' => 'Ｆ码商品',
                'promotion_combo' => '推荐组合',
                'promotion_sole' => '手机专享',
                'pointprod' => $lang['sys_pointprod'],
                'voucher' => $lang['sys_voucher_price_manage'],
                'redpacket' => '平台红包',
                'activity' => $lang['sys_activity_manage']
            )),
        array(
            'name' => $lang['sys_stat'],
            'child' => array(
                'stat_general' => $lang['sys_statgeneral'],
                'stat_industry' => $lang['sys_statindustry'],
                'stat_member' => $lang['sys_statmember'],
                'stat_store' => $lang['sys_statstore'],
                'stat_trade' => $lang['sys_stattrade'],
                'stat_goods' => $lang['sys_statgoods'],
                'stat_marketing' => $lang['sys_statmarketing'],
                'stat_aftersale' => $lang['sys_stataftersale']
            ))
    ));
