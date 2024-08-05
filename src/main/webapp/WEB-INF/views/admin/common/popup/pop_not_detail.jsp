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
	<h1 class="popTtl"><c:out value="${popupView.noticeTitle}" /></h1>
	<div class="cntbox"><c:out value="${popupView.noticeHTMLContent}" escapeXml="false" /></div>
	<div id="todaypopup">하루동안 이 창을 열지 않음&nbsp;<input type="checkbox" name="todayClose" value="todayCloseFin" onclick="javascript:closePop();"/></div>
	<a href="#" class="popclose"><img src="/images/btn_close.png" alt="팝업닫기" /></a>

	<script>
	function closePop(){
		opener.setCookie('<c:out value='${noticeVO.noticeSeq}'/>');
		window.close();
	}
	</script>
</body>