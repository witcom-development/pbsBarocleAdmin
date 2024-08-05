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
						<p class="pageTitle">운영보고</p>
						<span>통계 &gt; <em>운영보고</em></span>
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
								<fieldset>
									<legend>검색 옵션</legend>
									<div class="shBoxSection">
										<div class="section radbox">
											<label class="laType02">구분</label>
											<span>
												<span class="input-rd01"><input data-chn="daymth1" type="radio" id="day" name="dType" value="D"><label for="day"> 일</label></span>
												<span class="input-rd01"><input data-chn="daymth2" type="radio" id="month" name="dType" value="M"><label for="month"> 월</label></span>
											</span>
										</div>
										<div class="section pright">
											<label for="bb22" class="laType02">일/월</label>
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
						<!--검색조건 E-->
						
						<p class="head2"><em>운영내역 현황</em></p>
						<div class="widscr mt5">
						<table class="tb_type03" style="min-width:700px">
							<colgroup>
								<col style="width:8%"/>
								<col style="width:11%"/>
								<col style="width:8%"/>
								<col style="width:11%"/>
								<col style="width:8%"/>
								<col style="width:11%"/>
								<col style="width:11%"/>
								<col style="width:auto"/>
							</colgroup>
							<thead> 
								<tr>
									<th colspan="2" rowspan="2">수익금(천원)</th>
									<th colspan="2" rowspan="2">회원가입(명)</th>
									<th colspan="5">자전거 이용(건)</th>
								</tr>
								<tr>
									<th colspan="2">이용수</th>
									<th>평균 이용 수</th>
									<th>평균 이동거리(km)</th>
									<th>평균 이용시간</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<th>합계</th>
									<td class="tr"><fmt:formatNumber type="number" value="${incomeList[0].payAmt+incomeList[1].payAmt == null ? 0 : (incomeList[0].payAmt+incomeList[1].payAmt)/1000}"/></td>
									<th>합계</th>
									<td class="tr">${userjoinList[0].totCnt+userjoinList[1].totCnt == null ? 0 : userjoinList[0].totCnt+userjoinList[1].totCnt}</td>
									<th>합계</th>
									<td class="tr">${bikeuseList[0].useCnt+bikeuseList[1].useCnt+bikeuseList[2].useCnt}</td>
									<td class="tr"><fmt:formatNumber value="${bikeuseList[0].useCnt+bikeuseList[1].useCnt + bikeuseList[2].useCnt== null ? 0 : (bikeuseList[0].useCnt+bikeuseList[1].useCnt+bikeuseList[2].useCnt)/period}" pattern="0.00"></fmt:formatNumber></td>
									<td class="tr"><fmt:formatNumber value="${bikeuseList[0].moveDist+bikeuseList[1].moveDist + bikeuseList[2].moveDist == null ? 0 : (bikeuseList[0].moveDist+bikeuseList[1].moveDist+bikeuseList[2].moveDist)/period/1000}" pattern="0.00"></fmt:formatNumber></td>
									<td class="tr"><fmt:formatNumber value="${bikeuseList[0].useMi+bikeuseList[1].useMi +bikeuseList[2].useMi== null ? 0 : (bikeuseList[0].useMi+bikeuseList[1].useMi+bikeuseList[2].useMi)/period}" pattern="0.00"></fmt:formatNumber></td>
								</tr>
								<tr>
									<th>회원</th>
									<td class="tr"><fmt:formatNumber type="number" value="${incomeList[0].payAmt == null ? 0 : incomeList[0].payAmt/1000}"/></td>
									<th>남</th>
									<td class="tr">${userjoinList[0].totCnt == null ? 0 : userjoinList[0].totCnt}</td>
									<th>남</th>
									<td class="tr">${bikeuseList[2].useCnt == null ? 0 : bikeuseList[2].useCnt}</td>
									<td class="tr"><fmt:formatNumber value="${bikeuseList[2].useCnt == null ? 0 : bikeuseList[2].useCnt/period}" pattern="0.00"></fmt:formatNumber></td>
									<td class="tr"><fmt:formatNumber value="${bikeuseList[2].moveDist == null ? 0 : bikeuseList[2].moveDist/period/1000}" pattern="0.00"></fmt:formatNumber></td>
									<td class="tr"><fmt:formatNumber value="${bikeuseList[2].useMi == null ? 0 : bikeuseList[2].useMi/period}" pattern="0.00"></fmt:formatNumber></td>
								</tr>
								<tr>
									<th>비회원</th>
									<td class="tr"><fmt:formatNumber type="number" value="${incomeList[1].payAmt == null ? 0 :incomeList[1].payAmt/1000}"/></td>
									<th>여</th>
									<td class="tr">${userjoinList[1].totCnt == null ? 0 : userjoinList[1].totCnt}</td>
									<th>여</th>
									<td class="tr">${bikeuseList[1].useCnt == null ? 0 : bikeuseList[1].useCnt}</td>
									<td class="tr"><fmt:formatNumber value="${bikeuseList[1].useCnt == null ? 0 : bikeuseList[1].useCnt/period}" pattern="0.00"></fmt:formatNumber></td>
									<td class="tr"><fmt:formatNumber value="${bikeuseList[1].moveDist == null ? 0 : bikeuseList[1].moveDist/period/1000}" pattern="0.00"></fmt:formatNumber></td>
									<td class="tr"><fmt:formatNumber value="${bikeuseList[1].useMi == null ? 0 : bikeuseList[1].useMi/period}" pattern="0.00"></fmt:formatNumber></td>
								</tr>

								<tr>
									<th></th>
									<td class="tr"></td>
									<th></th>
									<td class="tr"></td>
									<th>성별없음</th>
									<td class="tr">${bikeuseList[0].useCnt == null ? 0 : bikeuseList[0].useCnt}</td>
									<td class="tr"><fmt:formatNumber value="${bikeuseList[0].useCnt == null ? 0 : bikeuseList[0].useCnt/period}" pattern="0.00"></fmt:formatNumber></td>
									<td class="tr"><fmt:formatNumber value="${bikeuseList[0].moveDist == null ? 0 : bikeuseList[0].moveDist/period/1000}" pattern="0.00"></fmt:formatNumber></td>
									<td class="tr"><fmt:formatNumber value="${bikeuseList[0].useMi == null ? 0 : bikeuseList[0].useMi/period}" pattern="0.00"></fmt:formatNumber></td>
								</tr>
							</tbody>
						</table>
						</div>
						
						<p class="head2"><em>시민의견(웹, 앱)</em></p>
						<div class="widscr mt5">
						<table class="tb_type03 tb_right">
							<colgroup>
								<col style="width:auto"/>
							</colgroup>
							<thead> 
								<tr>
									<th>날짜</th>
									<th>신규등록</th>
									<th>신규누계</th>
									<th>처리</th>
									<th>처리누계</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach var="opnList" items="${opinionList}">
								<tr>
									<td class="tc">${opnList.days}</td>
									<td class="tc">${opnList.opinionCnt == null  ? 0 : opnList.opinionCnt}</td>
									<td class="tc">${opnList.opinionMCnt == null ? 0 : opnList.opinionMCnt}</td>
									<td class="tc">${opnList.processCnt == null  ? 0 : opnList.processCnt}</td>
									<td class="tc">${opnList.processMCnt == null ? 0 : opnList.processMCnt}</td>
								</tr>
							</c:forEach>	
							</tbody>
						</table>
						</div>
						
						<p class="head2"><em>시간대 이용 현황</em></p>
						<div class="widscr mt5">
						<table class="tb_type03 tb_right" style="min-width:1500px">
							<colgroup>
								<col style="width:auto"/>
							</colgroup>
							<thead> 
								<tr>
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
								<tr>
									<td class="tc">${timeuseList[0].useCnt00 == null ? 0 : timeuseList[0].useCnt00}</td>
									<td class="tc">${timeuseList[0].useCnt01 == null ? 0 : timeuseList[0].useCnt01}</td>
									<td class="tc">${timeuseList[0].useCnt02 == null ? 0 : timeuseList[0].useCnt02}</td>
									<td class="tc">${timeuseList[0].useCnt03 == null ? 0 : timeuseList[0].useCnt03}</td>
									<td class="tc">${timeuseList[0].useCnt04 == null ? 0 : timeuseList[0].useCnt04}</td>
									<td class="tc">${timeuseList[0].useCnt05 == null ? 0 : timeuseList[0].useCnt05}</td>
									<td class="tc">${timeuseList[0].useCnt06 == null ? 0 : timeuseList[0].useCnt06}</td>
									<td class="tc">${timeuseList[0].useCnt07 == null ? 0 : timeuseList[0].useCnt07}</td>
									<td class="tc">${timeuseList[0].useCnt08 == null ? 0 : timeuseList[0].useCnt08}</td>
									<td class="tc">${timeuseList[0].useCnt09 == null ? 0 : timeuseList[0].useCnt09}</td>
									<td class="tc">${timeuseList[0].useCnt10 == null ? 0 : timeuseList[0].useCnt10}</td>
									<td class="tc">${timeuseList[0].useCnt11 == null ? 0 : timeuseList[0].useCnt11}</td>
									<td class="tc">${timeuseList[0].useCnt12 == null ? 0 : timeuseList[0].useCnt12}</td>
									<td class="tc">${timeuseList[0].useCnt13 == null ? 0 : timeuseList[0].useCnt13}</td>
									<td class="tc">${timeuseList[0].useCnt14 == null ? 0 : timeuseList[0].useCnt14}</td>
									<td class="tc">${timeuseList[0].useCnt15 == null ? 0 : timeuseList[0].useCnt15}</td>
									<td class="tc">${timeuseList[0].useCnt16 == null ? 0 : timeuseList[0].useCnt16}</td>
									<td class="tc">${timeuseList[0].useCnt17 == null ? 0 : timeuseList[0].useCnt17}</td>
									<td class="tc">${timeuseList[0].useCnt18 == null ? 0 : timeuseList[0].useCnt18}</td>
									<td class="tc">${timeuseList[0].useCnt19 == null ? 0 : timeuseList[0].useCnt19}</td>
									<td class="tc">${timeuseList[0].useCnt20 == null ? 0 : timeuseList[0].useCnt20}</td>
									<td class="tc">${timeuseList[0].useCnt21 == null ? 0 : timeuseList[0].useCnt21}</td>
									<td class="tc">${timeuseList[0].useCnt22 == null ? 0 : timeuseList[0].useCnt22}</td>
									<td class="tc">${timeuseList[0].useCnt23 == null ? 0 : timeuseList[0].useCnt23}</td>
									<td class="tc">${timeuseList[0].useCntTotal == null ? 0 : timeuseList[0].useCntTotal}</td>
								</tr>
							</tbody>
						</table>
						</div>
						
						<p class="head2"><em>상위 대여소</em></p>
						<div class="widscr mt5">
						<table class="tb_type01" style="min-width:700px">
							<colgroup>
								<col style="width:35%"/>
								<col style="width:35%"/>
								<col style="width:15%"/>
								<col style="width:15%"/>
							</colgroup>
							<thead> 
								<tr>
									<th>아파트</th>
									<th>대여소</th>
									<th>대여건수</th>
									<th>반납건수</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach var="highStationList" items="${highStationList}" varStatus="status">
								<tr>
									<td>${highStationList.stationGrpName}</td>
									<td>${highStationList.stationName}</td>
									<td class="tr">${highStationList.rentCnt}</td>
									<td class="tr">${highStationList.returnCnt}</td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
						</div>
						
						<p class="head2"><em>하위 대여소</em></p>
						<div class="widscr mt5">
						<table class="tb_type01" style="min-width:700px">
							<colgroup>
								<col style="width:35%"/>
								<col style="width:35%"/>
								<col style="width:15%"/>
								<col style="width:15%"/>
							</colgroup>
							<thead> 
								<tr>
									<th>아파트</th>
									<th>대여소</th>
									<th>대여건수</th>
									<th>반납건수</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach var="lowStationList" items="${lowStationList}" varStatus="status">
								<tr>
									<td>${lowStationList.stationGrpName}</td>
									<td>${lowStationList.stationName}</td>
									<td class="tr">${lowStationList.rentCnt}</td>
									<td class="tr">${lowStationList.returnCnt}</td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
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
   			$('.daymth1').css('display','inline-block');
			$('.daymth2').css('display','none');
   			$('#day').attr("checked", true);
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
   			
   	    	$("[name='currentPageNo']").val('1');
   	    	
   			if($("[name='searchBgnMt']").val() > $("[name='searchEndMt']").val()) {
   	            alert('<spring:message code="fail.input.daterange"/>');
   	            return false;
   	        }
   			if($('[name="dateType"]').val() == 'D'){
   				if(DateUtil.diffDays( $("[name='searchBgnDe']").val(),  $("[name='searchEndDe']").val(), '-') > 32){
   		    		alert("일별 조회기간은 한달 이내로 설정해주세요.");
   		    		return false;
   		    	}	
   			}
   			if($('[name="dateType"]').val() == 'M'){
   				if(DateUtil.diffMonths( $("[name='searchBgnMt']").val(),  $("[name='searchEndMt']").val(), '') > 3){
   		    		alert("월별 조회기간은 3개월 이내로 설정해주세요.");
   		    		return false;
   		    	}	
   			}
   			$('#searchFrm').attr({method : 'post', action : '/manage/manageStatistics.do'}).submit();
   			
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
   				if(DateUtil.diffDays( $("[name='searchBgnDe']").val(),  $("[name='searchEndDe']").val(), '-') > 32){
   		    		alert("일별 조회기간은 한달 이내로 설정해주세요.");
   		    		return false;
   		    	}	
   			}
   			if($('[name="dateType"]').val() == 'M'){
   				if(DateUtil.diffMonths( $("[name='searchBgnMt']").val(),  $("[name='searchEndMt']").val(), '') > 3){
   		    		alert("월별 조회기간은 3개월 이내로 설정해주세요.");
   		    		return false;
   		    	}	
   			}
    		
   			$('#searchFrm').attr({method : 'post', action : '/manage/manageStatisticsExcel.do'}).submit();
   		});
   	});
    </script>
</body>
</html>
