<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	
	ASIS : 2020-10-21 : 화면을 로드했을 때의 단말기상태가 수리완료인 경우(화면단에서 단말기상태값 변경기준X) 단말기수리자와 현재 접속자가 다를 때
	                    자전거 점검,정비 체크항목을 확인 해 체크항목이 없다면 수정 차단 - 자전거 수리자 변경방지
	                      
					  , 기존 점검 필수에서 점검 혹은 정비 필수로 변경 
					  	
		   2020-10-14 : 로딩속도 개선작업 (ajax 호출 중 동기화 할 필요없는 호출들 비동기로 전환) 
	
		   2020-10-13 : 예전 재고내역에 사용하던 코드 삭제 작업 
	
	       2020-10-06 : 자전거 찾기 시에 배터리 교체일자 정보 가져와 화면처리
	       
	       2020-09-11 : 해당 센터가 단말기팀일 경우 단말기 탭으로 이동 처리
	       
	       2020-09-10 : 정비,정비반장은 근태 등록했는지 확인 후 등록하지 않았다면 알림창 띄운 후 메인화면으로 이동 처리
	
		   단말기 수리등록은 단말기 항목에 체크사항이 있으면 접속자로 자동 등록
	       자전거 수리완료시 단말기도 무조건 수리완료 처리
	       
	       (단말기 수리완료 되어있지 않다면 단말기 수리중에서 다른 정비직원이 단말기 수리항목을 체크 했을 시 단말기 수리자는 기존 정비직원이 아닌 다른 정비직원이됨)
	        
	       2021-09-29 : 방차장 요청사항( 체인텐셔너 추가 ) 
	                    INSPB , MAB 에 추가 ( 연결은 ADD_VAL1 에 추가 해줘야 해당 부분에 포함됨 )  
 -->
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" /> 
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />
<meta name="description=" Content="" />
<title><tiles:insertAttribute name="title"/></title>
<tiles:insertAttribute name="resource"/>

