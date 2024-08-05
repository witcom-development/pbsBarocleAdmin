<%@ page language="java" contentType="application/vnd.ms-excel;charset=euc-kr"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="java.util.Calendar"          %>
<%
Calendar today = Calendar.getInstance();
String getNowDatetime = "" + today.get(Calendar.YEAR) + (today.get(Calendar.MONTH)+1) + today.get(Calendar.DATE) + today.get(Calendar.HOUR) + today.get(Calendar.MINUTE) + today.get(Calendar.SECOND);
    response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode("사업소현황조회_" + getNowDatetime +".xls", "UTF8"));
    response.setHeader("Content-Description", "JSP Generated Data");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko">
<head>
<title>분배원 엑셀다운로드</title>
<meta content="text/html; charset=KSC5601" http-equiv="content-type" />

<link href="https://abc.bikeseoul.com/css/solbit200525.css" rel="stylesheet" type="text/css" />
<link href="https://abc.bikeseoul.com/css/style.css" rel="stylesheet" type="text/css" />

<style type="text/css">
    .tb-sb-1 h1 { line-height: 2em; font-size: 1.8em; text-align: center}
    .tb-sb-1 h2 { line-height: 2em; font-size: 1.2em; text-align: left}
    .tb-sb-1 th { line-height: 2em; font-size: 1.1em; text-align: center}
    .tb-sb-1 td { line-height: 2em; font-size: 1.1em; text-align: right}
    tfoot    td   { line-height: 2em; font-size: 1.3em; text-align: right; background:navy;color:white}
     
</style>
</head>
<body> 
	<div class="searchArea">
		<table class="tb-sb-1">
			<thead>
	   			<tr>
	   				<th colspan="7" class="text-center"><h1 style="text-align: center">- 공공자전거 관리소 배송일지 -</h1></th>
	   			</tr>
			</thead>
			<tbody>
		     <tr>
				<td colspan="7" class="text-center">
			      	<h2></h2>
			      	<h2>▣ 일 시 : ${searchCondition.searchBgnDe} ~ ${searchCondition.searchEndDe}</h2>
			      	<h2>▣ 날 씨 : <span id="weather">${weather}</span></h2>
			      	<h2>▣ 근무인력 현황 </h2>
				</td>
			</tr>
			<tr>	
				<td colspan="7" class="text-center">
						<table class="tb-sb-1">
						<thead>
						    <tr>
						      <th>구분</th>
						      <th>총원</th>
						      <th>이동건수</th>
						      <th>설치건수</th>
						      <th>입고건수</th>
						      <th>강반건수</th>
						    </tr>
						</thead>
						<tbody>
							
							<c:forEach items="${dsOfficeList}" var="item" varStatus="stat">
								<tr>
									<td style="text-align:center">${item.officeName}</td>
									<td>${item.etc}</td>
									<td>${item.bikeMoveCnt}</td>
									<td>${item.bikeReplaceCnt}</td>
									<td>${item.warehousingCnt}</td>
									<td>${item.darTp006Cnt}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>	
				</td>	
		     </tr>
		     <tr>	
				<td colspan="7" class="text-center">
				 <h2>▣ 자전거 배송분야 </h2>
                   	<table class="tb-sb-1">
					<thead>
					    <tr>
					      <th>팀</th>
					      <th>차량번호</th>
					      <th>근무자</th>
					      <th>회수</th>
					      <th>분배</th>
					      <th>고장</th>
					      <th>강반</th>
					    </tr>
					</thead>
					<tbody>
						<c:set var = "memberCnt" value = "0" />
						<c:set var = "moveTotalCnt" value = "0" />
						<c:set var = "replaceTotalCnt" value = "0" />
						<c:set var = "wareTotalCnt" value = "0" />
						<c:set var = "darTp006TotCnt" value = "0" />
						<c:forEach items="${dsList}" var="item" varStatus="stat">
							 	<tr>
									<td style=' <c:if test="${item.teamSeq eq 'TEAM_000' }">background:beige;font-weight:bold;</c:if>'>${item.teamName}</td>								    
									<td style=' <c:if test="${item.teamSeq eq 'TEAM_000' }">background:beige;font-weight:bold;</c:if>'>${item.vcleNo}</td>								    
									<td style=' <c:if test="${item.teamSeq eq 'TEAM_000' }">background:beige;font-weight:bold;</c:if>'>${item.etc}</td>								    
									<td style=' <c:if test="${item.teamSeq eq 'TEAM_000' }">background:beige;font-weight:bold;</c:if>'>${item.bikeMoveCnt}</td>								    
									<td style=' <c:if test="${item.teamSeq eq 'TEAM_000' }">background:beige;font-weight:bold;</c:if>'>${item.bikeReplaceCnt}</td>								    
									<td style=' <c:if test="${item.teamSeq eq 'TEAM_000' }">background:beige;font-weight:bold;</c:if>'>${item.warehousingCnt}</td>								    
									<td style=' <c:if test="${item.teamSeq eq 'TEAM_000' }">background:beige;font-weight:bold;</c:if>'>${item.darTp006Cnt}</td>								    
							    </tr>
							    <c:if test="${item.teamSeq eq 'TEAM_000' }"> 
								    <c:set var= "memberCnt"    	  value="${memberCnt       + item.etc}"/>
								    <c:set var= "moveTotalCnt"    value="${moveTotalCnt    + item.bikeMoveCnt}"/>
								    <c:set var= "replaceTotalCnt" value="${replaceTotalCnt + item.bikeReplaceCnt}"/>
								    <c:set var= "wareTotalCnt"    value="${wareTotalCnt    + item.warehousingCnt}"/>
								    <c:set var= "darTp006TotCnt"  value="${darTp006TotCnt  + item.darTp006Cnt}"/>
							    </c:if>
						</c:forEach>
					
					</tbody>
					<tfoot>
					 <tr>
			            <td>총 합계</td>
			            <td></td>
			            <td><c:out value="${memberCnt}"/></td>
			            <td><c:out value="${moveTotalCnt}"/></td>
			            <td><c:out value="${replaceTotalCnt}"/></td>
			            <td><c:out value="${wareTotalCnt}"/></td>
			            <td><c:out value="${darTp006TotCnt}"/></td>
			        </tr>
					</tfoot>
				</table>
				</td>
			</tr>	
			</tbody>
		</table>
	</div>
     	
                 <%--   
                 --%>
                <%-- 
                --%>
	</div>			
</body>
</html>