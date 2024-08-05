<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<script type="text/javascript" src="/js/common_barocle.js"></script>
<script type="text/javascript">
	
	// 2020-04-21 
	var grpCd = "" + ${userSessionVO.usrGrpCd};
		
	$(function() {
		
		
	/*	
		if('${info.sex_cd }' == "F"){
			$("#sex_f").prop('checked', true);
		}else if('${info.sex_cd }' == "M"){
			$("#sex_m").prop('checked', true);
		}
		
		*/
		if("${info.black_list}" == 0){
			$("#blackListInsert").css("display", "");
			$("#blackListDelete").css("display", "none");
		}else{
			$("#blackListInsert").css("display", "none");
			$("#blackListDelete").css("display", "");
		}
		
		$(".input-text09 input").keyup(function(){
			$(this).val($(this).val().replace(/[^0-9]/g,""));
		});
		
		if ("${info.usr_mpn_no  }".split("-").length == 3) {
				$("input[name=mpnNo1]").val("${info.usr_mpn_no }".split("-")[0]);
				$("input[name=mpnNo2]").val("${info.usr_mpn_no }".split("-")[1]);
				$("input[name=mpnNo3]").val("${info.usr_mpn_no }".split("-")[2]);
			}
		
		if ("${info.parent_mpn_no  }".split("-").length == 3) {
			$("input[name=mpnNoP1]").val("${info.parent_mpn_no }".split("-")[0]);
			$("input[name=mpnNoP2]").val("${info.parent_mpn_no }".split("-")[1]);
			$("input[name=mpnNoP3]").val("${info.parent_mpn_no }".split("-")[2]);
		}

		$(".page .tablist li").click(function() {
			//alert(this)
			//alert($(".page .tablist li").index(this));

			$(".page .tablist li").each(function() {
				$(this).attr("class", "");
			})
			$(this).attr("class", "on");

			var action = getAction($(".page .tablist li").index(this));

			$("#frm").attr("action", action);
			$("#frm").submit();

		});

		$("#mobiletableList").change(function() {

			var action = getAction($("#mobiletableList").val());
			$("#searchStartDate").val("");
			$("#searchEndDate").val("");
			$("#currentPageNo").val(1);

			$("#frm").attr("action", action);
			$("#frm").submit();
		})
		
		 //상태코드
        /* commonAjax.getCommonCode("TEC", function(data) {
             if(data !== null && data.codeList !== null) {
                 commCdBox.makeComboBox('CC',_this.selecrTelecomClsCd, data.codeList, "a1");
             }
        }); */
        
        // 20200422
		$("#mainType").val("${info.mainType}").prop("selected", true);
	});

	function getAction(idx) {

		var actionValue = "";
		switch (Number(idx)) {
		case 0:
			actionValue = "/admin/service/member/memberInfo.do";
			break;
		case 1:
			actionValue = "/admin/service/member/memberPaymentList.do";
			break;
		case 2:
			actionValue = "/admin/service/member/memberUseList.do";
			break;
		case 3:
			actionValue = "/admin/service/member/memberMileage.do";
			break;
		case 4:
			actionValue = "/admin/service/member/memberPenalty.do";
			break;
		case 5:
			actionValue = "/admin/service/member/memberRefundList.do";
			break;
		case 6:
			actionValue = "/admin/service/member/memberUnpaidList.do";
			break;
		case 7:
			actionValue = "/admin/service/member/memberVoucherList.do";
			break;
		case 8:
			actionValue = "/admin/service/member/memberGiftList.do";
			break;
		}
		return actionValue;
	}

	function fn_list() {

		if ("${info.black_list}" == 0 || "${listType}" == "U") {
			$("#frm").attr("action", "/admin/service/member/memberList.do");
		} else {
			$("#frm").attr("action", "/admin/service/member/listBlackList.do");
		}
		$("#frm").submit();
	}

	function fn_Reset() {

		if ( confirm("비밀번호를 초기화하시겠습니까?")) {
			
			$.post("/admin/service/member/resetPasswordAjax.do", "usr_seq="
					+ $("#usr_seq").val(), function(data) {
				if (data.resultMsg == "성공") {
					
					alert("비번 : 1234");
				} else {
					alert('<spring:message code="fail.request.msg" />');
				}
			});
			
		}
	}	
	
	function fn_Unsubscribe() {
		
		if (confirm('<spring:message code="common.delete.alert.msg" />')) {
			if ('${rentYn == "Y"}' == 'true') {
				alert('대여중에는 탈퇴가 불가능합니다.');
				return;
			}
			if ('${remainPayYn == "Y"}' == 'true') {
				alert('미납요금이 존재합니다. 요금 완납 처리 이후 탈퇴가 가능합니다.');
				return;
			}
			if ('${useVoucherYn == "Y"}' == 'true') {
				if (!confirm('이용권 기간이 남아있습니다. 강제회원탈퇴 처리하시겠습니까?')) {
					return;
				}
			}
			if ('${remainVoucherYn == "Y"}' == 'true') {
				if (!confirm('미사용 이용권이 남아있습니다. 강제회원탈퇴 처리하시겠습니까?')) {
					return;
				}
			}
			if ('${blackListYn == "Y"}' == 'true') {
				if (!confirm('블랙리스트로 등록된 사용자입니다. 회원탈퇴 시 재가입이 불가능합니다 강제회원탈퇴 처리하시겠습니까?')) {
					return;
				}
			}

			$.post("/admin/service/member/memberUnsubscribe.do", "usr_seq="
					+ $("#usr_seq").val(), function(data) {
				if (data.resultMsg == "성공") {
					alert('<spring:message code="success.common.out" />');
					var userEmail = '${info.mb_email_name }';
					var userId = '${info.mb_id}';
					var parameter = {};
					parameter.email = userEmail;
					parameter.val1 = userId;
					parameter.biz_id = "seoulbikego";
					var comCd = "TPL_005";
					$.ajax({
						type : 'post',
						url : '/commonCode/getCommonCodeVal.do',
						dataType : 'json',
						data : {
							comCd : comCd
						},
						async : false,
						success : function(data) {
							parameter.templateNo = data.templateNo;
							sendEmail(parameter);
							fn_list();
						},
						error : function(jqXHR, textStatus, errorThrown) {
							if (jqXHR.status === 500) {
								alert(textStatus);
							} else {
								return false;
							}
							//console.log(textStatus);
						}
					});
				} else {
					alert('<spring:message code="fail.request.msg" />');
				}
			});
		}
	}

	function changeButton() {

		$("#blackListInsert").css("display", "none");
		$("#blackListDelete").css("display", "");
	}

	function blackListDel() {

		if (confirm("블랙리스트 해지 하시겠습니까?? 등록된 모든 벌점이 삭제 됩니다.")) {
			$.post("/admin/service/member/delBlackListAjax.do", "usrSeq="
					+ $("#usr_seq").val(), function(data) {
				if (data.isDel) {
					$("#blackListInsert").css("display", "");
					$("#blackListDelete").css("display", "none");
				}

			});
		}
	}

	function fn_MemberCheckSms() {
		var allData = {
			"mb_id" : '${info.mb_id }',
			"usr_mpn_no" : '${info.usr_mpn_no }'
		};
		if (confirm("회원확인 SMS를 발송하시겠습니까?")) {
			$.ajax({
				type : "POST",
				url : "/admin/service/member/smsSend.do",
				dataType : "json",
				data : allData,
				success : function(data) {
					if (data) {
						if (data.isSuccess == "true") {
							alert("알람이 발송되었습니다.");
						}
					}
				}
			});
		}
	}
	
	function fn_MemberParentCheckSms() {
		var allData = {
			"mb_id" : '${info.mb_id }',
			"usr_mpn_no" : '${info.parent_mpn_no }'
		};
		if (confirm("보호자확인 SMS를 발송하시겠습니까?")) {
			$.ajax({
				type : "POST",
				url : "/admin/service/member/smsSend.do",
				dataType : "json",
				data : allData,
				success : function(data) {
					if (data) {
						if (data.isSuccess == "true") {
							alert("알람이 발송되었습니다.");
						}
					}
				}
			});
		}
	}
	
	// 결제수단 삭제
	function fn_DeltePaymentMethod() {
		
		 switch( grpCd ) {
			 case "15" :
			 case "12" :	 
			break;	 
			default :											 
				alert("권한이 없습니다.");
				return;
		 }
		
		var allData = {
				"usr_seq" : '${info.usr_seq }',
		};
		if (confirm("추가 과금 수단을 삭제하시겠습니까?")) {
			$.ajax({
				type : "POST",
				url : "/admin/service/member/deleteAddPayMethod.do",
				dataType : "json",
				data : allData,
				success : function(data) {
					if (data) {
						alert( data.resultMsg + "되었습니다.");
					}
				}
			});
		}
	}
	
	
	function fn_MemberCheckAlram() {
		var allData = {
			"usr_seq" : '${info.usr_seq }',
			"push_yn" : '${info.push_yn }',
			"usr_mpn_no" : '${info.usr_mpn_no }'
		};
		if (confirm("회원확인 알람을 발송하시겠습니까?")) {
			$.ajax({
				type : "POST",
				url : "/admin/service/member/pushSend.do",
				dataType : "json",
				data : allData,
				success : function(data) {
					if (data) {
						if (data.isSuccess == "true") {
							alert("SMS가 발송되었습니다.");
						}
					}
				}
			});
		}
	}
	
	function fn_validate(){
		
		if(!$("input[name=mpnNo1]").val() || !$("input[name=mpnNo2]").val() || !$("input[name=mpnNo3]").val()){
			alert('<spring:message code="fail.input.emptyValue2" arguments="휴대전화 번호"/>');
			return false;
		}
		
		// parent_mpn_no
		
		if($("input[name=parent_mpn_no]").val() && (!$("input[name=mpnNoP1]").val() || !$("input[name=mpnNoP2]").val() || !$("input[name=mpnNoP3]").val()) ){
			alert('<spring:message code="fail.input.emptyValue2" arguments="휴대전화 번호"/>');
			return false;
		}
		
		var frm = document.frm;
		frm.mpn_no.value = frm.mpnNo1.value+'-'+frm.mpnNo2.value+'-'+frm.mpnNo3.value;
		frm.parent_mpn_no.value = frm.mpnNoP1.value+'-'+frm.mpnNoP2.value+'-'+frm.mpnNoP3.value;
		 
		 $("#frm").attr("action", "/admin/service/member/memberSaveInfo.do");
		 
		 commonAjax.postAjax("/admin/service/member/memberSaveInfo.do", "json", 
	   				$("#frm").serialize(), 
	   				function(data) {
		   				if(data) {
							if(data.resultMsg == "성공") {
								alert("저장되었습니다.");
								//penForm.moveList();
							} else {
								alert("저장 실패하였습니다.");
							}
						}	
			});
		
	}
	

	// 2021-05-01
	function fn_pushDetail(){
		
		
		
		
	}
	
	
	// 2021-05-01
	function fn_push() {
		var userId = '${info.mb_id}';
		
		if ( userId == "" ){
			alert("회원만 조회가능합니다.");
			return;	
		}
		
	   	$.ajax({
			url : "/admin/service/push/pushUserInfo.do",
			type : "post",
			dataType : "json",
			data : {searchValue:userId},
			/* data : $("#searchFrm").serialize(), */
			async : false,
	   		beforeSubmit: function (data,form,option) {
				return true;
			},
			success : function(data){
				if ( data.pushUser == null ) {
					alert("미등록되었습니다.");
					return;
				}
				
				$("#osType").html(data.pushUser.pnsid);
				$("#osVersion").html(data.pushUser.os_VER);
				$("#push_HP").html(data.pushUser.device_MD);
				$("#appVersion").html(data.pushUser.app_VER);
				$("#push_REG").html(data.pushUser.regdate);
				$("#push_MOD").html(data.pushUser.moddate);
				// userseqno: "561562"
			},
			error : function(jqXHR, textStatus,errorThrown){
				if(jqXHR.status === 500 || jqXHR.status === 200){
					alert("에러가 발생했습니다. : " + textStatus);
				}
			}
		});
	}	
	
	
	function getPushDetail(){
		document.getElementById('light').style.display='block';document.getElementById('fade').style.display='block';
		
		var userId = '${info.mb_id}';
			
		if ( userId == "" ){
			alert("회원만 조회가능합니다.");
			return;	
		}
		$('#pushWrap table tbody tr').remove();
		
	   	$.ajax({
			url : "/admin/service/push/pushSuccessList.do",
			type : "post",
			dataType : "json",
			data : {searchValue:userId},
			/* data : $("#searchFrm").serialize(), */
			async : false,
	   		beforeSubmit: function (data,form,option) {
				return true;
			},
			success : function(data){
				if ( data.pushSuccessList == null ) {
					alert("미등록되었습니다.");
					return;
				}
				
				var pushList = data.pushSuccessList;
				var $listTbody = $("#pushWrap #pushList	tbody");
				// +  "</td><td>" + val.readdate 
				pushList.forEach(function(val) {
			        $listTbody.append("<tr><td>" + val.pnsid + "</td><td>" + val.regdate  +  "</td><td>" + val.sub_TITLE +  "</td><td style='text-align:left'>" + val.message +"</td></tr>");
			    });
			},
			error : function(jqXHR, textStatus,errorThrown){
				if(jqXHR.status === 500 || jqXHR.status === 200){
					alert("에러가 발생했습니다. : " + textStatus);
				}
			}
		});
	   	
	   	
	   	$.ajax({
			url : "/admin/service/push/getPushFailList.do",
			type : "post",
			dataType : "json",
			data : {searchValue:userId},
			/* data : $("#searchFrm").serialize(), */
			async : false,
	   		beforeSubmit: function (data,form,option) {
				return true;
			},
			success : function(data){
				if ( data.pushSuccessList == null ) {
					alert("미등록되었습니다.");
					return;
				}
				
				var pushList = data.pushSuccessList;
				var $listTbody = $("#pushWrap #pushFailList	tbody");
				
				pushList.forEach(function(val) {
			        $listTbody.append("<tr><td>" + val.pnsid + "</td><td>" + val.regdate +  "</td><td>" + val.resultmsg  +  "</td><td style='text-align:left'>" + val.message +"</td></tr>");
			    });
			},
			error : function(jqXHR, textStatus,errorThrown){
				if(jqXHR.status === 500 || jqXHR.status === 200){
					alert("에러가 발생했습니다. : " + textStatus);
				}
			}
		});
	   	//pushFailList
	}
	
	function closePushDetail(){
		
		document.getElementById('light').style.display='none';document.getElementById('fade').style.display='none';
	}
	
