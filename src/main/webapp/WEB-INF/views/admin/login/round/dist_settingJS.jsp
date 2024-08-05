<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
</head>
<body>

<script type="text/javascript">

var settings = {};

function initSetting(){
	
	$(window).resize(function(){
		
		var width = $("#filterImage").width();
		if(width > 0){
			
    		$("#filterLabel").width(width);
    		
		}
		
		var mHeigth = ($(window).height()/2);
		var mWidth  = $("#initMapSize").width();
		var mmw     = mWidth/10;
		    mWidth  = mWidth-mmw;
		
		if(screen.height > 1000) {
			mHeigth = 500;
		}
		
		var mSize = new naver.maps.Size(mWidth, mHeigth);
		
		nMap.map.setSize(mSize);
		
		changeFontSizeRefNavTop();
		
	});
	
}

function startFontSizeSetting(){
	
	$("#mainDiv .collapse").each(function(){
		
		var className = $(this).attr('class');
		var elId = $(this).attr('id');
		
		if(className.indexOf('show') > -1){
			
			var targetId = elId.replace('collapse','heading');
			
			$("#"+targetId+" button").trigger("click");
			
		}
		 
	});
	
    $("#menuDiv,.page_cover,html").removeClass("menuOpen");
	
}

function changeFontSizeRefNavTop(){
	
	$("#mainDiv .collapse").each(function(){
		
		 var obj = new Object();
		 
		 obj.el = this;
		 obj.top = $(this).parent().find('button').offset().top;
		 
		 collapseList.push(obj);
		 
	});
	
}

function initFontSizeSetTable(){
	
	var el = document.getElementById('contents-wrap');
	var style = window.getComputedStyle(el, null).getPropertyValue('font-size');
	settings.fontSize = parseFloat(style); 
	
	var html =  '<div>                           '
			 +  '	<table style="border solid 1px;">                      '
			 +  '		<tr>                     '
			 +  '			<td>현재 글자크기</td>     '
			 +  '			<td id="fontSizeFormTd">'+settings.fontSize+'</td>            '
			 +  '		</tr>                    '
			 +  '		<tr>                     '
			 +  '			<td>글자크기 설정</td>     '
			 +  '			<td>						'
			 +  '				<button type="button" id="fontSizeUp">'
			 +	'					<svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-arrow-up-square-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg"> '
			 +	' 						<path fill-rule="evenodd" d="M2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2zm6.5 11.5a.5.5 0 0 1-1 0V5.707L5.354 7.854a.5.5 0 1 1-.708-.708l3-3a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1-.708.708L8.5 5.707V11.5z"/> '
			 +	'					</svg>				'
			 +	'				</button>				'
			 +  '				<button type="button" id="fontSizeDown">'
			 +	'					<svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-arrow-down-square-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg"> '
			 +	' 						<path fill-rule="evenodd" d="M2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2zm6.5 4.5a.5.5 0 0 0-1 0v5.793L5.354 8.146a.5.5 0 1 0-.708.708l3 3a.5.5 0 0 0 .708 0l3-3a.5.5 0 0 0-.708-.708L8.5 10.293V4.5z"/> '
			 +	'					</svg>				'
			 +	'				</button>				'			 
			 
			 +  '			</td>      					'
			 +  '		</tr>                    '
			 +  '	</table>                     '
			 +  '</div>                          '

			;
	return html;		 
}

</script>
</body>
</html>