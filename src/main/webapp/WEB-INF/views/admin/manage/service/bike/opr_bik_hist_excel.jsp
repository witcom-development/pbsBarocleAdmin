<%@ page language="java" contentType="application/vnd.ms-excel;charset=euc-kr"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
    response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode("자전거리스트.xls", "UTF8"));
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
.tb_condition {width : 1200px}
.tb_condition td {text-align:center;padding:15px 0;border: 1px solid #e6e6e6;}
.tb_condition td.condition {width:150px;text-align:center;padding:15px 0;background:#FFFF99;}
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
                    <td style="width:200px;" class="condition" ><label class="laType02">등록일</label></td>
                    <td style="width:400px;">${bike.searchBgnDe} ~ ${bike.searchEndDe}</td>
                    <td style="width:200px;" class="condition" ><label class="laType02">자전거 번호</label></td>
	                <td style="width:400px;">${currentInfo.bikeNo}</td>
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
                <th rowspan="2">대여구분</th>
                <th colspan="2">대여</th>
                <th colspan="2">반납</th>
                <th rowspan="2">대여자 ID</th>
                <th rowspan="2">이용거리(km)</th>
                <th rowspan="2">이용시간(분)</th>
            </tr>
            <tr>
            	<th>일시</th>
            	<th>station</th>
            	<th>일시</th>
            	<th>station</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="info" items="${rentalList}" varStatus="loop">
                <tr>
                    <td>${info.rentClsCdName}</td>
                    <td>${info.rentDttm }</td>
                    <td>${info.rentStationName }</td>
                    <td>${info.returnDttm }</td>
                    <td>${info.returnStationName }</td>
                    <td>${info.mbId }</td>
                    <td>${info.useDist }</td>
                    <td>${info.useMi }</td>
                </tr>
            </c:forEach>
            <c:if test="${fn:length(BikeList) == 0 }">
                <tr><td colspan="8">no data</td></tr>
            </c:if>
        </tbody>
    </table>
</body>
</html>