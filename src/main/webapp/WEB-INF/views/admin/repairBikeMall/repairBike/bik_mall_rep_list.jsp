<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" /> 
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />
<meta name="description=" Content="" />
<tiles:insertAttribute name="resource"/>
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
						<form id="searchFrm">
							<div class="shBox">
								<input type="hidden" name="viewFlg" value="" />
                                <input type="hidden" name="repairOursrcSeq" value="" />
                                <input type="hidden" name="adminId" value="" />
                                <input type="hidden" name="months" value="" />
                                <!-- 정비보고서 출력용 변수 -->
                                <input type="hidden" name="repairYear" value="" />
                                <input type="hidden" name="repairMonth" value="" />
                                <input type="hidden" name="takeId" value="" />
                                <%-- <input type="hidden" name="transId" value="<%= com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil.getSessionAttribute(request, "usrId") %>" /> --%>
								<fieldset>
									<legend>검색 옵션</legend>
									<div class="shBoxSection">
										<div class="section">
											<label for="bb22" class="laType02">등록일</label>
											<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" name="searchBgnDe" title="선택 날짜" id="bb22" readonly/></span>
											<span class="dash">~</span>
											<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" name="searchEndDe" title="선택 날짜" readonly/></span>
										</div>
										<div class="section pright">
										<c:if test="${bikeMallAdmin.usrGrpCd ne 21}">
											<label for="a11" class="laType02">점포명</label>
											<!-- 점포명으로 검색할 경우 등록일 선택 필수!! -->
											<select class="select-category02" name="centerId">
												<option value="">선택</option>
												<c:forEach var="bikeMall" items="${bikeMallList}" varStatus="status">
												<option value="${bikeMall.centerId}" <c:if test="${bikeMall.centerId eq searchCondition.centerId}">selected</c:if>>${bikeMall.centerName}</option>
												</c:forEach>
											</select>
											</c:if>
											<button id="searchBtn" class="btn-srh03 btncase1"><img src="/images/searchIcon.gif" alt="검색" id="searchBtn"></button>
										</div>
									</div>
								</fieldset>
							</div>
						<!--검색조건 E-->
						<table class="tb_type01 mt20">
							<colgroup>
								<col style="width:10%"/>
								<col style="width:30%"/>
								<col style="width:15%"/>
								<col style="width:15%"/>
								<col style="width:14.5%"/>
								<col style="width:5%"/>
								<%-- <col style="width:14.5%"/> --%>
							</colgroup>
							<thead>
								<tr>
									<th>해당년월</th>
									<th>점포명</th>
									<th>정비(건)</th>
									<th>단가(총합)</th>
									<th>보고서 출력</th>
									<!-- <th>내역통보(점주)</th> -->
									<th>건별</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="result" items="${ReportMallList}" varStatus="status">
								<tr>
									<td style="display: none;">${result.mpnNo}</td>
									<%-- <fmt:parseDate var="dateString" value="${result.regDttm }" pattern="yyyy-MM-ddHH:mm:ss" />
									<td class="tc"><fmt:formatDate value="${dateString}" pattern="yyyy-MM"/></td> --%>
									<td class="tc">${result.months}</td>
									<td class="tc">${result.centerName}</td>
									<td class="tc">${result.repairCnt}건</td>
									<td class="tc"><fmt:formatNumber pattern="#,###" value="${result.totPrice }"></fmt:formatNumber>원</td>
									<td class="tc"><button class="btnType02" id="btnPrint">보고서 출력</button></td>
									<td style="display: none;">${result.adminId}</td>
									<td class="tc"><button class="btnType07" id="btnSendBike">건별</button></td>
								</tr>								
								</c:forEach>
								<c:if test="${fn:length(ReportMallList) eq 0 }">
									<table class="tb_type01 nbt0">
										<tr><td style="text-align:center"><spring:message code="search.nodata.msg" /></td></tr>
									</table>
								</c:if>
							</tbody>
						</table>  
						<c:choose>
						<c:when test="${fn:length(ReportMallList) > 0}">
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
						</form>
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
	
	<script type="text/javascript" src="/js/common_barocle.js"></script>
    <script type="text/javascript">
    $(function() {
   		reportMallList.initBtn();
		
   		var transBikeList = {};
		var totalPageCount = '${paginationInfo.totalPageCount}' == '' ? 1 : Number('${paginationInfo.totalPageCount}');
   		$('#prevPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			transBikeList.pageSelect(currentPageNo-1);
		});
		$('#nextPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			transBikeList.pageSelect(currentPageNo+1);
		});
		$('#movePage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			var regExp = /^[1-9]?[0-9]/;
			if(!regExp.test(currentPageNo) ||(totalPageCount < currentPageNo)){
				alert('현재 페이지 값이 정상적이지 않습니다.');
			}else{
				transBikeList.pageSelect(currentPageNo);
			}
		});
		
		transBikeList.pageSelect = function(pageNo) {
	    	$("[name='currentPageNo']").val(pageNo);
	    	$("[name='viewFlg']").val('list');
	    	$("#searchFrm").attr({method : 'post', action : '/bikeMallReport.do'}).submit();
	    };
		
		$(".btnType02").click(function(){ 	/// 보고서 출력
			var repairYear = $(this).parent().prev().prev().prev().prev().text().substring(0,4);
			var repairMonth = $(this).parent().prev().prev().prev().prev().text().substring(5);
			var takeId = $(this).parent().next().text();
			
			$("[name='repairYear']").val(repairYear);
			$("[name='repairMonth']").val(repairMonth);
			$("[name='takeId']").val(takeId);
				
			$("#searchFrm").attr({method : 'post', action : '/bikeMallReportExcel.do'}).submit();
			
		});
		

		// 건별 실적
		$(".btnType07").click(function(){ 	/// 보고서 출력
			
			// 현재 클릭된 Row(<tr>)
			var tr = $(this).parent().parent();
			var td = tr.children();
				
			// tr.text()는 클릭된 Row 즉 tr에 있는 모든 값을 가져온다.
			var repairYear = td.eq(1).text().substring(0,4);
			var repairMonth = td.eq(1).text().substring(6,7);
			var takeId = td.eq(6).text();
			
			$("[name='repairYear']").val(repairYear);
			$("[name='repairMonth']").val(repairMonth);
			$("[name='takeId']").val(takeId);
			$("#searchFrm").attr({method : 'post', action : '/bikeMallReportBikeExcel.do'}).submit();
		});
		
		
	});
    
	var reportMallList = {};
    
	reportMallList.initBtn = function(){
		var date = new Date;
		date.setDate(date.getDate()-6);
		var fromday = DateUtil.dateFmt(date);
		var today = DateUtil.dateFmt(new Date());
		var sDate = '${searchCondition.searchBgnDe}' !== '' ? '${searchCondition.searchBgnDe}' : '';
		var eDate = '${searchCondition.searchEndDe}' !== '' ? '${searchCondition.searchEndDe}' : '';
		
		$("[name='searchBgnDe']").val(sDate);
		$("[name='searchEndDe']").val(eDate);
		
    	$("#searchBtn").on("click",{listType: "list"},this.exeListFnc);
    	
    	$("[name='adminId']").val('${bikeMallAdmin.usrId }');
    }
    
	reportMallList.exeListFnc = function(e) {
        e.preventDefault();
        var listType = e.data.listType;

        if($("[name='searchBgnDe']").val() != '' && $( "[name='searchEndDe']").val() != ''){
	        if(DateUtil.checkDateTerm( $( "[name='searchBgnDe']").val(),  $( "[name='searchEndDe']").val()) != 'ok') {
	            alert('<spring:message code="fail.input.daterange"/>');
	            return false;
	        }
	        if(DateUtil.diffDays( $("[name='searchBgnDe']").val(),  $("[name='searchEndDe']").val(), '-') >= 365){
	    		alert("조회기간은  1년 이내로 설정해주세요.");
	    		return false;
	    	} 
        }

        $("[name='currentPageNo']").val(1);
        
        $("[name='viewFlg']").val(listType);
        $("#searchFrm").attr({method : 'post', action : '/bikeMallReport.do'}).submit();
    };
    
    reportMallList.pageSelect = function(pageNo) {
    	$("[name='currentPageNo']").val(pageNo);
    	$("[name='viewFlg']").val('list');
    	$("#searchFrm").attr({action :'/bikeMallReport.do', method : 'post'}).submit();
    };
    
    reportMallList.exeUdtInfoFnc = function(e) {
    	
    	e.preventDefault();
    	var udtFlag = e.data.flag;
    	var seq = "";
    	// var transId = $("[name='transId']").val();
    	
    	if(udtFlag === 'trans') {
    		seq = $(this).parent().prev().prev().prev().text();
    	}else{
    		seq = $(this).parent().prev().prev().prev().prev().prev().prev().prev().text();
    	}
    	$("[name='viewFlg']").val(udtFlag);
    	
    	//$("#searchFrm").attr({method : 'post', action : '/moveTransferBikeEditForm.do'}).submit();
    	$.ajax({
			url : "/checkTransferBikeAjax.do",
			type : "post",
			dataType : "json",
			data : {viewFlg:udtFlag,repairOursrcSeq:seq},
			async : false,
	   		beforeSubmit: function (data,form,option) {
				return true;
			},
			success : function(data){
				if(data.resultMessage == "Success"){
					alert("인수(인계)가 완료되었습니다.");
					location.reload();
				}
			},
			error : function(jqXHR, textStatus,errorThrown){
				if(jqXHR.status === 500 || jqXHR.status === 200){
					alert("에러가 발생했습니다. : " + textStatus);
				}
			}
		});
    	
    }

    reportMallList.exePrintReportFnc = function(e) {
    	alert("보고서 출력");
    };
    
    reportMallList.exeSendSmsFnc = function(e) {
    	alert("내역 통보");
    };
    
    
    </script>
</body>
</html>