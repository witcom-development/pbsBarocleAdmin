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
		
		//받은 이용권 클릭시
		$("#rec").click(function(){
			if($("#searchStartDate").val()  &&  $("#searchEndDate").val())
				if($("#searchStartDate").val() > $("#searchEndDate").val()){
					alert('<spring:message code="fail.input.daterange" />');
					return;
				}
				$("#currentPageNo").val(1);
				$("#btn_chk").val($("#rec").val());
				
				$("#frm").attr("action", "/admin/service/member/memberGiftList.do");
				$("#frm").submit();
		});
		
		//보낸 이용권 클릭시
		$("#sen").click(function(){
			if($("#searchStartDate").val()  &&  $("#searchEndDate").val())
				if($("#searchStartDate").val() > $("#searchEndDate").val()){
					alert('<spring:message code="fail.input.daterange" />');
					return;
				}
				$("#currentPageNo").val(1);
				$("#btn_chk").val($("#sen").val());
				
				$("#frm").attr("action", "/admin/service/member/memberGiftList.do");
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
	
});

function fn_MemberDetail(seq){
	
	$("#usr_seq").val(seq);
	
	$("#frm").attr("action", "/admin/service/member/memberInfo.do");

	$("#frm").submit();
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
	
	$("#btn_chk").val($("#btn_chk").val());
	$("#currentPageNo").val(no);
	
	$("#frm").attr("action", "/admin/service/member/memberGiftList.do");
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
		<input type="hidden" name="btn_chk"	id="btn_chk" value="${btnChk}" >
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
							<li><a href="#">이용권</a></li>
							<li class="on"><a href="#">선물</a></li>
						</ul>
						<select  id="mobiletableList" class="tablist_m">
							<option value="0">회원정보</option>
							<option value="1">결제이력</option>
							<option value="2" >이용이력</option>
							<option value="3">마일리지이력</option>
							<option value="4">벌점이력</option>
							<option value="5">환불이력</option>
							<option value="6">미납이력</option>
							<option value="7">이용권</option>
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
							<legend>검색조건</legend>
							<div class="shBoxSection">
								<div class="section">
									<label for="bb22" class="laType02">등록일</label>
									<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" id="searchStartDate" name="searchStartDate" readonly/></span>
									<span class="dash">~</span>
									<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" id="searchEndDate"	name="searchEndDate" readonly/></span>
								</div>
								<div class="section pright etccase1">
									<button class="btn-srh03 btncase1 mdbtncase1" onclick="fn_Search(); return false;"><img src="/images/searchIcon.gif" alt="검색" /></button>
								</div>
							</div>
						</div>
						<!--검색조건 E-->
						
						<div class="tabWrap type3">
							<ul class="tabBox">
								<%--
								<li class="tab on"><button type="button" class="frist">이용권 현황</button></li>
								 --%>
								<c:if test="${btnChk == 1 || btnChk == null}">
								<li class="tab on" ><button type="button" id="rec" value="1">받은 이용권</button></li>
								<li class="tab"><button type="button" id="sen" value="2">보낸 이용권</button></li>
								</c:if>
								<c:if test="${btnChk == 2}">
								<li class="tab" ><button type="button" id="rec" value="1">받은 이용권</button></li>
								<li class="tab on"><button type="button" id="sen" value="2">보낸 이용권</button></li>
								</c:if>
								
							</ul>
							<%--
							<!-- heading 레벨은 상황에 따라 수정 -->
							<h5 class="blind">이용권 현황</h5>
							<div class="tabCon on">
								<p class="tb_numlist" style="margin-top: -30px">
									<c:if test="${paginationInfo != null }">
										총 ${paginationInfo.totalRecordCount } 건
									</c:if>
								</p>
								<table class="tb_type01">
									<caption>
										<details>
											<summary>이용권 현황</summary>
										</details>
									</caption>
									<colgroup>
										<col style="width:15%">
										<col style="width:15%">
										<col style="width:40%">
										<col style="width:10%">
									</colgroup>
									<thead>
										<tr>
											<th scope="col">이용권 구분</th>
											<th scope="col">등록일</th>
											<th scope="col">사용기간</th>
											<th scope="col">상태</th>
										</tr>
									</thead>
									<tbody>
									<%--
									<c:forEach var="result" items="${voucherList}" varStatus="status">
										<tr>
											<td>${result.couponName}</td>
											<td class="tc">${result.regDttm}</td>
											<c:choose>
												<c:when test="${result.voucherUseYn == 'N'}">
												<td class="tc">-</td>
												</c:when>
												<c:otherwise>
												<td class="tc">${result.voucherBgnDttm} ~ ${result.voucherEndDttm}</td>
												</c:otherwise>
											</c:choose>
											<td>${result.voucherUseYn == 'Y' ? '사용' : '미사용'}</td>
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
							</div>
							--%>
							<h5 class="blind">받은 이용권</h5>
							<c:if test="${btnChk == 1 || btnChk == null}">
									<p class="tb_numlist" style="margin-top: -25px">
										<c:if test="${paginationInfo != null }">
											총 ${paginationInfo.totalRecordCount} 건
										</c:if>
									</p>
									<table class="tb_type01">
										<caption>
											<details>
												<summary>받은 이용권</summary>
												<p>이용권 구분, 등록일, 사용기간, 상태에 대한 정보 안내입니다.</p>
											</details>
										</caption>
										<colgroup>
											<col style="width:12%">
											<col style="width:15%">
											<col style="width:10%">
											<col style="width:10%">
											<col style="width:20%">
											<col style="width:20%">
											<col style="width:20%">
										</colgroup>
										<thead>
											<tr>
												<th scope="col">이용권 구분</th>
												<th scope="col">발신자</th>
												<th scope="col">쿠폰번호</th>
												<th scope="col">사용개시 여부</th>
												<th scope="col">결제일시</th>
												<th scope="col">개시일시</th>
												<th scope="col">종료일시</th>
											</tr>
										</thead>
										<tbody>
										<c:forEach var="recvList" items="${recvCouponList}" varStatus="status">
											<tr>
												<td>${recvList.couponName}</td>
												<td class="tc"><a href="#" onclick="fn_MemberDetail('${recvList.usr_seq }'); return false;">${recvList.telNo}</a></td>
												<td class="tc">${recvList.couponNo}</td>
												<td class="tc">${recvList.couponStatus}</td>
												<td class="tc">${recvList.paymentDttm}</td>
												<td class="tc">${recvList.voucherBgnDttm}</td>
												<td class="tc">${recvList.voucherEndDttm}</td>
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
								
							</c:if>	
							<h5 class="blind">보낸 이용권</h5>
							<c:if test="${btnChk == 2}">
									<p class="tb_numlist" style="margin-top: -25px">
										<c:if test="${paginationInfo != null }">
											총 ${paginationInfo.totalRecordCount } 건
										</c:if>
									</p>
									<table class="tb_type01">
										<caption>
											<details>
												<summary>보낸 이용권</summary>
												<p>이용권 구분, 등록일, 사용기간, 상태에 대한 정보 안내입니다.</p>
											</details>
										</caption>
										<colgroup>
											<col style="width:12%">
											<col style="width:15%">
											<col style="width:10%">
											<col style="width:10%">
											<col style="width:20%">
											<col style="width:20%">
											<col style="width:20%">
										</colgroup>
										<thead>
											<tr>
												<th scope="col">이용권 구분</th>
												<th scope="col">수신자</th>
												<th scope="col">쿠폰번호</th>
												<th scope="col">사용개시 여부</th>
												<th scope="col">결제일시</th>
												<th scope="col">개시일시</th>
												<th scope="col">종료일시</th>
											</tr>
										</thead>
										<tbody>
										<c:forEach var="sendList" items="${sendCouponList}" varStatus="status">
											<tr>
												<td>${sendList.couponName}</td>
												<td class="tc"><a href="#" onclick="fn_MemberDetail('${sendList.usr_seq }'); return false;">${sendList.telNo}</a></td>
												<td class="tc">${sendList.couponNo}</td>
												<td class="tc">${sendList.couponStatus}</td>
												<td class="tc">${sendList.paymentDttm}</td>
												<td class="tc">${sendList.voucherBgnDttm}</td>
												<td class="tc">${sendList.voucherEndDttm}</td>
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
							</c:if>	
						</div>
						
						<div class="paging">
							<input type="hidden" name="usr_seq"	id="usr_seq" value="${info.usr_seq }">
							<c:if test="${paginationInfo != null }">
								<input type="hidden" name="currentPageNo"	id="currentPageNo" value="${paginationInfo.currentPageNo }">
								<input type="hidden" name="penalty_seq"	id="penalty_seq" value="">
								<ui:pagination paginationInfo = "${paginationInfo}" type="custom" jsFunction="linkPage"	/>
							</c:if>
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
</body>
</html>
