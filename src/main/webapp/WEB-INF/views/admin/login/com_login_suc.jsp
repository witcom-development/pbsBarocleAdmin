<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.dkitec.barocle.admin.login.vo.UserSessionVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html>
<html lang="ko">
<head>

<!-- 
	개발일시 : 2020-06-01
	개발자   : 김시성
	내용	 : 정비직원 근태 입력 구현
	TODO : 근태입력 당일 마감시간
 -->
 
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" /> 
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />
<meta name="description=" Content="" />
<title><tiles:insertAttribute name="title"/></title>
<tiles:insertAttribute name="resource"/>
<script type="text/javascript" src="/js/common_barocle.js?ver=0403"></script>



<style>
	.myButton {
		box-shadow:inset 0px -3px 7px 0px #29bbff;
		background-color:#2dabf9;
		border-radius:5px;
		border:1px solid #0b0e07;
		display:inline-block;
		cursor:pointer;
		color:#ffffff;
		font-family:Arial;
		font-size:16px;
		padding:10px;
		text-decoration:none;
		text-shadow:0px 1px 0px #0688fa;
		width:50px;
		margin: 10px 10px 20px 10px;
	}
	.myButton:hover {
		background:linear-gradient(to bottom, #0688fa 5%, #2dabf9 100%);
		background-color:#0688fa;
	}
	.myButton:active {
		position:relative;
		top:1px;
	}
	.myButton span {
		margin-top: 10px;
	}
	.loginInfo{
		font-size: 13px;
	}
	
	
	#newQr .layer_bg{position:fixed; width:100%; height:100%; background: #fff; left:0; top:0}
	#newQr .layer_wrap{ position:absolute;  width:350px; height:400px; background:#fff; text-align: center; box-shadow: 10px 10px 5px #dce3de; padding: 3px;border: 2px dashed #bcbcbc;}
	
	
	#newQr table.type10 {
	  border-collapse: collapse;
	  text-align: left;
	  line-height: 1.5;
	  border-top: 1px solid #ccc;
	  border-bottom: 1px solid #ccc;
	  margin: 20px 10px;
	}
	#newQr table.type10 thead th {
	  width: 150px;
	  padding: 10px;
	  font-weight: bold;
	  vertical-align: top;
	  color: #fff;
	  background: cornflowerblue;
	  margin: 20px 10px;
	}
	#newQr table.type10 tbody th {
	  width: 150px;
	  padding: 10px;
	}
	#newQr table.type10 td {
	  width: 350px;
	  padding: 10px;
	  vertical-align: top;
	}
	#newQr table.type10 .even {
	  background: #fdf3f5;
	}
	
	#newQr .button {
	  background-color: #4CAF50; /* Green */
	  border: none;
	  color: white;
	  padding: 10px;
	  text-align: center;
	  text-decoration: none;
	  display: inline-block;
	  font-size: 14px;
	  margin: 2px 1px;
	  cursor: pointer;
	  border-radius: 6px;
	}
	
</style>

</head>
<body>




	<c:choose>
	<c:when test="${UserSessionVO.usrGrpName=='모니터링'}">
		<%@ include file="./fullNaverMap.jsp" %>
	</c:when>
	<c:otherwise>
			<div class="allwrap">
				<!--모바일 메뉴 S-->
				<tiles:insertAttribute name="header" />
				<!--모바일 메뉴 E-->
				<!--Head S-->
				<tiles:insertAttribute name="head" />
				<!--Head E-->
				<div id="body" class="logined">
				
				
				
					<div class="cont">
						<!--left menu S-->
						<tiles:insertAttribute name="left"  />
						<!--left menu E-->
						<!--conteent S-->
						<!-- 20210601 -->
						<div id="newQr" style="display: inline-block; margin: 0 auto; width: 87%; display: none">
							<div id="qr-reader" style="width:400px; display: hidden"></div>
							<div id="qr-reader-results"></div>
							<div class="layer_bg"></div>
							<div class="layer_wrap" style="visibility: none;z-index:999;" >
								<div  style="text-align: right; margin: 10px;">
									<a href="javascript:;" class="btn_close">닫기</a>
								</div>
								<div>
									<table class="type10">
									  <thead>
										  <tr>
											<th scope="cols" colspan="2" id="serialNo">12345 자전거</th>
										  </tr>
									  </thead>
										<tr>
											<td scope="row"   >최초 등록일자</td>
											<td   id="rep_regDttm">2018.01.01</td>
										</tr>
										<tr>
											<td scope="row" class="even">누적운행거리</td>
											<td class="even" id="rep_useTotDist">300km</td>
										</tr>
										<tr>
											<td scope="row"  >자전거상태</td>
											<td   id="rep_statusName">대여중</td>
										</tr>
							 
										<tr>
											<td scope="row" class="even">고장 신고내역</td>
											<td  id="rep_checkDesc" class="even" >2021-05-28</td>
										</tr>
										
										
										<tr>
											<td scope="row" >최종 수리일자</td>
											<td   id="rep_lastChkDttm">2021-05-28</td>
										</tr>
<!-- 										<tr>
											<td scope="row" class="even">최종 수리내역</td>
											<td  id="rep_repairDesc" class="even">2021-05-28</td>
										</tr>  -->
									</table>
									
									<form action="" method="post" id="sendRepairForm" target="_blank">
										<input type="hidden" name="viewFlg"	 id="form_viewFlg"/>
										<input type="hidden" name="bikeId"	  id="form_bikeId"/>
										<input type="hidden" name="repairSeq"   id="form_repairSeq"/>
										<input type="hidden" name="adminId"	 id="form_adminId" value="yang1004"/>
										<input type="hidden" name="searchBgnDe" id="form_searchBgnDe"/>
										<input type="hidden" name="searchEndDe" id="form_searchEndDe"/>
										<input type="hidden" name="division"	id="form_division" value="bikeNo"/>
										<input type="hidden" name="divisionValue" id="form_divisionValue"/>
										<input type="hidden" name="bikeStatusComCd" id="form_bikeStatusComCd"/>
										<input type="hidden" name="bikeStatusName" id="form_bikeStatusName"/>
									</form>
								 
									
									<button class="button" id="histBtn">정비 이력</button>
									<button class="button" id="updateRepair">최종 수리내역</button>
									<button class="button" id="insertRepair">수리등록</button>
									
								</div>	
							</div>
						</div>
						
						
						<!-- 20210601 E-->
						
						<div class="content" style="margin-top: 2em;">
							<!------------------------------------- solbit test S -------------------------------------->
							
							<div style="width:65%; margin:0 auto;visibility: hidden; display: none;" name="cleansvcDiv" id="cleansvcDiv">
							
								<div class="d-flex justify-content-center row">
									
									<button id="btnCleanStatus" class="s-btn s-btn-primary mx-1 mb-1">근태관리</button>
									<button id="btnCleanNotice" class="s-btn s-btn-primary mx-1 mb-1">준수사항</button>
									<button id="btnCleanList" class="s-btn s-btn-primary mx-1 mb-1">근태리스트</button>
											
								</div>
								
							</div>
							
							<div style="width:65%; margin:0 auto;visibility: hidden; display: none;" name="workDiv" id="workDiv">
								<div class="d-flex justify-content-center row">
									<!-- <button id="btnWrkSelect" class="s-btn s-btn-primary mx-1 mb-1">근태 조회</button> -->
									<!-- <button id="btnPerSelect" class="s-btn s-btn-primary mx-1 mb-1">실적 조회</button> -->
									<button id="btnCenSelect" class="s-btn s-btn-primary mx-1 mb-1">현황 조회</button>
									<button id="btnMgtSelect" class="s-btn s-btn-primary mx-1 mb-1">통계 조회</button>
									<!-- <button id="btnManageQR" class="s-btn s-btn-primary mx-1 mb-1">정비 관리</button> -->
									<!-- 20210514 분재직원용 -->
