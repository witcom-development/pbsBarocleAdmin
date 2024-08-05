<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.util.Calendar,  java.util.Date, java.text.SimpleDateFormat"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" /> 
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />
<meta name="description=" Content="" />
<%@ include file="../popup/pop_resource.jsp" %>
<%
     String toDate = new java.text.SimpleDateFormat("yyyy.MM.dd     HH:mm:ss").format(new java.util.Date());
%>
</head>
<body>
	<h1 class="popTtl">장애리스트 (자전거)</h1>
		<div id="body2">
					<div class="page">
						<!-- 모바일 검색조건 S-->
						<form id="searchFrm">
						<!--검색조건 E--><p style="margin-top: -20px;">
						<table>
						<tr>
							<td>
								<p class="tb_numlist" style="margin-right: 5px; font-size: 15px; margin-top: 30px;" ><%=toDate %></p>
							</td>
							<td>
							
							</td>
						</tr>
						</table>
						<p class="tb_numlist" style="margin-left: 500px; font-size: 15px; margin-top: -15px;" >총 ${ paginationInfo.getTotalRecordCount()} 건</p>
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
									<th>대여소 / 센터</th>
									<th>거치대 번호</th>
									<th>자전거 번호</th>
									<th>점검구분</th>
									<th>발생일시</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="bike" items="${InspectBikeList}" varStatus="loop">
	                                <tr>
	                                    <td>${bike.stationName}</td>
	                                    <td>${bike.stationEquipOrder}</td>
	                                    <td style="display: none;">${bike.repairCmptYn}</td>
	                                    <td style="display: none;">${bike.repairSeq}</td>
	                                    <td>${bike.bikeNo}</td>
	                                    <td style="display: none;">${bike.bikeId}</td>
	                                	<td style="display: none;">${bike.faultSeq}</td>
	                                    <td>${bike.bikeStatusName}</td>	
										<td>${bike.regDttm }</td>
	                                </tr>
                                </c:forEach>
                                <c:if test="${fn:length(InspectBikeList) eq 0 }">
	                                <table class="tb_type01 nbt0">
			                            <tr><td style="text-align:center"><spring:message code="search.nodata.msg" /></td></tr>
			                        </table>
								</c:if>
							</tbody>
						</table>
					<c:choose>
						<c:when test="${fn:length(InspectBikeList) > 0}">
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
				<!--content E-->
			</div>
	<script type="text/javascript" src="/js/common_barocle.js"></script>
    <script type="text/javascript">
    $(function() {
    	//inspectBikeList.initCombo();
		//inspectBikeList.initBtn();
		
		var date = new Date;
		date.setDate(date.getDate()-6);
		var fromday = DateUtil.dateFmt(date);
		var today = DateUtil.dateFmt(new Date());
		var sDate = '${searchCondition.searchBgnDe}' !== '' ? '${searchCondition.searchBgnDe}' : fromday;
		var eDate = '${searchCondition.searchEndDe}' !== '' ? '${searchCondition.searchEndDe}' : today;
		var searchVal 	 = '${searchCondition.searchVal}' !== '' ? '${searchCondition.searchVal}' : '';
		var stationGrpSeq = '${searchCondition.stationGrpSeq}' !== '' ? '${searchCondition.stationGrpSeq}' : '';
		var stationId = '${searchCondition.stationId}' !== '' ? '${searchCondition.stationId}' : '';
		var chkType = '${searchCondition.chkType}' !== '' ? '${searchCondition.chkType}' : 'state';
		
		$("[name='searchBgnDe']").val(sDate);
		$("[name='searchEndDe']").val(eDate);
		$("[name='searchVal']").val(searchVal);
		$("[name='stationGrpSeq']").val(stationGrpSeq);
		$("[name='stationId']").val(stationId);
		$("[name='chkType']:input[value='"+chkType+"']").prop('checked', true);
		
		var totalPageCount = '${paginationInfo.totalPageCount}' == '' ? 1 : Number('${paginationInfo.totalPageCount}');
   		$('#prevPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			inspectBikeList.pageSelect(currentPageNo-1);
		});
		$('#nextPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			inspectBikeList.pageSelect(currentPageNo+1);
		});
		$('#movePage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			var regExp = /^[1-9]?[0-9]/;
			if(!regExp.test(currentPageNo) ||(totalPageCount < currentPageNo)){
				alert('현재 페이지 값이 정상적이지 않습니다.');
			}else{
				inspectBikeList.pageSelect(currentPageNo);
			}
		});
	});
    
    var inspectBikeList = {};
    inspectBikeList.bikeStatusCd = '${searchCondition.bikeStatusCd}';
    inspectBikeList.bikeNo = '${searchCondition.bikeNo}';
    inspectBikeList.stationGrpSeq = '${searchCondition.stationGrpSeq}';
    inspectBikeList.stationId = '${searchCondition.stationId}';
    inspectBikeList.chkType = '${searchCondition.chkType}';
    
    inspectBikeList.initCombo = function(){
    	var _this = inspectBikeList;

    	//스테이션 
        commonAjax.getStationCode( 
	        function(data) {
	            if(data != null && data.stationList != null) {
	                commCdBox.makeComboBox('S',_this.stationGrpSeq,data.stationList, "stationGrpSlt");
	                $("#stationGrpSlt").trigger('change');
	            }
	        }
        );
    };
    
    inspectBikeList.pageSelect = function(pageNo) {
    	
    	$("[name='currentPageNo']").val(pageNo);
    	$("#searchFrm").attr({action :'/obstaclePopup.do', method : 'post'}).submit();
    	
    };

    </script>
	</div>
</body>
</html>