<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.dkitec.barocle.admin.login.vo.UserSessionVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>    
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" /> 
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no shrink-to-fit=no" />
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
<tiles:insertAttribute name="resource"/>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
<script type="text/javascript" src="/js/common_barocle.js?ver=0403"></script>
<link rel="stylesheet" type="text/css" href="/css/distApp.css" >
<link rel="stylesheet" type="text/css" href="/css/w3.css" >
<!-- 
	개발일시 : 2021-12-03
	개발자   : 양재영
	내용     : 순회정비반 팀 전용 화면
	AS-IS : 기존 페이지 이동 행위를 모달로 변경구현 
 -->

<title>순회정비반 모바일페이지</title>
</head>
<body>

<div id="contents-wrap">

<div id="initMapSize"></div>

	<%@ include file="./round_topSlideMenuView.jsp" %>

		<div id="mainDiv">

	<div class="accordion" id="accordionDiv">	
	  
	  <div class="card">
	  
	    <div class="card-body" id="headingOne">
	      <h2 class="mb-0">
	        <button class="collapseBtn" type="button" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne" style="text-align-last: center;">공지사항</button>
	      </h2>
	    </div>
	
	    <div id="collapseOne" class="collapse" aria-labelledby="headingOne" data-parent="#accordionDiv">
			<div class="card-body">
	        
					<table class="tb_type01">
						<caption>공지사항</caption>
						<colgroup>
						<col style="width:20%"/>
						<col style="width:70%"/>
						<col style="width:10%"/>
						</colgroup>
						<thead>
							<tr>
								<th>제목</th>
								<th>내용</th>
								<th>파일첨부</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
							<c:when test="${fn:length(distBoardList) > 0 }">
								<c:forEach items="${distBoardList}" var="distBoardList" varStatus="status">
									<tr>
										<td class="title"><c:out value="${distBoardList.distTitle}"/></td>
										<td class="tc">${distBoardList.distTextContent}
										</td>
										<td class="tc">
										
										<c:if test="${distBoardList.atchFileID ne null }">
										<a target="_blank()" href="https://abc.bikeseoul.com/${distBoardList.atchFileID}" >파일</a>
										</c:if>
										</td>
										
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td class="tc" colspan="5"><spring:message code="search.nodata.msg" /></td>
								</tr>
							</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
	    	</div>
	  </div>
	  
	<div class="card">
		<div class="card-body" id="headingTwo">
			<h2 class="mb-0">
		    	<button class="collapseBtn" type="button" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo" style="text-align-last: center;">근태등록</button>
			</h2>
		</div>
		
		<div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionDiv">
			<div class="card-body">
				<%@ include file="./round_dispatchView.jsp" %>
		  </div>
		</div>
	  
	</div>
	   
	  
<%-- 	  
	<div class="card">
		<div class="card-body" id="headingFour">
			<h2 class="mb-0">
				<button class="collapseBtn" type="button" data-toggle="collapse" data-target="#collapseFour" aria-expanded="false" aria-controls="collapseFour" style="text-align-last: center;">공동작업</button>
			</h2>
		</div>
		<div id="collapseFour" class="collapse" aria-labelledby="headingFour" data-parent="#accordionDiv">
			<div class="card-body">
				<%@ include file="./dist_massMoveBikeView.jsp" %> 	      	
			</div>
		</div>
	</div>
 --%>
 
 
	  <div class="card">
		  
		    <div class="card-body" id="headingFive">
		      <h2 class="mb-0">
		        <button class="collapseBtn" type="button" data-toggle="collapse" data-target="#collapseFive" aria-expanded="false" aria-controls="collapseFive" style="text-align-last: center;">대여소</button>
		      </h2>
		    </div>
		    
		    <div id="collapseFive" class="collapse" aria-labelledby="headingFive" data-parent="#accordionDiv">
		    
		      <div class="card-body">
		      
	         	<%@ include file="./round_mapView.jsp" %>
	            	
			  </div>
			  
		    </div>
		    
		  </div>
 
 
 
 	  <div class="card" >
	  
	    <div class="card-body" id="headingSix" name="headingSix">
	      <h2 class="mb-0">
	        <button class="collapseBtn" name="bunbae" type="button" data-toggle="collapse" data-target="#collapseSix" aria-expanded="false" aria-controls="collapseSix" style="text-align-last: center;">업무일지</button>
	      </h2>
	    </div>
	    
	    <div id="collapseSix" class="collapse" aria-labelledby="headingSix" data-parent="#accordionDiv">
	      <div class="card-body">
	      	<%@ include file="./round_diaryView.jsp" %>  
	      </div>
	    </div>
	    
	  </div>
 	 
			<form id="QRfrm">
			    <input type="hidden" id="deviceId" name="deviceId" value=""/>
			    <input type="hidden" id="bikeId" name="bikeId" value=""/>
			    <input type="hidden" id="stationId" name="stationId" value=""/>
			    <input type="hidden" id="rackId" name="rackId" value=""/>
			    <input type="hidden" id="deviceName" name="deviceName" value=""/>
			    <input type="hidden" id="useTime" name="useTime" value=""/>
			    <input type="hidden" id="beaconId" name="beaconId" value=""/>
			    <!-- <input type="hidden" id="lat" name="lat" value=""/>
			    <input type="hidden" id="log" name="log" value=""/> -->
			</form>	 	 
	  
	</div>