<%-- 									<c:if test='${UserSessionVO.usrGrpName eq "관리운영그룹"}'>	 --%>
<!-- 										<button onclick="goRepairScan()" class="s-btn s-btn-primary mx-1 mb-1" style="background-color: green;">정비QR촬영</button> -->
<!-- 										<button onclick="findBikeNo()" class="s-btn s-btn-primary mx-1 mb-1" style="background-color: green;">정비QR 테스트</button>  -->
<%-- 									</c:if> --%>
									<!-- 20210514 분재직원용 end -->
								</div>
								<!-- <hr class="s-hr"> -->
								<%-- 
								<c:set var="date" value="<%= new java.util.Date() %>" />
					   			<c:set var="nowDateFormat"><fmt:formatDate value="${date}" pattern="MM-dd" /></c:set>
					   			 --%>
<!-- 					   			<h2>근태입력</h2> -->
<%-- 								<div style="text-align: left; padding-left: 2%;">근무일 : ${nowDateFormat}</div> --%>
								<%-- 
								<table class="tb_type02">
									<colgroup>
										<col style="width:35%">
										<col style="width:65%">
										<col style="width:55%">
									</colgroup>
									<tbody>
										<tr>
											<th class="top">근무시간</th>
											<td class="top">
											<input class="otherTime" name="workTime" type="hidden">
											<div class="row">
												<div class="col-md-4 d-flex align-items-center py-1" style="max-width:120px;">
													<input type="radio" id="timeRd_8" name="timeRd" value="8"/> &nbsp; 8시간  &nbsp; 
													<input type="radio" id="timeRd_4" name="timeRd" value="4"/> &nbsp; 4시간  	
												</div>
												<div class="col-md-6 d-flex align-items-start">
												 
													<select id="timeSt" style="display : inline-block;">
														<option value="0">선택</option>
														<option value="1">1시간</option>
														<option value="2">2시간</option>
														<option value="3">3시간</option>
														<option value="4">4시간</option>
														<option value="5">5시간</option>
														<option value="6">6시간</option>
														<option value="7">7시간</option>
														<option value="8">8시간</option>
														<option value="9">9시간</option>
														<option value="10">10시간</option>
														<option value="11">11시간</option>
														<option value="12">12시간</option>
													</select>
												</div>
											</div>
											</td>
											
										</tr>
										<tr>
											<th>정비 외 시간</th>
											<td>
												<select name="dtlCd" style="display : inline-block;">
													<option value="">없음</option>
												</select>
												
												<input name="dtlTime" type="hidden"/>
												
												<select id="dtlTimeSt" style="display : inline-block;">
													<option value="0">선택</option>
													<option value="1">1</option>
													<option value="2">2</option>
													<option value="3">3</option>
													<option value="4">4</option>
													<option value="5">5</option>
													<option value="6">6</option>
													<option value="7">7</option>
													<option value="8">8</option>
												</select>
												<span>시간</span>
											</td>
										</tr>
										<tr id="etcTr" style="display: show;">
											<th>
												<span>기타 사유 입력 </span>
											</th>
											<td>
												<input name="etc" type="text" style="display : inline-block; width : 90%;"/>
											</td>
										</tr>
									</tbody>
									
									
								</table>
								 --%>
								<!-- <div class="my-2 text-left"> <button id="btnTest" class="s-btn s-btn-info s-btn-sm py-0 px-2">+</button>  <button id="btnTest2" class="s-btn s-btn-secondary s-btn-sm py-0 px-2"> - </button></div> -->
								
								<!-- 
								<div class="text-center my-2">
									<button id="btnWrkSubmit" class="s-btn s-btn-success">저장</button>
									<button id="btnWrkUpdate" class="s-btn s-btn-success" style="display: none;">수정</button>
								</div>
								 -->
								<%-- 
								<form id="workForm">
									<input type="hidden" name="adminId" value="${UserSessionVO.usrId}"/>
								</form>
								 --%>
										
								<hr class="s-hr my-3">
							</div>
							<hr>
							<!------------------------------------- solbit test E -------------------------------------->
							<div style="color:bisque; visibility: hidden; display: none;" name="favorite">
								<a href="/getStationCurrentStatus.do" class="myButton">정거장 현황</a>
								<a href="/getBikeList.do" class="myButton">자전거 조회</a>
								<!-- <a href="/inspectBikeList.do" class="myButton">장애관리</a> -->
								<!-- <a href="/repairBikeList.do" class="myButton">수리관리</a> -->
<!-- 								<a href="/getExeImpulseList.do" class="myButton">강제반납관리</a> -->
								<!-- <a href="/admin/manage/station/stationList.do" class="myButton">정거장개폐</a> -->
<!-- 								<a href="javascript:hold()" class="myButton">관리직<br/>게시판</a> -->
<!-- 								<a href="/admin/board/distribute/distBoardList.do" class="myButton">관리직<br/>게시판</a> -->
								<!-- 20210117 경정비실적조회 -->
<%-- 								<c:if test='${UserSessionVO.usrGrpName eq "분배반장"}'> --%>
<!-- 									<a href="/getLightRepairBike.do" 		  class="myButton">경정비<br/>조회</a> -->
<%-- 								</c:if> --%>
<%-- 								<c:if test='${UserSessionVO.usrGrpName eq "분배"}'> --%>
<!-- 									<a href="/getLightRepairBike.do" 		  class="myButton">경정비<br/>조회</a> -->
<%-- 								</c:if> --%>
<%-- 								<c:if test='${UserSessionVO.usrGrpName eq "관리운영그룹"}'> --%>
<!-- 									<a href="/getLightRepairBike.do" 		  class="myButton">경정비<br/>조회</a> -->
<%-- 								</c:if> --%>
<%-- 								<c:if test='${UserSessionVO.usrGrpName eq "관리팀"}'> --%>
<!-- 									<a href="/getLightRepairBike.do" 		  class="myButton">경정비<br/>조회</a> -->
<%-- 								</c:if> --%>
								<br/>
								<!--  QR 자전거 관리 -->
								<a href="javascript:goQrScan('move');" class="myButton">자전거 이동</a>
								<a href="javascript:goQrScan('check');" class="myButton">자전거 확인</a>
								<!-- <a href="javascript:goQrScan('relocate');" class="myButton">재배치 완료</a> -->
								<a href="javascript:goQrScan('reset');" class="myButton">단말기 리셋</a>
								<!--  QR 자전거 관리 -->
								<!-- 20210514 분재직원용 -->
								<%-- 
								<c:if test='${UserSessionVO.usrGrpName eq "분배반장"}'>
									<a href="/moveBunBae.do" class="myButton">분배Test</a>
								</c:if>
								<c:if test='${UserSessionVO.usrGrpName eq "분배"}'>
									<a href="/moveBunBae.do" class="myButton">분배Test</a>
								</c:if>
								
								<c:if test='${UserSessionVO.usrGrpName eq "관리팀"}'>
									<a href="/moveBunBae.do" class="myButton">분배Test</a>
								</c:if>
								
								<c:if test='${UserSessionVO.usrGrpName eq "관리운영그룹"}'>
									<a href="/moveBunBae.do" class="myButton">분배Test</a>
								</c:if>
								 --%>
								<!-- 순회정비 관련 -->
								<%-- 
								<c:if test='${UserSessionVO.usrGrpName eq "관리팀"}'>
									<a href="/moveRound.do" class="myButton">순회Test</a>
								</c:if>
								
								<c:if test='${UserSessionVO.usrGrpName eq "순회정비반장"}'>
									<a href="/moveRound.do" class="myButton">순회Test</a>
								</c:if>
								<c:if test='${UserSessionVO.usrGrpName eq "순회정비반"}'>
									<a href="/moveRound.do" class="myButton">순회Test</a>
								</c:if>
								
								<c:if test='${UserSessionVO.usrGrpName eq "관리운영그룹"}'>
									<a href="/moveRound.do" 		  class="myButton">순회Test</a>
								</c:if>
								<c:if test='${UserSessionVO.usrGrpName eq "관리팀"}'>
									<a href="/moveRound.do" 		  class="myButton">순회Test</a>
								</c:if>
								 --%>
								
								<%-- <c:if test='${UserSessionVO.usrGrpName eq "관리운영그룹"}'>	
									<a href="/moveBunBae.do" class="myButton">분배Test</a>
								</c:if>	
								<c:if test='${UserSessionVO.usrGrpName eq "분배반장"}'>
									<a href="/moveBunBae.do" class="myButton">분배Test</a>
								</c:if>
								<c:if test='${UserSessionVO.usrGrpName eq "관리팀"}'>
									<a href="/moveBunBae.do" class="myButton">분배Test</a>
								</c:if>
								
								<c:if test='${UserSessionVO.usrGrpName eq "운영팀"}'>
									<a href="/moveBunBae.do" class="myButton">분배Test</a>
								</c:if> --%>
								<!-- 20210514 분재직원용 end -->	
									
								<br/>
								<hr/>
							</div>			
							<div class="loginedBox displayChk" style="display: none;">	
							<form id="bikefrm">
								<div style="float: left;">운행중 자전거 :${wholeStatusTotCnt.rentStableTotCnt}대</div>
								<div style="float: right;">자전거 번호 : <input type="text" id="bikeNoSearch" name="searchWord" style="width:30%;"><button id="bikeSearchBtn" class="btn-srh03"><img src="/images/searchIcon.gif" alt="검색"></button></div><br/>
								
								<table class="tb_type01 mt20">
										<colgroup>
											<col style="width:35%">
											<col style="width:35%">
											<col style="width:39%">									
											<col style="width:39%">									
											<col style="width:39%">									
										</colgroup>
										<thead>
											<tr>
												<th>자전거번호</th>
												<th>정거장</th>
												<th>자전거상태</th>										
												<th>최종보고</th>										
												<th>배터리상태</th>										
											</tr>
										</thead>
										<!--  정거장 노출 -->
										<tbody>
											<tr>
												<td class="tc" id="rentBikeNo"></td>
												<td class="tc" id="stationName"></td>
												<td class="tc" id="rentBikeStat"></td>										
												<td class="tc" id="regDttm"></td>											  
												<td class="tc" id="bikeSeCd"></td>										
											</tr>
										</tbody>
									</table>
								
								<input type="hidden" name="rentBikeId" value="">
								<input type="hidden" name="rentBikeNo" value="">
								<input type="hidden" name="rentHistSeq" value="">
								<input type="hidden" name="rentSeq" value="">
								<input type="hidden" name="rentStatusCd" value="">
								<input type="hidden" name="rentBikeStat" value="">
								<input type="hidden" name="rentStationId" value="">
								<input type="hidden" name="stationName" value="">
								<input type="hidden" name="regDttm" value="">
								<input type="hidden" name="bikeSeCd" value="">
								<input type="hidden" name="lang" value="LAG_001">
								<input type="hidden" name="adminId" value="${UserSessionVO.usrId}">
							</form>
							
							<span id="cautionText" style="color: red; font-size: 12px; display:none;">주의) 대여중인 자전거는 강제반납만 가능합니다.</span><br/><br/>
							<div>
