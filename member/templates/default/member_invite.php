<?php defined('INSYSVIEW') or exit('Access Invalid!');?>
<style type="text/css">
/*绑定工具提示*/
.bindtooltip { background-color: #FFF; overflow: hidden;}
.bindtooltip dl {  font-size: 0; *word-spacing: -1px/*IE6、7*/;}
.bindtooltip dl dt { font-size: 12px; vertical-align: top; letter-spacing: normal; word-spacing: normal; text-align: right; display: inline-block; *display: inline/*IE*/; width: 23%; padding: 10px 0; margin: 0; *zoom: 1;}
.bindtooltip dl dt img { width: 40px; height: 40px; margin: 5px 0 0;}
.bindtooltip .hint { color: #F33;}
.bindtooltip dl dd { font-size: 12px; vertical-align: top; letter-spacing: normal; word-spacing: normal; display: inline-block; *display: inline/*IE*/; width: 74%; padding: 10px 0 10px 3% ; *zoom: 1;}
.bindtooltip .bottom { background-color: #F9F9F9; text-align: center; padding: 12px 0; border-top: 1px solid #EAEAEA; }
a.mini-btn { font: normal 12px/20px arial; color: #FFF;  background-color: #5BB75B; text-align: center; vertical-align: middle; display: inline-block; *display: inline/*IE*/; height: 20px; padding: 0 10px; margin-right: 8px; border-style: solid; border-width: 1px; border-color: #52A452 #52A452 #448944 #52A452; *zoom: 1; cursor: pointer;}
a:hover.mini-btn { text-decoration: none; color: #FFF; background-color: #51A351; border-color: #499249 #499249 #3D7A3D #499249;}
.bindtooltip .bottom span a { color: #0077BB; text-decoration: underline; margin-left: 8px;}
.operate input{height: 30px;font-size: 14px;width:320px;}
</style>
<div class="wrap">
  <div class="tabmenu">
    <?php include template('layout/submenu');?>
  </div>
  <div class="alert alert-block">
    <h4>提示：</h4>
    <ul>
      <li><?php echo $lang['sharebind_list_tip1'];?></li>
      <li>成功邀请一个好友，可获<em><?php echo $output['points'];?></em>积分奖励；</li>
    </ul>
  </div>
  <ul class="bind-account-list">
      <li style="width:100%">
      <div class="account-item">
        <dl>
            <dd><em>邀请链接：</em> 复制下面的链接，通过QQ，旺旺，微博，论坛发帖等方式发给好友，对方通过该链接注册即可~</dd>
          <dd class="operate">
              <input type="text" readonly value="<?php echo $output['member_id'];?>" class="std-input i-invite-link">
          </dd>
        </dl>
      </div>
    </li>
  </ul>
</div>
<script>
$(function(){
    $(".i-invite-link").click(function(){
		$(this).select();
	});
})
</script>