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
	//function linkPage(pageNo){ location.href = "/admin/customer/police/policeList.do?currentPageNo="+pageNo; }
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
									
									<input id="polReqSeq" 	name="polReqSeq" 	type="hidden"  value=""/>
									<input id="viewFlg" 	name="viewFlg" 		type="hidden"  value=""/>
									
									<legend>검색조건</legend>
									<div class="shBoxSection">
										<div class="section">
											<label for="sDate" class="laType02">등록일</label>
											<span class="selectDate input-datepick04"><input id="sDate" name="searchStartDate" type="text" class="datepicker input-datepick04" title="선택 날짜" readonly="true" value="${policeView.searchStartDate}"/></span>
											<span class="dash">~</span>
											<span class="selectDate input-datepick04"><input id="eDate" name="searchEndDate" type="text" class="datepicker input-datepick04" title="선택 날짜" readonly="true" value="${policeView.searchEndDate}"/></span>
										</div>
										<div class="section pright">
											<label for="searchValue" class="laType02">요청 기관명</label>
											<span class="input-text07"><input id="searchValue" name="searchValue" type="text" class="input-text07" value="${policeView.searchValue}" maxLength="32"/></span>
											<button class="btn-srh03 btncase1" id="btnSearch" ><img src="/images/searchIcon.gif" alt="검색" /></button>
										</div>
									</div>
								</fieldset>
							</div>
						<!--검색조건 E-->
						<p class="tb_numlist">총 <c:out value="${policeView.totalRecordCount}"/>건</p>
						<table class="tb_type01">
							<colgroup>
								<col style="width:50%"/>
								<col style="width:30%"/>
								<col style="width:20%"/>
							</colgroup>
							<thead>
								<tr>
									<th>요청 기관명</th>
									<th>문서 번호</th>
									<th>등록일</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${fn:length(policeList) > 0 }">
										<c:forEach items="${policeList}" var="policeVO" varStatus="status">
											<tr>
												<td class="title">
													<a href="#"><c:out value="${policeVO.polReqInstitutionName}"/></a>
												</td>
												<td style="display: none;">${policeVO.polReqSeq}</td>
												<td>${policeVO.polReqName}</td>
												<td class="tc">${policeVO.polReqReqDttm}</td>
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
						<c:when test="${fn:length(policeList) > 0}">
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
							<span class="right"><button class="btnType01 bc_green" id ="moveEditForm">등록</button></span>
						</div>
					</div>
				</div>
				<!--content E-->
			</div>
		</div>
		
		<script type="text/javascript">
			var policeList = {};	
			$( function() {	
				policeList.initBtn();
			});
		    
		    policeList.initBtn = function(){
		    	var totalPageCount = '${paginationInfo.totalPageCount}' == '' ? 1 : Number('${paginationInfo.totalPageCount}');
				$("#prevPage")				.on("click",	 { process : -1 , totalPageCount : totalPageCount }, this.select);
				$("#nextPage")				.on("click",	 { process : 1  , totalPageCount : totalPageCount }, this.select);
				$("#movePage")				.on("click",	 { process : 0  , totalPageCount : totalPageCount }, this.select);
		    	$("#btnSearch")				.on("click",	 { process : 99 }								   , this.select);
		    	$(".tb_type01 > tbody > tr").on("click", "a",{ viewFlg : 'R'}, this.moveEditForm);
		    	$("#moveEditForm")			.on("click",	 { viewFlg : 'C'}, this.moveEditForm);
		    }
			
		    policeList.select = function (e) {
		    	e.preventDefault();
		    	// 조회일 때는
		    	if ( e.data.process == 99 ) {
		    		policeList.pageSelect( 1 );
		    		return;
		    	} 
		    	// 페이징 관련 처리
		    	var currPageNo      = Number($('[name="currentPageNo"]').val());
		    		currPageNo		= currPageNo +   e.data.process ;
		    	if(	currPageNo == 0) currPageNo = 1; 
		    	var totalPageCount 	= e.data.totalPageCount;
		    	var regExp = /^[1-9]?[0-9]/;
				if( !regExp.test( currPageNo ) ||( totalPageCount < currPageNo ) ) {
					alert('이동 페이지 값이 정상적이지 않습니다.');
					return;
				}
				
		    	policeList.pageSelect( currPageNo );
		    };
		    
			policeList.pageSelect = function(pageNo) {
		    	$("[name='currentPageNo']").val(pageNo);
		    	$("[name='viewFlg']").val('list');
		    	$("#frm").attr({action :'/admin/customer/police/policeList.do', method : 'get'}).submit();
		    };	
		    
		    policeList.moveEditForm = function (e) {
		    	e.preventDefault();
		    	var pViewFlg = e.data.viewFlg;
		    	 
		    	if(pViewFlg === 'R') {
		    		$("[name='polReqSeq']").val($(this).parent().next().text());
		    	}else{
		    		$("[name='polReqSeq']").val('');
		    	}  
		    	$("[name='viewFlg']").val(pViewFlg);
		    	$("#frm").attr({method : 'get', action : '/admin/customer/police/policeListWrite.do'}).submit();
		    };
		     
			var previousValue;
			$("input").on('focus',function(){
				previous = this.value;
			}).change(function(){
				if(  !isEmpty($("#sDate").val())	 && !isEmpty($("#eDate").val()) &&	$("#sDate").val() > $("#eDate").val()  ){
					alert("종료일이 시작일보다 빠를 수 없습니다.");
					$(this).val(previous);
				}
			});
			var isEmpty = function(value){ if( value == "" || value == null || value == undefined || ( value != null && typeof value == "object" && !Object.keys(value).length ) ){ return true }else{ return false } };
			
		</script>
		
		<!--footer S-->
			<tiles:insertAttribute name="footer" />
		<!--footer E-->
	</div>
</body>
</html>