/* 	
	$(function(){
		  $('#pushList').tablesorter(); 
	}); */
</script>

<style>
	.black_overlay {
	  display: none;	 position: absolute;		  top: 0%;	  left: 0%;
	  width: 100%;			height: 100%;			  background-color: black;
	  z-index: 1001;	  -moz-opacity: 0.8;		  opacity: .80;			  filter: alpha(opacity=80);
	}
	.white_content {
	  display: none;	  position: absolute;		  top: 10%;	  left: 10%;
	  width: 80%;		  height: 80%;				  padding: 16px;
	  border: 16px solid orange;	  background-color: white;	  z-index: 1002;	  overflow: auto;
	}

	#pushWrap 					{	float: left;	width: 100%;	}
	#pushWrap table				{	width: 100%;	margin-top:30px;margin-bottom: 30px;}
	
	#pushWrap thead				{	cursor: pointer;  background: #c9dff0;	}
	#pushWrap thead tr th 		{	font-weight: bold;	padding: 12px 30px;	padding-left: 42px; }
	#pushWrap thead tr th span 	{	padding-right: 20px;  background-repeat: no-repeat;  background-position: 100% 100%;	}
	#pushWrap thead tr th.headerSortUp, #keywords thead tr th.headerSortDown {  background: #acc8dd;	}
	#pushWrap tbody tr 			{	  color: #555;	}
	#pushWrap tbody tr td 		{  text-align: center;  padding: 15px 10px;}	
	#pushWrap tbody tr td.lalign {  text-align: left;	}

	</style>
	
