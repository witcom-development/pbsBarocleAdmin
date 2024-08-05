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

<script type="text/javascript">

$(function() {
	
	if("${result }" != ""){
		alert("${result}")
	}
	
	/* $("#penalty_point").keyup(function(){
		$(this).val($(this).val().replace(/[^0-9]/g,""));
	}); */
	
	$("#searchStartDate").val("${form.searchStartDate}");
	$("#searchEndDate").val("${form.searchEndDate}");
	$("#mbYn").val("${form.mbYn}");
	//$("#penalty_point").val("{form.penalty_point}");
	$("#searchValue").val("${form.searchValue}");
	
	if("${form.searchParameter}" != ""){
		$("#searchParameter").val("${form.searchParameter}");
	}
		
		
	
});

function linkPage(no){
	
	if($("#searchStartDate").val()  &&  $("#searchEndDate").val())
	if($("#searchStartDate").val() > $("#searchEndDate").val()){
		alert('<spring:message code="fail.input.daterange" />');
		return;
	}
	
	$("#searchValue").val($("#searchValue").val().replace(/ /g, ''));	// 공백제거

	$("#currentPageNo").val(no);
	$("#frm").attr("action", "/admin/service/safetycert/safetyCertUserList.do");

	$("#frm").submit();
}

function fn_search(){
	linkPage(1);
}

function fn_MemberDetail(seq){
	$("#certUsrSeq").val(seq);
	
	$("#frm").attr("action", "/admin/service/safetycert/safetyCertUserDetail.do");

	$("#frm").submit();
}

 


