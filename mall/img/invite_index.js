/*plugin/invite/template/js/ZeroClipboard.js*/
// JavaScript Document
function fenduan(val,level,arr){
	if(typeof arguments[3]!='undefined'){
		var bili=arguments[3];
	}
	else{
		var bili=1;
	}
	var re=0;
    for(var k in arr){
    	k=parseInt(k);
        if(level>=k){
        	re=val*arr[k+'a'];
            break;
		}
    }
    if(re==0){
    	re=val*arr[k+'a'];
    }
	re*=bili;
    return dataType(re,DATA_TYPE);
}

function dataType(num,type){  //本来直接用toFixed函数就可以，但是火狐浏览器不行
	if(type==1){
		num=parseInt(num);
	}
	else if(type==2){
		num=num*100;
  		num=num.toFixed(0);
  		num=Math.round(num)/100;
	}
	return num;
}

//小发泄：谷歌（火狐）不支持数组的for in 的形式，只支持对象。如果索引是数字，还会强制从最小的数字开始算第一个，不管你当初是怎么设置的，在IE中这些都不会存在。
//IE显示的js错误随便比较简单，但是很方便，谷歌虽然有控制台，但还是麻烦。毕竟很多人只是需要看一些定义方面的错误提示。
//在IE中，看一个A标签的链接，右键一下很简单，谷歌就费老劲了，由于网速慢图片没显示，IE可以手动二次加载，谷歌就没有。
//一个页面如果是post产生的，谷歌就不能查看其源码了（完全不懂为什么这个都做不到），IE好好的。
//还有好多就不说了，支持IE，虽然你们的第六代儿子给我造成了很多麻烦，虽然你们的第12胎都不一定完全支持css3，但相信你们会越做越好。

function setPic(pic,width,height,alt,classname,onerrorPic){
	pic =  decode64(pic);
	writestr = "<img src='"+pic+"' ";
	if(width!=0){
		writestr+=" width="+width;
	}
	if(height!=0){
		writestr+=" height="+height;
	}
	writestr = writestr+" alt='"+alt+"' onerror='this.src=\""+onerrorPic+"\"' class='"+classname+"' />";
	document.write(writestr);
}

function selAll(obj){
    $(obj).attr("checked",'true');//全选
}
function selNone(obj){
    $(obj).removeAttr("checked");//取消全选
}
function selfan(obj){
    $(obj).each(function(){
		if($(this).attr("checked")){
			$(this).removeAttr("checked");
		}
		else{
		    $(this).attr("checked",'true');
		}
	})
}

function parse_str(url){
    if(url.indexOf('?')>-1){
        u=url.split("?");
		var param1 = u[1];
    }else{
        var param1 = url;
    }
	var s = param1.split("&");
    var param2 = {};
    for(var i=0;i<s.length;i++){
       var d=s[i].split("=");
       eval("param2."+d[0]+" = '"+d[1]+"';");
    }
	return param2;
}

/*var arr = [];  
for(i in param2){  
   arr.push( i + "=" + param2[i]); //根据需要这里可以考虑escape之类的操作  
}  
alert(arr.join("&")) */ 

function postForm(action,input){
	var postForm = document.createElement("form");//表单对象
    postForm.method="post" ;
    postForm.action = action ;
	var k;
    for(k in input){
		if(input[k]!=''){
			var htmlInput = document.createElement("input");
			htmlInput.setAttribute("name", k) ;
            htmlInput.setAttribute("value", input[k]);
            postForm.appendChild(htmlInput) ;
		}
	}
	document.body.appendChild(postForm) ;
	//alert(document.body.innerHTML)
    postForm.submit() ;
    document.body.removeChild(postForm) ;
}

function u(mod,app,arr,wjt){
	if(!arguments[2]){
	    var arr = new Array();
	}
	if(!arguments[3]){
	    wjt=0;
	}
	var mod_app_url='';
	if(app=='' && mod=='index'){
	    mod_app_url='?';
	}
	else if(app==''){
	    mod_app_url="index.php?mod="+mod+"&app=index";
	}
	else{
		if(wjt==1){
			var str='';
			for(k in arr){
			    str+='-'+arr[k];
			}
		    mod_app_url=mod+'/'+app+str+'.html';
		}
		else{
		    mod_app_url="index.php?mod="+mod+"&app="+app+arr2param(arr);
		}
	}
    return mod_app_url;
}

function arr2param(arr){
	var param='';
	var k;
    for(k in arr){
		if(arr[k]!=''){
		    param+='&'+k+'='+arr[k];
		}
	}
	return param;
}


function getClientHeight()
{
  var clientHeight=0;
  if(document.body.clientHeight&&document.documentElement.clientHeight)
  {
  var clientHeight = (document.body.clientHeight<document.documentElement.clientHeight)?document.body.clientHeight:document.documentElement.clientHeight;   
  }
  else
  {
  var clientHeight = (document.body.clientHeight>document.documentElement.clientHeight)?document.body.clientHeight:document.documentElement.clientHeight;   
  }
  return clientHeight;
}


function like(id,htmlId){
	var $t=$("#"+htmlId);
	var user_hart=parseInt($t.text());
	$.ajax({
	    url: u('ajax','like'),
		data:{'id':id},
		dataType:'jsonp',
		jsonp:"callback",
		success: function(data){
			if(data.s==0){
			    alert(errorArr[data.id]);
			}
			else if(data.s==1){
			    $t.text(user_hart+1);
			}
		 }
	});
}


String.prototype.Trim = function() 
{ 
    return this.replace(/(^\s*)|(\s*$)/g, ""); 
} 


//////右下角帮助
function miaovAddEvent(oEle, sEventName, fnHandler)
{
	if(oEle.attachEvent)
	{
		oEle.attachEvent('on'+sEventName, fnHandler);
	}
	else
	{
		oEle.addEventListener(sEventName, fnHandler, false);
	}
}
function helpWindows(word,title)
{
	$('#miaov_float_layer').remove();
	$("body").append('<div class="float_layer" id="miaov_float_layer"><h2><strong>'+title+'</strong><a id="btn_min" href="javascript:;" class="min"></a><a id="btn_close" href="javascript:;" class="close"></a></h2><div class="content"><div class="wrap">'+word+'</address></div></div></div>');
	var oDiv=document.getElementById('miaov_float_layer');
	var oBtnMin=document.getElementById('btn_min');
	var oBtnClose=document.getElementById('btn_close');
	var oDivContent=oDiv.getElementsByTagName('div')[0];
	
	var iMaxHeight=0;
	
	var isIE6=window.navigator.userAgent.match(/MSIE 6/ig) && !window.navigator.userAgent.match(/MSIE 7|8/ig);
	
	oDiv.style.display='block';
	iMaxHeight=oDivContent.offsetHeight;
	
	if(isIE6)
	{
		oDiv.style.position='absolute';
		repositionAbsolute();
		miaovAddEvent(window, 'scroll', repositionAbsolute);
		miaovAddEvent(window, 'resize', repositionAbsolute);
	}
	else
	{
		oDiv.style.position='fixed';
		repositionFixed();
		miaovAddEvent(window, 'resize', repositionFixed);
	}
	
	oBtnMin.timer=null;
	oBtnMin.isMax=true;
	oBtnMin.onclick=function ()
	{
		startMove
		(
			oDivContent, (this.isMax=!this.isMax)?iMaxHeight:0,
			function ()
			{
				oBtnMin.className=oBtnMin.className=='min'?'max':'min';
			}
		);
	};
	
	oBtnClose.onclick=function ()
	{
		oDiv.style.display='none';
	};
};

function startMove(obj, iTarget, fnCallBackEnd)
{
	if(obj.timer)
	{
		clearInterval(obj.timer);
	}
	obj.timer=setInterval
	(
		function ()
		{
			doMove(obj, iTarget, fnCallBackEnd);
		},30
	);
}

function doMove(obj, iTarget, fnCallBackEnd)
{
	var iSpeed=(iTarget-obj.offsetHeight)/8;
	
	if(obj.offsetHeight==iTarget)
	{
		clearInterval(obj.timer);
		obj.timer=null;
		if(fnCallBackEnd)
		{
			fnCallBackEnd();
		}
	}
	else
	{
		iSpeed=iSpeed>0?Math.ceil(iSpeed):Math.floor(iSpeed);
		obj.style.height=obj.offsetHeight+iSpeed+'px';
		
		((window.navigator.userAgent.match(/MSIE 6/ig) && window.navigator.userAgent.match(/MSIE 6/ig).length==2)?repositionAbsolute:repositionFixed)()
	}
}

function repositionAbsolute()
{
	var oDiv=document.getElementById('miaov_float_layer');
	var left=document.body.scrollLeft||document.documentElement.scrollLeft;
	var top=document.body.scrollTop||document.documentElement.scrollTop;
	var width=document.documentElement.clientWidth;
	var height=document.documentElement.clientHeight;
	
	oDiv.style.left=left+width-oDiv.offsetWidth+'px';
	oDiv.style.top=top+height-oDiv.offsetHeight+'px';
}

