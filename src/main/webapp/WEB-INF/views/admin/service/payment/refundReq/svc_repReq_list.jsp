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
                    <form id="searchFrm" name="searchFrm">
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
							<div class="shBox">
			                    <input type="hidden" name="searchType" value="" />
				                <input type="hidden" name="viewFlg" value="" />
				                <input type="hidden" name="chkType" value="" />
				                <input type="hidden" name="paymentClsCdName" value="" />
				                <input type="hidden" name="paymentMethodCdName" value="" />
				                <input type="hidden" name="paymentStusCdName" value="" />
				                <input type="hidden" name="paymentSeq" value="" />
				                <input type="hidden" name="paymentDttm" value="" />
				                <input type="hidden" name="usrMainId" value="" />
				                <input type="hidden" name="chkPaymentStusCd" value="" />
				                <input type="hidden" name="usr_seq" value="" />
				                <input type="hidden" name="totAmt" value="" />
				                <input type="hidden" name="useYn" value="" />
				                <input type="hidden" name="couponNo" value="" />
				                <input type="hidden" name="chkPaymentMethodCd" value="" /><!-- 추가:계좌이체 결제취소 관련_2017.06.09_JHN -->
				                <input type="hidden" name="chkPaymentClsCd" value="" />
				                <input type="hidden" name="refndAmt" value="" />
				                <input type="hidden" name="mileagePaymentAmt" value="" />
				                <input type="hidden" name="acnutBank" value="" />
				                <input type="hidden" name="acnutNo" value="" />
				                <input type="hidden" name="acnutNm" value="" />
				                <input type="hidden" name="usrSeq" value="" />
				                <!-- <input type="hidden" name="refundReason" value="" /> -->
				                
				                 
			                    <fieldset>
									<legend>검색조건</legend>
									<div class="shBoxSection">
										<div class="section">
											<label for="bb22" class="laType02">일자</label>
											<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" id="bb22" name="startDttm" readonly/></span>
											<span class="dash">~</span>
											<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" name="endDttm" readonly/></span>
										</div>
										<div class="section">
											<label for="aa22" class="laType02">휴대폰번호</label>
											<span class="input-text07"><input type="text" name="usrMpnNo" class="" value="${searchCondition.usrMpnNo}"/></span>
										</div>
									<button class="btn-srh03 btncase1" id="searchBtn"><img src="/images/searchIcon.gif" alt="검색"></button>
									</div>
								</fieldset>
							</div>
						<!--검색조건 E-->
						<p class="tb_numlist">총 ${paginationInfo.getTotalRecordCount()} 건</p>
						<table class="tb_type01">
							<colgroup>
								<col style="width:6%"/>	<!-- 결제일 -->
								<col style="width:6%"/>	<!-- 개시일 -->
								<col style="width:6%"/>	<!-- 접수일 -->
								<col style="width:9%"/>	<!-- 아이디 -->
								<col style="width:9%"/>	<!-- 휴대폰 -->
								<col style="width:9%"/>	<!-- 결제구분-->
								<col style="width:9%"/>	<!-- 결제금액 -->
								<col style="width:9%"/>	<!-- 승인번호 -->
								<col style="width:7%"/>	<!-- 예금주 -->
								<col style="width:7%"/>	<!-- 은행명 -->
								<col style="width:7%"/>	<!-- 계좌번호 -->
								<col style="width:7%"/>
								<col style="width:7%"/>	<!-- 계좌번호 -->
								<col style="width:7%"/>
								<col style="display:none"/>
								<col style="display:none"/>
								<col style="display:none"/>
								<col style="display:none"/>
								<col style="display:none"/>
								<col style="display:none"/>
								<col style="display:none"/>
								<col style="display:none"/>
							</colgroup>
							<thead>
								<tr>
									<th>결제일</th>
									<th>개시일</th>
									<th>접수일</th>
									<th>아이디</th>
									<th>휴대폰</th>
									<th>이용권</th>
									<th>결제금액</th>
									<th>승인번호</th>
									<th>예금주</th>
									<th>은행</th>
									<th>계좌</th>
									<th>환불 예정액</th>
									<th>환불 요청 사유</th>
									<th>환불</th>
									<th style="display:none"></th>
									<th style="display:none"></th>
									<th style="display:none"></th>
									<th style="display:none"></th>
									<th style="display:none"></th>
									<th style="display:none"></th>
									<th style="display:none"></th>
									<th style="display:none"></th>
								</tr>
							</thead>
							<tbody>
							<c:forEach var="result" items="${refundList}" varStatus="status">
                                <tr>
                                    <td class="tc" id="paymentDttmFmt"><fmt:parseDate var="parseRegDate" value="${result.paymentDttm}" pattern="yyyy-MM-dd"/>
                                    <fmt:formatDate pattern="MM-dd" value="${parseRegDate}"/></td>
                                    <td class="tc" id="fistStrDttm">${result.fistStrDttm}</td>
                                    <td class="tc" id="refundDttm">${result.refundDttm}</td>

