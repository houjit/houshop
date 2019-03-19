<?php defined('INSYSVIEW') or exit('Access Invalid!');?>
<!--店铺街推荐排行-->
<?php $store_list_count = count($output['store_list']);?>

<div class="title-bar">
  <h3><?php echo $lang['feiwa_shareshow_store'];?></h3>
  <a href="<?php echo SHARESHOW_SITE_URL.DS;?>index.php?app=store" class="more" target="_blank"><?php echo $lang['feiwa_more'];?></a> </div>
<div class="contnet-box">
  <ol feiwa_type="index_store" class="shareshow-store-list">
      <?php $i = 1;?>
    <?php if(!empty($output['store_list']) && is_array($output['store_list'])) {?>
    <?php foreach($output['store_list'] as $key=>$value) {?>
    <li class="overall" style="display:none;"><i><?php echo $i;?></i>
      <dl class="store-intro">
        <dt><?php echo $value['store_name'];?></dt>
        <dd><?php echo $lang['shareshow_text_goods'];?><?php echo $lang['feiwa_colon'];?><em><?php echo $value['goods_count'];?></em><?php echo $lang['piece'];?></dd>
        <dd><a href="<?php echo SHARESHOW_SITE_URL.DS;?>index.php?app=store&feiwa=detail&store_id=<?php echo $value['shareshow_store_id'];?>" target="_blank"><?php echo $lang['micro_api_store_info'];?></a></dd>
      </dl>
    </li>
    <li class="simple"><i><?php echo $i++;?></i><a href=""><?php echo $value['store_name'];?></a></li>
    <?php } ?>
    <?php } ?>
  </ol>
</div>
