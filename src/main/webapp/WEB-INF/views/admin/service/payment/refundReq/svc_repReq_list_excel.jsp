<%@ page language="java" contentType="application/vnd.ms-excel;charset=euc-kr"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
	response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode("환불신청내역.xls", "UTF8"));
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
                <tr>조회조건</tr>
                <tr>
                    <td class="condition" ><label class="laType02">결제일</label></td>
                    <td >${searchCondition.startDttm} ~ ${searchCondition.endDttm}</td>
                    <td><label class="laType02"><b>총 ${paginationInfo.getTotalRecordCount() } 건</b></label></td>
                </tr>
               <tr></tr>
            </tbody>
        </table>
    </div> 

    
    <div style="width:1200px;text-align:right;margin:10px;">
          
    </div>
    <table class="tb_type01" style="width : 1200px;">
        <thead>
            <tr>
               	<th>결제일</th>
				<th>개시일</th>
				<th>접수일</th>
				<th>아이디</th>
				<th>휴대폰</th>
				<th>이용권</th>
				<th>결제구분</th>
				<th>마일리지사용금액</th>
				<th>결제금액</th>
				<th>예금주</th>
				<th>은행</th>
				<th>계좌</th>
				<th>환불 처리자</th>
				<th>환불예정액</th>
				<th>환불요청사유</th>
				<th>결제일련번호</th>
				<th>사용자seq</th>
            </tr>
        </thead>
        <tbody>
        <c:forEach var="result" items="${refundList}" varStatus="status">
            <tr>
				<td class="tc" id="paymentDttm">${result.paymentDttm}</td>
				<td class="tc" id="fistStrDttm">${result.fistStrDttm}</td>
				<td class="tc" id="refundDttm">${result.refundDttm}</td>
				<td>${result.usrMainId}</td>
				<td>${result.usrMpnNo}</td>
				<td>${result.paymentClsCdName}</td>
				<td>${result.paymentMethodCdName}</td>
				<td class="tr" id="mileagePaymentAmt"><fmt:formatNumber type="number" value="${result.mileagePaymentAmt}"/></td>
				<td class="tr" id="totAmt"><fmt:formatNumber type="number" value="${result.totAmt}"/></td>
				<td class="tc" id="acnutNm">${result.acnutNm}</td>
				<td class="tc" id="acnutBank">${result.acnutBank}</td>
				<td class="tc" id="acnutNo">${result.acnutNo}</td>
				<td class="tc" id="acnutNo">${result.refundAdminId}</td>
				<td class="tr" id="refndAmt"><fmt:formatNumber type="number" value="${result.refndAmt}"/></td>
				<td class="tc" id="refundReason">${result.refundReason}</td>
				<td style="display:none" id="paymentSeq">${result.paymentSeq}</td>
				<td style="display:none" id="usrSeq">${result.usrSeq}</td>
            </tr>
        </c:forEach>    
        </tbody>
    </table>
</body>
</html>
