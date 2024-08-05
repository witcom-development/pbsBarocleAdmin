<%@ page language="java" contentType="application/vnd.ms-excel;charset=euc-kr"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
    response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode("도난보고리스트.xls", "UTF8"));
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
                    <td style="width:200px;" class="condition" ><label class="laType02">보고일</label></td>
                    <td style="width:400px;">${searchCondition.searchBgnDe} ~ ${searchCondition.searchEndDe}</td>
                    <td style="width:200px;" class="condition" ><label class="laType02">자전거번호</label></td>
                    <td style="width:400px;">${searchCondition.searchWord}</td>
                </tr>
                <tr>
                    <td style="width:200px;" class="condition" ><label class="laType02">Lock 상태</label></td>
                    <td style="width:400px;">
                    	<c:choose>
							<c:when test="${searchCondition.lockState == '01'}">
								ON
							</c:when>
							<c:when test="${searchCondition.lockState == '02'}">
								OFF
							</c:when>
							<c:otherwise>
								Error
							</c:otherwise>
						</c:choose>
					</td>
					<td style="width:400px;">
						<c:choose>
							<c:when test="${searchCondition.sortType == 'bikeNo'}">
								자전거번호
							</c:when>
							<c:when test="${searchCondition.sortType == 'regDttm'}">
								보고일시
							</c:when>
							<c:otherwise>
								-
							</c:otherwise>
						</c:choose>
					</td>
					<td style="width:400px;">
						<c:choose>
							<c:when test="${searchCondition.sortValue == 'ASC'}">
								오름차순
							</c:when>
							<c:when test="${searchCondition.sortValue == 'DESC'}">
								내림차순
							</c:when>
							<c:otherwise></c:otherwise>
						</c:choose>
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
				<th>자전거번호</th>
				<th class="tc">보고일시</th>
				<th>Lock 상태</th>
				<th>GPS정보</th>
				<th>대여소</th>
				<th>거치대</th>
			</tr>
        </thead>
        <tbody>
            <c:forEach var="report" items="${robReportList}"  varStatus="loop">
                <tr>
					<td>${report.bikeNo }</td>
					<td>${report.regDttm }</td>
					<c:choose>
						<c:when test="${report.lockState == '01'}">
							<td>ON</td>
						</c:when>
						<c:when test="${report.lockState == '02'}">
							<td>OFF</td>
						</c:when>
						<c:otherwise>
							<td>Error</td>
						</c:otherwise>
					</c:choose>
					<td>위 : ${report.latitude}<br />
						경 : ${report.longitude}
					</td>
					<td>${report.stationName}</td>
					<td>${report.stationEquipOrd}</td>
				</tr>
            </c:forEach>
            <c:if test="${fn:length(robReportList) == 0 }">
                <tr><td colspan="6">no data</td></tr>
            </c:if>
        </tbody>
    </table>
</body>
</html>