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
<meta content="text/html; charset=KSC5601" http-equiv="content-type" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" /> 
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />
<meta name="description=" Content="" />
<title><tiles:insertAttribute name="title"/></title>
<tiles:insertAttribute name="resource"/>
<script type="text/javascript" src="/js/common_barocle.js"></script>
<script type="text/javascript">
//<![CDATA[
	
	/* 페이지 로드 */
	$(document).ready(function(){
		/* 목록 버튼 클릭시 */
		$('#btn_list').click(function() {
			fn_list();
		});
		
		$("#btn_save").click(function(e){
			e.preventDefault();
			if(!isEmptyDmsgF("musicGb", "음악구분을")) return;
			if(!isEmptyDmsgF("musicTp", "음악유형를")) return;
			if(!isEmptyDmsgF("musicNm", "음악명을")) return;
			if(!isEmptyDmsgF("sngrNm", "가수명을")) return;
// 			if(!isEmptyDmsgF("cont", "내용를")) return;
			fn_save();
		});
		
	});
	
	/* 엑셀 다운로드 */
	function fn_duplStationCheck(){
		if("${cmd}" == "INFO"){
			if($("#station_no").val() == $("#checkNo").val()){
				alert('<spring:message code="fail.duplicated.data" arguments="정거장 번호"/>');
				return;
			}
		}
		
		if(!$("#station_no").val()){
			alert('<spring:message code="fail.input.emptyValue2" arguments="정거장 번호"/>');
			$("#station_no").focus();
			return;
		}
		
		if($("#station_no").val().length != 5){
			alert('<spring:message code="fail.input.chkLength" arguments="5"/>');
			$("#station_no").focus();
			return;
		}
		
		$.post("/admin/manage/station/stationNumberCheck.do", "station_no=" + $("#station_no").val()  , function(data) {
			if(data.result == "ok"){
				alert('<spring:message code="success.duplicationCheck.isNot" arguments="정거장 번호"/>');
				$("#checkNo").val($("#station_no").val());
			}else{
				alert('<spring:message code="fail.duplicated.data" arguments="정거장 번호"/>');
			}
		});
	}
	
	function fn_duplStationNameCheck(){
		if("${cmd}" == "INFO"){
			if($("#LAG_001").val() == $("#checkName").val()){
				alert('<spring:message code="fail.duplicated.data" arguments="정거장 명"/>');
				return;
			}
		}
		
		if(!$("#LAG_001").val()){
			alert('<spring:message code="fail.input.emptyValue1" arguments="정거장 명"/>');
			return;
		}
		
		$.post("/admin/manage/station/stationNumberCheck.do", "station_name=" + $("#LAG_001").val()  , function(data) {
			if(data.result == "ok"){
				alert('<spring:message code="success.duplicationCheck.isNot" arguments="정거장 명"/>');
				$("#checkName").val($("#LAG_001").val());
			}else{
				alert('<spring:message code="fail.duplicated.data" arguments="정거장 명"/>');
			}
		});
	}
	
	function checkBeacon(num){
		var checkSerial = null;
		
		if(num == 1){
			checkSerial = $("#beaconId1").val();
		}else{
			checkSerial = $("#beaconId2").val();
		}
		
		$.post("/admin/manage/station/beaconCheck.do", "beaconId1=" + checkSerial  , function(data) {
			if(data.result == "ok"){
				alert('<spring:message code="success.duplicationCheck.isNot" arguments="비콘 번호"/>');
			}else{
				alert('<spring:message code="fail.duplicated.data" arguments="비콘 번호"/>');
			}
		});
	}
	
	function fn_list(){
		$("#staImgFile").val("");
		$("#frm").attr("action", "/admin/manage/station/stationList.do");
		$("#frm").submit();
	}
	
	$(function() {
		var date = new Date;
		date.setDate(date.getDate()+30);
		var today = DateUtil.dateFmt(date);
		var fromday = DateUtil.dateFmt(new Date()); 
		var sDate =fromday;
		var eDate =today;
		
		if ('${info.unuse_str_dttm}' !== '0000-00-00 00:00:00' && '${info.unuse_str_dttm}' !== '') {
			sDate = '${info.unuse_str_dttm}'
		}
		
		if ('${info.unuse_end_dttm}' !== '0000-00-00 00:00:00' && '${info.unuse_end_dttm}' !== '') {
			eDate = '${info.unuse_end_dttm}'
		}
		
		$("[name='unuse_str_dttm']").val(sDate);
		$("[name='unuse_end_dttm']").val(eDate);
		
		if("${result }" != ""){
			alert("${result}")
		}
		
		$("#station_no").keyup(function(){
			$(this).val($(this).val().replace(/[^0-9]/g,""));
		});
		
		if("${cmd}" == "INFO"){
			$("select[name=station_grp_seq]").val("${info.station_grp_seq}");
			$("#station_no").val('${info.station_no }');
			$("#checkNo").val('${info.station_no }');
			
			"<c:forEach items='${stationName }' var='lang'>"
				$("#"+"${lang.lang_cls_cd}").val("${lang.station_name}");
			"</c:forEach>"
			
			$("#checkName").val($("#LAG_001").val());
			$("select[name=station_cls_cd]").val("${info.station_cls_cd}");
			$("#station_post_no").val("${info.station_post_no }");
/* 			$("#station_post_no1").val($("#station_post_no").val().substring(0,3));
			$("#station_post_no2").val($("#station_post_no").val().substring(3)); */
			$("#station_addr1").val("${info.station_addr1 }");
			$("#station_addr2").val("${info.station_addr2 }");
			$("#station_latitude").val("${info.station_latitude }");
			$("#station_longitude").val("${info.station_longitude }");
			$("#memo").val("${info.memo }");
			$("#dstnc_lt").val("${info.dstnc_lt }");
			
			if('${info.station_use_yn }' == "Y"){
				$("#station_use_y").prop('checked', true);
			}else if('${info.station_use_yn }' == "N"){
				$("#station_use_n").prop('checked', true);
			}else if('${info.station_use_yn }' == "C"){
				$("#station_use_c").prop('checked', true);
			}else if('${info.station_use_yn }' == "R"){
				$("#station_use_r").prop('checked', true);
			}else if('${info.station_use_yn }' == "T"){
				$("#station_use_t").prop('checked', true);
				$("#unuseDate").css("display","");
			}else{
				$("#station_use_s").prop('checked', true);
				$("#unuseDate").css("display","");
			}
			
			if("${info.device_id}" != ""){
				$("select[name=device_id]").append("<option value='${info.device_id}' selected>${info.device_id}");
			}
			
			$("#rockCnt").text("${info.rockCnt}");
			$("#reason").text("${info.reason}");
			//$("#btn_addCode").on("click",this.clickAddCodeFormFnc);
			
			commcodeEdit.initBtn('');
		}
		
		$("#staImgFile").on('change', function(){
			readURL(this);
		});
		
		$("[name='station_use_yn']").on("change",  function(){
			var radioVal = $(':radio[name="station_use_yn"]:checked').val();
			if (radioVal == "T" || radioVal == "S" ) {
				$("#unuseDate").css("display","");
				$("#reason").css("display",""); 
			} else {
				$("#unuseDate").css("display","none"); 
				$("#reason").css("display","none"); 
			}
		});
		
		commonAjax.getCommonCode("RAK", function(data){
			if(data !== null && data.codeList !== null) {
				var code = new Array();
				for(var i =0; i <data.codeList.length ;i++) {
					code.push(data.codeList[i]);
				}
				commCdBox.makeComboBox('CC', '${info.station_se_cd}', code, "station_se_cd");
			}
		});
		
		commonAjax.getCommonCode("ENT", function(data){
			if(data !== null && data.codeList !== null) {
				var code = new Array();
				 for(var i =0; i <data.codeList.length ;i++) {
						 code.push(data.codeList[i]);
				 }
				 commCdBox.makeComboBox('CC', '${info.rack_entrps_cd}', code, "rack_entrps_cd");
			}
		});
		
		 $("#station_se_cd").change(function(){ 
				$("#station_se_cd option:selected").each(function(){
					var stSe = $(this).val();
					if(stSe !== "RAK_001"){
						$("#qrRack").css("display","");
					}else{
						$("#qrRack").css("display","none");
						$("#rack_entrps_cd option:eq(0)").attr("selected", "selected");
					}
				});
		 });
		  
		 // 사유 직접입력
		 $("#selboxDirect").hide();
		 $("#selbox").change(function() {
		 	if($("#selbox").val() == "") {
		 		$("#selboxDirect").show();
		 	}  else {
		 		$("#selboxDirect").hide();
		 	}
		 })
	});

	/* 소속 팀 리스트 조회 */
