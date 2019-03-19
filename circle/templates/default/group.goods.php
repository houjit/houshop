<?php defined('INSYSVIEW') or exit('Access Invalid!');?>
	
<div class="community-wrap">
    <div class="community-main zoom" style="display: table;">
        <div class="main-ls">
       <?php require_once circle_template('group.top');?>
       	 <div class="lab-nav">
<a href="<?php echo urlCircle('group','index',array('c_id'=>$output['c_id']));?>">话题</a>
<a href="<?php echo urlCircle('group','group_member',array('c_id'=>$output['c_id']));?>">圈友</a>
<a class="now" href="<?php echo urlCircle('group','group_goods',array('c_id'=>$output['c_id']));?>">商品</a>
 </div>
 <div style=" height:35px ;"></div>
       	 <?php if(!empty($output['goods_list'])){?>
        <ul class="share-goods-pinterest" id="groupPinterest">
          <?php foreach($output['goods_list'] as $val){?>
          <li class="item">
            <div class="share-goods-pic thumb"><a href="<?php echo urlMall('goods', 'index', array('goods_id'=>$val['snsgoods_goodsid']));?>" target="_blank" title="<?php echo $val['snsgoods_goodsname'];?>"><img alt="<?php echo $val['snsgoods_goodsname'];?>" title="<?php echo $val['snsgoods_goodsname'];?>" src="<?php echo cthumb($val['snsgoods_goodsimage'], 240, $val['snsgoods_storeid']);?>"></a></div>
            <dl class="share-describe">
              <dt class="member-avatar-s"><img src="<?php echo getMemberAvatarForID($val['share_memberid']);?>" /></dt>
              <dd class="member-name">
                <h4><a href="javascript:void(0);"><?php echo $val['share_membername'];?></a></h4>
                <h5 class="share-date"><?php echo $lang['feiwa_at'];?>
                  <?php if($val['share_isshare'] == 1){?>
                  <em><?php echo @date('Y-m-d H:i', $val['share_addtime']);?></em><?php echo $lang['feiwa_show'];?>
                  <?php }else{?>
                  <em><?php echo @date('Y-m-d H:i', $val['share_likeaddtime']);?></em><?php echo $lang['feiwa_like'];?>
                  <?php }?>
                </h5>
              </dd>
              <dd class="share-content"><i></i>
                <p>
                  <?php if($val['share_content'] != ''){echo $val['share_content'];}else{echo $lang['feiwa_share_default_content'];}?>
                </p>
                <?php if(isset($output['pic_list'][$val['share_id']])){?>
                <ul class="ap-pics">
                  <li class="case"></li>
                  <?php foreach($output['pic_list'][$val['share_id']] as $v){?>
                  <li><span class="thumb"><a href="JavaScript:void(0);"><img src="<?php echo showImgUrl($v);?>" class="t-img" /></a></span></li>
                  <?php }?>
                </ul>
                <?php }?>
                <div class="clear">&nbsp;</div>
              </dd>
            </dl>
            <div class="share-ops"> <span class="ops-like" id="likestat_<?php echo $val['share_goodsid'];?>" title="<?php echo $lang['feiwa_like'];?>"> <a href="javascript:void(0);" feiwa_type="likebtn" data-param='{"gid":"<?php echo $val['share_goodsid'];?>"}' class="<?php echo $val['snsgoods_havelike']==1?'noaction':''; ?>"><i class="<?php echo $val['snsgoods_havelike']==1?'noaction':''; ?>"></i><?php echo $lang['feiwa_like'];?></a> <em feiwa_type="likecount_<?php echo $val['share_goodsid'];?>"><?php echo $val['snsgoods_likenum'];?></em> </span> <span class="ops-comment" title="<?php echo $lang['feiwa_comment'];?>"><a href="<?php echo MALL_SITE_URL?>/index.php?app=member_snshome&feiwa=goodsinfo&mid=<?php echo $val['share_memberid'];?>&id=<?php echo $val['share_id'];?>" target="_blank"><i></i></a><em><?php echo $val['share_commentcount'];?></em></span></div>
            <div class="clear"></div>
          </li>
          <?php }?>
        </ul>
        <div class="clear"></div>
        <div class="navPage-box"><?php echo $output['show_page'];?></div>
        <?php }else{?>
        <div class="no-goods"><span><i></i><?php echo $lang['feiwa_share_goods_null'];?></span></div>
        <?php }?>
       </div>
       <div class="main-rs"><?php require_once circle_template('group.sidebar');?></div>
       </div></div>
<script src="<?php echo RESOURCE_SITE_URL;?>/js/jquery.masonry.js" type="text/javascript"></script> 
<script type="text/javascript">
$(function(){
	var $container = $('#groupPinterest');
		// initialize
		$container.masonry({
  		itemSelector: '.item'
		});
	var msnry = $container.data('masonry');

	//喜欢操作
	$("a[feiwa_type='likebtn']").live('click',function(){
		var obj = $(this);
		var data_str = $(this).attr('data-param');
        eval( "data_str = "+data_str);
        //ajaxget(SITEURL+'/index.php?app=member_snsindex&feiwa=editlike&inajax=1&id='+data_str.gid);
        ajaxget(CIRCLE_SITE_URL+'/index.php?app=member_snsindex&feiwa=editlike&inajax=1&id='+data_str.gid);
	});

//横高局中比例缩放隐藏显示图片
	$(".ap-pics .t-img").VMiddleImg({"width":30,"height":30});
	
});
</script> 
