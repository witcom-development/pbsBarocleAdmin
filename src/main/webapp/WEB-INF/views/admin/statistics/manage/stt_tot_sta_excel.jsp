<%@ page language="java" contentType="application/vnd.ms-excel;charset=euc-kr"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
    response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode("운영보고.xls", "UTF8"));
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
                    <td style="width:200px;" class="condition" colspan="5"><label class="laType02">구분</label></td>
                    <td style="width:400px;" colspan="7">
                    <c:if test='${searchCondition.dateType == "D"}'>일</c:if>
                    <c:if test='${searchCondition.dateType == "M"}'>월</c:if>
                    </td>
                    <td style="width:200px;" class="condition" colspan="5"><label class="laType02">기간</label></td>
                    <td style="width:400px;" colspan="8">
                    <c:if test='${searchCondition.dateType == "D"}'>${searchCondition.searchBgnDe} ~ ${searchCondition.searchEndDe}</c:if>
                    <c:if test='${searchCondition.dateType == "M"}'>${searchCondition.searchBgnMt} ~ ${searchCondition.searchEndMt}</c:if>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
    <!--검색조건 E-->
    <div style="width:1200px;text-align:left;margin:10px;">
          <label class="laType02"><b>운영내역 현황</b></label>
    </div>
    <table class="tb_type01" style="width : 1200px;">
        <thead> 
			<tr>
				<th colspan="6" rowspan="2">수익금(천원)</th>
				<th colspan="6" rowspan="2">회원가입(명)</th>
				<th colspan="13">자전거 이용(건)</th>
			</tr>
			<tr>
				<th colspan="4">이용수</th>
				<th colspan="3">평균 이용 수</th>
				<th colspan="3">평균 이동거리(km)</th>
				<th colspan="3">평균 이용시간</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<th colspan="2">합계</th>
				<td colspan="4" class="tr"><fmt:formatNumber type="number" value="${incomeList[0].payAmt+incomeList[1].payAmt == null ? 0 : (incomeList[0].payAmt+incomeList[1].payAmt)/1000}"/></td>
				<th colspan="2">합계</th>
				<td colspan="4" class="tr">${userjoinList[0].totCnt+userjoinList[1].totCnt == null ? 0 : userjoinList[0].totCnt+userjoinList[1].totCnt}</td>
				<th colspan="2">합계</th>
				<td colspan="2" class="tr">${bikeuseList[0].useCnt+bikeuseList[1].useCnt == null ? 0 : bikeuseList[0].useCnt+bikeuseList[1].useCnt}</td>
				<td colspan="3" class="tr"><fmt:formatNumber value="${bikeuseList[0].useCnt+bikeuseList[1].useCnt == null ? 0 : (bikeuseList[0].useCnt+bikeuseList[1].useCnt)/period}" pattern="0.00"></fmt:formatNumber></td>
				<td colspan="3" class="tr"><fmt:formatNumber value="${bikeuseList[0].moveDist+bikeuseList[1].moveDist == null ? 0 : (bikeuseList[0].moveDist+bikeuseList[1].moveDist)/period/1000}" pattern="0.00"></fmt:formatNumber></td>
				<td colspan="3" class="tr"><fmt:formatNumber value="${bikeuseList[0].useMi+bikeuseList[1].useMi == null ? 0 : (bikeuseList[0].useMi+bikeuseList[1].useMi)/period}" pattern="0.00"></fmt:formatNumber></td>
			</tr>
			<tr>
				<th colspan="2">회원</th>
				<td colspan="4" class="tr"><fmt:formatNumber type="number" value="${incomeList[0].payAmt == null ? 0 : incomeList[0].payAmt/1000}"/></td>
				<th colspan="2">남</th>
				<td colspan="4" class="tr">${userjoinList[0].totCnt == null ? 0 : userjoinList[0].totCnt}</td>
				<th colspan="2">남</th>
				<td colspan="2" class="tr">${bikeuseList[0].useCnt == null ? 0 : bikeuseList[0].useCnt}</td>
				<td colspan="3" class="tr"><fmt:formatNumber value="${bikeuseList[0].useCnt == null ? 0 : bikeuseList[0].useCnt/period}" pattern="0.00"></fmt:formatNumber></td>
				<td colspan="3" class="tr"><fmt:formatNumber value="${bikeuseList[0].moveDist == null ? 0 : bikeuseList[0].moveDist/period/1000}" pattern="0.00"></fmt:formatNumber></td>
				<td colspan="3" class="tr"><fmt:formatNumber value="${bikeuseList[0].useMi == null ? 0 : bikeuseList[0].useMi/period}" pattern="0.00"></fmt:formatNumber></td>
			</tr>
			<tr>
				<th colspan="2">비회원</th>
				<td colspan="4" class="tr"><fmt:formatNumber type="number" value="${incomeList[1].payAmt == null ? 0 :incomeList[1].payAmt/1000}"/></td>
				<th colspan="2">여</th>
				<td colspan="4" class="tr">${userjoinList[1].totCnt == null ? 0 : userjoinList[1].totCnt}</td>
				<th colspan="2">여</th>
				<td colspan="2" class="tr">${bikeuseList[1].useCnt == null ? 0 : bikeuseList[1].useCnt}</td>
				<td colspan="3" class="tr"><fmt:formatNumber value="${bikeuseList[1].useCnt == null ? 0 : bikeuseList[1].useCnt/period}" pattern="0.00"></fmt:formatNumber></td>
				<td colspan="3" class="tr"><fmt:formatNumber value="${bikeuseList[1].moveDist == null ? 0 : bikeuseList[1].moveDist/period/1000}" pattern="0.00"></fmt:formatNumber></td>
				<td colspan="3" class="tr"><fmt:formatNumber value="${bikeuseList[1].useMi == null ? 0 : bikeuseList[1].useMi/period}" pattern="0.00"></fmt:formatNumber></td>
			</tr>
		</tbody>
	</table>
	<div style="width:1200px;text-align:left;margin:10px;">
          <label class="laType02"><b>시간대 이용 현황</b></label>
    </div>
    <table class="tb_type01">
		<thead> 
			<tr>
				<th>0</th>
				<th>1</th>
				<th>2</th>
				<th>3</th>
				<th>4</th>
				<th>5</th>
				<th>6</th>
				<th>7</th>
				<th>8</th>
				<th>9</th>
				<th>10</th>
				<th>11</th>
				<th>12</th>
				<th>13</th>
				<th>14</th>
				<th>15</th>
				<th>16</th>
				<th>17</th>
				<th>18</th>
				<th>19</th>
				<th>20</th>
				<th>21</th>
				<th>22</th>
				<th>23</th>
				<th>합계</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td class="tc">${timeuseList[0].useCnt00 == null ? 0 : timeuseList[0].useCnt00}</td>
				<td class="tc">${timeuseList[0].useCnt01 == null ? 0 : timeuseList[0].useCnt01}</td>
				<td class="tc">${timeuseList[0].useCnt02 == null ? 0 : timeuseList[0].useCnt02}</td>
				<td class="tc">${timeuseList[0].useCnt03 == null ? 0 : timeuseList[0].useCnt03}</td>
				<td class="tc">${timeuseList[0].useCnt04 == null ? 0 : timeuseList[0].useCnt04}</td>
				<td class="tc">${timeuseList[0].useCnt05 == null ? 0 : timeuseList[0].useCnt05}</td>
				<td class="tc">${timeuseList[0].useCnt06 == null ? 0 : timeuseList[0].useCnt06}</td>
				<td class="tc">${timeuseList[0].useCnt07 == null ? 0 : timeuseList[0].useCnt07}</td>
				<td class="tc">${timeuseList[0].useCnt08 == null ? 0 : timeuseList[0].useCnt08}</td>
				<td class="tc">${timeuseList[0].useCnt09 == null ? 0 : timeuseList[0].useCnt09}</td>
				<td class="tc">${timeuseList[0].useCnt10 == null ? 0 : timeuseList[0].useCnt10}</td>
				<td class="tc">${timeuseList[0].useCnt11 == null ? 0 : timeuseList[0].useCnt11}</td>
				<td class="tc">${timeuseList[0].useCnt12 == null ? 0 : timeuseList[0].useCnt12}</td>
				<td class="tc">${timeuseList[0].useCnt13 == null ? 0 : timeuseList[0].useCnt13}</td>
				<td class="tc">${timeuseList[0].useCnt14 == null ? 0 : timeuseList[0].useCnt14}</td>
				<td class="tc">${timeuseList[0].useCnt15 == null ? 0 : timeuseList[0].useCnt15}</td>
				<td class="tc">${timeuseList[0].useCnt16 == null ? 0 : timeuseList[0].useCnt16}</td>
				<td class="tc">${timeuseList[0].useCnt17 == null ? 0 : timeuseList[0].useCnt17}</td>
				<td class="tc">${timeuseList[0].useCnt18 == null ? 0 : timeuseList[0].useCnt18}</td>
				<td class="tc">${timeuseList[0].useCnt19 == null ? 0 : timeuseList[0].useCnt19}</td>
				<td class="tc">${timeuseList[0].useCnt20 == null ? 0 : timeuseList[0].useCnt20}</td>
				<td class="tc">${timeuseList[0].useCnt21 == null ? 0 : timeuseList[0].useCnt21}</td>
				<td class="tc">${timeuseList[0].useCnt22 == null ? 0 : timeuseList[0].useCnt22}</td>
				<td class="tc">${timeuseList[0].useCnt23 == null ? 0 : timeuseList[0].useCnt23}</td>
				<td class="tc">${timeuseList[0].useCntTotal == null ? 0 : timeuseList[0].useCntTotal}</td>
			</tr>
		</tbody>
	</table>
	
	<div style="width:1200px;text-align:left;margin:10px;">
          <label class="laType02"><b>상위 대여소</b></label>
    </div>
    <table class="tb_type01" style="width : 1200px;">
		<thead> 
			<tr>
				<th colspan="6">아파트</th>
				<th colspan="13">대여소</th>
				<th colspan="3">대여건수</th>
				<th colspan="3">반납건수</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="highStationList" items="${highStationList}" varStatus="status">
			<tr>
				<td colspan="6">${highStationList.stationGrpName}</td>
				<td colspan="13">${highStationList.stationName}</td>
				<td class="tr" colspan="3">${highStationList.rentCnt}</td>
				<td class="tr" colspan="3">${highStationList.returnCnt}</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
    
	<div style="width:1200px;text-align:left;margin:10px;">
          <label class="laType02"><b>하위 대여소</b></label>
    </div>
    <table class="tb_type01" style="width : 1200px;">
    	<thead> 
			<tr>
				<th colspan="6">아파트</th>
				<th colspan="13">대여소</th>
				<th colspan="3">대여건수</th>
				<th colspan="3">반납건수</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="lowStationList" items="${lowStationList}" varStatus="status">
			<tr>
				<td colspan="6">${lowStationList.stationGrpName}</td>
				<td colspan="13">${lowStationList.stationName}</td>
				<td class="tr" colspan="3">${lowStationList.rentCnt}</td>
				<td class="tr" colspan="3">${lowStationList.returnCnt}</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</body>
</html>