<!-- 							<button class="btnType01" id="bikeRobbedBtn">도난추정</button>&nbsp; -->
<!-- 							<button  class="btnType01 bc_green" id="bikeRetrievalBtn">회수</button> -->
							<!-- &nbsp;<button class="btnType01" type="button" id="bikeBatReplace">배터리 교체</button> -->
							<!-- 20210108 -->
<%-- 							<c:if test='${UserSessionVO.usrGrpName eq "분배반장"}'> --%>
<!-- 								<button class="btnType01 bc_green" type="button" id="lightRepair">경정비</button> -->
<%-- 							</c:if> --%>
<%-- 							<c:if test='${UserSessionVO.usrGrpName eq "분배"}'> --%>
<!-- 								<button class="btnType01 bc_green" type="button" id="lightRepair">경정비</button> -->
<%-- 							</c:if> --%>
<%-- 							<c:if test='${UserSessionVO.usrGrpName eq "관리운영그룹"}'> --%>
<!-- 								<button class="btnType01 bc_green" type="button" id="lightRepair">경정비</button> -->
<%-- 							</c:if> --%>
<%-- 							<c:if test='${UserSessionVO.usrGrpName eq "관리팀"}'> --%>
<!-- 								<button class="btnType01 bc_green" type="button" id="lightRepair">경정비</button> -->
<%-- 							</c:if> --%>
							</div> 
							
							</div>
							
							<div class="page">
								 <!--검색조건 S-->
								<form  id="searchFrm" name="searchFrm">
								<!--검색조건 E-->
								<div class="loginedBox" >
									<div class="user">
										<em class="img"><img src="/images/icon_login.png" alt="" /></em>
										<p>
											<span class="id" >${UserSessionVO.usrName}(${UserSessionVO.usrId})</span>님 로그인이 정상적으로 처리 되었습니다.<br><br>
											<span class="loginInfo info1"></span>&nbsp;&nbsp;<span class="loginInfo info2"></span>
										</p>
									</div>
									<div class="loginInfoBox">
									<p class="head tl">로그인정보</p>
									<table class="tb_type01 mt20">
										<colgroup>
											<col style="width:20%">
											<col style="width:20%">
										</colgroup>
										<thead>
											<tr>
												<th>접속 IP</th>
												<th>로그인일시</th>
											</tr>
										</thead>
										
										<tbody>
										<c:forEach var="result" items="${LoginHistoryList}" varStatus="status">
											<tr>
												<td class="tc">${result.usrIp}</td>
												<td class="tc">${result.loginDate}</td>
											</tr>
										</c:forEach>	
										<c:if test='${fn:length(LoginHistoryList) == 0}'>
											<tr>
												<td style="text-align:center" colspan="2"><spring:message code="search.nodata.msg" /></td>
											</tr>
										</c:if>
										</tbody>
									</table>
							<c:choose>
								<c:when test="${fn:length(LoginHistoryList) > 0}">
									<div class="drpaging">
								</c:when>
								<c:otherwise>
									<div class="drpaging" style="display:none;">
								</c:otherwise>
							</c:choose>
									<c:choose>
									<c:when test="${paginationInfo.currentPageNo > 1}">
										<a id="prevPage" href="#"><img src="/images/p_prev.gif" alt="이전 페이지" /></a>
									</c:when>
									<c:otherwise>
										<a href="#"><img src="/images/p_prev.gif" alt="이전 페이지" /></a>
									</c:otherwise>
									</c:choose>
									<span><input name="currentPageNo" type="number" value="${paginationInfo.currentPageNo}"/><em>/ ${paginationInfo.totalPageCount}</em><button id="movePage">이동</button></span>
									<c:choose>
									<c:when test="${paginationInfo.currentPageNo < paginationInfo.totalPageCount}">
									<a id="nextPage" href="#"><img src="/images/p_next.gif" alt="다음 페이지" /></a>
									</c:when>
									<c:otherwise>
										<a href="#"><img src="/images/p_next.gif" alt="다음 페이지" /></a>
									</c:otherwise>
									</c:choose>
								</div>
								</div>
								</form>
								<p class="head tl" style="display: none;"><a href="/common/pop/entrcReutnListPop.do" id="pop1" class="winNewPop"  title="강제반납 조회" data-width="700" data-height="455" data-pmt="&teamSeq=<c:out value='${UserSessionVO.teamSeq}'/>">강제반납 조회</a></p>
								</div>
								<%-- <table>
								<tr><td><a href="/common/pop/entrcReutnListPop.do" class="winNewPop"  title="강제반납 조회" data-width="700" data-height="455" data-pmt="&teamSeq=<c:out value='${UserSessionVO.teamSeq}'/>">강제반납 조회</a></td></tr>
								</table> --%>
							</div>
						</div>
						<!--conteent E-->
						<form id="linkForm">
							<input type="hidden" name="bikeNo" value="">
							<input type="hidden" name="bikeId" value="">
							<input type="hidden" name="lang" value="">
							<input type="hidden" name="viewFlg" value="">
							<input type="hidden" name="tabNum" value="">
							<input type="hidden" name="currentPageNo" value="">
						</form>
					</div>
				</div>
				<form id="QRfrm">
					<input type="hidden" id="deviceId" name="deviceId" value=""/>
					<input type="hidden" id="bikeId" name="bikeId" value=""/>
					<input type="hidden" id="stationId" name="stationId" value=""/>
					<input type="hidden" id="rackId" name="rackId" value=""/>
					<input type="hidden" id="deviceName" name="deviceName" value=""/>
					<input type="hidden" id="useTime" name="useTime" value=""/>
					<input type="hidden" id="beaconId" name="beaconId" value=""/>
					<!-- <input type="hidden" id="lat" name="lat" value=""/>
					<input type="hidden" id="log" name="log" value=""/> -->
				</form>
				<!--footer S-->
				<tiles:insertAttribute name="footer" />
				<!--footer E-->
			
			<script type="text/javascript">
			/*************************** solbit S  ***************************/
			
			$("#btnCleanStatus").click(function(){//방역단 - 근태관리 조회 버튼
				
				window.location.href = "/cleanStatus.do";
				
			});
			
			$("#btnCleanNotice").click(function(){//방역단 - 준수사항 조회 버튼
				
				window.location.href = "/cleanNotice.do";
				
			});
			
			$("#btnCleanList").click(function(){//방역단 - 근태리스트 조회 버튼
				
				window.location.href = "/cleanStatusList.do";
				
			});
			
