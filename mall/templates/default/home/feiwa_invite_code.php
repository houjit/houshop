<?php defined('INSYSVIEW') or exit('Access Invalid!');?>
<link rel="stylesheet" type="text/css" href="<?php echo WAP_SITE_URL;?>/css/base.css">
<link rel="stylesheet" type="text/css" href="<?php echo WAP_SITE_URL;?>/css/nctouch_member.css">
<script type="text/javascript" src="<?php echo RESOURCE_SITE_URL;?>/js/html2canvas.js"></script>
<script src="<?php echo RESOURCE_SITE_URL;?>/js/jquery.js"></script>
		<script type="text/javascript">
			$(function(){	
				print();
			});
			function print(){	
				html2canvas( $("#canv") ,{  		
					onrendered: function(canvas){
						$('#down_button').attr( 'href' , canvas.toDataURL() ) ;
						$('#down_button').attr( 'download' , 'myjobdeer.png' ) ;
						//$('#down_button').css('display','inline-block');
						var html_canvas = canvas.toDataURL();
						$.post('', {order_id:1,type_id:2,html_canvas:html_canvas}, function(json){
						}, 'json');
					}
				});
			}
		</script>

		<div id="canv">
        <div class="logo"></div>
        <div class="head">
        <span class="title">现在注册</span>
        <span class="stitle">畅享35%返利优惠</span>
        </div>
        <code class="code" ><img src="<?php echo UPLOAD_SITE_URL;?>/mall/member/<?php echo $_GET['id'];?>_member.png"></code>
        <div class="code_ft">xxxxx.xxx</div>
		</div>
		<div class="ofver"><a type="button" id="down_button">保存到手机</a></div>
	<?php
	if(isset($_POST['html_canvas'])){
	$order_id = $_POST['order_id'];
	$type_id = $_POST['type_id'];
	$html_canvas = $_POST['html_canvas'];
	$image = base64_decode(substr($html_canvas, 22));
	header('Content-Type: image/png');
	$filename =  $order_id.'-'.$type_id.".png";
	$fp = fopen($filename, 'w');
	fwrite($fp, $image);
	fclose($fp);
	}
	
	?>
