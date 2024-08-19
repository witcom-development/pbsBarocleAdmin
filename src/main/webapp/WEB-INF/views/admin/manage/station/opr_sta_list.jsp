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
<tiles:insertAttribute name="resource" ignore="true"/><!-- tiles의 title 값이 존재 하지 않아 런타임 에러 발생하여 ignore="true" 추가_20170518 -->

<script type="text/javascript" src="/js/common_barocle.js"></script>
<script type="text/javascript">

$(function() {
	
	if("${result }" != ""){
		alert("${result}");
	}
	
	$("#search_grp").change(function(){
		fn_selectChange(false);
	});
	
	if("${searchVO.searchUse}" != ""){
		$("#searchUse").val("${searchVO.searchUse}");
	}
	
	$("#search_grp").val("${searchVO.search_grp}");
	if("${searchVO.search_grp}" != ""){
		fn_selectChange(true);
	}
	
	$("#search_gubun").val("${searchVO.search_gubun}");
	
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
	
	$("#sortSlt").on('change', function(){
		$("[name='lsalign']").prop('checked', false);
	});
	$("[name='lsalign']").on("change", fn_setColumnSortInfo);
	
	commonAjax.getCommonCode("RAK", function(data){
		if(data !== null && data.codeList !== null) {
			var code = new Array();
			for(var i =0; i <data.codeList.length ;i++) {
					 code.push(data.codeList[i]);
			}
			commCdBox.makeComboBox('CC', '${searchVO.station_se_cd}', code, "station_se_cd");
		}
	});
	
	if("${searchVO.useYN}" != ""){
		switch ( "${searchVO.useYN}" ){
			case "Y" : $("#useYN").prop('selectedIndex', 1); break;
// 			case "T" : $("#useYN").prop('selectedIndex', 2);  break;
			case "N" : $("#useYN").prop('selectedIndex', 3);  break;
// 			case "C" : $("#useYN").prop('selectedIndex', 4);  break;
// 			case "S" : $("#useYN").prop('selectedIndex', 5);  break;
		}
	}else{
		$("#useYN").prop('selectedIndex', 0);
	}
	
});

	function fn_selectChange( flg ){
		
		var select = "<option value=\"\">선택</option>"
		if($("#search_grp").val() == ''){
			$("#search_name").find("option").remove().end();
			$("#search_name").append(select);
			
		}else{
			$("#search_name").find("option").remove().end();
			$("#search_name").append(select);
			
			$.post("/admin/manage/station/groupStationList.do", "station_grp_seq=" + $("#search_grp").val()  , function(data) {
				
				for(var i=0; i < data.nameList.length; i++){
					if(flg){
						if("${searchVO.search_name}" == data.nameList[i].station_id){
							$("#search_name").append("<option value='"+data.nameList[i].station_id+"' selected>"+ data.nameList[i].station_name +"</option>");
						}else{
							$("#search_name").append("<option value='"+data.nameList[i].station_id+"'>"+ data.nameList[i].station_name +"</option>");
						}
					}else{
						$("#search_name").append("<option value='"+data.nameList[i].station_id+"'>"+ data.nameList[i].station_name +"</option>");
					}						
				}
				
			});
			
		}
	}
	
	function fn_regist(){
		$("form[name=frm]").attr("action", "/admin/manage/station/stationRegist.do");
		
		$("form[name=frm]").submit();
	}
	
	function fn_Search(){
		$("[name='currentPageNo']").val(1);
		$("form[name=frm]").attr("action", "/admin/manage/station/stationList.do");
		
		$("form[name=frm]").submit();
	}
	
	function linkPage( no ){
		$("input[name=currentPageNo]").val(no);
		$("form[name=frm]").attr("action", "/admin/manage/station/stationList.do");
		
		$("form[name=frm]").submit();
	}
	
	function fn_stationInfo( id ){
		$("#station_id").val(id);
		$("form[name=frm]").attr("action", "/admin/manage/station/stationInfo.do");
		
		$("form[name=frm]").submit();
	}
	
	
	function fn_Excel(){
		$("input[name=stationGubun]").val($("#search_gubun option:selected").text());
		
		if($("#searchUse option:selected").text() == '선택'){
			$("input[name=gubun]").val( $("#searchUse option:selected").text() );
		}else{
			if($("input[name=useYN]").is(":checked"))
				$("input[name=gubun]").val($("#searchUse option:selected").text() + ($(':radio[name="useYN"]:checked').val() )); 
		}
		
		$("input[name=group]").val($("#search_grp option:selected").text());
		$("input[name=name]").val($("#search_name option:selected").text());
		
		$("form[name=frm]").attr("action", "/admin/manage/station/stationListExcel.do");
		$("form[name=frm]").submit();
	}
	
	function fn_setColumnSortInfo(){
		
		var tTarget = $("#sortSlt").val();
		if($("#sortSlt").val() === ''){
			//tTarget = 'G';
			return false;
		}
		$("[name='orderColumn']").val(tTarget);
		$("[name='orderType']").val($("[name='lsalign']:checked").val());
		//alert($("[name='orderColumn']").val());
		fn_Search();
			
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
		<form name="frm" method="post">
		<input type="hidden" name="orderColumn"   value="${condition.orderColumn}">
		<input type="hidden" name="orderType"	  value="${condition.orderType }">	
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
											<!-- 
											<div class="section">
												<label for="aa21" class="laType02">정거장구분</label>
												<select class="select-category03" id="station_se_cd" name="station_se_cd">
													<option value="">선택</option>
												</select>
											</div>
											 -->
											<div class="section">
												<label for="aa1" class="laType02">아파트</label>
												<select class="select-category04" id="search_grp" name="search_grp">
													<option value="">선택</option>
													<c:forEach items="${group }" var="group">
														<option value="${group.station_grp_seq }">${group.station_grp_name }</option>
													</c:forEach>
												</select>
											</div>
											<div class="section pright">
												<label for="aa21" class="laType02">정거장명</label>
												<select class="select-category05" id="search_name" name="search_name">
													<option value="">선택</option>
												</select>
												<!-- <button class="btn-srh03 btncase1" onclick="fn_Search(); return false;"><img src="/images/searchIcon.gif" alt="검색" /></button> -->
											</div>
											<div class="section">
												<label for="aaa1" class="laType02">정거장번호</label>
												<span class="input-text07"><input type="text" name="station_no" class="" value="${searchVO.station_no }"/></span>
												<button class="btn-srh03 btncase1" onclick="fn_Search(); return false;"><img src="/images/searchIcon.gif" alt="검색" /></button>
											</div>
											<div class="section pright">
												<label for="a1" class="laType02">사용여부</label>
												<input type="hidden" id="useY" name="searchUse" value="station_use_yn">
												<span>
													<select class="select-category04" id="useYN"	name="useYN">
														<option value="">전체</option>
														<option value="Y">사용</option>
<!-- 														<option value="T">임시폐쇄</option> -->
<!-- 														<option value="S">임시폐쇄(예정)</option> -->
														<option value="N">미사용</option>
<!-- 														<option value="C">폐쇄</option> -->
													</select>	
												</span>
											</div>
										</div>	
										
									</fieldset>
							</div>
							<!--검색조건 E--> 
							<div class="listalign mt20" style="margin-bottom : 5px;">
								<select name="sortSlt" id="sortSlt" class="mr10">
									<option value="">선택</option>
									<option value="G" <c:if test='${ condition.orderColumn eq "G"}'>selected="selected"</c:if>>아파트명</option>
									<option value="S" <c:if test='${ condition.orderColumn eq "S" }'>selected="selected"</c:if>>정거장명</option>
								</select>
								<label><input name="lsalign" type="radio" value="ASC" class="vm" <c:if test="${condition.stationOrderType eq 'ASC'  or condition.sharedOrderType eq 'ASC'}">checked="checked"</c:if>/> 오름차순</label>
								<label><input name="lsalign" type="radio" value="DESC" class="vm ml10" <c:if test="${condition.stationOrderType eq 'DESC' or condition.sharedOrderType eq 'DESC'}">checked="checked"</c:if>/> 내림차순</label>
								<label class="tb_numlist" style="float:right"><c:if test="${paginationInfo != null }">
									총 ${paginationInfo.totalRecordCount } 건
								</c:if></label>
							</div>
							<!-- <p class="tb_numlist"></p> -->
							<table class="tb_type01">
								<caption>아파트 목록</caption>
									<colgroup>
										<col style="width:15%"/>
										<col style="width:30%"/>
										<col style="width:13%"/>
										<col style="width:20%"/>
									</colgroup>
								<thead>
									<tr>
										<th>아파트명</th>
										<th>정거장명</th>
										<th>구분</th>
										<th>사용여부</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${stationList }"	var="list">
										<tr>
											<td class="pl10">${list.station_grp_name }</td>
											<td class="title" onclick="fn_stationInfo('${list.station_id}')"><a href="#">
												<c:if test="${list.station_se_cd eq 'RAK_001' }"></c:if>
												<%-- <c:if test="${list.station_se_cd ne 'RAK_001' }">(신규)</c:if> --%>
												${list.station_name }</a>
											</td>
											<td class="tc">${list.station_cls_cd_name }</td>
											<td class="tc">
											<c:choose>
												<c:when test="${list.station_use_yn eq 'Y'}">사용</c:when>
												<c:when test="${list.station_use_yn eq 'N'}">미사용</c:when>
												<%-- <c:when test="${list.station_use_yn eq 'C'}">폐쇄</c:when> --%>
												<%-- <c:when test="${list.station_use_yn eq 'T'}">임시 폐쇄</c:when> --%>
												<%-- <c:when test="${list.station_use_yn eq 'S'}">임시 폐쇄(예정)</c:when> --%>
												<c:otherwise>${list.station_use_yn }</c:otherwise>
											</c:choose>
											</td>
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
							
						<c:choose>
							<c:when test="${fn:length(stationList) > 0}">
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
								<span class="right">
									<button class="btnType01" type="button" onclick="fn_Excel()">엑셀다운로드</button>
									<button class="btnType01 bc_green" onclick="fn_regist()">등록</button>
								</span>
								
							</div>
						</div>
						
						<input name="stationGubun" type="hidden" value="">
						<input name="gubun" type="hidden" value="">
						<input name="group" type="hidden" value="">
						<input name="name" type="hidden" value="">
						
						<input type="hidden" name="station_id"	id="station_id">
				</div>
				<!--conteent E-->			
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
