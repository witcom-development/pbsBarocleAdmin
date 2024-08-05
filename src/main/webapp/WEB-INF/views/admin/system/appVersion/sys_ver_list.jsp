<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" /> 
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />
<meta name="description=" Content="" />
<title><tiles:insertAttribute name="title"/></title>
<tiles:insertAttribute name="resource"/>
<script type="text/javaScript">
	$(function() {	
		/* 에러 메시지  */
		var alertValue = "<c:out value='${resultError.errorMessage}'/>";
		if(alertValue!=""){ alert(alertValue); }
		
		var totalPageCount = '${paginationInfo.totalPageCount}' == '' ? 1 : Number('${paginationInfo.totalPageCount}');
   		$('#prevPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			linkPage(currentPageNo-1);
		});
		$('#nextPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			linkPage(currentPageNo+1);
		});
		$('#movePage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			var regExp = /^[1-9]?[0-9]/;
			if(!regExp.test(currentPageNo) ||(totalPageCount < currentPageNo)){
				alert('현재 페이지 값이 정상적이지 않습니다.');
			}else{
				linkPage(currentPageNo);
			}
		});
	});
	function linkPage(pageNo){ location.href = "/admin/system/appVersion/appVersionList.do?currentPageNo="+pageNo+"<c:out value='${parameterInfo}' escapeXml='false'/>"; }
	
</script>
</head>
<body>
	<div class="allwrap">
		<!--모바일 메뉴 S-->
			<tiles:insertAttribute name="header" />
		<!--모바일 메뉴 E-->
		<!--Head S-->
			<tiles:insertAttribute name="head" />
		<!--Head E-->
		<div id="body">
			<div class="cont">
				<!--left menu S-->
					<tiles:insertAttribute name="left" />
				<!--left menu E-->
				<!--content S-->
				<div class="content">
					<div class="subject">
						<!--subject path S-->
							<tiles:insertAttribute name="subject" />
						<!--subject path E-->
					</div>
					<div class="page">
						<!-- 모바일 검색조건 S-->
						<div class="shBox_m">
							<div class="downtitle">
								<div class="title">
									<p>검색조건</p><span><button><img src="/images/srh_open.png" alt="검색조건 열기" /></button></span>
								</div>
							</div>
						</div>
						<!-- 모바일 검색조건 E-->
						<!--검색조건 S-->
						<%-- 
						<div class="shBox">
							<form:form id="frm" commandName="form" action="/admin/system/appVersion/appVersionList.do" accept-charset="utf-8" modelAttribute="appVersionView">
								<fieldset>
									<legend>검색 옵션</legend>
									<div class="shBoxSection">
										<div class="section">
											<label for="osClsCD" class="laType03">OS 구분</label>
											<select id="osClsCD" name="osClsCD" class="select-category03">
													<option value="">선택</option>
												<c:forEach items="${appVersionView.codeOSS}" var="codeOss" varStatus="status">
													<option value="${codeOss.comCD}" <c:if test="${codeOss.comCD eq appVersionView.osClsCD}">selected="true"</c:if>><c:out value="${codeOss.cdDesc1}"/></option>
												</c:forEach>
											</select>
										</div>
										<div class="section pright">
											<label for="updateClsCD" class="laType03">업데이트구분</label>
											<select id="updateClsCD" path="updateClsCD" class="select-category03">
													<option value="">선택</option>
												<c:forEach items="${appVersionView.codeUDT}" var="codeUdt" varStatus="status">
													<option value="${codeUdt.comCD}" <c:if test="${codeUdt.comCD eq appVersionView.updateClsCD}">selected="true"</c:if>><c:out value="${codeUdt.cdDesc1}"/></option>
												</c:forEach>
											</select>
											<button class="btn-srh03 btncase1" onclick="$('#frm').submit();"><img src="/images/searchIcon.gif" alt="검색"></button>
										</div>
									</div>
								</fieldset>
							</form:form>
						</div>
						 --%>
						<!--검색조건 E-->
						<p class="tb_numlist">총 <c:out value="${appVersionView.totalRecordCount}" /> 건</p>
						<table class="tb_type01">
							<colgroup>
								<col style="width:20%"/>
								<col style="width:40%"/>
								<col style="width:20%"/>
								<col style="width:20%"/>
							</colgroup>
							<thead>
								<tr>
									<th>OS구분</th>
									<th>Version</th>
									<th>수정자</th>
									<th>수정일</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${fn:length(appVersionList) > 0 }">
										<c:forEach items="${appVersionList}" var="appVersionList" varStatus="status">
											<tr>
												<td class="title"><a href="/admin/system/appVersion/appVersionEdit.do?mode=edit&appSeq=<c:out value='${appVersionList.appSeq}'/><c:if test="${appVersionView.currentPageNo!=0}">&currentPageNo=<c:out value='${appVersionView.currentPageNo}'/></c:if><c:out value='${parameterInfo}' escapeXml='false'/>"><c:out value="${appVersionList.osClsName}"/></a></td>
												<td class="tc"><c:out value="${appVersionList.appVerInfo}"/></td>
												<td class="tc"><c:out value="${appVersionList.adminName}"/>(<c:out value="${appVersionList.adminID}"/>)</td>
												<td class="tc"><fmt:formatDate value="${appVersionList.regDttm}" pattern="yyyy.MM.dd"/></td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td colspan="5"><spring:message code="search.nodata.msg" /></td>
										</tr>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					<c:choose>
						<c:when test="${fn:length(appVersionList) > 0}">
							<div class="drpaging">
						</c:when>
						<c:otherwise>
							<div class="drpaging" style="display:none;">
						</c:otherwise>
					</c:choose>
							<c:choose>
							<c:when test="${paginationInfo.currentPageNo > 1}">
								<a id="prevPage" href="#"><img src="/images/p_prev.gif" alt="이전 페이지" /></a>
							</c:when>
							<c:otherwise>
								<a href="#"><img src="/images/p_prev.gif" alt="이전 페이지" /></a>
							</c:otherwise>
							</c:choose>
							<span><input name="currentPageNo" type="number" value="${paginationInfo.currentPageNo}"/><em>/ ${paginationInfo.totalPageCount}</em><button id="movePage">이동</button></span>
							<c:choose>
							<c:when test="${paginationInfo.currentPageNo < paginationInfo.totalPageCount}">
							<a id="nextPage" href="#"><img src="/images/p_next.gif" alt="다음 페이지" /></a>
							</c:when>
							<c:otherwise>
								<a href="#"><img src="/images/p_next.gif" alt="다음 페이지" /></a>
							</c:otherwise>
							</c:choose>
						</div>
						<div class="btnArea">
							<span class="right"><button class="btnType01 bc_green" onclick="location.href='/admin/system/appVersion/appVersionEdit.do<c:if test="${appVersionView.currentPageNo ne '' && appVersionView.currentPageNo ne null}">?currentPageNo=<c:out value="${appVersionView.currentPageNo}"/></c:if><c:out value="${parameterInfo}" escapeXml="false"/>';">등록</button></span>
						</div>
					</div>
				</div>
				<!--content E-->
			</div>
		</div>
		
		<!--footer S-->
			<tiles:insertAttribute name="footer" />
		<!--footer E-->
	</div>
</body>
</html>
