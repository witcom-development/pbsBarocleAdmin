<%@ page language="java" contentType="application/vnd.ms-excel;charset=euc-kr"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
    response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode("연령대별이용통계.xls", "UTF8"));
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
   <div style="height:200px; width:1200px;text-align:center; margin-top:10px;">
    </div>
    <div>
        <table class="tb_condition">
            <tbody>
                <tr>
                    <td style="width:200px;" class="condition" colspan="3"><label class="laType02">대여월</label></td>
                    <td style="width:400px;" colspan="6">${searchCondition.searchBgnDe} ~ ${searchCondition.searchEndDe}</td>
                </tr>
            </tbody>
        </table>
    </div>
    <!--검색조건 E-->
    <table class="tb_type01 tb_right">
	<colgroup>
		<col style="width:auto" span="9" />
	</colgroup>
	<thead> 
		<tr>
			<th>유형</th>
			<th>성별</th>
			<th>10대</th>
			<th>20대</th>
			<th>30대</th>
			<th>40대</th>
			<th>50대</th>
			<th>60대</th>
			<th>70대</th>
			<th>기타</th>
			<th>합계</th>
		</tr>
	</thead>
	<tbody>
	<c:forEach var="result" items="${dataList}" varStatus="status">
		<tr>
			<td style="text-align:center;<c:if test="${result.bikeType eq '전체' }">background:grey;color:white;</c:if><c:if test="${result.sexCd eq '합계' }">background:beige;</c:if>">${result.bikeType}</td>
			<td style="text-align:center;<c:if test="${result.bikeType eq '전체' }">background:grey;color:white;</c:if><c:if test="${result.sexCd eq '합계' }">background:beige;</c:if>">${result.sexCd}</td>  
			<td style="text-align:center;<c:if test="${result.bikeType eq '전체' }">background:grey;color:white;</c:if><c:if test="${result.sexCd eq '합계' }">background:beige;</c:if>"><fmt:formatNumber value="${result.age1}" pattern="#,###" /></td>
			<td style="text-align:center;<c:if test="${result.bikeType eq '전체' }">background:grey;color:white;</c:if><c:if test="${result.sexCd eq '합계' }">background:beige;</c:if>"><fmt:formatNumber value="${result.age2}" pattern="#,###" /></td>
			<td style="text-align:center;<c:if test="${result.bikeType eq '전체' }">background:grey;color:white;</c:if><c:if test="${result.sexCd eq '합계' }">background:beige;</c:if>"><fmt:formatNumber value="${result.age3}" pattern="#,###" /></td>
			<td style="text-align:center;<c:if test="${result.bikeType eq '전체' }">background:grey;color:white;</c:if><c:if test="${result.sexCd eq '합계' }">background:beige;</c:if>"><fmt:formatNumber value="${result.age4}" pattern="#,###" /></td>
			<td style="text-align:center;<c:if test="${result.bikeType eq '전체' }">background:grey;color:white;</c:if><c:if test="${result.sexCd eq '합계' }">background:beige;</c:if>"><fmt:formatNumber value="${result.age5}" pattern="#,###" /></td>
			<td style="text-align:center;<c:if test="${result.bikeType eq '전체' }">background:grey;color:white;</c:if><c:if test="${result.sexCd eq '합계' }">background:beige;</c:if>"><fmt:formatNumber value="${result.age6}" pattern="#,###" /></td>
			<td style="text-align:center;<c:if test="${result.bikeType eq '전체' }">background:grey;color:white;</c:if><c:if test="${result.sexCd eq '합계' }">background:beige;</c:if>"><fmt:formatNumber value="${result.age7}" pattern="#,###" /></td>
			<td style="text-align:center;<c:if test="${result.bikeType eq '전체' }">background:grey;color:white;</c:if><c:if test="${result.sexCd eq '합계' }">background:beige;</c:if>"><fmt:formatNumber value="${result.age8}" pattern="#,###" /></td>
			<td style="text-align:center;<c:if test="${result.bikeType eq '전체' }">background:grey;color:white;</c:if><c:if test="${result.sexCd eq '합계' }">background:beige;</c:if>"><fmt:formatNumber value="${result.ageTotal}" pattern="#,###" /></td>
		</tr>
	</c:forEach>
	</tbody>
</table>
</body>
</html>
