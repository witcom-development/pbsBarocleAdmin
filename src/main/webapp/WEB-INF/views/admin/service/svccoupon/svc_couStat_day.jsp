<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html>
<html lang="ko">
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
                <tiles:insertAttribute name="left"  />
                <!--left menu E-->
                <!--conteent S-->
				<div class="content">
					<div class="subject">
                        <!--subject path S-->
                        <tiles:insertAttribute name="subject" />
                        <!--subject path E-->
                    </div>
					<div class="page">
						<!-- 모바일 검색조건 S-->
						<div class="shBox_m mt20">
							<div class="downtitle">
								<div class="title">
									<p>검색조건</p><span><button><img src="/images/srh_open.png" alt="검색조건 열기" /></button></span>
								</div>
							</div>
						</div>
						<!-- 모바일 검색조건 E-->
						<!--검색조건 S-->
						<form id="frm"></form>
                        <form id="searchFrm" name="searchFrm">
							<div class="shBox">
			                    <input type="hidden" name="viewFlg" value="" />
			                    <input type="hidden" name="paymentSeq" value="" />
			                    <input type="hidden" name="paymentDttm" value="" />
			                    <input type="hidden" name="searchValue" value="" />
			                                                <fieldset>
                                <legend>검색 옵션</legend>
                                <div class="shBoxSection">
                                    
									<div class="section repos">
										 <label for="a3" class="laType02">구분</label>
											<span class="input-rd01"><input type="radio" id="a3" name="radioSearchType" value="01" checked="checked"><label for="a3">일</label></span>
											<span class="input-rd01"><input type="radio" id="a4" name="radioSearchType" value="02" <c:if test="${fn:indexOf(searchCondition.searchValue,'02')>-1}">checked="true"</c:if>><label for="a4">월</label></span>
									</div>
									
									<div class="section pright">
										<label for="bb22" class="laType02">기간선택</label>
                                        <span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" id="bb22" name="searchStartDate" readonly/></span>
                                        <span class="dash">~</span>
                                        <span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" name="searchEndDate" readonly/></span>
										<button class="btn-srh03 btncase1" id="searchBtn"><img src="/images/searchIcon.gif" alt="검색"></button>
									</div>
									
								</div>
                            </fieldset>
							</div>
						<!--검색조건 E-->
						<p class="tb_numlist">&nbsp;</p>
						<div class="widscr mt5">
						<table class="tb_type01 tb_right" style="min-width:800px">
							<colgroup>
								<col style="width:100px"/>
								<col style="width:auto" span="14" />
							</colgroup>
							<thead>
								
								<tr>
									<th>일시</th>
									<th>합계</th>
									<th>일일 <br/>1시간</th>
									<th>일일 <br/>2시간</th>
									<th>7일 <br/>1시간</th>
									<th>7일 <br/>2시간</th>
									<th>30일 <br/>1시간</th>
									<th>30일 <br/>2시간</th>
									<th>90일 <br/>1시간</th>
									<th>90일 <br/>2시간</th>
									<th>180일 <br/>1시간</th>
									<th>180일 <br/>2시간</th>
									<th>365일 <br/>1시간</th>
									<th>365일 <br/>2시간</th>
									<th>기타</th>
									
								</tr>
							</thead>
							<tbody>
							<c:set var="sumCnt">0</c:set>
							<c:set var="sumCnt006">0</c:set>
							<c:set var="sumCnt001">0</c:set>
							<c:set var="sumCnt002">0</c:set>
							<c:set var="sumCnt003">0</c:set>
							<c:set var="sumCnt004">0</c:set>
							<c:set var="sumCnt005">0</c:set>
							<c:set var="sumCnt016">0</c:set>
							<c:set var="sumCnt011">0</c:set>
							<c:set var="sumCnt012">0</c:set>
							<c:set var="sumCnt013">0</c:set>
							<c:set var="sumCnt014">0</c:set>
							<c:set var="sumCnt015">0</c:set>
							<c:set var="sumCntEtc">0</c:set>
							<c:forEach var="result" items="${svccouponDayStat}" varStatus="status">
								 <tr>
									<td class="tc">
										${result.paymentDttm}
									</td>
									<td class="tc"><fmt:formatNumber value="${result.cnt}" pattern="#,###"></fmt:formatNumber></td>
									<td class="tc"><fmt:formatNumber value="${result.bilCnt006}" pattern="#,###"></fmt:formatNumber></td>
									<td class="tc"><fmt:formatNumber value="${result.bilCnt001}" pattern="#,###"></fmt:formatNumber></td>
									<td class="tc"><fmt:formatNumber value="${result.bilCnt002}" pattern="#,###"></fmt:formatNumber></td>
									<td class="tc"><fmt:formatNumber value="${result.bilCnt003}" pattern="#,###"></fmt:formatNumber></td>
									<td class="tc"><fmt:formatNumber value="${result.bilCnt004}" pattern="#,###"></fmt:formatNumber></td>
									<td class="tc"><fmt:formatNumber value="${result.bilCnt005}" pattern="#,###"></fmt:formatNumber></td>
									<td class="tc"><fmt:formatNumber value="${result.bilCnt016}" pattern="#,###"></fmt:formatNumber></td>
									<td class="tc"><fmt:formatNumber value="${result.bilCnt011}" pattern="#,###"></fmt:formatNumber></td>
									<td class="tc"><fmt:formatNumber value="${result.bilCnt012}" pattern="#,###"></fmt:formatNumber></td>
									<td class="tc"><fmt:formatNumber value="${result.bilCnt013}" pattern="#,###"></fmt:formatNumber></td>
									<td class="tc"><fmt:formatNumber value="${result.bilCnt014}" pattern="#,###"></fmt:formatNumber></td>
									<td class="tc"><fmt:formatNumber value="${result.bilCnt015}" pattern="#,###"></fmt:formatNumber></td>
									<td class="tc"><fmt:formatNumber value="${result.bilEtcCnt}" pattern="#,###"></fmt:formatNumber></td> 
								</tr>
								<c:if test='${result.cnt != null && result.cnt != ""}'><c:set var="sumCnt">${sumCnt + result.cnt}</c:set></c:if>
								<c:if test='${result.bilCnt006 != null && result.bilCnt006 != ""}'><c:set var="sumCnt006">${sumCnt006 + result.bilCnt006}</c:set></c:if>
								<c:if test='${result.bilCnt001 != null && result.bilCnt001 != ""}'><c:set var="sumCnt001">${sumCnt001 + result.bilCnt001}</c:set></c:if>
								<c:if test='${result.bilCnt002 != null && result.bilCnt002 != ""}'><c:set var="sumCnt002">${sumCnt002 + result.bilCnt002}</c:set></c:if>
								<c:if test='${result.bilCnt003 != null && result.bilCnt003 != ""}'><c:set var="sumCnt003">${sumCnt003 + result.bilCnt003}</c:set></c:if>
								<c:if test='${result.bilCnt004 != null && result.bilCnt004 != ""}'><c:set var="sumCnt004">${sumCnt004 + result.bilCnt004}</c:set></c:if>
								<c:if test='${result.bilCnt005 != null && result.bilCnt005 != ""}'><c:set var="sumCnt005">${sumCnt005 + result.bilCnt005}</c:set></c:if>
								<c:if test='${result.bilCnt016 != null && result.bilCnt016 != ""}'><c:set var="sumCnt016">${sumCnt016 + result.bilCnt016}</c:set></c:if>
								<c:if test='${result.bilCnt011 != null && result.bilCnt011 != ""}'><c:set var="sumCnt011">${sumCnt011 + result.bilCnt011}</c:set></c:if>
								<c:if test='${result.bilCnt012 != null && result.bilCnt012 != ""}'><c:set var="sumCnt012">${sumCnt012 + result.bilCnt012}</c:set></c:if>
								<c:if test='${result.bilCnt013 != null && result.bilCnt013 != ""}'><c:set var="sumCnt013">${sumCnt013 + result.bilCnt013}</c:set></c:if>
								<c:if test='${result.bilCnt014 != null && result.bilCnt014 != ""}'><c:set var="sumCnt014">${sumCnt014 + result.bilCnt014}</c:set></c:if>
								<c:if test='${result.bilCnt015 != null && result.bilCnt015 != ""}'><c:set var="sumCnt015">${sumCnt015 + result.bilCnt015}</c:set></c:if>
								<c:if test='${result.bilEtcCnt != null && result.bilEtcCnt != ""}'><c:set var="sumCntEnt">${sumCntEnt + result.bilEtcCnt}</c:set></c:if>  
								
								
							</c:forEach>
							<tr>
									<th class="tc">합계</td>
									<th class="tc"><fmt:formatNumber value="${sumCnt}" pattern="#,###"></fmt:formatNumber></td>
									<th class="tc"><fmt:formatNumber value="${sumCnt006}" pattern="#,###"></fmt:formatNumber></td>
									<th class="tc"><fmt:formatNumber value="${sumCnt001}" pattern="#,###"></fmt:formatNumber></td>
									<th class="tc"><fmt:formatNumber value="${sumCnt002}" pattern="#,###"></fmt:formatNumber></td>
									<th class="tc"><fmt:formatNumber value="${sumCnt003}" pattern="#,###"></fmt:formatNumber></td>
									<th class="tc"><fmt:formatNumber value="${sumCnt004}" pattern="#,###"></fmt:formatNumber></td>
									<th class="tc"><fmt:formatNumber value="${sumCnt005}" pattern="#,###"></fmt:formatNumber></td>
									<th class="tc"><fmt:formatNumber value="${sumCnt016}" pattern="#,###"></fmt:formatNumber></td>
									<th class="tc"><fmt:formatNumber value="${sumCnt011}" pattern="#,###"></fmt:formatNumber></td>
									<th class="tc"><fmt:formatNumber value="${sumCnt012}" pattern="#,###"></fmt:formatNumber></td>
									<th class="tc"><fmt:formatNumber value="${sumCnt013}" pattern="#,###"></fmt:formatNumber></td>
									<th class="tc"><fmt:formatNumber value="${sumCnt014}" pattern="#,###"></fmt:formatNumber></td>
									<th class="tc"><fmt:formatNumber value="${sumCnt015}" pattern="#,###"></fmt:formatNumber></td>
									<th class="tc"><fmt:formatNumber value="${sumCntEnt}" pattern="#,###"></fmt:formatNumber></td>
									
							</tbody>
						</table>
						</div>
						<c:if test='${fn:length(svccouponDayStat) == 0}'>
						<table class="tb_type01 mbt0">
							<tr>
								<td style="text-align:center"><spring:message code="search.nodata.msg" /></td>
							</tr>
						</table>
						</c:if>
						
						<div class="drpaging" style="display:none;">
							
						</div>
						</form>
						<div class="btnArea tr">
							
						</div>
					</div>
				</div>
				<!--conteent E-->
			</div>
		</div>
		<!--footer S-->
        <tiles:insertAttribute name="footer" />
        <!--footer E-->
	</div>
	<script type="text/javascript" src="/js/common_barocle.js"></script>
    <script type="text/javascript">
    $(function() {
        //initialize
        

        var calDay = new Date();
        var dayOfMonth = calDay.getDate();
        calDay.setDate(dayOfMonth - 7);
        var startDay = DateUtil.dateFmt(calDay);
        var endDay = DateUtil.dateFmt(new Date());
        
       
        var sDate;
        var eDate;
        
        var coupon = {};
       
        
        var totalPageCount = '${paginationInfo.totalPageCount}' == '' ? 1 : Number('${paginationInfo.totalPageCount}');
   		$('#prevPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			coupon.pageSelect(currentPageNo-1);
		});
		$('#nextPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			coupon.pageSelect(currentPageNo+1);
		});
		$('#movePage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			var regExp = /^[1-9]?[0-9]/;
			if(!regExp.test(currentPageNo) ||(totalPageCount < currentPageNo)){
				alert('현재 페이지 값이 정상적이지 않습니다.');
			}else{
				coupon.pageSelect(currentPageNo);
			}
		});
		$('#searchBtn').on("click",function(){
			var searchType = $(':radio[name="radioSearchType"]:checked').val();
			$("[name='searchValue']").val(searchType);
	        $("#searchFrm").attr({method : "post", action : "<c:out value='/coupon/dailyCouponStatistics.do'/>"}).submit();
		});
		

		
		//결제수단
		
		var paymentClsCd = "${searchCondition.paymentClsCd}";
        commonAjax.getCommonCode("BIL", function(data) {
        	 if(data !== null && data.codeList !== null) {
                 commCdBox.makeComboBox('CC', paymentClsCd,data.codeList, "paymentClsCd");
             }
        });
        
        
        $("[name='couponDelYn']").val("${searchCondition.couponDelYn}");
        $("[name='couponUseYn']").val("${searchCondition.couponUseYn}");
        $("[name='searchStartDate']").val("${searchCondition.searchStartDate}");
        $("[name='searchEndDate']").val("${searchCondition.searchEndDate}");
		
		
    });
   
    
    
    </script>
</body>
</html>
