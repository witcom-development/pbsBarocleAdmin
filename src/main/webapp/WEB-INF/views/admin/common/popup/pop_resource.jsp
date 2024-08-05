<title>관리자 페이지 - 서울자전거 따릉이</title>
<link href="/css/font.css" rel="stylesheet" type="text/css" />
<link href="/css/set.css" rel="stylesheet" type="text/css" />
<link href="/css/style.css" rel="stylesheet" type="text/css" />
<link href="/css/mdvcss.css" rel="stylesheet" type="text/css" media="only screen and (max-width:700px)" />
<link href="/css/tdvcss.css" rel="stylesheet" type="text/css" media="only screen and (min-width:700px) and (max-width:1000px)" />
<!--[If IE 8]><link href="/css/ie8cross.css" rel="stylesheet" type="text/css" /><![endif]-->
<!--[If IE 9]><link href="/css/ie9cross.css" rel="stylesheet" type="text/css" /><![endif]-->
<link href="/css/ie10cross.css" rel="stylesheet" type="text/css" />
<script src="/js/jquery-1.11.2.min.js"></script>
<script src="/js/jquery-ui.min.js" type="text/javascript"></script>
<script src="/js/comm.js"></script>
<script>
window.onunload = window.onbeforeunload = function(){
	try{
		
		if(typeof(opener.maskhide) == "undefined"){
		}else if(typeof(opener.maskhide) == "function"){
			
    		opener.location.href = "javascript:maskhide()";
		}
		
	}catch(e){
		
	}
}
</script>
<!--[if lt IE 9]>
<link href="/css/pw8m.css" rel="stylesheet" type="text/css" />
<link href="/css/pw8t.css" rel="stylesheet" type="text/css" />
<![endif]-->
