<?php defined('INSYSVIEW') or exit('Access Invalid!');?>
<!doctype html>
<html lang="zh">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=<?php echo CHARSET;?>">
<title><?php echo $output['html_title'];?></title>
<meta name="keywords" content="<?php echo $output['seo_keywords']; ?>" />
<meta name="description" content="<?php echo $output['seo_description']; ?>" />
<meta name="author" content="">
<meta name="copyright" content="   All Rights Reserved">
<?php echo html_entity_decode($output['setting_config']['qq_appcode'],ENT_QUOTES); ?><?php echo html_entity_decode($output['setting_config']['sina_appcode'],ENT_QUOTES); ?><?php echo html_entity_decode($output['setting_config']['share_qqzone_appcode'],ENT_QUOTES); ?><?php echo html_entity_decode($output['setting_config']['share_sinaweibo_appcode'],ENT_QUOTES); ?>
<style type="text/css">
body {
_behavior: url(<?php echo MEMBER_TEMPLATES_URL;
?>/css/csshover.htc);
}
</style>
<link href="<?php echo MALL_TEMPLATES_URL;?>/css/base.css" rel="stylesheet" type="text/css">
<link href="<?php echo MALL_TEMPLATES_URL;?>/css/home_header.css" rel="stylesheet" type="text/css">
<link href="<?php echo MEMBER_RESOURCE_SITE_URL;?>/font/font-awesome/css/font-awesome.min.css" rel="stylesheet" />
<!--[if IE 7]>
  <link rel="stylesheet" href="<?php echo MEMBER_RESOURCE_SITE_URL;?>/font/font-awesome/css/font-awesome-ie7.min.css">
<![endif]-->
<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
      <script src="<?php echo RESOURCE_SITE_URL;?>/js/html5shiv.js"></script>
      <script src="<?php echo RESOURCE_SITE_URL;?>/js/respond.min.js"></script>
