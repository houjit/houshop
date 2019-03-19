$(function(){
    var key = getCookie('dlyp_key');
    var dlyp_name = getCookie('dlyp_name');
    if(!key && !dlyp_name){
        window.location.href = WapSiteUrl + "/tmpl/delivery/login.html";
    }
    
    $("#loginbtn").click(function() {
        var order_id =  getQueryString("order_id");
        var pickup_code = $("#pickup_code").val();

        $.ajax({
            type:'post',
            url:ApiUrl+"/index.php?app=delivery&feiwa=pickup_parcel",
            data:{key:key,order_id:order_id,pickup_code:pickup_code},
            dataType:'json',
            success:function(result){

                if(result.datas.error){
                    $.sDialog({
                        skin: "red",
                        content: result.datas.error,
                        okBtn: true,
                        cancelBtn: true,
                        okFn:function(){},
                        cancelFn:function(){}
                    });
                }else{
                    $.sDialog({
                        skin: "red",
                        content: result.datas.msg,
                        okBtn: true,
                        cancelBtn: true,
                        okFn:function(){window.location.href = WapSiteUrl + "/tmpl/delivery/center.html";},
                        cancelFn:function(){window.location.href = WapSiteUrl + "/tmpl/delivery/center.html";}
                    });
                   
                }
                
                
                
            }
        });
    });

});
