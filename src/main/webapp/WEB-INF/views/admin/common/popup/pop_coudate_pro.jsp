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
</head>
<body>
	<h1 class="popTt"></h1>
	<div class="cntbox">
		<form id="frmList">
			<c:forEach var="result" items="${svcCouponMgmtVO.svcCouponSeqList}" varStatus="status">
				<input type="hidden" name="svcCouponSeqList" value="${result }">
			</c:forEach>
			<input type="hidden" name="couponEndDttm" value="">
			<input type="hidden" name="extendReasonDesc" value="">
		</form>
		
		<div class="allwrap pop">
            <table class="tb_type02 mt20">
                <colgroup>
                    <col style="width:30%">
                    <col style="width:70%">
                </colgroup>
                <tbody>
                    
                    <tr>
                        <th>유효기간 종료일</th>
                        <td>
                            <span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04"  title="선택 날짜" id="bb22" readonly/></span>
                            <span>
                                <select name="selectHour">
                                    <c:forEach begin="0" end="23" step="1" varStatus="loop">
                                        <c:if test="${loop.index < 10 }">
                                        <option value="0${loop.index }" >0${loop.index }</option>
                                        </c:if>
                                        <c:if test="${loop.index > 9 }">
                                        <option value="${loop.index }">${loop.index }</option>
                                        </c:if>
                                    </c:forEach>                  
                                </select>시
                                <select name="selectMinute">
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
						<th>사유 </th>
						<td>
							<textarea id="extendDesc" name="extendDesc" class="detatextarea"></textarea>
						</td>
					</tr>
                    
                </tbody>
            </table>
            <div class="btnArea">
                <span class="right">
	                <button class="btnType01" id="saveBtn">저장</button>
	                <button class="btnType01" id="cancelBtn">취소</button>
                </span>
                <p class="tc mt40" id="sendTxt" style="color: #330066;font-size: 18px;font-weight: bold;display: none;"></p>
            </div>
        </div>
				
	</div>
	<a href="#" class="popclose"><img src="/images/btn_close.png" alt="팝업닫기" /></a>
	<script type="text/javascript" src="/js/common_barocle.js"></script>
	<script type="text/javascript">
	$(function() {
    	$("#cancelBtn").on("click", function(e){
    		e.preventDefault();
    		window.close();
    	});
    	
    	$("#saveBtn").on("click", function(e){
	    	if($("#bb22").val() !== '') {
		    	
		    	selectDate = $("#bb22").val()+' '+$("[name='selectHour']").val()+':'+$("[name='selectMinute']").val();
	            $("[name='couponEndDttm']").val(selectDate);
	            $("[name='extendReasonDesc']").val($("[name='extendDesc']").val());
		    	/* alert($("[name='extendDesc']").val());
		    	alert($("[name='extendReasonDesc']").val());
		    	return false; */
	    	} else {
	    		 
	                  alert("유효기간을 설정해주세요."); 
	                  return false;
	                  
	    	}
		
				$("#saveBtn").attr("disabled", true);
				commonAjax.postAjax("/changeDateSvcCouponProc.do", "json", 
		   				$("#frmList").serialize(), 
		   				function(data) {
			   				if(data) {
								if(data.isSuccess == "true") {
									alert("저장되었습니다.");
									window.close();
									opener.location.reload();
									
								} else {
									alert("저장 실패하였습니다.");
			   						$("#saveBtn").attr("disabled", false);
								}
							}
				});
	    	
    	});
    });
	
     function checkVal(frm) {
 		var rst = false;
 		$(frm).find("input[type='text']").each(function() {
 			if(!isNumeric($(this).val())) {
 	        	alert("숫자만 입력가능 합니다.");
 	        	$(this).val("").focus();
 	        	rst = true;
 	        	return false;
 	        }
 		});
 		if(rst)
 			return false;

 		
 		
 		return true;
 	}
	</script>
</body>
</html>
