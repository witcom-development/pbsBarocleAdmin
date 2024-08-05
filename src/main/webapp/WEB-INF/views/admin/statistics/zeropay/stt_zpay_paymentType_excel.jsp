<%@ page language="java" contentType="application/vnd.ms-excel;charset=euc-kr"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
    String chkYn = (String)request.getAttribute("chkYn");
	String filename = "결제수단별현황.xls";	
	if(chkYn != null && chkYn.equals("Y")){
		filename = "결제수단별현황(일일권).xls";
	}
	response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode(filename, "UTF8"));
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
.tb_type01 th {text-align:center;padding:15px 0;background:#eff5f8;border-top:1px solid #e6e6e6;border-right:1px solid #e6e6e6}
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
	<div style="width:2000px;margin:10px;text-align: right;display: inline-block;">
         <label class="laType02"><b>총 ${ paginationInfo.getTotalRecordCount()} 건</b></label>
  	</div>
	 <table class="tb_type01" style="width : 2000px;">
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
		</tbody>
	</table>
</div>
</body>
</html>
