<?php defined('INSYSVIEW') or exit('Access Invalid!');?>

<div class="page">
  <div class="fixed-bar">
    <div class="item-title">
      <div class="subject">
        <h3><?php echo $lang['sys_set'];?></h3>
        <h5><?php echo $lang['sys_set_subhead'];?></h5>
      </div>
      <?php echo $output['top_link'];?> </div>
  </div>
  <!-- 操作说明 -->
  <div class="explanation" id="explanation">
    <div class="title" id="checkZoom"><i class="fa fa-lightbulb-o"></i>
      <h4 title="<?php echo $lang['sys_prompts_title'];?>"><?php echo $lang['sys_prompts'];?></h4>
      <span id="explanationZoom" title="<?php echo $lang['sys_prompts_span'];?>"></span> </div>
    <ul>
      <li>在这里可以设置开发的一些基本功能。</li>
    </ul>
  </div>
  <form method="post" enctype="multipart/form-data" name="form1">
    <input type="hidden" name="form_submit" value="ok" />
    <div class="ncap-form-default">
      <dl class="row">
        <dt class="tit">
          <label for="feiwa_stitle"><?php echo $lang['sys_stitle'];?></label>
        </dt>
        <dd class="opt">
          <input id="feiwa_stitle" name="feiwa_stitle" value="<?php echo $output['list_setting']['feiwa_stitle'];?>" class="input-txt" type="text" />
          <p class="notic"><?php echo $lang['sys_stitle_notice'];?></p>
        </dd>
      </dl>
      <dl class="row">
        <dt class="tit">
          <label for="feiwa_phone"><?php echo $lang['sys_phone'];?></label>
        </dt>
        <dd class="opt">
          <input id="feiwa_phone" name="feiwa_phone" value="<?php echo $output['list_setting']['feiwa_phone'];?>" class="input-txt" type="text" />
          <p class="notic"><?php echo $lang['sys_phone_notice'];?></p>
        </dd>
      </dl>
            <dl class="row">
        <dt class="tit">
          <label for="feiwa_time"><?php echo $lang['sys_time'];?></label>
        </dt>
        <dd class="opt">
          <input id="feiwa_time" name="feiwa_time" value="<?php echo $output['list_setting']['feiwa_time'];?>" class="input-txt" type="text" />
          <p class="notic"><?php echo $lang['sys_time_notice'];?></p>
        </dd>
      </dl>
      <dl class="row">
        <dt class="tit">
          <label for="feiwa_default_city">默认城市</label>
        </dt>
        <dd class="opt">
          <input id="feiwa_default_city" name="feiwa_default_city" value="<?php echo $output['list_setting']['feiwa_default_city'];?>" class="input-txt" type="text" />
          <p class="notic">请填写全站默认城市</p>
        </dd>
      </dl>
       <dl class="row">
        <dt class="tit">
          <label for="feiwa_index_brand">首页推荐品牌</label>
        </dt>
        <dd class="opt">
          <input id="feiwa_index_brand" name="feiwa_index_brand" value="<?php echo $output['list_setting']['feiwa_index_brand'];?>" class="input-txt" type="text" />
          <p class="notic">请填写品牌ID以（,）号分隔</p>
        </dd>
      </dl>
       <dl class="row">
        <dt class="tit">
          <label for="feiwa_index_store">首页推荐店铺</label>
        </dt>
        <dd class="opt">
          <input id="feiwa_index_store" name="feiwa_index_store" value="<?php echo $output['list_setting']['feiwa_index_store'];?>" class="input-txt" type="text" />
          <p class="notic">请填写店铺ID以（,）号分隔</p>
        </dd>
      </dl>
             <dl class="row">
        <dt class="tit">
          <label for="feiwa_index_goods">首页推荐商品</label>
        </dt>
        <dd class="opt">
          <input id="feiwa_index_goods" name="feiwa_index_goods" value="<?php echo $output['list_setting']['feiwa_index_goods'];?>" class="input-txt" type="text" />
          <p class="notic">请填写商品ID以（,）号分隔，上限5个</p>
        </dd>
      </dl>
       <dl class="row">
        <dt class="tit">
          <label for="feiwa_invite2">二级佣金比</label>
        </dt>
        <dd class="opt">
          <input id="feiwa_invite2" name="feiwa_invite2" value="<?php echo $output['list_setting']['feiwa_invite2'];?>" class="w60" type="text" /><i>%</i>
          <p class="notic">二级佣金=1级佣金*二级佣金比</p>
        </dd>
      </dl>
             <dl class="row">
        <dt class="tit">
          <label for="feiwa_invite3">三级佣金比</label>
        </dt>
        <dd class="opt">
          <input id="feiwa_invite3" name="feiwa_invite3" value="<?php echo $output['list_setting']['feiwa_invite3'];?>" class="w60" type="text" /><i>%</i>
          <p class="notic">三级佣金=1级佣金*三级佣金比</p>
        </dd>
      </dl>
       
      <div class="bot"><a href="JavaScript:void(0);" class="ncap-btn-big ncap-btn-green" onclick="document.form1.submit()"><?php echo $lang['sys_submit'];?></a></div>
    </div>
  </form>
</div>