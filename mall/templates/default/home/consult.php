<?php defined('INSYSVIEW') or exit('Access Invalid!');?>
<link href="<?php echo MALL_TEMPLATES_URL;?>/css/ask.css" rel="stylesheet" type="text/css">
<div class="focus-wrap">
        <div class="ask-banner">
            <a href="javascript:;"><img src="<?php echo MALL_SITE_URL;?>/img/sak-banner.jpg" alt=""></a>
            <div class="ques_total">
                <div class="black_bar clearfix">
                    <div class="black-bj"></div>
                    <div class="num">
                        <strong class="split_num flleft" num="369364"><?php echo $output['consults']['consults'];?>
                        </strong>
                        <div class="arc_white flleft">个问题得到解答</div>
                    </div>
                </div>
                <div class="banner-text">
                    <div class="percent">
                        <div>认证 · 高效</div>
                        <p><?php echo $output['consults']['stores'];?>家认证店铺</p>
                    </div>
                    <a href="<?php echo urlMall('store_list','index');?>" class="btn-blue text-center" target="_blank">向商家提问</a>
                </div>
            </div><?php if(!empty($output['consult_lists'])) { ?>
                        <div class="banner-doctor">
          <?php foreach($output['consult_lists'] as $k=>$v){ ?>
                                    <a href="<?php echo urlMall('consult','consulting', array('consult_id'=>$v['consult_id']));?>" target="_blank">
                        <img src="<?php echo getStoreLogo($v['store_avatar']);?>" alt="<?php echo nl2br($v['store_name']);?>">
                        <div><?php echo nl2br($v['store_name']);?></div>
                        <p><?php echo nl2br($v['consult_content']);?></p>
                    </a>
<?php }?>
                            </div><?php }?>
                    </div>
    </div>
   <div class="clear"></div> 
    
    
    
    
    
    
    
    
    
    
    <div class="wrapper main-ask zoom">
    <!--左部分-->
    <div class="main_left flleft"> 
        <div class="nav-title">
            <a class="<?php if (intval($_GET['ctid']) == 0) {?>selected<?php }?>" href="<?php echo urlMall('consult', 'index');?>" target="_self">全部提问</a>
             <?php if (!empty($output['consult_type'])) {?>
            <?php foreach ($output['consult_type'] as $val) {?>
            <a class="<?php if (intval($_GET['ctid']) == $val['ct_id']) {?>selected<?php }?>" href="<?php echo urlMall('consult', 'index', array('ctid' => $val['ct_id']));?>"><?php echo $val['ct_name'];?></a>
            <?php }?>
            <?php }?>
        </div>
        <div class="tab-cont2">
            <!--咨询列表开始-->
            <div class="tab-item" style="display: block;">
            	<?php if(!empty($output['consult_list'])) { ?>
                <ul class="ask-list-t2">
 
          <?php foreach($output['consult_list'] as $k=>$v){ ?>
                                            <li class="clearfix">
                            <div class="ques clearfix">
                                <div class="en_green flleft">Q:</div>
                                <div class="arc flleft">
                                    <div class="arc"><a target="_blank" href="<?php echo urlMall('consult','consulting', array('consult_id'=>$v['consult_id']));?>"><?php echo nl2br($v['consult_content']);?></a></div>
                                </div>
                            </div>
                            <div class="answ clearfix">
                            	<?php if($v['consult_reply']!=""){?>
                                <div class="en_blue flleft">A:</div>
                                <div class="pic-box flleft"><a class="c666" target="_blank" href="<?php echo urlMall('show_store','', array('store_id'=>$v['store_id']),$v['store_domain']);?>"><img width="30" height="30" alt="<?php echo nl2br($v['store_name']);?>" src="<?php echo getStoreLogo($v['store_avatar']);?>"></a></div>
                                <?php }?>
                                <div class="arc1 flleft">
                                	<?php if($v['consult_reply']!=""){?>
                                    <p class="d-name"><a href="<?php echo urlMall('show_store','', array('store_id'=>$v['store_id']),$v['store_domain']);?>" target="_blank"><?php echo nl2br($v['store_name']);?></a></p>
                                    <p class="d-text"><?php echo nl2br($v['consult_reply']);?></p><?php }?>
                                    <div class="labs-bot">
                                        <div class="time flright"><?php echo date("Y-m-d H:i:s",$v['consult_addtime']);?></div>
                                        <a href="javascript:;" class="answer flright">解答(<?php if($v['consult_reply']!=""){?>1<?php }else{?>0<?php }?>)</a>
                                    </div>
                                </div>
                            </div>
                        </li>
                          <?php }?>
                          	
                          </ul>
          <div class="tr pr5 pb5">
            <div class="pagination"> <?php echo $output['show_page'];?> </div>
          </div>
          <?php } else { ?>
          <div class="feiwa-ss-norecord">暂无咨询</div>
          <?php } ?>
                                    
            </div>
            <!--咨询列表结束-->
        </div>
        <!--推荐关注的商家-->
                <div class="doctor-main">
            <div class="doctor-title">推荐关注的商家</div>
            <div class="docCards">
                <ul>
                	<?php if(!empty($output['store_lists']) && is_array($output['store_lists'])){?>
                    <?php foreach($output['store_lists'] as $skey => $store){?>
                                        <li class="theS">
                                                    <i class="teyao">推荐</i>
                                                <div class="cardImg">
                                                        <img src="<?php echo getStoreLogo($store['store_label']);?>" alt="">
                                                    </div>
                        <div class="cover"></div>
                        <div class="cardInfo">
                            <a href="<?php echo urlMall('show_store','', array('store_id'=>$store['store_id']),$store['store_domain']);?>" class="coverLink" target="_blank"></a>
                            <p class="item1">
                                <span class="ft20"><?php echo $store['store_name'];?></span>
                                <i><?php if($store['is_own_mall']==1){;?>本站自营<?php }else{?>第三方店铺<?php }?></i>
                            </p>
                            <p class="item2"><?php echo $store['store_zy'];?></p>
                            <p class="item3">
                                <span class="left"><i><?php echo ($tmp = $store['goods_count']) ? $tmp  : 0;?></i>件商品</span>
                                <span><i><?php echo $store['store_collect'];?></i>人已关注</span>
                            </p>
                            <a href="<?php echo urlMall('show_store','', array('store_id'=>$store['store_id']),$store['store_domain']);?>" class="see-home" target="_blank">查看主页</a>
                        </div>
                    </li>
<?php } ?><?php } ?>


  
                                        
                                    </ul>
                <a class="more-doctor" href="<?php echo urlMall('store_list','index');?>" target="_blank">查看更多商家店铺</a>
            </div>
        </div>
                <!--//推荐关注的商家-->
    </div>
    <!--右部分-->
    <div class="flright main_right">

        <div class="tab-t1">
            <div class="tab-title1">
                <a href="javascript:;" class="selected">热门关注店铺<em></em></a>
              
            </div>
            <dl class="tab-cont1">
                <dd style="display: block;">
                    <div class="doc-list-t1">
                    	<?php if(!empty($output['store_list']) && is_array($output['store_list'])){?>
<?php foreach($output['store_list'] as $skey => $store){?>
                                                    <a target="_blank" href="<?php echo urlMall('show_store','', array('store_id'=>$store['store_id']),$store['store_domain']);?>">
                                <div class="doctor-img">
                                    <img class="user-img" src="<?php echo getStoreLogo($store['store_avatar']);?>">
                                    <span class="v-icon"></span>
                                </div>
                                <div class="doctor-rs">
                                    <div class="doctor-top">
                                        <span class="name"><?php echo $store['store_name'];?></span>
                                                                                <span></span>
                                    </div>
                                    <div class="doctor-address"><?php if($store['is_own_mall']==1){;?>本站自营<?php }else{?>第三方店铺<?php }?></div>
                                </div>
                            </a><?php } ?><?php } ?>
                                              
                                            </div>
                </dd>
               
            </dl>
        </div>
    
    </div>
    <div class="clear"></div>
    </div>
