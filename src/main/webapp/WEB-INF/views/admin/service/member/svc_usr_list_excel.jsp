<%@ page language="java" contentType="application/vnd.ms-excel;charset=euc-kr"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
    response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode("회원목록.xls", "UTF8"));
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
                    <td style="width:200px;" class="condition" ><label class="laType02">가입일</label></td>
                    <td style="width:400px;">${form.searchStartDate } ~ ${form.searchEndDate }</td>
                    <td style="width:200px;" class="condition" ><label class="laType02">사용자구분</label></td>
                    <td style="width:400px;">${form.usergubun }</td>
                </tr>
                <tr>
                    <td style="width:200px;" class="condition" ><label class="laType02">구분</label></td>
                    <td style="width:400px;">
                    	${form.gubun}  : ${form.searchValue }
                    </td>
                    <td style="width:200px;" class="condition" >벌점</td>
                    <td style="width:400px;">
                    	${form.penalty_point } 이상
                    </td>
                </tr>
                <tr>
                    <td style="width:200px;" class="condition" ><label class="laType02">결제구분</label></td>
                    <td style="width:400px;">${form.paymentClsCdName}</td>
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
                <th>아이디</th>
                <th>연락처</th>
                <th>성별</th>
                <th>생년월일</th>
                <th>사용자구분</th>
                <th>가입일</th>
            </tr>
        </thead>
        <tbody>
            <c:if test="${fn:length(memberList) > 0 }">
            <c:forEach var="mb" items="${memberList}" varStatus="loop">
                <tr>
                    <td>${mb.mb_id_excel}</td>
                    <td class="title">${mb.usr_mpn_no}</td>
                    <td>${mb.sex_cd =='F'?'여':'남' }</td>
                    <td>${mb.usr_birth_date }</td>
                    <td>${mb.mlang_com_cd_name}</td>
                    <td class="tx"> 
                  		  ${mb.reg_dttm }
                    </td>
                </tr>
            </c:forEach>
            </c:if>
            <c:if test="${fn:length(memberList) == 0 }">
                <tr><td colspan="6">
                	<spring:message code="search.nodata.msg" />
                </td></tr>
            </c:if>
        </tbody>
    </table>
</body>
</html>
