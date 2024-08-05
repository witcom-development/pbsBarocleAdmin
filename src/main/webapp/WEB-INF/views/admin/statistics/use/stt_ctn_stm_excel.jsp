<%@ page language="java" contentType="application/vnd.ms-excel;charset=euc-kr"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
    response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode("시간대별이용통계.xls", "UTF8"));
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
                    <td style="width:200px;" class="condition" colspan="3"><label class="laType02">대여일</label></td>
                    <td style="width:400px;" colspan="6">${searchCondition.searchBgnDe} ~ ${searchCondition.searchEndDe}</td>
                    <td style="width:200px;" class="condition" colspan="3"><label class="laType02">대여구분</label></td>
                    <td style="width:400px;" colspan="7">
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
                <tr>
                    <td style="width:200px;" class="condition" colspan="3"><label class="laType02">아파트</label></td>
                    <td style="width:400px;" colspan="6">
                    <c:if test='${searchCondition.stationGrp != ""}'>
                    ${dataList[0].stationGrpName}
                    </c:if>
                    </td>
                    <td style="width:200px;" class="condition" colspan="3"><label class="laType02">대여소</label></td>
                    <td style="width:400px;" colspan="7">
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
				<th>대여소명</th>
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
		<c:forEach var="result" items="${dataList}" varStatus="status">
			<tr>
				<td class="tl">${result.stationName}</td>
				<td>${result.useCntTime00}</td>
				<td>${result.useCntTime01}</td>
				<td>${result.useCntTime02}</td>
				<td>${result.useCntTime03}</td>
				<td>${result.useCntTime04}</td>
				<td>${result.useCntTime05}</td>
				<td>${result.useCntTime06}</td>
				<td>${result.useCntTime07}</td>
				<td>${result.useCntTime08}</td>
				<td>${result.useCntTime09}</td>
				<td>${result.useCntTime10}</td>
				<td>${result.useCntTime11}</td>
				<td>${result.useCntTime12}</td>
				<td>${result.useCntTime13}</td>
				<td>${result.useCntTime14}</td>
				<td>${result.useCntTime15}</td>
				<td>${result.useCntTime16}</td>
				<td>${result.useCntTime17}</td>
				<td>${result.useCntTime18}</td>
				<td>${result.useCntTime19}</td>
				<td>${result.useCntTime20}</td>
				<td>${result.useCntTime21}</td>
				<td>${result.useCntTime22}</td>
				<td>${result.useCntTime23}</td>
				<td>${result.useCntTimeTotal}</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</body>
</html>
