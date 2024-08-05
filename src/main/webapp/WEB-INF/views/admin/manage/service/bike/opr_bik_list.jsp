<%@page import="com.dkitec.barocle.base.IConstants"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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
						<form id="frm"></form>
						<form id="searchFrm"> 	
							<div class="shBox">
								<input type="hidden" name="viewFlg" value="" />
								<input type="hidden" name="bikeNo" value="" />
								<input type="hidden" name="chkType" value="" />
								<input type="hidden" name="bikeId" value="" />
								<input type="hidden" name="searchTypeName" value="" />
								<input type="hidden" name="bikeStatusName" value="" />
								<input type="hidden" name="rentSeq" value="" />
								
								<fieldset>
									<legend>검색 옵션</legend>
									<div class="shBoxSection">
										<div class="section">
											<label for="bb22" class="laType02">등록일</label>
											<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04"  name="searchBgnDe"  title="선택 날짜" id="bb22" readonly/></span>
											<span class="dash">~</span>
											<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04"  name="searchEndDe"  title="선택 날짜" readonly/></span>
										</div>
										<div class="section pright">
											
											<label for="a1" class="laType02">상태</label>
											
											<select class="select-category02" id="a1" name="bikeStatusCd">
<!--												<option value="">선택</option>  -->
												<c:if test="${ searchCondition.bikeStatusCd eq NULL || searchCondition.bikeStatusCd eq ''}">
													<option value="all" selected="selected">전체</option>
												</c:if>
												<c:if test="${ searchCondition.bikeStatusCd ne NULL && searchCondition.bikeStatusCd ne ''}">
													<option value="all">전체</option>
												</c:if>
											</select>
										</div>
										<div class="section">
											<label for="aa1" class="laType02">구분</label>
											<select  id="aa1"  name="searchType">
												<option value="">선택</option>
												<option value="B">자전거 번호</option>
												<option value="S">정거장명</option>
												<!-- <option value="C">센터명</option> -->
											</select>
											<span class="input-text12"><input type="text" class="" name="searchWord"/></span>
										</div>
										<div class="section pright">
											<label for="b2" class="laType02">자전거 구분</label>
											<select class="select-category08" id="a11" name="bikeSeCd">
												<option value="">선택</option>
											</select>
											<button type="button" id="searchBtn" class="btn-srh03 btncase1"><img src="/images/searchIcon.gif" alt="검색" ></button>
										</div>
										<!--  2019-10-16 추가 -->
										<%-- 
										<div class="section pright" id="lostYn_BKS_015"> 
											<label for="lostYn" class="laType02" >처리유형</label>
												
													강제반납 상태조회
													<select class="select-category02" name="lostYn" id="lostYn_BKS_015_DTL">
														<option value="">전체</option>
														<option value="0" <c:if test="${searchCondition.lostYn eq '0'}">selected="selected"</c:if>>미처리</option>
														<option value="1" <c:if test="${searchCondition.lostYn eq '1'}">selected="selected"</c:if>>재배치</option>
														<option value="2" <c:if test="${searchCondition.lostYn eq '2'}">selected="selected"</c:if>>회수후 재배치</option>
														<option value="3" <c:if test="${searchCondition.lostYn eq '3'}">selected="selected"</c:if>>센터입고</option>
														<option value="4" <c:if test="${searchCondition.lostYn eq '4'}">selected="selected"</c:if>>정상 대기중</option>
														<option value="6" <c:if test="${searchCondition.lostYn eq '6'}">selected="selected"</c:if>>대여중</option>
														<option value="5" <c:if test="${searchCondition.lostYn eq '5'}">selected="selected"</c:if>>자전거 없음</option>
														<option value="7" <c:if test="${searchCondition.lostYn eq '7'}">selected="selected"</c:if>>자동조치</option>
													</select>
										</div>
										 --%>
									</div>
								</fieldset>
						</div>
						<!--검색조건 E-->
						<p class="tb_numlist">총 ${ paginationInfo.getTotalRecordCount()} 건</p>
						<table class="tb_type01">
							<colgroup>
								
								<c:choose>

									<%-- 자전거이력 --%>
									<c:when test="${ searchCondition.bikeStatusCd eq 'BKS_013'}">	
										<col style="width:15%"/>
										<col style="width:10%"/>
										<col style="width:10%"/>
										<col style="width:15%"/>
										<col style="width:15%"/>
										<col style="width:10%"/>
										<col style="width:10%"/>
										<col style="width:10%"/>
									</c:when>


									<%-- 강제 분실 --%>
									<c:when test="${ searchCondition.bikeStatusCd eq 'BKS_014'}">	
										<col style="width:15%"/>
										<col style="width:10%"/>
										<col style="width:10%"/>
										<col style="width:15%"/>
										<col style="width:15%"/>
										<col style="width:10%"/>
										<col style="width:10%"/>
									</c:when>
	
									<%-- 분실 --%>
									<c:when test="${ searchCondition.bikeStatusCd eq 'BKS_007'}">	
										<col style="width:15%"/>
										<col style="width:25%"/>
										<col style="width:10%"/>
										<col style="width:10%"/>
										<col style="width:15%"/>
										<col style="width:10%"/>
									</c:when>

									<%-- 강제반납 상태조회 --%>
									<c:when test="${ searchCondition.bikeStatusCd eq 'BKS_015'}">
										<col style="width:5%"/>
										<col style="width:5%"/>
										<col style="width:5%"/>
										<col style="width:5%"/>											
										<col style="width:5%"/>											
										<col style="width:5%"/>											
										<col style="width:5%"/>											
										<col style="width:5%"/>											
										<col style="width:5%"/>											
										<col style="width:5%"/>											
									</c:when>   

									<%-- 수리중 --%>
									<c:when test="${ searchCondition.bikeStatusCd eq 'BKS_005'}">
										<col style="width:15%"/>
										<col style="width:20%"/>
										<col style="width:25%"/>
										<col style="width:10%"/>
									</c:when>

									<%-- 도난추정 --%>
									<%-- <c:when test="${ searchCondition.bikeStatusCd eq 'BKS_016'}">
										자전거번호
										<col style="width:15%"/>
										지역구
										<col style="width:10%"/>
										반납정거장명
										<col style="width:25%"/>

										<col style="width:25%"/>
										<col style="width:10%"/>
										<col style="width:18%"/>
										<col style="width:18%"/>
										<col style="width:18%"/>
										<col style="width:10%"/>
									</c:when> --%>
									
									<c:otherwise>	
										<col style="width:15%"/>
										<col style="width:auto"/>
										<col style="width:13%"/>
										<col style="width:13%"/>
										<col style="width:13%"/>
										<col style="width:13%"  class="mhid"/>
									</c:otherwise>

								</c:choose>
							</colgroup>
							<thead>
								<tr>
									<c:choose>

										<%-- 자전거이력 --%>
										<c:when test="${ searchCondition.bikeStatusCd eq 'BKS_013'}">	
											<th>자전거번호</th>
											<th>상태</th>
											<th>현재상태</th>
											<th>등록일시</th>
											<th>회수담당자</th>
											<th>회수일자</th>
											<th>상세내용</th>
											<th>상세내용</th>
										</c:when> 


										<%-- 분실 상세 --%>
										<c:when test="${ searchCondition.bikeStatusCd eq 'BKS_014'}">	
											<th>자전거번호</th>
											<th>이전상태</th>
											<th>현재상태</th>
											<th>등록일시</th>
											<th>회수담당자</th>
											<th>회수일자</th>
											<th>상세내용</th>
										</c:when>   

										<%-- 분실 --%>
										<c:when test="${ searchCondition.bikeStatusCd eq 'BKS_007'}">	
											<th>자전거번호</th>
											<th>접수일자</th>
											<th>상태</th>
											<th>등록자</th>
											<th>분실일자</th>
											<th>경과일자</th>
										</c:when>	

										<%-- 강반상태조회 --%>
										<c:when test="${ searchCondition.bikeStatusCd eq 'BKS_015'}">
											<th>자전거번호</th>
											<th>구분</th>
											<th>자전거현재상태</th>
											<th>미반납사유</th>
											<th>현장조치여부</th>
											<th>등록자</th>
											<th>등록일시</th>
											<th>처리자</th>
											<th>처리일시</th>
											<th>처리센터</th>
										</c:when>
		
										<%-- 수리중 --%>
										<c:when test="${ searchCondition.bikeStatusCd eq 'BKS_005'}">
											<th>자전거번호</th>
											<th>수리등록일자</th>
											<th>센터</th>
											<th>경과일자</th>
										</c:when>		

										<%-- 도난추정 --%>
									   <%--  <c:when test="${ searchCondition.bikeStatusCd eq 'BKS_016'}">
											<th>자전거</br>번호</th>
											<th>지역구</th>
											<th>반납정거장명</th>
											<th>반납일시</th>
											
											<th>강반</th>

											<th>최종신호</th>
											<th>상태정보</br>미전송일시</th>
											<th>등록일자</th>
											<th>경과</br>일자</th>
										</c:when>	--%>

										<c:otherwise>	 
											<th>자전거번호</th>
											<th>정거장</th>
											<th>배터리상태</th>
											<th>상태</th>
											<th>납품처</th>
											<th class="mhid">등록일</th>
										</c:otherwise>  
									</c:choose>
									
								</tr>
							</thead>
							<c:if test="${fn:length(BikeList) > 0 }">
							<tbody>
								<c:forEach var="bike" items="${BikeList}" varStatus="loop">
									<tr>
											<td class="pl10"><a href="#" id="${bike.bikeId}" target="_blank">${bike.bikeNo}</a></td>
											<c:set var="bikeNoVar" value="${fn:substring(bike.bikeNo, 4, 5)}"/>
										<c:choose>
										
											<%-- 자전거이력 --%>
											<c:when test="${ searchCondition.bikeStatusCd eq 'BKS_013'}">	
												<td class="pl10">${bike.bikeStatusCd }</td>
												<td class="pl10">${bike.bikeStatusName}</td>
												<td class="pl10">${bike.adminId}</td>
												<td class="pl10">${bike.locateStrDttm}</td>
												<c:if test="${bikeNoVar < 3}"><td class="pl10">${bike.batteryStusCd}</td></c:if>
												<c:if test="${bikeNoVar >= 3}"><td class="pl10">${bike.useCnt}</td></c:if>
												<td class="pl10">${bike.isParking}</td>
												<td class="pl10">${bike.isParking}</td>
											</c:when>										
										
										
											<%-- 강반 분실 --%>
											<c:when test="${ searchCondition.bikeStatusCd eq 'BKS_014'}">	
												<td class="pl10">${bike.bikeStatusCd }</td>
												<td class="pl10">${bike.bikeStatusName}</td>
												<td class="pl10">${bike.regDttm}</td>
												<td class="pl10">${bike.adminId}</td>
												<td class="pl10">${bike.modDttm}</td>
												 <c:if test="${bikeNoVar < 3}"><td class="pl10">${bike.batteryStusCd}</td></c:if>
												<c:if test="${bikeNoVar >= 3}"><td class="pl10">${bike.useCnt}</td></c:if>
											</c:when>

											<%-- 분실 --%>
											<c:when test="${ searchCondition.bikeStatusCd eq 'BKS_007'}">	
												<td class="pl10">${bike.modDttm }</td>
												<td class="pl10">${bike.bikeStatusName}</td>
												<td class="pl10">${bike.entrpsCdNm}</td>
												<td class="pl10">${bike.lostDate}</td>
												<td class="pl10">${bike.locateStrDttm}</td>
											</c:when>

											<%-- 강반상태조회 --%>
											<c:when test="${ searchCondition.bikeStatusCd eq 'BKS_015'}">
												<td class="pl10">${bike.bikeStatusCd }</td>
												<td class="pl10">${bike.bikeStatusName }</td>
												<td class="pl10">${bike.lostRegId }</td>
												<td class="pl10">${bike.entrpsCd }</td>
												<td class="pl10">${bike.adminId }</td>
												<td class="pl10">${bike.regDttm }</td>
												<td class="pl10">${bike.entrpsCdNm }</td>
												<td class="pl10">${bike.modDttm }</td>
												<td class="pl10">${bike.centerId }</td>
											</c:when>

											<%-- 수리중 --%>   
											<c:when test="${ searchCondition.bikeStatusCd eq 'BKS_005'}">	
												<td class="pl10">${bike.modDttm }</td>
												<td class="pl10">${bike.stationName}</td>
												<td class="pl10">${bike.locateStrDttm}</td>
											</c:when>

											<%-- 도난추정 --%>
										   <%--  <c:when test="${ searchCondition.bikeStatusCd eq 'BKS_016'}">
												지역구
													<td class="pl10">${bike.centerId}</td>
												반납정거장명
													<td class="pl10">${bike.stationName}</td>
												반납일시
												<td class="pl10">
													${fn:substring(bike.lostDate, 0, 10)}</br>
													${fn:substring(bike.lostDate, 11,19)}
												</td>		
												강제반납
												<td class="pl10">${bike.bikeStatusName}</td>
												최종신호
												<td class="pl10">
													${fn:substring(bike.entrpsCd, 0, 10)}</br>
													${fn:substring(bike.entrpsCd, 11,19)}
												</td>
												상태정보미전송일시
												<td class="pl10">
													${fn:substring(bike.entrpsCdNm, 0, 10)}</br>
													${fn:substring(bike.entrpsCdNm, 11,19)}
												</td>
												등록일자
												<td class="pl10">
													${fn:substring(bike.regDttm, 0, 10)}</br>
													${fn:substring(bike.regDttm, 11,19)}	
												</td>
												경과일자
												<td class="pl10">${bike.locateStrDttm}</td>
											</c:when>	 --%>										 

											<c:otherwise>	 
												<td class="title pl10">${bike.stationName}</td>
												 <c:if test="${bikeNoVar < 3}"><td class="pl10">${bike.batteryStusCd}</td></c:if>
												<c:if test="${bikeNoVar >= 3}"><td class="pl10">${bike.useCnt}</td></c:if>
												
												<td class="pl10">												 
												 <c:choose>
												 <c:when test="${bike.bikeStatusName eq '대여중'}">
												 <span style="cursor:pointer;" onclick="op_rent('${bike.rentSeq}');">${bike.bikeStatusName}<span style="position: relative; display: block; left: -8px; width: 100vw;">${bike.rentClsCdName}&nbsp;${bike.elapseTime}분</span></span>
											   	 </c:when>
											   	 <c:otherwise>
											   	 ${bike.bikeStatusName}
											   	 </c:otherwise>
											   	 </c:choose>
											   
												 </td>
												<td class="pl10">${bike.entrpsCdNm}</td>
												<td class="tc mhid">${bike.regDttm }</td>
											</c:otherwise>  

										</c:choose>	
											
									</tr>
								</c:forEach>
							</tbody>
							</c:if>
						</table>
						<c:if test="${fn:length(BikeList) == 0 }">
						<table class="tb_type01 nbt0">
							<tr><td style="text-align:center"><spring:message code="search.nodata.msg" /></td></tr>
						</table>
						</c:if>
					<c:choose>
						<c:when test="${fn:length(BikeList) > 0}">
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
						<div class="btnArea tr">
							<button class="btnType01 mb10 mhid" id="excelViewBtn" title="엑셀다운로드">엑셀다운로드</button>
							<a href="<c:out value='/common/pop/DEV_001/openUploadPop.do'/>" id="bulkUploadBtn" class="winNewPop btnType01 mb10 mhid" title="엑셀파일업로드" data-width="450" data-height="355" data-pmt="">엑셀업로드</a>
							<button class="btnType01 bc_green mb10" id="moveBikeEditForm">등록</button>
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
	$(function() {

		 //initialize
		bikeList.commonCode();
		bikeList.initBtn();
		var sDate = '${searchCondition.searchBgnDe}' !== '' ? '${searchCondition.searchBgnDe}' : "";
		var eDate = '${searchCondition.searchEndDe}' !== '' ? '${searchCondition.searchEndDe}' : "";
	 
		$( "[name='searchBgnDe']").val(sDate);
		$( "[name='searchEndDe']").val(eDate);

		// 2019-10-16 
		switch('${searchCondition.bikeStatusCd}'){
				case "BKS_015" :
				$("#lostYn_BKS_015").css("visibility","visible");
				break;

				default :
				$("#lostYn_BKS_015").css("visibility","hidden");
		}

		var totalPageCount = '${paginationInfo.totalPageCount}' == '' ? 1 : Number('${paginationInfo.totalPageCount}');
   		$('#prevPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			bikeList.pageSelect(currentPageNo-1);
		});
		$('#nextPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			bikeList.pageSelect(currentPageNo+1);
		});
		$('#movePage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			var regExp = /^[1-9]?[0-9]/;
			if(!regExp.test(currentPageNo) ||(totalPageCount < currentPageNo)){
				alert('현재 페이지 값이 정상적이지 않습니다.');
			}else{
				bikeList.pageSelect(currentPageNo);
			}
		});
		
	});

	
	//20201106 solbit add
	function op_rent(f1) {
		
		 $( "[name='rentSeq']").val(f1);
		 $("#searchFrm").attr({target: '_blank'});
		 $("#searchFrm").attr({method : 'post', action : '/moveRentStatusInfo.do'}).submit();
	}
	
	var bikeList = {};
	bikeList.bikeStatusCd = '${searchCondition.bikeStatusCd}';
	bikeList.searchType = '${searchCondition.searchType}';
	bikeList.searchWord = '${searchCondition.searchWord}';
	bikeList.bikeSeCd = '${searchCondition.bikeSeCd}';
	bikeList.commonCode = function() {
		var _this = bikeList;
		 //상태코드
		commonAjax.getCommonCode("BKS", function(data) {
			 if(data !== null && data.codeList !== null) {
				// 2019-10-16 출고를 강제로 강제반납관리 상태조회로 변경
					data.codeList[12].comCdName ="자전거 이력조회";
					data.codeList[13].comCdName ="분실후속조치";
					//data.codeList[14].comCdName ="강제반납관리 상태";

				commCdBox.makeComboBox('CC',_this.bikeStatusCd, data.codeList, "a1");
			 }
		}); 
		
	  //자전거 구분
		commonAjax.getCommonCode("BIK", function(data) {
			 if(data !== null && data.codeList !== null) {
				 commCdBox.makeComboBox('CC',_this.bikeSeCd, data.codeList, "a11");
			 }
		}); 
		 
		 $("#aa1").val(_this.searchType);
		 $("[name='searchWord']").val(_this.searchWord);
		 //$("[name='rglChkSearch']").val("${searchCondition.rglChkSearch}");
	};

	bikeList.initBtn = function () {
		
		$("#aa1").on("change", function(e){
			if($("#aa1").val() !== "") {
				$("[name='searchWord']").val('');
			}
		});

		// 자전거 상태에 따른 조회조건 변경
		$("[name='bikeStatusCd']").on("change", function(e){
			
			switch($("[name='bikeStatusCd']").val()){
				case "BKS_015" :
				$("#lostYn_BKS_015").css("visibility","visible");
				break;

				default :
				$("#lostYn_BKS_015").css("visibility","hidden");
			}
				// $("#lostYn_BKS_015_DTL").val('');
			
		});

		

		// 2019-10-16 추가 포커스 갈때 우선 자전거 번호로
		$("[name='searchWord']").focus(function(){
			if ( $("#aa1").val() == null ||  $("#aa1").val() == "" ){
				$("#aa1").val("B");
			}
		});

		// 2019-10-16 추가 포커스 OUT일 때 우선 자전거 번호로
		$("[name='searchWord']").blur(function(){
			if ( $("[name='searchWord']").val() == null ||  $("[name='searchWord']").val() == "" ){
				$("#aa1").val("");
			}
		});
		 

		$(".tb_type01 > tbody > tr").on("click", "a",{ viewFlg : 'U'},  this.moveEditForm);
		$("#moveBikeEditForm").on("click",{ viewFlg : 'C'}, this.moveEditForm);
		$("#excelViewBtn").on("click",{listType : "excel"},this.exeListFnc);
		$("#searchBtn").on("click",{listType: "list"},this.exeListFnc);

		
	};
	
	bikeList.exeListFnc = function(e) {
		e.preventDefault();
		e.stopPropagation();
		
		var listType = e.data.listType;
		
		if(DateUtil.checkDateTerm( $( "[name='searchBgnDe']").val(),  $( "[name='searchEndDe']").val()) !== 'ok') {
			$( "[name='searchBgnDe']").val('searchBgnDe');
			$( "[name='searchEndDe']").val('searchBgnDe');
			alert("검색 조건의 시작 날이 종료 날보다 큽니다.");
			return false;
		}
		
		// 자전거 이력조회는 5일 미만으로
		if (   $( "[name='bikeStatusCd']").val() == "BKS_013"  && (	   DateUtil.diffDays(  $( "[name='searchBgnDe']").val() ,  $( "[name='searchEndDe']").val() , "-" ) > 4)) {
			alert("조회 기간은 3일 미만으로 변경 부탁드립니다.");
			return;
		};
		

		if (   $( "[name='bikeStatusCd']").val() == "BKS_013" &&  $( "[name='searchType']").val() == "") {
			alert("자전거 번호입력부탁드립니다..");
			return;
		}
		
		if (   listType == "list" &&  $( "[name='bikeStatusCd']").val() == "BKS_013" ) {
			alert("바로 엑셀 다운로드로 바로 누르시기 바랍니다.");
			return;
		}		
		
		if (   $( "[name='bikeStatusCd']").val() == "BKS_013") {
			alert("조회가 오래 걸립니다. 조회 될때까지 기다려 주시기 바랍니다.");
		}
		
		if($("#aa1").val() !== '' && $("[name='searchWord']").val() === '') {
			alert("선택한 항목의 키워드를 입력해 주세요.");
			return false;
		}
		$("[name='currentPageNo']").val(1);
		if(listType === 'excel') {
			$("[name='bikeStatusName']").val($("#a1 option:selected").text());
			$("[name='searchTypeName']").val($("#aa1 option:selected").text());
		} 
		$("[name='viewFlg']").val(listType);
		
		//자전거 번호 입력시 상태검색 전체
		/* if($("[name='searchWord']").val()!=''){
			$("[name='bikeStatusCd']").val('all');
		} */
		
		$("#searchFrm").attr({method : 'post', action : '/getBikeList.do'}).submit();
		
	};
	
	bikeList.pageSelect = function(pageNo) {
		
		$("[name='currentPageNo']").val(pageNo);
		$("[name='viewFlg']").val('list');
		$("#searchFrm").attr({action :'/getBikeList.do', method : 'post'}).submit();
	};

	bikeList.moveEditForm = function (e) {
		e.preventDefault();
		var pViewFlg = e.data.viewFlg;
		if(pViewFlg === 'U') {
			$("[name='bikeNo']").val($(this).text());
			$("[name='bikeId']").val(e.target.id);
			$("[name='currentPageNo']").val(1);
			$("[name='searchBgnDe']").val("");
			$("[name='searchEndDe']").val("");
		}
		$("[name='viewFlg']").val(pViewFlg);
		$("#searchFrm").attr({method : 'post', action : '/moveBikeEditForm.do'}).submit();
	};
	 
	</script>
</body>
</html>