</head>
<body>

<!-- PUSH 팝업 -->
	<div id="light" class="white_content">
		<div style="float:right"><a href="javascript:void(0)" onclick="closePushDetail()">Close</a></div>
		<div id="pushWrap">
			<h1>성공내역</h1>
	  		<table id="pushList">
				<colgroup>
					<col style="width:10%">
					<col style="width:20%">
					<%-- <col style="width:20%"> --%>
					<col style="width:10%">
					<col style="width:40%">
				</colgroup>
				<thead>
					<tr>
						<th scope="col">HP</th>
						<th scope="col">등록일자</th>
						<!-- <th scope="col">확인일자</th> -->
						<th scope="col">구분</th>
						<th scope="col">메시지</th>
					</tr>
				</thead>
				<tbody>
					<tr>
					</tr>
				</tbody>
	  		</table>
	  		<h1>실패내역</h1>
	  		<table id="pushFailList">
				<colgroup>
					<col style="width:10%">
					<col style="width:20%">
					<col style="width:30%">
					<col style="width:40%">
				</colgroup>
				<thead>
					<tr>
						<th scope="col">HP</th>
						<th scope="col">등록일자</th>
						<th scope="col">오류내용</th>
						<th scope="col">메시지</th>
					</tr>
				</thead>
				<tbody>
					<tr>
					</tr>
				</tbody>
	  		</table>
	  	</div>	
	</div>
	<div id="fade" class="black_overlay"></div>