<style type="text/css">
	.rebTable {
		width:100%;
	}
	.rebTable td {
		padding: 0%;
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
							<input type="hidden" name="mode" value="newPage" />
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
										<tr>
											<th>배터리 교체일자</th>
											<td id="tdBatReplaceTime">
												<c:if test="${empty repairBikeInfo.batReplaceTime}">
													정보없음
												</c:if>	
												<c:if test="${repairBikeInfo.batReplaceTime ne ''}">
													${repairBikeInfo.batReplaceTime}
												</c:if>													
											</td>
										</tr>
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
									<tbody id="repairBike">
										<tr>
											<td class="top">
												<div class="insp">
													<table class="rebTable">
														<colgroup>
															<col style="width:25%;">
															<col style="width:45%;">
															<col style="width:15%;">
															<col style="width:15%;">
														</colgroup>
														<thead>
															<tr>
																<td class="text-center">구분</td>
																<td class="text-center">수리부문</td>
																<td class="text-center">점검</td>
																<td class="text-center">정비</td>
															</tr>
														</thead>
													</table>
												
												</div>
											</td>
												
										</tr>
									</tbody>
									<tbody id="repairTerm">
										<tr>
											<td id="termReb" class="top">
												<h1 class="mb10" style="margin-bottom: 5px; color: #33335a; background: #eff5f8;">점검(부품미사용)</h1>
												<div class="container pb-3">
													<div class="row" style="margin:0;">

													</div>
												</div>
											</td>											
										</tr>
										<tr id="gubunTr">
											<td class="top">
												<h2 style="display:inline-block; margin-right: 5px;">정비 구분</h2>
												<span class="input-rd01"><input type="radio" name="radioQr" id="qr1" value="QR" checked=true /><label for="qr1">QR</label></span>
												<span class="input-rd01"><input type="radio" name="radioQr" id="qr2" value="LCD"/><label for="qr2">LCD</label></span>
												<span>제조사 : </span><span id="entrpsCd"></span>
											</td>										
										</tr>
										<tr>
											<td class="top">
												<h1 class="mb10" style="margin-bottom: 5px; color: #33335a; background: #eff5f8;">정비(부품사용)</h1>
												<div class="container">
													<div id="radioQr" class="row" style="margin:0;"></div>
													<div id="radioLcd" class="row" style="margin:0;"></div>
												</div>
											</td>										
										</tr>
									</tbody>
								</table>
								
								<div class="btnArea">
									<span class="left"><button class="btnType01 bc_gray" id="moveRepairBikeList">목록</button></span>
									<span class="right">
										<c:if test="${repairBikeInfo.editRepairYn == 'Y' || repairBikeInfo.repairCmptYn != 'Y'}"><button type="button" class="btnType01 bc_green" id="exeRepairBikeEdit">저장</button></c:if>
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
    	
    	// 2020-09-10 - 정비인원이 근태 등록하지 않았을 경우 근태 등록하도록 메인화면으로 이동
    	repairBikeInfo.checkAdmin('<%= com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil.getSessionAttribute(request, "usrId") %>');
    	
		var repairSeq = '${repairBikeInfo.repairSeq}' !== '' ? '${repairBikeInfo.repairSeq}' : '';										//수리일련번호
	    var bikeNo = '${repairBikeInfo.bikeNo}' !== '' ? '${repairBikeInfo.bikeNo}' : '${repairBike.bikeNo}';							//수리자전거 일련번호
	    var bikeId = '${repairBikeInfo.bikeId}' !== '' ? '${repairBikeInfo.bikeId}' : '${repairBike.bikeId}';							//수리자전거 아이디
	    var repairCmptYn = '${repairBikeInfo.repairCmptYn}' !== '' ? '${repairBikeInfo.repairCmptYn}' : '';								//수리완료 YN
	    var editRepairYn = '${repairBikeInfo.editRepairYn}' !== '' ? '${repairBikeInfo.editRepairYn}' : '';								//당일건인지
		var repairCodeList = '${repairBikeInfo.repairCodeList}' !== '' ? '${repairBikeInfo.repairCodeList}' : '';						//수리항목 코드 리스트
		
		// 2019-02-01추가
		var adminId = '<%= com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil.getSessionAttribute(request, "usrId") %>';
		
		// 2020-07-13 자전거 납품처 추가
		var entrpsCd = '${repairBikeInfo.entrpsCd}' !== '' ? '${repairBikeInfo.entrpsCd}' : '등록정보없음';
		$("#entrpsCd").text(entrpsCd);
		
		// 2020-07-14 내 목록만보기 추가
		var onlyMyListYn = '${repairBike.onlyMyListYn}' !== '' ? '${repairBike.onlyMyListYn}' : '';
		$("[name='onlyMyListYn']").val(onlyMyListYn);
		
		// 2020-06-08 추가
		repairBikeInfo.repairSeq = repairSeq; 
		repairBikeInfo.repairCmptYn = repairCmptYn; 
		repairBikeInfo.editRepairYn = editRepairYn; 
		repairBikeInfo.repairCodeList = repairCodeList;
		repairBikeInfo.entrpsCd = entrpsCd;
		repairBikeInfo.gubunValCnt = 0;
		
		// 2020-06-08 재고 등록 센터 고정
		repairBikeInfo.partsCenterId;
		$.ajax({
			url  : "/getAdminCenterIdAjax.do"
		   ,type : "post"
		   ,data : "adminId="+adminId
		   ,async	: false
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
		
    	// 2020-09-11 - 센터가 단말기팀일 경우에는 단말기 탭으로 이동
   		$.ajax({
   			type 	: "post"
   		   ,url 	: "/getAdmCenterCodeAjax.do"
   		   ,dataType: 'json'
   		   ,async	: false
   		   ,success : function(data){
   				
   			 	if(data !== null && data.centerList !== null) {
   			 		
   			 		var centerList = data.centerList;
   			 		
   			 		for(var i= 0; i< centerList.length; i++){
   			 			
   			 			if(centerList[i].centerId == repairBikeInfo.partsCenterId){
   			 				
   			 				var cenName = centerList[i].centerName;
   			 				
   			 				if(cenName.indexOf("단말기") > -1){
   			 					
	   			 				$("ul.tabBox li").each(function(){
	   			 					
	   			 					$(this).removeClass("on");
	   			 			
			   			 			if($(this).text() == "단말기") $(this).addClass("on"); 
			   			 			
	   			 				});
   			 					
	   			 				$("#repTermAdTr").show();
	   							$("#repTermCmpTr").show();
	   							$("#TermTr").show();
	   							$("#repBikeAdTr").hide();
	   							$("#repBikeCmpTr").hide();
	   			 				repairBikeInfo.getCngTabCdList("단말기");
	   							repairBikeInfo.getCngRdCdList($("[name='radioQr']:checked").val());
   			 					
   			 				} 
   			 					
   			 			}
   			 			
   			 		}
   			 		
   			 	}
   				
   			}
   		   ,error : function(data){
   			   
   				alert("센터코드 조회에 실패했습니다.");
   				
   			}
   		});
		
		
    });
	/*********** 변수 및 함수 S ************/
    var partsData = new Array(); //json
    var prevPartsData = new Array(); //json
    var modifyPartsData = new Array(); //json
    var lineCnt = 0;
    
	var repairBikeInfo = {};
	repairBikeInfo.orgRebCdList;																				//공통코드 REB 모든 값을 가지고있는 List
	repairBikeInfo.orgInbarocleCdList;																				//공통코드 INSPB 모든 값을 가지고있는 List
	repairBikeInfo.orgMabCdList;																				//공통코드 MAB 모든 값을 가지고있는 List
    repairBikeInfo.centerId = '${repairBikeInfo.centerId}' !== '' ? '${repairBikeInfo.centerId}' : '';
    repairBikeInfo.centerName = '${repairBikeInfo.centerName}' !== '' ? '${repairBikeInfo.centerName}' : '';
    repairBikeInfo.adminId = '${repairBikeInfo.adminId}' !== '' ? '${repairBikeInfo.adminId}' : '';	
    repairBikeInfo.termRadioChk = "";																			//단말기 항목 있는지 체크 후 이 변수로 단말기 구분 매핑
    
	
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
    	
    	$('.repairInbarocle').each(function(e){//점검
    		
    		if($(this).is(":checked")){
    			
    			if(repairCode.length > 0){
    				
        			repairCode = repairCode+",";
        			
        		}
    			
    			repairCode = repairCode+$(this).val();
    			
    		}
    		
    	});
    	
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
		
		
    	if(repairCode.length == 0 && $('[name="partsData"]').val().length <= 2){
    		alert('<spring:message code="fail.input.emptyValue1" arguments="수리구분"/>');
    		return;
    	}
    	
    	//2020-10-21 : 화면을 로드할 때의 단말기상태가 수리완료인 경우(화면단에서 단말기상태값 변경기준X) 단말기수리자와 현재 접속자가 다를 때
    	if('${repairTermInfo.termCmptYn}' === "Y" && $("[name='adminId']").val() !== '${repairTermInfo.termAdminId}'){ 
    		
    		var bikeCheck = false;
    		
    		$('#repairBike .repairInbarocle:checked').each(function(){
    			bikeCheck = true;
    		});
    		
    		$('#repairBike .repairMab:checked').each(function(){
    			bikeCheck = true;
    		});
    		
    		if(!bikeCheck){
    			
    			alert('<spring:message code="fail.input.emptyValue1" arguments="수리구분"/>');
        		return;
    			
    		}
    		
    	}
		
  		$('#exeRepairBikeEdit').attr('disabled', true);
  		
  		
  		/************************단말기항목 체크 S******************************/
  		
  		var termCheck = false;
  		
    	$('#repairTerm input[type="checkbox"]:checked').each(function(idx,item){
    		
    		if(repairBikeInfo.checkTermCmpt == "Y" || $('[name="termCmptYn"]').val() !== 'Y') termCheck = true;
			return true;

    	});
    	
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
    			
    				if(data.checkRental != null && data.checkRental == "Fail"){
    					
    					alert("대여중인 자전거는 등록하실 수 없습니다.");
    					$("#frm").attr({method :"post", action :"/repairBikeMgmtList.do"}).submit();
    					
    				}else if(data.checkOverLap != null && data.checkOverLap == "Fail"){
    					
    					alert("해당자전거는 이미 당일 수리완료 처리 되어있습니다.");
    					$("#frm").attr({method :"post", action :"/repairBikeMgmtList.do"}).submit();
    					
    				}else{
    					
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
    				
              	}
  	        );
    		
    	}
  
    }   
    
    repairBikeInfo.getPartsList = function(pData){		//경정비내역 호출 
		
    	var dataList = pData;
    	
	    for(var i = 0; i < dataList.length; i++){

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
    		
    		$('[name='+dataList[i].partsName+']').val(dataList[i].usePartsCnt);
    		$('[name='+dataList[i].partsName+']').prop("checked",true);
    		
		    if(repairBikeInfo.termRadioChk == ""){
		    
		    	if(dataList[i].partsName.indexOf("PAR") > -1 ) repairBikeInfo.termRadioChk = $('[name="'+dataList[i].partsName+'"]').parent().parent().attr("id");
		    	
		    }
		    
    	}
	    
	    if(repairBikeInfo.termRadioChk != ""){
	    	
	    	if(repairBikeInfo.termRadioChk == "radioQr"){
	    		
	    		$("[name='radioQr']:radio[value='QR']").prop("checked",true);
	    		
	    	}else if(repairBikeInfo.termRadioChk == "radioLcd"){
	    		
	    		$("[name='radioQr']:radio[value='LCD']").prop("checked",true);
	    		
	    	}
	    	
	    }
	    
	    partsData.splice(0,partsData.length);	//비교에 필요한 데이터는 prePartsData에도 있기 때문에 화면에 뿌려주고 나서는 비운다
    }
	
	repairBikeInfo.getCngRdCdList = function(radioValue){	//라디오버튼 에 따라 show / hide
		
		if(radioValue == "QR"){

			$('#radioQr').show();
	   	 	$('#radioLcd').hide();
			
		}else if(radioValue == "LCD"){

			$('#radioQr').hide();
	   	 	$('#radioLcd').show();
			
		}
		
	}
	
	repairBikeInfo.getCngTabCdList = function(tabValue){	//탭에 따라 show / hide
		
		if(tabValue == "자전거"){
			
	   	 	$('#repairBike').show();
	   	 	$('#repairTerm').hide();
	   		
		}else{
			
	   	 	$('#repairTerm').show();
	   	 	$('#repairBike').hide();
	   		
		}
		
	}
	
	/************** 경정비 재고 체크 S  **************/
	
	repairBikeInfo.partsValidationCheck = function(){
		
    	$('.repairMab').each(function(idx,item){
    		
    		if($(this).is(":checked")){
    			
				if($(this).val() != ""){
					
					var obj = new Object();
					obj['partsName'] = $(item).attr('name');
					obj['centerName'] = repairBikeInfo.partsCenterId;
					obj['usePartsCnt'] = "1";
					partsData[idx] = obj;
					
				}
				
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
			
			repairBikeInfo.nullChkPartsArr = nullChkPartsArr;
			
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
		
		//20200813 - 자전거 점검 공통코드 바꿈 S
		
		var rebCnt
    	repairBikeInfo.getAdmComCodeInfo("REB", function(data){//구분 값
    		
    		if(data !== null && data.codeList !== null) {
    			repairBikeInfo.orgRebCdList = data.codeList;
    			rebCnt = repairBikeInfo.orgRebCdList.length;
    			 
            }
    		
    	});
    	
    	repairBikeInfo.getAdmComCodeInfo("INSPB", function(data){// 점검 값
    		
    		if(data !== null && data.codeList !== null) {
    			 repairBikeInfo.orgInbarocleCdList = data.codeList; 

            }
    		
    	});
    	
		repairBikeInfo.getAdmComCodeInfo("MAB", function(data){// 정비(자전거) 값
    		
    		if(data !== null && data.codeList !== null) {
    			
    			repairBikeInfo.orgMabCdList = data.codeList;

            }
    		
    	});
		
		repairBikeInfo.getAdmComCodeInfo("PAR", function(data){// 정비(단말기) 값
			
			if(data !== null && data.codeList !== null){
				
				repairBikeInfo.orgParCdList = data.codeList;
				
			}
			
		});
		
    	
    	var rebCdListBike = [];	// 자전거
    	var rebCdListTerm = [];	// 단말기
    	for(var i = 0; i < this.orgRebCdList.length; i++){//구분(종합현황)에서 자전거 와 단말기 분리
    		
   	 		var gubun = this.orgRebCdList[i].addVal1;
   	 		var ord = this.orgRebCdList[i].addVal2;
   	 		
   	 		var comUpCd = this.orgRebCdList[i].comCd;

   	 		
   	 		var rowCnt = 0;
   	 		
   	 		for(var j = 0; j < this.orgInbarocleCdList.length; j++){//구분(종합현황)에 속한 수리부문(개인실적) 개수 구하기
   	 			
   	 			var comCd = this.orgInbarocleCdList[j].addVal1;
   	 			
   	 			if(comUpCd == comCd) rowCnt++;
   	 			
   	 		}
   	 		
   	 		if(!gubun){
   	 		}
   	 		else if(gubun == "BIKE"){//구분(종합현황) 코드와 구분(종합현황) 이름, 구분(종합현황)에 속한 수리부문 개수 저장 : 자전거 구분
   	 			var obj = new Object();
   	 			
   	 			obj['comCd'] = comUpCd;
   	 			obj['comCdName'] = this.orgRebCdList[i].comCdName;
   	 			obj['rowValue'] = rowCnt;
   	 			obj['ord'] = ord;
   	 			
   	 			rebCdListBike.push(obj);
   	 			 
   	 		} 
   	 		else if(gubun == "TERM"){//구분(종합현황) 코드와 구분(종합현황) 이름, 구분(종합현황)에 속한 수리부문 개수 저장 : 단말기 구분
   	 			
   	 			var obj = new Object();
   	 			
   	 			obj['comCd'] = comUpCd;
   	 			obj['comCdName'] = this.orgRebCdList[i].comCdName;
   	 			obj['rowValue'] = rowCnt;
   	 			obj['ord'] = ord;
   	 			
   	 			rebCdListTerm.push(obj);
   	 			 
   	 		}

    	}
    	//자전거 S
    	//정렬 S
    	var sortRebBikeList = []
    	for(var i = 0; i < rebCdListBike.length; i++){
    		var obj = this.arrSort(rebCdListBike,(i+1));
    		if(!obj);else{
	    		sortRebBikeList.push(obj);
    		}
    	}
    	console.log( sortRebBikeList )
	 		
    	//정렬 E
    	
    	var colorNameCode = "aliceblue;";
    	var colorNameArr = ['aliceblue;','#cbf9e4;'];
    	
   		var tableCodeList = [];
    	for(var i =0; i < sortRebBikeList.length; i++){
    		
    		var comCd = sortRebBikeList[i].comCd;
    		var comCdName = sortRebBikeList[i].comCdName;
    		var rowValue = sortRebBikeList[i].rowValue;
    		var rowCnt = 0;
    		var rowColorCnt = 0;
    		
     		var mabCdArr = [];
    		
     		if ( j==0) console.log( comCd + " : " +  "comCdName : " + comCdName );
    		
       	 	for(var z = 0; z < this.orgMabCdList.length; z++){
       	 		
       	 		var mabUpCd = ""; 
       	 		if(!this.orgMabCdList[z].addVal1); else mabUpCd += this.orgMabCdList[z].addVal1;
       	 		
       	 		if(comCd == mabUpCd){
       	 			
       	 			var obj = new Object();
       	 			
       	 			obj['comCd'] = this.orgMabCdList[z].comCd;
       	 			obj['ord'] = this.orgMabCdList[z].addVal2;
       	 			
       	 			mabCdArr.push(obj);
       	 			
       	 		}
       	 		
       	 	}
    		
	    	for(var j =0; j < this.orgInbarocleCdList.length; j++){
	    		
	    		var item = this.orgInbarocleCdList[j];
	    		
	    		var mabComCd = "";
	    		
	    		
	    		
				if(comCd == item.addVal1){
					
 					$.each(mabCdArr, function(idx,mabObj){
						
						if(mabObj.ord == item.addVal2){
							
							mabComCd += mabObj.comCd;
							
						}
						
					}); 
 					
					if( rowCnt == 0){
						
						var sht = "";
						
						if(i == 0) sht = colorNameCode; 
						else{
							
							for(var idx = 0; idx < colorNameArr.length; idx++){
								
								if(colorNameCode == colorNameArr[idx]); 
								else {
									
									sht += colorNameArr[idx];
									
								}
								
							}
							
						}
						
					var htmlCode =  '<table class="rebTable" style="width:100%;"><colgroup><col style="width:25%;"><col style="width:45%;"><col style="width:15%;"><col style="width:15%;"></colgroup>';
						htmlCode += '<tr><td rowspan="'+rowValue+'" class="text-center">'+comCdName+'</td>';
						htmlCode += '<td class="text-center" style="background: '+sht+'">'+item.comCdName+'</td><td class="text-center">'+'<input class="repairInbarocle" name="'+item.comCd+'"type="checkbox" value="'+item.comCd+'" />'+'</td>';
						htmlCode += '<td class="text-center">'+'<input class="repairMab" name="'+mabComCd+'"type="checkbox" value="'+mabComCd+'" />'+'</td></tr>'; 
						
						colorNameCode = sht;
						
					}else if( rowCnt < rowValue ){
						
						var layr = "";
						for(var idx = 0; idx < colorNameArr.length; idx++){
							
							if(colorNameCode == colorNameArr[idx]); 
							else {
								
								layr += colorNameArr[idx];
								
							}
							
						}
						
						htmlCode += '<tr><td class="text-center" style="background: '+layr+'">'+item.comCdName+'</td>'+'<td class="text-center">'+'<input class="repairInbarocle" name="'+item.comCd+'"type="checkbox" value="'+item.comCd+'" />'+'</td>';
						htmlCode += '<td class="text-center">'+'<input class="repairMab" name="'+mabComCd+'"type="checkbox" value="'+mabComCd+'" />'+'</td></tr>';
						
						colorNameCode = layr;
					}
					
					if( rowCnt+1 == rowValue ){
						
						htmlCode += '</table>';
						
						var obj = new Object();
						
						obj['htmlCode'] = htmlCode;
						
						tableCodeList.push(obj);
						
					}
					
					rowCnt++;
					
				}
	    		
				
	    	}
				
		}
    	
    	for(var i =0; i < tableCodeList.length;i++){
    		
    		
    		var item =  tableCodeList[i];
    		
    		$('#repairBike .insp').append(item.htmlCode);
    		
    	}
    	
		//자전거 E
		
    	//단말기 S
    	
    	//정렬 S
    	
    	var sortRebTermList = []
    	for(var i = 0; i < rebCdListTerm.length; i++){
    		
    		var obj = this.arrSort(rebCdListTerm,(i+1));
    		
    		if(!obj);else{
    			
    			sortRebTermList.push(obj);
    			
    		}
    		
    	}
    	
    	//정렬 E
    	
    	for(var i =0; i < sortRebTermList.length; i++){
    		
    		var comCd = sortRebTermList[i].comCd;
    		var comCdName = sortRebTermList[i].comCdName;
    		
    		if(comCdName.indexOf("배터리 교체") >-1){
    			
    			$("#termReb .pb-3 .row").append('<div class="col-md-3 py-1 mx-0 px-0 input-ck02 text-left"><input class="repairInbarocle" type="checkbox" id="ci'+i+'" value="'+comCd+'" disabled=true /><label for="ci'+i+'">'+comCdName+'</label></div>');
    			
    		}else{
    		
    			$("#termReb .pb-3 .row").append('<div class="col-md-3 py-1 mx-0 px-0 input-ck02 text-left"><input class="repairInbarocle" type="checkbox" id="ci'+i+'" value="'+comCd+'"/><label for="ci'+i+'">'+comCdName+'</label></div>');
    		
    		}
       	 	for(var z = 0; z < this.orgParCdList.length; z++){//단말기 정비
       	 		
       	 		var item = this.orgParCdList[z];
       	 	
       	 		if(comCd == item.addVal1){
       	 			
       	 			if(item.addVal3 == "QR"){
       	 				
       	 				$("#radioQr").append('<div class="col-md-3 py-1 mx-0 px-0 input-ck02 text-left"><input class="repairMab" type="checkbox" id="cpq'+item.addVal2+'" name="'+item.comCd+'" value="'+item.comCd+'"/><label for="cpq'+item.addVal2+'">'+item.comCdName+'</label></div>');
       	 				
       	 			}else if(item.addVal3 == "LCD"){
       	 				
       	 				$("#radioLcd").append('<div class="col-md-3 py-1 mx-0 px-0 input-ck02 text-left"><input class="repairMab" type="checkbox" id="cpl'+item.addVal2+'" name="'+item.comCd+'" value="'+item.comCd+'"/><label for="cpl'+item.addVal2+'">'+item.comCdName+'</label></div>');
       	 				
       	 			}
       	 			
       	 		}
       	 		
       	 	}
    		
		}
    	
		//단말기 E
		
    	
    	//20200813 - 자전거 점검 공통코드 바꿈 E
		
   	 	
   	 	/*****************수리중 & 수리완료 인 경우 테이블에서 가져온 reb값을 화면에 checked 작업 S *******************/
   	 	
   	 	var repairCode = this.repairCodeList.replace(' ', '').replace('[', '').replace(']', '').split(',');
   	 	
   	 	if(repairCode != ""){
   	 		
	   	 	for(var i=0; i < repairCode.length; i++) {
	   	 		
	 			$("input[value='"+repairCode[i].replace(' ', '')+"']").prop('checked', true);
	 			
	   	 	}
	   	 	
   	 	}
   	 	/*****************수리중 & 수리완료 인 경우 테이블에서 가져온 reb값을 화면에 checked 작업 E *******************/
   	 	
   	 	
   	 	$('#repairTerm').hide();	//첫 화면은 자전거가 메인이기 때문에 단말기 예방점검은 hide
   	    $('#repTermAdTr').hide();	//단말기 - 단말기 수리자 hide
   	    $('#repTermCmpTr').hide();	//단말기 - 단말기 상태 hide
   	    $('#TermTr').hide();		//단말기 - 단말기 완료버튼 hide
   	    
   	 	
		
		/************ 수리중 & 수리완료 인 경우 테이블에서 경정비 부품 데이터 호출 S ************/
		
		if('${repairBikeInfo.partsData != null}' == 'true'){
			partsData = JSON.parse('${repairBikeInfo.partsData}');
			prevPartsData = JSON.parse('${repairBikeInfo.partsData}');
			lineCnt = partsData.length;
	    	repairBikeInfo.getPartsList(partsData);
		}
		
		/************ 수리중 & 수리완료 인 경우 테이블에서 경정비 부품 데이터 호출 E ************/
		
		/******************* 수리완료이면 입력 차단 S *******************/
		
 		if(this.repairCmptYn === 'Y' && this.editRepairYn !== 'Y'){
 			
			$("#repairBike").find('input').each(function(){
				
				$(this).attr("disabled",true);
				
			});
			
			$("#repairTerm").find('input').each(function(){
				
				$(this).attr("disabled",true);
				
			});
			
		}else if(this.repairTermCmptYn === 'Y'){
			
			$("#repairTerm").find('input').each(function(){
				
				$(this).attr("disabled",true);
				
			});
			
		}
		
		$("[name='radioQr']").attr("disabled",false);
		
		/******************* 수리완료이면 입력 차단 E *******************/
		
		/***************** 자전거 번호로 QR LCD 분기 S ******************/
		
		if($("[name='bikeNo']").val() != "" && $("[name='bikeNo']").val() != null && $("[name='bikeNo']").val().indexOf('-') > -1){
			
			var termType = $("[name='bikeNo']").val().split("-")[1];
			
			if(Number(termType) > 29999){
				
				$("[name='radioQr']:radio[value='QR']").prop('checked', true);
				
			}else{
				
				$("[name='radioQr']:radio[value='LCD']").prop('checked', true);
				
			}
			
		}
		
		/***************** 자전거 번호로 QR LCD 분기 E ******************/
		
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
				$("#TermTr").show();
				$("#repBikeAdTr").hide();
				$("#repBikeCmpTr").hide();
				repairBikeInfo.getCngTabCdList(tabLabel);
				repairBikeInfo.getCngRdCdList($("[name='radioQr']:checked").val());
				
			}else{
				
				$("#repBikeAdTr").show();
				$("#repBikeCmpTr").show();
				$("#repTermAdTr").hide();
				$("#repTermCmpTr").hide();
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
    			
    		}else{
    			
    			$(this).val("");
    			
    		}
    	
    	});
    	
    }
	
	/*********** 버튼 이벤트리스너 등록 E **********/
    
    /*********** 자전거번호 찾기 팝업에서 호출 할 함수 S **********/
    
 	function setBikeId(bikeId, bikeNo, batReplaceTime) {
    	$("[name='bikeId']").val(bikeId);
    	$("[name='bikeNo']").val(bikeNo);
    	
		if($("[name='bikeNo']").val() != "" && $("[name='bikeNo']").val() != null && $("[name='bikeNo']").val().indexOf('-') > -1){
			
			var termType = $("[name='bikeNo']").val().split("-")[1];
			
			if(Number(termType) > 29999){
				
				$("[name='radioQr']:radio[value='QR']").prop('checked', true);
				
			}else{
				
				$("[name='radioQr']:radio[value='LCD']").prop('checked', true);
				
			}
			
			repairBikeInfo.getCngRdCdList($("[name='radioQr']:checked").val());
			
		}
		
		if(batReplaceTime != '' && batReplaceTime != 'null' && batReplaceTime != null){
			
			$("#tdBatReplaceTime").text(batReplaceTime);
			
		}else{
			
			$("#tdBatReplaceTime").text("정보없음");
			
		}
    	
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
    			repairBikeInfo.repairTermCmptYn = params.termCmptYn;
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
	    		repairBikeInfo.checkTermCmpt = "Y";
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
    
	/*
	 * param1 : Array
	 * param2 : ord
	 * rturn : obj
	 */
	repairBikeInfo.arrSort = function(arr,ord){
		
		 var rObj;
		 
		 for(var i =0; i < arr.length; i++){
			 
			 if(arr[i].ord == ord){
				 
				 rObj = arr[i];
				 
			 }
			 
		 }
			
		 return rObj;
		 
	}
	
	/*
	 * param1 : adminId
	 */
	repairBikeInfo.checkAdmin = function(pAdminId){
		
		var params = {adminId : pAdminId};		 
		 
	    	$.ajax({
	    		
	    		type		: "post",
	    		url			: "/getCheckMntncAdminAjax.do",
	    		dataType	: "json",
	    		data		: params,
	    		success		: function( data ) {
	    			
	    			if(data.resultMessage !== "Success"){
	    				
	    				alert("근태등록을 하지않아 등록페이지로 이동합니다.");
	    				window.location.href = "/main.do";
	    				
	    			}
	    				
	    		},
	    		error : function(jqXHR, textStatus,errorThrown){
	    			if(jqXHR.status === 500 ){
	    				alert("에러가 발생했습니다.");
	    			}
	    		}
	    		
	    	});		 
		 
	}
    /*********** 공통코드 호출 함수 E *************/
    
	
	/*********** 변수 및 함수 E ************/
	</script>
</body>
</html>