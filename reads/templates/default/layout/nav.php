<!-- 导航 -->
<div class="wrapper">
<div class="news-nav">
	<a href="<?php echo READS_SITE_URL;?>" <?php echo $output['index_sign'] == 'index'?'class="now"':''; ?>><span>资讯首页</span></a>
	          <?php if(!empty($output['article_class_list']) && is_array($output['article_class_list'])) {?>
          <?php foreach($output['article_class_list'] as $value) {?>
          <a href="<?php echo urlREADS('article','article_list',array('class_id'=>$value['class_id']));?>" 
          <?php echo $output['index_sign'] == $value['class_id']?'class="now"':''; ?>><span><?php echo $value['class_name'];?></span></a>
          <?php } ?>
          <?php } ?>

                                   </div></div>