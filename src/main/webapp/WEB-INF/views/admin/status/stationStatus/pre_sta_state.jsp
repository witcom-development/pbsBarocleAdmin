<%@page import="java.util.Iterator"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" /> 
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
	<meta name="description=" Content="" />
	<title><tiles:insertAttribute name="title"/></title>
	<tiles:insertAttribute name="resource"/>
</head>
<body>
	<c:choose>
	<c:when test="${userSessionVO.usrId == 'monitor'}">
		<%@ include file="./fullNaverMap.jsp" %>
	</c:when>
	<c:otherwise>
		<div class="allwrap">
			<!--모바일 메뉴 S-->
			<tiles:insertAttribute name="header"/>
			<!--모바일 메뉴 E-->
			<!--Head S-->
			<tiles:insertAttribute name="head"/>
			<!--Head E-->
			<div id="body">
				<div class="cont">
					<!--left menu S-->
					<tiles:insertAttribute name="left"/>
					<!--left menu E-->
					<!--conteent S-->
					<div id="content" class="content">
						<div class="subject">
							<!--subject path S-->
							<tiles:insertAttribute name="subject" />
							<!--subject path E-->
						</div>
						<div class="page">
							<!-- 모바일 검색조건 S-->
							<div class="shBox_m">
								<div class="downtitle">
									<div class="title">
										<p>검색조건</p><span><button><img src="/images/srh_open.png" alt="검색조건 열기" /></button></span>
									</div>
								</div>
							</div>
							<!-- 모바일 검색조건 E-->
							<!--검색조건 S-->
							
							<div class="staBox mapguide mhid">
								<p>거치율(%) 기존</p>
								<span><em><img src="/images/icon_b1_76.png" alt="76이상" /></em>76이상</span>
								<span><em><img src="/images/icon_b1_26.png" alt="26~75" /></em>26~75</span>
								<span><em><img src="/images/icon_b1_1.png" alt="1~25" /></em>1~25</span>
								<span><em><img src="/images/icon_b1_0.png" alt="0" /></em>0</span>
								<p> 신규</p>
								<span><em><img src="/images/icon_b2_76.png" alt="76이상" /></em>76이상</span>
								<span><em><img src="/images/icon_b2_26.png" alt="26~75" /></em>26~75</span>
								<span><em><img src="/images/icon_b2_1.png" alt="1~25" /></em>1~25</span>
								<span><em><img src="/images/icon_b2_0.png" alt="0" /></em>0</span>
							</div>
							<form id="searchFrm" >
								<div class="shBox">
									<input type="hidden" name="stationOrderType" value="${condition.stationOrderType}">
									<input type="hidden" name="sharedOrderType" value="${condition.sharedOrderType}">
									<input type="hidden" name="orderColumn" value="${condition.orderColumn}">
									<input type="hidden" name="viewType" value="${condition.viewType}">
									<input type="hidden" name="stationId" id="stationId"   value="${condition.stationId }">
									<input type="hidden" name="stationGrpId" id="stationGrpId" value="${condition.stationGrpId}">
									<input type="hidden" name="stationGrpSeq" id="stationGrpSeq" value="${condition.stationGrpSeq }">
									<input type="hidden" name="defaultLevel" value="${condition.defaultLevel }">
									<input type="hidden" name="defaultTeamYn" value="${condition.defaultTeamYn}">
									<input type="hidden" name="paramSearchWord" id="paramSearchWord" value="${condition.paramSearchWord}">
									<input type="hidden" name="paramSearchType" id="paramSearchType" value="${condition.paramSearchType}">
									<fieldset>
										<legend>검색 옵션</legend>
										<div class="shBoxSection">
											<div class="section">
												<label for="bb22" class="laType03">아파트</label>
											<c:choose>
												<c:when test="${userSessionVO.usrGrpCd ne '13'}">
													<c:if test="${condition.stationGrpId eq userSessionVO.assignStationGrpId}">
														<select class="select-category02" id="bb22" style="width: 210px;">
															<!-- <option value="">선택</option> -->
														</select>
													</c:if>
												</c:when>
												<c:otherwise>
													<select class="select-category02" id="bb22" style="width: 210px;">
														<option value="">선택</option>
													</select>
												</c:otherwise>
											</c:choose>
											</div>
											<div class="section pright etccase3">
												<label for="aa21" class="laType03">대여소명</label>
												<select class="select-category02" id="aa21">
													<option value="">선택</option>
												</select>
												<button type="button" name="searchBtn" id="searchBtn" class="btn-srh03 btncase1" ><img src="/images/searchIcon.gif" alt="검색"/></button>
											</div>
											<div class="section">
												<label for="searchStationName" class="laType03">대여소명</label>
												<!-- <select  id="searchType"  name="searchType">
													<option value="">선택</option>
													<option value="NUM">대여소번호</option>
													<option value="NAME">대여소명</option>
												</select> -->
												<span class="input-text12"><input type="text" class="" id="searchWord" value="${condition.paramSearchWord}"/></span>
												<!-- <button type="button" name="reSet" id="reSetBtn" class="btn-srh03 btncase1" style="color:white"></button> -->
											</div>
											<!-- <div class="section pright etccase3">
												
												<label for="batteryStusCd" class="laType03">센터/팀</label>
												<select id="batteryStusCd" name="batteryStusCd" style="width:80px">
													<option value="">선택</option>
												</select>&nbsp;
												<select id="searchType" name="searchType" required="true"  style="width:auto">
													<option value="">선택</option>
												</select>
												
												<label for="stationSeCd" class="laType03">대여소 구분</label>
												<select class="select-category02" id="a12" name="stationSeCd">
													<option value="">선택</option>
													<option value="RAK_001">(LCD+QR 반납가능)</option>
													<option value="RAK_002">신규(QR)</option>
													<option value="RAK_003">새싹거치대여소</option>
												</select>
												
											</div> -->
										</div>
									</fieldset>
								</div>
							<!--검색조건 E-->
							
							<!-- <div id="filterDiv" class="staBox mapguide">
								<div id="filterImage">
									<div style="display: inline-block; width:14%;"><span class="filterLstBike" style="cursor:pointer;"><em><img src="/images/icon_bike_b4.png" alt="분실" style="width: auto;height: auto;max-width: 100%;"/></em></span></div>
									<div style="display: inline-block; width:14%;"><span class="filterRtnBike" style="cursor:pointer;"><em><img src="/images/icon_bike_b3.png" alt="강반" style="width: auto;height: auto;max-width: 100%;"/></em></span></div>
									<div style="display: inline-block; width:14%;"><span class="filterExcess" style="cursor:pointer;"><em><img src="/images/staStop_ss150p.png" alt="거치초과" style="width: auto;height: auto;max-width: 85%;"/></em></span></div>
									<div style="display: inline-block; width:14%;"><span class="filterErr" style="cursor:pointer;"><em><img src="/images/mapIcon/E/icon_b3_4.png" alt="고장" style="width: auto;height: auto;max-width: 100%;"/></em></span></div>
									<div style="display: inline-block; width:14%;"><span class="filterTeamp" style="cursor:pointer;"><em><img src="/images/mapIcon/T/icon_b5_0.png" alt="임시폐쇄" style="width: auto;height: auto;max-width: 100%;"/></em></span></div>
									<div style="display: inline-block; width:8%;"><span class="filterBat" style="cursor:pointer;"><em><img src="/images/batLow.png" alt="배터리부족" style="width: auto;height: auto;max-width: 120%;"/></em></span></div>	
									<div style="display: inline-block; width:8%;"><div style="display: inline-block;float: right;"><span class="filterExit" style="cursor:pointer;"><em><img src="/images/position_re.png" alt="필터초기화" style="width: auto;height: auto;max-width: 77%; position: absolute; top: 15px; right: 10px;" /></em></span></div></div>
								</div>
								<div id="filterLabel" style="width:100%; margin-left: -0.3%;">
									<div style="display: inline-block; width:14%;"><span class="filterLstBike" style="cursor:pointer; font-weight: bold;">분실</span></div>
									<div style="display: inline-block; width:14%;"><span class="filterRtnBike" style="cursor:pointer; font-weight: bold;">강반</span></div>
									<div style="display: inline-block; width:14%;"><span class="filterExcess" style="cursor:pointer; font-weight: bold;">초과</span></div>
									<div style="display: inline-block; width:14%;"><span class="filterErr" style="cursor:pointer; font-weight: bold;">고장</span></div>
									<div style="display: inline-block; width:14%;"><span class="filterTeamp" style="cursor:pointer; font-weight: bold;">임폐</span></div>
									<div style="display: inline-block; width:14%;"><span class="filterBat" style="cursor:pointer; font-weight: bold;">부족</span></div>
									<div style="display: inline-block;"></div>
								</div>
							</div> -->
							<div id="mapDiv" class="mt20" ></div>
							<div class="listalign mt20" style="margin-bottom : 5px;">
								<label><input name="lsalign" type="radio" value="ASC" class="vm" >오름차순</label>
								<label><input name="lsalign" type="radio" value="DESC" class="vm ml10" checked="checked" >내림차순</label>
								<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 건수 : ${fn:length(stationList)} -테스트대여소 포함</span><br/>
								<span>표 상단 제목을 누르시면 정렬됩니다.(우측 정렬조건에 따라)</span>
								<%-- 
								<c:if test="${condition.stationSeCd eq 'RAK_003'}">
									<c:set var="RAK_003_totBikeCnt" value="0"></c:set>
									<c:forEach var="info" items="${stationList}">
										<c:if test="${ info.stationUseYn eq 'Y'}">
											<c:set var="RAK_003_totBikeCnt" value="${RAK_003_totBikeCnt + info.parkingELECBikeCnt}"></c:set>
										</c:if>
									</c:forEach>
									<span style="position: relative; top: 2%; left: 32%;">새싹자전거 수 : ${RAK_003_totBikeCnt}</span>
								</c:if>
								 --%>
							</div>
							<table class="tb_type01" id="list">
								<colgroup>
									<col style="width:80%;" class="station_col1"/>
									<col style="width:auto;" class="station_col2"/>
								</colgroup>
								<thead>
									<tr>
										<th>대여소</th>
										<!-- <th title="[ LCD/QR/새싹]">자전거<br/> (점검)</th> -->
										<!-- <th title="연결반납 자전거 수/전체 자전거 수(점검수)">자전거 (점검)</th> -->
										<th>거치댓수</th>
									</tr>
								</thead>
								<tbody> 
								<c:forEach var="info" items="${stationList}" varStatus="status" end="100" >
									<tr>
										<td class="title tl"><a href="#" id="${ info.stationId }" >${ info.stationName }</a></td>
										<td class="title tr pr10">${ info.parkingBikeTotCnt }</td>
									</tr> 
								</c:forEach>
								<c:if test="${fn:length(stationList) == 0 }">
									<tr><td colspan="2" style="text-align: center;"><spring:message code="search.nodata.msg" /></td></tr>
								</c:if>
								</tbody>
							</table>
						<c:choose>
							<c:when test="${fn:length(stationList) > 0}">
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
							</form>
						</div>
					</div>
					<!--conteent E-->
				</div>
			</div>
			<!--footer S-->
			<tiles:insertAttribute name="footer"/>
			<!--footer E-->
		<%@ include file="./pre_sta_stateJs.jsp" %>
	</c:otherwise>
	</c:choose>
</body>

</html>
