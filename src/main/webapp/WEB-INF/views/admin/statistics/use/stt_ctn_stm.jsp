<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
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
						<p class="pageTitle">시간대별 이용</p>
						<span>통계 &gt; 이용내역 &gt; <em>시간대별</em></span>
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
								<input type="hidden" name="rentType" value="${searchCondition.rentType}" />
								<fieldset>
									<legend>검색 옵션</legend>
									<div class="shBoxSection">
										<div class="section">
											<label for="searchBgnDe" class="laType02">대여일</label>
											<span>
												<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" id="searchBgnDe" name="searchBgnDe" readonly/></span>
												<span class="dash">~</span>
												<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" id="searchEndDe" name="searchEndDe" readonly/></span>
											</span>
										</div>
										<div class="section pright radbox2">
											<!-- <label class="laType02">대여구분</label>
											<span>
												<span class="input-rd01"><input type="checkbox" id="RCC_001" name="type" value="RCC_001"><label for="RCC_001"> 정기</label></span>
												<span class="input-rd01"><input type="checkbox" id="RCC_002" name="type" value="RCC_002"><label for="RCC_002"> 회원</label></span>
												<span class="input-rd01"><input type="checkbox" id="RCC_003" name="type" value="RCC_003"><label for="RCC_003"> 비회원</label></span>
												<span class="input-rd01"><input type="checkbox" id="RCC_004" name="type" value="RCC_004"><label for="RCC_004"> 단체</label></span>
											</span> -->
											<button type="button" id="searchBtn" class="btn-srh03 btncase1"><img src="/images/searchIcon.gif" alt="검색" /></button>
										</div>
										<div class="section">
											<label for="stationGrpSlt" class="laType02">아파트</label>
											<select class="select-category02" name="stationGrp" id="stationGrpSlt">
                                                <option value="">선택</option>
                                            </select>
										</div>
										<div class="section pright">
											<label for="stationIdSlt" class="laType02">대여소</label>
											<select class="select-category03" name="stationId" id="stationIdSlt">
												<option value="">선택</option>
											</select>
										</div>
									</div>
								</fieldset>
							</div>
						<!--검색조건 E-->
						<p class="tb_numlist">총 ${ paginationInfo.getTotalRecordCount()} 건</p>
						<div class="widscr mt5">
						<table class="tb_type01 tb_right" style="min-width:1200px">
							<colgroup>
								<col style="width:150px"/>
								<col style="width:auto" span="25" />
							</colgroup>
							<thead> 
								<tr>
									<th>대여소명</th>
									<th>0</th>
									<th>1</th>
									<th>2</th>
									<th>3</th>
									<th>4</th>
									<th>5</th>
									<th>6</th>
									<th>7</th>
									<th>8</th>
									<th>9</th>
									<th>10</th>
									<th>11</th>
									<th>12</th>
									<th>13</th>
									<th>14</th>
									<th>15</th>
									<th>16</th>
									<th>17</th>
									<th>18</th>
									<th>19</th>
									<th>20</th>
									<th>21</th>
									<th>22</th>
									<th>23</th>
									<th>합계</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach var="result" items="${dataList}" varStatus="status">
								<tr>
									<td class="tl">${result.stationName}</td>
									<td>${result.useCntTime00}</td>
									<td>${result.useCntTime01}</td>
									<td>${result.useCntTime02}</td>
									<td>${result.useCntTime03}</td>
									<td>${result.useCntTime04}</td>
									<td>${result.useCntTime05}</td>
									<td>${result.useCntTime06}</td>
									<td>${result.useCntTime07}</td>
									<td>${result.useCntTime08}</td>
									<td>${result.useCntTime09}</td>
									<td>${result.useCntTime10}</td>
									<td>${result.useCntTime11}</td>
									<td>${result.useCntTime12}</td>
									<td>${result.useCntTime13}</td>
									<td>${result.useCntTime14}</td>
									<td>${result.useCntTime15}</td>
									<td>${result.useCntTime16}</td>
									<td>${result.useCntTime17}</td>
									<td>${result.useCntTime18}</td>
									<td>${result.useCntTime19}</td>
									<td>${result.useCntTime20}</td>
									<td>${result.useCntTime21}</td>
									<td>${result.useCntTime22}</td>
									<td>${result.useCntTime23}</td>
									<td>${result.useCntTimeTotal}</td>
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
						</form>
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
	   		
	   		var _this = timeStatistics;
	   		timeStatistics.initCombo();
			timeStatistics.initBtn();
	   		
			$("[name='stationGrp']").val(_this.stationGrp);
			$("[name='stationId']").val(_this.stationId);
			$('[name="searchBgnDe"]').val('${searchCondition.searchBgnDe}');
			$('[name="searchEndDe"]').val('${searchCondition.searchEndDe}');
			
			var type = '${searchCondition.rentType}';
			var rentType = type.split(",");
			for(var i = 0; i < rentType.length; i++){
				$('#'+rentType[i]).attr('checked', true);
			}
			
			
			
			var totalPageCount = '${paginationInfo.totalPageCount}' == '' ? 1 : Number('${paginationInfo.totalPageCount}');
			$('#prevPage').on("click",function(){
				var currentPageNo = Number($('[name="currentPageNo"]').val());
				timeStatistics.pageSelect(currentPageNo-1);
			});
			$('#nextPage').on("click",function(){
				var currentPageNo = Number($('[name="currentPageNo"]').val());
				timeStatistics.pageSelect(currentPageNo+1);
			});
			$('#movePage').on("click",function(){
				var currentPageNo = Number($('[name="currentPageNo"]').val());
				var regExp = /^[1-9]?[0-9]/;
				if(!regExp.test(currentPageNo) ||(totalPageCount < currentPageNo)){
					alert('현재 페이지 값이 정상적이지 않습니다.');
				}else{
					timeStatistics.pageSelect(currentPageNo);
				}
			});
	   	});
	   	
	   	var timeStatistics = {};
	    timeStatistics.stationGrp = '${searchCondition.stationGrp}';
	    timeStatistics.stationId = '${searchCondition.stationId}';
	   	
	   	timeStatistics.initCombo = function(){
	    	var _this = timeStatistics;
	
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
	    
	    timeStatistics.initBtn = function(){
	    	var _this = timeStatistics;
	    	$("#searchBtn").on("click", this.exeStatisticsFnc);
	    	$("#excelBtn").on("click", this.exeStatisticsExcelFnc);
	    }
	    
	    timeStatistics.exeStatisticsFnc = function(e) {
	        e.preventDefault();
	        
	        if(DateUtil.diffDays( $("[name='searchBgnDe']").val(),  $("[name='searchEndDe']").val(), '-') > 32){
		    	alert("조회기간은 한달 이내로 설정해주세요.");
		    	return false;
		    }
	        
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
	        $("#searchFrm").attr({method : 'post', action : '/use/timeStatistics.do'}).submit();
	        fn_loading();
	    };
	    
	    timeStatistics.exeStatisticsExcelFnc = function(e) {
	        e.preventDefault();
	        
	        if(DateUtil.diffDays( $("[name='searchBgnDe']").val(),  $("[name='searchEndDe']").val(), '-') > 32){
		    	alert("조회기간은 한달 이내로 설정해주세요.");
		    	return false;
		    }

	        
	        
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
	        $("#searchFrm").attr({method : 'post', action : '/use/timeStatisticsExcel.do'}).submit();
	    };
	    
	    timeStatistics.pageSelect = function(pageNo) {
	    	$("[name='currentPageNo']").val(pageNo);
	    	$("#searchFrm").attr({method : 'post', action :'/use/timeStatistics.do'}).submit();
	    };
    </script>
</body>
</html>