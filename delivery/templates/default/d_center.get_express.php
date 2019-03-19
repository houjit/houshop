<?php defined('INSYSVIEW') or exit('Access Invalid!');?>

<ul id="express_list"></ul>
<script>
$(function(){
    $.getJSON('index.php?app=d_center&feiwa=ajax_get_express&e_code=<?php echo $_GET['e_code']?>&shipping_code=<?php echo $_GET['shipping_code']?>',function(data){
        if(data){
            $.each(data, function(i, n){
                $('#express_list').append('<li>' + n + '</li>');
            });
        }else{
            $('#express_list').html('<li>暂无物流记录</li>');
        }
    });
});
</script>