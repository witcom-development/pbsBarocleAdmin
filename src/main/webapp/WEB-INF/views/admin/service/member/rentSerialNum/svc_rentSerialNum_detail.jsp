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

<script type="text/javascript" src="/js/common_barocle.js"></script>
<script type="text/javascript">
	$(function() {
		$("#serialNoVoucherCancelBtn").on("click", function(e){
			e.preventDefault();
	    	e.stopPropagation();
	    	
	       	var popTitle 			= "이용권 만료";
	       	var viewFlg 			= $("input:hidden[name='viewFlg']").val();
	       	var serialNo			= $("input:hidden[name='serialNo']").val();
	       	var serialNoHistSeq		= $("input:hidden[name='serialNoHistSeq']").val();
	        var serialNoPaymentSeq 	= $("input:hidden[name='serialNoPaymentSeq']").val();
	        var serialNoVoucherSeq	= $("input:hidden[name='serialNoVoucherSeq']").val();
	        var serialNoUsrSeq		= $("input:hidden[name='serialNoUsrSeq']").val();
	        
	        var voucherCancelAbleYn = "${voucherCancelAbleYn}";
	        var rentOverFeePayYn = "${rentSerialNumDetailList.overFeePayYn}";
	        var paymentStusCd = "${rentSerialNumDetailList.paymentStusCd}";
	        var con = true;
	        
	        if(rentOverFeePayYn == "미결제"){
// 	        	 con = confirm("미납된 추가 과금이 존재합니다. \n이용권 만료를 계속 진행 하시겠습니까?");
				con = false;
				alert("미납된 추가 과금이 존재합니다.");
	        }
	        if(con){
	        	if(con && (paymentStusCd == "BIS_001" || paymentStusCd == "BIS_003")/*voucherCancelAbleYn == "Y"*/){
		        	if( $('body').find("#tempWinNewPop") !== undefined && $('body').find("#tempWinNewPop").length >0 ) {
				       	$('body').find("#tempWinNewPop").remove();
				    }
					
			       	var $a = null;
			       	$a = $("<a>", {'href' : '/admin/service/member/moveRentSerialNumCancelPop.do', 'title' : popTitle, 'data-width' :"450" ,'data-height' :"540", 'data-pmt' : '&viewFlg=' + viewFlg + '&serialNo=' + serialNo + '&serialNoHistSeq=' + serialNoHistSeq + '&serialNoPaymentSeq=' + serialNoPaymentSeq + '&serialNoVoucherSeq=' + serialNoVoucherSeq + '&serialNoUsrSeq=' + serialNoUsrSeq }).addClass("winNewPop modal");
			       	$a.attr("id","tempWinNewPop");
			       	$('body').first().append($a);
			           	$("#tempWinNewPop").trigger("click");
		        } else {
		        	//alert("이미 이용권 만료 상태 입니다.");
		        	con = false;
		        	
		        	if(paymentStusCd == "BIS_001"){
		        		con = confirm("이미 이용권 만료 상태 입니다. \n 환불 진행 하시겠습니까?");
		        	} else {
		        		con = true;
		        	}
		        	
		        	if(con){
		        		popTitle = "환불처리";
		        		var usrMainId 		= $("input:hidden[name='serialNo']").val();
		                var paymentSeq 		= $("input:hidden[name='serialNoPaymentSeq']").val();
		                var paymentDttm 	= $("input:hidden[name='paymentDttm']").val();
		                var paymentStusCd 	= $("input:hidden[name='chkPaymentStusCd']").val();
		                var totAmt 			= replaceAll($("input:hidden[name='totAmt']").val(), ",", "");
		                var useYn 			= $("input:hidden[name='useYn']").val();
		                var couponNo 		= "null";
		                var paymentMethodCd	= $("input:hidden[name='chkPaymentMethodCd']").val();//추가:계좌이체 결제취소 관련_2017.06.09_JHN
		        		var paymentClsCd	= $("input:hidden[name='chkPaymentClsCd']").val();
// 		                   alert(usrMainId+" "+paymentSeq+" "+paymentDttm+" "+paymentStusCd+" "+totAmt+" "+useYn+" "+paymentMethodCd+" "+paymentClsCd);
		        		if( $('body').find("#tempWinNewPop") !== undefined && $('body').find("#tempWinNewPop").length >0 ) {
		               		$('body').find("#tempWinNewPop").remove();
		               	}
		               	var $a = null;
		               	$a = $("<a>", {'href' : '/moveRefundPop.do', 'title' : popTitle, 'data-width' :"450" ,'data-height' :"640", 'data-pmt' : '&viewFlg=' + viewFlg + '&paymentSeq=' + paymentSeq + '&couponNo=' + couponNo + '&useYn=' + useYn + '&paymentDttm=' + paymentDttm + '&usrMainId=' + usrMainId + '&totAmt=' + totAmt + '&paymentMethodCd=' + paymentMethodCd + '&paymentClsCd=' + paymentClsCd}).addClass("winNewPop modal");
		               	$a.attr("id","tempWinNewPop");
		                $('body').first().append($a);
		                $("#tempWinNewPop").trigger("click");
		        	}
		        }
	        }
		});
	});
	function fn_list(){

		$("#frm").attr("action","/admin/service/member/rentSerialNum.do");
		$("#frm").submit();
	}
	function fn_MemberDetail(seq){
		$("#usr_seq").val(seq);
		
		$("#frm").attr("action", "/admin/service/member/memberInfo.do");

		$("#frm").submit();
	}
	function replaceAll(str, searchStr, replaceStr) {
    	return str.split(searchStr).join(replaceStr);
    };
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
				<form  method="post" name="frm"	id="frm">
					<input type="hidden" name="searchStartDate"  	id="searchStartDate"		value="${searchParam.searchStartDate}"/>
					<input type="hidden" name="searchEndDate" 	 	id="searchEndDate"			value="${searchParam.searchEndDate}"/>
					<input type="hidden" name="page"			 	id="page"					value="${searchParam.pageNo}"/>
					<input type="hidden" name="searchParameter"	 	id="searchParameter"		value="${searchParam.searchParameter}"/>
					<input type="hidden" name="searchParameter2" 	id="searchParameter2"		value="${searchParam.searchParameter2}"/>
					<input type="hidden" name="searchValue"		 	id="searchValue"			value="${searchParam.searchValue}"/>
					<input type="hidden" name="viewFlg"			 	id="viewFlg"				value="${rentSerialNumDetailList.viewFlg}">
					<input type="hidden" name="serialNoPaymentSeq"	id="serialNoPaymentSeq" 	value="${rentSerialNumDetailList.serialNoPaymentSeq}"/>
					<input type="hidden" name="serialNoVoucherSeq"	id="serialNoVoucherSeq"		value="${rentSerialNumDetailList.serialNoVoucherSeq}"/>
					<input type="hidden" name="serialNoUsrSeq"		id="serialNoUsrSeq"			value="${rentSerialNumDetailList.serialNoUsrSeq}"/>
					<input type="hidden" name="serialNo"			id="serialNo"				value="${rentSerialNumDetailList.serialNo}"/>
					<input type="hidden" name="serialNoHistSeq"		id="serialNoHistSeq"		value="${rentSerialNumDetailList.serialNoHistSeq}"/>
					<input type="hidden" name="paymentDttm"			id="paymentDttm"			value="${rentSerialNumDetailList.paymentDttm}"/>
					<input type="hidden" name="chkPaymentStusCd"	id="chkPaymentStusCd"		value="${rentSerialNumDetailList.paymentStusCd}"/>
					<input type="hidden" name="totAmt"				id="totAmt"					value="${rentSerialNumDetailList.payTotAmt}"/>
					<input type="hidden" name="useYn"				id="useYn"					value="${rentSerialNumDetailList.voucherUseYnFlg}"/>
					<input type="hidden" name="chkPaymentMethodCd"	id="chkPaymentMethodCd"		value="${rentSerialNumDetailList.paymentMethodCd}"/>
					<input type="hidden" name="chkPaymentClsCd"		id="chkPaymentClsCd"		value="${rentSerialNumDetailList.paymentClsCd}"/>
				
				<div class="content">
					<div class="subject">
						<!--subject path S-->
							<tiles:insertAttribute name="subject" />
						<!--subject path E-->
					</div>
					<div class="page">
						<table class="tb_type02 mt20">
