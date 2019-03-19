<?php defined('INSYSVIEW') or exit('Access Invalid!'); ?>
<link href="<?php echo MALL_TEMPLATES_URL; ?>/css/feiwa_new_index.css" rel="stylesheet" type="text/css">
<link href="<?php echo MALL_TEMPLATES_URL; ?>/css/feiwa-main.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<?php echo MALL_RESOURCE_SITE_URL; ?>/js/home_index.js" charset="utf-8"></script>
<script type="text/javascript" src="<?php echo MALL_RESOURCE_SITE_URL; ?>/js/scroll.js" charset="utf-8"></script>
</script><script type="text/javascript" src="<?php echo RESOURCE_SITE_URL; ?>/js/waypoints.js"></script>
<style type="text/css">
    .category { display: block !important; }
</style>
<div class="clear"></div>

<!-- HomeFocusLayout Begin-->
<div class="banner">
    <?php echo $output['web_html']['index_pic']; ?>
    <!--进入页面默认的三个专题推荐-->
    <div class="feiwa-new-b-r">
        <div class="left-m-login vip-con" style="display: block;">
            <?php if ($_SESSION['is_login'] == '1') { ?>
                <div class="avatar">
                    <div class="avatar-default">
                        <img src="<?php echo getMemberAvatar($_SESSION['avatar']); ?>">
                    </div>
                    <div class="login-info">
                        <div>亲爱的，</div>
                        <div class="user-name"><?php echo $_SESSION['member_name']; ?></div>
                        <div>欢迎回来！</div>
                    </div>
                    <div class="seprate"></div>
                    <div class="more-info-con sd">

                        <a class="point-con" href="<?php echo urlMall('pointmall', 'index'); ?>" >
                            <div class="title">我的积分</div>
                            <div class="number"><?php echo $output['member_info']['member_points']; ?></div>
                        </a>
                        <div class="seprate"></div>
                        <a class="coupon-con" href="<?php echo urlMember('predeposit', 'pd_log_list'); ?>" >
                            <div class="title">我的余额</div>
                            <div class="number"><?php echo $output['member_info']['available_predeposit']; ?></div><div class="unit">元</div>
                        </a>
                    </div>
                </div>
            <?php } else { ?>
                <!--未登录-->
                <div class="avatar">
                    <div class="avatar-default">
                        <img src="<?php echo getMemberAvatar($_SESSION['avatar']); ?>">
                    </div>
                    <div class="login-info">
                        <div>Hi~你好!</div>
                        <a target="_self" href="<?php echo urlMember('login', 'index'); ?>" class="login-button">请登录</a>
                        <a class="register" href="<?php echo urlMember('login', 'register'); ?>">免费注册 &gt;</a>
                    </div>
                    <div class="seprate"></div>
                    <div class="more-info-con">
                        <div class="more-info">
                            <ul>
                                <?php if ($output['contract_list']) { ?>
                                    <?php foreach ($output['contract_list'] as $k => $v) { ?>
                                        <li><i><img style="width: 15px;" src="<?php echo $v['cti_icon_url_60']; ?>" /></i><span><?php echo $v['cti_name']; ?></span></li>      <?php } ?>
                                <?php } ?>
                                <li><a class="get-more" href="//vip.tmall.com/privilege/all">更多特权 &gt;</a></li>
                            </ul>
                        </div>
                    </div>		<div class="m-tq">
                        <iframe allowtransparency="true" frameborder="0" width="140" height="109" scrolling="no" src="http://tianqi.2345.com/plugin/widget/index.htm?s=1&z=1&t=0&v=1&d=1&bd=0&k=&f=ffffff&q=0&e=0&a=1&c=54511&w=140&h=109&align=center"></iframe>
                    </div>
                </div>
                <!--//未登录-->
            <?php } ?>
        </div>
    </div>
    <!--//进入页面默认的三个专题推荐-->
