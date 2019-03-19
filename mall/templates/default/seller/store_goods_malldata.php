<?php defined('INSYSVIEW') or exit('Access Invalid!');?>

<style type="text/css">
<!--
.STYLE7 {color: #FF0000}
.STYLE8 {color: #009966}
.STYLE9 {color: #0000FF}
-->
</style>

<div class="tabmenu">
  <?php include template('layout/submenu'); ?>

</div>
<div class="page">
  <div class="tab-div" style="width: 1030px;">
    <div id="tabbody-div" style="background: #FFFDEA;" >
    <form enctype="multipart/form-data" action="index.php?app=taobao_caiji&feiwa=getAlmmmall" method="post" name="theForm" >
      <input type="hidden" name="MAX_FILE_SIZE" value="2097152" />
      <table width="90%" id="general-table" >
	  <tr><td height="20"></td></tr>
	  	  		<tr><td></td><td height="20"><input type="text" value="<?php echo $output['good_cat_id']; ?>" class="textinput" name="cat_id" size="80" height="55" style="display:none;" /> </td></tr>
        <tr id="webcode">
		  <th width="150"><div align="left"><span class="STYLE8">打开店铺的
		    ‘<span class="STYLE9">所有宝贝</span>’页面，把该页面所有内容复制到右边。</span></br>
		    <span class="STYLE7">注：不是复制链接，是复制整个页面内容。</span></div></th>
          <td>
		 <?php showEditor('g_body',$output['goods']['goods_body'],'100%','360px','visibility:hidden;',"false",$output['editor_multimedia']);?>
             
              <p id="des_demo"></p>
		    </td>
        </tr>

<tr><td height="20"></td></tr>
        <tr>
          <th><div align="right">采集数量：</div></th>
          <td><input type="text" value="10" class="textinput" name="conum" size="4">
          </td>
        </tr>
<tr><td height="20"></td></tr>
         <tr>
           <td><div align="center">放到店铺分类：</div></td>
           <td height="20"> <?php if (!empty($output['store_class_goods'])) { ?>
          <?php foreach ($output['store_class_goods'] as $v) { ?>
          <select name="sgcate_id[]" class="sgcategory">
            <option value="0"><?php echo $lang['feiwa_please_choose'];?></option>
            <?php foreach ($output['store_goods_class'] as $val) { ?>
            <option value="<?php echo $val['stc_id']; ?>" <?php if ($v==$val['stc_id']) { ?>selected="selected"<?php } ?>><?php echo $val['stc_name']; ?></option>
            <?php if (is_array($val['child']) && count($val['child'])>0){?>
            <?php foreach ($val['child'] as $child_val){?>
            <option value="<?php echo $child_val['stc_id']; ?>" <?php if ($v==$child_val['stc_id']) { ?>selected="selected"<?php } ?>>&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $child_val['stc_name']; ?></option>
            <?php }?>
            <?php }?>
            <?php } ?>
          </select>
          <?php } ?>
          <?php } else { ?>
          <select name="sgcate_id[]" class="sgcategory">
            <option value="0"><?php echo $lang['feiwa_please_choose'];?></option>
            <?php if (!empty($output['store_goods_class'])){?>
            <?php foreach ($output['store_goods_class'] as $val) { ?>
            <option value="<?php echo $val['stc_id']; ?>"><?php echo $val['stc_name']; ?></option>
            <?php if (is_array($val['child']) && count($val['child'])>0){?>
            <?php foreach ($val['child'] as $child_val){?>
            <option value="<?php echo $child_val['stc_id']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $child_val['stc_name']; ?></option>
            <?php }?>
            <?php }?>
            <?php } ?>
            <?php } ?>
          </select>
          <?php } ?></td></tr>
          <tr><td height="20"></td></tr>
     
        <tr class="app">
          <th>&nbsp;</th>
          <td>&nbsp;&nbsp;
            <input type="submit" class="submit_btn" value="开始采集" />
          </td>
        </tr>
		<tr><td height="20"></td></tr>	
      </table>
    </form>
    </div>
  </div>
</div>

