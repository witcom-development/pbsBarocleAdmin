<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ page import="com.dkitec.barocle.base.IConstants" %>
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
						<div class="tabWrap type3">
							<ul class="tabBox">
								<li class="tab on"><button class="tabBtn" type="button" idx="1">상세정보</button></li>
								<li class="tab"><button class="tabBtn" type="button" idx="2">이력정보</button></li>
								<!-- <li class="tab"><button class="tabBtn" type="button" idx="3">수리이력</button></li> -->
								<li class="tab"><button class="tabBtn" type="button" idx="4">로그정보</button></li>
							</ul>
							<div class="tabCon on">
								<form id="frm">
									<input type="hidden" name="viewFlg" value="${bike.getViewFlg() }"/>
									<input type="hidden"  name="searchBgnDe"  value="${bike.getSearchBgnDe()}" />
									<input type="hidden"  name="searchEndDe"  value="${bike.getSearchEndDe()}" />
									<input type="hidden"  name="currentPageNo" value="1"/>
									<input type="hidden" name="tabNum" value="${bike.getTabNum() }"/>
									<input type="hidden" name="locateId" value=""/>
									<input type="hidden" name="locateClsCd" value="C"/>
									<input type="hidden" name="dupChk" value="N"/>
									<input type="hidden" name="bikeNo" value="${currentInfo.bikeNo ne null ? currentInfo.bikeNo : bike.bikeNo  }"/>
									<!-- 대여현황목록 회원정보 연동 링크 start_cms_20161104 -->
									<input type="hidden" name="usr_seq"	id="usr_seq">
									<!-- end -->
									<fieldset>
										<table  class="tb_type02 mt20">
											<caption>자전거</caption>
											<colgroup>
												<col style="width:25%"/>
												<col style="width:75%"/>
											</colgroup>
											<tbody>
												<tr>
													<th class="top"><em>*</em>자전거 번호 / ID</th>
													<td class="top ">
														<span class="input-text08"><label id="bikeLabel"><c:out value="<%=IConstants.PREFIX_BIKE_NO%>"/> </label>-<input type="text" class="input-text08" id="bikeNo"  maxlength="15"  value=""/></span>
														<span class="dash"> / </span>
														<span class="input-text08"><input type="text" class="input-text08" id="bikeId"  name="bikeId" maxlength="20" value="${bikeVo.bikeId }"/></span>
														<c:if test="${ bike.getViewFlg() eq 'C' }">
															<button class="btnType02" id="dupCodeCheck" >중복확인</button>
														</c:if>
													</td>
												</tr>
												<tr>
													<th>자전거 구분 </th>
													<td>
														<select class="select-category02" name="bikeSeCd" id="bikeSlt">
															<option value="">선택</option>
														</select>
													</td>
												</tr>
												<tr>
													<th>단말기 ID</th>
													<td>
														<span><input type="text" name="terminalId" value="${bikeVo.terminalId}" /></span>
													</td>
												</tr>
												<c:if test="${bike.getViewFlg() eq 'U' }">
												<tr>
													<th>아파트</th>
													<td>
														<select class="select-category02" name="stationGrpSeq" id="stationGrpSlt" disabled="disabled">
															<option value="">선택</option>
														</select>
													</td>
												</tr>
												<tr>
													<th>정거장명/거치대</th>
													<td>
														<select class="select-category04"  name="stationId" id="stationSlt" disabled="disabled">
															<option value="">선택</option>
														</select>
														<span class="input-text08">
															<input type="text" class="input-text08"  name="stationEquipOrder"  value="${bikeVo.stationEquipOrder }" readonly="readonly"/>
														</span>
													</td>
												</tr>
												</c:if>
												<!-- 
												<tr>
													<th>센터</th>
													<td>
														<select class="select-category02" name="centerId" id="centerSlt">
															<option value="">선택</option>
														</select>
													</td>
												</tr>
												 -->
												<tr>
													<th><em>*</em>상태</th>
													<td>
														<select class="select-category02" name="bikeStatusCd" id="statusSlt">
															<option value="">선택</option>
														</select>
													</td>
												</tr>
												<%-- 
												<tr>
													<th>최종 정기 점검일</th>
													<td>
														<span class="input-text08"><input type="text" class="input-text08" name="lastChkDttm" readonly value="${bikeVo.lastChkDttm }"/></span>
														<c:if test="${bike.getViewFlg() eq 'U' }">
															<a href="/common/pop/DEV_001/showRegularChkPop.do" class="winNewPop modal btnType02" title="정기점검" data-width="450" data-height="588" data-pmt="&equipmentId=${bikeVo.bikeNo}&mode=U">정기점검</a>
														</c:if>
													</td>
												</tr>
												 --%>
												 <tr>
													<th>납품처</th>
													<td>
														<select class="select-category02" name="entrpsCd" id="entrpsSlt">
															<option value="">선택</option>
														</select>
													</td>
												</tr>
												<tr>
													<th>등록일</th>
													<td>
														<span><input type="text" name="regDttm" value="${bikeVo.regDttm}" readonly /></span>
													</td>
												</tr>
											</tbody>
										</table>
										<div class="btnArea">
											<span class="left"><button class="btnType01 bc_gray" id="moveListPage1">목록</button></span>
											<span class="right">
												<%-- <a href="/common/pop/showBikeRetrievalPop.do" 		class="winNewPop btnType01" title="회수" data-width="450" data-height="600" data-pmt="&rentBikeId=${bikeVo.bikeId }&rentBikeNo=${bikeVo.bikeNo }">회수</a>
												<a href="/common/pop/showBikeRobbedPop.do" 		class="winNewPop btnType01" title="도난추정" data-width="450" data-height="689" data-pmt="&rentBikeId=${bikeVo.bikeId }&rentBikeNo=${bikeVo.bikeNo }">도난추정</a>
												<a href="/common/pop/showBikeParkingLocation.do" class="winNewPop btnType01" title="방치신고" data-width="450" data-height="689" data-pmt="&rentBikeId=${bikeVo.bikeId }&rentBikeNo=${bikeVo.bikeNo }" >방치신고</a> --%>
												
