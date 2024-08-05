<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%-- <%@ page import java.util.*; %> --%>
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
<script type="text/javascript" src="/js/common_barocle.js"></script>
<script type="text/javascript">

$(function() {
	
	switch ( "${userSessionVO.usrGrpCd}" ) {
	
	case "12" :			// 관리운영그룹
	case "15" : 		// 안내센터 조장
	
	// case "19" :			// 티머니
		$("#blackListInsert").css("display", "");	// 이용권 삭제
		$("#blackListdelete").css("display", "");	// 이용권 등록
		$("#hourAdd").css("display", "");			// 1시간 연장
		$("#btnInit").css("display", "");			// 이용권 초기화
		$("#btnStop").css("display", "");			// 이용권 즉시정지
	
	break;	
		
	
	case "7" :			// 관리운영그룹
		$("#blackListInsert").css("display", "");	// 이용권 삭제
		$("#blackListdelete").css("display", "");	// 이용권 등록
		$("#hourAdd").css("display", "");			// 1시간 연장
		$("#btnStop").css("display", "");			// 이용권 즉시정지
	break;			
	}

	
	switch ( "${userSessionVO.usrId}" ) {
	
	case "witcom01" :			// 관리운영그룹
		$("#blackListInsert").css("display", "");	// 이용권 삭제
		$("#blackListdelete").css("display", "");	// 이용권 등록
		$("#hourAdd").css("display", "");			// 1시간 연장
		$("#btnInit").css("display", "");			// 이용권 초기화
		$("#btnStop").css("display", "");			// 이용권 즉시정지
	
	break; 		
	}
	
	if("${result }" != ""){
		alert("${result}")
	}
	
		
	$("#searchStartDate").val("${form.searchStartDate}");
	$("#searchEndDate").val("${form.searchEndDate}");
			
	
		$(".page .tablist li").click(function(){
			//alert($(".page .tablist li").index(this));
			
			$(".page .tablist li").each(function(){
				$(this).attr("class", "");
			})
			$(this).attr("class","on");
			
			var action = getAction($(".page .tablist li").index(this));
			
			
			$("#searchStartDate").val("");
			$("#searchEndDate").val("");
			$("#currentPageNo").val(1);
			$("#frm").attr("action", action );
			$("#frm").submit();
			
		});
		
		
		$("#mobiletableList").change(function(){
			
			var action = getAction($("#mobiletableList").val());
			$("#searchStartDate").val("");
			$("#searchEndDate").val("");
			$("#currentPageNo").val(1);
			$("#frm").attr("action", action );
			$("#frm").submit();
		})
		
		//정기권 구분
	    commonAjax.getCommonCode("BIL", function(data) {
	         if(data !== null && data.codeList !== null) {
	        	 var code = new Array();
	             for(var i =0; i <data.codeList.length ;i++) {
	                 if(data.codeList[i].addVal1 === "SEASON" || data.codeList[i].addVal1 === "MDAY") {
	                     code.push(data.codeList[i]);
	                 }
	             }
	             commCdBox.makeComboBox('CC', '${frm.paymentClsCd}', code, "comPaymentClsCd");
	         }
	     });		
});

function fn_updateVocher(){
	$("#frm").attr("action", "/admin/service/member/memberVoucherReg.do");
	$("#frm").submit();
}

function fn_insertVocher(){
	$("#frm").attr("action", "/admin/service/member/memberVoucherReg.do");
	$("#frm").submit();
}

function reloadPage(){
	location.reload(true);
}

function getAction(idx){

	var actionValue = "" ;
	switch (Number(idx) ) {
		case 0: actionValue = "/admin/service/member/memberInfo.do"; 			break;
		case 1: actionValue = "/admin/service/member/memberPaymentList.do";		break;
		case 2:	actionValue = "/admin/service/member/memberUseList.do";			break;
		case 3:	actionValue = "/admin/service/member/memberMileage.do";			break;
		case 4: actionValue = "/admin/service/member/memberPenalty.do";			break;
		case 5: actionValue = "/admin/service/member/memberRefundList.do";		break;
		case 6: actionValue = "/admin/service/member/memberUnpaidList.do";  	break;
		case 7:	actionValue = "/admin/service/member/memberVoucherList.do"; 	break;
		case 8:	actionValue = "/admin/service/member/memberGiftList.do"; 		break;
	}
	return actionValue;
}

function fn_Search(){
	linkPage(1);
}

