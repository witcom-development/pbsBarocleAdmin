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
						<p class="pageTitle">일일권 결제 현황</p>
						<span>통계 &gt; 제로페이 &gt; <em>일일권 결제 현황</em></span>
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
												<input type="checkbox" value="Y" id="chkTicket" name="chkTicket" style="width: 20px; height: 20px;"/>
												<span style=" vertical-align: top; font-size:14px;">제로페이 제외</span>
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
								<table class="tb_type03 tb_right" style="min-width:1500px">
									<colgroup>
										<col style="width:auto"/>
									</colgroup>
									<thead>
										<tr>
											<th rowspan="2">일자</th>
											<th rowspan="2">총결제건</th>
											<th rowspan="2">총결제금액</th>
											<th colspan="2">회원1시간</th>
											<th colspan="2">회원2시간</th>
											<th colspan="2">비회원1시간</th>
											<th colspan="2">비회원2시간</th>
										<c:if test="${searchCondition.chkTicket eq 'Y'}">
											<th colspan="2">외국인종일권</th>
										</c:if>
										</tr>	
									
									
										<tr>
											<th>결제건수</th>
											<th>결제금액</th>
											<th>결제건수</th>
											<th>결제금액</th>
											<th>결제건수</th>
											<th>결제금액</th>
											<th>결제건수</th>
											<th>결제금액</th>
										<c:if test="${searchCondition.chkTicket eq 'Y'}">
											<th>결제건수</th>
											<th>결제금액</th>
										</c:if>
										</tr>
									</thead>
									<tbody>	
										<c:forEach var="result" items="${dataList}" varStatus="status">
			                                <tr>
			                                	<td style="text-align: center;">${result.ticketDate}</td>
			                                	
			                                	<td style="text-align: right;"><fmt:formatNumber value="${result.ticketCnt}" pattern="#,###"/>&nbsp;&nbsp;</td> 
			                                	<td style="text-align: right;"><fmt:formatNumber value="${result.totPmtPrice}" pattern="#,###"/>&nbsp;&nbsp;</td> 
			                                	<td style="text-align: right;"><fmt:formatNumber value="${result.member_1h}" pattern="#,###"/>&nbsp;&nbsp;</td> 
			                                	<td style="text-align: right;"><fmt:formatNumber value="${result.memberPmt_1h}" pattern="#,###"/>&nbsp;&nbsp;</td> 
			                                	<td style="text-align: right;"><fmt:formatNumber value="${result.member_2h}" pattern="#,###"/>&nbsp;&nbsp;</td> 
			                                	<td style="text-align: right;"><fmt:formatNumber value="${result.memberPmt_2h}" pattern="#,###"/>&nbsp;&nbsp;</td> 
			                                	<td style="text-align: right;"><fmt:formatNumber value="${result.nonMember_1h}" pattern="#,###"/>&nbsp;&nbsp;</td> 
			                                	<td style="text-align: right;"><fmt:formatNumber value="${result.nonMemberPmt_1h}" pattern="#,###"/>&nbsp;&nbsp;</td> 
			                                	<td style="text-align: right;"><fmt:formatNumber value="${result.nonMember_2h}" pattern="#,###"/>&nbsp;&nbsp;</td> 
			                                	<td style="text-align: right;"><fmt:formatNumber value="${result.nonMemberPmt_2h}" pattern="#,###"/>&nbsp;&nbsp;</td> 
			                                <c:if test="${searchCondition.chkTicket eq 'Y'}">
			                                	<td style="text-align: right;"><fmt:formatNumber value="${result.foreigner_24h}" pattern="#,###"/>&nbsp;&nbsp;</td>
			                                	<td style="text-align: right;"><fmt:formatNumber value="${result.foreignerPmt_24h}" pattern="#,###"/>&nbsp;&nbsp;</td>
			                                </c:if> 
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
	    
	        
	        var chkTicket = '${searchCondition.chkTicket}';
	   		if(chkTicket == 'Y'){
	   			$("#chkTicket").prop('checked', true);
	   			$(".pageTitle").text("일일권 결제 현황(제로페이 제외)");
	   		} else{
	   			$(".pageTitle").text("일일권 결제 현황");
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
					$("#searchFrm").attr({method : 'post', action : '/zeropay/dailyTicketStatistics.do'}).submit();
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
					$("#searchFrm").attr({method : 'post', action : '/zeropay/dailyTicketStatistics.do'}).submit();
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
		        $("#searchFrm").attr({method : 'post', action : '/zeropay/dailyTicketStatistics.do'}).submit();
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
	    		$('#searchFrm').attr({method : 'post', action : '/zeropay/dailyTicketStatisticsExcel.do'}).submit();
	   		}); 
			
	   	});
    </script>
</body>
</html>