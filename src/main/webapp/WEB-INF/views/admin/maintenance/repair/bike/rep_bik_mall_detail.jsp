<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" /> 
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />
<meta name="description=" Content="" />
<title><tiles:insertAttribute name="title"/></title>
<tiles:insertAttribute name="resource"/>
<link href="/css/jquery-editable-select.css" rel="stylesheet">
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
                            <input type="hidden" name="partsData" />
                            <input type="hidden" name="modifyPartsData" />
                            <input type="hidden" name="bikeReport" id="bikeReport" value=""/>
                            <input type="hidden" name="repairReport" id="repairReport" value=""/>
                            <input type="hidden" name="bikeStusCd" id="bikeStusCd" value="${repairBikeInfo.bikeStusCd}"/>
                            <input type="hidden" name="bikeStatusComCd" id="bikeStatusComCd" value="${repairBikeInfo.bikeStatusComCd}"/>
                            <!-- 20190201 양재영 추가 -->
                            <input type="hidden" name="adminId" id="adminId">
                            <!-- 20190326 양재영추가 -->
                            <input type="hidden" name="centerId" id="centerId">
                            
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
												<span><input type="text" name="bikeNo" readonly /></span>
												<span class="dash">/</span>
												<span><input type="text" name="bikeId" readonly /></span>
												<c:if test="${repairBikeInfo.bikeStatusName == null && repairBike.viewFlg == 'C'}">
												<a href="/common/pop/DEV_001/showFODevicePop.do" class="winNewPop modal btnType02" title="자전거찾기" data-width="450" data-height="480"  data-pmt="&searchType=R">찾기</a>
												</c:if>
											</td>
										</tr>
										<tr>
											<th><em>*</em> 유지보수자</th>
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
											</td>
										</tr>
										<c:if test="${repairBikeInfo.bikeStatusName != null}">
										<tr>
											<th> 장애구분</th>
											<td>
												<%-- ${repairBikeInfo.bikeStatusName} --%>
												<c:if test="${repairBikeInfo.repairCmptYn != 'Y'}"><select class="select-category01" style="width:400px;" id="comBikeStatusName" name="comBikeStatusName"></c:if>
												<c:if test="${repairBikeInfo.repairCmptYn == 'Y'}"><select class="select-category01" style="width:400px;" id="comBikeStatusName" name="comBikeStatusName"  disabled="disabled"></c:if>
														<option value="">선택</option>
												</select>
												</td>
										</tr>
										</c:if>
										<tr>
											<th><em>*</em> 수리구분</th>
											<td id="repairDivision">
												<!-- <span class="pwtableblock input-ck02"><input type="checkbox" id="c23" value="REB_024"><label for="c23">타이어.튜브</label></span>
												<span class="pwtableblock input-ck02"><input type="checkbox" id="c28" value="REB_027"><label for="c28">체인</label></span> -->
											
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
											<th><em>*</em> 보관센터</th>
											<td>
												<!-- 2019.03.26. -->
												<select class="select-category01"  style="width:400px" name="centerName" id="centerSlt">
													<option value="" >선택</option>
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

								<table class="tb_type01  mt20">
										<colgroup>
											<col style="width:7%">
											<col style="width:88%">
											<col style="width:7%">
										</colgroup>
										<thead>
											<tr>
												<th>NO</th>
												<th class="sd">부품 교체</th>
												<th class="last"><button id="addParts" class="fullBtn"><img src="/images/btn_addAnswer.png" alt=""></button></th>
											</tr>
										</thead>
										<tbody id="partsList">
										</tbody>
								</table>

								<div class="btnArea">
									<span class="left"><button class="btnType01 bc_gray" id="moveRepairBikeList">목록</button></span>
									<span class="right">
									    <c:if test="${empty repairBikeInfo.divisionValue || repairBikeInfo.divisionValue <= 1 }"><button type="button" class="btnType01 bc_green" id="exeRepairBikeEdit">저장</button></c:if>
										<c:if test="${empty repairBikeInfo.divisionValue || repairBikeInfo.divisionValue <= 1}"><button type="button" class="btnType01 bc_green" id="exeRepairBikeDelete">삭제</button></c:if>
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
	<!-- 2019.03.04 editable combo -->

	<script type="text/javascript" src="/js/jquery-editable-select.js"></script>
	
	
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
			
    		//var partsData = new Array(); //json
			//$('[name="partsData"]').val('[]');
			//$('[name="modifyPartsData"]').val('[]');
			
			// 자전거 수리구분 세팅
			commonAjax.getCommonCode("REC", function(data){
	    		if(data !== null && data.codeList !== null) {
	           	 	for(var i = 0; i < data.codeList.length; i++){
	            		$('<span class="pwtableblock input-ck02"><input type="checkbox" id="c'+i+'" value="'+data.codeList[i].comCd+'"/><label for="c'+i+'">'+data.codeList[i].comCdName+'</label></span>').appendTo('#repairDivision');
	           	 	}
	           	 	var repairCode = repairCodeList.replace(' ', '').replace('[', '').replace(']', '').split(',');
		 			for(var i=0; i < repairCode.length; i++) {
		     			$("input[value='"+repairCode[i].replace(' ', '')+"'").prop('checked', true);
		     		}
	            }
	    	});
 
			
			
	    });
	    
 	    var partsData = new Array(); //json
	    var prevPartsData = new Array(); //json
	    var modifyPartsData = new Array(); //json	    
	    var lineCnt = 0;
	    var repairBikeInfo = {};
	    repairBikeInfo.init = function(){
			
			if('${repairBikeInfo.partsData != null}' == 'true'){
				partsData = JSON.parse('${repairBikeInfo.partsData}');
				prevPartsData = JSON.parse('${repairBikeInfo.partsData}');
				lineCnt = partsData.length;
		    	repairBikeInfo.makePartsList(partsData);
			}
	    	
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
	    
	    repairBikeInfo.centerId = '${repairBikeInfo.centerId}' 	!== '' ? '${repairBikeInfo.centerId}' : '';
	    repairBikeInfo.adminId = '${repairBikeInfo.adminId}' 	!== '' ? '${repairBikeInfo.adminId}' : '';
	    
	    repairBikeInfo.initBtn = function(){
	    	var _this = repairBikeInfo;
	    	$("#moveRepairBikeList").on("click", this.moveRepairBikeList);
	    	$('#exeRepairBikeEdit').on("click", this.exeRepairBikeEdit);
	    	$('#exeRepairBikeDelete').on("click", this.exeRepairBikeDelete);
	    	$('#addParts').on("click", this.addParts);
	    }
	    
	  
      //$("[name='centerId']").val(centerId);	
	  
    commonAjax.getCenterMallCode = function( pCb) {
		this.ajax("post", "/commonCode/getCenterMallInfo.do", "json", {}, pCb);
	};
     
      var centerId = '${repairBikeInfo.centerId}' !== '' ?  '${repairBikeInfo.centerId}'.replace('CEN', '') : '';
	  repairBikeInfo.initCombo = function(){
	    	var _this = repairBikeInfo;
	    		    	
	    	// 2019.03.26. 보관센터
	    	commonAjax.getCenterMallCode( 
                function(data) {
                    if(data !== null && data.centerList !== null) {
                        commCdBox.makeComboBox('C', _this.centerId, data.centerList, "centerSlt");
                        $('#centerSlt > option').each(function() {
						      if($(this).text() == '${repairBikeInfo.centerName}') {
						         $(this).attr('selected', 'selected');
						      }
						  });
                       
                     
					    $('#centerSlt').editableSelect()
				    					// 센터 id 가져오는 로직
				    					.on('select.editable-select', function (e, li) {
				    						$('#centerId').val("CEN" + lpad( li.val(), 3, '0'));
				            					
				   						});
					    
                    }
                }
	        );
			// 정비
	    }
	  
	    function lpad(str, padLen, padStr) {
	        if (padStr.length > padLen) {
	            console.log("오류 : 채우고자 하는 문자열이 요청 길이보다 큽니다");
	            return str;
	        }
	        str += ""; // 문자로
	        padStr += ""; // 문자로
	        while (str.length < padLen)
	            str = padStr + str;
	        str = str.length >= padLen ? str.substring(0, padLen) : str;
	        return str;
	    }
	    
	    repairBikeInfo.moveRepairBikeList = function (e) {
	    	e.preventDefault();
	    	$('[name="repairCmptYn"]').val('${repairAp.repairCmptYn}');
	        $("#frm").attr({method :"post", action :"/repairBikeMallList.do"}).submit();
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
	    	
	    	if($('[name="centerId"]').val() == "" || $('[name="centerId"]').val() == undefined){
	    		alert('<spring:message code="fail.input.emptyValue2" arguments="보관센터"/>');
	    		$('[name="centerName"]').focus();
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

	    	if(repairBikeInfo.partsValidationCheck() == false){
	    		return;
	    	}
	    	
    		$("#bikeReport").val($("#bikeReportTxt").val());
    		
    		$("#repairReport").val($("#repairReportTxt").val());
    		
    		$('[name="partsData"]').val(JSON.stringify(partsData));
    		$('[name="modifyPartsData"]').val(JSON.stringify(modifyPartsData));
    		
    		
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
          	        		$("#frm").attr({method :"post", action :"/moveRepairBikeEditMallForm.do"}).submit();
          	        	}else{
          	        		alert('오류가 발생하였습니다.');
          	        		$('#exeRepairBikeEdit').attr('disabled', false);
          	        	}
	              	}
	  	        );
	    	} else if ($('[name="viewFlg"]').val() == 'C'){
	    		commonAjax.postAjax("/insertRepairBikeAjax.do", 'json', $("#frm").serialize()
          			, function(data){
          	        	if(data.resultMessage == 'Success'){
          	        		alert('등록이 완료되었습니다.');
          	        		$('#exeRepairBikeEdit').attr('disabled', false);
          	        		$("#frm").attr({method :"post", action :"/repairBikeMallList.do"}).submit();
          	        	}else{
          	        		alert('오류가 발생하였습니다.');
          	        		$('#exeRepairBikeEdit').attr('disabled', false);
          	        	}
	              	}
	  	        );
	    	}
	    }
	    
	    
	    repairBikeInfo.partsValidationCheck = function(){
	    	modifyPartsData = new Array();
	    	
	    	var tempPartsName;
	    	var tempCenterName;
	    	for(var i = 0; i < partsData.length; i++){
	    		tempPartsName = partsData[i].partsName;
	    		tempCenterName = partsData[i].centerName;
	    		if(partsData[i].partsName == ""){
					alert('부품명을 선택해주세요.');
					$('#partsName'+(i+1)).focus();
					return false;
				}
	    		if(partsData[i].centerName == ""){
					alert('센터를 선택해주세요.');
					$('#centerName'+(i+1)).focus();
					return false;
				}
	    		if(Number(partsData[i].usePartsCnt) < 1){
					alert('수량은 1보다 작을 수 없습니다.');
					$('#usePartsCnt'+(i+1)).focus();
					return false;
				}
	    		for(var j = i+1; j <  partsData.length; j++){
		    		if(partsData[j].partsName == tempPartsName && partsData[j].centerName == tempCenterName){
						alert('중복되는 부품값이 존재합니다.');
						$('#partsName'+(j+1)).focus();
						return false;
					}
	    		}
	    		
	    	}
	    	if(prevPartsData == ""){
				var modLength = modifyPartsData.length == undefined ? 0 : modifyPartsData.length;
		    	var obj = new Object();
			    for(var i = 0; i < partsData.length; i++){
			    	obj = new Object();
			    	obj['partsName'] = partsData[i].partsName;
			    	obj['centerName'] = partsData[i].centerName;
			    	obj['chngType'] = 'P';
			    	obj['chngCnt'] = partsData[i].usePartsCnt;
	    			modifyPartsData[i] = obj;
		    	}
	    	}else{
	    		for(var i = 0; i < partsData.length; i++){
	    			var cnt = 0;
					var modLength = modifyPartsData.length == undefined ? 0 : modifyPartsData.length;
					var obj = new Object();
	    			for(var j = 0; j < prevPartsData.length; j++){
		    			if(partsData[i].partsName == prevPartsData[j].partsName && partsData[i].centerName == prevPartsData[j].centerName && partsData[i].usePartsCnt != prevPartsData[j].usePartsCnt){
		    				obj['partsName'] = partsData[i].partsName;
	        		    	obj['centerName'] = partsData[i].centerName;
		    				if(Number(partsData[i].usePartsCnt) > Number(prevPartsData[j].usePartsCnt)){
		    					obj['chngType'] = 'P';
		        		    	obj['chngCnt'] = (Number(partsData[i].usePartsCnt) - Number(prevPartsData[j].usePartsCnt)).toString();
		    				}else if(Number(partsData[i].usePartsCnt) < Number(prevPartsData[j].usePartsCnt)){
		        		    	obj['chngType'] = 'M';
		        		    	obj['chngCnt'] = (Number(prevPartsData[j].usePartsCnt) - Number(partsData[i].usePartsCnt)).toString();
		    				}
		    				modifyPartsData[modLength] = obj;
		    				cnt++;
		    			}
		    			
		    			if(partsData[i].partsName == prevPartsData[j].partsName && partsData[i].centerName == prevPartsData[j].centerName && partsData[i].usePartsCnt == prevPartsData[j].usePartsCnt){
		    				cnt++;
		    			}
		    		}
	    			if(cnt == 0){
	    				obj['partsName'] = partsData[i].partsName;
	    		    	obj['centerName'] = partsData[i].centerName;
	    		    	obj['chngType'] = 'P';
	    		    	obj['chngCnt'] = partsData[i].usePartsCnt;
	        			modifyPartsData[modLength] = obj;
	    			}
	    		}
	    		
	    		for(var i = 0; i < prevPartsData.length; i++){
	    			var cnt = 0;
	    			var modLength = modifyPartsData.length == undefined ? 0 : modifyPartsData.length;
					var obj = new Object();
	    			for(var j = 0; j < partsData.length; j++){
	    				if(partsData[j].partsName == prevPartsData[i].partsName && partsData[j].centerName == prevPartsData[i].centerName){
		    				cnt++;
		    			}
		    		}
	    			if(cnt == 0){
	    				obj['partsName'] = prevPartsData[i].partsName;
	    		    	obj['centerName'] = prevPartsData[i].centerName;
	    		    	obj['chngType'] = 'M';
	    		    	obj['chngCnt'] = prevPartsData[i].usePartsCnt;
	        			modifyPartsData[modLength] = obj;
	    			}
	    		}
	    	}
	    	
	    	for(var i = 0; i < modifyPartsData.length; i ++){
	    		if(modifyPartsData[i].chngType == "P"){
	    			var remainPartsCnt;
	    			
	    			if(Number(modifyPartsData[i].chngCnt) > Number(partsData[i].remainPartsCnt)){
						alert('부품 재고가 부족합니다.');
						$('#usePartsCnt'+(i+1)).focus();
						return false;
					}

	    			$.ajax({
						url : "/getRemainPartsCnt.do",
						type : "post",
						dataType : "json",
						data : {partCd:modifyPartsData[i].partsName, centerId:modifyPartsData[i].centerName},
						async : false,
						success : function(data){
							if(data.resultMessage == "Success"){
								remainPartsCnt = data.remainPartsCnt == null ? 0 : data.remainPartsCnt
							}
						},
						error : function(jqXHR, textStatus,errorThrown){
							if(jqXHR.status === 500 || jqXHR.status === 200){
								alert("에러가 발생했습니다. : " + textStatus);
							}
						}
					});
	    			
		    		if(modifyPartsData[i].chngCnt > Number(remainPartsCnt)){
						alert('부품 재고에 변동이 발생했습니다. 다시 한번 확인해 주세요');
				    	repairBikeInfo.makePartsList(partsData);
						$('#usePartsCnt'+(i+1)).focus();
						return false;
					}
	    		}
	    	}
			return true;
	    }
	    	    
	    
	    repairBikeInfo.exeRepairBikeDelete = function (e) {
	    	e.preventDefault();
	    	if ( confirm("정말 삭제하시겠습니까?")) {
		    	commonAjax.postAjax("/deleteRepairBike.do", 'json', $("#frm").serialize()
	          			, function(data){
	          	        	if(data.resultMessage == 'Success'){
	          	        		alert('삭제가 완료되었습니다.');
	          	        		$('#exeRepairBikeEdit').attr('disabled', false);
	          	        		$("#frm").attr({method :"post", action :"/repairBikeMallList.do"}).submit();
	          	        	}else{
	          	        		alert('오류가 발생하였습니다.');
	          	        		$('#exeRepairBikeEdit').attr('disabled', false);
	          	        	}
		              	}
		    	    );
	    	}
	    }	
	    
	    
	    
	    
	    
	    repairBikeInfo.addParts = function(e){
	    	e.preventDefault();
	    	partsLineCnt = partsData.length == undefined ? 0 : partsData.length;
	    	
	    	var obj = new Object();
	    	obj['partsName'] = "";
	    	obj['centerName'] = "";
	    	obj['remainPartsCnt'] = "";
	    	obj['usePartsCnt'] = "";
	    	partsData[lineCnt] = obj;
	    	lineCnt++;
	    	repairBikeInfo.makePartsList(partsData);
	    };
	    
	    

	    repairBikeInfo.makePartsList = function(pData){
	    	
	    	
	    	$('#partsList').empty();
	    	
	    	var dataList = pData;
	    	
 	    	for(var i = 0; i < dataList.length; i++){
 	    		
 	    		var append  = '<tr>';
	 	    			append += '<td style="text-align:center" name="no">'+(i+1)+'</td>';
	 	    			append += '<td class="title">';
	 	    				append += '<span class="pwtableblock">';
	 	    					append += '<select id="partsName'+(i+1)+'" name="partsName"> class="select-category08"><option value="">부품명</option></select>';
	 	    					append += '<select id="centerName'+(i+1)+'" name="centerName" class="select-category08"><option value="">센터</option></select>';
	 	    				append += '</span>';
	 	    				append += '<span class="pwtableblock">';
	 	    					append += '<span class="input-text12">';
	 	    						append += '<input type="text" id="remainPartsCnt'+(i+1)+'" name="remainPartsCnt" readonly />'
	 	    					append += '</span>';
	 	    					append += '<span class="input-text12">'
	 	    						append += '<input type="text" id="usePartsCnt'+(i+1)+'" name="usePartsCnt" maxlength="5"/>'
	 	    					append += '</span>'
	 	    				append += '</span>'
	 	    			append += '</td>'
	 	    			append += '<td class="last" style="text-align:center">'
	 	    				append += '<button type="button" name="delParts" class="fullBtn"><img src="/images/btn_delAnswer.png" alt=""></button>'
	 	    			append += '</td>'
 	    			append += 	'</tr>';
 	    		
	    		$(append).appendTo('#partsList');
	    		
	    		$.ajax({
					url : "/commonCode/getCommonCode.do",
					type : "post",
					dataType : "json",
					data : {"comUpCd" : "PAR" },
					async : false,
					success : function(data){
						if(data !== null && data.codeList !== null) {
		    				commCdBox.makeComboBox("CC", dataList[i].partsName, data.codeList, "partsName"+(i+1));
		    			}
					},
					error : function(jqXHR, textStatus,errorThrown){
						if(jqXHR.status === 500 || jqXHR.status === 200){
							alert("에러가 발생했습니다. : " + textStatus);
						}
					}
				});
	    		
	    		$.ajax({
					url : "/commonCode/getCenterInfo.do",
					type : "post",
					dataType : "json",
					data : {},
					async : false,
					success : function(data){
						if(data !== null && data.centerList !== null) {
		    				commCdBox.makeComboBox("C", dataList[i].centerName, data.centerList, "centerName"+(i+1));
		    			}
					},
					error : function(jqXHR, textStatus,errorThrown){
						if(jqXHR.status === 500 || jqXHR.status === 200){
							alert("에러가 발생했습니다. : " + textStatus);
						}
					}
				});

	    		var remainPartsCnt;
	    		
	    		$.ajax({
					url : "/getRemainPartsCnt.do",
					type : "post",
					dataType : "json",
					data : {partCd:dataList[i].partsName, centerId:dataList[i].centerName},
					async : false,
					success : function(data){
						if(data.resultMessage == "Success"){
							remainPartsCnt = data.remainPartsCnt == null ? 0 : data.remainPartsCnt
						}
					},
					error : function(jqXHR, textStatus,errorThrown){
						if(jqXHR.status === 500 || jqXHR.status === 200){
							alert("에러가 발생했습니다. : " + textStatus);
						}
					}
				});
	    		
	    		$('#remainPartsCnt'+(i+1)).val(remainPartsCnt);
	    		$('#usePartsCnt'+(i+1)).val(dataList[i].usePartsCnt);
	    		
	    		
	    	}
	    }
	    
	    $(document).on('click', '[name="delParts"]', function(){
	    	var no = $(this).parent().parent().find('[name="no"]').text();
	    	var tempData = new Array(); //json
	    	var tempCnt = 0;

	    	for(var i = 0; i < partsData.length; i++){
	    		if(i != (no-1)){
	    			tempData[tempCnt] = partsData[i];
	    			tempCnt++;
	    		}
	    	}
	    	partsData = tempData;
	    	lineCnt--;
	    	repairBikeInfo.makePartsList(partsData);
	    });
	    
	    $(document).on('change', '[name="partsName"]', function(){
	    	var no = $(this).parent().parent().parent().find('[name="no"]').text();
	    	partsData[(no-1)].partsName = $('#partsName'+no).val();
	    	
	    	var partCd = $(this).val();
	    	var centerId = $(this).parent().parent().parent().find('[name="centerName"]').val();
	    	
	    	if(partCd != "" && centerId != ""){
	    		$.ajax({
					url : "/getRemainPartsCnt.do",
					type : "post",
					dataType : "json",
					data : {partCd:partCd, centerId:centerId},
					async : false,
					success : function(data){
						if(data.resultMessage == "Success"){
							var remainPartsCnt = data.remainPartsCnt == null ? 0 : data.remainPartsCnt
							$('#remainPartsCnt'+no).val(remainPartsCnt);
							partsData[(no-1)].remainPartsCnt = remainPartsCnt;
						}
					},
					error : function(jqXHR, textStatus,errorThrown){
						if(jqXHR.status === 500 || jqXHR.status === 200){
							alert("에러가 발생했습니다. : " + textStatus);
						}
					}
				});
	    	}
	    });
	    
	    $(document).on('change', '[name="centerName"]', function(){
	    	var no = $(this).parent().parent().parent().find('[name="no"]').text();
	    	partsData[(no-1)].centerName = $('#centerName'+no).val();
	    	
	    	var partCd = $(this).parent().parent().parent().find('[name="partsName"]').val();
	    	var centerId = $(this).val();
	    	
	    	if(partCd != "" && centerId != ""){
	    		$.ajax({
					url : "/getRemainPartsCnt.do",
					type : "post",
					dataType : "json",
					data : {partCd:partCd, centerId:centerId},
					async : false,
					success : function(data){
						if(data.resultMessage == "Success"){
							var remainPartsCnt = data.remainPartsCnt == null ? 0 : data.remainPartsCnt
							$('#remainPartsCnt'+no).val(remainPartsCnt);
							partsData[(no-1)].remainPartsCnt = remainPartsCnt;
						}
					},
					error : function(jqXHR, textStatus,errorThrown){
						if(jqXHR.status === 500 || jqXHR.status === 200){
							alert("에러가 발생했습니다. : " + textStatus);
						}
					}
				});
	    	}
	    });
	    
	    // 2020-02-14
	    $(document).on('change', '[name="usePartsCnt"]', function(){
	    	var no = $(this).parent().parent().parent().parent().find('[name="no"]').text();
	    	partsData[(no-1)].usePartsCnt = $('#usePartsCnt'+no).val();
	    });
	    
	    
	    function setBikeId(bikeId, bikeNo) {
	    	$("[name='bikeId']").val(bikeId);
	    	$("[name='bikeNo']").val(bikeNo);
	    };
	</script>
</body>
</html>