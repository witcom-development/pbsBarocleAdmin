<%@ page language="java" contentType="application/vnd.ms-excel;charset=euc-kr"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
    response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode("재배치내역자전거.xls", "UTF8"));
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
                    <td class="condition" ><label class="laType02">일자</label></td>
                    <td >${searchCondition.searchBgnDe} ~ ${searchCondition.searchEndDe}</td>
                    <td class="condition" ><label class="laType02">상태</label></td>
                    <td >${searchCondition.relocationCmptYn == 'Y' ? '배치완료' : '배치이동'}</td>
                </tr>
                <tr>
                    <td class="condition" ><label class="laType02">조회구분</label></td>
                    <td >${searchCondition.viewType}</td>
                    <td class="condition" ><label class="laType02">자전거번호</label></td>
                    <td >${searchCondition.bikeNo}</td>
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
				<th>자전거번호</th>
				<th>이동대여소</th>
				<th>이동거치대</th>
				<th>이동 시작일시</th>
				<th>이동 관리자</th>
				<th>설치대여소</th>
				<th>설치거치대</th>
				<th>재배치 종료일시</th>
				<th>설치 관리자</th>
				<th>상태</th>
			</tr>
        </thead>
        <tbody>
        <c:forEach var="result" items="${RelocationStateDetail}" varStatus="status">
		    <tr>
		        <td>${result.bikeNo}</td>
		        <td>${result.fromStationName}</td>
		        <td class="tr">${result.fromStationEquipOrder}</td>
		        <td class="tc">${result.relocateStrDttm}</td>
		        <td>${result.moveagnAdmin}</td>
		        <td>${result.toSationName}</td>
		        <td class="tr">${result.toStationEquipOrder}</td>
		        <td class="tc">${result.relocateEndDttm}</td>
		        <td>${result.relocationAdmin}</td>
		        <td class="tc">${result.relocationCmptYn == 'Y' ? '배치완료' : '배치이동'}</td>
		    </tr>
		</c:forEach>    
        <c:if test='${fn:length(RelocationStateDetail) == 0}'>
            <tr>
                <td style="text-align:center" colspan="10"><spring:message code="search.nodata.msg" /></td>
            </tr>
        </c:if>
        </tbody>
    </table>
</body>
</html>
