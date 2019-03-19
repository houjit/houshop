var page = pagesize; 
var curpage = 1;
$(function(){
    var key = getCookie('dlyp_key');
    var dlyp_name = getCookie('dlyp_name');
    if(!key && !dlyp_name){
        window.location.href = WapSiteUrl + "/tmpl/delivery/login.html";
    }
 
    $.ajax({
        type:'post',
        url:ApiUrl+"/index.php?app=delivery&feiwa=info",
        data:{key:key},
        dataType:'json',
        success:function(result){
            $("#dlyp_name").val(result.datas.info.dlyp_name);
            $("#dlyp_truename").val(result.datas.info.dlyp_truename);
            $("#dlyp_idcard").val(result.datas.info.dlyp_idcard);
            $("#dlyp_area").val(result.datas.info.area);
            $("#dlyp_mobile").val(result.datas.info.dlyp_mobile);
            $("#dlyp_telephony").val(result.datas.info.dlyp_telephony);
            $("#dlyp_state").val(result.datas.info.dlyp_state);
            
        }
    });

    
  
});
