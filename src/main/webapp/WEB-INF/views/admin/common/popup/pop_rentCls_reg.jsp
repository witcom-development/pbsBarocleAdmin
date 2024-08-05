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
		<input type="hidden" name="rent_hist_seq" value="${paymentVo.rent_hist_seq}">
		<input type="hidden" name="return_station" value="${paymentVo.return_station}">
		<input type="hidden" name="rent_cls_cd" value="">
		<div class="allwrap pop">
			<table class="tb_type02 mt20">
				<colgroup>
					<col style="width:30%">
					<col style="width:70%">
				</colgroup>
				<tbody>
						<th><em>*</em> 이용권 구분</th>
						<td><select class="select-category02" id="rentClsCd" name="rentClsCd">
								<option value="">선택</option>
								<c:forEach var="result" items="${rentTypeList }" varStatus="status">
									<option value="${result.rentCd }">${result.rentName }</option>
								</c:forEach>
							</select></td>
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
		$("input[name=rent_cls_cd]").val($("#rentClsCd option:selected").val());
		
		if($("input[name=rent_cls_cd]").val() == ""){
			alert("대여 구분을 선택해주세요.")
			return;
		}

		
		commonAjax.postAjax("/admin/service/member/regRentClsAjax.do", "json", 
   				$("#frmVou").serialize(), 
   				function(data) {
	   				if(data) {
						if(data.isCreate == 1) {
							alert("대여 구분이 등록되었습니다.");
							opener.reloadPage();
							window.close();
						} else{
							alert("대여 구분 등록에 실패하였습니다.");
							window.close();
						}
					}	
		});
	
	}
</script>

</body>
</html>
