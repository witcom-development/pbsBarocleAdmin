<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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
        <div class="allwrap pop">
        	<form id="frm">
        		<input type="hidden" name="faultSeq" value="${resultVo.faultSeq == null ? '' : resultVo.faultSeq}">
        		<input type="hidden" name="mode" value="${mode}">
        		<input type="hidden" name="deviceType" value="${deviceType}">
        		<input type="hidden" name="equipmentId" value="${troubleReportVo.equipmentId}">
        		<input type="hidden" name="stationId" value="${resultVo.stationId == null ? troubleReportVo.stationId : resultVo.stationId}">
        		<input type="hidden" name="reportId" value="${resultVo.reportId == null ? troubleReportVo.reportId : resultVo.reportId}">
        		<input type="hidden" name="faultCode" value="${resultVo.faultCode}">
        		<input type="hidden" name="faultContent" value="${resultVo.faultContent}">
	            <table class="tb_type02 mt20">
	                <colgroup>
						<col style="width:30%">
						<col style="width:70%">
					</colgroup>
					<tbody>
						<tr>
							<th class="top"><em>*</em> 거치대 ID</th>
							<td class="top"><span class="input-text01p"><input type="text" readonly="readonly" value="${resultVo.equipmentId == null ? troubleReportVo.equipmentId : resultVo.equipmentId}"></span></td>
						</tr>
						<tr>
							<th><em>*</em> 대여소명/번호</th>
							<td>${resultVo.stationName == null ? troubleReportVo.stationName : resultVo.stationName}</td>
						</tr>
						<tr>
							<th><em>*</em> 신고자 ID</th>
							<c:if test="${mode != 'view'}">
								<td>${troubleReportVo.reportId}</td>
							</c:if>
							<c:if test="${mode == 'view'}">
								<td>${resultVo.reportId}</td>
							</c:if>
						</tr>
						<tr>
							<th><em>*</em> 고장상태</th>
							<td id="troubleStatus">
							</td>
						</tr>
						<tr>
							<th><em>*</em> 비고</th>
							<td><textarea name="faultComment" class="detatextarea">${resultVo.faultContent}</textarea></td>
						</tr>
					</tbody>
	            </table>
	        </form>
            <div class="btnArea">
                <span class="right">
                	<c:if test="${mode != 'view'}">
                	<button class="btnType01" id="saveBtn">저장</button>
                	</c:if>
                	<button class="btnType01" id="cancelBtn">취소</button>
                </span>
            </div>
        </div>
    </div>
    <a href="#" class="popclose"><img src="/images/btn_close.png" alt="팝업닫기" /></a>
    <script type="text/javascript" src="/js/common_barocle.js"></script>
    <script type="text/javascript">
    $(function() {
    	commonAjax.getCommonCode("ELC", function(data){
    		if(data !== null && data.codeList !== null) {
           	 	for(var i = 0; i < data.codeList.length; i++){
            		$('<span class="pwtableblock input-ck01"><input type="checkbox" id="c'+i+'" value="'+data.codeList[i].comCd+'"/><label for="c'+i+'">'+data.codeList[i].comCdName+'</label></span>').appendTo('#troubleStatus');
           	 	}
            }
    		if('${mode == "insert"}' != 'true'){
        		var faultSeq = '${resultVo.faultSeq == null ? "" : resultVo.faultSeq}';
        		commonAjax.getFaultList(faultSeq,
          			function(data) {
          		        if(data) {
          		        	if(data.faultList.length > 0) {
          		        		var uSize = data.faultList.length;
          		        		for(var i=0; i < uSize; i +=1) {
          		        			$("input[value='"+data.faultList[i].faultCode+"'").prop('checked', true);		
          		        		}
          		        	}
          		        }
          		    }
               	);
        		if('${mode == "view"}' == 'true'){
        			$('input[type="checkbox"]').prop('disabled', true)
        		}
        	}
    	});
    	
    	$("#saveBtn").on("click", function(e) {
    	    e.preventDefault();
    	    
	    	var faultCode = "";
	    	$('input[type="checkbox"]:checked').each(function(e){
	    		if(faultCode.length > 0){
	    			faultCode = faultCode+",";
	    		}
	    		faultCode = faultCode+$(this).val();
			});
	    	$('[name="faultCode"]').val(faultCode);
	    	
	    	var faultContent = $('[name="faultComment"]').val();
	    	
	    	$('[name="faultContent"]').val(faultContent);
    	   
	    	if(faultCode.length == 0){
	    		alert('<spring:message code="fail.input.emptyValue2" arguments="고장상태"/>');
	    		return;
	    	}
	    	
	    	if($('[name="faultComment"]').val() == ''){
	    		alert('<spring:message code="fail.input.emptyValue2" arguments="비고"/>');
	    		return;
	    	}
	    	
	    	commonAjax.postAjax("/common/pop/exeTroubleAjax.do", 'json', $("#frm").serialize()
       			, function(data){
   	        	if(data.resultMessage == 'Insert'){
   	        		var isChk = data.checkResult === '-1' ? true : false;
                    if(isChk) {
                       alert('<spring:message code="fail.fault.exist.chk" arguments="거치대"/>');  
                       return false;
                    }
   	        		alert('<spring:message code="success.common.insert2" arguments="고장신고"/>');
   	        		opener.reloadPage();
   	        		window.close();
   	        	}else if(data.resultMessage == 'Update'){
   	        		alert('<spring:message code="success.common.update2" arguments="고장신고"/>');
   	        	}else{
   	        		alert('작업이 정상적으로 실행되지 않았습니다.');
   	        	}
            });
    	});
    	
		$("#cancelBtn").on("click", function(e) {
			e.preventDefault();
			window.close();
		});
    });
    </script>
</body>
</html>
