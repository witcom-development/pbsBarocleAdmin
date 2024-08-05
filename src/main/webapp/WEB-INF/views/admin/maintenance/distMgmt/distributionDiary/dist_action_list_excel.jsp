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
	   				<th class="text-center"><h1 style="text-align: center">- 공공자전거 관리소 회수작업일지 -</h1></th>
	   			</tr>
			</thead>
			<tbody>
		     <tr>
				<td>
			      	<h2></h2>
			      	<h2>▣ 기간 : ${searchCondition.searchBgnDe} ~ ${searchCondition.searchEndDe}   ▣ 센터 : ${searchCondition.centerName}
			      	▣ 이름 : ${searchCondition.searchAdminName} ▣ 사유 : ${searchCondition.retTypeName}
			      	</h2>
				</td>
			</tr>	
			<tr>
				<td>
								<table class="tb_type01">
								<colgroup>
									<col style="width:13%;"/>
									<col style="width:8%;"/>
									<col style="width:8%;"/>
									<col style="width:10%;"/>
									<col style="width:10%;"/>
									<col style="width:20%;"/>
									<col style="width:10%;"/>
									<col style="width:20%;"/>
									 
								</colgroup>
								<thead>
								    <tr>
								      <th>이동일자</th>
								      <th>센터</th>
								      <th>팀</th>
								      <th>작업구분</th>
								      <th>작업자</th>
								      <th>자전거번호</th>
								      <th>주소</th>
								       <th>처리결과</th>
								    </tr>
								</thead>
								<tbody>
								<c:forEach items="${dsList}" var="item" varStatus="stat">
									 	<tr>
											<td style="text-align:center;">${item.regDttm}</td>								    
											<td style="text-align:center;">${item.centerName}</td>								    
											<td style="text-align:center;">${item.teamName}</td>								    
											<td style="text-align:center;">${item.retType}</td>								    
											<td style="text-align:right;word-break:break-all">${item.adminName}</td>
											<td style="text-align:center;">${item.bikeNo}</td>								    
											<td style="text-align:center;">${item.addr}</td>
											<td style="text-align:left;">${item.followName}</td>								    
										</tr>										      	
								</c:forEach>
								</tbody> 
                 		</table>
                 </td>
              </tr>
           </tbody>      			
	</table>
		 
</body>
</html>