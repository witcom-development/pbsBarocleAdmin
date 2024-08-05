<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%
	Calendar cal = Calendar.getInstance();
	int minYear = 2010;
	int nowYear = cal.get(Calendar.YEAR);
	SimpleDateFormat sdf = new SimpleDateFormat("MM");
	String nowMonth = sdf.format(cal.getTime());
%>
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
						<p class="pageTitle">운동량/탄소량 현황</p>
						<span>통계 &gt; 이용내역 &gt; <em>운동량/탄소량 현황</em></span>
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
								<input type="hidden" name="dateType" />
								<input type="hidden" name="rentType" />
								<input type="hidden" name="searchBgnMt" />
								<input type="hidden" name="searchEndMt" />
								<fieldset>
									<legend>검색 옵션</legend>
									<div class="shBoxSection">
										<div class="section radbox">
											<label class="laType02">구분</label>
											<span>
												<span class="input-rd01"><input data-chn="daymth1" type="radio" id="day" name="dType" value="D"><label for="day"> 일</label></span>
												<span class="input-rd01"><input data-chn="daymth1" type="radio" id="week" name="dType" value="W"><label for="week"> 요일</label></span>
												<span class="input-rd01"><input data-chn="daymth2" type="radio" id="month" name="dType" value="M"><label for="month"> 월</label></span>
											</span>
										</div>
										<div class="section pright">
											<label for="bb22" class="laType02">일/요일/월</label>
											<p class="daymth1">
												<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" name="searchBgnDe" readonly/></span>
												<span class="dash">~</span>
												<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" name="searchEndDe" readonly/></span>
											</p>
											<p class="daymth2">
												<select name="searchBgnYear">
												<%
													for(int i = minYear; i < (nowYear+1); i++){
												%>
													<option value="<%=i%>"><%=i%></option>
												<%
													}
												%>
												</select>
												<select name="searchBgnMonth">
													<option value="01">01</option>
													<option value="02">02</option>
													<option value="03">03</option>
													<option value="04">04</option>
													<option value="05">05</option>
													<option value="06">06</option>
													<option value="07">07</option>
													<option value="08">08</option>
													<option value="09">09</option>
													<option value="10">10</option>
													<option value="11">11</option>
													<option value="12">12</option>
												</select>
												<span class="dash">~</span>
												<select name="searchEndYear">
												<%
													for(int i = minYear; i < (nowYear+1); i++){
												%>
													<option value="<%=i%>"><%=i%></option>
												<%
													}
												%>
												</select>
												<select name="searchEndMonth">
													<option value="01">01</option>
													<option value="02">02</option>
													<option value="03">03</option>
													<option value="04">04</option>
													<option value="05">05</option>
													<option value="06">06</option>
													<option value="07">07</option>
													<option value="08">08</option>
													<option value="09">09</option>
													<option value="10">10</option>
													<option value="11">11</option>
													<option value="12">12</option>
												</select>
											</p>
										</div>
										<div class="section radbox2">
											<label class="laType02">대여구분</label>
											<span>
												<span class="input-rd01"><input type="checkbox" id="RCC_001" name="type" value="RCC_001"><label for="RCC_001"> 정기</label></span>
												<span class="input-rd01"><input type="checkbox" id="RCC_002" name="type" value="RCC_002"><label for="RCC_002"> 회원</label></span>
