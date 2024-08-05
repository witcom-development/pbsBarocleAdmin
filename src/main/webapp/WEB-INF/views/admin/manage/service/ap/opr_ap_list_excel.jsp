<%@ page language="java" contentType="application/vnd.ms-excel;charset=euc-kr"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
    response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode("무선AP리스트.xls", "UTF8"));
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
    <p style="height:200px; width:1200px;text-align:center; margin-top:10px;"></p>
    <div style="margin-top:10px;">
        <table class="tb_condition">
            <tbody>
                <tr>
                    <td class="condition" ><label class="laType02">등록일</label></td>
                    <td >${searchCondition.searchBgnDe} ~ ${searchCondition.searchEndDe}</td>
                    <td class="condition" ><label class="laType02">상태</label></td>
                    <td >${searchCondition.deviceStatusName}</td>
                </tr>
                <tr>
                    <td class="condition" ><label class="laType02">아파트</label></td>
                    <td >${searchCondition.stationGrpName}</td>
                    <td class="condition" ><label class="laType02">대여소명</label></td>
                    <td >${searchCondition.stationName}</td>
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
               <th>무선AP</th>
               <th>시리얼No</th>
               <th>IP</th>
               <th>설치 대여소</th>
               <th>상태</th>
               <th>납품처</th>
               <th>등록일</th>
               <th>최종정기 점검일</th>
               <th>점검 잔여일수</th>
            </tr>
        </thead>
        <tbody>
        <c:forEach var="result" items="${APList}" varStatus="status">
            <tr>
                <td>${result.deviceId}</td>
                <td class="txRight" style='mso-number-format:000000'>${result.serialNo}</td>
                <td>${result.ipV4}</td>
                <td>${result.stationName}</td>
                <td>${result.deviceStatusName}</td>
                <td>${result.entrpsCdNm}</td>
                <td class="txCenter">${result.regDttm}</td>
                <td class="txCenter">${result.lastChkDttm}</td>
                <td class="txCenter">${result.lastChkRemainDay}</td>
            </tr>
        </c:forEach>    
        <c:if test='${fn:length(APList) == 0}'>
            <tr>
                <td style="text-align:center" colspan="9"><spring:message code="search.nodata.msg" /></td>
            </tr>
        </c:if>
        </tbody>
    </table>
</body>
</html>
