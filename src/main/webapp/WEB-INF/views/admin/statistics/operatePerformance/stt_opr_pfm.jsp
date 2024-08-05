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
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" /> 
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />
<meta name="description=" Content="" />
<title><tiles:insertAttribute name="title"/></title>
<tiles:insertAttribute name="resource"/>
<script type="text/javascript" src="/js/common_barocle.js"></script>
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
						<p class="pageTitle">운영실적</p>
						<span>통계 &gt; <em>운영실적</em></span>
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
										</div>
										<div class="section">
											<label for="rentStationGrp" class="laType02">표출방법</label>
											<span>
												<span class="input-rd01"><input data-chn="showtb1" type="radio" id="all" name="sType" value="A"><label for="all"> 누적</label></span>
												<span class="input-rd01"><input data-chn="showtb2" type="radio" id="avg" name="sType" value="E"><label for="avg"> 평균</label></span>
											</span>
										</div>
										<div class="section pright">
											<button type="button" id="searchBtn" class="btn-srh03 btncase1"><img src="/images/searchIcon.gif" alt="검색" /></button>
										</div>
									</div>
								</fieldset>
							</div>
						<!--검색조건 E-->
						<p class="head2"><em>회원실적</em></p>
					</form>
					</div>
				</div>
				<%-- <div class="content">
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
												<span class="input-rd01"><input data-chn="daymth2" type="radio" id="monthly" name="dType" value="monthly"><label for="monthly"> 월</label></span>
											</span>
										</div>
										<div class="section pright">
											<label class="laType02">일/월</label>
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
											<label class="laType02">대여횟수</label>
											<span>
												<span class="input-rd01"><input type="radio" id="asc" name="sType"><label for="asc">오름차순</label></span>
												<span class="input-rd01"><input type="radio" id="desc" name="sType"><label for="desc">내림차순</label></span>
											</span>
										</div>
										<div class="section pright">
											<button type="button" id="searchBtn" class="btn-srh03 btncase1"><img src="/images/searchIcon.gif" alt="검색" /></button>
										</div>
									</div>
								</fieldset>
							</div>
						<!--검색조건 E-->
						<div class="posrela mt30">
							<div class="widpos">
								<p class="whead">총 합계</p>
								<table class="tb_type01 mt20">
								<colgroup>
									<col style="width:20%"/>
									<col span="4" style="width:20%" />
								</colgroup>
									<tr>
										<th rowspan="2">대여<p>구분</p></th>
										<th>정기</th>
										<th>일일<br />(회원)</th>
										<th>일일<br />(비회원)</th>
										<th>단체</th>
									</tr>
									<tr>
										<td>${rentTypeDataList[0].useCntSum}</td>
										<td>${rentTypeDataList[1].useCntSum}</td>
										<td>${rentTypeDataList[2].useCntSum}</td>
										<td>${rentTypeDataList[3].useCntSum}</td>
									</tr>
								</table>
								<table class="tb_type01 mt10">
								<colgroup>
									<col style="width:15%"/>
									<col span="3" style="width:20%" />
								</colgroup>
									<tr>
										<th rowspan="2">이용<p>합계</p></th>
										<th>이용건수</th>
										<th>이동거리<br />(Km)</th>
										<th>이용시간<br />(분)</th>
									</tr>
									<tr>
										<td>${genderDataList[0].useCntSum}</td>
										<td><fmt:formatNumber value="${genderDataList[0].moveDistSum/1000}" pattern="0.00"></fmt:formatNumber></td>
										<td>${genderDataList[0].useMinuteSum}</td>
									</tr>
								</table>
							</div>
							<div class="widpos posright">
								<p class="whead">일/월 평균</p>
								<table class="tb_type01 mt20">
								<colgroup>
									<col style="width:20%"/>
									<col span="4" style="width:20%" />
								</colgroup>
									<tr>
										<th rowspan="2">대여<p>구분</p></th>
										<th>정기</th>
										<th>일일<br />(회원)</th>
										<th>일일<br />(비회원)</th>
										<th>단체</th>
									</tr>
									<tr>
										<td><fmt:formatNumber value="${rentTypeDataList[0].useCntAvg}" pattern="0.00"></fmt:formatNumber></td>
										<td><fmt:formatNumber value="${rentTypeDataList[1].useCntAvg}" pattern="0.00"></fmt:formatNumber></td>
										<td><fmt:formatNumber value="${rentTypeDataList[2].useCntAvg}" pattern="0.00"></fmt:formatNumber></td>
										<td><fmt:formatNumber value="${rentTypeDataList[3].useCntAvg}" pattern="0.00"></fmt:formatNumber></td>
									</tr>
								</table>
								<table class="tb_type01 mt10">
								<colgroup>
									<col style="width:15%"/>
									<col span="3" style="width:20%" />
								</colgroup>
									<tr>
										<th rowspan="2">이용<p>합계</p></th>
										<th>이용건수</th>
										<th>이동거리<br />(Km)</th>
										<th>이용시간<br />(분)</th>
									</tr>
									<tr>
										<td><fmt:formatNumber value="${genderDataList[0].useCntAvg}" pattern="0.00"></fmt:formatNumber></td>
										<td><fmt:formatNumber value="${genderDataList[0].moveDistAvg/1000}" pattern="0.00"></fmt:formatNumber></td>
										<td><fmt:formatNumber value="${genderDataList[0].useMinuteAvg}" pattern="0.00"></fmt:formatNumber></td>
									</tr>
								</table>
							</div>
						</div>
						
						<p class="head2"><em>이용회원 현황</em><span>총 ${ paginationInfo.getTotalRecordCount()} 건</span></p>
						<div class="widscr mt5">
						<table class="tb_type01" style="min-width:700px">
							<colgroup>
								<col style="width:12%"/>
								<col style="width:12%"/>
								<col style="width:12%"/>
								<col style="width:10%"/>
								<col style="width:30%"/>
								<col style="width:auto"/>
							</colgroup>
							<thead> 
								<tr>
									<th>대여 아파트</th>
									<th>사용자구분</th>
									<th>ID</th>
									<th>성별</th>
									<th>휴대폰번호</th>
									<th>대여횟수</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach var="result" items="${dataList}" varStatus="status">
                                <tr>
                                    <td>${result.paymentType}</td>
                                    <td>
                                    <c:if test='${result.userType == "USR_001"}'>회원-내국인</c:if>
                                    <c:if test='${result.userType == "USR_002"}'>회원-외국인</c:if>
                                    <c:if test='${result.userType == "USR_003"}'>비회원</c:if>
                                    </td>
                                    <td>${result.userId}</td>
                                    <c:choose>
                                    	<c:when test="${result.userGender == 'M'}"><td>남</td></c:when>
                                    	<c:when test="${result.userGender == 'F'}"><td>여</td></c:when>
                                    	<c:otherwise><td>-</td></c:otherwise>
                                    </c:choose>
                                    <td>${result.userMob}</td>
                                    <td>${result.rentCnt }</td>
                                </tr>
                            </c:forEach>    
                            <c:if test="${fn:length(dataList) eq 0 }">
								<table class="tb_type01 nbt0">
									<tr><td style="text-align:center"><spring:message code="search.nodata.msg" /></td></tr>
								</table>
							</c:if>
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
				</div> --%>
				<!--content E-->
			</div>
		</div>
		<!--footer S-->
			<tiles:insertAttribute name="footer" />
		<!--footer E-->
	</div>

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
    		$('#searchFrm').attr({method : 'post', action : '/manage/manageStatistics.do'}).submit();
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
    		$('#searchFrm').attr({method : 'post', action : '/manage/manageStatisticsExcel.do'}).submit();
   		});
   	});
    </script>
<%--     <script type="text/javascript">
   	$(function() {
   		$('[name="searchBgnDe"]').val('${searchCondition.searchBgnDe}');
		$('[name="searchEndDe"]').val('${searchCondition.searchEndDe}');
		
		var dateType = '${searchCondition.dateType == null ? "D" : searchCondition.dateType}';
   		$('[name="dateType"]').val(dateType);
   		var sortType = '${searchCondition.sortType == null ? "A" : searchCondition.sortType}';
   		$('[name="sortType"]').val(sortType);
   		
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
   		
   		if($('[name="sortType"]').val() == 'D'){
   			$('#desc').attr("checked", true);
   		}

   		if($('[name="sortType"]').val() == 'A'){
   			$('#asc').attr("checked", true);
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
   		$('[name="sType"]').on("click", function(){
   			if($(this).attr("id") == 'asc'){
   				$('[name="sortType"]').val('A');
   			}else if($(this).attr("id") == 'desc'){
   				$('[name="sortType"]').val('D');
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
    		$('#searchFrm').attr({method : 'post', action : '/use/userStatistics.do'}).submit();
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
   	
    </script> --%>
</body>
</html>