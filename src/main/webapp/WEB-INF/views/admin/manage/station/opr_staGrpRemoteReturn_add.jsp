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
// 		$('#btn_list').click(function() {
// 			fn_list();
// 		});
		
		$("#btn_save").click(function(e){
			e.preventDefault();
// 			if(!isEmptyDmsgF("musicGb", "음악구분을")) return;
// 			if(!isEmptyDmsgF("musicTp", "음악유형를")) return;
// 			if(!isEmptyDmsgF("musicNm", "음악명을")) return;
// 			if(!isEmptyDmsgF("sngrNm", "가수명을")) return;
// 			if(!isEmptyDmsgF("cont", "내용를")) return;
			fn_save();
		});
		
		$("#btn_addRow").click(function(e){
			e.preventDefault();
			e.stopPropagation();
			this.blur();
			
// 			var _this = commcodeEdit;
// 			_this.addCodeFormFnc();
			fn_addRow(this);
		});
	});
	
	function fn_addRow(obj){
// 		var _this = commcodeEdit;
// 		var rIdx	= parseInt(_this.subBoxSize);
// 		var $cloneDiv = $("#cloneDiv .questionBox").clone();
// 		var upCode = _this.comUpCd;
// 		var surffix = "_00"+(rIdx +1);
// 		if(rIdx > 8) {
// 			surffix = "_0"+(rIdx +1);
// 		}
// 		upCode  = upCode+surffix;
// 		$cloneDiv.find("table").addClass('tb_type02'); 
// 		$cloneDiv.find("button").on("click", _this.removeBox);
// 		if(rIdx === 0) {
// 			alert("1");
// 			$cloneDiv.find("table tr").eq(1).find("input:hidden").eq(1).val(upCode);
// 			$cloneDiv.find("table tr").eq(1).find("input:text").on('keyup',_this.chkNumber);
// 			$(".questionBoxWrap").append($cloneDiv);
// 		} else {
// 			alert("2");
// 			$cloneDiv.find("table tr").eq(1).find("input[type='text']").eq(0).attr('name', 'beaconList['+rIdx+'].deviceId');
// 			$cloneDiv.find("table tr").eq(1).find("input[type='text']").eq(0).attr('id', 'beaconList['+rIdx+'].deviceId');
// 			//$cloneDiv.find("table tr").eq(2).find("input[type='hidden']").eq(0).attr('name', 'beaconList['+rIdx+'].beaconId');
// 			$cloneDiv.find("table tr").eq(2).find("input[type='text']").eq(0).attr('name', 'beaconList['+rIdx+'].serialNo');
// 			$cloneDiv.find("table tr").eq(2).find("input[type='text']").eq(0).attr('id', 'SserialNo'+rIdx);
// 			$cloneDiv.find("table tr").eq(2).find("a").eq(0).attr('id', rIdx);
// 			$(".questionBoxWrap").first().prepend($cloneDiv);
// 		}
// 		_this.subBoxSize +=1;

		var tr = $(obj).parent().parent();
		html = "";
		html += "<tr>",
		html += "<td><select name='station_grp_seq_list' id='station_grp_seq_list'><option value=''>선택</option><c:forEach items='${groupList}' var='group'><option value='${group.station_grp_seq }'>${group.station_grp_name}</option></c:forEach></select></td>",
		html += "<td><input type='text' id='remote_station_name_list' name='remote_station_name_list' size='20' autocomplete='off' class='form-control'></td>",
		html += "<td><input type='text' id='remote_latitude_list' name='remote_latitude_list' autocomplete='off' class='form-control'></td>",
		html += "<td><input type='text' id='remote_logitude_list' name='remote_logitude_list' autocomplete='off' class='form-control'></td>",
		html += "<td><button type='button' class='btnType02' onclick='goMapAddr();'>지도보기</button></td>"
// 		html += "<td><input type='text' id='remote_use_yn_list' name='remote_use_yn_list' size='20' autocomplete='off' class='form-control'></td>",
		html += "<td><select name='remote_use_yn_list' id='remote_use_yn_list'><option value='Y'>사용</option><option value='N'>미사용</option></select></td>",
		html += "<td><button type='button' class='btnType05' name='btn_delRow' onclick='javascript:fn_delRow(this); return false;'>행삭제</button></td>"
		html += "</tr>"
		$("#stationGrpRemoteReturnRow").append(html);
	}
	
	/* 행 삭제 */
	function fn_delRow(obj){
		var tr = $(obj).parent().parent();
		tr.remove();
	}
	
	/* 숫자만 입력 */
	function fn_numkeyCheck(event) { 
		 event = event || window.event;
		  var keyID = (event.which) ? event.which : event.keyCode;
		    if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
		        return;
		    else
		        event.target.value = event.target.value.replace(/[^0-9]/g, "");
	}
	
	function fn_duplStationNameCheck(){
		
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
	
	function fn_list(){
		$("#frm").attr("action", "/admin/manage/station/stationGrpRemoteReturnList.do");
		$("#frm").submit();
	}
	
	$(function() {
		if("${result }" != ""){
			alert("${result}")
		}
		
		$("[name='remote_use_yn']").on("change",  function(){
			var radioVal = $(':radio[name="remote_use_yn"]:checked').val();
		});
	});
	
	function vallidateModify( flag, id ){
		if(!$("select[name=station_grp_seq]").val()){
			alert('<spring:message code="fail.input.emptyValue1" arguments="아파트"/>');
			$("select[name=station_grp_seq]").focus();
			return false;
		}
		
		
// 		var temp  = false;
// 		$("input[name=nameList]").each(function(){
// 			//alert($(this).val())
// 			if(!$(this).val()){
// 				alert('<spring:message code="fail.input.emptyValue1" arguments="정거장 명"/>');
// 				$(this).focus();
// 				temp = true;
// 				return false;
// 			}
// 		});
		
// 		if(temp){
// 			return false;
// 		}
// 		if($("input[name=nameList]").val() != $("#checkName").val()){
// 			alert('<spring:message code="fail.input.emptyValue2" arguments="정거장 명 중복검사"/>');
// 			return false;
// 		}
		
		
		
// 		if(!$("input[name=remote_use_yn]").is(":checked")){
// 			alert('<spring:message code="fail.input.emptyValue2" arguments="사용여부"/>');
// 			return false;
// 		}
		
		if(flag == "INSERT"){
				$("#cmd").val("INSERT");
//		 		frm.histYn.value = 'N';
// 				frm.currentPageNo.value=0;
// 				if(doubleClick){
// 					doubleClick = false;
// 					$("#frm").attr({method : "post", action : "/admin/manage/station/stationGrpRemoteReturnModify.do"}).submit();
					
					if(confirm('저장 하시겠습니까?')){
						$("#frm").attr("action", "/admin/manage/station/stationGrpRemoteReturnModify.do");
						$("#frm").submit();
					}
				/*	$.post("/admin/manage/station/stationGrpRemoteReturnModify.do", $("#frm").serialize()  , function(data) {
						
						if(data.rtMsg == "성공"){
							alert(succMsg);
							fn_list();
						}else{
							alert(failMsg);
						}
					});
					*/
// 				}
		}
	}
	

	function fn_save(){
		$('#mode').val("INSERT");
		var count= 0;
// 		$('#bicycleRow').find('input[name=bcycl_id_list]').each(function(i, e){
// 	 		var bcyclId = validByclId($("input[name=bcycl_id_list]:eq("+i+")").val(),'0',4);
// 	 		//DB 저장된값 중복확인
// 			if(bycleList.some( function( x ) { return x === bcyclId } )){
// 				alert("이미 중복된 자전거번호값이 저장되어있습니다. 확인해주세요!");
// 				$("input[name=bcycl_id_list]:eq(" + i + ")").focus();
// 				count ++;
// 				return false;
// 			}
			
// 			//잠금장치 ID null 체크
// 			var size =  $("input[name=bcycl_id_list]").length;
// 			if($(this).val() ==  null || $(this).val() == ''){
// 				alert("자전거번호을 입력해주세요!");
// 				count ++;
// 				return false;
				
// 			}
			
// 			//리스트 중복값 체크
// 			for(var j=i+1; j < size; j++){
// 				if($(this).val() == $("input[name=bcycl_id_list]:eq("+j+")").val()){ 
// 					alert("중복값이 있습니다. 확인해주세요!");
// 					$("input[name=bcycl_id_list]:eq(" + j + ")").focus();
// 					count ++;
// 					return false;
// 				}
// 			}
			
// 		});
		
// 		if(count == 0){
// 			$('#bicycleRow').find('input[name=rfid_list]').each(function(i, e){
// 				if($(this).val() ==  null || $(this).val() == ''){
// 					alert("RFID를 입력해주세요!");
// 					count ++;
// 					return false;
// 				}
// 			});
// 		}
		
// 		if(count == 0){
// 			$('#bicycleRow').find('input[name=device_id_list]').each(function(i, e){
				
// 			});
// 		}
		
		if(count == 0){
			if(confirm("저장 하시겠습니까?")){
				$("#frm").attr("action", "/admin/manage/station/saveStationGrpRemoteReturnInfo.do");
				$("#frm").submit();
			}
		}
		
	}
	
	
	
// 	var doubleClick = true;
	var succMsg = '<spring:message code="success.common.save" />';
	var failMsg = '<spring:message code="fail.request.msg" />';
	
	function goMapAddr(){
		/* 		if(!$("#remote_latitude").val() && !$("#remote_logitude").val()){
		alert('<spring:message code="fail.input.emptyValue2" arguments="위경도"/>');
		return;
	} */
		var pwidth = 600;
		var pheight = 680;
		var winL = (screen.width-pwidth)/2;
		var winT = (screen.height-pheight)/2;
		var lat = $("#remote_latitude").val();
		var lon = $("#remote_logitude").val();
		window.open("/common/pop/showLocationMapPop.do?outptt=%uC704%uCE58%uC9C0%uB3C4%uCC3E%uAE30&latitude="+ lat +"&longitude=" + lon , "winpop", "width=600, height=680, top="+winT+", left="+winL , "scrollbars=yes");
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
// 		$("#btn_add").on("click",this.clickAddCodeFormFnc);
		$("#dupSerialChk").on("click",{ type : "serial"}, this.beaconDupChkFnc);
	};
	
	commcodeEdit.clickAddCodeFormFnc = function(e) {
		alert("8");
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
			alert("1");
			$cloneDiv.find("table tr").eq(1).find("input:hidden").eq(1).val(upCode);
			$cloneDiv.find("table tr").eq(1).find("input:text").on('keyup',_this.chkNumber);
			$(".questionBoxWrap").append($cloneDiv);
		} else {
			alert("2");
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
	
// function fn_matchingBeacon(deviceId, oldDeviceId){
// 	var station_grp_seq ='${info.station_grp_seq}';
// 	commonAjax.postAjax(
// 			"<c:out value='/beacon/matchingBeaconAjax.do'/>"
// 			, "json"
// 			, { station_grp_seq : station_grp_seq, deviceId : deviceId, oldDeviceId : oldDeviceId }
// 			, function(data){
					  
// 						 location.reload(); 
					  
// 			  }
// 		);
// }

// function fn_matchingBeacon2(deviceId, oldDeviceId){
// 	deviceId = $("#SserialNo"+deviceId).val();
	
// 	commonAjax.postAjax(
// 			"<c:out value='/beacon/delConnBeaconAjax.do'/>"
// 			, "json"
// 			, {deviceId : deviceId}
// 			, function(data){
// 				if(data.checkResult > 0){
// 					alert(data.resultMessage);
// 					location.reload();
// 				}
// 			}
// 		);
// }
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
				<div class="content">
				<form action="" method="post"	name="frm" id="frm"  enctype="multipart/form-data">
				<input type="hidden" name="mode" id="mode"/>
					<div class="subject">
						<!--subject path S-->
							<tiles:insertAttribute name="subject" />
						<!--subject path E-->
					</div>
					<div class="page">
					<div class="tabWrap type3">
							<ul class="tabBox">
								<li class="tab on"><button type="button">원격반납정거장 정보</button></li>
								<!-- <li class="tab"><button type="button">사용 이력</button></li> -->
							</ul>
							<div class="tabCon on">
							<fieldset>
								<table  class="tb_type02 mt20">
									<caption>원격반납정거장 상세</caption>
									<colgroup>
										<col style="width:25%"/>
										<col style="width:75%"/>
									</colgroup>
									<tbody>
									<%-- 
										<tr>
											<th class="top"><em>*</em>아파트</th>
											<td class="top">
												<select name="station_grp_seq" class="select-category02">
													<option value="">선택</option>
													<c:forEach items="${groupList}" var="group">
														<option value="${group.station_grp_seq }">${group.station_grp_name }</option>
													</c:forEach>
												</select>
											</td>
										</tr>
									 --%>
										<%-- 
										<tr>
											<th><em>*</em>정거장 번호</th>
											<td>
												<span class="input-text08"><input type="text"  class="input-text08" name="station_no"	id="station_no" maxlength="5"/></span>
												<button class="btnType02"  onclick="fn_duplStationCheck(); return false;">중복확인</button>
												<input type="hidden" id="checkNo">
												<input type="hidden" id="checkName">
												<input type="hidden" id="histYn" name="histYn" value="${info.remote_use_yn }">
												<input type="hidden" id="station_grp_seq" name="station_grp_seq">
												<input type="hidden" id="cmd" name="cmd" value="${cmd }">
												<input type="hidden" id="station_se_cd" name="station_se_cd" value="RAK_001">
											</td>
										</tr>
										 --%>
<%-- 										 		<input type="hidden" id="histYn" name="histYn" value="${info.remote_use_yn }"> --%>
												<input type="hidden" id="station_grp_seq" name="station_grp_seq">
												<input type="hidden" id="cmd" name="cmd" value="${cmd }">
										<%-- 
										<tr>
											<th><em>*</em>원격정거장명</th>
											<td class="lengcase1">
												<input type="text" name="remote_station_name" id="remote_station_name"/>
												
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
										 --%>
										<!-- 
										<tr>
											<th>위도/경도</th>
											<td>
												<p>
													<span class="input-text02"><input type="text" class="input-text03" id="remote_latitude" name="remote_latitude"/> / </span>
												</p>
												<p>
													<span class="input-text02"><input type="text" class="input-text03" id="remote_logitude" name="remote_logitude"/></span>
													<button class="btnType02" onclick="goMapAddr();" type="button">지도보기</button>
												</p>
											</td>
										</tr>
										 -->
										<!-- 
										<tr>
											<th><em>*</em>원격 사용 여부</th>
											<td>
												<span>
													<span class="input-rd01"><input type="radio" name="remote_use_yn" id="remote_use_y" value="Y"><label for="remote_use_y">사용</label></span>
													<span class="input-rd01"><input type="radio" name="remote_use_yn" id="remote_use_n" value="N"><label for="remote_use_n">미사용</label></span>
												</span>
											</td>
										</tr>
										 -->
										</tr>
									</tbody>
								</table>
								
								
							<table class="tb_type01">
								<caption>대리반납정거장 목록</caption>
									<colgroup>
										<col style="width:18%"/>
										<col style="width:25%"/>
										<col style="width:14%"/>
										<col style="width:14%"/>
										<col style="width:10%"/>
										<col style="width:10%"/>
										<col style="width:9%"/>
									</colgroup>
								<thead>
									<tr>
										<th>아파트명</th>
										<th>대리정거장명</th>
										<th>대리정거장위도</th>
										<th>대리정거장경도</th>
										<th>지도선택</th>
										<th>대리사용여부</th>
										<th>행삭제</th>
									</tr>
								</thead>
								
<!-- 								<tbody> -->
<%-- 									<c:forEach items="${stationList }"	var="list"> --%>
<!-- 										<tr> -->
<%-- 											<td class="pl10">${list.station_grp_name }</td> --%>
<%-- 											<td class="title" onclick="fn_stationInfo('${list.station_grp_seq}')"><a href="#"> --%>
<%-- 												<c:if test="${list.station_se_cd eq 'RAK_001' }"></c:if> --%>
<%-- 												${list.remote_station_name }</a> --%>
<!-- 											</td> -->
<%-- 											<td class="pl10">${list.remote_latitude}</td> --%>
<%-- 											<td class="pl10">${list.remote_logitude}</td> --%>
<!-- 											<td class="tc"> -->
<%-- 											<c:choose> --%>
<%-- 												<c:when test="${list.remote_use_yn eq 'Y'}">사용</c:when> --%>
<%-- 												<c:when test="${list.remote_use_yn eq 'N'}">미사용</c:when> --%>
<%-- 												<c:otherwise>${list.remote_use_yn}</c:otherwise> --%>
<%-- 											</c:choose> --%>
<!-- 											</td> -->
<!-- 										</tr> -->
<%-- 									</c:forEach> --%>
<!-- 								</tbody> -->
								
								<tbody id="stationGrpRemoteReturnRow">
									<tr>
										<td><!-- <input type="hidden" id="device_id_list" name="device_id_list" size="20" autocomplete="off"  class="form-control"> -->
											<!-- <input type="text" id="station_grp_seq_list" name="station_grp_seq_list" autocomplete="off" style='IME-MODE: disabled' onblur="return fn_numkeyCheck(event)" class="form-control"> -->
											<select name="station_grp_seq_list" id="station_grp_seq_list">
												<option value="">선택</option>
												<c:forEach items="${groupList}" var="group">
													<option value="${group.station_grp_seq }">${group.station_grp_name }</option>
												</c:forEach>
											</select>
										</td>
										<td><input type="text" id="remote_station_name_list" name="remote_station_name_list" size="20" autocomplete="off" class="form-control"></td>
										<td><input type="text" id="remote_latitude_list" name="remote_latitude_list" autocomplete="off" class="form-control"></td>
										<td><input type="text" id="remote_logitude_list" name="remote_logitude_list" autocomplete="off" class="form-control"></td>
										<td><button type="button" class="btnType02" onclick="goMapAddr();">지도보기</button></td>
										<td><!-- <input type="text" id="remote_use_yn_list" name="remote_use_yn_list" autocomplete="off" style='IME-MODE: disabled' class="form-control"> -->
<!-- 											<span class="input-rd01"><input type="radio" name="remote_use_yn_list" id="remote_use_y" value="Y"><label for="remote_use_y">사용</label></span> -->
<!-- 											<span class="input-rd01"><input type="radio" name="remote_use_yn_list" id="remote_use_n" value="N"><label for="remote_use_n">미사용</label></span> -->
											<select name="remote_use_yn_list" id="remote_use_yn_list">
												<option value="Y">사용</option>
												<option value="N">미사용</option>
											</select>
										</td>
										<td><button type="button" name="btn_delRow" class="btnType05" onclick="javascript:fn_delRow(this); return false;">행삭제</button></td>
									</tr>
								</tbody>
							</table>
						<div id="childDiv"><!-- 원격반납정거장 설치 -->
							<p class="head ttbtncase1"><span><button type="button" class="btnType05" id="btn_addRow">행추가</button></span></p>
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
													<%-- 
													<tr>
														<th class="top">코드</th>
														<td class="top">
															<span class="input-text07"><input type="text" name="beaconList[${loop.index}].deviceId" id="beaconList[${loop.index}].deviceId" readonly="readonly" value="<c:out value='${result.deviceId }'/>" /></span>
														</td>
													</tr>
													 --%>
													<tr>
														<th class="top">원격정거장명_</th>
														<td class="top">
															<span class="input-text07">
															<input type="text" name="beaconList[${loop.index}].deviceId" id="beaconList[${loop.index}].deviceId" readonly="readonly" value="<c:out value='${result.deviceId }'/>" />
															<!-- <input type="text" name="remote_station_name" id="remote_station_name"/> -->
															</span>
															
														</td>
													</tr>
													<tr>
														<th>위도/경도_</th>
														<td>
															<span class="input-text07">
																<input type="text"  name="beaconList[${loop.index}].serialNo" id="SserialNo${loop.index}" placeholder="코드설명1" value="<c:out value='${result.serialNo }'/>"/> 
<%-- 																<a href="#" id="${loop.index}" onclick="fn_beaconDupChkFnc([this.id],'update');return false;">저장</a> --%>
<%-- 																<a href="#" id="${loop.index}" onclick="fn_matchingBeacon2([this.id],'delete');return false;">삭제</a> --%>
<!-- 												<p> -->
<!-- 													<span class="input-text02"><input type="text" class="input-text03" id="remote_latitude" name="remote_latitude"/> / </span> -->
<!-- 												</p> -->
<!-- 												<p> -->
<!-- 													<span class="input-text02"><input type="text" class="input-text03" id="remote_logitude" name="remote_logitude"/></span> -->
<!-- 													<button class="btnType02" onclick="goMapAddr();" type="button">지도보기</button> -->
<!-- 												</p> -->
															</span>
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
													<%-- 
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
													 --%>
												</tbody>
											</table>
										</div>
								   </div>
							   </c:forEach>
							</div>
						</div>
								
								<div class="btnArea">
									<c:if test="${cmd == 'INSERT'}">
										<span class="left"><button id="btn_list" class="btnType01 bc_gray">목록</button></span><!-- onclick="fn_list(); return false;" -->
										<!-- <span class="right" onclick="vallidateModify('INSERT'); return false;"><button class="btnType01 bc_green">저장</button></span> -->
										<span class="right"><button id="btn_save" class="btnType01 bc_green">저장</button></span>
									</c:if>
								</div>
								
							</fieldset>
							</div>
							
							
						</div>
							
							</div>
					</form>
					</div>
				<!--content E-->
			</div>
		</div>
	</div>
	<div style="height: 200px"></div>
		<!--footer S-->
<%-- 			<tiles:insertAttribute name="footer" /> --%>
		<!--footer E-->
	
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
								   <th class="top">원격정거장명</th>
								   <td class="top">
									   <span class="input-text07">
									   <!-- <input type="text" name="" id="" readonly="readonly" value="" /> -->
									   <input type="text" name="remote_station_name" id="remote_station_name"/>
									   </span>
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
						  <th>위도/경도</th>
						  <td>
							 <span class="pwtableblock">
								<!-- <input type="text"  name="beaconList[0].serialNo" id="SserialNo0" placeholder="위도/경도" value=""/> -->
								<!-- <a href="#" id="0" onclick="fn_beaconDupChkFnc([this.id],'insert');return false;">저장</a> -->
								  <!-- <a href="#" id="0" onclick="fn_matchingBeacon2([this.id],'delete');return false;">삭제</a> -->
												<p>
													<span class="input-text02"><input type="text" class="input-text03" id="remote_latitude" name="beaconList[0].remote_latitude"  placeholder="위도"/> / </span>
												</p>
												<p>
													<span class="input-text02"><input type="text" class="input-text03" id="remote_logitude" name="beaconList[0].remote_logitude"  placeholder="경도"/></span>
													<button class="btnType02" onclick="goMapAddr();" type="button">지도보기</button>
												</p>
							</span>
								 
								  
						  </td>
						  
					  </tr>
					  <tr>
						  <th>원격 사용 여부</th>
						  <td>
						  	<!-- 
							<span class="pwtableblock">
								  <input type="text"  name="beaconList[0].serialNo" id="SserialNo0" placeholder="위도/경도" value=""/>
								 
								  <a href="#" id="0" onclick="fn_beaconDupChkFnc([this.id],'insert');return false;">저장</a>
								  <a href="#" id="0" onclick="fn_matchingBeacon2([this.id],'delete');return false;">삭제</a>
							</span>
							 -->
							<span class="input-rd01"><input type="radio" name="remote_use_yn" id="remote_use_y" value="Y"><label for="remote_use_y">사용</label></span>
							<span class="input-rd01"><input type="radio" name="remote_use_yn" id="remote_use_n" value="N"><label for="remote_use_n">미사용</label></span>
						  </td>
						  
					  </tr>
				</table>
			</div>
		</div>
		</section>
</body>
</html>

