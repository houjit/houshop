<?php defined('INSYSVIEW') or exit('Access Invalid!');?>

<div class="page">
  <div class="fixed-bar">
    <div class="item-title">
      <div class="subject">
        <h3>夺宝分类</h3>
        <h5>夺宝分类的管理与编辑</h5>
      </div>
    </div>
  </div>
  <!-- 操作说明 -->
  <div class="explanation" id="explanation">
    <div class="title" id="checkZoom"><i class="fa fa-lightbulb-o"></i>
      <h4 title="<?php echo $lang['sys_prompts_title'];?>"><?php echo $lang['sys_prompts'];?></h4>
      <span id="explanationZoom" title="<?php echo $lang['sys_prompts_span'];?>"></span> </div>
    <ul>
      <li>夺宝分类用于一元夺宝的分类的操作</li>
      <li>分类只能为一级</li>
    </ul>
  </div>
  <form method='post'>
    <input type="hidden" name="form_submit" value="ok" />
    <table class="flex-table">
      <thead>
        <tr>
          <th width="24" align="center" class="sign"><i class="ico-check"></i></th>
          <th width="150" align="center" class="handle"><?php echo $lang['sys_handle'];?></th>
          <th width="150" align="center"><?php echo $lang['sys_sort'];?></th>
          <th width="300" align="left">分类名称</th>
          <th></th>
        </tr>
      </thead>
      <tbody>
        <?php if(!empty($output['class_list']) && is_array($output['class_list'])){ ?>
        <?php foreach($output['class_list'] as $k => $v){ ?>
        <tr class="edit">
          <td class="sign"><i class="ico-check"></i></td>
          <td class="handle">
          <a class="btn red" href="javascript:if(confirm('你确定要删除该分类吗？'))window.location = 'index.php?app=yydb_class&feiwa=yydb_class_del&sc_id=<?php echo $v['sc_id'];?>';"><i class="fa fa-trash-o"></i><?php echo $lang['sys_del'];?></a>
          <a class="btn blue" href="index.php?app=yydb_class&feiwa=yydb_class_edit&sc_id=<?php echo $v['sc_id'];?>"><i class="fa fa-pencil-square-o"></i><?php echo $lang['sys_edit'];?></a>
          </td>
          <td class="sort"><span feiwa_type="inline_edit" title="<?php echo $lang['can_edit'];?>" column_id="<?php echo $v['sc_id'];?>" fieldname="sc_sort" class="editable"><?php echo $v['sc_sort'];?></span></td>
          <td class="name"><span feiwa_type="inline_edit" title="<?php echo $lang['yydb_class_name'];?>" column_id="<?php echo $v['sc_id'];?>" fieldname="sc_name" class="node_name editable"><?php echo $v['sc_name'];?></span></td>
          <td><?php echo $v['sc_bail'];?></td>
          <td></td>
        </tr>
        <?php } ?>
        <?php }else { ?>
        <tr class="no-data">
          <td colspan="10"><?php echo $lang['sys_no_record'];?></td>
        </tr>
        <?php } ?>
      </tbody>
    </table>
  </form>
</div>
<script type="text/javascript" src="<?php echo ADMIN_RESOURCE_URL;?>/js/jquery.edit.js" charset="utf-8"></script> 
<script>
$(function(){
	$('.flex-table').flexigrid({
		height:'auto',// 高度自动
		usepager: false,// 不翻页
		striped:false,// 不使用斑马线
		resizable: false,// 不调节大小
		title: '夺宝分类列表',// 表格标题
		reload: false,// 不使用刷新
		columnControl: false,// 不使用列控制
        buttons : [ 
                   {display: '<i class="fa fa-plus"></i>新增数据', name : 'add', bclass : 'add', title : '新增数据', onpress : fg_operation }
               ]
		});

    // 修改分佣比例
    $('span[feiwa_type="inline_edit"]').inline_edit({app: 'yydb_class',op: 'ajax'});
});

function fg_operation(name, bDiv) {
    if (name == 'add') {
        window.location.href = 'index.php?app=yydb_class&feiwa=yydb_class_add';
    }
}
</script>