	
		<!--footer S-->
		<div id="footer">
			<div class="foot">
				<input type="hidden" id="mainPage" name="mainPage"  value="${mainPage }">
				<p>Copyright ⓒ 2024 All right reserved</p>
			</div>
		</div>
		<form id="sessionLogoutForm" action="/j_spring_security_logout" method='POST'>
		</form>
		<!--footer E-->
<script type="text/javascript">

//F12 버튼 방지
// $(document).bind('keydown',function(e){
	
// 	if(e.keyCode == 123){
		
// 		e.preventDefault();
// 		e.returnValue = false;
		
// 	}
	
// });

//우클릭 방지
// $(document).bind('contextmenu',function (e){
// 	alert('오른쪽버튼을 이용할 수 없습니다.');
// 	return false;
	
// });

if($("#mainPage").val() != "Y"){
// 주석처리	
//	window.setTimeout("obstacleTimeChk()", 1000); 
}

//window.setTimeout("sessionTimeChk()", 9000);
//15분
//var intervalSession = setInterval("sessionTimeChk()", 9000000);
//1시간
//var intervalSession = setInterval("sessionTimeChk()", 36000000);
//3시간
var intervalSession = setInterval("sessionTimeChk()", 108000000);

function obstacleTimeChk(){
	/* clearInterval(timerId); */

	$.ajax({
		url : "/obstacleTimeCnt.do",
		type : "post",
		dataType : "json",
		data : "",
		async : false,
		beforeSubmit: function (data,form,option) {
            return true;
        },
		success : function(data){
			if(data.resultMessage == "Success"){
				//자전거_장애건수 한건이상일시 팝업을 띄어 사용자에게 알려준다.
				if(data.addVal > 0){
					var times = data.addVal *1000;
					window.setInterval("obstacleChk()", times); 
				}
			}
		},
		error : function(jqXHR, textStatus,errorThrown){
			if(jqXHR.status === 500 || jqXHR.status === 200){
			//	alert("에러가 발생했습니다. : " + textStatus);
			}
		    lodBarCtl.close();
		}
	});
} 

//setInterval("obstacleChk()", 10000); 

function obstacleChk(){
	/* clearInterval(timerId); */

	var top = 100;
	var left = 10;

	$.ajax({
		url : "/obstacleCnt.do",
		type : "post",
		dataType : "json",
		data : "",
		async : false,
		success : function(data){
			if(data.resultMessage == "Success"){
				//자전거_장애건수 한건이상일시 팝업을 띄어 사용자에게 알려준다.
				if(data.obsCnt > 0){
					window.open("/obstaclePopup.do","pop", "toolbar=no, location=no, directory=no, scrollbars=no, resizable=yes, top="+ top +", left="+ left +", width=700, height=420");
				}
			}
		},
		error : function(jqXHR, textStatus,errorThrown){
			if(jqXHR.status === 500 || jqXHR.status === 200){
			//	alert("에러가 발생했습니다. : " + textStatus);
			}
		    lodBarCtl.close();
		}
	});
} 

function sessionTimeChk()
{
	clearInterval(intervalSession);
	//alert("약 15분 동안 서비스 이용이 없어 로그아웃됩니다.");
	//alert("약 1시간 동안 서비스 이용이 없어 로그아웃됩니다.");
	alert("약 3시간 동안 서비스 이용이 없어 로그아웃됩니다.");
	document.getElementById("sessionLogoutForm").submit();
	
}

</script>	