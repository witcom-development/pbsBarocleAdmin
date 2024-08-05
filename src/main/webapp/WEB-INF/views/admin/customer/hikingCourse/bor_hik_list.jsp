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
	$(document).ready(function(){
		/* 에러 메시지  */
		var alertValue = "<c:out value='${resultError.errorMessage}'/>";
		if(alertValue!=""){ alert(alertValue); }
	});
	function linkPage(pageNo){ location.href = "/admin/customer/hikingCourse/hikingCourseList.do?currentPageNo="+pageNo+"<c:out value='${parameterInfo}' escapeXml='false'/>"; }
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
						<form id="frm" name="frm" accept-charset="utf-8">
							<div class="shBox">
								<fieldset>
									<legend>검색조건</legend>
									<div class="shBoxSection">
										<div class="section">
											<label for="a1" class="laType02">자치구</label>
											<select id="districtCD" name="districtCD" class="select-category01">
												<c:choose>
													<c:when test="${fn:length(categoryList) > 0 }">
														<option value="">선택</option>
														<c:forEach items="${categoryList}" var="categoryVO" varStatus="status">
															<option value="<c:out value='${categoryVO.comCD}'/>" <c:if test="${hikingCourseView.districtCD eq categoryVO.comCD}">selected="true"</c:if> ><c:out value="${categoryVO.cdDesc1}"/></option>
														</c:forEach>
													</c:when>
													<c:otherwise>
														<option value="">선택</option>
													</c:otherwise>
												</c:choose>
											</select>
										</div>
										<div class="section pright">
											<label for="searchValue" class="laType02">제목</label>
											<span class="input-text07"><input id="searchValue" name="searchValue" type="text" class="input-text07" value="${hikingCourseView.searchValue}" maxLength="32"/></span>
											<button class="btn-srh03 btncase1" onclick="document.getElementById('frm').submit();"><img src="/images/searchIcon.gif" alt="검색" /></button>
										</div>
									</div>
								</fieldset>
							</div>
						<!--검색조건 E-->
						<p class="tb_numlist">총 <c:out value="${hikingCourseView.totalRecordCount}"/>건</p>
						<table class="tb_type01">
							<colgroup>
								<col style="width:32%"/>
								<col style="width:12%"/>
								<col style="width:12%"/>
								<col style="width:10%"/>
							</colgroup>
							<thead>
								<tr>
									<th>제목</th>
									<th>자치구</th>
									<th>총거리</th>
									<th>수정일</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${fn:length(hikingCourseList) > 0 }">
										<c:forEach items="${hikingCourseList}" var="hikingCourseVO" varStatus="status">
											<tr>
												<td class="title"><a href="/admin/customer/hikingCourse/hikingCourseEdit.do?mode=edit&hikingCourseSeq=<c:out value='${hikingCourseVO.hikingCourseSeq}'/><c:if test="${hikingCourseView.currentPageNo!=0}">&currentPageNo=<c:out value='${hikingCourseView.currentPageNo}'/></c:if><c:out value='${parameterInfo}' escapeXml='false'/>"><c:out value="${hikingCourseVO.hikingCourseTitle}"/></a></td>
												<td class="tc"><c:out value="${hikingCourseVO.cdDesc1}"/></td>
												<td class="tc"><c:out value="${hikingCourseVO.courseDist}"/>Km</td>
												<td class="tc"><fmt:formatDate value="${hikingCourseVO.modDttm}" pattern="yyyy-MM-dd"/></td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td class="tc" colspan="4"><spring:message code="search.nodata.msg" /></td>
										</tr>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					<c:choose>
						<c:when test="${fn:length(hikingCourseList) > 0}">
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
						</form>
						<div class="btnArea">
							<span class="right"><button class="btnType01 bc_green" onclick="window.location='/admin/customer/hikingCourse/hikingCourseEdit.do<c:if test="${hikingCourseView.currentPageNo ne '' && hikingCourseView.currentPageNo ne null}">?currentPageNo=<c:out value='${hikingCourseView.currentPageNo}'/></c:if><c:out value='${parameterInfo}' escapeXml='false'/>';">등록</button></span>
						</div>
					</div>
				</div>
				<!--content E-->
			</div>
		</div>
		
		<script type="text/javascript">
			$(function() {	
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
			function checkSubmit(){
				$("#frm").attr('action','/admin/customer/hikingCourse/hikingCourseList.do').submit();
				return true;
			}
		</script>
		
		<!--footer S-->
			<tiles:insertAttribute name="footer" />
		<!--footer E-->
	</div>
</body>
</html>
