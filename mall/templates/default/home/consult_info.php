<?php defined('INSYSVIEW') or exit('Access Invalid!');?>
<link href="<?php echo MALL_TEMPLATES_URL;?>/css/feiwa-tenpty.css" rel="stylesheet" type="text/css">
<div class="mainBox">
<div class="rightBox">
    <div class="rightCont">                              
    <p class="c555 ft18">相关咨询产品</p>
    <div class="tao-over">
        <div class="tao-cont">
        	
        	<?php if ($output['mrs_hot_sales']) { ?>
        <?php foreach ((array) $output['mrs_hot_sales'] as $g) { ?>
                    <dl class="baokuan-item">
                <dt><a target="_blank" href="<?php echo urlMall('goods', 'index', array('goods_id' => $g['goods_id'])); ?>"><img width="80px;" height="80px;" src="<?php echo thumb($g, 60); ?>" alt="<?php echo $g['goods_name']; ?>"></a></dt>
                <dd>
                    <p class="item1"><a href="<?php echo urlMall('goods', 'index', array('goods_id' => $g['goods_id'])); ?>" target="_blank"><?php echo $g['goods_name']; ?></a></p>
                  <p class="item4"><a href="<?php echo urlMall('goods', 'index', array('goods_id' => $g['goods_id'])); ?>" target="_blank"><i>￥</i><em><?php echo ncPriceFormat($g['goods_promotion_price']); ?></em><b class="c999"><i><?php echo $g['goods_salenum']; ?></i>人已购买</b></a></p>
                </dd>
            </dl><?php }} ?>
            
                 
                </div>
    </div>
        
    </div>
</div>
<!--//右侧内容-->
<div class="leftBox">
<div class="author w1000 zoom">
	<?php if($output['consult_info']['member_id']== '0') echo $lang['feiwa_guest']; else if($output['consult_info']['isanonymous'] == 1){?>
                <?php echo str_cut($output['consult_info']['member_name'],2).'***';?>
                <?php }else{?>
                <a href="index.php?app=member_snshome&mid=<?php echo $output['consult_info']['member_id'];?>" target="_blank" data-param="{'id':<?php echo $output['consult_info']['member_id'];?>}" nctype="mcard">
                	<img class="left" src="<?php echo UPLOAD_SITE_URL;?>/mall/avatar/avatar_<?php echo $output['consult_info']['member_id'];?>.jpg" alt="<?php echo str_cut($output['consult_info']['member_name'],8);?>"></a>
                	<span class="left"><a href="index.php?app=member_snshome&mid=<?php echo $output['consult_info']['member_id'];?>"><?php echo str_cut($output['consult_info']['member_name'],8);?></a></span>
                <?php }?>
    <div class="right handle">
                <span class="cbbb"><?php echo date("Y-m-d",$output['consult_info']['consult_addtime']);?></span>
    </div>
</div>
<!--帖子内容-->
<div class="compile-box w1000"><?php echo $output['consult_info']['consult_content']; ?></div>
<!--//帖子内容-->
<div class="w1000"></div>

<?php if(!empty($output['gc_ids']) && is_array($output['gc_ids'])){?>
<div class="w1000 share clearfix mt42">

    <?php foreach($output['gc_ids'] as $gcs){?>
    <?php if(!empty($gcs['link'])){?>
    	<a href="<?php echo $gcs['link'];?>" target="_blank" class="span"><?php echo $gcs['title'];?></a>
    <?php }else{?>
    <span><?php echo $gcs['title'];?></span>
    <?php }?>
    <?php }?>
  </div>
       <?php }?> 
    <div class="zixunFormy">
        <div>
            <span class="c999">注：</span>
            <p><?php echo $output['goods']['goods_name']; ?></p>
        </div>
        <a href="<?php echo urlMall('goods','consulting_list',array('goods_id'=>$output['consult_info']['goods_id']));?>" target="_blank">我要咨询</a>
    </div>

<!--回复-->
<div class="w1000">
    <p class="theTip"><span>此问题只允许店主解答，暂不支持其他人解答</span></p>
</div>
<!--//回复-->
<!--回复列表-->
<?php if($output['consult_info']['consult_reply']!=""){?>
<div class="preson-list w1000">
    <p class="person-box-tit"><span id="answer_num">1条回复</span></p>
            <div class="person-box">
            <a target="_blank" href="<?php echo urlMall('show_store','', array('store_id'=>$output['consult_info']['store_id']),$output['consult_info']['store_domain']);?>" class="head-img" >
                <img alt="" src="<?php echo getStoreLogo($output['consult_info']['store_avatar']);?>">
            </a>
            <div class="head-cont">
                <div class="cont-top list-top">
                    <a href="<?php echo urlMall('show_store','', array('store_id'=>$output['consult_info']['store_id']),$output['consult_info']['store_domain']);?>" target="_blank" class="img-name">
                    	<?php echo $output['consult_info']['store_name'];?></a>
                    <span class="num-lou"><?php echo date("Y-m-d",$output['consult_info']['consult_reply_time']);?></span>
                    <i class="time">1楼</i>
                </div>

                <div class="cont-cent list-cent"><p class="name-txt"><?php echo  $output['consult_info']['consult_reply'] ;?></p>

                    <div id="" class="ask-btnsBox"></div>
                </div>
                            </div>
        </div>

     </div><?php }?>
            
            </div></div>
        </div>

</div>

<?php if(!empty($output['consult_list'])) { ?>
<div class="w1000 otherQbox">
    <p class="person-box-tit"><span>相关问题</span></p>
    <ul class="ask-list-t2">
    	<?php foreach($output['consult_list'] as $k=>$v){ ?>
                        <li class="zoom clearfix">
                    <div class="ques clearfix">
                        <div class="en_green left">Q:</div>
                        <div class="arc left">
                            <div class="arc"><a href="<?php echo urlMall('consult','consulting', array('consult_id'=>$v['consult_id']));?>" target="_blank"><?php echo nl2br($v['consult_content']);?></a></div>
                        </div>
                    </div>

                    <div class="answ zoom">
                    <div class="answ-head">
                    	<?php if($v['consult_reply']!=""){?>
                    <div class="en_blue left">A:</div>
                    <div class="pic-box left"><a href="<?php echo urlMall('show_store','', array('store_id'=>$v['store_id']),$v['store_domain']);?>" target="_blank" class="c666"><img height="30" width="30" src="<?php echo getStoreLogo($v['store_avatar']);?>" alt="<?php echo nl2br($v['store_name']);?>"></a></div><?php }?> 
                                    <div class="arc1 left">
<?php if($v['consult_reply']!=""){?>
                                        <p><a href="<?php echo urlMall('show_store','', array('store_id'=>$v['store_id']),$v['store_domain']);?>" target="_blank" class="c666"><?php echo nl2br($v['store_name']);?></a></p>
                                        <p><?php echo nl2br($v['consult_reply']);?></p><?php }?>
                                        	
                                        <p class="c999"><?php if($v['consult_reply']!=""){?><?php echo date("Y-m-d",$v['consult_reply_time']);?><?php }else{?><?php echo date("Y-m-d",$v['consult_addtime']);?><?php }?></p>
                                    </div>
                                </div>
                                                </div>
                </li>
                       <?php }?>  
                        
                </ul>
</div><?php }?>
<!--//回复列表-->
</div>
</div>
