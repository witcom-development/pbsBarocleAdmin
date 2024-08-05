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
			<c:forEach var="result" items="${nonPaymentVO.nonPayList}" varStatus="status">
				<input type="hidden" name="nonPayList[${status.index}].paymentMethodCd" value="${result.paymentMethodCd}">
				<input type="hidden" name="nonPayList[${status.index}].rentHistSeq" value="${result.rentHistSeq}">
				<input type="hidden" name="nonPayList[${status.index}].rentDttm" value="${result.rentDttm}">
				<input type="hidden" name="nonPayList[${status.index}].usrSeq" value="${result.usrSeq}">
				<input type="hidden" name="nonPayList[${status.index}].overFee" value="${result.overFee}">
			</c:forEach>
		</form>
		<form id="frmCon">
			<input type="hidden" name="viewFlg" value="${viewFlg}">
			<input type="hidden" name="overFeeProcessClsCd" value="">
			<input type="hidden" name="paymentMethodCd" value="">
			<input type="hidden" name="processReasonDesc" value="">
		</form>
		<div class="allwrap pop">
			<table class="tb_type02 mt20">
				<colgroup>
					<col style="width:30%">
					<col style="width:70%">
				</colgroup>
				<tbody>
					<tr>
						<th class="top">미납요금 처리</th>
						<td class="top">
							<span class="input-rd01"><input type="radio" id="a3" name="radioChkType" value="OPD_001" checked="checked"><label for="a3">계좌납부</label></span>
							<span class="input-rd01"><input type="radio" id="a4" name="radioChkType" value="OPD_003" ><label for="a4">미납요금삭제</label></span>
						</td>
					</tr>
					<tr>
						<th>비고</th>
						<td><textarea class="detatextarea" name="processReasonDesc" id="processReasonDesc"></textarea></td>
					</tr>
				</tbody>
			</table>
			<div class="btnArea">
				<span class="right">
					<button class="btnType01" id="saveBtn">저장</button>
					<button class="btnType01" id="cancelBtn">취소</button>
				</span>
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
    	$("#saveBtn").on("click", savePayment);
    });
	
	function savePayment(e) {
    	e.preventDefault();
    	
    	var radioChkType = $(':radio[name="radioChkType"]:checked').val();
    	$("input:hidden[name='overFeeProcessClsCd']").val(radioChkType);
    	if(radioChkType == "OPD_001"){
    		$("input:hidden[name='paymentMethodCd']").val("BIM_005");
    	} else {
    		$("input:hidden[name='paymentMethodCd']").val("");
    	}
    	var desc = $('#processReasonDesc').val();
    	$("input:hidden[name='processReasonDesc']").val(desc);
    	
    	pData = $("#frmCon").serialize();
    	pDataList = $("#frmList").serialize();
    	
    	commonAjax.postAjax("/addNonPayment.do", "json", pData + "&nonPayList=" + pDataList
    		,function(data){
    			if(data) {
					alert(data.resultMessage);
					window.close();
					opener.reloadList();
    		    } else {
    		    	alert(data.resultMessage);
    		    	return false;
    		    }
    		}
    	);
    };
	</script>
</body>
</html>
