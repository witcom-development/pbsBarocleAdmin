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
			                    <input type="hidden" name="searchType" value="" />
			                    <input type="hidden" name="paymentStusCdName" value="" />
			                    <fieldset>
									<legend>검색조건</legend>
									<div class="shBoxSection">
										<div class="section">
											<label for="bb22" class="laType02">일자</label>
											<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" id="bb22" name="startDttm" readonly/></span>
											<span class="dash">~</span>
											<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" name="endDttm" readonly/></span>
										</div>
										<div class="section pright">
											<label for="aa1" class="laType02">승인번호</label>
											<span class="input-text07"><input type="text" maxlength=50 name="paymentConfmNo" /></span>
										</div>
										<div class="section repos">
											<label for="a3" class="laType02">구분</label>
											<span class="input-rd01"><input type="radio" id="a3" name="radioSearchType" value="01" checked="checked"><label for="a3">환불</label></span>
											<span class="input-rd01"><input type="radio" id="a4" name="radioSearchType" value="02"><label for="a4">취소</label></span>
											<button class="btn-srh03 btncase1" id="searchBtn"><img src="../images/searchIcon.gif" alt="검색"></button>
										</div>
									</div>
								</fieldset>
							</div>
						<!--검색조건 E-->
						<div class="tb_case1">총금액  : <em><fmt:formatNumber type="number" value="${searchTotAmt}"/></em> <span>총 ${paginationInfo.getTotalRecordCount()} 건</span></div>
						<table class="tb_type01">
							<colgroup>
								<col style="width:10%"/>
								<col style="width:15%"/>
								<col style="width:10%"/>
								<col style="width:15%"/>
								<col style="width:20%"/>
								<!--[if gt IE 8]><!--><col style="width:15%" class="mhid"/><!--<![endif]-->
							</colgroup>
							<thead>
								<tr>
									<th>결제구분</th>
									<th>아이디</th>
									<th>처리자</th>
									<th>금액</th>
									<th>처리일시</th>
									<!--[if gt IE 8]><!--><th class="mhid">관련승인번호</th><!--<![endif]-->
								</tr>
							</thead>
							<tbody>
							<c:forEach var="result" items="${refundList}" varStatus="status">
								<tr>
									<td>${result.paymentClsCdName}</td>
									<c:choose>
                                    <c:when test="${result.mbId!=null}">
                                    <td>${result.usrMainId}</td>
                                    </c:when>
                                    <c:otherwise>
                                    <td>${result.usrMainId}</td>
                                    </c:otherwise>
                                    </c:choose>
									<td>${result.refundAdminName}</td>
									<c:choose>
                                    <c:when test="${result.paymentStusCd=='BIS_002'}">
                                    <td class="tr">
                                    <a href="<c:out value='/moveRefundPop.do'/>" 
                                    class="winNewPop modal" title="환불처리" 
                                    data-width="450" data-height="588"  
                                    data-pmt="&viewFlg=view&paymentSeq=${result.paymentSeq}&paymentDttm=${result.paymentDttm}&usrMainId=${result.usrMainId}"><fmt:formatNumber type="number" value="${result.totAmt}"/></a>
                                    </td>
                                    </c:when>
                                    <c:when test="${result.paymentStusCd=='BIS_003'}">
                                    <td class="tr">
                                    <a href="<c:out value='/moveCancelPop.do'/>"
                                    class="winNewPop modal" title="결제취소"
                                    data-width="450" data-height="447"  
                                    data-pmt="&viewFlg=view&paymentSeq=${result.paymentSeq}&paymentDttm=${result.paymentDttm}&usrMainId=${result.usrMainId}"><fmt:formatNumber type="number" value="${result.totAmt}"/></a>
                                    </td>
                                    </c:when>
                                    </c:choose>
									<c:choose>
                                    <c:when test="${result.paymentStusCd=='BIS_002'}">
									<td class="tc">${result.refundDttm}</td>
									</c:when>
                                    <c:otherwise>
									<td class="tc">${result.cancelDttm}</td>
									</c:otherwise>
                                    </c:choose>
									<!--[if gt IE 8]><!--><td class="mhid">${result.paymentConfmNo}</td><!--<![endif]-->
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
        refund.initBtn();
        
        var calDay = new Date();
        var dayOfMonth = calDay.getDate();
        calDay.setDate(dayOfMonth - 30);
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
    
    
    var refund = {};
    //refund.searchType = "${searchCondition.searchType}";
    refund.initBtn = function () {
    	var _this = refund;
        $("#searchBtn").on("click", this.searchDataFnc);
        $("#excelViewBtn").on("click", this.excelDataFnc);
    };
    
    refund.searchDataFnc = function(e) {
    	if(DateUtil.checkDateTerm( $( "[name='startDttm']").val(),  $( "[name='endDttm']").val()) !== 'ok') {
            alert("검색 조건의 시작 날이 종료 날보다 큽니다.");
            return false;
        }
    	
    	if(DateUtil.diffDays( $("[name='startDttm']").val(),  $("[name='endDttm']").val(), '-') >= 31){
    		alert("조회기간은 31일 이내로 설정해주세요.");
    		return false;
    	} 
    	
    	var searchType = $(':radio[name="radioSearchType"]:checked').val();
        
    	$("[name='paymentConfmNo']").val($("[name='paymentConfmNo']").val().replace(/ /g, ''));	// 공백제거
    	
    	$("input:hidden[name='viewFlg']").val('list');
        $("[name='currentPageNo']").val(1);
        $("input:hidden[name='searchType']").val(searchType);
        $("#searchFrm").attr({method : "post", action : "<c:out value='/getRefundList.do'/>"}).submit();
    };
    refund.excelDataFnc = function(e) {
    	var searchType = $(':radio[name="radioSearchType"]:checked').val();
    	var text = $('input:radio:checked + label').text();
        
    	$("input:hidden[name='viewFlg']").val('excel');
    	$("input:hidden[name='searchType']").val(searchType);
    	$("input:hidden[name='paymentStusCdName']").val(text);
    	$("#searchFrm").attr({method : "post", action : "<c:out value='/getRefundList.do'/>"}).submit();
    };
    refund.pageSelect = function(cPage) {
    	var searchType = $(':radio[name="radioSearchType"]:checked').val();
    	
        $("input:hidden[name='viewFlg']").val('list');
        $("[name='currentPageNo']").val(cPage);
        $("input:hidden[name='searchType']").val(searchType);
        $("#searchFrm").attr({method : "post", action : "<c:out value='/getRefundList.do'/>"}).submit();
    };
    </script>
</body>
</html>