function repositionFixed()
{
	var oDiv=document.getElementById('miaov_float_layer');
	var width=document.documentElement.clientWidth;
	var height=document.documentElement.clientHeight;
	
	oDiv.style.left=width-oDiv.offsetWidth+'px';
	oDiv.style.top=height-oDiv.offsetHeight+'px';
}

//操作cookie
function setCookie(name, value,expiredays) {
	expiredays=expiredays||3 * 24 * 60 * 60 * 1000;
	var exp = new Date();
	exp.setTime(exp.getTime() + expiredays); //3天过期
	document.cookie = name + "=" + encodeURIComponent(value) + ";expires=" + exp.toGMTString()+";path=/";
};

//取得cookie
function getCookie(name){
    var str=document.cookie.split(";")
    for(var i=0;i<str.length;i++){
        var str2=str[i].split("=");
		str2[0]=str2[0].Trim();
        if(str2[0]==name){
		    return unescape(str2[1]);
	    }
    }
}
//删除cookie
function delCookie(name){
 var date=new Date();
 date.setTime(date.getTime()-10000);
 document.cookie=name+"=n;expire="+date.toGMTString();
}

//图片自适应大小
function imgAuto(img, maxW, maxH) {
	var oriImg = document.createElement("img");
	oriImg.onload = function(){oriImg.height
		if (oriImg.width == 0 || oriImg.height == 0)
			return;
		var oriW$H = oriImg.width / oriImg.height;
		//var maxW$H = maxW / maxH;

		if (oriImg.height > maxH) {
			img.style.height = maxH;
			// img.removeAttribute("width");
			img.style.width = maxH * oriW$H;
		}
		if (img.width > maxW) {
			img.style.width = maxW;
			// img.removeAttribute("height");
			img.style.height = maxW / oriW$H;
		}

		if (maxH) {// if it defined the maxH argument
			if (img.height > 0)
				img.style.marginTop = (maxH - img.height) / 2 + "px";
		}
	};
	oriImg.src = img.src;
	img.style.display="block";
}


function ajaxPost(url,query){
	var type='json';
	var test=arguments[2];
	if(test==1){
		type='html';
	}
	$.ajax({
	    url: url,
		type: "POST",
		data:query,
		dataType:type,
		success: function(data){
			if(test ==1){
			    alert(data);
			}
			
		    if(data.s==0){
			    alert(errorArr[data.id]);
			}
			else if(data.s==1){
			    alert('保存成功');
				location.replace(location.href);
			}
		}
	});
}

function ajaxPostForm(form){
	var query=$(form).serialize();
	var url=$(form).attr('action');
	var type='json';
	var word=arguments[2];
	var goto=arguments[1];
	if(typeof word=='undefined') word='';
	if(typeof goto=='undefined') goto='';
	$.ajax({
	    url: url,
		type: "POST",
		data:query,
		dataType:'json',
		success: function(data){//alert(data);
		    if(data.s==0){
			    alert(errorArr[data.id]);
			}
			else if(data.s==1){
				if(word!=''){
				    alert(word);
				}
				if(goto !=''){
	                window.location.href=goto;
					return false;
	            }
				
				if(typeof data.g=='undefined' || data.g=='' || data.g==0){
				    location.replace(location.href);
				}
				else{
				    window.location.href=data.g;
				}
			}
		},
		error: function(XMLHttpRequest,textStatus, errorThrown){
			alert(XMLHttpRequest.status+'--'+XMLHttpRequest.readyState+'--'+textStatus);
        }
	});
}

function IsUrl(str_url){
    var strRegex = "^((https|http|ftp|rtsp|mms)?://)"
    + "?(([0-9a-z_!~*'().&=+$%-]+: )?[0-9a-z_!~*'().&=+$%-]+@)?" //ftp的user@
    + "(([0-9]{1,3}\.){3}[0-9]{1,3}" // IP形式的URL- 199.194.52.184
    + "|" // 允许IP和DOMAIN（域名）
    + "([0-9a-z_!~*'()-]+\.)*" // 域名- www.
    + "([0-9a-z][0-9a-z-]{0,61})?[0-9a-z]\." // 二级域名
    + "[a-z]{2,6})" // first level domain- .com or .museum
    + "(:[0-9]{1,4})?" // 端口- :80
    + "((/?)|" // a slash isn't required if there is no file name
    + "(/[0-9a-z_!~*'().;?:@&=+$,%#-]+)+/?)$";
    var re=new RegExp(strRegex);
    //re.test()
    if (re.test(str_url)){
        return 1;
    }else{
        return 0;
    }
}

function isPic(a){
  	if(!a.match(/\.jpg|png|gif$/,a)){
  		return 0;
  	}
  	else{
		if(a.indexOf('taobaocdn.com')>0){
			return 2;
		}
		else{
			return 1;
		}
  	}
}

function checkForm(t){
    var subm=1;
	$(t).find('.required').each(function(){
		var word=$(this).attr('word');
		var num=$(this).attr('num');
		var url=$(this).attr('url');
		var pic=$(this).attr('pic');
		var val=$(this).val();
		if(typeof word=='undefined'){word='';}
		if(val=='' || val==word){
			$(this).focus().addClass('red_border');
			if(word!=''){
			    alert(word);
			}
		    else{
			    alert('此字段必填');
			}
			subm=0;
			return false;
		}
		if(num=='y' && isNaN(val)){
			$(this).focus().addClass('red_border');
			alert('这不是一个数字');
			subm=0;
			return false;
		}
		if(url=='y' && IsUrl(val)==0){
			$(this).focus().addClass('red_border');
			alert('这不是一个网址（http://开头）');
			subm=0;
			return false;
		}
		if(pic=='y'){
			var a=isPic(val);
			if(a==2){
				val=val.replace(/_\d+x\d+\.jpg/,'');
				val=val.replace(/_b\.jpg/,'');
				$(this).val(val);
			}
			else if(a==0){
				$(this).focus().addClass('red_border');
				alert('这不是一个图片');
				subm=0;
				return false;
			}
		}
    }).blur(function(){
	    if($(this).val()!=''){
		    $(this).removeClass('red_border');
		}
	}); 
	if(subm==0){
		return false;
	}
	else{
	    return true;
	}
}

function http_pic(pic){
    if(pic.indexOf("http://")>=0){
	    return pic;
	}
	else{
	    return '../'+pic;
	}
}

function inArray(val,array){
	for(var i in array){
	    if(array[i]!='' && val.indexOf(array[i])>=0){
		    return val;
		}
	}
	return '';
}

function backToTop(pageW){
	function jisuanW(pageW){
		if(pageW>0){
			var screenW=$(window).width();
			var w=(screenW-pageW)/2-30;
		}
		else{
			var w=10;
		}
		return w;
	}
	pageW=pageW||0;
	var w=jisuanW(pageW);
    var $backToTopTxt = "返回顶部";
	var $backToTopEle = $('<div class="backToTop" id="backToTop" style="bottom:20px; right:'+w+'px"></div>').appendTo($("body")).text($backToTopTxt).attr("title", $backToTopTxt).click(function() {$("html, body").animate({ scrollTop: 0 }, 120);});
	var $backToTopFun = function() {
        var st = $(document).scrollTop(), winh = $(window).height();
        (st > 0)? $backToTopEle.show(): $backToTopEle.hide();
        //IE6下的定位
        if (!window.XMLHttpRequest) {
            $backToTopEle.css("top", st + winh - 166);
        }
    };
    $(window).bind("scroll", $backToTopFun);
    $backToTopFun();
	$(window).resize(function(){
		var w=jisuanW(pageW);
		$('#backToTop').css('right',w+'px');
	});
}

function domStop(id) {  //id外围需要一个position:relative的元素定位，id最好不要有css，只起到单纯的定位作用
	var IO = document.getElementById(id),Y = IO,H = 0,IE6;
	IE6 = window.activeXObject && !window.XMLHttpRequest;
	while (Y) {
		H += Y.offsetTop;
		Y = Y.offsetParent
	};
	if (IE6) {
		IO.style.cssText = "position:absolute;top:expression(this.fix?(document" + ".documentElement.scrollTop-(this.javascript||" + H + ")):0)";
	} else {
		IO.style.cssText = "top:0px";
	}

	window.onscroll = function() {
		var d = document,
		s = Math.max(d.documentElement.scrollTop, document.body.scrollTop);
		if (s > H && IO.fix || s <= H && !IO.fix) return;
		if (!IE6) IO.style.position = IO.fix ? "": "fixed";
		IO.fix = !IO.fix;
	};
	try {
		document.execCommand("BackgroundImageCache", false, true)
	} catch(e) {};
}

