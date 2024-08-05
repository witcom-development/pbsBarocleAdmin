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
	<form id="frmVou">
		<input type="hidden" name="usr_seq" value="${usr_seq}">
		<input type="hidden" name="usr_mpn_no" value="${memberInfoMap.USR_MPN_NO }">
		<input type="hidden" name="mb_id" value="${memberInfoMap.MB_ID }">
		<input type="hidden" name="payment_cls_cd" value="">
		<input type="hidden" name="admin_id" value="${admin_ID }">
		<input type="hidden" name="voucher_create_reason" value="">
		<input type="hidden" name="party_use_cnt" value="0">
		<div class="allwrap pop">
			<table class="tb_type02 mt20">
				<colgroup>
					<col style="width:30%">
					<col style="width:70%">
				</colgroup>
				<tbody>
					<tr>
						<th class="top"><em>*</em> 회원 ID</th>
						<td class="top">${memberInfoMap.MB_ID }</td>
					</tr>
					<tr>
						<th><em>*</em> 회원 휴대폰번호</th>
						<td>${memberInfoMap.USR_MPN_NO }</td>
					</tr>
					<tr>
						<th><em>*</em> 이용권 구분</th>
						<td><select class="select-category02" id="voucherClsCd" name="voucherClsCd">
								<option value="">선택</option>
								<c:forEach var="result" items="${voucherTypeList }" varStatus="status">
									<option value="${result.voucherCd }">${result.voucherName }</option>
								</c:forEach>
							</select></td>
					</tr>
					<tr>
						<th> 단체권 매수</th>
						<td><select class="select-category02" id="partyUseCntCd" name="partyUseCntCd">
								<option value="0">선택</option>
								<option value="2">2인</option>
								<option value="3">3인</option>
								<option value="4">4인</option>
								<option value="5">5인</option>
							</select></td>
					</tr>
					<tr>
						<th><em>*</em> 등록 관리자</th>
						<td>${admin_ID }</td>
					</tr>
					<tr>
						<th> 등록 내용</th>
						<td><span class="input-text06"><input type="text" id="vocherCreateReason" class=""/></span></td>
					</tr>
				</tbody>
			</table>
			<div class="btnArea">
				<span class="right">
					<button class="btnType01 bc_green" type="button" id="regBtn">등록</button>
					<button class="btnType01" type="button" id="cancelBtn">취소</button>
				</span>
			</div>
		</div>
	</form>
	</div>
	<a href="#" class="popclose"><img src="/images/btn_close.png" alt="팝업닫기" /></a>
	
<script type="text/javascript" src="/js/common_barocle.js"></script>
<script type="text/javascript">
	$(function() {
		$("#cancelBtn").on("click", function(e){
    		e.preventDefault();
    		window.close();
    	});
		
		$("#regBtn").on("click", regVoucherInfo);
	});
	
	regVoucherInfo = function() {	
		$("input[name=payment_cls_cd]").val($("#voucherClsCd option:selected").val());
		$("input[name=party_use_cnt]").val($("#partyUseCntCd option:selected").val());
		$("input[name=voucher_create_reason]").val($("#vocherCreateReason").val());
		
		if($("input[name=payment_cls_cd]").val() == ""){
			alert("등록할 이용권을 선택해주세요.");
			return;
		}
		
		if($("input[name=payment_cls_cd]").val() == "BIL_008" && $("input[name=party_use_cnt]").val() == 0 ){
			alert("단체권 매수를 선택해주세요.");
			return;
		}
		
		if($("input[name=payment_cls_cd]").val() != "BIL_008") {
			$("input[name=party_use_cnt]").val(0);
		}
		//alert($("input[name=party_use_cnt]").val());
		commonAjax.postAjax("/admin/service/member/creatVoucherAjax.do", "json", 
   				$("#frmVou").serialize(), 
   				function(data) {
	   				if(data) {
						if(data.isCreate == 1) {
							alert("이용권이 등록되었습니다.");
							opener.reloadPage();
							window.close();
						} else if(data.isSuccess == 2) {
							alert("이용권 등록에 실패하였습니다.");
							window.close();
						} else {
							alert("이용권이 있어 등록에 실패했습니다.");
							window.close();
						}
					}	
		});
	
	}
</script>

</body>
</html>