<!--											   
												<c:if test="${ bikeVo.bikeStatusCd ne 'BKS_007'}">
													<a href="/common/pop/showBikeMissingPop.do"  class="winNewPop btnType01" title="분실등록" data-width="450" data-height="315" data-pmt="&bikeId=${bikeVo.bikeId}&bikeNo=${bikeVo.bikeNo}&terminalId=${bikeVo.terminalId}&chkType=I">분실등록</a>
												</c:if>
  -->												
												<c:if test="${ bikeVo.bikeStatusCd eq 'BKS_007'}">
													<!-- 분실해제 팝업 -->
													<a href="/common/pop/showBikeMissingPop.do"  class="winNewPop btnType01" title="분실해제" data-width="450" data-height="315" data-pmt="&bikeId=${bikeVo.bikeId}&bikeNo=${bikeVo.bikeNo}&terminalId=${bikeVo.terminalId}&chkType=U">분실해제</a>
												</c:if>
												<c:if test="${ bikeVo.bikeSeCd ne NULL && bikeVo.bikeSeCd ne ''}">
													<a href="/common/pop/showBikeMap.do" class="winNewPop btnType01" title="위치찾기" data-width="450" data-height="689" data-pmt="&rentBikeId=${bikeVo.bikeId }&rentBikeNo=${bikeVo.bikeNo }" >위치찾기</a>
												</c:if>
												<button class="btnType01 bc_green" id="exeBikeEdit">저장</button>
											</span>
											
										</div>
									</fieldset>
								</form>
							</div>
							<div class="tabCon">
								<p class="head mt20">자전거 상태 정보</p>
								<table class="tb_type01 mt20">
									<caption>자전거 상태 정보</caption>
										<colgroup>
											<col style="width:25%">
											<col style="width:25%">
											<col style="width:25%">
											<col style="width:25%">
										</colgroup>
									<thead>
										<tr>
											<th>자전거 번호</th>
											<th>상태</th>
											<th>현재위치</th>
											<th>전체이동거리(km)</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td class="pl10">${currentInfo.bikeNo }</td>
											<td class="pl10">${currentInfo.bikeStatusName }</td>
											<td class="pl10">${currentInfo.centerName }${currentInfo.stationName }</td>
											<td class="tr pr10">${currentInfo.totMoveDist }</td>
										</tr>
									</tbody>
								</table>
								<p class="head">자전거 대여 이력</p>
								<!--검색조건 S-->
								<form id="searchFrm"> 	
									<div class="shBox">
										<fieldset>
											<legend>검색 옵션</legend>
											<div class="shBoxSection">
												<div class="section">
													<label for="bb22" class="laType02">대여일</label>
													<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04"  name="searchBgnDeT"  title="선택 날짜" id="bb22" readonly/></span>
													<span class="dash">~</span>
													<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04"  name="searchEndDeT"  title="선택 날짜" readonly/></span>
													<button type="button" id="searchBtn" class="btn-srh03 btncase1"><img src="/images/searchIcon.gif" alt="검색" ></button>
												</div>
											</div>
										</fieldset>
								</div>
								</form>
								<!--검색조건 E-->
								<table class="tb_type01 mt20" id="rentTbl">
									<caption>자전거 대여 이력</caption>
										<colgroup>
											<col style="width:12%">
											<col style="width:12%">
											<col style="width:12%">
											<col style="width:12%">
											<col style="width:12%">
											<!--[if gt IE 8]><!--><col style="width:12%" class="mhid"><!--<![endif]-->
											<!--[if gt IE 8]><!--><col style="width:10%" class="mhid"><!--<![endif]-->										  
											<!--[if gt IE 8]><!--><col style="width:10%" class="mhid"><!--<![endif]-->
										</colgroup>
									<thead>
										<tr>
											<th rowspan="2">대여구분</th>
											<th colspan="2">대여</th>
											<th colspan="2">반납</th>
											<!--[if gt IE 8]><!--><th rowspan="2" class="mhid">대여자 정보</th><!--<![endif]-->
											<!--[if gt IE 8]><!--><th rowspan="2" class="mhid">이용거리(km)</th><!--<![endif]-->
											<!--[if gt IE 8]><!--><th rowspan="2" class="mhid">이용시간(분)</th><!--<![endif]-->
										</tr>
										<tr class="spanLine">
											<th>일시</th>
											<th>station</th>
											<th>일시</th>
											<th>station</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="info" items="${rentalList }" varStatus="loop">
										<tr>
											<td class="pl10">${info.rentClsCdName }</td>
											<td class="pl10">
											   <c:if test="${ info.rentDttm ne null }">
											   <a href="/common/pop/rentDetailPop.do" class="winNewPop" style="color : #3366FF" title="대여상세" data-width="450" data-height="680" data-pmt="&rentHistSeq=${info.rentHistSeq}">${info.rentDttm }</a>
											   </c:if>
											</td>
											<td class="pl10">${info.rentStationName }</td>
											<td class="pl10">${info.returnDttm }</td>
											<td class="pl10">${info.returnStationName }</td>
											<%-- 자전거 대여이력 회원정보 연동 링크 start_cms_20161104
											<!--[if gt IE 8]><!--><td class="mhid">${info.mbId }</td><!--<![endif]-->
											end --%>
											<!-- 대여현황목록 회원정보 연동 링크 start_cms_20161104 -->
											<td class="mhid" ><a href="#"  id="${info.usrSeq }" name="usrSeq">${info.usrMpnNo }</a></td>
											<!-- end -->
											<!--[if gt IE 8]><!--><td class="mhid">${info.useDist }</td><!--<![endif]-->
											<!--[if gt IE 8]><!--><td class="mhid">${info.useMi }</td><!--<![endif]-->
										</tr>
										</c:forEach>
									</tbody>
								</table>
								<c:if test="${fn:length(rentalList) eq 0 }">
								<table class="tb_type01 nbt0">
									<tr><td style="text-align:center"><spring:message code="search.nodata.msg" /></td></tr>
								</table>
								</c:if>
								<div class="paging">
									<div id="pagingWeb">
										<c:if test="${paginationInfo!=null}">
										<ui:pagination paginationInfo="${paginationInfo}" type="custom" jsFunction="bikeDetail.pageSelect" />
										</c:if>
									</div>
									<div id="pagingMobile">
										<c:if test="${paginationMobileInfo!=null}">
										<ui:pagination paginationInfo="${paginationMobileInfo}" type="custom" jsFunction="bikeDetail.pageSelect" />
										</c:if>
									</div>
								</div>
								<div class="btnArea">
									 <span class="left"><button class="btnType01 bc_gray" id="moveListPage2">목록</button></span>
									<span class="right"><button class="btnType01 mb10 mhid" id="excelViewBtn" title="엑셀다운로드">엑셀다운로드</button></span>
								</div>
							</div>
							<!-- 수리이력 시작 -바로클 고도화 -->
							<div class="tabCon">
								<p class="head mt20">자전거 상태 정보</p>
								<table class="tb_type01 mt20">
									<caption>자전거 상태 정보</caption>
										<colgroup>
											<col style="width:25%">
											<col style="width:25%">
											<col style="width:25%">
											<col style="width:25%">
										</colgroup>
									<thead>
										<tr>
											<th>자전거 번호</th>
											<th>상태</th>
											<th>현재위치</th>
											<th>전체이동거리(km)</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td class="pl10">${currentInfo.bikeNo }</td>
											<td class="pl10">${currentInfo.bikeStatusName }</td>
											<td class="pl10">${currentInfo.centerName }${currentInfo.stationName }</td>
											<td class="tr pr10">${currentInfo.totMoveDist }</td>
										</tr>
									</tbody>
								</table>
								<p class="head">자전거 수리 이력</p>
								<table class="tb_type01 mt20" id="rentTbl">
									<caption>자전거 수리 이력</caption>
										<colgroup>
											<col style="width:20%">
											<col style="width:20%">
											<col style="width:20%">
											<col style="width:20%">
											<col style="width:20%">
										</colgroup>
									<thead>
										<tr>
											<th>자전거 번호</th>
											<th>유지보수자명</th>
											<th>상태</th>
											<th>수리일자</th>
											<th>완료일자</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="result" items="${resultListRepair}" varStatus="status">
									   		<tr>
												<td style="display: none;">${result.repairSeq}</td>
												<td>${result.bikeNo}</td>
												<td style="display: none;">${result.bikeId}</td>
												<td>${result.adminId}</td>
												<td>${result.repairCmptYn == 'Y' ? '수리완료' : '수리중'}</td>
												<td>${result.repDttm }</td>
												<td>${result.cmptDttm }</td>
											</tr>
										</c:forEach>	
										<c:if test="${fn:length(resultListRepair) eq 0 }">
											<table class="tb_type01 nbt0">
												<tr><td style="text-align:center"><spring:message code="search.nodata.msg" /></td></tr>
											</table>
										</c:if>
									</tbody>
								</table>
								<%-- <div class="paging">
									<div id="pagingWeb">
										<c:if test="${paginationInfoRepair!=null}">
										<ui:pagination paginationInfo="${paginationInfoRepair}" type="custom" jsFunction="repairHist.pageSelect" />
										</c:if>
									</div>
									<div id="pagingMobile">
										<c:if test="${paginationMobileInfoRepair!=null}">
										<ui:pagination paginationInfo="${paginationMobileInfoRepair}" type="custom" jsFunction="repairHist.pageSelect" />
										</c:if>
									</div>
								</div> --%>
								<c:choose>
						<c:when test="${fn:length(resultListRepair) > 0}">
							<div class="drpaging">
						</c:when>
						<c:otherwise>
							<div class="drpaging" style="display:none;">
						</c:otherwise>
						</c:choose>
							<c:choose>
							<c:when test="${paginationInfoRepair.currentPageNo > 1}">
								<a id="prevPage" href="#"><img src="/images/p_prev.gif" alt="이전 페이지" /></a>
							</c:when>
							<c:otherwise>
								<a href="#"><img src="/images/p_prev.gif" alt="이전 페이지" /></a>
							</c:otherwise>
							</c:choose>
							<span><input name="currentPageNoRepair" type="number" value="${paginationInfoRepair.currentPageNo}"/><em>/ ${paginationInfoRepair.totalPageCount}</em><button id="movePage">이동</button></span>
							<c:choose>
							<c:when test="${paginationInfoRepair.currentPageNo < paginationInfoRepair.totalPageCount}">
							<a id="nextPage" href="#"><img src="/images/p_next.gif" alt="다음 페이지" /></a>
							</c:when>
							<c:otherwise>
								<a href="#"><img src="/images/p_next.gif" alt="다음 페이지" /></a>
							</c:otherwise>
							</c:choose>
						</div>
								<div class="btnArea">
									 <span class="left"><button class="btnType01 bc_gray" id="moveListPage3">목록</button></span>
								</div>
							</div>
							<!-- 수리이력 끝 -->
							<!-- 로그정보 시작 -->
						  <div class="tabCon">
						  	<fieldset>
								<table  class="tb_type02 mt20">
									<caption>자전거</caption>
										<colgroup>
											<col style="width:25%"/>
											<col style="width:75%"/>
										</colgroup>
										<tbody>
											<tr>
												<th class="top"><em>*</em>자전거 번호 / ID</th>
												<td class="top">${logInfo.bikeNo }</td>
											</tr>
											<tr>
												<th>단말기ID</th>
												<td>${logInfo.deviceId }</td>
											</tr>
											<tr>
												<th>최종보고시간<br>(yyyymmddhhMMss)</th>
												<td><%-- ${logInfo.bikeTimeStamp } --%>
													<script type="text/javascript">
													var str = "${logInfo.bikeTimeStamp }";
													document.write(str.substring(0, 4)+"년 " +str.substring(4, 6) +"월 " +str.substring(6,8)+"일 "+str.substring(8,10)+"시 "+str.substring(10,12)+"분 "+str.substring(12)+"초");
													</script>
												</td>
											</tr>
											<tr>
												<th>자전거 상태</th>
												<td>
													<c:choose>
														<c:when test="${logInfo.bikeStatus eq '00'}">-</c:when>
														<c:when test="${logInfo.bikeStatus eq '01'}">설치 및 초기</c:when>
														<c:when test="${logInfo.bikeStatus eq '02'}">대기상태(반납)</c:when>
														<c:when test="${logInfo.bikeStatus eq '03'}">대여상태</c:when>
														<c:when test="${logInfo.bikeStatus eq '04'}">관리자이동</c:when>
														<c:when test="${logInfo.bikeStatus eq 'FF'}">공장초기화</c:when>
													</c:choose>
													(${logInfo.bikeStatus})
												</td>
											</tr>
											<tr>
												<th>LOCK 상태</th>
												<td>
													<c:choose>
														<c:when test="${logInfo.bikeLock eq '00'}">-</c:when>
														<c:when test="${logInfo.bikeLock eq '01'}">락 닫힘</c:when>
														<c:when test="${logInfo.bikeLock eq '02'}">락 열림</c:when>
													</c:choose>
													(${logInfo.bikeLock })
												</td>
											</tr>
											<tr>
												<th>사용자타입<br>(사용자내부번호)</th>
												<td>
													<c:choose>
														<c:when test="${logInfo.userType eq '01'}">사용자(${logInfo.userSeq })</c:when>
														<c:when test="${logInfo.userType eq '02'}">관리자(${logInfo.userSeq })</c:when>
														<c:otherwise>-</c:otherwise>
													</c:choose>
												</td>
											</tr>
											<tr>
												<th>비콘ID</th>
												<td>${logInfo.beaconId }</td>
											</tr>
											<tr>
												<th>단말기 배터리</th>
												<td>${logInfo.devBatt }%</td>
											</tr>
											<tr>
												<th>비콘 배터리</th>
												<td>${logInfo.beaconBatt }%</td>
											</tr>
											<tr>
												<th>전기자전거 배터리</th>
												<td>${logInfo.bikeBatt }%</td>
											</tr>
											<tr>
												<th>위치 x, y</th>
												<td>
													XPOS : ${logInfo.xPos }<br>YPOS : ${logInfo.yPos }
												</td>
											</tr>
											<tr>
												<th>펌웨어 버젼</th>
												<td>${logInfo.firmFw }</td>
											</tr>
											<tr>
												<th>모뎀FW</th>
												<td>${logInfo.modemFw }</td>
											</tr>
										</tbody>
								</table>
							</fieldset>
							<c:if test="${ logInfo.bikeNo ne NULL && logInfo.bikeNo ne ''}">
							<div class="btnArea">
								<a href="/common/pop/showBikeMap.do" class="winNewPop btnType01" title="위치찾기" data-width="450" data-height="689" data-pmt="&rentBikeId=${logInfo.deviceId }&rentBikeNo=${logInfo.bikeNo }" >위치찾기</a>
							</div>
							</c:if>
						  </div>
						   <!-- 로그정보 끝 -->
						</div>
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
	$(function(){
		bikeDetail.initView();
		bikeDetail.initCombo();
		bikeDetail.initBtn();
	});
	
	//이력 달력
	var calDay = new Date();
	var dayOfMonth = calDay.getDate();
	calDay.setDate(dayOfMonth - 7);
	var startDay = DateUtil.dateFmt(calDay);
	var endDay = DateUtil.dateFmt(new Date());
	var sDate = '${bike.searchBgnDe}' !== '' ? '${bike.searchBgnDe}' : startDay;
	var eDate = '${bike.searchEndDe}' !== '' ? '${bike.searchEndDe}' : endDay;
	
	$("[name='searchBgnDeT']").val(sDate);
	$("[name='searchEndDeT']").val(eDate);
	
	var PREFIX_BIKE_NO = "<%=IConstants.PREFIX_BIKE_NO%>";
	var bikeDetail = {};
	bikeDetail.bikeId = '${bikeVo.bikeId}';
	bikeDetail.bikeNo = '${bikeVo.bikeNo}';
	bikeDetail.bikeStatusCd  = '${bikeVo.bikeStatusCd}';
	bikeDetail.stationGrpSeq = '${bikeVo.stationGrpSeq}';
	bikeDetail.stationId	 = '${bikeVo.stationId}';
	bikeDetail.centerId	  = '${bikeVo.centerId}';
	bikeDetail.entrpsCd	  = '${bikeVo.entrpsCd}';
	bikeDetail.viewType	  = '${bike.getViewFlg() }';
	bikeDetail.bikeSeCd	  = '${bikeVo.bikeSeCd}';
	
	bikeDetail.initView = function() {
		var tNum = $("[name='tabNum']").val() === '' ? 1 : parseInt($("[name='tabNum']").val());
		if(tNum === 1) {
			//탭 상세정보
			$(".tab").eq(0).addClass('on');
			$(".tabCon").eq(0).addClass('on');
			
			$(".tab").eq(1).removeClass('on');
			$(".tabCon").eq(1).removeClass('on');
			$(".tab").eq(2).removeClass('on');
			$(".tabCon").eq(2).removeClass('on');
			$(".tab").eq(3).removeClass('on');
			$(".tabCon").eq(3).removeClass('on');
			
		} else if(tNum === 2) {
			$(".tab").eq(0).removeClass('on');
			$(".tabCon").eq(0).removeClass('on');
			//탭 이력정보
			$(".tab").eq(1).addClass('on');
			$(".tabCon").eq(1).addClass('on');
			
			$(".tab").eq(2).removeClass('on');
			$(".tabCon").eq(2).removeClass('on');
			$(".tab").eq(3).removeClass('on');
			$(".tabCon").eq(3).removeClass('on');
			
		} else if(tNum === 3) {
			$(".tab").eq(0).removeClass('on');
			$(".tabCon").eq(0).removeClass('on');
			$(".tab").eq(1).removeClass('on');
			$(".tabCon").eq(1).removeClass('on');
			//탭 수리이력
			$(".tab").eq(2).addClass('on');
			$(".tabCon").eq(2).addClass('on');
			
			$(".tab").eq(3).removeClass('on');
			$(".tabCon").eq(3).removeClass('on');
			
		}else {
			$(".tab").eq(0).removeClass('on');
			$(".tabCon").eq(0).removeClass('on');
			$(".tab").eq(1).removeClass('on');
			$(".tabCon").eq(1).removeClass('on');
			$(".tab").eq(2).removeClass('on');
			$(".tabCon").eq(2).removeClass('on');
			//탭 로그정보
			$(".tab").eq(3).addClass('on');
			$(".tabCon").eq(3).addClass('on');
			
		}
		if( $("[name='viewFlg']").val() === 'C' ) {
			$(".tabBox > li").eq(1).css("display", "none");
			$(".right").find('a').css("display", "none");
			$(".tabBox > li").eq(2).css("display", "none");
			$(".right").find('a').css("display", "none");
			$(".tabBox > li").eq(3).css("display", "none");
		} else {
			$("[name='dupChk']").val("Y");
			$("#stationGrpSlt").prop('disabled', true);
			$("#stationSlt").prop('disabled', true);
			$("#centerSlt").prop('disabled', true);
			//$("#statusSlt").prop('disabled', true);
			$("#entrpsSlt").prop('disabled', true);
			$("#bikeSlt").prop('disabled', true);
		}
		var bNum = '${bikeVo.bikeNo}'.split("-");
		if(bNum.length > 1){
			$("#bikeNo").val(bNum[1]);
		} 

	};
	bikeDetail.initBtn = function() {
		var _this = bikeDetail;
		$("#moveListPage1").on("click", this.clickListPage);
		$("#moveListPage2").on("click", this.clickListPage);
		$("#moveListPage3").on("click", this.clickListPage);
		$("#dupCodeCheck").on("click", this.isDupIdChkFnc);
		$("#exeBikeEdit").on("click", this.exeBikeEditFnc);

		$("#excelViewBtn").on("click",{listType : "excel"},this.searchListPage);
		$("#searchBtn").on("click",{listType: "list"}, this.searchListPage);
		//moveListpage
		$("#stationGrpSlt").on('change', function(e) {
			/*if($("#centerSlt").val() !== '') {
				$("#centerSlt").val('');
				$("#statusSlt").val('');
			}*/
			var tId = e.target.id;
			var idx = $("#"+tId+" option:selected").index();
			var subList =$("#"+tId).data().sub_data;
			 
			var sltsubData = subList[(idx-1)];
			if(sltsubData !== undefined) {
				if(sltsubData.length > 0) {
					commCdBox.makeComboBox("S",_this.stationId, sltsubData, "stationSlt");
				}
			}
		});
		$("#stationGrpSlt").trigger("change");
		$("#stationSlt").on("change", function(e){
			$("#statusSlt").val('BKS_003');
		});
		$("#centerSlt").on("change",function(e){
			$("#statusSlt").val('BKS_004');
			$("#stationGrpSlt").val('');
			$("#stationSlt").val(''); 
		});
		$(".tb_type01 > tbody > tr").on("click", "a", this.moveRentStatusDetail);
		
		var totalPageCount = '${paginationInfoRepair.totalPageCount}' == '' ? 1 : Number('${paginationInfoRepair.totalPageCount}');
			$('#prevPage').on("click",function(){
				var currentPageNo = Number($('[name="currentPageNoRepair"]').val());
				bikeDetail.pageSelect2(currentPageNo-1);
			});
			$('#nextPage').on("click",function(){
				var currentPageNo = Number($('[name="currentPageNoRepair"]').val());
				bikeDetail.pageSelect2(currentPageNo+1);
			});
			$('#movePage').on("click",function(){
				var currentPageNo = Number($('[name="currentPageNoRepair"]').val());
				var regExp = /^[1-9]?[0-9]/;
				if(!regExp.test(currentPageNo) ||(totalPageCount < currentPageNo)){
					alert('현재 페이지 값이 정상적이지 않습니다.');
				}else{
					bikeDetail.pageSelect2(currentPageNo);
				}
			});
		
			$(".tabBtn").on("click",this.tabSelect);
	
	};
	
	bikeDetail.moveRentStatusDetail = function(e) {
		e.preventDefault();
		<%-- 대여현황목록 회원정보 연동 링크 start_cms_20161104 --%>
		if($(this).attr('name') == "usrSeq"){
			$("#usr_seq").val(e.target.id);
			$("#frm").attr({action: '/admin/service/member/memberInfo.do', method :"post"}).submit();
		}
	};
	
	bikeDetail.clickListPage = function(e) {
		var _this = bikeDetail;		
		e.preventDefault();
		_this.moveListpage();
		
	};
	
   bikeDetail.searchListPage = function(e) {
	   e.preventDefault();
	   e.stopPropagation();
	   
	   var listType = e.data.listType;
		$("[name='viewFlg']").val("R");
		$("[name='pageNo']").val(1);
		$("[name='bikeStatusCd']").val('');
		$("[name='currentPageNo']").val(1);
		$("[name='tabNum']").val(2);
		$("[name='searchBgnDe']").val($("[name='searchBgnDeT']").val());
		$("[name='searchEndDe']").val($("[name='searchEndDeT']").val());
		$("#frm").attr({method :"post", action :"/moveBikeEditForm.do"}).submit();
	}; 
	
	bikeDetail.moveListpage = function() {
		$("[name='viewFlg']").val("list");
		$("[name='pageNo']").val(1);
		$("[name='bikeStatusCd']").val('');
		$("#frm").attr({method :"post", action :"/getBikeList.do"}).submit();
	};
	bikeDetail.initCombo = function() {
		var _this = bikeDetail;
		if(_this.bikeId !== '' && _this.bikeNo !== '') {
			$("[name='bikeId']").prop('readonly', true);
			$("#bikeNo").prop('readonly', true);
		}
		//상태코드
		commonAjax.getCommonCode("BKS", function(data) {
			 if(data !== null && data.codeList !== null) {
				 commCdBox.makeComboBox('CC',_this.bikeStatusCd, data.codeList, "statusSlt");
			 }
		});
		//센터 
		commonAjax.getCenterCode( 
				function(data) {
					if(data !== null && data.centerList !== null) {
						commCdBox.makeComboBox('C', _this.centerId, data.centerList, "centerSlt");
					}
				}
		);
		 //스테이션 
		commonAjax.getStationCode( 
			function(data) {
				if(data != null && data.stationList != null) {
					$("#stationGrpSlt > option").not(':eq(0)').empty();
					commCdBox.makeComboBox('S', _this.stationGrpSeq,data.stationList, "stationGrpSlt");
					if(_this.stationId !== '') {
					  	$("#stationGrpSlt").trigger("change");
					}
				}
			}
		);
		
		// 납품처 
		commonAjax.getCommonCode("ENT", function(data) {
			if(data !== null && data.codeList !== null) {
				commCdBox.makeComboBox('CC',_this.entrpsCd, data.codeList, "entrpsSlt");
			}
		});
	  //자전거 구분
		commonAjax.getCommonCode("BIK", function(data) {
			 if(data !== null && data.codeList !== null) {
				 commCdBox.makeComboBox('CC',_this.bikeSeCd, data.codeList, "bikeSlt");
			 }
		});
	};
	
	bikeDetail.exeBikeEditFnc = function (e) {
		e.preventDefault();
		$("[name='locateId']").val($("#centerSlt").val());
		var bikeNum = $("#bikeLabel").text()+"-"+$("#bikeNo").val();
		$("[name='bikeNo']").val(bikeNum);
		
		if(bikeDetail.inputValidChk()) {
			
			if(bikeDetail.viewType === 'C') {
				$("[name='locateId']").val($("#centerSlt").val());
			}
			
			commonAjax.postAjax("/bikeDataEditExe.do", "json", $("#frm").serialize()
				,function(data) {
					 if(data.result > 0) {
						 alert(data.resultMessage);
						if(bikeDetail.viewType === 'C'){
							bikeDetail.moveListpage();  
						}
						return false;
					 } else {
						 alert(data.resultMessage);
						 return false;
					 }
				}
			) ;			
		}
	};
	
	bikeDetail.inputValidChk = function() {

		if($("#bikeNo").val() === '' || $("#bikeId").val() === '') {
			alert("자전거 번호와 ID 둘다 입력해주세요.");
			return false;
		}
		if(!isAlNumber($("#bikeNo").val())) {
			alert("자전거 번호는 영문,숫자만 입력가능 합니다.");
			$("#bikeNo").val('').focus();
			return false;
		}
		if(!isAlNumber($("#bikeId").val())) {
			alert("자전거 번호는 영문,숫자만 입력가능 합니다.");
			$("#bikeId").val('').focus();
			return false;
		}
	   
		if(bikeDetail.viewType === 'C' && $("[name='dupChk']").val() === 'N') {
			alert("자전거 번호, ID의 중복 체크를 해주세요.");
			return false;
		}
		if($("#stationSlt").val() === "" && $("#centerSlt").val() === '') {
			alert("등록할 센터를 선택 해주세요.");
			return false;
		}
		if($("#statusSlt").val() === '') {
			alert("자전거 상태를 선택해주세요.");
			return false;
		}
	   /*  if($("#stationGrpSlt").val() !== '') {
			if($("#stationSlt").val() === ''){
				alert("정거장명을 선택해 주세요");
				return false;
			}
			if($("#centerSlt").val() !== '') {
				alert("정거장 또는 센터 한곳만 선택 해주세요.");
				$("#centerSlt").val('');
				return false;
			}
			if($("[name='terminalId']").val() === "") {
				alert("단말기 ID를 검색해 주세요.");
				return false;
			}
		} else {
		   
		} */
		return true;
	};
	bikeDetail.pageSelect = function(pageNo) {
		$("[name='currentPageNo']").val(pageNo);
		$("[name='viewFlg']").val("R");
		$("[name='tabNum']").val(2);
		$("#frm").attr({method : "post", action : "/moveBikeEditForm.do"}).submit();
		
	};
	bikeDetail.isDupIdChkFnc = function(e) {
		e.preventDefault();
		if($("#bikeNo").val() === '' || $("#bikeId").val() === '') {
			alert('중복확인을 위한 자전거 번호와 자전거 Id를 입력해주세요.');
			return false;
		}
		if(!isAlNumber($("#bikeNo").val())) {
			alert("자전거 번호는 영문,숫자만 입력가능 합니다.");
			$("#bikeNo").val('').focus();
			return false;
		}
		if(!isAlNumber($("#bikeId").val())) {
			alert("자전거 번호는 영문,숫자만 입력가능 합니다.");
			$("#bikeNo").val('').focus();
			return false;
		}
   		var bNo = PREFIX_BIKE_NO.concat("-").concat($("#bikeNo").val());
   		$("[name='bikeNo']").val(bNo);
		
		commonAjax.postAjax('/bike/dupIdCheckAjax.do','json', $("#frm").serialize()
			, function(data){
				   if(data) {
					   alert(data.resultMessage);
					   if(!data.result ){
						   $("[name='dupChk']").val("Y");
					   }
					   if(data.target === "id") {
						   $("[name='bikeId']").val("").focus();
					   } else if(data.target === "no"){
						   $("#bikeNo").val("").focus();
					   } else if(data.target === "both") {
						   $("#bikeNo").val("").focus();
						   $("[name='bikeId']").val("");
					   } else {}
					   return false;
					   
				   }
			  }
		);
		
	};
	bikeDetail.setTerminalId = function(tId) {
		$("[name='terminalId']").val(tId);
		$("#centerSlt").val("");
	};
	function bikeStatusChange(statusCode) {
		$("#statusSlt").val(statusCode);
	};
	function setNewLastChkDttm(chkDttm) {
		$("[name='lastChkDttm']").val(chkDttm);
	};
  
	bikeDetail.pageSelect2 = function(pageNo) {
		$("[name='currentPageNo']").val(pageNo);
		$("[name='viewFlg']").val("R");
		$("[name='tabNum']").val(3);
		
		$("#frm").attr({method : "post", action : "/moveBikeEditForm.do"}).submit();
		
	};
	
	bikeDetail.tabSelect = function(e) {
		e.preventDefault();
		
		var button = $(this);
		var tNum = $(button).attr("idx");
		
		$("[name='viewFlg']").val("R");
		$("[name='tabNum']").val(tNum);
		
		$("#frm").attr({method : "post", action : "/moveBikeEditForm.do"}).submit();
		
	};
	
	
	</script>
</body>
</html>