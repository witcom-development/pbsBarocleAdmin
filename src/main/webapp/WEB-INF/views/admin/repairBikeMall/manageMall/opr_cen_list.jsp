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
	function linkPage(pageNo){ location.href = "/getManageBikeMallList.do?currentPageNo="+pageNo+"<c:out value='${parameterInfo}' escapeXml='false'/>"; }
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
						<div class="shBox">
							<form:form id="frm" commandName="form" action="/getManageBikeMallList.do" accept-charset="utf-8" modelAttribute="centerView">
								<input type="hidden" name="centerClsCD" value="CEN_003" />
								<fieldset>
									<legend>검색조건</legend>
									<div class="shBoxSection">
										<!-- <div class="section">
											<label for="centerClsCD" class="laType02">센터구분</label>
												<select class="select-category02" id="centerClsCD" name="centerClsCD">
													<option value="">선택</option>
												</select>
										</div> -->
										<div class="section">
											<label for="searchValue" class="laType02">센터명</label>
											<span class="input-text07"><form:input id="searchValue" path="searchValue" type="text" class="input-text07" maxLength="32" /></span>
											<button class="btn-srh03 btncase1" onclick="$('#frm').submit();"><img src="/images/searchIcon.gif" alt="검색" /></button>
										</div>
									</div>
								</fieldset>
							</form:form>
						</div>
						<!--검색조건 E-->
						<p class="tb_numlist">총 <c:out value="${centerView.totalRecordCount}" /> 건</p>
						<table class="tb_type01">
							<colgroup>
								<col style="width:20%" />
								<col style="width:auto" />
								<col style="width:20%" />
								<col style="width:15%" />									
								<col style="width:20%" />
							</colgroup>
							<thead>
								<tr>
									<th>센터구분</th>
									<th>센터명</th>
									<th>자치구</th>
									<th>담당자</th>
									<th>연락처</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${fn:length(centerList) > 0 }">
										<c:forEach items="${centerList}" var="centerList" varStatus="status">
											<tr>
												<td class="tc"><c:out value="${centerList.centerGubun}" /></td>
												<td class="title"><a href="/editBikeMall.do?mode=edit&centerID=${centerList.centerID}<c:if test="${centerView.currentPageNo!=0}">&currentPageNo=<c:out value='${centerView.currentPageNo}'/></c:if><c:out value='${parameterInfo}'/>"><c:out value="${centerList.centerName}" /></a></td>
												<td class="tc"><c:out value="${centerList.centerGu}" /></td>
												<td class="tc"><c:out value="${centerList.chargerName}" /></td>
												<td class="tc"><c:out value="${centerList.centerTelNO}" /></td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td class="tc" colspan="5"><spring:message code="search.nodata.msg" /></td>
										</tr>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					<c:choose>
						<c:when test="${fn:length(centerList) > 0}">
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
							<span class="right"><button class="btnType01 bc_green" onclick="location.href='/editBikeMall.do<c:if test="${centerView.currentPageNo ne '' && centerView.currentPageNo ne null}">?currentPageNo=<c:out value='${centerView.currentPageNo}'/></c:if><c:out value='${parameterInfo}' escapeXml='false'/>';">등록</button></span>
						</div>
					</div>
				</div>
				<!--content E-->
			</div>
		</div>
		
		<script type="text/javaScript">
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
			/* 센터 구분 */
			<%-- $.getJSON('/admin/manage/center/getSysCode.do?sysCode=CEN&mLang=LAG_001',function(data){ --%>
			$.getJSON('/admin/manage/center/getSysCode.do?sysCode=CEN',function(data){
				$.each(data.dataList,function(key,val){
					$("#centerClsCD").append('<option value="' + this.comCD + '">' + this.comCdName + '</option>');
				})
				var initValue = '<c:out value="${centerView.centerClsCD}"/>';
				if(initValue!=''){ $("#centerClsCD").val(initValue); }
			})
		</script>
		
		<!--footer S-->
			<tiles:insertAttribute name="footer" />
		<!--footer E-->
	</div>
</body>
</html>

