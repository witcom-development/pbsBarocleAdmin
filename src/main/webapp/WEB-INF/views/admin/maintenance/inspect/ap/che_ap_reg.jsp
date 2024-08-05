<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
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
					<tiles:insertAttribute name="left" />
				<!--left menu E-->
				<!--content S-->
				<div class="content">
					<div class="subject">
                        <!--subject path S-->
                        <tiles:insertAttribute name="subject" />
                        <!--subject path E-->
					</div>
					<div class="page">
						<form id="frm">
                            <%-- <input type="hidden" name="searchBgnDe"  value="${repairAp.searchBgnDe}" />
                            <input type="hidden" name="searchEndDe"  value="${repairAp.searchEndDe}" />
                            <input type="hidden" name="pageNo" value="${repairAp.getCurrentPageNo() }"/>
                            <input type="hidden" name="division" value="${repairAp.division}"/> --%>
                           <%--  <input type="hidden" name="repairSeq" value="${repairAp.repairSeq}"/>
                            <input type="hidden" name="faultSeq" value="${repairAp.faultSeq}"/>    --%>
                            <input type="hidden" name="faultClsCd" value=""/>
                            <input type="hidden" name="adminId" id="adminId" value="${adminId}"/>
                            <input type="hidden" name="viewFlg" value="${repairAp.viewFlg}"/>
                           <!--  <input type="hidden" name="repairApReport" id="repairApReport" value=""/> -->
                            
							<fieldset>
								<legend>무선 AP 등록</legend>
								<table class="tb_type02 mt20">
									<colgroup>
										<col style="width: 25%" />
										<col style="width: 75%" />
									</colgroup>
									<tbody>
										<tr>
											<th class="top"><em>*</em> AP ID</th>
											<td class="top"><span class="input-text07"><input type="text" id="apId" name="apId" readonly /></span>
											<a href="/common/pop/DEV_003/showFODevicePop.do" class="winNewPop modal btnType02" title="무선AP 찾기" data-width="450" data-height="480"  data-pmt="&searchType=R">찾기</a>
										</tr>
										<tr>
											<th> 대여소명</th>
											<td>
												<label id="stationName"></label>
											</td>
										</tr>
										<tr>
											<th> 작성자</th>
											<td>
												${adminId}
											</td>
										</tr>
										<tr>
											<th><em>*</em> 장애구분</th>
											<td>
												<select class="select-category01" id="comDeviceStatusName" name="comDeviceStatusName">
												<option value="">선택</option>
												</select>
											</td>
										</tr>
										<!-- <tr>
											<th>특이사항</th>
											<td>
												<span class="input-text21"><input type="text" name="repairApReportTxt" id="repairApReportTxt" value=""/></span>
											</td>
										</tr> -->
									</tbody>
								</table>
								<div class="btnArea">
									<span class="left"><button class="btnType01 bc_gray" id="moveRepairApList">목록</button></span>
									<span class="right">
										<button type="button" class="btnType01 bc_green" id="exeRepairApEdit">저장</button>
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
    	repairApInfo.init();
    	repairApInfo.initBtn();
    });
	
    var repairApInfo = {};
    repairApInfo.init = function(){
		//장애구분
		    commonAjax.getCommonCode("ERA", function(data) {
		         if(data !== null && data.codeList !== null) {
		        	 var code = new Array();
		             for(var i =0; i <data.codeList.length ;i++) {
		                     code.push(data.codeList[i]);
		             }
		             commCdBox.makeComboBox('CC', '${repairApInfo.deviceStatusName}', code, "comDeviceStatusName");
		         }
		     });
	}
    
    repairApInfo.initBtn = function(){
    	var _this = repairApInfo;
    	$("#moveRepairApList").on("click", _this.moveRepairApList);
    	$('#exeRepairApEdit').on("click", _this.exeRepairApEdit);
    }
    
    repairApInfo.moveRepairApList = function (e) {
    	e.preventDefault();
    	$('[name="repairCmptYn"]').val('${repairAp.repairCmptYn}');
        $("#frm").attr({method :"post", action :"/inspectApList.do"}).submit();
    };
		
    repairApInfo.exeRepairApEdit = function (e) {
    	e.preventDefault();
    	
    	if($('[name="apId"]').val() == "" || $('[name="apId"]').val() == undefined){
    		alert('<spring:message code="fail.input.emptyValue2" arguments="AP ID"/>');
    		$('[name="apId"]').focus();
    		return;
    	}
    	
    	if($('[name="comDeviceStatusName"]').val() == "" || $('[name="comDeviceStatusName"]').val() == undefined){
    		alert('<spring:message code="fail.input.emptyValue1" arguments="장애구분"/>');
    		return;
    	}
    	
    	$('[name="faultClsCd"]').val($('[name="comDeviceStatusName"]').val());
    	
  		$('#exeRepairApEdit').attr('disabled', true);
  		
  		commonAjax.postAjax("/insertInspectApAjax.do", 'json', $("#frm").serialize()
      			, function(data){
      	        	if(data.resultMessage == 'Success'){
      	        		alert('등록이 완료되었습니다.');
      	        		$('#exeRepairApEdit').attr('disabled', false);
      	        		$('[name="apId"]').val("");
       	        		$("#frm").attr({method :"post", action :"/inspectApList.do"}).submit();
      	        	}else{
      	        		alert('오류가 발생하였습니다.');
      	        		$('#exeRepairApEdit').attr('disabled', false);
      	        	}
              	}
  	        );
   	
    }
    
    function setApId(apId, stationInfo) {
    	$("[name='apId']").val(apId);
    	$("#stationName").text(stationInfo);
    }; 
    
