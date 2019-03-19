<?php
defined('INSYSVIEW') or exit('Access Invalid!');
$lang['shareshow_not_install'] = '您没有安装分享秀模块';

$lang['shareshow_member'] = '用户';
$lang['shareshow_channel'] = '频道';
$lang['shareshow_commend'] = '推荐';
$lang['shareshow_text_id'] = '编号';

$lang['shareshow_class_name'] = '分类名称';
$lang['shareshow_parent_class'] = '上级分类';
$lang['shareshow_class_image'] = '分类图片';
$lang['shareshow_class_keyword'] = '分类关键字';

$lang['shareshow_goods_class_binding'] = '绑定分类';
$lang['shareshow_goods_class_binding_select'] = '选择分类';
$lang['shareshow_goods_class_binded'] = '已绑定分类';
$lang['goods_relation_save_success'] = '绑定分类保存成功';
$lang['goods_relation_save_fail'] = '绑定分类保存失败';
$lang['shareshow_goods_class_default'] = '设为默认';

//分类表单
$lang['class_parent_id_error'] = '分类上级编号错误';
$lang['class_name_error'] = '分类名称名称不能为空且必须小于10个字符';
$lang['class_name_required'] = '分类名称不能为空';
$lang['class_name_maxlength'] = '分类名称最多个{0}字符';
$lang['class_keyword_maxlength'] = '分类关键字最多个{0}字符';
$lang['class_keyword_explain'] = '分类关键字用英文逗号分隔，如果需要高亮显示在关键字前加"*"，例："裤子,*鞋子"';
$lang['class_sort_explain'] = '数字范围为0~255，数字越小越靠前';
$lang['class_sort_error'] = '分类排序必须为0~255之间的数字';
$lang['class_sort_required'] = '排序不能为空';
$lang['class_sort_digits'] = '排序必须为数字';
$lang['class_sort_max'] = '排序最大为{0}';
$lang['class_sort_min'] = '排序最小为{0}';
$lang['class_add_success'] = '分类保存成功';
$lang['class_add_fail'] = '分类保存失败';
$lang['class_drop_success'] = '分类删除成功';
$lang['class_drop_fail'] = '分类删除失败';
$lang['shareshow_sort_error'] = '排序必须为0~255之间的数字';

//分享秀管理
$lang['shareshow_isuse'] = '分享秀开关';
$lang['shareshow_isuse_explain'] = '关闭后分享秀前台将无法访问';
$lang['shareshow_url'] = '分享秀地址';
$lang['shareshow_url_explain'] = '如果分享秀配置了二级域名，在此填写后商城中的分享秀链接使用二级域名，如果留空使用默认地址';
$lang['shareshow_style'] = '分享秀主题';
$lang['shareshow_style_explain'] = '设置分享秀主题，默认为default';
$lang['shareshow_header_image'] = '分享秀头部图片';
$lang['shareshow_personal_limit'] = '个人秀数量限制';
$lang['shareshow_personal_limit_explain'] = '会员发布个人秀的数量限制，0为不限制';
$lang['shareshow_seo_keywords'] = '分享秀SEO关键字';
$lang['shareshow_seo_description'] = '分享秀SEO描述';

//随心看
$lang['shareshow_goods_name'] = '商品名称';
$lang['shareshow_goods_image'] = '商品图片';
$lang['shareshow_commend_time'] = '推荐时间';
$lang['shareshow_commend_message'] = '推荐说明';
$lang['shareshow_goods_tip1'] = '通过修改排序数字可以控制前台随心看的显示顺序，数字越小越靠前';
$lang['shareshow_goods_tip2'] = '点亮推荐列的符号，该商品将推荐到分享秀首页';
$lang['shareshow_goods_class_tip1'] = '通过修改排序数字可以控制前台随心看分类的显示顺序，数字越小越靠前';
$lang['shareshow_goods_class_tip2'] = '点亮推荐列的符号，该分类将推荐到分享秀首页';
$lang['shareshow_goods_class_tip3'] = '点击行首的"+"号，可以展开下级分类';
$lang['shareshow_goods_class_tip4'] = '点击二级分类后的"绑定分类"按钮可以绑定分享秀和商城系统的分类，绑定后推荐的随心看商品将自动匹配分类';
$lang['shareshow_goods_class_tip5'] = '点击二级分类后的"设为默认"按钮可以设定分享秀的默认分类，随心看发布的商城中未绑定分类都将使用默认分类';
$lang['shareshow_goods_class_binding_tip1'] = '选择下方的商城分类后单击完成绑定，绑定后推荐的随心看商品将自动匹配分类';
$lang['shareshow_goods_class_binding_tip2'] = '鼠标移到已绑定的分类上，点击右上角的"x"可以删除绑定';

$lang['shareshow_personal_tip1'] = '通过修改排序数字可以控制前台随心看的显示顺序，数字越小越靠前';
$lang['shareshow_personal_tip2'] = '点亮推荐列的符号，该商品将推荐到分享秀首页';

//店铺
$lang['shareshow_store_add_confirm'] = '确认添加该店铺到店铺街?';
$lang['shareshow_store_goods_count'] = '商品数';
$lang['shareshow_store_credit'] = '商家信用';
$lang['shareshow_store_praise_rate'] = '好评率';
$lang['shareshow_store_add'] = '已添加';
$lang['shareshow_store_tip1'] = '通过修改排序数字可以控制前台店铺街的显示顺序，数字越小越靠前';
$lang['shareshow_store_tip2'] = '点亮推荐列的符号，该店铺将推荐到分享秀首页，首页最多显示15个推荐店铺';
$lang['shareshow_store_add_tip1'] = '点击"添加"按钮将商城店铺添加到分享秀的店铺街';

//评论
$lang['shareshow_comment_id'] = '评论编号';
$lang['shareshow_comment_object_id'] = '对象编号';
$lang['shareshow_comment_message'] = '评论内容';
$lang['shareshow_comment_tip1'] = '点击"删除"按钮将删除对应的评论';

//广告
$lang['shareshow_adv_type'] = '广告类型';
$lang['shareshow_adv_name'] = '广告名称';
$lang['shareshow_adv_image'] = '广告图片';
$lang['shareshow_adv_url'] = '广告链接';
$lang['shareshow_adv_type_index'] = '首页幻灯';
$lang['shareshow_adv_type_store_list'] = '店铺列表页幻灯';
$lang['shareshow_adv_image_error'] = '广告图片不能为空';
$lang['shareshow_adv_tip1'] = '通过修改排序数字可以控制前台广告的显示顺序，数字越小越靠前';
$lang['shareshow_adv_type_explain'] = '选择对应的广告位置';
$lang['shareshow_adv_image_explain'] = '首页广告图片推荐尺寸700px*280px，店铺列表页广告图片推荐尺寸1000px*250px';
$lang['shareshow_adv_url_explain'] = '广告对应的链接地址';


