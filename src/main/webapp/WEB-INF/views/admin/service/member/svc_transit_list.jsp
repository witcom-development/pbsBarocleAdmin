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
	
	$("#searchStartDate").val("${form.searchStartDate}");
	$("#searchEndDate").val("${form.searchEndDate}");
	$("#searchValue").val("${form.searchValue}");
	
	if("${form.searchParameter}" != ""){
		$("#searchParameter").val("${form.searchParameter}");
	}
	
});

function linkPage(no){
	
	if($("#searchStartDate").val()  &&  $("#searchEndDate").val())
	if($("#searchStartDate").val() > $("#searchEndDate").val()){
		alert('<spring:message code="fail.input.daterange" />');
		return;
	}
	
	
	$("#searchValue").val($("#searchValue").val().replace(/ /g, ''));	// 공백제거
	
	$("#currentPageNo").val(no);
	$("#frm").attr("action", "/admin/service/member/publicTransitList.do");

	$("#frm").submit();
}

function fn_search(){
	linkPage(1);
}

function fn_MemberDetail(seq){
	
	$("#usr_seq").val(seq);
	
	$("#frm").attr("action", "/admin/service/member/memberInfo.do");

	$("#frm").submit();
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
				<form name="frm" id="frm" method="post">	
				<input type="hidden" name="listType" value="U"/>
				<input type="hidden" name="paymentClsCdName" value=""/>		
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
								<legend>검색조건</legend>
								<div class="shBoxSection">
									<div class="section">
										<label for="bb22" class="laType03">탑승일   </label>
										<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" id="searchStartDate" name="searchStartDate" readonly/></span>
										<span class="dash">~</span>
										<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" id="searchEndDate" name="searchEndDate" readonly/></span>
									</div>
									<div class="section">
										<label for="aa1" class="laType02">회원정보</label>
										<select class="select-category07" id="searchParameter" name="searchParameter" style="width: 105px;">
											<option value="ID">ID</option>
											<option value="PHONE">휴대번호</option>
										</select>
										<span class="input-text08"><input type="text" class="" id="searchValue" name="searchValue"></span>
										<button class="btn-srh03 btncase1 mdbtncase1" onclick="fn_search(); return false;"><img src="/images/searchIcon.gif" alt="검색" /></button>
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
							<colgroup>
								<col style="width:20%"/>
								<col style="width:20%"/>
								<col style="width:14%"/>
								<col style="width:23%"/>
								<col style="width:23%"/>
							</colgroup>
							<thead>
								<tr>
									<th>아이디</th>
									<th>휴대폰번호</th>
									<th>대중교통 수단</th>
									<th>탐승시간</th>
									<th>하차시간</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="tr"	items="${transitList }">
									<tr>
										<td class="title"><a href="#" onclick="fn_MemberDetail('${tr.usr_seq }'); return false;">${tr.mb_id }</a></td>
										<td class="tc">${tr.usr_mpn_no }</td>
										<td class="tc">${tr.transport_cd }</td>
										<!--[if gt IE 8]><!-->
										<td class="tc">${tr.ride_dttm }</td>
										<td class="title pl10">${tr.alight_dttm }</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						
						
						
						<c:if test="${paginationInfo.totalRecordCount == 0}">
							<table class="tb_type01">
								<tr>
									<td class="tc">
										<spring:message code="search.nodata.msg" />
									</td>
								</tr>
							</table>
						</c:if>
						
						
						<table class="tb_type01">
							<colgroup>
								<col style="width:20%"/>
								<col style="width:20%"/>
								<col style="width:14%"/>
								<col style="width:23%"/>
								<col style="width:23%"/>
							</colgroup>
							<thead>
								<tr>
									<th>아이디</th>
									<th>휴대폰번호</th>
									<th>대중교통 수단</th>
									<th>탐승시간</th>
									<th>하차시간</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="tr"	items="${transitList }">
									<tr>
										<td class="title"><a href="#" onclick="fn_MemberDetail('${tr.usr_seq }'); return false;">${tr.mb_id }</a></td>
										<td class="tc">${tr.usr_mpn_no }</td>
										<td class="tc">${tr.transport_cd }</td>
										<!--[if gt IE 8]><!-->
										<td class="tc">${tr.ride_dttm }</td>
										<td class="title pl10">${tr.alight_dttm }</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<c:if test="${paginationInfo.totalRecordCount == 0}">
							<table class="tb_type01">
								<tr>
									<td class="tc">
										<spring:message code="search.nodata.msg" />
									</td>
								</tr>
							</table>
						</c:if>
						
						
						
						<div class="paging">
							<input type="hidden" name="currentPageNo"	id="currentPageNo" value="${paginationInfo.currentPageNo }">
							<input type="hidden" name="usr_seq"	id="usr_seq">
							<input type="hidden" name="usergubun"	id="usergubun">
							<input type="hidden" name="gubun"	id="gubun">
							<c:if test="${paginationInfo != null }">
								<ui:pagination paginationInfo = "${paginationInfo}" type="custom" jsFunction="linkPage"	/>
							</c:if>
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
	<script type="text/javascript" src="/js/common_barocle.js"></script>
</body>
</html>
