<?php defined('INSYSVIEW') or exit('Access Invalid!');?>
<div class="community-wrap">
    <div class="community-main zoom">
        <div class="main-ls">
            <div class="ls-top">全部讨论组</div>
            <div class="discuss-lab">
        <?php if(!empty($output['circle_list'])){?>
        <?php foreach($output['circle_list'] as $val){?>
     <div class="lab-list">
<div class="fl-l"><img src="<?php echo circleLogo($val['circle_id']);?>" alt="<?php echo $val['circle_name'];?>"></div>
<div class="fl-r"><a class="lab-name text-hidden" href="<?php echo urlCircle('group','index',array('c_id'=>$val['circle_id']));?>"><?php echo $val['circle_name'];?></a><div class="text-hidden">今日+<?php echo intval($output['nowthemecount_array'][$val['circle_id']]['count']);?></div>
                    </div>
                </div>
                <?php }?>
        <?php }?> <div class="lab-list lab-last">
                    <div class="fl-l"></div>
                    <div class="fl-r">
                        <a class="lab-name text-hidden" href="<?php echo urlCircle('search','group');?>">更多讨论组</a>
                        <div class="text-hidden">敬请关注...</div>
                    </div>
                </div>
            </div>

            <div class="lab-nav">
                <a <?php if(empty($_GET['type'])||($_GET['type']==1)){ echo 'class="now"';}?> href="<?php echo urlCircle('index','index',array('type'=>1));?>">热门</a>
                <a <?php if($_GET['type']==2){ echo 'class="now"';}?> href="<?php echo urlCircle('index','index');?>?type=2">最新</a>
                <a <?php if($_GET['type']==3){ echo 'class="now"';}?> href="<?php echo urlCircle('index','index');?>?type=3">精华</a>
                <a <?php if($_GET['type']==4){ echo 'class="now"';}?> href="<?php echo urlCircle('index','index');?>?type=4">热评</a>
                <a <?php if($_GET['type']==5){ echo 'class="now"';}?> href="<?php echo urlCircle('index','index');?>?type=5">晒单<i class="hot-icon"></i></a>
            </div>
            <?php if(!empty($output['circles_list'])){?>
                        <ul class="nav-cont">
               <?php foreach($output['circles_list'] as $val){?>         	
                                <li>
                    <div class="fl-l">
                        <a href="<?php echo urlmall('sns_circle','index',array('mid'=>$val['member_id']));?>" class="top-img" target="_blank">
                            <img src="<?php echo getMemberAvatar($val['avatar']);?>" alt="<?php echo $val['member_name'];?>">
                        </a>
                        <a class="top-name text-hidden" href="<?php echo urlmall('sns_circle','index',array('mid'=>$val['member_id']));?>" target="_blank"><?php echo $val['member_name'];?></a>
                                                <div class="name-icon icon2"></div>                    </div>
                    <div class="fl-r">
                        <div class="rs-top">
                            <a href="<?php echo urlCircle('theme','theme_detail',array('c_id'=>$val['circle_id'],'t_id'=>$val['theme_id']));?>" target="_blank"><?php echo $val['theme_name'];if($val['theme_readperm'] > 0){ echo '<font>'.L('feiwa_brackets1,circle_read_permissions').'lv'.$val['theme_readperm'].L('feiwa_brackets2').'</font>';}?></a>
                <?php if($val['is_stick'] == 1){?> <i class="lab-icon top">置顶</i> <?php }?>                       </div>                             
              <?php if(isset($output['affix_lists'][$val['theme_id']])){?>
                        <div class="rs-cont">
                <?php $array = array_slice($output['affix_lists'][$val['theme_id']], 0, 5);foreach($array as $v){ ?>
 <a href="<?php echo urlCircle('theme','theme_detail',array('c_id'=>$val['circle_id'],'t_id'=>$val['theme_id']));?>" target="_blank"><img src="<?php echo themeImageUrl($v['affix_filethumb']);?>" alt="<?php echo $val['theme_name'];if($val['theme_readperm'] > 0){ echo '<font>'.L('feiwa_brackets1,circle_read_permissions').'lv'.$val['theme_readperm'].L('feiwa_brackets2').'</font>';}?>"></a> 
                <?php }?>
              </div>
              <?php }?>
           
              
                        <div class="rs-bot">
                            <a href="<?php echo urlCircle('theme','theme_detail',array('c_id'=>$val['circle_id'],'t_id'=>$val['theme_id']));?>#quickReply" target="_blank" class="fl-r reply"><i></i>回复(<?php echo $val['theme_commentcount'];?>)</a>
                            <span class="fl-r great"><i></i>浏览(<?php echo $val['theme_browsecount'];?>)</span>
                        </div>
                    </div>
                </li><?php }?>

                            </ul><?php }?>
                        
        </div>

        <div class="main-rs">
        	 <?php if($_SESSION['is_login'] == 0){?>
    <dl class="member-no-login">
      <dd class="avatar"><img src="<?php  echo UPLOAD_SITE_URL.'/'.ATTACH_COMMON.DS.C('default_user_portrait');?>" /> </dd>
      <dd class="welcomes"><?php echo $lang['circle_welcome_to']?><strong><?php echo C('circle_name');?></strong></dd>
      <dd class="quick-link"> <?php echo $lang['circle_login_prompt_one'];?><a href="javascript:void(0);" nctype="login" class="url">[<?php echo $lang['feiwa_login'];?>]</a><?php echo $lang['circle_login_prompt_two'];?><br/>
        <?php echo $lang['circle_register_prompt_one'];?><a href="<?php echo urlLogin('login', 'register', array('ref_url' => getRefUrl()));?>" class="url">[<?php echo $lang['feiwa_register'];?>]</a><?php echo $lang['circle_register_prompt_two'];?></dd>
    </dl>
    <?php }else{?>
    <dl class="member-me-info">
      <dt class="member-name"><?php echo $_SESSION['member_name'];?></dt>
      <dd class="avatar"><img src="<?php  echo getMemberAvatarForID($_SESSION['member_id']);?>" /><a href="<?php echo urlMember('member_information', 'avatar');?>" title="<?php echo $lang['feiwa_edit_avatar'];?>"><?php echo $lang['feiwa_edit_avatar'];?></a></dd>
      <dd class="welcomes"> <?php echo $lang['circle_welcome_back_to'].C('circle_name');?></dd>
      <dd class="go-btn"><a target="_blank" href="index.php?app=p_center"><?php echo $lang['circle_into_user_centre'];?></a></dd>
      <dd class="quick-link"> <a target="_blank" href="index.php?app=p_center&feiwa=my_group" class="url"><?php echo $lang['my_circle'];?></a> <a href="index.php?app=p_center" class="url"><?php echo $lang['my_theme'];?></a> <a href="<?php echo urlLogin('login','logout');?>" class="url"><?php echo $lang['feiwa_logout'];?></a> </dd>
    </dl>
    <?php }?>
                        <div class="rs-tit"><span>热门话题</span></div>
            <ul class="hot-topic">
            <?php if(!empty($output['theme_list'])){?>
            <?php foreach($output['theme_list'] as $val){?>
                                <li>
                    <a class="fl-l" href="
<?php echo urlCircle('theme','theme_detail',array('c_id'=>$val['circle_id'],'t_id'=>$val['theme_id']));?>" target="_blank">
                        <img class="feiwa-no" src="<?php echo $val['affix'];?>" alt="<?php echo $val['theme_name'];?>"></a>
                    <a class="fl-r" href="<?php echo urlCircle('theme','theme_detail',array('c_id'=>$val['circle_id'],'t_id'=>$val['theme_id']));?>" target="_blank"><?php echo $val['theme_name'];?></a>
                </li>            <?php }?>
            <?php }?>

                            </ul>
                            <?php if(!empty($output['more_membertheme'])){?>
                        <div class="rs-tit mar-t46"><span>热门圈友</span></div>
            <ul class="hot-doc">
          <?php foreach ($output['more_membertheme'] as $val){?>
           <li class="clearfix">
                    <a class="pic-box fl-l" target="_blank" href="<?php echo urlmall('sns_circle','index',array('mid'=>$val['member_id']));?>"><img width="45" height="45" src="<?php echo getMemberAvatarForID($val['member_id']);?>" alt="<?php echo $val['member_name'];?>"></a>
                    <div class="arc">
                        <a class="doc-name" target="_blank" href="<?php echo urlmall('sns_circle','index',array('mid'=>$val['member_id']));?>"><?php echo $val['member_name'];?></a>
                        <a class="hospital-name" target="_blank" href="<?php echo urlCircle('theme','theme_detail',array('c_id'=>$val['circle_id'],'t_id'=>$val['theme_id']));?>"><?php echo $val['theme_name'];?></a>

                    </div>
                </li><?php }?>
                            </ul> <?php }?>

            <div class="rs-tit mar-t46">
                <span>热销商品</span>
                <a class="more" href="<?php echo urlmall('search','index')?>" target="_blank">更多<i></i></a>
            </div>
            <ul class="hot-service">
            	<?php if(!empty($output['goods_list']) && is_array($output['goods_list'])) {$i=0; ?><?php foreach($output['goods_list'] as $val) {$i++; ?> 
            		
                                <li class="clearfix">
                    <div class="<?php echo $i>3 ? 'last':'num';?>"><?php echo $i;?></div>
                    <a href="<?php echo urlMall('goods','index',array('goods_id'=> $val['goods_id']));?>" class="name" target="_blank"><?php echo $val['goods_name']; ?></a>
                    <span class="money">¥ <?php echo $val['goods_promotion_price']; ?></span>
                </li><?php }}?>
                           </ul>
