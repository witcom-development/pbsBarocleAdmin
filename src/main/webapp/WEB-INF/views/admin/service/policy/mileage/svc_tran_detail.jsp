<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" /> 
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />
<meta name="description=" Content="" />
<title><tiles:insertAttribute name="title"/></title>
<tiles:insertAttribute name="resource"/>
</head>
<body>
	<div class="allwrap">
        <!--모바일 메뉴 S-->
        <tiles:insertAttribute name="header" />
        <!--모바일 메뉴 E-->
        <!--Head S-->
        <tiles:insertAttribute name="head" />
        <!--Head E-->
        <div id="body">
            <div class="cont">
                <!--left menu S-->
                <tiles:insertAttribute name="left"  />
                <!--left menu E-->
				<!--conteent S-->
				<div class="content">
					<div class="subject">
						<!--subject path S-->
							<tiles:insertAttribute name="subject" />
						<!--subject path E-->
					</div>
					<div class="page">
						<form id="tranFormFrm" name="tranFormFrm">
						<input type="hidden" id="transferPolicySeq" name="transferPolicySeq"/>
						<input type="hidden" id="isDateChange" value="N"/>
							<fieldset>
							<legend>환승</legend>
								<table class="tb_type02 mt20">
										<colgroup>
											<col style="width:35%" />
											<col style="width:65%" />
										</colgroup>
									<tbody>
										<tr>
											<th><em>*</em> 적용 기간</th>
											<td>
											<c:choose>
												<c:when test="${fn:contains(viewFlg, 'U')}">
													${formTransferPolicy.applyStrDate } <span class="dash">~</span> ${formTransferPolicy.applyEndDate }
													<input type="hidden" id="applyStrDate" name="applyStrDate" />
													<input type="hidden" id="applyEndDate" name="applyEndDate" />
												</c:when>
												<c:otherwise>
													<span class="selectDate input-datepick02"><input type="text" class="datepicker input-datepick02" title="선택 날짜" id="applyStrDate" name="applyStrDate" readonly/></span>
													<span class="dash">~</span> 9999-12-31 <input type="hidden" id="applyEndDate" name="applyEndDate" value="9999-12-31"/>
												</c:otherwise>
											</c:choose>
											</td>
										</tr>
										<tr>
											<th><em>*</em> 일 최대 적립 포인트</th>
											<td><span class="input-text03"><input type="text" class="tr pr10" id="ddMaxAccMileage" name="ddMaxAccMileage" /></span></td>
										</tr>
										<tr>
											<th><em>*</em> 월 최대 적립 포인트</th>
											<td><span class="input-text03"><input type="text" class="tr pr10" id="mmMaxAccMileage" name="mmMaxAccMileage" /></span></td>
										</tr>
										<tr>
											<th><em>*</em> 년 최대 적립 포인트</th>
											<td><span class="input-text03"><input type="text" class="tr pr10" id="yyMaxAccMileage" name="yyMaxAccMileage" /></span></td>
										</tr>
										<tr>
											<th><em>*</em> 1회 적립 포인트</th>
											<td><span class="input-text03"><input type="text" class="tr pr10" id="tmsAccMileage" name="tmsAccMileage" /></span></td>
										</tr>
										<tr>
											<th><em>*</em> 환승 범위(분)</th>
											<td><span class="input-text03"><input type="text" class="tr pr10" id="transferRangeMi" name="transferRangeMi" /></span></td>
										</tr>
										<tr>
											<th><em>*</em> 일 최대 적립 회수</th>
											<td><span class="input-text03"><input type="text" class="tr pr10" id="ddMaxAccCnt" name="ddMaxAccCnt" /></span></td>
										</tr>
										<tr>
											<th><em>*</em> 최소 사용 포인트</th>
											<td><span class="input-text03"><input type="text" class="tr pr10" id="minUseMileage" name="minUseMileage" /></span></td>
										</tr>
										<tr>
											<th><em>*</em> 최대 사용 포인트</th>
											<td><span class="input-text03"><input type="text" class="tr pr10" id="maxUseMileage" name="maxUseMileage" /></span></td>
										</tr>
										<tr>
											<th><em>*</em> 포인트 기준</th>
											<td><span class="input-text03"><input type="text" class="tr pr10" id="mileageStandard" name="mileageStandard" /></span></td>
										</tr>
									</tbody>
								</table>
								<div class="btnArea">
									<span class="left"><button class="btnType01 bc_gray" type="button" id="tranFormListBtn">목록</button></span>
									<span class="right">
									<c:choose>
										<c:when test="${viewFlg != 'U'}">
											<button class="btnType01 bc_green" type="button" id="tranFormSaveBtn">저장</button>
										</c:when>
										<c:when test="${fn:contains(viewFlg, 'U') && fn:contains(formTransferPolicy.applyEndDate, '9999-12-31')}">
											<button class="btnType01 bc_green" type="button" id="tranFormSaveBtn">저장</button>
										</c:when>
									</c:choose>
									</span>
								</div>
							</fieldset>
						</form>
					</div>
				</div>
				<!--content E-->
			</div>
        </div>
        <!--footer S-->
        <tiles:insertAttribute name="footer" />
        <!--footer E-->
    </div>

