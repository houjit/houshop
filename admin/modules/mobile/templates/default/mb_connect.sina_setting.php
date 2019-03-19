<?php defined('INSYSVIEW') or exit('Access Invalid!');?>

<div class="page">
  <div class="fixed-bar">
    <div class="item-title">
      <div class="subject">
        <h3>第三方账号登录</h3>
        <h5>设置使用第三方账号在手机客户端中登录</h5>
      </div>
      <?php echo $output['top_link'];?> </div>
  </div>
  <div class="explanation" id="explanation">
    <div class="title" id="checkZoom"><i class="fa fa-lightbulb-o"></i>
      <h4 title="提示相关设置操作时应注意的要点">操作提示</h4>
      <span id="explanationZoom" title="收起提示"></span> </div>
    <ul>
      <li>启用前需在微博平台注册开发者帐号，并获得相应的AppID和AppSecret。</li>
    </ul>
  </div>
  <?php if ($output['is_exist']){?>
  <form method="post" name="settingForm">
    <input type="hidden" name="form_submit" value="ok" />
    <div class="ncap-form-default">
      <dl class="row">
        <dt class="tit"><?php echo $lang['sina_isuse'];?></dt>
        <dd class="opt">
          <div class="onoff">
            <label for="app_sina_isuse_1" class="cb-enable <?php if($output['list_setting']['app_sina_isuse'] == '1'){ ?>selected<?php } ?>" title="<?php echo $lang['sina_isuse_open'];?>"><span><?php echo $lang['sina_isuse_open'];?></span></label>
            <label for="app_sina_isuse_0" class="cb-disable <?php if($output['list_setting']['app_sina_isuse'] == '0'){ ?>selected<?php } ?>" title="<?php echo $lang['sina_isuse_close'];?>"><span><?php echo $lang['sina_isuse_close'];?></span></label>
            <input type="radio" id="app_sina_isuse_1" name="app_sina_isuse" value="1" <?php echo $output['list_setting']['app_sina_isuse']==1?'checked=checked':''; ?>>
            <input type="radio" id="app_sina_isuse_0" name="app_sina_isuse" value="0" <?php echo $output['list_setting']['app_sina_isuse']==0?'checked=checked':''; ?>>
          </div>
          <p class="notic">开启后可使用新浪微博登录。</p>
        </dd>
      </dl>
      <dl class="row">
        <dt class="tit">
          <label for="app_sina_akey"><em>*</em><?php echo $lang['sina_wb_akey'];?></label>
        </dt>
        <dd class="opt">
          <input id="app_sina_akey" name="app_sina_akey" value="<?php echo $output['list_setting']['app_sina_akey'];?>" class="input-txt" type="text">
          <p class="notic"><a class="ncap-btn" target="_blank" href="http://open.weibo.com/developers"><?php echo $lang['sina_apply_link']; ?></a></p>
        </dd>
      </dl>
      <dl class="row">
        <dt class="tit">
          <label for="app_sina_skey"><em>*</em><?php echo $lang['sina_wb_skey'];?></label>
        </dt>
        <dd class="opt">
          <input id="app_sina_skey" name="app_sina_skey" value="<?php echo $output['list_setting']['app_sina_skey'];?>" class="input-txt" type="text">
          <p class="notic">&nbsp;</p>
        </dd>
      </dl>
      <div class="bot"><a href="JavaScript:void(0);" class="ncap-btn-big ncap-btn-green" onclick="document.settingForm.submit()"><?php echo $lang['sys_submit'];?></a></div>
    </div>
  </form>
  <?php }else{ ?>
  <?php echo $lang['sina_function_fail_tip']; ?>
  <?php }?>
</div>
