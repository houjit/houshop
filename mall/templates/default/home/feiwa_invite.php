<?php defined('INSYSVIEW') or exit('Access Invalid!');?>
<link rel=stylesheet type=text/css href="<?php echo MALL_SITE_URL;?>/img/invite_index.css" />

</head>
<body>
<div id="wrapper">
	<div class="banner-invite">
		<div class="inner"></div>
	</div>
	<div id="wrapper_invite">
		<div class="m-box-invite">
			<div class="tit clearfix">
				<h3 class="ico-invite i-invite-t1"></h3>
			</div>
			<div class="con">
				<p>点击下方任意按钮，分享即可！（分享给QQ好友或QQ空间，更容易邀请到好友哦~）</p>                         
				<ul id="bdshare" class="bdshare_t share-list" data="{'url':'<?php echo urlLogin('login','register',array('rec'=>$_SESSION['member_id']));?>'}">

					<li><a class="bds_tsina"><i class="ico-invite i-invite-s1"></i><span>新浪微博</span></a></li>
					<li><a class="bds_tqq"><i class="ico-invite i-invite-s2"></i><span>腾讯微博</span></a></li>
					<li><a class="bds_qzone"><i class="ico-invite i-invite-s3"></i><span>QQ空间</span></a></li>
					<li><a class="bds_sqq" data-cmd="sqq"><i class="ico-invite i-invite-s4"></i><span>QQ好友</span></a></li>
					<li><a class="bds_renren"><i class="ico-invite i-invite-s5"></i><span>人人网</span></a></li>
					<li><a class="bds_kaixin001" data-cmd="kaixin001"><i class="ico-invite i-invite-s6"></i><span>开心网</span></a></li>
					<li><a class="bds_douban"><i class="ico-invite i-invite-s7"></i><span>豆瓣</span></a></li>
				</ul>
				<div class="clear"></div>
			</div>
			<div class="tit clearfix">
				<h3 class="ico-invite i-invite-t2"></h3>
			</div>
			<div class="con">
				<div class="invite-method">
					<p>复制您的专属邀请链接，发送给好友，好友通过该链接注册即可！ <a href="javascript:void(0)" class="show-detail blue_link"><i class="ico-invite i-invite-tip"></i>小窍门</a> </p>
					<div class="invite-detail" style="display:none;">
						<h5>怎么发这个链接？</h5>
						<ol>
							<li><span>1.</span>用聊天工具如：QQ、微信、旺旺、MSN、短信等，私聊或者群聊都行；</li>
							<li><span>2.</span>在新浪微博、腾讯微博发条微博，或者，发个私信神马的；</li>
							<li><span>3.</span>在QQ空间、人人网、开心网，豆瓣等挂个签名改个状态，或者评论转发；</li>
							<li><span>4.</span>分享到蘑菇街、美丽说等购物分享类平台，告诉大家用<?php //echo $output['setting_config']['site_name']; ?>最高能返现金50%哦；</li>
							<li><span>5.</span>大到门户网站的论坛、小到社区小论坛，发帖、回帖、站内短信都可以；</li>
							<li><span>6.</span>百度知道、搜搜问问、新浪爱问、天涯问答，帮助他人学会用<?php //echo $output['setting_config']['site_name']; ?>，更聪明的网购。还有各种其他网站，要好好利用互联网的无限可能哦！</li>
						</ol>
						<i class="ico-invite i-invite-arrow"></i>
					</div>
				</div>
				<div class="invite-code-outer">
										
										<?php if($_SESSION['is_login'] == '1'){?>
                                        <div class="invite-code-outer">
										<input type="text" readonly id="invite_code" value="<?php echo urlLogin('login','register',array('rec'=>$_SESSION['member_id']));?>">
					<div id="invite-act"><a href="javascript:void(0);" class="btn-red-invite" id="invite_copy" style="color:#FFF;font-size:22px;">复制链接</a></div>
									</div>
                                     <?php }else{?><div class="invite-tip-login">您还没有登录，请登录后获取专属邀请链接 <a href="<?php echo urlMember('login');?>" class="btn-red-invite" style="padding:0 20px;height:28px;line-height:28px;font-size:16px;color:#FFF;">登录</a></div> <?php } ?>
									</div>
			</div>
			<div class="tit clearfix">
				<h3 class="ico-invite i-invite-t3"></h3>
							<ul id="comment_tab">
              <li <?php echo $output['type'] == '1'?'class="current"':'';?>><a href="<?php echo urlMall('invite', 'index', array('type' => '1'));?>">一级</a></li>
              <li <?php echo $output['type'] == '2'?'class="current"':'';?>><a href="<?php echo urlMall('invite', 'index', array('type' => '2'));?>">二级</a></li>
              <li <?php echo $output['type'] == '3'?'class="current"':'';?>><a href="<?php echo urlMall('invite', 'index', array('type' => '3'));?>">三级</a></li>
            </ul></div>
			<div class="con">
				<div class="reword-list">
					<table>
						<colgroup>
							<col width="20%">
							<col width="20%">
							<col width="10%">
							<col width="30%">
							<col width="20%">
						</colgroup>
						<thead>
							<tr>
								<th class="nickname">好友昵称</th>
								<th>邀请等级</th>
								<th>订单数量</th>
								<th>邀请时间</th>
								<th>您获得的奖励</th>
							</tr>
						</thead>
						<tbody>         
                        <?php if(!empty($output['list_log']) && is_array($output['list_log'])){?>
            <?php foreach($output['list_log'] as $k=>$val){?>

      <tr class="bd-line">
	   <td class="goods-price"><?php echo $val['member_name'];?></th>
       <td class="goods-price"><?php echo $output['type'] == '1'?'一级':'';?><?php echo $output['type'] == '2'?'二级':'';?><?php echo $output['type'] == '3'?'三级':'';?></th>
        <td class="goods-time"><?php echo $val['invite_num'];?></td>
        <td class="goods-price"><?php echo @date('Y-m-d',$val['member_time']);?></td>
        <td><?php echo $val['invite_amount'];?>元</td>
      </tr>
      <?php } ?>      <tr>
        <td colspan="20"><div class="pagination"><?php echo $output['show_page']; ?></div></td>
      </tr>
      <?php } else { ?> 
														<tr>
								<td colspan="5" >
    
									<div class="no-recode">
										<p>每邀请成功1个好友，只要他在本站购物你就能获得返利，<br/>最高可获得50%消费返利！</p>
										<a href="<?php echo urlMall('invite','index');?>#wrapper_invite" class="btn-red-invite" style="font-size:22px;">免费拿奖励，行动！</a>
									</div>
								</td>
							</tr><?php } ?>
									   

      		</tbody>		
					</table>
				</div>
				<div class="reword-list reword-charts">
					<table>
						<tbody>
							<tr>
								<th>排名</th>
								<th class="nickname">用户名称</th>
								<th class="fanli">获得的奖励金额</th>
							</tr>
														<tr>
								<td><i class="top_b">1</i></td>
								<td class="nickname"><div class="nicknamediv">j42****</div></td>
								<td class="fanli">25800.00元</td>
							</tr>
														<tr>
								<td><i class="top_b">2</i></td>
								<td class="nickname"><div class="nicknamediv">luc****</div></td>
								<td class="fanli">14745.00元</td>
							</tr>
														<tr>
								<td><i class="top_b">3</i></td>
								<td class="nickname"><div class="nicknamediv">197****</div></td>
								<td class="fanli">13055.00元</td>
							</tr>
														<tr>
								<td><i class="top_b">4</i></td>
								<td class="nickname"><div class="nicknamediv">yan****</div></td>
								<td class="fanli">12640.00元</td>
							</tr>
														<tr>
								<td><i class="top_b">5</i></td>
								<td class="nickname"><div class="nicknamediv">心****</div></td>
								<td class="fanli">7235.00元</td>
							</tr>
														<tr>
								<td><i class="top_b">6</i></td>
								<td class="nickname"><div class="nicknamediv">假****</div></td>
								<td class="fanli">7065.00元</td>
							</tr>
														<tr>
								<td><i class="top_b">7</i></td>
								<td class="nickname"><div class="nicknamediv">向****</div></td>
								<td class="fanli">6650.00元</td>
							</tr>
														<tr>
								<td><i class="top_b">8</i></td>
								<td class="nickname"><div class="nicknamediv">ang****</div></td>
								<td class="fanli">5275.00元</td>
							</tr>
														<tr>
								<td><i class="top_b">9</i></td>
								<td class="nickname"><div class="nicknamediv">浣****</div></td>
								<td class="fanli">5140.00元</td>
							</tr>
														<tr>
								<td><i class="top_b">10</i></td>
								<td class="nickname"><div class="nicknamediv">shi****</div></td>
								<td class="fanli">5090.00元</td>
							</tr>
													</tbody>
					</table>
				</div>
				<div class="clear"></div>
			</div>
			<div class="tit clearfix">
				<h3 class="ico-invite i-invite-t4"></h3>
			</div>
			<div class="bar-notice">
				<ol>
					<li>记得注册之后多多教教好友怎么用哦！获得更高奖励机会更高！</li>
					<li>不要为了获得小小的邀请奖励而失掉了自己的诚信，我们会人工核查，对于查实的<font color="#FF0000">作弊行为</font>，我们将收回该帐号全部的邀请奖励，<br />严重者将冻结所有收入并永久封号；</li>
					<li>当好友通过您的邀请链接访问FeiWa后，只要TA在1个小时内注册，均为有效；</li>
					<li>不要以注册送钱或注册送积分等利益诱导来吸引注册，否则将给予处罚；</li>
					<li>为了合作商城的正常利益,请不要到<?php //echo $output['setting_config']['site_name']; ?>的合作商城进行推广；</li>
					<p style="color:#FF0000">*作弊行为：包括但不限于使用相同的电脑、相同的IP地址在同一天内注册多个帐号，以骗取邀请奖励的行为。</p>
				</ol>
			</div>
			<div class="clear"></div>
		</div>
	</div>
    <?php if($_SESSION['is_login'] == '1'){?>
 <!-- Baidu Button BEGIN --> 
      <script type="text/javascript" id="bdshare_js" data="type=tools" ></script> 
      <script type="text/javascript" id="bdshell_js"></script> 
      <script type="text/javascript">
    var bds_config = {'bdText':'赚钱是一种能力，花钱是一种技术，我能力有限，技术却很高。幸好及时发现了<?php //echo $output['setting_config']['site_name']; ?>，挣钱能力涨了，省钱能力猛增！！','bdPic':'<?php echo UPLOAD_SITE_URL.DS.ATTACH_COMMON.DS.$output['setting_config']['site_logo']; ?>','bdDesc':'<?php //echo $output['setting_config']['site_name']; ?>现有800多家合作商城，同时提供上万张优惠券任你领，已有超过1000万的人正在使用<?php //echo $output['setting_config']['site_name']; ?>赚钱，再不注册，你就out了','review':'off'};
    document.getElementById("bdshell_js").src = "http://bdimg.share.baidu.com/static/js/shell_v2.js?cdnversion=" + new Date().getHours();
</script> 
      <!-- Baidu Button END --><?php } ?> 
