<%@ page language="java" contentType="text/html; charset=UTF-8"
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
						<form id="searchFrm">
						<!-- 모바일 검색조건 E-->
						<!--검색조건 S-->
							<div class="shBox">
								<input type="hidden" name="viewFlg" value="" />
								<input type="hidden" name="sortValue" />
								<fieldset>
									<legend>검색 옵션</legend>
									<div class="shBoxSection">
										<div class="section">
											<label for="bb22" class="laType02">보고일</label>
											<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" name="searchBgnDe" title="선택 날짜" id="bb22" readonly/></span>
											<span class="dash">~</span>
											<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" name="searchEndDe" title="선택 날짜" readonly/></span>
										</div>
										<div class="section pright">
											<label for="aa1" class="laType02">자전거 번호</label>
											<span class="input-text07"><input type="text" name="searchWord" class=""/></span>
										</div>
										<div class="section">
											<label for="lockState" class="laType02">Lock 상태</label>
											<select class="select-category02" name="lockState" id="lockState">
                                                <option value="">선택</option>
                                                <option value="01">ON</option>
                                                <option value="02">OFF</option>
                                                <option value="03">Error</option>
                                            </select>
											<button id="searchBtn" class="btn-srh03 btncase1"><img src="/images/searchIcon.gif" alt="검색"></button>
										</div>
									</div>
									
								</fieldset>
							</div>
						<div class="listalign mt20">
							<select class="" name="sortType" id="sortType" class="mr10">
                                <option value="">선택</option>
                                <option value="bikeNo">자전거번호</option>
                                <option value="regDttm">보고일시</option>
                            </select>
                            <label><input name="sortVal" class="vm" type="radio" value="ASC"> 오름차순</label>
                            <label><input name="sortVal" class="vm ml10" type="radio" value="DESC"> 내림차순</label>
                            <div class=" tb_numlist" style="float: right;">총 ${ paginationInfo.getTotalRecordCount()} 건</div>
                        </div>
						<!--검색조건 E-->
						<table class="tb_type01">
							<colgroup>
								<col style="width:15%"/>
								<col style="width:25%"/>
								<col style="width:10%"/>
								<col style="width:15%"/>
								<col style="width:25%"/>
								<col style="width:10%"/>
							</colgroup>
							<thead>
								<tr>
									<th>자전거번호</th>
									<th class="tc">보고일시</th>
									<th>Lock 상태</th>
									<th>GPS정보</th>
									<th>대여소</th>
									<th>거치대</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="report" items="${robReportList}"  varStatus="loop">
	                                <tr>
	                                    <td>${report.bikeNo }</td>
	                                    <td>${report.regDttm }</td>
	                                    <c:choose>
	                                    <c:when test="${report.lockState == '01'}">
	                                    	<td>ON</td>
	                                    </c:when>
	                                    <c:when test="${report.lockState == '02'}">
	                                    	<td>OFF</td>
	                                    </c:when>
										<c:otherwise>
											<td>Error</td>
										</c:otherwise>
										</c:choose>
										<td><a title="위치지도찾기" class="winNewPop" href="/common/pop/showLocationMapPop.do" data-pmt="&latitude=${report.latitude}&longitude=${report.longitude}" data-height="680" data-width="600">위 : ${report.latitude}<br/>경 : ${report.longitude}</a></td>
	                                    <td>${report.stationName}</td>	
	                                   	<td>${report.stationEquipOrd}</td>
									</tr>
                                </c:forEach>
                                <c:if test="${fn:length(robReportList) eq 0 }">
	                                <table class="tb_type01 nbt0">
			                            <tr><td style="text-align:center"><spring:message code="search.nodata.msg" /></td></tr>
			                        </table>
								</c:if>
							</tbody>
						</table>
					<c:choose>
						<c:when test="${fn:length(robReportList) > 0}">
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
						<!-- 
						<div class="btnArea">
							<span class="right">
								<button class="btnType01" id="excelViewBtn" title="엑셀다운로드">엑셀다운로드</button>
							</span>
						</div>
						 -->
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
		robReportList.initBtn();
		
		var sDate = '${searchCondition.searchBgnDe}' != '' ? '${searchCondition.searchBgnDe}' : '';
		var eDate = '${searchCondition.searchEndDe}' != '' ? '${searchCondition.searchEndDe}' : '';
		var searchWord = '${searchCondition.searchWord}' !== '' ? '${searchCondition.searchWord}' : '';
		var lockState = '${searchCondition.lockState}' !== '' ? '${searchCondition.lockState}' : '';
		var sortType = '${searchCondition.sortType}' !== '' ? '${searchCondition.sortType}' : '';
		var sortValue = '${searchCondition.sortValue}' !== '' ? '${searchCondition.sortValue}' : '';
		
		$("[name='searchBgnDe']").val(sDate);
		$("[name='searchEndDe']").val(eDate);
		$("[name='searchWord']").val(searchWord);
		$("[name='lockState']").val(lockState);
		$("[name='sortType']").val(sortType);
		$("[value='"+sortValue+"']").attr("checked",true);
		$("[name='sortValue']").val(sortValue);
		
		var totalPageCount = '${paginationInfo.totalPageCount}' == '' ? 1 : Number('${paginationInfo.totalPageCount}');
   		$('#prevPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			robReportList.pageSelect(currentPageNo-1);
		});
		$('#nextPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			robReportList.pageSelect(currentPageNo+1);
		});
		$('#movePage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			var regExp = /^[1-9]?[0-9]/;
			if(!regExp.test(currentPageNo) ||(totalPageCount < currentPageNo)){
				alert('현재 페이지 값이 정상적이지 않습니다.');
			}else{
				robReportList.pageSelect(currentPageNo);
			}
		});
	});
    
    var robReportList = {};
    
    robReportList.initBtn = function(){
    	var _this = robReportList;
    	$("#searchBtn").on("click",{listType: "list"},this.exeListFnc);
    	$("#excelViewBtn").on("click",{listType : "excel"},this.exeListFnc);
    	$("[name=sortVal]").on("click", function(){
    	$("[name=sortValue]").val($(this).val());
    	});
    }
    
    robReportList.exeListFnc = function(e) {
        e.preventDefault();
        var listType = e.data.listType;

        if(DateUtil.checkDateTerm( $( "[name='searchBgnDe']").val(),  $( "[name='searchEndDe']").val()) != 'ok') {
            alert('<spring:message code="fail.input.daterange"/>');
            return false;
        }
        if(DateUtil.diffDays( $("[name='searchBgnDe']").val(),  $("[name='searchEndDe']").val(), '-') >= 31){
    		alert("조회기간은 31일 이내로 설정해주세요.");
    		return false;
    	} 
        $("[name='currentPageNo']").val(1);
       
        $("[name='viewFlg']").val(listType);
        $("#searchFrm").attr({method : 'post', action : '/getRobReportList.do'}).submit();
    };
    
    robReportList.pageSelect = function(pageNo) {
    	$("[name='currentPageNo']").val(pageNo);
    	$("[name='viewFlg']").val('list');
    	$("#searchFrm").attr({action :'/getRobReportList.do', method : 'post'}).submit();
    	
    };
   
    </script>
</body>
</html>