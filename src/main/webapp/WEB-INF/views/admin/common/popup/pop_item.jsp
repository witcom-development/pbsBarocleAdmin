<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" /> 
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />
<meta name="description=" Content="" />
<%@ include file="../popup/pop_resource.jsp" %>
</head>
<body>
	<h1 class="popTtl">기타의견 리스트</h1>
		<div id="body2">
					<div class="page">
						<!-- 모바일 검색조건 S-->
						<form id="searchFrm">
						<!--검색조건 E-->
						<p class="tb_numlist" style="margin-right: 5px; font-size: 15px" >총 ${fn:length(resultList)} 건</p>
						<table class="tb_type01">
							<colgroup>
								<col style="width:40%"/>
								<col style="width:55%"/>
							</colgroup>
							<thead>
								<tr>
									<th>작성자 ID</th>
									<th>답글</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${resultList}" var="result" varStatus="status">
	                                <tr>
	                                    <td>${result.regID}</td>
	                                    <td>${result.itemContent}</td>
	                                </tr>
                                </c:forEach>
                                <c:if test="${fn:length(resultList) eq 0 }">
	                                <table class="tb_type01 nbt0">
			                            <tr><td style="text-align:center"><spring:message code="search.nodata.msg" /></td></tr>
			                        </table>
								</c:if>
							</tbody>
						</table>
						</form>
				<!--content E-->
			</div>
	</div>
</body>
</html>