<script type="text/javascript" src="/js/common_barocle.js"></script>
<script type="text/javascript">
	$(function() {
		tranForm.initBtn();
		tranForm.initVal();
	});
	
	var tranForm = {};
	tranForm.initBtn = function () {
		
		$("#tranFormListBtn").on("click", this.moveList);

		$("#tranFormSaveBtn").on("click", tranForm.chkSubmitData);
		
		$("#tranFormDelBtn").on("click", function() {
			if(confirm("삭제하시겠습니까?")) {
				commonAjax.postAjax("/admin/service/policyMgmt/delTransferPolicy.do", "json", 
		   				$("#tranFormFrm").serialize(), 
		   				function(data) {
			   				if(data) {
								if(data.isSuccess == "true") {
									alert("삭제되었습니다.");
									tranForm.moveList();
								} else {
									alert("삭제 실패하였습니다.");
								}
							}	
				});
			}
		});
	};
	
	tranForm.initVal = function () {
		
		if('${viewFlg }' == 'U') {
			$("#transferPolicySeq").val("${formTransferPolicy.transferPolicySeq }");
			$("#applyStrDate").val("${formTransferPolicy.applyStrDate }");
			$("#applyEndDate").val("${formTransferPolicy.applyEndDate }");
			$("#ddMaxAccMileage").val("${formTransferPolicy.ddMaxAccMileage }");
			$("#mmMaxAccMileage").val("${formTransferPolicy.mmMaxAccMileage }");
			$("#yyMaxAccMileage").val("${formTransferPolicy.yyMaxAccMileage }");
			$("#tmsAccMileage").val("${formTransferPolicy.tmsAccMileage }");
			$("#transferRangeMi").val("${formTransferPolicy.transferRangeMi }");
			$("#ddMaxAccCnt").val("${formTransferPolicy.ddMaxAccCnt }");
			$("#minUseMileage").val("${formTransferPolicy.minUseMileage }");
			$("#maxUseMileage").val("${formTransferPolicy.maxUseMileage }");
			$("#mileageStandard").val("${formTransferPolicy.mileageStandard }");
		}
	}
	
	tranForm.moveList = function() {
		$("#transferPolicySeq").val("")
		$("#applyStrDate").val("")
		$("#applyEndDate").val("")
		$("#tranFormFrm").attr({method : "post", action : "/admin/service/policyMgmt/listTransferPolicy.do"}).submit();
	}
	
    tranForm.chkSubmitData = function() {
    	
    	var rst = false;
		$("input[type='text']").each(function(idx) {
			if(parseInt(idx) < 2) {
				if($(this).val() == "") {
					alert("최대 적립 포인트를 입력해주세요.");
		        	rst = true;
		        	return false;
				}
			} else {
				if($(this).val() == "") {
					alert("해당 입력값을 입력해주세요.");
					$(this).focus();
		        	rst = true;
		        	return false;
				}
			}
		});
		if(rst)
			return false;
	/*	
		$("input[type='text']").each(function(idx) {
				if(!isNumeric($(this).val())) {
					alert("숫자만 입력가능 합니다.");
					$(this).val("").focus();
		        	rst = true;
		        	return false;
				}
		});
		if(rst)
			return false;
	*/	
    	if(DateUtil.checkDateTerm( $( "[name='applyStrDate']").val(),  $( "[name='applyEndDate']").val()) !== 'ok') {
            alert("적용 기간의 시작 날이 종료 날보다 큽니다.");
            return false;
        }
    	
    	commonAjax.postAjax("/admin/service/policyMgmt/duplDateCheckAjax.do", "json", 
   				{applyStrDate : $("#applyStrDate").val(), applyEndDate : $("#applyEndDate").val(), transferPolicySeq : $("#transferPolicySeq").val()}, function(data) {
   			if(data) {
				if((data.isDateDupl == "true")) {
					alert("적용 기간이 중복됩니다.");
		    		return false;
				} else {
					if('${viewFlg }' == 'U') {
			    		commonAjax.postAjax("/admin/service/policyMgmt/modTransferPolicy.do", "json", 
				   				$("#tranFormFrm").serialize(), 
				   				function(data) {
					   				if(data) {
										if(data.isSuccess == "true") {
											alert("저장되었습니다.");
										} else {
											alert("저장 실패하였습니다.");
										}
									}	
						});
			    	} else if('${viewFlg }' == 'I') {
						commonAjax.postAjax("/admin/service/policyMgmt/insertTransferPolicy.do", "json", 
				   				$("#tranFormFrm").serialize(), 
				   				function(data) {
					   				if(data) {
										if(data.isSuccess == "true") {
											alert("저장되었습니다.");
											tranForm.moveList();
										} else {
											alert("저장 실패하였습니다.");
										}
									}	
						});
					}	
				}
			}
		});
    }
    
</script>
</body>
</html>