<!-- 						<table class="tb_type01"> -->
								<colgroup>
									<col style="width:30%" />
									<col style="width:70%" />
								</colgroup>
							<tbody>
							
<%-- 								<c:forEach var="result" items="${returnList }" varStatus="status"> --%>
									<tr>
										<th>대여일련번호</th>
<%-- 										<td>${result.usrId }</td> --%>
										<td class="title"><!-- a href="#" onclick="fn_MemberDetail('${rentSerialNumDetailList.serialNoUsrSeq }'); return false;"> -->${rentSerialNumDetailList.serialNo }</a></td>
									</tr>
									<tr>
										<th>결제수단</th>
										<td>${rentSerialNumDetailList.payMethodType }</td>
									</tr>
									<tr>
										<th>결제수단 번호</th>
										<td>
										${rentSerialNumDetailList.payMethodNo}
										</td>
									</tr>
									<tr>
										<th>이용권</th>
										<td>
											${rentSerialNumDetailList.voucherType}
										</td>
									</tr>
									<tr>
										<th>결제일시</th>
										<td>${rentSerialNumDetailList.paymentDttm }</td>
									</tr>
									<tr>
										<th>이용권 시작일</th>
										<td>${rentSerialNumDetailList.voucherStrDttm }</td>
									</tr>
									<tr>
										<th>이용권 종료일</th>
										<td>${rentSerialNumDetailList.voucherEndDttm }</td>
									</tr>
									<tr>
										<th>결제금액</th>
										<td>${rentSerialNumDetailList.payTotAmt }</td>
									</tr>
 									<tr>
 										<th>연락처</th>
 										<td>${rentSerialNumDetailList.smsRecvAgreeYn }</td>
 									</tr>
									<tr>
										<th>추가 과금 수단</th>
										<td>${rentSerialNumDetailList.overPayMethodType }</td>
									</tr>
									<tr>
										<th>미납금액</th>
										<td>${rentSerialNumDetailList.overFee }</td>
									</tr>
									<tr>
										<th>추가 과금 결제 여부</th>
										<td>${rentSerialNumDetailList.overFeePayYn }</td>
									</tr>
<%-- 								</c:forEach> --%>
							</tbody>
						</table>
						<div class="btnArea">
							<span class="left" onclick="fn_list(); return false;"><button class="btnType01 bc_gray">목록</button></span>
							<span class="right"><button class="btnType01" type="button" id="serialNoVoucherCancelBtn">이용권 만료</button></span>
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
