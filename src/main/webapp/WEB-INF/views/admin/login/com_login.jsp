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
<style type="text/css">


</style>

<script>
$(document).ready(function() {
	// 브라우저마다 prefix가 달라 아래와 같이 처리한다.
	  var RTCPeerConnection = window.RTCPeerConnection || window.webkitRTCPeerConnection || window.mozRTCPeerConnection || window.msRTCPeerConnection;
	  // RTCPeerConnection 객체 생성 
	  var rtc = new RTCPeerConnection();
	  // 임의의 이름으로 채널 생성
	  rtc.createDataChannel("TEMP");
	  // 이벤트 핸들러 설정, ice 후보가 감지 되었을때 호출됩니다.
	  // 원래는 이곳에서 해당 candidate를 현재 커넥션에 연결해야 하나, ip를 알아내는 것이 목적이기 때문에 별다른 행동을 하지 않습니다.
	  rtc.onicecandidate = function(iceevent) {
	    if( iceevent && iceevent.candidate && iceevent.candidate.candidate ) {
	      var r = /\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b/;
	      var t = iceevent.candidate.candidate.match(r);
		  	if( t != null ) {
	      		console.log(t[0]); //IP
		  		$("#admin_ip").val(t[0]);
		  	}
	    }
	  }
	  //createOffer를 호출하면 연결하고자 하는 SDP가 생성됩니다. createOffer()의 결과로 offer가 생성되는데 이를 다시 setLocalDescription를 통해 설정하면
	  //로컬의 엔드포인트가 생성이 완료됩니다. 이렇게 생성된 Description을 연결하고자 하는 원격지에 전달해야 하나 이역시 해당 예제에서는 필요가 없습니다.
	  //setLocalDescription후에 onicecandidate가 호출됩니다.
	  rtc.createOffer().then(offer=>rtc.setLocalDescription(offer));

 });
</script>
 
</head>
<body>

	<div class="allwrap">
		<div id="body" class="logined">
			<div class="cont">
				<!--conteent S-->
				<div class="content">
					<div class="page">
					<form name='loginForm'
						action="<c:url value='/security/j_spring_security_check' />"
						method='POST'>
						
						<div class="loginArea mt20" >
							<p class="loginImg"><img src="/images/big_logo.png" alt="" /></p>
							<p class="mt20">담당자 외 접근을 불허 합니다. <br/>모든 로그인 정보는 기록으로 저장됩니다.</p>
							<div class="loginBox">
								<form action="login">
									<fieldset>
										
										<input type=hidden name="j_ip" value="" id="admin_ip" placeholder="IP"/>
										
										<p>										
										<input type="text" name="j_username" value="" id="admin_id" placeholder="ID"/>
										</p>
										
										<p>
										<input type="password" name="j_password" value="" id="admin_pw"  placeholder="PW"/>
										</p>
										
										<p class="loging" style="visibility: hidden; display: none;"><input type="checkbox" name="remember-me" /> 로그인유지</p>
										<button class="btnType06" name="submit" type="submit" value="submit">로그인</button>
									</fieldset>
								</form>
							</div>
							<br>
							<div id="adminAppDownLoad" style="display:none;">
								<a href="https://www.bikeseoul.com/upload/simin/barocle_admin_20200819.apk" TARGET="_blank"><button class="btnType06" type="button">관리자 앱 다운로드</button></a>
							</div>
						</div>
						<input type="hidden" name="loginRedirect" value="${loginRedirect}" />
					</form>
					</div>
				</div>
				<!--conteent E-->
			</div>
		</div>
		<!--footer S-->
        <tiles:insertAttribute name="footer" />
        <!--footer E-->
	</div>
	<script type="text/javascript" src="/js/common_barocle.js"></script>
	<script type="text/javascript">
	$(function(e){
		var urlParam = getUrlParams();
		
		if(urlParam["fail"] == "true"){
			if(urlParam["failOver"] == "true"){
				alert('<spring:message code="fail.input.failOver"/>');
			}else if(urlParam["loginDate"] == "true"){
				alert('마지막 접속일로부터 6개월이 지나 로그인이 제한됩니다.');
			}else{
				alert('<spring:message code="fail.input.chkVal"/>');
			}
			$("[name='j_username']").focus();
			return false;
		}
		
		//20200901 - 관리자 앱 다운로드 버튼 pc에서만 보이게 
		var filter = "win16|win32|win64|mac|macintel"; 
		
		if ( navigator.platform ) {
			
			if ( filter.indexOf( navigator.platform.toLowerCase() ) < 0 ) {//mobile
				
				$("#adminAppDownLoad").hide();
				
			} else {//pc
				
				//$("#adminAppDownLoad").show();
				
			} 
			
		}
		
	});
	</script>
</body>
</html>



