</div>
<!--HomeFocusLayout End-->
<!--今日主题优惠-->
<div class="sales-events wrapper">
    <div class="lf"><?php echo $output['web_html']['index_sale']; ?></div>
    <div class="rt"><div class="fastZT fastZT1">
            <div class="hoverTab topbox">
                <div class="tabCont">
                    <a target="_blank" href="javascript:void(0)" class="now">公告</a>
                    <a target="_blank" href="javascript:void(0)" class="">入驻</a>
                </div>
                <div style="display: block;" class="hoverCont "><ul class=" noticeList"> <?php if (!empty($output['show_article']['notice']['list']) && is_array($output['show_article']['notice']['list'])) { ?> <?php foreach ($output['show_article']['notice']['list'] as $val) { ?><li><a rel="nofollow" href="<?php echo empty($val['article_url']) ? urlMember('article', 'show', array('article_id' => $val['article_id'])) : $val['article_url']; ?>" target="_blank">【公告】<?php echo $val['article_title']; ?></a></li><?php }
            } ?></ul></div>
                <div style="display: none;" class="hoverCont "><a href="<?php echo urlMall('show_joinin', 'index'); ?>" title="申请商家入驻；已提交申请，可查看当前审核状态。" class="store-join-btn" target="_blank">&nbsp;</a><a href="<?php echo urlMall('seller_login', 'show_login'); ?>" target="_blank" class="store-join-help"><i class="icon-cog"></i>登录商家管理中心</a></div>
            </div>
            <div class="topbox2">
                <ul class="featuresList clearfix">
                    <li><a rel="nofollow" href="<?php echo urlMall('show_joinin', 'index'); ?>" target="_self"><i class="i_ico01"></i>招商入驻</a></li><li><a rel="nofollow" href="<?php echo urlMall('seller_login', 'show_login'); ?>" target="_self"><i class="i_ico02"></i>商家管理</a></li><li><a rel="nofollow" href="<?php echo urlmall('special', 'special_detail', array('special_id' => '1')); ?>" target="_self"><i class="i_ico03"></i>消费保障</a></li><li><a rel="nofollow" href="<?php echo urlMall('invite', 'index'); ?>" target="_self"><i class="i_ico04"></i>推广返利</a></li><li><a rel="nofollow" href="<?php echo DELIVERY_SITE_URL; ?>" target="_self"><i class="i_ico05"></i>物流自提</a></li><li><a rel="nofollow" href="<?php echo WAP_SITE_URL; ?>" target="_self"><i class="i_ico06"></i>手机专享</a></li></ul></div>
        </div></div>
</div>

<!--今日主题优惠end-->



<div class="wrapper">
    <div class="mt10 38sss">
<?php echo loadadv(38, html); ?>
    </div>

    <!--StandardLayout Begin--> 
<?php echo $output['web_html']['index']; ?>
    <!--StandardLayout End-->
</div>
<!--快捷导航-->
<div id="nav_box_none"><ul><div class="m-logo"></div> 
        <?php if (is_array($output['lc_list']) && !empty($output['lc_list'])) {
            $i = 0 ?>
            <?php foreach ($output['lc_list'] as $v) {
                $i++ ?>
                <li class="nav_Sd_<?php echo $i; ?> <?php if ($i == 1) echo 'hover' ?>"> <a class="word" href="javascript:;"><em class="em"><?php echo $v['value'] ?></em><?php echo $v['name'] ?></a></li>
    <?php }
} ?>
    </ul></div>
<!--快捷导航end-->

<!--限时特价随机--> 
        <?php if (!empty($output['xianshi_item']) && is_array($output['xianshi_item'])) { ?>
    <div class="wrapper partTit"><span><em class="ft31"><a href="<?php echo urlMall('promotion', 'list'); ?>" target="_blank"><i class="pink">限时</i>特价 </a></em><i class="eng">ON SALE</i></span></div>
    <div class="boxItem1_index wrapper zoom hoverTab">
        <ul style="display:block" class="hoverCont">
    <?php foreach ($output['xianshi_item'] as $val) { ?>
                <li><div class="act-img-wrap"><a href="<?php echo urlMall('promotion', 'index', array('id' => $val['xianshi_id'])); ?>" target="_blank"><img  width="688" height="190" src="<?php echo xsthumb($val['xianshi_image1']); ?>" class="">
                        </a>
                        <div class="countdown-tag">
                            <span class="tick-logo"></span>
                            <p class="infoTit1 time-remain" count_down="<?php echo $val['end_time'] - TIMESTAMP; ?>"><i></i><em time_id="d">0</em>天<em time_id="h">0</em>时<em time_id="m">0</em>分<em time_id="s">0</em>秒</p>
                            <span class="arrow-circle"></span>
                        </div>
                    </div>
                    <div class="act-detail-wrap">
                        <div class="inner">
                            <img width="150" height="35" src="<?php echo xsthumb($val['xianshi_image2']); ?>" class="">
                            <h3><a  href="<?php echo urlMall('promotion', 'index', array('id' => $val['xianshi_id'])); ?>" target="_blank"><?php echo $val['xianshi_explain']; ?></a>
                            </h3>
                            <span class="discount">低至<?php echo $val['xianshi_discount']; ?>折</span>
                        </div>
                    </div>
                </li>
    <?php } ?>
        </ul>
    </div><?php } ?>
