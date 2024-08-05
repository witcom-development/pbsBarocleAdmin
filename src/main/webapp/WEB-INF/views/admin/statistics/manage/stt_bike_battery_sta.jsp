<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
					<tiles:insertAttribute name="left" />
				<!--left menu E-->
				<!--content S-->
				<div class="content">
					<div class="subject">
						<p class="pageTitle">자전거 배터리 정보</p>
						<span>통계 &gt; <em>자전거 배터리 정보</em></span>
					</div>
					<form id="searchFrm">
					<input type="hidden" name="totalPage" id="totalPage" value="${paginationInfo.totalPageCount}" >
					<input type="hidden" name="ArrDaySize" id="ArrDaySize" value="${ArrDaySize }" >
					<%-- <input type="hidden" name="bikeNo" id="bikeNo" value="${searchCondition.bikeNo }" > --%>
					
					
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
							<div class="shBox">
								<input type="hidden" name="dateType" />
								<input type="hidden" name="searchBgnMt" />
								<input type="hidden" name="searchEndMt" />
								<fieldset>
									<legend>검색 옵션</legend>
									<div class="shBoxSection">
										<div class="section ">
											<label for="bb22" class="laType02">등록일</label>
											<p class="daymth1">
												<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" name="searchBgnDe" readonly/></span>
												<span class="dash">~</span>
												<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" name="searchEndDe" readonly/></span>
											</p>
										</div>
										<div class="section pright">
											<label for="aa1" class="laType02">자전거번호</label>
											<span class="input-text07"><input type="text" name="bikeNo" class=""/></span>
											
											<button type="button" id="searchBtn" class="btn-srh03 btncase1"><img src="/images/searchIcon.gif" alt="검색" /></button>
										</div>
									</div>
								</fieldset>
							
							</div>
							<div style="margin-top: 25px;">
							<p class="tb_numlist">총 ${ paginationInfo.getTotalRecordCount()} 건</p>
							<div style=width:100%;height:100%;overflow:auto>
								<table class="tb_type01 tb_right" style="width:100%">
									<colgroup>
										<c:forEach var="result" items="${ArrDay}" varStatus="status">
										<col style="width:100px"/>
										</c:forEach>
									</colgroup>
									<thead> 
										<tr>
											<c:forEach var="result" items="${ArrDay}" varStatus="status">
												<c:if test="${result == 'BIKE_ID'}">
													<th>자전거 번호</th>
												</c:if>
												<c:if test="${result != 'BIKE_ID'}">
													<th>${fn:substring(result,2,11)}</th>
												</c:if>	
											</c:forEach>
										</tr>
									</thead>
									<tbody>
										<c:if test="${!empty returnList1}">
											<tr>
												<c:forEach var="result1" items="${returnList1}" varStatus="status">
													<td>${result1}</td>
												</c:forEach>
											</tr>
										</c:if>
										<c:if test="${!empty returnList2}">
											<tr>
												<c:forEach var="result2" items="${returnList2}" varStatus="status">
													<td>${result2}</td>
												</c:forEach>
											</tr>
										</c:if>
										<c:if test="${!empty returnList3}">
											<tr>
												<c:forEach var="result3" items="${returnList3}" varStatus="status">
													<td>${result3}</td>
												</c:forEach>
											</tr>
										</c:if>
										<c:if test="${!empty returnList4}">
											<tr>
												<c:forEach var="result4" items="${returnList4}" varStatus="status">
													<td>${result4}</td>
												</c:forEach>
											</tr>
										</c:if>
										<c:if test="${!empty returnList5}">
											<tr>
												<c:forEach var="result5" items="${returnList5}" varStatus="status">
													<td>${result5}</td>
												</c:forEach>
											</tr>
										</c:if>
									</tbody>
								</table>
							</div>	
							<c:choose>
								<c:when test="${fn:length(ArrDay) > 0}">
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
							<span><input name="currentPageNo" id="currentPageNo" type="number" value="${paginationInfo.currentPageNo}"/><em>/ ${paginationInfo.totalPageCount}</em><button id="movePage">이동</button></span>
							<c:choose>
							<c:when test="${paginationInfo.currentPageNo < paginationInfo.totalPageCount}">
							<a id="nextPage" href="#"><img src="/images/p_next.gif" alt="다음 페이지" /></a>
							</c:when>
							<c:otherwise>
								<a href="#"><img src="/images/p_next.gif" alt="다음 페이지" /></a>
							</c:otherwise>
							</c:choose>
						</div>	
						<!--검색조건 E-->
					</div>
					</form>
					
					<div class="btnArea">
						<span class="right"><button type="button" id="excelBtn" class="btnType01">엑셀다운로드</button></span>
					</div>
						
				</div>
				<!--content E-->
			</div>
		</div>
		
	</div>
	<!--footer S-->
			<tiles:insertAttribute name="footer" />
		<!--footer E-->
	<script type="text/javascript" src="/js/common_barocle.js"></script>
    <script type="text/javascript">
	   	$(function() {
	   		
    	var sDate = '${searchCondition.searchBgnDe}' !== '' ? '${searchCondition.searchBgnDe}' : "";
    	var eDate = '${searchCondition.searchEndDe}' !== '' ? '${searchCondition.searchEndDe}' : "";
    	
    	var bikeNo 	 = '${searchCondition.bikeNo}' !== '' ? '${searchCondition.bikeNo}' : '';
    	
    	//alert($("#bikeNo").val());
     
    	$( "[name='bikeNo']").val(bikeNo);
    	
        $( "[name='searchBgnDe']").val(sDate);
        $( "[name='searchEndDe']").val(eDate);

	   	//next page
			$("#nextPage").click(function(){
				if($("#searchStartDate").val()  &&  $("#searchEndDate").val())
					if($("#searchStartDate").val() > $("#searchEndDate").val()){
						alert('<spring:message code="fail.input.daterange" />');
						return;
					}
					$("#currentPageNo").val(Number($("#currentPageNo").val())+1);
					
					$("#searchFrm").attr({method : 'post', action : '/manage/bikeBatterySta.do'}).submit();
			});
			
			//prev page
			$("#prevPage").click(function(){
				if($("#searchStartDate").val()  &&  $("#searchEndDate").val())
					if($("#searchStartDate").val() > $("#searchEndDate").val()){
						alert('<spring:message code="fail.input.daterange" />');
						return;
					}
					$("#currentPageNo").val(Number($("#currentPageNo").val())-1);
					
					$("#searchFrm").attr({method : 'post', action : '/manage/bikeBatterySta.do'}).submit();
			});
			
			$("#movePage").click(function(){
				if(Number($("#currentPageNo").val()) > $("#totalPage").val()){
					alert("현재 페이지 값이 정상적이지 않습니다.");
					return false;
				}
			});
			
			$("#excelBtn").on("click", function() {

	            $("#searchFrm").attr({method : 'post', action : '/manage/bikeBatteryStaExcel.do'}).submit();
			});
			
			$("#searchBtn").on("click", function() {

	       	    $("[name='currentPageNo']").val("1");
	            $("#searchFrm").attr({method : 'post', action : '/manage/bikeBatterySta.do'}).submit();
	            
	            fn_loading();
	       	   
	       	    $('.tb_right > thead > tr > th ').remove();
	       	    $('.tb_right > tbody > tr > td ').remove();
	       	    var BIKE_ID = "BIKE_ID";
	
	           	var t = $('.tb_right > thead > tr');
	                t.append('<c:forEach var="result" items="${ArrDay}" varStatus="status">');
	                t.append('	<c:if test="${result == 'BIKE_ID'}">');
	                t.append('		<th>자전거 번호</th>');
	                t.append('	</c:if>'); 
	                t.append('	<c:if test="${result != 'BIKE_ID'}">');
	                t.append('		<th>${fn:substring(result,2,11)}</th>');
	                t.append('	</c:if>');
	                t.append('</c:forEach>');
                var t2 = $('.tb_right > tbody ');
	                t2.append('<c:if test="${!empty returnList1}">');
	                t2.append('	<tr>');
		   	        t2.append('		<c:forEach var="result1" items="${returnList1}" varStatus="status">');
		   	        t2.append('			<td>${result1}</td>');
		   	        t2.append('		</c:forEach>');
		   	        t2.append('	</tr>');
		   	        t2.append('</c:if>');
		   	        t2.append('<c:if test="${!empty returnList2}">');
		   	        t2.append('	<tr>');
		   	        t2.append('		<c:forEach var="result2" items="${returnList2}" varStatus="status">');
		   	        t2.append('			<td>${result2}</td>');
		   	        t2.append('		</c:forEach>');
		   	        t2.append('	</tr>');
		   	        t2.append('</c:if>');
		   	        t2.append('<c:if test="${!empty returnList3}">');
		   	        t2.append('	<tr>');
		   	        t2.append('		<c:forEach var="result3" items="${returnList3}" varStatus="status">');
		   	        t2.append('			<td>${result3}</td>');
		   	        t2.append('		</c:forEach>');
		   	        t2.append('	</tr>');
		   	        t2.append('</c:if>');
		   	        t2.append('<c:if test="${!empty returnList4}">');
		   	        t2.append('	<tr>');
		   	        t2.append('		<c:forEach var="result4" items="${returnList4}" varStatus="status">');
		   	        t2.append('			<td>${result4}</td>');
		   	        t2.append('		</c:forEach>');
		   	        t2.append('	</tr>');
		   	        t2.append('</c:if>');
		   	        t2.append('<c:if test="${!empty returnList5}">');
		   	        t2.append('	<tr>');
		   	        t2.append('		<c:forEach var="result5" items="${returnList5}" varStatus="status">');
		   	        t2.append('			<td>${result5}</td>');
		   	        t2.append('		</c:forEach>');
		   	        t2.append('	</tr>');
		   	        t2.append('</c:if>');
                var t3 = $('.tb_right > colgroup');
	                t3.append('<c:forEach var="result" items="${ArrDay}" varStatus="status">');
	                t3.append('		<col style="width:100px"/>');
	                t3.append('</c:forEach>');
		    });
			
	   	});
    </script>
</body>
</html>