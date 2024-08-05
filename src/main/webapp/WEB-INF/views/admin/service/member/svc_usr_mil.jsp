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
		
		
		$("#mobiletableList").change(function(){
			
			var action = getAction($("#mobiletableList").val());
			$("#searchStartDate").val("");
			$("#searchEndDate").val("");
			$("#currentPageNo").val(1);
			
			$("#frm").attr("action", action );
			$("#frm").submit();
		})
		
	
});



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


function fn_DeletePenalty( penalty_seq ){
	
	$.post("/admin/service/member/deletePenalty.do", "penalty_seq=" + penalty_seq  , function(data) {
		
		if(data.resultMsg == "삭제성공"){
			alert(data.resultMsg);
			fn_penaltySearch();
		}
		
	});
	
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
	
	$("#currentPageNo").val(no);
	
	$("#frm").attr("action", "/admin/service/member/memberMileage.do");
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
						<ul class="tablist mt20">
							<li><a href="#">회원정보</a></li>
							<li><a href="#">결제이력</a></li>
							<li><a href="#">이용이력</a></li>
							<li class="on"><a href="#">마일리지 이력</a></li>
							<li><a href="#">벌점이력</a></li>
							<li><a href="#">환불이력</a></li>
							<li><a href="#">미납이력</a></li>
							<li><a href="#">이용권</a></li>
							<li><a href="#">선물</a></li>
						</ul>
						<select  id="mobiletableList" class="tablist_m">
							<option value="0">회원정보</option>
							<option value="1">결제이력</option>
							<option value="2" >이용이력</option>
							<option value="3" selected="selected">마일리지이력</option>
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
									<label for="bb22" class="laType02">적용일</label>
									<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" id="searchStartDate" name="searchStartDate" readonly/></span>
									<span class="dash">~</span>
									<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" id="searchEndDate"	name="searchEndDate" readonly/></span>
								</div>
								<div class="section pright">
									<label for="a1" class="laType02">이용구분</label>
									<select class="select-category03" id="mileage_cls_cd" name="mileage_cls_cd">
										<option value="">선택</option>
										<c:forEach items="${codeList }"	var="code">
											<c:if test="${form.mileage_cls_cd == code.comCd }">
												<option value="${code.comCd }" selected="selected">${code.comCdName }</option>
											</c:if>
											<c:if test="${form.mileage_cls_cd != code.comCd }">
												<option value="${code.comCd }">${code.comCdName }</option>
											</c:if>
										</c:forEach>
									</select>
									<button class="btn-srh03 btncase1" onclick="fn_Search(); return false;"><img src="/images/searchIcon.gif" alt="검색" /></button>
								</div>
							</div>
						</div>
						<!--검색조건 E-->
						<p class="tb_numlist">
							<c:if test="${paginationInfo != null }">
								총 ${paginationInfo.totalRecordCount } 건
							</c:if>
						</p>
						<table class="tb_type01">
							<colgroup>
								<col style="width:12%"/>
								<col style="width:12%"/>
								<col style="width:10%"/>
								<col style="width:21%"/>
								<col style="width:10%"/>
								<col style="width:10%"/>
							</colgroup>
							<thead>
								<tr>
									<th>등록일시</th>
									<th>대여일시</th>
									<th>이용구분</th>
									<th>카드번호</th>
									<th>적립마일리지</th>
									<th>잔여마일리지</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${mileageList }"  var="mileageList">
									<tr>
										<td class="tc">
											<fmt:parseDate var="dateString" value="${mileageList.reg_dttm }" pattern="yyyy-MM-ddHH:mm:ss" />
											<fmt:formatDate value="${dateString}" pattern="yyyy-MM-dd HH:mm" />
										</td>
										<td class="tc">
										    <c:if test="${mileageList.rent_dttm ne '-'}">
	                                            <fmt:parseDate var="dateString" value="${mileageList.rent_dttm }" pattern="yyyy-MM-ddHH:mm:ss" />
	                                            <fmt:formatDate value="${dateString}" pattern="yyyy-MM-dd HH:mm" />
										    </c:if>
										    <c:if test="${mileageList.rent_dttm eq '-'}">
										         ${mileageList.rent_dttm}
										    </c:if>
                                        </td>
										<td class="title pl10">${mileageList.mlang_com_cd_name }</td>
										<td class="tc">
											<%-- ${mileageList.mb_card_no } --%>
											<script type="text/javascript">
													if("${mileageList.mb_card_no }" !== "-" && "${mileageList.mb_card_no }".length == 19){
														var str = "${mileageList.mb_card_no }";
														document.write(str.substring(0, 4)+" - " +str.substring(5, 9) +" - **** - " +str.substring(15));
													}
											</script>
										</td>
										<td class="tr pr10">${mileageList.mileage_point }</td>
										<td class="tr pr10">${mileageList.mileage }</td>
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
						
						<br/>
						<br/>
						
						<table class="tb_type01">
							<colgroup>
								<col style="width:30%"/>
								<col style="width:30%"/>
								<col style="width:30%"/>
							</colgroup>
							<thead>
								<tr>
									<th>카드번호</th>
									<th>카드시작일자</th>
									<th>카드종료일자</th>
								</tr>
							</thead>
							<tbody>
							  	<c:forEach items="${cardList }"  var="cardList">
									<tr>
										<td class="tr pr10">${cardList.mb_card_no}</td>
										<td class="tc">
											<fmt:parseDate var="dateString" value="${cardList.reg_dttm }" pattern="yyyy-MM-ddHH:mm:ss" />
											<fmt:formatDate value="${dateString}" pattern="yyyy-MM-dd HH:mm" />
										</td>
										 <td class="tc">
											<fmt:parseDate var="dateString" value="${cardList.rent_dttm }" pattern="yyyy-MM-ddHH:mm:ss" />
											<fmt:formatDate value="${dateString}" pattern="yyyy-MM-dd HH:mm" />
										</td>
									</tr>
								</c:forEach> 
							</tbody>
						</table>
						
						 
						
						
						
						
						
						
						
						
						<div class="paging">
							<input type="hidden" name="usr_seq"	id="usr_seq" value="${info.usr_seq }" >
							<c:if test="${paginationInfo != null }">
								<input type="hidden" name="currentPageNo"	id="currentPageNo" value="${paginationInfo.currentPageNo }">
								<!-- <input type="hidden" name="penalty_seq"	id="penalty_seq" value=""> -->
								<ui:pagination paginationInfo = "${paginationInfo}" type="custom" jsFunction="linkPage"	/>
							</c:if>
						</div>
						
						<div class="btnArea">
	                            <span class="right">
	                            <input type="hidden" name="mbCardSeq"	id="mbCardSeq" value="${cardInfo.mb_card_no }">
	                            <c:if test="${cardInfo.mb_card_no != null && cardInfo.mb_card_no != ''}">
	                            <a href="/common/pop/showMileageImpose.do"  class="winNewPop btnType01" title="마일리지추가" data-width="450" data-height="300" data-pmt="&viewType=insert&usrSeq=${form.usr_seq}&mbCardSeq=" >마일리지등록</a>
	                            </c:if>
	                            </span>
	                            <!-- 추가  -->
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
