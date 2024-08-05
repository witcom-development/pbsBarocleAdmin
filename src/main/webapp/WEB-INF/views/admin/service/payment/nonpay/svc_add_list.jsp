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
                    <form id="frm"></form>
                    <form id="searchFrm" name="searchFrm">
					<div class="page">
						<!-- 모바일 검색조건 S-->
						<div class="shBox_m mt20">
							<div class="downtitle">
								<div class="title">
									<p>검색조건</p><span><button type="button"><img src="/images/srh_open.png" alt="검색조건 열기" /></button></span>
								</div>
							</div>
						</div>
						<!-- 모바일 검색조건 E-->
						<!--검색조건 S-->
						
							<div class="shBox">
			                    <input type="hidden" name="viewFlg" value="" />
			                    <input type="hidden" name="searchType" value="" />
			                    <input type="hidden" name="paymentMethodCdName" value="" />
			                    <input type="hidden" name="stationGrpName" value="" />
			                    <input type="hidden" name="stationName" value="" />
			                    <input type="hidden" name="rentHistSeq" value="" />
			                    <input type="hidden" name="startPaymentDttm" value="" />
			                    <input type="hidden" name="endPaymentDttm" value="" />
								<fieldset>
									<legend>검색조건</legend>
									<div class="shBoxSection">
										<div class="section">
											<label for="bb22" class="laType02">이용일자</label>
											<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" id="bb22" name="startDttm" readonly/></span>
											<span class="dash">~</span>
											<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" name="endDttm" readonly/></span>
										</div>
										<div class="section pright">
											<label for="paymentMethodCd" class="laType02">결제수단</label>
											<select id="paymentMethodCd" name="paymentMethodCd">
												<option value="">선택</option>
											</select>
										</div>
										
										
                                         <div class="section">
                                            <label for="usrSearchType" class="laType02">사용자</label>
                                            <select id="usrSearchType" name="usrSearchType">
                                                <option value="">선택</option>
                                                <option value="ID">아이디</option>
                                                <option value="PHONE">핸드폰</option>
                                                <option value="RENTSERIALNO">대여번호</option>
                                                <option value="CARD_NO">카드번호</option>
                                                <option value="USRSEQ">사용자일련번호</option>
                                            </select>
                                            <span class="input-text08"><input type="text" class="" name="usrSearchKey"></span>
                                            <button class="btn-srh03 btncase1" id="searchBtn"><img src="/images/searchIcon.gif" alt="검색"></button>
                                        </div>
									</div>
								</fieldset>
							</div>
						<!--검색조건 E-->
						<p class="tb_numlist">총 ${paginationInfo.getTotalRecordCount()} 건</p>
						<table class="tb_type01">
							<colgroup>
								<col style="width:5%"/>
								<col style="width:10%"/>
								<col style="width:17%"/>
								<col style="width:17%"/>
								<col style="width:17%"/>
								<col style="width:8%"/>
								<!--[if gt IE 8]><!--><col style="width:8%" class="mhid"/><!--<![endif]-->
								<!--[if gt IE 8]><!--><col style="width:8%" class="mhid"/><!--<![endif]-->
								<!--[if gt IE 8]><!--><col style="width:10%" class="mhid"/><!--<![endif]-->
							</colgroup>
							<thead>
								<tr>
									<th></th>
									<th>아이디</th>
									<th>대여대여소</th>
									<th>반납대여소</th>
									<th>결제수단</th>
									<th>결제실패<br>횟수</th>
									<!--[if gt IE 8]><!--><th class="mhid">이용시간<br>(분)</th><!--<![endif]-->
									<!--[if gt IE 8]><!--><th class="mhid">초과시간<br>(분)</th><!--<![endif]-->
									<!--[if gt IE 8]><!--><th class="mhid">미납금액</th><!--<![endif]-->
								</tr>
							</thead>
							<tbody>
							<c:forEach var="result" items="${nonPaymentList}" varStatus="status">
								<tr>
									<td><input type="checkbox" name="chk" /></td>
									<td id="usrMainId">${result.usrMainId}</td>
									<c:choose>
                            		<c:when test="${result.rentHistSeq!=null}">
									<td><a href="/common/pop/rentDetailPop.do" class="winNewPop" style="color : #3366FF" title="대여상세" data-width="450" data-height="745" data-pmt="&rentHistSeq=${result.rentHistSeq}">${result.rentStationName}</a></td>
									</c:when>
                                    <c:otherwise>
                                    <td>${result.rentStationName}</td>
                                    </c:otherwise>
                                    </c:choose>
									<td>${result.returnStationName}</td>
									<td>${result.paymentMethodCdName}</td>
									<c:choose>
                            		<c:when test="${result.paymentAttCnt>0}">
									<td class="tr"><a href="#" onclick="nonPay.searchFailFnc('<c:out value="${result.rentHistSeq}"/>'); return false;">${result.paymentAttCnt}</a></td>
									</c:when>
                                    <c:otherwise>
                                    <td class="tr">${result.paymentAttCnt}</td>
                                    </c:otherwise>
                                    </c:choose>
									<!--[if gt IE 8]><!--><td class="mhid tr">${result.useMi}</td><!--<![endif]-->
									<!--[if gt IE 8]><!--><td class="mhid tr">${result.overMi}</td><!--<![endif]-->
									<!--[if gt IE 8]><!--><td class="mhid tr"><fmt:formatNumber type="number" value="${result.overFee}"/></td><!--<![endif]-->
									<td style="display:none" id="rentHistSeq">${result.rentHistSeq}</td>
									<td style="display:none" id="rentDttm">${result.rentDttm}</td>
									<td style="display:none" id="usrSeq">${result.usrSeq}</td>
									<td style="display:none" id="overFee">${result.overFee}</td>
									<td style="display:none" id="paymentMethodCd">${result.paymentMethodCd}</td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
						<c:if test='${fn:length(nonPaymentList) == 0}'>
						<table class="tb_type01 mbt0">
							<tr>
								<td style="text-align:center"><spring:message code="search.nodata.msg" /></td>
							</tr>
						</table>
						</c:if>
						<c:choose>
							<c:when test="${fn:length(nonPaymentList) > 0}">
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
							<button class="btnType01" id="nonPayPopBtn">관리자 처리</button>
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
        nonPay.commonCode();
        nonPay.initBtn();
        
        var calDay = new Date();
        var dayOfMonth = calDay.getDate();
        calDay.setDate(dayOfMonth - 30);
        var startDay = DateUtil.dateFmt(calDay);
        var endDay = DateUtil.dateFmt(new Date());
        
        var sDate = '${searchCondition.startDttm}' !== '' ? '${searchCondition.startDttm}' : endDay;
        var eDate = '${searchCondition.endDttm}' !== '' ? '${searchCondition.endDttm}' : endDay;
        
        $("[name='startDttm']").val(sDate);
        $("[name='endDttm']").val(eDate);
        
        var totalPageCount = '${paginationInfo.totalPageCount}' == '' ? 1 : Number('${paginationInfo.totalPageCount}');
   		$('#prevPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			nonPay.pageSelect(currentPageNo-1);
		});
		$('#nextPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			nonPay.pageSelect(currentPageNo+1);
		});
		$('#movePage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			var regExp = /^[1-9]?[0-9]/;
			if(!regExp.test(currentPageNo) ||(totalPageCount < currentPageNo)){
				alert('현재 페이지 값이 정상적이지 않습니다.');
			}else{
				nonPay.pageSelect(currentPageNo);
			}
		});
    });
    
    var nonPay = {};
    nonPay.paymentMethodCd = "${searchCondition.paymentMethodCd}";
    nonPay.commonCode = function () {
    	var _this = nonPay;
    	//결제수단
        commonAjax.getCommonCode("BIM", function(data) {
        	 if(data !== null && data.codeList !== null) {
                 commCdBox.makeComboBox('CC', _this.paymentMethodCd,data.codeList, "paymentMethodCd");
             }
        });
        $("#usrSearchType").val('${searchCondition.usrSearchType}');
        $("[name='usrSearchKey']").val('${searchCondition.usrSearchKey}');
    };
    
    nonPay.initBtn = function () {
    	var _this = nonPay;
        $("#searchBtn").on("click", this.searchDataFnc);
        $("#excelViewBtn").on("click", this.excelDataFnc);
        $("#nonPayPopBtn").on("click", this.moveAddPayPopPage);

    };
    
    nonPay.searchDataFnc = function(e) {
    	if(DateUtil.checkDateTerm( $( "[name='startDttm']").val(),  $( "[name='endDttm']").val()) !== 'ok') {
            alert("검색 조건의 시작 날이 종료 날보다 큽니다.");
            return false;
        }
    	if(DateUtil.diffDays( $("[name='startDttm']").val(),  $("[name='endDttm']").val(), '-') >= 187){
    		alert("조회기간은 6개월 이내로 설정해주세요.");
    		return false;
    	} 
    	if($("#usrSearchType").val() !== "" && $("[name='usrSearchKey']").val() ==="" ) {
    		alert("검색어를 입력해주세요.");
    		return false;
    	}
    	if($("#usrSearchType").val() === "" && $("[name='usrSearchKey']").val() !=="" ) {
            alert("검색 타입을 선택해주세요.");
            return false;
        }
    	
    	$("[name='usrSearchKey']").val($("[name='usrSearchKey']").val().replace(/ /g, ''));	// 공백제거
    	
//대여번호_2017.07.04_JHN
    	if($("#usrSearchType").val() == "RENTSERIALNO"){
    		var num_check=/^[0-9]*$/;
    		var rentSerialNo = $("[name='usrSearchKey']").val();
    		
        	if(num_check.test(rentSerialNo)){
        		if(!(rentSerialNo.length == 8)){
        			alert("대여번호는 8자리 숫자만 입력 가능합니다.");
        			return false;
        		} 
        	} else {
        		alert("숫자만 입력할 수 있습니다.");
        		return false;
        	}
    	}
    	
        $("input:hidden[name='viewFlg']").val('list');
        $("[name='currentPageNo']").val(1);
        $("#searchFrm")
//         .append($('<input>', {type : 'hidden',name : 'usrSearchType'}).val($("#usrSearchType").val()))//JHN 추가 테스트
        .attr({method : "post", action : "<c:out value='/getNonPaymentList.do'/>"}).submit();
    };
    nonPay.searchFailFnc = function(rentHistSeq) {
    	var today = DateUtil.dateFmt(new Date());
     
    	$("input:hidden[name='startPaymentDttm']").val($("input[name=startDttm]").val());
     	$("input:hidden[name='endPaymentDttm']").val(today);
    	$("input:hidden[name='rentHistSeq']").val(rentHistSeq);
    	
    	$("input:hidden[name='viewFlg']").val('list');
        $("[name='currentPageNo']").val(1);
        
        
        $("#searchFrm").attr({method : "post", action : "<c:out value='/getFailPaymentList.do'/>"}).submit();
    }
    nonPay.excelDataFnc = function(e) {
        $("input:hidden[name='viewFlg']").val('excel');
        $("input:hidden[name='paymentMethodCdName']").val($("#paymentMethodCd option:selected").text());
        $("#searchFrm").attr({method : "post", action : "<c:out value='/getNonPaymentList.do'/>"}).submit();
    };
    nonPay.pageSelect = function(cPage) {
        $("input:hidden[name='viewFlg']").val('list');
        $("[name='currentPageNo']").val(cPage);
        $("#searchFrm").attr({method : "post", action : "<c:out value='/getNonPaymentList.do'/>"}).submit();
    };
    nonPay.moveAddPayPopPage = function(e) {
    	e.preventDefault();
    	e.stopPropagation();
    	var chkCount = 0;
    	var viewFlg = "insert";
    	var popTitle = "미납요금 관리자 처리";
    	
    	$("#frm").empty();
    	$(".tb_type01 > tbody > tr").each(function(idx) {
    		var $input1 = null;
    		var $input2 = null;
    		var $input3 = null;
    		var $input4 = null;
    		var $input5 = null;
    		
    		if($(this).find("input:checkbox").prop("checked")) {
    			$input4 = $("<input>", {type : "hidden", name: "nonPayList["+chkCount+"].paymentMethodCd"}).val($(this).find("#paymentMethodCd").text()); 
                $("#frm").append($input4);
                $input1 = $("<input>", {type : "hidden", name: "nonPayList["+chkCount+"].rentHistSeq"}).val($(this).find("#rentHistSeq").text()); 
                $("#frm").append($input1);
                $input2 = $("<input>", {type : "hidden", name: "nonPayList["+chkCount+"].rentDttm"}).val($(this).find("#rentDttm").text()); 
                $("#frm").append($input2);
                $input3 = $("<input>", {type : "hidden", name: "nonPayList["+chkCount+"].usrSeq"}).val($(this).find("#usrSeq").text()); 
                $("#frm").append($input3);
                $input5 = $("<input>", {type : "hidden", name: "nonPayList["+chkCount+"].overFee"}).val($(this).find("#overFee").text()); 
                $("#frm").append($input5);
                
                chkCount++
            }
        });
    	pData = $("#frm").serialize();
    	
    	$("input:hidden[name='viewFlg']").val(viewFlg);
    	
    	if(chkCount == 0) {
    		alert("미납요금 대상을 선택한 후 관리자 처리하시기 바랍니다.");
    		return false;
    	}
    	
    	if( $('body').find("#tempWinNewPop") !== undefined && $('body').find("#tempWinNewPop").length >0 ) {
    		$('body').find("#tempWinNewPop").remove();
    	}
    	var $a = null;
    	$a = $("<a>", {'href' : '/moveAddPayPop.do', 'title' : popTitle, 'data-width' :"450" ,'data-height' :"442", 'data-pmt' : '&viewFlg=' + viewFlg + '&nonPayList=' + pData}).addClass("winNewPop modal");
    	$a.attr("id","tempWinNewPop");
        $('body').first().append($a);
        $("#tempWinNewPop").trigger("click");
    };
    function reloadList(){
    	//window.open("/getNonPaymentList.do", "_self", true);
    	
    	$("input:hidden[name='viewFlg']").val('list');
        $("[name='currentPageNo']").val(1);
        $("#searchFrm").attr({method : "post", action : "<c:out value='/getNonPaymentList.do'/>"}).submit();
    };
    </script>
</body>
</html>
