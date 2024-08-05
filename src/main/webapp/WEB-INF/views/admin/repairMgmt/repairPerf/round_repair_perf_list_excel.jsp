<%@ page language="java" contentType="application/vnd.ms-excel;charset=euc-kr"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
    response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode("순회정비직원실적조회.xls", "UTF8"));
    response.setHeader("Content-Description", "JSP Generated Data");
    
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko">
<head>
<title>SPB</title>
<meta content="text/html; charset=KSC5601" http-equiv="content-type" />

<link href="https://abc.bikeseoul.com/css/solbit200525.css" rel="stylesheet" type="text/css" />

<style type="text/css">

.tb-sb-1{width: 100%;}
.tb-sb-1 td {font-size:9px;}
.tb-sb-1 th {font-size:9px;}
.widscr span {font-size:9px;}

</style>

</head>
<body>
    <div class="shBox">
    	<table class="border">
    		<thead class="logo">
    			<tr><th colspan="17" class="text-center">순회정비직원 실적 조회 결과</th></tr>
			</thead>
			<tr>
				<td class="text-center">기간</td>
				<td colspan="16">
					 ${searchCondition.searchBgnDe} ~ ${searchCondition.searchEndDe}
				</td>	
			</tr>
		</table>
	</div>
	<br/>
     <!--검색조건 E-->
		<div class="widscr mt5">
			<div>
					
							<h2 style="margin-top: 20px; margin-bottom: 20px">정비실적</h2>
							<c:choose>
								<c:when test="${fn:length(wrkPerfList) ne 0 }">                       	
	                       		<table class="tb-sb-1">
									<colgroup>
	                       				<col style="width:10%">
	                       				<col style="width:10%">
	                       				<col style="width:10%">
	                       				<col style="width:10%">
	                       				<col style="width:10%">
	                       				<col style="width:10%">
	                       				<col style="width:10%">
	                       				<col style="width:10%">
	                       				<col>
	                       			</colgroup>
									<thead>
									    <tr>
									      <td class="text-center">센터구분</td>
									      <td class="text-center">이름</td>
									      <td class="text-center">비콘</td>
									      <td class="text-center">거치대</td>
									      <td class="text-center">AP</td>
									      <td class="text-center">안내간판</td>
									      <td class="text-center">수리<br/>공구대</td>
									      <td class="text-center">기타</td>
									      <td class="text-center">합계</td>
									      <td class="text-center">대여소<br/>방문</td>
									    </tr>
									</thead>
									<tbody>
									<c:set var="itemCheck" value="1" />
									<c:set var="centerCheck" value="" />
									<c:set var="nameCheck" value="" />
									<c:forEach items="${wrkPerfList}" var="item" varStatus="stat">
										<tr class="rebTr">
										 
											<td class="text-center">${item.centerName}</td>								    
											<td class="text-center">${item.adminName}</td>								    
											<td class="text-right">${item.r01}</td>								    
											<td class="text-right">${item.r02}</td>
											<td class="text-right">${item.r03}</td>
											<td class="text-right">${item.r04}</td>
											<td class="text-right">${item.r05}</td>
											<td class="text-right">${item.r06}</td>
											<td class="text-right">${item.tot}</td>
											<td class="text-right">${item.stationCnt}</td>
											
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
						<br/>
						<h2 style="margin-top: 20px; margin-bottom: 20px">상세실적(1일 단위 조회시간 조회)</h2>
						<c:choose>
								<c:when test="${fn:length(perfDtlList) ne 0 }">                       	
	                       		<table class="tb-sb-1">
									<colgroup>
	                       				<col style="width:10%">
	                       				<col style="width:20%">
	                       				<col style="width:20%">
	                       				<col style="width:20%">
	                       				<col style="width:10%">
	                       				<col style="width:10%">
	                       				<col style="width:10%">
	                       				<col>
	                       			</colgroup>
									<thead>
									    <tr>
									      <td class="text-center">센터구분</td>
									      <td class="text-center">대여소</td>
									      <td class="text-center">이름</td>
									      <td class="text-center">시간</td>
									      <td class="text-center">구분</td>
									      <td class="text-center">상세내용</td>
									      <td class="text-center">작업구분</td>
									    </tr>
									</thead>
									<tbody>
									<c:set var="itemCheck" value="1" />
									<c:set var="centerCheck" value="" />
									<c:set var="nameCheck" value="" />
									<c:forEach items="${perfDtlList}" var="item" varStatus="stat">
										<tr class="rebTr">
											<td class="text-center">${item.centerName}</td>								    
											<td class="text-center">${item.stationName}</td>								    
											<td class="text-center">${item.adminName}</td>								    
											<td class="text-center">${item.regDttm}</td>								    
											<td class="text-center">${item.repairMain}</td>
											<td class="text-center">${item.repairName}</td>
											<td class="text-center">${item.repairType}</td>
										</tr>		
									</c:forEach>
									</tbody>
									<tfoot>    
									    <tr>
									    </tr>
									</tfoot>    
	                       		</table>
	                       	</c:when>	
                      		<c:otherwise>
                                <table class="tb_type01 nbt0">
		                            <tr><td style="text-align:center"><spring:message code="search.nodata.msg" /></td></tr>
		                        </table>
							</c:otherwise>
						</c:choose>
						
						
		</div>	
  	</div>
</body>
</html>