<!-- id -->                                
                                    <c:choose>
                            		<c:when test="${result.mbId!=null}">
                            		<%-- <c:when test="${result.usrMainId!=null}"> --%>
                                    <td id="usrMainId"><a href="#" onclick="refund.searchPayHisFnc('<c:out value="${result.usrSeq}"/>'); return false;">${result.usrMainId}</a></td>
                                    </c:when>
                                    <c:otherwise>
                                    <td id="usrMainId">
                                   	<c:choose>
                                   		<c:when test="${result.paymentClsCd == 'BIL_007' || result.paymentClsCd == 'BIL_017'}">
                                   		<a href="#" onclick="pay.searchLatestSms('<c:out value="${result.usrMainId}"/>','<c:out value="${result.paymentSeq}"/>'); return false;">${result.usrMainId}</a>
                                   		</c:when>
                                   		<c:otherwise>
                                   		${result.usrMainId}
                                   		</c:otherwise>
                                   	</c:choose>
                                    </td>
                                    </c:otherwise>
                                    </c:choose>
                                    <td>${result.usrMpnNo}</td>
                                    <td>${result.paymentClsCdName}</td>
                                    <td class="tr" id="totAmt"><fmt:formatNumber type="number" value="${result.totAmt}"/></td>
                                    
                                    <!-- 2020-12-15 승인번호 추가 -->
                                    <td class="tc" id="paymentConfmNo">${result.paymentConfmNo}</td>
                                    <td class="tc" id="acnutNm">${result.acnutNm}</td>
                                    <td class="tc" id="acnutBank">${result.acnutBank}</td>
                                    <td class="tc" id="acnutNo">
                                    	<script type="text/javascript">
											if("${usrGrpCd }" == "12" || "${usrGrpCd }" == "15" ){
												document.write("${result.acnutNo }");
											}else{
												var str = "${result.acnutNo }";
												document.write(str.substring(0, str.length-4)+"****");
											}
										
										</script>
                                    </td>
                                    
                                    
                                    <td class="tr" id="refndAmt">${result.refndAmt}</td>
                                    <td class="tc" id="refundReason">${result.refundReason}</td>
                                    <td class="tc" id="refBtn"><button class="btnType02">환불</button><br/><br/>
                                    	<button class="btnType05">취소</button>
                                    </td>
                                    
                                    
                                    <td style="display:none" id="paymentSeq">${result.paymentSeq}</td>
                                    <td style="display:none" id="chkPaymentStusCd">${result.paymentStusCd}</td>
                                    <td style="display:none" id="chkPaymentMethodCd">${result.paymentMethodCd}</td>
                                    <td style="display:none" id="chkPaymentClsCd">${result.paymentClsCd}</td>
                                    <td style="display:none" id="mileagePaymentAmt">${result.mileagePaymentAmt}</td>
                                    <td style="display:none" id="acnutBank">${result.acnutBank}</td>
                                    <td style="display:none" id="acnutNo">${result.acnutNo}</td>
                                    <td style="display:none" id="usrSeq">${result.usrSeq}</td>
                                    <td style="display:none" id="acnutNo">${result.acnutNm}</td>
                                    <td style="display:none" id="paymentDttm">${result.paymentDttm}</td>
                                </tr>
                            </c:forEach>
							
							</tbody>
						</table>
						<c:if test='${fn:length(refundList) == 0}'>
						<table class="tb_type01 mbt0">
							<tr>
								<td style="text-align:center"><spring:message code="search.nodata.msg" /></td>
							</tr>
						</table>
						</c:if>
					<c:choose>
						<c:when test="${fn:length(refundList) > 0}">
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
							<!-- <button class="btnType01" id="refundPopBtn">환불처리</button>-->
							<button class="btnType01 mhid" id="excelViewBtn">엑셀</button> 
						</div>
					</div>
				</div>
				<!--conteent E-->
			</div>
		<!--footer S-->
        <tiles:insertAttribute name="footer" />
        <!--footer E-->
	</div>
	<script type="text/javascript" src="/js/common_barocle.js"></script>
    <script type="text/javascript">
    $(function() {
        //initialize
        refund.initBtn();
        
        var calDay = new Date();
        var dayOfMonth = calDay.getDate();
        calDay.setDate(dayOfMonth - 7);
        var startDay = DateUtil.dateFmt(calDay);
        var endDay = DateUtil.dateFmt(new Date());
        
        var sDate = '${searchCondition.startDttm}' !== '' ? '${searchCondition.startDttm}' : startDay;
        var eDate = '${searchCondition.endDttm}' !== '' ? '${searchCondition.endDttm}' : endDay;
        var paymentConfmNo = '${searchCondition.paymentConfmNo}' !== '' ? '${searchCondition.paymentConfmNo}' : '';
        var searchType = '${searchCondition.searchType}' !== '' ? '${searchCondition.searchType}' : '01';
        
        $("[name='startDttm']").val(sDate);
        $("[name='endDttm']").val(eDate);
        $("[name='paymentConfmNo']").val(paymentConfmNo);
        $('input:radio[name=radioSearchType]:input[value='+ searchType +']').attr("checked", true);
        
        var totalPageCount = '${paginationInfo.totalPageCount}' == '' ? 1 : Number('${paginationInfo.totalPageCount}');
   		$('#prevPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			refund.pageSelect(currentPageNo-1);
		});
		$('#nextPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			refund.pageSelect(currentPageNo+1);
		});
		$('#movePage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			var regExp = /^[1-9]?[0-9]/;
			if(!regExp.test(currentPageNo) ||(totalPageCount < currentPageNo)){
				alert('현재 페이지 값이 정상적이지 않습니다.');
			}else{
				refund.pageSelect(currentPageNo);
			}
		});
    });
    
    $(".btnType02").click(function(){ 
    	var chkCount = 0;
    	var viewFlg = "insert";
    	var popTitle = "환불처리";
    	var tdArr = new Array();	// 배열 선언
		var checkBtn = $(this);
    	
		var tr = checkBtn.parent().parent();
		var td = tr.children();
		
		/* alert("준비중입니다.");
		return false; */
		
		$.ajax({
			url : "/couponYnChk.do",
			type : "post",
			dataType : "json",
			data : {paymentSeq:td.eq(13).text()},
			async : false,
	   		beforeSubmit: function (data,form,option) {
				return true;
			},
			success : function(data){
				if(data.resultMessage == "Success"){
					$("input:hidden[name='useYn']").val(data.useYn);
					$("input:hidden[name='couponNo']").val(data.couponNo);
				}
			},
			error : function(jqXHR, textStatus,errorThrown){
				if(jqXHR.status === 500 || jqXHR.status === 200){
					alert("에러가 발생했습니다. : " + textStatus);
				}
				//lodBarCtl.close();
			}
		});
		
    	/* $.ajax({
			url : "/couponYnChk.do",
			type : "post",
			dataType : "json",
			data : {paymentSeq:td.eq(7).text()},
			async : false,
	   		beforeSubmit: function (data,form,option) {
				return true;
			},
			success : function(data){
				if(data.resultMessage == "Success"){
					$("input:hidden[name='useYn']").val(data.useYn);
					$("input:hidden[name='couponNo']").val(data.couponNo);
				}
			},
			error : function(jqXHR, textStatus,errorThrown){
				if(jqXHR.status === 500 || jqXHR.status === 200){
					alert("에러가 발생했습니다. : " + textStatus);
				}
				//lodBarCtl.close();
			}
		}); */
    	
		$("input:hidden[name='usrMainId']").val(td.eq(3).text());
		$("input:hidden[name='paymentSeq']").val(td.eq(13).text());
		$("input:hidden[name='paymentDttm']").val(td.eq(22).text());
		$("input:hidden[name='chkPaymentStusCd']").val(td.eq(14).text());
		$("input:hidden[name='totAmt']").val(td.eq(6).text());
		$("input:hidden[name='chkPaymentMethodCd']").val(td.eq(15).text());//추가:계좌이체 결제취소 관련_2017.06.09_JHN
		$("input:hidden[name='chkPaymentClsCd']").val(td.eq(16).text());
		$("input:hidden[name='refndAmt']").val(td.eq(10).text());
		$("input:hidden[name='mileagePaymentAmt']").val(td.eq(17).text());
		$("input:hidden[name='acnutBank']").val(td.eq(18).text());
		$("input:hidden[name='acnutNo']").val(td.eq(19).text());
		$("input:hidden[name='usrSeq']").val(td.eq(20).text());
		$("input:hidden[name='acnutNm']").val(td.eq(21).text());
		//$("input:hidden[name='refundReason']").val(td.eq(11).text());
		
    	/* $("input:hidden[name='usrMainId']").val(td.eq(0).text());
		$("input:hidden[name='paymentSeq']").val(td.eq(7).text());
		$("input:hidden[name='paymentDttm']").val(td.eq(2).text());
		$("input:hidden[name='chkPaymentStusCd']").val(td.eq(8).text());
		$("input:hidden[name='totAmt']").val(td.eq(3).text());
		$("input:hidden[name='chkPaymentMethodCd']").val(td.eq(9).text());//추가:계좌이체 결제취소 관련_2017.06.09_JHN
		$("input:hidden[name='chkPaymentClsCd']").val(td.eq(10).text());
		$("input:hidden[name='refndAmt']").val(td.eq(5).text());
		$("input:hidden[name='mileagePaymentAmt']").val(td.eq(11).text());
		$("input:hidden[name='acnutBank']").val(td.eq(12).text());
		$("input:hidden[name='acnutNo']").val(td.eq(13).text());
		$("input:hidden[name='usrSeq']").val(td.eq(14).text());
		$("input:hidden[name='acnutNm']").val(td.eq(15).text()); */
		
		
		$("input:hidden[name='viewFlg']").val(viewFlg);
		var usrMainId 		= $("input:hidden[name='usrMainId']").val();
        var paymentSeq 		= $("input:hidden[name='paymentSeq']").val();
        var paymentDttm 	= $("input:hidden[name='paymentDttm']").val();
        var paymentStusCd 	= $("input:hidden[name='chkPaymentStusCd']").val();
        var totAmt 			= replaceAll($("input:hidden[name='totAmt']").val(), ",", "");
        var useYn 			= $("input:hidden[name='useYn']").val();
        var couponNo 		= $("input:hidden[name='couponNo']").val();
        var paymentMethodCd	= $("input:hidden[name='chkPaymentMethodCd']").val();//추가:계좌이체 결제취소 관련_2017.06.09_JHN
        var paymentClsCd	= $("input:hidden[name='chkPaymentClsCd']").val();
        var refndAmt = replaceAll($("input:hidden[name='refndAmt']").val(), ",", "");
        var mileagePaymentAmt = $("input:hidden[name='mileagePaymentAmt']").val();
        var acnutBank = $("input:hidden[name='acnutBank']").val();
        var acnutNo = $("input:hidden[name='acnutNo']").val();
        var usrSeq = $("input:hidden[name='usrSeq']").val();
        var acnutNm = $("input:hidden[name='acnutNm']").val();
       // var refundReason = $("input:hidden[name='refundReason']").val();
		
        if(paymentStusCd == "BIS_002" || paymentStusCd == "BIS_003"){
			alert("이미 처리된 환불/취소 내역은 환불처리할 수 없습니다.");
   			$('input[type="checkbox"][name="chk"]').prop('checked', false);
			return false;
		} else if(paymentClsCd == "BIL_009" && paymentMethodCd != "BIM_005") {
			var con = confirm("결제수단이 계좌이체를 제외한 초과요금은 환불처리 할 수 없습니다.\n[결제취소] 하시겠습니까?");
			if(con){
				pay.moveCancelPopPage(e);
			}
			return false;
		}

    	if( $('body').find("#tempWinNewPop") !== undefined && $('body').find("#tempWinNewPop").length >0 ) {
       		$('body').find("#tempWinNewPop").remove();
       	}
    	
    	var $a = null;
       	$a = $("<a>", {'href' : '/moveRefundPop.do', 'title' : popTitle, 'data-width' :"450" ,'data-height' :"640", 'data-pmt' : '&viewFlg=' + viewFlg + '&paymentSeq=' + paymentSeq + '&couponNo=' + couponNo + '&useYn=' + useYn + '&paymentDttm=' + paymentDttm + '&usrMainId=' + usrMainId + '&totAmt=' + totAmt + '&paymentMethodCd=' + paymentMethodCd + '&paymentClsCd=' + paymentClsCd + '&refndAmt=' + refndAmt + '&mileagePaymentAmt=' + mileagePaymentAmt+ '&acnutBank=' + acnutBank+ '&acnutNo=' + acnutNo+ '&usrSeq=' + usrSeq+ '&acnutNm=' + acnutNm}).addClass("winNewPop modal");
       	$a.attr("id","tempWinNewPop");
        $('body').first().append($a);
        $("#tempWinNewPop").trigger("click");
    	
    });
    
    $(".btnType05").click(function(){ 
		var checkBtn = $(this);
    	
		var tr = checkBtn.parent().parent();
		var td = tr.children();
		
		/* $("input:hidden[name='paymentSeq']").val(td.eq(13).text());
		$("input:hidden[name='usrSeq']").val(td.eq(20).text());
		
		var paymentSeq 		= $("input:hidden[name='paymentSeq']").val();
		var usrSeq = $("input:hidden[name='usrSeq']").val(); */
		
		 $.ajax({
			url : "/cancleRefundReqkAjax.do",
			type : "post",
			dataType : "json",
			data : {paymentSeq:td.eq(14).text(), usrSeq:td.eq(21).text()},
			async : false,
	   		beforeSubmit: function (data,form,option) {
				return true;
			},
			success : function(data){
				if(data.resultMessage == "Success"){
					alert("환불취소처리를 완료하였습니다.");
					location.reload();
				}
			},
			error : function(jqXHR, textStatus,errorThrown){
				if(jqXHR.status === 500 || jqXHR.status === 200){
					alert("에러가 발생했습니다. : " + textStatus);
				}
				//lodBarCtl.close();
			}
		});
		
    	//alert("환불신청 취소 준비중");
    });
    
    var refund = {};
    //refund.searchType = "${searchCondition.searchType}";
    refund.initBtn = function () {
    	var _this = refund;
        $("#searchBtn").on("click", this.searchDataFnc);
        $("#excelViewBtn").on("click", this.excelDataFnc);
        $("#refundPopBtn").on("click", this.moveRefundPopPage);
    };
    
    refund.searchDataFnc = function(e) {
    	if(DateUtil.checkDateTerm( $( "[name='startDttm']").val(),  $( "[name='endDttm']").val()) !== 'ok') {
            alert("검색 조건의 시작 날이 종료 날보다 큽니다.");
            return false;
        }
    	
    	var searchType = $(':radio[name="radioSearchType"]:checked').val();
        
    	// 검색시 사용 안하므로 주석처리
        //$("[name='paymentConfmNo']").val($("[name='paymentConfmNo']").val().replace(/ /g, ''));	// 공백제거
    	
    	$("input:hidden[name='viewFlg']").val('list');
        $("[name='currentPageNo']").val(1);
        $("input:hidden[name='searchType']").val(searchType);
        $("#searchFrm").attr({method : "post", action : "<c:out value='/getRefundReqList.do'/>"}).submit();
    };
    
    refund.excelDataFnc = function(e) {
    	var searchType = $(':radio[name="radioSearchType"]:checked').val();
    	var text = $('input:radio:checked + label').text();
        
    	$("input:hidden[name='viewFlg']").val('excel');
    	$("input:hidden[name='searchType']").val(searchType);
    	$("input:hidden[name='paymentStusCdName']").val(text);
    	$("#searchFrm").attr({method : "post", action : "<c:out value='/getRefundReqListExcel.do'/>"}).submit();
    };
    
    refund.pageSelect = function(cPage) {
    	var searchType = $(':radio[name="radioSearchType"]:checked').val();
    	
        $("input:hidden[name='viewFlg']").val('list');
        $("[name='currentPageNo']").val(cPage);
        $("input:hidden[name='searchType']").val(searchType);
        $("#searchFrm").attr({method : "post", action : "<c:out value='/getRefundReqList.do'/>"}).submit();
    };
    
    function replaceAll(str, searchStr, replaceStr) {
    	return str.split(searchStr).join(replaceStr);
    };
	
    /* refund.moveRefundPopPage = function(e) {
		e.preventDefault();
       	e.stopPropagation();
       	var chkCount = 0;
       	var viewFlg = "insert";
       	var popTitle = "환불처리";

       	$(".tb_type01 > tbody > tr").each(function(idx) {
               if($(this).find("input:checkbox").prop("checked")){
            	   
            	   $.ajax({
	   					url : "/couponYnChk.do",
	   					type : "post",
	   					dataType : "json",
	   					data : {paymentSeq:$(this).find("#paymentSeq").text()},
	   					async : false,
	   					beforeSubmit: function (data,form,option) {
	   			            return true;
	   			        },
	   					success : function(data){
	   						if(data.resultMessage == "Success"){
	   							$("input:hidden[name='useYn']").val(data.useYn);
	   			                $("input:hidden[name='couponNo']").val(data.couponNo);
	   						}
	   					},
	   					error : function(jqXHR, textStatus,errorThrown){
	   						if(jqXHR.status === 500 || jqXHR.status === 200){
	   						//	alert("에러가 발생했습니다. : " + textStatus);
	   						}
	   					    lodBarCtl.close();
	   					}
	   				});

               	   $("input:hidden[name='usrMainId']").val($(this).find("#usrMainId").text());
                   $("input:hidden[name='paymentSeq']").val($(this).find("#paymentSeq").text());
                   $("input:hidden[name='paymentDttm']").val($(this).find("#paymentDttm").text());
                   $("input:hidden[name='chkPaymentStusCd']").val($(this).find("#chkPaymentStusCd").text());
                   $("input:hidden[name='totAmt']").val($(this).find("#totAmt").text());
                   $("input:hidden[name='chkPaymentMethodCd']").val($(this).find("#chkPaymentMethodCd").text());//추가:계좌이체 결제취소 관련_2017.06.09_JHN
                   $("input:hidden[name='chkPaymentClsCd']").val($(this).find("#chkPaymentClsCd").text());
                   chkCount++
               }
           });
       	
       	$("input:hidden[name='viewFlg']").val(viewFlg);
        var usrMainId 		= $("input:hidden[name='usrMainId']").val();
        var paymentSeq 		= $("input:hidden[name='paymentSeq']").val();
        var paymentDttm 	= $("input:hidden[name='paymentDttm']").val();
        var paymentStusCd 	= $("input:hidden[name='chkPaymentStusCd']").val();
        var totAmt 			= replaceAll($("input:hidden[name='totAmt']").val(), ",", "");
        var useYn 			= $("input:hidden[name='useYn']").val();
        var couponNo 		= $("input:hidden[name='couponNo']").val();
        var paymentMethodCd	= $("input:hidden[name='chkPaymentMethodCd']").val();//추가:계좌이체 결제취소 관련_2017.06.09_JHN
        var paymentClsCd	= $("input:hidden[name='chkPaymentClsCd']").val();
        
       	if(chkCount == 0) {
       		alert("환불처리 대상을 선택한 후 환불처리 하시기 바랍니다.");
       		return false;
       	} else {
       		//if(mbId == "" || mbId == null){
       		//	alert("비회원은 환불처리할 수 없습니다.\n회원을 선택한 후 환불처리하시기 바랍니다.");
       		//	$('input[type="checkbox"][name="chk"]').prop('checked', false);
   	        //    return false;
       		//} else {
       			if(paymentStusCd == "BIS_002" || paymentStusCd == "BIS_003"){
       				alert("이미 처리된 환불/취소 내역은 환불처리할 수 없습니다.");
           			$('input[type="checkbox"][name="chk"]').prop('checked', false);
       	            return false;
       			} else if(paymentClsCd == "BIL_009" && paymentMethodCd != "BIM_005") {
       				var con = confirm("결제수단이 계좌이체를 제외한 초과요금은 환불처리 할 수 없습니다.\n[결제취소] 하시겠습니까?");
       				if(con){
       					pay.moveCancelPopPage(e);
       				}
       				return false;
       			}
       			/* if(useYn == "Y"){
       				alert("이미 사용한 이용권이라 환불처리가 불가능합니다.");
       				$('input[type="checkbox"][name="chk"]').prop('checked', false);
       	            return false;
       			} */
       		//}
       	/*}
       	
       	if( $('body').find("#tempWinNewPop") !== undefined && $('body').find("#tempWinNewPop").length >0 ) {
       		$('body').find("#tempWinNewPop").remove();
       	}
       	var $a = null;
       	$a = $("<a>", {'href' : '/moveRefundPop.do', 'title' : popTitle, 'data-width' :"450" ,'data-height' :"640", 'data-pmt' : '&viewFlg=' + viewFlg + '&paymentSeq=' + paymentSeq + '&couponNo=' + couponNo + '&useYn=' + useYn + '&paymentDttm=' + paymentDttm + '&usrMainId=' + usrMainId + '&totAmt=' + totAmt + '&paymentMethodCd=' + paymentMethodCd + '&paymentClsCd=' + paymentClsCd}).addClass("winNewPop modal");
       	$a.attr("id","tempWinNewPop");
        $('body').first().append($a);
        $("#tempWinNewPop").trigger("click");

	}; */
	
	refund.searchPayHisFnc = function(usrSeq) {
    	$("input:hidden[name='viewFlg']").val('list');
        $("[name='currentPageNo']").val(1);
        $("input:hidden[name='usr_seq']").val(usrSeq);
        $("#searchFrm").attr({method : "post", action : "<c:out value='/admin/service/member/memberPaymentList.do'/>"}).submit();
    };
    
    function changePaymentStus(pPaymentSeq, pPaymentStusCd, pPaymentStusCdName, pPaymentDttm, pUsrMainId, rDate){
		if(rDate.result > 0){
			var searchType = $(':radio[name="radioSearchType"]:checked').val();
	    	
	        $("input:hidden[name='viewFlg']").val('list');
	        $("input:hidden[name='searchType']").val(searchType);
	        $("#searchFrm").attr({method : "post", action : "<c:out value='/getRefundReqList.do'/>"}).submit();
       	}
    };
    </script>
</body>
</html>
