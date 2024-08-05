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
				<!--content S-->
				<div class="content">
					<div class="subject">
						<!--subject path S-->
							<tiles:insertAttribute name="subject" />
						<!--subject path E-->
					</div>
					<div class="page">
						<form id="penFormFrm" name="penFormFrm">
							<fieldset>
								<legend>벌점</legend>
								<table class="tb_type02 mt20">
										<colgroup>
											<col style="width:25%" />
											<col style="width:75%" />
										</colgroup>
									<tbody>
										<tr>
											<th><em>*</em> 벌점명</th>
											<td><span class="input-text07"><input type="text" id="penaltyName" name="penaltyName" /></span></td>
										</tr>
										<tr>
											<th><em>*</em> 벌점 코드</th>
											<td>
											<c:choose>
												<c:when test="${fn:contains(viewFlg, 'I')}">PEN_<span class="input-text03"><input type="text" id="penaltyCd" name="penaltyCd" /></span></c:when>
												<c:when test="${fn:contains(viewFlg, 'U')}"><span class="input-text03">${formPenaltyPolicy.penaltyCd }</span><input type="hidden" id="penaltyCd" name="penaltyCd" /></c:when>
											</c:choose>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											<c:if test="${fn:contains(viewFlg, 'I')}">
												<button type="button" class="btnType02" id="cdDuplChkBtn">중복확인</button>
												<input type="hidden" id="duplChk" value="Y"/>
											</c:if>
											</td>
										</tr>
										<tr>
											<th><em>*</em> 벌점 점수</th>
											<td><span class="input-text07"><input type="text" id="penaltyPoint" name="penaltyPoint" /></span></td>
										</tr>
										<tr>
											<th>벌점 내용</th>
											<td><span class="input-text05"><input type="text" id="penaltyContent" name="penaltyContent" /></span></td>
										</tr>
									</tbody>
								</table>
								<div class="btnArea">
									<span class="left"><button class="btnType01 bc_gray" type="button" id="penFormListBtn">목록</button></span>
									<span class="right">
									<c:if test="${fn:contains(viewFlg, 'U')}">
										<button class="btnType01" type="button" id="penFormDelBtn">삭제</button>
									</c:if>
									<button class="btnType01 bc_green" type="button" id="penFormSaveBtn">저장</button></span>	
								</div>
							</fieldset>
						</form>
					</div>
				</div>
				<!--conteent E-->
            </div>
        </div>
        <!--footer S-->
        <tiles:insertAttribute name="footer" />
        <!--footer E-->
    </div>
    
<script type="text/javascript" src="/js/common_barocle.js"></script>
<script type="text/javascript">
	$(function() {
		penForm.initBtn();
		penForm.initVal();
	});
	
	var penForm = {};
	penForm.initBtn = function () {
		
		$("#penFormListBtn").on("click", this.moveList);

		$("#cdDuplChkBtn").on("click", penForm.cdDuplChk);
		
		$("#penaltyCd").on("change", function() {
			$("#duplChk").val("Y");
		});
		
		$("#penFormSaveBtn").on("click", penForm.chkSubmitData);
		
		$("#penFormDelBtn").on("click", function() {
    		commonAjax.postAjax("/admin/service/policyMgmt/applyPenaltyCheckAjax.do", "json", {penaltyCd : $("#penaltyCd").val()}, function(data) {
    			if(data) {
					if((data.isCdApply == "true")) {
						alert("적용되어있는 벌점코드입니다. 삭제할 수 없습니다.");
						return false;
					} else {
						if(confirm("삭제 하시겠습니까?")) {
							commonAjax.postAjax("/admin/service/policyMgmt/delPenaltyPolicy.do", "json", 
					   				$("#penFormFrm").serialize(), 
					   				function(data) {
						   				if(data) {
											if(data.isSuccess == "true") {
												alert("삭제되었습니다.");
												penForm.moveList();
											} else {
												alert("삭제 실패하였습니다.");
											}
										}	
							});
						}
					}
				}
			});
		});
	};
	
	penForm.initVal = function () {
		
		if('${viewFlg }' == 'U') {
			$("#penaltyName").val("${formPenaltyPolicy.penaltyName }");
			$("#penaltyCd").val("${formPenaltyPolicy.penaltyCd }");
			$("#penaltyPoint").val("${formPenaltyPolicy.penaltyPoint }");
			$("#penaltyContent").val("${formPenaltyPolicy.penaltyContent }");
		}
	}
	
	penForm.moveList = function() {
		$("#penaltyCd").val("")
		$("#penaltyName").val("")
		$("#penFormFrm").attr({method : "post", action : "/admin/service/policyMgmt/listPenaltyPolicy.do"}).submit();
	};
	
	penForm.cdDuplChk = function() {
    	
    	if($("#penaltyCd").val()) {
    		commonAjax.postAjax("/admin/service/policyMgmt/duplCdCheckAjax.do", "json", {penaltyCd : $("#penaltyCd").val()}, function(data) {
    			if(data) {
					if((data.isCdDupl == "true")) {
						$("#duplChk").val("Y");
						alert("벌점 코드가 중복됩니다.");
					} else {
						$("#duplChk").val("N");
						alert("사용 가능한 벌점 코드입니다.");
					}
				}
			});
    	} else {
    		alert("벌점 코드를 입력하세요.");
    		$("#penaltyCd").focus();
    	}
    };
    
    penForm.chkSubmitData = function() {
    	
    	if('${viewFlg }' == 'I') {
	    	if($("#duplChk").val() == 'Y') {
	    		alert("벌점 코드 중복 검사를 해주세요.");
	    		return false;
	    	}
		}

    	if($("#penaltyName").val() == "") {
    		alert("벌점명을 입력해주세요.");
    		$($("#penaltyName")).focus();
    		return false;
    	}

    	if($("#penaltyPoint").val() == "") {
    		alert("벌점 점수를 입력해주세요.");
    		$($("#penaltyPoint")).focus();
    		return false;
    	}
    	
    	if(!isNumeric($("#penaltyPoint").val())) {
    		alert("벌점 점수는 숫자만 입력 가능합니다.");
    		$($("#penaltyPoint")).val("").focus();
    		return false;
    	}
    	
    	if('${viewFlg }' == 'U') {
    		commonAjax.postAjax("/admin/service/policyMgmt/modPenaltyPolicy.do", "json", 
	   				$("#penFormFrm").serialize(), 
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
			commonAjax.postAjax("/admin/service/policyMgmt/insertPenaltyPolicy.do", "json", 
	   				$("#penFormFrm").serialize(), 
	   				function(data) {
		   				if(data) {
							if(data.isSuccess == "true") {
								alert("저장되었습니다.");
								penForm.moveList();
							} else {
								alert("저장 실패하였습니다.");
							}
						}	
			});
		}
    	
    	return false;
    }
    
</script>
</body>
</html>