<div class="focus-banner flexslider">
      <ul class="slides">
        <?php if(!empty($output['loginpic']) && is_array($output['loginpic'])){?>
        <?php foreach($output['loginpic'] as $val){?>
        <li><a href="<?php if($val['url'] != ''){echo $val['url'];}else{echo 'javascript:void(0);';}?>" target="_blank"><img src="<?php echo UPLOAD_SITE_URL.'/'.ATTACH_CIRCLE.'/'.$val['pic'];?>"></a></li>
        <?php }?>
        <?php }?>
      </ul>
    </div>
        </div>

    </div>
</div>

<script type="text/javascript" src="<?php echo RESOURCE_SITE_URL;?>/js/jcarousel/jquery.jcarousel.min.js" charset="utf-8"></script> 
<!-- 引入幻灯片JS --> 
<script type="text/javascript" src="<?php echo RESOURCE_SITE_URL;?>/js/jquery.flexslider-min.js"></script> 
<script>
$(function(){
// 绑定幻灯片事件 
	$('.flexslider').flexslider();
	//图片轮换
    	$('#mycarousel1').jcarousel({visible: 8,itemFallbackDimension: 300});

	//横高局中比例缩放隐藏显示图片
	$(window).load(function () {
		$(".recommend-theme-list .t-img").VMiddleImg({"width":145,"height":96});
		$(".good-member .t-img").VMiddleImg({"width":140,"height":96});
		$(".show-goods .t-img").VMiddleImg({"width":30,"height":30});
	});
});
$(function() {
	$(".tabs-nav > li > a").mouseover(function(e) {
	if (e.target == this) {
		var tabs = $(this).parent().parent().children("li");
		var panels = $(this).parents('.theme-top:first').find(".tabs-panel");
		var index = $.inArray(this, $(this).parent().parent().find("a"));
		if (panels.eq(index)[0]) {
			tabs.removeClass("tabs-selected")
				.eq(index).addClass("tabs-selected");
			panels.addClass("tabs-hide")
				.eq(index).removeClass("tabs-hide");
		}
	}
	});
});
</script> 