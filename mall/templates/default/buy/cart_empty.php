<?php defined('INSYSVIEW') or exit('Access Invalid!');?>

<div class="ncc-null-mallping"><i class="ico"></i>
  <h4><?php echo $lang['cart_index_no_goods_in_cart'];?></h4>
  <p><a href="index.php" class="ncbtn mr10"><i class="icon-reply-all"></i><?php echo $lang['cart_index_mallping_now'];?></a> <a href="index.php?app=member_order" class="ncbtn"><i class="icon-file-text"></i><?php echo $lang['cart_index_view_my_order'];?></a></p>
</div>
<!-- 猜你喜欢 -->
<div id="guesslike_div"></div>
<script type="text/javascript">
$(function(){
	//猜你喜欢
	$('#guesslike_div').load('<?php echo urlMall('search', 'get_guesslike', array()); ?>', function(){
        $(this).show();
    });
});
</script> 