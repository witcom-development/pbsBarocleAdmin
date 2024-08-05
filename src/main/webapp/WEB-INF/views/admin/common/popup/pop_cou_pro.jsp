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
			<div class="page">
						<div class="tabWrap type3">
							<ul class="tabBox">
								<li class="tab on"><button type="button">정기권</button></li>
								<li class="tab"><button type="button">일일권</button></li>
								<li class="tab"><button type="button">단체권</button></li>
							</ul>
							
							<!-- 정기권 S  -->
							<div class="tabCon on">
								<form action="action" id="seasonFrm">
									<fieldset>
									<legend>정기권</legend>
										<table  class="tb_type01">
											<colgroup>
												<col style="width:60%"/>
												<col style="width:40%"/> 
											</colgroup>
											<tbody>
											<c:set var="topCount" value="0" />
											<tr>
												<th>구분</th>
												<th>매수</th>
											</tr>
											<c:forEach var="result" items="${rentChargePolicyList }" varStatus="status">
												<c:if test="${(fn:contains(result.addVal3, 'RCC_001'))}">
													<tr>
														<td>${result.cdDesc }</td>
														<td class="tc">
															<span class="input-text03">
																<input type="text" class="tr pr10" name="svcCouponCountList" value="0"/>&nbsp;
																<input type="hidden" name="paymentClsCdList" value="${result.paymentClsCd }"/>
															</span>
														</td>
													</tr>
													<c:set var="topCount" value="1"/>
												</c:if>
											</c:forEach>	
											</tbody>
										</table>
										<input type="hidden" name="partyUseCnt" value="0"/>
										<table  class="tb_type02 mt20">
											<colgroup>
												<col style="width:20%"/>
												<col style="width:80%"/>
											</colgroup>
											<tbody>
												<tr>
													<th class="top"><em></em>메모 </th>
													<td class="top">
														<textarea name="couponName" class="detatextarea"></textarea>
													</td>
												</tr>
											</tbody>
										</table>
										<div class="btnArea">
											<span class="right"><button class="btnType01 bc_green" type="button" id="seasonSaveBtn">저장</button></span>
										</div>
									</fieldset>
								</form>
							</div>
							<!-- 정기권 E  -->
							
							<!-- 일일권(회원) S  -->
							<div class="tabCon">
								<form action="action" id="memberFrm">
									<fieldset>
									<legend>일일권(회원)</legend>
										<table  class="tb_type01">
											<colgroup>
												<col style="width:60%"/>
												<col style="width:40%"/>
											</colgroup>
											<tbody>
												<tr>
													<th>구분</th>
													<th>매수</th>
												</tr>
												<c:forEach var="result" items="${rentChargePolicyList }" varStatus="status">
													<c:if test="${(fn:contains(result.addVal3, 'RCC_002'))}">
														<tr class="tc"> 
															<td>${result.cdDesc }</td>
															<td>
																<span class="input-text03">
																	<input type="text" class="tr pr10" name="svcCouponCountList" value="0"/>
																	<input type="hidden" name="paymentClsCdList" value="${result.paymentClsCd }"/>
																	
																</span>
															</td>
														</tr>
													</c:if>
												</c:forEach>
											</tbody>
										</table>
										<input type="hidden" name="partyUseCnt" value="0"/>
										<table  class="tb_type02 mt20">
											<colgroup>
												<col style="width:20%"/>
												<col style="width:80%"/>
											</colgroup>
											<tbody>
												<tr>
													<th class="top"><em></em>메모 </th>
													<td class="top">
														<textarea name="couponName" class="detatextarea"></textarea>
													</td>
												</tr>
											</tbody>
										</table>
										
										<div class="btnArea">
											<span class="right"><button class="btnType01 bc_green" type="button" id="memberSaveBtn">저장</button></span>
										</div>
									</fieldset>
								</form>
							</div>
							<!-- 일일권(회원) E  -->
							
							<!-- 단체권 S  -->
							<div class="tabCon">
								<form action="action" id="groupFrm">
									<fieldset>
									<legend>단체권</legend>
										<table  class="tb_type01">
											<colgroup>
												<col style="width:60%"/>
												<col style="width:40%"/>
											</colgroup>
											<tbody>
												<tr>
													<th>구분</th>
													<th>매수</th>
												</tr>
												<c:forEach var="result" items="${rentChargePolicyList }" varStatus="status">
													<c:if test="${(fn:contains(result.addVal3, 'RCC_004'))}">
														<tr>
															<td>${result.cdDesc }</td>
														<td>
															<span class="input-text03">
																<input type="text" class="tr pr10" name="svcCouponCountList" value="0"/> 
																<input type="hidden" name="paymentClsCdList" value="${result.paymentClsCd }"/>
															</span>
														</td>
													</tr>
													</c:if>
												</c:forEach>
											</tbody>
										</table>
										<table  class="tb_type02 mt20">
											<colgroup>
												<col style="width:20%"/>
												<col style="width:80%"/>
											</colgroup>
											<tbody>
												<tr>
													<th class="top"><em></em>인원 </th>
													<td class="top">
														<select id="groupPartyUseCnt" name="partyUseCnt" class="select-category02">
														<option value="">선택하세요</option>
														<option value="2">2</option>
														<option value="3">3</option>
														<option value="4">4</option>
														<option value="5">5</option>
													</select>
													</td>
												</tr>
												<tr>
													<th><em></em>메모 </th>
													<td>
														<textarea name="couponName" class="detatextarea"></textarea>
													</td>
												</tr>
											</tbody>
										</table>
										<div class="btnArea">
											<span class="right"><button class="btnType01 bc_green" type="button" id="groupMemberSaveBtn">저장</button></span>
										</div>
									</fieldset>
								</form>
							</div>
							<!-- 단체권 E  -->
						</div>
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
    	$("#seasonSaveBtn").on("click", function() {
			if(checkVal($("#seasonFrm"))) {
				$("#seasonSaveBtn").attr("disabled", true);
				commonAjax.postAjax("/addSvcCouponProc.do", "json", 
		   				$("#seasonFrm").serialize(), 
		   				function(data) {
			   				if(data) {
								if(data.isSuccess == "true") {
									alert("저장되었습니다.");
									window.close();
									opener.location.reload();
									
								} else {
									alert("저장 실패하였습니다.");
			   						$("#seasonSaveBtn").attr("disabled", false);
								}
							}
				});
			}
		});
    	
    	$("#memberSaveBtn").on("click", function() {
			if(checkVal($("#memberFrm"))) {
				$("#memberSaveBtn").attr("disabled", true);
				commonAjax.postAjax("/addSvcCouponProc.do", "json", 
		   				$("#memberFrm").serialize(), 
		   				function(data) {
			   				if(data) {
								if(data.isSuccess == "true") {
									alert("저장되었습니다.");
									window.close();
									opener.location.reload();
									
								} else {
									alert("저장 실패하였습니다.");
			   						$("#memberSaveBtn").attr("disabled", false);
								}
							}
				});
			}
		});
    	
    	$("#groupMemberSaveBtn").on("click", function() {
			if($("#groupPartyUseCnt").val()==''){
				alert("인원을 선택하세요");
			} else {
	    		if(checkVal($("#groupFrm"))) {
					$("#groupMemberSaveBtn").attr("disabled", true);
					commonAjax.postAjax("/addSvcCouponProc.do", "json", 
			   				$("#groupFrm").serialize(), 
			   				function(data) {
				   				if(data) {
									if(data.isSuccess == "true") {
										alert("저장되었습니다.");
										window.close();
										opener.location.reload();
										
									} else {
										alert("저장 실패하였습니다.");
				   						$("#groupMemberSaveBtn").attr("disabled", false);
									}
								}
					});
				}
			}
		});
		
    });
	/* 
	function savePayment(e) {
    	e.preventDefault();
    	
    	var radioChkType = $(':radio[name="radioChkType"]:checked').val();
    	$("input:hidden[name='overFeeProcessClsCd']").val(radioChkType);
    	
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
     */
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