// 			$("#btnWrkSelect").click(function(){//근태정보 조회 버튼
// 				$('#workForm').attr({method : "post", action : "<c:out value='/getRepairWork.do'/>"}).submit();
// 			});
			
// 			$("#btnPerSelect").click(function(){//실적정보 조회 버튼
// 				$('#workForm').attr({method : "post", action : "<c:out value='/getRepairPerf.do'/>"}).submit();
// 			});
			
			$("#btnCenSelect").click(function(){//현황정보 조회 버튼
				
				$('#workForm').attr({method : "post", action : "<c:out value='/getCenterStatus.do'/>"}).submit();
			
			});
			
			$("#btnMgtSelect").click(function(){//통계정보 조회 버튼
				
				$('#workForm').attr({method : "post", action : "<c:out value='/getMgmtStat.do'/>"}).submit();
			
			});
			
			$("#btnWrkUpdate").click(function(){//근태입력 수정버튼
				
				workList.wrkValidationCheck();
		
				if(workList.wrkValidationResult != false) workList.ajax("updateWork");
				else alert("변경사항이 없습니다.");
			
			})
			
			$("#btnWrkSubmit").click(function(){//근태입력 저장버튼
				
				workList.ajax("insertWork");
			
			});//근태입력 저장버튼 E
			
			/******* 변수 및 함수 S *******/
			
			var workList = {};
			
			workList.wrkValidationCheck = function(){
				
				this.wrkValidationResult = false;
				
			 	if(!this.orgWorkVO){
				}else{
					
					var workVO = this.orgWorkVO;
					if($("[name='workTime']").val() == workVO.workTime && $("[name='dtlCd']").val() == workVO.dtlCd ){
						
						if($("[name='dtlTime']").val() == "0" || !$("[name='dtlTime']")) $("[name='dtlTime']").val("0");
						
						if($("[name='dtlCd']") == 'WRK_001'){
							
							if(workVO.etc != $("[name='etc']").val() || workVO.dtlTime != $("[name='dtlTime']").val() ){
								this.wrkValidationResult = true;
							}
							
						}else{
						
							if(workVO.dtlTime != $("[name='dtlTime']").val() ){
								this.wrkValidationResult = true;
							}
							
						}
						
					}else{
						this.wrkValidationResult = true;
					}
					
				} 
			}
			
			workList.ajax = function(data){
				
				if(data == "mainWork"){//당일날 근태 입력 했다면 화면에 그 값을 보여줌.
					
					$.ajax({
						url: "getMainWorkAjax.do",
						type: "post",
						data : "adminId=${UserSessionVO.usrId}",
						success: function(data){
							var workVO = data.workVO;
							if(!workVO.workTime){
							}else{
								workList.orgWorkVO = data.workVO;
								$("[name='workTime']").val(workVO.workTime);
								
								$("[name='timeRd']").each(function(){
								
									if($(this).val() == workVO.workTime){
										
										$(this).prop("checked",true);
										
									}
									
								});
								
								$("#timeSt").val(workVO.workTime);
								$("[name='dtlCd']").val(workVO.dtlCd);
								$("[name='dtlTime']").val(workVO.dtlTime == '' ? 0 : workVO.dtlTime);
								$("#dtlTimeSt").val(workVO.dtlTime);
								
								$("[name='etc']").val(workVO.etc);
								
								/*
								if(workVO.dtlCd == 'WRK_001'){
									$("#etcTr").css("display","show");
									$("#etcTr").show();
									$("[name='etc']").val(workVO.etc);
								}else{
									$("#etcTr").css("display","none");
									$("#etcTr").hide();
								}
								*/
								
								$("#btnWrkUpdate").css("display","show");
								$("#btnWrkUpdate").show();
								$("#btnWrkSubmit").css("display","none");
								$("#btnWrkSubmit").hide();
							}	
						}, error : function(){
							alert("정비직원 근태조회 실패"); 
						}
					});
				
				}else if(data == "getCd"){//근태 입력 정비 외 사유 selectbox 데이터 불러오기.
					
					commonAjax.getCommonCode("WRK",function(data){
						
						for(var i = 0; i<data.codeList.length;i++){
							
							var code = data.codeList[i];
							var option = $("<option value='"+code.comCd+"'>"+code.comCdName+"</option>");			
							$("[name='dtlCd']").append(option); 
							
						}
						
					});
				
				}else if(data.indexOf("insertWork") > -1 || data.indexOf("updateWork") > -1){
					
					var url;
					if(data == "insertWork") url = "/insertRepairWorkAjax.do";
					if(data == "updateWork") url = "/updateRepairWorkAjax.do";
					
			  		var dr = true;
					var workTime = $("[name='workTime']").val() == '' ? 0 : $("[name='workTime']").val();
					var dtlCd = $("[name='dtlCd']").val();
					var dtlTime = $("[name='dtlTime']").val() == '' ? 0 : $("[name='dtlTime']").val();
					
					var regExp = /^[0-9]*$/; 							// 정규식으로 추가 근무 시간 숫자 체크 처리
					if(!regExp.test(dtlTime)) {
						
						alert("정비 외 시간에 숫자만 입력하세요.");
						dr = false;
						return true;
					}
					
					var etc = $("[name='etc']").val();
					
					if(workTime == '0' || workTime == '' || workTime == null || workTime.length == 0){ 
						
						$("[name='workTime']").focus();
						alert("근무시간을 입력하세요.");
						dr = false;
						return true;
						
					}
					
					if(Number(workTime)>8){		// 근무시간 8시간 초과 시 확인알림 창
						
						var result = confirm(workTime+"시간이 맞습니까?");
						if(result == false) {
							$("#timeSt").focus();
							return true;
						}
						
					}
					
					if(Number(dtlTime) > Number(workTime)){
						$("#dtlTimeSt").focus();
						alert("정비 외 시간이 근무시간을 초과하였습니다. \n"+workTime+"시간 보다 적게 입력하세요.");
						dr = false;
						return true;
					}
					
					if(dtlCd =='' && dtlTime != '0'){
						
						$("[name='dtlCd']").focus();
						alert("정비 외 업무를 선택하세요.");
						dr = false;
						return true;
						
					}else if(dtlCd == 'WRK_001' && etc == '' ){
						
						$("[name='etc']").focus();
						alert("기타 사유를 입력하세요.");
						dr = false;
						return true;
						
					}else if(dtlCd != '' && dtlTime == '0'){
						
						$("#dtlTimeSt").focus();
						alert("정비 외 시간을 입력하세요.");
						dr = false;
						return true;
						
					}
					
					if(dr){//문제없을 때만 저장 처리
						
						var params = {};
						params.adminId = '${UserSessionVO.usrId}';
						params.workTime = workTime;
						params.dtlCd = dtlCd;
						params.dtlTime = dtlTime;
						params.etc = etc;
						
						var succMsg;
						if(data.indexOf("insertWork") > -1) succMsg = "등록되었습니다."
						else if(data.indexOf("updateWork") > -1) succMsg = "수정되었습니다."	
						
						$.ajax({
							type : "post",
							url : url,
							data : params,
							success : function(data){
								alert(succMsg);
								if(succMsg == "등록되었습니다.") window.location.reload();
								else{
									this.orgWorkVO;
								}
							},
							error : function(data){
								alert("실패했습니다.");
							}
						});
					
					}else{//문제있으니 아무것도 안함.
						
						alert("입력사항을 확인하세요.");
					
					}
					
				}
				
			}
			
			/******* 변수 및 함수 E *******/
			
			/*************************** solbit E  ***************************/
			
			var loginHistory = {};
			loginHistory.pageSelect = function(cPage) {
				$("input:hidden[name='viewFlg']").val('list');
				$("[name='currentPageNo']").val(cPage);
				$("#searchFrm").attr({method : "post", action : "<c:out value='/main.do'/>"}).submit();
			};
			var popCount = 0;
			var popup;
			var top = 100;
			var left = 10;
		
			$(function(){
				
				// 2020-12-04 : 중복로그인 알림창 구현
				<%
						HttpSession hss = request.getSession();
						Object adminLoginOverlap = hss.getAttribute("adminLoginOverlap");
						
						if(adminLoginOverlap != null){
							
							boolean overlap = (Boolean) adminLoginOverlap;
							if(overlap){
				%>
								alert("중복 로그인으로 인해 \r이전 로그인 환경에서 로그아웃 되었습니다.");
				<%
								hss.removeAttribute("adminLoginOverlap");
							}
						}
				%>
				
				// 2019-10-17
				switch( "${UserSessionVO.usrGrpName}"){
					
					case "방역단근태" :
						
						$("#btnCleanNotice").css("display","none");
						$("#btnCleanList").css("display","none");
						$("[name='cleansvcDiv']").css("visibility","visible");
						$("[name='cleansvcDiv']").css("display","inline-block");
						$("[name='favorite']").css("display","none"); 
						$(".loginInfoBox").css("display","none");
						$(".displayChk").css("display","none");
						$(".info1").text("IP : ${LoginHistoryList[0].usrIp}");
						$(".info2").text("일시 : ${LoginHistoryList[0].loginDate}");
						
					break;
					
					case "바로클포" :
		
						$("#btnCleanNotice").css("display","none");
						$("#btnCleanList").css("display","none");
						$("[name='cleansvcDiv']").css("display","none");
						$("[name='favorite']").css("display","none"); 
						$(".loginInfoBox").css("display","none");
						$(".displayChk").css("display","none");
						$(".info1").text("IP : ${LoginHistoryList[0].usrIp}");
						$(".info2").text("일시 : ${LoginHistoryList[0].loginDate}");				
					
					break;	
						
					case "정비" :
						
						$("#btnCenSelect").css("display","none");
						$("#bikeBatReplace").css("display","none");
						
					case "정비반장" :
						
						$("#btnMgtSelect").css("display","none");
						$("#bikeBatReplace").css("display","none");
						
						workList.ajax("getCd");
						workList.ajax("mainWork");
						$("[name='workDiv']").css("visibility","visible"); 
						$("[name='workDiv']").css("display","inline-block");
					//	$("#etcTr").css("display","none");
					//	$("#etcTr").hide();
						
					case "분배반장":
					case "분배":
						
						$("[name='favorite']").css("visibility","visible"); 
						$("[name='favorite']").css("display","inline-block"); 
						$("[name='favorite']").css("width","100%"); 
						$(".loginInfoBox").css("display","none");
						$(".displayChk").css("display","");
						$("[name='favorite']").css("margin-top","2em");
						$(".info1").text("IP : ${LoginHistoryList[0].usrIp}");
						$(".info2").text("일시 : ${LoginHistoryList[0].loginDate}");
						
					break;
		
					case "관리운영그룹":		
					case "관리팀":
						
						workList.ajax("getCd");
						workList.ajax("mainWork");
						$("[name='workDiv']").css("visibility","visible"); 
						$("[name='workDiv']").css("display","inline-block");
					//	$("#etcTr").css("display","none");
					//	$("#etcTr").hide();
						
					default :
		
						$("[name='favorite']").css("visibility","visible"); 
						$("[name='favorite']").css("display","inline-block"); 
						$("[name='favorite']").css("width","100%"); 
						$("[name='favorite']").css("margin-top","2em");
						$(".loginInfoBox").css("display","none");
						$(".info1").text("IP : ${LoginHistoryList[0].usrIp}");
						$(".info2").text("일시 : ${LoginHistoryList[0].loginDate}");
						$(".displayChk").css("display","");
					break;
				}
				/********************** solbit S ************************/
				
				$("[name='dtlCd']").on("change",function(){//정비 외 사유 선택박스 -> 출장,기타....
					
					var item = $(this).val();
					/*
					if(item == 'WRK_001'){
						
						$("#etcTr").css("display","show"); 
						$("#etcTr").show();
						
					}else if(item == ""){
						
						$("[name='dtlTime']").val("");
						$("[name='etc']").val("");
						$("#etcTr").css("display","none");
						$("#etcTr").hide();
						
					}else{
						
						$("[name='etc']").val("");
						$("#etcTr").css("display","none");
						$("#etcTr").hide();
						
					}
					*/
				});
				
				$("#timeSt").on("change",function(){//근무시간 선택박스
					
					var item = $(this).val();
				
					if(item == "4" || item == "8"){
						
						$("#timeRd_"+item).prop("checked", true);
						
					}else $("[name='timeRd']").prop("checked", false);
					
					$("[name='workTime']").val(item);
					
				});
				
				$("#dtlTimeSt").on("change",function(){//정비 외 시간 선택박스
					
					var item = $(this).val();
					
					$("[name='dtlTime']").val(item);
					
				});
				
				$("[name='timeRd']").click(function(){//근무시간 라디오박스
					
					var item = $(this).val();
					$("[name='workTime']").val(item);
					$("#timeSt").val(item);
					
				});
				
				/********************** solbit E ************************/
				
				var totalPageCount = '${paginationInfo.totalPageCount}' == '' ? 1 : Number('${paginationInfo.totalPageCount}');
		   		$('#prevPage').on("click",function(){
					var currentPageNo = Number($('[name="currentPageNo"]').val());
					loginHistory.pageSelect(currentPageNo-1);
				});
				$('#nextPage').on("click",function(){
					var currentPageNo = Number($('[name="currentPageNo"]').val());
					loginHistory.pageSelect(currentPageNo+1);
				});
				$('#movePage').on("click",function(){
					var currentPageNo = Number($('[name="currentPageNo"]').val());
					var regExp = /^[1-9]?[0-9]/;
					if(!regExp.test(currentPageNo) ||(totalPageCount < currentPageNo)){
						alert('현재 페이지 값이 정상적이지 않습니다.');
					}else{
						loginHistory.pageSelect(currentPageNo);
					}
				});
				/*
				$.ajax({
					url : "/admin/customer/notice/noticePopupCount.do",
					type : "get",
					contentType: "charset=utf-8",
					success : function(data){
							if(data!=null){
								for(var i=0; i<data.popupCount.length; i++){
									var s = getCookie(data.popupCount[i].noticeSeq);
									if(s!='hide'){
										window.open("/admin/customer/notice/noticePopup.do?popSeq="+data.popupCount[i].noticeSeq, "noticePop"+data.popupCount[i].noticeSeq, "toolbar=no, location=no, directory=no, scrollbars=yes, resizable=yes, top="+ top +", left="+ left +", width=400, height=600");
										left += 415;
									}
								}
							}
					}, error : function(){ alert("데이터를 가져오는데 실패 하였습니다."); }
				});
				*/
				/* 관리직 게시판 팝업 임시 주석 20200211 
				$.ajax({
					url : "/admin/board/distribute/boardPopupCount.do",
					type : "get",
					contentType: "charset=utf-8",
					success : function(data){
							if(data!=null){
								for(var i=0; i<data.popupCount.length; i++){
									var s = getCookie(data.popupCount[i].distSeq);
									if(s!='hide'){
										window.open("/admin/board/distribute/boardPopup.do?popSeq="+data.popupCount[i].distSeq, "noticePop"+data.popupCount[i].distSeq, "toolbar=no, location=no, directory=no, scrollbars=yes, resizable=yes, top="+ top +", left="+ left +", width=400, height=600");
										left += 415;
									}
								}
							}
					}, error : function(){ alert("데이터를 가져오는데 실패 하였습니다."); }
				});
				 */
				//alert('${UserSessionVO.teamSeq}');
				var teamSeq = '${UserSessionVO.teamSeq}';
				if(teamSeq != null && teamSeq !="" ){
					//pop1.click(); 
				}
				
				
				// 2019-11-08 
				$("#bikeSearchBtn").on("click",bikeNoSearch);
				$("#bikeRobbedBtn").on("click",bikeRobbedExe);
				$("#bikeRetrievalBtn").on("click",bikeRtrvlExe);
				$("#bikeBatReplace").on("click",bikeBatReplace);
				$(document).on("click","#linkBikeDetail",function(e){
					if($("#rentBikeStat").text() == "대여중"){
						moveRentStatusInfo(e);
					} else {
						moveBikeEditForm(e);
					}
				});
				
				// 20210108
				$("#lightRepair").on("click",onSiteAction);
			});
			
			
			// 20200108 경정비 입력
			var bikeSearch = {};
			function onSiteAction(e) {
				e.preventDefault();
				
				bikeSearch.actType = "A";
				
				var bikeId = $("#bikefrm input[name=rentBikeId]").val();				  
				var bikeNo = $("#bikefrm input[name=rentBikeNo]").val();  
				
				$("[name='currentPageNo']").val("0");
				$("[name='bikeNo']").val(bikeNo);
				$("[name='bikeId']").val(bikeId);
				
				if(!bikeId || !bikeNo){
					alert("자전거 번호를 입력해주시기 바랍니다. !");
					return;
				} else if(bikeId != "" && bikeNo != ""){//자전거를 검색해서 이미 값을 가지고 있는 경우
					if ( !confirm( bikeNo + " 번호가 맞습니가? " )) return;
				}
					
				bikeSearch.repairTime = 0;
				bikeSearch.repairType = "onSiteAction";
				bikeSearch.repairYn = "N";
				
				$("[name='currentPageNo']").val(1);
				$("[name='viewFlg']").val('C');
					
				$("#linkForm").attr({method : 'post',target : 'newWindow', action : '/moveRepairBikeEditForm.do'});
				
				var src = '/moveRepairBikeEditForm.do?bikeId='+ bikeId + '&viewFlg=R&bikeNo=' + bikeNo ;
				
				if(popupRepair!= null) popupRepair.close();
				popupRepair = window.open( src ,'newWindow', 'width=500, height=700');
			};
			
			var popupRepair =null;
			
			
			// 20200108 경정비 입력 end
			
			function setCookie(num){
		 		var expDate = new Date();
		 		expDate = new Date(parseInt(expDate.getTime() / 86400000) * 86400000 + 54000000);
		 		if(expDate<new Date()){ expDate.setDate(expDate.getDate()-1); }
				var expires = "expires="+expDate.toUTCString();
				document.cookie = "SPBcookie" + num + "=hide; " + expires;
			}
			
			function getCookie(num){
				var cookieName = "SPBcookie" + num + "=";
				var ca = document.cookie.split(';');
				for(var i=0; i<ca.length; i++) {
					var c = ca[i];
					while (c.charAt(0)==' ') c = c.substring(1);
					if (c.indexOf(cookieName) >= 0) return c.substring(cookieName.length, c.length);
				}
				return "";
			}
		
			function goEmpImpluseList(e){
				//setTimeout(alert(1),1000);
				//setTimeout($("#searchFrm").attr({method : "post", action : "<c:out value='/getExeImpulseList.do'/>"}).submit(),1000);
				$("#searchFrm").attr({method : "post", action : "<c:out value='/getExeImpulseList.do'/>"}).submit();
			}
			function bikeNoSearch(e){
				e.preventDefault();
				commonAjax.postAjax("/bikeNoSearch.do", "json", $("#bikefrm").serialize()
					,function(data){
					   if(data) {
						  var result= data.result;
						  $("input[name=rentBikeId]").val(result.rentBikeId);				  
						  $("input[name=rentBikeNo]").val(result.rentBikeNo);				  
						  $("input[name=rentHistSeq]").val(result.rentHistSeq);				  
						  $("input[name=rentSeq]").val(result.rentHistSeq);				  
						  $("input[name=rentStatusCd]").val(result.rentStatusCd);				  
						  $("input[name=rentBikeStat]").val(result.rentBikeStat);				  
						  $("input[name=rentStationId]").val(result.rentStationId);				  
						  $("input[name=stationName]").val(result.stationName);  
						  
						  $("input[name=regDttm]").val(result.regDttm);			// 최종 보고시간
						  $("input[name=bikeSeCd]").val(result.bikeSeCd);		// 배터리상태
						  
						  //$("#rentBikeNo").text(result.rentBikeNo);
						  $("#rentBikeNo").html('<a href="#" id="linkBikeDetail" target="_blank">'+result.rentBikeNo);
			 			 
						  if(result.rentBikeStat == "정상(대기중)"){
		  		 			  $("#rentBikeStat").text("정상 대기중");
						  } else {
							  $("#rentBikeStat").text(result.rentBikeStat);
						  }
						  
						  if(result.stationName == "null" || result.stationName == "" || result.stationName == null){
							  $("#stationName").text("대여정보 없음");
						  } else {
							  $("#stationName").text(result.stationName);
						  }
						  						  
						  if(result.regDttm == "null" || result.regDttm == "" || result.regDttm == null){
							  $("#regDttm").text("");
						  } else {
							  $("#regDttm").text(result.regDttm);
						  }
						  
						  if(result.bikeSeCd == "null" || result.bikeSeCd == "" || result.bikeSeCd == null){
							  $("#bikeSeCd").text("");
						  } else {
							  $("#bikeSeCd").text(result.bikeSeCd);
						  }
						  
						  if(result.rentBikeStat == "대여중"){
		  		 			  $("#cautionText").css("display","");
						  } else {
							  $("#cautionText").css("display","none");
						  }
						  
						  
						  
					   }
					}
				);
			}
			var isRun = false;
			var lastTermReplaceNo = '';
			
			function bikeBatReplace(e){
				
				var bikeNo = $("input[name=rentBikeNo]").val();
				
				if(lastTermReplaceNo == bikeNo) return false;
				
				if(bikeNo == null || bikeNo == ''){
					alert("자전거 조회 후 시도해주세요.");
					return false;
				}
				if($("#rentBikeStat").text() == "대여중"){
					alert("대여중인 자전거는 강제반납만 가능합니다.");
					return false;
				}
				if($("#rentBikeStat").text() == "대여중"){
					alert("대여중인 자전거는 강제반납만 가능합니다.");
					return false;
				}
				if($("#rentBikeStat").text() == "분실"){
					alert("분실 등록된 자전거 입니다.");
					return false;
				}
				
				var ans = confirm("자전거No ["+bikeNo+"]를 배터리 교체 등록 하시겠습니까?");
				if(ans){
					
					var pCenterId = "";
					
					$.ajax({
						
						url  : "/getAdminCenterIdAjax.do"
					   ,type : "post"
					   ,async: false
					   ,data : "adminId="+$("[name='adminId']").val()
					   ,success : function(data){
						   pCenterId = data.centerId;
					   }
					   ,error : function(data){
						   alert("통신실패");
					   }
					   
					});			
					
					var bikeParams = {
							
								adminId : $("[name='adminId']").val()
							  ,centerId : pCenterId
								,bikeId : $("[name='rentBikeId']").val()
								,bikeNo : $("[name='rentBikeNo']").val()
							  ,faultSeq : "" 
							,repairCode : "REB_057"
						  ,repairCmptYn : "Y"
							 ,bfBatStat : $("[name='bikeSeCd']").val()
					};
					
				  	$.ajax({
						type		: "post",
						url			: "/insertRepairBikeAjax.do",
						dataType	: "json",
						data		: bikeParams,
						async		: false,//중복요청 방지_2017.06.09_JHN
						success		: function( data ) {
							
							if(data.checkOverLap != null && data.checkOverLap == "Fail"){
								
								alert("해당자전거는 이미 당일 수리완료 처리 되어있습니다.");
								
							}else{
							
								if(data.resultMessage == 'Success'){
									
									alert("등록 되었습니다.");
									lastTermReplaceNo = bikeParams.bikeNo;
									
								}else{
									
									alert("오류가 발생하였습니다.");
									
								}
								
							}
						},
						error	   : function(jqXHR, textStatus,errorThrown) {
							
							if(jqXHR.status === 500) alert("에러가 발생했습니다.");
							
						}
						
					});
						
				}
			};
			
			function bikeRobbedExe(e){
				e.preventDefault();
				if(isRun == true) return false;
				
				var bikeNo = $("input[name=rentBikeNo]").val();
				if(bikeNo == null || bikeNo == ''){
					alert("자전거 조회 후 시도해주세요.");
					return false;
				}
				if($("#rentBikeStat").text() == "대여중"){
					alert("대여중인 자전거는 강제반납만 가능합니다.");
					return false;
				}
				if($("#rentBikeStat").text() == "대여중"){
					alert("대여중인 자전거는 강제반납만 가능합니다.");
					return false;
				}
				if($("#rentBikeStat").text() == "분실"){
					alert("분실 등록된 자전거 입니다.");
					return false;
				}
				
				var ans = confirm("자전거No ["+bikeNo+"]를 도난추정으로 등록 하시겠습니까?");
				if(ans){
						isRun = true;	
						commonAjax.postAjax("/common/pop/exeBikeRobbed.do", "json", $("#bikefrm").serialize()
						,function(data){
						   if(data.checkResult > 0) {
							   isRun = false;
							   alert(data.resultMessage);
							   $("#bikeSearchBtn").trigger("click");
						   }
						}
					);
				}
			};
			
			function bikeRtrvlExe(e){
				e.preventDefault();
				if(isRun == true) return false;
				  
				var bikeNo = $("input[name=rentBikeNo]").val();
				if(bikeNo == null || bikeNo == ''){
					alert("자전거 조회 후 시도해주세요.");
					return false;
				}
				
				if($("#rentBikeStat").text() == "대여중"){
					alert("대여중인 자전거는 강제반납만 가능합니다.");
					return false;
				}
				if($("#rentBikeStat").text() == "회수"){
					alert("회수 등록된 자전거 입니다.");
					return false;
				}
				
				var ans = confirm("자전거No ["+bikeNo+"]를 회수 등록 하시겠습니까?");
				   	 
				if(ans){
			   			isRun = true;
			   		 	commonAjax.postAjax("/common/pop/exeBikeRtrvl.do", "json", $("#bikefrm").serialize()
						,function(data){
						   if(data.checkResult > 0) {
							   isRun = false;
							   
							   if ( data.resultMessage == "회수 등록에 성공했습니다." ){
								  if ( confirm("수리 입고를 등록하시겠습니까?") ) {
									  
									  // var locateInfo = "/moveRepairBikeEditForm.do?viewFlg=C&bikeId=" + $("input[name=rentBikeId]").val() + "&bikeNo=" + $("input[name=rentBikeNo]").val();  
									  // window.open(locateInfo, "네이버새창", "width=800, height=700, toolbar=no, menubar=no, scrollbars=no, resizable=yes" ); 
									  var locateInfo = "/moveRepairBikeEditForm.do?viewFlg=C&bikeId=" + $("input[name=rentBikeId]").val() + "&bikeNo=" + $("input[name=rentBikeNo]").val();  
									  window.location.href= locateInfo ;
									  
								  } else {
									  alert( data.resultMessage );
								  }
		
							   } else {
								
								   alert(data.resultMessage);
								   
							   }
							   
							   $("#bikeSearchBtn").trigger("click");
						   }
						}
					);
				}
			};
			
			
			function moveBikeEditForm(e) {
				e.preventDefault();
				$("[name='bikeNo']").val($("[name='rentBikeNo']").val());
				$("[name='bikeId']").val($("[name='rentBikeId']").val());
				$("[name='currentPageNo']").val(1);
				$("[name='viewFlg']").val('U');
				$("[name='lang']").val('LAG_001');
				$("[name='tabNum']").val(2);
				$("#linkForm").attr({method : 'post',target : '_blank', action : '/moveBikeEditForm.do'}).submit();
			};
			
			function moveRentStatusInfo(e){
				  e.preventDefault();
				  $("#bikefrm").attr({method : 'post', target : '_blank', action : '/moveRentStatusInfo.do'}).submit();
			}
			function osInfo(pOSobj){
				var obj = JSON.parse(pOSobj);
				window.osType = obj.osInfo;
			};
			
			
			function goQrScan(scanType) {
				var adminSeq = 1;
				
				if (adminSeq != null && adminSeq > 0 ) {
					window.osType = 'android';
					// test
					var loginId = '${UserSessionVO.usrId}';
					
					if (loginId.indexOf('barocletest') === 0) {
						app.isTest = true;
					}
					
					var usrSeq = '${UserSessionVO.adminSeq}';
					
					if (usrSeq != null && usrSeq != '' && usrSeq > 0) {
						var tempSeq = '';
						for (var i = usrSeq.length; i < 10; i++) {
							tempSeq += '0';
						}
						usrSeq = tempSeq + usrSeq;	
					} else {
						usrSeq = '0000000000';
					
					}
					
					var jsonTestData = {"userseq" : usrSeq, "isuser" : false, "call" : "setUser"};
					var loginTestInfo = JSON.stringify(jsonTestData);
					window.android_admin.setUser(loginTestInfo);
				
				} else {
					
					alert(" 로그인이 안되어 있습니다. 앱 종료 후, 재 접속 부탁드립니다. ");
					
					return false;
					/*
					var jsonTestData = {"userseq" : "0000000000", "isuser" : false, "call" : "setUser"};
					var loginTestInfo = JSON.stringify(jsonTestData);
					window.android_admin.setUser(loginTestInfo);
					*/
				}
				
				//if(window.osType !== 'web') {
					//QR코드 대여,안드로이드 경우
					//app.deviceType = window.osType;
					app.deviceType = 'android';
					app.scanType = scanType;
					app.QRscanStart();
				//}
			}
			</script>
	</c:otherwise>
	</c:choose>

