$(function(){
	//代金券兑换功能
    $("[feiwa_type='exchangebtn']").live('click',function(){
    	var data_str = $(this).attr('data-param');
	    eval( "data_str = "+data_str);
	    ajaxget('index.php?app=pointvoucher&feiwa=voucherexchange&dialog=1&vid='+data_str.vid);
	    return false;
    });
    //红包兑换功能
    $("[feiwa_type='rptexchangebtn']").live('click',function(){
    	var data_str = $(this).attr('data-param');
	    eval( "data_str = "+data_str);
	    ajaxget('index.php?app=pointredpacket&feiwa=rptexchange&dialog=1&tid='+data_str.tid);
	    return false;
    });
});