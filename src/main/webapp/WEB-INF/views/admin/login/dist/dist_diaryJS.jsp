<script>

function setDisplay(id, type){
	if( type == "show") {
		$( id ).css("display","show");	$( id ).show();
	} else {
		$( id ).css("display","none");	$( id ).hide();
	}
}

function isValidation(target, data,message, type){
	// 숫자체크
	if( data != null && data != ""){
		var regExp = /^[0-9]*$/; 							// 정규식으로 숫자 체크 처리
		if( type =="number" && !regExp.test(data)) {
    		alert(message);
    		$(target).focus();
    		return false;
    	} 
	}
	
	// null check
	if( data == null || data == ""){
		if( type == "null" ) {
    		alert(message + " :" + data );
    		$(target).focus();
    		return false;
    	}
	}
	return true;
}	

/**
 * 문자열이 빈 문자열인지 체크하여 결과값을 리턴한다.
 * @param str       : 체크할 문자열
 */
function isEmpty(str){
     
    if(typeof str == "undefined" || str == null || str == "")
        return true;
    else
        return false ;
}
 
/**
 * 문자열이 빈 문자열인지 체크하여 기본 문자열로 리턴한다.
 * @param str           : 체크할 문자열
 * @param defaultStr    : 문자열이 비어있을경우 리턴할 기본 문자열
 */
function nvl(str, defaultStr){
     
    if(typeof str == "undefined" || str == null || str == "")
        str = defaultStr ;
     
    return str ;
}


function storageAvailable(type) {
    var storage;
    try {
        storage = window[type];
        var x = '__storage_test__';
        storage.setItem(x, x);
        storage.removeItem(x);
        return true;
    }
    catch(e) {
        return e instanceof DOMException && (
            // Firefox를 제외한 모든 브라우저
            e.code === 22 ||
            // Firefox
            e.code === 1014 ||
            // 코드가 존재하지 않을 수도 있기 떄문에 이름 필드도 확인합니다.
            // Firefox를 제외한 모든 브라우저
            e.name === 'QuotaExceededError' ||
            // Firefox
            e.name === 'NS_ERROR_DOM_QUOTA_REACHED') &&
            // 이미 저장된 것이있는 경우에만 QuotaExceededError를 확인하십시오.
            (storage && storage.length !== 0);
    }
}

if (storageAvailable('localStorage')) {
	
	if( !isEmpty(localStorage.getItem('font-size')) ){
		// localStorage.setItem('font-size',"10")
		var _currSize = localStorage.getItem('font-size')+"px";
		var _currbigSize = localStorage.getItem('font-size')* 2 +"px";
		$( "button" ).css( "font-size", _currSize );
		$( "form" ).css( "font-size", _currSize );
    	$( "div" ).css( "font-size", _currSize );
    	$( "table" ).css( "font-size", _currSize );
		
    	$(".collapseBtn").css( "font-size", _currbigSize );
	}
} else {
}	

function selectSetWithNavName(name){
	
	var result = "";
	
	switch (name) {
	
		case "글자크기 조절":
			
			startFontSizeSetting();
			
			$("#exampleModalLabel2").html(name);
			
			var html = initFontSizeSetTable();
	       	$("#exampleModal2 .modal-body").html(html);
	    	
	    	$("#fontSizeUp").on("click",function(){
	    		
	    		var el = document.getElementById('contents-wrap');
	    		var setVar = (settings.fontSize + 1) + 'px';
	    		
	    		if( !isEmpty(localStorage.getItem('font-size')) ){
	    			settings.fontSize = localStorage.getItem('font-size');
	    			setVar =  +'px';
	    		}
	    		
		    	el.style.setProperty('font-size', setVar,'important');
		    	
		    	$("#fontSizeFormTd").html((parseInt(settings.fontSize) + 1));
		    	
		    	settings.fontSize = parseInt(settings.fontSize) + 1;
		    	
		    	changeFontSizeRefNavTop();
		    	
		    	$( "button" ).css( "font-size", settings.fontSize+"px" );
		    	$( "form" ).css( "font-size", settings.fontSize+"px" );
		    	$( "div" ).css( "font-size", settings.fontSize+"px" );
		    	$( "table" ).css( "font-size", settings.fontSize+"px" );
		    	
		    	var _currbigSize = settings.fontSize* 2 +"px"; 
		    	$(".collapseBtn").css( "font-size", _currbigSize );
		    	
		    	if (storageAvailable('localStorage')) {
		    		localStorage.setItem('font-size', parseInt(settings.fontSize) );
		    	} else {
		    	}
		    	
	    	});
	    	
	    	$("#fontSizeDown").on("click",function(){
	    		
	    		var el = document.getElementById('contents-wrap');
	    		var setVar = (settings.fontSize - 1) + 'px';
	    		
		    	if( !isEmpty(localStorage.getItem('font-size')) ){
		    		settings.fontSize = localStorage.getItem('font-size');
	    			setVar =  +'px';
	    		}
		    	el.style.setProperty('font-size', setVar,'important');
		    	
		    	$("#fontSizeFormTd").html((parseInt(settings.fontSize) - 1));
		    	
		    	settings.fontSize = parseInt(settings.fontSize) - 1;
		    	
		    	changeFontSizeRefNavTop();
		    	
		    	$( "button" ).css( "font-size", settings.fontSize+"px" );
		    	$( "form" ).css( "font-size", settings.fontSize+"px");
		    	$( "div" ).css( "font-size", settings.fontSize+"px" );
		    	$( "table" ).css( "font-size", settings.fontSize+"px" );
		    	
				var _currbigSize = settings.fontSize* 2 +"px"; 
		    	$(".collapseBtn").css( "font-size", _currbigSize );
		    	
		    	
		    	if (storageAvailable('localStorage')) {
		    		localStorage.setItem('font-size', parseInt(settings.fontSize) );
		    	} else {
		    	}
		    	
	    	});
	    	
			$("#exampleModal2").modal();
			
			break;

	}
	
	return result;
}
 
</script>