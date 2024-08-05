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
	<%-- 현재 메뉴의 값을 절대적으로 표시하야 함. --%> var currentPageName = "usrcpr";
</script>
<script type="text/javascript">

$(function() {
	
	if("${result }" != ""){
		alert("${result}")
	}
	
	$("#penalty_point").keyup(function(){
		$(this).val($(this).val().replace(/[^0-9]/g,""));
	});
	
	
	$("#searchStartDate").val("${form.searchStartDate}");
	$("#searchEndDate").val("${form.searchEndDate}");
	$("#usr_cls_cd").val("${form.usr_cls_cd}");
	$("#penalty_point").val("${form.penalty_point}");
	$("#searchValue").val("${form.searchValue}");
	
	if("${form.searchParameter}" != ""){
		$("#searchParameter").val("${form.searchParameter}");
	}
		
	window.osType = '${appOsType}';
	window.osType = window.osType != "" ? window.osType : "web";
	
});

function linkPage(no){
	
	if($("#searchStartDate").val()  &&  $("#searchEndDate").val())
	if($("#searchStartDate").val() > $("#searchEndDate").val()){
		alert('<spring:message code="fail.input.daterange" />');
		return;
	}
	
	$("#searchValue").val($("#searchValue").val().replace(/ /g, ''));	// 공백제거

	$("#currentPageNo").val(no);
	$("#frm").attr("action", "/admin/service/member/memberCprList.do");

	$("#frm").submit();
}

function fn_search(){
	linkPage(1);
}

function fn_MemberDetail(seq){
	
	$("#usr_seq").val(seq);
	
	$("#frm").attr("action", "/admin/service/member/memberInfo.do");

	$("#frm").submit();
}

function fn_MemberConfirm(seq, mbId){
	$("#usr_seq").val(seq);
	
	if(confirm(mbId+" 가입을 승인하시겠습니까?")){
		/* $("#frm").attr("action", "/admin/service/member/memberConfirm.do");
		$("#frm").submit(); */
		$.ajax({
			type		: 'post',
			url			: '/admin/service/member/memberConfirm.do',
			dataType	: 'json',
			data		: $('#frm').serialize(),
			async		: false,
			success		: function(data){
				if(data.resultMessage == 'Success'){
					alert('승인이 완료되었습니다.');
					$("#frm").attr({method : 'post', action : '/admin/service/member/memberCprList.do'}).submit();
				}else{
					alert('가입 승인을 실패하였습니다.');
				}
			},
			error : function(jqXHR, textStatus,errorThrown){
				if(jqXHR.status === 500){
					alert(textStatus);
				} else {
					return false;
				}
				//console.log(textStatus);
			}
		});
	}
	
	return;
}

