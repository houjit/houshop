<?php defined('INSYSVIEW') or exit('Access Invalid!');?>

<div class="page">
  <div class="fixed-bar">
    <div class="item-title">
      <div class="subject">
        <h3><?php echo $lang['webchat_set'];?></h3>
        <h5><?php echo $lang['webchat_set_subhead'];?></h5>
      </div>
      <?php echo $output['top_link'];?> </div>
  </div>
  <!-- 操作说明 -->
  <div class="explanation" id="explanation">
    <div class="title" id="checkZoom"><i class="fa fa-lightbulb-o"></i>
      <h4 title="<?php echo $lang['sys_prompts_title'];?>"><?php echo $lang['sys_prompts'];?></h4>
      <span id="explanationZoom" title="<?php echo $lang['sys_prompts_span'];?>"></span> </div>
    <ul>
      <li><?php echo $lang['webchat_set_subhead'];?></li>
    </ul>
  </div>
  <form method="post" enctype="multipart/form-data" name="form1">
    <input type="hidden" name="form_submit" value="ok" />
    <div class="ncap-form-default">
            <dl class="row">
        <dt class="tit">
          <label for="feiwa_webchat_appid"><?php echo $lang['webchat_appid'];?></label>
        </dt>
        <dd class="opt">
          <input id="feiwa_webchat_appid" name="feiwa_webchat_appid" value="<?php echo $output['list_setting']['feiwa_webchat_appid'];?>" class="input-txt" type="text" />
          <p class="notic"><?php echo $lang['sys_webchat_appid_notice'];?></p>
        </dd>
      </dl>
            <dl class="row">
        <dt class="tit">
          <label for="feiwa_webchat_appsecret"><?php echo $lang['webchat_appsecret'];?></label>
        </dt>
        <dd class="opt">
          <input id="feiwa_webchat_appsecret" name="feiwa_webchat_appsecret" value="<?php echo $output['list_setting']['feiwa_webchat_appsecret'];?>" class="input-txt" type="text" />
          <p class="notic"><?php echo $lang['sys_webchat_appsecret_notice'];?></p>
        </dd>
      </dl>
        
      <div class="bot"><a href="JavaScript:void(0);" class="ncap-btn-big ncap-btn-green" onclick="document.form1.submit()"><?php echo $lang['sys_submit'];?></a></div>
    </div>
  </form>
</div>