function linkPage(no){
	
	if($("#searchStartDate").val()  &&  $("#searchEndDate").val())
	if($("#searchStartDate").val() > $("#searchEndDate").val()){
		alert('<spring:message code="fail.input.daterange" />');
		return;
	}
	if($("#paymentClsCd").val()!=""){
		$("#payment_cls_cd").val($("#comPaymentClsCd").val());
	}
	
	$("#currentPageNo").val(no);
	
	$("#frm").attr("action", "/admin/service/member/memberVoucherList.do");
	$("#frm").submit();
	
}

function fn_UpdateDate(seq){
	if(seq == ''){
		alert("이용권 정보가 없습니다.");
		return;
	}
	
	if(!$("#strDate").val() && !$("#strDate").val()){
		alert("이용권 정보가 없습니다.");
		return;
	}
	
	if(confirm("이용권 정보를 변경하시겠습니까?")){
		$.post("/admin/service/member/memberVoucherUpdate.do", "voucher_seq=" + seq +"&voucher_str_dttm="+ $("#strDate").val()+$("#strTime").val() +"&voucher_end_dttm=" + $("#endDate").val()+$("#endTime").val() , function(data) {
			
			if(data.resultMsg == '성공'){
				alert(data.resultMsg)
				fn_Search();
			}
		});	
	}
}

function fn_Unsubscribe() {
	if ($("input[name=seqChk]:checked").val() != null){
 	if(confirm('이용중인 이용권을 즉시정지 시키시겠습니까?')){
 		var seq="";
 		$("input[name=seqChk]:checked").each(function() {
 			if (seq != "" ){
 				seq += $(this).val();
 			}else if(seq == ""){
 				seq = $(this).val();
 			}
 		}); 
 		if ($("input[name=seqChk]:checked")){
			$.post("/admin/service/member/expiryVoucherAjax.do", "voucher_seq="+ seq, function(data) {
			if (data.resultMsg == "성공") {
				alert("이용권이 정지되었습니다.");
				fn_Search();
				return true;
			}else {
				alert(data.resultMsg);
			}	
		});
 	  }
 	}}
 	else{
		alert("즉시정지할 이용권을 체크해 주십시오.");
		return false;
	}
	return false;
}

function fn_Reset() {
	if ($("input[name=seqChk]:checked").val() != null){
 		if(confirm('이용권을 초기화 하시겠습니까?')){
 		var seq="";
		 $("input[name=seqChk]:checked").each(function() {
			if (seq != "" ){
				seq += $(this).val();
			}else if(seq == ""){
				seq = $(this).val();
			}
		});  
		if ($("input[name=seqChk]:checked")){
		 $.post("/admin/service/member/resetVoucherAjax.do", "voucher_seq="+ seq ,function(data) {
			 if (data.resultMsg == "성공") {
				alert("이용권이 초기화되었습니다.");
				fn_Search();
				return true;
			}else {
				alert(data.resultMsg);
			}	
			});}
 		}}else{
			alert("초기화할 이용권을 체크해 주십시오.");
			return false;
		}
	return false; 
}

$(document).ready(function(){
	$("input[name=seqChk]").click(function(){
		if ($(this).prop('checked')){
    		$('input[type="checkbox"][name="seqChk"]').prop('checked',false);
	 		$(this).prop('checked',true);
		}
	});
	var today = DateUtil.dateFmt(new Date())+" "+DateUtil.getCurrentTime();
	//alert(today);
});

</script>
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
				<!--conteent S-->
