<%@ page language="java" contentType="application/vnd.ms-excel;charset=euc-kr"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
    response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode("자전거_배터리_정보.xls", "UTF8"));
    response.setHeader("Content-Description", "JSP Generated Data");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko">
<head>
<meta content="text/html; charset=KSC5601" http-equiv="content-type" />
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
    <table class="tb_type01" style="width : 1200px;">
    	<thead> 
			<tr>
    			<span>총 ${totCnt}건</span>
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
            
            	<c:forEach var="result" items="${parameterMap}" varStatus="status">
            		<tr>
	            	<%-- [${status.index}]: ${parameterMap[status.index]} --%>
	            		<c:forEach var="result2" items="${parameterMap[status.index]}">
	               	 	<td>${fn:replace(fn:replace(result2, '[', ''),']','')}</td>
	               	 	</c:forEach>
               	   </tr>	
           		</c:forEach> 
           		  
          
		</tbody>
	</table>
</body>
</html>
