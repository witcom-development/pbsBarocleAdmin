/**
 *         [공통 스크립트]
 * 
 * 작성자:김병기
 * 작성일자:2014.04.08
 * 작성내용: HMS 프로젝트에 사용되는 자바스크립트 공통함수(임시) 
 */

//화면 프린트:파라미터-엘리먼트id. solbit 2020-06-16
function fnContentPrint(id){
	
	var html = document.querySelector('html');
	var printContents = document.querySelector('#'+id).innerHTML;
	
	var printDiv = document.createElement('DIV');
	var breakPrint = document.createElement('DIV');
	
	printDiv.className = 'print-div';
	breakPrint.className = 'page-break-before:always';
	
	printDiv.innerHTML = printContents;
	
	var printWidth = $('#'+id).width()+30;
	$(printDiv).width(printWidth+"px");
	
	$(".shBoxSection").find("*").each(function(){// 검색영역태그
		
		var find = findElementWithName(this);
		if(find){
			
			var name = $(this).attr('name');
			
			var value = $(document).find("[name='"+name+"']").val();
				
			$(printDiv).find("[name='"+name+"']").val(value);
				
			
		} 
		
	});
	
	html.appendChild(printDiv);
	html.appendChild(breakPrint);
	
	document.body.style.display = 'none';
	
	
	
	var orgTitle = $(document).find("title").text();
	var date = new Date();
	var today = date.getFullYear() + "-" + ("0"+(date.getMonth()+1)).slice(-2) + "-" + ("0"+date.getDate()).slice(-2);
	
	var p = $(".pageTitle").text();
	$(document).attr("title",p+"_"+today);
	
	window.print();
	
	document.body.style.display = 'block';
	html.removeChild(printDiv);
	html.removeChild(breakPrint);
	$(document).attr("title",orgTitle);
}

//return Boolean : name속성 가지고있다면 true
function findElementWithName(element){
	
	var rBoolean = false; 
	
	var name = $(element).attr("name"); 
	
	if(typeof name !== typeof undefined && name !== false) rBoolean = true;
	
	return rBoolean;
}

// 팝업
function windowOpen(sURL, sName, sWidth, sHeight, sTop, sLeft, sScrollbars,
		sResizable) {
	var sStatus = 'toolbar=no,location=no,status=yes,menubar=no,scrollbars='
			+ sScrollbars + ',resizable=' + sResizable + ',width=' + sWidthnumbersonly
			+ ',height=' + sHeight + ',top=' + sTop + ',left=' + sLeft;
	window.open(sURL, sName, sStatus, false);

}

// 팝업창 닫기
function windowClose() {
	window.open('about:blank', '_self').close(); // 닫기
}

/* 폼: 생성 */
function formCreate(nm, mt, at, tg) {
	var f = document.createElement("form");
	f.name = nm;
	f.method = mt;
	f.action = at;
	f.target = tg ? tg : "_self";
	return f;
}

/* 폼: 인풋 생성 */
function formInput(f, n, v) {
	var i = document.createElement("input");
	i.type = "hidden";
	i.name = n;
	i.value = v;
	// f.appendChild(i);
	f.insertBefore(i, null);
	// f.insertBefore(i);
	return f;
}

/* 폼: 전송 */
/*function formSubmit(f) {
	document.body.appendChild(f);
	f.submit();
	
}*/

/*
 *     <동적 폼 사용예제>
 * 
 *      // 먼저, selector를 통해 폼으로 전송할 값을 변수로 선언합니다. 
 *		var userId = $('#userId').val();   
 *		// 동적을 폼을 생성합니다.
 *		var form = createAsyncForm("modifyFrm", "modifyFrm", '<c:url value="/adm/mem/mem_modify.do"/>') ;
 *		// 생성한 폼에 변수를 저장합니다.
 *		form = inputAsyncForm(form, "userId", userId);
 *		form = inputAsyncForm(form, "registerYn", 'N');
 *		// 폼을 전송합니다.
 *		submitAsyncForm(form);
 * 
 */

// 동적으로 폼을 생성합니다.
function createAsyncForm(formName, formId, action) {
	var form = $('<form />', {id:formName, name:formId, action: action, method: 'post'});
	return form.clone();	
}

// 동적으로 만들어진 폼에 변수를 hidden 형태로 삽입한 뒤 해당 폼을 리턴합니다.
function inputAsyncForm(form, name, val) {
	var input = $('<input />', {type: 'hidden', name: name, id: name, value: val});
	$(form).append($(input).clone());
	return form;
}

// 폼을 submit 하고, body 태그에서 흔적을 삭제합니다.
function submitAsyncForm(form) {
	$(form).prependTo('body');
	$(form).submit().remove();
}


// 금액 천단위마다 콤마찍기
function FormatNumber(price, num) {
	var str = new Array();
	price = String(price);
	for (var i = 1; i <= price.length; i++) {
		if (i % num)
			str[price.length - i] = price.charAt(price.length - i);
		else
			str[price.length - i] = ',' + price.charAt(price.length - i);
	}
	return str.join('').replace(/^,/, '');
}

/*
 * checkbox 의 체크된 값들을 하나의 스트링에 구분자로 나누어 저장 
 * 
 * 작성자 : 김병기 작성일자 : 2011.04.20
 * ------------------------------------------------------------- 
 * desciption :
 * 
 * input : - chName 체크박스의 name 속성값, 
 *         - sp 구분자 : ex ',', '#', '*', ... 
 * return : 구분자로 나뉘어진 스트링 Value
 * 
 * ex) var str = checkedToString('key', ',');
 */
function checkedToString(chName, sp) {
	var rtn = "";
	$("input[name=" + chName + "]:checkbox").each(function() {
		if ($(this).is(":checked")) {
			rtn += $(this).val() + sp;
		}
	});
	var lastIndex = rtn.lastIndexOf(sp);
	rtn = rtn.substring(0, lastIndex);
	return rtn;
}

// 공백 제거 trim() 메소드
function fncTrim(value) {
	value = value.replace(/^\s*/, '');
	value = value.replace(/\s*$/, '');

	return value;
}
// 공백제거후 값의 length 반환
function fncValuLength(value) {

	return fncTrim(value).length;
}
// form id 를 넘겨주면 해당 input:text 앞뒤 trim 처리
$.trimAllText = function(target) {
	$("input:text", "#" + target).each(function() {
		$(this).val($.trim($(this).val()));
		console.log("> input name : " + $(this).attr("name"));
	});
};
// jscript 태그가 있으면 로딩 완료 후 eval을 이용하여 스크립트를 실행한다.
$.doJscript = function() {
	$("[name=jscript]").each(function($idx, $data) {
		eval($($data).text());
		console.log("jscript excute :: " + $($data).text());
		$($data).remove();
	});
};

