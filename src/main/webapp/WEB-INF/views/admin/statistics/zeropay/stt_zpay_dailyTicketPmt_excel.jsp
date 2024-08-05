<%@ page language="java" contentType="application/vnd.ms-excel;charset=euc-kr"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode("일일권결제현황.xls", "UTF8"));
    response.setHeader("Content-Description", "JSP Generated Data");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko">
<head>
<title></title>
<style>
.tb_type01 th {text-align:center;padding:5% 0;}
.tb_type01 td {text-align:center;padding:5% 0}
.tb_type01 {width:100%;border:1px solid #e6e6e6;font-size:15px;table-layout:fixed}
.tb_type01 th {text-align:center;padding:15px 0;background:#eff5f8;border-top:2px solid #5e5e5e;border-right:1px solid #e6e6e6}
.tb_type01 td {text-align:center;padding:10px 2px;border:1px solid #e6e6e6}
.tb_type01 td.title {text-align:left;}
.tb_type01 td.condition {text-align:center;padding:15px 0;background:#FFFF33;}
.tb_type01 td.txRight {text-align:right;}
.tb_type01 td.txLeft {text-align:left;}
.tb_condition {width : 1200px}
.tb_condition td {text-align:center;padding:15px 0;border: 1px solid #e6e6e6;}
.tb_condition td.condition {text-align:center;padding:15px 0;background:#eff5f8;}
/*label*/
.laType02 {margin-right:5px;display:inline-block;font-size:11px;}
</style>
</head>
<body>
 <div style="margin-top: 25px;">
	<div style="width:1200px;text-align:right;margin:10px;">
         <label class="laType02"><b>총 ${ paginationInfo.getTotalRecordCount()-1} 건</b></label>
  		 </div>
	 <table class="tb_type01" style="width : 1500px;">
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
</body>
</html>
