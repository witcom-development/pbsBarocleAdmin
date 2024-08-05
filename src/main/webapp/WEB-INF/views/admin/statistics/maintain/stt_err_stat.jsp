<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%
	Calendar cal = Calendar.getInstance();
	int minYear = 2010;
	int nowYear = cal.get(Calendar.YEAR);
	SimpleDateFormat sdf = new SimpleDateFormat("MM");
	String nowMonth = sdf.format(cal.getTime());
%>
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
						<p class="pageTitle">장애통계</p>
						<span>통계 &gt; 유지보수 통계 &gt; <em>장애통계</em></span>
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
								<input type="hidden" name="searchBgnMt" />
								<input type="hidden" name="searchEndMt" />
								<input type="hidden" name="searchBgnYe" />
								<input type="hidden" name="searchEndYe" />
								<fieldset>
									<legend>검색 옵션</legend>
									<div class="shBoxSection">
										<div class="section radbox">
											<label class="laType02">구분</label>
											<span>
												<span class="input-rd01"><input data-chn="daymth1" type="radio" id="day" name="dType" value="D"><label for="day"> 일</label></span>
												<span class="input-rd01"><input data-chn="daymth2" type="radio" id="month" name="dType" value="M"><label for="month"> 월</label></span>
												<span class="input-rd01"><input data-chn="daymth2" type="radio" id="year" name="dType" value="Y"><label for="year"> 년</label></span>
											</span>
										</div>
										<div class="section pright">
											<label for="bb22" class="laType02">일/월/년</label>
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
												<span class="inputMt">
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
												</span>
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
												<span class="inputMt">
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
												</span>
											</p>
										</div>
										<div class="section">
											<label for="aa2" class="laType02">점검 장치</label>
											<select class="select-category02" id="deviceType" name="deviceType">
											</select>
											<button type="button" id="searchBtn" class="btn-srh03 btncase1"><img src="/images/searchIcon.gif" alt="검색" /></button>
										</div>
									</div>
								</fieldset>
							</div>
						<!--검색조건 E-->
						<p class="tb_numlist">총 <fmt:formatNumber type="number" value="${ paginationInfo.getTotalRecordCount() / stateCodeCnt }"/> 건</p>
						<table class="tb_type01">
							<colgroup>
								<col style="width:25%"/>
								<col style="width:25%"/>
								<col style="width:25%"/>
								<col style="width:auto"/>
							</colgroup>
							<thead> 
								<tr>
									<th>일자</th>
									<th>소계</th>
									<th>장애구분</th>
									<th>발생건수</th>
								</tr>
							</thead>
							<tbody>
							<c:set var="prevDttm" value=""/>
							<c:forEach var="result" items="${dataList}" varStatus="status">
								<c:choose>
									<c:when test="${prevDttm != result.faultDttm}">
										<tr>
											<td class="tc vm" rowspan="${stateCodeCnt}">${result.faultDttm}</td>
											<!-- 총합 계산 필요한 부분입니다  -->
											<td class="tc vm" rowspan="${stateCodeCnt}">${result.faultTotal}</td>
											<td>${result.faultName}</td>
											<td class="tr">${result.faultCnt}</td>
										</tr>
									</c:when>
									<c:otherwise>
										<tr>
											<td>${result.faultName}</td>
											<td class="tr">${result.faultCnt}</td>
										</tr>
									</c:otherwise>
								</c:choose>
								<c:set var="prevDttm" value="${result.faultDttm}"/>
							</c:forEach>
							</tbody>
						</table>
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
   		commonAjax.getCommonCode('DEV', function(data){
    		if(data !== null && data.codeList !== null) {
           	 	for(var i = 0; i < data.codeList.length; i++){
           	 		if(data.codeList[i].comCd != 'DEV_002'){
           	 			$('<option value="'+data.codeList[i].comCd+'">'+data.codeList[i].comCdName+'</option>').appendTo('#deviceType');
           	 		}
           	 	}
           		$('[name="deviceType"]').val('${searchCondition.deviceType}');
            }
    	});
		
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
   		}else if(dateType == "Y"){
   			var searchBgnYe = '${searchCondition.searchBgnYe}';
   			var searchEndYe = '${searchCondition.searchEndYe}';
   			$('[name="searchBgnYe"]').val(searchBgnYe);
   			$('[name="searchEndYe"]').val(searchEndYe);
   			$('[name="searchBgnYear"]').val(searchBgnYe);
   	   		$('[name="searchEndYear"]').val(searchEndYe);
   		}else{
   	   		$('[name="searchBgnDe"]').val('${searchCondition.searchBgnDe}');
   			$('[name="searchEndDe"]').val('${searchCondition.searchEndDe}');
   			$('[name="searchBgnYear"]').val('<%=nowYear%>');
   	   		$('[name="searchBgnMonth"]').val('<%=nowMonth%>');
   	   		$('[name="searchEndYear"]').val('<%=nowYear%>');
   	   		$('[name="searchEndMonth"]').val('<%=nowMonth%>');
   	   		$('[name="searchBgnMt"]').val('<%=nowYear+nowMonth%>');
   	   		$('[name="searchEndMt"]').val('<%=nowYear+nowMonth%>');
   	   		$('[name="searchBgnYe"]').val('<%=nowYear%>');
   	   		$('[name="searchEndYe"]').val('<%=nowYear%>');
   		}
   		
   		if($('[name="dateType"]').val() == 'D'){
   			$('.daymth1').css('display','inline-block');
   			$('.daymth2').css('display','none');
   			$('#day').attr("checked", true);
   		}

   		if($('[name="dateType"]').val() == 'M'){
   			$('.daymth1').css('display','none');
   			$('.daymth2').css('display','inline-block');
   			$('#month').attr("checked", true);
   		}
   		
   		if($('[name="dateType"]').val() == 'Y'){
			$('.daymth1').css('display','none');
			$('.daymth2').css('display','inline-block');
			$('.inputMt').css('display','none');
   			$('#year').attr("checked", true);
   		}
   		
   		$('[name="dType"]').on("click", function(){
   			if($(this).attr("id") == 'day'){
   				$('.daymth1').css('display','inline-block');
   				$('.daymth2').css('display','none');
   				$('[name="searchBgnMt"]').val('');
   				$('[name="searchEndMt"]').val('');
   				$('[name="searchBgnYe"]').val('');
   				$('[name="searchEndYe"]').val('');
   				$('[name="dateType"]').val('D');
   			}else if($(this).attr("id") == 'month'){
   				$('.daymth1').css('display','none');
   				$('.daymth2').css('display','inline-block');
   				$('.inputMt').css('display','inline-block');
   	   			$('[name="searchBgnMt"]').val($('[name="searchBgnYear"]').val()+$('[name="searchBgnMonth"]').val());
   				$('[name="searchEndMt"]').val($('[name="searchEndYear"]').val()+$('[name="searchEndMonth"]').val());
   				$('[name="dateType"]').val('M');
   			}else if($(this).attr("id") == 'year'){
   				$('.daymth1').css('display','none');
   				$('.daymth2').css('display','inline-block');
   				$('.inputMt').css('display','none');
   	   			$('[name="searchBgnYe"]').val($('[name="searchBgnYear"]').val());
   	   			$('[name="searchEndYe"]').val($('[name="searchEndYear"]').val());
   				$('[name="dateType"]').val('Y');
   			}
   		});
   		
   		$('[name="searchBgnYear"]').on('change', function(){
   			$('[name="searchBgnMt"]').val($('[name="searchBgnYear"]').val()+$('[name="searchBgnMonth"]').val());
   			$('[name="searchBgnYe"]').val($('[name="searchBgnYear"]').val());
   		});
   		$('[name="searchBgnMonth"]').on('change', function(){
   			$('[name="searchBgnMt"]').val($('[name="searchBgnYear"]').val()+$('[name="searchBgnMonth"]').val());
   		});
   		$('[name="searchEndYear"]').on('change', function(){
   			$('[name="searchEndMt"]').val($('[name="searchEndYear"]').val()+$('[name="searchEndMonth"]').val());
   			$('[name="searchEndYe"]').val($('[name="searchEndYear"]').val());
   		});
   		$('[name="searchEndMonth"]').on('change', function(){
   			$('[name="searchEndMt"]').val($('[name="searchEndYear"]').val()+$('[name="searchEndMonth"]').val());
   		});
   		
   		$('#searchBtn').on("click", function(){
   			if($('[name="dateType"]').val() == 'D'){
   				if(DateUtil.checkDateTerm( $( "[name='searchBgnDe']").val(),  $( "[name='searchEndDe']").val()) != 'ok') {
   	   	            alert('<spring:message code="fail.input.daterange"/>');
   	   	            return false;
   	   	        }
   	   		}

   	   		if($('[name="dateType"]').val() == 'M'){
	   	   		if($("[name='searchBgnMt']").val() > $("[name='searchEndMt']").val()) {
	   	            alert('<spring:message code="fail.input.daterange"/>');
	   	            return false;
	   	        }
   	   		}
   	   		
   	   		if($('[name="dateType"]').val() == 'Y'){
	   	   		if($("[name='searchBgnYe']").val() > $("[name='searchEndYe']").val()) {
	   	            alert('<spring:message code="fail.input.daterange"/>');
	   	            return false;
	   	        }
   	   		}
	        
   	    	$("[name='currentPageNo']").val('1');
   	    	
    		$('#searchFrm').attr({method : 'post', action : '/maintain/errorStatistics.do'}).submit();
    		
    		fn_loading();
    		
   		});
   		
   		$('#excelBtn').on("click", function(){
   			if($('[name="dateType"]').val() == 'D'){
   				if(DateUtil.checkDateTerm( $( "[name='searchBgnDe']").val(),  $( "[name='searchEndDe']").val()) != 'ok') {
   	   	            alert('<spring:message code="fail.input.daterange"/>');
   	   	            return false;
   	   	        }
   	   		}

   	   		if($('[name="dateType"]').val() == 'M'){
	   	   		if($("[name='searchBgnMt']").val() > $("[name='searchEndMt']").val()) {
	   	            alert('<spring:message code="fail.input.daterange"/>');
	   	            return false;
	   	        }
   	   		}
   	   		
   	   		if($('[name="dateType"]').val() == 'Y'){
	   	   		if($("[name='searchBgnYe']").val() > $("[name='searchEndYe']").val()) {
	   	            alert('<spring:message code="fail.input.daterange"/>');
	   	            return false;
	   	        }
   	   		}
    		$('#searchFrm').attr({method : 'post', action : '/maintain/errorStatisticsExcel.do'}).submit();
   		});
   		
   		var totalPageCount = '${paginationInfo.totalPageCount}' == '' ? 1 : Number('${paginationInfo.totalPageCount}');
   		$('#prevPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			errorStatistics.pageSelect(currentPageNo-1);
		});
		$('#nextPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			errorStatistics.pageSelect(currentPageNo+1);
		});
		$('#movePage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			var regExp = /^[1-9]?[0-9]/;
			if(!regExp.test(currentPageNo) ||(totalPageCount < currentPageNo)){
				alert('현재 페이지 값이 정상적이지 않습니다.');
			}else{
				errorStatistics.pageSelect(currentPageNo);
			}
		});
   	});
   	
   	var errorStatistics = {};
		
	errorStatistics.pageSelect = function(pageNo) {
    	$("[name='currentPageNo']").val(pageNo);
    	$("#searchFrm").attr({action :'/maintain/errorStatistics.do', method : 'post'}).submit();
    };
    </script>
</body>
</html>