</div>


<div> 
    <!-- bottom menu -->
    <div id="navbarBottom" class="navbar navbar-dark fixed-bottom" style="place-content: center;" >
    
    	<button id="navBarHome" type="button">
			<svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-house" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
			  <path fill-rule="evenodd" d="M2 13.5V7h1v6.5a.5.5 0 0 0 .5.5h9a.5.5 0 0 0 .5-.5V7h1v6.5a1.5 1.5 0 0 1-1.5 1.5h-9A1.5 1.5 0 0 1 2 13.5zm11-11V6l-2-2V2.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5z"/>
			  <path fill-rule="evenodd" d="M7.293 1.5a1 1 0 0 1 1.414 0l6.647 6.646a.5.5 0 0 1-.708.708L8 2.207 1.354 8.854a.5.5 0 1 1-.708-.708L7.293 1.5z"/>
			</svg>    	
    	</button>
    	
    </div>
    
</div>
	
	
	<!-- Modal -->
	<%@ include file="./round_modalView.jsp" %>
	
</div>	

<form name="sessionLogoutForm" action="/j_spring_security_logout" method='POST'></form>
	
<script type="text/javascript" src="/js/common_barocle.js"></script>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=zc9ttduqic&callback=draw"></script>
<script type="text/javascript" src="/js/stationCommonMapv.js"></script>

<%@ include file="./dist_diaryJS.jsp" %>
<%@ include file="./round_mapJS.jsp" %>
<%@ include file="./dist_settingJS.jsp" %>
<%@ include file="./dist_speechJS.jsp" %>
<%@ include file="./dist_massMoveBikeJS.jsp" %>
<%@ include file="./round_dispatchJS.jsp" %>

<script type="text/javascript">

$(function(){
	
	init();
	
	//맵생성 S //
	initMap();
	//맵생성 E //
	
	//사이드 메뉴 버튼 이벤트 설정 S //
	initNavBtn();
	//사이드 메뉴 버튼 이벤트 설정 E //
	
	//collapse 이벤트 설정 S //
	initCollapseEvent();
	//collapse 이벤트 설정 E //
	
	//modal 이벤트 설정 S //
	initModalEvent();
	//modal 이벤트 설정 E //
	
	//지도 설정 S //
	currentStatus.initSearchForm();
	//지도 설정 E //
	
	//설정 S//
	initSetting();
	//설정 E//
	
	//대여소 검색 설정 S //
	initStationSearch();
	//대여소 검색 설정 E //  
	 
	
});

var collapseList = new Array();

function initModalEvent(){
	
	$("#contents-wrap .modalClose").on('click', function(){//닫기 버튼
		
		var parent = $(this).parent();
		var start = true;
		
		while(start){
			
			var parentId = $(parent).attr('id');
			
			if(parentId && parentId.indexOf('exampleModal') > -1){
				
				$(parent).modal('hide');
				start = false;
				
			}else{
				
				if(parentId && parentId.indexOf('contents-wrap') > -1 ){
					
					$("#contents-wrap .modal").each(function(){
						$(this).modal('hide');
					});
					start = false;
				}
				
				parent = $(parent).parent();
				
			}
			
		}
		
	});
	
	//열기전
	$('#contents-wrap .modal').on('show.bs.modal', function (e) {});
	//열기후
	$('#contents-wrap .modal').on('shown.bs.modal', function (e) {});
	//닫기전
	$('#contents-wrap .modal').on('hide.bs.modal', function (e) {
		if(!iframe.timerId){}else{	clearInterval(iframe.timerId);	}
	});
	//닫기후
	$('#contents-wrap .modal').on('hidden.bs.modal', function (e) { });
	
}

