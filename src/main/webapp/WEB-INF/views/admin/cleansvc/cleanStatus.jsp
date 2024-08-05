<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />
<meta name="description=" Content="" />
<title><tiles:insertAttribute name="title"/></title>
<tiles:insertAttribute name="resource"/>
</head>
<body>
<!-- solbit test-테스트 페이지  S   -->
    <div class="allwrap">
        <!--모바일 메뉴 S-->
        <tiles:insertAttribute name="header" />
        <!--모바일 메뉴 E-->
        <!--Head S-->
        <tiles:insertAttribute name="head" />
        <!--Head E-->
        <div id="body">
            <div class="cont">
                <!--left menu S-->
                <tiles:insertAttribute name="left"  />
                <!--left menu E-->
                <!--conteent S-->
                <div class="content">
                    <div class="subject">
                        <!--subject path S-->
						<tiles:insertAttribute name="subject" />
                        <!--subject path E-->
                    </div>
                    <div class="page">
                        <!-- 모바일 검색조건 S-->
                        <!-- 모바일 검색조건 E-->
                       	<!-- 검색조건  S -->
                       	<form id="searchFrm">
                       	<input type="hidden" name="clean_type" value="">
                       	
                       	
                       		<!--  -->
                       		<!--  -->
                       	</form>
                       	<div class="btnArea d-flex mb-4 justify-content-center">
							<div class="s-btn s-btn-success py-3 w-25" id="btnTypeA">출근</div>
							<div class="s-btn s-btn-outline-danger py-3 w-25" id="btnTypeB">퇴근</div>
						</div>
                       	
                       	<!--p class="tb_numlist">총 ${ paginationInfo.getTotalRecordCount()}건</p-->
                       	
                       	<div id="stWorkOn">
	                       	<div class="d-flex">
	                       		<div class="s-btn s-btn-success px-4 btnWorkOn">출근목록</div>
	                       		<div class="s-btn s-btn-outline-success px-4 btnWorkOff">퇴근목록</div>
	                       	</div>
                       	
							<table class="tb_type01 stWorks">
								<thead>
									<tr>
										<th>출근일시</th>
										<th>장소</th>
										<th>구분</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="result" items="${cleanListA}" varStatus="status">
									<tr>										
										<td class="tc">${result.reg_dttm}</td>
										<td class="tc">${result.reg_addr} ${result.reg_addr_detail}</td>
										<td class="tc">
										<c:choose>
											<c:when test="${result.clean_type == 'A'}">
											출근
											</c:when>
											<c:when test="${result.clean_type == 'B'}">
											퇴근
											</c:when>
										</c:choose>
										</td>										
									</tr>								
									</c:forEach>
									<c:if test="${fn:length(cleanListA) eq 0 }">
										<table class="tb_type01 nbt0">
											<tr><td style="text-align:center"><spring:message code="search.nodata.msg" /></td></tr>
										</table>
									</c:if>
								</tbody>
							</table>
						</div>
						
						<div id="stWorkOff" style="display:none;">
							<div class="d-flex">
	                       		<div class="s-btn s-btn-outline-success px-4 btnWorkOn">출근목록</div>
	                       		<div class="s-btn s-btn-success px-4 btnWorkOff">퇴근목록</div>
	                       	</div>
	                       	
							<table class="tb_type01 stWorks">
								<thead>
									<tr>
										<th>퇴근일시</th>
										<th>장소</th>
										<th>구분</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="result" items="${cleanListB}" varStatus="status">
									<tr>										
										<td class="tc">${result.reg_dttm}</td>
										<td class="tc">${result.reg_addr} ${result.reg_addr_detail}</td>
										<td class="tc">
										<c:choose>
											<c:when test="${result.clean_type == 'A'}">
											출근
											</c:when>
											<c:when test="${result.clean_type == 'B'}">
											퇴근
											</c:when>
										</c:choose>
										</td>										
									</tr>								
									</c:forEach>
									<c:if test="${fn:length(cleanListB) eq 0 }">
										<table class="tb_type01 nbt0">
											<tr><td style="text-align:center"><spring:message code="search.nodata.msg" /></td></tr>
										</table>
									</c:if>
								</tbody>
							</table>
						</div>
						
                    </div>
                 </div>
             </div>
      	</div>
       <form id="aForm" name="aForm">
       <input type="hidden" name="workType" id="workType" value="">
       </form>
</body>
<script>

$(".btnWorkOn").click(function(){
	$("#stWorkOn").css("display","");
	$("#stWorkOff").css("display","none");
});
$(".btnWorkOff").click(function(){
	$("#stWorkOn").css("display","none");
	$("#stWorkOff").css("display","");
});

$("#btnTypeA").on("click",function(e){
	e.preventDefault();
	$("[name='clean_type']").val('A');
	//$("#workType").val('on')
	$("#searchFrm").attr({method : 'post', action : '/cleanStatusDetail.do'}).submit();
});
$("#btnTypeB").on("click",function(e){
	e.preventDefault();
	$("[name='clean_type']").val('B');
	//$("#workType").val('off')
	$("#searchFrm").attr({method : 'post', action : '/cleanStatusDetail.do'}).submit();
});


function findLocation( param ) {
	deviceName = checkDevice();
	
	if ( param == null && deviceName !=="" && confirm("내 위치 찾기를 하시겠습니까? \r\n 확인시 내위치 찾기 , 취소시 미확인")) {
		getUsrGpsInfo();
	} else {
		onErrorGeolocation();
	}	
     
     if ( param != null ) {
    	 getUsrGpsInfo();
     }  
};


function getUsrGpsInfo() {
	
	if ( appOsType === undefined || appOsType === "web" || appOsType === "") { //웹, 모바일웹의 경우
			if (navigator.geolocation) {
				var options = {
					enableHighAccuracy : true,
					timeout : 10000,
					//timeout : 100,
					maximumAge : 6000
				};
				
				// navigator.geolocation.getCurrentPosition(onSuccessGeolocation, onErrorGeolocation, options);
				if ( realStationList == null || realStationList.length == 0 ) {
					navigator.geolocation.getCurrentPosition(onSuccessGeolocation, onErrorGeolocation, options);
				} else {
					navigator.geolocation.getCurrentPosition(onSuccessGeolocation1, onErrorGeolocation1, options);
				}
				
			} else {
				alert("이 브라우저는 Geolocation를 지원하지 않습니다.");
				location.replace(returnSta.replaceUrl);
			}
	
	} else { //앱으로 접속할 경우
		if (appOsType === 'android' || appOsType === "Android") {
			window.android.gpsStart();
		}
		if (appOsType === 'iPhone' || appOsType === "iPad" || appOsType === 'ios') {
			window.location = 'toApp://?{"call":"gpsStart"}';
		}
		
		// 2019.02.20 
		if (navigator.geolocation) {
			navigator.geolocation.getCurrentPosition(onSuccessGeolocation, onErrorGeolocation);
		} else {
			onErrorGeolocation();
		}
		
	}
};

</script>
</html>