<!-- 												<span class="input-rd01"><input type="checkbox" id="RCC_003" name="type" value="RCC_003"><label for="RCC_003"> 비회원</label></span> -->
												<span class="input-rd01"><input type="checkbox" id="RCC_004" name="type" value="RCC_004"><label for="RCC_004"> 단체</label></span>
											</span>
										</div>
										<div class="section pright">
											<button type="button" id="searchBtn" class="btn-srh03 btncase1"><img src="/images/searchIcon.gif" alt="검색" /></button>
										</div>
									</div>
								</fieldset>
							</div>
						<!--검색조건 E-->
						<p class="tb_numlist">총 ${ paginationInfo.getTotalRecordCount()} 건</p>
						<div class="widscr mt5">
						<table class="tb_type03 tb_right" style="min-width:800px">
							<colgroup>
								<col style="width:100px"/>
								<col style="width:auto" span="16" />
							</colgroup>
							<thead> 
								<tr>
									<th rowspan="2">구분</th>
									<th colspan="2">10대</th>
									<th colspan="2">20대</th>
									<th colspan="2">30대</th>
									<th colspan="2">40대</th>
									<th colspan="2">50대</th>
									<th colspan="2">60대</th>
									<th colspan="2">70대</th>
									<th rowspan="2">합계<p>운동</p></th>
									<th rowspan="2">합계<p>탄소</p></th>
								</tr>
								<tr>
									<th>운동량</th>
									<th>탄소량</th>
									<th>운동량</th>
									<th>탄소량</th>
									<th>운동량</th>
									<th>탄소량</th>
									<th>운동량</th>
									<th>탄소량</th>
									<th>운동량</th>
									<th>탄소량</th>
									<th>운동량</th>
									<th>탄소량</th>
									<th>운동량</th>
									<th>탄소량</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach var="result" items="${dataList}" varStatus="status">
								<tr>
									<td class="tl">${result.statisticsDate}</td>
									<td>${result.useCntAgeMvm_10}</td>
									<td>${result.useCntAgeCo2_10}</td>
									<td>${result.useCntAgeMvm_20}</td>
									<td>${result.useCntAgeCo2_20}</td>
									<td>${result.useCntAgeMvm_30}</td>
									<td>${result.useCntAgeCo2_30}</td>
									<td>${result.useCntAgeMvm_40}</td>
									<td>${result.useCntAgeCo2_40}</td>
									<td>${result.useCntAgeMvm_50}</td>
									<td>${result.useCntAgeCo2_50}</td>
									<td>${result.useCntAgeMvm_60}</td>
									<td>${result.useCntAgeCo2_60}</td>
									<td>${result.useCntAgeMvm_70}</td>
									<td>${result.useCntAgeCo2_70}</td>
									<td>${result.useCntAgeMvm_Total}</td>
									<td>${result.useCntAgeCo2_Total}</td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
						</div>
						<c:if test="${searchCondition.dateType != 'W'}">
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
						</c:if>
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
		$('[name="searchBgnDe"]').val('${searchCondition.searchBgnDe}');
		$('[name="searchEndDe"]').val('${searchCondition.searchEndDe}');
		
		var dateType = '${searchCondition.dateType == null ? "D" : searchCondition.dateType}';
   		$('[name="dateType"]').val(dateType);
   		
   		if(dateType == "M"){
   			var searchBgnMt = '${searchCondition.searchBgnMt}';
   			var searchEndMt = '${searchCondition.searchEndMt}';
   			$('[name="searchBgnMt"]').val(searchBgnMt);
   			$('[name="searchEndMt"]').val(searchEndMt);
   			$('[name="searchBgnYear"]').val(searchBgnMt.substring(0,4));
   	   		$('[name="searchBgnMonth"]').val(searchBgnMt.substring(4,6));
   	   		$('[name="searchEndYear"]').val(searchEndMt.substring(0,4));
   	   		$('[name="searchEndMonth"]').val(searchEndMt.substring(4,6));
   		}else{
   			$('[name="searchBgnYear"]').val('<%=nowYear%>');
   	   		$('[name="searchBgnMonth"]').val('<%=nowMonth%>');
   	   		$('[name="searchEndYear"]').val('<%=nowYear%>');
   	   		$('[name="searchEndMonth"]').val('<%=nowMonth%>');
   	   		$('[name="searchBgnMt"]').val('<%=nowYear+nowMonth%>');
   	   		$('[name="searchEndMt"]').val('<%=nowYear+nowMonth%>');
   		}
		
   		var type = '${searchCondition.rentType}';
		var rentType = type.split(",");
		for(var i = 0; i < rentType.length; i++){
			$('#'+rentType[i]).attr('checked', true);
		}
   		
   		if($('[name="dateType"]').val() == 'D'){
   			$('.daymth1').css('display','inline-block');
			$('.daymth2').css('display','none');
   			$('#day').attr("checked", true);
   		}
   		
   		if($('[name="dateType"]').val() == 'W'){
   			$('.daymth1').css('display','inline-block');
			$('.daymth2').css('display','none');
   			$('#week').attr("checked", true);
   		}

   		if($('[name="dateType"]').val() == 'M'){
   			$('.daymth1').css('display','none');
			$('.daymth2').css('display','inline-block');
   			$('#month').attr("checked", true);
   		}
   		
   		$('[name="dType"]').on("click", function(){
   			if($(this).attr("id") == 'day'){
   				$('.daymth2').css('display','none');
   				$('.daymth1').css('display','inline-block');
   				$('[name="searchBgnMt"]').val('');
   				$('[name="searchEndMt"]').val('');
   				$('[name="dateType"]').val('D');
   			}else if($(this).attr("id") == 'week'){
   				$('.daymth2').css('display','none');
   				$('.daymth1').css('display','inline-block');
   				$('[name="searchBgnMt"]').val('');
   				$('[name="searchEndMt"]').val('');
   				$('[name="dateType"]').val('W');
   			}else if($(this).attr("id") == 'month'){
   				$('.daymth1').css('display','none');
   				$('.daymth2').css('display','inline-block');
   	   			$('[name="searchBgnMt"]').val($('[name="searchBgnYear"]').val()+$('[name="searchBgnMonth"]').val());
   	   			$('[name="searchEndMt"]').val($('[name="searchEndYear"]').val()+$('[name="searchEndMonth"]').val());
   				$('[name="dateType"]').val('M');
   			}
   		});
   		
   		$('[name="searchBgnYear"]').on('change', function(){
   			$('[name="searchBgnMt"]').val($('[name="searchBgnYear"]').val()+$('[name="searchBgnMonth"]').val());
   		});
   		$('[name="searchBgnMonth"]').on('change', function(){
   			$('[name="searchBgnMt"]').val($('[name="searchBgnYear"]').val()+$('[name="searchBgnMonth"]').val());
   		});
   		$('[name="searchEndYear"]').on('change', function(){
   			$('[name="searchEndMt"]').val($('[name="searchEndYear"]').val()+$('[name="searchEndMonth"]').val());
   		});
   		$('[name="searchEndMonth"]').on('change', function(){
   			$('[name="searchEndMt"]').val($('[name="searchEndYear"]').val()+$('[name="searchEndMonth"]').val());
   		});
   		
   		$('#searchBtn').on("click", function(){
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
   	    	$("[name='currentPageNo']").val('1');
   	    	
   			if($("[name='searchBgnMt']").val() > $("[name='searchEndMt']").val()) {
   	            alert('<spring:message code="fail.input.daterange"/>');
   	            return false;
   	        }
   			if($('[name="dateType"]').val() == 'W'){
   				var chkDay = DateUtil.diffDays($(".datepicker").eq(0).val(), $(".datepicker").eq(1).val(), '-');
   	   			if(chkDay > 7) {
   	   				alert("검색 기간이 7일을 초과 하였습니다.");
   	   				return false;
   	   			}
   			}
   			
    		$('#searchFrm').attr({method : 'post', action : '/use/ranStatistics.do'}).submit();
    		
    		fn_loading(); 
    		
   		});
   		
   		$('#excelBtn').on("click", function(){
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
   	    	
   			if($("[name='searchBgnMt']").val() > $("[name='searchEndMt']").val()) {
   	            alert('<spring:message code="fail.input.daterange"/>');
   	            return false;
   	        }
    		$('#searchFrm').attr({method : 'post', action : '/use/ranStatisticsExcel.do'}).submit();
   		});
   		
   		var totalPageCount = '${paginationInfo.totalPageCount}' == '' ? 1 : Number('${paginationInfo.totalPageCount}');
   		$('#prevPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			ranStatistics.pageSelect(currentPageNo-1);
		});
		$('#nextPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			ranStatistics.pageSelect(currentPageNo+1);
		});
		$('#movePage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			var regExp = /^[1-9]?[0-9]/;
			if(!regExp.test(currentPageNo) ||(totalPageCount < currentPageNo)){
				alert('현재 페이지 값이 정상적이지 않습니다.');
			}else{
				ranStatistics.pageSelect(currentPageNo);
			}
		});
   	});
   	
   	var ranStatistics = {};
		
	ranStatistics.pageSelect = function(pageNo) {
    	$("[name='currentPageNo']").val(pageNo);
    	$("#searchFrm").attr({action :'/use/ranStatistics.do', method : 'post'}).submit();
    };
    </script>
</body>
</html>