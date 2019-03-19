<?php defined('INSYSVIEW') or exit('Access Invalid!');?>
	
<div class="community-wrap">
    <div class="community-main zoom" style="display: table;">
        <div class="main-ls">
       <?php require_once circle_template('group.top');?>
       	 <div class="lab-nav">
<a href="<?php echo urlCircle('group','index',array('c_id'=>$output['c_id']));?>">话题</a>
<a class="now" href="<?php echo urlCircle('group','group_member',array('c_id'=>$output['c_id']));?>">圈友</a>
<a href="<?php echo urlCircle('group','group_goods',array('c_id'=>$output['c_id']));?>">商品</a>
 </div>
 <div style=" height:35px ;"></div>	
	    <div class="group-member">
      <?php if(in_array($output['identity'], array(1,2,3,6))){?>
      <ul class="group-member-list">
      <h3><?php echo $lang['circle_my_cart'];?></h3>
        <li>
          <dl class="member-info">
            <dt class="member-name"><a target="_blank" href="<?php echo MALL_SITE_URL;?>/index.php?app=sns_circle&mid=<?php echo $output['cm_info']['member_id'];?>"><?php echo $output['cm_info']['member_name'];?></a></dt>
            <dd class="member-avatar-m"><img src="<?php echo getMemberAvatarForID($output['cm_info']['member_id']);?>" /></dd>
            <dd class="time"><em><?php echo @date('Y-m-d', $output['cm_info']['cm_jointime']);?></em><?php echo $lang['circle_join'];?></dd>
            <dd><?php echo memberIdentity($output['cm_info']['is_identity']);?>&nbsp;<?php echo memberLevelHtml($output['cm_info']);?></dd>
            <dd class="member-intro-edit"><i></i><a href="javascript:void(0);" nctype="cmEdit"><?php echo $lang['feiwa_edit'];?></a></dd>
          </dl>
          <p class="intro" title="<?php if($output['cm_info']['cm_intro'] != ''){echo $output['cm_info']['cm_intro'];}else{echo $lang['circle_introduction_null'];}?>"><?php if($output['cm_info']['cm_intro'] != ''){echo $output['cm_info']['cm_intro'];}else{echo $lang['circle_introduction_null'];}?></p>
        </li>
      </ul>
      <div class="clear"></div>
      <?php }?>
      <ul class="group-member-list">
      <h3><?php echo $lang['circle_other_friend'];?></h3>
      <?php if(!empty($output['cm_list'])){?>
      <?php foreach ($output['cm_list'] as $val){?>
        <li>
          <dl class="member-info">
            <dt class="member-name"><a target="_blank" href="<?php echo MALL_SITE_URL;?>/index.php?app=sns_circle&mid=<?php echo $val['member_id'];?>"><?php echo $val['member_name'];?></a></dt>
            <dd class="member-avatar-m"><img src="<?php echo getMemberAvatarForID($val['member_id']);?>" /></dd>
            <dd class="time"><em><?php echo @date('Y-m-d', $val['cm_jointime']);?></em><?php echo $lang['circle_join'];?></dd>
            <dd><?php echo memberIdentity($val['is_identity']);?>&nbsp;<?php echo memberLevelHtml($val);?></dd>
          </dl>
          <p class="intro" title="<?php if($val['cm_intro'] != ''){echo $val['cm_intro'];}else{echo $lang['circle_introduction_null'];}?>"><?php if($val['cm_intro'] != ''){echo $val['cm_intro'];}else{echo $lang['circle_introduction_null'];}?></p>
        </li>
      <?php }?>
      <?php }?>
      </ul>
      <div class="clear"></div>
      <div class="navPage-box"><?php echo $output['show_page'];?></div>
    </div>
	</div>
	       <div class="main-rs"><?php require_once circle_template('group.sidebar');?></div>
      </div></div>
<script type="text/javascript" src="<?php echo RESOURCE_SITE_URL;?>/js/jquery.validation.min.js"></script> 
<script>
$(function(){
	$('a[nctype="cmEdit"]').click(function(){
		if(_ISLOGIN){
    		_uri = "<?php echo CIRCLE_SITE_URL;?>/index.php?app=group&feiwa=group_memberedit&inajax=1&c_id=<?php echo $output['c_id'];?>";
    		CUR_DIALOG = ajax_form('memberedit', '<?php echo $lang['circle_edit_personal_information'];?>', _uri, 520);
		}
	});
});
</script>