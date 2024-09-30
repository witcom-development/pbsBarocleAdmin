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

<!--임시파일 및 캐쉬가 로그인 관리자의 pc에 저장되는 것을 방지 -->
<META http-equiv="Expires" content="Mon, 06 Jan 1990 00:00:01 GMT">
<META http-equiv="Expires" content="-1">
<META http-equiv="Pragma" content="no-cache">
<META http-equiv="Cache-Control" content="No-Cache">  

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
                    <form id="searchFrm" name="searchFrm">
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
									<p>검색조건</p><span><button type="button"><img src="/images/srh_open.png" alt="검색조건 열기" /></button></span>
								</div>
							</div>
						</div>
						<!-- 모바일 검색조건 E-->
                        <!--검색조건 S-->
                        <div class="shBox">
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
			                <input type="hidden" name="usrClscd" value="" /> <!-- 20180914 -->
			                <input type="hidden" name="isSearchGb" value="1" /> <!-- 20180914 -->
			                <input type="hidden" name="usrSeq" value="" /> <!-- 20200118 -->
                            <fieldset>
                                <legend>검색 옵션</legend>
                                <div class="shBoxSection">
                                    <div class="section">
                                        <label for="bb22" class="laType02">결제일</label>
                                        <span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" id="bb22" name="startPaymentDttm" readonly/></span>
                                        <span class="dash">~</span>
                                        <span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" name="endPaymentDttm" readonly/></span>
                                    </div>
                                    <div class="section pright">
										<label for="usrSearchType" class="laType02">사용자</label>
										<select id="usrSearchType" name="usrSearchType">
											<option value="">선택</option>
										</select>
										<span class="input-text08"><input type="text" class="" name="usrSearchKey"></span>
									</div>
									<!-- <div class="section">
										<label for="paymentClsCd" class="laType02">결제구분</label>
										<select id="paymentClsCd" name="paymentClsCd">
											<option value="">선택</option>
										</select>
									</div>
									<div class="section pright">
										<label for="paymentMethodCd" class="laType02">결제수단</label>
										<select id="paymentMethodCd" name="paymentMethodCd">
											<option value="">선택</option>
										</select>
									</div> -->
									<div class="section">
										<label for="paymentStusCd" class="laType02">결제상태</label>
										<select id="paymentStusCd" name="paymentStusCd">
											<option value="">선택</option>
										</select>
									</div>
									<div class="section pright">
										<label class="laType02">승인번호</label>
										<span class="input-text08"><input type="text" class="" name="paymentConfmNoSeacrhKey"></span>
										<button class="btn-srh03 btncase1" id="searchBtn"><img src="/images/searchIcon.gif" alt="검색"></button>
									</div>
									
									<!-- 20180914 -->
									<!-- <div class="section">
										<label for="usrClsCd" class="laType02">회원구분</label>
										<select id="usrClsCd" name="usrClsCd">
											<option value="">선택</option>
										</select>
									</div>									
									
									<div class="section">
										<label for="isSearchGb" class="laType02">조회구분</label>
										<select id="isSearchGb" name="isSearchGb">
											<option value="1">회원</option>
											<option value="2">통계</option>
										</select>
									</div>
									 -->
									
								</div>
                            </fieldset>
                        </div>
                        
                        <%-- <p class="head mhid">결제요약(단위: 천원 )</p>
                        <div class="didBox2 mhid">
                        	수입금  : [ 일계 :  ${paymentStatCol.totAmt} ] , [  누계 :  ${paymentStatCol.totAmtMileage} ]
                        </div> --%>
                         
						<p class="head ttbtncase1">결제상세</p>
                        <p class="tb_numlist">총 ${paginationInfo.getTotalRecordCount()} 건</p>
                        <table class="tb_type01">
							<colgroup>
								<col style="width:5%"/>
								<col style="width:12%"/>
								<col style="width:10%"/>
								<col style="width:10%"/>
								<col style="width:16%"/>
								<col style="width:8%"/>
								<!--[if gt IE 8]><!--><col style="width:12%" class="mhid"/><!--<![endif]-->
								<!--[if gt IE 8]><!--><col style="width:12%" class="mhid"/><!--<![endif]-->
								<col style="display:none"/>
								<col style="display:none"/>
								<col style="display:none"/>
							</colgroup>
							<thead>
								<tr>
									<!-- <th><input type="checkbox" id="allChk"/></th> -->
									<th></th>
									<th>아이디</th>
									<th>결제구분</th>
									<th>환불/취소</th>
									<th>결제일시</th>
									<th>결제금액</th>
									<!--[if gt IE 8]><!--><th class="mhid">승인번호</th><!--<![endif]-->
									<!--[if gt IE 8]><!--><th class="mhid">결제방법</th><!--<![endif]-->
									<!--[if gt IE 8]><!--><th class="mhid">카드번호</th><!--<![endif]-->
									<th style="display:none"></th>
									<th style="display:none"></th>
									<th style="display:none"></th>
								</tr>
							</thead>
							
                            <tbody>
                            <c:forEach var="result" items="${paymentList}" varStatus="status">
                                <tr>
                                    <td><input type="checkbox" name="chk" /></td>
                            		<!--
                            		<c:choose>
                            		<c:when test="${result.mbId!=null}">
                            		<td id="usrMainId"><a href="#" onclick="pay.searchIdFnc('<c:out value="${result.mbId}"/>','MB_ID'); return false;">${result.usrMainId}</a></td>
                                    </c:when>
                                    <c:otherwise>
                                    <td id="usrMainId"><a href="#" onclick="pay.searchIdFnc('<c:out value="${result.usrMpnNo}"/>','USR_MPN_NO'); return false;">${result.usrMainId}</a></td>
                                    </c:otherwise>
                                    </c:choose>
                                    -->
                                    <c:choose>
                            		<c:when test="${result.mbId!=null}">
                            		<%-- <c:when test="${result.usrMainId!=null}"> --%>
                                    <td id="usrMainId"><a href="#" onclick="pay.searchPayHisFnc('<c:out value="${result.usrSeq}"/>'); return false;">${result.usrMainId}</a></td>
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
                                    <td>${result.paymentClsCdName}</td>
                                    <c:choose>
                                    <c:when test="${result.paymentStusCd=='BIS_002'}">
                                    <td class="tc" id="paymentStus">
                                    <a href="<c:out value='/moveRefundPop.do'/>" 
                                    class="winNewPop modal" title="환불처리" 
                                    data-width="450" data-height="588"  
                                    data-pmt="&viewFlg=view&paymentStusCd=BIS_002&paymentSeq=${result.paymentSeq}&paymentDttm=${result.paymentDttm}&usrMainId=${result.usrMainId}&usrSeq=${result.usrSeq}">${result.paymentStusCdName}</a>
                                    </td>
                                    
                                    </c:when>
                                    
                                    <c:when test="${result.paymentStusCd=='BIS_004'}">
                                    <td class="tc" id="paymentStus">
                                    <a href="<c:out value='/moveRefundPop.do'/>" 
                                    class="winNewPop modal" title="환불진행중 상태" 
                                    data-width="450" data-height="588"  
                                    data-pmt="&viewFlg=view&paymentStusCd=BIS_004&paymentSeq=${result.paymentSeq}&paymentDttm=${result.paymentDttm}&usrMainId=${result.usrMainId}&usrSeq=${result.usrSeq}">${result.paymentStusCdName}</a>
                                    </td>
                                     
                                    </c:when>
                                    
                                    <c:when test="${result.paymentStusCd=='BIS_003'}">
                                    <td class="tc" id="paymentStus">
                                    <a href="<c:out value='/moveCancelPop.do'/>"
                                    class="winNewPop modal" title="결제취소"
                                    data-width="450" data-height="447"  
                                    data-pmt="&viewFlg=view&paymentSeq=${result.paymentSeq}&paymentDttm=${result.paymentDttm}&usrMainId=${result.usrMainId}">${result.paymentStusCdName}</a>
                                    </td>
                                    </c:when>
                                    <c:otherwise>
                                    <td class="tc" id="paymentStus">${result.paymentStusCdName}</td>
                                    </c:otherwise>
                                    </c:choose>
                                    <td class="tc" id="paymentDttm">${result.paymentDttm}</td>
                                    <td class="tr" id="totAmt"><fmt:formatNumber type="number" value="${result.totAmt}"/></td>
                                    <!--[if gt IE 8]><!--><td class="mhid">${result.paymentConfmNo}</td><!--<![endif]-->
                                    <!--[if gt IE 8]><!--><td class="mhid">${result.paymentMethodCdName}</td><!--<![endif]-->
                                    <td style="display:none" id="paymentSeq">${result.paymentSeq}</td>
                                   <%--  <td style="display:none" id="useYn">${result.useYn}</td>
                                    <td style="display:none" id="couponNo">${result.couponNo}</td> --%>
                                    <%-- <td style="display:none" id="mbId">${result.mbId}</td> --%>
                                    <%-- <td style="display:none" id="mbId">${result.mbId}</td> --%>
                                    <td class="tr" id="mbCardNo">${result.mbCardNo}</td>
                                    <td style="display:none" id="chkPaymentStusCd">${result.paymentStusCd}</td>
                                    <td style="display:none" id="chkPaymentMethodCd">${result.paymentMethodCd}</td>
                                    <td style="display:none" id="chkPaymentClsCd">${result.paymentClsCd}</td>
                                    <%-- 2020-01-18 --%>
                                    <td style="display:none" id="usrSeq">${result.usrSeq}</td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                        <c:if test='${fn:length(paymentList) == 0}'>
						<table class="tb_type01 mbt0">
							<tr>
								<td style="text-align:center"><spring:message code="search.nodata.msg" /></td>
							</tr>
						</table>
						</c:if>
						<c:if test='${fn:length(paymentList) >  0}'>
						<c:choose>
							<c:when test="${fn:length(paymentList) > 0}">
								<div class="drpaging">
							</c:when>
							<c:otherwise>
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
						</c:if>
						</div>
                        </form>
                        <form id="serialNoInfoDetail" name="serialNoInfoDetail"></form>
                        <div class="btnArea tr">
							<button class="btnType01" id="cancelPopBtn">결제취소</button>
							<!-- <button class="btnType01" id="refundPopBtn">환불처리</button>
							
							<button class="btnType01" id="cancelPorcePopBtn">강제취소</button> -->
							
							<!--[if gt IE 8]><!--><!-- <button class="btnType01 mhid" id="excelViewBtn">엑셀</button> --><!--<![endif]-->
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
  		pay.commonCode();
        pay.initBtn();

        var calDay = new Date();
        var dayOfMonth = calDay.getDate();
        calDay.setDate(dayOfMonth - 1);
        //calDay.setDate(dayOfMonth);
        var startDay = DateUtil.dateFmt(calDay);
        var endDay = DateUtil.dateFmt(new Date());
        
        var sDate = '${searchCondition.startPaymentDttm}' !== '' ? '${searchCondition.startPaymentDttm}' : startDay;
        var eDate = '${searchCondition.endPaymentDttm}' !== '' ? '${searchCondition.endPaymentDttm}' : endDay;
        var usrSearchKey = '${searchCondition.usrSearchKey}' !== '' ? '${searchCondition.usrSearchKey}' : '';
        var paymentConfmNoSeacrhKey = '${searchCondition.paymentConfmNoSeacrhKey}' !== '' ? '${searchCondition.paymentConfmNoSeacrhKey}' : '';
     
        // 20180914
        var usrClsCd = '${searchCondition.usrClsCd}' !== '' ? '${searchCondition.usrClsCd}' : '';
        var isSearchGb = '${searchCondition.isSearchGb}' !== '' ? '${searchCondition.isSearchGb}' : '1';
        
        $("[name='startPaymentDttm']").val(sDate);
        $("[name='endPaymentDttm']").val(eDate);
        $("[name='usrSearchKey']").val(usrSearchKey);
        $("[name='paymentConfmNoSeacrhKey']").val(paymentConfmNoSeacrhKey);
        
        // 20180914
        $("[name='usrClsCd']").val(usrClsCd);
        $("[name='isSearchGb']").val(isSearchGb);
        
        $("#usrSearchType").trigger('change');
        
        var totalPageCount = '${paginationInfo.totalPageCount}' == '' ? 1 : Number('${paginationInfo.totalPageCount}');
   		$('#prevPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			pay.pageSelect(currentPageNo-1);
		});
		$('#nextPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			pay.pageSelect(currentPageNo+1);
		});
		$('#movePage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			var regExp = /^[1-9]?[0-9]/;
			if(!regExp.test(currentPageNo) ||(totalPageCount < currentPageNo)){
				alert('현재 페이지 값이 정상적이지 않습니다.');
			}else{
				pay.pageSelect(currentPageNo);
			}
		});
		
		
    });
    
    var pay = {};
    
    pay.paymentClsCd = "${searchCondition.paymentClsCd}";
    pay.paymentMethodCd = "${searchCondition.paymentMethodCd}";
    pay.paymentStusCd = "${searchCondition.paymentStusCd}";
    pay.usrSearchType = "${searchCondition.usrSearchType}";
    // 20180914
    pay.usrClsCd = "${searchCondition.usrClsCd}";
    pay.isSearchGb = "${searchCondition.isSearchGb}";
    pay.commonCode = function () {
    	var _this = pay;
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
      	//결제상태
        commonAjax.getCommonCode("BIS", function(data) {
        	 if(data !== null && data.codeList !== null) {
                 commCdBox.makeComboBox('CC', _this.paymentStusCd,data.codeList, "paymentStusCd");
             }
        });
        
      	//회원구분
        commonAjax.getCommonCode("USR", function(data) {
        	 if(data !== null && data.codeList !== null) {
                 commCdBox.makeComboBox('CC', _this.usrClsCd,data.codeList, "usrClsCd");
             }
        });
      	
      	//사용자
      	//customCodeList = [{comCd:"USR_MPN_NO", comCdName:"휴대폰"},{comCd:"MB_ID", comCdName:"회원ID"},{comCd:"SERIAL_NO", comCdName:"대여번호"},{comCd:"USR_CLS_CD", comCdName:"회원구분"}];
      	customCodeList = [{comCd:"USR_MPN_NO", comCdName:"휴대폰"}];
        //20170517 대여일련번호 추가_JHN  //20180914  회원구분 추가
      	commCdBox.makeComboBox('CC', _this.usrSearchType, customCodeList, "usrSearchType");
      	
        if(   $("#usrSearchType option:selected").val() == "" ){
        	$("#usrSearchType").val("USR_MPN_NO")
        }
        
    };
    
    pay.initBtn = function () {
        $("#searchBtn").on("click", this.searchDataFnc);
        $("#excelViewBtn").on("click", this.excelDataFnc);
        $("#cancelPopBtn").on("click", this.moveCancelPopPage);
        $("#refundPopBtn").on("click", this.moveRefundPopPage);
        //20200503 
        $("#cancelPorcePopBtn").on("click", this.moveCancelPorcePopPage);
        
        
      	/*
        //라디오 요소처럼 동작시킬 체크박스 그룹 셀렉터 (경고)
        $('input[type="checkbox"][name="chk"]').click(function(){
            //클릭 이벤트 발생한 요소가 선택 상태일 경우
            //체크된 요소 확인후 복수개 선택되있을 경우 체크 해제
            if ($(this).prop('checked') 
            && $('input[type="checkbox"][name="chk"]:checked').size()>1) {
                $(this).prop('checked', false);
            alert('두개 이상 선택할 수 없습니다.');
            }
        });
      	*/
      	
      	//라디오 요소처럼 동작시킬 체크박스 그룹 셀렉터
        $('input[type="checkbox"][name="chk"]').click(function(){
            //클릭 이벤트 발생한 요소가 체크 상태인 경우
            if ($(this).prop('checked')) {
                //체크박스 그룹의 요소 전체를 체크 해제후 클릭한 요소 체크 상태지정
                $('input[type="checkbox"][name="chk"]').prop('checked', false);
                $(this).prop('checked', true);
            }
        });
      	
        $("#usrSearchType").on('change', function(e){
        	var tId = e.target.id;
        	var idx = $("#"+tId+" option:selected").index();
        	
        	if(idx > 0) {
        		$("[name=usrSearchKey]").attr("readonly",false);
        	} else {
        		$("[name=usrSearchKey]").val("");
        		$("[name=usrSearchKey]").attr("readonly",true);
        	}
        });
    };
  
    pay.searchDataFnc = function(e) {
    	if(DateUtil.checkDateTerm( $("[name='startPaymentDttm']").val(),  $("[name='endPaymentDttm']").val()) !== 'ok') {
               alert("검색 조건의 시작 날이 종료 날보다 큽니다.");
               return false;
           }
 
    	if(DateUtil.diffDays( $("[name='startPaymentDttm']").val(),  $("[name='endPaymentDttm']").val(), '-') >= 187){
    		alert("조회기간은 6개월 이내로 설정해주세요.");
    		return false;
    	}  

    	
    	$("[name='usrSearchKey']").val($("[name='usrSearchKey']").val().replace(/ /g, ''));	// 공백제거
    	
//대여번호_2017.07.04_JHN
    	if($("#usrSearchType").val() == "SERIAL_NO"){
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
    	
    	//추가 : 2017.05.18_JHN
    	if($("[name='usrSearchType']").val() == "USR_MPN_NO"){
    		var usrSearchKey = $("[name='usrSearchKey']").val();
    		//usrSearchKey = autoHypenPhone(usrSearchKey);
    		$("[name='usrSearchKey']").val(usrSearchKey);
    	}
    	
    	//2020.10.22 : 비회원 검색 시  usrSearchType 휴대폰 혹은 대여번호 필수 추가
    	if($("[name='usrClsCd']").val() === "USR_003"){
    		
    		if($("[name='usrSearchType']").val() === "USR_MPN_NO" || $("[name='usrSearchType']").val() === "SERIAL_NO"){
    			
    			if($("[name='usrSearchKey']").val() === ""){
    				
    				alert("비회원을 검색할 시 휴대번호 혹은 대여번호를 꼭 입력해야 합니다.");
        			return false;
    			}
    			
    		}else{
    			
    			alert("비회원을 검색할 시 휴대번호 혹은 대여번호를 꼭 입력해야 합니다.");
    			return false;
    			
    		}
    		
    	}
    	
    	
        $("input:hidden[name='viewFlg']").val('list');
        $("[name='currentPageNo']").val(1);
        
        
        $("#searchFrm").attr({method : "post", action : "<c:out value='/getPaymentList.do'/>"}).submit();
    };
    
    pay.searchIdFnc = function(usrMainId, usrType) {
    	var today = DateUtil.dateFmt(new Date());
    	$("[name='startPaymentDttm']").val(SPB_SVC_START_DATE);
     	$("[name='endPaymentDttm']").val(today);
     	$("#usrSearchType").val(usrType);
    	$("#usrSearchType").trigger('change');
    	$("[name='usrSearchKey']").val(usrMainId);
    	$("#paymentClsCd").val("");
    	$("#paymentMethodCd").val("");
    	$("#paymentStusCd").val("");
    	$("[name='paymentConfmNoSeacrhKey']").val("");
    	
    	$("input:hidden[name='viewFlg']").val('list');
        $("[name='currentPageNo']").val(1);
        $("#searchFrm").attr({method : "post", action : "<c:out value='/getPaymentList.do'/>"}).submit();
    };
    
    pay.searchPayHisFnc = function(usrSeq) {
    	$("input:hidden[name='viewFlg']").val('list');
        $("[name='currentPageNo']").val(1);
        $("input:hidden[name='usr_seq']").val(usrSeq);
        $("#searchFrm").attr({method : "post", action : "<c:out value='/admin/service/member/memberPaymentList.do'/>"}).submit();
    };
    
    pay.searchLatestSms = function(usrMpnNo, paymentSeq) {
    	var rentSerialNumLen = usrMpnNo.split('-');
    	if(rentSerialNumLen[0].length == 8){
    		usrMpnNo = "";
    	}
    	
    	$("#serialNoInfoDetail").empty()
		.append($('<input>', {type : 'hidden',name : 'serialNoPaymentSeq'}).val(paymentSeq))
		.append($('<input>', {type : 'hidden',name : 'serialNo'}).val(rentSerialNumLen[0]))
		.append($('<input>', {type : 'hidden',name : 'serialNoHistSeq'}).val(''))
		.attr({action:'/admin/service/member/rentSerialNumDetail.do', method : 'post'}).submit();
    	
    	/* 
     
    	 */
    };
    
    pay.excelDataFnc = function(e) {
        $("input:hidden[name='viewFlg']").val('excel');
        $("input:hidden[name='paymentClsCdName']").val($("#paymentClsCd option:selected").text());
        $("input:hidden[name='paymentMethodCdName']").val($("#paymentMethodCd option:selected").text());
        $("input:hidden[name='paymentStusCdName']").val($("#paymentStusCd option:selected").text());
        $("#searchFrm").attr({method : "post", action : "<c:out value='/getPaymentList.do'/>"}).submit();
    };
    
    pay.pageSelect = function(cPage) {
        $("input:hidden[name='viewFlg']").val('list');
        $("[name='currentPageNo']").val(cPage);
        $("#searchFrm").attr({method : "post", action : "<c:out value='/getPaymentList.do'/>"}).submit();
    };
    
    pay.moveCancelPopPage = function(e) {
    	e.preventDefault();
    	e.stopPropagation();
    	var chkCount = 0;
       	var viewFlg = "insert";
       	var popTitle = "결제취소";
       	
       	$(".tb_type01 > tbody > tr").each(function(idx) {

			if($(this).find("input:checkbox").prop("checked")) {
				
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
							alert("에러가 발생했습니다. : " + textStatus);
						}
					    //lodBarCtl.close();
					}
				});

            	$("input:hidden[name='usrMainId']").val($(this).find("#usrMainId").text());
                $("input:hidden[name='paymentSeq']").val($(this).find("#paymentSeq").text());
                $("input:hidden[name='paymentDttm']").val($(this).find("#paymentDttm").text());
                $("input:hidden[name='chkPaymentStusCd']").val($(this).find("#chkPaymentStusCd").text());
                $("input:hidden[name='chkPaymentMethodCd']").val($(this).find("#chkPaymentMethodCd").text());//추가:계좌이체 결제취소 관련_2017.06.09_JHN
                $("input:hidden[name='chkPaymentClsCd']").val($(this).find("#chkPaymentClsCd").text());
                chkCount++;
        	}
		});
       	
       	$("input:hidden[name='viewFlg']").val(viewFlg);
       	
		var usrMainId 		= $("input:hidden[name='usrMainId']").val();
        var paymentSeq 		= $("input:hidden[name='paymentSeq']").val();
        var paymentDttm 	= $("input:hidden[name='paymentDttm']").val();
        var paymentStusCd 	= $("input:hidden[name='chkPaymentStusCd']").val();
        var useYn 			= $("input:hidden[name='useYn']").val();
        var couponNo 		= $("input:hidden[name='couponNo']").val();
		var paymentMethodCd	= $("input:hidden[name='chkPaymentMethodCd']").val();//추가:계좌이체 결제취소 관련_2017.06.09_JHN
		var paymentClsCd	= $("input:hidden[name='chkPaymentClsCd']").val();
       
        if(chkCount == 0) {
       		alert("결제취소 대상을 선택한 후 결제취소 하시기 바랍니다.");
       		return false;
       	} else {
       		//if(mbId == "" || mbId == null){
       		//	alert("비회원은 결제취소할 수 없습니다.\n회원을 선택한 후 결제취소하시기 바랍니다.");
       		//	$('input[type="checkbox"][name="chk"]').prop('checked', false);
   	        //    return false;
       		//} else {
       			
       			if(paymentStusCd == "BIS_002" || paymentStusCd == "BIS_003" || paymentStusCd == "BIS_004" ){
       				alert("이미 처리된 환불/취소 내역은 결제취소할 수 없습니다.");
           			$('input[type="checkbox"][name="chk"]').prop('checked', false);
       	            return false;
       			} else if (paymentMethodCd == "BIM_005"){//추가:계좌이체 결제취소 관련_2017.06.09_JHN
       				var con = confirm("계좌이체는 결제취소 할 수 없습니다.\n[환불처리] 하시겠습니까?");
       				if(con){
       					pay.moveRefundPopPage(e);
       				}
       	            return false;
       			}
       			/* if(useYn == "Y"){
       				alert("이미 사용한 이용권이라 결제취소가 불가능합니다.");
       				$('input[type="checkbox"][name="chk"]').prop('checked', false);
       	            return false;
       			} */
       		//}
       	}
        
        if( $('body').find("#tempWinNewPop") !== undefined && $('body').find("#tempWinNewPop").length >0 ) {
	       		$('body').find("#tempWinNewPop").remove();
	    }
			
			
       	var $a = null;
       	$a = $("<a>", {'href' : '/moveCancelPop.do', 'title' : popTitle, 'data-width' :"450" ,'data-height' :"540", 'data-pmt' : '&viewFlg=' + viewFlg + '&paymentSeq=' + paymentSeq + '&couponNo=' + couponNo + '&useYn=' + useYn + '&paymentDttm=' + paymentDttm + '&usrMainId=' + usrMainId}).addClass("winNewPop modal");
       	$a.attr("id","tempWinNewPop");
       	$('body').first().append($a);
           	$("#tempWinNewPop").trigger("click");
          
		
	};
	
	// 걸제 강제 취소
	pay.moveCancelPorcePopPage = function(e) {
    	e.preventDefault();
    	e.stopPropagation();
    	var chkCount = 0;
       	var viewFlg = "insert";
       	var popTitle = "결제 강제 취소";
       	
       	$(".tb_type01 > tbody > tr").each(function(idx) {

			if($(this).find("input:checkbox").prop("checked")) {
				
/*				
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
*/

$("input:hidden[name='useYn']").val("N");

            	$("input:hidden[name='usrMainId']").val($(this).find("#usrMainId").text());
                $("input:hidden[name='paymentSeq']").val($(this).find("#paymentSeq").text());
                $("input:hidden[name='paymentDttm']").val($(this).find("#paymentDttm").text());
                $("input:hidden[name='chkPaymentStusCd']").val($(this).find("#chkPaymentStusCd").text());
                $("input:hidden[name='chkPaymentMethodCd']").val($(this).find("#chkPaymentMethodCd").text());//추가:계좌이체 결제취소 관련_2017.06.09_JHN
                $("input:hidden[name='chkPaymentClsCd']").val($(this).find("#chkPaymentClsCd").text());
                chkCount++;
        	}
		});
       	
       	$("input:hidden[name='viewFlg']").val(viewFlg);
       	
		var usrMainId 		= $("input:hidden[name='usrMainId']").val();
        var paymentSeq 		= $("input:hidden[name='paymentSeq']").val();
        var paymentDttm 	= $("input:hidden[name='paymentDttm']").val();
        var paymentStusCd 	= $("input:hidden[name='chkPaymentStusCd']").val();
        var useYn 			= $("input:hidden[name='useYn']").val();
        var couponNo 		= $("input:hidden[name='couponNo']").val();
		var paymentMethodCd	= $("input:hidden[name='chkPaymentMethodCd']").val();//추가:계좌이체 결제취소 관련_2017.06.09_JHN
		var paymentClsCd	= $("input:hidden[name='chkPaymentClsCd']").val();
       
        if(chkCount == 0) {
       		alert("결제취소 대상을 선택한 후 결제취소 하시기 바랍니다.");
       		return false;
       	} else {
       			if(paymentStusCd == "BIS_002" || paymentStusCd == "BIS_003" || paymentStusCd == "BIS_004" ){
       				alert("이미 처리된 환불/취소 내역은 결제취소할 수 없습니다.");
           			$('input[type="checkbox"][name="chk"]').prop('checked', false);
       	            return false;
       			} else if (paymentMethodCd == "BIM_005"){//추가:계좌이체 결제취소 관련_2017.06.09_JHN
       				var con = confirm("계좌이체는 결제취소 할 수 없습니다.\n[환불처리] 하시겠습니까?");
       				if(con){
       					pay.moveRefundPopPage(e);
       				}
       	            return false;
       			}
       	}
        
        if( $('body').find("#tempWinNewPop") !== undefined && $('body').find("#tempWinNewPop").length >0 ) {
	       		$('body').find("#tempWinNewPop").remove();
	    }
			
			
       	var $a = null;
       	$a = $("<a>", {'href' : '/moveCancelPop.do', 'title' : popTitle, 'data-width' :"450" ,'data-height' :"540", 'data-pmt' : '&viewFlg=' + viewFlg + '&paymentSeq=' + paymentSeq + '&couponNo=' + couponNo + '&useYn=' + useYn + '&paymentDttm=' + paymentDttm + '&usrMainId=' + usrMainId}).addClass("winNewPop modal");
       	$a.attr("id","tempWinNewPop");
       	$('body').first().append($a);
           	$("#tempWinNewPop").trigger("click");
          
		
	};
	
	
	
	
  	pay.moveRefundPopPage = function(e) {
		e.preventDefault();
       	e.stopPropagation();
       	var chkCount = 0;
       	var viewFlg = "insert";
       	
       	var popTitle = "환불처리";
		
       	var tempUsr = "";
       	
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
	   							alert("에러가 발생했습니다. : " + textStatus);
	   						}
	   					    //lodBarCtl.close();
	   					}
	   				});

               	   $("input:hidden[name='usrMainId']").val($(this).find("#usrMainId").text());
                   $("input:hidden[name='paymentSeq']").val($(this).find("#paymentSeq").text());
                   $("input:hidden[name='paymentDttm']").val($(this).find("#paymentDttm").text());
                   $("input:hidden[name='chkPaymentStusCd']").val($(this).find("#chkPaymentStusCd").text());
                   $("input:hidden[name='totAmt']").val($(this).find("#totAmt").text());
                   $("input:hidden[name='chkPaymentMethodCd']").val($(this).find("#chkPaymentMethodCd").text());//추가:계좌이체 결제취소 관련_2017.06.09_JHN
                   $("input:hidden[name='chkPaymentClsCd']").val($(this).find("#chkPaymentClsCd").text());
                   // 2020-01-18
                   tempUsr = $(this).find("#usrSeq").text();
                    
                   
                   
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
       			if(paymentStusCd == "BIS_002" || paymentStusCd == "BIS_003" || paymentStusCd == "BIS_004"){
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
       	}
       	
       	if( $('body').find("#tempWinNewPop") !== undefined && $('body').find("#tempWinNewPop").length >0 ) {
       		$('body').find("#tempWinNewPop").remove();
       	}
       	var $a = null;
       	 
       	
       	$a = $("<a>", {'href' : '/moveRefundPop.do', 'title' : popTitle, 'data-width' :"450" ,'data-height' :"640", 'data-pmt' : '&viewFlg=' + viewFlg + '&paymentSeq=' + paymentSeq + '&couponNo=' + couponNo + '&useYn=' + useYn + '&paymentDttm=' + paymentDttm + '&usrMainId=' + usrMainId + '&totAmt=' + totAmt + '&paymentMethodCd=' + paymentMethodCd + '&paymentClsCd=' + paymentClsCd +'&usrSeq=' + tempUsr + '&paymentStusCd=BIS_004' }).addClass("winNewPop modal");
       	$a.attr("id","tempWinNewPop");
        $('body').first().append($a);
        $("#tempWinNewPop").trigger("click");

	};
	
    function changePaymentStus(pPaymentSeq, pPaymentStusCd, pPaymentStusCdName, pPaymentDttm, pUsrMainId, rDate){
		if(rDate.result > 0){
        	$(".tb_type01 > tbody > tr").each(function(idx) {
        		if($(this).find("#paymentSeq").text() == pPaymentSeq){
        			$(this).find("#chkPaymentStusCd").text(pPaymentStusCd);
        			$(this).find("#paymentStus").text("");
        			
        			var $a = null;
        			
        			if( pPaymentStusCd == "BIS_002"  || pPaymentStusCd == "BIS_004" ){
        				$a = $("<a>", {'href' : '/moveRefundPop.do', 'title' : "환불처리", 'data-width' :"450" ,'data-height' :"588", 'data-pmt' : '&viewFlg=view&paymentSeq=' + pPaymentSeq + '&paymentDttm=' + pPaymentDttm + '&usrMainId=' + pUsrMainId}).addClass("winNewPop modal");
        			} else {
        				$a = $("<a>", {'href' : '/moveCancelPop.do', 'title' : "결제취소", 'data-width' :"450" ,'data-height' :"447", 'data-pmt' : '&viewFlg=view&paymentSeq=' + pPaymentSeq + '&paymentDttm=' + pPaymentDttm + '&usrMainId=' + pUsrMainId}).addClass("winNewPop modal");
        			}
                	
                	$(this).find("#paymentStus").append($a);
                	$(this).find("#paymentStus a").text(pPaymentStusCdName);
        		}
        	});
        	$('input[type="checkbox"][name="chk"]').prop('checked', false);
       	}
    };
    
    function replaceAll(str, searchStr, replaceStr) {
    	return str.split(searchStr).join(replaceStr);
    };
    //추가 : 2017.05.18_JHN
    function autoHypenPhone(str){
		str = str.replace(/[^0-9]/g, '');
		var tmp = '';
		if( str.length < 4){
			return str;
		}else if(str.length < 7){
			tmp += str.substr(0, 3);
			tmp += '-';
			tmp += str.substr(3);
			return tmp;
		}else if(str.length < 11){
			tmp += str.substr(0, 3);
			tmp += '-';
			tmp += str.substr(3, 3);
			tmp += '-';
			tmp += str.substr(6);
			return tmp;
		}else{				
			tmp += str.substr(0, 3);
			tmp += '-';
			tmp += str.substr(3, 4);
			tmp += '-';
			tmp += str.substr(7);
			return tmp;
		}
		return str;
	};
	</script>
</body>
</html>
