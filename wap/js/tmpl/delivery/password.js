$(function(){
    var key = getCookie('dlyp_key');
    var dlyp_name = getCookie('dlyp_name');
    if(!key && !dlyp_name){
        window.location.href = WapSiteUrl + "/tmpl/delivery/login.html";
    }
    
    $("#loginbtn").click(function() {
        var old_password = $("#old_password").val();
        var password = $("#password").val();
        var passwd_confirm = $("#passwd_confirm").val();

        $.ajax({
            type:'post',
            url:ApiUrl+"/index.php?app=delivery&feiwa=change_password",
            data:{key:key,old_password:old_password,password:password,passwd_confirm:passwd_confirm},
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
                        content: '修改成功',
                        okBtn: true,
                        cancelBtn: true,
                        okFn:function(){
                            delCookie('dlyp_id');
                            delCookie('dlyp_name');
                            delCookie('dlyp_key');
                            window.location.href = WapSiteUrl + "/tmpl/delivery/delivery.html";
                        },
                        cancelFn:function(){
                            delCookie('dlyp_id');
                            delCookie('dlyp_name');
                            delCookie('dlyp_key');
                            window.location.href = WapSiteUrl + "/tmpl/delivery/login.html";
                        }
                    });
                   
                }
                
                
                
            }
        });
    });

});
