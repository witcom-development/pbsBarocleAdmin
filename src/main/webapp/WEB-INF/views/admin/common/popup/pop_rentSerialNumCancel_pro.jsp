<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" /> 
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />
<meta name="description=" Content="" />
<%@ include file="../popup/pop_resource.jsp" %>
</head>
<body>
	<h1 class="popTt"></h1>
	<div class="cntbox">
	<form id="frm">
			<input type="hidden" name="viewFlg" value="${viewFlg}">
			<input type="hidden" name="couponNo" value="">
			<input type="hidden" name="paymentSeq" value="${rentSerialNumVO.serialNoPaymentSeq}">
			<input type="hidden" name="paymentDttm" value="${rentSerialNumVO.paymentDttm}">
			<input type="hidden" name="useYn" value="${rentSerialNumVO.voucherUseYn}">
			<input type="hidden" name="cancelAdminId" value="${userSessionVO.usrId}">
			
			<div class="allwrap pop">
				<table class="tb_type02 mt20">
					<colgroup>
						<col style="width:30%">
						<col style="width:70%">
					</colgroup>
					<tbody>
						<tr>
							<th class="top">대여일련번호</th>
							<td class="top">${rentSerialNumVO.serialNo}</td>
						</tr>
						<tr>
							<th>만료처리자ID</th>
							<td>
								<c:choose>
									<c:when test="${rentSerialNumVO.cancelAdminId eq '' }">
										${userSessionVO.usrId}
									</c:when>
									<c:otherwise>
										${rentSerialNumVO.cancelAdminId}
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
						<tr>
							<th>비고</th>
							<td><textarea class="detatextarea" maxlength=250 name="cancelReasonDesc">${rentSerialNumVO.cancelReasonDesc}</textarea></td>
						</tr>
					</tbody>
				</table>
				<div class="btnArea">
					<span class="right">
					<c:if test="${viewFlg != 'view'}">
						<button class="btnType01" id="saveBtn">저장</button>
					</c:if>
						<button class="btnType01" id="cancelBtn">취소</button>
					</span>
				</div>
			</div>
		</form>
	</div>
	<a href="#" class="popclose"><img src="/images/btn_close.png" alt="팝업닫기" /></a>
	<script type="text/javascript" src="/js/common_barocle.js"></script>
	<script type="text/javascript">
    $(function() {
    	var viewFlg = "${viewFlg}";
    	
    	if(viewFlg == "view"){
    		$("[name=cancelReasonDesc]").attr("readonly",true);
    	} else {
    		$("[name=cancelReasonDesc]").attr("readonly",false);
    	}
    	
    	$("#cancelBtn").on("click", function(e){
    		e.preventDefault();
    		window.close();
    	});
    	
    	$("#saveBtn").on("click", saveRefund);
    });
    
    function saveRefund(e) {
    	
    	e.preventDefault();
   		$.ajax({
				type		: 'post',
				url			: '/setPaymentCancel.do', //이용권이 생성되어 있어야 하고, 이용권이 오픈되지 않고, 대여 이력도 없어야 함.
				dataType	: 'json',
				data		: $("#frm").serialize(),
				//async		: false,
				beforeSend	: function () {
					$("[name=cancelReasonDesc]").attr("readonly",true);  
					postAjaxLoading();
		       	}
		       	, complete		: function () {
		                     $("#div_ajax_load_image").hide();
		       	}
				, success		: function( data ) {
	    		     if(data) {
	    		    	 //alert(data.resultMessage);
	    		    	 /* var con = false;
	    		    	 var rentOverFeePayYn = "${rentSerialNumVO.overFeePayYn}";
	    		    	 if(rentOverFeePayYn == "미결제"){
	    		    		 con = confirm("추가과금 미결제 고객 입니다. \n추가 과금 결제 상태를 강제 처리 하시겠습니까?");
	    		    	 } */
	    		    	 if(data.resultMessage == "결제취소가 완료되지 않았습니다." || data.resultMessage == "사용이력이 존재합니다"){
	    		    		 var con = false;
	    		    		 if(data.resultMessage == "사용이력이 존재합니다"){
	    		    			 con = confirm("결제 취소가 정상적으로 이루어졌습니다.\n"+data.resultMessage + " 이용권 만료 하시겠습니까?");
	    		    		 } else {
	    		    			 con = confirm(data.resultMessage + "\n이용권 만료 하시겠습니까?"); 
	    		    		 }
	    		    		 
	    		    		 if(con){
	    		    			 $.ajax({
	    		 					type		: 'post',
	    		 					url			: '/admin/service/member/rentSerialNumVoucherExpiry.do',
	    		 					dataType	: 'json',
	    		 					data		: $("#frm").serialize(),
	    		 					//async		: false,
	    		 					beforeSend	: function () {
	    		 						$("[name=cancelReasonDesc]").attr("readonly",true);  
	    		 						postAjaxLoading();
	    		 			       	}
	    		 			       	, complete		: function () {
										$("#div_ajax_load_image").hide();
	    		 			       	}
	    		 			       	, success		: function( data ) {
	    		 			       		$("[name=cancelReasonDesc]").attr("readonly",true);
   		    							$("#saveBtn").hide();
   		    							alert("정상적으로 이용권 만료 처리 되었습니다.");
   		    							opener.parent.location.reload();
	    		 			       	}
	    		 			       	, error			: function(request, status, error){
	    		 			       		$("[name=cancelReasonDesc]").attr("readonly",false);
	    		 			       		alert("이용권 만료가 정상 처리되지 않았습니다. \n다시 시도 해주십시오.");
	    		 			       		//alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	    		 			       	}
	    		    			 });
	    		    		 } else {
	    		    			 $("[name=cancelReasonDesc]").attr("readonly",false);
	    		    		 }
	    		    	 } else {
	    		    		 $("[name=cancelReasonDesc]").attr("readonly",true);
    						 $("#saveBtn").hide();
    						 alert("결제 취소가 정상적으로 이루어졌습니다.");
    						 opener.parent.location.reload();
	    		    	 }
	    		     } else {
	    		    	 //alert(data.resultMessage);
	    		    	 return false;
	    		     }
	    		  }
			 }
    	);
    };
    function postAjaxLoading() {
    	var width = 0;
         var height = 0;
         var left = 0;
         var top = 0;
         
         width = 50;
         height = 50;
           
         top = ( $(window).height() - height ) / 2 + $(window).scrollTop();
         left = ( $(window).width() - width ) / 2 + $(window).scrollLeft();
           
         if($("#div_ajax_load_image").length != 0) {
                $("#div_ajax_load_image").css({
                       "top": top+"px",
                       "left": left+"px"
                });
                $("#div_ajax_load_image").show();
         } else {
                  $('body').append('<div id="div_ajax_load_image" style="position:absolute; top:' + top + 'px; left:' + left + 'px; width:' + width + 'px; height:' + height + 'px; z-index:9999; background:#f0f0f0; filter:alpha(opacity=50); opacity:alpha*0.5; margin:auto; padding:0; "><img src="/images/ajax_loader3.gif" style="width:50px; height:50px;"></div>');
         }
    }
    </script>
</body>
</html>
