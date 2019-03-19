<?php defined('INSYSVIEW') or exit('Access Invalid!');?>
<link href="<?php echo MALL_TEMPLATES_URL;?>/css/feiwa-pmtion.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<?php echo MALL_RESOURCE_SITE_URL;?>/js/home_index.js" charset="utf-8"></script>
<div class="s5-prom-wp" >
	<div class="new-wraper" style="background-image: url(<?php if(!empty($output['loginpic']) && is_array($output['loginpic'])){$i=0?><?php foreach($output['loginpic'] as $val){$i++?><?php if($i==1){?><?php echo UPLOAD_SITE_URL.'/'.ATTACH_LOGIN.'/'.$val['pic'];?><?php }}}?>); background-position: 50% 0; background-repeat: no-repeat;">
		<div class="wrapper">
			<div class="clearfix">
				<div class="new-user-defined">
		<ul>
		<?php if(!empty($output['loginpic']) && is_array($output['loginpic'])){$i=0?>
        <?php foreach($output['loginpic'] as $val){$i++?>
        	<?php if($i==1){?>
        		<a style="height: 510px; display: block;" href="<?php if($val['url'] != ''){echo $val['url'];}else{echo 'javascript:void(0);';}?>"></a><?php }else{?> <li class="p<?php echo $i;?>"><a href="<?php if($val['url'] != ''){echo $val['url'];}else{echo 'javascript:void(0);';}?>" target="_blank"><img src="<?php echo UPLOAD_SITE_URL.'/'.ATTACH_LOGIN.'/'.$val['pic'];?>"></a></li>
        <?php }}?>
        <?php }?></ul>
				</div>
				
				<!--今日最新开始 -->
				<div class="feiwa-left">
				<div class="_new_today_new_new_today_new">
	            <div class="ml-tit">
					<img alt="" src="<?php echo MALL_SITE_URL;?>/img/5715cec7N4f8e8f43.png">
	            </div>
				 
<?php if(!empty($output['list']) && is_array($output['list'])) { ?>
	<?php foreach($output['list'] as $val) { ?>	
 <div class="ml-item" style="border-color: rgb(221, 221, 221);">
<div class="mli-img"><a href="<?php echo urlMall('promotion','index',array('id'=>$val['xianshi_id']));?>" target="_blank">
<img width="480" height="190" src="<?php echo xsthumb($val['xianshi_image1']);?>" >
    				                   </a>								
										<div class="countdown-tag">
                                        <span class="tick-logo"></span>
                                        <p class="infoTit1 time-remain" count_down="<?php echo $val['end_time']-TIMESTAMP;?>"><i></i><em time_id="d">0</em>天<em time_id="h">0</em>时<em time_id="m">0</em>分<em time_id="s">0</em>秒</p>
                                        <span class="arrow-circle"></span>
										</div>
<!--<div class="act-msg">  <div class="act-mg-bg"></div> <p class="txt">满199元,减100元</p></div>-->  </div>
 <div class="mli-info">  <div class="brand-logo">
<a href="<?php echo urlMall('promotion','index',array('id'=>$val['xianshi_id']));?>" target="_blank">
  <img width="150" height="35"  src="<?php echo xsthumb($val['xianshi_image2']);?>">
    				                        </a>
    				                    </div>
    									<div class="mli-short-line"></div>
    				                    <div class="brand-active">
<a href="<?php echo urlMall('promotion','index',array('id'=>$val['xianshi_id']));?>" target="_blank"><?php echo $val['xianshi_explain']; ?></a>
<span> 低至<?php echo $val['xianshi_discount']; ?>折</span> </div> 
<div class="brand-rebate"><a href="<?php echo urlMall('promotion','index',array('id'=>$val['xianshi_id']));?>" target="_blank">立即选购</a></div> </div> </div>
 <?php } ?> 
 	      <div class="tc mt20 mb20">
        <div class="pagination"> <?php echo $output['show_page']; ?> </div>
      </div><?php } ?>
	        </div>
	        <div class="s5-menu">
	        	<ul><input type="hidden" id="sc_id" value="<?php echo intval($_GET['sc_id'])>0?intval($_GET['sc_id']):'';?>"/> <li><a class="<?php echo intval($_GET['class_id']) <= 0?'selected':'';?>" href="<?php echo urlMall('promotion','list');?>">所有分类</a></li><?php foreach ($output['goods_class'] as $k=>$v){?><li><a class="<?php echo intval($_GET['class_id']) == $v['class_id']?'selected':'';?>" href="<?php echo urlMall('promotion','list',array('class_id'=>$v['class_id']));?>"}'><?php echo $v['class_name'];?></a></li> <?php } ?></ul>
	        	
	        </div>
	        </div>
	        
	        
	        
	        
	        <div class="feiwa-right">
	            <div class="sidebar">
					<!-- 自定义模块【预告栏上方广告】开始 -->
					                    <!-- 自定义模块【预告栏上方广告】 结束 -->
					
	            	<!--右侧排行榜  开始-->
					<div class="tabs hoversTab">																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																										                      
