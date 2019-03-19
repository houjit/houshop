<?php defined('INSYSVIEW') or exit('Access Invalid!');?>

<div class="wrap">
  <div class="tabmenu">
    <?php include template('layout/submenu');?>
    <a class="ncbtn ncbtn-bittersweet" href="<?php echo urlMall('member_feedback', 'add');?>"><i class="icon-comments-alt"></i>增加反馈</a></div>
  <table class="ncm-default-table">
    <thead>
      <tr>
        <th class="w10"></th>
        <th class="w150">标题</th>
        <th class="tl">内容</th>
        <th class="w150">咨询时间</th>
        <!--<th class="w150">状态</th>-->
        <th class="w110">操作</th>
      </tr>
    </thead>
    <tbody>
      <?php  if (!empty($output['consult_list'])) { ?>
      <?php foreach($output['consult_list'] as $val) { ?>
      <tr class="bd-line">
        <td></td>
        <td class=""><?php echo $val['title'];?></td>
        <td class="tl"><?php echo $val['content'];?></td>
        <td><?php echo date('Y-m-d H:i:s', $val['ftime']);?></td>
        <!--<td class=""><?php echo $output['state'][$val['is_reply']];?>ddd</td>-->
        <td class="ncm-table-handle">
          <span><a href="<?php echo urlMall('member_feedback', 'info', array('id' => $val['id']));?>" class="btn-bluejeans"><i class="icon-eye-open"></i><p>查看</p></a></span>
          <span><a href="javascript:void(0);" onclick="ajax_get_confirm('<?php echo $lang['feiwa_common_op_confirm'];?>', '<?php echo urlMall('member_feedback', 'del', array('id' => $val['id']));?>');" class="btn-bluejeans"><i class="icon-trash"></i><p>删除</p></a></span>
        </td>
      </tr>
      <?php } ?>
      <?php } else {?>
      <tr>
        <td colspan="20" class="norecord"><div class="warning-option"><i>&nbsp;</i><span><?php echo $lang['no_record'];?></span></div></td>
      </tr>
      <?php } ?>
    </tbody>
    <tfoot>
      <?php  if (!empty($output['consult_list'])) { ?>
      <tr>
        <td colspan="20"><div class="pagination"> <?php echo $output['show_page']; ?></div></td>
      </tr>
      <?php } ?>
    </tfoot>
  </table>
</div>
