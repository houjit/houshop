$(function() {
    var key = getCookie('dlyp_key');
    if (!key) {
        window.location.href = WapSiteUrl + '/tmpl/delivery/login.html';
        return;
    }
    var order_id = getQueryString("order_id");
    $.ajax({
        type: 'post',
        url: ApiUrl + "/index.php?app=delivery&feiwa=search_deliver",
        data:{key:key,order_id:order_id},
        dataType:'json',
        success:function(result) {

            var data = result && result.datas;
            if(result.datas.error){
                data = {};
                data.err = result.datas.error;
            }
            

            var html = template.render('order-delivery-tmpl', data);
            $("#order-delivery").html(html);
        }
    });

});
