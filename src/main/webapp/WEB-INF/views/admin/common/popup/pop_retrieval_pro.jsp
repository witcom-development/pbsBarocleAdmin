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
	                        <th>회수 일자</th>
	                        <td><span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" name="rtrvlDate"  title="선택 날짜" id="bb22" readonly/></span></td>
	                    </tr>
                    <tr>
                        <th>회수자</th>
                        <td>
                        	<input type="text" name="rtrvlNm">
						</td>
                    </tr>
                     <tr>
                        <th>회수장소</th>
                        <td>
                        	<input type="text" style="width: 92%;" name="rtrvlPlace">
						</td>
                    </tr>
                  	
                    <tr>
                        <th>회수경위</th>
                        <td>
                        	 <select class="select-category02" name="rtrvlCd">
                                    <option value="">선택</option>
                                    <option value="1">시민 신고</option>
                                    <option value="2">배송팀 발견</option>
                                    <option value="3">정상 대기중</option>
                                    <option value="4">대여중</option>
                                    <option value="5">수리중</option>
                                    <option value="6">기타</option>
                             </select>
						</td>
                    </tr>
                    <tr>
                        <th>메모</th>
                        <td>
                        	<textarea rows="10" cols="37" name="rtrvlDetail"></textarea>
						</td>
                    </tr>
	                </tbody>
	            </table>
            </form>
            <div id="resultTxt"></div>
            <div class="btnArea">
                <span class="right">
	                <button class="btnType01" id="rtrvlBtn">저장</button>
	                <button class="btnType01" id="cancelBtn">취소</button>
                </span>
            </div>
        </div>
    </div>
    <a href="#" class="popclose"><img src="/images/btn_close.png" alt="팝업닫기" /></a>
    <script type="text/javascript" src="/js/common_barocle.js"></script>
    <script type="text/javascript">
    $(function() {
    	$(".popTt").text("회수(콜센터용)");
    	
    	var today = DateUtil.dateFmt(new Date());
    	$("[name='rtrvlDate']").val(today);
    	
    	$("#rtrvlBtn").on("click",bikeRtrvlExe);
    	$("#cancelBtn").on("click", function(e) {
    		e.preventDefault();
    		window.close();
    	});
    });
    function bikeRtrvlExe(e) {
    	e.preventDefault();
    	
    	/* console.log("rentBikeNo = "+$("input[name='rentBikeNo']").val());
    	console.log("rentBikeId = "+$("input[name='rentBikeId']").val());
    	console.log("rtrvlDate = "+$("input[name='rtrvlDate']").val());
    	console.log("rtrvlNm = "+$("input[name='rtrvlNm']").val());
    	console.log("rtrvlPlace = "+$("input[name='rtrvlPlace']").val());
    	console.log("rtrvlCd = "+$("select[name='rtrvlCd']").val());
    	console.log("rtrvlDetail = "+$("textarea[name='rtrvlDetail']").val()); */
    	
    	
    	if($("input[name='rtrvlNm']").val() == null || $("input[name='rtrvlNm']").val() ==''){
    		alert("회수자를 입력해 주세요.");
    		$("input[name='rtrvlNm']").focus();
    		return false;
    	}
    	
    	if($("input[name='rtrvlPlace']").val() == null || $("input[name='rtrvlPlace']").val() ==''){
    		alert("회수장소를 입력해 주세요.");
    		$("input[name='rtrvlPlace']").focus();
    		return false;
    	}
    	
    	if($("select[name='rtrvlCd']").val() == null || $("select[name='rtrvlCd']").val() ==''){
    		alert("회수경위를 선택해 주세요.");
    		return false;
    	}
    	
    	
    	var ans = confirm("자전거No [${info.rentBikeNo}]를 회수 등록 하시겠습니까?");
    	 if(ans) {
		    	    commonAjax.postAjax("/common/pop/exeBikeRtrvl.do", "json", $("#frm").serialize()
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