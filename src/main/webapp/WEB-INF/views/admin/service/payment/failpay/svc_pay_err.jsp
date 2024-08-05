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
                        <form id="searchFrm" name="searchFrm">
							<div class="shBox">
			                    <input type="hidden" name="viewFlg" value="" />
			                    <input type="hidden" name="rentHistSeq" value="" />
			                    <input type="hidden" name="paymentClsCdName" value="" />
			                    <input type="hidden" name="paymentMethodCdName" value="" />
			                    <fieldset>
									<legend>검색조건</legend>
									<div class="shBoxSection">
										<div class="section">
											<label for="bb22" class="laType02">결제일자</label>
											<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" id="bb22" name="startPaymentDttm" readonly/></span>
											<span class="dash">~</span>
											<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" name="endPaymentDttm" readonly/></span>
										</div>
										<div class="section pright">
											<label for="paymentClsCd" class="laType02">결제구분</label>
											<select id="paymentClsCd" name="paymentClsCd">
												<option value="">선택</option>
											</select>
										</div>
										<div class="section">
											<label for="paymentMethodCd" class="laType02">결제수단</label>
											<select id="paymentMethodCd" name="paymentMethodCd">
												<option value="">선택</option>
											</select>
											<button class="btn-srh03 btncase1" id="searchBtn"><img src="../images/searchIcon.gif" alt="검색"></button>
										</div>

									</div>
								</fieldset>
							</div>
						<!--검색조건 E-->
						<p class="tb_numlist">총 ${paginationInfo.getTotalRecordCount()} 건</p>
						<table class="tb_type01">
							<colgroup>
								<col style="width:10%"/>
								<col style="width:15%"/>
								<col style="width:20%"/>
								<col style="width:10%"/>
								<!--[if gt IE 8]><!--><col style="width:45%" class="mhid"/><!--<![endif]-->
							</colgroup>
							<thead>
								<tr>
									<th>결제구분</th>
									<th>결제수단</th>
									<th>결제일시</th>
									<th>결제금액(원)</th>
									<!--[if gt IE 8]><!--><th class="mhid">사유</th><!--<![endif]-->
								</tr>
							</thead>
							<tbody>
							<c:forEach var="result" items="${failPaymentList}" varStatus="status">
								<tr>
									<td>${result.paymentClsCdName}</td>
									<td>${result.paymentMethodCdName}</td>
									<td class="tc" >${result.paymentDttm}</td>
									<td class="tr"><fmt:formatNumber type="number" value="${result.paymentAmt}"/></td>
									<!--[if gt IE 8]><!--><td class="mhid">${result.errMsg}</td><!--<![endif]-->
								</tr>
							</c:forEach>    
                            </tbody>
						</table>
						<c:if test='${fn:length(failPaymentList) == 0}'>
						<table class="tb_type01 mbt0">
							<tr>
								<td style="text-align:center"><spring:message code="search.nodata.msg" /></td>
							</tr>
						</table>
						</c:if>
					<c:choose>
						<c:when test="${fn:length(failPaymentList) > 0}">
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
                        <div class="btnArea tr">
							<!--[if gt IE 8]><!--><!-- <button class="btnType01 mhid" id="excelViewBtn">엑셀</button> --><!--<![endif]-->
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
        failPay.commonCode();
        failPay.initBtn();
        
        var calDay = new Date();
        var dayOfMonth = calDay.getDate();
        calDay.setDate(dayOfMonth - 30);
        var startDay = DateUtil.dateFmt(calDay);
        var endDay = DateUtil.dateFmt(new Date());
        
        var sDate = '${searchCondition.startPaymentDttm}' !== '' ? '${searchCondition.startPaymentDttm}' : endDay;
        var eDate = '${searchCondition.endPaymentDttm}' !== '' ? '${searchCondition.endPaymentDttm}' : endDay;
        var rentHistSeq = "${searchCondition.rentHistSeq}";
        
        $("[name='startPaymentDttm']").val(sDate);
        $("[name='endPaymentDttm']").val(eDate);
        $("[name='rentHistSeq']").val(rentHistSeq);
        
        var totalPageCount = '${paginationInfo.totalPageCount}' == '' ? 1 : Number('${paginationInfo.totalPageCount}');
   		$('#prevPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			failPay.pageSelect(currentPageNo-1);
		});
		$('#nextPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			failPay.pageSelect(currentPageNo+1);
		});
		$('#movePage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			var regExp = /^[1-9]?[0-9]/;
			if(!regExp.test(currentPageNo) ||(totalPageCount < currentPageNo)){
				alert('현재 페이지 값이 정상적이지 않습니다.');
			}else{
				failPay.pageSelect(currentPageNo);
			}
		});
    });
    
    
    var failPay = {};
    failPay.paymentClsCd = "${searchCondition.paymentClsCd}";
    failPay.paymentMethodCd = "${searchCondition.paymentMethodCd}";
    failPay.rentHistSeq = "${searchCondition.rentHistSeq}";
    failPay.commonCode = function () {
    	var _this = failPay;
        //결제구분(이용권 구분)
        commonAjax.getCommonCode("BIL", function(data) {
        	 if(data !== null && data.codeList !== null) {
                 commCdBox.makeComboBox('CC', _this.paymentClsCd,data.codeList, "paymentClsCd");
             }
        });
        //결제수단
        commonAjax.getCommonCode("BIM", function(data) {
        	 if(data !== null && data.codeList !== null) {
                 commCdBox.makeComboBox('CC', _this.paymentMethodCd,data.codeList, "paymentMethodCd");
             }
        });
    };
    
    failPay.initBtn = function () {
    	var _this = failPay;
        $("#searchBtn").on("click", this.searchDataFnc);
        $("#excelViewBtn").on("click", this.excelDataFnc);
    };
    
    failPay.searchDataFnc = function(e) {
    	if(DateUtil.checkDateTerm( $( "[name='startPaymentDttm']").val(),  $( "[name='endPaymentDttm']").val()) !== 'ok') {
            alert("검색 조건의 시작 날이 종료 날보다 큽니다.");
            return false;
        }
    	if(DateUtil.diffDays( $("[name='startPaymentDttm']").val(),  $("[name='endPaymentDttm']").val(), '-') >= 31){
    		alert("조회기간은 31일 이내로 설정해주세요.");
    		return false;
    	} 
    	
        $("input:hidden[name='viewFlg']").val('list');
        $("[name='currentPageNo']").val(1);
        $("#searchFrm").attr({method : "post", action : "<c:out value='/getFailPaymentList.do'/>"}).submit();
    };
    failPay.excelDataFnc = function(e) {
    	$("input:hidden[name='viewFlg']").val('excel');
        $("input:hidden[name='paymentClsCdName']").val($("#paymentClsCd option:selected").text());
        $("input:hidden[name='paymentMethodCdName']").val($("#paymentMethodCd option:selected").text());
        $("#searchFrm").attr({method : "post", action : "<c:out value='/getFailPaymentList.do'/>"}).submit();
    };
    failPay.pageSelect = function(cPage) {
    	$("input:hidden[name='viewFlg']").val('list');
        $("[name='currentPageNo']").val(cPage);
        $("#searchFrm").attr({method : "post", action : "<c:out value='/getFailPaymentList.do'/>"}).submit();
    };
    </script>
</body>
</html>