// 숫자만 입력받는 텍스트
// <input type="text" style="ime-mode:disabled;" onKeyPress="return
// numbersonly(event, false)">
function numbersonly(e, decimal) {
	var key;
	if (window.event) {
		key = window.event.keyCode;
	} else if (e) {
		key = e.which;
	} else {
		return true;
	}
	keychar = String.fromCharCode(key);
	/*if(key < 48 || key > 57){
		return false;
    } else {
    	return true;
    }*/
	if (!(key == 8 || key == 9 || key == 13 || (key >= 35 && key <= 40)
			|| key == 45 || key == 46 || key == 116 || key == 144
			|| (key >= 48 && key <= 57) || (key >= 96 && key <= 105)
			|| key == 110 || key == 190)) {
		return false;
	} else {
		return true;
	}
}

jQuery.fn.extend({
    /**
     * 숫자만 입력 가능하도록 처리
     */
    numberOnly : function() {
        return this.each(function() {
            try {
                var $this = $(this);

                // FF patch : 한글입력 상태에서 keydown 입력 제한이 안걸리는 문제가 있어 한글 입력 불가능하도록 설정
               $this.css('ime-mode', 'disabled');
                
                
        		//숫자, del, backspace 키만 입력가능 설정
                $this.keypress(function(p_event) {
                	var keyCode = window.event ? window.event.keyCode : e.which;
            		if (window.event) {
            			keyCode = window.event.keyCode;
            		} else if (e) {
            			keyCode = e.which;
            		} else {
            			return true;
            		}

                    if((48<=keyCode && keyCode<=57) || keyCode==0 || keyCode==45 || keyCode==8){
                    	return;
                    }else{
                        if(window.event)    window.event.returnValue = false;
                        else e.preventDefault();
                    }
                    
                });
                
                //한글 입력 불가로 설정(크롬)
                $this.keyup(function(e){
                	var keyCode = window.event ? window.event.keyCode : e.which;
            		if (window.event) {
            			keyCode = window.event.keyCode;
            		} else if (e) {
            			keyCode = e.which;
            		}
                	
                    if (!(keyCode >=37 && keyCode<=40)) {
                        var inputVal = $(this).val();
                        if(window.event)    window.event.returnValue = false;
                        else e.preventDefault();
                        $(this).val(inputVal.replace(/[^0-9]/gi,''));

                    }

                });
                

                // 포커스를 얻어을 때 처리 - number format을 위한 콤마를 모두 제거한다.
                $this.focus(function() {
                    $this.val($this.val().replace(/,/g, ''));
                });
            } catch(e) {
                alert("[common.js's numberOnly] " + e.description);
            }
        });
    }    
});

/*
 * StringUtil
 */
//문자열 byte 체크 알파벳&숫자 (1byte), 한글(3byte)
function getStringByte (str) {
	var strLength = 0;

	for (var i = 0; i < str.length; i++) {
		var code = str.charCodeAt(i);
		var ch = str.substr(i,1).toUpperCase();

		code = parseInt(code);

		if ((ch < "0" || ch > "9") && (ch < "A" || ch > "Z") && ((code > 255) || (code < 0)))
			strLength = strLength + 3;
		else
			strLength = strLength + 1;
	}
	return strLength;
}
/* 
obj  			: this
limitByte 	: 제한 size  ex) 10 -> 10byte까지만
초과된 글자 삭제
*/
function cutString(obj, limitByte) {

    var  byteLength = 0;
    var tempStr = "";
    var tempStr2 = "";

    for(var i = 0; i < (obj.value).length; i++) {
        tempStr = (obj.value).charAt(i);

        if(escape(tempStr).length > 4) {
            byteLength += 3;
        }else {
            byteLength += 1;
        }

        if (byteLength > limitByte) { //초과된 글자수가 위치하는 지점
        
            if(escape(tempStr).length > 4) { //한글
                byteLength -= 3;
            }
            else {                           //기타
                byteLength -= 1;
            }

            break;
        }
        else {
        
            tempStr2 += tempStr;
        }
    }
    //제한길이를 초과한 문자는 초과부분까지만 표시
    obj.value = tempStr2;
    
}
/* 
obj  			: this
limitByte 	: 제한 size  ex) 10 -> 10byte까지만
ex onkeyup="javascript:cutString(this, 300 );"
제한문자길이 체크하고, 초과된 글자 삭제
*/
function checkStrByte(obj, limitByte) {
	var strByte = getStringByte (obj.value);
	if (strByte > limitByte) {
        alert("최대 " + limitByte + "byte이므로 초과된 글자수는 자동으로 삭제됩니다.");
        cutString(obj, limitByte);
    }
}
//한글 포함 여부 확인	
function isKorean(str) {
	var pattern = /[\u3131-\u314e|\u314f-\u3163|\uac00-\ud7a3]/g;
	return (pattern.test(str)) ? true : false; 
}
//숫자만 이루어졌는지 확인
function isNumeric(str) {
	var re = /^[0-9]+$/;
    return !re.test(str) ? false : true;
}

//숫자 입력 체크
function onlyNum(value) {
	
 if(Number(value) == 'NaN') {
	 return false;
 } else {
	 return true;
 }
 
 //var pattern = /\D/g;

 //if (pattern.test(value)) {
 //    return false;
 //}

 //return true;
}

//특수문자 제한
function checkSpecialChar(obj)
{
	var _etcValue3   = '<>+;:|\'\"';
	for(var i=0; i<obj.value.length; i++)
	{
		for(var j=0;j<_etcValue3.length;j++){ 
			if(obj.value.charAt(i) == _etcValue3.charAt(j))
			{
				alert("특수문자는 입력할 수 없습니다!\n[<>+;:|\'\"]");
				return false;
			}
		}
	}
	return true;
}

/*
 * 이메일 형식인지 확인
 * false : 이메일 형식, true : 이메일 형식 아님
 */
function isEmail(str) {	
	var re = /^[0-9a-zA-Z][_0-9a-zA-Z\-]*@[_0-9a-zA-Z\-]+[.][._0-9a-zA-Z\-]+$/; 
    return !re.test(str) ? true : false;
}

//콤마제거
function removeComma(val) {
	if(val === 0){
		return val;
	}
    return val.replace(/,/g, '');
}


