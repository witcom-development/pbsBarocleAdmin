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
	function linkPage(pageNo){ location.href = "/admin/manage/relocationCar/relocationCarList.do?currentPageNo="+pageNo+"<c:out value='${parameterInfo}' escapeXml='false'/>"; }
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
							<form:form id="frm" commandName="form" action="/admin/manage/relocationCar/relocationCarList.do" accept-charset="utf-8" modelAttribute="relocationCarView">
								<fieldset>
									<legend>검색조건</legend>
									<div class="shBoxSection">
										<div class="section">
											<label for="assignCenterID" class="laType02">소속 센터</label>
												<select class="select-category02" id="assignCenterID" name="assignCenterID">
													<option value="">선택</option>
												</select>
										</div>
										<div class="section pright ptr">
											<label for="carNO" class="laType02">차량번호</label>
											<span class="input-text03 input-text03p"><form:input id="searchValue" path="searchValue" type="text" class="input-text07" maxLength="32" /> (뒷4자리)</span>
											<button class="btn-srh03 btncase1" onclick="$('#frm').submit();"><img src="/images/searchIcon.gif" alt="검색" /></button>
										</div>
									</div>
								</fieldset>
							</form:form>
						</div>
						<!--검색조건 E-->
						<p class="tb_numlist">총 <c:out value="${relocationCarView.totalRecordCount}" /> 건</p>
						<table class="tb_type01">
							<colgroup>
								<col style="width:auto" />
								<col style="width:20%" />
								<col style="width:30%" />
							</colgroup>
							<thead>
								<tr>
									<th>아파트</th>
									<th>차종</th>
									<th>차량번호</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${fn:length(relocationCarList) > 0 }">
										<c:forEach items="${relocationCarList}" var="relocationCarList" varStatus="status">
											<tr>
												<td class="title">&nbsp;<c:out value="${relocationCarList.centerName}" /></td>
												<td class="tc"><c:out value="${relocationCarList.carModlName}" /></td>
												<td class="tc"><a href="/admin/manage/relocationCar/relocationCarEdit.do?relocateCarID=${relocationCarList.relocateCarID}<c:if test="${relocationCarView.currentPageNo!=0}">&currentPageNo=<c:out value='${relocationCarView.currentPageNo}'/></c:if><c:out value='${parameterInfo}'/>"><c:out value="${relocationCarList.carNO}" /></a></td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td class="tc" colspan="3"><spring:message code="search.nodata.msg" /></td>
										</tr>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					<c:choose>
						<c:when test="${fn:length(relocationCarList) > 0}">
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
							<span class="right"><button class="btnType01 bc_green" onclick="location.href='/admin/manage/relocationCar/relocationCarEdit.do<c:if test="${relocationCarView.currentPageNo ne '' && relocationCarView.currentPageNo ne null}">?currentPageNo=<c:out value='${relocationCarView.currentPageNo}'/></c:if><c:out value='${parameterInfo}' escapeXml='false'/>';">등록</button></span>
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
			/* 아파트 */
			$.getJSON('/admin/manage/relocationCar/getCenterList.do?centerClsCD=CEN_001',function(data){
				$.each(data.dataList,function(key,val){
					$("#assignCenterID").append('<option value="' + this.centerID + '">' + this.centerName + '</option>');
				})
				var initValue = '<c:out value="${relocationCarView.assignCenterID}"/>';
				if(initValue!=''){ $("#assignCenterID").val(initValue); }
			})
		</script>
		
		<!--footer S-->
			<tiles:insertAttribute name="footer" />
		<!--footer E-->
	</div>
</body>
</html>
