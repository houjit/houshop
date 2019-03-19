<?php defined('INSYSVIEW') or exit('Access Invalid!');?>
<?php if(!empty($output['friendship_list'])){?>
<div class="rs-tit"><span>热门讨论组</span></div>
            <ul class="hot-crumbs">
   <?php foreach ($output['friendship_list'] as $val){?>
                                <li>
                    <a class="fl-l" href="<?php echo urlCircle('group','index',array('c_id'=>$val['friendship_id']));?>">
                        <img src="<?php echo circleLogo($val['friendship_id']);?>" alt="<?php echo $val['friendship_name'];?>"></a>
                    <div class="fl-r">
                        <a href="<?php echo urlCircle('group','index',array('c_id'=>$val['friendship_id']));?>" class="crumbs-name text-hidden"><?php echo $val['friendship_name'];?></a>
                        <p class="text-hidden"><?php echo $val['friendship_desc'];?></p>
                        <div>今日+<span><?php echo $val['friendship_count'];?></span></div>
                    </div>
                </li><?php }?>
                            </ul><?php }?>
<?php if(!empty($output['hots_themelist'])){?>
                        <div class="rs-tit mar-t46"><span>热门话题</span></div>
            <ul class="hot-topic">
            <?php foreach($output['hots_themelist'] as $val){?>
                                <li>
                    <a class="fl-l" href="
<?php echo urlCircle('theme','theme_detail',array('c_id'=>$val['circle_id'],'t_id'=>$val['theme_id']));?>" target="_blank">
                        <img class="feiwa-no" src="<?php echo $val['affix'];?>" alt="<?php echo $val['theme_name'];?>"></a>
                    <a class="fl-r" href="<?php echo urlCircle('theme','theme_detail',array('c_id'=>$val['circle_id'],'t_id'=>$val['theme_id']));?>" target="_blank"><?php echo $val['theme_name'];?></a>
               </li><?php }?>
                            </ul><?php }?>
            <?php if(!empty($output['star_member'])){?>
            <div class="rs-tit mar-t46"><span>明星圈友</span></div>
            <ul class="hot-doc">
            	      
      <?php foreach($output['star_member'] as $val){?>
                                    <li class="clearfix">
                        <a class="pic-box fl-l" target="_blank" href="<?php echo urlmall('sns_circle','index',array('mid'=>$val['member_id']));?>"><img width="45" height="45" src="<?php echo getMemberAvatarForID($val['member_id']);?>" alt="<?php echo $val['member_name'];?>"></a>
                        <div class="arc">
                            <a class="doc-name" target="_blank" href="<?php echo urlmall('sns_circle','index',array('mid'=>$val['member_id']));?>"><?php echo $val['member_name'];?></a>
                            <a class="hospital-name" target="_blank" href="<?php echo urlmall('sns_circle','index',array('mid'=>$val['member_id']));?>"><?php echo $val['cm_thcount'];?></a>

                        </div>
                    </li><?php }?>

                            </ul><?php }?>
<?php if(!empty($output['goods_lists'])){$i=0;?>
            <div class="rs-tit mar-t46">
                <span>圈友分享商品</span><a class="more" href="<?php echo urlCircle('group','group_goods',array('c_id'=>$output['c_id']));?>" target="_blank">更多<i></i></a>
            </div>
            <ul class="hot-service">
            	<?php foreach($output['goods_lists'] as $val){$i++?>
                                    <li class="clearfix">
                        <div class="<?php echo $i>3 ? 'last':'num';?>"><?php echo $i?></div>
                        <a href="<?php echo urlMall('goods', 'index', array('goods_id'=>$val['snsgoods_goodsid']));?>" class="name" target="_blank"><?php echo $val['snsgoods_goodsname'];?></a>
                        <span class="money">¥ <?php echo $val['snsgoods_goodsprice'];?></span>
                    </li><?php }?>
                           </ul><?php }?>

<div class="sidebar">
	<div class="feiwa-gg">
		<?php if($output['circle_info']['circle_notice'] != ''){ echo '公告：'.$output['circle_info']['circle_notice'];}else{?>
        <span class="no-notice"><i></i><?php echo $lang['circle_no_notice'];?></span>
        <?php }?>
	</div>
  <?php if(in_array($output['identity'], array(1,2,3))){?>
  <div class="my-info">
    <div class="avatar"><img src="<?php echo getMemberAvatarForID($output['cm_info']['member_id']);?>"/><a href="<?php echo urlMember('member_information', 'avatar');?>" title="<?php echo $lang['feiwa_edit_avatar'];?>"><?php echo $lang['feiwa_edit_avatar'];?></a></div>
    <dl>
      <dt>
        <h3><a href="index.php?app=p_center" target="_blank"><?php echo $lang['feiwa_inro_personal_center'];?></a></h3>
      </dt>
      <dd>
        <?php echo $lang['feiwa_rank'].$lang['feiwa_colon'];?>
        <?php echo memberLevelHtml($output['cm_info']);?>
      </dd>
      <dd class="mt10">
        <?php echo $lang['feiwa_exp'].$lang['feiwa_colon'];?>
        <div class="cm-exp">
          <?php if($output['cm_info']['cm_level'] == 16){?>
          <p style="width: 100%;"> </p>
          <i> <?php echo $output['cm_info']['cm_exp'];?></i>
          <?php }else{?>
          <p style="width: <?php echo intval($output['cm_info']['cm_nextexp']) != 0?sprintf('%.2f%%', intval($output['cm_info']['cm_exp'])/intval($output['cm_info']['cm_nextexp'])*100):0;?>"> </p>
          <i> <?php echo $output['cm_info']['cm_exp'].'/'.$output['cm_info']['cm_nextexp'];?></i>
          <?php }?>
        </div>
      </dd>
    </dl>
  </div>
  <?php }?>
</div>
<script>
$(function(){
	//帖子列表隔行变色
	$(".group-theme-list li:odd").css("background-color","#F8F9FA");
	$(".group-theme-list li:even").css("background-color","#FCFCFC");

//侧边栏tab切换
$(".tabs-nav > li > a").click(function(e) {
	if (e.target == this) {
		var tabs = $(this).parent().parent().children("li");
		var panels = $(this).parent().parent().parent().children(".tabs-panel");
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