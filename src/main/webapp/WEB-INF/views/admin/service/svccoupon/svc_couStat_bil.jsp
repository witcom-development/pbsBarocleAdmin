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
			                   
			                                                <fieldset>
                                <legend>검색 옵션</legend>
                                <div class="shBoxSection">
                                    
									<div class="section">
										 <label for="bb22" class="laType02">기간선택</label>
                                        <span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" id="bb22" name="searchStartDate" readonly/></span>
                                        <span class="dash">~</span>
                                        <span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" name="searchEndDate" readonly/></span>
									</div>
									
									<div class="section pright">
										<label for="paymentClsCd" class="laType03">권종</label>
										<select id="paymentClsCd" name="paymentClsCd">
											<option value="">선택</option>
											
										</select>
									</div>
									<div class="section">
										<label for="usrSearchKey" class="laType02">업체</label>
										<select id="usrSearchKey" name="usrSearchKey">
											<option value="">선택</option>
											
										</select>
									</div>
									
									<div class="section pright">
										
										<button class="btn-srh03 btncase1" id="searchBtn"><img src="/images/searchIcon.gif" alt="검색"></button>
									</div>
									
								</div>
                            </fieldset>
							</div>
						<!--검색조건 E-->
						<p class="tb_numlist">&nbsp;</p>
						<table class="tb_type01">
							<colgroup>
								<col style="width:17%"/>
								<col style="width:17%"/>
								<col style="width:25%"/>
								<col style="width:14%"/>
								<col style="width:14%"/>
								<col style="width:10%"/>
							</colgroup>
							<thead>
								<!-- <tr>
									<th>업체명</th>
									<th>종류</th>
									<th>권종</th>
									<th>결제일</th>
									<th>유효기간</th>
									<th>구매건수 </th>
									<th>등록건수 </th>
									[if gt IE 8]><!<th class="mhid">사용건수</th><![endif]
								</tr> -->
								<tr>
									<th>업체명</th>
									<th>권종</th>
									<th>수량</th>
									<th>금액</th>
									<th>구매일시</th>
									<th>사용 비율</th>
								</tr>
							</thead>
							<tbody>
							<c:set var="sumCnt">0</c:set>
							<c:set var="sumAmt">0</c:set>
							<c:forEach var="result" items="${svccouponBilStat}" varStatus="status">
								<tr>
									<td class="tc">
										${result.mbName}
									</td>
									<td class="tc">
										${result.paymentClsCdName}
									</td>
									<td class="tc"><fmt:formatNumber value="${result.cnt}" pattern="#,###"></fmt:formatNumber></td>
									<td class="tc"><fmt:formatNumber value="${result.totAmt}" pattern="#,###"></fmt:formatNumber></td>
									<td class="tc">
										${result.paymentDttm}
									</td>
									<td class="tc"><fmt:formatNumber value="${result.useCnt}" pattern="#,###"></fmt:formatNumber>(${result.usePer}%)</td>
									
								</tr>
								<c:if test='${result.cnt != null && result.cnt != ""}'>
								  <c:set var="sumCnt">${sumCnt + result.cnt}</c:set>
								</c:if>
								<c:if test='${result.totAmt != null && result.totAmt != ""}'>
								  <c:set var="sumAmt">${sumAmt + result.totAmt}</c:set>
								</c:if>
								
							</c:forEach>
							<tr>
									<th class="tc" colspan="2">합계</td>
									<th class="tc"><fmt:formatNumber value="${sumCnt}" pattern="#,###"></fmt:formatNumber></td>
									<th class="tc"><fmt:formatNumber value="${sumAmt}" pattern="#,###"></fmt:formatNumber></td>
									<th class="tc" colspan="2">-</td>
									
							</tbody>
						</table>
						<c:if test='${fn:length(svccouponBilStat) == 0}'>
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
			
	        $("#searchFrm").attr({method : "post", action : "<c:out value='/coupon/bilCouponStatistics.do'/>"}).submit();
		});
		

		
		//결제수단
		
		var paymentClsCd = "${searchCondition.paymentClsCd}";
        commonAjax.getCommonCode("BIL", function(data) {
        	 if(data !== null && data.codeList !== null) {
                 commCdBox.makeComboBox('CC', paymentClsCd,data.codeList, "paymentClsCd");
             }
        });
        
        var usrSearchKey = "${searchCondition.usrSearchKey}";
          $.ajax({
    		type		: "post",
    		url			: "/coupon/getCouponMbName.do",
    		dataType	: "json",
    		data		: {"usrSearchKey" : usrSearchKey },
    		async		: false,
    		success		: function( data ) {
    			//pCb(data);
    			if(data !== null && data.codeList !== null) {
                    //commCdBox.makeComboBox('CC', paymentClsCd,data.codeList, "usrSearchKey");
                    // cType,cVal,comboData, comboParent
                    var $pDisplay = $("#usrSearchKey");
                    var comboData = data.codeList; 
                    var cVal = usrSearchKey;
						
					var cSize = comboData.length;
                    for(var i=0; i < cSize; i +=1 ) {
            			var $op = $('<option>',{ id : 'comm_'+comboData[i].usrSeq, value : comboData[i].usrSeq }).text(comboData[i].mbName);
            			if(cVal !== '' && cVal === comboData[i].usrSeq) {
            				$op.attr('selected', true);
            			}
            			if($pDisplay.children().length === 0) {
            				$pDisplay.append($op);
            			} else {
            				$pDisplay.children().last().after($op);
            			}
            		}
                }
    		},
    		error : function(jqXHR, textStatus,errorThrown){
    			if(jqXHR.status === 500 ){
    				alert("에러가 발생했습니다.");
    			}
    			//console.log(textStatus);
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
