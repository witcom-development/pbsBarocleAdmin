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
$(document).ready(function(){
	saveCarbon.initSearch();

});
var saveCarbon = {};

saveCarbon.initSearch = function(){
	$("#searchStartDate").val("${saveCarbonVo.searchStartDate}");
	$("#searchEndDate").val("${saveCarbonVo.searchEndDate}");
	
	if("${saveCarbonVo.searchParameter}" !== null && "${saveCarbonVo.searchParameter}" !== ""){
		$("#searchParameter").val("${saveCarbonVo.searchParameter}");
	}
	
	if("${saveCarbonVo.searchValue}" !== null && "${saveCarbonVo.searchValue}" !== ""){
		$("#searchValue").val("${saveCarbonVo.searchValue}");
	}
	
	if("${saveCarbonVo.goalCd}" !== null && "${saveCarbonVo.goalCd}" !== ""){
		$("#goalCd").val("${saveCarbonVo.goalCd}");
	}
	
	if("${saveCarbonVo.meansCd}" !== null && "${saveCarbonVo.meansCd}" !== ""){
		$("#meansCd").val("${saveCarbonVo.meansCd}");
	}
}

function linkPage(pageNo){ location.href = "/admin/system/savecarbon/saveCarbonList.do?currentPageNo="+pageNo+"<c:out value='${parameterInfo}' escapeXml='false'/>"; }
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
				<div class="content">
					<div class="subject">
						<!--subject path S-->
							<tiles:insertAttribute name="subject" />
						<!--subject path E-->
					</div>
					<form name="frm" id="searchFrm" method="post">	
						<input type="hidden" name="listType" value="U"/>
						<input type="hidden" name="paymentClsCdName" value=""/>	
						<input type="hidden" name="usr_seq"	id="usr_seq">
						<input type="hidden" name="carbon_seq"	id="carbon_seq">
						<input type="hidden" id="totalCnt" name="totalCnt" value="${paginationInfo.totalPageCount}">
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

						<fieldset>
							<table class="tb_type02 mt20">
								<colgroup>
									<col style="width:40%">
									<col style="width:60%">
								</colgroup>
								
								<tbody>
									<tr>
										<th class="top">기간내 절감탄소량</th>
										<td class="top">${totSaveCarbon }</td>
									</tr>
								</tbody>
							</table>
						</fieldset>
						
						<!--검색조건 S-->
						<div class="shBox">
							<fieldset>
								<legend>검색조건</legend>
								<div class="shBoxSection">
									<div class="section">
										<label for="bb22" class="laType02">조회일</label>
										<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" id="searchStartDate" name="searchStartDate" readonly/></span>
										<span class="dash">~</span>
										<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" id="searchEndDate" name="searchEndDate" readonly/></span>
									</div>

									<div class="section">
										<label for="aa1" class="laType02">구분</label>
										<select class="select-category07" id="searchParameter" name="searchParameter" style="width: 105px;">
											<option value="ID">ID</option>
											<option value="PHONE">휴대번호</option>
										</select>
										
										<span class="input-text08"><input type="text" class="" id="searchValue" name="searchValue" style="width: 110px;"></span>
										
									</div>
									
									<div class="section">
										<label for="aa1" class="laType02">이용목적</label>
										<select class="select-category07" id="goalCd" name="goalCd" style="width: 233px;">
											<option value="">선택</option>
											<c:forEach items="${goalList }" var="goal">
												<option value="${goal.goalCd }">${goal.goalNm }</option>
											</c:forEach>
										</select>
									</div>
									
									<div class="section">
										<label for="aa1" class="laType02">이용수단</label>
										<select class="select-category07" id="meansCd" name="meansCd" style="width: 233px;">
											<option value="">선택</option>
											<c:forEach items="${meansList }" var="means">
												<option value="${means.meansCd }">${means.meansNm }</option>
											</c:forEach>
										</select>
										
										<button class="btn-srh03 btncase1 mdbtncase1" id= "searchBtn"><img src="/images/searchIcon.gif" alt="검색" /></button>
									</div>
								</div>
								
							</fieldset>
						</div>
						<!--검색조건 E-->					
						<div style="margin-top: 25px;">
						<p class="tb_numlist">
							<c:if test="${paginationInfo != null }">
								총 ${paginationInfo.totalRecordCount } 건
							</c:if>
						</p>
						<table class="tb_type01">
							<colgroup>
								<col style="width:25%"/>
								<col style="width:25%"/>
								<col style="width:25%"/>
								<col style="width:25%"/>
								<!--[if gt IE 8]><!--><col style="width:25%" class="mhid"/><!--<![endif]-->
							</colgroup>
							<thead>
								<tr>
									<th>아이디</th>
									<th>이용목적</th>
									<th>이용수단</th>
									<th>절감탄소량</th>
									<th>등록/수정일시</th>
									<!-- <!--[if gt IE 8]><th class="mhid">등록/수정일시</th><![endif] -->
								</tr>
							</thead>
							<tbody>
								<c:forEach var="SC"	items="${saveCarbonList }">
									<tr>
										<td class="title"><a href="#" onclick="fn_MemberDetail('${SC.usr_seq }','${SC.carbon_seq }'); return false;">${SC.mb_id }</a></td>
										<td class="tc">${SC.usingPurpose }</td>
										<td class="tc">${SC.usingMeans }</td>
										<td class="tc">${SC.reduce_co2 }</td>
										<!--[if gt IE 8]><!-->
										<td class="tc">${SC.regDttm }</td>
										<%-- <td class="mhid tc">
											<fmt:parseDate var="dateString" value="${SC.regDttm }" pattern="yyyy-MM-ddHH:mm:ss" />
										<fmt:formatDate value="${dateString}" pattern="yyyy-MM-dd" />
										</td><!--<![endif]--> --%>
									</tr>
								</c:forEach>
								<c:if test="${fn:length(saveCarbonList) eq 0 }">
									<table class="tb_type01 nbt0">
										<tr><td style="text-align:center"><spring:message code="search.nodata.msg" /></td></tr>
									</table>
								</c:if>
							</tbody>
							</table>
							
							<c:choose>
								<c:when test="${fn:length(saveCarbonList) > 0}">
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
							<span><input name="currentPageNo" id="currentPageNo" type="number" value="${paginationInfo.currentPageNo}"/><em>/ ${paginationInfo.totalPageCount}</em><button id="movePage">이동</button></span>
							<c:choose>
							<c:when test="${paginationInfo.currentPageNo < paginationInfo.totalPageCount}">
							<a id="nextPage" href="#"><img src="/images/p_next.gif" alt="다음 페이지" /></a>
							</c:when>
							<c:otherwise>
								<a href="#"><img src="/images/p_next.gif" alt="다음 페이지" /></a>
							</c:otherwise>
							</c:choose>
							</div>
						</div>
					</form>
				</div>
				<!--content E-->
			</div>
		</div>
	</div>
	
	<!--footer S-->
		<tiles:insertAttribute name="footer" />
	<!--footer E-->
	
	<script type="text/javascript" src="/js/common_barocle.js"></script>
	<script type="text/javascript">
	$(function() {	
		
		// 공통부분(paging 처리 - prev, next, move, move validation)
		var totalCnt  = $("#totalCnt").val();
		isPaging('searchFrm','/admin/system/savecarbon/saveCarbonList.do',totalCnt);
		
		/* $("#nextPage").click(function(){
			if($("#searchStartDate").val()  &&  $("#searchEndDate").val())
				if($("#searchStartDate").val() > $("#searchEndDate").val()){
					alert('<spring:message code="fail.input.daterange" />');
					return;
				}
				$("#currentPageNo").val(Number($("#currentPageNo").val())+1);
				
				$("#searchFrm").attr({method : 'post', action : '/admin/system/savecarbon/saveCarbonList.do'}).submit();
		});
		
		//prev page
		$("#prevPage").click(function(){
			if($("#searchStartDate").val()  &&  $("#searchEndDate").val())
				if($("#searchStartDate").val() > $("#searchEndDate").val()){
					alert('<spring:message code="fail.input.daterange" />');
					return;
				}
				$("#currentPageNo").val(Number($("#currentPageNo").val())-1);
				
				$("#searchFrm").attr({method : 'post', action : '/admin/system/savecarbon/saveCarbonList.do'}).submit();
		});
		
		$("#movePage").click(function(){
			if(Number($("#currentPageNo").val()) > $("#totalPage").val()){
				alert("현재 페이지 값이 정상적이지 않습니다.");
				return false;
			}
		}); */
		
		$("#searchBtn").on("click", function() {
	    	if(DateUtil.checkDateTerm( $( "[name='searchStartDate']").val(),  $( "[name='searchEndDate']").val()) !== 'ok') {
	    		alert("검색 조건의 시작 날이 종료 날보다 큽니다.");
	    		$( "[name='searchStartDate']").val('');
	    		$( "[name='searchEndDate']").val('');
	    		return false;
	    	}
	        $("[name='currentPageNo']").val("1");
	        $("#searchFrm").attr({method : 'post', action : '/admin/system/savecarbon/saveCarbonList.do'}).submit();
	    });
	});

	var previousValue;
	$("input").on('focus',function(){
		previous = this.value;
	}).change(function(){
		var sDate = $("#searchStartDate").val();
		var eDate = $("#searchEndDate").val();
		if(sDate!=''&&eDate!=''&&sDate>eDate){
			alert("수정일 시작 시간이 종료 시간보다 빠를 수 없습니다.");
			$(this).val(previous);
		}
	});
	
	function fn_MemberDetail(seq,carbonSeq){

		$("#usr_seq").val(seq);
		
		$("#carbon_seq").val(carbonSeq);
		
		$("#searchFrm").attr("action", "/admin/service/member/memberInfo.do");

		$("#searchFrm").submit();
	}
	</script>
</body>
</html>