function fn_excel(){
	
	
	$("input[name=usergubun]").val($("#usr_cls_cd option:selected").text());
	$("input[name=gubun]").val($("#searchParameter option:selected").text());
	$("input[name=paymentClsCdName]").val($("#comPaymentClsCd option:selected").text());
	

	$("#frm").attr("action", "/admin/service/member/memberListExcel.do");

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
				<input type="hidden" name="listType" value="U"/>
				<input type="hidden" name="paymentClsCdName" value=""/>		
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
										<label for="bb22" class="laType02">가입일</label>
										<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" id="searchStartDate" name="searchStartDate" readonly/></span>
										<span class="dash">~</span>
										<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" id="searchEndDate" name="searchEndDate" readonly/></span>
									</div>
									<!-- <div class="section pright">
										<label for="a1" class="laType02">사용자구분</label>
										<select class="select-category03" id="usr_cls_cd" name="usr_cls_cd">
											<option value="">선택</option>
											<option value="USR_001">내국인</option>
											<option value="USR_002">외국인</option>
										</select>
									</div> -->
									<div class="section">
										<label for="aa1" class="laType02">구분</label>
										<select class="select-category07" id="searchParameter" name="searchParameter" style="width: 105px;">
											<option value="ID">ID</option>
											<option value="PHONE">휴대번호</option>
											
										</select>
										<span class="input-text08"><input type="text" class="" id="searchValue" name="searchValue"></span>
									</div>
									<!-- <div class="section pright">
										<label for="a44" class="laType02">벌점</label>
										<span class="input-text08"><input type="text" id="penalty_point" name="penalty_point" class="tr" maxlength="5"/>이상</span>
										<button class="btn-srh03 btncase1 mdbtncase1" onclick="fn_search(); return false;"><img src="/images/searchIcon.gif" alt="검색" /></button>
									</div>
									<div class="section">
                                        <label for="aa1" class="laType02">결제구분</label>
                                        <select class="select-category03" id="comPaymentClsCd" name="paymentClsCd">
                                            <option value="">선택</option>
                                        </select>
                                    </div> -->
								</div>
							</fieldset>
						</div>
						<!--검색조건 E-->
						<p class="tb_numlist">
							<c:if test="${paginationInfo != null }">
								총 ${paginationInfo.totalRecordCount } 건
							</c:if>
						</p>
						<table class="tb_type01">
							<colgroup>
								<col style="width:5%"/><!--15-10-05 추가  -->
								<col style="width:15%"/>
								<col style="width:18%"/>
								<col style="width:18%"/>
								<col style="width:10%"/>
								<!--[if gt IE 8]><!--><col style="width:18%" class="mhid"/><!--<![endif]-->
								<col style="width:10%"/>
							</colgroup>
							<thead>
								<tr>
									<th><input type="checkbox" id="chkAll"/></th><!--15-10-05 추가  -->
									<th>아이디</th>
									<th>휴대폰번호</th>
									<th>사업자번호</th>
									<th>승인여부</th>
									<!--[if gt IE 8]><!--><th class="mhid">가입일</th><!--<![endif]-->
									<th>사업자등록증</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="mb"	items="${memberList }">
									<tr>
										 <td class="tc"><input type="checkbox"/></td><!--15-10-05 추가  -->
										<td class="title"><a href="#" onclick="fn_MemberDetail('${mb.usr_seq }'); return false;">${mb.mb_id }</a></td>
										<td class="tc">${mb.usr_mpn_no }</td>
										<td class="tc">${mb.jurirNo}</td>
										<td class="tc">
											<c:if test="${mb.authYn =='N' }"><a href="#" onclick="fn_MemberConfirm('${mb.usr_seq }','${mb.mb_id }'); return false;">미승인</a></c:if>
											<c:if test="${mb.authYn =='Y' }">승인</c:if>
										</td>
										<!--[if gt IE 8]><!-->
										<td class="mhid tc">
										${mb.reg_dttm }
											<fmt:parseDate var="dateString" value="${mb.reg_dttm }" pattern="yyyy-MM-ddHH:mm:ss" />
										</td><!--<![endif]-->
										<td class="tc">
											<c:if test="${mb.jurirFile != null }">
											<a href="javascript:fileDownload('${mb.usr_seq}','${mb.jurirFile}')">다운</a>
											</c:if>
											<%-- ${mb.jurirFile } --%>
										</td>
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
							<input type="hidden" name="usr_seq"	id="usr_seq">
							<input type="hidden" name="usergubun"	id="usergubun">
							<input type="hidden" name="gubun"	id="gubun">
							<c:if test="${paginationInfo != null }">
								<ui:pagination paginationInfo = "${paginationInfo}" type="custom" jsFunction="linkPage"	/>
							</c:if>
						</div>
						<div class="btnArea">
							<span class="right">
							<!--15-10-05 추가  -->
							<button class="btnType01" id="selectSmsBtn">선택발송</button>
                            <button class="btnType01" id="allSmsBtn">전체발송</button>
							<!-- 추가  -->
							<button class="btnType01" type="button" onclick="fn_excel()">엑셀 다운로드</button></span>
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
	    commonAjax.getCommonCode("BIL", function(data) {
	         if(data !== null && data.codeList !== null) {
	        	 var code = new Array();
	             for(var i =0; i <data.codeList.length ;i++) {
	                 if(data.codeList[i].addVal1 === "SEASON" || data.codeList[i].addVal1 === "MDAY") {
	                     code.push(data.codeList[i]);
	                 }
	             }
	             commCdBox.makeComboBox('CC', '${form.paymentClsCd}', code, "comPaymentClsCd");
	         }
	     });
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
	        var $a = $("<a>", {'href' : '/admin/service/member/getSmsAllMBMpnNo.do', 'title' : 'sms', 'data-width' :"450" ,'data-height' :"550", 'data-pmt' : '&'+$("#frm").serialize()}).addClass("winNewPop");
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
	
	function fileDownload(seq, url){
		
    	$('[name="usr_seq"]').val(seq);
    	
		if(confirm("다운로드 하시겠습니까?")){
			$("#frm").attr({action : "/admin/service/member/downloadFile.do", method : 'post'}).submit();
			//location.href = "/admin/service/member/downloadFile.do?currentPageName="+currentPageName;
		}else return false;

    	/* var downUrlStr =url.substring(46);
		var fileUploadDir = "${fileUploadDir}";
    	var downUrl = location.protocol + "//" + location.host + url;
		
    	window.osType = window.osType != "" ? window.osType : "web";
    	alert(window.osType);
    	switch(window.osType){
        case "web" :
        	$("#frm").attr({action : "/admin/service/member/downloadFile.do", method : 'post'}).submit();
            break;
        case "android" :
			window.android.downLoadFile(downUrl);
            break;
        case "ios" : 
        	window.android.downLoadFile(downUrl);
        	break;
		}	 */	
    	
	}
	</script>
</body>
</html>
