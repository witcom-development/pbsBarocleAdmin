<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" /> 
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />
<meta name="description=" Content="" />
<title><tiles:insertAttribute name="title"/></title>
<tiles:insertAttribute name="resource"/>
</head>
<body>
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
					<tiles:insertAttribute name="left" />
				<!--left menu E-->
				<!--content S-->
				<div class="content">
					<div class="subject">
						<!--subject path S-->
						<tiles:insertAttribute name="subject" />
						<!--subject path E-->
					</div>
					<div class="page">
						<form id="frm">
							<input type="hidden"  name="bookDate" id="bookDate" value=""/>
							<input type="hidden"  name="senderId" id="senderId" value=""/>
							
							<input type="hidden"  name="yyyy" id="yyyy" value=""/>
							<input type="hidden"  name="mm" id="mm" value=""/>
							<input type="hidden"  name="dd" id="dd" value=""/>
							<input type="hidden"  name="hh" id="hh" value=""/>
							<input type="hidden"  name="ss" id="ss" value=""/>
							
							<fieldset>
								<table class="tb_type02 mt20">
									<colgroup>
										<col style="width:30%">
										<col style="width:70%">
									</colgroup>
									<tbody>
										<tr>
											<th class="top">수신 전화번호</th>
											<td class="top">
										   <span class="pholder input-text07"><label for="phonNo"></label><input id="phonNo" name="phonNo" type="text" maxlength="13" style="IME-MODE: disabled" ></span>
											</td>
										</tr>
										<tr>
											<th>발송 관리자</th>
											<td id="phoneTxt">
											<span style="width: 220px;" readonly="readonly"><input type="hidden" value="<%= com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil.getSessionAttribute(request, "usrId") %>"  id="loginId"> 
													<%= com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil.getSessionAttribute(request, "usrId") %></span>
											</td>
										</tr>
										<tr>
											<th>발송구분</th>
											<td>
												<select id="sendClsSlt" name="sendClsName" >
													<option value="">선택</option>
												</select>
											</td>
										</tr>
										<tr>
											<th>발송 수단 선택</th>
											<td>
												<span class="input-ck01">
													<input type="checkbox"  class="vm"  id="sendType1"  name="sendType" value="001" checked/>&nbsp;카카오톡/문자&nbsp;&nbsp;
													<!-- 알람은 우선 보이지 않도록 수정 2020.01.13 -->
													<!-- <input type="checkbox"  class="vm"  id="sendType2" name="sendType"  value="002" />&nbsp;알람 -->
												</span>
											</td>
										</tr>
										<tr>
										<tr>
											<th>예약발송</th>
											<td>
												<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04"  title="선택 날짜" id="bookingSend" readonly/></span>
												<div class="section pright" style="margin-top: 5px;">
												<span>
													<select name="bookHour" id="bookHour">
														<option value="">선택</option>
														<c:forEach begin="1" end="24" step="1" varStatus="loop">
															<c:if test="${loop.index < 10 }">
															<option value="0${loop.index }" >0${loop.index }</option>
															</c:if>
															<c:if test="${loop.index > 9 }">
															<option value="${loop.index }">${loop.index }</option>
															</c:if>
														</c:forEach>				  
													</select>시
													<select name="bookMinute" id="bookMinute">
														<option value="">선택</option>
														<c:forEach begin="0" end="59" step="1" varStatus="loop">
															<c:if test="${loop.index < 10 }">
															<option value="0${loop.index }" >0${loop.index }</option>
															</c:if>
															<c:if test="${loop.index > 9 }">
															<option value="${loop.index }">${loop.index }</option>
															</c:if>
														</c:forEach>
													</select>분
												</span>
												</div>
											</td>
										</tr>
										<tr>
											<th>발송내용</th>
											<td><textarea name="smsMsg" id="sendMsg" class="detatextarea" style="width: 99%;"></textarea></td>
											
										</tr>
									</tbody>
								</table>
								
								<div class="btnArea">
									<span class="right">
										<button type="button" class="btnType01 bc_green" id="sendBtn">발송</button>
									</span>	
								</div>
							</fieldset>
						</form>
					</div>
				</div>
				<!--content E-->
			</div>
		</div>
		<!--footer S-->
			<tiles:insertAttribute name="footer" />
		<!--footer E-->
	</div>
	
	<script type="text/javascript" src="/js/common_barocle.js"></script>
	<script type="text/javascript">
	$(function() {
		 var date = new Date();
		 var yyyy = date.getFullYear();		//년
		 var mm = date.getMonth()+1;		//월
		 var dd = date.getDate();			//일
		 var hh = date.getHours();			//시간
		 var ss = date.getMinutes();		//분
		 
		 
		$("#yyyy").val(yyyy);
		$("#mm").val(mm);
		$("#dd").val(dd);
		$("#hh").val(hh);
		$("#ss").val(ss);
		
		sendSms();
	});
	
	//화면 초기화
	function sendSms() {
		
		// 예약 날짜가 null 이면 시간 설정 못하게 막음.
		if($("#bookingSend").val() == '') {
			$("#bookHour").attr("disabled", "disabled");
			$("#bookMinute").attr("disabled", "disabled");
		}
		
		//발송구분 콤보박스 데이터
		commonAjax.getAjax("/common/pop/getSmsMessageList.do", "json",{},makeSmsSelect);
		
		//발송구분(selectbox) 변경시 
		$("#sendClsSlt").on("change", sendCdSltChange);
		
	  	//날짜 입력시
		$("#bookingSend").on("change", sendDateAdd);
		
		//발송버튼 클릭시
		$("#sendBtn").on("click", exeSendMsg);
	}
	
	//발송구분 변경시
	function sendCdSltChange(e) {
		e.preventDefault();
		var msg = $(e.target).find("option:selected").attr("msg");
		if(msg == null){
			$("#sendMsg").text('');
		}else{
			$("#sendMsg").text(msg);
		}
	}
	
	
	//예약날짜 입력시
	function sendDateAdd(e) {
		e.preventDefault();
		
		$('#bookHour').removeAttr("disabled"); 
		$('#bookMinute').removeAttr("disabled"); 
	}
	
	//화면 초기시 발송구분 selectList
	function makeSmsSelect(data) {
		if(data) {
			if(data.smsMsgList !== null) {
				var mSize = data.smsMsgList.length;
				for(var i=0; i<mSize; i+=1) {
					var $op = $("<option>", { value : data.smsMsgList[i].smsSeq, msg :data.smsMsgList[i].smsMsg }).text(data.smsMsgList[i].sendClsName);
					$("#sendClsSlt > option").last().after($op);
				}
			}
		}
	}
	
	// sms 발송
	function exeSendMsg(e) {
		e.preventDefault();
		var chk = 0;
		var bookDate ='';
		
		//예약 날짜만 있을 경우
		if($("#bookingSend").val() !== '') {
			if(($("[name='bookHour']").val() === '' &&  $("[name='bookMinute']").val() !== '') 
					|| ($("[name='bookHour']").val() !== '' &&  $("[name='bookMinute']").val() === '') 
					|| ($("[name='bookHour']").val() === '' &&  $("[name='bookMinute']").val() === '') ) {
				alert("발송 예약 시간을 설정해주십시오."); 
				chk = 1;
				return false;
			}
			bookDate = $("#bookingSend").val()+' '+$("[name='bookHour'").val()+':'+$("[name='bookMinute'").val();
			
			// 금일 이전 예약 설정 체크.
			var bookdt = $("#bookingSend").val().replace(/-/gi,'')+$("[name='bookHour'").val()+$("[name='bookMinute'").val();
			var ymdhs = $("#yyyy").val()+$("#mm").val()+$("#dd").val()+$("#hh").val()+$("#ss").val();
			
			if(parseInt(bookdt) <= parseInt(ymdhs)){
				alert("예약 시간을 현재시간 이후로 설정해주십시오."); 
				chk = 1;
				return false;
			}
			
			$("[name='bookDate']").val(bookDate);
			
		} else {
			  if($("[name='bookHour']").val() !== '' &&  $("[name='bookMinute']").val() !== '') {
				  alert("발송 예약 시간을 설정해주십시오."); 
				  chk = 1;
				  return false;
			  }
		}
		//폰번호 체크
		if($("#phonNo").val() === '') {
			alert('전화번호를 입력해 주십시오.');
			$("#phonNo").focus();
			chk = 1;
			return false;
		}
		
		//발송내용 체크
		if($("#sendMsg").val() === '') {
			alert('발송내용을 입력해 주십시오.');
			$("#sendMsg").focus();
			chk = 1;
			return false;
		}
		//발송수단 체크
		if(!$("#sendType1").prop("checked")&&!$("#sendType2").prop("checked")&&!$("#sendType3").prop("checked")) {
			alert('발송수단이 선택되지 않았습니다.');
			chk = 1;
			return false;
		}
		
		//history에 발송한 ID 저장
		$("#senderId").val($("#loginId").val());
		
		if(chk === 0) {
			 commonAjax.postAjax("/admin/service/policyMgmt/sendSms.do", "json",$("#frm").serialize()
				,function(data){
					 if(data) {
						 if(data.checkResult) {
							 alert("전송 되었습니다.[" +  data.checkResult +"]" );
							 document.location.reload();
							 
						 }
					 }
			}); 
		}
	}
	
	//수신 전화번호 숫자만 입력 가능
	$('#phonNo').keypress(function (event) {
		/* if (event.which && ((event.which <= 47) || (event.which >= 58)) && event.which != 8) {
		  event.preventDefault();
		} */
	});
	
	// 발송구분 선택후 발송내역 전체 삭제시 selectBox 초기화 한다.
	$('#sendMsg').keyup(function () {
		var inputLength = $(this).val().length;
		
		if(inputLength == 0 ){
			$('#sendClsSlt').find('option:first').attr('selected', 'selected'); 
		}

	});

	
	</script>
</body>
</html>