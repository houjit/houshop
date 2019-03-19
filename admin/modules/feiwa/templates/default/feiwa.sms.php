<?php defined('INSYSVIEW') or exit('Access Invalid!');?>

<div class="page">
  <div class="fixed-bar">
    <div class="item-title">
      <div class="subject">
        <h3><?php echo $lang['sms_set'];?></h3>
        <h5><?php echo $lang['sms_set_subhead'];?></h5>
      </div>
      <?php echo $output['top_link'];?> </div>
  </div>
  <!-- 操作说明 -->
  <div class="explanation" id="explanation">
    <div class="title" id="checkZoom"><i class="fa fa-lightbulb-o"></i>
      <h4 title="<?php echo $lang['sys_prompts_title'];?>"><?php echo $lang['sys_prompts'];?></h4>
      <span id="explanationZoom" title="<?php echo $lang['sys_prompts_span'];?>"></span> </div>
    <ul>
      <li>在这里可以设置提供的短信服务商完成设置。</li>
    </ul>
  </div>
  <form method="post" enctype="multipart/form-data" name="form1">
    <input type="hidden" name="form_submit" value="ok" />
    <div class="ncap-form-default">
     <dl class="row"  style="display: none;">
      <dt class="tit"><span><?php echo $lang['sys_sms_type'];?></span></dt>
        <dd class="opt">
          <ul class="ncap-account-container-list">
            <?php if($output['list_setting']['feiwa_sms_type']==4){ ?>
            <!-- liuxuexin start -->
            <li>
            <input type="radio" name="feiwa_sms_type" value="4" checked="checked" />
             <label for="feiwa_sms_type"><?php echo $lang['sys_sms_polang'];?></label>
            </li>
        <!-- liuxuexin start -->
          <?php }elseif($output['list_setting']['feiwa_sms_type']==2){ ?>
          <?php }elseif($output['list_setting']['feiwa_sms_type']==3){ ?>
          <?php }?>
          <!-- liuxuexin end -->        
          
            </ul>
        </dd>
      </dl>
        <dl class="row" style="display: none;">
        <dt class="tit">
          <label for="feiwa_sms_tgs"><?php echo $lang['sys_sms_tgs'];?></label>
        </dt>
        <dd class="opt">
          <input id="feiwa_sms_tgs" name="feiwa_sms_tgs" value="<?php echo $output['list_setting']['feiwa_sms_tgs'];?>" class="input-txt" type="text" />
          <p class="notic"><?php echo $lang['sys_sms_tgs_notice'];?></p>
        </dd>
      </dl>
            <dl class="row">
        <dt class="tit">
          <label for="feiwa_sms_zh"><?php echo $lang['sys_sms_zh'];?></label>
        </dt>
        <dd class="opt">
          <input id="feiwa_sms_zh" name="feiwa_sms_zh" value="<?php echo $output['list_setting']['feiwa_sms_zh'];?>" class="input-txt" type="text" />
          <p class="notic"><?php echo $lang['sys_sms_zh_notice'];?></p>
        </dd>
      </dl>
            <dl class="row">
        <dt class="tit">
          <label for="feiwa_sms_pw"><?php echo $lang['sys_sms_pw'];?></label>
        </dt>
        <dd class="opt">
          <input id="feiwa_sms_pw" name="feiwa_sms_pw" value="<?php echo $output['list_setting']['feiwa_sms_pw'];?>" class="input-txt" type="text" />
          <p class="notic"><?php echo $lang['sys_sms_pw_notice'];?></p>
        </dd>
      </dl>
            <dl class="row">
        <dt class="tit">
          <label for="feiwa_sms_key"><?php echo $lang['sys_sms_key'];?></label>
        </dt>
        <dd class="opt">
          <input id="feiwa_sms_key" name="feiwa_sms_key" value="<?php echo $output['list_setting']['feiwa_sms_key'];?>" class="input-txt" type="text" />
          <p class="notic"><?php echo $lang['sys_sms_key_notice'];?></p>
        </dd>
      </dl>
            </dl>

            </dl>
            <dl class="row">
        <dt class="tit">
          <label for="feiwa_sms_signature"><?php echo $lang['sys_sms_signature'];?></label>
        </dt>
        <dd class="opt">
          <input id="feiwa_sms_signature" name="feiwa_sms_signature" value="<?php echo $output['list_setting']['feiwa_sms_signature'];?>" class="input-txt" type="text" />
          <p class="notic"><?php echo $lang['sys_sms_signature_notice'];?></p>
        </dd>
      </dl>
      <dl class="row">
        <dt class="tit">
          <label for="feiwa_sms_bz"><?php echo $lang['sys_sms_bz'];?></label>
        </dt>
        <dd class="opt">
          <textarea name="feiwa_sms_bz" rows="6" class="tarea" id="feiwa_sms_bz"><?php echo $output['list_setting']['feiwa_sms_bz'];?></textarea>
          <p class="notic"><?php echo $lang['sys_sms_bz_notice'];?></p>
        </dd>
      </dl>
      <div class="bot"><a href="JavaScript:void(0);" class="ncap-btn-big ncap-btn-green" onclick="document.form1.submit()"><?php echo $lang['sys_submit'];?></a></div>
    </div>
  </form>
</div>