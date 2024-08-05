<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" /> 
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />
<meta name="description=" Content="" />
<%@ include file="../popup/pop_resource.jsp" %>
<script type="text/javascript">
if('${memberVo.listType}' === 'AS' && '${checkResult}' === 'true') {
    alert('저장 완료 되었습니다.');
    window.close();
}
</script>
</head>
<body>
    <h1 class="popTt"></h1>
    <div class="cntbox">
        <form id="frm">
        <input type="hidden"  name="bookYn" value=""/>
        <input type="hidden"  name="bookDate" value=""/>
        <c:if test="${ memberVo ne null }">
	        <input type="hidden"  name="searchStartDate" value="${memberVo.searchStartDate }"/>
	        <input type="hidden"  name="searchEndDate" value="${memberVo.searchEndDate }"/>
	        <input type="hidden"  name="usr_cls_cd" value="${memberVo.usr_cls_cd}"/>
	        <input type="hidden"  name="searchParameter" value="${memberVo.searchParameter}"/>
	        <input type="hidden"  name="searchValue" value="${memberVo.searchValue}"/>
	        <input type="hidden"  name="listType" value="${memberVo.listType}"/>
        </c:if>
        <div class="allwrap pop">
            <table class="tb_type02 mt20">
                <colgroup>
                    <col style="width:30%">
                    <col style="width:70%">
                </colgroup>
                <tbody>
                    <tr>
                        <th class="top">전화번호</th>
                        <td class="top" id="phoneTxt">
                        <c:if test="${memberVo.listType eq 'A' }">
	                        전체발송
                        </c:if>
                        </td>
                    </tr>
                    <tr>
                        <th>발송구분</th>
                        <td>
                            <select id="sendClsSlt" name="sendClsName">
                                <option value="">전체</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th>예약발송</th>
                        <td>
                            <span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04"  title="선택 날짜" id="bb22" readonly/></span>
                            <span>
                                <select name="bookHour">
                                    <option value="">선택</option>
                                    <c:forEach begin="1" end="24" step="1" varStatus="loop">
                                        <c:if test="${loop.index < 10 }">
                                        <option value="0${loop.index }" >0${loop.index }</option>
                                        </c:if>
                                        <c:if test="${loop.index > 9 }">
                                        <option value="${loop.index }">${loop.index }</option>
                                        </c:if>
                                    </c:forEach>                  
                                </select>시
                                <select name="bookMinute">
                                    <option value="">선택</option>
                                    <c:forEach begin="0" end="59" step="1" varStatus="loop">
                                        <c:if test="${loop.index < 10 }">
                                        <option value="0${loop.index }" >0${loop.index }</option>
                                        </c:if>
                                        <c:if test="${loop.index > 9 }">
                                        <option value="${loop.index }">${loop.index }</option>
                                        </c:if>
                                    </c:forEach>
                                </select>분
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <th>발송내용</th>
                        <td><textarea name="smsMsg" id="sendMsg" class="detatextarea"></textarea></td>
                        
                    </tr>
                </tbody>
            </table>
            <div class="btnArea">
                <span class="right">
	                <button class="btnType01" id="sendBtn">저장</button>
	                <button class="btnType01" id="cancelBtn">취소</button>
                </span>
                <p class="tc mt40" id="sendTxt" style="color: #330066;font-size: 18px;font-weight: bold;display: none;"></p>
            </div>
        </div>
        </form>
    </div>
    <a href="#" class="popclose"><img src="/images/btn_close.png" alt="팝업닫기" /></a>
    <script type="text/javascript" src="/js/common_barocle.js"></script>
    <script type="text/javascript">
    $(function() {
        initPop();
    });
    var mpnNoList = '${UsrMpnNo}';
    var mpnList = [];
    function initPop() {
    	if(mpnNoList !== null && mpnNoList !== '') {
            mpnList = mpnNoList.split(",");
	        makeSmsList(mpnList);      
	        var showTxt = mpnList[0];
	        if((mpnList.length -1) >  0){
	            showTxt = showTxt+" 외"+ (mpnList.length -1)+"명";    
	        }
	        $("#phoneTxt").text(showTxt);
        }
        //발송구분 콤보박스 데이터
        commonAjax.getAjax("/common/pop/getSmsMessageList.do", "json",{},makeSmsSelect);

        $("#sendClsSlt").on("change", sendCdSltChange);
        $("#cancelBtn").on("click", closePop);
        $("#sendBtn").on("click", exeSendMsg);
    }
    function makeSmsSelect(data) {
    	if(data) {
    		if(data.smsMsgList !== null) {
    			var mSize = data.smsMsgList.length;
    			for(var i=0; i<mSize; i+=1) {
    				var $op = $("<option>", { value : data.smsMsgList[i].smsSeq, msg :data.smsMsgList[i].smsMsg }).text(data.smsMsgList[i].sendClsName);
    				$("#sendClsSlt > option").last().after($op);
    			}
    		}
    	}
    }
    
    function makeSmsList(mpnNoList) {
    	var mSize = mpnNoList.length;
    	var mpnArray = [];
    	for(var i=0; i< mSize; i+=1) {
    		mpnArray.push($("<input>",{'type' : 'hidden', 'name': 'mprNoList['+i+']'}).val(mpnNoList[i]));
    	}
    	$("#frm").append(mpnArray);
    }
    function exeSendMsg(e) {
    	e.preventDefault();
    	var chk = 0;
    	var bookDate ='';
    	if($("#bb22").val() !== '') {
	    	if(($("[name='bookHour']").val() === '' &&  $("[name='bookMinute']").val() !== '') 
	    			|| ($("[name='bookHour']").val() !== '' &&  $("[name='bookMinute']").val() === '') ) {
	    	    alert("발송 예약 시간을 설정해주세요."); 
	    	    chk = 1;
	    		return false;
	    	}
	    	bookDate = $("#bb22").val()+' '+$("[name='bookHour'").val()+':'+$("[name='bookMinute'").val();
            $("[name='bookDate']").val(bookDate);
	    	
    	} else {
    		  if($("[name='bookHour']").val() !== '' &&  $("[name='bookMinute']").val() !== '') {
                  alert("발송 예약 시간을 설정해주세요."); 
                  chk = 1;
                  return false;
              }
    	}
    	if($("#sendMsg").val() === '') {
    		alert('발송내용을 입력해 주세요.');
    		chk = 1;
    		return false;
    	}
    	if(chk === 0) {
    		if('${memberVo.listType}' === 'A') {
    			$(".right").css("display","none");
    			$("#sendTxt").css("display","");
    			$("#sendTxt").text('전송중 입니다.');
    			$("[name='listType']").val("AS");
    		    $("#frm").attr({action: '/common/pop/sendAllSmsMessage.do'}).submit();	
    		} else {
		    	commonAjax.postAjax("/common/pop/sendSmsMessage.do", "json",$("#frm").serialize()
		    		,function(data){
		    		     if(data) {
		    		    	 if(data.checkResult) {
		    		    		 alert("저장 완료했습니다.");
		    		    		 closePop();
		    		    	 }
		    		     }
		    	});
    		}
    	}
    }
    function sendCdSltChange(e) {
    	e.preventDefault();
    	var msg = $(e.target).find("option:selected").attr("msg");
    	$("#sendMsg").text(msg);
    }
    
    function closePop() {
    	window.close();
    }
    </script>
</body>
</html>
