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
						<input type="hidden" name="usrSeq" value="${searchCondition.usrSeq}"/>
						<input type="hidden" name="couponName" value="${searchCondition.couponName}"/>
						<input type="hidden" name="paymentClsCd" value="${searchCondition.paymentClsCd}"/>
						<input type="hidden" name="paymentDttm" value="${searchCondition.paymentDttm}"/>
						<input type="hidden" name="partyUseCnt" value="${searchCondition.partyUseCnt}"/>
						<input type="hidden" name="viewFlg" value=""/>
						
						
						
						</form>
                        <form id="searchFrm" name="searchFrm">
							<div class="shBox">
			                   <h1> ${searchCondition.couponName}  구매 상세 내역</h1>
							</div>
						<!--검색조건 E-->
						<p class="tb_numlist">총 ${paginationInfo.getTotalRecordCount()} 건</p>
						<table class="tb_type01">
							<colgroup>
								<%-- <col style="width:12%"/> --%>
								<col style="width:17%"/>
								<col style="width:17%"/>
								<col style="width:25%"/>
								<col style="width:14%"/>
								<col style="width:10%"/>
							</colgroup>
							<thead>
								<!-- <tr>
									<th>업체명</th>
									<th>종류</th>
									<th>권종</th>
									<th>결제일</th>
									<th>유효기간</th>
									<th>구매건수 </th>
									<th>등록건수 </th>
								</tr> -->
								<tr>
									<!-- <th>업체명</th> -->
									<th>쿠폰번호</th>
									<th>권종</th>
									<th>유효기간</th>
									<th>발급일</th>
									<th>사용여부</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach var="result" items="${svccouponBuyDetailList}" varStatus="status">
								<tr>
									<%-- <td>${result.mbName}</td> --%>
									<td>${result.couponNo}</td>
									<td class="tc">
										${result.paymentClsCdName}<c:if test='${result.partyUseCnt != 0}'>(${result.partyUseCnt}명)</c:if>
									</td>
									<td class="tc"><fmt:parseDate var="strDate" value="${result.couponStrDttm}" pattern="yyyy-MM-dd"/>
									<fmt:parseDate var="endDate" value="${result.couponEndDttm}" pattern="yyyy-MM-dd"/>
                                    <fmt:formatDate pattern="yyyy-MM-dd" value="${strDate}"/> ~ <fmt:formatDate pattern="yyyy-MM-dd" value="${endDate}"/></td>
									<td class="tc"><fmt:formatDate pattern="yyyy-MM-dd" value="${strDate}"/> </td>
									<td class="tc"><c:if test='${result.couponUseYn != "N"}'>사용</c:if>
									<c:if test='${result.couponUseYn == "N"}'>미사용</c:if>
									</td>
									
								</tr>
							</c:forEach>
							</tbody>
						</table>
						<c:if test='${fn:length(svccouponBuyDetailList) == 0}'>
						<table class="tb_type01 mbt0">
							<tr>
								<td style="text-align:center"><spring:message code="search.nodata.msg" /></td>
							</tr>
						</table>
						</c:if>
					<c:choose>
						<c:when test="${fn:length(svccouponBuyDetailList) > 0}">
							<div class="drpaging">
						</c:when>
						<c:otherwise>
							<div class="drpaging" style="display:none;">
						</c:otherwise>
					</c:choose>
							<c:choose>
							<c:when test="${paginationInfo.currentPageNo > 1}">
								<a id="prevPage1" href="#"><img src="/images/p_prev.gif" alt="이전 페이지" /></a>
							</c:when>
							<c:otherwise>
								<a href="#"><img src="/images/p_prev.gif" alt="이전 페이지" /></a>
							</c:otherwise>
							</c:choose>
							<span><input name="currentPageNo" type="number" value="${paginationInfo.currentPageNo}"/><em>/ ${paginationInfo.totalPageCount}</em><button id="movePage">이동</button></span>
							<c:choose>
							<c:when test="${paginationInfo.currentPageNo < paginationInfo.totalPageCount}">
							<a id="nextPage1" href="#"><img src="/images/p_next.gif" alt="다음 페이지" /></a>
							</c:when>
							<c:otherwise>
								<a href="#"><img src="/images/p_next.gif" alt="다음 페이지" /></a>
							</c:otherwise>
							</c:choose>
						</div>
						</form>
						<div class="btnArea tr">
					
							<!--[if gt IE 8]><!--><button class="btnType01 mhid" id="excelViewBtn">엑셀</button><!--<![endif]-->
							<%-- </c:if> --%>
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
	        $("#searchFrm").attr({method : "post", action : "<c:out value='/getSvcCouponBuyList.do'/>"}).submit();
		});
		$('#excelViewBtn').on("click",function(){
			$("input:hidden[name='viewFlg']").val('excel');
			
	        $("#frm").attr({method : "post", action : "<c:out value='/getSvcCouponBuyDetail.do'/>"}).submit();
		});
		
		
		
    });
   
    
    
    </script>
</body>
</html>