<form name="frm" id="frm" method="post">
<input type="hidden"  id="payment_cls_cd" name="payment_cls_cd" value=""/>
<input type="hidden" name="usr_seq"	id="usr_seq" value="${info.usr_seq }" />
 
		<div class="content">
					<div class="subject">
						<!--subject path S-->
							<tiles:insertAttribute name="subject" />
						<!--subject path E-->
					</div>
					<div class="page">
						<ul class="tablist mt20">
							<li><a href="#">회원정보</a></li>
							<li><a href="#">결제이력</a></li>
							<li><a href="#">이용이력</a></li>
							<li><a href="#">마일리지 이력</a></li>
							<li><a href="#">벌점이력</a></li>
							<li><a href="#">환불이력</a></li>
							<li><a href="#">미납이력</a></li>
							<li class="on"><a href="#">이용권</a></li>
							<li><a href="#">선물</a></li>
						</ul>
						<select  id="mobiletableList" class="tablist_m">
							<option value="0">회원정보</option>
							<option value="1">결제이력</option>
							<option value="2" >이용이력</option>
							<option value="3">마일리지이력</option>
							<option value="4">벌점이력</option>
							<option value="5">환불이력</option>
							<option value="6">미납이력</option>
							<option value="7" selected="selected">이용권</option>
						</select>
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
							<fieldset>
								<legend>검색조건</legend>
								<div class="shBoxSection">
									<div class="section">
										<label for="bb22" class="laType02">종료일</label>
										<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" id="searchStartDate" name="searchStartDate" readonly/></span>
										<span class="dash">~</span>
										<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" id="searchEndDate"	name="searchEndDate" readonly/></span>
									</div>
									<div class="section">
                                        <label for="aa1" class="laType02">결제구분</label>
                                        <select class="select-category03" id="comPaymentClsCd" name="comPaymentClsCd">
                                            <option value="">선택</option>
                                        </select>
                                   <!--  </div>
									<div class="section pright etccase1"> -->
										<button class="btn-srh03 btncase1 mdbtncase1" onclick="fn_Search(); return false;"><img src="/images/searchIcon.gif" alt="검색" /></button>
									</div>
								</div>
							</fieldset>
						</div>
						<!--검색조건 E-->

						<!-- <p class="head">사용중 이용권</p>
							<legend>사용중 이용권</legend>
							<table class="tb_type02 mt20">
								<colgroup>
									<col style="width:16%"/>
									<col style="width:auto"/>
								</colgroup>
								<tbody>
									<tr>
										<th class="top">${voucher.cls_cd } </br>기간설정</th>
										<td class="top usaltbtd">
										<span class="selectDate input-datepick04">
											<fmt:parseDate var="dateStr" value="${voucher.voucher_str_dttm }" pattern="yyyy-MM-ddHH:mm:ss" />
											<fmt:parseDate var="hourString" value="${voucher.voucher_str_dttm }" pattern="yyyy-MM-ddHH:mm:ss" />
											
											<input type="text" class="datepicker input-datepick04" title="선택 날짜" id="strDate" readonly value="<fmt:formatDate  pattern="yyyy-MM-dd" value="${dateStr}"/>	"/>
											<input type="text" class="input-datepick04" title="선택 날짜" id="strTime" readonly value="<fmt:formatDate value="${hourString}" pattern="HH:mm:ss" />	"/>
										</span>
										<span class="dash">~</span>
										<span class="selectDate input-datepick04 mr10">
											<fmt:parseDate var="dateStr" value="${voucher.voucher_end_dttm }" pattern="yyyy-MM-ddHH:mm:ss" />
											<fmt:parseDate var="hourString" value="${voucher.voucher_end_dttm }" pattern="yyyy-MM-ddHH:mm:ss" />
											
											<input type="text" class="datepicker input-datepick04" title="선택 날짜" id="endDate" readonly value="<fmt:formatDate  pattern="yyyy-MM-dd" value="${dateStr}"/>"/>
											<input type="text" class="input-datepick04" title="선택 날짜" id="endTime" readonly value="<fmt:formatDate value="${hourString}" pattern="HH:mm:ss" />	"/>
										</span>
										<p class="usalbtn" ><button class="btnType02"  onclick="fn_UpdateDate('${voucher.voucher_seq}'); return false;">저장</button></p>
										</td>
									</tr>
								</tbody>
							</table>
						 -->	
						<p class="head" style="margin-top: 15px">이용권 내역</p>							
						<p class="tb_numlist" style="margin-top: -10px">
							<c:if test="${paginationInfo != null }">
								총 ${paginationInfo.totalRecordCount } 건
							</c:if>
						</p>
						<table class="tb_type01">
							<colgroup>
								<col style="width:15%"/>
								<col style="width:10%"/>
								<col style="width:20%"/>
								<col style="width:20%"/>
								<!--[if gt IE 8]><!--><col style="width:20%" class="mhid"/><!--<![endif]-->
								<!--[if gt IE 8]><!--><col style="width:10%" class="mhid"/><!--<![endif]-->
								 <col style="width:5%"/>
							</colgroup>
							<thead>
								<tr>
									<th>결제구분</th>
									<th>사용여부</th>
									<th>시작일시</th>
									<th>종료일시</th>
									<!--[if gt IE 8]><!--><th class="mhid">결제일시</th><!--<![endif]-->
									<!--[if gt IE 8]><!--><th class="mhid">쿠폰번호</th><!--<![endif]-->
									<th></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach	items="${list }" var="list">
									
									<tr>
										<td class="title pl10">
											<c:if test="${list.payment_cls_cd == 'BIL_008' }">
												${list.cls_cd } ( ${list.party_use_cnt } 명 )
											</c:if>
											<c:if test="${list.payment_cls_cd != 'BIL_008' }">
												${list.cls_cd } 
											</c:if>
											
										</td>
										<td class="tc">	${list.voucher_use_yn }</td>
										<td class="tc">
											<fmt:parseDate var="dateString" value="${list.voucher_str_dttm }" pattern="yyyy-MM-ddHH:mm:ss" />
											<fmt:formatDate value="${dateString}" pattern="yyyy-MM-dd HH:mm:ss" />	
											
										</td>
										<td class="tc">
											<fmt:parseDate var="dateString" value="${list.voucher_end_dttm}" pattern="yyyy-MM-ddHH:mm:ss" />
											<fmt:formatDate value="${dateString}" pattern="yyyy-MM-dd HH:mm:ss" />	
											
										</td>
										  <!--[if gt IE 8]><!-->
										<td class="mhid tc">
											<fmt:parseDate var="dateString" value="${list.payment_dttm}" pattern="yyyy-MM-ddHH:mm:ss" />
											<fmt:formatDate value="${dateString}" pattern="yyyy-MM-dd HH:mm" />	
											
										</td><!--<![endif]-->  
										<!--[if gt IE 8]><!-->
										<td class="mhid tc">
											<c:choose>
												<c:when test="${list.payment_chnnl_cd == 'CHN_003' }">
													<a href="#" onclick="fn_CouponList('${list.coupon_no}'); return false;">${list.coupon_no}</a>
												</c:when>
												<c:otherwise>
													${list.coupon_no}
												</c:otherwise>
											</c:choose>
										</td><!--<![endif]-->
										<c:choose>
										<c:when test="${today ne list.voucher_end_dttm}">
											<td class="tc"><input type="checkbox" id="seqChk" name="seqChk" value="${list.voucher_seq}"/></td>
										</c:when>
										<c:otherwise>
											<td class="tc"></td>
										</c:otherwise>
									   </c:choose>
									   <%-- <td class="tc"> <input type="checkbox" id="seqChk" name="seqChk" value="${list.voucher_seq}" /> --%>
									    <!-- <a href="#" onclick="fn_Reset();"></a> -->
									    
									    <!-- 2021-04-12 한시간 연장 관련 -->
									    <td style="display: none;">${list.voucher_seq}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						
						<c:if test="${paginationInfo.totalRecordCount == 0}">
							<table class="tb_type01">
								<tr>
									<td class="tc">
										<spring:message code="search.nodata.msg" />
									</td>
								</tr>
							</table>
						</c:if>
					<%-- 	
						<div class="paging">
							<input type="hidden" name="usr_seq"	id="usr_seq" value="${info.usr_seq }" >
							<input type="hidden" name="voucher_seq"	id="voucher_seq" value="${info.voucher_seq }" > 
							<c:if test="${paginationInfo != null }">
								<input type="hidden" name="currentPageNo"	id="currentPageNo" value="${paginationInfo.currentPageNo }">
								<input type="hidden" name="penalty_seq"	id="penalty_seq" value="">
								<ui:pagination paginationInfo = "${paginationInfo}" type="custom" jsFunction="linkPage"	/>
							</c:if>
						</div>
						 --%>
						
						 
						<div class="btnArea">
							<span class="right">
								<c:if test="${paginationInfo.totalRecordCount != 0}">
								<button	id="btnInit" class="btnType01"  style="display: none;" onclick="fn_Reset(); return false;">이용권 초기화 </button>
								<button id="btnStop" class="btnType01"  style="display: none;" onclick="fn_Unsubscribe(); return false;">이용권 즉시정지</button>
								</c:if>
								<a href="/admin/service/member/memberVoucherExtend.do" id="blackListInsert" style="display: none;"
                                  			class="winNewPop modal" title="이용권 관리"	data-width="450" data-height="510"  
                                  			data-pmt="&usr_seq=${info.usr_seq}&voucher_seq=${info.voucher_seq}"><button class="btnType01" type="button">이용권 관리</button></a>
			                    <a href="/admin/service/member/memberVoucherReg.do" id="blackListdelete" style="display: none;"
                                  			class="winNewPop modal" title="이용권 등록"	data-width="450" data-height="410"  
                                  			data-pmt="&usr_seq=${info.usr_seq}"><button class="btnType01 bc_green" type="button">이용권 등록</button></a>
                                  			
								<button id="hourAdd"  style="display: none;" class="btnType01 bc_green" type="button">한시간 연장</button>                                 			
                                  			
			                </span>
		                    <!-- 추가  -->
		                </div>
					</div>
				</div>
		
				</form>
				<form name="searchFrm" id="searchFrm">
				<input type="hidden"  id="currentPageNo" name="currentPageNo" value="1"/>
				<input type="hidden"  id="viewFlg" name="viewFlg" value="list"/>
				<input type="hidden"  id="couponNo" name="couponNo" value=""/>
				</form>
				<!--content E-->
			</div>
		</div>
		<!--footer S-->
			<tiles:insertAttribute name="footer" />
		<!--footer E-->
	</div>