// 	$.getJSON('/admin/manage/relocationCar/getTeamList.do',function(data){
// 		$.each(data.dataList,function(key,val){
// 			$("[name=team_seq]").append('<option value="' + this.teamSeq + '">' + this.centerNm + '|' + this.teamNm + '</option>');
// 		})
// 		var initValue = '<c:out value="${info.team_seq}"/>';
// 		if(initValue!=''){ $("[name=team_seq]").val(initValue); }
// 	});	
	
	function vallidateModify( flag, id ){
		if(!$("select[name=station_grp_seq]").val()){
			alert('<spring:message code="fail.input.emptyValue1" arguments="아파트"/>');
			$("select[name=station_grp_seq]").focus();
			return false;
		}
		
		if(!$("#station_no").val()){
			alert('<spring:message code="fail.input.emptyValue2" arguments="정거장 번호"/>');
			$("#station_no").focus();
			return false;
		}
		
		if($("#station_no").val() != $("#checkNo").val()){
			alert('<spring:message code="fail.input.emptyValue2" arguments="정거장 번호 중복검사"/>');
			return false;
		}
		
		var temp  = false;
		$("input[name=nameList]").each(function(){
			//alert($(this).val())
			if(!$(this).val()){
				alert('<spring:message code="fail.input.emptyValue1" arguments="정거장 명"/>');
				$(this).focus();
				temp = true;
				return false;
			}
		});
		
		if(temp){
			return false;
		}
		if($("input[name=nameList]").val() != $("#checkName").val()){
			alert('<spring:message code="fail.input.emptyValue2" arguments="정거장 명 중복검사"/>');
			return false;
		}
		
		// 2020-08-12 팀도 필수입력으로 변경
// 		if($("[name='team_seq']").val() == '' || !$("[name='team_seq']").val() ){
			
// 			alert('<spring:message code="fail.input.emptyValue2" arguments="팀 (은)"/>');
// 			return false;
// 		}
		
		// 2019-08-16
		// !$("#station_post_no").val() ||
		// !$("#station_addr2").val()
		if(!$("#station_addr1").val() ){
			alert('<spring:message code="fail.input.emptyValue2" arguments="주소"/>');
			return false;
		}	
		
		if(!$("input[name=station_use_yn]").is(":checked")){
			alert('<spring:message code="fail.input.emptyValue2" arguments="사용여부"/>');
			return false;
		}
		
		/* if($("input[name=station_use_yn]").val() == "T" || $("select[name=station_use_yn]").val()== "S" ){
			if($("input[name=reason]").val() == '선택'  ){	
				alert('<spring:message code="fail.input.emptyValue2" arguments="사유(은)"/>');
				return false;
			}
		} */
		
		if(!$("input[name=dstnc_lt]").val() && $("select[name=station_cls_cd]").val()=='STG_003' ){
			$("input[name=dstnc_lt]").val('30');
		}
		
		if(flag == "INSERT"){
			fn_regist();
		}else if(flag == "UPDATE"){
			fn_update( id );
		}
	}
	
	var doubleClick = true;
	var succMsg = '<spring:message code="success.common.save" />';
	var failMsg = '<spring:message code="fail.request.msg" />';
	
	function fn_regist(){
	//	vallidateModify();
		$("#cmd").val("INSERT");
		frm.histYn.value = 'N';
		frm.currentPageNo.value=0;
		if(doubleClick){
			doubleClick = false;
			$("#frm").attr({method : "post", action : "/admin/manage/station/stationModify.do"}).submit();
		/*	$.post("/admin/manage/station/stationModify.do", $("#frm").serialize()  , function(data) {
				
				if(data.rtMsg == "성공"){
					alert(succMsg);
					fn_list();
				}else{
					alert(failMsg);
				}
			});
			*/
		}
	}
	
	function fn_update( id ){
		$("#cmd").val("UPDATE");
		$("#station_id").val(id);
		var radioVal = $(':radio[name="station_use_yn"]:checked').val();
		if('${info.station_use_yn }' == radioVal 
			&& '${info.unuse_str_dttm }' ==  $("input[name=unuse_str_dttm]").val() 
			&& '${info.unuse_end_dttm }' ==  $("input[name=unuse_end_dttm]").val() ){
			frm.histYn.value = 'N';
		} else {
			frm.histYn.value = 'Y';
		}
		
		//var target = document.getElementsByName("selectBox");
		
		if ( radioVal == 'S'){
			if( $("#selbox").val() == '선택'){	
				alert('<spring:message code="fail.input.emptyValue2" arguments="사유(은)"/>');
				return false;
			}	
			if ( confirm( $("input[name=unuse_str_dttm]").val() + "부터 임시폐쇄 예정입니다. 저장하시겠습니까?")) {
				$("#frm").attr({method : "post", action : "/admin/manage/station/stationModify.do"}).submit();
			}
		}else if( radioVal == 'T'){
			if( $("#selbox").val() == '선택'){	
				alert('<spring:message code="fail.input.emptyValue2" arguments="사유(은)"/>');
				return false;
			}  
			if ( confirm( $("input[name=unuse_str_dttm]").val() + "부터 임시폐쇄됩니다. 저장하시겠습니까?")) {
				$("#frm").attr({method : "post", action : "/admin/manage/station/stationModify.do"}).submit();
			}
		}else if($("#memo").val() == 0 && $("#station_se_cd").val() != 'RAK_001'){
			if ( confirm("거치대건수가 "+ $("input[name=memo]").val() + "입니다. 거치대 건수 입력하시겠습니까?")){
				return false;
			}
		}else if (confirm('<spring:message code="common.save.msg"/>')){
			$("#frm").attr({method : "post", action : "/admin/manage/station/stationModify.do"}).submit();
		}
		
		/*	
		$.post("/admin/manage/station/stationModify.do", $("#frm").serialize()  , function(data) {
			
			if(data.rtMsg == "성공"){
				alert(succMsg);
				fn_list();
			}else{
				alert(failMsg);
			}
		});
		*/
	}
	
	function fn_delete(id){
		$("#cmd").val("DELETE");
		$("#station_id").val(id);
		
		if(confirm('<spring:message code="common.delete.msg"/>')){
			$("#frm").attr("action", "/admin/manage/station/stationModify.do");
			$("#frm").submit();
		}
	}
	
	function goMapAddr(){
		/* 		if(!$("#station_latitude").val() && !$("#station_longitude").val()){
		alert('<spring:message code="fail.input.emptyValue2" arguments="위경도"/>');
		return;
	} */
		var pwidth = 600;
		var pheight = 680;
		var winL = (screen.width-pwidth)/2;
		var winT = (screen.height-pheight)/2;
		var lat = $("#station_latitude").val();
		var lon = $("#station_longitude").val();
		window.open("/common/pop/showLocationMapPop.do?outptt=%uC704%uCE58%uC9C0%uB3C4%uCC3E%uAE30&latitude="+ lat +"&longitude=" + lon , "winpop", "width=600, height=680, top="+winT+", left="+winL , "scrollbars=yes");
	}
	
	function readURL(input) {
		if (input.files && input.files[0]) {
		var reader = new FileReader();
		
		reader.onload = function (e) {
				$('#blah').attr('src', e.target.result);
			}
		reader.readAsDataURL(input.files[0]);
		}
	}
	
	var commcodeEdit = {};
	commcodeEdit.subBoxSize = parseInt('${fn:length(beaconList)}');
	//commcodeEdit.comUpCd = '${codeVO.comCd}';
	commcodeEdit.initBtn = function(pUpCd) {
		$("#comCd").focusin(function() {
			$("#comCd").val('');
			$("#dupCheck").val('N');
		});
		
		$("#dupCodeCheck").on("click",this.dupCodeCheckFnc);
		$("#moveListBtn").on("click",function(e) {
			e.preventDefault();
			e.stopPropagation();
			$("#frm").attr({method : 'post', action: "<c:url value='/getCommonCodeList.do'/>"}).submit();
		});
		$("#dataEditBtn").on("click",this.dataEditExecFnc);
		$("#btn_addCode").on("click",this.clickAddCodeFormFnc);
		$("#dupSerialChk").on("click",{ type : "serial"}, this.beaconDupChkFnc);
	};
	
	commcodeEdit.clickAddCodeFormFnc = function(e) {
		e.preventDefault();
		e.stopPropagation();
		this.blur();
		var _this = commcodeEdit;
		_this.addCodeFormFnc();
	};
	
	commcodeEdit.chkNumber = function(e) {
		var r = numbersonly(e,false);
		if(!r){
			alert('숫자만 입력 가능합니다.');
			$(this).val('');
			return false;
		}
	};
	
	commcodeEdit.removeBox = function(e) {
		var _this = commcodeEdit;
		e.preventDefault();
		e.stopPropagation();
		$(this).parent().parent().remove();
		_this.subBoxSize -= 1;
	};
	
	commcodeEdit.addCodeFormFnc = function(){
		var _this = commcodeEdit;
		var rIdx	= parseInt(_this.subBoxSize);
		var $cloneDiv = $("#cloneDiv .questionBox").clone();
		var upCode = _this.comUpCd;
		var surffix = "_00"+(rIdx +1);
		if(rIdx > 8) {
			surffix = "_0"+(rIdx +1);
		}
		upCode  = upCode+surffix;
		$cloneDiv.find("table").addClass('tb_type02'); 
		$cloneDiv.find("button").on("click", _this.removeBox);
		if(rIdx === 0) {
			$cloneDiv.find("table tr").eq(1).find("input:hidden").eq(1).val(upCode);
			$cloneDiv.find("table tr").eq(1).find("input:text").on('keyup',_this.chkNumber);
			$(".questionBoxWrap").append($cloneDiv);
		} else {
			$cloneDiv.find("table tr").eq(1).find("input[type='text']").eq(0).attr('name', 'beaconList['+rIdx+'].deviceId');
			$cloneDiv.find("table tr").eq(1).find("input[type='text']").eq(0).attr('id', 'beaconList['+rIdx+'].deviceId');
			//$cloneDiv.find("table tr").eq(2).find("input[type='hidden']").eq(0).attr('name', 'beaconList['+rIdx+'].beaconId');
			$cloneDiv.find("table tr").eq(2).find("input[type='text']").eq(0).attr('name', 'beaconList['+rIdx+'].serialNo');
			$cloneDiv.find("table tr").eq(2).find("input[type='text']").eq(0).attr('id', 'SserialNo'+rIdx);
			$cloneDiv.find("table tr").eq(2).find("a").eq(0).attr('id', rIdx);
			$(".questionBoxWrap").first().prepend($cloneDiv);
		}
		_this.subBoxSize +=1;
	};
	