</body>

<script src="/js/html5-qrcode.min.js"></script>
<script>
	function layer_position(){
	   /*  var win_W = $(window).width();
		var win_H = $(window).height();
		*/
		//$(".layer_wrap").css({ 'transform': 'translate(-50%, -50%)'; 'top':'-50%'; 'left':'-50%';});  // 'left':(win_W-600)/2, */
		
	};
	
	//레이어팝업 open 상태 function 만들기
	function layer_open(){
	  $(".layer_wrap").fadeIn();
	  $(".layer_bg").fadeIn();
	  layer_position();
	  //레이어 영역 외 바탕화면 클릭시 화면 닫기
	  $(".layer_bg").click(function (e) {
		if(!$(".layer_wrap").has(e.target).length){
		  layer_close();
		};
	  });
	};
	
	//레이어팝업 close 상태 function 만들기
	function layer_close(){
		$(".layer_wrap, .layer_bg").fadeOut();
	};		

	$(function () {
		
		$("#newQr").show();
		
		// 레이어 display none 상태
		$(".layer_bg, .layer_wrap").hide();
		//닫기 버튼 클릭시 레이어 닫기
		$(".btn_close").click(function () {
			layer_close();
		});
		//반응형 대응 - 레이어 위치 잡기
		$(window).resize(function () {
			layer_position();
		});
		  
		
		function prevMonth(month) {
			var d = new Date();
			var monthOfYear = d.getMonth();
			d.setMonth(monthOfYear - month);
			return getDateStr(d);
		}
		function getDateStr(myDate){
			var year = myDate.getFullYear();
			var month = ("0"+(myDate.getMonth()+1)).slice(-2);
			var day = ("0"+myDate.getDate()).slice(-2);
			return ( year + '-' + month + '-' + day );
		}		
		
		// 정비이력  
		$('#histBtn').click(function(){
				$("#form_viewFlg").val("list");
				
				$("#form_searchBgnDe").val(prevMonth(3));
				$("#form_searchEndDe").val(prevMonth(0));
				
				$("form#sendRepairForm").attr("action", "/repairBikeMgmtList.do");
				$('form#sendRepairForm').submit();
			}
		)
		
		var repairSeq = $("#form_repairSeq").val();
		
		// 수리등록
		$('#insertRepair').click(function(){
				$("#form_viewFlg").val("P");
			//	$("#form_repairSeq").val("");
				
				$("form#sendRepairForm").attr("action", "/moveRepairBikeEditMgmtForm.do");
				$('form#sendRepairForm').submit();				
			}
		)		  
	
		// 수리완료
		$('#updateRepair').click(function(){
				$("#form_viewFlg").val("U");
				if ( $("#form_repairSeq").val() == "" ) {
					$("#form_repairSeq").val(repairSeq);
				}	
				$("form#sendRepairForm").attr("action", "/moveRepairBikeEditMgmtForm.do");
				$('form#sendRepairForm').submit();  
			}
		)		
	})
 
 	function goRepairScan(){
		
		var broswerInfo = navigator.userAgent;
		// 안드로이드 앱일 경우
		if(broswerInfo.indexOf("Android") >-1 ){
			try{goQrScan('repairCheck');}
			catch(e){
				webQR();
			}
				
		} else {
			webQR();	
		}
	}
	
	function webQR(){
		Html5Qrcode.getCameras( { facingMode: { exact: "environment"} } ).then(devices => {
			
			var deviceId = "";	
			if (devices && devices.length) {
				
				for ( var i=0; i < devices.length; i++ ) {
					var cameraId = devices[i].id;
					var label	= devices[i].label;
					// .. use this to start scanning.
					if ( label.indexOf( "facing back") >= 0 ) {
						deviceId = cameraId;
					} else if ( label.indexOf( "후면") >= 0 ) {
						deviceId = cameraId;
					}
				}	
				if ( deviceId == "" ) {
					deviceId = devices[0].id;
				}
				
				$('#qr-reader').show();  
				const html5QrCode = new Html5Qrcode("qr-reader");
				
				html5QrCode.start(
						deviceId,	 // retreived in the previous step.
				{
					fps: 10,	// sets the framerate to 10 frame per second
					qrbox: 250  // sets only 250 X 250 region of viewfinder to
								// scannable, rest shaded.
				},
				qrCodeMessage => {
					$('#qr-reader').hide();  
					
					// qrCode stop
					html5QrCode.stop().then(ignore => {
						  
						// 자전거 상태 조회
						findBikeNo( decode64( qrCodeMessage ) );	
						  
						}).catch(err => {
						  // Stop failed, handle it.
						   alert( err )
					});
					
				},
				errorMessage => {
					// parse error, ideally ignore it. For example:
					// alert(`QR Code no longer in front of camera.`);
				})
				.catch(err => {
				// Start failed, handle it. For example,
				alert(`Unable to start scanning, error: ${err}`);
				});
				
			}
		}).catch(err => {
		// handle err
			alert( err );
		});  
	
	}
	
 		
 	function findBikeNo( qrCodeMessage ){
		// TODO
		commonAjax.postAjax('/bike/getQRBikeInfoPhone.do', "json", {rackId: qrCodeMessage } ,function(data){
		/* commonAjax.postAjax('/bike/getQRBikeInfoPhone.do', "json", {rackId: "BRC-34075" } ,function(data){ */
				if(data.result){
					switch( data.bikeVO.bikeStatusCd ) {
					
					case "BKS_010" :
						alert("대여중인 자전거입니다.");
						break;
					default :
						$("#serialNo").html(data.bikeVO.bikeNo + " 자전거 내역");
						$("#rep_regDttm").html(data.bikeVO.regDttm);
						$("#rep_useTotDist").html(data.bikeVO.totMoveDist);
						$("#rep_statusName").html(data.bikeVO.bikeStatusName);
						$("#rep_lastChkDttm").html(data.bikeVO.LastChkDttm);
						// $("#rep_repairDesc").html(data.bikeVO.repairDesc);
						$("#rep_checkDesc").html(data.bikeVO.checkDesc);
						
						// 페이지 이동용
						$("#form_bikeId").val(data.bikeVO.bikeId);
						$("#form_divisionValue").val(data.bikeVO.bikeNo);
						$("#form_repairSeq").val(data.bikeVO.repairSeq);
						$("#form_bikeStatusComCd").val(data.bikeVO.bikeStatusCd);
						$("#form_bikeStatusName").val(data.bikeVO.bikeStatusName);
						
						layer_open();
					} 
				}	
			});
	}
		
 	function lockerResponse(info){
		var jInfo = JSON.parse(info);
		if(typeof jInfo !== 'undefined'){
			var command = jInfo.command;
			if (command == 'LOCK_OPEN') {
				// 락 오픈
				if (app.isTest) {
					alert('lock 상태 : '+jInfo.result.lockStatus);
				}
				
				if (app.unLockType == '') {
					if (jInfo.result.lockStatus == 'OPEN') {
						
						// QR 단말기
						if( $("#QRfrm #bikeId").val() =="" ) {
							alert("관리 이동처리에 실패하였습니다. \r\n 자전거번호 확인 및 앱 종료 후, 다시 로그인하여, 재배치를 부탁드립니다.");
							return;
						}
						
						// 대여 실행
						// QR 단말기
						commonAjax.postAjax('/bike/exeQRBikeMove.do', "json", $("#QRfrm").serialize() ,function(data){
							if(data.result) {
								app.hideLoading();
								alert('관리 이동 처리 되었습니다.');
								return;
							} else {
								app.hideLoading();
								alert('관리 이동 실패\n\n다시 시도해 주세요.');
								return;
							}
						});
					} else {
						app.hideLoading();
						alert('관리 이동 실패\n\n다시 시도해 주세요.');
						return;
					}
				} else {
					app.hideLoading();
					alert('임시 잠금 해제');
					return;
				}
			} else if (command == 'LOCK_RETURN_STATUS') {
				// 재배치 완료 처리
				var beaconId = jInfo.result.beaconId;
				
				if (beaconId !== '') {
					// QR 단말기
					commonAjax.postAjax('/bike/exeQRBikeRelocate.do', "json", {beaconId:beaconId} ,function(data){
						if(data.result) {
							app.hideLoading();
							alert('재배치 완료 처리 성공.');
							return;
						} else {
							app.hideLoading();
							alert('재배치 완료 처리가 불가능한 장소 입니다.');
							return;
						}
					});
				} else {
					app.hideLoading();
					alert('비콘 인식 실패.\\다시 시도해 주십시오.');
					return;
				}
				
			} else if (command == 'LOCK_STATUS') {
				
				if (app.isTest) {
					alert('lock 상태 : '+jInfo.result.lockStatus);
				}
				alert('lock 상태 : '+jInfo.result.lockStatus + '\n\n자전거 상태 : '+jInfo.result.bikeStatus);
				app.hideLoading();
				return;
			}
			
		}
	}

	
</script>

</html>