<!--限时特价随机end-->
<div class="wrapper partTit" style="display:none;"><span><em class="ft31"><a href="<?php echo urlMall('promotion', 'list'); ?>" target="_blank"><i class="pink">晒单</i>促销 </a></em><i class="eng">INORDER TO SHARE SALE</i></span></div>	
<div class="feiwa-new-tabcron wrapper" style="display:none;">

    <!--晒单评价--><div class="bcon">
        <!-- 代码开始 -->
        <div class="list_lh">
            <ul class="boxItem2 boxItem2-1 zoom" style="display:block">
<?php if (!empty($output['goods_evaluate_info']) && is_array($output['goods_evaluate_info'])) { ?>
    <?php foreach ($output['goods_evaluate_info'] as $k => $v) { ?>
                <li>
                <a href="<?php echo urlMall('goods', 'comments_list', array('goods_id' => $v['geval_goodsid'])); ?>" target="_blank">
                    <p class="infoImg feiwa-left"><img alt="" feiwa-url="<?php echo strpos($v['goods_pic'], 'http') === 0 ? $v['goods_pic'] : UPLOAD_SITE_URL . "/" . ATTACH_GOODS . "/" . $v['geval_storeid'] . "/" . $v['geval_goodsimage']; ?>"   rel='lazy' src="<?php echo MALL_SITE_URL; ?>/img/loading.gif" style="display: block;"></p>
                    <div class="feiwa-right">
                        <p class="infoItem2"><?php echo str_cut($v['geval_frommembername'], 2) . '***'; ?></p>
                        <p class="infoItem3 c999"><?php echo $v['geval_content']; ?></p>
                        <p class="price pink">
                            <i class="ft14">￥</i>
                            <b class="ft20"><?php echo $v['geval_goodsprice']; ?></b>
                            <b class="butie"><?php echo $v['geval_scores']; ?></b></p>
                    </div>
                    </a>
                </li>
    <?php }
} ?>	
            </ul>
        </div>
        <!-- 代码结束 -->
        <script type="text/javascript">
            $(document).ready(function () {
                $('.list_lh li:even').addClass('lieven');
            })
            $(function () {
                $("div.list_lh").myScroll({
                    speed: 40, //数值越大，速度越慢
                    rowHeight: 100 //li的高度
                });
            });
        </script></div><!--晒单评价end-->
    <!--右侧推荐店铺及推荐品牌-->
    <!--品牌及店铺推荐-->
    <div class="boxItem4">
        <div class="focusImg focusImg1">
            <div class="inner feiwa-new-slider">
                <ul>
                    <li>    <div class="hotCont" style="display: block;">
                            <a class="checkMore">换一换<i></i></a>
                            <div class="feiwa-tab-zt">
                                <?php if (!empty($output['special_list']) && is_array($output['special_list'])) { ?>
                                        <?php foreach ($output['special_list'] as $value) { ?>
                                        <a href="<?php echo $value['special_link']; ?>"><img  feiwa-url="<?php echo getREADSSpecialImageUrl($value['special_image']); ?>" rel='lazy' src="<?php echo MALL_SITE_URL; ?>/img/loading.gif" alt="<?php echo $value['special_title']; ?>"><div class="item-text" ><?php echo $value['special_title']; ?></div></a><?php }
                            } ?>
                            </div>
                            <div class="items docItem">
<?php if (!empty($output['brand_r'])) {
    $i = 0; ?>
                                <div class="showItem now" style="display:block;">
                                <?php foreach ($output['brand_r'] as $key => $brand_r) {
                                    if ($i == 4) {
                                        echo '</div><div class="showItem">';
                                        $i = 1;
                                    } else {
                                        echo ' ';
                                        $i++;
                                    } ?>
                        <a href="<?php echo urlMall('brand', 'list', array('brand' => $brand_r['brand_id'])); ?>" target="_blank">
                            <p class="doc-img"><span><img feiwa-url="<?php echo brandImage($brand_r['brand_pic']); ?>"  rel='lazy' src="<?php echo MALL_SITE_URL; ?>/img/loading.gif" alt="<?php echo $brand_r['brand_name']; ?>"></span><i></i></p>
                            <p class="doc-name"><?php echo $brand_r['brand_name']; ?></p>
                        </a>
    <?php } ?></div> 
<?php } ?>
                            </div>
                <?php //团购?>
                <div class="feiwa-tab-tg">
