<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%
	Calendar cal = Calendar.getInstance();
	int minYear = 2010;
	int nowYear = cal.get(Calendar.YEAR);
	SimpleDateFormat sdf = new SimpleDateFormat("MM");
	String nowMonth = sdf.format(cal.getTime());
%>
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
						<form id="searchFrm">
							<div class="shBox">
								<fieldset>
									<legend>검색 옵션</legend>
									<div class="shBoxSection">
										<div class="section">
											<label for="adminType" class="laType02">관리구분</label>
											<select class="select-category02" name="adminType" id="adminType">
												<option value="">선택</option>
												<option value="ADM_001">운영 관리자</option>
												<option value="ADM_002">유인대여소 관리자</option>
												<option value="ADM_003">센터 관리자</option>
												<option value="ADM_004">유지보수 관리자</option>
												<option value="ADM_005">재배치 관리자</option>
											</select>
										</div>
										<div class="section pright">
											<label for="searchBgnDe" class="laType02">기간</label>
											<span>
												<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" id="searchBgnDe" name="searchBgnDe" readonly/></span>
												<span class="dash">~</span>
												<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" id="searchEndDe" name="searchEndDe" readonly/></span>
											</span>
										</div>
										<div class="section">
											<label for="searchName" class="laType02">이름</label>
											<input type="text" class="input-text07" id="searchName" name="searchName" />
											<button type="button" id="searchBtn" class="btn-srh03 btncase1"><img src="/images/searchIcon.gif" alt="검색" /></button>
										</div>
									</div>
								</fieldset>
							</div>
							<!--검색조건 E-->
							<p class="tb_numlist">총 ${ paginationInfo.getTotalRecordCount()} 건</p>
							<table class="tb_type01">
								<colgroup>
									<col style="width:25%"/>
									<col style="width:25%"/>
									<col style="width:25%"/>
									<col style="width:auto"/>
								</colgroup>
								<thead> 
									<tr>
										<th>그룹명</th>
										<th>이름명</th>
										<th>ID</th>
										<th>로그인 일시</th>
									</tr>
								</thead>
								<tbody>
								<c:forEach var="result" items="${dataList}" varStatus="status">
									   <tr>
										   <td>${result.adminGrpName}</td>
										   <td>${result.adminName}</td>
										   <td>${result.adminId}</td>
										   <td>${result.loginDttm }</td>
									   </tr>
								   </c:forEach>	
								   <c:if test="${fn:length(dataList) eq 0 }">
									<table class="tb_type01 nbt0">
										<tr><td style="text-align:center"><spring:message code="search.nodata.msg" /></td></tr>
									</table>
								</c:if>
								</tbody>
							</table>
					</div>
					<c:choose>
						<c:when test="${fn:length(dataList) > 0}">
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
						<div class="btnArea">
							<span class="right"><button type="button" id="excelBtn" class="btnType01">엑셀다운로드</button></span>
						</div>
					</div>
					<!--content E-->
				</div>
				<!--cont E-->
			</div>
			<!--body E-->
		</div>
		<!--allwrap E-->
	<!--footer S-->
	<tiles:insertAttribute name="footer" />
	<!--footer E-->
	
	<script type="text/javascript" src="/js/common_barocle.js"></script>
	<script type="text/javascript">
   	$(function() {
   		var _this = adminStatistics;
   		adminStatistics.initBtn();
   		
   		$('[name="searchBgnDe"]').val('${searchCondition.searchBgnDe}');
		$('[name="searchEndDe"]').val('${searchCondition.searchEndDe}');
		$('[name="adminType"]').val('${searchCondition.adminType}');
		$('[name="searchName"]').val('${searchCondition.searchName}');
		
		var totalPageCount = '${paginationInfo.totalPageCount}' == '' ? 1 : Number('${paginationInfo.totalPageCount}');
   		$('#prevPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			adminStatistics.pageSelect(currentPageNo-1);
		});
		$('#nextPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			adminStatistics.pageSelect(currentPageNo+1);
		});
		$('#movePage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			var regExp = /^[1-9]?[0-9]/;
			if(!regExp.test(currentPageNo) ||(totalPageCount < currentPageNo)){
				alert('현재 페이지 값이 정상적이지 않습니다.');
			}else{
				adminStatistics.pageSelect(currentPageNo);
			}
		});
   	});
   	
   	var adminStatistics = {};
   	adminStatistics.initBtn = function(){
		var _this = adminStatistics;
		$("#searchBtn").on("click", this.exeStatisticsFnc);
		$("#excelBtn").on("click", this.exeStatisticsExcelFnc);
	}
	
	adminStatistics.exeStatisticsFnc = function(e) {
		e.preventDefault();
		if(DateUtil.checkDateTerm( $( "[name='searchBgnDe']").val(),  $( "[name='searchEndDe']").val()) != 'ok') {
			alert('<spring:message code="fail.input.daterange"/>');
			return false;
		}

		if($("[name='searchBgnMt']").val() > $("[name='searchEndMt']").val()) {
			alert('<spring:message code="fail.input.daterange"/>');
			return false;
		}
		
		$("[name='currentPageNo']").val(1);
		$("#searchFrm").attr({method : 'post', action : '/admlogin/adminLoginStatistics.do'}).submit();
		fn_loading();
	};
	
	adminStatistics.exeStatisticsExcelFnc = function(e) {
		e.preventDefault();
		if(DateUtil.checkDateTerm( $( "[name='searchBgnDe']").val(),  $( "[name='searchEndDe']").val()) != 'ok') {
			alert('<spring:message code="fail.input.daterange"/>');
			return false;
		}

		if($("[name='searchBgnMt']").val() > $("[name='searchEndMt']").val()) {
			alert('<spring:message code="fail.input.daterange"/>');
			return false;
		}
		
		$("#searchFrm").attr({method : 'post', action : '/admlogin/adminLoginStatisticsExcel.do'}).submit();
	};
	
   	adminStatistics.pageSelect = function(pageNo) {
		$("[name='currentPageNo']").val(pageNo);
		$("#searchFrm").attr({action :'/admlogin/adminLoginStatistics.do', method : 'post'}).submit();
		fn_loading();
	};
	</script>
</body>
</html>