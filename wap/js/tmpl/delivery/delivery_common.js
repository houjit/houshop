$(function(){
    $('#logoutbtn').click(function(){
        delCookie('dlyp_id');
	delCookie('dlyp_name');
        delCookie('dlyp_key');
        window.location.href = WapSiteUrl + "/tmpl/delivery/delivery.html";
    });
});