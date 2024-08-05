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
<script type="text/javascript">

$(function() {
	
	if("${result }" != ""){
		alert("${result}")
	}

	/* $("#searchStartDate, #searchEndDate").css('margin-right', '5px').focus(function() {
		$(this).blur();
	});

	$("#searchStartDate").datepicker({
		dateFormat : 'yy-mm-dd',
		onClose : function(selectedDate) {
			$("#searchEndDate").datepicker("option", "minDate", selectedDate);
		}
	});
	$("#searchEndDate").datepicker({
		dateFormat : 'yy-mm-dd',
		onClose : function(selectedDate) {
			$("#searchStartDate").datepicker("option", "maxDate",	selectedDate);
		}
	}); */

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

	function fn_regist(){
		$("form[name=form]").attr("action", "/admin/manage/stationGroup/stationGroupRegist.do");
		
		$("form[name=form]").submit();
	}
	
	function fn_Search(){
		
		linkPage( 1 );
		$("form[name=form]").attr("action", "/admin/manage/stationGroup/stationGroupList.do");
	
		$("form[name=form]").submit();
	}
	
	function linkPage( no ){

		$("input[name=currentPageNo]").val(no);
		
		$("form[name=form]").attr("action", "/admin/manage/stationGroup/stationGroupList.do");
		
		$("form[name=form]").submit();
	}
	
	
	
	function fn_detailInfo( key ){
		
		$("#station_grp_seq").val(key);
		
		$("form[name=form]").attr("action", "/admin/manage/stationGroup/stationGroupInfo.do");
		
		$("form[name=form]").submit();
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
				
<form action="" method="post"	name="form">				
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
										<%-- <div class="section">
											<label for="bb22" class="laType02">수정일</label>
											<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" readonly id="searchStartDate" name="searchStartDate" value="${searchVO.searchStartDate }" readonly/></span>
											<span class="dash">~</span>
											<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" readonly id="searchEndDate" name="searchEndDate" class="input" value="${searchVO.searchEndDate }"/></span>
										</div> --%>
										<div class="section">
											<label for="aa21" class="laType02">아파트명</label>
											<input name="searchValue" type="text" value="${searchVO.searchValue}" title="검색어 입력" maxlength="20" class="select-category02" >
											<button class="btn-srh03 btncase1" onclick="fn_Search(); return false;"><img src="/images/searchIcon.gif" alt="검색"></button>
										</div>
										<div class="section pright">
										</div>
									</div>
								</fieldset>
						</div>
						<!--검색조건 E-->
						<p class="tb_numlist">
							<c:if test="${paginationInfo != null }">
								총 ${paginationInfo.totalRecordCount } 건
							</c:if>
						</p>
						<table class="tb_type01">
							<caption>아파트 목록</caption>
								<colgroup>
									<col style="width:*%"/>
									<col style="width:30%"/>
									<%-- <col style="width:18%"/> --%>
								</colgroup>
							<thead>
								<tr>
									<th>아파트명</th>
									<th>수정일</th>
									<!-- <th>호환여부</th> -->
								</tr>
							</thead>
							<tbody>
							<c:forEach items="${list }" var="data">
								<tr>
									<td class="title">
										<a href="#" onclick="fn_detailInfo('${data.station_grp_seq}')">
											${data.station_grp_name }
										</a>
										<input type="hidden" name="station_grp_seq" id="station_grp_seq" value="${data.station_grp_seq}">
									</td>
									<td class="tc">
										<fmt:parseDate var="dateString" value="${data.mod_dttm }" pattern="yyyy-MM-ddHH:mm:ss" />
										<fmt:formatDate value="${dateString}" pattern="yyyy-MM-dd" />
									</td>
									<%-- 
									<td class="tc">
										${data.comptb_can_yn }
									</td>
									 --%>
								</tr>
							</c:forEach>
		
 							</tbody>
						</table>
						
						<c:if test="${paginationInfo.totalRecordCount == 0}">
							<table class="tb_type01">
								<tr>
									<td class="tc">
										no data
									</td>
								</tr>
							</table>
						</c:if>
						
						
					<c:choose>
						<c:when test="${fn:length(list) > 0}">
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
							<span class="right" onclick="fn_regist()"><button class="btnType01 bc_green">등록</button></span>
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
