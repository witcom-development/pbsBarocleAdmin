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
									<legend>검색조건</legend>
									<div class="shBoxSection">
										<div class="section">
											<label for="bb22" class="laType02">일자</label>
											<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" id="bb22" name="searchStrDate" readonly/></span>
											<span class="dash">~</span>
											<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" name="searchEndDate" readonly/></span>
										</div>
										<div class="section pright">
											<label for="aa1" class="laType02">이용구분</label>
					                        <select class="select-category03" name="mileageClsCd" id="mileageClsCd">
					                        	<option value="">전체</option>
					                        </select>
										</div>
										<div class="section repos">
											<label for="a3" class="laType02">회원 ID</label>
											<span class="input-text07"><input type="text" name="userId" class=""/></span>
											<button class="btn-srh03 btncase1" id="searchBtn"><img src="../images/searchIcon.gif" alt="검색"></button>
										</div>
									</div>
								</fieldset>
							</div>
						<!--검색조건 E-->
                        <div class=" tb_numlist" style="float: right;">총 ${ paginationInfo.getTotalRecordCount()} 건</div>
						<table class="tb_type01">
							<colgroup>
								<col style="width:20%"/>
								<col style="width:20%"/>
								<col style="width:20%"/>
								<col style="width:20%"/>
								<col style="width:20%"/>
							</colgroup>
							<thead>
								<tr>
									<th colspan="4">합계 (단위 : 천)</th>
									<th class="tr"><fmt:formatNumber value="${totalSum/1000}" pattern="0.0"></fmt:formatNumber></th>
								</tr>
								<tr>
									<th>등록일시</th>
                                    <th>대여일시</th>
									<th>회원 ID</th>
									<th>이용구분</th>
									<th>마일리지</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach var="result" items="${mileageList}" varStatus="status">
								<tr>
									<td class="tc">${result.regDttm}</td>
									<td class="tc">${result.rentDttm}</td>
									<td class="pl10">${result.userId}</td>
									<td class="pl10">${result.mileageClsCd}</td>
									<td class="pr10 tr"><fmt:formatNumber value="${result.mileagePoint/1000}" pattern="0.0"></fmt:formatNumber></td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
						<c:if test='${fn:length(mileageList) == 0}'>
						<table class="tb_type01 mbt0">
							<tr>
								<td style="text-align:center"><spring:message code="search.nodata.msg" /></td>
							</tr>
						</table>
						</c:if>
					<c:choose>
						<c:when test="${fn:length(mileageList) > 0}">
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
        mileage.initBtn();
        
        var sDate = '${searchCondition.searchStrDate}' != '' ? '${searchCondition.searchStrDate}' : '';
		var eDate = '${searchCondition.searchEndDate}' != '' ? '${searchCondition.searchEndDate}' : '';
		var mileageClsCd = '${searchCondition.mileageClsCd}' !== '' ? '${searchCondition.mileageClsCd}' : '';
		var userId = '${searchCondition.userId}' !== '' ? '${searchCondition.userId}' : '';
		
        commonAjax.getCommonCode("MIG", 
   	        function(data) {
   	            if(data != null && data.codeList != null) {
   	                commCdBox.makeComboBox('CC', mileageClsCd ,data.codeList, "mileageClsCd");
   	                $("#mileageClsCd").trigger('change');
   	            }
   	        }
        );
        
	
      
		$("[name='searchStrDate']").val(sDate);
		$("[name='searchEndDate']").val(eDate);
		$("[name='mileageClsCd']").val(mileageClsCd);
		$("[name='userId']").val(userId);
        
        var totalPageCount = '${paginationInfo.totalPageCount}' == '' ? 1 : Number('${paginationInfo.totalPageCount}');
   		$('#prevPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			mileage.pageSelect(currentPageNo-1);
		});
		$('#nextPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			mileage.pageSelect(currentPageNo+1);
		});
		$('#movePage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			var regExp = /^[1-9]?[0-9]/;
			if(!regExp.test(currentPageNo) ||(totalPageCount < currentPageNo)){
				alert('현재 페이지 값이 정상적이지 않습니다.');
			}else{
				mileage.pageSelect(currentPageNo);
			}
		});
    });
    
    
    var mileage = {};
    
    mileage.initBtn = function () {
    	var _this = mileage;
        $("#searchBtn").on("click", this.searchDataFnc);
        $("#excelViewBtn").on("click", this.excelDataFnc);
    };
    
    mileage.searchDataFnc = function(e) {
    	if(DateUtil.checkDateTerm( $( "[name='searchStrDate']").val(),  $( "[name='searchEndDate']").val()) !== 'ok') {
            alert("검색 조건의 시작 날이 종료 날보다 큽니다.");
            return false;
        }
    	if(DateUtil.diffDays( $("[name='searchStrDate']").val(),  $("[name='searchEndDate']").val(), '-') >= 31){
    		alert("조회기간은 31일 이내로 설정해주세요.");
    		return false;
    	} 
    	
    	$("#userId").val($("#userId").val().replace(/ /g, ''));	// 공백제거
    	
    	$("[name='viewFlg']").val('list');
        $("[name='currentPageNo']").val(1);
        $("#searchFrm").attr({method : "post", action : "<c:out value='/getMileageList.do'/>"}).submit();
    };
    mileage.excelDataFnc = function(e) {
    	$("[name='viewFlg']").val('excel');
    	$("#searchFrm").attr({method : "post", action : "<c:out value='/getMileageList.do'/>"}).submit();
    };
    mileage.pageSelect = function(cPage) {
        $("[name='viewFlg']").val('list');
        $("[name='currentPageNo']").val(cPage);
        $("#searchFrm").attr({method : "post", action : "<c:out value='/getMileageList.do'/>"}).submit();
    };
    </script>
</body>
</html>
