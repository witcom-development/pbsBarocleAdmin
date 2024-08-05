<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
    request.setCharacterEncoding("euc-kr"); //따라서 setCharacterEncoding("euc-kr"); 를 사용해 문자열을 인코딩해줘야 된다. 
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" /> 
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no"  />
<meta name="description=" Content="" />
<%@ include file="../popup/pop_resource.jsp" %>
</head>
<body>
    <h1 class="popTt"></h1>
    <div class="cntbox">
        <div class="allwrap pop">
            <select class="shortselect" style="width:100%" name="deadline" size="2">
            	<option value="14일 "> 14일 (답변기한일로부터 7일 연장) </option>
            </select>
            <div class="btnArea">
				<span class="right">
					<button id="confirmBtn" class="btnType01">확인</button>
					<button id="cancelBtn" class="btnType01">취소</button>
				</span>
			</div>
        </div>
    </div>
    <a href="#" class="popclose"><img src="/images/btn_close.png" alt="팝업닫기" /></a>
    <script type="text/javascript" src="/js/common_barocle.js" charset="utf-8" ></script>
    <script type="text/javascript">
    $(function() {
    	//$('#searchBtn').on("click", getDeadline);
    	$("#confirmBtn").on("click", function(e) {
    	    e.preventDefault();
    	    var deadline = $('[name="deadline"]').val();
    	    //var extendCnt = '${extendCnt}';
    	    var qnaSeq = '${qnaSeq}';
            
            opener.setDeadline(deadline, qnaSeq);
            window.close();
    	});
    	
    	$("#cancelBtn").on("click", function(e) {
    		e.preventDefault();
    		window.close();
    	});
    });
    
    </script>
</body>
</html>