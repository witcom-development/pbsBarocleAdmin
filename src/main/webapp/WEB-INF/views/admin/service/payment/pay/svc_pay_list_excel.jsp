<%@ page language="java" contentType="application/vnd.ms-excel;charset=euc-kr"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
	response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode("결제내역.xls", "UTF8"));
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
.tb_type01 td {text-align:center;padding:10px 2px;border:1px solid #e6e6e6;mso-number-format:\@;}
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
                    <td class="condition" ><label class="laType02">결제일</label></td>
                    <td >${searchCondition.startPaymentDttm} ~ ${searchCondition.endPaymentDttm}</td>
                    <td class="condition" ><label class="laType02">사용자ID</label></td>
                    <td >${searchCondition.usrSearchKey}</td>
                    <td class="condition" ><label class="laType02">승인번호</label></td>
                    <td >${searchCondition.paymentConfmNoSeacrhKey}</td>
                </tr>
                <tr>
                    <td class="condition" ><label class="laType02">결제구분</label></td>
                    <td >${searchCondition.paymentClsCdName}</td>
                    <td class="condition" ><label class="laType02">결제수단</label></td>
                    <td >${searchCondition.paymentMethodCdName}</td>
                    <td class="condition" ><label class="laType02">결제상태</label></td>
                    <td >${searchCondition.paymentStusCdName}</td>
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
               	<th>아이디</th>
				<th>결제구분</th>
				<th>결제방법</th>
				<th>결제일시</th>
				<th>승인번호</th>
				<th>전체금액</th>
				<th>마일리지</th>
				<th>초과요금</th>
				<th>정산금액</th>
				<th>취소금액</th>
				<th>취소자</th>
            </tr>
        </thead>
        <tbody>
        <c:forEach var="result" items="${paymentList}" varStatus="status">
            <tr>
                <td>${result.mb_id_excel}</td>
                <td>${result.paymentClsCdName}</td>
                <td>${result.paymentMethodCdName}</td>
                <td>${result.paymentDttm}</td>
                <td>${result.paymentConfmNo}</td>
                <td class="txRight" style="mso-number-format:\#\,0\">${result.totAmt}</td>
                <td style="mso-number-format:\#\,0\">${result.mileagePaymentAmt}</td>
                <td style="mso-number-format:\#\,0\">${result.rentOverFeeSum}</td>
                <td style="mso-number-format:\#\,0\">${ result.totAmt - result.mileagePaymentAmt}</td>
                <c:choose>
                <c:when test="${result.paymentStusCd=='BIS_003'}">
                <td class="txRight" style="mso-number-format:\#\,0\">${result.totAmt}</td>
                </c:when>
				<c:otherwise>
				<td class="txRight" style="mso-number-format:\#\,0\">0</td>
				</c:otherwise>
                </c:choose>
                <td>${result.cancelAdminName}</td>
            </tr>
        </c:forEach>    
        <c:if test='${fn:length(paymentList) == 0}'>
            <tr>
                <td style="text-align:center" colspan="11"><spring:message code="search.nodata.msg" /></td>
            </tr>
        </c:if>
        </tbody>
    </table>
</body>
</html>
