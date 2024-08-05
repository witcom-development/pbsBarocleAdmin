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
		<input type="hidden" name="usr_mpn_no" value="${memberInfoMap.USR_MPN_NO}">
		<input type="hidden" name="admin_id" value="${admin_ID}">
		<input type="hidden" name="voucher_str_dttm" value="">
		<input type="hidden" name="voucher_end_dttm" value="">
		<input type="hidden" name="voucher_extend_reason" value="">
		<input type="hidden" name="voucher_seq" value="${memberVoucherMap.VOUCHER_SEQ} }">
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
						<th><em>*</em> 등록 관리자</th>
						<td>${admin_ID }</td>
					</tr>
					<tr>
						<th><em>*</em> 이용권 시작일</th>
						<td><span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" id="voucher_str_dttm" readonly/></span></td>
					</tr>
					<tr>
						<th><em>*</em> 이용권 종료일</th>
						<td><span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" id="voucher_end_dttm" readonly/></span></td>
					</tr>
					<tr>
						<th> 등록 내용</th>
						<td><span class="input-text06"><input type="text" id="voucher_extend_reason" class=""/></span></td>
					</tr>
				</tbody>
			</table>
			<div class="btnArea">
				<span class="right">
					<button class="btnType01 bc_green" type="button" id="updateBtn">저장</button>
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
		
		if("${memberVoucherMap.VOUCHER_SEQ}" == "N"){
			alert("기간을 연장할 수 있는 이용권 정보가 없습니다.");
			window.close();
		}
		
		$("#voucher_str_dttm").val("${memberVoucherMap.VOUCHER_STR_DTTM}");
		$("#voucher_end_dttm").val("${memberVoucherMap.VOUCHER_END_DTTM}");
		
		$("#updateBtn").on("click", extendVoucherInfo);
	});
	
	extendVoucherInfo = function() {	
		
		$("input[name=voucher_str_dttm]").val($("#voucher_str_dttm").val());
		$("input[name=voucher_end_dttm]").val($("#voucher_end_dttm").val());
		$("input[name=voucher_extend_reason]").val($("#voucher_extend_reason").val());
		
		if($("input[name=voucher_str_dttm]").val() >= $("input[name=voucher_end_dttm]").val()){
			alert("이용권 시작일이 이용권 종료일보다 큽니다. 이용권 시작일을 변경하여 등록바랍니다.")
			return;
		}
		
		commonAjax.postAjax("/admin/service/member/extendVoucherAjax.do", "json", 
   				$("#frmVou").serialize(), 
   				function(data) {
	   				if(data) {
						if(data.isUpdate == 1) {
							alert("이용권이 연장되었습니다.");
							opener.reloadPage();
							window.close();
						} else {
							alert("이용권 연장에 실패하였습니다.");
							window.close();
						}
					}	
		});
	}
</script>

</body>
</html>
