<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<h1><c:out value="${helloWorld.message}"/></h1>

<h4><spring:message code="sample.availableLanguages"/></h4>
<ul>
<c:forEach var="language" items="${availableLanguages}">
	<li><a href="<c:url value="/helloWorld.do?lang=${language}"/>"><spring:message code="sample.language.${language}"/></a></li>
</c:forEach>
</ul>

<table>
	<tr>
		<td width="100px" align="center">아이디</td>
		<td width="100px" align="center">성명</td>
		<td width="100px" align="center">구분</td>
		<td width="100px" align="center">비밀번호</td>
		<td width="100px" align="center">휴대전화번호</td>
	</tr>
	<!-- result는 contoller의 addObject로 부터 가져온다. -->
	<c:forEach items="${membersInfo}" var="members">
		<tr>
		    <td align="center">${members.member_id}</td>
			<td align="center">${members.member_name}</td>
			<td align="center">${members.member_type}</td>
			<td align="center">${members.member_password}</td>
			<td align="center">${members.member_cellno}</td>    
		</tr>
	</c:forEach>
 </table>
