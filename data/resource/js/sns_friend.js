$(function(){
	//加关注
	$("[feiwa_type='followbtn']").live('click',function(){
		var data_str = $(this).attr('data-param');
        eval( "data_str = "+data_str);
        $.getJSON(MEMBER_SITE_URL + '/index.php?app=member_snsfriend&feiwa=addfollow&mid='+data_str.mid, function(data){
        	if(data){
        		var obj = $('#recordone_'+data_str.mid);
        		obj.find('[feiwa_type="signmodule"]').children().hide();
        		if(data.state == 2){
        			obj.find('[feiwa_type=\"mutualsign\"]').show();
        		}else{
        			obj.find('[feiwa_type=\"followsign\"]').show();
        		}
    			showSucc('关注成功');
        	}else{
        		showError('关注失败');
        	}
        });
        return false;
	});
	//取消关注
	$("[feiwa_type='cancelbtn']").live('click',function(){
		var data_str = $(this).attr('data-param');
        eval( "data_str = "+data_str);
        $.getJSON(MEMBER_SITE_URL + '/index.php?app=member_snsfriend&feiwa=delfollow&mid='+data_str.mid, function(data){
        	if(data){
        		$('#recordone_'+data_str.mid).hide();
        		showSucc('取消成功');
        	}else{
        		showError('取消失败');
        	}
        });
        return false;
	});
	// 批量关注
	$('*[nctype="batchFollow"]').live('click', function(){
		eval("data_str = "+$(this).attr('data-param'));
		ajax_get_confirm('',MEMBER_SITE_URL + '/index.php?app=member_snsfriend&feiwa=batch_addfollow&ids='+data_str.ids);
	});
});