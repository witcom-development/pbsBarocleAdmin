<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<%@ page import="com.dkitec.barocle.admin.login.vo.UserSessionVO" %>
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
		/* case 3:	actionValue = "/admin/service/member/memberMileage.do";			break;
		case 4: actionValue = "/admin/service/member/memberPenalty.do";			break;
		case 5: actionValue = "/admin/service/member/memberRefundList.do";		break; */
		case 3: actionValue = "/admin/service/member/memberUnpaidList.do";  	break;
		/* case 7:	actionValue = "/admin/service/member/memberVoucherList.do"; 	break;
		case 8:	actionValue = "/admin/service/member/memberGiftList.do"; 		break; */
	}
	return actionValue;
}

function reloadPage(){
	location.reload(true);
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
	
	$("#frm").attr("action", "/admin/service/member/memberPaymentList.do");
	$("#frm").submit();
	
}

function canclePayment(paymentSeq,paymentDttm,mbId){
	
	$.ajax({
		url : "/couponYnChk.do",
		type : "post",
		dataType : "json",
		data : {paymentSeq:paymentSeq},
		async : false,
		beforeSubmit: function (data,form,option) {
            return true;
        },
		success : function(data){
			if(data.resultMessage == "Success"){
				
                if ( data.useYn == "N" ) {

                   	var $a = null;
                   	$a = $("<a>", {'href' : '/moveCancelPop.do', 
                   					'title' : "결제 강제 취소", 
                   					'data-width' :"450" ,
                   					'data-height' :"540", 
                   					'data-pmt' : '&viewFlg=' + "insert" 
                   					+ '&paymentSeq=' + paymentSeq 
                   					+ '&couponNo=' + data.couponNo
                   					+ '&useYn=' + data.useYn
                   					+ '&paymentDttm=' + paymentDttm 
                   					+ '&usrMainId=' + "${payment.mb_id}"}).addClass("winNewPop modal");
                   	$a.attr("id","tempWinNewPop");
                   	$('body').first().append($a);
                    $("#tempWinNewPop").trigger("click");
                      
                	
                	
                	/* var cancleReason = prompt('결제 취소사유를 입력해주세요.', '결제 취소');
	                
                	if ( cancleReason  == null ) return;
                	
	                	$.ajax({
							url : "/setPaymentCancel.do",
							type : "post",
							dataType : "json",
							data : {viewFlg:'insert',paymentSeq:paymentSeq,paymentDttm:paymentDttm,useYn:'N',cancelReasonDesc:cancleReason},
							async : false,
							beforeSubmit: function (data,form,option) {
					            return true;
					        },
							success : function(data){
								alert("정상처리되었습니다. 재 조회를 부탁드립니다.");
							},
							error : function(jqXHR, textStatus,errorThrown){
								if(jqXHR.status === 500 || jqXHR.status === 200){
									alert("에러가 발생했습니다. : " + textStatus);
								}
							}
	                 
	                	}
	               ); */
	                
	                
                } else {
                	
                	alert("이용권이 사용중입니다.");
                	
                }
			}
			
			
			
		},
		error : function(jqXHR, textStatus,errorThrown){
			if(jqXHR.status === 500 || jqXHR.status === 200){
				alert("에러가 발생했습니다. : " + textStatus);
			}
		    //lodBarCtl.close();
		}
	});
	
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
							<li class="on"><a href="#">결제이력</a></li>
							<li><a href="#">이용이력</a></li>
							<!-- <li><a href="#">마일리지 이력</a></li>
							<li><a href="#">벌점이력</a></li>
							<li><a href="#">환불이력</a></li> -->
							<li><a href="#">미납이력</a></li>
							<!-- <li><a href="#">이용권</a></li>
							<li><a href="#">선물</a></li> -->
						</ul>
						<select  id="mobiletableList" class="tablist_m">
							<option value="0">회원정보</option>
							<option value="1"  selected="selected">결제이력</option>
							<option value="2">이용이력</option>
							<!-- <option value="3">마일리지이력</option>
							<option value="4">벌점이력</option>
							<option value="5">환불이력</option> -->
							<option value="6">미납이력</option>
							<!-- <option value="7">이용권</option> -->
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
									<label for="bb22" class="laType02">결제 일</label>
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
						<p class="tb_numlist">
							<c:if test="${paginationInfo != null }">
								총 ${paginationInfo.totalRecordCount } 건
							</c:if>
						</p>
						<table class="tb_type01">
							<colgroup>
								<col style="width:18%"/>
								<%-- <col style="width:12%"/> --%>
								<col style="width:18%"/>
								<col style="width:18%"/>
								<col style="width:11%"/>
								<!--[if gt IE 8]><!--><col style="width:12%" class="mhid"/><!--<![endif]-->
								<!--[if gt IE 8]><!--><col style="width:12%" class="mhid"/><!--<![endif]--> <!-- 20200511 이용권번호 -->
							</colgroup>
							<thead>
								<tr>
									<th>승인번호</th>
									<th>결제일시</th>
									<!-- <th>결제구분</th> -->
									<th>결제방법</th>
									<th>결제금액</th>
									<!--[if gt IE 8]><!--><th class="mhid">결제상태</th><!--<![endif]-->
									<!--[if gt IE 8]><!--><th class="mhid">결제취소</th><!--<![endif]--> <!-- 20200511 이용권번호 -->
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${payList }"	var="payment">
									
									<script>
									
										console.log("${payment.mb_id}" );
									</script>
									
									<tr>
										<td class="tc">${payment.payment_confm_no }</td>
										<%-- <td class="title pl10">
											<c:choose>
												<c:when test="${payment.cls_cd ne null}">
												${payment.cls_cd }
												</c:when>
												<c:otherwise>
													<a href="/admin/service/member/memberVoucherClsReg.do" title="이용권 구분 지정" data-width="440" data-height="455" data-pmt="&payment_seq=<c:out value='${payment.payment_seq}'/>"  class="winNewPop modal">지정</a>
												</c:otherwise>
											</c:choose>
										</td> --%>
										<td class="tc">
											<fmt:parseDate var="dateString" value="${payment.payment_dttm }" pattern="yyyy-MM-ddHH:mm:ss" />
											<fmt:formatDate value="${dateString}" pattern="yyyy-MM-dd HH:mm" />	
										</td>
										<td class="title pl10">${payment.method_cd }</td>
										<td class="tr pr10">
											<fmt:formatNumber pattern="#,###" value="${payment.tot_amt }"></fmt:formatNumber>
										</td>
										<!--[if gt IE 8]><!--><td class="mhid tc">
											<c:choose>
			                                    <c:when test="${payment.payment_stus_cd=='BIS_002'}">
			                                    	<a href="/moveRefundPop.do" class="winNewPop modal" title="환불처리" data-width="450" data-height="588"
			                                    	data-pmt="&viewFlg=view&paymentSeq=${payment.payment_seq}&paymentDttm=${payment.payment_dttm}&usrMainId=${payment.mb_id}">
				                                    	${payment.stus_cd }
			                                    	</a>
			                                    	
			                                    </c:when>
			                                    <c:when test="${payment.payment_stus_cd=='BIS_003'}">
			                                    	<a href="/moveCancelPop.do" class="winNewPop modal" title="결제취소" data-width="450" data-height="447"
			                                    	data-pmt="&viewFlg=view&paymentSeq=${payment.payment_seq}&paymentDttm=${payment.payment_dttm}&usrMainId=${payment.mb_id}">
				                                    	${payment.stus_cd }
			                                    	</a>
			                                    </c:when>
			                                    <c:otherwise>
			                                    	${payment.stus_cd }
			                                    </c:otherwise>
		                                    </c:choose>
										</td><!--<![endif]-->
										
										<td class="tr pr10"><!-- 20200511 이용권번호 -->
 
		<c:choose>
		    <c:when test="${payment.payment_stus_cd=='BIS_001' && payment.cls_cd=='초과요금' }">										
					 <a href="javascript:canclePayment( '${payment.payment_seq}', '${payment.payment_dttm}' , '${payment.mb_id}');" class="myButton">결제취소</a> 
		 	</c:when>
		</c:choose>	
							
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
							<input type="hidden" name="usr_seq"	id="usr_seq" value="${info.usr_seq }" >
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
