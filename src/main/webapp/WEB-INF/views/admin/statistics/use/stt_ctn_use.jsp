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
	cal.add(Calendar.MONTH, -1);
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
						<p class="pageTitle">이용자별 이용</p>
						<span>통계 &gt; 이용내역 &gt; <em>이용자별</em></span>
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
								<input type="hidden" name="sortType"/>
								<fieldset>
									<legend>검색 옵션</legend>
									<div class="shBoxSection">
										<div class="section radbox">
											<label class="laType02">구분</label>
											<span>
												<span class="input-rd01"><input data-chn="daymth1" type="radio" id="daily" name="dType" value="daily" checked><label for="daily"> 일</label></span>
												<!-- <span class="input-rd01"><input data-chn="daymth2" type="radio" id="monthly" name="dType" value="monthly"><label for="monthly"> 월</label></span> -->
											</span>
										</div>
										<div class="section pright">
											<label class="laType02">날짜</label>
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
											<button type="button" id="searchBtn" class="btn-srh03 btncase1"><img src="/images/searchIcon.gif" alt="검색" /></button>
										</div>
									</div>
								</fieldset>
							</div>
							
							<div class="lralign mt20">
	                           <p><span>총 ${fn:length(dataList)} 건</span></p>
	                        </div>	
						
							<table class="tb_type01">
								<colgroup>
									<col style="width:13%"/>
									<col style="width:15%"/>
									<col style="width:15%"/> 
									<col style="width:14%"/> 
								</colgroup>
								<thead> 
									<tr>
										<th>일자</th>
										<th>대여건수</th>
										<th>이동거리(m)</th> 
										<th>이용시간(분)</th> 
									</tr>
								</thead>
								<tbody>
								<c:forEach var="result" items="${dataList}" varStatus="status">
	                                <tr>
	                                    <td style="text-align: center">${result.getUseMember_date}</td>
	                                    <td style="text-align: right; background-color: #e6ffee"><fmt:formatNumber value="${result.getUseMember_1}" pattern="#,###" /></td>
	                                    <td style="text-align: right;"><fmt:formatNumber value="${result.getUseMember_2}" pattern="#,###" /></td>
	                                    <td style="text-align: right;"><fmt:formatNumber value="${result.getUseMember_3}" pattern="#,###" /></td>
	                                </tr>
	                            </c:forEach>    
	                            <c:if test="${fn:length(dataList) eq 0 }">
									<table class="tb_type01 nbt0">
										<tr><td style="text-align:center">noData</td></tr>
									</table>
								</c:if>
								</tbody>
							</table>
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
   		
   		if($('[name="dateType"]').val() == 'D'){
   			$('#daily').attr("checked", true);
   		}

   		if($('[name="dateType"]').val() == 'M'){
   			$('.daymth1').css('display','none');
			$('.daymth2').css('display','inline-block');
   			$('#monthly').attr("checked", true);
   		}
   		
   		
   		$('[name="dType"]').on("click", function(){
   			if($(this).attr("id") == 'daily'){
   				$('.daymth2').css('display','none');
   				$('.daymth1').css('display','inline-block');
   				$('[name="searchBgnMt"]').val('');
   				$('[name="searchEndMt"]').val('');
   				$('[name="dateType"]').val('D');
   			}else if($(this).attr("id") == 'monthly'){
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
   			
   	    	$("[name='currentPageNo']").val('1');
   	    	
   			if($("[name='searchBgnMt']").val() > $("[name='searchEndMt']").val()) {
   	            alert('<spring:message code="fail.input.daterange"/>');
   	            return false;
   	        }

  			if($('[name="dateType"]').val() == 'D'){
   				if(DateUtil.diffDays( $("[name='searchBgnDe']").val(),  $("[name='searchEndDe']").val(), '-') > 31){
   		    		alert("일별 조회기간은 한달 이내로 설정해주세요.");
   		    		return false;
   		    	}	
   			}
   			if($('[name="dateType"]').val() == 'M'){
   				if(DateUtil.diffMonths( $("[name='searchBgnMt']").val(),  $("[name='searchEndMt']").val(), '') > 24){
   		    		alert("월별 조회기간은 2년 이내로 설정해주세요.");
   		    		return false;
   		    	}	
   			} 
   			
   			$('#searchFrm').attr({method : 'post', action : '/use/userStatistics.do'}).submit();
   			
   			fn_loading(); 
   		});
   		
   		$('#excelBtn').on("click", function(){
   			if(DateUtil.checkDateTerm( $( "[name='searchBgnDe']").val(),  $( "[name='searchEndDe']").val()) != 'ok') {
   	            alert('<spring:message code="fail.input.daterange"/>');
   	            return false;
   	        }
   			
   			if($("[name='searchBgnMt']").val() > $("[name='searchEndMt']").val()) {
   	            alert('<spring:message code="fail.input.daterange"/>');
   	            return false;
   	        }
   			if($('[name="dateType"]').val() == 'D'){
   				if(DateUtil.diffDays( $("[name='searchBgnDe']").val(),  $("[name='searchEndDe']").val(), '-') > 31){
   		    		alert("조회기간은 한달 이내로 설정해주세요.");
   		    		return false;
   		    	}	
   			}
   			if($('[name="dateType"]').val() == 'M'){
   				if(DateUtil.diffMonths( $("[name='searchBgnMt']").val(),  $("[name='searchEndMt']").val(), '') > 24){
   		    		alert("월별 조회기간은 2년 이내로 설정해주세요.");
   		    		return false;
   		    	}	
   			} 
   			
    		$('#searchFrm').attr({method : 'post', action : '/use/userStatisticsExcel.do'}).submit();
   		});
   		
   		
   		var totalPageCount = '${paginationInfo.totalPageCount}' == '' ? 1 : Number('${paginationInfo.totalPageCount}');
   		$('#prevPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			userStatistics.pageSelect(currentPageNo-1);
		});
		$('#nextPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			userStatistics.pageSelect(currentPageNo+1);
		});
		$('#movePage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			var regExp = /^[1-9]?[0-9]/;
			if(!regExp.test(currentPageNo) ||(totalPageCount < currentPageNo)){
				alert('현재 페이지 값이 정상적이지 않습니다.');
			}else{
				userStatistics.pageSelect(currentPageNo);
			}
		});
		
		
   	});
   	
   	var userStatistics = {};
		
	userStatistics.pageSelect = function(pageNo) {
    	$("[name='currentPageNo']").val(pageNo);
    	$("#searchFrm").attr({action :'/use/userStatistics.do', method : 'post'}).submit();
    };
   	
    </script>
</body>
</html>