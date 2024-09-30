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
	<form id="frm">
			<input type="hidden" id ="viewFlg" name="viewFlg" value="${viewFlg}">
			<input type="hidden" name="couponNo" value="${couponNo}">
			<input type="hidden" name="paymentSeq" value="${paymentVO.paymentSeq}">
			<input type="hidden" name="paymentDttm" value="${paymentVO.paymentDttm}">
			<input type="hidden" name="useYn" id="useYn" value="${paymentVO.useYn}">
			
			<div class="allwrap pop">
				<table class="tb_type02 mt20">
					<colgroup>
						<col style="width:30%">
						<col style="width:70%">
					</colgroup>
					<tbody>
						<tr>
							<th class="top">아이디</th>
							<td class="top" name="usrMainId">${paymentVO.usrMainId}</td>
						</tr>
						<%-- <tr>
							<th>이용권 사용 유무</th>
							<td name="usrMainId">
								<c:if test="${paymentVO.useYn == 'Y'}">
									사용
								</c:if>	
								<c:if test="${paymentVO.useYn == 'N'}">
									미사용
								</c:if>	
							</td>
						</tr>
						<tr>
							<th>취소가능 여부</th>
							<td name="usrMainId">
								<c:if test="${paymentVO.useYn == 'Y'}">
									불가
								</c:if>	
								<c:if test="${paymentVO.useYn == 'N'}">
									가능
								</c:if>	
							</td>
						</tr> --%>
						<tr>
							<th>취소 사유</th>
							<td><textarea class="detatextarea" maxlength=250 name="cancelReasonDesc">${paymentVO.cancelReasonDesc}</textarea></td>
						</tr>
					</tbody>
				</table>
				<div class="btnArea">
					<span class="right">
					<c:if test="${viewFlg != 'view'}">
						<button class="btnType01" id="saveBtn">저장</button>
					</c:if>
						<!-- <button class="btnType01" id="enBtn">강제취소</button> -->
						<button class="btnType01" id="cancelBtn">취소</button>
					</span>
				</div>
			</div>
		</form>
	</div>
	<a href="#" class="popclose"><img src="/images/btn_close.png" alt="팝업닫기" /></a>
	<script type="text/javascript" src="/js/common_barocle.js"></script>
	<script type="text/javascript">
	$(function() {
		var viewFlg = "${viewFlg}";
		
		if(viewFlg == "view"){
			$("[name=cancelReasonDesc]").attr("readonly",true);
		} else {
			$("[name=cancelReasonDesc]").attr("readonly",false);
		}
		
		$("#cancelBtn").on("click", function(e){
			e.preventDefault();
			window.close();
		});
		
		<c:if test="${paymentVO.useYn == 'Y'}">
			alert("이미 사용한 이용권이라 결제취소가 불가합니다. \n환불처리 해주시기 바랍니다.");
			window.close();
		</c:if>	
		<c:if test="${paymentVO.useYn == 'N'}">
			$("#saveBtn").on("click", saveRefund);
		</c:if>	
		
		// 강제취소
// 		$("#enBtn").on("click", savePayCancle);
	});
	
// 	function savePayCancle(e) {
// 		e.preventDefault();
// 		var usrMainId = $.trim('${paymentVO.usrMainId}');
// 		$("#viewFlg").val( "E");
// 		commonAjax.postAjax("/setPaymentCancel.do", "json", $("#frm").serialize()
// 			,function(data){
// 				 if(data) {
// 					 alert(data.resultMessage);
// 					 opener.changePaymentStus('${paymentVO.paymentSeq}','BIS_003', '취소', '${paymentVO.paymentDttm}', usrMainId, data);
// 					 window.close();
// 				 } else {
// 					 alert(data.resultMessage);
// 					 return false;
// 				 }
// 			}
// 		);
// 	};
	
	function saveRefund(e) {
		e.preventDefault();
		var usrMainId = $.trim('${paymentVO.usrMainId}');
		commonAjax.postAjax("/setPaymentCancel.do", "json", $("#frm").serialize()
			,function(data){
				 if(data) {
					 alert(data.resultMessage);
					 opener.changePaymentStus('${paymentVO.paymentSeq}','BIS_020', '취소', '${paymentVO.paymentDttm}', usrMainId, data);
					 window.close();
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
