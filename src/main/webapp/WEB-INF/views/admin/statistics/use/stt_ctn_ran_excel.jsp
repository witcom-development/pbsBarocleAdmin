<%@ page language="java" contentType="application/vnd.ms-excel;charset=euc-kr"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
    response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode("운동량/탄소량통계.xls", "UTF8"));
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
                    <td style="width:200px;" class="condition" colspan="4"><label class="laType02">구분</label></td>
                    <td style="width:400px;" colspan="4">
                    <c:if test='${searchCondition.dateType == "D"}'>일</c:if>
                    <c:if test='${searchCondition.dateType == "W"}'>요일</c:if>
                    <c:if test='${searchCondition.dateType == "M"}'>월</c:if>
                    </td>
                    <td style="width:200px;" class="condition" colspan="5"><label class="laType02">일/월</label></td>
                    <td style="width:400px;" colspan="4">
                    <c:if test='${searchCondition.dateType == "D"}'>${searchCondition.searchBgnDe} ~ ${searchCondition.searchEndDe}</c:if>
                    <c:if test='${searchCondition.dateType == "W"}'>${searchCondition.searchBgnDe} ~ ${searchCondition.searchEndDe}</c:if>
                    <c:if test='${searchCondition.dateType == "M"}'>${searchCondition.searchBgnMt} ~ ${searchCondition.searchEndMt}</c:if>
                    </td>
                </tr>
                <tr>
					<td style="width:200px;" class="condition" colspan="4"><label class="laType02">대여구분</label></td>
                    <td style="width:400px;" colspan="4">
                    	<c:if test='${searchCondition.rentType != ""}'>
                    	<c:set var="rentTypeArr" value="${fn:split(searchCondition.rentType,',')}"/>
						<c:forEach var="x" items="${rentTypeArr}" varStatus="status"> 
							<c:if test='${status.index != 0}'>, </c:if>
						    <c:if test='${x == "RCC_001"}'>정기</c:if>
						    <c:if test='${x == "RCC_002"}'>회원</c:if>
						    <c:if test='${x == "RCC_003"}'>비회원</c:if>
						    <c:if test='${x == "RCC_004"}'>단체</c:if>
						</c:forEach>
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
				<th rowspan="2">구분</th>
				<th colspan="4">10대</th>
				<th colspan="4">20대</th>
				<th colspan="4">30대</th>
				<th colspan="4">40대</th>
				<th colspan="4">50대</th>
				<th colspan="4">60대</th>
				<th colspan="4">70대</th>
				<th colspan="2" rowspan="2">합계<p>운동</p></th>
				<th colspan="2" rowspan="2">합계<p>탄소</p></th>
			</tr>
			<tr>
				<th colspan="2">운동량</th>
				<th colspan="2">탄소량</th>
				<th colspan="2">운동량</th>
				<th colspan="2">탄소량</th>
				<th colspan="2">운동량</th>
				<th colspan="2">탄소량</th>
				<th colspan="2">운동량</th>
				<th colspan="2">탄소량</th>
				<th colspan="2">운동량</th>
				<th colspan="2">탄소량</th>
				<th colspan="2">운동량</th>
				<th colspan="2">탄소량</th>
				<th colspan="2">운동량</th>
				<th colspan="2">탄소량</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="result" items="${dataList}" varStatus="status">
			<tr>
				<td class="tl">${result.statisticsDate}</td>
				<td colspan="2">${result.useCntAgeMvm_10}</td>
				<td colspan="2">${result.useCntAgeCo2_10}</td>
				<td colspan="2">${result.useCntAgeMvm_20}</td>
				<td colspan="2">${result.useCntAgeCo2_20}</td>
				<td colspan="2">${result.useCntAgeMvm_30}</td>
				<td colspan="2">${result.useCntAgeCo2_30}</td>
				<td colspan="2">${result.useCntAgeMvm_40}</td>
				<td colspan="2">${result.useCntAgeCo2_40}</td>
				<td colspan="2">${result.useCntAgeMvm_50}</td>
				<td colspan="2">${result.useCntAgeCo2_50}</td>
				<td colspan="2">${result.useCntAgeMvm_60}</td>
				<td colspan="2">${result.useCntAgeCo2_60}</td>
				<td colspan="2">${result.useCntAgeMvm_70}</td>
				<td colspan="2">${result.useCntAgeCo2_70}</td>
				<td colspan="2">${result.useCntAgeMvm_Total}</td>
				<td colspan="2">${result.useCntAgeCo2_Total}</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</body>
</html>