function fn_beaconDupChkFnc(serialNo ,mode){
	if( $("#beaconList["+serialNo+"].serialNo").val() === '' ) {
		alert("체크 할 ID를 입력 해주세요.");
		return;
	}
	
	if(!isAlNumber($("#SserialNo"+serialNo).val())) {
		alert("영문,숫자로만 입력 해주세요.");
		$("#deviceId").val('').focus();
		return;
	}
	
	var lengthChk = $("#SserialNo"+serialNo).val();
	if( lengthChk.length < 14 ) {
		alert("체크 할 ID를 14자리로 해주세요.");
		return;
	}
	
	var chkId = $("#SserialNo"+serialNo).val();
	var type ="serial";
	var oldDeviceId = "";
	
	if(mode =='update'){
		oldDeviceId = $("[name='beaconList["+serialNo+"].deviceId']").val();
	}
	
	commonAjax.postAjax(
			"<c:out value='/beacon/dupIdCheckAjax.do'/>"
			, "json"
			, { chkId : chkId , chkType : type }
			, function(data){
				  if(data) {
					  if((data.isDup === "true")) {
						
						  if(data.resultVo != null && data.resultVo.nowLocateId !=null && data.resultVo.nowLocateId !=''){
							  
							  if(confirm(data.resultVo.stationName+data.resultVo.centerName+ '에 이미 등록된 비콘입니다 변경하시겠습니까?')) {
								  $('#SdeviceId'+serialNo).val(data.resultVo.deviceId);
								  
								  //바로 등록 ㄱㄱ
								fn_matchingBeacon(data.resultVo.deviceId,oldDeviceId);
							  } else {
								  
							  }
						  } else {
							  $('#SdeviceId'+serialNo).val(data.resultVo.deviceId);
							  fn_matchingBeacon(data.resultVo.deviceId,oldDeviceId);
						  }
						  
					  } else {
						  alert("등록 되지 않은 시리얼 번호 입니다.");
					  }
				  }
			  }
		);
	}
	
