loc_work_order<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" /> 
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />
<meta name="description=" Content="" />
<title><tiles:insertAttribute name="title"/></title>
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
						<div class="shBox">
							<form id="searchFrm">
								<input type="hidden" name="adminId" value="${searchCondition.adminId}" />
								<input type="hidden" name="viewFlg" value="" />
								<fieldset>
									<legend>검색 옵션</legend>
									<div class="shBoxSection">
										<div class="section">
											<label for="bb22" class="laType02">일자</label>
											<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" name="searchBgnDe" title="선택 날짜" id="bb22" readonly/></span>
											<span class="dash">~</span>
											<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" name="searchEndDe" title="선택 날짜" readonly/></span>
										</div>
										<div class="section">
											<label for="stationId" class="laType02">대여소 번호</label>
											<span class="input-text08"><input type="text" id="stationId" name="stationId" /></span>
											<button type="button" id="searchBtn" class="btn-srh03 btncase1 mdbtncase1"><img src="/images/searchIcon.gif" alt="검색"></button>
										</div>
										
									</div>
								
						</div>
						<!--검색조건 E-->
						<p class="tb_numlist">총 ${ paginationInfo.getTotalRecordCount()} 건</p>
						<div class="widscr mt5">
							<table class="tb_type01">
								<colgroup>
									<col style="width:15%"/>
									<col style="width:15%"/>
									<col style="width:30%"/>
									<col style="width:20%"/>
									<col style="width:10%"/>
									<col style="width:10%"/>
									<col style="width:20%"/>
								</colgroup>
								<thead>
									<tr>
										<th>센터</th>
										<th>팀</th>
										<th>대여소</th>
										<th>일자</th>
										<th>시간</th>
										<th>거치된건수</th>
										<th>재배치 </th> 
									</tr>
								</thead>
								<tbody>
									<c:forEach var="result" items="${RelocationStateDetail}" varStatus="status">
	                                <tr>
	                                    <td class="tc">${result.stationGrp}</td>
	                                    <td>${result.returnableCnt}</td>
	                                    <td>${result.fromStationName}</td>
	                                    <td class="tc">${result.relocateStrDttm}</td>
	                                    <td class="tc">${result.relocateEndDttm}</td>
	                                    <td class="tc">${result.rockCnt}</td>
	                                    <td class="tc">${result.moveCnt1}</td>
	                                </tr>
	                            </c:forEach>    
								<c:if test="${fn:length(RelocationStateDetail) eq 0 }">
									<table class="tb_type01 nbt0">
										<tr><td style="text-align:center"><spring:message code="search.nodata.msg" /></td></tr>
									</table>
								</c:if>
								</tbody>
							</table>
						</div>
					<c:choose>
						<c:when test="${fn:length(RelocationStateDetail) > 0}">
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
							
							</fieldset>
							</form>
							
						</div>
                        <div class="btnArea tr">
                            <button class="btnType01  mb10 mhid" id="excelViewBtn" title="엑셀다운로드">엑셀다운로드</button>
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
   		relocationStateList.initBtn();
		var sDate = '${searchCondition.searchBgnDe}' != '' ? '${searchCondition.searchBgnDe}' : '';
		var eDate = '${searchCondition.searchEndDe}' != '' ? '${searchCondition.searchEndDe}' : '';
		
		// var relocationCmptYn = '${searchCondition.relocationCmptYn}' != '' ? '${searchCondition.relocationCmptYn}' : '';
		// var viewType = '${searchCondition.viewType}' != '' ? '${searchCondition.viewType}' : '';
		var stationId = '${searchCondition.stationId}' != '' ? '${searchCondition.stationId}' : '';
		
		$("[name='searchBgnDe']").val(sDate);
		$("[name='searchEndDe']").val(eDate);
		// $("[name='relocationCmptYn']").val(relocationCmptYn);
		// $("[name='viewType']").val(viewType);
		$("[name='stationId']").val(stationId);
		
		var totalPageCount = '${paginationInfo.totalPageCount}' == '' ? 1 : Number('${paginationInfo.totalPageCount}');
   		$('#prevPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			relocationStateList.pageSelect(currentPageNo-1);
		});
		$('#nextPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			relocationStateList.pageSelect(currentPageNo+1);
		});
		$('#movePage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			var regExp = /^[1-9]?[0-9]/;
			if(!regExp.test(currentPageNo) ||(totalPageCount < currentPageNo)){
				alert('현재 페이지 값이 정상적이지 않습니다.');
			}else{
				relocationStateList.pageSelect(currentPageNo);
			}
		});
	});
    
    var relocationStateList = {};
    // relocationStateList.relocationCmptYn = '${searchCondition.relocationCmptYn}';
    
    
    relocationStateList.initBtn = function(){
    	$("#searchBtn").on("click",{listType: "list"},this.exeListFnc);
    	$("#excelViewBtn").on("click",{listType: "excel"},this.exeExcelFnc);
    }
    
    relocationStateList.exeListFnc = function(e) {
        e.preventDefault();
        var listType = e.data.listType;

        if(DateUtil.checkDateTerm( $( "[name='searchBgnDe']").val(),  $( "[name='searchEndDe']").val()) != 'ok') {
            alert('<spring:message code="fail.input.daterange"/>');
            return false;
        }
        // $("[name='currentPageNo']").val(1);
        
        $("#searchFrm").attr({method : 'post', action : '/getRelocationWorkOrder.do'}).submit();
    };
    
    relocationStateList.exeExcelFnc = function(e) {
        e.preventDefault();
        var listType = e.data.listType;
		
        if(DateUtil.checkDateTerm( $( "[name='searchBgnDe']").val(),  $( "[name='searchEndDe']").val()) != 'ok') {
            alert('<spring:message code="fail.input.daterange"/>');
            return false;
        }
        if ( DateUtil.diffDays( $( "[name='searchBgnDe']").val().replaceAll("-",""),  $( "[name='searchEndDe']").val().replaceAll("-",""))
        	> 6		
        ) {
        	alert("7일이상은 조회 불가능합니다.");
        	return;
        }
        $("[name='viewFlg']").val(listType);
        
        $("#searchFrm").attr({method : 'post', action : '/getRelocationWorkOrder.do'}).submit();
    };
    
    relocationStateList.pageSelect = function(pageNo) {
    	$("[name='currentPageNo']").val(pageNo);
    	$("#searchFrm").attr({action :'/getRelocationWorkOrder.do', method : 'post'}).submit();
    	
    };
    
    </script>
</body>
</html>