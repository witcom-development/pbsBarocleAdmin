<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
			<input type="hidden" name="couponNo" value="${couponNo}">
			<input type="hidden" name="paymentSeq" value="${refundVO.paymentSeq}">
			<input type="hidden" name="paymentDttm" value="${refundVO.paymentDttm}">
			<input type="hidden" name="useYn" id="useYn" value="${refundVO.useYn}">
			<input type="hidden" name="paymentClsCd" id="paymentClsCd" value="${paymentClsCd}">
			<input type="hidden" name="mileagePaymentAmt" id="mileagePaymentAmt" value="${refundVO.mileagePaymentAmt}">
			<input type="hidden" name="usrSeq" id="usrSeq" value="${refundVO.usrSeq}">
<%-- 			<c:if test="${refundVO.paymentStusCd ne null }">
			<input type="text" name="paymentStusCd" id="paymentStusCd" value="${refundVO.paymentStusCd}">
			</c:if> --%>
			
			
	        <div class="allwrap pop">
				<table class="tb_type02 mt20">
					<colgroup>
						<col style="width:30%">
						<col style="width:70%">
					</colgroup>
					<tbody>
						<tr>
							<th class="top">아이디</th>
							<td class="top" name="usrMainId">${refundVO.usrMainId}</td>
						</tr>
						<tr>
							<th>이용권 사용 유무</th>
							<td name="usrMainId">
								<c:if test="${refundVO.useYn == 'Y'}">
									사용
								</c:if>	
								<c:if test="${refundVO.useYn == 'N'}">
									미사용
								</c:if>	
							</td>
						</tr>
						<tr>
							<th>취소가능 여부</th>
							<td name="usrMainId">
								<c:if test="${refundVO.useYn == 'Y'}">
									가능
								</c:if>	
								<c:if test="${refundVO.useYn == 'N'}">
									불가
								</c:if>	
							</td>
						</tr>
						<tr>
							<th>환불계좌정보</th>
							<td id="refundInfo">
							<!-- 2020-01-18 -->
							<span class="input-text01"><input class="tr onlyNumber" type="text" name="acnutNo" maxlength=20 value="${refundVO.acnutNo}" /></span>
							</td>
						</tr>
						<!-- 2020-01-18 -->
						<tr>
							<th>환불 은행</th>
							<td id="acnutBank">
								<input type="hidden" name="acnutBank" value="${refundVO.acnutBank}"/>
								<select class="searchType" id="bankList"  name="bankList"  >
    	        				</select>
							</td>
							
						</tr>
						<!-- 2020-01-18 -->
						<!-- 2020-01-18 -->
						<tr>
							<th>예금주명</th>
							<td id="acnutNm">
								<span class="input-text01"><input class="tr" type="text" name="acnutNm" maxlength=10 value="${refundVO.acnutNm}" /></span>
								<button class="btnType02" id="checkBtn">검증</button>
							</td>
						</tr>
						<!-- 2020-01-18 -->
						
						<tr>
							<th>환불예정금액<br>(마일리지)</th>
							<td><span class="input-text01" id="tempAmt">${refundVO.refndAmt}</span></td>
						</tr>
						
						<tr>
							<th>환불금액</th>
							<c:choose>
							<c:when test="${viewFlg != 'view'}">
							<td><span class="input-text01"><input class="tr onlyNumber" type="text" name="refundAmt" maxlength=10 value="0" /></span></td>
							</c:when>
							<c:otherwise>
                         	<td><span class="input-text01"><input class="tr onlyNumber" type="text" name="refundAmt" maxlength=10 value="${refundVO.refndAmt}" /></span></td>                            </c:otherwise>
							</c:choose>
						</tr>
						<tr>
							<th>수수료</th>
							<td><span class="input-text01"><input class="tr onlyNumber" type="text" name="refundComssnAmt" maxlength=10 value="${refundVO.refundComssnAmt}" /></span></td>
						</tr>
						<tr>
							<th>환불마일리지</th>
							<td><span class="input-text01"><input class="tr onlyNumber" type="text" name="mileageAmt" maxlength=10 value="0" /></span></td>
						</tr>
						<tr>
							<th>환불일자</th>
							<c:choose>
							<c:when test="${viewFlg != 'view'}">
							<td><span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" id="bb22" name="refundDttm" readonly/></span></td>
							</c:when>
							<c:otherwise>
                         	<td><span><input type="text" name="refundDttm" value="${refundVO.refundDttm}" style="width:65px" readonly /></span></td>                            </c:otherwise>
							</c:choose>
						</tr>
						
						<tr>
							<th>환불사유</th>
							<td><textarea class="detatextarea" maxlength=250 name="refundReason">${refundVO.refundReason}</textarea></td>
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
    	var today = DateUtil.dateFmt(new Date());
        var sDate = '${refundVO.refundDttm}' !== '' ? '${refundVO.refundDttm}' : today;
        var viewFlg = "${viewFlg}";
        var totAmt = "${refundVO.totAmt}";
        var paymentClsCd = "${paymentClsCd}";
        var paymentMethodCd = "${paymentMethodCd}";
        var refundAmt = "${refundVO.refndAmt}"; 
        $( "[name='refundDttm']").val(sDate);
            	
    	if(viewFlg == "view"){
    		$("[name=refundAmt]").val(refundAmt);
    		$("[name=refundAmt]").attr("readonly",true);
    		$("[name=refundComssnAmt]").attr("readonly",true);
    		$("[name=refundReason]").attr("readonly",true);
    		
    		$("th:eq(1)").hide();
    		$("th:eq(2)").hide();
    		$("td:eq(1)").hide();
    		$("td:eq(2)").hide();
    		$("tr:eq(1)").hide();
    		$("tr:eq(2)").hide();
    	} else {
    		$("[name=refundAmt]").attr("readonly",false);
    		$("[name=refundComssnAmt]").attr("readonly",false);
    		$("[name=refundReason]").attr("readonly",false);
    		$("[name=refundAmt]").val(refundAmt);
    	}
        
    	$("#cancelBtn").on("click", function(e){
    		e.preventDefault();
    		window.close();
    	});
    	 
    	//미사용권 환불 허용 20190312	
    	$("#saveBtn").on("click", saveRefund);
     
    	$("#checkBtn").on("click", checkRefndNumber); 
    		
    	
    });
     
   	// 2020-01-18
    commonAjax.getCommonCode("REFBNK", function(data){
		if(data !== null && data.codeList !== null) {
			
			var acnutBank = "${refundVO.acnutBank}";
			var selectedRow = 0;
			
			var selectedVal = "";
			
			for(var i = 0; i < data.codeList.length; i++){
				
				if ( acnutBank !== null && acnutBank == data.codeList[i].comCdName ) {
					// 계좌 확인용 코드로 변경
					selectedVal = data.codeList[i].addVal2; 
				}
				// 계좌 확인용 은행코드로 변경
				var $op = $("<option value='"+data.codeList[i].addVal2+"'>"+data.codeList[i].comCdName+"</option>").appendTo('[name="bankList"]');
			}
			
			$("#bankList" ).val(selectedVal);
		}
	});
     
   // 20210924
   function checkRefndNumber(e){
	   e.preventDefault();
	   // 은행코드 acnutBank 202109287444852
	   /* var acnutBank = "004";	// $("select[name=bankList]").val();
	   // 계조번호
	   var acnutNo = "4842020126";  // $("[name=acnutNo]").val();
	   // 이름  acnutNm
	   var acnutNm = "양재영";  // $("[name=acnutNm]").val(); */
	   
	   commonAjax.postAjax("/getCheckRefundNumAjax.do", "json",   $("#frm").serialize()
	    	,function(data){
		   
	    	     if(data) {
	    	    	 alert(data.resultMessage + " : "  + data.result );
	    	     } else {
	    	    	 alert("저장에 실패하였습니다 . : " + data.resultMessage);
	    	    	 return false;
	    	     }
	    	}
	    );
   }
    
    function saveRefund(e) {
    	e.preventDefault();
    	
    	var totAmt = "${refundVO.totAmt}";
    	var refundAmt = $("[name=refundAmt] option:selected").val();
    	
    	if(Number(refundAmt) > Number(totAmt)){
    		alert("환불금액이 결제된 금액 " + comma(totAmt) +"원을 초과합니다.\n확인 후 다시 입력하세요.");
    		return false;
    	}

    	var con = confirm("저장 하시겠습니까?");
    	
    	$("input[name=acnutBank]").val($("#bankList option:selected").text());
    	
    	if(con) {
	    	commonAjax.postAjax("/addRefund.do", "json", $("#frm").serialize()
	    		,function(data){
	    		     if(data) {
	    		    	 alert(data.resultMessage);
	    		    	 opener.changePaymentStus('${refundVO.paymentSeq}','BIS_004', '환불진행중', '${refundVO.paymentDttm}', '${refundVO.usrMainId}', data);
	    		    	 window.close();
	    		     } else {
	    		    	 alert("저장에 실패하였습니다 . : " + data.resultMessage);
	    		    	 return false;
	    		     }
	    		}
	    	);
    	} else {
    		
    	}
    };
    
  	//콤마찍기
    function comma(str) {
        str = String(str);
        return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
    };
  	//콤마풀기
    function uncomma(str) {
        str = String(str);
        return str.replace(/[^\d]+/g, '');
    };
    
  
    </script>
</body>
</html>
 