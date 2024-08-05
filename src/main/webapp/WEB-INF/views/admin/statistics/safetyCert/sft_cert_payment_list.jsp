<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
						<p class="pageTitle">인증제 합격자 세부 내역</p>
						<span>통계 &gt;  <em>인증제 합격자 통계</em></span>
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
								<input type="hidden" name="searchBgnMt" />
								<input type="hidden" name="searchEndMt" />
								<fieldset>
									<legend>검색 옵션</legend>
									<div class="shBoxSection">
										<div class="section">
											<label for="bb22" class="laType02">검색기간</label>
											<p class="daymth1">
												<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" name="searchStartDate" readonly/></span>
												<span class="dash">~</span>
												<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" name="searchEndDate" readonly/></span>
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
										<div class="section radbox" style="display:none;">
											<label class="laType02">구분</label>
											<span>
												<span class="input-rd01"><input data-chn="daymth1" type="radio" id="day" name="dType" value="D"><label for="day"> 일</label></span>
												<span class="input-rd01"><input data-chn="daymth2" type="radio" id="month" name="dType" value="M"><label for="month"> 월</label></span>
											</span>
										</div>
										<div class="section">
											<label for="aa1" class="laType02">구분</label>
											<select class="select-category07" id="searchParameter" name="searchParameter" style="width: 105px;">
												<option value="PAYMENT">결제일자기준</option>
												<option value="DISCOUNT">할인기간기준</option>
											</select>
										</div>
										<!-- div class="section">
											<label for="stationGrpSlt" class="laType02">아파트</label>
											<select class="select-category02" name="stationGrp" id="stationGrpSlt">
                                                <option value="">선택</option>
                                            </select>
										</div> -->
										<div class="section pright">
											<button type="button" id="searchBtn" class="btn-srh03 btncase1"><img src="/images/searchIcon.gif" alt="검색" /></button>
										</div>
									</div>
								</fieldset>
							</div>
						<!--검색조건 E-->
						<p class="tb_numlist">
								결제건수 : 총 ${paginationInfo.totalRecordCount } 건
								대상인원 : ${targetMemberNum } 명<br>
								할인누적요금: (합계) ${totalFee } 원
						</p>
						
						<table class="tb_type01">
							<colgroup>
								<col style="width:20%"/>
								<col style="width:20%"/>
								<col style="width:15%"/>
								<col style="width:15%"/>
								<col style="width:40%"/>
							</colgroup>
							<thead> 
								<tr>
									<th>아이디</th>
									<th>이용권종류</th>
									<th>결제금액</th>
									<th>할인금액</th>
									<th>결제일자</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach var="result" items="${dataList}" varStatus="status">
								<tr>
									<td>${result.mb_id}</td>
									<td>${result.cls_cd }</td>
									<td class="tc"><fmt:formatNumber pattern="#,###" value="${result.tot_amt }"></fmt:formatNumber></td>
									<td class="tc"><fmt:formatNumber pattern="#,###" value="${result.disAmt }"></fmt:formatNumber></td>
									<td class="tc">
										<fmt:parseDate var="dateString" value="${result.payment_dttm }" pattern="yyyy-MM-ddHH:mm:ss" />
										<fmt:formatDate value="${dateString}" pattern="yyyy-MM-dd HH:mm" />	
									</td>
								</tr>
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
   		var _this = certStatistics;
   		//certStatistics.initCombo();
   		certStatistics.initBtn();
		
   		$('[name="searchStartDate"]').val('${searchCondition.searchStartDate}');
		$('[name="searchEndDate"]').val('${searchCondition.searchEndDate}');
		if("${searchCondition.searchParameter}" != ""){
			$("#searchParameter").val("${searchCondition.searchParameter}");
		}
		
   		//$("[name='stationGrp']").val(_this.stationGrp);
		//$("[name='stationId']").val(_this.stationId);

   		var totalPageCount = '${paginationInfo.totalPageCount}' == '' ? 1 : Number('${paginationInfo.totalPageCount}');
   		$('#prevPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			certStatistics.pageSelect(currentPageNo-1);
		});
		$('#nextPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			certStatistics.pageSelect(currentPageNo+1);
		});
		$('#movePage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			var regExp = /^[1-9]?[0-9]/;
			if(!regExp.test(currentPageNo) ||(totalPageCount < currentPageNo)){
				alert('현재 페이지 값이 정상적이지 않습니다.');
			}else{
				certStatistics.pageSelect(currentPageNo);
			}
		});
   	});
   	
   	var certStatistics = {};
   	//certStatistics.stationGrp = '{searchCondition.stationGrp}';
   	
   	
    
    certStatistics.initBtn = function(){
    	var _this = certStatistics;
    	$("#searchBtn").on("click", this.exeStatisticsFnc);
    	$("#excelBtn").on("click", this.exeStatisticsExcelFnc);
    }
    
    certStatistics.exeStatisticsFnc = function(e) {
        e.preventDefault();
        if(DateUtil.checkDateTerm( $( "[name='searchStartDate']").val(),  $( "[name='searchEndDate']").val()) != 'ok') {
            alert('<spring:message code="fail.input.daterange"/>');
            return false;
        }

		if($("[name='searchBgnMt']").val() > $("[name='searchEndMt']").val()) {
            alert('<spring:message code="fail.input.daterange"/>');
            return false;
        }
		
        $("[name='currentPageNo']").val(1);
        $("#searchFrm").attr({method : 'post', action : '../safetycert/getSafetyCertPaymentInfoList.do'}).submit();
        
        fn_loading(); 
        
    };
    
    certStatistics.exeStatisticsExcelFnc = function(e) {
        e.preventDefault();
        if(DateUtil.checkDateTerm( $( "[name='searchStartDate']").val(),  $( "[name='searchEndDate']").val()) != 'ok') {
            alert('<spring:message code="fail.input.daterange"/>');
            return false;
        }
		
        $("#searchFrm").attr({method : 'post', action : '../safetycert/getSafetyCertPaymentInfoListExcel.do'}).submit();
    };
    
   	certStatistics.pageSelect = function(pageNo) {
    	$("[name='currentPageNo']").val(pageNo);
    	$("#searchFrm").attr({action :'../safetycert/getSafetyCertPaymentInfoList.do', method : 'post'}).submit();
    };
    </script>
</body>
</html>