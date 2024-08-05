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
						<form id="searchFrm">
							<p class="tb_numlist">총 ${paginationInfo.getTotalRecordCount()} 건</p>
							<table class="tb_type01">
								<colgroup>
								<col style="width:20%"/>
								<col style="width:15%"/>
								<col style="width:20%"/>
								<col style="width:20%"/>
								<col style="width:20%"/>
								</colgroup>
								<thead>
								<tr>
									<th>정거장 명</th>
									<th>자전거 개수</th>
									<th>장애 자전거 개수</th>
									<th>사용유무</th>
									<th>비고</th>
								</tr>
								</thead>
								<tbody>
								<c:forEach var="result" items="${InspectStationList}" varStatus="status">
								<tr>
									<td style="display: none;">${result.stationId}</td>
									<td>${result.stationNm}</td>
									<td>${result.bikeCnt}</td>
									<td>${result.falutCnt}</td>
									<td>
										<c:choose>
	                                    <c:when test="${result.stationUseYn == 'Y'}">
	                                    	사용
	                                	</c:when>
	                                	<c:when test="${result.stationUseYn == 'N'}">
	                                    	미사용
	                                	</c:when>
	                                	<c:when test="${result.stationUseYn == 'T'}">
	                                    	임시미사용
	                                	</c:when>
	                                	<c:when test="${result.stationUseYn == 'C'}">
	                                    	폐쇄
	                                	</c:when>
	                                	</c:choose>
	                                </td>
	                                <td style="color:red;">장애 정거장</td>
								</tr>
								</c:forEach>
								<c:if test="${fn:length(InspectStationList) eq 0 }">
                                <table class="tb_type01 nbt0">
		                            <tr><td style="text-align:center"><spring:message code="search.nodata.msg" /></td></tr>
		                        </table>
                           		</c:if>
								</tbody>
							</table>
							
							<c:choose>
								<c:when test="${fn:length(InspectStationList) > 0}">
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
    	var inspectStationList={};
    $(function() {
		
    	
		var totalPageCount = '${paginationInfo.totalPageCount}' == '' ? 1 : Number('${paginationInfo.totalPageCount}');
   		$('#prevPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			inspectStationList.pageSelect(currentPageNo-1);
		});
		$('#nextPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			inspectStationList.pageSelect(currentPageNo+1);
		});
		$('#movePage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			var regExp = /^[1-9]?[0-9]/;
			if(!regExp.test(currentPageNo) ||(totalPageCount < currentPageNo)){
				alert('현재 페이지 값이 정상적이지 않습니다.');
			}else{
				inspectStationList.pageSelect(currentPageNo);
			}
		});
	});
    
    inspectStationList.pageSelect = function(pageNo) {
    	
    	$("[name='currentPageNo']").val(pageNo);
    	$("#searchFrm").attr({action :'/inspectStationList.do', method : 'post'}).submit();
    	
    };
    </script>
</body>
</html>