function fn_excel(){
	//alert('excel');
	//return;
		
	/*if ( $("#searchStartDate").val() == "2015-09-01" ) {
		if( this.confirm("조회 시작일이 " + $("#searchStartDate").val() + " 맞으신가요 ?") == false ) return;
	}*/

	var arrStart = $("#searchStartDate").val().split("-");
	var startDate = new Date( arrStart[0], arrStart[1], arrStart[2]);
		
	var arrEnd = $("#searchEndDate").val().split("-");
	var endDate = new Date( arrEnd[0], arrEnd[1], arrEnd[2]);
	
	/*var MonthDiff = ( endDate - startDate ) / ( 24 * 60 * 60 * 1000 * 30 ) ;
	
	if ( MonthDiff > 1 ) {
		this.alert("조회기간은 1달을 넘어설 수 없습니다. \n많은 데이터를 조회하기 위해서는 시스템관리팀에 문의부탁드립니다.");
		return;
	}*/
	
	$("input[name=usergubun]").val($("#mbYn option:selected").text());
	$("input[name=gubun]").val($("#searchParameter option:selected").text());
	//$("input[name=paymentClsCdName]").val($("#comPaymentClsCd option:selected").text()); //shoh2999
	$("#frm").attr("action", "/admin/service/safetycert/safetyCertUserListExcel.do");
	$("#frm").submit();
}

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
				<div class="content">
					<div class="subject">
						<!--subject path S-->
							<tiles:insertAttribute name="subject" />
						<!--subject path E-->
					</div>
					<div class="page">
						<!-- 모바일 검색조건 S-->
						<div class="shBox_m">
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
										<label for="bb22" class="laType02">안전교육<br>일자</label>
										<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" id="searchStartDate" name="searchStartDate" readonly/></span>
										<span class="dash">~</span>
										<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" id="searchEndDate" name="searchEndDate" readonly/></span>
									</div>
									<div class="section pright">
										<label for="a1" class="laType02">사용자구분</label>
										<select class="select-category03" id="mbYn" name="mbYn">
											<option value="">선택</option>
											<option value="Y">회원</option>
											<option value="N">비회원</option>
										</select>
									</div>
									<div class="section">
										<label for="aa1" class="laType02">구분</label>
										<select class="select-category07" id="searchParameter" name="searchParameter" style="width: 105px;">
											<option value="PHONE">휴대번호</option>
											<option value="ID">ID</option>
											<option value="NAME">이름</option>
											
										</select>
										<span class="input-text08"><input type="text" class="" id="searchValue" name="searchValue"></span>
									</div>
									<div class="section pright">
										<button class="btn-srh03 btncase1 mdbtncase1" onclick="fn_search(); return false;"><img src="/images/searchIcon.gif" alt="검색" /></button>
									</div>
								</div>
							</fieldset>
						</div>
						<!--검색조건 E-->
						<p class="tb_numlist">
							<c:if test="${paginationInfo != null }">
								총 ${paginationInfo.totalRecordCount } 건
							</c:if>
						</p>
						<table class="tb_type01" style="font-size: 12px;">
							<colgroup>
								<col style="width:4%"/>
								<col style="width:8%"/>
								<col style="width:8%"/>
								<col style="width:9%"/>
								<col style="width:7%"/>
								<col style="width:10%"/><!-- 응시일 -->
								<col style="width:7%"/>
								<col style="width:9%"/>
								<col style="width:10%"/>
								<col style="width:8%"/>
								<col style="width:10%"/>
								<!--[if gt IE 8]><!--><col style="width:10%" class="mhid"/><!--<![endif]-->
							</colgroup>
							<thead>
								<tr>
									<th>일련<br>번호</th>
									<th>응시번호</th>
									<th>이름</th>
									<th>휴대폰번호</th>
									<th>자치구</th>
									<th>응시일</th>
									<th>인증제유형코드</th>
									<th>안전교육이수기관</th>
									<th class="mhid">안전교육일자</th>
									<th>회원아이디</th>
									<th class="mhid">할인적용시작일자</th>
									
									<!--[if gt IE 8]><!--><th class="mhid">할인적용종료일자</th><!--<![endif]-->
								</tr>
							</thead>
							<tbody>
								<c:forEach var="mb"	items="${safetyCertUserList }">
									<tr>
										<td class="tc">${mb.certUsrSeq }</td>
										<td class="title"><a href="#" onclick="fn_MemberDetail('${mb.certUsrSeq }'); return false;">${mb.certNum }</a></td>
										<td class="tc">${mb.usrName }</td>
										<td class="tc">${mb.usrMpnNo }</td>
										<td class="tc">${mb.usrPrvCd }</td>
										<td class="mhid tc">
											<fmt:parseDate var="dateStringC" value="${mb.certDate }" pattern="yyyy-MM-ddHH:mm:ss" />
											<fmt:formatDate value="${dateStringC}" pattern="yyyy-MM-dd" />
										</td>
										<td class="tc">${mb.certCls }</td>
										<td class="title pl10">${mb.certOrg }</td>
										<td class="mhid tc">
											<fmt:parseDate var="dateString1" value="${mb.certEdDate }" pattern="yyyy-MM-ddHH:mm:ss" />
											<fmt:formatDate value="${dateString1}" pattern="yyyy-MM-dd" />
										</td>
										<td class="tc">${mb.mbId }</td>
										<td class="mhid tc">
											<fmt:parseDate var="dateString2" value="${mb.disSDttm }" pattern="yyyy-MM-ddHH:mm:ss" />
											<fmt:formatDate value="${dateString2}" pattern="yyyy-MM-dd" />
										</td>
										
										<!--[if gt IE 8]><!-->
										<td class="mhid tc">
											<fmt:parseDate var="dateString3" value="${mb.disEDttm }" pattern="yyyy-MM-ddHH:mm:ss" />
										<fmt:formatDate value="${dateString3}" pattern="yyyy-MM-dd" />
										</td><!--<![endif]-->
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
						
						
						<div class="paging">
							<input type="hidden" name="currentPageNo"	id="currentPageNo" value="${paginationInfo.currentPageNo }">
							<input type="hidden" name="certUsrSeq"	id="certUsrSeq">
							<input type="hidden" name="usergubun"	id="usergubun">
							<input type="hidden" name="gubun"	id="gubun">
							<c:if test="${paginationInfo != null }">
								<ui:pagination paginationInfo = "${paginationInfo}" type="custom" jsFunction="linkPage"	/>
							</c:if>
						</div>
						<div class="btnArea">
							<span class="right">
							<!--
							<button class="btnType01" id="selectSmsBtn">선택발송</button>
                            <button class="btnType01" id="allSmsBtn">전체발송</button>
							-->
							<a href='javascript:void(0);' onclick="javascript:fn_excel();return false;"  class="btnType01 mb10 mhid" >엑셀다운로드</a>
							<a href="<c:out value='/admin/service/safetycert/openUploadPop.do'/>" id="bulkUploadBtn" class="winNewPop btnType01 mb10 mhid" title="엑셀업로드" data-width="450" data-height="355" data-pmt="">엑셀업로드</a>
							</span>
						</div>
					</div>
				</div>
				</form>
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
		/* 15-10-05 추가 */
		$("#chkAll").on("click", function(e){
	        if( $("#chkAll").prop("checked")) {
	            $(".tb_type01 > tbody > tr").find('input:checkbox').prop("checked", true);
	        } else {
	            $(".tb_type01 > tbody > tr").find('input:checkbox').prop("checked", false);
	        }
	     });
		$(".tb_type01 > tbody > tr").on("change",'input' ,function(e){
            if(!$(this).prop("checked")) {
            	$("#chkAll").prop("checked", false);
            } 
         });
	     $("#selectSmsBtn").on("click", {smsType : ''}, showSmsPopup);
	     $("#allSmsBtn").on("click", {smsType : 'ALL'}, showSmsPopup);
	    /* 추가  */
	    /* 15-12-14 추가 */
	    //정기권 구분
	    /*commonAjax.getCommonCode("BIL", function(data) {
	         if(data !== null && data.codeList !== null) {
	        	 var code = new Array();
	             for(var i =0; i <data.codeList.length ;i++) {
	                 if(data.codeList[i].addVal1 === "SEASON" || data.codeList[i].addVal1 === "MDAY") {
	                     code.push(data.codeList[i]);
	                 }
	             }
	             commCdBox.makeComboBox('CC', '{form.paymentClsCd}', code, "comPaymentClsCd"); //shoh2999
	         }
	     });*/ //shoh2999
	     /* 추가  */   
	});
	/* 15-10-05 추가 */
	function showSmsPopup(e) {
	    e.preventDefault();
	    e.stopPropagation();
	    if( $('body').find(".winNewPop") !== undefined && $('body').find(".winNewPop").length >0 ) {
	        $('body').find(".winNewPop").remove();
	    }
	    var mpnNoList = [];
	    if(e.data.smsType ==='ALL') {
	        $("[name='listType']").val('A');
	        var $a = $("<a>", {'href' : '/admin/service/safetycert/getSmsAllMBMpnNo.do', 'title' : 'sms', 'data-width' :"450" ,'data-height' :"550", 'data-pmt' : '&'+$("#frm").serialize()}).addClass("winNewPop");
            $('body').first().append($a);
            $(".winNewPop").trigger("click");
	    } else {
	        $(".tb_type01 > tbody > tr").each(function(idx) {
	            if($(this).find("input[type='checkbox']").is(':checked')) {
	            	if($(this).children().eq(2).text() !== '') {
		                mpnNoList.push($(this).children().eq(2).text());
	            	}
	            }
	        });
	        if(mpnNoList.length === 0){
	            alert("선택 발송할 전화번호를 선택해 주세요.");
	            return false;
	        }
	        var $a = $("<a>", {'href' : '/common/pop/showSmsPopup.do', 'title' : 'sms', 'data-width' :"450" ,'data-height' :"550", 'data-pmt' : '&UsrMpnNo='+mpnNoList.toString() }).addClass("winNewPop");
	        $('body').first().append($a);
	        $(".winNewPop").trigger("click");
	    }
	}
	
	</script>
</body>
</html>
