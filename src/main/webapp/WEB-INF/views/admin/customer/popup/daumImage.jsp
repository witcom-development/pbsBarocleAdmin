<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>DAUM - 이미지 업로드</title> 
<script type="text/javascript" src="<c:out value='/daumeditor/js/popup.js'/>" charset="utf-8"></script>
<script type="text/javascript" src="<c:out value='/js/jquery-1.11.2.min.js'/>" charset="utf-8"></script>
<script type="text/javascript" src="<c:out value='/daumeditor/pages/trex/jquery.form.js'/>" charset="utf-8"></script>
<link rel="stylesheet" href="<c:out value='/daumeditor/css/popup.css'/>" type="text/css"  charset="utf-8"/>
<script type="text/javascript">
//<![CDATA[
	var currentPageName = PopupUtil.getOpener().currentPageName;
	/* alert(currentPageName); */
	if(currentPageName==undefined||currentPageName==''){ closeWindow(); }
	var actionLocation = "<c:out value='${pageURL}'/>" + currentPageName;
	$(function(){
		$("#saveBtn").click(function(){ $("#frm").attr({action:actionLocation,mehtod:'post',encType:'multipart/form-data'}).submit(); });
	    $("#frm").ajaxForm({
	        beforeSubmit: function (data,form,option) { return true; },
	        success: function(response,status){ done(response); },
	        error: function(){ alert("파일을 첨부하는데 오류가 발생하였습니다."); }                               
	    });
	})
	function done(response) {
	    if (typeof(execAttach) == 'undefined') { return; }
	    var response_object = $.parseJSON(response);
	    execAttach(response_object);
	    closeWindow();
	}
	function initUploader(){
	    var _opener = PopupUtil.getOpener();
	    if (!_opener) { alert('잘못된 경로로 접근하셨습니다.'); return; }
	    var _attacher = getAttacher('image', _opener);
	    registerAction(_attacher);
	}
//]]>
</script>
</head>
<body onload="initUploader();">

	<div class="wrapper">
	    <div class="header">
	        <h1>사진 첨부</h1>
	    </div>    
	    <div class="body">
	        <dl class="alert">
	            <dt>사진 첨부 확인 중</dt>
	            <dd>
	            <form id="frm" action="/daumeditorFileUploadPersist.do" method="post" encType="multipart/form-data">
	                <input type="file" name="fileName"/>
	            </form>
	            </dd>
	        </dl>
	    </div>
	    <div class="footer">
	        <ul>
	            <li class="submit"><a href="#" id="saveBtn" title="등록" class="btnlink">등록</a>&nbsp;</li>
	            <li class="cancel"><a href="#" onclick="closeWindow();" title="취소" class="btnlink">취소</a></li>
	        </ul>
	    </div>
	</div>

</body>
</html>