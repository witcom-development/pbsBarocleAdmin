<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<title><tiles:insertAttribute name="title"/></title>
<tiles:insertAttribute name="resource"/>
<script type="text/javascript" src="/js/common_barocle.js?ver=0403"></script>
<style>

	.myButton {
		box-shadow:inset 0px -3px 7px 0px #29bbff;
		background-color:#2dabf9;
		border-radius:5px;
		border:1px solid #0b0e07;
		display:inline-block;
		cursor:pointer;
		color:#ffffff;
		font-family:Arial;
		font-size:16px;
		padding:10px;
		text-decoration:none;
		text-shadow:0px 1px 0px #0688fa;
		width:50px;
		margin: 10px 10px 20px 10px;
	}
	.myButton:hover {
		background:linear-gradient(to bottom, #0688fa 5%, #2dabf9 100%);
		background-color:#0688fa;
	}
	.myButton:active {
		position:relative;
		top:1px;
	}
	.myButton span {
		margin-top: 10px;
	}
	.loginInfo{
		font-size: 13px;
	}
</style>
</head>
<body>
    <div class="allwrap">
        <!--모바일 메뉴 S-->
        <tiles:insertAttribute name="header" />
        <!--모바일 메뉴 E-->
        <!--Head S-->
        <tiles:insertAttribute name="head" />
        <!--Head E-->
		<div id="body" class="logined">
			<div class="cont">
				<!--left menu S-->
                <tiles:insertAttribute name="left"  />
                <!--left menu E-->
				<!--conteent S-->
                <div class="content" style="margin-top: 2em;">
                	<div style="color:bisque; visibility: hidden; display: none;" name="favorite">
						<a href="/getStationCurrentStatus.do" class="myButton">대여소 현황</a>
						<a href="/getBikeList.do"             class="myButton">자전거 조회</a>
						<a href="/inspectBikeList.do"         class="myButton">장애관리</a>
						<a href="/repairBikeList.do"          class="myButton">수리관리</a>
						<a href="/getExeImpulseList.do"       class="myButton">강제반납관리</a>
						<!-- <a href="javascript:hold()" class="myButton">관리직<br/>게시판</a> -->
						<a href="/admin/board/distribute/distBoardList.do" 		  class="myButton">관리직<br/>게시판</a>
						<br/>
						<!--  QR 자전거 관리 -->
						<a href="javascript:goQrScan('move');" class="myButton">자전거 이동</a>
						<a href="javascript:goQrScan('check');" class="myButton">자전거 확인</a>
						<a href="javascript:goQrScan('relocate');" class="myButton">재배치 완료</a>
						<a href="javascript:goQrScan('reset');" class="myButton">단말기 리셋</a>
						<!--  QR 자전거 관리 -->
						<br/>
						<hr/>
					</div>			
					<div class="loginedBox displayChk" style="display: none;">	
					<form id="bikefrm">
						<div style="float: left;">운행중 자전거 :${wholeStatusTotCnt.rentStableTotCnt}대</div>
						<div style="float: right;">자전거 번호 : <input type="text" id="bikeNoSearch" name="searchWord" style="width:30%;"><button id="bikeSearchBtn" class="btn-srh03"><img src="/images/searchIcon.gif" alt="검색"></button></div><br/>
						
						<table class="tb_type01 mt20">
								<colgroup>
									<col style="width:35%">
									<col style="width:65%">
									<%-- <col style="width:55%"> --%>
								</colgroup>
								<thead>
									<tr>
										<th>자전거번호</th>
										<th>자전거상태</th>
										<!-- <th>최종대여소</th> -->
									</tr>
								</thead>
								
								<tbody>
	                                <tr>
	                                    <td class="tc" id="rentBikeNo"></td>
	                                    <td class="tc" id="rentBikeStat"></td>
	                                    <!-- <td class="tc" id="stationName"></td> -->
	                                </tr>
	                            </tbody>
							</table>
						
						
						<input type="hidden" name="rentBikeId" value="">
						<input type="hidden" name="rentBikeNo" value="">
						<input type="hidden" name="rentHistSeq" value="">
						<input type="hidden" name="rentSeq" value="">
						<input type="hidden" name="rentStatusCd" value="">
						<input type="hidden" name="rentBikeStat" value="">
						<input type="hidden" name="rentStationId" value="">
						<input type="hidden" name="stationName" value="">
						<input type="hidden" name="lang" value="LAG_001">
						<input type="hidden" name="adminId" value="${UserSessionVO.usrId}">
					</form>
					
					<span id="cautionText" style="color: red; font-size: 12px; display:none;">주의) 대여중인 자전거는 강제반납만 가능합니다.</span><br/><br/>
					<button class="btnType01" id="bikeRobbedBtn">도난추정</button>&nbsp;<button  class="btnType01 bc_green" id="bikeRetrievalBtn">회수</button> 
					
					</div>
					
                    <div class="page">
                    	 <!--검색조건 S-->
                    	<form  id="searchFrm" name="searchFrm">
						<!--검색조건 E-->
						<div class="loginedBox" >
							<div class="user">
								<em class="img"><img src="/images/icon_login.png" alt="" /></em>
								<p>
									<span class="id" >${UserSessionVO.usrName}(${UserSessionVO.usrId})</span>님 로그인이 정상적으로 처리 되었습니다.<br><br>
									<span class="loginInfo info1"></span>&nbsp;&nbsp;<span class="loginInfo info2"></span>
								</p>
							</div>
							<div class="loginInfoBox">
							<p class="head tl">로그인정보</p>
							<table class="tb_type01 mt20">
								<colgroup>
									<col style="width:20%">
									<col style="width:20%">
								</colgroup>
								<thead>
									<tr>
										<th>접속 IP</th>
										<th>로그인일시</th>
									</tr>
								</thead>
								
								<tbody>
	                            <c:forEach var="result" items="${LoginHistoryList}" varStatus="status">
	                                <tr>
	                                    <td class="tc">${result.usrIp}</td>
	                                    <td class="tc">${result.loginDate}</td>
	                                </tr>
	                            </c:forEach>    
	                            <c:if test='${fn:length(LoginHistoryList) == 0}'>
		                            <tr>
		                                <td style="text-align:center" colspan="2"><spring:message code="search.nodata.msg" /></td>
		                            </tr>
	                            </c:if>
	                            </tbody>
							</table>
					<c:choose>
						<c:when test="${fn:length(LoginHistoryList) > 0}">
							<div class="drpaging">
						</c:when>
						<c:otherwise>
							<div class="drpaging" style="display:none;">
						</c:otherwise>
					</c:choose>
							<c:choose>
							<c:when test="${paginationInfo.currentPageNo > 1}">
								<a id="prevPage" href="#"><img src="/images/p_prev.gif" alt="이전 페이지" /></a>
							</c:when>
							<c:otherwise>
								<a href="#"><img src="/images/p_prev.gif" alt="이전 페이지" /></a>
							</c:otherwise>
							</c:choose>
							<span><input name="currentPageNo" type="number" value="${paginationInfo.currentPageNo}"/><em>/ ${paginationInfo.totalPageCount}</em><button id="movePage">이동</button></span>
							<c:choose>
							<c:when test="${paginationInfo.currentPageNo < paginationInfo.totalPageCount}">
							<a id="nextPage" href="#"><img src="/images/p_next.gif" alt="다음 페이지" /></a>
							</c:when>
							<c:otherwise>
								<a href="#"><img src="/images/p_next.gif" alt="다음 페이지" /></a>
							</c:otherwise>
							</c:choose>
						</div>
						</div>
                        </form>
						<p class="head tl" style="display: none;"><a href="/common/pop/entrcReutnListPop.do" id="pop1" class="winNewPop"  title="강제반납 조회" data-width="700" data-height="455" data-pmt="&teamSeq=<c:out value='${UserSessionVO.teamSeq}'/>">강제반납 조회</a></p>
						</div>
						<%-- <table>
						<tr><td><a href="/common/pop/entrcReutnListPop.do" class="winNewPop"  title="강제반납 조회" data-width="700" data-height="455" data-pmt="&teamSeq=<c:out value='${UserSessionVO.teamSeq}'/>">강제반납 조회</a></td></tr>
						</table> --%>
					</div>
				</div>
				<!--conteent E-->
				<form id="linkForm">
					<input type="hidden" name="bikeNo" value="">
					<input type="hidden" name="bikeId" value="">
					<input type="hidden" name="lang" value="">
					<input type="hidden" name="viewFlg" value="">
					<input type="hidden" name="tabNum" value="">
					<input type="hidden" name="currentPageNo" value="">
				</form>
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
		<!--footer S-->
        <tiles:insertAttribute name="footer" />
        <!--footer E-->
    </div>
    <script type="text/javascript">
    var loginHistory = {};
    loginHistory.pageSelect = function(cPage) {
        $("input:hidden[name='viewFlg']").val('list');
        $("[name='currentPageNo']").val(cPage);
        $("#searchFrm").attr({method : "post", action : "<c:out value='/main.do'/>"}).submit();
    };
	var popCount = 0;
	var popup;
	var top = 100;
	var left = 10;

	$(function(){
		// 2019-10-17
		switch( "${UserSessionVO.usrGrpName}"){
			
			case "관리운영그룹" :
			case "분배반장":
			case "분배":
				$("[name='favorite']").css("visibility","visible"); 
				$("[name='favorite']").css("display","inline-block"); 
				$("[name='favorite']").css("width","100%"); 
				$("[name='favorite']").css("margin-top","2em");
				$(".loginInfoBox").css("display","none");
				$(".info1").text("IP : ${LoginHistoryList[0].usrIp}");
				$(".info2").text("일시 : ${LoginHistoryList[0].loginDate}");
				$(".displayChk").css("display",""); //관리운영그룹만 보이도록
			default :
				$("[name='favorite']").css("visibility","visible"); 
				$("[name='favorite']").css("display","inline-block"); 
				$("[name='favorite']").css("width","100%"); 
				$("[name='favorite']").css("margin-top","2em");
				$(".loginInfoBox").css("display","none");
				$(".info1").text("IP : ${LoginHistoryList[0].usrIp}");
				$(".info2").text("일시 : ${LoginHistoryList[0].loginDate}");
				$(".displayChk").css("display",""); //관리운영그룹만 보이도록
		 
			break;
		}
		var totalPageCount = '${paginationInfo.totalPageCount}' == '' ? 1 : Number('${paginationInfo.totalPageCount}');
   		$('#prevPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			loginHistory.pageSelect(currentPageNo-1);
		});
		$('#nextPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			loginHistory.pageSelect(currentPageNo+1);
		});
		$('#movePage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			var regExp = /^[1-9]?[0-9]/;
			if(!regExp.test(currentPageNo) ||(totalPageCount < currentPageNo)){
				alert('현재 페이지 값이 정상적이지 않습니다.');
			}else{
				loginHistory.pageSelect(currentPageNo);
			}
		});
		$.ajax({
			url : "/admin/customer/notice/noticePopupCount.do",
			type : "get",
			contentType: "charset=utf-8",
			success : function(data){
					if(data!=null){
						for(var i=0; i<data.popupCount.length; i++){
							var s = getCookie(data.popupCount[i].noticeSeq);
							if(s!='hide'){
								window.open("/admin/customer/notice/noticePopup.do?popSeq="+data.popupCount[i].noticeSeq, "noticePop"+data.popupCount[i].noticeSeq, "toolbar=no, location=no, directory=no, scrollbars=yes, resizable=yes, top="+ top +", left="+ left +", width=400, height=600");
								left += 415;
							}
						}
					}
			}, error : function(){ alert("데이터를 가져오는데 실패 하였습니다."); }
		});
		/* 관리직 게시판 팝업 임시 주석 20200211 
		$.ajax({
			url : "/admin/board/distribute/boardPopupCount.do",
			type : "get",
			contentType: "charset=utf-8",
			success : function(data){
					if(data!=null){
						for(var i=0; i<data.popupCount.length; i++){
							var s = getCookie(data.popupCount[i].distSeq);
							if(s!='hide'){
								window.open("/admin/board/distribute/boardPopup.do?popSeq="+data.popupCount[i].distSeq, "noticePop"+data.popupCount[i].distSeq, "toolbar=no, location=no, directory=no, scrollbars=yes, resizable=yes, top="+ top +", left="+ left +", width=400, height=600");
								left += 415;
							}
						}
					}
			}, error : function(){ alert("데이터를 가져오는데 실패 하였습니다."); }
		});
		 */
		//alert('${UserSessionVO.teamSeq}');
		var teamSeq = '${UserSessionVO.teamSeq}';
		if(teamSeq != null && teamSeq !="" ){
			//pop1.click(); 
		}
		
		
		// 2019-11-08 
		$("#bikeSearchBtn").on("click",bikeNoSearch);
		$("#bikeRobbedBtn").on("click",bikeRobbedExe);
		$("#bikeRetrievalBtn").on("click",bikeRtrvlExe);
		$(document).on("click","#linkBikeDetail",function(e){
			if($("#rentBikeStat").text() == "대여중"){
				moveRentStatusInfo(e);
			} else {
				moveBikeEditForm(e);
			}
		});
		
	});
	
	function setCookie(num){
 		var expDate = new Date();
 		expDate = new Date(parseInt(expDate.getTime() / 86400000) * 86400000 + 54000000);
 		if(expDate<new Date()){ expDate.setDate(expDate.getDate()-1); }
		var expires = "expires="+expDate.toUTCString();
		document.cookie = "SPBcookie" + num + "=hide; " + expires;
	}
	
	function getCookie(num){
		var cookieName = "SPBcookie" + num + "=";
		var ca = document.cookie.split(';');
		for(var i=0; i<ca.length; i++) {
			var c = ca[i];
			while (c.charAt(0)==' ') c = c.substring(1);
			if (c.indexOf(cookieName) >= 0) return c.substring(cookieName.length, c.length);
		}
		return "";
	}

	function goEmpImpluseList(e){
		//setTimeout(alert(1),1000);
		//setTimeout($("#searchFrm").attr({method : "post", action : "<c:out value='/getExeImpulseList.do'/>"}).submit(),1000);
		$("#searchFrm").attr({method : "post", action : "<c:out value='/getExeImpulseList.do'/>"}).submit();
	}
	function bikeNoSearch(e){
		e.preventDefault();
		commonAjax.postAjax("/bikeNoSearch.do", "json", $("#bikefrm").serialize()
    		,function(data){
    		   if(data) {
    			  var result= data.result;
				  $("input[name=rentBikeId]").val(result.rentBikeId);    			  
				  $("input[name=rentBikeNo]").val(result.rentBikeNo);    			  
				  $("input[name=rentHistSeq]").val(result.rentHistSeq);    			  
				  $("input[name=rentSeq]").val(result.rentHistSeq);    			  
				  $("input[name=rentStatusCd]").val(result.rentStatusCd);    			  
				  $("input[name=rentBikeStat]").val(result.rentBikeStat);    			  
				  $("input[name=rentStationId]").val(result.rentStationId);    			  
				  $("input[name=stationName]").val(result.stationName);    			  
    			  
				  //$("#rentBikeNo").text(result.rentBikeNo);
				  $("#rentBikeNo").html('<a href="#" id="linkBikeDetail" target="_blank">'+result.rentBikeNo);
     			 
    			  if(result.rentBikeStat == "정상(대기중)"){
  		 			  $("#rentBikeStat").text("정상 대기중");
    			  } else {
	    			  $("#rentBikeStat").text(result.rentBikeStat);
    			  }
    			  
    			  if(result.stationName == "null"){
    				  $("#stationName").text("대여정보 없음");
    			  } else {
    				  $("#stationName").text(result.stationName);
    			  }
    			  
    			  if(result.rentBikeStat == "대여중"){
  		 			  $("#cautionText").css("display","");
    			  } else {
    				  $("#cautionText").css("display","none");
    			  }
    			  
    			  
    			  
    		   }
    		}
    	);
	}
	var isRun = false;
	function bikeRobbedExe(e){
		e.preventDefault();
		if(isRun == true) return false;
		
		var bikeNo = $("input[name=rentBikeNo]").val();
		if(bikeNo == null || bikeNo == ''){
			alert("자전거 조회 후 시도해주세요.");
			return false;
		}
		if($("#rentBikeStat").text() == "대여중"){
			alert("대여중인 자전거는 강제반납만 가능합니다.");
			return false;
		}
		if($("#rentBikeStat").text() == "대여중"){
			alert("대여중인 자전거는 강제반납만 가능합니다.");
			return false;
		}
		if($("#rentBikeStat").text() == "분실"){
			alert("분실 등록된 자전거 입니다.");
			return false;
		}
		
		var ans = confirm("자전거No ["+bikeNo+"]를 도난추정으로 등록 하시겠습니까?");
		if(ans){
				isRun = true;	
	    		commonAjax.postAjax("/common/pop/exeBikeRobbed.do", "json", $("#bikefrm").serialize()
	    		,function(data){
	    		   if(data.checkResult > 0) {
	    			   isRun = false;
	    			   alert(data.resultMessage);
	    			   $("#bikeSearchBtn").trigger("click");
	    		   }
	    		}
	    	);
	    }
	};
	
	function bikeRtrvlExe(e){
		e.preventDefault();
		if(isRun == true) return false;
		  
		var bikeNo = $("input[name=rentBikeNo]").val();
		if(bikeNo == null || bikeNo == ''){
			alert("자전거 조회 후 시도해주세요.");
			return false;
		}
		
		if($("#rentBikeStat").text() == "대여중"){
			alert("대여중인 자전거는 강제반납만 가능합니다.");
			return false;
		}
		if($("#rentBikeStat").text() == "회수"){
			alert("회수 등록된 자전거 입니다.");
			return false;
		}
		
		var ans = confirm("자전거No ["+bikeNo+"]를 회수 등록 하시겠습니까?");
		   	 
		if(ans){
	   			isRun = true;
	   		 	commonAjax.postAjax("/common/pop/exeBikeRtrvl.do", "json", $("#bikefrm").serialize()
	    		,function(data){
	    		   if(data.checkResult > 0) {
	    			   isRun = false;
	    			   
	    			   if ( data.resultMessage == "회수 등록에 성공했습니다." ){
	    				  if ( confirm("수리 입고를 등록하시겠습니까?") ) {
	    					  
	    					  // var locateInfo = "/moveRepairBikeEditForm.do?viewFlg=C&bikeId=" + $("input[name=rentBikeId]").val() + "&bikeNo=" + $("input[name=rentBikeNo]").val();  
	    					  // window.open(locateInfo, "네이버새창", "width=800, height=700, toolbar=no, menubar=no, scrollbars=no, resizable=yes" ); 
	    					  var locateInfo = "/moveRepairBikeEditForm.do?viewFlg=C&bikeId=" + $("input[name=rentBikeId]").val() + "&bikeNo=" + $("input[name=rentBikeNo]").val();  
	    					  window.location.href= locateInfo ;
	    					  
	    				  } else {
	    					  alert( data.resultMessage );
	    				  }

	    			   } else {
		    			
	    				   alert(data.resultMessage);
	    				   
	    			   }
	    			   
	    			   $("#bikeSearchBtn").trigger("click");
	    		   }
	    		}
	    	);
	    }
	};
	
	
	function moveBikeEditForm(e) {
        e.preventDefault();
        $("[name='bikeNo']").val($("[name='rentBikeNo']").val());
        $("[name='bikeId']").val($("[name='rentBikeId']").val());
        $("[name='currentPageNo']").val(1);
        $("[name='viewFlg']").val('U');
        $("[name='lang']").val('LAG_001');
        $("[name='tabNum']").val(2);
        $("#linkForm").attr({method : 'post',target : '_blank', action : '/moveBikeEditForm.do'}).submit();
    };
    
    function moveRentStatusInfo(e){
    	  e.preventDefault();
    	  $("#bikefrm").attr({method : 'post', target : '_blank', action : '/moveRentStatusInfo.do'}).submit();
    }
	function osInfo(pOSobj){
	    var obj = JSON.parse(pOSobj);
	    window.osType = obj.osInfo;
	};
	function goQrScan(scanType) {
		var adminSeq = 1;
		
		if (adminSeq != null && adminSeq > 0 ) {
			window.osType = 'android';
			// test
			var loginId = '${UserSessionVO.usrId}';
			if (loginId.indexOf('barocletest') === 0) {
				app.isTest = true;
			}
			var usrSeq = '${UserSessionVO.adminSeq}';
			if (usrSeq != null && usrSeq != '' && usrSeq > 0) {
				var tempSeq = '';
				for (var i = usrSeq.length; i < 10; i++) {
					tempSeq += '0';
				}
				usrSeq = tempSeq + usrSeq;	
			} else {
				usrSeq = '0000000000';
			}
			
			var jsonTestData = {"userseq" : usrSeq, "isuser" : false, "call" : "setUser"};
			var loginTestInfo = JSON.stringify(jsonTestData);
			window.android_admin.setUser(loginTestInfo);
		} else {
			var jsonTestData = {"userseq" : "0000000000", "isuser" : false, "call" : "setUser"};
			var loginTestInfo = JSON.stringify(jsonTestData);
			window.android_admin.setUser(loginTestInfo);
		}
		
		//if(window.osType !== 'web') {
			//QR코드 대여,안드로이드 경우
			//app.deviceType = window.osType;
			app.deviceType = 'android';
			app.scanType = scanType;
			app.QRscanStart();
		//}
	}
    </script>
</body>
</html>