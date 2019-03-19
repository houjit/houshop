<?php defined('INSYSVIEW') or exit('Access Invalid!');?>

<div class="page">
  <div class="fixed-bar">
    <div class="item-title">
      <div class="subject">
        <h3><?php echo $lang['sys_reads_special_manage'];?></h3>
        <h5><?php echo $lang['sys_reads_special_manage_subhead'];?></h5>
      </div>
    </div>
  </div>
  <!-- 操作说明 -->
  <div class="explanation" id="explanation">
    <div class="title" id="checkZoom"><i class="fa fa-lightbulb-o"></i>
      <h4 title="<?php echo $lang['sys_prompts_title'];?>"><?php echo $lang['sys_prompts'];?></h4>
      <span id="explanationZoom" title="<?php echo $lang['sys_prompts_span'];?>"></span> </div>
    <ul>
      <li><?php echo $lang['reads_special_list_tip1'];?></li>
      <li>专题类型分为资讯和商城，资讯专题将出现在资讯频道内，商城专题出现在商城使用商城统一风格</li>
    </ul>
  </div>
  <form id="list_form" method='post'>
    <input id="special_id" name="special_id" type="hidden" />
    <table class="flex-table">
      <thead>
        <tr>
          <th width="24" align="center" class="sign"><i class="ico-check"></i></th>
          <th width="150" align="center" class="handle"><?php echo $lang['sys_handle'];?></th>
          <th width="300"><?php echo $lang['reads_text_title'];?></th>
          <th width="100" align="center">类型</th>
          <th width="100" align="center">专题封面图</th>
          <th width="100" align="center"><?php echo $lang['reads_text_state'];?></th>
          <th></th>
        </tr>
      </thead>
      <tbody>
        <?php if(!empty($output['list']) && is_array($output['list'])){ ?>
        <?php foreach($output['list'] as $val){ ?>
        <tr>
          <td class="sign"><i class="ico-check"></i></td>
          <td class="handle"><a href="index.php?app=reads_special&feiwa=reads_special_drop&special_id=<?php echo $val['special_id'];?>" class="btn red confirm-del"><i class="fa fa-trash-o"></i><?php echo $lang['sys_del'];?></a> <span class="btn"><em><i class="fa fa-cog"></i><?php echo $lang['sys_set'];?><i class="arrow"></i></em>
            <ul>
              <li>
                <?php if($val['special_state'] == '2') { ?>
                <a href="<?php echo $val['special_link'];?>" target="_blank">查看专题页面</a>
                <?php } else { ?>
                <a href="index.php?app=reads_special&feiwa=reads_special_detail&special_id=<?php echo $val['special_id'];?>" target="_blank">预览专题页面</a>
                <?php } ?>
              </li>
              <li><a href="index.php?app=reads_special&feiwa=reads_special_edit&special_id=<?php echo $val['special_id'];?>">编辑专题内容</a></li>
            </ul>
            </span></td>
          <td class="name"><?php echo $val['special_title'];?></td>
          <td class="name"><?php echo $val['special_type_text'];?></td>
          <td>
            <a href="javascript:;" class="pic-thumb-tip" onmouseout="toolTip()" onmouseover="toolTip('<img src=\'<?php echo $val['special_image'] ? getREADSSpecialImageUrl($val['special_image']) : ADMIN_TEMPLATES_URL . '/images/preview.png'; ?>\'>')">
              <i class='fa fa-picture-o'></i>
            </a>
          </td>
          <td class="name"><?php echo $output['special_state_list'][$val['special_state']];?></td>
          <td></td>
        </tr>
        <?php } ?>
        <?php }else { ?>
        <tr>
          <td class="no-data" colspan="100"><i class="fa fa-exclamation-triangle"></i><?php echo $lang['sys_no_record'];?></td>
        </tr>
        <?php } ?>
      </tbody>
    </table>
  </form>
</div>
<script>
$(function(){
	$('.flex-table').flexigrid({
		height:'auto',// 高度自动
		usepager: false,// 不翻页
		striped:false,// 不使用斑马线
		resizable: false,// 不调节大小
		title: '专题列表',// 表格标题
		reload: false,// 不使用刷新
		columnControl: false,// 不使用列控制
        buttons : [
                   {display: '<i class="fa fa-plus"></i>新增专题', name : 'add', bclass : 'add', title : '新增专题', onpress : fg_operation }
               ]
		});

    $('a.confirm-del').live('click', function() {
        if (!confirm('确定删除？')) {
            return false;
        }
    });

});
function fg_operation(name, bDiv) {
    if (name == 'add') {
        window.location.href = 'index.php?app=reads_special&feiwa=reads_special_add';
    }
}
</script>