var page = pagesize; 
var curpage = 1;
$(function(){
    var key = getCookie('dlyp_key');
    var dlyp_name = getCookie('dlyp_name');
    if(!key && !dlyp_name){
        window.location.href = WapSiteUrl + "/tmpl/delivery/login.html";
    }
    t();
    function t() {
        var key_word = $("#key_word").val();
        $.ajax({
            type:'post',
            url:ApiUrl+"/index.php?app=delivery&feiwa=center&page=" + page + "&curpage="+curpage,
            data:{key:key,curpage:curpage,key_word:key_word},
            dataType:'json',
            success:function(result){
                var nums = result.datas.curpage;
                if(nums<1){
                    nums=1.1;
                }
                if(nums<curpage){return false;}
                
                var t = result;
                var r = template.render("order-list-tmpl", t);
                $("#order-list").append(r);
                 curpage++;
            }
        });
    }
    
    $("#search_btn").click(function() {
        var key_word = $("#key_word").val();
        $.ajax({
            type:'post',
            url:ApiUrl+"/index.php?app=delivery&feiwa=center&page=" + page + "&curpage=1",
            data:{key:key,curpage:curpage,key_word:key_word},
            dataType:'json',
            success:function(result){
                var t = result;
                var r = template.render("order-list-tmpl", t);
                $("#order-list").html(r);
                 curpage=2;
            }
        });
    });
    

    $(window).scroll(function() {
        if ($(window).scrollTop() + $(window).height() > $(document).height() - 1) {
            t();
        }
    })
});

function daozhan(id){
    var key = getCookie('dlyp_key');
    $.ajax({
        type:'post',
        url:ApiUrl+"/index.php?app=delivery&feiwa=arrive_point",
        data:{key:key,order_id:id},
        dataType:'json',
        success:function(result){
            $.sDialog({
                skin: "red",
                content: '请确认包裹已经到站，提醒买家取件？',
                okBtn: true,
                cancelBtn: true,
                okFn:function(){window.location.reload();},
                cancelFn:function(){}
            });
        }
    });
}
function quhuo(id){
    alert(id);
}
