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
<script type="text/javaScript" language="javascript">
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

	/* 글 수정 화면 function */
	function groInfo(grpCd) {
		document.searchFrm.usrGrpCd.value = grpCd;
	   	document.searchFrm.action = "<c:url value='/admin/system/userGroup/groInfo.do'/>";
	   	document.searchFrm.submit();
	}
	
	/* 글 등록 화면 function */
	function goGroInsertForm() {
	   	document.searchFrm.action = "<c:url value='/admin/system/userGroup/groInsertForm.do'/>";
	   	document.searchFrm.submit();
	}
	
	/* 글 목록 화면 function */
	function searchGroList() {
		linkPage(1);
	}
	
	/* pagination 페이지 링크 function */
	function linkPage(pageNo){
		document.searchFrm.currentPageNo.value = pageNo;
		document.searchFrm.action = "<c:url value='/admin/system/userGroup/groupList.do'/>";
	   	document.searchFrm.submit();
	}


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
				<!--conteent S-->
				<form name="searchFrm"	id="searchFrm" method="post">
					<div class="content">
					<div class="subject">
						<p class="pageTitle">운영자 그룹 관리 - 목록</p>
						<span>시스템 관리 &gt; <em>운영자 그룹 관리</em></span>
					</div>
					<div class="page">
						<!-- 모바일 검색조건 S-->
						<div class="shBox_m">
							<div class="downtitle">
								<div class="title">
									<p>검색조건</p><span><button type="button"><img src="/images/srh_open.png" alt="검색조건 열기" /></button></span>
								</div>
							</div>
						</div>
						<!-- 모바일 검색조건 E-->
						<!--검색조건 S-->
						<div class="shBox">
							<fieldset>
								<legend>검색 옵션</legend>
								<div class="shBoxSection">
									<div class="section">
										<label for="a1" class="laType02">관리구분</label>
										<select class="select-category03" id="admin_cls_cd"	name="admin_cls_cd">
											<option value="">선택</option>
												<c:forEach var="result" items="${codeList}" varStatus="status">
													<c:if test="${searchVO.admin_cls_cd == result.comCd}">
														<option value="${result.comCd}" selected="selected"><c:out value="${result.comCdName}"/></option>
													</c:if>
													<c:if test="${searchVO.admin_cls_cd != result.comCd}">
														<option value="${result.comCd}" ><c:out value="${result.comCdName}"/></option>
													</c:if>
													
												</c:forEach>
										</select>
									</div>
									<div class="section pright">
										<label for="aa11" class="laType02">그룹명</label>
										<span class="input-text07"><input type="text" class="" id="grpName" name="grpName" value="${searchVO.grpName}"/></span>
										<button class="btn-srh03 btncase1" onclick="searchGroList(); return false;"><img src="/images/searchIcon.gif" alt="검색"></button>
									</div>
								</div>
							</fieldset>
						</div>
						<!--검색조건 E-->
						<p class="tb_numlist">
							총 ${paginationInfo.totalRecordCount } 건
						</p>
						<table class="tb_type01">
							<colgroup>
								<col style="width:15%"/>
								<col style="width:20%"/>
								<col style="width:15%"/>
								<col style="width:15%"/>
								<col style="width:15%"/>
							</colgroup>
							<thead>
								<tr>
									<th>그룹이름</th>
									<th>관리구분</th>
									<th>수정자</th>
									<th>인원</th>
									<th>수정일</th>
								</tr>
							</thead>
							<tbody>
								<c:if test="${fn:length(groList) > 0 }">                  
									<c:forEach var="result" items="${groList}" varStatus="status">
	                                <tr>
	                                    <td style="text-align: left; padding-left: 1%;">
	                                    	<a href="javascript:groInfo('<c:out value="${result.usrGrpCd}"/>');"><c:out value="${result.grpName}"/></a>
	                                    </td>
	                                    <td style="text-align: left; padding-left: 1%;">
	                                    	<c:out value="${result.usrGrpCdName}"/>
	                                    </td>
	                                    <td style="text-align: left; padding-left: 1%;"><c:out value="${result.mod_id}"/></td>
	                                    <td class="tr pr10">${result.admin}</td>
	                                    <td class="tc">
	                                    	<fmt:parseDate value="${result.modDate}" var="dateString" pattern="yyyy-MM-dd HH:mm:ss"></fmt:parseDate>
	                                    	<fmt:formatDate value="${dateString }"	pattern="yyyy-MM-dd"/>
	                                    </td>
	                                </tr>
									</c:forEach>
								</c:if>
                            	<c:if test="${fn:length(groList) == 0 }">  
	                                <tr>
	                                	<td colspan="5" class="tc"><spring:message code="info.nodata.msg" /></td>
	                                </tr>
								</c:if>
							</tbody>
						</table>
					<c:choose>
						<c:when test="${fn:length(groList) > 0}">
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
						<input type="hidden" id="usrGrpCd" name="usrGrpCd" value=""/>
						<div class="btnArea">
							<span class="right" onclick="goGroInsertForm(); return false;"><button class="btnType01 bc_green">등록</button></span>
						</div>
					</div>
				</div>
				</form>
				<!--content E-->
			</div>
		</div>
		<!--footer S-->
			<tiles:insertAttribute name="footer" />
		<!--footer E-->
	</div>
</body>
</html>
