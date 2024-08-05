<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
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
        <div class="allwrap pop">
            <form id="frm">
            	<input type="hidden" name="rentBikeNo" value="${info.rentBikeNo}">
            	<input type="hidden" name="rentBikeId" value="${info.rentBikeId}">
                <input type="hidden" name="adminId" value="${adminId}">
                <%-- <input type="hidden" name="terminalId" value="${bikeInfo.terminalId }">
                <input type="hidden" name="bikeStatusCd" value="BKS_007">
                <input type="hidden" name="lostYn" value="Y">
                <input type="hidden" name="chkType" value="${bikeInfo.chkType}"> --%>
            
	            <table class="tb_type02 mt20">
	                <colgroup>
	                    <col style="width:25%">
	                    <col style="width:75%">
	                </colgroup>
	                <tbody>
	                    <tr>
	                        <th class="top">자전거 번호</th>
	                        <td class="top">
	                        	${info.rentBikeNo}
	                        </td>
	                    </tr>
	                    <tr>
	                        <th>신고일</th>
	                        <td><span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" name="reportDate"  title="선택 날짜" id="bb22" readonly/></span></td>
	                    </tr>
	                <tr>
                        <th>신고구분</th>
                        <td>
                        	<select name="reportCd">
                        		<option value="1">직원</option>
                        		<option value="2">시민</option>
                       		</select> </td>
                    </tr>
                    <%-- <tr>
                        <th>센터</th>
                        <td>
                        	<select class="select-category02" name="manageCenter" id="centerId">
                                <option value="">선택</option>
                             <c:forEach var="result" items="${codeList}" varStatus="status">
									<option value="${result.comCd}" ><c:out value="${result.comCdName}"/></option>
							</c:forEach>
                             </select> 
                        </td>
                    </tr> --%>
                    <tr>
                        <th>신고자</th>
                        <td>
                        	<input type="text" name="reportNm">
						</td>
                    </tr>
                  	
                  	 <tr>
                        <th>연락처</th>
                        <td>
                        	<input type="text" name="reportPno" placeholder="ex) xxx-xxxx-xxxx">
						</td>
                    </tr>
                  	
                    <tr>
                        <th>신고내용</th>
                        <td>
                        	<textarea rows="15" cols="37" name="reportDetail"></textarea>
						</td>
                    </tr>
	                </tbody>
	            </table>
            </form>
            <div id="resultTxt"></div>
            <div class="btnArea">
                <span class="right">
	                <button class="btnType01" id="robbedBtn">저장</button>
	                <button class="btnType01" id="cancelBtn">취소</button>
                </span>
            </div>
        </div>
    </div>
    <a href="#" class="popclose"><img src="/images/btn_close.png" alt="팝업닫기" /></a>
    <script type="text/javascript" src="/js/common_barocle.js"></script>
    <script type="text/javascript">
    $(function() {
    	$(".popTt").text("도난추정(콜센터용)");
    	
    	var today = DateUtil.dateFmt(new Date());
    	$("[name='reportDate']").val(today);
    	
    	$("#robbedBtn").on("click",bikeRobbedExe);
    	$("#cancelBtn").on("click", function(e) {
    		e.preventDefault();
    		window.close();
    	});
    });
    function bikeRobbedExe(e) {
    	e.preventDefault();
    	
    	/* console.log("rentBikeNo = "+$("input[name='rentBikeNo']").val());
    	console.log("rentBikeId = "+$("input[name='rentBikeId']").val());
    	console.log("reportDate = "+$("input[name='reportDate']").val());
    	console.log("reportCd = "+$("select[name='reportCd']").val());
    	console.log("reportNm = "+$("input[name='reportNm']").val());
    	console.log("reportPno = "+$("input[name='reportPno']").val());
    	console.log("reportDetail = "+$("[name='reportDetail']").val()); */
    	
    	
    	if($("input[name='reportNm']").val() == null || $("input[name='reportNm']").val() ==''){
    		alert("신고자를 입력해 주세요.");
    		$("input[name='reportNm']").focus();
    		return false;
    	}
    	
    	if($("input[name='reportPno']").val() == null || $("input[name='reportPno']").val() ==''){
    		alert("연락처를 입력해 주세요.");
    		$("input[name='reportPno']").focus();
    		return false;
    	}
    	
    	var regRule = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$/;
    	if(!regRule.test($("input[name='reportPno']").val())) {
    		alert("연락처를 다시 확인해 주세요.");
    		$("input[name='reportPno']").focus();
    	    return false;
    	}
    	
    	if($("textarea[name='reportDetail']").val() == null || $("textarea[name='reportDetail']").val() ==''){
    		alert("신고내용을 입력해 주세요.");
    		$("textarea[name='reportDetail']").focus();
    		return false;
    	}
    	
    	var ans = confirm("자전거No [${info.rentBikeNo}]를 도난추정으로 등록 하시겠습니까?");
    	 if(ans) {
		    		commonAjax.postAjax("/common/pop/exeBikeRobbed.do", "json", $("#frm").serialize()
		    		,function(data){
		    		   if(data.checkResult > 0) {
		    			   alert(data.resultMessage);
		    			   window.close();
		    		   }
		    		}
		    	);
	      }
    }
    </script>
    
</body>
</html>