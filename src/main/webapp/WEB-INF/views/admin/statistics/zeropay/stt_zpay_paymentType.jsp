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
						<p class="pageTitle">결제수단별 현황</p>
						<span>통계 &gt; 제로페이 &gt; <em>결제수단별 현황</em></span>
					</div>
					<form id="searchFrm">
					<input type="hidden" name="totalPage" id="totalPage" value="${paginationInfo.totalPageCount}" >
					
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
										<div>
											<label for="bb22" class="laType02">기간</label>
											<p class="daymth1">
												<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" name="searchBgnDe" readonly/></span>
												<span class="dash">~</span>
												<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" name="searchEndDe" readonly/></span>
											</p>
										</div>
										<div class="section" style="margin-top: -25px; float: right;">
											<span style="position:absolute;">
												<input type="radio" value="A" id="chkDailyTicket" name="chkDailyTicket" checked="checked" style="width: 20px; height: 20px;"/>
												<span style=" vertical-align: top; font-size:14px;">전체&nbsp;&nbsp;</span>
												<input type="radio" value="D" id="chkDailyTicket" name="chkDailyTicket" style="width: 20px; height: 20px;"/>
												<span style=" vertical-align: top; font-size:14px;">일일권만&nbsp;&nbsp;</span>
												<input type="radio" value="S" id="chkDailyTicket" name="chkDailyTicket" style="width: 20px; height: 20px;"/>
												<span style=" vertical-align: top; font-size:14px;">정기권만</span>
											</span>
										</div>
										<div class="section" style="margin-top: -30px;">
											<button type="button" id="searchBtn" class="btn-srh03 btncase1"><img src="/images/searchIcon.gif" alt="검색" /></button>
										</div>
									</div>
								</fieldset>
							
							</div>
							 <div style="margin-top: 25px;">
								<p class="tb_numlist" style="margin-top: -10px">총 ${ paginationInfo.getTotalRecordCount()-1} 건</p>
								<div class="widscr mt5">
								<table class="tb_type03 tb_right" style="min-width:2000px">
									<colgroup>
										<col style="width:auto"/>
									</colgroup>
									<thead>
										<tr>
											<th rowspan="2">일자</th>
											<th width="50px" rowspan="2">요일</th>
											<th rowspan="2">총결제건</th>
											<th rowspan="2">총결제금액</th>
											<th colspan="4" style="color: #3232FF">제로페이</th>
											<th colspan="3">신용카드</th>
											<th colspan="3">휴대폰</th>
											<th colspan="3">카카오</th>
											<th colspan="3">페이코</th>
										</tr>
										<tr>
											<th style="color: #3232FF">결제금액</th>
											<th style="color: #3232FF">결제금액비율</th>
											<th style="color: #3232FF">결제건수</th>
											<th style="color: #3232FF">결제건수비율</th>
											<th>결제금액</th>
											<th>결제건수</th>
											<th>결제건수비율</th>
											<th>결제금액</th>
											<th>결제건수</th>
											<th>결제건수비율</th>
											<th>결제금액</th>
											<th>결제건수</th>
											<th>결제건수비율</th>
											<th>결제금액</th>
											<th>결제건수</th>
											<th>결제건수비율</th>
										</tr>
									</thead>
									<tbody>	
										<c:forEach var="result" items="${dataList}" varStatus="status">
			                                <tr>
			                                	<c:if test="${result.pmtDate eq '총계'}">
			                                		<td colspan="2" style="text-align: center;">${result.pmtDate}</td>
			                                	</c:if>
			                                	<c:if test="${result.pmtDate ne '총계'}">
			                                		<c:choose>
				                                		<c:when test="${result.pmtWeek eq '토' || result.pmtWeek eq '일'}">
			                                				<td style="text-align: center; color:red;">${result.pmtDate}</td>
				                                			<td style="text-align: center; color:red;">${result.pmtWeek}</td>
				                                		</c:when>
				                                		<c:otherwise>
				                                			<td style="text-align: center;">${result.pmtDate}</td>
				                                			<td style="text-align: center;">${result.pmtWeek}</td>
				                                		</c:otherwise>
			                                		</c:choose>
			                                	</c:if>
			                                	<td style="text-align: right;"><fmt:formatNumber value="${result.totPmtCnt}" pattern="#,###"/>&nbsp;&nbsp;</td>
			                                	<td style="text-align: right;"><fmt:formatNumber value="${result.totPmtPrice}" pattern="#,###"/>&nbsp;&nbsp;</td>
			                                	
			                                	<td style="text-align: right;"><fmt:formatNumber value="${result.zeropayPmt_price}" pattern="#,###"/>&nbsp;&nbsp;</td>
			                                	<td style="text-align: right;">${result.zeropayPmt_priceRatio}%&nbsp;&nbsp;</td>
			                                	<td style="text-align: right;"><fmt:formatNumber value="${result.zeropayPmt_cnt}" pattern="#,###"/>&nbsp;&nbsp;</td>
			                                	<td style="text-align: right; color:#0064FF;">${result.zeropayPmt_ratio}%&nbsp;&nbsp;</td>
			                                	
			                                	<td style="text-align: right;"><fmt:formatNumber value="${result.creditPmt_price}" pattern="#,###"/>&nbsp;&nbsp;</td>
			                                	<td style="text-align: right;"><fmt:formatNumber value="${result.creditPmt_cnt}" pattern="#,###"/>&nbsp;&nbsp;</td>
			                                	<td style="text-align: right;">${result.creditPmt_ratio}%&nbsp;&nbsp;</td>
			                                	
			                                	<td style="text-align: right;"><fmt:formatNumber value="${result.phonePmt_price}" pattern="#,###"/>&nbsp;&nbsp;</td>
			                                	<td style="text-align: right;"><fmt:formatNumber value="${result.phonePmt_cnt}" pattern="#,###"/>&nbsp;&nbsp;</td>
			                                	<td style="text-align: right;">${result.phonePmt_ratio}%&nbsp;&nbsp;</td>
			                                	
			                                	<td style="text-align: right;"><fmt:formatNumber value="${result.kakaoPmt_price}" pattern="#,###"/>&nbsp;&nbsp;</td>
			                                	<td style="text-align: right;"><fmt:formatNumber value="${result.kakaoPmt_cnt}" pattern="#,###"/>&nbsp;&nbsp;</td>
			                                	<td style="text-align: right;">${result.kakaoPmt_ratio}%&nbsp;&nbsp;</td>
			                                	
			                                	<td style="text-align: right;"><fmt:formatNumber value="${result.paycoPmt_price}" pattern="#,###"/>&nbsp;&nbsp;</td>
			                                	<td style="text-align: right;"><fmt:formatNumber value="${result.paycoPmt_cnt}" pattern="#,###"/>&nbsp;&nbsp;</td>
			                                	<td style="text-align: right;">${result.paycoPmt_ratio}%&nbsp;&nbsp;</td>
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
	     
	        $( "[name='searchBgnDe']").val(sDate);
	        $( "[name='searchEndDe']").val(eDate);
	        
	        var chkDailyTicket = '${searchCondition.chkDailyTicket}';
	   		if(chkDailyTicket == 'D'){
	   			$("input:radio[name='chkDailyTicket']:radio[value='D']").prop('checked', true);
	   			$(".pageTitle").text("결제수단별 현황(일일권)");
	   		} else if(chkDailyTicket == 'S'){
	   			$("input:radio[name='chkDailyTicket']:radio[value='S']").prop('checked', true);
	   			$(".pageTitle").text("결제수단별 현황(정기권)");
	   		}else{
	   			$(".pageTitle").text("결제수단별 현황");
	   		}
	    
	   	//next page
			$("#nextPage").click(function(){
				if($("#searchStartDate").val()  &&  $("#searchEndDate").val())
					if($("#searchStartDate").val() > $("#searchEndDate").val()){
						alert('<spring:message code="fail.input.daterange" />');
						return;
					}
					$("#currentPageNo").val(Number($("#currentPageNo").val())+1);
					fn_loading();
					$("#searchFrm").attr({method : 'post', action : '/zeropay/paymentTypeStatistics.do'}).submit();
			});
			
			//prev page
			$("#prevPage").click(function(){
				if($("#searchStartDate").val()  &&  $("#searchEndDate").val())
					if($("#searchStartDate").val() > $("#searchEndDate").val()){
						alert('<spring:message code="fail.input.daterange" />');
						return;
					}
					$("#currentPageNo").val(Number($("#currentPageNo").val())-1);
					fn_loading();
					$("#searchFrm").attr({method : 'post', action : '/zeropay/paymentTypeStatistics.do'}).submit();
			});
			
			$("#movePage").click(function(){
				if(Number($("#currentPageNo").val()) > $("#totalPage").val()){
					alert("현재 페이지 값이 정상적이지 않습니다.");
					return false;
				}
				fn_loading();
			});
			
			$("#searchBtn").on("click", function() {
		    	if(DateUtil.checkDateTerm( $( "[name='searchBgnDe']").val(),  $( "[name='searchEndDe']").val()) !== 'ok') {
		    		alert("검색 조건의 시작 날이 종료 날보다 큽니다.");
		    		$( "[name='searchBgnDe']").val('');
		    		$( "[name='searchEndDe']").val('');
		    		return false;
		    	}
		        $("[name='currentPageNo']").val("1");
		        fn_loading();
		        $("#searchFrm").attr({method : 'post', action : '/zeropay/paymentTypeStatistics.do'}).submit();
		    }); 
			 
			 
			$('#excelBtn').on("click", function(){
	   			if(DateUtil.checkDateTerm( $( "[name='searchBgnDe']").val(),  $( "[name='searchEndDe']").val()) != 'ok') {
	   	            alert('<spring:message code="fail.input.daterange"/>');
	   	            return false;
	   	        }
	   			
	   			if($("[name='searchBgnMt']").val() > $("[name='searchEndMt']").val()) {
	   	            alert('<spring:message code="fail.input.daterange"/>');
	   	            return false;
	   	        }
	    		$('#searchFrm').attr({method : 'post', action : '/zeropay/paymentTypeStatisticsExcel.do'}).submit();
	   		}); 
			
	   	});
    </script>
</body>
</html>