<?php defined('INSYSVIEW') or exit('Access Invalid!');?>
<?php if($output['circle_info']['circle_status'] == 1){?>
<link href="<?php echo CIRCLE_TEMPLATES_URL;?>/css/ubb.css" rel="stylesheet" type="text/css">
<div class="community-wrap">
    <div class="community-main zoom" style="display: table;">
        <div class="main-ls">
       <?php require_once circle_template('group.top');?>
            <div class="lab-nav">
 <a <?php if($output['thc_id'] == ''){?>class="now"<?php }?> href="<?php echo urlCircle('group','index',array('c_id'=>$output['c_id']));?>">全部</a>
 <?php if(!empty($output['thclass_list'])){?>
          <?php foreach ($output['thclass_list'] as $val){?>
          <a href="javascript:void(0);" onclick="replaceParam('thc_id','<?php echo $val['thclass_id'];?>');" <?php if($output['thc_id'] == $val['thclass_id']){?>class="now"<?php }?>><i></i><?php echo $val['thclass_name'];?></a>
          <?php }?>
          <?php }?>
        <a <?php if($_GET['cream'] == '1'){?>class="now"<?php }?> href="<?php echo urlCircle('group','index',array('c_id'=>$output['c_id'],'cream'=>1));?>" title="<?php echo $lang['circle_digest_theme'];?>"><i></i>精华</a>
                            </div>
             <?php if(!empty($output['theme_list'])){?>
            <ul class="nav-cont">
            	<?php foreach($output['theme_list'] as $val){?>
                                    <li>
 <div class="fl-l">
                        <a href="<?php echo urlmall('sns_circle','index',array('mid'=>$val['member_id']));?>" class="top-img" target="_blank">
                            <img src="<?php echo getMemberAvatar($val['avatar']);?>" alt="<?php echo $val['member_name'];?>">
                        </a>
                        <a class="top-name text-hidden" href="<?php echo urlmall('sns_circle','index',array('mid'=>$val['member_id']));?>" target="_blank"><?php echo $val['member_name'];?></a>
                                                <div class="name-icon icon2"></div>                    </div>
                        <div class="fl-r">
                            <div class="rs-top">
                                <a href="<?php echo urlCircle('theme','theme_detail',array('c_id'=>$val['circle_id'],'t_id'=>$val['theme_id']));?>" target="_blank">[<?php if($val['thclass_name'] != ''){echo $val['thclass_name'];}else{echo $lang['feiwa_default'];}?>]<?php echo $val['theme_name'];if($val['theme_readperm'] > 0){ echo '<font>'.L('feiwa_brackets1,circle_read_permissions').'lv'.$val['theme_readperm'].L('feiwa_brackets2').'</font>';}?></a>
                                                                <?php if($val['is_stick'] == 1){
            	echo '<i class="lab-icon top">置顶</i> ';
            }elseif($val['is_digest'] == 1){
            	echo 'digest';
            }elseif($val['is_shut'] == 1){
            	echo 'close';
            }elseif($val['theme_special']==1){	echo 'poll';  }?> </div>
               <?php if(isset($output['affix_list'][$val['theme_id']])){?>
                        <div class="rs-cont">
                <?php $array = array_slice($output['affix_list'][$val['theme_id']], 0, 5);foreach($array as $v){ ?>
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

                            </ul>
          <div class="navPage-box"><?php echo $output['show_page'];?></div>
        <?php }else{?>
        <div class="no-theme"><span><i></i><?php if($_GET['cream'] == 1){echo $lang['circle_no_digest'];}else{echo $lang['circle_no_theme'];}?></span></div>
        <?php }?>
        </div>
                <div class="main-rs">
                	<?php require_once circle_template('group.sidebar');?>
            

        </div>
        
    </div>
</div>	
  <div class="group-post">
    <h3><?php echo $lang['feiwa_release_new_theme'];?>...</h3>
    <div class="stat"><span class="noborder"><?php echo $lang['circle_today'].$lang['feiwa_colon'];?><em><?php echo $output['todaythcount'];?></em></span><span><?php echo $lang['circle_theme'].$lang['feiwa_colon'];?><em><?php echo $output['circle_info']['circle_thcount'];?></em></span><span><?php echo $lang['circle_firend'].$lang['feiwa_colon'];?><em><?php echo $output['circle_info']['circle_mcount'];?></em></span></div>
    <div class="clear">&nbsp;</div>
    <div class="thread-layer">
      <div class="input-style">
        <?php 
        if(!intval(C('circle_istalk'))){
          echo $lang['circle_theme_cannot_be_published'];
        }else if($_SESSION['is_login'] != 1){
          echo $lang['circle_not_login_prompt'].'<a href="javascript:void(0);" nctype="login">'.$lang['feiwa_login'].'</a>';
        }else if(in_array($output['identity'], array(0,5))){
          echo $lang['circle_not_join_prompt_one'].'<a href="javascript:void(0);" nctype="apply">'.$lang['circle_not_join_prompt_two'].'</a>'.$lang['circle_not_join_prompt_three'];
        }else if($output['identity'] == 4){
          echo $lang['circle_waiting_verify_prompt'];
        }else if($output['identity'] == 6){
          echo $lang['circle_nospeak_prompt'];
        }else{
          echo "<p>&nbsp;</p>";
        }
        ?>
      </div>
      <div class="button-style-tp"><a href="<?php echo urlCircle('theme', 'new_theme', array('sp' => 1, 'c_id' => $output['c_id']));?>">发投票</a></div>
      <div class="button-style"><?php echo $lang['feiwa_release_new_theme'];?></div>
      
    </div>
    <!-- 编辑器 S -->
    <?php require_once circle_template('group.editor');?>
    <!-- 编辑器 E -->
    <div class="clear"></div>
  </div>

<script type="text/javascript" src="<?php echo RESOURCE_SITE_URL;?>/js/jquery.charCount.js"></script> 
<script type="text/javascript" src="<?php echo RESOURCE_SITE_URL;?>/js/jquery.validation.min.js"></script>
<link href="<?php echo RESOURCE_SITE_URL;?>/js/jquery.nyroModal/styles/nyroModal.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<?php echo RESOURCE_SITE_URL;?>/js/jquery.nyroModal/custom.min.js"></script> 
<?php }else if($output['circle_info']['circle_status'] == 2){?>
<div class="warp-all">
  <div class="circle-status"><i class="icon02"></i><h3><?php echo $lang['circle_is_under_approval'];?></h3></div>
</div>
<?php }else if($output['circle_info']['circle_status'] == 3){?>
<div class="warp-all">
  <div class="circle-status"><i class="icon03"></i><h3><?php echo $lang['circle_approval_fail'];?></h3><?php if($output['circle_info']['circle_statusinfo'] != ''){echo '<h5>'.$lang['circle_reason'].$lang['feiwa_colon'].$output['circle_info']['circle_statusinfo'].'</h5>'; }?></div>
</div>
<?php }else{?>
<div class="warp-all">
  <div class="circle-status"><i class="icon01"></i><h3><?php echo $lang['circle_is_closed'];?></h3><?php if($output['circle_info']['circle_statusinfo'] != ''){echo '<h5>'.$lang['circle_reason'].$lang['feiwa_colon'].$output['circle_info']['circle_statusinfo'].'</h5>'; }?></div>
</div>
<?php }?>
<script>
/* 替换参数 */
function replaceParam(key, value, arg)
{
	if(!arguments[2]) arg = 'string';
    var params = location.search.substr(1).split('&');
    var found  = false;
    for (var i = 0; i < params.length; i++)
    {
        param = params[i];
        arr   = param.split('=');
        pKey  = arr[0];
        if(arg == 'string'){
	        if (pKey == key)
	        {
	            params[i] = key + '=' + value;
	            found = true;
	        }
        }else{
        	for(var j = 0; j < key.length; j++){
        		if(pKey ==  key[j]){
        			params[i] = key[j] + '=' + value[j];
    	            found = true;
        		}
        	}
        }
    }
    if (!found)
    {
        if (arg == 'string'){
            value = transform_char(value);
            params.push(key + '=' + value);
        }else{
        	for(var j = 0; j < key.length; j++){
        		params.push(key[j] + '=' + transform_char(value[j]));
        	}
        }
    }
    location.assign(CIRCLE_SITE_URL + '/index.php?' + params.join('&'));
}
</script>