<%@ page language="java" contentType="application/vnd.ms-excel;charset=euc-kr"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="java.util.Calendar"          %>
<%

	Calendar today = Calendar.getInstance();
	String getNowDatetime = "" + today.get(Calendar.YEAR) + (today.get(Calendar.MONTH)+1) + today.get(Calendar.DATE) + today.get(Calendar.HOUR);

    response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode("재배치내역등급_" + getNowDatetime +".xls", "UTF8"));
    response.setHeader("Content-Description", "JSP Generated Data");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko">
<head>
<title></title>
<meta content="text/html; charset=KSC5601" http-equiv="content-type" />
<style>
.tb_type01 th {text-align:center;padding:5% 0;}
.tb_type01 td {text-align:center;padding:5% 0}
.tb_type01 {width:100%;border:1px solid #e6e6e6;font-size:15px;table-layout:fixed}
.tb_type01 th {text-align:center;padding:15px 0;background:#eff5f8;border-top:2px solid #5e5e5e;border-right:1px solid #e6e6e6}
.tb_type01 td {text-align:left;padding:10px 2px;border:1px solid #e6e6e6}
.tb_type01 td.txRight {text-align:right;}
.tb_type01 td.txCenter {text-align:center;}
.tb_condition {width : 1200px}
.tb_condition td {text-align:center;padding:15px 0;border: 1px solid #e6e6e6;}
.tb_condition td.condition {width:150px;text-align:center;padding:15px 0;background:#FFFF99;}
/*label*/
.laType02 {margin-right:5px;display:inline-block;font-size:11px;}
</style>
</head>
<body>
    <div style="height:200px; width:1200px;text-align:center; margin-top:10px;">
    </div>
 
        <table class="tb_type01" id="list" style="margin-top:10px;">
	        <colgroup>
	            <col style="width:15%;" />
	            <col style="width:10%" />
	            <col style="width:30%" />
	            <col style="width:7%" />
	            <col style="width:7%" />
	            <col style="width:7%" />
	            <col style="width:7%" />
	        </colgroup>
	        <thead>
	            <tr>
	                <th>센터</th>
	                <th>구</th>
	                <th>대여소</th>
	                <th>등급</th>
	                <th>총 건수</th>
	                <th>이동 방문</th>
	                <th>배치 방문</th>
	            </tr>
	        </thead>
	        <tbody id="stationBody"> 
	        <c:forEach var="result" items="${dsList}" varStatus="loop">
	            <tr>
	                 <td>${result.centerName }</td>
	                 <td>${result.stationGrpName }</td>
	                 <td>${result.stationName }</td>
	                 <td>${result.imgSrc }</td>
	                 <td>${result.totCnt }</td>
	                 <td>${result.relocateCnt }</td>
	                 <td>${result.moveCnt }</td>
	                
	            </tr>
	             </c:forEach>
	             <c:if test="${fn:length(dsList) == 0 }">
	                <tr><td colspan="7">no data</td></tr>
	            </c:if>
	        </tbody>
		</table>
        
         
</body>
</html>