// 올바른 URL 패턴인지 체크
function collectURL(text) {
	var rUrlRegex = /(?:(?:(https?|ftp|telnet):\/\/|[\s\t\r\n\[\]\`\<\>\"\'])((?:[\w$\-_\.+!*\'\(\),]|%[0-9a-f][0-9a-f])*\:(?:[\w$\-_\.+!*\'\(\),;\?&=]|%[0-9a-f][0-9a-f])+\@)?(?:((?:(?:[a-z0-9\-가-힣]+\.)+[a-z0-9\-]{2,})|(?:[\d]{1,3}\.){3}[\d]{1,3})|localhost)(?:\:([0-9]+))?((?:\/(?:[\w$\-_\.+!*\'\(\),;:@&=ㄱ-ㅎㅏ-ㅣ가-힣]|%[0-9a-f][0-9a-f])+)*)(?:\/([^\s\/\?\.:<>|#]*(?:\.[^\s\/\?:<>|#]+)*))?(\/?[\?;](?:[a-z0-9\-]+(?:=[^\s:&<>]*)?\&)*[a-z0-9\-]+(?:=[^\s:&<>]*)?)?(#[\w\-]+)?)/gmi;
  return rUrlRegex.test(text);
}

//소수점 1자리 형식 확인
function isDecimal(obj) {
	var str = obj.value;
	var pattern = /^([0-9]{1,3})(\.[0-9]?)?$/;
	var result = true;
	if(pattern.test(str)) {
		result = true;
	}else {
		obj.focus();
		obj.value = '';
		result = false;
	}
	return result;
}

/*input값에 char안의 문자가 있는지 체크*/
function containsChars(input,chars) {
    for (var inx = 0; inx < input.length; inx++) {
       if (chars.indexOf(input.charAt(inx)) != -1)
           return true; 
    }
    return false;
}

 /*** 파일명, 확장자 추출
 // 결과예시 : fname = '/abc/def/ghi/filename.ext';
 // getFileName(fname)    -----> filename.ext
 // getFileName(fname, 1) -----> filename
 // getFileName(fname, 2) -----> ext
 **/
function getFileName(str, num){
	 var pos = str.lastIndexOf("/");
	 var ln = str.lastIndexOf("\.");
	 var filename = str.substring(pos + 1, ln);
	 var fullname = str.substring(pos + 1, str.length); 
	 var ext = str.substring(ln + 1, str.length); 
	 if(num==null || num=="") return fullname;
	 if(num==1) return filename;
	 if(num==2) return ext;
}


var DateUtil = {
	  dateGubun : '-',
	  dateFmt: function(date) {
		  var rDate = date;
		  if (typeof(rDate) == 'string') {
			  if(this.dateGubun) {
				  var sDate = rDate.split(this.dateGubun);
				  if(sDate.length == 3) {
					  rDate = new Date(sDate[0], parseInt(sDate[1], 10)-1, sDate[2]);
				  }
			  } else {
				  rDate = new Date(rDate.substr(0,4), parseInt(rDate.substr(4,2), 10)-1, rDate.substr(6,2));
			  }
		  } else {
			  
			  var year = date.getFullYear();
			  var month = date.getMonth()+1;
			  var day = date.getDate();
			  if(month < 10){
				  month = '0'+month;
			  }
			  if(day < 10){
				  day = '0'+day;
			  }
			  rDate = year+this.dateGubun+ month+this.dateGubun+day;
		  }
		  return rDate;
	  },
     diffDays: function(d1, d2, dateGubun) {
    	 this.dateGubun = dateGubun;
         var t2 = this.dateFmt(d2).getTime();
         var t1 = this.dateFmt(d1).getTime();
         
         return Math.floor((t2-t1)/(24*3600*1000));
//		          return parseInt((t2-t1)/(24*3600*1000), 10);
     },   
     diffWeeks: function(d1, d2, dateGubun) {
      this.dateGubun = dateGubun;
         var t2 = this.dateFmt(d2).getTime();
         var t1 = this.dateFmt(d1).getTime();
  
         return parseInt((t2-t1)/(24*3600*1000*7), 10);
     },
     diffMonths: function(d1, d2, dateGubun) {
    	 this.dateGubun = dateGubun;
         var d1Y = this.dateFmt(d1).getFullYear();
         var d2Y = this.dateFmt(d2).getFullYear();
         var d1M = this.dateFmt(d1).getMonth();
         var d2M = this.dateFmt(d2).getMonth();
  
         return (d2M+12*d2Y)-(d1M+12*d1Y);
     },
     diffYears: function(d1, d2, dateGubun) {
      this.dateGubun = dateGubun;
         return this.dateFmt(d2).getFullYear()-this.dateFmt(d1).getFullYear();
     }, 
     /*
      * 두 날짜 스트링을 입력받아 두 날짜 사이의 차이를 체크한다.
      * (DateUtil 함수를 사용)
      */
     checkDateTerm: function (date1, date2) {
         if(date1 === '' || date2 === '') {
    	     return 'ok';
    	 }
    	 var type1 = 'yyyymmdd';
    	 var type2 = 'yyyymmdd';
    	 var term = 0;
    	 var result = 'ok';
    	 // 문자열에 '-' 문자 포함여부' : yyyy-mm-dd 형식
    	 if (date1.indexOf('-') > -1) type1 = 'yyyy-mm-dd';
    	 if (date2.indexOf('-') > -1) type2 = 'yyyy-mm-dd';
    	 if (type1 != type2) result = "typeDisMatch";
    	 // 차이(term)를 구한다.
    	 if (type1 == 'yyyymmdd') {
    	    term = DateUtil.diffDays(date1, date2);
    	 } else {
    	     term = DateUtil.diffDays(date1, date2, '-');
    	 }
    	 if (term < 0) result = "upsidedown";
    	 // 날짜의 차이에 따른 alert()
         return result;
     },
     getCurrentTime : function() {
    	 //현재 시간을 리턴(시분초.)
    	 var myDate = new Date().toTimeString().replace(/.*(\d{2}:\d{2}:\d{2}).*/, "$1");
    	 return myDate;
     }
};

function setCookie( name, value, expiredays ) {
    var todayDate = new Date();
    todayDate.setDate( todayDate.getDate() + expiredays );
    document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";";
}

function getCookie( name ) { 
    var nameOfCookie = name + "="; 
    var x = 0; 
    
    while ( x <= document.cookie.length ) 
    { 
        var y = (x+nameOfCookie.length); 
        if ( document.cookie.substring( x, y ) == nameOfCookie ) 
        { 
            if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 ) 
                endOfCookie = document.cookie.length;
            return unescape( document.cookie.substring( y, endOfCookie ) ); 
        } 
        x = document.cookie.indexOf( " ", x ) + 1; 
        if ( x == 0 ) 
            break; 
    } 
    return ""; 
}

/*
 * 비밀번호 확인
 * 특이사항 : 영문 시작
 * 범위 : 숫자 영문 기호
 * 길이 : 8자리 이상 20자리 이하
 */
function isPassword(text){
	//var regexp = /^[a-zA-Z]{1}[\w\W]{7,19}$/;
	var regexp = /^.*(?=^.{8,20}$)(?=^.[a-zA-Z])(?=.*?\d)(?=.*?[a-zA-Z])(?=.*?[!@#$%^&+=]).*$/;
	return regexp.test(text);
}

/*
 * 코드 확인
 * 특이사항 : 영문 시작
 * 범위 : 영문 숫자
 * 길이 : 2자리 이상 20자리 이하
 */
function isCode(text){
	var regexp = /^[a-zA-Z]{1}[\w]{1,19}$/;
	return regexp.test(text);
}

/*
 * 아이디 확인
 * 특이사항 : 영문 시작
 * 범위 : 영문 숫자
 * 길이 : 5자리 이상20자리 이하
 */
function isId(text){
	var regexp = /^[a-zA-Z]{1}[\w]{4,19}$/;
	return regexp.test(text);
}

/*
 * 이름 확인
 * 특이사항 : 한글 영문 시작
 * 범위 : 한글 영문 숫자
 * 길이 : 2자리 이상 20자리 이하
 */
function isUsrName(text){
	var regexp = /^[a-zA-z가-힣]{1}[\w가-힣]{1,19}$/;
	return regexp.test(text);
}

/*
 * 전화번호 확인
 * 특이사항 : 0으로 시작, 첫자리 가운데 혹은 끝자리 0불가, 중간자리 첫번 째 0 불가 , 끝자리 첫번 째 0 불가
 * 범위 : 숫자
 * 길이 : 9 ~ 11
 */
function isTel(text){
	var regexp = /^0[1-9]{1}[0-9]{0,1}[1-9]{1}[0-9]{2,3}[0-9]{4}$/;
	return regexp.test(text);
}

/*
 * 휴대폰 번호 확인
 * 특이사항 : 0으로 시작 국번 가운데 혹은 끝자리 0불가, 중간자리 첫번 째 0 불가 
 * 범위 : 한글 영문 숫자
 * 길이 : 2자리 이상 20자리 이하
 */
function isMpn(text){
	var regexp = /^0[1-9]{1}[0-9]{1}[1-9]{1}[0-9]{2,3}[0-9]{4}$/;
	return regexp.test(text);
}
function isMpnSpb(text){
	var regexp =  /(01[016789])[-](\d{4}|\d{3})[-]\d{4}$/g;  
	return regexp.test(text);
}
/*
 * 이름 확인
 * 특이사항 : 한글, 영어, 숫자, _,-,() 공백
 * 범위 : 한글 영문 숫자 _ space
 * 길이 : 1자리 이상 20자리 이하
 */
function isName(text){
	var regexp = /^[\w가-힣_\-() ]{1,20}$/;
	return regexp.test(text);
}

function isAlNumber(text) {
	var regexp = /^[A-Za-z0-9]*$/;
	return regexp.test(text);
}

function isAlHanNumber(text) {
	var regexp = /^[\w가-힣_/ ]*$/;
	return regexp.test(text);
}

function isUrl(text){
	var regexp = /^[/]{1}[/.\-_\w]{1,99}$/;
	return regexp.test(text);
}

function onlyBigEng(text, length){
	if(text.length > length){
		return false;
	}
	var regexp = /^[A-Z]*$/;
	return regexp.test(text);
}
/**
 * jquery Ajax 
 * @since 2015.04.10
 * @author  ymshin
 * 
 * */
var commonAjax = {};
commonAjax.ajax = function(pType, pUrl, pDataType, pData, pCb) {
	$.ajax({
		type		: pType,
		url			: pUrl,
		dataType	: pDataType,
		data		: pData,
		async		: false,//중복요청 방지_2017.06.09_JHN
		success		: function( data ) {
			pCb(data);
		},
		error : function(jqXHR, textStatus,errorThrown){
			if(jqXHR.status === 500 ){
				alert("에러가 발생했습니다.");
			}
			//console.log(textStatus);
		}
	});			
	
};

commonAjax.postAjax = function(pUrl, pDataType, pData, pCb) {
	this.ajax('POST', pUrl,  pDataType, pData, pCb);
};
commonAjax.getAjax = function(pUrl, pDataType, pData, pCb) {
	this.ajax('GET', pUrl, pDataType, pData, pCb);
};
/**공통코드*/
commonAjax.getCommonCode = function(comUpCd , pCb) {
	this.ajax("post", "/commonCode/getCommonCode.do", "json", {"comUpCd" : comUpCd }, pCb);
};
/**스테이션*/
commonAjax.getStationCode = function( pCb) {
	this.ajax("post", "/commonCode/getStation.do", "json", {}, pCb);
};
/**센터*/
commonAjax.getCenterCode = function( pCb) {
	this.ajax("post", "/commonCode/getCenterInfo.do", "json", {}, pCb);
};

/** 바로클포 센터*/
commonAjax.getCenterMallCode = function( pCb) {
	this.ajax("post", "/commonCode/getCenterMallInfo.do", "json", {}, pCb);
};

/**운영자 데이터*/
commonAjax.getAdminList = function(pGrpCd, pName, pCb) {
	this.ajax("post", "/commonCode/getUserGrpInfo.do", "json", {"usrGrpCd" : pGrpCd, "usrName" : pName}, pCb);
};

/**바로클포 운영자 데이터*/
commonAjax.getRepBikeAdminList = function(pGrpCd, pName, pCb) {
	this.ajax("post", "/commonCode/getRepBikeAdminInfo.do", "json", {"usrGrpCd" : pGrpCd, "usrName" : pName}, pCb);
};

/**벌점 데이터*/
commonAjax.getPenaltyCode = function(pCb) {
	this.ajax("post", "/commonCode/getPenaltyCode.do", "json", {}, pCb);
};
/**장애신고코드 데이터*/
commonAjax.getFaultList = function(pSeq, pCb) {
	this.ajax("post", "/commonCode/getFaultList.do", "json", {"faultSeq" : pSeq}, pCb);
};

var commCdBox = {};
commCdBox.makeComboBox = function( cType,cVal,comboData, comboParent) {
	var $pDisplay = null;
	if(typeof comboParent === "string") {
		$pDisplay = $("#"+comboParent);
	} else {
		$pDisplay = comboParent;
	}
	var cSize = comboData.length;
	
	if(cType === 'S') {
		var sub = [];
		for(var i=0; i < cSize; i +=1 ) {
			
			var $op = $("<option>", {value : comboData[i].stationId}).text(comboData[i].stationName);
			if(cVal !== '' && cVal === comboData[i].stationId ) {
				$op.attr('selected', true);
			}
			if(comboData[i].stationList !== null ) {
				sub.push(comboData[i].stationList);
			}
			if($pDisplay.children().length === 0) {
				$pDisplay.append($op);
			} else {
				$pDisplay.children().last().after($op);
			}
		}
		$pDisplay.data("sub_data", sub);
	} else if(cType === 'C') {
		for(var i=0; i < cSize; i +=1 ) {
			var $op = $("<option>", {id :'center_'+comboData[i].centerId , value : comboData[i].centerId}).text(comboData[i].centerName);
			if(cVal !== '' && cVal === comboData[i].centerId) {
				$op.attr('selected', true);
			}
			if($pDisplay.children().length === 0) {
				$pDisplay.append($op);
			} else {
				$pDisplay.children().last().after($op);
			}
		}
	} else {
		for(var i=0; i < cSize; i +=1 ) {
			var $op = $('<option>',{ id : 'comm_'+comboData[i].comCd, value : comboData[i].comCd }).text(comboData[i].comCdName);
			if(cVal !== '' && cVal === comboData[i].comCd) {
				$op.attr('selected', true);
			}
			if($pDisplay.children().length === 0) {
				$pDisplay.append($op);
			} else {
				$pDisplay.children().last().after($op);
			}
		}
	}
};

//아파트 자전거 서비스 시작일자 상수 추가
var SPB_SVC_START_DATE = "2015-01-01";

//정수.실수 체크함수.
function chkNumber(pChk) {
	var regexp =/^[+-]?\d*(\.?\d*)$/;
	
	return regexp.test(pChk);
}

//URL 파라메터 추출
function getUrlParams() {
	// 파라미터가 담길 배열
    var param = new Array();
 
    // 현재 페이지의 url
    var url = decodeURIComponent(location.href);
    // url이 encodeURIComponent 로 인코딩 되었을때는 다시 디코딩 해준다.
    url = decodeURIComponent(url);
 
    var params;
    // url에서 '?' 문자 이후의 파라미터 문자열까지 자르기
    params = url.substring( url.indexOf('?')+1, url.length );
    // 파라미터 구분자("&") 로 분리
    params = params.split("&");

    // params 배열을 다시 "=" 구분자로 분리하여 param 배열에 key = value 로 담는다.
    var size = params.length;
    var key, value;
    for(var i=0 ; i < size ; i++) {
        key = params[i].split("=")[0];
        value = params[i].split("=")[1];

        param[key] = value;
    }

    return param;
};

//이메일 발송

function sendEmail(parameter){
	M_NM = "";	/* 이름    */
	
	if(parameter.email == undefined){
		alert("이메일 발송에 실패하였습니다.");
		return;
	}
	M_EMAIL = parameter.email;/* 이메일 */
	M_MEMO1 = parameter.val1 == undefined ? "" : parameter.val1;/* 메모1 (50byte미만) */
	M_MEMO2 = parameter.val2 == undefined ? "" : parameter.val2;/* 메모2 (50byte미만) */
	M_MEMO3 = parameter.val3 == undefined ? "" : parameter.val3;/* 메모3 (50byte미만) */
	M_MEMO4 = parameter.val4 == undefined ? "" : parameter.val4;/* 메모4 (50byte미만) */
	M_MEMO5 = parameter.val5 == undefined ? "" : parameter.val5;/* 메모5 (50byte미만) */
	
	function _biz_trk_escape(_str) {
		var str, ch;
		var bEncURI = "N";
		eval("try{bEncURI=encodeURI('Y');}catch(_e){ }" );
		if( bEncURI == "Y" ) str=encodeURIComponent(_str);
		else str = escape(_str);
		while((ch=str.indexOf("+"))>0) str=str.substr(0,ch)+"%2B"+str.substr(ch+1,str.length);
		while((ch=str.indexOf("/"))>0) str=str.substr(0,ch)+"%2F"+str.substr(ch+1,str.length);
		while((ch=str.indexOf("&"))>0) str=str.substr(0,ch)+"%26"+str.substr(ch+1,str.length);
		while((ch=str.indexOf("?"))>0) str=str.substr(0,ch)+"%3F"+str.substr(ch+1,str.length);
		while((ch=str.indexOf(":"))>0) str=str.substr(0,ch)+"%3A"+str.substr(ch+1,str.length);
		while((ch=str.indexOf("#"))>0) str=str.substr(0,ch)+"%23"+str.substr(ch+1,str.length);
		return str;
	}
	
	function _biz_makeSrc(trk_server){
		var tc = "";
		var temp;
		var prtcl=document.location.protocol.indexOf("https")!=-1?"https://":"http://";
		tc=prtcl+trk_server;
		tc=tc+"?biz_id="+parameter.biz_id+"&auth_key="+parameter.templateNo+"";	//계정명 + 템플릿 번호
		if((typeof M_NM)!="undefined" && M_NM!="") tc+="&m_nm="+ encodeURIComponent(M_NM);
		if((typeof M_EMAIL)!="undefined" && M_EMAIL!="") tc+="&m_email="+_biz_trk_escape(M_EMAIL);
		if((typeof M_MOBILE)!="undefined" && M_MOBILE!="") tc+="&m_mobile="+_biz_trk_escape(M_MOBILE);
		if((typeof M_MEMO1)!="undefined" && M_MEMO1!="") tc+="&m_memo1="+_biz_trk_escape(M_MEMO1);
		if((typeof M_MEMO2)!="undefined" && M_MEMO2!="") tc+="&m_memo2="+_biz_trk_escape(M_MEMO2);
		if((typeof M_MEMO3)!="undefined" && M_MEMO3!="") tc+="&m_memo3="+_biz_trk_escape(M_MEMO3);
		if((typeof M_MEMO4)!="undefined" && M_MEMO4!="") tc+="&m_memo4="+_biz_trk_escape(M_MEMO4);
		if((typeof M_MEMO5)!="undefined" && M_MEMO5!="") tc+="&m_memo5="+_biz_trk_escape(M_MEMO5);
		return tc;
	}
	
	var _biz_trk_bMSIE = (document.all)?true:false;
	var _biz_trk_bJS12 = (window.screen)?true:false;
	var _biz_trk_code_base = _biz_makeSrc("www.bizmailer.co.kr/bizsmart/action/auto.do");
	var _biz_trk_img_base = new Image();
	
	if(_biz_trk_bJS12==true) {
		if(_biz_trk_bMSIE) {
			_biz_trk_img_base.src=_biz_trk_code_base;
		} 
		else {
			setTimeout(_biz_trk_img_base.src = _biz_trk_code_base ,1);
		}
	} else {
		if(_biz_trk_bMSIE) document.write('<div style=\"display: none\">');
		document.write('<img src=\"'+_biz_trk_code_base+'\" height=\"0\" width=\"0\">');
		if(_biz_trk_bMSIE) document.write('</div>');
	}
}

	// 현재 일시 상수 추가
	var date = new Date();
	var YYYY = date.getFullYear();		//년
	var MM = date.getMonth()+1;			//월
	var DD = date.getDate();			//일
	var HH = date.getHours();			//시간
	var SS = date.getMinutes();			//분
	
	// 공통 paging 처리
	function isPaging(form_id, url, totalCnt){

   		$('#prevPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());

			if(currentPageNo > totalCnt){
				$("[name='currentPageNo']").val(1);
			}else{
				$("[name='currentPageNo']").val(currentPageNo-1);
			}
	    	$("#"+form_id).attr({action :url, method : 'post'}).submit();
		});
		$('#nextPage').on("click",function(){

			var currentPageNo = Number($('[name="currentPageNo"]').val());
			
			if(currentPageNo > totalCnt){
				$("[name='currentPageNo']").val(1);
			}else{
				$("[name='currentPageNo']").val(currentPageNo+1);
			}
			
			$("#"+form_id).attr({action :url, method : 'post'}).submit();

		});
		$('#movePage').on("click",function(){

			// 숫자만 입력 가능 ( 문자일 경우 1페이지로 강제 치환 )
			if($('[name="currentPageNo"]').val() == ""){
				currentPageNo = 1;
			}
			
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			
			if(Number($('[name="currentPageNo"]').val()) < 1){
				currentPageNo = 1;
			}

			if((totalCnt < currentPageNo)){
				alert('입력한 값이 전체 페이지 수보다 큽니다.');
				return false;
			}else{
				$("[name='currentPageNo']").val(currentPageNo);
				$("#"+form_id).attr({action :url, method : 'post'}).submit();
			}
		});

	}
	
//////////////////////////////////////////////////////////////// 관리자 app용 공통 스크립트////////////////////////////////////////////////////////////
	//app 용 QRsacn
	var app = {
		deviceType : ''
	   ,deviceName : ''
	   ,couponTime : ''
	   ,rentType : ''
	   ,unLockType : ''
	   ,scanType : ''
	   ,isTest : false
	   ,targetUrl : ''
	   ,voucherSeq : ''
	   ,lat : 0
	   ,log : 0
	   ,timeOut : 10
	   ,checkDevice : function() {
			//디바이스 체크 fnc
			var mobileKeyWords = new Array('iPhone','iPad', 'BlackBerry', 'Android', 'Windows CE', 'LG', 'MOT', 'SAMSUNG', 'SonyEricsson');
			var deviceName = "";
			for (var word in mobileKeyWords){
				if (navigator.userAgent.match(mobileKeyWords[word]) != null){
					deviceName = mobileKeyWords[word];
					break;
				}
			}
			return deviceName;
		}
	    ,QRscanStart : function(){
			if(this.deviceType === 'android' || this.deviceType === "Android") {
			    window.android_admin.scanQR();
			} 
			if(this.deviceType === 'iPhone' || this.deviceType === 'iPad' || this.deviceType === 'ios') {
			    window.location='toApp://?{"call":"scanQR"}';
			}
		}
		,getUsrGpsInfo : function() {
			
			if(this.deviceType === 'android' || this.deviceType === "Android") {
	            window.android_admin.gpsStart();
	        } 
	        if(this.deviceType === 'iPhone' || this.deviceType === 'iPad'|| this.deviceType === 'ios') {
	            window.location='toApp://?{"call":"gpsStart"}';
	        }
	    }
		,showLoading : function() {
			
			if(this.deviceType === 'android' || this.deviceType === "Android") {
	            window.android_admin.showLoading(this.timeOut);
	        } 
	        if(this.deviceType === 'iPhone' || this.deviceType === 'iPad'|| this.deviceType === 'ios') {
	            window.location='toApp://?{"call":"showLoading"}';
	        }
	    }
		,hideLoading : function() {
			
			if(this.deviceType === 'android' || this.deviceType === "Android") {
	            window.android_admin.hideLoading();
	        } 
	        if(this.deviceType === 'iPhone' || this.deviceType === 'iPad'|| this.deviceType === 'ios') {
	            window.location='toApp://?{"call":"hideLoading"}';
	        }
	    }
		,lockStatus : function() {
			if (this.isTest) {
				alert('lockStatus');
				alert(this.deviceName);
			}
			
			if(this.deviceType === 'android' || this.deviceType === "Android") {
	            window.android_admin.lockStatus(this.deviceName);
	        } 
	        if(this.deviceType === 'iPhone' || this.deviceType === 'iPad'|| this.deviceType === 'ios') {
	            window.location='toApp://?{"call":"lockStatus"}';
	        }
	    }
		,lockRestart : function() {
			if (this.isTest) {
				alert('lockRestart');
				alert(this.deviceName);
			}
			
			if(this.deviceType === 'android' || this.deviceType === "Android") {
	            window.android_admin.lockRestart(this.deviceName);
	        } 
	        if(this.deviceType === 'iPhone' || this.deviceType === 'iPad'|| this.deviceType === 'ios') {
	            window.location='toApp://?{"call":"lockRestart"}';
	        }
	    }
		,unLock : function() {
			if (this.isTest) {
				alert('unLock');
				alert(this.deviceName);
			}
			
			if(this.deviceType === 'android' || this.deviceType === "Android") {
	            window.android_admin.unLock(this.deviceName, this.couponTime);
	        } 
	        if(this.deviceType === 'iPhone' || this.deviceType === 'iPad'|| this.deviceType === 'ios') {
	            window.location='toApp://?{"call":"unLock"}';
	        }
	    }
		,returnCheck : function() {
			if (this.isTest) {
				alert('returnCheck');
			}
			
			if(this.deviceType === 'android' || this.deviceType === "Android") {
	            window.android_admin.returnCheck(this.deviceName);
	        } 
	        if(this.deviceType === 'iPhone' || this.deviceType === 'iPad'|| this.deviceType === 'ios') {
	            window.location='toApp://?{"call":"returnCheck"}';
	        }
	    }
		,noReturnDataReset : function() {
			if (this.isTest) {
				alert('dataReset : '+this.deviceName);
			}
			if(this.deviceType === 'android' || this.deviceType === "Android") {
	            window.android_admin.noReturnDataReset(this.deviceName);
	        } 
	        if(this.deviceType === 'iPhone' || this.deviceType === 'iPad'|| this.deviceType === 'ios') {
	            window.location='toApp://?{"call":"noReturnDataReset"}';
	        }
	    }
	};
	/**
	 * QRcode 복호
	 * */
	var keyStr = "Aa0Bb1Cc2Dd3Ee4Ff5Gg6Hh7Ii8Jj9KkLlMmNnOoPpQqRrSsTtUuVvWwXx+Yy/Zz"; 
	//var keyStr = "Aa0Bb1Cc2Dd3Ee4Ff5Gg6Hh7Ii8Jh9KkLlMmNnOoPpQqRrSsTtUuVvWwXx+Yy/Zz" ;
	function decode64(input){
	    var output = "", chr1, chr2, chr3,enc1, enc2, enc3, enc4;
		var i = 0;
		input = input.replace(/[^A-Za-z0-9\+\/\=]/g, "");
		do {
			enc1 = keyStr.indexOf(input.charAt(i++));
			enc2 = keyStr.indexOf(input.charAt(i++));
			enc3 = keyStr.indexOf(input.charAt(i++));
			enc4 = keyStr.indexOf(input.charAt(i++));
			chr1 = (enc1 << 2) | (enc2 >> 4);
			chr2 = ((enc2 & 15) << 4) | (enc3 >> 2);
			chr3 = ((enc3 & 3) << 6) | enc4;
			
			output = output + String.fromCharCode(chr1);
			
			if (enc3 != 64) {
				output = output + String.fromCharCode(chr2);
			}
			if (enc4 != 64) {
				output = output + String.fromCharCode(chr3);
			}
		} while (i < input.length);
		return output;
	}

	function scanInfo(sInfo){
		
		//scan result callback fnc
	    //대여소 정보로 해당 대여소에 대한 정보 
	    //QRcode 정보에 대해서는 미정.
	    var infoObj = JSON.parse(sInfo);

		// 2021 06 14 추가
		if ( infoObj.scanInfo == null ) {
			alert("스캔에 실패하였습니다.");
			return;
		} 

	    //빅텍용 디코드
	    //var rId = unescape(decode64(infoObj.scanInfo));
	    var rId = escape(decode64(infoObj.scanInfo)).substring(0, 14);
	    if(rId !== '' && Number(infoObj.success) === 0){
	    	// QR 자전거 인 경우 메인에서 바로 처리
	    	if ((rId.indexOf("SSBK-") != -1) || (rId.indexOf("BRC-") != -1)) {
	    		// QR 단말기
	    		app.showLoading();
	    		if (app.scanType === 'move') {
	    			// 관리 이동
	    			commonAjax.postAjax('/bike/getQRBikeCodeDataInfo.do', "json", {rackId:rId} ,function(data){
		    			if(data.result) {
		    				if (data.resultCode == -1) {
		    					// login error
		    					app.hideLoading();
		    					alert('로그인 후 다시 시도해 주세요.');
		    					return;
		    				} else if (data.resultCode == -2) {
		    					// qr error
		    					app.hideLoading();
		    					alert('등록되지 않은 QR 코드 입니다.');
		    					return;
		    				} else if(data.resultCode == -3){//해당 자전거 대여중
		    					
		    					app.hideLoading();
		    					alert("현재 대여 중인 자전거입니다.\r강반 처리 후 진행해 주시길 바랍니다.");
		    					return;
		    					
		    				} else if (data.resultCode == -99) {
		    					app.deviceName = data.qrData.deviceName;
		    					app.unLockType = 'force';
		    					app.couponTime = 60;
	        					app.unLock();
	        					return;
		    				} else {
		    					if (data.qrData.bikeId != '') {
			        				$("#deviceId").val(data.qrData.deviceId);
			        				$("#bikeId").val(data.qrData.bikeId);
			        				$("#rackId").val(data.qrData.rackId);
			        				$("#stationId").val(data.qrData.stationId);
			        				$("#deviceName").val(data.qrData.deviceName);
			        				
			        				if (data.qrData.deviceName != '') {
			        					app.deviceType = 'android';
			        					app.deviceName = data.qrData.deviceName;
			        					if (app.isTest) {
			        						alert(app.deviceName);
			        					}
			        					
			        					app.couponTime = 60;
			        					app.unLock();
			        				}
			    				} else {
			    					app.hideLoading();
			    					alert('대여가 불가능한 자전거 입니다.');
			    					return;
			    				}
			    				app.hideLoading();
			    				return;
		    				}
		    			} else {
		    				$('#progress').css('display','none');
		    				alert('대여가 불가능한 자전거 입니다.');
		    				app.hideLoading();
		    				return;
		    			}
		            }); 
	    		} else if (app.scanType === 'check') {
	    			alert('자전거 상태 체크');
	    			app.deviceName = rId;
	    			app.lockStatus();
	    		} else if (app.scanType === 'relocate') {
	    			alert('재배치 완료 처리');
	    			app.deviceName = rId;
	    			app.returnCheck();
	    			
	    		} else if (app.scanType === 'relocateNew') {
	    			
	    			commonAjax.postAjax('/bike/exeQRBikeRelocateNew.do', "json",  {bikeNo:rId}  ,function(data){
	    				
	    				if(data.result){
	    					if ( data.cnt > 0 ) {
	    					 alert("정상 처리되었습니다. \r\n " + data.cnt + "건 처리완료되었습니다." );
	    					} else {
	    						alert("처리건수가 없습니다. 재배치 정상 처리 완료 후 확인 부탁드립니다.");
	    					}
	    				}else{
	    					
	    					app.hideLoading();
	    					alert("재배치에 실패하였습니다. 다시 시도해 주세요.");
	    					return;
	    					
	    				}
	    				
	    			});
	    			return;
	    			
	    			
	    			
	    		} else if (app.scanType === 'reset') {
	    			
	    			commonAjax.postAjax('/bike/getQRBikeInfo.do', "json", {rackId:rId} ,function(data){
	    				
	    				if(data.result){
	    					
	    					if(data.bikeStatusCd != "BKS_010"){
	    						
		    					alert('단말기 리셋');
		    					app.deviceName = rId;
		    					app.lockRestart();
		    					
	    					}else{
	    						
	    						app.hideLoading();
		    					alert("현재 대여 중인 자전거입니다.\r강반 처리 후 진행해 주시길 바랍니다.");
		    					return;
	    						
	    					}
	    					
	    				}else{
	    					
	    					app.hideLoading();
	    					alert("다시 시도해 주세요.");
	    					return;
	    					
	    				}
	    				
	    			});
	    			
	    		}
	    		
	    	} else {
	    		app.hideLoading();
	    		alert('자전거를 인식해 주세요.');
	    		return;
	    	}
	    } else {
	        return false;
	    }
	}

// 	function bleScanFinish(){

// alert("블루투스 스캔 종료");
// return;

// 	}

	function scanInfoDirect(sInfo){
		//scan result callback fnc
	    var infoObj = JSON.parse(sInfo);
	    //var rId = unescape(decode64(infoObj.scanInfo));
	    //var rId = 'BRC-' + infoObj.scanInfo;
	    var rId = infoObj.scanInfo;

	    if(rId !== '' && Number(infoObj.success) === 0){

	    	// QR 단말기
    		app.showLoading();
    		if (app.scanType === 'move') {
    			// 관리 이동
    			commonAjax.postAjax('/bike/getQRBikeCodeDataInfo.do', "json", {rackId:rId} ,function(data){
	    			if(data.result) {
	    				if (data.resultCode == -1) {
	    					// login error
	    					app.hideLoading();
	    					alert('로그인 후 다시 시도해 주세요.');
	    					return;
	    				} else if (data.resultCode == -2) {
	    					// qr error
	    					app.hideLoading();
	    					alert('등록되지 않은 QR 코드 입니다.');
	    					return;
	    				} else if (data.resultCode == -99) {
	    					app.deviceName = data.qrData.deviceName;
	    					app.unLockType = 'force';
	    					app.couponTime = 60;
        					app.unLock();
        					return;
	    				} else {
	    					if (data.qrData.bikeId != '') {
		        				$("#deviceId").val(data.qrData.deviceId);
		        				$("#bikeId").val(data.qrData.bikeId);
		        				$("#rackId").val(data.qrData.rackId);
		        				$("#stationId").val(data.qrData.stationId);
		        				$("#deviceName").val(data.qrData.deviceName);
		        				
		        				if (data.qrData.deviceName != '') {
		        					app.deviceType = 'android';
		        					app.deviceName = data.qrData.deviceName;
		        					if (app.isTest) {
		        						alert(app.deviceName);
		        					}
		        					
		        					app.couponTime = 60;
		        					app.unLock();
		        				}
		    				} else {
		    					app.hideLoading();
		    					alert('대여가 불가능한 자전거 입니다.');
		    					return;
		    				}
		    				app.hideLoading();
		    				return;
	    				}
	    			} else {
	    				$('#progress').css('display','none');
	    				alert('대여가 불가능한 자전거 입니다.');
	    				app.hideLoading();
	    				return;
	    			}
	            }); 
    		} else if (app.scanType === 'check') {
    			alert('자전거 상태 체크');
    			app.deviceName = rId;
    			app.lockStatus();
    		} else if (app.scanType === 'relocate') {
    			app.deviceName = rId;
    			
    			alert('재배치 완료 처리 : ' + rId );
    			
    			app.returnCheck();
    			
    		} else if (app.scanType === 'relocateNew') {
    			
    			commonAjax.postAjax('/bike/exeQRBikeRelocateNew.do', "json",  {bikeNo:rId}  ,function(data){
    				
    				if(data.result){
    					if ( data.cnt > 0 ) {
    					 alert("정상 처리되었습니다. \r\n " + data.cnt + "건 처리완료되었습니다." );
    					} else {
    						alert("처리건수가 없습니다. 재배치 정상 처리 완료 후 확인 부탁드립니다.");
    					}
    				}else{
    					
    					app.hideLoading();
    					alert("재배치에 실패하였습니다. 다시 시도해 주세요.");
    					return;
    					
    				}
    				
    			});
    			return;    			
    			
    			
    		} else if (app.scanType === 'reset') {
    			alert('단말기 리셋');
    			app.deviceName = rId;
    			app.lockRestart();
    		}
	    } else {
	    	app.hideLoading();
	    	alert('자전거를 인식해 주세요.');
    		return;
	    }
	}
	
	//단말기에서 gps정보 return callback function
	function chkGpsInfo(info){
		//alert(info);
	    var jInfo = JSON.parse(info);
	    if(typeof jInfo !== 'undefined'){
	        if(Number(jInfo.gpsStatus) === 0){
	            var loc = jInfo.gpsLoc;
	            if(loc){
	            	app.lat = loc.lat;
	            	app.log = loc.log;
	            	if (typeof nMap !== 'undefined' && nMap !== null) {
	            		nMap.setGPSLoc(loc.lat,loc.log);
	            	}
	            }
	        
	        }
	    }
	}

	//단말기에서 resopnse callback function
	function lockerResponse(info){
	    var jInfo = JSON.parse(info);
	    if(typeof jInfo !== 'undefined'){
	    	var command = jInfo.command;
	    	if (command == 'LOCK_OPEN') {
	    		// 락 오픈
	    		if (app.isTest) {
	    			alert('lock 상태 : '+jInfo.result.lockStatus);
				}
	    		
	    		if (app.unLockType == '') {
	    			if (jInfo.result.lockStatus == 'OPEN') {
	        			// 대여 실행
	        			// QR 단말기
	    				
	        			// QR 단말기
	    				if( $("#QRfrm #bikeId").val() =="" ) {
	    					alert("관리 이동처리에 실패하였습니다. \r\n 앱 종료 후, 다시 로그인하여, 재배치를 부탁드립니다.");
	    					return;
	    				}
	    				
	    				
			    		commonAjax.postAjax('/bike/exeQRBikeMove.do', "json", $("#QRfrm").serialize() ,function(data){
			    			if(data.result) {
			    				app.hideLoading();
		    					alert('관리 이동 처리 되었습니다.');
		    					return;
			    			} else {
			    				app.hideLoading();
			    				alert('관리 이동 실패\n\n다시 시도해 주세요.');
			    				return;
			    			}
			            });
	        		} else {
	        			app.hideLoading();
	        			alert('관리 이동 실패\n\n다시 시도해 주세요.');
	        			return;
	        		}
	    		} else {
	    			app.hideLoading();
	    			alert('임시 잠금 해제');
	    			return;
	    		}
	    	} else if (command == 'LOCK_RETURN_STATUS') {
	    		// 재배치 완료 처리
	    		var beaconId = jInfo.result.beaconId;
	    		
	    		if (beaconId !== '') {
		    		// QR 단말기
		    		commonAjax.postAjax('/bike/exeQRBikeRelocate.do', "json", {beaconId:beaconId} ,function(data){
		    			if(data.result) {
	    					app.hideLoading();
	    					alert('재배치 완료 처리 성공.');
		    				return;
		    			} else {
		    				app.hideLoading();
		    				alert('재배치 완료 처리가 불가능한 장소 입니다.');
		    				return;
		    			}
		            });
	    		} else {
	    			app.hideLoading();
	    			alert('비콘 인식 실패.\\다시 시도해 주십시오.');
	    			return;
	    		}
	    		
	    	} else if (command == 'LOCK_STATUS') {
	    		
	    		if (app.isTest) {
	    			alert('lock 상태 : '+jInfo.result.lockStatus);
				}
	    		alert('lock 상태 : '+jInfo.result.lockStatus + '\n\n자전거 상태 : '+jInfo.result.bikeStatus);
	    		app.hideLoading();
	    		return;
	    	}
	        
	    }
	}

	///////////////////////////////////////////end//////////////////////////////////////////////////
	function JSONtoString(object) {
		var results = [];
		for (var property in object) {
			var value = object[property];
			if (value)
				results.push(property.toString() + ': ' + value);
			}
					
			return '{' + results.join(', ') + '}';
	}

	
//단말기에서 resopnse callback function
function newlockerResponse(info){
	
    var jInfo = JSON.parse(info);
    if(typeof jInfo !== 'undefined'){
    	var command = jInfo.command;

    	if (command == 'LOCK_OPEN') {
			// 20210615 수정
    		// if (app.unLockType == '') {
    			if (jInfo.result.lockStatus == 'OPEN') {
        			    				
        			// QR 단말기
    				if( $("#QRfrm #bikeId").val() =="" ) {
    					alert("관리 이동처리에 실패하였습니다. \r\n 앱 종료 후, 다시 로그인하여, 재배치를 부탁드립니다.");
    					return;
    				}
    				
		    		commonAjax.postAjax('/bike/exeQRBikeMove.do', "json", $("#QRfrm").serialize() ,function(data){
		    			if(data.result) {
		    				app.hideLoading();
	    					
		    				alert('관리 이동 처리 되었습니다. [' + data.bikeNo + ']  이전 상태 [' + data.bikeStatusName + '], 배터리 : ' + data.useCnt  );
	    					
		    				$("#bikeNoSearch").val(data.bikeNo);
		    				
	    					
	    					return;
		    			} else {
		    				
		    				
		    				
		    				app.hideLoading();
		    				
		    				if ( data.resultCode == "-2" ) {
		    					alert("로그인을 다시 해주시고 시도 부탁드립니다.");
		    				} else {
		    					alert('관리 이동 실패\n\n다시 시도해 주세요.');
		    					
		    				}
		    				return;
		    			}
		            });
        		} else {
        			app.hideLoading();
        			alert('관리 이동 실패\n\n다시 시도해 주세요.');
        			return;
        		}

    		// } else {
    		//	app.hideLoading();
    		//	alert('임시 잠금 해제');
    		//	return;
    		// }
    	} else if (command == 'LOCK_RETURN_STATUS') {
    		
			// 재배치 완료 처리
    		var beaconId = jInfo.result.beaconId;
    		
    		if (beaconId !== '') {
	    		// QR 단말기
	    		commonAjax.postAjax('/bike/exeQRBikeRelocate.do', "json", {beaconId:beaconId} ,function(data){
	    			if(data.result) {
    					app.hideLoading();
    					alert('재배치 완료 처리 성공.');
	    				return;
	    			} else {
	    				app.hideLoading();
	    				alert('재배치 완료 처리가 불가능한 장소 입니다.');
	    				return;
	    			}
	            });
    		} else {
    			app.hideLoading();
    			alert('비콘 인식 실패.\\다시 시도해 주십시오.');
    			return;
    		}
    		
    	} else if (command == 'LOCK_STATUS') {
    		
    		if (app.isTest) {
    			alert('lock 상태 : '+jInfo.result.lockStatus);
			}
    		alert('lock 상태 : '+jInfo.result.lockStatus + '\n\n자전거 상태 : '+jInfo.result.bikeStatus);
    		app.hideLoading();
    		return;
    	}
        
    }
}


