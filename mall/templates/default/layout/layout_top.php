<?php defined('INSYSVIEW') or exit('Access Invalid!');?>
<div id="append_parent"></div>
<div id="ajaxwaitid"></div>
<?php if ($output['hidden_nctoolbar'] != 1) {?>
<div id="ncToolbar" class="nc-appbar">
  <div class="nc-appbar-tabs" id="b appBarTabs">
    <div class="ever">
      <?php if (!$output['hidden_rtoolbar_cart']) { ?>
      <div class="cart"><a href="javascript:void(0);" id="rtoolbar_cart"><span class="icon"></span> <span class="name">购物车</span><i id="rtoobar_cart_count" class="new_msg" style="display:none;"></i></a></div>
      <?php } ?>
      <?php if (!$output['hidden_rtoolbar_compare']) { ?>
      <div class="compare"><a href="javascript:void(0);" id="compare"><span class="icon"></span><span class="tit">商品对比</span></a></div>
      <?php } ?>
    </div>
    <div class="variation">
      <div class="middle">
        <?php if ($_SESSION['is_login']) {?>
        <div class="user" nctype="a-barUserInfo">
        <a href="javascript:void(0);">
          <div class="avatar"><img src="<?php echo getMemberAvatar($_SESSION['avatar']);?>"/></div>
          <span class="tit">我的账户</span>
        </a></div>
        <div class="user-info" nctype="barUserInfo" style="display:none;"><i class="arrow"></i>
          <div class="avatar"><img src="<?php echo getMemberAvatar($_SESSION['avatar']);?>"/>
            <div class="frame"></div>
          </div>
          <dl>
            <dt>Hi, <?php echo $_SESSION['member_name'];?></dt>
            <dd>当前等级：<strong nctype="barMemberGrade"><?php echo $output['member_info']['level_name'];?></strong></dd>
            <dd>当前经验值：<strong nctype="barMemberExp"><?php echo $output['member_info']['member_exppoints'];?></strong></dd>
          </dl>
        </div>
        <?php } else {?>
        <div class="user" nctype="a-barLoginBox">
        <a href="javascript:void(0);" >
          <div class="avatar"><img src="<?php echo getMemberAvatar($_SESSION['avatar']);?>"/></div>
          <span class="tit" >会员登录</span>
        </a>
        </div>
		<div class="user-login-box" nctype="barLoginBox" style="display:none;"> <i class="arrow"></i> <a href="javascript:void(0);" class="close-a" nctype="close-barLoginBox" title="关闭">X</a>
          <form id="login_form" method="post" action="<?php echo urlLogin('login', 'login');?>" onsubmit="ajaxpost('login_form', '', '', 'onerror')">
            <?php Security::getToken();?>  <input type="hidden" name="form_submit" value="ok" />
            <input name="nchash" type="hidden" value="<?php echo getNchash('login','index');?>">
            <dl>
              <dt><strong>登录名</strong></dt>
              <dd>
                <input type="text" class="text" autocomplete="off" name="user_name" autofocus>
                <label></label>
              </dd>
            </dl>
            <dl>
              <dt><strong>登录密码</strong><a href="<?php echo urlLogin('login', 'forget_password');?>" target="_blank">忘记登录密码？</a></dt>
              <dd>
                <input type="password" class="text" name="password" autocomplete="off">
                <label></label>
              </dd>
            </dl>
                        <dl>
              <dt><strong>验证码</strong><a href="javascript:void(0)" class="ml5" onclick="javascript:document.getElementById('codeimage').src='index.php?app=seccode&amp;feiwa=makecode&amp;nchash=<?php echo getNchash('login','index');?>&amp;t=' + Math.random();">更换验证码</a></dt>
              <dd>
                <input type="text" name="captcha" autocomplete="off" class="text w130" id="captcha" maxlength="4" size="10">
                <img src="" name="codeimage" border="0" id="codeimage" class="vt">
                <label></label>
              </dd>
            </dl>
                        <div class="bottom">
              <input type="submit" class="submit" value="确认">
              <input type="hidden" value="" name="ref_url">
              <a href="<?php echo urlLogin('login', 'register', array('ref_url' => $_GET['ref_url']));?>" target="_blank">注册新用户</a> 
			        <?php if (C('qq_isuse') == 1 || C('sina_isuse') == 1 || C('weixin_isuse') == 1){?>
      <h4><?php echo $lang['feiwa_otherlogintip'];?></h4>
               <?php if (C('weixin_isuse') == 1){?>
                            <a href="javascript:void(0);" onclick="ajax_form('weixin_form', '微信账号登录', '<?php echo urlLogin('connect_wx', 'index');?>', 360);" title="微信账号登录" class="mr20">微信</a><?php } ?>
							<?php if (C('sina_isuse') == 1){?>
                                          <a href="<?php echo MEMBER_SITE_URL;?>/api.php?app=tosina" title="新浪微博账号登录" class="mr20">新浪微博</a><?php } ?>
                                          <?php if (C('qq_isuse') == 1){?><a href="<?php echo MEMBER_SITE_URL;?>/api.php?app=toqq" title="QQ账号登录" class="mr20">QQ账号</a><?php } ?><?php } ?>
                          </div>
          </form>
        </div>
        <?php }?>
        <div class="prech">&nbsp;</div>
        <?php if(C('node_chat')){ ?>
        <div class="chat"><a href="javascript:void(0);" id="chat_show_user"><span class="icon"></span><i id="new_msg" class="new_msg" style="display:none;"></i><span class="tit">在线联系</span></a></div>
        <?php } ?>
      </div>
      <div class="l_qrcode"><a href="javascript:void(0);" class=""><span class="icon"></span><code><img src="<?php echo UPLOAD_SITE_URL.DS.ATTACH_MOBILE.DS.C('mobile_wx');?>"></code></a></div>
      <div class="gotop"><a href="javascript:void(0);" id="gotop"><span class="icon"></span><span class="tit">返回顶部</span></a></div>
    </div>
    <div class="content-box" id="content-compare">
      <div class="top">
        <h3>商品对比</h3>
        <a href="javascript:void(0);" class="close" title="隐藏"></a></div>
      <div id="comparelist"></div>
    </div>
    <div class="content-box" id="content-cart">
      <div class="top">
        <h3>我的购物车</h3>
        <a href="javascript:void(0);" class="close" title="隐藏"></a></div>
      <div id="rtoolbar_cartlist"></div>
    </div>
  </div>
</div>


<script type="text/javascript">
//登录开关状态
var connect_qq = "<?php echo C('qq_isuse')?>";
var connect_sn = "<?php echo C('sina_isuse')?>";
var connect_wx = "<?php echo C('weixin_isuse')?>";
$(function(){
	$(".l_qrcode a").hover(function() {
		$(this).addClass("hover");
	},
	function() {
		$(this).removeClass("hover");
	});
	
});
//返回顶部
backTop=function (btnId){
	var btn=document.getElementById(btnId);
	var scrollTop = document.documentElement.scrollTop || document.body.scrollTop;
	window.onscroll=set;
	btn.onclick=function (){
		btn.style.opacity="0.5";
		window.onscroll=null;
		this.timer=setInterval(function(){
		    scrollTop = document.documentElement.scrollTop || document.body.scrollTop;
			scrollTop-=Math.ceil(scrollTop*0.1);
			if(scrollTop==0) clearInterval(btn.timer,window.onscroll=set);
			if (document.documentElement.scrollTop > 0) document.documentElement.scrollTop=scrollTop;
			if (document.body.scrollTop > 0) document.body.scrollTop=scrollTop;
		},10);
	};
	function set(){
	    scrollTop = document.documentElement.scrollTop || document.body.scrollTop;
	    btn.style.opacity=scrollTop?'1':"0.5";
	}
};
backTop('gotop');

//动画显示边条内容区域
$(function() {
    ncToolbar();
    $(window).resize(function() {
        ncToolbar();
    });
    function ncToolbar() {
        if ($(window).width() >= 1240) {
            $('#appBarTabs >.variation').show();
        } else {
            $('#appBarTabs >.variation').hide();
        }
    }
    $('#appBarTabs').hover(
        function() {
            $('#appBarTabs >.variation').show();
        }, 
        function() {
            ncToolbar();
        }
    );
    $("#compare").click(function(){
    	if ($("#content-compare").css('right') == '-210px') {
 		   loadCompare(false);
 		   $('#content-cart').animate({'right': '-210px'});
  		   $("#content-compare").animate({right:'35px'});
    	} else {
    		$(".close").click();
    		$(".chat-list").css("display",'none');
        }
	});
    $("#rtoolbar_cart").click(function(){
        if ($("#content-cart").css('right') == '-210px') {
         	$('#content-compare').animate({'right': '-210px'});
    		$("#content-cart").animate({right:'35px'});
    		if (!$("#rtoolbar_cartlist").html()) {
    			$("#rtoolbar_cartlist").load('index.php?app=cart&feiwa=ajax_load&type=html');
    		}
        } else {
        	$(".close").click();
        	$(".chat-list").css("display",'none');
        }
	});
	$(".close").click(function(){
		$(".content-box").animate({right:'-210px'});
      });

	$(".quick-menu dl").hover(function() {
		$(this).addClass("hover");
	},
	function() {
		$(this).removeClass("hover");
	});
		$(".links_a").hover(function() {
		$(this).addClass("hover");
	},
	function() {
		$(this).removeClass("hover");
	});

    // 右侧bar用户信息
    $('div[nctype="a-barUserInfo"]').click(function(){
        $('div[nctype="barUserInfo"]').toggle();
    });
    // 右侧bar登录
    $('div[nctype="a-barLoginBox"]').click(function(){
        $('div[nctype="barLoginBox"]').toggle();
        document.getElementById('codeimage').src='index.php?app=seccode&feiwa=makecode&nchash=<?php echo getNchash('login','index');?>&t=' + Math.random();
    });
    $('a[nctype="close-barLoginBox"]').click(function(){
        $('div[nctype="barLoginBox"]').toggle();
    });
    <?php if ($output['cart_goods_num'] > 0) { ?>
    $('#rtoobar_cart_count').html(<?php echo $output['cart_goods_num'];?>).show();
    <?php } ?>
    });
</script>
<?php } ?>
<?php if ($output['setting_config']['feiwa_top_banner_status']>0){ ?>
<div style=" background:<?php echo $output['setting_config']['feiwa_top_banner_color']; ?>;">
<div class="wrapper" id="t-sp" style="display: none;">
<a href="javascript:void(0);" class="close" title="关闭"></a>
<a href="<?php echo $output['setting_config']['feiwa_top_banner_url']; ?>" title="<?php echo $output['setting_config']['feiwa_top_banner_name']; ?>"><img border="0" src="<?php echo UPLOAD_SITE_URL.DS.ATTACH_COMMON.DS.$output['setting_config']['feiwa_top_banner_pic']; ?>" alt=""></a></div>
<script type="text/javascript">
$(function(){
	//search
	var skey = getCookie('top_s');
		if(skey){
		$("#t-sp").hide();
		} else {
			$("#t-sp").slideDown(800);
			}
		$("#t-sp .close").click(function(){
			setCookie('top_s','yes',1);
			$("#t-sp").hide();
	});	
});
</script></div><?php } ?>
	
	
	
	
<div class="headNew-bg">
    <div class="head-wrap">
        <div class="index feiwa-left">
            <a href="<?php echo MALL_SITE_URL;?>" target="_blank">返回首页</a>
            <em class="download"></em>
        </div>
        <?php if(0>3){ ?>
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
        <?php  } ?>
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
            <div class="sign-right sign-user"><span><a href="<?php echo urlMember('login','register');?>" rel="nofollow">用户注册</a></span></div>
            <div class="box-xx box_xx-line">|</div>
            <div class="sign-right"><span><a href="<?php echo urlMember('login','index');?>" rel="nofollow">登录</a></span></div>
            <div class="box-xx box_xx-line">|</div>
            <div class="sign-right"><span class="callUs">联系客服<em><?php echo $output['setting_config']['feiwa_phone']; ?></em></span></div>
        </div>
        <!--//未登录-->
       <?php }?>
    </div>
</div>	
