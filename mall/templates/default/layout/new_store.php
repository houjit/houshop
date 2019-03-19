<?php defined('INSYSVIEW') or exit('Access Invalid!');?>
	
<style>.feiwa_store_head { background: url("	<?php if(!empty($output['store_info']['store_banner'])){?> <?php echo getStoreLogo($output['store_info']['store_banner'],'store_logo');?> <?php }else{?><?php echo getStoreLogo('default_top.jpg');?> <?php }?>") no-repeat center 0;</style>

<div class="feiwa_store_head">
        <div class="wrap pos_rel">
            <div class="doc-info">
                <div class="doc-img left">
                    <img src="<?php echo getStoreLogo( $output['store_info']['store_avatar']);?>" alt="">
                </div>
                <div class="doc-infoTxt left">
                    <span class="doc-name"><?php echo $output['store_info']['store_name'];?>                   	                   	 	<i class="theV">认证</i>
					<?php if($output['store_info']['is_distribution']==1){?>
                    <i style='background:#f00;padding:2px;font-size:14px;color:#fff;font-weight:700;'>分销商认证</i>
                    <?php } ?>
                   	 	                    </span>
                    <p class="hos_file hos_lev">
                        <span>资质：</span> <?php if ($output['store_info']['is_own_mall']) { ?>本站自营<?php }else{?>第三方<?php }?></p>
                                        <p class="hos_file"><span>电话：</span><?php echo $output['store_info']['store_phone'];?></p>
                                                            <p class="hos_file"><span>地址：</span><b id="HosName"><?php echo $output['store_info']['area_info'];?></b><i class="check-adr">查看</i></p>
                    <input type="hidden" id="lon" value="0">
                    <input type="hidden" id="lat" value="0">
                                    </div>
            </div>
            <div class="edit_btn">
<a href="javascript:collect_store('<?php echo $output['store_info']['store_id'];?>','count','store_collect')" class="collect_doc collect" >收藏店铺(<em nctype="store_collect"><?php echo $output['store_info']['store_collect']?></em>)</a>
<a onclick="ajax_form('kf_form', '联系客服', '<?php echo UrlMall('goods','callcenter', array('store_id'=>$output['store_info']['store_id']));?>', 360);" href="javascript:void(0);" class="zixun defalt consult">联系客服</a>

            </div>
        </div>
    </div>
<div class="wrap doc_nav pos_rel">
        <div class="doc_nav_list">   
            <a href="<?php echo urlMall('show_store', 'index', array('store_id'=>$output['store_info']['store_id']));?>" class="link1 <?php if($output['page'] == 'index'){?>now<?php }?>">首页</a>
            <a href="<?php echo urlMall('show_store', 'goods_all', array('store_id' => $output['store_info']['store_id']));?>" class="link2 <?php if ($output['page'] == 'allgoods') {?>now<?php }?>">商品<i>（<?php echo $output['store_info']['goods_count'];?>）</i></a>
            <a href="<?php echo urlMall('store_snshome', 'index', array('sid' => $output['store_info']['store_id']))?>" class="link6 <?php if ($output['page'] == 'store_sns') {?>now<?php }?>">动态<i>（<?php echo $output['store_info']['sns_tracelog_count'];?>）</i></a>
            <a href="<?php echo urlMall('show_store', 'comments_goods', array('store_id' => $output['store_info']['store_id']));?>" class="link8   <?php if ($output['page'] == 'store_comments_goods') {?>now<?php }?>">口碑<i>（<?php echo $output['store_info']['evaluate_goods_count'];?>）</i></a>
                    </div>
<?php if($output['page'] == 'index'){?>
                <div class="doc_summary">
        		            <p class="show_defalt">
	            	店铺简介：<?php echo $output['store_info']['store_zy'];?>
                </p>
                    </div><?php }?>
                    
            </div>