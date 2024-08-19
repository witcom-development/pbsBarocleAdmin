<%@ page language="java" contentType="application/vnd.ms-excel;charset=euc-kr"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
    response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode("대여소목록.xls", "UTF8"));
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
                    <td style="width:200px;" class="condition" ><label class="laType02">대여소구분</label></td>
                    <td style="width:400px;">${searchVO.station_se_cd }
                    	<c:if test="${searchVO.station_se_cd eq 'RAK_001' }"></c:if>
                    	<%-- <c:if test="${searchVO.station_se_cd ne 'RAK_001' }">(신규)</c:if> --%>
                    </td>
                    <td style="width:200px;" class="condition" ><label class="laType02">구분</label></td>
                    <td style="width:400px;">${searchVO.gubun}</td>
                </tr>
                <tr>
                    <td style="width:200px;" class="condition" ><label class="laType02">아파트</label></td>
                    <td style="width:400px;">
                    	${searchVO.group}
                    </td>
                    <td style="width:200px;" class="condition" >대여소병</td>
                    <td style="width:400px;">
                    	${searchVO.name }
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
                <th>그룹명</th>
				<th>대여소구분</th>
				<th>대여소명</th>
				<th>구분</th>
				<th>사용여부</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="stationList" items="${stationList}" varStatus="loop">
                <tr>
                    <td>${stationList.station_grp_name}</td>
                    <td>
                    	<c:if test="${stationList.station_se_cd eq 'RAK_001' }"></c:if>
                        <%-- <c:if test="${stationList.station_se_cd eq 'RAK_002' }">(신규)</c:if> --%>
                    </td>
                    <td class="title">
						${stationList.station_name }
					</td>
                    <td>${stationList.station_cls_cd_name}</td>
                    <td class="tx">
                    <c:choose>
						<c:when test="${stationList.station_use_yn eq 'Y'}">사용</c:when>
						<c:when test="${stationList.station_use_yn eq 'N'}">미사용</c:when>
						<c:when test="${stationList.station_use_yn eq 'C'}">폐쇄</c:when>
						<c:when test="${stationList.station_use_yn eq 'T'}">임시 미사용</c:when>
						<c:otherwise>${stationList.station_use_yn }</c:otherwise>
					</c:choose>
					</td>
                </tr>
            </c:forEach>
            <c:if test="${fn:length(stationList) == 0 }">
                <tr><td colspan="6">
                	<spring:message code="search.nodata.msg" />
                </td></tr>
            </c:if>
        </tbody>
    </table>
</body>
</html>
