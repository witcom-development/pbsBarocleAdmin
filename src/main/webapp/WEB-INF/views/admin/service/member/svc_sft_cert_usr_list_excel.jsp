<%@ page language="java" contentType="application/vnd.ms-excel;charset=euc-kr"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
    response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode("인증제합격자목록.xls", "UTF8"));
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
                    <td style="width:200px;" class="condition" ><label class="laType02">안전교육일자</label></td>
                    <td style="width:400px;">${form.searchStartDate } ~ ${form.searchEndDate }</td>
                    <td style="width:200px;" class="condition" ><label class="laType02">회원구분</label></td>
                    <td style="width:400px;">${form.mbYn }</td>
                </tr>
                <tr>
                    <td style="width:200px;" class="condition" ><label class="laType02">구분</label></td>
                    <td style="width:400px;">
                    	${form.searchParameter}  : ${form.searchValue }
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
    <div style="width:1200px;text-align:right;margin:10px;">
          <label class="laType02"><b>총 ${paginationInfo.getTotalRecordCount() } 건</b></label>
    </div>
    <!--검색조건 E-->
    <table class="tb_type01" style="width : 1200px;">
        <thead>
            <tr>
				<th>응시번호</th>
				<th>이름</th>
				<th>휴대폰번호</th>
				<th>자치구</th>
				<th>응시일</th>
				<th>인증제유형코드</th>
				<th>안전교육이수기관</th>
				<th>안전교육일자</th>
				<th>회원여부</th>
				<th>회원아이디</th>
				<th>할인적용시작일자</th>
				<th>할인적용종료일자</th>
            </tr>
        </thead>
        <tbody>
            <c:if test="${fn:length(safetyCertUserList) > 0 }">
            <c:forEach var="mb" items="${safetyCertUserList}" varStatus="loop">
                <tr>
                    <td class="title">${mb.certNum }</a></td>
					<td class="tc">${mb.usrName }</td>
					<td class="tc">${mb.usrMpnNo }</td>
					<td class="tc">${mb.usrPrvCd }</td>
					<td style='mso-number-format:"Medium Date"'>${mb.certDate }</td>
					<td class="tc">${mb.certCls }</td>
					<td class="title pl10">${mb.certOrg }</td>
					<td style='mso-number-format:"Medium Date"'>${mb.certEdDate }</td>
					<td class="tc">${mb.mbYn =='Y'?'회원':'비회원' }</td>
					<td class="tc">${mb.mbId }</td>
					<td style='mso-number-format:"Medium Date"'>${mb.disSDttm }</td>
					<td style='mso-number-format:"Medium Date"'>${mb.disEDttm }</td>
                </tr>
            </c:forEach>
            </c:if>
            <c:if test="${fn:length(safetyCertUserList) == 0 }">
                <tr><td colspan="6">
                	<spring:message code="search.nodata.msg" />
                </td></tr>
            </c:if>
        </tbody>
    </table>
</body>
</html>
