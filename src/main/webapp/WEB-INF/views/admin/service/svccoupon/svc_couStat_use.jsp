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
			                    <input type="hidden" name="paymentMethodCdName" value="" />
			                    <input type="hidden" name="couponUseYnName" value="" />
			                    <input type="hidden" name="couponDelYnName" value="" />
			                    <input type="hidden" name="paymentSeq" value="" />
			                    <input type="hidden" name="paymentDttm" value="" />
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
								<col style="width:25%"/>
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
									<th>권종</th>
									<th>전체 발급개수</th>
									<th>쿠폰 등록</th>
									<th>쿠폰 사용</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach var="result" items="${svccouponStat}" varStatus="status">
								<tr>
									
									<td class="tc">
										${result.paymentClsCdName}
									</td>
									<td class="tc"><fmt:formatNumber value="${result.cnt}" pattern="#,###"></fmt:formatNumber></td>
									<td class="tc"><fmt:formatNumber value="${result.regisCnt}" pattern="#,###"></fmt:formatNumber>(${result.regisPer}%)</td>
									<td class="tc"><fmt:formatNumber value="${result.useCnt}" pattern="#,###"></fmt:formatNumber>(${result.usePer}%)</td>
									
								</tr>
							</c:forEach>
							</tbody>
						</table>
						<c:if test='${fn:length(svccouponStat) == 0}'>
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
			
	        $("#searchFrm").attr({method : "post", action : "<c:out value='/coupon/useCouponStatistics.do'/>"}).submit();
		});
		$('#excelViewBtn').on("click",function(){
			$("input:hidden[name='viewFlg']").val('excel');
			$("input:hidden[name='paymentMethodCdName']").val($("#paymentMethodCd option:selected").text());
	        $("input:hidden[name='couponDelYnName']").val($("#couponDelYn option:selected").text());
	        $("input:hidden[name='couponUseYnName']").val($("#couponUseYn option:selected").text());
	        $("#searchFrm").attr({method : "post", action : "<c:out value='/getSvcCouponList.do'/>"}).submit();
		});
		$('#addPopBtn').on("click",function(){
			var popTitle 			= "쿠폰 등록 ";
	    	//alert(popTitle);
	    	$a = $("<a>", {'href' : '/addSvcCouponPop.do', 'title' : popTitle, 'data-width' :"450" ,'data-height' :"640", 'data-pmt' : '&authNoHistSeq=' + '1'  }).addClass("winNewPop modal");
		   	$a.attr("id","tempWinNewPop");
		    $('body').first().append($a);
		    $("#tempWinNewPop").trigger("click");
		});
		$('#delCouponBtn').on("click",function(){
			$("#frm").empty();
			var i =0;
			$(".tb_type01 > tbody > tr").each(function(idx) {

				if($(this).find("input:checkbox").prop("checked")) {
                          //alert($(this).find("#couponSeq").text());
                          $input1 = $("<input>", {type : "hidden", name: "svcCouponSeqList["+i+"]"}).val($(this).find("#couponSeq").text()); 
 	                     $("#frm").append($input1);
 	                     i++;
				}
				
			});
			
			if(i===0) {
            	alert("삭제할 쿠폰을 선택해 주세요.");
            	return false;
            }
            // $("#frm").append($("[name='chkType']").val(""));
            pData = $("#frm").serialize();
        
        	var anw = confirm("선택하신 쿠폰은 데이터 베이스에서 삭제 됩니다. 삭제 하시겠습니까?");
        	
        	if(anw) {
	            commonAjax.postAjax("/delSvcCouponProc.do", "json", pData
	                ,function(data){
	                      if(data) {
	                          if(data.isSuccess == "true") {	  
	                              alert("삭제가 완료 되었습니다.");
	                              location.reload();
	                          }
	                     }
	            });
	        }
        
        
		});
		
		$('#unUseCouponBtn').on("click",function(){
			$("#frm").empty();
			var i =0;
			$(".tb_type01 > tbody > tr").each(function(idx) {

				if($(this).find("input:checkbox").prop("checked")) {
                          //alert($(this).find("#couponSeq").text());
                          $input1 = $("<input>", {type : "hidden", name: "svcCouponSeqList["+i+"]"}).val($(this).find("#couponSeq").text()); 
 	                     $("#frm").append($input1);
 	                     i++;
				}
				
			});
			
			if(i===0) {
            	alert("사용불가 처리할 쿠폰을 선택해 주세요.");
            	return false;
            }
            // $("#frm").append($("[name='chkType']").val(""));
            pData = $("#frm").serialize();
        
        	var anw = confirm("선택하신 쿠폰을 사용불가 처리 하시겠습니까?");
        	
        	if(anw) {
	            commonAjax.postAjax("/unUseSvcCouponProc.do", "json", pData
	                ,function(data){
	                      if(data) {
	                          if(data.isSuccess == "true") {	  
	                              alert("처리가 완료 되었습니다.");
	                              location.reload();
	                          }
	                     }
	            });
	        }
        
        
		});
		
		$('#useCouponBtn').on("click",function(){
			$("#frm").empty();
			var i =0;
			$(".tb_type01 > tbody > tr").each(function(idx) {

				if($(this).find("input:checkbox").prop("checked")) {
                          //alert($(this).find("#couponSeq").text());
                          $input1 = $("<input>", {type : "hidden", name: "svcCouponSeqList["+i+"]"}).val($(this).find("#couponSeq").text()); 
 	                     $("#frm").append($input1);
 	                     i++;
				}
				
			});
			
			if(i===0) {
            	alert("사용가능 처리할 쿠폰을 선택해 주세요.");
            	return false;
            }
            // $("#frm").append($("[name='chkType']").val(""));
            pData = $("#frm").serialize();
        
        	var anw = confirm("선택하신 쿠폰을 사용가능 처리 하시겠습니까?");
        	
        	if(anw) {
	            commonAjax.postAjax("/useSvcCouponProc.do", "json", pData
	                ,function(data){
	                      if(data) {
	                          if(data.isSuccess == "true") {	  
	                              alert("처리가 완료 되었습니다.");
	                              location.reload();
	                          }
	                     }
	            });
	        }
        
        
		});
		
		$('#dateChangeBtn').on("click",function(){
			var popTitle 			= "쿠폰 유효기간 설정";
			$("#frm").empty();
			var i =0;
			$(".tb_type01 > tbody > tr").each(function(idx) {

				if($(this).find("input:checkbox").prop("checked")) {
                          //alert($(this).find("#couponSeq").text());
                          $input1 = $("<input>", {type : "hidden", name: "svcCouponSeqList"}).val($(this).find("#couponSeq").text()); 
 	                     $("#frm").append($input1);
 	                     i++;
				}
				
			});
			
			if(i===0) {
            	alert("유효기간 설정할 쿠폰을 선택해 주세요.");
            	return false;
            }
            // $("#frm").append($("[name='chkType']").val(""));
            pData = $("#frm").serialize();
           // alert(pData);
	    	//alert(popTitle);
	    	$a = $("<a>", {'href' : '/changeDateSvcCouponPop.do', 'title' : popTitle, 'data-width' :"450" ,'data-height' :"480", 'data-pmt' : '&' + pData  }).addClass("winNewPop modal");
		   	$a.attr("id","tempWinNewPop");
		    $('body').first().append($a);
		    $("#tempWinNewPop").trigger("click");
		});
		
		//결제수단
		var paymentMethodCd = "${searchCondition.paymentMethodCd}";
        commonAjax.getCommonCode("BIM", function(data) {
        	 if(data !== null && data.codeList !== null) {
                 commCdBox.makeComboBox('CC', paymentMethodCd,data.codeList, "paymentMethodCd");
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
