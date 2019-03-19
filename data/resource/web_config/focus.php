<?php defined('INSYSVIEW') or exit('Access Invalid!');?>
    <ul class="bannerImg inner">
    	 <?php if (is_array($output['code_screen_list']['code_info']) && !empty($output['code_screen_list']['code_info'])) {$i=0; ?>
          <?php foreach ($output['code_screen_list']['code_info'] as $key => $val) {$i++; ?>
          <?php if (is_array($val) && $val['ap_id'] > 0) { ?>
          <li ap_id="<?php echo $val['ap_id'];?>" color="<?php echo $val['color'];?>" style="<?php echo $i==1 ? 'display: block':'display: none'?>; background: <?php echo $val['color'];?>;" class="">
            <a href="<?php echo $val['pic_url'];?>" target="_blank"><img alt="" feiwa-url="<?php echo UPLOAD_SITE_URL.'/'.$val['pic_img'];?>" style="display:block" rel='lazy' src="<?php echo MALL_SITE_URL;?>/img/loading.gif" title="<?php echo $val['pic_name'];?>"></a>
        </li>	
          <?php }else { ?>
          <li style="<?php echo $i==1 ? 'display: block':'display: none'?>;; background: <?php echo $val['color'];?>;" class="">
            <a href="<?php echo $val['pic_url'];?>" target="_blank"><img alt="" feiwa-url="<?php echo UPLOAD_SITE_URL.'/'.$val['pic_img'];?>" style="display:block" rel='lazy' src="<?php echo MALL_SITE_URL;?>/img/loading.gif" title="<?php echo $val['pic_name'];?>"></a>
            <?php if($val['pic_simg']!=null){?>
            <a href="<?php echo $val['pic_surl'];?>" class="r-img r-img0" target="_blank"><img alt="" feiwa-url="<?php echo $val['pic_simg'];?>" style="display:block" rel='lazy' src="<?php echo MALL_SITE_URL;?>/img/loading.gif" title="<?php echo $val['pic_name'];?>"></a><?php } ?>
            	 <?php if($val['pic_wimg']!=null){?>
            <a href="<?php echo $val['pic_wurl'];?>" class="r-img r-img1" target="_blank"><img alt="" feiwa-url="<?php echo $val['pic_wimg'];?>" style="display:block" rel='lazy' src="<?php echo MALL_SITE_URL;?>/img/loading.gif" title="<?php echo $val['pic_name'];?>"></a><?php } ?>
        </li><?php } ?>
          <?php } ?>
          <?php } ?>
 
            </ul>
    <div class="tabIcon">
    	 <?php if (is_array($output['code_screen_list']['code_info']) && !empty($output['code_screen_list']['code_info'])) {$i=0; ?>
          <?php foreach ($output['code_screen_list']['code_info'] as $key => $val) {$i++; ?>
                <span class="<?php echo $i==1 ? 'now':''?>"></span>
          <?php } ?>
          <?php } ?>
            </div>
    <span class="feiwa-prev" style="display: none;"></span>
    <span class="feiwa-next" style="display: none;"></span>
    
  </ul>
  <div class="jfocus-trigeminy">
    <ul>
          <?php if (is_array($output['code_focus_list']['code_info']) && !empty($output['code_focus_list']['code_info'])) { ?>
          <?php foreach ($output['code_focus_list']['code_info'] as $key => $val) { ?>
          <li>
              <?php if (is_array($val['pic_list']) && $val['pic_list'][1]['ap_id'] > 0) { ?>
              <?php foreach($val['pic_list'] as $k => $v) { ?>
            <a ap_id="<?php echo $v['ap_id'];?>" href="<?php echo $v['pic_url'];?>" target="_blank" title="<?php echo $v['pic_name'];?>">
                <img src="<?php echo UPLOAD_SITE_URL.'/'.$v['pic_img'];?>" alt="<?php echo $v['pic_name'];?>"></a>
              <?php } ?>
              <?php }else { ?>
              <?php foreach($val['pic_list'] as $k => $v) { ?>
            <a href="<?php echo $v['pic_url'];?>" target="_blank" title="<?php echo $v['pic_name'];?>">
                <img src="<?php echo UPLOAD_SITE_URL.'/'.$v['pic_img'];?>" alt="<?php echo $v['pic_name'];?>"></a>
              <?php } ?>
              <?php } ?>
          </li>
          <?php } ?>
          <?php } ?>
    </ul>
  </div>
<script type="text/javascript">
	update_screen_focus();
</script>