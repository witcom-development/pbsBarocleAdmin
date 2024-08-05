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
						<form id="frm">
						<input type="hidden" id="usr_seq" name="usr_seq" value="" />
						<input type="hidden" name="listType" value="U"/>
						<input type="hidden" name="paymentClsCdName" value=""/>		
						</form>
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
                                       <label class="laType03">업체명</label>
									   <span class="input-text08"><input type="text" class="" name="searchValue" value="${searchCondition.searchValue}"></span>
                                    </div>
                                    <div class="section pright">
										<label for="usrSearchType" class="laType02">쿠폰번호</label>
										 <span class="input-text01"><input type="text" class="" name="couponNo" value="${searchCondition.couponNo}"></span>
									</div>
									<div class="section">
										<label for="bb11" class="laType03">발급일</label>
                                        <span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" id="bb11" name="searchRegisStartDate" readonly/></span>
                                        <span class="dash">~</span>
                                        <span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" name="searchRegisEndDate" readonly/></span>
                                        
									</div>
									<div class="section pright">
										<label for="bb22" class="laType02">사용일</label>
                                        <span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" id="bb22" name="searchStartDate" readonly/></span>
                                        <span class="dash">~</span>
                                        <span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" name="searchEndDate" readonly/></span>
									</div>
									<div class="section">
										<label for="paymentClsCd" class="laType03">권종</label>
										<select id="paymentClsCd" name="paymentClsCd">
											<option value="">선택</option>
											
										</select>
									</div>
									<div class="section pright">
										<label for="couponUseYn" class="laType02">사용여부</label>
										<select id="couponUseYn" name="couponUseYn">
											<option value="">선택</option>
											<option value="N">미사용</option>
											<option value="Y">사용</option>
										</select>
									</div>
									<div class="section">
										<label for="usrSearchType" class="laType03">사용자</label>
										<select id="usrSearchType" name="usrSearchType">
											<option value="">선택</option>
											<option value="USER_ID">회원ID</option>
											<option value="MPN_NO">휴대폰</option>
										</select>
										<span class="input-text01"><input type="text" class="" name="usrSearchKey"></span>
									</div>
									<div class="section pright">
										
										<button class="btn-srh03 btncase1" id="searchBtn"><img src="/images/searchIcon.gif" alt="검색"></button>
									</div>
									
								</div>
                            </fieldset>
							</div>
						<!--검색조건 E-->
						<p class="tb_numlist">총 ${paginationInfo.getTotalRecordCount()} 건</p>
						<table class="tb_type01">
							<colgroup>
								<col style="width:12%"/>
								<col style="width:17%"/>
								<col style="width:17%"/>
								<col style="width:17%"/>
								<col style="width:14%"/>
								<col style="width:10%"/>
								<col style="width:10%"/>
								<col style="display:none"/>
							</colgroup>
							<thead>
								
								<tr>
									<th>업체명</th>
									<th>쿠폰번호</th>
									<th>권종</th>
									<th>발급일</th>
									<th>사용일</th>
									<th>사용여부</th>
									<th>사용자</th>
									<th style="display:none"></th>
								</tr>
							</thead>
							<tbody>
							<c:forEach var="result" items="${svccouponUseList}" varStatus="status">
								<tr>
									<td>${result.mbName}</td>
									<td>${result.couponNo}</td>
									<td class="tc">
										${result.paymentClsCdName}<c:if test='${result.partyUseCnt != 0}'>(${result.partyUseCnt}명)</c:if>
									</td>
									<td class="tc"><fmt:parseDate var="strDate" value="${result.couponStrDttm}" pattern="yyyy-MM-dd"/>
									<fmt:formatDate pattern="yyyy-MM-dd" value="${strDate}"/> </td>
									<td class="tc"><fmt:parseDate var="useDate" value="${result.useDttm}" pattern="yyyy-MM-dd"/>
                                    <fmt:formatDate pattern="yyyy-MM-dd" value="${useDate}"/> </td>
									<td class="tc"><c:if test='${result.couponUseYn != "N"}'>사용</c:if>
									<c:if test='${result.couponUseYn == "N"}'>미사용</c:if>
									</td>
									<td class="title"><a href="#" onclick="fn_MemberDetail('${result.useUsrSeq }'); return false;">${result.mbId }</a></td>
									<td style="display:none" id="couponSeq">${result.couponSeq}</td>
									
								</tr>
							</c:forEach>
							</tbody>
						</table>
						<c:if test='${fn:length(svccouponUseList) == 0}'>
						<table class="tb_type01 mbt0">
							<tr>
								<td style="text-align:center"><spring:message code="search.nodata.msg" /></td>
							</tr>
						</table>
						</c:if>
					<c:choose>
						<c:when test="${fn:length(svccouponUseList) > 0}">
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
			$("[name='currentPageNo']").val(1);
			$("input:hidden[name='viewFlg']").val('list');
	        $("#searchFrm").attr({method : "post", action : "<c:out value='/getSvcCouponUseList.do'/>"}).submit();
		});
		
		
		//결제수단
		/* var paymentMethodCd = "${searchCondition.paymentMethodCd}";
        commonAjax.getCommonCode("BIM", function(data) {
        	 if(data !== null && data.codeList !== null) {
                 commCdBox.makeComboBox('CC', paymentMethodCd,data.codeList, "paymentMethodCd");
             }
        });
         */
         
         var paymentClsCd = "${searchCondition.paymentClsCd}";
         commonAjax.getCommonCode("BIL", function(data) {
         	 if(data !== null && data.codeList !== null) {
                  commCdBox.makeComboBox('CC', paymentClsCd,data.codeList, "paymentClsCd");
              }
         }); 
         
      
         
        $("[name='couponDelYn']").val("${searchCondition.couponDelYn}");
        $("[name='couponUseYn']").val("${searchCondition.couponUseYn}");
        $("[name='searchStartDate']").val("${searchCondition.searchStartDate}");
        $("[name='searchEndDate']").val("${searchCondition.searchEndDate}");
        $("[name='searchRegisStartDate']").val("${searchCondition.searchRegisStartDate}");
        $("[name='searchRegisEndDate']").val("${searchCondition.searchRegisEndDate}");
        $("[name='usrSearchType']").val("${searchCondition.usrSearchType}");
        $("[name='usrSearchKey']").val("${searchCondition.usrSearchKey}");

		coupon.pageSelect = function(pageNo) {
        	
        	$("[name='currentPageNo']").val(pageNo);
        	$("input:hidden[name='viewFlg']").val('list');
	        $("#searchFrm").attr({method : "post", action : "<c:out value='/getSvcCouponUseList.do'/>"}).submit();
        	
        };
		
		
    });
    
    function fn_MemberDetail(seq){
    	
    	$("#usr_seq").val(seq);
    	
    	// $("#frm").attr("action", "/admin/service/member/memberInfo.do");
    	$("#frm").attr({method : 'post', action : '/admin/service/member/memberInfo.do'}).submit();

    	$("#frm").submit();
    }
   
    
    
    </script>
</body>
</html>