<ul class="tab-mt tabCont">																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																										                    		
                            <li class="fore1 now"><span>推荐TOP10</span><b></b></li>
                            <li class="fore2"><span>品牌推荐</span><b></b></li>	                    </ul>
	
	<div class="tab-mc hoverCont  " style="display: block;">								
							<ul class="tm-list pb3" id="rankUl">
		<?php if(!empty($output['goods_list']) && is_array($output['goods_list'])) { $i=0?>																														    								    					<?php foreach($output['goods_list'] as $goods_info) {$i++ ?>
																																    								    						<li class="fore single ">
    								<a target="_blank" href="<?php echo $goods_info['goods_url'];?>">
    									    									<span class="num num<?php echo $i;?>"></span>
    									    										<img class="prd-img" src="<?php echo $goods_info['image_url_240'];?>">
    									    	                                <div class="tl-detail">
    	                                    <h2><?php echo $goods_info['xianshi_title'];?></h2>    										<p class="tl-des" title="<?php echo $goods_info['goods_name'];?>"><?php echo $goods_info['goods_name'];?></p>    	                                    <p class="tl-yen"><?php echo ncPriceFormatForList($goods_info['xianshi_price']);?></p>
    	                                    <p class="tl-pnum">已售件数：<?php echo $goods_info['goods_salenum'];?></p>
    	                                </div>
    								</a></li><?php } } ?></ul>
						</div>
																		<div class="tab-mc hoverCont   hide " style="display: none;">								
							<ul class="tm-list">
								<?php if(!empty($output['list_rec']) && is_array($output['list'])) { ?>
	<?php foreach($output['list_rec'] as $val) { ?>
								<li class="brand " "=""><a  href="<?php echo urlMall('promotion','index',array('id'=>$val['xianshi_id']));?>" target="_blank">
									<div class="brand-detail">
										<div class="brand-detail-inner">
											<span class="brand-num brand-num1"></span>
																							<img src="<?php echo xsthumb($val['xianshi_image2']);?>"><span class="brand-name" title="<?php echo $val['xianshi_explain']; ?>"><?php echo $val['xianshi_explain']; ?></span>
				                     	</div>
									</div>
				                    <img class="tl-brand-img" src="<?php echo xsthumb($val['xianshi_image1']);?>">
								</a>
				                </li>
								<?php } } ?>		
																																																																																																																																																																																																																																																																																															</ul>
						</div>
						                    </div>
					<!--右侧排行榜 结束-->
	                
	                <!-- ------------自定义模块------------ 开始 -->
	                		                <!-- 自定义模块【模块一】开始 第三次 -->
							                	<div class="custom" style="display:none">
		                    <div class="c-tit">
		                        <i class="ct-line"></i>
		                        <h3>---</h3>
		                    </div>
		                    <div class="c-con">
								<div class="btns btn_prev" id="prev" style="display: none;"></div>
								<div class="btns btn_next" id="next"></div>
		                        <div class="img-box">
		                            <ul style="width: 825px;">
		                                <li>
		                                    <a target="_blank" href="#"><img src="//img11.360buyimg.com/red/jfs/t331/354/211290830/67643/ab429684/5405633eN1c75404a.jpg" width="275" height="275" alt=""></a>
		                                </li>
		                                <li>
		                                    <a target="_blank" href="#"><img src="" width="275" height="275" alt=""></a>
		                                </li>
		                                <li>
		                                    <a target="_blank" href="#"><img src="" width="275" height="275" alt=""></a>
		                                </li>
		                            </ul>
		                        </div>
		                    </div>
		                </div>
								                <!-- 自定义模块【模块一】 结束 -->
		                
		                <!-- 自定义模块【模块二】开始 -->
		                		                <!-- 自定义模块【模块二】结束 -->
	                	                <!-- ------------自定义模块------------ 结束 -->
	            </div>
	        </div>
				
				
				
				
				
				
			</div>
		</div>
	</div>
	
</div>

