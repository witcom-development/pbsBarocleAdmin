<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%
//request.setCharacterEncoding("UTF-8"); //한글깨지면주석제거
//request.setCharacterEncoding("EUC-KR"); //해당시스템의인코딩타입이EUC-KR일경우에
String inputYn = request.getParameter("inputYn");
String roadFullAddr = request.getParameter("roadFullAddr");
String roadAddrPart1 = request.getParameter("roadAddrPart1");
String roadAddrPart2 = request.getParameter("roadAddrPart2");
String engAddr = request.getParameter("engAddr");
String jibunAddr = request.getParameter("jibunAddr");
String zipNo = request.getParameter("zipNo");
String addrDetail = request.getParameter("addrDetail");
String admCd = request.getParameter("admCd");
String rnMgtSn = request.getParameter("rnMgtSn");
String bdMgtSn = request.getParameter("bdMgtSn");
%>
</head>
<script src="/js/jquery-1.11.2.min.js"></script>
<script language="javascript"> 
function init(){
	try {
		
		var url = location.href;
		var confmKey = '<c:out value="${juso.jusoKey}"/>';
		var inputYn= "<%=inputYn%>";
		if(inputYn != "Y"){
            $('#confmKey').val(confmKey);
            $('#returnUrl').val(url);
            $("#frm").attr("action", '<c:out value="${juso.jusoPublicZone}"/>'); //인터넷망
            //$("#frm").attr("action", '<c:out value="${juso.jusoPrivateZone}"/>'); //내부행망
            $("#frm").submit();
		}else{
		opener.jusoCallBack("<%=roadFullAddr%>","<%=roadAddrPart1%>","<%=addrDetail%>","<%=roadAddrPart2%>","<%=engAddr%>","<%=jibunAddr%>","<%=zipNo%>", "<%=admCd%>", "<%=rnMgtSn%>", "<%=bdMgtSn%>");
		window.close();
		}
	} catch (e) {
		alert(e)
		// TODO: handle exception
	}
}
</script>
<body onload="init();">
<form id="frm" name="frm" method="post">
<input type="hidden" id="confmKey" name="confmKey" value=""/>
<input type="hidden" id="returnUrl" name="returnUrl" value=""/>
<!--해당시스템의인코딩타입이EUC-KR일경우에만추가START-->
<!--
<input type="hidden" id="encodingType" name="encodingType" value="EUC-KR"/>
-->
<!--해당시스템의인코딩타입이EUC-KR일경우에만추가END-->
</form>
</body>
</html>