<?php if (!empty($output['group_list']) && is_array($output['group_list'])) { ?>
    <?php foreach ($output['group_list'] as $val) { ?>
                        <dl> <dt class="goods-name"><a target="_blank" href="<?php echo urlMall('show_groupbuy', 'groupbuy_detail', array('group_id' => $val['groupbuy_id'])); ?>" title="<?php echo $val['groupbuy_name']; ?>">
<?php echo $val['groupbuy_name']; ?></a></dt>
                            <dd class="goods-thumb">
                                <a target="_blank" href="<?php echo urlMall('show_groupbuy', 'groupbuy_detail', array('group_id' => $val['groupbuy_id'])); ?>">
                                    <img alt="<?php echo $val['groupbuy_name']; ?>" feiwa-url="<?php echo gthumb($val['groupbuy_image1'], 'small'); ?>" rel='lazy' src="<?php echo MALL_SITE_URL; ?>/img/loading.gif"  style="display: block;">
                                </a></dd>
                            <dd class="time-remain" count_down="<?php echo $val['end_time'] - TIMESTAMP; ?>"><i></i><em time_id="d">0</em>天<em time_id="h">0</em>小时 <em time_id="m">0</em>分<em time_id="s">0</em>秒 </dd>
                            <dd class="goods-price"><em><?php echo $val['groupbuy_price']; ?></em>
                                <span class="original"><?php echo $val['goods_price']; ?></span></dd>
                        </dl><?php }
                            } ?>
                </div>
                        </div></li>
                        
<li>    <div class="hotCont" style="display: block;">
<a class="checkMore">换一换<i></i></a> 
<div class="items  starShop">
    <div class="showItem" style="display: block;">
<?php 
//var_dump('ifeng',$output['store_list']);
if (!empty($output['store_list']) && is_array($output['store_list'])) {
$i = 0;
?>
    <?php foreach ($output['store_list'] as $val) {
        if ($i == 3) {
            echo '</div><div class="showItem">';
            $i = 1;
        } else {
            echo ' ';
            $i++;
        } ?>
<div class="starShopIner"> 
    <div class="topLogo"> 
        <a href="<?php echo urlMall('show_store', '', array('store_id' => $val['store_id']), $val['store_domain']); ?>" target="_blank"> 
            <div class="logo">  <img src="<?php echo getStoreLogo($val['store_label'], 'store_logo'); ?>"> </div> 
            <div class="logoTxt"> 
                <span class="shopName"><?php echo $val['store_name']; ?></span> 
                <span>在售<?php echo $val['goods_count']; ?>商品</span> 
            </div> </a> 
        <div class="quan"> 
            <a href="<?php echo urlMall('show_store', '', array('store_id' => $val['store_id']), $val['store_domain']); ?>" target="_blank" class="btnW80red">进店看看</a> 
        </div> 
    </div> 

    <div class="proInfoBox">
<?php if (!empty($val['search_list_goods']) && is_array($val['search_list_goods'])) { ?>
<?php foreach ($val['search_list_goods'] as $k => $v) { ?>
                <dl> 
                    <div class="innerBox"> 
                        <div class="proImg"> 
                            <a href="<?php echo urlMall('goods', 'index', array('goods_id' => $v['goods_id'])); ?>"> <img src="<?php echo thumb($v, 240); ?>" alt="<?php echo $v['goods_name']; ?>"> </a> 
                        </div> 
                        <p class="proName"> <a href="<?php echo urlMall('goods', 'index', array('goods_id' => $v['goods_id'])); ?>" ><?php echo $v['goods_name']; ?></a> </p> 
                        <div class="inrBox clearfix"> 
                            <p class="priceSales"><i class="newPrice">¥<?php echo $v['goods_promotion_price']; ?></i><em class="newSales"> 销售量<i><?php echo $v['goods_salenum']; ?></i></em></p> 
                        </div> 
                    </div> </dl> 
<?php }
} ?>
    </div> 
</div> 
<?php } } ?>

    </div></div>
</li>

                </ul>
            </div>
        </div>

    </div>

    <!--品牌及店铺推荐end-->


</div>