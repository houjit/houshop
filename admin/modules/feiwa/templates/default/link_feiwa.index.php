<?php defined('INSYSVIEW') or exit('Access Invalid!');?>
<div class="page">
  <div class="fixed-bar">
    <div class="item-title">
      <div class="subject">
        <h3>在线升级</h3>
        <h5>了解最新更新信息，快速获取</h5>
      </div>
    </div>
  </div>
  <div class="explanation" id="explanation">
    <div class="title" id="checkZoom"><i class="fa fa-lightbulb-o"></i>
      <h4 title="提示相关设置操作时应注意的要点">操作提示</h4>
      <span id="explanationZoom" title="收起提示"></span> </div>
    <ul>
      <li>通过此页面可以快速了解最近更新，以便于你更好的了解</li>
      <li>获得更新的时候你需要登入你的官方帐号</li>
    </ul>
  </div>
    <table class="flex-table">
      <thead>
        <tr>
         <th width="24" align="center" class="sign"><i class="ico-check"></i></th>
          <th width="150" align="center">查看</th>
          <th width="400">更新名称</th>
          <th width="200" align="center">发布作者</th>
          <th width="200" align="center">发布日期</th>
          <th></th>
        </tr>
      </thead>
      <tbody>
        <script type="text/javascript" src="#/api.php?mod=js&bid=3"></script>
      </tbody>
    </table>
</div>
<script type="text/javascript" src="<?php echo ADMIN_RESOURCE_URL;?>/js/jquery.edit.js" charset="utf-8"></script>
<script type="text/javascript">
$(document).ready(function(){
	$('.flex-table').flexigrid({
		height:'auto',// 高度自动
		usepager: false,// 不翻页
		striped:false,// 不使用斑马线
		resizable: false,// 不调节大小
		title: '更新列表',// 表格标题
		reload: false,// 不使用刷新
		columnControl: false,// 不使用列控制
	});
    //行内ajax编辑
    $('span[feiwa_type="tag_sort"]').inline_edit({app: 'navigation',op: 'ajax'});
    $('span[feiwa_type="tag_name"]').inline_edit({app: 'navigation',op: 'ajax'});
});
</script>