<!doctype html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE9" />
<meta http-equiv="Content-Type" content="text/html; charset=<?php echo CHARSET;?>">
<title>tstsxxx<?php echo empty($output['seo_title'])?$output['html_title']:$output['seo_title'].'-'.$output['html_title'];?></title>
<meta name="keywords" content="<?php echo $output['seo_keywords']; ?>" />
<meta name="description" content="<?php echo $output['seo_description']; ?>" />
<meta name="author" content="">
<meta name="copyright" content="   All Rights Reserved">
<link href="<?php echo MALL_TEMPLATES_URL;?>/css/base.css" rel="stylesheet" type="text/css">
<link href="<?php echo READS_TEMPLATES_URL;?>/css/layout.css" rel="stylesheet" type="text/css">
<link href="<?php echo MALL_TEMPLATES_URL;?>/css/home_header.css" rel="stylesheet" type="text/css">
<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
      <script src="<?php echo RESOURCE_SITE_URL;?>/js/html5shiv.js"></script>
      <script src="<?php echo RESOURCE_SITE_URL;?>/js/respond.min.js"></script>
<![endif]-->
<script>
var COOKIE_PRE = '<?php echo COOKIE_PRE;?>'; var _CHARSET = '<?php echo strtolower(CHARSET);?>'; var LOGIN_SITE_URL = '<?php echo LOGIN_SITE_URL;?>';var MEMBER_SITE_URL = '<?php echo MEMBER_SITE_URL;?>'; var SITEURL = '<?php echo MALL_SITE_URL;?>'; var MALL_SITE_URL = '<?php echo MALL_SITE_URL;?>'; var RESOURCE_SITE_URL = '<?php echo RESOURCE_SITE_URL;?>';
</script>
<script type="text/javascript" src="<?php echo RESOURCE_SITE_URL;?>/js/jquery.js" charset="utf-8"></script>
<script type="text/javascript" src="<?php echo RESOURCE_SITE_URL;?>/js/jquery-ui/jquery.ui.js"></script>
<script id="dialog_js" type="text/javascript" src="<?php echo RESOURCE_SITE_URL;?>/js/dialog/dialog.js" charset="utf-8"></script>
<script type="text/javascript" src="<?php echo RESOURCE_SITE_URL;?>/js/common.js" charset="utf-8"></script>
<script type="text/javascript" src="<?php echo READS_RESOURCE_SITE_URL;?>/js/common.js" charset="utf-8"></script>
<link href="<?php echo RESOURCE_SITE_URL;?>/js/perfect-scrollbar.min.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<?php echo RESOURCE_SITE_URL;?>/js/perfect-scrollbar.min.js"></script>
<script type="text/javascript">
var PRICE_FORMAT = '<?php echo $lang['currency'];?>%s';
var LOADING_IMAGE = '<?php echo getLoadingImage();?>';
$(function(){
	//search
	$("#searchREADS").children('ul').children('li').click(function(){
		$(this).parent().children('li').removeClass("current");
		$(this).addClass("current");
        $("#form_search").attr("action", $(this).attr("action"));
        $("#app").val($(this).attr("app"));
        $("#feiwa").val($(this).attr("feiwa"));
	});
    var search_current_item = $("#searchREADS").children('ul').children('li.current');
    $("#form_search").attr("action", search_current_item.attr("action"));
    $("#app").val(search_current_item.attr("app"));
    $("#feiwa").val(search_current_item.attr("feiwa"));
});
//登录开关状态
var connect_qq = "<?php echo C('qq_isuse');?>";
var connect_sn = "<?php echo C('sina_isuse');?>";
var connect_wx = "<?php echo C('weixin_isuse');?>";

