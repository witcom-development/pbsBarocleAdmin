<%@ page language="java" contentType="application/vnd.ms-excel;charset=euc-kr"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
	response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode("마일리지내역.xls", "UTF8"));
    response.setHeader("Content-Description", "JSP Generated Data");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko">
<head>
<META HTTP-EQUIVE="CONTENT-TYPE" CONTENT="TEXT/HTML; CHARSET=KSC5601">
<title></title>
<style>
.tb_type01 th {text-align:center;padding:5% 0;}
.tb_type01 td {text-align:center;padding:5% 0}
.tb_type01 {width:100%;border:1px solid #e6e6e6;font-size:15px;table-layout:fixed}
.tb_type01 th {text-align:center;padding:15px 0;background:#eff5f8;border-top:2px solid #5e5e5e;border-right:1px solid #e6e6e6}
.tb_type01 td {text-align:center;padding:10px 2px;border:1px solid #e6e6e6}
.tb_type01 td.title {text-align:left;}
.tb_type01 td.txRight {text-align:right;}
.tb_type01 td.txLeft {text-align:left;}
.tb_condition {width : 1200px}
.tb_condition td {text-align:center;padding:15px 0;border: 1px solid #e6e6e6;}
.tb_condition td.condition {width:150px;text-align:center;padding:15px 0;background:#FFFF99;}
/*label*/
.laType02 {margin-right:5px;display:inline-block;font-size:11px;}
</style>
</head>
<body>
    <p style="height:200px; width:1200px;text-align:center; margin-top:10px;"></p>
    <div style="margin-top:10px;">
        <table class="tb_condition">
            <tbody>
                <tr>
                    <td class="condition" ><label class="laType02">일자</label></td>
                    <td >${searchCondition.searchStrDate} ~ ${searchCondition.searchEndDate}</td>
                    <td class="condition" ><label class="laType02"></label></td>
                    <td colspan="3"></td>
                </tr>
                <tr>
                    <td class="condition" ><label class="laType02">이용구분</label></td>
                    <td>
                    <c:if test="${searchCondition.mileageClsCd != null && searchCondition.mileageClsCd != ''}">
                    	${mileageList.get(0).mileageClsCd}
                    </c:if>
                    </td>
                    <td class="condition" ><label class="laType02">회원 ID</label></td>
                    <td colspan="3">${searchCondition.userId}</td>
                </tr>
            </tbody>
        </table>
    </div>
    <div style="width:1200px;text-align:right;margin:10px;">
          <label class="laType02"><b>총 ${paginationInfo.getTotalRecordCount() } 건</b></label>
    </div>
    <table class="tb_type01" style="width : 1200px;">
       <thead>
			<tr>
				<th colspan="3">합계 (단위 : 천)</th>
				<th colspan="3"><fmt:formatNumber value="${totalSum/1000}" pattern="0.0"></fmt:formatNumber></th>
			</tr>
			<tr>
				<th>등록일시</th>
				<th>대여일시</th>
				<th>회원 ID</th>
				<th>이용구분</th>
				<th colspan="3">마일리지</th>
			</tr>
		</thead>
        <tbody>
        <c:forEach var="result" items="${mileageList}" varStatus="status">
            <tr>
				<td>${result.regDttm}</td>
				<td>${result.rentDttm}</td>
				<td>${result.userId}</td>
				<td>${result.mileageClsCd}</td>
				<td colspan="3"><fmt:formatNumber value="${result.mileagePoint/1000}" pattern="0.0"></fmt:formatNumber></td>
			</tr>
        </c:forEach>    
        <c:if test='${fn:length(mileageList) == 0}'>
            <tr>
                <td style="text-align:center" colspan="4"><spring:message code="search.nodata.msg" /></td>
            </tr>
        </c:if>
        </tbody>
    </table>
</body>
</html>