<![endif]-->
<script>
var COOKIE_PRE = '<?php echo COOKIE_PRE;?>';var _CHARSET = '<?php echo strtolower(CHARSET);?>';var SITEURL = '<?php echo MALL_SITE_URL;?>';var MALL_SITE_URL = '<?php echo MALL_SITE_URL;?>';var MEMBER_SITE_URL = '<?php echo MEMBER_SITE_URL;?>';var RESOURCE_SITE_URL = '<?php echo RESOURCE_SITE_URL;?>';var MALL_TEMPLATES_URL = '<?php echo MALL_TEMPLATES_URL;?>';
</script>
<script src="<?php echo RESOURCE_SITE_URL;?>/js/jquery.js"></script>
<script src="<?php echo RESOURCE_SITE_URL;?>/js/common.js" charset="utf-8"></script>
<script src="<?php echo RESOURCE_SITE_URL;?>/js/jquery-ui/jquery.ui.js"></script>
<script src="<?php echo RESOURCE_SITE_URL;?>/js/jquery.validation.min.js"></script>
<script src="<?php echo RESOURCE_SITE_URL;?>/js/dialog/dialog.js" id="dialog_js" charset="utf-8"></script>
<script type="text/javascript">
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
					$(menu).css("top",-li_top + 46);
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
  $('.cityItem p a').click(function(){
		var city=$(this).attr('data-wh');
		var url = '<?php echo MALL_SITE_URL;?>/index.php?app=index&feiwa=save_city&city='+city;
		window.location.href=url;
	});
});
</script>
</head>
<body>
<!-- PublicTopLayout Begin -->
<?php require_once template('layout/layout_top');?>
<!-- PublicHeadLayout Begin -->
<div class="header-wrap">
  <header class="public-head-layout wrapper">
    <h1 class="site-logo"><a href="<?php echo MALL_SITE_URL;?>" class="new-logo"><img src="<?php echo UPLOAD_SITE_URL.DS.ATTACH_COMMON.DS.$output['setting_config']['site_logo']; ?>" class="pngFix"></a>    <div class="cityCont">
                <span class="cityNow"><em><?php if($_COOKIE['city'] !=null){ echo  $_COOKIE['city']; } else{?>
		    		<?php echo $output['setting_config']['feiwa_default_city']; ?>
		    		<?php }?></em></span>
                <div class="cityItem">
                    <p>
              <?php if (is_array($output['citys_list']) && !empty($output['citys_list'])) { ?>
              <?php foreach($output['citys_list'] as $v) { ?>
              <a href="javascript:void(0)" <?php if($_COOKIE['city']==$v['name']){echo 'class="now"';} ?> data-wh="<?php echo $v['name']; ?>" ><span><?php echo $v['name']; ?></span></a>
                 <?php } ?>
              <?php } ?>  
                                            </p>
                </div>
            </div></h1>

    
   
    <div class="head-search-layout">
      <div class="head-search-bar" id="head-search-bar">
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
    <div class="navCont">
            <a href="<?php echo MALL_SITE_URL;?>" <?php if($output['index_sign'] == 'index' && $output['index_sign'] != '0') {echo 'class="now"';} ?>>首页</a>
            <div class="taoBtnList">
                <a href="<?php echo urlMall('show_groupbuy', 'index');?>" class="taoListHv">淘抢购</a>
                <div class="">
                    <a href="<?php echo urlMall('show_groupbuy', 'index');?>" class="taoListHv">淘抢购</a>
                    <a href="<?php echo urlMall('show_groupbuy', 'index');?>">淘抢购首页</a>
                    <a href="<?php echo urlMall('promotion','index');?>">限时特价</a>
                    <a href="<?php echo urlMall('brand', 'index');?>">品牌精品</a>
                    <a href="<?php echo urlMall('special', 'special_list');?>">主题抢购<i class="theNew">new</i></a>
                    <a href="<?php echo urlMall('special', 'special_list');?>">运营保障</a>
                </div>
            </div>
            <a href="<?php echo urlMall('consult', 'index');?>" <?php if($output['index_sign'] == 'consult' && $output['index_sign'] != '0') {echo 'class="now"';} ?>>商家应答</a>
            <a href="<?php echo urlMall('search', 'index');?>" <?php if($output['index_sign'] == 'search' && $output['index_sign'] != '0') {echo 'class="now"';} ?>>淘产品</a>
            <a href="<?php echo urlMall('store_list', 'index');?>" <?php if($output['index_sign'] == 'store_list' && $output['index_sign'] != '0') {echo 'class="now"';} ?>>淘店铺</a>
             <?php if (C('reads_isuse')){ ?>
            <a href="<?php echo READS_SITE_URL;?>" <?php if($output['index_sign'] == 'reads' && $output['index_sign'] != '0') {echo 'class="now"';} ?>>淘资讯</a><?php } ?>
            	<?php if (C('circle_isuse')){ ?>
            <a href="<?php echo CIRCLE_SITE_URL;?>" <?php if($output['index_sign'] == 'circle' && $output['index_sign'] != '0') {echo 'class="now"';} ?>>淘友圈</a><?php } ?>
            <?php if(!empty($output['nav_list']) && is_array($output['nav_list'])){?>
      <?php foreach($output['nav_list'] as $nav){?>
      <?php if($nav['nav_location'] == '1'){?> <a
        <?php
        if($nav['nav_new_open']) {
            echo ' target="_blank"';
        }
        switch($nav['nav_type']) {
            case '0':
                echo ' href="' . $nav['nav_url'] . '"';
                break;
            case '1':
                echo ' href="' . urlMall('search', 'index',array('cate_id'=>$nav['item_id'])) . '"';
                if (isset($_GET['cate_id']) && $_GET['cate_id'] == $nav['item_id']) {
                    echo ' class="current"';
                }
                break;
            case '2':
                echo ' href="' . urlMember('article', 'article',array('ac_id'=>$nav['item_id'])) . '"';
                if (isset($_GET['ac_id']) && $_GET['ac_id'] == $nav['item_id']) {
                    echo ' class="current"';
                }
                break;
            case '3':
                echo ' href="' . urlMall('activity', 'index', array('activity_id'=>$nav['item_id'])) . '"';
                if (isset($_GET['activity_id']) && $_GET['activity_id'] == $nav['item_id']) {
                    echo ' class="current"';
                }
                break;
        }
        ?>><?php echo $nav['nav_title'];?></a>
      <?php }?>
      <?php }?>
      <?php }?>
       </div>
  </div>
</nav>