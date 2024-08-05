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
	<form id="frmCon">
		<input type="hidden" name="usrSeq" value="${usr_seq}">
		<div class="allwrap pop">
			<table class="tb_type02 mt20">
				<colgroup>
					<col style="width:30%">
					<col style="width:70%">
				</colgroup>
				<tbody>
					<tr>
						<th class="top">이유</th>
						<td class="top">
							<select class="select-category02" id="blkListReasonCd" name="blkListReasonCd">
								<option value="">선택</option>
								<c:forEach var="result" items="${blackListReason }" varStatus="status">
									<option value="${result.blkListReasonCd }">${result.blkListReasonName }</option>
								</c:forEach>
							</select>
						</td>
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
		
		$("#regBtn").on("click", regBlackList);
	});
	
	regBlackList = function() {
		
		if($("#blkListReasonCd").val() == "") {
			alert("이유를 선택해주세요.");
			return false;
		}
		
		commonAjax.postAjax("/admin/service/member/regBlackListAjax.do", "json", 
   				$("#frmCon").serialize(), 
   				function(data) {
	   				if(data) {
						if(data.isSuccess == "true") {
							alert("등록되었습니다.");
							opener.changeButton();
							window.close();
						} else {
							alert("등록 실패하였습니다.");
							window.close();
						}
					}	
		});
	}
</script>

</body>
</html>
