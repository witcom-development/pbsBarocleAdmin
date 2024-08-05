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
                            <input type="hidden" name="searchBgnDe"  value="${repairBike.searchBgnDe}" />
                            <input type="hidden" name="searchEndDe"  value="${repairBike.searchEndDe}" />
                            <input type="hidden" name="pageNo" value="${repairBike.getCurrentPageNo() }"/>
                            <input type="hidden" name="division" value="${repairBike.division}"/>
                            <input type="hidden" name="repairSeq" value="${repairBike.repairSeq}"/>        
                            <input type="hidden" name="faultSeq" value="${repairBike.faultSeq}"/>      
                            <input type="hidden" name="repairCode" value=""/>
                            <input type="hidden" name="viewFlg" value="${repairBike.viewFlg}"/>
                            <input type="hidden" name="bikeReport" id="bikeReport" value=""/>
                            <input type="hidden" name="repairReport" id="repairReport" value=""/>
                            <input type="hidden" name="bikeStusCd" id="bikeStusCd" value="${repairBikeInfo.bikeStusCd}"/>
                            <input type="hidden" name="bikeStatusComCd" id="bikeStatusComCd" value="${repairBikeInfo.bikeStatusComCd}"/>
                            <!-- 20190201 양재영 추가 -->
                            <input type="hidden" name="adminId" id="adminId">
                            
                            
							<fieldset>
								<legend>자전거 등록 / 상세 / 수정</legend>
								<table class="tb_type02 mt20">
									<colgroup>
										<col style="width:25%"/>
										<col style="width:75%"/>
									</colgroup>
									<tbody>
										<tr>
											<th class="top"><em>*</em> 자전거 번호 / ID</th>
											<td class="top">
												<span class="input-text08"><input type="text" name="bikeNo" readonly /></span>
												<span class="dash">/</span>
												<span class="input-text08"><input type="text" name="bikeId" readonly /></span>
												<c:if test="${repairBikeInfo.bikeStatusName == null && repairBike.viewFlg == 'C'}">
												<a href="/common/pop/DEV_001/showFODevicePop.do" class="winNewPop modal btnType02" title="자전거찾기" data-width="450" data-height="480"  data-pmt="&searchType=R">찾기</a>
												</c:if>
											</td>
										</tr>
										<tr>
											<th><em>*</em>유지보수자:</th>
											<td>
											<!-- 2019-02-01 이름으로 변경 양재영 -->
											<span class="input-text21">
											
											<c:if test="${repairBikeInfo.adminName != null}">
												"${repairBikeInfo.adminName}"
											</c:if>
											<c:if test="${repairBikeInfo.adminName == null}">
											<%= com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil.getSessionAttribute(request, "usrName") %>
											</c:if>
											
											</span>
						
											<!-- 
												<select disabled="disabled" class="select-category01" name="adminId" id="adminSlt">
													<option value="">선택</option>
												</select> -->
											</td>
										</tr>
										<c:if test="${repairBikeInfo.bikeStatusName != null}">
										<tr>
											<th> 장애구분</th>
											<td>
												<%-- ${repairBikeInfo.bikeStatusName} --%>
												<c:if test="${repairBikeInfo.repairCmptYn != 'Y'}"><select class="select-category01" id="comBikeStatusName" name="comBikeStatusName"></c:if>
												<c:if test="${repairBikeInfo.repairCmptYn == 'Y'}"><select class="select-category01" id="comBikeStatusName" name="comBikeStatusName"  disabled="disabled"></c:if>
														<option value="">선택</option>
												</select>
												</td>
										</tr>
										</c:if>
										<tr>
											<th><em>*</em> 수리구분</th>
											<td id="repairDivision">
											</td>
										</tr>
										<tr>
											<th><em>*</em> 상태</th>
											<td>
												<span class="input-rd01"><input type="radio" name="repairCmptYn" id="a3" value="N"><label for="a3">수리중</label></span>
												<span class="input-rd01"><input type="radio" name="repairCmptYn" id="ab3" value="Y"><label for="ab3">수리완료</label></span>
											</td>
										</tr>
										<tr>
											<th><c:if test="${repairBike.viewFlg == 'U'}"><em>*</em></c:if> 보관센터</th>
											<td>
												<select class="select-category01" name="centerId" id="centerSlt">
													<option value="">선택</option>
												</select>
												<p>(보관센터를 선택 하시면 장치의 위치가 해당 센터로 변경됩니다.)</p>
											</td>
										</tr>
										<tr>
											<th>정비내역</th>
											<td>
												<span class="input-text21"><input type="text" name="repairReportTxt" id="repairReportTxt" value="${repairBikeInfo.repairReport}"/></span>
											</td>
										</tr>
										<tr>
											<th>특이사항</th>
											<td>
												<span class="input-text21"><input type="text" name="bikeReportTxt" id="bikeReportTxt" value="${repairBikeInfo.bikeReport}"/></span>
											</td>
										</tr>
									</tbody>
								</table>
								<div class="btnArea">
									<span class="left"><button class="btnType01 bc_gray" id="moveRepairBikeList">목록</button></span>
									<span class="right">
										<c:if test="${repairBikeInfo.repairCmptYn != 'Y'}"><button type="button" class="btnType01 bc_green" id="exeRepairBikeEdit">저장</button></c:if>
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
 	    	repairBikeInfo.init();
	   		repairBikeInfo.initBtn();
	   		repairBikeInfo.initCombo();
	   		var repairSeq = '${repairBikeInfo.repairSeq}' !== '' ? '${repairBikeInfo.repairSeq}' : '';
		    var bikeNo = '${repairBikeInfo.bikeNo}' !== '' ? '${repairBikeInfo.bikeNo}' : '${repairBike.bikeNo}';
		    var bikeId = '${repairBikeInfo.bikeId}' !== '' ? '${repairBikeInfo.bikeId}' : '${repairBike.bikeId}';
		    var repairCmptYn = '${repairBikeInfo.repairCmptYn}' !== '' ? '${repairBikeInfo.repairCmptYn}' : '';
			var repairCodeList = '${repairBikeInfo.repairCodeList}' !== '' ? '${repairBikeInfo.repairCodeList}' : '';
			
			// 2019-02-01추가
			var adminId = '<%= com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil.getSessionAttribute(request, "usrId") %>';
			$("[name='adminId']").val(adminId);
			
			
			$("[name='bikeNo']").val(bikeNo);
			$("[name='bikeId']").val(bikeId);
			$("[name='repairCmptYn']:input[value='"+repairCmptYn+"']").prop('checked', true);
			
			repairBikeInfo.getAdmComCodeInfo("REB", function(data){
	    		if(data !== null && data.codeList !== null) {
	           	 	for(var i = 0; i < data.codeList.length; i++){
	           	 		
	           	 		if(data.codeList[i].addVal1 === 'BIKE' || data.codeList[i].addVal1 === 'TERM'){
	            	
	           	 			$('<span class="pwtableblock input-ck02"><input type="checkbox" id="c'+i+'" value="'+data.codeList[i].comCd+'"/><label for="c'+i+'">'+data.codeList[i].comCdName+'</label></span>').appendTo('#repairDivision');
	           	 	
	           	 		}
	           	 	}	
	           	 	var repairCode = repairCodeList.replace(' ', '').replace('[', '').replace(']', '').split(',');
		 			for(var i=0; i < repairCode.length; i++) {
		     			$("input[value='"+repairCode[i].replace(' ', '')+"']").prop('checked', true);
		     		}
	            }
	    	});
			
	    });
	    
	    var repairBikeInfo = {};
	    repairBikeInfo.init = function(){
			
			//장애구분
		    commonAjax.getCommonCode("ERB", function(data) {
		         if(data !== null && data.codeList !== null) {
		        	 var code = new Array();
		             for(var i =0; i <data.codeList.length ;i++) {
		                 /* if(data.codeList[i].addVal1 === "SEASON" || data.codeList[i].addVal1 === "MDAY") { */
		                     code.push(data.codeList[i]);
		                 //}
		             }
		             commCdBox.makeComboBox('CC', '${repairBikeInfo.bikeStatusComCd}', code, "comBikeStatusName");
		         }
		     });
			
	    }
	   
	    
	    repairBikeInfo.centerId = '${repairBikeInfo.centerId}' !== '' ? '${repairBikeInfo.centerId}' : '';
	    repairBikeInfo.adminId = '${repairBikeInfo.adminId}' !== '' ? '${repairBikeInfo.adminId}' : '';
	    
	    repairBikeInfo.initBtn = function(){
	    	var _this = repairBikeInfo;
	    	$("#moveRepairBikeList").on("click", this.moveRepairBikeList);
	    	$('#exeRepairBikeEdit').on("click", this.exeRepairBikeEdit);
	    }
	    
	    repairBikeInfo.initCombo = function(){
	    	var _this = repairBikeInfo;
	    	
	    	commonAjax.getCenterCode( 
                function(data) {
                    if(data !== null && data.centerList !== null) {
                    	
						// 20200102 도난추정 항목 삭제
                        var newDataList = data.centerList.slice(0,10);
                        newDataList = newDataList.concat(data.centerList.slice(-1));
                        commCdBox.makeComboBox('C', _this.centerId, newDataList, "centerSlt");
                        // 20200102 도난추정 항목 삭제 
                     
                        var centerId = '${repairBikeInfo.centerId}' !== '' ? '${repairBikeInfo.centerId}' : '';
                        $("[name='centerId']").val(centerId);
                        
                        
                        
                    }
                }
	        );
			// 정비
/* 	    	2019-02-01 양재영 수정
               commonAjax.getAdminList("004", "",
    			function(data) {
					if(data !== null && data.userList !== null) {
		        		var uSize = data.userList.length;
		        		for(var i=0; i < uSize; i +=1) {
		        			var userInfo = data.userList[i];
		        			var userText = userInfo.usrId+"("+userInfo.usrName+")";
		        			var $op = $("<option value='"+userInfo.usrId+"'>"+userText+"</option>").appendTo("#adminSlt");    
		        		}
		        		var adminId = '${repairBikeInfo.adminId}' !== '' ? '${repairBikeInfo.adminId}' : '';
		    			$("[name='adminId']").val(adminId);
			        }
    		    }
	    	); */
	    }
	    
	    repairBikeInfo.moveRepairBikeList = function (e) {
	    	e.preventDefault();
	    	$('[name="repairCmptYn"]').val('${repairAp.repairCmptYn}');
	        $("#frm").attr({method :"post", action :"/inspectBikeList.do"}).submit();
	    };
	    
	    repairBikeInfo.exeRepairBikeEdit = function (e) {
	    	e.preventDefault();
	    	if($('[name="bikeNo"]').val() == "" || $('[name="bikeNo"]').val() == undefined){
	    		alert('<spring:message code="fail.input.emptyValue2" arguments="자전거번호"/>');
	    		$('[name="bikeNo"]').focus();
	    		return;
	    	}
	    	if($('[name="bikeId"]').val() == "" || $('[name="bikeId"]').val() == undefined){
	    		alert('<spring:message code="fail.input.emptyValue2" arguments="자전거 ID"/>');
	    		$('[name="bikeId"]').focus();
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
	    	
	    	$('[name="repairCode"]').val(repairCode);
	    	
	    	
    		$("#bikeReport").val($("#bikeReportTxt").val());
    		
    		$("#repairReport").val($("#repairReportTxt").val());

	    	
      		$('#exeRepairBikeEdit').attr('disabled', true);
	    	if($('[name="viewFlg"]').val() == 'U'){
	    		var prevCenterId = '${repairBikeInfo.centerId}';
	    		var centerId = $('[name="centerId"]').val();
	    		if(centerId == '' && prevCenterId != centerId){
		    		alert('보관센터가 지정된 상태에서 미지정으로 변환할 수 없습니다.');
	    			return; 
	    		}
	    		
	    		commonAjax.postAjax("/updateRepairBikeAjax.do", 'json', $("#frm").serialize()
          			, function(data){
          	        	if(data.resultMessage == 'Success'){
          	        		prevCenterId = centerId;
          	        		alert('수정이 완료되었습니다.');
          	        		$('#exeRepairBikeEdit').attr('disabled', false);
          	        		$("#frm").attr({method :"post", action :"/moveInspectBikeEditForm.do"}).submit();
          	        	}else{
          	        		alert('오류가 발생하였습니다.');
          	        		$('#exeRepairBikeEdit').attr('disabled', false);
          	        	}
	              	}
	  	        );
	    	}else if($('[name="viewFlg"]').val() == 'C'){
	    		commonAjax.postAjax("/insertRepairBikeAjax.do", 'json', $("#frm").serialize()
          			, function(data){
          	        	if(data.resultMessage == 'Success'){
          	        		alert('등록이 완료되었습니다.');
          	        		$('#exeRepairBikeEdit').attr('disabled', false);
          	        		$("#frm").attr({method :"post", action :"/inspectBikeList.do"}).submit();
          	        	}else{
          	        		alert('오류가 발생하였습니다.');
          	        		$('#exeRepairBikeEdit').attr('disabled', false);
          	        	}
	              	}
	  	        );
	    	}
	    	
	    }
	    
	    repairBikeInfo.getAdmComCodeInfo = function(comUpCd , pCb){
	    	$.ajax({
	    		type		: "post",
	    		url			: "/getAdmComCodeAjax.do",
	    		dataType	: "json",
	    		data		: {"comUpCd" : comUpCd },
	    		async		: false,//중복요청 방지_2017.06.09_JHN
	    		success		: function( data ) {
	    			pCb(data);
	    		},
	    		error : function(jqXHR, textStatus,errorThrown){
	    			if(jqXHR.status === 500 ){
	    				alert("에러가 발생했습니다.");
	    			}
	    		}
	    	});
	    }
	    
	    function setBikeId(bikeId, bikeNo) {
	    	$("[name='bikeId']").val(bikeId);
	    	$("[name='bikeNo']").val(bikeNo);
	    };
	</script>
</body>
</html>