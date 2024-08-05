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

$(document).bind('contextmenu',function (e){
	
});
 
</script>