</body>

 
<script type="text/javascript">

	$("#hourAdd").on("click", function(e){
		var isCheckcnt = 0;
		
		
		var tdArr = new Array();
		var checkbox = $("input[name=seqChk]:checked");
		
		var voucher_str_dttm ="";
		var voucher_end_dttm ="";
		var voucherSeq       ="";
		
		// 체크된 체크박스 값을 가져온다
		checkbox.each(function(i) {

			// checkbox.parent() : checkbox의 부모는 <td>이다.
			// checkbox.parent().parent() : <td>의 부모이므로 <tr>이다.
			var tr = checkbox.parent().parent().eq(i);
			var td = tr.children();
			
			// td.eq(0)은 체크박스 이므로  td.eq(1)의 값부터 가져온다.
			gubun = td.eq(0).text().trim();
			
			voucher_str_dttm = td.eq(2).text().trim();
			voucher_end_dttm = td.eq(3).text().trim();
			voucherSeq = td.eq(7).text().trim();
			
			isCheckcnt++;
		});
	 
		var tDate = new Date( voucher_end_dttm )
		
		var agent = navigator.userAgent.toLowerCase();

		if ( navigator!= null && agent != null && ((navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1) )) {
			tDate = new Date( voucher_end_dttm.replace("-", "/") );
		}
		
		// 시간 더하기
		tDate.setHours(tDate.getHours()+1);
		
		if ( voucherSeq =="" || voucherSeq =="0" || voucherSeq == "undefined") {
			alert("이용권이 정확하지 않습니다.");
			return;
		}
		
		if ( isCheckcnt == 0 || isCheckcnt > 1 ){
			alert("변경할 대상을 선택해 주시기 바랍니다.(한건만 선택가능)");
			return;
		}
		
		if( confirm( get_date_str( tDate) + "으로 연장하시겠습니까? ") ) {
			
			commonAjax.postAjax("/admin/service/member/extendVoucherAjax.do", "json", 
					{voucher_str_dttm:voucher_str_dttm, voucher_end_dttm:get_date_str(tDate), voucher_extend_reason:"비회원1시간연장", voucher_seq:voucherSeq} , 
	   				function(data) {
		   				if(data) {
							if(data.isUpdate == 1) {
								alert("이용권이 연장되었습니다." + get_date_str( tDate) );
								fn_Search();
								
							} else {
								alert("이용권 연장에 실패하였습니다.");
							}
						}	
			});
			
		} else {
			alert("취소되었습니다.");
		};
		
		 
		
	});
	
	function get_date_str(date)
	{
	    var sYear = date.getFullYear();
	    var sMonth = date.getMonth() + 1;
	    var sDate = date.getDate();
		var sHour = date.getHours();
		var sMinuetes = date.getMinutes();
	    sMonth = sMonth > 9 ? sMonth : "0" + sMonth;
	    sDate  = sDate > 9 ? sDate : "0" + sDate;
	    sHour  = sHour > 9 ? sHour : "0" + sHour;
	    sMinuetes  = sMinuetes > 9 ? sMinuetes : "0" + sMinuetes;
	    
	    console.log( date );
	    
	    return sYear + "-"  + sMonth + "-" + sDate + " " + sHour + ":"+ sMinuetes +":00" ;
	}

	function fn_CouponList(couponNo){
		$("[name='currentPageNo']").val(1);
		$("input:hidden[name='viewFlg']").val('list');
		$("[name='couponNo']").val(couponNo);
		
        $("#searchFrm").attr({method : "post", action : "<c:out value='/getSvcCouponUseList.do'/>"}).submit();
	}
</script>  


</html>
