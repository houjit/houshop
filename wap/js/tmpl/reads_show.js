$(function(){
	var article_id = getQueryString('article_id')
	
	if (article_id=='') {
    	window.location.href = WapSiteUrl + '/index.html';
    	return;
	}
	else {
		$.ajax({
			url:ApiUrl+"/index.php?app=index&feiwa=reads_show",
			type:'get',
			data:{article_id:article_id},
			jsonp:'callback',
			dataType:'jsonp',
			success:function(result){
				$('title,h1').html(result.datas.article_title);
				var data = result.datas;
				var html = template.render('article', data);				
				$("#article-content").html(html);
				$(".article-content").html(data.article_content);
			}
		});
	}	
});