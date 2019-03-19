$(function () {  
	var e = getCookie("delivery_key");
//	delCookie('delivery_user');
//	delCookie('delivery_key');
//        delCookie('store_name');
    if (e) {
        window.location.href = WapSiteUrl + "/tmpl/delivery/delivery.html";
        return;
    }
    var r = document.referrer;
    $.sValid.init({
        rules: {
            dname: "required",
            dpasswd: "required"
        },
        messages: {
            dname: "用户名必须填写！",
            dpasswd: "密码必填!"
        },
        callback: function (e, r, a) {
            if (e.length > 0) {
                var i = "";
                $.map(r, function (e, r) {
                    i += "<p>" + e + "</p>"
                });
                errorTipsShow(i)
            } else {
                errorTipsHide()
            }
        }
    });
    var a = true;
    $("#loginbtn").click(function () { 
        if (!$(this).parent().hasClass("ok")) {
            return false
        }
        if (a) {
            a = false
        } else {
            return false
        }
        var e = $("#dname").val();
        var i = $("#dpasswd").val();
        var t = "wap";
		 
        if ($.sValid()) {
            $.ajax({
                type: "post",
                url: ApiUrl + "/index.php?app=delivery_login&feiwa=index",
                data: {
                    dname: e,
                    dpasswd: i,
                    client: t
                },
                dataType: "json",
                success: function (e) {
                    a = true;
                    if (!e.datas.error) {
                        if (typeof e.datas.key == "undefined") {
							
                            return false
                        } else {
                            var i = 0;
                            if ($("#checkbox").prop("checked")) {
                                i = 188
                            }
                            //updateCookieCart(e.datas.key);
                            
                             addCookie("dlyp_name", e.datas.dlyp_name, i);
                             addCookie("dlyp_id", e.datas.dlyp_id, i);
                             addCookie("dlyp_key", e.datas.key, i);
                            location.href = WapSiteUrl + "/tmpl/delivery/delivery.html";
							 
                        }
                        errorTipsHide()
                    } else {
						
                        errorTipsShow("<p>" + e.datas.error + "</p>")
                    }
                }
            })
        }
    });

});
