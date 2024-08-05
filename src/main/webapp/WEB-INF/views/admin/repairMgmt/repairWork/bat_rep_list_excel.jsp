<%@ page language="java" contentType="application/vnd.ms-excel;charset=euc-kr"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
    response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode("배터리교체리스트.xls", "UTF8"));
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
/*label*/
.laType02 {margin-right:5px;display:inline-block;font-size:11px;}
</style>
</head>
<body>
    <!--검색조건 E-->
    <table class="tb_type01" style="width : 800px;">
        <thead>
            <tr>
                <th>자전거 번호</th>
				<th>교체일자</th>
				<th>교체자 팀명</th>
				<th>교체자 센터명</th>
				<th>교체자 아이디</th>
				<th>교체자 이름</th>
				<th>교체 전 상태</th>
				<th>교체 후 상태</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="result" items="${batReplaceList}" varStatus="loop">
                <tr>
                    <td>${result.bikeNo}</td>
                    <td>&nbsp;${result.batReplaceTime}</td>
                    <td>
                    	<c:if test="${empty result.division}">
                    		정보없음
                    	</c:if>
                    	<c:if test="${not empty result.division}">
                    		${result.division}
                    	</c:if>
                    </td>
                    <td>
                    	<c:if test="${empty result.centerName}">
                    		정보없음
                    	</c:if>
                    	<c:if test="${not empty result.centerName}">
                    		${result.centerName}
                    	</c:if>
                    </td>
                    <td>${result.adminId}</td>
                    <td>${result.adminName}</td>
                    <td>${result.bfBatStat}</td>
                    <td>${result.afBatStat}</td>
                </tr>
            </c:forEach>
            <c:if test="${fn:length(batReplaceList) == 0 }">
                <tr><td colspan="8">no data</td></tr>
            </c:if>
        </tbody>
    </table>
</body>
</html>