<script type="text/javascript">
$(function() {
    //小窍门
    var invite_detail_timeout = null;
    $(".show-detail").hover(function() {
        clearTimeout(invite_detail_timeout);
        $(this).addClass("hover").parents(".invite-method").find(".invite-detail").show();

    },
    function() {
        var this_a = $(this);
        invite_detail_timeout = setTimeout(function() {
            this_a.removeClass("hover").parents(".invite-method").find(".invite-detail").hide();

        },
        300);

    });
    $(".invite-method").find(".invite-detail").live('mouseover', 
    function() {
        clearTimeout(invite_detail_timeout);

    }).live('mouseout', 
    function() {
        invite_detail_timeout = setTimeout(function() {
            $(".show-detail").removeClass("hover");
            $(".invite-method").find(".invite-detail").hide();

        },
        300);

    });
    
	<?php if($_SESSION['is_login'] !== '1'){?>
	//分享
    $(".share-list a").click(function() {
		        alert('亲，您还没有登录哦！');
		window.location.href='<?php echo urlMember('login');?>';
		    });<?php } ?>
	// 判断用户是否登录以及显示
    $('#invite_code').live('click', 
    function() {
        $(this).select();
    });
    $("#show_tjsj").show();
    //复制
    var invite_timeout = null;
    function copyText() {
        var clip = new ZeroClipboard.Client();
        clip.setHandCursor(true);
        clip.setCSSEffects(true);
        $(window).resize(function() {
            clip.reposition();
        });
        clip.addEventListener("mouseOver", 
        function(client) {
            client.setText($('#invite_code').val());
        });
        clip.addEventListener('complete', 
        function(client) {
            if (CurrentUser.UserId != undefined || CurrentUser.UserId != "") {
                if ($("#invite-act").find(".tip-success").length > 0) {
                    clearTimeout(invite_timeout);
                    invite_timeout = setTimeout(function() {
                        $("#invite-act").find(".tip-success").remove();

                    },
                    3000);
                } else {
                    $("#invite-act").append('<span class="tip-success"><i class="ico-invite i-invite-true"></i>链接复制成功</span>');
                    invite_timeout = setTimeout(function() {
                        $("#invite-act").find(".tip-success").remove();

                    },
                    3000);
                }
            }
        });
        clip.glue("invite_copy");
    }
    copyText();
})
</script>