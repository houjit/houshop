$(function(){
    var key = getCookie('dlyp_key');

    if(!key){
        window.location.href = WapSiteUrl + "/tmpl/delivery/login.html";
    }
});