function initCollapseEvent(){
	
	
	$("#mainDiv .collapse").each(function(){
		
		 var obj = new Object();
		 
		 obj.el = this;
		 obj.btn = $(this).parent().find('.collapseBtn');
		 obj.name= $(this).parent().find('.collapseBtn').text();
		 obj.top = $(this).parent().find('.collapseBtn').offset().top;
		 
		 collapseList.push(obj);
		 
	});

	$('#mainDiv .collapse').on('show.bs.collapse', function () {//열기전
		
		
		
	});
	
	$('#mainDiv .collapse').on('shown.bs.collapse', function (e) {//열기후
		
		e.preventDefault();
	
		var position = null;
		
		for(var i = 0; i < collapseList.length; i++){
			
			if(this === collapseList[i].el) {
				position = collapseList[i].top;
				
				switch( collapseList[i].name ){
					case "근태등록" :
						//차량등록 설정 S //
						initDispatch();
						//차량등록 설정 E //
					break;
					case "업무일지" :
						//분배일지 설정 S // TODO
						initDiary();	
					break;
					
					case "공동작업" :
						//자전거 대량이동 설정 S //
						initMsmvBike();	
					break;
				}
				
			}
		}
		
		$("html, body").animate({
			"scrollTop" : position-(currentStatus.navHeight+20)	
		},400);
		 
	
	});
	
	$('#mainDiv .collapse').on('hide.bs.collapse', function () {//닫기전
		// alert(2);
	});
	
	$('#mainDiv .collapse').on('hidden.bs.collapse', function (e) {//닫기후
	});
	
}

function initNavBtn(){
	
	$("#navBarHome").on('click',function(){
		 location.href="/moveMainPage.do"
		// location.href="/moveMainPage.do"
	});
	
	$("#slideNav button").each(function(){
		
		var elClass = $(this).attr('class');
		
		if(elClass == "navBtn"){
			
			$(this).on('click',function(){
				selectPositionWithNavName($(this).text());
			});
			
		}else if(elClass == "setBtn"){
			
			$(this).on('click',function(){
				selectSetWithNavName($(this).text());
			});
			
		}
		
	});
	
}

var _adminId = "";


function init(){
	
	<%
		javax.servlet.http.HttpSession s = request.getSession();
		com.dkitec.barocle.admin.login.vo.UserSessionVO uVo = (com.dkitec.barocle.admin.login.vo.UserSessionVO)s.getAttribute("userSessionVO");
	%>
	
	var usrGrpCd ='<%= uVo.getUsrGrpCd()%>';
	
	dispatch.adminId = '<%= uVo.getUsrId()%>';
	
	_adminId = '<%= uVo.getUsrId()%>';
	
	if(usrGrpCd === '1'){
		
		$("#filterDiv").hide();
		
	}
	
	currentStatus.navHeight = $("#navbarTop").outerHeight(true);
	
	$(".menuBtn").click(function () {
	    $("#menuDiv,.page_cover,html").addClass("menuOpen");
	});
	$(".page_cover").click(function () {
	    $("#menuDiv,.page_cover,html").removeClass("menuOpen");
	});
	$(".menuClose").click(function () {
	    $("#menuDiv,.page_cover,html").removeClass("menuOpen");
	});
	
	$(".menuHome").click(function () {
		
		$("#mainDiv .collapse").each(function(){
			
			var className = $(this).attr('class');
			var elId = $(this).attr('id');
			
			if(className.indexOf('show') > -1){
				
				var targetId = elId.replace('collapse','heading');
				
				$("#"+targetId+" button").trigger("click");
				
			}
			 
		});
		
	    $("#menuDiv,.page_cover,html").removeClass("menuOpen");
	    
	});
	
	$(".logOut").click(function () {
	    $("[name='sessionLogoutForm']").submit();
	});
		
	
	
}

function selectSetWithNavName(name){
	
	var result = "";
	
	switch (name) {
	
		case "글자크기 조절":
			
			startFontSizeSetting();
			
			$("#exampleModalLabel2").html(name);
			
			var html = initFontSizeSetTable();
	       	$("#exampleModal2 .modal-body").html(html);
	    	
	    	$("#fontSizeUp").on("click", function(){
	    		
	    		var el = document.getElementById('contents-wrap');
	    		
	    		
	    		
	    		var setVar = (settings.fontSize + 1) + 'px';
	    		
		    	el.style.setProperty('font-size', setVar,'important');
		    	
		    	$("#fontSizeFormTd").html((settings.fontSize + 1));
		    	
		    	settings.fontSize = settings.fontSize + 1;
		    	
		    	changeFontSizeRefNavTop();
		    	
		    	$( "button" ).css( "font-size", "+=2" );
		    	$( "form" ).css( "font-size", "+=2" );
		    	$( "div" ).css( "font-size", "+=2" );
		    	$( "table" ).css( "font-size", "+=2" );
		    	
		    	
	    	});
	    	
	    	$("#fontSizeDown").on("click",function(){
	    		
	    		var el = document.getElementById('contents-wrap');
	    		var setVar = (settings.fontSize - 1) + 'px';
	    		
		    	el.style.setProperty('font-size', setVar,'important');
		    	
		    	$("#fontSizeFormTd").html((settings.fontSize - 1));
		    	
		    	settings.fontSize = settings.fontSize - 1;
		    	
		    	changeFontSizeRefNavTop();
		    	
		    	$( "button" ).css( "font-size", "-=2" );
		    	$( "form" ).css( "font-size", "-=2" );
		    	$( "div" ).css( "font-size", "-=2" );
		    	$( "table" ).css( "font-size", "-=2" );
	    	});
	    	
			$("#exampleModal2").modal();
			
			break;

	}
	
	return result;
}

