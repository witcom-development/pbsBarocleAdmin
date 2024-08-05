<%@ page language="java" contentType="application/vnd.ms-excel;charset=euc-kr"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
    response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode("배송원 경정비실적조회.xls", "UTF8"));
    response.setHeader("Content-Description", "JSP Generated Data");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko">
<head>
<title>SPB</title>
<meta content="text/html; charset=KSC5601" http-equiv="content-type" />
<style>
.tb_type01 th {text-align:center;padding:5% 0;}
.tb_type01 td {text-align:center;padding:5% 0}
.tb_type01 {width:100%;border:2px solid #212529;font-size:15px;table-layout:fixed}
.tb_type01 th {text-align:center;padding:15px 0;background:#b3c5ce;border-right:thin solid #212529; border-bottom:thin solid #212529;}
.tb_type01 td {text-align:left;padding:10px 2px;border:thin solid #212529; }
.tb_type01 td.txRight {text-align:right;}
.tb_type01 td.txCenter {text-align:center;}
.tb_condition {width:1200px;border: 2px solid #212529;}
.tb_condition th {text-align:center;padding:15px 0;background:#b3c5ce; border-bottom:thin solid #212529;}
.tb_condition td {text-align:center;padding:15px 0;border: thin solid #212529;}
.tb_condition td.condition {width:150px;text-align:center;padding:15px 0;background:#FFFF99;}
.tb_condition label {background:#b3c5ce;}

/*label*/
.laType02 {margin-right:5px;display:inline-block;font-size:11px;}


</style>
</head>
<body>
    <div class="shBox">
    	<table class="tb_condition">
    		<thead class="logo">
    			<tr><th colspan="8">배송원 실적 조회 결과</th></tr>
			</thead>
			<tr>
				<td>
					<label>기간</label>
				</td>
				<td>	
					<span>${searchCondition.searchBgnDe} ~ ${searchCondition.searchEndDe}</span>
				</td>
				<td>
					<label>직원명</label>
				</td>
				<td>	
					<span>${searchCondition.searchAdmin}</span>
				</td>
				<td>
					<label>사업소</label>
				</td>
				<td>	
					<span>${searchCondition.searchOffice}</span>
				</td>
				<td>
					<label>센터</label>
				</td>
				<td>	
					<span>${searchCondition.searchCenter}</span>
				</td>	
			</tr>
			  
		</table>
	</div>
    
    <div style="width:1000px;text-align:right;margin:20px;">
         
    </div>
    
     <!--검색조건 E-->
		<div class="widscr mt5">
		
				<c:choose>
					<c:when test="${fn:length(wrkLightList) ne 0 }">                       	
                     		<table class="tb-sb-1">
						<thead>
						    <tr>
						      <td class="top text-center" rowspan="2" style="width:15%;">사업소</td>
						      <td class="top text-center" rowspan="2" style="width:15%;">팀</td>
						      <td class="top text-center" rowspan="2" style="width:15%;">id</td>
						      <td class="top text-center" rowspan="2" style="width:15%;">이름</td>
						      <td class="top text-center" colspan="4" style="width:45%;">정비내역</td>
						      <td class="top text-center" rowspan="2" style="width:5%;">완료건수</td>
						      <td class="top text-center" rowspan="2" style="width:5%;">자전거대수</td>
						    </tr>
						    <tr>
						      <td class="text-center">스탠드</td>
						      <td class="text-center">물받이</td>
						      <td class="text-center">타이어 튜브</td>
						      <td class="text-center">배터리 교체</td>
						    </tr>
						</thead>
						<tbody>
						<c:set var="itemCheck" value="1" />
						<c:set var="centerCheck" value="" />
						<c:set var="nameCheck" value="" />
						<c:forEach items="${wrkLightList}" var="item" varStatus="stat">
						    
						    <c:choose>

								<c:when test="${item.repairCenterName eq '합계'}"><tr class="rebTr" style="background-color:#93DAFF; height: 4em "></c:when>
								<c:when test="${item.repairTeamName eq '합계'}"><tr class="rebTr" style="background-color:#FFAAAF; height: 3em "></c:when>
								<c:when test="${item.repairAdminId eq '합계'}"><tr class="rebTr" style="background-color:#E6FFE6; height: 2em "></c:when>
								<c:otherwise><tr class="rebTr"></c:otherwise>
							</c:choose>
						    
						      	<td class="text-center" >${item.repairCenterName }</td>
						      	<td class="text-center" >${item.repairTeamName }</td>
						      	<td class="text-center" >${item.repairAdminId }</td>
						      	<td class="text-center" >${item.repairAdminName}</td>
								<td class="text-right">${item.REB_009}</td>								    
								<td class="text-right">${item.REB_018}</td>								    
								<td class="text-right">${item.REB_024}</td>								    
								<td class="text-right">${item.REB_057}</td>								    
								<td class="text-right">${item.repairTotCnt}</td>								    
								<td class="text-right">${item.repairBikeCnt}</td>								    
						    </tr>
						</c:forEach>
						    
						</tbody> 
                     		</table>
                     	</c:when>	
                     	
                   		<c:otherwise>
                             <table class="tb_type01 nbt0">
                           <tr><td style="text-align:center"><spring:message code="search.nodata.msg" /></td></tr>
                       </table>
				</c:otherwise>
			</c:choose>
		
  	</div>
</body>
</html>