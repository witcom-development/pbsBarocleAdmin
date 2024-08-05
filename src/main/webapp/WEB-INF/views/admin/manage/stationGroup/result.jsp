<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script type="text/javascript" src="<c:url value="/js/jquery-1.11.2.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/jquery-ui-1.11.4/jquery-ui.js" />"></script>
<script type="text/javascript">

$(function() {
	
	alert("${rtMsg }");
	
	document.location = "/admin/manage/stationGroup/stationGroupList.do";
	 
});

	
</script>
<title>관리자</title>
</head>

<body>

</body>
</html>