function fn_matchingBeacon(deviceId, oldDeviceId){
	var station_id ='${info.station_id}';
	//var nowLocateClsCd = '${info.station_cls_cd}';
	commonAjax.postAjax(
			"<c:out value='/beacon/matchingBeaconAjax.do'/>"
			, "json"
			, { stationId : station_id, deviceId : deviceId, oldDeviceId : oldDeviceId }
			, function(data){
					  
						 location.reload(); 
					  
			  }
		);
}

function fn_matchingBeacon2(deviceId, oldDeviceId){
	deviceId = $("#SserialNo"+deviceId).val();
	
	commonAjax.postAjax(
			"<c:out value='/beacon/delConnBeaconAjax.do'/>"
			, "json"
			, {deviceId : deviceId}
			, function(data){
				if(data.checkResult > 0){
					alert(data.resultMessage);
					location.reload();
				}
			}
		);
}
//]]>
</script>

<script type="text/javascript">
	String.prototype.trim = function(){
		return this.replace(/\s/g, "");
	}
</script>

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
				<!--conteent S-->
			<form action="" method="post"	name="frm" id="frm"  enctype="multipart/form-data">
				<div class="content">
					<div class="subject">
						<!--subject path S-->
							<tiles:insertAttribute name="subject" />
						<!--subject path E-->
					</div>
					<div class="page">
					<div class="tabWrap type3">
							<ul class="tabBox">
								<li class="tab on"><button type="button">정거장 정보</button></li>
								<!-- <li class="tab"><button type="button">사용 이력</button></li> -->
							</ul>
							<div class="tabCon on">
							<fieldset>
								<table  class="tb_type02 mt20">
									<caption>정거장 상세</caption>
									<colgroup>
										<col style="width:25%"/>
										<col style="width:75%"/>
									</colgroup>
									<tbody>
										<tr>
											<th class="top"><em>*</em>아파트</th>
											<td class="top">
												<select name="station_grp_seq" class="select-category02">
													<option value="">선택</option>
													<c:forEach items="${groupList }" var="group">
														<option value="${group.station_grp_seq }">${group.station_grp_name }</option>
													</c:forEach>
												</select>
											</td>
										</tr>
										<tr>
											<th><em>*</em>정거장 번호</th>
											<td>
												<span class="input-text08"><input type="text"  class="input-text08" name="station_no"	id="station_no" maxlength="5"/></span>
												<button class="btnType02"  onclick="fn_duplStationCheck(); return false;">중복확인</button>
												<input type="hidden" id="checkNo">
												<input type="hidden" id="checkName">
												<input type="hidden" id="histYn" name="histYn" value="${info.station_use_yn }">
												<input type="hidden" id="station_id" name="station_id">
												<input type="hidden" id="cmd" name="cmd" value="${cmd }">
												<input type="hidden" id="station_se_cd" name="station_se_cd" value="RAK_001">
											</td>
										</tr>
										<tr>
											<th><em>*</em>정거장 명</th>
											<td class="lengcase1">
												<c:forEach items="${codeList }" var="code" varStatus="idx">
													<p><label>${code.comCdName }</label><span class="input-text11"><input type="text" name="nameList" id="${code.comCd }" /></span>
														<c:if test="${idx.index == 0 }">
															<button class="btnType02" onclick="fn_duplStationNameCheck(); return false;">중복확인</button>
														</c:if>
														<input type="hidden" name="codeList" value="${code.comCd }" maxlength="50">
													</p>
												</span>
												</c:forEach>
											</td>
										</tr>
										<!-- 
										<tr>
											<th><em>*</em>팀</th>
											<td>
												<select class="select-category02" name="team_seq">
													<option value="">선택</option>
												</select>
											</td>
										</tr>
										 -->
										<tr>
											<th><em>*</em>구분</th>
											<td>
												<select class="select-category02" name="station_cls_cd">
													<option value="STG_001">무인</option>
													<!-- <option value="STG_002">유인</option> -->
													<!-- <option value="STG_003">가상</option> -->
												</select>
											</td>
										</tr>
										<!-- 
										<tr>
											<th><em>*</em>정거장 구분</th>
											<td>
												<select class="select-category02" name="station_se_cd" id="station_se_cd">
													<option value="">선택</option>
												</select>
											</td>
										</tr>
										 -->
										<tr id="qrRack" style="display:none;">
											<th>거치대 납품처</th>
											<td>
												<select class="select-category02" name="rack_entrps_cd" id="rack_entrps_cd">
													<option value="">선택</option>
												</select>
											</td>
										</tr>
										<!-- <tr>
											<th><em>*</em>주소</th>
											<td>
												<input type="hidden"  name="station_post_no" id="station_post_no"/>
												<div><span class="input-text03"><input type="text" name="station_post_no1" id="station_post_no1" readonly /></span>-<span class="input-text03"><input type="text"  name="station_post_no2" id="station_post_no2" readonly /></span> <button class="btnType02" onclick="goPopup(); return false;">주소찾기</button></div>
												<p class="mt10"><span class="input-text05"><input type="text" name="station_addr1" id="station_addr1" readonly /></span></p>
												<p class="mt10"><span class="input-text05"><input type="text" name="station_addr2" id="station_addr2" readonly/></span></p>
											</td>
										</tr> -->
										<tr>
											<th><em>*</em>주소</th>
											<td>
												<input type="text"  name="station_post_no" id="station_post_no"/>
												
												<div><span class="input-text03"><input type="text" name="station_post_no1" id="station_post_no1" readonly /></span>-<span class="input-text03"><input type="text"  name="station_post_no2" id="station_post_no2" readonly /></span> <button class="btnType02" onclick="goPopup(); return false;">주소찾기</button></div>
												
												<p class="mt10"><span class="input-text05"><input type="text" name="station_addr1" id="station_addr1" readonly /></span></p>
												<p class="mt10"><span class="input-text05"><input type="text" name="station_addr2" id="station_addr2" readonly/></span></p>
											</td>
										</tr>
										<tr>
											<th>위도/경도</th>
											<td>
												<p>
													<span class="input-text02"><input type="text" class="input-text03" id="station_latitude" name="station_latitude"/> / </span>
												</p>
												<p>
													<span class="input-text02"><input type="text" class="input-text03" id="station_longitude" name="station_longitude"/></span>
													<button class="btnType02" onclick="goMapAddr();" type="button">지도보기</button>
												</p>
											</td>
										</tr>
										<tr>
											<th>반경</th>
											<td>
												<p>
													<span class="input-text02"><input type="text" class="input-text03" id="dstnc_lt" name="dstnc_lt"/> m (숫자만 입력)</span>
												</p>
											</td>
										</tr>
										<!-- 
										<tr>
											<th>거치대 수</th>
											<td>
												<p>
													<span class="input-text05"><input type="text" id="memo" name="memo"/></span>
												</p>
											</td>
										</tr>
										 -->
										<tr>
											<th><em>*</em>사용 여부</th>
											<td>
												<span>
													<span class="input-rd01"><input type="radio" name="station_use_yn" id="station_use_y" value="Y"><label for="station_use_y">사용</label></span>
													<span class="input-rd01"><input type="radio" name="station_use_yn" id="station_use_n" value="N"><label for="station_use_n">미사용</label></span>
													<!-- 
													<span class="input-rd01"><input type="radio" name="station_use_yn" id="station_use_c" value="C"><label for="station_use_c">폐쇄</label></span>
													<span class="input-rd01"><input type="radio" name="station_use_yn" id="station_use_t" value="T"><label for="station_use_t">임시 폐쇄</label></span>
													<span class="input-rd01"><input type="radio" name="station_use_yn" id="station_use_s" value="S"><label for="station_use_s">임시 폐쇄 <font color="red">(예정)</font></label></span>
													<span class="input-rd01"><input type="radio" name="station_use_yn" id="station_use_r" value="R"><label for="station_use_t">정비센터 테스트용</label></span>
													 -->
												</span>
											</td>
										</tr>
										<%-- 
										<tr>
											<th><em>*</em>임시 미사용 기간</th>
										 	<td>
										 		<div id="unuseDate" style="display: none;">
										 		<span class="selectDate input-datepick04">
										 		<input type="text" class="datepicker input-datepick04" name="unuse_str_dttm"  title="선택 날짜" id="unuse_str_dttm" readonly value="${info.unuse_str_dttm}"/></span>
										 		<span class="dash">~</span>
										 		<span class="selectDate input-datepick04">
										 		<input type="text" class="datepicker input-datepick04" name="unuse_end_dttm"  title="선택 날짜" id="unuse_end_dttm" readonly value="${info.unuse_end_dttm}"/></span>
										 		
										 	</td>
										<tr>
										 --%>
											<%-- <th>무선 AP</th>
											<td>
												<select class="select-category02" name="device_id" disabled="disabled">
														<option value="">
													<c:forEach items="${aplist }" var="ap">
														<option  disabled="disabled" value="${ap.deviceId }">${ap.deviceId }
													</c:forEach>
												</select>
											</td> --%>
											<%-- 
											<th><em>*</em>사유</th>
											<td>
												<select class="select-category02" name="reason" id="selbox">
													<option value="선택">선택</option>
													<option value="통신장애"		<c:if test="${info.reason eq '통신장애,'}"><c:out value="selected"></c:out> </c:if>	>통신장애</option>
													<option value="공사"			<c:if test="${info.reason eq '공사,'}"><c:out value="selected"></c:out> </c:if>	>공사</option>
													<option value="행사/축제"		<c:if test="${info.reason eq '행사/축제,'}"><c:out value="selected"></c:out> </c:if> >행사/축제</option>
													<option value="">직접입력</option>
												</select>
												<input type="text" class="input-text03" id="selboxDirect" name="reason"/>
											</td>
											 --%>
										</tr>
										<tr>
											<th >정거장 사진</th>
											<td>
												<div>
												<span>
													<input type="file" id="staImgFile" name="staImgFile" style="width: 350px"/>
													(${info.station_img_file_name })
												</span>
												</div>
												<div>
													<span>
													<c:if test="${info.saveImg eq null || info.saveImg == ''}">
														<img id="blah" src="/images/btn_back.png" alt="정거장 이미지" height="70" width="70"  />
													</c:if>
													<c:if test="${info.saveImg ne null && info.saveImg != ''}">
														<img id="blah" src="data:image/gif;base64,${info.saveImg}" alt="정거장 이미지" height="70" width="70"  />
													</c:if>
													</span>
													<span>(화면에 사진 표시 기준 크기 : 70 * 70 pixel 입니다.)</span>
												</div>
											</td>
										</tr>
									</tbody>
								</table>
						 <%-- 
							 <div id="childDiv2">
								<table class="tb_type02 mt20">
								  	<tbody>
								  	<colgroup>
										<col style="width:25%"/>
										<col style="width:75%"/>
									</colgroup>
										<tr>
											<th><font color="blue">담당자 문자전송여부 </font></th>
											<td></td>
										</tr> 
										<tr>
											<th><font color="blue">알림톡 발송여부</font></th>
											<td>
												<span>
													<c:if test="${info.cnt ne null && info.cnt != ''}"> 
														<c:out value="${info.cnt}"/>건 
													</c:if>
												</span>
											</td>
										</tr>
									</tbody>
								</table>
						 </div> 
						  --%>
						  <c:if test="${cmd != 'INSERT'}">
								 <div id="childDiv">
									<p class="head ttbtncase1">설치 비콘<span><button type="button" class="btnType05" id="btn_addCode">추가</button></span></p>
									<div class="questionBoxWrap">
										<c:forEach var="result" items="${beaconList}" varStatus="loop">
											<div class="questionBox">
												<div class="addStwrap">
													<table class="tb_type02">
														<colgroup>
															<col style="width:25%"/>
															<col style="width:75%"/>
														</colgroup>
														<tbody>
															<tr>
																<th class="top">코드</th>
																<td class="top">
																	<span class="input-text07"><input type="text" name="beaconList[${loop.index}].deviceId" id="beaconList[${loop.index}].deviceId" readonly="readonly" value="<c:out value='${result.deviceId }'/>" /></span>
																</td>
															</tr>
															<%-- <tr>
																<th>순서</th>
																<td style="display: none" >
																	<input type="hidden" name="beaconList[${loop.index}].beaconId" value="${result.deviceId }"/>
																</td>
																<td>
																	<span class="input-text07">&nbsp;</span>
																</td>
															</tr> --%>
															<tr>
																<th>시리얼 번호</th>
																<td>
																	<span class="input-text07">
																		<input type="text"  name="beaconList[${loop.index}].serialNo" id="SserialNo${loop.index}" placeholder="코드설명1" value="<c:out value='${result.serialNo }'/>"/> 
																		<a href="#" id="${loop.index}" onclick="fn_beaconDupChkFnc([this.id],'update');return false;">저장</a>
																		<a href="#" id="${loop.index}" onclick="fn_matchingBeacon2([this.id],'delete');return false;">삭제</a>
																	</span>
																</td>
															</tr>
															
													   </tbody>
												   </table>
											   </div>
										   </div>
									   </c:forEach>
									</div>
								</div>
								</c:if>
								<div class="btnArea">
									<c:if test="${cmd == 'INFO'}">
										<span class="left"><button id="btn_list" class="btnType01 bc_gray">목록</button></span><!-- onclick="fn_list(); return false;" -->
										<span class="right" onclick="vallidateModify('UPDATE','${info.station_id}'); return false;"><button class="btnType01 bc_green">저장</button></span>
										<%-- <span class="right" onclick="fn_delete('${info.station_id}'); return false;"><button class="btnType01 bc_green">삭제</button></span> --%>
									</c:if>
									<c:if test="${cmd == 'INSERT'}">
										<span class="left"><button id="btn_list" class="btnType01 bc_gray">목록</button></span><!-- onclick="fn_list(); return false;" -->
										<span class="right" onclick="vallidateModify('INSERT'); return false;"><button class="btnType01 bc_green">저장</button></span>
									</c:if>
								</div>
								
							</fieldset>
							</div>
							
							<div class="tabCon">
							<table class="tb_type01">
								<colgroup>
									<col style="width:15%"/>
									<col style="width:15%"/>
									<col style="width:15%"/> 
									<col style="width:15%"/>
									<col style="width:15%"/>
								</colgroup>
								<thead>
									<tr>
										
										<th>등록자</th>
										<th>등록일</th>
										<th>사용구분</th>
										<th>임시정지시작일</th>
										<th>임시정지종료일</th>
									</tr>
								</thead>
								<tbody>
									<c:if test="${fn:length(stationUseList) > 0 }">				  
										<c:forEach var="result" items="${stationUseList}" varStatus="status">
											<tr>
												 <td class="tc"><c:out value="${result.reg_id}"/></td>
												<td class="tc"><c:out value="${result.reg_dttm}"/></td>
												<td class="tc">
													<c:if test="${result.station_use_yn eq 'Y'}">사용</c:if>
													<c:if test="${result.station_use_yn eq 'N'}">미사용</c:if>
													<c:if test="${result.station_use_yn eq 'T'}">임시폐쇄</c:if>
													<c:if test="${result.station_use_yn eq 'C'}">폐쇄</c:if>
													<c:if test="${result.station_use_yn eq 'S'}">임시폐쇄(예정)</c:if>
													<c:if test="${result.station_use_yn eq 'R'}">정비센터 테스트용</c:if>
												</td>
												<td class="tc"><c:out value="${result.unuse_str_dttm}"/></td>
												<td class="tc"><c:out value="${result.unuse_end_dttm}"/></td>
											</tr>
										</c:forEach>
									</c:if>
									<c:if test="${fn:length(stationUseList) == 0 }">  
										<tr>
											<td colspan="5" class="tc"><spring:message code="info.nodata.msg" /></td>
										</tr>
									</c:if>
								</tbody>
							</table>
							
							<c:choose>
							<c:when test="${fn:length(stationUseList) > 0}">
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
							
							</div>
							
							</div>
						</div>
				</form>
				<!--content E-->
			</div>
		</div>
		<div style="height: 200px"></div>
		<!--footer S-->
		<%-- 	<tiles:insertAttribute name="footer" /> --%>
		<!--footer E-->
	</div>
	<!--하위코드 추가용 clone  -->
	<section id="cloneDiv" style="display: none;" >
		<div class="questionBox" >
			<div class="btn_delQ"><button class="btnType04" ><img src="/images/btn_delQ.png" alt="" /></button></div>
			<div class="addStwrap">
				<table>
					<colgroup>
						<col style="width:25%"/>
						<col style="width:75%"/>
					</colgroup>
					<tr style="display: none;"></tr>
					<tr>
								   <th class="top">코드</th>
								   <td class="top">
									   <span class="input-text07"><input type="text" name="" id="" readonly="readonly" value="" /></span>
								   </td>
							   </tr>
					  <!-- <tr>
						  <th>순서</th>
						  <td style="display: none" >
						   <input type="hidden" name="beaconList[0].beaconId" value="0"/>
		  				 </td>
						  <td>
							  <span class="input-text07">&nbsp;</span>
						  </td>
					  </tr> -->
					  <tr>
						  <th>시리얼 번호</th>
						  <td>
							 <span class="pwtableblock">
								  <input type="text"  name="beaconList[0].serialNo" id="SserialNo0" placeholder="시리얼 번호" value=""/>
								 
								  <a href="#" id="0" onclick="fn_beaconDupChkFnc([this.id],'insert');return false;">저장</a>
								  <!-- <a href="#" id="0" onclick="fn_matchingBeacon2([this.id],'delete');return false;">삭제</a> -->
								  </span>
								 
								  
						  </td>
						  
					  </tr>
				</table>
			</div>
		</div>
		</section>
</body>
</html>