/* 	    $(function() {
	   		repairApInfo.initBtn();
	   		repairApInfo.initCombo();
	   		var repairSeq = '${repairApInfo.repairSeq}' != '' ? '${repairApInfo.repairSeq}' : '';
		    var apId = '${repairApInfo.apId}' != '' ? '${repairApInfo.apId}' : '${repairAp.apId}';
		    var repairCmptYn = '${repairApInfo.repairCmptYn}' != '' ? '${repairApInfo.repairCmptYn}' : '';
			var repairCodeList = '${repairApInfo.repairCodeList}' != '' ? '${repairApInfo.repairCodeList}' : '';
			
			$("[name='apId']").val(apId);
			$("[name='repairCmptYn']:input[value='"+repairCmptYn+"']").prop('checked', true);

	    	commonAjax.getCommonCode("REA", function(data){
	    		if(data !== null && data.codeList !== null) {
	           	 	for(var i = 0; i < data.codeList.length; i++){
	            		$('<span class="pwtableblock input-ck02"><input type="checkbox" id="c'+i+'" value="'+data.codeList[i].comCd+'"/><label for="c'+i+'">'+data.codeList[i].comCdName+'</label></span>').appendTo('#repairDivision');
	           	 	}
	    			var repairCode = repairCodeList.replace(' ', '').replace('[', '').replace(']', '').split(',');	// 추후 수정
	    			for(var i=0; i < repairCode.length; i++) {
	        			$("input[value='"+repairCode[i].replace(' ', '')+"'").prop('checked', true);
	        		}
	            }
	    	});
	    });
	    
	    var repairApInfo = {};
	    repairApInfo.centerId = '${repairApInfo.centerId}' !== '' ? '${repairApInfo.centerId}' : '';
	    repairApInfo.adminId = '${repairApInfo.adminId}' !== '' ? '${repairApInfo.adminId}' : '';
	    
	    repairApInfo.initBtn = function(){
	    	var _this = repairApInfo;
	    	$("#moveRepairApList").on("click", _this.moveRepairApList);
	    	$('#exeRepairApEdit').on("click", _this.exeRepairApEdit);
	    }
	    
	    repairApInfo.initCombo = function(){
	    	var _this = repairApInfo;
	    	
	    	commonAjax.getCenterCode( 
                function(data) {
                    if(data !== null && data.centerList !== null) {
                        commCdBox.makeComboBox('C', _this.centerId, data.centerList, "centerSlt");
                        var centerId = '${repairApInfo.centerId}' !== '' ? '${repairApInfo.centerId}' : '';
                        $("[name='centerId']").val(centerId);
                    }
                }
	        );
				
			commonAjax.getAdminList("004", "",
    			function(data) {
					if(data !== null && data.userList !== null) {
		        		var uSize = data.userList.length;
		        		for(var i=0; i < uSize; i +=1) {
		        			var userInfo = data.userList[i];
		        			var userText = userInfo.usrId+"("+userInfo.usrName+")";
		        			var $op = $("<option value='"+userInfo.usrId+"'>"+userText+"</option>").appendTo("#adminSlt");    
		        		}
		        		var adminId = '${repairApInfo.adminId}' !== '' ? '${repairApInfo.adminId}' : '';
		    			$("[name='adminId']").val(adminId);
			        }
    		    }
	    	);
	    }
	    
	    repairApInfo.moveRepairApList = function (e) {
	    	e.preventDefault();
	    	$('[name="repairCmptYn"]').val('${repairAp.repairCmptYn}');
	        $("#frm").attr({method :"post", action :"/repairApList.do"}).submit();
	    };
	    
	    repairApInfo.exeRepairApEdit = function (e) {
	    	e.preventDefault();
	    	
	    	if($('[name="apId"]').val() == "" || $('[name="apId"]').val() == undefined){
	    		alert('<spring:message code="fail.input.emptyValue2" arguments="AP ID"/>');
	    		$('[name="apId"]').focus();
	    		return;
	    	}
	    	if($('[name="adminId"]').val() == "" || $('[name="adminId"]').val() == undefined){
	    		alert('<spring:message code="fail.input.emptyValue2" arguments="유지보수자"/>');
	    		$('[name="adminId"]').focus();
	    		return;
	    	}
	    	
	    	var repairCode = "";
	    	$('input[type="checkbox"]:checked').each(function(e){
	    		if(repairCode.length > 0){
	    			repairCode = repairCode+",";
	    		}
				repairCode = repairCode+$(this).val();
			});
	    	
	    	if(repairCode.length == 0){
	    		alert('<spring:message code="fail.input.emptyValue1" arguments="수리구분"/>');
	    		return;
	    	}

	    	if($('[name="repairCmptYn"]:checked').val() == "" || $('[name="repairCmptYn"]:checked').val() == undefined){
	    		alert('<spring:message code="fail.input.emptyValue2" arguments="상태"/>');
	    		$('[name="repairCmptYn"]').focus();
	    		return;
	    	}
	    	
	    	$("#repairApReport").val($("#repairApReportTxt").val());
	    	
	    	$('[name="repairCode"]').val(repairCode);
	    	
      		$('#exeRepairApEdit').attr('disabled', true);
      		
	    	if($('[name="viewFlg"]').val() == 'U'){
	    		var prevCenterId = '${repairApInfo.centerId}';
	    		var centerId = $('[name="centerId"]').val();
	    		if(centerId == '' && prevCenterId != centerId){
		    		alert('보관센터가 지정된 상태에서 미지정으로 변환할 수 없습니다.');
	    			return;
	    		}
	    		commonAjax.postAjax("/updateRepairApAjax.do", 'json', $("#frm").serialize()
          			, function(data){
          	        	if(data.resultMessage == 'Success'){
          	        		prevCenterId = centerId;
          	        		alert('수정이 완료되었습니다.');
          	        		$('#exeRepairApEdit').attr('disabled', false);
          	        		$("#frm").attr({method :"post", action :"/moveRepairApEditForm.do"}).submit();
          	        	}else{
          	        		alert('오류가 발생하였습니다.');
          	        	}
	              	}
	  	        )
	    	}else if($('[name="viewFlg"]').val() == 'C'){
	    		commonAjax.postAjax("/insertRepairApAjax.do", 'json', $("#frm").serialize()
          			, function(data){
          	        	if(data.resultMessage == 'Success'){
          	        		alert('등록이 완료되었습니다.');
          	        		$('#exeRepairApEdit').attr('disabled', false);
	       	        		$("#frm").attr({method :"post", action :"/repairApList.do"}).submit();
          	        	}else{
          	        		alert('오류가 발생하였습니다.');
          	        		$('#exeRepairApEdit').attr('disabled', false);
          	        	}
	              	}
	  	        );
	    	}
	    	
	    }
	    
	    function setApId(apId) {
	    	$("[name='apId']").val(apId);
	    }; */
	</script>
</body>
</html>