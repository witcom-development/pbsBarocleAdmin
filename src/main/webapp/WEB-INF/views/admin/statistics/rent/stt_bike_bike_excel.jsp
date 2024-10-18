<%@ page language="java" contentType="application/vnd.ms-excel;charset=euc-kr"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
    response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode("대여소대여내역.xls", "UTF8"));
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
                    <td style="width:200px;" class="condition" ><label class="laType02">구분</label></td>
                    <td style="width:400px;">
                    <c:if test='${searchCondition.dateType == "D"}'>일</c:if>
                    <c:if test='${searchCondition.dateType == "M"}'>월</c:if>
                    </td>
                    <td style="width:200px;" class="condition" ><label class="laType02">날짜</label></td>
                    <td style="width:400px;">
                    <c:if test='${searchCondition.dateType == "D"}'>${searchCondition.searchBgnDe} ~ ${searchCondition.searchEndDe}</c:if>
                    <c:if test='${searchCondition.dateType == "M"}'>${searchCondition.searchBgnMt} ~ ${searchCondition.searchEndMt}</c:if>
                    </td>
                </tr>
                <tr>
                    <td style="width:200px;" class="condition" ><label class="laType02">아파트</label></td>
                    <td style="width:400px;">
                    <c:if test='${searchCondition.stationGrp != ""}'>
                    ${dataList[0].stationGrpName}
                    </c:if>
                    </td>
                    <td style="width:200px;" class="condition" ><label class="laType02">대여소</label></td>
                    <td style="width:400px;">
                    <c:if test='${searchCondition.stationId != ""}'>
                    ${dataList[0].stationName}
                    </c:if>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
    <!--검색조건 E-->
    <div style="width:1200px;text-align:right;margin:10px;">
          <label class="laType02"><b>총 ${ paginationInfo.getTotalRecordCount()} 건</b></label>
    </div>
    <table class="tb_type01" style="width : 1200px;">
		<thead> 
			<tr>
				<th>아파트</th>
				<th>대여소 명</th>
				<th>대여 일자 / 월</th>
				<th>대여 건수</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="result" items="${dataList}" varStatus="status">
			<tr>
				<td>${result.stationGrpName}</td>
				<td>${result.stationName}</td>
				<td class="tc">${result.rentDttm}</td>
				<td class="tc">${result.rentCnt}</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</body>
</html>