function regEmail(email){
    var reg = /^[-_A-Za-z0-9\.]+@([_A-Za-z0-9]+\.)+[A-Za-z0-9]{2,3}$/;
    if(reg.test(email)){
	    return true;
	}else{    
        return false;    
    } 
}

function regMobile(str){    
    if(/^1\d{10}$/g.test(str)){      
        return true;    
    }else{    
        return false;    
    }    
} 

function regAlipay(str){
    if(regMobile(str) || regEmail(str)){
	    return true;
	}else{    
        return false;    
    }
}

function regQQ(qq){
    if((!isNaN(str) && str.length.length>4 && str.length.length<15) || regEmail(str)){
	    return true;
	}else{    
        return false;    
    }
}

function fixDiv(div_id,offsetTop){
	var offset=arguments[1]?arguments[1]:0;
    var Obj=$(div_id);
	var w=Obj.width();
    var ObjTop=Obj.offset().top;
    var isIE6=navigator.userAgent.toLowerCase().indexOf('msie 6.0')>=0;
	var position=Obj.css('position');
	
    if(isIE6){
        $(window).scroll(function(){
			if($(window).scrollTop()<=ObjTop){
                    Obj.css({
                        'position':position,
                        'top':0
                    });
            }else{
                Obj.css({
                    'position':'absolute',
                    'top':$(window).scrollTop()+offsetTop+'px',
                    'z-index':1
                });
            }
        });
    }else{
        $(window).scroll(function(){
            if($(window).scrollTop()<=ObjTop){
                Obj.css({
                    'position':position,
					'top':0
                });
            }else{
                Obj.css({
                    'position':'fixed',
                    'top':0+offsetTop+'px',
					'z-index':999,
					'width':w+'px'
                });
            }
        });
    }
}

function debugObjectInfo(obj) {
    traceObject(obj);

    function traceObject(obj) {
        var str = '';
        if (obj.tagName && obj.name && obj.id) str = "<table border='1' width='100%'><tr><td colspan='2' bgcolor='#ffff99'>traceObject 　　tag: &lt;" + obj.tagName + "&gt;　　 name = \"" + obj.name + "\" 　　id = \"" + obj.id + "\" </td></tr>";
        else {
            str = "<table border='1' width='100%'>";
        }
        var key = [];
        for (var i in obj) {
            key.push(i);
        }
        key.sort();
        for (var i = 0; i < key.length; i++) {
            var v = new String(obj[key[i]]).replace(/</g, "&lt;").replace(/>/g, "&gt;");
            str += "<tr><td valign='top'>" + key[i] + "</td><td>" + v + "</td></tr>";
        }
        str = str + "</table>";
        writeMsg(str);
    }
    function trace(v) {
        var str = "<table border='1' width='100%'><tr><td bgcolor='#ffff99'>";
        str += String(v).replace(/</g, "&lt;").replace(/>/g, "&gt;");
        str += "</td></tr></table>";
        writeMsg(str);
    }
    function writeMsg(s) {
        traceWin = window.open("", "traceWindow", "height=600, width=800,scrollbars=yes");
        traceWin.document.write(s);
    }
}

function call_user_func(func){ //模拟php的call_user_func，缺点参数不能是对象，有待改进
	var l = arguments.length;
	var s='';
	var x='';

	for(var i=0;i<l;i++){
		if(isNaN(arguments[i])==false){
			x=arguments[i];
		}
		else{
			x='"'+arguments[i]+'"';
		}
		if(i==1){
			s=s+x;
		}
		else if(i>1){
			s=s+','+x;
		}
	}
	eval(func+'('+s+')');
}

/*function call_user_func (cb) {  //参数可以是数组，但是被调用的含糊不能含有jquery方法
  // http://kevin.vanzonneveld.net
  // +   original by: Brett Zamir (http://brett-zamir.me)
  // +   improved by: Diplom@t (http://difane.com/)
  // +   improved by: Brett Zamir (http://brett-zamir.me)
  // *     example 1: call_user_func('isNaN', 'a');
  // *     returns 1: true
  var func;

  if (typeof cb === 'string') {
    func = (typeof this[cb] === 'function') ? this[cb] : func = (new Function(null, 'return ' + cb))();
  }
  else if (Object.prototype.toString.call(cb) === '[object Array]') {
    func = (typeof cb[0] == 'string') ? eval(cb[0] + "['" + cb[1] + "']") : func = cb[0][cb[1]];
  }
  else if (typeof cb === 'function') {
    func = cb;
  }

  if (typeof func != 'function') {
    throw new Error(func + ' is not a valid function');
  }

  var parameters = Array.prototype.slice.call(arguments, 1);
  return (typeof cb[0] === 'string') ? func.apply(eval(cb[0]), parameters) : (typeof cb[0] !== 'object') ? func.apply(null, parameters) : func.apply(cb[0], parameters);
}*/

function intval(v) 
{ 
    v = parseInt(v); 
    return isNaN(v) ? 0 : v; 
} 

// 获取元素信息 
function getPos(e) 
{ 
    var l = 0; 
    var t  = 0; 
    var w = intval(e.style.width); 
    var h = intval(e.style.height); 
    var wb = e.offsetWidth; 
    var hb = e.offsetHeight; 
    while (e.offsetParent){ 
        l += e.offsetLeft + (e.currentStyle?intval(e.currentStyle.borderLeftWidth):0); 
        t += e.offsetTop  + (e.currentStyle?intval(e.currentStyle.borderTopWidth):0); 
        e = e.offsetParent; 
    } 
    l += e.offsetLeft + (e.currentStyle?intval(e.currentStyle.borderLeftWidth):0); 
    t  += e.offsetTop  + (e.currentStyle?intval(e.currentStyle.borderTopWidth):0); 
    return {x:l, y:t, w:w, h:h, wb:wb, hb:hb}; 
} 

// 获取滚动条信息 
function getScroll()  
{ 
    var t, l, w, h; 
     
    if (document.documentElement && document.documentElement.scrollTop) { 
        t = document.documentElement.scrollTop; 
        l = document.documentElement.scrollLeft; 
        w = document.documentElement.scrollWidth; 
        h = document.documentElement.scrollHeight; 
    } else if (document.body) { 
        t = document.body.scrollTop; 
        l = document.body.scrollLeft; 
        w = document.body.scrollWidth; 
        h = document.body.scrollHeight; 
    } 
    return { t: t, l: l, w: w, h: h }; 
} 

// 锚点(Anchor)间平滑跳转 
function scroller(el, duration,offset) 
{
    if(typeof el != 'object') { el = document.getElementById(el); } 

    if(!el) return; 

    var z = this; 
    z.el = el; 
    z.p = getPos(el);
	if(offset>0){
		z.p.y=z.p.y-offset;
	}
    z.s = getScroll(); 
    z.clear = function(){window.clearInterval(z.timer);z.timer=null}; 
    z.t=(new Date).getTime(); 

    z.step = function(){ 
        var t = (new Date).getTime(); 
        var p = (t - z.t) / duration; 
        if (t >= duration + z.t) { 
            z.clear(); 
            window.setTimeout(function(){z.scroll(z.p.y, z.p.x)},13); 
        } else { 
            st = ((-Math.cos(p*Math.PI)/2) + 0.5) * (z.p.y-z.s.t) + z.s.t; 
            sl = ((-Math.cos(p*Math.PI)/2) + 0.5) * (z.p.x-z.s.l) + z.s.l; 
            z.scroll(st, sl); 
        } 
    }; 
    z.scroll = function (t, l){window.scrollTo(l, t)}; 
    z.timer = window.setInterval(function(){z.step();},13); 
}

function randNum(n){
	var rnd="";
	for(var i=0;i<n;i++){
		rnd+=Math.floor(Math.random()*10);
	}
	return rnd;
}

function getMobileYzm(mobile,n){
	var rnd="";
	mobile=String(mobile);
	for(var i=0;i<n;i=i+2){
		var r=Math.floor(Math.random()*10);
		r=String(r);
		rnd+=r+String(mobile.charAt(r));
	}
	return rnd;
}

function iframe(url,width,height){
	document.write('<iframe id="testframe" scrolling="no" src="'+url+'" width="'+width+'" height="'+height+'" frameborder="0"></iframe>');
}

/*获取模板函数*/
function getTpl(_function){
	var tpl=_function.toString();
	tpl=tpl.replace(/function\s*\w+\s*\(\)\s*{\/\*/,'').replace(/\*\/;}$/,'');
	return tpl;
	//alert(tpl.match(/^[\w]+\snav_tpl\(\)\{\s+\/\*([\w\s*\/\\<>'"=#;:$.()]+)\*\/\s+\}$/i)[1]);
}

