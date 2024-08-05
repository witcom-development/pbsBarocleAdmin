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
<!-- 
	개발일시 : 2020-06-05
	개발자   : 김시성
	내용     : 정비직원 수리 입력화면 수정
	TODO :  
	
	ASIS : 단말기 수리등록은 단말기 항목에 체크사항이 있으면 접속자로 자동 등록
	       자전거 수리완료시 단말기도 무조건 수리완료 처리
	        
 -->
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" /> 
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />
<meta name="description=" Content="" />
<title><tiles:insertAttribute name="title"/></title>
<tiles:insertAttribute name="resource"/>

<style type="text/css">
	td {
		
	}
</style>


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
                            <!-- 20200608 solbit 센터 고정으로 변경  -->
                            <input type="hidden" name="centerId" id="centerId">
                            <!-- 20200714 내 목록만 보기 -->
                            <input type="hidden" name="onlyMyListYn" id="onlyMyListYn">
                            
                            <div class="tabWrap type3">
	                        	<ul class="tabBox mt20">
                                    <li class="tab on"><button type="button">자전거</button></li>
									<li class="tab"><button type="button">단말기</button></li>
								</ul>
							</div>	
							<fieldset>
								<legend>자전거 등록 / 상세 / 수정</legend>
								<table class="tb_type02 mt20">
									<colgroup>
										<col style="width:25%"/>
										<col style="width:75%"/>
									</colgroup>
									<tbody>
										<tr>
											<th class="top"><em>*</em> 자전거 번호 <!-- / ID --></th>
											<td class="top">
												<span class="input-text08"><input type="text" name="bikeNo" readonly /></span>
												<!-- <span class="dash">/</span> -->
												<span class="input-text12"><input type="hidden" name="bikeId" readonly /></span>
												<c:if test="${repairBikeInfo.bikeStatusName == null && repairBike.viewFlg == 'C'}">
												<a href="/common/pop/DEV_001/showFODevicePopDtlObs.do" class="winNewPop modal btnType02" title="자전거찾기" data-width="450" data-height="480"  data-pmt="&searchType=R">찾기</a>
												</c:if>
											</td>
										</tr>
										<c:if test="${repairBikeInfo.repairCmptYn == 'N'}">
											<tr>
												<th>최근 수리완료시간</th>
												<td id="tdLastDttm">
													
												</td>
											</tr>
										</c:if>	
										<tr id="repBikeAdTr">
											<th><em>*</em><span>유지보수자</span></th>
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
										<tr id="repTermAdTr">
											<th><em>*</em><span>단말기수리자</span></th>
											<td>
											<span class="input-text21" id="repairTermAdminName">
											
											<c:if test="${repairTermInfo.termAdminName != null}">
												"${repairTermInfo.termAdminName}"
											</c:if>
											<c:if test="${repairTermInfo.termAdminName == null}">
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
										<tr id="repBikeCmpTr">
											<th><em>*</em> 상태</th>
											<td>
												<span class="input-rd01"><input type="radio" name="repairCmptYn" id="a3" value="N"><label for="a3">수리중</label></span>
												<span class="input-rd01"><input type="radio" name="repairCmptYn" id="ab3" value="Y"><label for="ab3">수리완료</label></span>
											</td>
										</tr>
										<tr id="repTermCmpTr">
											<th>단말기 상태</th>
											<td>
												<span id="termCmptYn"></span>
												<input type="hidden" name="termCmptYn" />
											</td>
										</tr>
										<tr>
											<th>특이사항</th>
											<td>
												<span class="input-text21"><input type="text" name="bikeReportTxt" id="bikeReportTxt" value="${repairBikeInfo.bikeReport}"/></span>
											</td>
										</tr>
										<tr id="TermTr" style="display:none;">
											<th>단말기 수리등록</th>
												<td>
												<c:if test="${repairBikeInfo.repairCmptYn != 'Y' && repairTermInfo.termCmptYn != 'Y'}">
														<button class="btnType01 bc_gray" id="cmptRepairTermUpd">수리완료 처리</button>
														<span class="pwtableblock input-ck02"><input type="checkbox" id="skipBikeRepairYn"><label for="skipBikeRepairYn">자전거 점검 불필요</label></span> 
												</c:if>	
												</td>
										</tr>
									</tbody>
								</table>
								<h2 class="mt10" style="color:#33335a;">수리구분</h2>
								<table class="tb_type02 mt10" style="margin-top : 0px;">
									<colgroup>
										<col style="100%">
									</colgroup>
									<tbody>
										<tr id="repairReb">
											<td class="top" id="repairBike">
												<h1 class="mb10" style="margin-bottom: 5px; color: #33335a; background: #eff5f8;">점검(부품미사용)</h1>
												<div class="container pb-3">
													<div class="row" style="margin:0;">

													</div>
												</div>												
											</td>
											<td class="top" id="repairTerm">
												<h1 class="mb10" style="margin-bottom: 5px; color: #33335a; background: #eff5f8;">점검(부품미사용)</h1>
												<div class="container pb-3">
													<div class="row" style="margin:0;">

													</div>
												</div>												
											</td>
										</tr>
										<tr id="gubunTr" style="display:none;">
											<td class="top">
												<h2 style="display:inline-block; margin-right: 5px;">정비 구분</h2>
												<span class="input-rd01"><input type="radio" name="radioQr" id="qr1"value="QR" checked=true/><label for="qr1">QR/전기</label></span>
												<span class="input-rd01"><input type="radio" name="radioQr" id="qr2"value="빅텍"/><label for="qr1">빅텍</label></span>
												<span class="input-rd01"><input type="radio" name="radioQr" id="qr3"value="위트콤"/><label for="qr1">위트콤</label></span>
											</td>
										</tr>										
										<tr id="repairPar">
											<td id="partsBike">
												<h1 class="mb10" style="margin-bottom: 5px; color: #33335a; background: #eff5f8;">정비(부품사용)</h1>
												<div class="container pb-3">
													<div class="row" style="margin:0;">

													</div>
												</div>
											</td>
											<td class="top" id="partsTerm">
												<h1 class="mb10" style="margin-bottom: 5px; color: #33335a; background: #eff5f8;">정비(부품사용)</h1>
												<div class="container">
													<div id="radioQr" class="row" style="margin:0;"></div>
													<div id="radioBc" class="row" style="margin:0;"></div>
													<div id="radioWe" class="row" style="margin:0;"></div>
												</div>
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
    $(function(){
		
		var repairSeq = '${repairBikeInfo.repairSeq}' !== '' ? '${repairBikeInfo.repairSeq}' : '';										//수리일련번호
	    var bikeNo = '${repairBikeInfo.bikeNo}' !== '' ? '${repairBikeInfo.bikeNo}' : '${repairBike.bikeNo}';							//수리자전거 일련번호
	    var bikeId = '${repairBikeInfo.bikeId}' !== '' ? '${repairBikeInfo.bikeId}' : '${repairBike.bikeId}';							//수리자전거 아이디
	    var repairCmptYn = '${repairBikeInfo.repairCmptYn}' !== '' ? '${repairBikeInfo.repairCmptYn}' : '';								//수리완료 YN
		var repairCodeList = '${repairBikeInfo.repairCodeList}' !== '' ? '${repairBikeInfo.repairCodeList}' : '';						//수리항목 코드 리스트
		
		// 2019-02-01추가
		var adminId = '<%= com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil.getSessionAttribute(request, "usrId") %>';
		
		// 2020-07-13 자전거 납품처 추가
		var entrpsCd = '${repairBikeInfo.entrpsCd}' !== '' ? '${repairBikeInfo.entrpsCd}' : '';
		
		// 2020-07-14 내 목록만보기 추가
		var onlyMyListYn = '${repairBike.onlyMyListYn}' !== '' ? '${repairBike.onlyMyListYn}' : '';
		$("[name='onlyMyListYn']").val(onlyMyListYn);
		
		// 2020-06-08 추가
		repairBikeInfo.repairSeq = repairSeq; 
		repairBikeInfo.repairCmptYn = repairCmptYn; 
		repairBikeInfo.repairCodeList = repairCodeList;
		repairBikeInfo.entrpsCd = entrpsCd;
		repairBikeInfo.gubunValCnt = 0;
		
		// 2020-06-08 재고 등록 센터 고정
		repairBikeInfo.partsCenterId;
		$.ajax({
			url  : "/getAdminCenterIdAjax.do"
		   ,type : "post"
		   ,async: false
		   ,data : "adminId="+adminId
		   ,success : function(data){
			   repairBikeInfo.partsCenterId = data.centerId;
		   }
		   ,error : function(data){
			   alert("통신실패");
		   }
		});
		
		/******* 단말기 정보 S *******/
		repairBikeInfo.termSeq = '${repairTermInfo.termSeq}' !== '' ? '${repairTermInfo.termSeq}' : '';												//단말기 수리 일련번호
		repairBikeInfo.termAdminId = adminId;																										//단말기 수리자 아이디
		repairBikeInfo.termCenterId = '${repairTermInfo.termCenterId}' !== '' ? '${repairTermInfo.termCenterId}' : repairBikeInfo.partsCenterId;	//단말기 수리자 소속 사업소 아이디
		repairBikeInfo.repairTermCmptYn = '${repairTermInfo.termCmptYn}' !== '' ? '${repairTermInfo.termCmptYn}' : ''; 								//단말기 수리완료 YN
		/******* 단말기 정보 E *******/
		
		$("[name='adminId']").val(adminId);
		$("[name='centerId']").val(repairBikeInfo.partsCenterId);
		$("[name='bikeNo']").val(bikeNo);
		$("[name='bikeId']").val(bikeId);
		$("[name='repairCmptYn']:input[value='"+repairCmptYn+"']").prop('checked', true);
		
		
		$("[name='termCmptYn']").val(repairBikeInfo.repairTermCmptYn);
		$("#termCmptYn").text(repairBikeInfo.repairTermCmptYn == 'Y' ? '수리완료' : repairBikeInfo.repairTermCmptYn == 'N' ? '수리중' : '');
    	
    	repairBikeInfo.init();
    	repairBikeInfo.initBtn();
		
		
		
    });
	/*********** 변수 및 함수 S ************/
    var partsData = new Array(); //json
    var prevPartsData = new Array(); //json
    var modifyPartsData = new Array(); //json
    var lineCnt = 0;
    
	var repairBikeInfo = {};
	repairBikeInfo.orgRebCdList;			//공통코드 REB 모든 값을 가지고있는 List
	repairBikeInfo.orgParCdList;			//공통코드 PAR 모든 값을 가지고있는 List
    repairBikeInfo.centerId = '${repairBikeInfo.centerId}' !== '' ? '${repairBikeInfo.centerId}' : '';
    repairBikeInfo.centerName = '${repairBikeInfo.centerName}' !== '' ? '${repairBikeInfo.centerName}' : '';
    repairBikeInfo.adminId = '${repairBikeInfo.adminId}' !== '' ? '${repairBikeInfo.adminId}' : '';	
    repairBikeInfo.termRadioChk = "";		//단말기 항목 있는지 체크 후 이 변수로 단말기 구분 매핑
    
	
    repairBikeInfo.exeRepairBikeEdit = function (e) {	//저장
    	
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
    	$('#repairReb input[type="checkbox"]:checked').each(function(e){
    		if(repairCode.length > 0){
    			repairCode = repairCode+",";
    		}
			repairCode = repairCode+$(this).val();
		});
    	
    	if(repairCode.length == 0){
    		alert('<spring:message code="fail.input.emptyValue1" arguments="수리구분"/>');
    		return;
    	}

    	
    	$('[name="repairCode"]').val(repairCode);

    	if(repairBikeInfo.partsValidationCheck() == false){
    		return;
    	}
    	
    	/* 2020-07-06 김시성 : 항목 체크여부를 이미 하기때문에 굳이 상태체크를 강제할 필요가없다. */
		if($('[name="repairCmptYn"]:checked').val() == undefined || $('[name="repairCmptYn"]:checked').val() != "Y"){
			
			if(!repairBikeInfo.repairTermCmptYn || repairBikeInfo.repairTermCmptYn == undefined || repairBikeInfo.repairTermCmptYn == ""){
				
				repairBikeInfo.repairTermCmptYn = "N";
				repairBikeInfo.repairCmptYn = "N";
				
			}
    		$("[name='repairCmptYn']:radio[value='N']").prop('checked', true);
    		
    	}else if($('[name="repairCmptYn"]:checked').val() == "Y"){
    		
			repairBikeInfo.repairTermCmptYn = "Y";
			repairBikeInfo.repairCmptYn = "Y";
		}
    	
		$("#bikeReport").val($("#bikeReportTxt").val());
		
		$("#repairReport").val($("#repairReportTxt").val());
		
		$('[name="partsData"]').val(JSON.stringify(repairBikeInfo.nullChkPartsArr));
		$('[name="modifyPartsData"]').val(JSON.stringify(modifyPartsData));
		
  		$('#exeRepairBikeEdit').attr('disabled', true);
  		
  		
  		/************************단말기항목 체크 S******************************/
  		
  		var termCheck = false;
  		
    	$('#repairTerm input[type="checkbox"]:checked').each(function(idx,item){
    		
			termCheck = true;
			return true;

    	});
    	
  		if(!termCheck){
  			
	    	$('#partsTerm input[type="checkbox"]:checked').each(function(idx,item){
	    		
				termCheck = true;
				return true;
					
			});
	    	
  		}
  		/************************단말기항목 체크 E******************************/
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
      	        		
      	        		if(termCheck){
      	        			
          	        		if(repairBikeInfo.repairCmptYn == 'Y'){
          	        			
          	        			repairBikeInfo.repairTermCmptYn = 'Y';
          	        			$("[name='termCmptYn']").val("Y")
          	        			
          	        		}else{
          	        			
          	        			
          	        			if(!$("[name='termCmptYn']").val() || $("[name='termCmptYn']").val() == ''){
          	        				
	          	        			repairBikeInfo.repairTermCmptYn = 'N';
	          	        			$("[name='termCmptYn']").val("N")
          	        				
          	        			}
          	        			
          	        		}
          	        		
      	        			repairBikeInfo.updateRepairTermAjax(e);
      	        			
      	        		}
      	        		
      	        		$('#exeRepairBikeEdit').attr('disabled', false);
      	        		$("#frm").attr({method :"post", action :"/moveRepairBikeEditMgmtForm.do"}).submit();
      	        		
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
      	        		
						if(termCheck){
      	        			
          	        		if(repairBikeInfo.repairCmptYn == 'Y'){
          	        			
          	        			repairBikeInfo.repairTermCmptYn = 'Y';
          	        			$("[name='termCmptYn']").val("Y");
          	        			
          	        		}							
							
      	        			repairBikeInfo.repairSeq = data.repairSeq;
							repairBikeInfo.updateRepairTermAjax(e);	
      	        			
      	        		}
      	        		
      	        		$('#exeRepairBikeEdit').attr('disabled', false);
      	        		$("#frm").attr({method :"post", action :"/repairBikeMgmtList.do"}).submit();
      	        		
      	        	}else{
      	        		
      	        		alert('오류가 발생하였습니다.');
      	        		$('#exeRepairBikeEdit').attr('disabled', false);
      	        		
      	        	}
              	}
  	        );
    		
    	}
  
    }   
    
    repairBikeInfo.getPartsList = function(pData){		//경정비내역 호출 
		
    	var dataList = pData;
    	
	    for(var i = 0; i < dataList.length; i++){

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
    		
    		//단말기 경정비 개수 체크박스로 변경 했기때문에 그에 따른 로직 변경 처리
    		var valueType = $('[name='+dataList[i].partsName+']').attr('type');
    		if(valueType == "text") $('[name='+dataList[i].partsName+']').val(dataList[i].usePartsCnt);
    		else {
    			$('[name='+dataList[i].partsName+']').val(dataList[i].usePartsCnt);
    			$('[name='+dataList[i].partsName+']').prop("checked",true);
    			repairBikeInfo.termRadioChk  = $('[name='+dataList[i].partsName+']').parent().parent().attr('id');
    			
    			
    		}
    		
    		
    		
    	}
	    partsData.splice(0,partsData.length);	//비교에 필요한 데이터는 prePartsData에도 있기 때문에 화면에 뿌려주고 나서는 비운다
    }
	
	repairBikeInfo.getCngRdCdList = function(radioValue){	//라디오버튼 에 따라 show / hide
		
		if(radioValue == "QR"){

			$('#radioQr').show();
	   	 	$('#radioBc').hide();
	   	 	$('#radioWe').hide();
			
		}else if(radioValue == "빅텍"){

			$('#radioQr').hide();
	   	 	$('#radioBc').show();
	   	 	$('#radioWe').hide();
			
		}else if(radioValue == "위트콤"){
			
			$('#radioQr').hide();
	   	 	$('#radioBc').hide();
	   	 	$('#radioWe').show();
			
		}
		
	}
	
	repairBikeInfo.getCngTabCdList = function(tabValue){	//탭에 따라 show / hide
		
		if(tabValue == "자전거"){
			
	   	 	$('#repairBike').show();
	   		$('#partsBike').show();
	   		
	   	 	$('#repairTerm').hide();
	   		$('#partsTerm').hide();
	   		
		}else{
			
	   	 	$('#repairTerm').show();
	   		$('#partsTerm').show();
			
	   	 	$('#repairBike').hide();
	   		$('#partsBike').hide();
	   		
	   		if(this.gubunValCnt == 0){
	   			//처음만 자전거 납품처 확인 후 단말기 구분 자동 선택 처리
	   			
	   			if(repairBikeInfo.termRadioChk ==""){
	   				
		   			var gubunVal = "";
	   				gubunVal = gubunVal+this.entrpsCd;
	   	
					if(gubunVal != ""){
						
						$('[name="radioQr"]').each(function(){
							
							if($(this).val().indexOf(gubunVal) > -1){
								
								$(this).prop("checked",true);
								repairBikeInfo.getCngRdCdList($(this).val());
								repairBikeInfo.gubunValCnt ++;
								
							}else{
								
								if(gubunVal.indexOf("에이텍티앤")){
									
									if($(this).val() == "QR") {
										
										$(this).prop("checked",true);
										repairBikeInfo.getCngRdCdList($(this).val());
										repairBikeInfo.gubunValCnt ++;
										
									}
									
								}
								
							}
							
						});
						
					}
				
	   			}else{
	   				
					$('[name="radioQr"]').each(function(){
						
						if(repairBikeInfo.termRadioChk == "radioBc" && $(this).val() == "빅텍"){
							
							$(this).prop("checked",true);
							repairBikeInfo.getCngRdCdList($(this).val());
							repairBikeInfo.gubunValCnt ++;
							
						}else if(repairBikeInfo.termRadioChk == "radioWc" && $(this).val() == "위트콤"){
							
							$(this).prop("checked",true);
							repairBikeInfo.getCngRdCdList($(this).val());
							repairBikeInfo.gubunValCnt ++;
							
						}else if(repairBikeInfo.termRadioChk == "radioQr" && $(this).val() == "QR"){
							
							$(this).prop("checked",true);
							repairBikeInfo.getCngRdCdList($(this).val());
							repairBikeInfo.gubunValCnt ++;
							
						}
						
					});
	   				
	   			}
				
	   		}
		}
		
	}
	
	/************** 경정비 재고 체크 S  **************/
	
	repairBikeInfo.partsValidationCheck = function(){
		
		$("#repairPar input[type='text']").each(function(idx,item){
			if(!$(item).val()){}else{
				
				if($(item).val() != ""){
					
					var obj = new Object();
					obj['partsName'] = $(item).attr('name');
					obj['centerName'] = repairBikeInfo.partsCenterId;
					obj['usePartsCnt'] = $(item).val();
					partsData[idx] = obj;
					
				}
			}
			
		});
		
    	$('#repairPar input[type="checkbox"]:checked').each(function(idx,item){
    		
				if($(item).val() != ""){
					
					var obj = new Object();
					obj['partsName'] = $(item).attr('name');
					obj['centerName'] = repairBikeInfo.partsCenterId;
					obj['usePartsCnt'] = $(item).val();
					partsData[idx] = obj;
					
				}
				
		});
		
		var nullChkPartsArr = partsData.filter(Boolean);
		repairBikeInfo.nullChkPartsArr = nullChkPartsArr;
		var remainPartsCnt;
		
		if(!nullChkPartsArr[0]){
		}else{
			
			for(var i = 0; i < nullChkPartsArr.length;i++){
				
				$.ajax({
					url : "/getRemainPartsCnt.do",
					type : "post",
					dataType : "json",
					data : {partCd:nullChkPartsArr[i].partsName, centerId:nullChkPartsArr[i].centerName},
					async : false,
					success : function(data){
						if(data.resultMessage == "Success"){
							remainPartsCnt = data.remainPartsCnt == null ? 0 : data.remainPartsCnt
							nullChkPartsArr[i].remainPartsCnt = remainPartsCnt;		
						}
					},
					error : function(jqXHR, textStatus,errorThrown){
						if(jqXHR.status === 500 || jqXHR.status === 200){
							alert("에러가 발생했습니다. : " + textStatus);
						}
					}
				});
			
			}
			
		}
		
    	modifyPartsData = new Array();
    	
    	var tempPartsName;
    	var tempCenterName;
    	
    	for(var i = 0; i < nullChkPartsArr.length; i++){
    		
    		tempPartsName = nullChkPartsArr[i].partsName;
    		tempCenterName = nullChkPartsArr[i].centerName;
    		
    		if(Number(nullChkPartsArr[i].usePartsCnt) < 1){
    			
				alert('수량은 1보다 작을 수 없습니다.');
				$('[name='+tempPartsName+']').focus();
				return false;
				
			}
        	var regExp = /^[0-9]*$/;
        	if(!regExp.test(Number(nullChkPartsArr[i].usePartsCnt))) {
        		
        		alert("수량은 숫자로만 작성하세요.");
        		$('[name='+tempPartsName+']').focus();3
        		return false;
        	}
    		
    	}
    	
    	if(prevPartsData == ""){	//불러온 경정비 데이터가 없을 때
			var modLength = modifyPartsData.length == undefined ? 0 : modifyPartsData.length;
	    	
	    	var obj = new Object();
		    for(var i = 0; i < nullChkPartsArr.length; i++){
		    	
		    	obj = new Object();
		    	obj['partsName'] = nullChkPartsArr[i].partsName;
		    	obj['centerName'] = nullChkPartsArr[i].centerName;
		    	obj['chngType'] = 'P';
		    	obj['chngCnt'] = nullChkPartsArr[i].usePartsCnt;
    			modifyPartsData[i] = obj;
    			
	    	}
		    
    	}else{	//불러온 경정비 데이터가 있을 때
    		
    		for(var i = 0; i < nullChkPartsArr.length; i++){
    			
    			var cnt = 0;
				var modLength = modifyPartsData.length == undefined ? 0 : modifyPartsData.length;
				var obj = new Object();
				
    			for(var j = 0; j < prevPartsData.length; j++){
    				
	    			if(nullChkPartsArr[i].partsName == prevPartsData[j].partsName && nullChkPartsArr[i].centerName == prevPartsData[j].centerName && nullChkPartsArr[i].usePartsCnt != prevPartsData[j].usePartsCnt){
	    				
	    				obj['partsName'] = nullChkPartsArr[i].partsName;
        		    	obj['centerName'] = nullChkPartsArr[i].centerName;
        		    	
	    				if(Number(nullChkPartsArr[i].usePartsCnt) > Number(prevPartsData[j].usePartsCnt)){
	    					
	    					obj['chngType'] = 'P';
	        		    	obj['chngCnt'] = (Number(nullChkPartsArr[i].usePartsCnt) - Number(prevPartsData[j].usePartsCnt)).toString();
	        		    	
	    				}else if(Number(nullChkPartsArr[i].usePartsCnt) < Number(prevPartsData[j].usePartsCnt)){
	    					
	        		    	obj['chngType'] = 'M';
	        		    	obj['chngCnt'] = (Number(prevPartsData[j].usePartsCnt) - Number(nullChkPartsArr[i].usePartsCnt)).toString();
	        		    	
	    				}
	    				
	    				modifyPartsData[modLength] = obj;
	    				cnt++;
	    				
	    			}
	    			
	    			if(nullChkPartsArr[i].partsName == prevPartsData[j].partsName && nullChkPartsArr[i].centerName == prevPartsData[j].centerName && nullChkPartsArr[i].usePartsCnt == prevPartsData[j].usePartsCnt){
	    				cnt++;
	    			}
	    		}
    			
    			if(cnt == 0){
    				
    				obj['partsName'] = nullChkPartsArr[i].partsName;
    		    	obj['centerName'] = nullChkPartsArr[i].centerName;
    		    	obj['chngType'] = 'P';
    		    	obj['chngCnt'] = nullChkPartsArr[i].usePartsCnt;
        			modifyPartsData[modLength] = obj;
        			
    			}
    		}
    		
    		for(var i = 0; i < prevPartsData.length; i++){
    			
    			var cnt = 0;
    			var modLength = modifyPartsData.length == undefined ? 0 : modifyPartsData.length;
				var obj = new Object();
    			for(var j = 0; j < nullChkPartsArr.length; j++){
    				
    				if(nullChkPartsArr[j].partsName == prevPartsData[i].partsName && nullChkPartsArr[j].centerName == prevPartsData[i].centerName){
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
    	
    	//재고 체크 여기서 함!!!.
    	for(var i = 0; i < modifyPartsData.length; i ++){
    		
    		if(modifyPartsData[i].chngType == "P"){
    			var remainPartsCnt;
    			
    			if(Number(modifyPartsData[i].chngCnt) > Number(nullChkPartsArr[i].remainPartsCnt)){
    				
					var check = confirm('부품 재고가 부족합니다.\n등록하시겠습니까?');
					
					if(!check){
						
						$('[name='+nullChkPartsArr[i].partsName+']').focus();
						return false;
						
					}
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
    			
/*  	    		if(modifyPartsData[i].chngCnt > Number(remainPartsCnt)){
	    			
					alert('부품 재고에 변동이 발생했습니다. 다시 한번 확인해 주세요');
					$('[name='+nullChkPartsArr[i].partsName+']').focus();
					return false;
					
				}  */
				
    		}
    	}
		return true;
    }
	
	/************** 경정비 재고 체크 E  **************/
	
	/**************************** init S **************************/
	
	repairBikeInfo.init = function(){
		
		//수리중 일때 해당 자전거의 마지막 수리완료시간 화면에 뿌리기
		<c:if test="${repairBikeInfo.repairCmptYn == 'N'}">

			$.ajax({
				url : "/getRepairCmptDttmAjax.do",
				type : "post",
				dataType : "json",
				data : {bikeId:$("[name='bikeId']").val()},
				async : false,
				success : function(data){
					if(data.resultMessage == "Success"){
						
						var lastDttm = data.lastDttm;
						if(lastDttm != null){
							$("#tdLastDttm").text(lastDttm);
						}else if(lastDttm == null){
							$("#tdLastDttm").text("최근 수리완료건 없음");
						}
					}
				}
				
			});
			
	    </c:if>	
		
		
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
		
		
		/********************공통코드 에서 REB 와 PAR 호출 S*******************/
		var rebCnt = 0;
    	repairBikeInfo.getAdmComCodeInfo("REB", function(data){
    		if(data !== null && data.codeList !== null) {
    			repairBikeInfo.orgRebCdList = data.codeList;
    			rebCnt = repairBikeInfo.orgRebCdList.length;
            }
    		
    	});
		
    	var rebCdListBike = new Array(rebCnt);	//reb 코드에서 addVal1 이 bike인 것만 담는 배열
    	var rebCdListTerm = new Array(rebCnt);	//reb 코드에서 addVal1 이 term인 것만 담는 배열
   	 	
    	for(var i = 0; i < this.orgRebCdList.length; i++){
   	 		var gubun = this.orgRebCdList[i].addVal1;
   	 		var ord = this.orgRebCdList[i].addVal2;
   	 		if(!gubun){
   	 		}else if(gubun == "BIKE"){
   	 			
   	 			 rebCdListBike[ord] = '<div class="col-md-3 py-1 mx-0 px-0 input-ck02 text-left"><input type="checkbox" id="c'+i+'" value="'+this.orgRebCdList[i].comCd+'"/><label for="c'+i+'">'+this.orgRebCdList[i].comCdName+'</label></div>';
   	 			 
   	 			 
   	 			 						
   	 		}else if(gubun == "TERM"){
   	 			
   	 			 rebCdListTerm[ord] = '<div class="col-md-3 py-1 mx-0 px-0 input-ck02 text-left"><input type="checkbox" id="c'+i+'" value="'+this.orgRebCdList[i].comCd+'"/><label for="c'+i+'">'+this.orgRebCdList[i].comCdName+'</label></div>';
   	 			 
   	 		}
   	 	}
		
    	var nullChkRebBikeArr = rebCdListBike.filter(Boolean);
   	 	
    	for(var i = 0; i< nullChkRebBikeArr.length;i++){
   	 		
   	 		$('#repairBike .pb-3 .row').append(nullChkRebBikeArr[i]);
   	 	}
   	 	
    	var nullChkRebTermArr = rebCdListTerm.filter(Boolean);
   	 	
   	 	for(var i = 0; i< nullChkRebTermArr.length;i++){
   	 		
	   	 	$('#repairTerm .pb-3 .row').append(nullChkRebTermArr[i]);
   	 	}
   	 	
   	 	$('#repairTerm').hide();	//첫 화면은 자전거가 메인이기 때문에 단말기 예방점검은 hide
   	 	
   	 	/*****************수리중 & 수리완료 인 경우 테이블에서 가져온 reb값을 화면에 checked 작업 S *******************/
   	 	
   	 	var repairCode = this.repairCodeList.replace(' ', '').replace('[', '').replace(']', '').split(',');
		
   	 	for(var i=0; i < repairCode.length; i++) {
   	 		
 			$("input[value='"+repairCode[i].replace(' ', '')+"']").prop('checked', true);
   	 	}
   	 	
   	 	/*****************수리중 & 수리완료 인 경우 테이블에서 가져온 reb값을 화면에 checked 작업 E *******************/
   	 	
		/********************공통코드 에서 REB 호출 E*******************/
		
		/********************공통코드 에서 PAR 호출 S*********************/
		
		var parCnt = 0;
		repairBikeInfo.getAdmComCodeInfo("PAR", function(data){
    		
    		if(data !== null && data.codeList !== null) {
    			
    			repairBikeInfo.orgParCdList = data.codeList;
    			parCnt = repairBikeInfo.orgParCdList.length;

            }
    		
    	});
		
		var parCdListBike = new Array(parCnt);
    	var qrCdList = new Array(parCnt);
    	var bcCdList = new Array(parCnt);
    	var weCdList = new Array(parCnt);
		
	   	/**************** 경정비 생성 시 재고 체크 S*****************/
    	var partsStockList;
    	var stockLen = 0;
    	
   		$.ajax({
			url : "/getPartsStockCnt.do",
			type : "post",
			dataType : "json",
			data : {partCd:parCd, centerId:repairBikeInfo.partsCenterId},
			async : false,
			success : function(data){
				if(data.resultMessage == "Success"){
					partsStockList = data.partsStockList;
					stockLen = partsStockList.length;
				}
			},
			error : function(jqXHR, textStatus,errorThrown){
				if(jqXHR.status === 500 || jqXHR.status === 200){
					alert("에러가 발생했습니다. : " + textStatus);
				}
			}
		});
	 	/**************** 경정비 생성 시 재고 체크 E*****************/
    	
   	 	for(var i = 0; i < parCnt; i++){
   	 		
   	 		var item = repairBikeInfo.orgParCdList[i];
   	 		var parUpCd = ""; if(!item.addVal1);else parUpCd += item.addVal1;
   	 		var ord = "";     if(!item.addVal2);else ord = item.addVal2;
   	 		var menu = "";    if(!item.addVal3);else menu = item.addVal3;
   	 		
   	 		var parCd = item.comCd;
   	 		var parName = item.comCdName;
   	 		
   	 		var remainPartsCnt = 0;
   	 		for(var x = 0; x < stockLen; x++){
   	 			
   	 			var item = partsStockList[x];
   	 			
   	 			if(parCd == item.partCd) remainPartsCnt = item.partQunt;
   	 			
   	 		}
   	 		
        	 	for(var j = 0; j < rebCnt; j++){
       	 		
       	 		var item = repairBikeInfo.orgRebCdList[j];
       	 		var rebCd = "";
       	 		var check = "";
       	 		if(!item.comCd);else  rebCd = item.comCd;
       	 		if(!item.addVal1);else check = item.addVal1;
       	 		
       	 		
       	 		if(parUpCd == rebCd && check == "BIKE"){
       	 			
       	 			/* if(remainPartsCnt > 0){ */
       	 				
       	 		 		/* parCdListBike[ord] =  '<div class="col-2 col-md-3 py-1 px-md-3 border">'+parName+'</div><div class="col-1 col-md-1 py-1 px-md-1 border text-center"><input type="text" class="s-rp-input border-0 text-center" name="'+parCd+'" maxlength="2" value=""/></div> '; */
       	 				
       	 			/* }else{//재고 체크 구간 */
       	 				
       	 				parCdListBike[ord] =  '<div class="col-2 col-md-3 py-1 px-md-3 border">'+parName+"&nbsp; ("+remainPartsCnt+")"+'</div><div class="col-1 col-md-1 py-1 px-md-1 border text-center"><input type="text" class="s-rp-input border-0 text-center" name="'+parCd+'" maxlength="2" value="" /></div> ';
       	 		 		
       	 			/* } */
       	 		}else if(parUpCd == rebCd && check == "TERM"){
       	 			
/*        	 			if(remainPartsCnt > 0){
       	 				
       	 					 if(menu == "QR") qrCdList[ord] = '<div class="col-1 col-md-1 py-1 px-md-0 input-ck02" style="display: inline-block;text-align: -webkit-right;"><input id="tc'+i+'" name="'+parCd+'"type="checkbox" value=""/></div><div class="col-2 col-md-3 py-1 px-md-5" style="display: inline-block;"><label for="tc'+i+'">'+parName+'</label></div>';
       	 				else if(menu == "빅텍") bcCdList[ord] = '<div class="col-1 col-md-1 py-1 px-md-0 input-ck02" style="display: inline-block;text-align: -webkit-right;"><input id="tc'+i+'" name="'+parCd+'"type="checkbox" value=""/></div><div class="col-2 col-md-3 py-1 px-md-5" style="display: inline-block;"><label for="tc'+i+'">'+parName+'</label></div>';
       	 				else if(menu == "위트콤") weCdList[ord] = '<div class="col-1 col-md-1 py-1 px-md-0 input-ck02" style="display: inline-block;text-align: -webkit-right;"><input id="tc'+i+'" name="'+parCd+'"type="checkbox" value=""/></div><div class="col-2 col-md-3 py-1 px-md-5" style="display: inline-block;"><label for="tc'+i+'">'+parName+'</label></div>';
    	 				
       	 			}else{//재고 체크 구간 */
       	 				
       	 			 		 if(menu == "QR") qrCdList[ord] = '<div class="col-md-3 py-1 mx-0 px-0 input-ck02 text-left"><input id="tc'+i+'" name="'+parCd+'"type="checkbox" value="" /><label for="tc'+i+'" style="font-size:11px;">'+parName+'('+remainPartsCnt+')</label></div>';
    	 				else if(menu == "빅텍") bcCdList[ord] = '<div class="col-md-3 py-1 mx-0 px-0 input-ck02 text-left"><input id="tc'+i+'" name="'+parCd+'"type="checkbox" value="" /><label for="tc'+i+'" style="font-size:11px;">'+parName+'('+remainPartsCnt+')</label></div>';
    	 				else if(menu == "위트콤") weCdList[ord] = '<div class="col-md-3 py-1 mx-0 px-0 input-ck02 text-left"><input id="tc'+i+'" name="'+parCd+'"type="checkbox" value="" /><label for="tc'+i+'" style="font-size:11px;">'+parName+'('+remainPartsCnt+')</label></div>';
       	 				
/*        	 			}	 */
       	 		}
       	 		
       	 	}
   	 	}
   	 	
   	 	var nullChkBikeArr = parCdListBike.filter(Boolean);
   	 	
   	 	for(var i=0; i< nullChkBikeArr.length; i++){
   	 		
   	 		$("#partsBike .pb-3 .row").append(nullChkBikeArr[i]);
   	 	}
   	 	
   	 	var nullChkQrCdArr = qrCdList.filter(Boolean);
   	 	var nullChkBcCdArr = bcCdList.filter(Boolean);
   	 	var nullChkWeCdArr = weCdList.filter(Boolean);
   	 	
   	 	for(var i=0; i< nullChkQrCdArr.length; i++){
   	 		
  	 		$("#radioQr").append(nullChkQrCdArr[i]);
   	 	}
   	 	for(var i=0; i< nullChkBcCdArr.length; i++){
   	 		
  	 		$("#radioBc").append(nullChkBcCdArr[i]);
   	 	}
   	 	for(var i=0; i< nullChkWeCdArr.length; i++){
   	 		
  	 		$("#radioWe").append(nullChkWeCdArr[i]);
   	 	}
   	 	
   	 	
   	 	$('#partsTerm').hide();		//단말기 - 경정비 hide
   	    $('#repTermAdTr').hide();	//단말기 - 단말기 수리자 hide
   	    $('#repTermCmpTr').hide();	//단말기 - 단말기 상태 hide
   	 	$('#radioBc').hide();		//단말기 - 경정비에 회사별로 영역을 주었기에 Qr이 아닌 빅텍 영역 hide
   	 	$('#radioWe').hide();		//단말기 - 경정비에 회사별로 영역을 주었기에 Qr이 아닌 위트콤 영역 hide
   	 	
		/********************공통코드 에서 PAR 호출 E*********************/
		
		/************ 수리중 & 수리완료 인 경우 테이블에서 경정비 부품 데이터 호출 S ************/
		
		if('${repairBikeInfo.partsData != null}' == 'true'){
			partsData = JSON.parse('${repairBikeInfo.partsData}');
			prevPartsData = JSON.parse('${repairBikeInfo.partsData}');
			lineCnt = partsData.length;
	    	repairBikeInfo.getPartsList(partsData);
		}
		
		/************ 수리중 & 수리완료 인 경우 테이블에서 경정비 부품 데이터 호출 E ************/
		
		/******************* 수리완료이면 입력 차단 S *******************/
		
 		if(this.repairCmptYn === 'Y'){
 			
			$("#repairReb").find('input').each(function(){
				
				$(this).attr("disabled",true);
				
			});
			
			$("#repairPar").find('input').each(function(){
				
				$(this).attr("disabled",true);
				
			});
			
		}else if(this.repairTermCmptYn === 'Y'){
			
			$("#repairTerm").find('input').each(function(){
				
				$(this).attr("disabled",true);
				
			});
			
			$("#repairPar").find('input').each(function(){
				
				if($(this).attr("type") === "checkbox"){
					
					$(this).attr("disabled",true);
					
				}
				
			});
			
			
		}
		
		/******************* 수리완료이면 입력 차단 E *******************/
		
		/********** 경정비 개수 입력 리스너 S ***********/
		
		$("input[type=text]").on("propertychange change keyup paste input",function(){	//경정비 개수 입력칸 숫자만 입력 정규식
			
			if($("#bikeReportTxt").attr('id') == $(this).attr('id')) return;
			
			$(this).val($(this).val().replace(/[^0-9]*$/,""));

		});
		
		/********** 경정비 개수 입력 리스너 E ***********/
		
    }
	
	/**************************** init E **************************/
    
	/*********** 버튼 이벤트리스너 등록 S **********/
	
	
	repairBikeInfo.initBtn = function(){
		
		$("#tempRepairTermUpd").on("click",this.tempRepairTermUpd);
		$("#cmptRepairTermUpd").on("click",this.cmptRepairTermUpd);
    	
		$("#moveRepairBikeList").on("click", this.moveRepairBikeList);
    	$('#exeRepairBikeEdit').on("click", this.exeRepairBikeEdit);
    	
		$("ul.tabBox li").on("click",function() {		//tab 이벤트 리스너
			
			$("ul.tabBox li").removeClass("on");
			$(this).addClass("on");
			var tabLabel = $(this).text();
			if(tabLabel == "단말기"){
				
				$("#repTermAdTr").show();
				$("#repTermCmpTr").show();
				$("#repBikeAdTr").hide();
				$("#repBikeCmpTr").hide();
				$("#gubunTr").css("display","show");
				$("#gubunTr").show();
				$("#TermTr").css("display","show");
				$("#TermTr").show();
				repairBikeInfo.getCngTabCdList(tabLabel);
				
			}else{
				
				$("#repBikeAdTr").show();
				$("#repBikeCmpTr").show();
				$("#repTermAdTr").hide();
				$("#repTermCmpTr").hide();
				$("#gubunTr").css("display","none");
				$("#gubunTr").hide();
				$("#TermTr").css("display","none");
				$("#TermTr").hide();
				repairBikeInfo.getCngTabCdList(tabLabel);
				
			}
			
		});
		
		$("[name='radioQr']").on("change",function(){		//단말기 구분 라디오 이벤트 리스너
			repairBikeInfo.getCngRdCdList($(this).val());
		});
		
		
    	$('#repairPar input[type="checkbox"]').on("change",function(){	//단말기 경정비 체크박스로 변경
    		if($(this).is(":checked")) {
    			
    			$(this).val("1");
    			console.log($(this).val());
    		}else{
    			
    			$(this).val("");
    			console.log($(this).val());
    		}
    	});
    	
    }
	
	/*********** 버튼 이벤트리스너 등록 E **********/
    
    /*********** 자전거번호 찾기 팝업에서 호출 할 함수 S **********/
    
 	function setBikeId(bikeId, bikeNo) {
    	$("[name='bikeId']").val(bikeId);
    	$("[name='bikeNo']").val(bikeNo);
    	
    	$.ajax({
			url : "/getBikeEntrsAjax.do",
			type : "post",
			dataType : "json",
			data : {bikeId:$("[name='bikeId']").val()},
			async : false,
			success : function(data){
				if(data.resultMessage == "Success"){
					
					var gubunVal = "";
					gubunVal = gubunVal+data.entrpsName;
					if(gubunVal != ""){
						
						$('[name="radioQr"]').each(function(){
							
							if($(this).val().indexOf(gubunVal) > -1){
								
								$(this).prop("checked",true);
								repairBikeInfo.getCngRdCdList($(this).val());
								repairBikeInfo.gubunValCnt ++;
								
							}else{
								
								if(gubunVal.indexOf("에이텍티앤")){
									
									if($(this).val() == "QR") {
										
										$(this).prop("checked",true);
										repairBikeInfo.getCngRdCdList($(this).val());
										repairBikeInfo.gubunValCnt ++;
										
									}
									
								}
								
							}
							
						});
						
					} 

				}
			},
			error : function(jqXHR, textStatus,errorThrown){
				if(jqXHR.status === 500 || jqXHR.status === 200){
					alert("에러가 발생했습니다. : " + textStatus);
				}
			}
		});
    	
    };
   
    /*********** 자전거번호 찾기 팝업에서 호출 할 함수 E **********/
    
    /*********** 공통코드 호출 함수 S *************/
    
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
    
    repairBikeInfo.updateRepairTermAjax = function(e){
    	
    	e.preventDefault();
    	
    	var url;
    	if(this.termSeq == "") url = "/insertRepairTermAjax.do";
    	else url = "/updateRepairTermAjax.do"

    	var params = {
    		  repairSeq : this.repairSeq
    	       ,termSeq : this.termSeq
    	   ,termAdminId : this.termAdminId
    	  ,termCenterId : this.termCenterId
    	    ,termCmptYn : this.repairTermCmptYn
    	};
    	
    	$.ajax({
    		type		: "post",
    		url			: url,
    		dataType	: "json",
    		data		: params,
    		async		: false,//중복요청 방지_2017.06.09_JHN
    		success		: function( data ) {
    			
    			if(!data.termSeq){}else repairBikeInfo.termSeq = data.termSeq;

    			$("[name='termCmptYn']").val(params.termCmptYn);
    			$("#termCmptYn").text((params.termCmptYn == 'Y') ? '수리완료' : '수리중');
    			$("#repairTermAdminName").text("");
    			var value = "&ldquo;<%= com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil.getSessionAttribute(request, "usrName") %>&rdquo;";
    			$("#repairTermAdminName").html(value);
    				
    		},
    		error : function(jqXHR, textStatus,errorThrown){
    			if(jqXHR.status === 500 ){
    				alert("에러가 발생했습니다.");
    			}
    		}
    	});
    	
    }
    
	repairBikeInfo.moveRepairBikeList = function (e) {
		
		e.preventDefault();
		
	    $('[name="repairCmptYn"]').val('${repairAp.repairCmptYn}');
	    $("#frm").attr({method :"post", action :"/repairBikeMgmtList.do"}).submit();
	    
	};
	
	repairBikeInfo.cmptRepairTermUpd = function(e){
	    e.preventDefault();
		
	    switch (repairBikeInfo.repairCmptYn){
	    	case "Y" : 
	    		alert("수리완료 된 자전거입니다.");
	    	break;
	    	default :
	    		repairBikeInfo.repairTermCmptYn = "Y";
	    		$("[name='termCmptYn']").val("Y");
	    		
	    		var check = $("#skipBikeRepairYn").is(":checked");
	    		
	    		if(check) {
	    			
	    			$("[name='repairCmptYn']:radio[value='Y']").prop('checked', true);
	    			$("[name='repairCmptYn']").val("Y");
	    			
	    		}
	    		
	    		repairBikeInfo.exeRepairBikeEdit(e);
	    		
	    	break;
	    }

	};    
    
    /*********** 공통코드 호출 함수 E *************/
    
	
	/*********** 변수 및 함수 E ************/
	</script>
</body>
</html>