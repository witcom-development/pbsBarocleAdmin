<%@ page language="java" contentType="application/vnd.ms-excel;charset=euc-kr"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
    response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode("장애자전거목록.xls", "UTF8"));
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
                    <td style="width:200px;" class="condition" ><label class="laType02">발생일자</label></td>
                    <td style="width:400px;">${searchCondition.searchBgnDe } ~ ${searchCondition.searchEndDe }</td>
                    <td style="width:200px;" class="condition" ><label class="laType02">자전거번호</label></td>
                    <td style="width:400px;">${searchCondition.searchVal}</td>
                </tr>
                <tr>
                    <td style="width:200px;" class="condition" ><label class="laType02">아파트</label></td>
                    <td style="width:400px;">
                    	<c:choose>
							<c:when test="${searchCondition.stationGrpName eq '선택'}">
								전체
							</c:when>
							<c:otherwise>
								${searchCondition.stationGrpName }
							</c:otherwise>
						</c:choose>
                    </td>
                    <td style="width:200px;" class="condition" ><label class="laType02">대여소</label></td>
                    <td style="width:400px;">
						<c:choose>
							<c:when test="${searchCondition.stationName eq '선택'}">
								전체
							</c:when>
							<c:otherwise>
								${searchCondition.stationName }
							</c:otherwise>
						</c:choose>
					</td>
                </tr>
                <tr>
                    <td style="width:200px;" class="condition" ><label class="laType02">조회구분</label></td>
                    <td style="width:400px;">
                    	<c:choose>
							<c:when test="${searchCondition.chkType eq 'S'}">
								현황
							</c:when>
							<c:when test="${searchCondition.chkType eq 'H'}">
								이력
							</c:when>
							<c:otherwise>
								-
							</c:otherwise>
						</c:choose>
                    </td>
                    <td style="width:200px;" class="condition">&nbsp;</td>
                    <td style="width:400px;">
                    	&nbsp;
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
                <th>대여소 / 센터</th>
                <th>거치대번호</th>
                <th>자전거번호</th>
                <th>점검구분</th>
                <th>발생일시</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="bike" items="${InspectBikeList}" varStatus="loop">
                <tr>
                    <td class="title">${bike.stationName}</td>
                    <td>${bike.stationEquipOrder}</td>
                    <td>${bike.bikeNo}</td>
                    <td>${bike.bikeStatusName}</td>
					<td class="tx">${bike.regDttm }</td>
                </tr>
            </c:forEach>
            <c:if test="${fn:length(InspectBikeList) == 0 }">
                <tr><td colspan="5">
                	<spring:message code="search.nodata.msg" />
                </td></tr>
            </c:if>
        </tbody>
    </table>
</body>
</html>