function selectPositionWithNavName(name){
	
	var result = "";
	
	
	for(var i = 0; i < collapseList.length; i++){

		if(name == collapseList[i].name){
			
			var el = collapseList[i].el;
			
			var className = $(el).attr('class');			
			var id = $(el).attr('id');
			var targetId = id.replace('collapse','heading');
			
			if(className.indexOf('show') == -1 ) $("#"+targetId+" button").trigger("click");
			
			result = id;
			
		}
			
	}
	
	return result;
	
}




var iframe = {};

function initModalIfarame(titleName,objArr,url){
	$("[name='modalIframe']").css({display : 'block', width : '95vw', height : '100vh'});
	
	if(typeof url !== "undefined"){
		window.open(url, "modalIframe", "");
		
	}
	iframeCustom(titleName,objArr);
}

var iframeCustom = function(titleName,objArr){
	$("[name='modalIframe']").load(function(){
   		var contents = $(this).contents();
   		
   		if(typeof $(contents).find("#header") != "undefined"){
   			$(contents).find("head").append($("<style type='text/css'>  #header{display:none;}  #body{background: transparent;}  #footer{display:none;}  .cont{padding-top: 5px;}  .layerMenuArea{padding-top:10px;}  .layerMenuArea{display:none;}  .leftmenu{display:none;} </style>"));
	   		$(contents).find('#sessionLogoutForm').remove();
	   		$(contents).find('#logoutForm').remove();
	   		
	   		if(!objArr){
	   		}else{
	   			
		   		for(var i= 0; i < objArr.length; i++){
		   			
		   			var obj = objArr[i];
		   			
		   			if(obj.commend == "remove"){
		   				
		   				$(contents).find(obj.selector).remove();
		   			}
		   		}
	   		} 
	   		
	   		$(contents).find('#header').remove();
	   		$(contents).find('.leftmenu').remove();
	   		$(contents).find('#footer').remove();
			$("#exampleModalLabel").html(titleName);
			$("#exampleModal").modal();
		}
	});
	
}


</script>




<script type="text/javascript">

var bikeSearch = {};


// 대여소 탭 이동
function initStationSearch(){
	
}

var isRun = false;
 


function fn_repairTimer(){
    iframe.timerId = setInterval(function(){
		bikeSearch.repairTime++
		if(bikeSearch.repairTime >= 3000){
		    clearInterval(iframe.timerId);
		    alert("30분이 경과되어 다시 시도하시길 바랍니다.");
		    return false;
		}
		if(bikeSearch.repairYn === "Y"){
			clearInterval(iframe.timerId);
			$("#exampleModal").modal('hide');
		}
		
	}, 1000);
}

function mSearchFaultModalIframe(faultSeq){
		
		var faultForm = $("<form>");
  		var modeInput = $("<input>");
  		var faultSeqInput = $("<input>");
  		
  		$(modeInput).attr({type : 'hidden', name: 'mode', value : 'view'});
  		$(faultSeqInput).attr({type : 'hidden', name: 'faultSeq', value : faultSeq});
  		
  		$(faultForm).append(modeInput);
  		$(faultForm).append(faultSeqInput);
  		
  		//HTML5 표준에선 Browsing contexts(document) 에 form 이 연결되어 있지 않으면, form submit을 중단하도록 규정하였다.
  		$(".displayChk").append(faultForm);
  		
  		$(faultForm).attr({method : 'post',target : 'modalIframe', action : '/common/pop/DEV_001/showTroubleReportPop.do'}).submit();
  		
  	    var objArr = [];
  	    
  	    var obj = new Object();
  	    obj.commend = "remove";
  	    obj.selector = ".popTt";
  	    
  	    objArr.push(obj);
  	    
  	    var obj = new Object();
  	    obj.commend = "remove";
  	    obj.selector = "#cancelBtn";
  	    
  	    objArr.push(obj);
  		initModalIfarame("신고내용",objArr);
}
 
