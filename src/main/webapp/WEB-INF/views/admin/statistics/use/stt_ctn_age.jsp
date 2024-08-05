<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
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
						<p class="pageTitle">연령대별 이용</p>
						<span>통계 &gt; 이용내역 &gt; <em>연령대별</em></span>
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
								<fieldset>
									<legend>검색 옵션</legend>
									<div class="shBoxSection">
										<div class="section">
											<label for="searchBgnDe" class="laType02">대여월</label>
											<span>
												<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" id="searchBgnDe" name="searchBgnDe" readonly/></span>
												<span class="dash">~</span>
												<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" id="searchEndDe" name="searchEndDe" readonly/></span>
											</span>
											<button type="button" id="searchBtn" class="btn-srh03 btncase1"><img src="/images/searchIcon.gif" alt="검색" /></button>
										</div>
									</div>
								</fieldset>
							</div>
						</form>	
						<!--검색조건 E-->
						<p class="tb_numlist">총 ${ paginationInfo.getTotalRecordCount()} 건</p>
						<div class="widscr mt5">
						<table class="tb_type01 tb_right">
							<colgroup>
								<col style="width:auto" span="9" />
							</colgroup>
							<thead> 
								<tr>
									<th>유형</th>
									<th>성별</th>
									<th>10대</th>
									<th>20대</th>
									<th>30대</th>
									<th>40대</th>
									<th>50대</th>
									<th>60대</th>
									<th>70대</th>
									<th>기타</th>
									<th>합계</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach var="result" items="${dataList}" varStatus="status">
								<tr>
									<td style="text-align:center;<c:if test="${result.bikeType eq '전체' }">background:grey;color:white;</c:if><c:if test="${result.sexCd eq '합계' }">background:beige;</c:if>">${result.bikeType}</td>
									<td style="text-align:center;<c:if test="${result.bikeType eq '전체' }">background:grey;color:white;</c:if><c:if test="${result.sexCd eq '합계' }">background:beige;</c:if>">${result.sexCd}</td>  
									<td style="text-align:center;<c:if test="${result.bikeType eq '전체' }">background:grey;color:white;</c:if><c:if test="${result.sexCd eq '합계' }">background:beige;</c:if>"><fmt:formatNumber value="${result.age1}" pattern="#,###" /></td>
									<td style="text-align:center;<c:if test="${result.bikeType eq '전체' }">background:grey;color:white;</c:if><c:if test="${result.sexCd eq '합계' }">background:beige;</c:if>"><fmt:formatNumber value="${result.age2}" pattern="#,###" /></td>
									<td style="text-align:center;<c:if test="${result.bikeType eq '전체' }">background:grey;color:white;</c:if><c:if test="${result.sexCd eq '합계' }">background:beige;</c:if>"><fmt:formatNumber value="${result.age3}" pattern="#,###" /></td>
									<td style="text-align:center;<c:if test="${result.bikeType eq '전체' }">background:grey;color:white;</c:if><c:if test="${result.sexCd eq '합계' }">background:beige;</c:if>"><fmt:formatNumber value="${result.age4}" pattern="#,###" /></td>
									<td style="text-align:center;<c:if test="${result.bikeType eq '전체' }">background:grey;color:white;</c:if><c:if test="${result.sexCd eq '합계' }">background:beige;</c:if>"><fmt:formatNumber value="${result.age5}" pattern="#,###" /></td>
									<td style="text-align:center;<c:if test="${result.bikeType eq '전체' }">background:grey;color:white;</c:if><c:if test="${result.sexCd eq '합계' }">background:beige;</c:if>"><fmt:formatNumber value="${result.age6}" pattern="#,###" /></td>
									<td style="text-align:center;<c:if test="${result.bikeType eq '전체' }">background:grey;color:white;</c:if><c:if test="${result.sexCd eq '합계' }">background:beige;</c:if>"><fmt:formatNumber value="${result.age7}" pattern="#,###" /></td>
									<td style="text-align:center;<c:if test="${result.bikeType eq '전체' }">background:grey;color:white;</c:if><c:if test="${result.sexCd eq '합계' }">background:beige;</c:if>"><fmt:formatNumber value="${result.age8}" pattern="#,###" /></td>
									<td style="text-align:center;<c:if test="${result.bikeType eq '전체' }">background:grey;color:white;</c:if><c:if test="${result.sexCd eq '합계' }">background:beige;</c:if>"><fmt:formatNumber value="${result.ageTotal}" pattern="#,###" /></td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
						</div>
					<c:choose>
						<c:when test="${fn:length(dataList) > 0}">
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
							<span class="right"><button type="button" id="excelBtn" class="btnType01">엑셀다운로드</button></span>
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
	   		var _this = ageStatistics;
	   		ageStatistics.initCombo();
			ageStatistics.initBtn();

			$('[name="searchBgnDe"]').val('${searchCondition.searchBgnDe}');
			$('[name="searchEndDe"]').val('${searchCondition.searchEndDe}');
			
			$("[name='stationGrp']").val(_this.stationGrp);
			$("[name='stationId']").val(_this.stationId);
			
			var type = '${searchCondition.rentType}';
			var rentType = type.split(",");
			for(var i = 0; i < rentType.length; i++){
				$('#'+rentType[i]).attr('checked', true);
			}
			
			$("#stationGrpSlt").on('change', function(e){
	        	var tId = e.target.id;
	        	var idx = $("#"+tId+" option:selected").index();
	        	var subList =$("#"+tId).data().sub_data;
	        	$("#stationIdSlt option").not(':eq(0)').remove();
	        	var sltsubData = subList[(idx-1)];
	        	if(sltsubData !== undefined) {
		        	if(sltsubData.length > 0) {
			        	commCdBox.makeComboBox("S",_this.stationId,sltsubData, "stationIdSlt");
		        	}
	        	}
	        });
			
			var totalPageCount = '${paginationInfo.totalPageCount}' == '' ? 1 : Number('${paginationInfo.totalPageCount}');
			$('#prevPage').on("click",function(){
				var currentPageNo = Number($('[name="currentPageNo"]').val());
				ageStatistics.pageSelect(currentPageNo-1);
			});
			$('#nextPage').on("click",function(){
				var currentPageNo = Number($('[name="currentPageNo"]').val());
				ageStatistics.pageSelect(currentPageNo+1);
			});
			$('#movePage').on("click",function(){
				var currentPageNo = Number($('[name="currentPageNo"]').val());
				var regExp = /^[1-9]?[0-9]/;
				if(!regExp.test(currentPageNo) ||(totalPageCount < currentPageNo)){
					alert('현재 페이지 값이 정상적이지 않습니다.');
				}else{
					ageStatistics.pageSelect(currentPageNo);
				}
			});
	   	});
	   	
	   	var ageStatistics = {};
	    ageStatistics.stationGrp = '${searchCondition.stationGrp}';
	    ageStatistics.stationId = '${searchCondition.stationId}';
	   	
	   	ageStatistics.initCombo = function(){
	    	var _this = ageStatistics;
	
	    	//스테이션 
	        commonAjax.getStationCode( 
		        function(data) {
		            if(data != null && data.stationList != null) {
		                commCdBox.makeComboBox('S',_this.stationGrp, data.stationList, "stationGrpSlt");
		                $("#stationGrpSlt").trigger('change');
		            }
		        }
	        );
	    };
	    
	    ageStatistics.initBtn = function(){
	    	var _this = ageStatistics;
	    	$("#searchBtn").on("click", this.exeStatisticsFnc);
	    	$("#excelBtn").on("click", this.exeStatisticsExcelFnc);
	    }
	    
	    ageStatistics.exeStatisticsFnc = function(e) {
	        e.preventDefault();
	        
	        if(DateUtil.checkDateTerm( $( "[name='searchBgnDe']").val(),  $( "[name='searchEndDe']").val()) != 'ok') {
	            alert('<spring:message code="fail.input.daterange"/>');
	            return false;
	        }
	        
	        var rentType = "";
	        $('[name="type"]:checked').each(function(idx){
	        	if(idx == 0){
	        		rentType = rentType + $(this).val();
	        	}else{
	        		rentType = rentType + "," + $(this).val();
	        	}
	        });
	        
	        $("[name='rentType']").val(rentType);
	        $("[name='currentPageNo']").val(1);
	        $("#searchFrm").attr({method : 'post', action : '/use/ageStatistics.do'}).submit();
	    };
	    
	    ageStatistics.exeStatisticsExcelFnc = function(e) {
	        e.preventDefault();
	        
	        if(DateUtil.checkDateTerm( $( "[name='searchBgnDe']").val(),  $( "[name='searchEndDe']").val()) != 'ok') {
	            alert('<spring:message code="fail.input.daterange"/>');
	            return false;
	        }
	        
	        var rentType = "";
	        $('[name="type"]:checked').each(function(idx){
	        	if(idx == 0){
	        		rentType = rentType + $(this).val();
	        	}else{
	        		rentType = rentType + "," + $(this).val();
	        	}
	        });
	        $("[name='rentType']").val(rentType);
	        $("#searchFrm").attr({method : 'post', action : '/use/ageStatisticsExcel.do'}).submit();
	    };
	    
	    ageStatistics.pageSelect = function(pageNo) {
	    	$("[name='currentPageNo']").val(pageNo);
	    	$("#searchFrm").attr({method : 'post', action :'/use/ageStatistics.do'}).submit();
	    };
    </script>
</body> 
</html>