var connect_weixin_appid = "<?php echo C('weixin_appid');?>";
</script>
</head>
<body>
<!-- 头 -->
<div id="append_parent"></div>
<div id="ajaxwaitid"></div>
<div class="headNew-bg">
    <div class="head-wrap">
        <div class="index feiwa-left">
            <a href="<?php echo MALL_SITE_URL;?>" target="_blank">返回首页</a>
            <em class="download"></em>
        </div>
        <div class="box-xx box_xx-line feiwa-left">|</div>
        <div class="phone">
            <a href="<?php echo WAP_SITE_URL;?>" target="_blank">移动APP</a>
            <em class="download" ><div class="qrcode"><img src="<?php echo UPLOAD_SITE_URL.DS.ATTACH_COMMON.DS.C('mobile_app');?>"></div>
            	        <div class="addurl">
          <?php if (C('mobile_apk')){?>
          <a href="<?php echo C('mobile_apk');?>" target="_blank"><i class="icon-android"></i>Android</a>
          <?php } ?>
          <?php if (C('mobile_ios')){?>
          <a href="<?php echo C('mobile_ios');?>" target="_blank"><i class="icon-apple"></i>iPhone</a>
          <?php } ?>
                        </div>
       </em>
        </div>
        <div class="box-xx box_xx-line feiwa-left">|</div>
        <div class="weixin">
            <a href="javascript:;" target="_blank">微信号</a>
            <em class="download"></em>
        </div>
        <?php if($_SESSION['is_login'] == '1'){?>
        <!--已登录-->
        <div id="isLogin" class="sign-box sign-on" style=""><div class="sign-right"><span><a href="<?php echo urlMall('member_order');?>">我的订单</a></span></div><div class="box-xx firstone">|</div><div class="user-info hover-cont"><span><a href="<?php echo urlMall('member','home');?>">      <?php if ($output['member_info']['level_name']){ ?>
      <div class="nc-grade-mini" style="cursor:pointer;" onclick="javascript:go('<?php echo urlMall('pointgrade','index');?>');"><?php echo $output['member_info']['level_name'];?></div>
      <?php } ?><?php echo $_SESSION['member_name'];?></a></span><div class="hover-show">
      	<a href="<?php echo urlMember('member_information','member');?>">基本信息</a>
      	<a href="<?php echo urlMember('member_security','auth',array('type'=>modify_pwd));?>">修改密码</a>
      	<a href="<?php echo urlMall('member_order');?>">我的订单</a>
      	<a href="<?php echo urlMember('member_voucher','');?>">我的代金券</a>
      	<a href="<?php echo urlMall('member_favorite_goods','');?>">我的收藏</a>
      	<a href="<?php echo urlLogin('login','logout');?>">退出</a></div></div><div class="box-xx">|</div><div class="sign-right hover-cont"><span><a href="<?php echo urlMall('member_mallconsult','add_mallconsult');?>">问平台</a></span><div class="hover-show"><a href="<?php echo urlMall('member_consult','my_consult');?>">商品咨询</a></div><div class="hover-show"><a href="<?php echo urlMall('member_complain','');?>">交易投诉</a></div></div><div class="box-xx">|</div><div class="sign-right hover-cont sign-side"><span id="news_xiaoxi">消息</span><div class="hover-show xx_num"><a href="<?php echo urlMember('member_message','message');?>"><span>我的消息</span></a><a href="<?php echo urlMember('member_message','systemmsg');?>"><span>系统消息</span></a><a class="new_sx_num" href="<?php echo urlMember('member_message','personalmsg');?>" target="_blank">私信</a></div></div><div class="box-xx box_xx-line lastone">|</div><div class="sign-right"><span class="callUs">联系客服<em><?php echo $output['setting_config']['feiwa_phone']; ?></em></span></div></div>
        <!--//已登录-->
        <?php }else{?>
        <!--未登录-->
        <div id="notLogin" class="sign-box to-sign">
            <div class="sign_hos"><a href="<?php echo urlMall('seller_login','show_login');?>" rel="nofollow">商家入口</a></div>
            <div class="box-xx box_xx-line">|</div>
            <div class="sign_doc"><a href="<?php echo urlMall('show_joinin','index');?>" rel="nofollow">商家入驻</a></div>
            <div class="box-xx box_xx-line">|</div>
            <div class="sign-right sign-user"><span><a href="<?php echo urlLogin('login','register');?>" rel="nofollow">用户注册</a></span></div>
            <div class="box-xx box_xx-line">|</div>
            <div class="sign-right"><span><a href="<?php echo urlMember('login');?>" rel="nofollow">登录</a></span></div>
            <div class="box-xx box_xx-line">|</div>
            <div class="sign-right"><span class="callUs">联系客服<em><?php echo $output['setting_config']['feiwa_phone']; ?></em></span></div>
        </div>
        <!--//未登录-->
       <?php }?>
    </div>
</div>	
<script type="text/javascript">
$(function(){
	$(".quick-menu dl").hover(function() {
		$(this).addClass("hover");
	},
	function() {
		$(this).removeClass("hover");
	});

});
</script>
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
});
</script>
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
          <input type="submit" id="button" value="搜索" class="input-submit">
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
                <a href="<?php echo urlMall('promotion', 'list');?>" class="taoListHv">淘特卖</a>
                <div class="">
                    <a href="<?php echo urlMall('promotion', 'list');?>" class="taoListHv">淘特卖</a>
                    <a href="<?php echo urlMall('promotion', 'list');?>">淘特卖首页</a>
                    <a href="<?php echo urlMall('show_groupbuy','index');?>">限时抢购</a>
                    <a href="<?php echo urlMall('brand', 'index');?>">品牌精品</a>
                    <a href="<?php echo urlMall('special', 'special_list');?>">主题抢购<i class="theNew">new</i></a>
                     <a href="<?php echo urlMall('special', 'special_detail',array('special_id'=>'1'));?>">运营保障</a>
                </div>
            </div>
            <a href="<?php echo urlMall('consult', 'index');?>" <?php if($output['index_sign'] == 'consult' && $output['index_sign'] != '0') {echo 'class="now"';} ?>>商家应答</a>
            <a href="<?php echo urlMall('search', 'index');?>" <?php if($output['index_sign'] == 'search' && $output['index_sign'] != '0') {echo 'class="now"';} ?>>淘产品</a>
            <a href="<?php echo urlMall('store_list', 'index');?>" <?php if($output['index_sign'] == 'store_list' && $output['index_sign'] != '0') {echo 'class="now"';} ?>>淘店铺</a>
                        <?php if (C('reads_isuse')){ ?>
            <a href="<?php echo READS_SITE_URL;?>" <?php if($output['index_signs'] == 'reads' && $output['index_sign'] != '0') {echo 'class="now"';} ?>>淘资讯</a><?php } ?>
            	<?php if (C('circle_isuse')){ ?>
            <a href="<?php echo CIRCLE_SITE_URL;?>" <?php if($output['index_sign'] == 'circle' && $output['index_sign'] != '0') {echo 'class="now"';} ?>>淘友圈</a><?php } ?>
            <?php if (C('shareshow_isuse')){ ?>
            <a href="<?php echo SHARESHOW_SITE_URL;?>" <?php if($output['index_sign'] == 'shareshow' && $output['index_sign'] != '0') {echo 'class="now"';} ?>>分享秀</a><?php } ?>
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



<header id="topHeader">
  <div class="warp-all">
    <div class="reads-logo"><a href="<?php echo READS_SITE_URL;?>">
    	<?php echo empty($_GET['class_id'])?'资讯首页':''.$output['article_class_list'][$_GET['class_id']]['class_name'];?>
    </a> </div>
  </div>
</header>