function getFuncName(_callee) {
	var ie = !-[1,];
	if(ie==true){
		var _text = _callee.toString();
		return _text.match(/^function\s*(\w+)\s*\(/)[1];
	}
	else{
		return _callee.prototype.constructor.name;
	}
}

/*循环对象模板*/
function getTplObj(tplName,obj){
	var tpl=getTpl(tplName);
	var _tpl='';
	var str='';
	
	if(typeof obj[0]=='undefined'){
		_tpl=tpl;
		for(var j in obj){
			var pattern = "\{\\$"+j+"\}";
			var reg = new RegExp(pattern, "g");
			_tpl=_tpl.replace(reg,obj[j]);
		}
		return _tpl;
	}
	else{
		for(i in obj){
			_tpl=tpl;
			for(var j in obj[i]){
				var pattern = "\{\\$"+j+"\}";
				var reg = new RegExp(pattern, "g");
				_tpl=_tpl.replace(reg,obj[i][j]);
			}
			str+=_tpl;
		}
		return str;
	}
}

$.fn.focusClear = function(tag) {
	tag=tag||'';
	inputFocusTime=0;
	$(this).focus(function(){//alert(inputFocusTime);
		$(this).attr('hasClick',1);
		if(new Date().getTime()-inputFocusTime>100){$(this).val('');inputFocusTime=0;}
	});
	$(this)[0].onpaste=function(){
		inputFocusTime=new Date().getTime();
	}
}

function checkSubFrom(input,word){
	word=word||'请输入查询内容！';
	var $input=$(input);
	var moren=$input.attr('moren');
	if($input.val()=='' || $input.attr('hasClick')!=1){
		if(moren==''){
			alert(word);
			return false;
		}
		else{
			$input.val(moren);
		}
	}
}

if(typeof getCookie('userlogininfo')!='undefined'){
	IS_LOGIN=1;
}
else{
	IS_LOGIN=0;
}

if(!-[1,]==true){
	IE=1;
}
else{
	IE=0;
}

function tao_perfect_click($t){
	u=$t.attr('href').replace(/&rf=[\w-%\.]+&/,'&rf='+encodeURIComponent(SITEURL)+'&');
	setCookie('tao_click_url',u,30);
	var url=$t.attr('a_jump_click');
	if(URL_COOKIE==0){
		url+='&url='+encodeURIComponent(u);
	}
	$t.attr('href',url);
	return true;
}

(function(a) {
	a.fn.sidebar = function(b) {
		b = a.extend({
			min: 1,
			fadeSpeed: 200,
			position: "bottom",
			ieOffset: 10,
			anchorOffset: 0,
			relative: false,
			relativeWidth: 960,
			backToTop: false,
			backContainer: "#backToTop",
			smooth: ".smooth",
			overlay: false,
			once: false,
			load: false,
			onShow: null
		},
		b);
		return this.each(function() {
			var i = a(this),
			m = a.browser,
			c = a(window),
			d = a(document),
			h = a("body, html"),
			l = b.fadeSpeed,
			f = (c.height() == d.height()) && !b.backToTop;
			var e = function() {
				if ( !! window.activeXObject && !window.XMLHttpRequest) {
					i.css({
						position: "absolute"
					});
					if (b.position == "bottom") {
						i.css({
							top: c.scrollTop() + c.height() - i.height() - b.ieOffset
						})
					}
					if (b.position == "top") {
						i.css({
							top: c.scrollTop() + b.ieOffset
						})
					}
				}
				if (!b.load && c.scrollTop() >= b.min || f) {
					i.fadeIn(l);
					if (typeof(b.onShow) === "function") {
						b.onShow()
					}
				} else {
					if (!b.once) {
						i.fadeOut(l)
					}
				}
			};
			if (b.min == 0 || f) {
				e()
			}
			c.on("scroll.sidebar",
			function() {
				e()
			});
			if (b.relative) {
				var k = b.relativeWidth,
				g = i.width(),
				j = (c.width() + k) / 2;
				i.css("left", j);
				c.on("resize.sidebar scroll.sidebar",
				function() {
					var n = c.width();
					if (b.overlay) {
						j = (n - g * 2 > k) ? ((n + k) / 2) : (n - g)
					} else {
						j = (n + k) / 2
					}
					i.css("left", j)
				})
			}
			if (b.backToTop) {
				a(b.backContainer).click(function() {
					h.animate({
						scrollTop: 0
					},
					100);
					return false
				})
			}
			i.find(b.smooth).click(function() {
				h.animate({
					scrollTop: a(a(this).attr("href")).offset().top - b.anchorOffset
				},
				100);
				return false
			})
		})
	}
})(jQuery);

(function(a) {
	a.fn.sticky = function(b) {
		b = a.extend({
			min: 1,
			max: null,
			top: 0,
			stickyClass: "stickybox",
			zIndex: 999
		},
		b);
		return this.each(function() {
			var d = a(this),
			c = a.browser,
			e = a(window),
			g = !!window.activeXObject && !window.XMLHttpRequest;
			function f() {
				var h = e.scrollTop();
				if ((b.max == null && h >= b.min) || (b.max != null && h >= b.min && h < b.max)) {
					d.addClass(b.stickyClass);
					if (!g) {
						d.css({
							position: "fixed",
							top: b.top,
							"z-index": b.zIndex
						})
					} else {
						d.css({
							position: "absolute",
							top: e.scrollTop(),
							"z-index": b.zIndex
						})
					}
				} else {
					d.removeClass(b.stickyClass).removeAttr("style")
				}
			}
			e.on("scroll.sticky",
			function() {
				f()
			})
		})
	}
})(jQuery);

function urlencode(str){
	return encodeURIComponent(str);
}

function closeAd($t,fun){
	var $p=$t.parents('div.yunad');
	var id=$p.attr('id');
	$p.css('height',0);
	$p.find('#ad_a').hide();
	$p.find('#ad_b').show();
	if(fun){fun();}
	setCookie(id+'Close',1);
}

function openAd($t,fun){
	var $p=$t.parents('div.yunad');
	var h=$t.attr('h');
	$p.css('height',h);
	$p.find('#ad_a').show();
	$p.find('#ad_b').hide();
	if(fun){fun();}
}

function erweima_api(str){
	return SITEURL+'api/qrcode.php?id='+str;
}

function openCenterDiv(html,width,height){
	width=width||400;
	height=height||200;
	var width_2=width/2;
	var height_2=height/2;
	var bodyHeight=$('body').height();
	//html=html.replace(/'/,'\'');
	$("body").append('<div onclick="closeCenterDiv()" id="center-div-ground" style="position:absolute;left:0px;top:0px;width:100%;height:'+bodyHeight+'px;background:#000;filter:alpha(opacity=40);opacity:0.40;z-index:9998;display:;"></div><div id="center-div" style="margin-left:-'+width_2+'px;left:50%;margin-top:-'+height_2+'px;top:45%;width:'+width+'px;height:'+height+'px;z-index:9999;position:fixed!important;/*FF IE7*/position:absolute;/*IE6*/background:#FFF;display:;">'+html+'</div>');
}

function closeCenterDiv(){
	$('#center-div-ground').remove();
	$('#center-div').remove();
}
/*js/fun.js*/
/*
 * Lazy Load - jQuery plugin for lazy loading images
 *
 * Copyright (c) 2007-2012 Mika Tuupola {ADDONVAR}
 *
 * Licensed under the MIT license:
 *   http://www.opensource.org/licenses/mit-license.php
 *
 * Project home:
 *   http://www.appelsiini.net/projects/lazyload
 *
 * Version:  1.7.2
 *
 */
(function(a,b){$window=a(b),a.fn.lazyload=function(c){function f(){var b=0;d.each(function(){var c=a(this);if(e.skip_invisible&&!c.is(":visible"))return;if(!a.abovethetop(this,e)&&!a.leftofbegin(this,e))if(!a.belowthefold(this,e)&&!a.rightoffold(this,e))c.trigger("appear");else if(++b>e.failure_limit)return!1})}var d=this,e={threshold:0,failure_limit:0,event:"scroll",effect:"show",container:b,data_attribute:"original",skip_invisible:!0,appear:null,load:null};return c&&(undefined!==c.failurelimit&&(c.failure_limit=c.failurelimit,delete c.failurelimit),undefined!==c.effectspeed&&(c.effect_speed=c.effectspeed,delete c.effectspeed),a.extend(e,c)),$container=e.container===undefined||e.container===b?$window:a(e.container),0===e.event.indexOf("scroll")&&$container.bind(e.event,function(a){return f()}),this.each(function(){var b=this,c=a(b);b.loaded=!1,c.one("appear",function(){if(!this.loaded){if(e.appear){var f=d.length;e.appear.call(b,f,e)}a("<img />").bind("load",function(){c.hide().attr("src",c.data(e.data_attribute))[e.effect](e.effect_speed),b.loaded=!0;var f=a.grep(d,function(a){return!a.loaded});d=a(f);if(e.load){var g=d.length;e.load.call(b,g,e)}}).attr("src",c.data(e.data_attribute))}}),0!==e.event.indexOf("scroll")&&c.bind(e.event,function(a){b.loaded||c.trigger("appear")})}),$window.bind("resize",function(a){f()}),f(),this},a.belowthefold=function(c,d){var e;return d.container===undefined||d.container===b?e=$window.height()+$window.scrollTop():e=$container.offset().top+$container.height(),e<=a(c).offset().top-d.threshold},a.rightoffold=function(c,d){var e;return d.container===undefined||d.container===b?e=$window.width()+$window.scrollLeft():e=$container.offset().left+$container.width(),e<=a(c).offset().left-d.threshold},a.abovethetop=function(c,d){var e;return d.container===undefined||d.container===b?e=$window.scrollTop():e=$container.offset().top,e>=a(c).offset().top+d.threshold+a(c).height()},a.leftofbegin=function(c,d){var e;return d.container===undefined||d.container===b?e=$window.scrollLeft():e=$container.offset().left,e>=a(c).offset().left+d.threshold+a(c).width()},a.inviewport=function(b,c){return!a.rightofscreen(b,c)&&!a.leftofscreen(b,c)&&!a.belowthefold(b,c)&&!a.abovethetop(b,c)},a.extend(a.expr[":"],{"below-the-fold":function(c){return a.belowthefold(c,{threshold:0,container:b})},"above-the-top":function(c){return!a.belowthefold(c,{threshold:0,container:b})},"right-of-screen":function(c){return a.rightoffold(c,{threshold:0,container:b})},"left-of-screen":function(c){return!a.rightoffold(c,{threshold:0,container:b})},"in-viewport":function(c){return!a.inviewport(c,{threshold:0,container:b})},"above-the-fold":function(c){return!a.belowthefold(c,{threshold:0,container:b})},"right-of-fold":function(c){return a.rightoffold(c,{threshold:0,container:b})},"left-of-fold":function(c){return!a.rightoffold(c,{threshold:0,container:b})}})})(jQuery,window)

/*template/jiukuaiyou/js/lazyload.js*/
$(document).ready(function(){
    $("#dosign:last,#opsign").live({
        mouseover:function(){
            $("#opsign").show();
        },
        mouseout:function(){
            $("#opsign").hide();
        }
    })

    $("#dokefu:last,#opkefu").live({
        mouseover:function(){
            $("#opkefu").show();
        },
        mouseout:function(){
            $("#opkefu").hide();
        }
    })

	$(".have_child").hover(function() {
        $(this).find("a").eq(0).addClass("current").removeClass("");
        $(this).find('.top_menu').show();
    },
    function() {
        $(this).find("a").eq(0).addClass("").removeClass("current");
		$(this).find('.top_menu').hide();
    });
});

function formatFloat(src, pos){
	return Math.round(src*Math.pow(10, pos))/Math.pow(10, pos);
}

/*收藏*/
function AddFavorite(b) {
	CloseNLRAF(true);
	var c = null;
	if (b == "childreTop") {
		var c = SITEURL;
	} else {
		if (b == "welcomefavorite") {
			var c = SITEURL+"?from=fav"
		} else {
			var c = location.href + (b == true ? "?from=topfavorite": "")
		}
	}
	if ($.browser.msie) {
		try {
			window.external.addFavorite(c, ""+WEBNAME+"-省钱，从"+WEBNAME+"开始。")
		} catch(a) {
			alert("请按键盘 CTRL键 + D 收藏"+WEBNAME+"")
		}
	} else {
		if ($.browser.mozilla) {
			try {
				window.sidebar.addPanel(""+WEBNAME+"-网购，从"+WEBNAME+"开始。", c, "")
			} catch(a) {
				alert("请按键盘 CTRL键 + D 收藏"+WEBNAME+"")
			}
		} else {
			alert("请按键盘 CTRL键 + D 收藏"+WEBNAME+"")
		}
	}
	return false
}

function SetHome(url){
	if (document.all) {
		document.body.style.behavior='url(#default#homepage)';
		document.body.setHomePage(url);
	}else{ 
		alert("您好,您的浏览器不支持自动设置页面为首页功能,请您手动在浏览器里设置该页面为首页!"); 
	} 
}

function CloseNLRAF() {
	setCookie("NLRAF",1);
	$("#afp").slideUp()
}

function zhidemaiLazyLoad($t){
	$t=$t||$('#zhidemaiDiv');
	var $obj=$t.find("img.lazy");
	var $cobj=$t.find('.J-item-content-inner');
	$obj.lazyload({
		threshold:20,
		failure_limit:50,
		effect : "fadeIn"
	});
	
	$cobj.each(function(){
		var $t=$(this).parent('.nodelog-detail');
		if($(this).height()>200){
			$t.next('.item-toggle').find('a').show();
		}
	});
}

$(function(){
	//图片懒加载
	$('img.lazy').lazyload({
		threshold:200,
		failure_limit:40,
		effect : "fadeIn"
	});

	//顶部弹出收藏
	if (!getCookie("NLRAF") && !/favorite|desk|zt11/.test(location.search)) {
		if (!$("#afp").length) {
			$("body").prepend('<div id="afp" style="display:none;"><div class="afpc"><p>网购，不要忘了用'+WEBNAME+'省钱哦，您可以把'+WEBNAME+'：<a id="af" class="afpa" href="javascript:void(0)" onclick="AddFavorite(true)">加入收藏夹</a><a href="'+SITEURL+'comm/shortcut.php" class="desktop">添加到桌面</a></p></div><div class="close_area"><label id="nlraf" onclick="CloseNLRAF(true)" for="check_nlraf"><input type="checkbox" id="check_nlraf" />不再提醒</label><a id="cafp" href="javascript:void(0)" onclick="CloseNLRAF(false)"></a></div></div>')
		}
		$("#afp").slideDown("slow")
	}

	//跟随滚动
	var F_scroll_lr = function(){
		var ele_fix = $("#lr_float");
		var _main = $(".main");
		if (ele_fix.length > 0) {
			var ele_offset_top = ele_fix.offset().top;
			$(window).scroll(function() {
				var scro_top = $(this).scrollTop();
				var test = ele_offset_top + scro_top;
				var fix_foot_pos = parseInt(ele_fix.height()) + parseInt(scro_top);
				var mainpos = parseInt(_main.offset().top) + parseInt(_main.height());
				if (scro_top <= ele_offset_top && fix_foot_pos < mainpos) {
					ele_fix.css({
						position: "static",
						top: "0"
					});
				} else if (scro_top > ele_offset_top && fix_foot_pos < mainpos) {
					ele_fix.css({
						"position": "fixed",
						"top": "0"
					});
				} else if (scro_top > ele_offset_top && fix_foot_pos > mainpos) {
					var posi = mainpos - fix_foot_pos;
					ele_fix.css({
						position: "fixed",
						top: posi
					});
				}
			});
		}
	}
	
	/*底部滚动*/
	var F_scroll_pics = function(){
    	var sWidth = $(".slide-img").width();
    	var len = $("#ft-box li").length;
    	var index = 0;
    	var picsScrollTimer;

    	var leftBtnClickEvt = function(){
        	$(".left-cur").on("click" , function () {
            	index -= 1;
            	if (index == -1) { index = len - 1; }
            	showPics(index);
            	addOrRemoveBtnsClass();
        	});
    	}
    
    	var rightBtnClickEvt = function(){
        	$(".right-cur").on("click" , function () {
            	index += 1;
            	if (index == len) { index = 0; }
            	showPics(index);
            	addOrRemoveBtnsClass();
        	});
    	}
   
    	$("#ft-box").css("width", sWidth * (len));
    
    	$(".wechat").hover(function () {
        	clearInterval(picsScrollTimer);
    	}, function () {
        	picsScrollTimer = setInterval(function () {
            	showPics(index);
            	addOrRemoveBtnsClass();
            	index++;
            	if (index == len) { index = 0; }
        	}, 3000);
    	}).trigger("mouseleave");
    

    	var initBtnClickEvt = function(){
        	leftBtnClickEvt();
        	rightBtnClickEvt();
        	addRightBtnClass();
    	}

    	function addRightBtnClass() {
        	$(".right-cur").addClass("right-unactive");
        	$(".right-unactive").unbind("click");
    	}

    	function addLeftBtnClass(){
        	$(".left-cur").addClass("left-unactive");
        	$(".left-unactive").unbind("click");
    	}

    	function removeRightBtnClass(){
        	$(".right-cur").removeClass("right-unactive");
        	$(".right-cur").on("click" , rightBtnClickEvt());
    	}

    	function removeLeftBtnClass(){
        	$(".left-cur").removeClass("left-unactive");
        	$(".left-cur").on("click" , leftBtnClickEvt());
    	}
    
    	function addOrRemoveBtnsClass(){
        	if(index == 0){
             	addRightBtnClass();
             	removeLeftBtnClass();
        	}else{  
            	removeRightBtnClass();           
            	addLeftBtnClass();        
        	}
    	}
    
    	function showPics(index) {
        	var nowLeft = -index * sWidth;
        	$("#ft-box").stop(true, false).animate({ "left": nowLeft }, 300);
    	}
    	initBtnClickEvt();
    }

	//左侧浮动导航
    var $navFun = function() {
        var st = $(document).scrollTop(), 
            headt = $("div.header_top_bg").height(),           
            headi = $("div.jiu-nav-main").height(),           
            headh = headt+headi,           
            $nav_classify = $("div.jiu-side-nav,div.side_nav");
            $nav_classify_logo = $(".jiu-side-nav .logo,.side_nav .logo");
            $nav_gotop = $(".side_right .go-top");

        if(st > headh){
			$nav_gotop.fadeIn()
            $nav_classify.addClass("fixed");
 			$nav_classify_logo.slideDown()
       } else {
			$nav_gotop.fadeOut()
            $nav_classify.removeClass("fixed");
			$nav_classify_logo.slideUp()
        }
    };

    var F_nav_scroll = function () {
        if (!window.XMLHttpRequest) {
           return;          
        }else{
            //默认执行一次
            $navFun();
            $(window).bind("scroll", $navFun);
        }
    }

    var F_top = function(){
        $('body,html').animate({scrollTop:0},500);
    }
    $('a.go-top').on('click',F_top)

	F_scroll_lr();
    F_nav_scroll();
	F_scroll_pics();
});

//浏览记录
jQuery(document).ready(function($) {
	$seeLog = $('.history_list');
	var size = $('.history_list ul li[index!=""]').size();
	$seeLog.css('height', Math.min(size * 100 + 80, 580) + 'px');
	$('.history_list ul').css('height', Math.min(size * 100 + 50, 560 - 50) + 'px');
	window.foot_show_history = function() {
		var bh_arr_cnt = $('.history_list ul li[index!=""]').size();
		if (bh_arr_cnt <= 0) {
			return;
		}
		$seeLog.animate({height: "toggle"},{
			duration: "fast",
			complete: function() {
			}
		});
		$('.history').toggleClass("big").hide().animate({height: "toggle"},{
			duration: "fast",
			complete: function() {}
		});
	};
	$('.history').click(window.foot_show_history);

	// 判断点击区域 隐藏/显示其他区域
	$(document).click(function(e) {
		e = window.event || e;
		// 兼容IE7
		obj = $(e.srcElement || e.target);
		if (!obj.is('.history_list') && !obj.is('.history_list *') && !obj.is('.history') && !obj.is('.history *') && $('.history_list').css('display') == 'block' && !obj.is('a') && !obj.is('a *')) {
			window.foot_show_history();
		}
	});

	$seeLog.find('.guanbi').click(function() {
		window.foot_show_history();
	});

	$('.history_list ul li').mouseenter(function() {
		$(this).children('.close').show();
	}).mouseleave(function() {
		$(this).children('.close').hide();
	});

	$('.history_list ul li .close').click(function() {
		$t = $(this);
		var index = $t.parent('li').attr('index');
		var $a = $t.parent('li').parent('ul').parent('div').prev('.history').find('span.txt3');
		var data = {'index': index};
		$.get('plugin/zhe/ajax.php?do=delseelog', data, 
		function() {
			$t.parent('li').slideUp(200);
			$a.html(parseInt($a.html()) - 1);
		});
	});
	$seeLog.find('.qingkong').click(function() {
		var data = {'index': -1};
		$.get('plugin/zhe/ajax.php?do=delseelog', data, 
		function() {
			$seeLog.find('ul').hide('slow');
			$('.history').find('span.txt3').html(0);
		});
	});
});
/*template/jiukuaiyou/js/fun.js*/
function addJumpBoxDom(o){
	$('#ddjumpboxdom').html('<div class="alert_fullbg" id="LightBox"></div><div class="alert_bg alert_report" id="'+o.id+'" show="0"><div class="alert_box"><div class="alert_top"><span class="title"></span><a class="close" href="javascript:;"></a></div><div class="alert_content">内容加载中。。。。。。</div></div>');
}
function jumpBoxInitialize(o){
    o.titleWord = o.title;
    $('#' + o.id + ' .title').html(o.titleWord);
    $('#' + o.id + ' .alert_content').css('height', o.height-40);
    $('#' + o.id + ' .alert_content').css('width', o.width-40);
	$('#' + o.id).css('width', o.width).css('margin-left', '-' + (o.width / 2+6) + 'px');
    $('#' + o.id).attr('show', 1);
    g1 = (getClientHeight() - o.height) / 2-16;
    g2 = g1 / getClientHeight();
    g2 = Math.round(g2 * 100) - 1;
    $('#' + o.id).css('top', g2 + '%');
	$('.alert_fullbg').css('height',document.body.scrollHeight);
	if ($.browser.msie && $.browser.version == "6.0") {	
		default_top1=document.documentElement.scrollTop+150+"px";
		$("#"+o.id).css("top",default_top1);
		$(window).scroll(function() {
			default_top2=document.documentElement.scrollTop+150+"px";
			$("#"+o.id).css("top",default_top2);	
		})
	}
}

// JavaScript Document
// 创建一个闭包  
(function($) {
    // 插件的定义  
    $.fn.jumpBox = function(options) {
        debug(this);
        // build main options before element iteration  
        var opts = $.extend({},
        $.fn.jumpBox.defaults, options);
        // iterate and reformat each matched element  
        $('body').click(mouseLocation);
        function mouseLocation(e) {
            if (opts.easyClose == 1 && $('#' + opts.id).attr('show') == 1) {
                rightk = (document.body.offsetWidth - 950) / 2;
                rightw = (950 - opts.width) / 2;
                toright = rightk + rightw;
                totop = $('#' + opts.id).attr("offsetTop");
                if (e.pageX < toright || e.pageX > toright + opts.width || e.pageY < totop || e.pageY > totop + opts.height) {
                    $('#' + opts.id + ' .close').click();
                }
            }
        }

        return this.each(function() {
            $this = $(this);
            // build element specific options  
            var o = $.meta ? $.extend({},
            opts, $this.data()) : opts;
            // update element styles   
            /*if(o.debug==1){
	    $.fn.jumpBox.initialize(o);
	  }*/
            $this[o.method](o.bind,function(event) {  // $this[o.method](o.event,function(event) {
				$('#ddjumpboxdom').html('');
				re=1;
				if (o.reg != '') {
                    re =eval(o.reg);
                }
				if(re==2){
				    return false;
				}

                if (re==1) {
					if(o.defaultContain == 0){
					    $.fn.jumpBox.load(o);
					}

					$('select').hide();
					$('#'+o.id+' select').show();
                    if (o.button == 1) {
                        $(this).attr('disabled', true);
                    }
				    $.fn.jumpBox.initialize(o);

				    ajaxUrl = $(this).attr('href');
                    word = $(this).attr('word');
                    contain = o.contain;
				    $content=$('#' + o.id + ' .alert_content');

                    if (o.jsCode != '') {
                        eval(o.jsCode);
                    }

                    if (ajaxUrl != '' && ajaxUrl != undefined && o.a == 0) {
                        if(o.jsonp==0){
							$.post(ajaxUrl, function(data) {
                            	$('#' + o.id + ' .alert_content').html(data);
                        	});
						}
                        else{
							$.ajax({
								type:'get',
								url:ajaxUrl,
								dataType:'jsonp',
								jsonp:"callback",
								success:function(data){
									$('#' + o.id + ' .alert_content').html(data.r);
								}
							});
						}
                    } else if (word != '' && word != undefined) {
                        $('#' + o.id + ' .alert_content').html(word);
                    } else if (o.contain != '') {
                        $('#' + o.id + ' .alert_content').html(contain);
                    }
                    $('#' + o.id).show();
                    if (o.LightBox == 'show') {
                        bodyHeight = document.body.scrollHeight;
                        $('#LightBox').css('height', bodyHeight);
                        $('#LightBox').show();
                    }

                    if (o.jsCode2 != '') {
                        eval(o.jsCode2);
                    }

                    if (o.jsScript != '') {
                        $.getScript(o.jsScript);
                    }
                }

                event.stopPropagation();

                if (o.a == 0) {
                    return false;
                }
            });
			
            $.fn.jumpBox.close(o, $(this));

            //var markup = $this.html();  
            //markup = $.fn.hilight.format(markup);  
            //$this.html(markup);  
        });
    };
    // 私有函数：debugging  
    function debug($obj) {
        if (window.console && window.console.log) window.console.log('hilight selection count: ' + $obj.size());
    };

    //初始化div
    $.fn.jumpBox.initialize = function(o) {
        jumpBoxInitialize(o);
    }
    //定义加载dom函数  
    $.fn.jumpBox.load = function(o) {
		addJumpBoxDom(o); 
    };
    //关闭弹出层
    $.fn.jumpBox.close = function(o, t) {
        cl = '#' + o.id + ' .close';
        ob = '#' + o.id;
        $(cl).live('click',
        function() {
            $(ob).hide();
            $('#LightBox,#jumpbox').hide();
            $('select').show();
            $(ob).attr('show', 0);
            if (o.button == 1) {
                t.attr('disabled', false);
            }
        })
    };
    // 插件的defaults  
    $.fn.jumpBox.defaults = {
        id: 'jumpbox',
        title: '',
        titlebg: 0,
        contain: '',
        jsCode: '',
        jsCode2: '',
        jsScript: '',
        LightBox: 'none',
        a: 0,
        easyClose: 0,
        button: 0,
        height: 300,
        width: 576,
        defaultContain: 0,
		bind:'click',
		background:'',
		reg:'',
		jsonp:0,
		method:'bind'
    };
    // 闭包结束  
})(jQuery);
$(function(){
    $("body").append('<div id="ddjumpboxdom"></div>');
});
function jumpboxClose(){
    $('#LightBox,#jumpbox').hide();
}
function jumpboxOpen(contain,height,width,title){
	var domObject=new Object();
	domObject.id='jumpbox2';
	domObject.title=title;
	domObject.titlebg=0;
	domObject.height=height;
	domObject.width=width;
	domObject.background='';
	addJumpBoxDom(domObject); 
	jumpBoxInitialize(domObject);
	$('#LightBox,#jumpbox2').show();
	$(".close").on("click",function(){
		$('#LightBox,#jumpbox2').hide();
	})
	if(contain!=''){
		$('#' + domObject.id + ' .alert_content').html(contain);
	}
}
/*template/jiukuaiyou/js/jumpbox.js*/
$(function(){
	var word = '';
	var timeoutid = null;
	dataUrl="http://suggest.taobao.com/sug?q=";
	if (!getCookie("NLRAF")) {
		var topOffset=57;
	}
	else{
		var topOffset=19;
	}
	var leftOffset=0;
	inputId='s-txt'; //输入框ID
	$inputId=$('#'+inputId);
	var left=$inputId.offset().left+leftOffset;
	var top=$inputId.height()+$inputId.offset().top+topOffset;
	width=417;//$inputId.width();  //搜索框长度
	taobaokeytips='taobaokeytips'; //提示层id
	$inputId.attr('autocomplete','off');
	$("body").append('<div id="'+taobaokeytips+'"></div>'); //添加容器
    $('#'+taobaokeytips).css('left',left+'px').css('top',top+'px').css('width',width+'px');
	var txt=$("#s-txt").attr('placeholder');
	$("#s-txt").attr('value',txt);
    $('#s-txt').click(function(){
		var q=$("#s-txt").val();
		if(q==txt){
			$("#s-txt").attr('value','');
		}
		if(q!=txt && q!=''){
			autocomplete();
		}
	});
   /*$('body').keydown(function(){
	    if(event.keyCode==13){
		    if($('#'+taobaokeytips).css('display')=='block'){
				return false;
			}
			else{
			    return true;
			}
		}
	});*/
	$('#s-txt').blur(function(){
		var q=$("#s-txt").val();
		if(q==''){
			$("#s-txt").attr('value',txt);
		}
	});
	$("#"+inputId).keyup(function(event){
		var mod=$('#mod').val();
		var app=$('#app').val();
		var neword = $(this).attr("value");
		var word=inArray(neword,noWordArr);
		if(word!=''){
			return false;
		}
		
		if(neword=='' || neword.indexOf("http://") >= 0 ){      
    		return false;  
		} 

		var myEvent = event || window.event; 
		var keyCode = myEvent.keyCode;              //获得键值
		switch(keyCode){
			case 38 : //按了上键  
				if($("#"+taobaokeytips).css("display") == "block"){       
					var arr = $("#"+taobaokeytips+" li").filter(".current");
					if(arr.length != 0){
						var index = $("#"+taobaokeytips+" li").index(arr[0]);
						var shangcheng_id = $("#"+taobaokeytips+" li").eq(index-1).attr("id");
						if(shangcheng_id>0){
							document.getElementById("mod").value = 'mall'; 
							document.getElementById("app").value = 'view';
							document.getElementById("id").value = shangcheng_id; 
							document.formname.action = 'index.php';   
						}else{
							document.formname.action = 'index.php'; 
							document.getElementById("mod").value = $("#"+taobaokeytips+" li").eq(index-1).attr("mod");
							document.getElementById("app").value = $("#"+taobaokeytips+" li").eq(index-1).attr("app");
						}
						switch(index){
							case 0:
								$("#"+taobaokeytips+" li").eq(index).removeClass("current");
							break;
							default:
								$("#"+taobaokeytips+" li").eq(index).removeClass("current");
								
								$("#"+taobaokeytips+" li").eq(index-1).addClass("current");	
						}
					}
					else{
						var shangcheng_id = $("#"+taobaokeytips+" li").eq(length-1).attr("id");
						if(shangcheng_id>0){
							document.getElementById("mod").value = 'mall'; 
							document.getElementById("app").value = 'view';
							document.getElementById("id").value = shangcheng_id; 
							document.formname.action = 'index.php';
						}else{
							document.formname.action = 'index.php'; 
							document.getElementById("mod").value = $("#"+taobaokeytips+" li").eq(length-1).attr("mod");
							document.getElementById("app").value = $("#"+taobaokeytips+" li").eq(length-1).attr("app");
						}
						$("#"+taobaokeytips+" li").eq($("#"+taobaokeytips+" li").length-1).addClass("current");
					}
				}else{autocomplete()};
				break;
			case 40 : //按了下键
				
				if($("#"+taobaokeytips).css("display") == "block"){ 
					var arr = $("#"+taobaokeytips+" li").filter(".current");
					if(arr.length != 0){
						var index = $("#"+taobaokeytips+" li").index(arr[0]);
						var shangcheng_id = $("#"+taobaokeytips+" li").eq(index+1).attr("id");
						if(shangcheng_id>0){
							document.getElementById("mod").value = 'mall'; 
							document.getElementById("app").value = 'view';
							document.getElementById("id").value = shangcheng_id;
							document.formname.action = 'index.php';   
						}else{
							document.formname.action = 'index.php'; 
							document.getElementById("mod").value = $("#"+taobaokeytips+" li").eq(index+1).attr("mod");
							document.getElementById("app").value = $("#"+taobaokeytips+" li").eq(index+1).attr("app");
						}
						switch(index){
							case $("#"+taobaokeytips+" li").length-1:
								
								$("#"+taobaokeytips+" li").eq(index).removeClass("current");
								
							break;
							default:
								$("#"+taobaokeytips+" li").eq(index).removeClass("current");
								
								$("#"+taobaokeytips+" li").eq(index+1).addClass("current");	
						}
					}
					else{
						var shangcheng_id = $("#"+taobaokeytips+" li").eq(0).attr("id");
						if(shangcheng_id>0){
							document.getElementById("mod").value = 'mall'; 
							document.getElementById("app").value = 'view';
							document.getElementById("id").value = shangcheng_id;
							document.formname.action = 'index.php';   
						}else{
							document.formname.action = 'index.php'; 
							document.getElementById("mod").value = $("#"+taobaokeytips+" li").eq(0).attr("mod");
							document.getElementById("app").value = $("#"+taobaokeytips+" li").eq(0).attr("app");
						}
						$("#"+taobaokeytips+" li").eq(0).addClass("current");
					}
				} else { autocomplete() };
				
				break;
			case 13 : //按了回车
				if($('#'+taobaokeytips).css("display") == "block"){ 
					var arr = $("#"+taobaokeytips+" li").filter(".current");
					arr.click();
					if(arr.length != 0){
						var index = $("#"+taobaokeytips+" li").index(arr[0]);
						$('#'+taobaokeytips).css("display","none");
					};
				}else{if(neword != word)autocomplete()}
				break;
			default:
				if (neword != "" && neword != word) {
					clearTimeout(timeoutid); //取消上次未完成的延时操作					
					//500ms后执行，执行一次
					timeoutid = setTimeout(function(){
						var url = dataUrl + neword + "&code=utf-8&callback=callback"
						var s = document.createElement("script"); 
						s.setAttribute("src", url);
						s.setAttribute("id", "GetOrder");
						document.getElementsByTagName("head")[0].appendChild(s);
						word = neword;
					},300)
				} else { $('#'+taobaokeytips).css("display","none");word = neword; }
			}
	})
	//---------------------------------------------------------------------------------------------
	
	$("body").bind("click",function(event){     var element = event.target;    if(element.id != 's-txt'){ setTimeout(function(){$('#'+taobaokeytips).css("display","none")},100)}})
	
	function autocomplete(){
		var neword = $("#"+inputId).attr("value");
		var url = dataUrl + neword + "&code=utf-8&callback=callback"
		var s = document.createElement("script"); 
		s.setAttribute("src", url);
		s.setAttribute("id", "GetOrder");
		document.getElementsByTagName("head")[0].appendChild(s);
		word = neword;
		var children = document.getElementById("GetOrder");
		var parent = children.parentNode;
		parent.removeChild(children);
	}
});

function callback(a){
	var key = $('#s-txt').val();
	var str = "";
	var url = '';
	$.ajax({
		url: u('ajax','callback_search'),
		data:{'q':key},
		dataType:'jsonp',
		type: "GET",
		jsonp:"callback",
		success: function(data){
			key_1 = '【<b class="org_3">'+key+'</b>】';
			for(var i in data){	
				str += "<li><a href='index.php?mod=mall&app=view&id="+data[i]['id']+"' target='_blank'><span class='fl pl20'><img src=\""+data[i]['img']+"\"><span class='ml10'>" + data[i]['title'] + "</span></span><span class='fr mr20'>最高返利"+data[i]['fan']+"</span></li>";
			}
			for(var k in sousuoxiala){
				str += "<li mod='"+sousuoxiala[k][0]+"' app='"+sousuoxiala[k][1]+"'><a class='ml10' href='index.php?mod="+sousuoxiala[k][0]+"&app="+sousuoxiala[k][1]+"&q="+encodeURIComponent(key)+"' target='_blank'> 搜 "+ key_1 +" "+sousuoxiala[k][2]+"</a></li>";
			}
			//str += "<li onclick=\"javascript:window.location.href='index.php?mod=mall&app=goods&q="+encodeURIComponent(key)+"'\" class='li_border'><a href=index.php?mod=mall&app=goods&q="+encodeURIComponent(k target="" style='margin-left:10px'> 搜" + key_1 + " 全网比价</a></li>";
			//	str += "<li onclick=\"javascript:window.location.href='index.php?mod=paipai&app=list&q="+encodeURIComponent(key)+"'\" class='li_border'><a style='margin-left:10px'> 搜" + key_1  + " 相关拍拍宝贝</a></li>";
			//	str += "<div id='s8_tao'><li onclick=\"javascript:window.location.href='index.php?mod=tao&app=view&q="+encodeURIComponent(key)+"'\" class='li_border'><a style='margin-left:10px'> 搜" + key_1  + " 相关淘宝宝贝</a></li></div>";
			$('#'+taobaokeytips).html('<ul>'+str+'</ul>');
			$('#'+taobaokeytips).show();
		}
	});
}
/*template/jiukuaiyou/js/taokey.js*/
errorArr=new Array();
errorArr[1]='用户名不合法';
errorArr[2]='包含非法词汇';
errorArr[3]='密码位数错误或包含非法字符';
errorArr[4]='账号密码错误';
errorArr[5]='验证码错误';
errorArr[6]='用户名已存在';
errorArr[7]='邮箱格式错误';
errorArr[8]='邮箱已存在';
errorArr[9]='QQ格式错误';
errorArr[10]='您还没有登陆';
errorArr[11]='缺少必要参数';
errorArr[12]='每日每个商城只能评论一次';
errorArr[13]='该邮箱不存在';
errorArr[14]='数据超时，请重新尝试';
errorArr[15]='参数验证失败';
errorArr[16]='您的兑换申请正在审核中';
errorArr[17]='不存在该商品';
errorArr[18]='该商品已下架或未参加推广计划';
errorArr[19]='您的金额不足';
errorArr[20]='您的积分不足';
errorArr[21]='您的等级不足';
errorArr[23]='非法网址';
errorArr[24]='该商品加载失败！';
errorArr[25]='请选择分类';
errorArr[26]='内容超限';
errorArr[27]='请添加评论内容';
errorArr[28]='最多填写5个关键词';
errorArr[29]='非法网址';
errorArr[30]='此商品你已经喜欢过了';
errorArr[31]='此商品你已经分享过了';
errorArr[32]='id错误';
errorArr[33]='亲，休息休息再评论吧';
errorArr[34]='密码不相同';
errorArr[35]='支付宝格式错误';
errorArr[36]='手机号码格式错误';
errorArr[37]='支付宝已存在';
errorArr[38]='您的提现正在审核中';
errorArr[39]='支付宝不能为空';
errorArr[40]='真实姓名不能为空';
errorArr[41]='提现密码错误';
errorArr[42]='参数错误';
errorArr[43]='签到关闭';
errorArr[44]='今天已签到';
errorArr[45]='该订单不能提交确认';
errorArr[46]='订单不存在';
errorArr[47]='订单号错误';
errorArr[48]='此项不参与兑换';
errorArr[49]='这不是一个淘宝网址';
errorArr[50]='注册受限，请不要在短时间内重复注册！';
errorArr[51]='商品已过期';
errorArr[52]='今天已达到最大兑换个数，明天再来吧！';
errorArr[53]='未开始';
errorArr[54]='此IP禁止登录注册';
errorArr[55]='此商品包含敏感词语';
errorArr[56]='此商品已经有人分享过了';
errorArr[57]='推荐人ID错误';
errorArr[58]='未选择银行';
errorArr[59]='银行id错误';
errorArr[60]='银行账号格式错误';
errorArr[61]='银行账号已被使用';
errorArr[62]='财付通格式错误！';
errorArr[63]='财付通已被使用！';
errorArr[64]='功能未开启！';
errorArr[65]='提现工具未选择！';
errorArr[66]='库存不足！';
errorArr[67]='验证次数太多，请联系网站管理员！';
errorArr[68]='该手机已验证，请更换手机号码！';
errorArr[69]='验证间隔过短，请稍后验证！';
errorArr[70]='请填写淘宝帐号！';
errorArr[71]='请求过多，请稍后再试！';
errorArr[101]='miss keyword or cid';
errorArr[102]='商品不存在';
errorArr[103]='掌柜昵称不能为空！';
errorArr[104]='昵称不存在或不是掌柜！';
errorArr[201]='无上传图片';
errorArr[202]='图片后缀名错误';
errorArr[203]='图片太大';
errorArr[204]='图片移动失败';
errorArr[999]='未知错误，请联系网站管理员';
/*data/error.js*/
noWordArr=new Array();
noWordArr[0]='卖淫';
noWordArr[1]='办假证';
noWordArr[2]='办理本科';
noWordArr[3]='办理民办学校文凭';
noWordArr[4]='办理文凭';
noWordArr[5]='办理文憑';
noWordArr[6]='办理真实文凭';
noWordArr[7]='办理证件';
noWordArr[8]='办理专科';
noWordArr[9]='办证服务';
noWordArr[10]='插入爽网';
noWordArr[11]='超爽视频';
noWordArr[12]='成人电影';
noWordArr[13]='代办假证';
noWordArr[14]='代办信用卡';
noWordArr[15]='代办银行卡';
noWordArr[16]='代开发票';
noWordArr[17]='代考网';
noWordArr[18]='代考网站';
noWordArr[19]='对外办理发票';
noWordArr[20]='黄色电影';
noWordArr[21]='黄色漫画';
noWordArr[22]='黄色图片';
noWordArr[23]='黄色网站';
noWordArr[24]='激情电影';
noWordArr[25]='激情伦理电影';
noWordArr[26]='激情视频';
noWordArr[27]='激情视频聊天';
noWordArr[28]='激情图';
noWordArr[29]='激情图片';
noWordArr[30]='激情小电影';
noWordArr[31]='寂寞少妇';
noWordArr[32]='考生答疑';
noWordArr[33]='考试答案';
noWordArr[34]='伦理电影';
noWordArr[35]='伦理电影在线';
noWordArr[36]='窃听器材';
noWordArr[37]='情色';
noWordArr[38]='情色六月天';
noWordArr[39]='情色图片';
noWordArr[40]='情色五月天';
noWordArr[41]='取得本科';
noWordArr[42]='取得专科';
noWordArr[43]='全国办证';
noWordArr[44]='热辣美图';
noWordArr[45]='人体写真';
noWordArr[46]='人体艺术';
noWordArr[47]='三唑仑';
noWordArr[48]='桑拿一条龙';
noWordArr[49]='色电影';
noWordArr[50]='色界';
noWordArr[51]='色情网站';
noWordArr[52]='色小说';
noWordArr[53]='色诱';
noWordArr[54]='上海丝足按摩';
noWordArr[55]='少儿勿入';
noWordArr[56]='少女初夜爽片';
noWordArr[57]='少女高潮';
noWordArr[58]='少女图片';
noWordArr[59]='声色场所';
noWordArr[60]='视频激情';
noWordArr[61]='手机定位器';
noWordArr[62]='手机复制';
noWordArr[63]='手机监听';
noWordArr[64]='手机监听器';
noWordArr[65]='网上办证';
noWordArr[66]='我要色图';
noWordArr[67]='西班牙苍蝇水';
noWordArr[68]='成人用品';
noWordArr[69]='硬币';
noWordArr[70]='百家乐';
noWordArr[71]='网赚';
noWordArr[72]='黑客';
noWordArr[73]='充值软件';
/*data/noWordArr.js*/
