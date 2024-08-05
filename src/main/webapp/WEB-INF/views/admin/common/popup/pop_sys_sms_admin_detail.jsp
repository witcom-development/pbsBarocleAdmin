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
<%@ include file="../popup/pop_resource.jsp" %>

<!-- 
	개발일시 : 2020-10-05
	개발자   : 김시성
	내용     : 관리자 문자 발송 상세 오류 건 팝업
	TODO : 
	ASIS : 오류 건 보여주기
	       
 -->
</head>
<body>
    <h1 class="popTt">전송오류 건</h1>
    <div class="cntbox">
        <div class="allwrap pop">
        	
        	<div id="sendErrorTag">
        		
        	</div>
        	
        </div>
    </div>
    <a href="#" class="popclose"><img src="/images/btn_close.png" alt="팝업닫기" /></a>
    <script type="text/javascript" src="/js/common_barocle.js"></script>
    <script type="text/javascript">
    $(function() {
    	
    	$(".popTt").html("");
    	$(".popTt").append("전송오류 건[ 수신대상(전화번호) : 오류코드 ]");
    	
    		
    	opener.pushData();
    		
    })
    </script>
</body>
</html>
