<%@ page language="java" contentType="application/vnd.ms-excel;charset=euc-kr"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="java.util.Calendar"          %>
<%
Calendar today = Calendar.getInstance();
String getNowDatetime = "" + today.get(Calendar.YEAR) + (today.get(Calendar.MONTH)+1) + today.get(Calendar.DATE) + today.get(Calendar.HOUR) + today.get(Calendar.MINUTE) + today.get(Calendar.SECOND);
    response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode("회수현황조회_" + getNowDatetime +".xls", "UTF8"));
    response.setHeader("Content-Description", "JSP Generated Data");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko">
<head>
<title>회수현황 엑셀다운로드</title>
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
		<table class="tb-sb-1">
			<thead>
	   			<tr>
	   				<th class="text-center"><h1 style="text-align: center">- 공공자전거 분배실적 회수작업일지 -</h1></th>
	   			</tr>
			</thead>
			<tbody>
		     <tr>
				<td>
					<h2>▣ 기간 : ${searchCondition.searchBgnDe} ~ ${searchCondition.searchEndDe}</h2>
			      	<%-- <h2></h2>
			      	<h2>▣ 기간 : ${searchCondition.searchBgnDe} ~ ${searchCondition.searchEndDe}   ▣ 센터 : ${searchCondition.centerName}
			      	▣ 이름 : ${searchCondition.searchAdminName} ▣ 사유 : ${searchCondition.retTypeName}
			      	</h2> --%>
				</td>
			</tr>	
			<tr>
				<td>
						<p class="tb_numlist">총 ${fn:length(dsList)} 건</p>                       	
	                       		<table class="tb_type01">
									
									<colgroup>
										<col style="width:13%;"/>
										<col style="width:8%;"/>
										<col style="width:15%;"/>
										<col style="width:10%;"/>
										<col style="width:10%;"/>
										<col style="width:10%;"/>
										<col style="width:10%;"/>
										
										<col style="width:10%;"/>
										<col style="width:10%;"/>
										<col style="width:10%;"/>
										<col style="width:10%;"/>
										<%-- <col style="width:10%;"/> --%>
										<col style="width:10%;"/>
									</colgroup>
									<thead>
									    <tr>
									      <th>이름</th>
									      <th>구분</th>
									      <th>차량<br/>번호</th>
									      <th>대여소<br/>번호</th>
									      <th>배송<br/>시각</th>
									      <th>공동<br/>근무</th>
									      <th>이동</th>
									      
									      <th>재배치</th>
									      <th>경정비</th>
									      <th>입고</th>
									      <th>강반</th>
									      <!-- <th>방치</th> -->
									      <th>고장</th>
									    </tr>
									</thead>
									<tbody>
											<c:set var = "darTp001Cnt" value = "0" />
											<c:set var = "darTp002Cnt" value = "0" />
											<c:set var = "darTp003Cnt" value = "0" />
											<c:set var = "darTp005Cnt" value = "0" />
											<c:set var = "darTp006Cnt" value = "0" />
											<c:set var = "darTp008Cnt" value = "0" />
									<c:forEach items="${dsList}" var="item" varStatus="stat">
										 	<tr>
										 		<c:if test="${item.workTime eq '999' }"><c:set var = "darTp001Cnt" value = "${darTp001Cnt + item.darTp001Cnt}"/></c:if>
										 		<c:if test="${item.workTime eq '999' }"><c:set var = "darTp002Cnt" value = "${darTp002Cnt + item.darTp002Cnt}"/></c:if>
										 		<c:if test="${item.workTime eq '999' }"><c:set var = "darTp003Cnt" value = "${darTp003Cnt + item.darTp003Cnt}"/></c:if>
										 		<c:if test="${item.workTime eq '999' }"><c:set var = "darTp005Cnt" value = "${darTp005Cnt + item.darTp005Cnt}"/></c:if>
										 		<c:if test="${item.workTime eq '999' }"><c:set var = "darTp006Cnt" value = "${darTp006Cnt + item.darTp006Cnt}"/></c:if>
										 		<c:if test="${item.workTime eq '999' }"><c:set var = "darTp008Cnt" value = "${darTp008Cnt + item.darTp008Cnt}"/></c:if>
										 	
												<td style="text-align:center;<c:if test="${item.workTime eq '999' }">background:beige;font-weight:bold;</c:if>">${fn:replace(item.adminName, newLineChar, "<br/>")}</td>								    
												<td style="text-align:center;<c:if test="${item.workTime eq '999' }">background:beige;font-weight:bold;</c:if>">${item.workClassifi}</td>								    
												<td style="text-align:center;<c:if test="${item.workTime eq '999' }">background:beige;font-weight:bold;</c:if>">${item.vcleNo}</td>								    
												<td style="text-align:center;<c:if test="${item.workTime eq '999' }">background:beige;font-weight:bold;</c:if>">${item.stationNo}</td>								    
												<td style="text-align:right;<c:if test="${item.workTime eq '999' }">background:beige;font-weight:bold;</c:if>">
												<c:choose>
													<c:when test="${item.workTime eq '50' }">공동작업</c:when>
													<c:when test="${item.workTime eq '99' }">수기입출고</c:when>
													<c:when test="${item.workTime eq '999' }">합계</c:when>
													<c:otherwise>${item.workTime}</c:otherwise></c:choose>
												</td>								    
																								
												<td style="text-align:right;<c:if test="${item.workTime eq '999' }">background:beige;font-weight:bold;</c:if>">${item.etc}</td>								    
												<td style="text-align:right;<c:if test="${item.workTime eq '999' }">background:beige;font-weight:bold;</c:if>">${item.darTp001Cnt}</td>
																				    
												<td style="text-align:right;<c:if test="${item.workTime eq '999' }">background:beige;font-weight:bold;</c:if>">${item.darTp002Cnt}</td>								    
												<td style="text-align:right;<c:if test="${item.workTime eq '999' }">background:beige;font-weight:bold;</c:if>">${item.darTp003Cnt}</td>								    
												<td style="text-align:right;<c:if test="${item.workTime eq '999' }">background:beige;font-weight:bold;</c:if>">${item.darTp005Cnt}</td>								    
												<td style="text-align:right;<c:if test="${item.workTime eq '999' }">background:beige;font-weight:bold;</c:if>">${item.darTp006Cnt}</td>								    
												<td style="text-align:right;<c:if test="${item.workTime eq '999' }">background:beige;font-weight:bold;</c:if>">${item.darTp008Cnt}</td>								    
										    </tr>										      	
									</c:forEach>
											
									</tbody> 
									 
									 <tfoot>
									 		<tr>
												<td style="text-align:right;background:#CCE1FF;font-weight:bold;" id="adminName">총합</td>								    
												<td style="text-align:right;background:#CCE1FF;font-weight:bold;"></td>								    
												<td style="text-align:right;background:#CCE1FF;font-weight:bold;"></td>								    
												<td style="text-align:right;background:#CCE1FF;font-weight:bold;" id="stationNo"></td>								    
												<td style="text-align:right;background:#CCE1FF;font-weight:bold;" id="workTime"></td>								    
												<td style="text-align:right;background:#CCE1FF;font-weight:bold;" id="etc"></td>								    
												<td style="text-align:right;background:#CCE1FF;font-weight:bold;" id="darTp001Cnt"><c:out value="${darTp001Cnt}"/></td>								    
												<td style="text-align:right;background:#CCE1FF;font-weight:bold;" id="darTp002Cnt"><c:out value="${darTp002Cnt}"/></td>								    
												<td style="text-align:right;background:#CCE1FF;font-weight:bold;" id="darTp003Cnt"><c:out value="${darTp003Cnt}"/></td>								    
												<td style="text-align:right;background:#CCE1FF;font-weight:bold;" id="darTp005Cnt"><c:out value="${darTp005Cnt}"/></td>								    
												<td style="text-align:right;background:#CCE1FF;font-weight:bold;" id="darTp006Cnt"><c:out value="${darTp006Cnt}"/></td>								    
												<td style="text-align:right;background:#CCE1FF;font-weight:bold;" id="darTp008Cnt"><c:out value="${darTp008Cnt}"/></td>								    
											</tr>
									 </tfoot>
									 
	                       		</table>
                 </td>
              </tr>
           </tbody>      			
	</table>
		 
</body>
</html>