<!-- // END -->

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
				<!--conteent S-->
<form  method="post"	name="frm"	 id="frm">
<input type="hidden" id="mpn_no" name="mpn_no"/>
<input type="hidden" id="parent_mpn_no" name="parent_mpn_no"/>
<div class="content">
					<div class="subject">
						<!--subject path S-->
							<tiles:insertAttribute name="subject" />
						<!--subject path E-->
					</div>
					
			
					
					
					<div class="page">
						<ul class="tablist mt20">
							<li class="on"><a href="#">회원정보</a></li>
							<li><a href="#">결제이력</a></li>
							<li><a href="#">이용이력</a></li>
							<li><a href="#">마일리지 이력</a></li>
							<li><a href="#">벌점이력</a></li>
							<li><a href="#">환불이력</a></li>
							<li><a href="#">미납이력</a></li>
							<li><a href="#">이용권</a></li>
							<li><a href="#">선물</a></li>
						</ul>
						<select  id="mobiletableList" class="tablist_m">
							<option value="0" selected="selected">회원정보</option>
							<option value="1">결제이력</option>
							<option value="2" >이용이력</option>
							<option value="3">마일리지이력</option>
							<option value="4">벌점이력</option>
							<option value="5">환불이력</option>
							<option value="6">미납이력</option>
							<option value="7">이용권</option>
							<option value="8">선물</option>
						</select>
						<table class="tb_type02 mt20">
								<colgroup>
									<col style="width:20%" />
									<col style="width:30%" />
									<col style="width:20%" />
									<col style="width:30%" />
								</colgroup>
							<tbody>
								<tr>
									<th>아이디</th>
									<td>
										${info.mb_id }
										<input type="hidden" name="usr_seq" id="usr_seq" value="${info.usr_seq }">
									</td>
									<th>생년월일</th>
									<td>${info.usr_birth_date }</td>
								</tr>
								<tr>
									<th>성별</th>
									<td>
										<c:choose>
									      <c:when test="${info.sex_cd == 'M'}">남</c:when>
									      <c:otherwise>여</c:otherwise>
									    </c:choose>
									</td>
									<th>즐겨찾기</th>
									<td>
										<select name="mainType" id="mainType" >
											<option value="map">지도보기</option>
											<option value="text">즐겨찾기</option>
										</select>
									 </td>
								</tr>
								<tr>
									<th>휴대폰번호/분실여부</th>
									<td colspan="3"> 
										<span class="input-text09"><input type="text" maxlength="3" name="mpnNo1"/></span>
										<span class="dash">-</span>
										<span class="input-text09"><input type="text" maxlength="4" name="mpnNo2"/></span>
										<span class="dash">-</span>
										<span class="input-text09"><input type="text" maxlength="4" name="mpnNo3"/></span>
										<%-- ${info.usr_mpn_no } --%> / ${info.mpn_lost_yn }
										<span class="pl10"><button class="btnType02"  onclick="fn_MemberCheckSms();" type="button">회원확인SMS</button></span>
										<!-- 2018-09-20 추가 -->
										<span class="input-text09"><input type="text" maxlength="12" name="mpnNoAll" style="width:80px" value="${info.usr_mpn_no}"></span>
										<span class="pl10"><button class="btnType02"  onclick="fn_MemberCheckAlram();" type="button">회원확인알람</button></span>
									</td>
								</tr>
								<tr>
									<th>법적 대리인 정보</th>
									<td colspan="3">
										<span class="input-text09"><input type="text" maxlength="3" name="mpnNoP1"/></span>
										<span class="dash">-</span>
										<span class="input-text09"><input type="text" maxlength="4" name="mpnNoP2"/></span>
										<span class="dash">-</span>
										<span class="input-text09"><input type="text" maxlength="4" name="mpnNoP3"/></span>
										<span class="pl10"><button class="btnType02"  onclick="fn_MemberParentCheckSms();" type="button">보호자확인 SMS</button></span>
										<!-- 2018-09-20 추가 -->
										 / ${info.parent_birth_date } / ${info.parent_sex_cd }
									</td>
								</tr>
								<tr>
									<th>이메일</th>
									<td>${info.mb_email_name }</td>
									<th>체중</th>
									<td>${info.mb_wgt }</td>
								</tr>
								<tr>
									<th>추가 과금 수단</th>
									<td>${addCharge.mlang_com_cd_name}&nbsp;&nbsp; 
										<!-- 20210809 추가 -->
										<c:if test="${fn:length(addCharge.mlang_com_cd_name) > 0}">
											<button class="btnType02"  onclick="fn_DeltePaymentMethod();" type="button">삭제</button>
										</c:if>
										
									</td>
									<th>사용자 구분</th>
									<td>${info.mlang_com_cd_name }</td>
								</tr>
								<tr>
								</tr>
								<tr>
									<th>대여 회원 카드 </th>
									<td colspan="3">
										( ${cardInfo.mlang_com_cd_name } ) 
										<script type="text/javascript">
											 switch( grpCd ) {
												 case "15" :
												 case "12" :	 
													 document.write("${cardInfo.mb_card_no }");
												break;	 
												default :											 
												if("${cardInfo.mb_card_no }".length == 19){
													var str = "${cardInfo.mb_card_no }";
													document.write(str.substring(0, 4)+" - " +str.substring(5, 9) +" - **** - " +str.substring(15));
												}
											 }
										</script>
										/ 등록일 : ${cardInfo.reg_dttm}
									</td>
								</tr>
								<tr>
									<th>환승 회원 카드 </th>
									<td  colspan="3">
										( ${transCardInfo.mlang_com_cd_name } ) 
										 <script type="text/javascript">
										 switch( grpCd ) {
											 case "15" :
											 case "12" :	 
												 document.write("${transCardInfo.mb_card_no }");
											break;	 
											default :											 
											if(("${transCardInfo.mb_card_no }".length == 18) || ("${transCardInfo.mb_card_no }".length == 19)){
												var str = "${transCardInfo.mb_card_no }";
												document.write(str.substring(0, 4)+" - " +str.substring(5, 9) +" - **** - " +str.substring(15));
											}
										 }
										</script>
										/ 등록일 : ${transCardInfo.reg_dttm}
									</td>
								</tr>
								<c:if test="${safetyCertInfoVO ne null}">
								<tr>
									<th>안전교육 합격자 <br> 여부</th>
									<td>합격자</td>
									<th>합격자 인증제 <br> 할인기간(2년)</th>
									<td>
									          ${fn:substring(safetyCertInfoVO.disSDttm,0,10)} ~  ${fn:substring(safetyCertInfoVO.disEDttm,0,10)}
									</td>
								</tr>
								</c:if>
								<tr>
									<th>앱 정보</th>
									<td colspan="3">
										<table style="width:100%">
											<colgroup>
												<col style="width:18%" />
												<col style="width:30%" />
												<col style="width:18%" />
												<col style="width:30%" />
											</colgroup>
											<tr>
												<th>OS</th><td id="osType"></td><th>OS VER</th><td id="osVersion"></td>
											</tr>	
											<tr>
												<th>HP</th><td id="push_HP"></td><th>앱 VER</th><td id="appVersion"></td>
											</tr>
											<tr>
												<th>등록일</th><td id="push_REG"></td><th>수정일</th><td id="push_MOD"></td>
											</tr>
										</table>
										<div style="float: right; padding: 10px;">
											<a class="btnType01" style="background:#A52A2A" href="javascript:void(0)" onclick="getPushDetail()">PUSH 발송내역 조회</a>
										</div>	
									</td>
								</tr>
							</tbody>
						</table>
						<div class="btnArea">
							<span class="left" onclick="fn_list(); return false;"><button class="btnType01 bc_gray">목록</button></span>
							<span class="right">
								
								
									<button class="btnType01" style="padding:12px; background: #A0522D;" onclick="fn_push(); return false;">푸쉬정보 조회</button>
								
									<button class="btnType01" style="padding:12px; background: #8B4513" onclick="fn_Reset(); return false;">비번 초기화</button>
								
									<button class="btnType01" style="padding:12px;" onclick="fn_Unsubscribe(); return false;">강제 회원탈퇴</button>
								
									<a href="/admin/service/member/blackListRegFormPop.do" id="blackListInsert" style="display: none;"
                                  			class="winNewPop modal" title="블랙리스트 등록"	data-width="450" data-height="250"  
                                  			data-pmt="&usr_seq=${info.usr_seq}">
                                  	<button class="btnType01 bc_green" style="padding:12px; background: #FFDAB9; color:black" type="button">블랙리스트 등록</button></a>
									<button class="btnType01 bc_green" style="padding:12px; background: #FFDAB9"  id="blackListDelete" style="display: none;" type="button" onclick="blackListDel();">블랙리스트 해지</button>
									<button class="btnType01 bc_green" style="padding:12px;"  onclick="fn_validate(); return false;">저장</button>
							</span>	
						</div>
					</div>
				</div>
			</form>
				<!--content E-->
	
			</div>

		</div>
		
		
		<!--footer S-->
			<tiles:insertAttribute name="footer" />
		<!--footer E-->
	</div>
	
	
	
	
</body>
</html>
