<?php defined('INSYSVIEW') or exit('Access Invalid!');?>
<!--店铺基本信息 S-->
<div class="feiwa-ss-info">
	 <?php if (!$output['store_info']['is_own_mall']) { ?>
	<div class="t-info">
		<p class="f14 c666"><?php echo $output['store_info']['store_company_name'];?></p>
		<p class="f12 c999">第三方店铺</p>
	</div>
	    <div class="feiwa-s-main-rate">
	    	 <dl class="all-rate ">
      <dt>综合评分</dt>
      <dd>
        <div class="rating"><span style="width: <?php echo $output['store_info']['store_credit_percent'];?>%"></span></div>
        <em><?php echo $output['store_info']['store_credit_average'];?></em>分</dd>
    </dl>
      <ul>
        <?php  foreach ($output['store_info']['store_credit'] as $value) {?>
        <li>
          <h5><?php echo $value['text'];?></h5>
          <div class="<?php echo $value['percent_class'];?>" title="<?php echo $value['percent_text'];?><?php echo $value['percent'];?>"><?php echo $value['credit'];?></div>
        </li>
        <?php } ?>
      </ul>
    </div>
	<div class="ft12 c999 hosarea">

      <div class="joinins"><span><?php echo $output['store_info']['area_info'];?><?php echo $output['store_info']['store_address'];?><a href="javascript:void(0)">查看地图</a></span>
       <div class="map-box"><div class="feiwa-info-map" id="map_container" style="width:208px;height:208px;"></div></div> 
       </div>

		</div>
		<?php } ?>
  <div class="title-l">
  	<a href="<?php echo urlMall('show_store', 'index', array('store_id' => $output['store_info']['store_id']), $output['store_info']['store_domain']);?>" class="store_img"><img src="<?php echo getStoreLogo( $output['store_info']['store_label']);?>"></a>
    <a href="<?php echo urlMall('show_store', 'index', array('store_id' => $output['store_info']['store_id']), $output['store_info']['store_domain']);?>" class="store_name"><?php echo $output['store_info']['store_name'];?></a>
    <a href="javascript:collect_store('<?php echo $output['store_info']['store_id'];?>','count','store_collect')" class="sc" >收藏<span>(<em nctype="store_collect"><?php echo $output['store_info']['store_collect']?></em>)</span></a>
  </div>
  <a onclick="ajax_form('kf_form', '联系客服', '<?php echo UrlMall('goods','callcenter', array('store_id'=>$output['store_info']['store_id']));?>', 360);" href="javascript:void(0);" class="zixun ">联系客服</a>
  <?php if(!empty($output['store_info']['store_phone'])){?>
  <p class="c666 zxtxt">电话咨询/预约</p>
  <p class="pink"><?php echo $output['store_info']['store_phone'];?></p>
  <?php } ?>
  <div class="content">
    <?php if(!empty($output['store_info']['store_qq']) || !empty($output['store_info']['store_ww'])){?>
    <dl class="messenger">
      
      <dd><span member_id="<?php echo $output['store_info']['member_id'];?>"></span>
        <?php if(!empty($output['store_info']['store_qq'])){?>
        <a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=<?php echo $output['store_info']['store_qq'];?>&site=qq&menu=yes" title="QQ: <?php echo $output['store_info']['store_qq'];?>"><img border="0" src="http://wpa.qq.com/pa?p=2:<?php echo $output['store_info']['store_qq'];?>:52" style=" vertical-align: middle;"/></a>
        <?php }?>
        <?php if(!empty($output['store_info']['store_ww'])){?>
        <a target="_blank" href="http://amos.im.alisoft.com/msg.aw?v=2&amp;uid=<?php echo $output['store_info']['store_ww'];?>&site=cntaobao&s=1&charset=<?php echo CHARSET;?>" ><img border="0" src="http://amos.im.alisoft.com/online.aw?v=2&uid=<?php echo $output['store_info']['store_ww'];?>&site=cntaobao&s=2&charset=<?php echo CHARSET;?>" alt="<?php echo $lang['feiwa_message_me'];?>" style=" vertical-align: middle;"/></a>
        <?php }?>
      </dd>
    </dl>
    <?php } ?>
  </div>

</div>
<!--店铺基本信息 E--> 
<script type="text/javascript">
var cityName = "<?php echo $output['store_info']['store_address'];?>";
var address = "<?php echo $output['store_info']['area_info'];?>";
var store_name = ""; 
function initialize() {
	map = new BMap.Map("map_container");
	localCity = new BMap.LocalCity();
	
	map.enableScrollWheelZoom(); 
	localCity.get(function(cityResult){
	  if (cityResult) {
	  	var level = cityResult.level;
	  	if (level < 13) level = 13;
	    map.centerAndZoom(cityResult.center, level);
	    cityResultName = cityResult.name;
	    if (cityResultName.indexOf(cityName) >= 0) cityName = cityResult.name;
	    	    	getPoint();
	    	  }
	});
}
 
function loadScript() {
	var script = document.createElement("script");
	script.src = "http://api.map.baidu.com/api?v=1.2&callback=initialize";
	document.body.appendChild(script);
}
function getPoint(){
	var myGeo = new BMap.Geocoder();
	myGeo.getPoint(address, function(point){
	  if (point) {
	    setPoint(point);
	  }
	}, cityName);
}
function setPoint(point){
	  if (point) {
	    map.centerAndZoom(point, 16);
	    var marker = new BMap.Marker(point);
	    map.addOverlay(marker);
	  }
}

// 当鼠标放在店铺地图上再加载百度地图。
$(function(){
	$('.joinins').one('mouseover',function(){
		loadScript();
	});
});
</script> 
<script>
$(function(){
	var store_id = "<?php echo $output['store_info']['store_id']; ?>";
	var goods_id = "<?php echo $_GET['goods_id']; ?>";
	var app = "<?php echo trim($_GET['app']); ?>";
	var op  = "<?php echo trim($_GET['feiwa']) != ''?trim($_GET['feiwa']):'index'; ?>";
	$.getJSON("index.php?app=show_store&feiwa=ajax_flowstat_record",{store_id:store_id,goods_id:goods_id,app_param:app,op_param:op});
});
</script> 