<?php defined('INSYSVIEW') or exit('Access Invalid!');?>
<?php if(!empty($_SESSION['member_id'])) { ?>
<script type="text/javascript">
$(document).ready(function(){
    //分享
    $("#btn_sns_share").click(function(){
        $("#commend_message").val("");
        $("#_share_title").html($(this).attr("data-title"));
        $("#_share_image").attr("src", $(this).attr("data-image"));
        $("#_share_publisher").html("<?php echo $lang['reads_text_publisher'];?><?php echo $lang['feiwa_colon'];?>" + $(this).attr("data-publisher"));
        $("#_share_origin").html("<?php echo $lang['reads_text_origin'];?><?php echo $lang['feiwa_colon'];?>" + $(this).attr("data-origin"));
        $("#_share_publish_time").html($(this).attr("data-publish_time"));
        $("#_share_abstract").html($(this).attr("data-abstract"));
        $("#div_sns_share").show_dialog({title:'<?php echo $lang['reads_text_share'];?>', width:480});
    });
    $('#commend_message').feiwa_text_count();
    $("#btn_share_publish").click(function(){
        if($('#commend_message').val().length <= 140) {
            $("#div_sns_share").hide();
            $("#btn_sns_share > em > b").feiwa_count();
            ajaxpost('share_form', '', '', 'onerror'); 
        }
    });
});
</script>
<!-- 弹出层开始 -->

<div id="div_sns_share" style="display:none;" class="reads-share">
<form action="<?php echo READS_SITE_URL;?>/index.php?app=share&feiwa=share_save&type=<?php echo $_GET['app'];?>" method="post" id="share_form" class="feededitor">
  <input type="hidden" value="<?php echo $output['detail_object_id'];?>" name="share_id">
  </input>
  <input type="hidden" value="<?php echo $output[$_GET['app'].'_detail'][$_GET['app'].'_title'];?>" name="share_title">
  </input>
  <input type="hidden" value="<?php echo getREADSArticleImageUrl($output[$_GET['app'].'_detail'][$_GET['app'].'_attachment_path'], $output[$_GET['app'].'_detail'][$_GET['app'].'_image']);?>" name="share_image">
  </input>
  <dl class="share-target">
    <dt id="_share_title" class="title"></dt>    
    <dd class="cover"><a href="JavaScript: void(0);"><img id="_share_image" src="" alt="" /></a></dd>
    <dd class="sub"><span id="_share_publisher"></span><span id="_share_origin"></span><!--<span id="_share_publish_time"></span>--></dd>
    <dd class="abstract"><span id="_share_abstract"></span></dd>
  </dl>
  <div class="share-content">
    <textarea name="commend_message" id="commend_message" placeholder="<?php echo $lang['reads_sns_share_title'];?>"></textarea>
  </div>
  <div class="handle">
    <input id="btn_share_publish" type="button" value="<?php echo $lang['reads_text_share'];?>" class="button" />
    <!-- 站外分享 -->
    <?php require('widget_share.php');?>
  </div>
</form>
</div>
<?php } else { ?>
<script type="text/javascript">
$(document).ready(function(){
    //登陆窗口
    $("#btn_sns_share").feiwa_login({
        nchash:'<?php echo getNchash();?>',
        formhash:'<?php echo Security::getTokenValue();?>',
        anchor:'reads_comment_flag'
    });
});
</script>
<?php } ?>

