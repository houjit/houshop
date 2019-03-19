<?php defined('INSYSVIEW') or exit('Access Invalid!');?><!doctype html><html lang="zh"><head><meta http-equiv="Content-Type" content="text/html; charset=<?php echo CHARSET;?>"><title><?php echo $output['html_title'];?></title><meta name="keywords" content="<?php echo $output['seo_keywords']; ?>" /><meta name="description" content="<?php echo $output['seo_description']; ?>" /><meta name="author" content=""><meta name="copyright" content="   All Rights Reserved"><meta name="renderer" content="webkit"><meta name="renderer" content="ie-stand"><?php echo html_entity_decode($output['setting_config']['qq_appcode'],ENT_QUOTES); ?><?php echo html_entity_decode($output['setting_config']['sina_appcode'],ENT_QUOTES); ?><?php echo html_entity_decode($output['setting_config']['share_qqzone_appcode'],ENT_QUOTES); ?><?php echo html_entity_decode($output['setting_config']['share_sinaweibo_appcode'],ENT_QUOTES); ?><style type="text/css">body { _behavior: url(<?php echo MALL_TEMPLATES_URL;?>/css/csshover.htc)}</style><link href="<?php echo MALL_TEMPLATES_URL;?>/css/base.css" rel="stylesheet" type="text/css"><link href="<?php echo MALL_TEMPLATES_URL;?>/css/home_group.css" rel="stylesheet" type="text/css"><link href="<?php echo MALL_TEMPLATES_URL;?>/css/home_header.css" rel="stylesheet" type="text/css"><link href="<?php echo MALL_RESOURCE_SITE_URL;?>/font/font-awesome/css/font-awesome.min.css" rel="stylesheet" />
<!--[if IE 7]>
<link rel="stylesheet" href="<?php echo MALL_RESOURCE_SITE_URL;?>/font/font-awesome/css/font-awesome-ie7.min.css">
<![endif]-->
<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
<script src="<?php echo RESOURCE_SITE_URL;?>/js/html5shiv.js"></script>
<script src="<?php echo RESOURCE_SITE_URL;?>/js/respond.min.js"></script>
<![endif]-->
<script>
var COOKIE_PRE = '<?php echo COOKIE_PRE;?>';var _CHARSET = '<?php echo strtolower(CHARSET);?>';var LOGIN_SITE_URL = '<?php echo LOGIN_SITE_URL;?>';var MEMBER_SITE_URL = '<?php echo MEMBER_SITE_URL;?>';var SITEURL = '<?php echo MALL_SITE_URL;?>';var MALL_SITE_URL = '<?php echo MALL_SITE_URL;?>';var RESOURCE_SITE_URL = '<?php echo RESOURCE_SITE_URL;?>';var RESOURCE_SITE_URL = '<?php echo RESOURCE_SITE_URL;?>';var MALL_TEMPLATES_URL = '<?php echo MALL_TEMPLATES_URL;?>';
</script>
<script src="<?php echo RESOURCE_SITE_URL;?>/js/jquery.js"></script>
<script src="<?php echo RESOURCE_SITE_URL;?>/js/common.js" charset="utf-8"></script>
<script src="<?php echo RESOURCE_SITE_URL;?>/js/jquery-ui/jquery.ui.js"></script>
<script src="<?php echo RESOURCE_SITE_URL;?>/js/jquery.validation.min.js"></script>
<script src="<?php echo RESOURCE_SITE_URL;?>/js/dialog/dialog.js" id="dialog_js" charset="utf-8"></script><script type="text/javascript">
var PRICE_FORMAT = '<?php echo $lang['currency'];?>%s';
$(function(){
  //首页左侧分类菜单
  $(".category ul.menu").find("li").each(
    function() {
      $(this).hover(
        function() {
            var cat_id = $(this).attr("cat_id");
          var menu = $(this).find("div[cat_menu_id='"+cat_id+"']");
          menu.show();
          $(this).addClass("hover");          
          var menu_height = menu.height();
          if (menu_height < 60) menu.height(80);
          menu_height = menu.height();
          var li_top = $(this).position().top;
          $(menu).css("top",-li_top + 47);
        },
        function() {
          $(this).removeClass("hover");
            var cat_id = $(this).attr("cat_id");
          $(this).find("div[cat_menu_id='"+cat_id+"']").hide();
        }
      );
    }
  );
  $(".mod_minicart").hover(function() {
    $("#nofollow,#minicart_list").addClass("on");
  },
  function() {
    $("#nofollow,#minicart_list").removeClass("on");
  });
  $('.mod_minicart').mouseover(function(){// 运行加载购物车
    load_cart_information();
    $(this).unbind('mouseover');
  });
    <?php if (C('fullindexer.open')) { ?>
  // input ajax tips
  $('#keyword').focus(function(){
    if ($(this).val() == $(this).attr('title')) {
      $(this).val('').removeClass('tips');
    }
  }).blur(function(){
    if ($(this).val() == '' || $(this).val() == $(this).attr('title')) {
      $(this).addClass('tips').val($(this).attr('title'));
    }
  }).blur().autocomplete({
        source: function (request, response) {
            $.getJSON('<?php echo MALL_SITE_URL;?>/index.php?app=search&feiwa=auto_complete', request, function (data, status, xhr) {
                $('#top_search_box > ul').unwrap();
                response(data);
                if (status == 'success') {
                 $('body > ul:last').wrap("<div id='top_search_box'></div>").css({'zIndex':'1000','width':'362px'});
                }
            });
       },
    select: function(ev,ui) {
      $('#keyword').val(ui.item.label);
      $('#top_search_form').submit();
    }
  });
  <?php } ?>

  $('#button').click(function(){
      if ($('#keyword').val() == '') {
        if ($('#keyword').attr('data-value') == '') {
          return false
      } else {
        window.location.href="<?php echo MALL_SITE_URL?>/index.php?app=search&feiwa=index&keyword="+$('#keyword').attr('data-value');
          return false;
      }
      }
  });
  $(".head-search-bar").hover(null,
  function() {
    $('#search-tip').hide();
  });
  // input ajax tips
  $('#keyword').focus(function(){$('#search-tip').show()}).autocomplete({
    //minLength:0,
        source: function (request, response) {
            $.getJSON('<?php echo MALL_SITE_URL;?>/index.php?app=search&feiwa=auto_complete', request, function (data, status, xhr) {
                $('#top_search_box > ul').unwrap();
                response(data);
                if (status == 'success') {
                    $('#search-tip').hide();
                    $(".head-search-bar").unbind('mouseover');
                    $('body > ul:last').wrap("<div id='top_search_box'></div>").css({'zIndex':'1000','width':'362px'});
                }
            });
       },
    select: function(ev,ui) {
      $('#keyword').val(ui.item.label);
      $('#top_search_form').submit();
    }
  });
  $('#search-his-del').on('click',function(){$.cookie('<?php echo C('cookie_pre')?>his_sh',null,{path:'/'});$('#search-his-list').empty();});
});
</script>
</head>
<body>
<!-- PublicTopLayout Begin -->
<?php require_once template('layout/layout_top');?>
<!-- PublicHeadLayout Begin -->
<div class="header-wrap"><header class="public-head-layout wrapper">
	<h1 class="site-logo"><a href="<?php echo MALL_SITE_URL;?>" class="new-logo"><img src="<?php echo UPLOAD_SITE_URL.DS.ATTACH_COMMON.DS.$output['setting_config']['site_logo']; ?>" class="pngFix"></a>
		<div class="title"><h2> <?php echo $lang['text_groupbuy'];?> </h2><?php if ($_GET['feiwa'] == 'index' || strpos($_GET['feiwa'], 'vr_groupbuy_') === 0) { ?><div class="city"> 地区[<a href="javascript:void(0)" id="button_show"><h3 id="show_area_name"><?php if (empty($output['city_name'])){ echo '全国';}else{ echo $output['city_name'];}?></h3><i class="arrow"></i></a>]</div><div id="list" class="list" style="display:none;"><a id="button_close" class="close" href="javascript:void(0)">&#215;</a><ul><li><a href="<?php echo urlMall('show_groupbuy', 'select_city'); ?>&back_op=<?php echo $_GET['feiwa']; ?>&city_id=0"><?php echo $lang['text_country'];?></a></li><?php $names = $output['groupbuy_vr_cities']['name']; foreach ($output['groupbuy_vr_cities']['children'][0] as $v) { ?><li><a href="<?php echo urlMall('show_groupbuy', 'select_city'); ?>&back_op=<?php echo $_GET['feiwa']; ?>&city_id=<?php echo $v; ?>"><?php echo $names[$v]; ?></a></li><?php } ?></ul></div><?php } ?></div></h1>
	
		<div class="head-search-layout"> <div class="head-search-bar" id="head-search-bar">
     <div class="hd_serach_tab" id="hdSearchTab">
      <ul><ul><li app="search" class="current"><span>商品</span><i class="arrow"></i></li><li app="store_list"><span>店铺</span></li><li app="brand" style="display: none;"><span>品牌</span></li></ul></ul>
<i></i>
</div>
<form action="<?php echo MALL_SITE_URL;?>" method="get" class="search-form" id="top_search_form">
<input name="app" id="search_app" value="search" type="hidden">
<?php
if ($_GET['keyword']) {
$keyword = stripslashes($_GET['keyword']);
} elseif ($output['rec_search_list']) {
$_stmp = $output['rec_search_list'][array_rand($output['rec_search_list'])];
$keyword_name = $_stmp['name'];
$keyword_value = $_stmp['value'];
} else {
$keyword = '';
}
?>
<input name="keyword" id="keyword" type="text" class="input-text" value="<?php echo $keyword;?>" maxlength="60" x-webkit-speech lang="zh-CN" onwebkitspeechchange="foo()" placeholder="<?php echo $keyword_name ? $keyword_name : '请输入您要搜索的商品关键字';?>" data-value="<?php echo rawurlencode($keyword_value);?>" x-webkit-grammar="builtin:search" autocomplete="off" />
<input type="submit" id="button" value="<?php echo $lang['feiwa_common_search'];?>" class="input-submit">
</form>
<div class="search-tip" id="search-tip">
<div class="search-history">
<div class="title">历史纪录<a href="javascript:void(0);" id="search-his-del">清除</a></div>
<ul id="search-his-list">
<?php if (is_array($output['his_search_list']) && !empty($output['his_search_list'])) { ?>
<?php foreach($output['his_search_list'] as $v) { ?>
<li><a href="<?php echo urlMall('search', 'index', array('keyword' => $v));?>"><?php echo $v ?></a></li>
<?php } ?>
<?php } ?>
</ul>
</div>
<div class="search-hot">
<div class="title">热门搜索...</div>
<ul>
<?php if (is_array($output['rec_search_list']) && !empty($output['rec_search_list'])) { ?>
<?php foreach($output['rec_search_list'] as $v) { ?>
<li><a href="<?php echo urlMall('search', 'index', array('keyword' => $v['value']));?>"><?php echo $v['value']?></a></li>
<?php } ?>
<?php } ?>
</ul>
</div>
</div>
</div>
 <div class="keyword">
        <ul>
          <?php if(is_array($output['hot_search']) && !empty($output['hot_search'])) { foreach($output['hot_search'] as $val) { ?>
          <li><a href="<?php echo urlMall('search', 'index', array('keyword' => $val));?>"><?php echo $val; ?></a></li>
          <?php } }?>
        </ul>
      </div>
    </div>
<div class="mod_minicart" style="">
    <a id="nofollow" target="_self" href="<?php echo MALL_SITE_URL;?>/index.php?app=cart" class="mini_cart_btn">
                        <i class="cart_icon"></i> 
      <em class="cart_num"><?php echo $output['cart_goods_num'];?></em>
      <span>购物车</span>
    </a>
    <div id="minicart_list" class="minicart_list">
      <div class="spacer"></div>
      <div class="list_detail">
        <!--购物车有商品时begin-->
        <ul><img class="loading" src="<?php echo MALL_TEMPLATES_URL;?>/images/loading.gif" /></ul> 
        <div class="checkout_box">
                    <p class="fl">共<em class="tNum"><?php echo $output['cart_goods_num'];?></em>件商品,合计：<em class="tSum">0</em></p>
          <a rel="nofollow" class="checkout_btn" href="<?php echo MALL_SITE_URL;?>/index.php?app=cart" target="_self"> 去结算 </a>
        </div>
        <div style="" class="none_tips">
          <i> </i>
          <p>购物车中没有商品，赶紧去选购！</p>
        </div>
      </div>
    </div>
  </div>
</header>
</div>
<!-- PublicHeadLayout End --> 

<!-- publicNavLayout Begin -->
<nav class="public-nav-layout <?php if($output['channel']) {echo 'channel-'.$output['channel']['channel_style'].' channel-'.$output['channel']['channel_id'];} ?>">
<div class="wrapper">
<div class="all-category">
<?php require template('layout/home_goods_class');?>
</div>
<ul class="site-menu">
<li><a href="<?php echo urlMall('show_groupbuy', 'groupbuy_list'); ?>"<?php if (isset($output['groupbuyMenuIsVr']) && !$output['groupbuyMenuIsVr']) echo ' class="current"'; ?>>线上抢购</a></li>
<li><a href="<?php echo urlMall('show_groupbuy', 'vr_groupbuy_list'); ?>"<?php if (isset($output['groupbuyMenuIsVr']) && $output['groupbuyMenuIsVr']) echo ' class="current"'; ?>>线下抢购</a></li>
<li><a href="<?php echo MALL_SITE_URL; ?>" target="_blank">网站首页</a></li>
</ul>
</div>
</nav>





<?php include template('layout/cur_local');?>
<?php require_once($tpl_file);?>
<div class="wrapper">
<div class="overseas-question clearfix ">
<div class="overseas-title">
<h4>抢购常见问题</h4>
</div>
<div class="question-content clearfix">
<ul class="left">
<li>
<h5>1、什么是保税区发货？</h5>
<p>答：海外购的商品分为海外库存和保税区库存两种，保税区库存是卖家提前将商品抵运国内保税区，在接收订单后直接从国内保税区仓库发货，通过国内快递寄到顾客手中，全程经由海关监管。</p>
</li>
<li>
<h5>2、保证正品吗？</h5>
<p>答：我们对进商城平台的商家都会进行严格的资质审核，同时本商城还拥有美国、日本、香港等多个海外采购中心，产地直采，以此保障商品质量。</p>
</li>
</ul>
<ul class="right">
<li>
<h5>3、支付会不会有风险？</h5>
<p>答：我们以支付宝来为您做担保，确认收货后再打款给商家，保证您货款安全，可支持人民币购买。</p>
</li>
<li>
<h5>4、这么便宜，会不会有质量问题？</h5>
<p>答：通过集装箱批量发货，存储在保税仓，物流成本减少90%；海外原产地采购，无贸易关税，采购成本减少15%，所以才给您带来货真价实的优惠。</p>
</li>
<li>
<h5>5、订单已提交，未支付，多长时间会被取消？</h5>
<p>答：请于15分钟内完成支付，逾期未支付订单，系统将自动取消该订单。另，请于本期闪购活动结束前完成支付。</p>
</li>
</ul>
</div>
</div></div>
<script src="<?php echo MALL_RESOURCE_SITE_URL;?>/js/home_index.js" ></script>
<script src="<?php echo RESOURCE_SITE_URL;?>/js/waypoints.js"></script>
<script language="JavaScript">
//浮动导航  waypoints.js
$("#ncgCategory").waypoint(function(event, direction) {
$(this).parent().toggleClass('sticky', direction === "down");
event.stopPropagation();
});
//鼠标触及更替li样式
$(document).ready(function(){
$("#list").hide();
$("#button_show").click(function(){
$("#list").toggle();
});
$("#button_close").click(function(){
$("#list").hide();
});
});
</script>
<?php require_once template('footer');?>
</body></html>