//////////////////////////////// QR 촬영 //////////////////////////////////// 

function getAdminLogin(){
	var usrSeq = '${UserSessionVO.adminSeq}';
	if (usrSeq != null && usrSeq != '' && usrSeq > 0) {
		var tempSeq = '';
		for (var i = usrSeq.length; i < 10; i++) {
			tempSeq += '0';
		}
		usrSeq = tempSeq + usrSeq;	
	} else {
		alert("관리자 번호가 조회되지 않았습니다. 다시 로그인 부탁드립니다.");
		return false;
	}
	
	var jsonTestData = {"userseq" : usrSeq, "isuser" : false, "call" : "setUser"};
	var loginTestInfo = JSON.stringify(jsonTestData);
	window.android_admin.setUser(loginTestInfo);
	return true;
} 
 
function goQrScan(scanType) {
	
	
	var usrSeq = '${UserSessionVO.adminSeq}';
	if (usrSeq != null && usrSeq != '' && usrSeq > 0) {
	} else {
		alert("관리자 번호가 조회되지 않았습니다. 다시 로그인 부탁드립니다.");
		return false;
	}
	var bikeNo = $("#bikefrm input[name=rentBikeNo]").val();  
	
	//대여중
	if($("input[name=rentStatusCd]").val() === "BKS_010"){	alert("현재 대여중인 상태입니다."); return;	}
	
	// 자전거 번호가 있을 경우
	if( !isEmpty( $("#bikefrm input[name=rentBikeId]").val() ) ){//자전거를 검색해서 이미 값을 가지고 있는 경우
		if ( !confirm( bikeNo + " 번호가 맞습니가? " )) return;
		window.osType = 'android';
		if ( scanType =="move") {
			if(!getAdminLogin()) return;
			commonAjax.postAjax('/bike/getQRBikeCodeDataInfo.do', "json", {rackId:bikeNo} ,function(data){
				if(data.result) {
					getQRMove(data);
				} else {
					alert('잠금해제가 불가능한 자전거 입니다.');
				}
	        });
			
		} else {
			if(!getAdminLogin()) return;
			window.android_admin.returnCheck(getDeviceName(bikeNo));
		}	
	// 자전거 번호 없을 경우
	} else {
		customQrScan(scanType);
	}
	
}

function customQrScan(scanType){
	if ( typeof( window.android_admin ) == undefined || typeof( window.android_admin) == 'undefined' ) {
		alert("관리자 앱에서 사용가능합니다.");
		return;
	}

	// 관리자 로그인
	if(!getAdminLogin()) return;
	app.deviceType = 'android';
	app.scanType = scanType;
	app.QRscanStart();
}

function getQRMove(data){
	app.hideLoading();
	
	if (data.resultCode == -1) {
		alert('로그인 후 다시 시도해 주세요.');
	} else if (data.resultCode == -2) {
		alert('등록되지 않은 QR 코드 입니다.');
	} else if(data.resultCode == -3){//해당 자전거 대여중
		alert("현재 대여 중인 자전거입니다.\r강반 처리 후 진행해 주시길 바랍니다.");
	} else if (data.resultCode == -99) {
		if (data.qrData.deviceName == '') {
			alert('잠금해제가 불가능한 자전거 입니다.');
			return;
		}
		/* 
		$("#deviceId").val(data.qrData.deviceId);
		$("#bikeId").val(data.qrData.bikeId);
		$("#rackId").val(data.qrData.rackId);
		$("#stationId").val(data.qrData.stationId);
		$("#deviceName").val(data.qrData.deviceName);
		 */
		window.android_admin.unLock( getDeviceName(data.qrData.deviceName) , 60);
	} else {
		if (data.qrData.deviceName == '') {
			alert('잠금해제가 불가능한 자전거 입니다.');
			return;
		}

		$("#deviceId").val(data.qrData.deviceId);
		$("#bikeId").val(data.qrData.bikeId);
		$("#rackId").val(data.qrData.rackId);
		$("#stationId").val(data.qrData.stationId);
		$("#deviceName").val(data.qrData.deviceName);		
		
		window.android_admin.unLock( getDeviceName(data.qrData.deviceName) , 60);
	}
}

function getDeviceName(s){
	if ( s.length ==  9 ) {
		s =	"BRC-000" + s.substring(4);
	}
	 
	return s;
}

////////////////////////////////QR 촬영 END ////////////////////////////////////

</script>

</body>
</html>