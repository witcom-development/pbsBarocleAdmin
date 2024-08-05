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
			<div class="allwrap pop">
				<table class="tb_type01 mt20">
	                <colgroup>
	                    <col style="width:5%"/>
	                    <col style="width:25%"/>
	                    <col style="width:25%"/>
	                </colgroup>
	                <thead>
	                    <tr>
	                        <th>번호</th>
	                        <th>입력번호</th>
	                        <th>입력시간</th>
	                    </tr>
	                </thead>
	                <tbody>
		                <c:forEach var="result" items="${mobileSmsAuthDetailList}" varStatus="status">
		                	<tr>
		                		<td style="text-align:center">${status.index }</td>
		                		<td style="text-align:center">${result.inputNo }</td>
		                		<td style="text-align:center">
		                			<c:set var="TextValue" value="${result.authDetRegDttm }"/>
						                ${fn:substring(TextValue,0,19) }
		                		</td>
		                	</tr>
		                </c:forEach>
	                </tbody>
	            </table>
				<div class="btnArea">
					<span class="right">
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
    	$("#cancelBtn").on("click", function(e){
    		e.preventDefault();
    		window.close();
    	});
    });
    </script>
</body>
</html>
