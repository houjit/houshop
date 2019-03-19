<?php defined('INSYSVIEW') or exit('Access Invalid!');?>
	
	
	 <div class="wrap judge">
        <p class="part-tit"><span>用户口碑</span></p>
                    <div class="judge_lev">
                <div class="juge_info">
                    <div class="star">
                        <span></span>
                        <i style="width: <?php echo $output['store_info']['store_credit_percent'];?>%"></i>
                    </div>
                <span class="star_info"><b><?php echo $output['store_info']['store_credit_average'];?></b>分<i class="blue">来自<?php echo $output['store_info']['evaluate_goods_count'];?>人点评</i></span>
                </div>
            </div>
                        <div class="juge_exp">
        <?php  foreach ($output['store_info']['store_credit'] as $value) {?>      
                <span><?php echo $value['text'];?>：<i><?php echo $value['credit'];?></i>分</span>
                <?php } ?>
                <p>点评来自用户用户购买后对购买商品进行的真实有效评价!<i></i></p>
            </div>
	</div>
	
	
	<?php if(!empty($output['goodsevallist']) && is_array($output['goodsevallist'])){$i=0;?>
<div class="wrap com_list cleartable">
        <div class="cleartable boxItem7_l left">
   
       <?php foreach($output['goodsevallist'] as $k=>$v){$i++;?>     	
                       <?php if($i % 11 === 0) { ?>
            </div><div class="clearfix boxItem7_r right">
            <?php } ?>
                    <a class="boxItem7" target="_blank" href="<?php echo urlMall('goods','comments_list',array('goods_id'=> $v['geval_goodsid']));?>">
            <i class="point"></i>
            <div class="infoImg"><img src="<?php echo getMemberAvatarForID($v['geval_frommemberid']);?>" alt=""></div>
            <div class="info_cont">
                <p class="info_tit1">
                    <?php if($v['geval_isanonymous'] == 1){?><?php echo str_cut($v['geval_frommembername'],2).'***';?><?php }else{?><?php echo $v['geval_frommembername'];?> <?php }?>
                    	<em class="levbox">
                        <i></i>
                        <b style="width:<?php echo $v['credit_percent'];?>%"></b>
                    </em>
     
                    <i class="ft12">
                    <?php echo $v['geval_scores'];?>.0 </i>
                                    </p>
                <p class="info_tit2"><?php echo $v['geval_content'];?></p>
                <?php if(!empty($v['geval_image'])) {?>
                                <div class="img_cont">
        <?php $image_array = explode(',', $v['geval_image']);?>
        <?php foreach ($image_array as $value) { ?>
         <span> <img src="<?php echo snsThumb($value);?>" alt=""></span>
        <?php } ?> </div><?php } ?>
                                <p class="info_tit3"><?php echo @date('Y-m-d H:i:s',$v['geval_addtime']);?></p>
            </div>
        </a><?php } ?>  
</div> </div>
<div class="wrap mB40">
 <div class="pagination"> <?php echo $output['show_page'];?></div>
</div>
<?php }else{?>
<div class="feiwa-ss-norecord"><?php echo $lang['no_record'];?></div>
<?php }?>    
</div>