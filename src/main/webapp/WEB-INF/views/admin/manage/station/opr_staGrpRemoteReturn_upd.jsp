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
// 	function fn_duplStationNameCheck(){
// 		if("${cmd}" == "INFO"){
// 			if($("#LAG_001").val() == $("#checkName").val()){
// 				alert('<spring:message code="fail.duplicated.data" arguments="정거장 명"/>');
// 				return;
// 			}
// 		}
		
// 		if(!$("#LAG_001").val()){
// 			alert('<spring:message code="fail.input.emptyValue1" arguments="정거장 명"/>');
// 			return;
// 		}
		
// 		$.post("/admin/manage/station/stationNumberCheck.do", "station_name=" + $("#LAG_001").val()  , function(data) {
// 			if(data.result == "ok"){
// 				alert('<spring:message code="success.duplicationCheck.isNot" arguments="정거장 명"/>');
// 				$("#checkName").val($("#LAG_001").val());
// 			}else{
// 				alert('<spring:message code="fail.duplicated.data" arguments="정거장 명"/>');
// 			}
// 		});
// 	}
	
	function fn_list(){
		$("#frm").attr("action", "/admin/manage/station/stationGrpRemoteReturnList.do");
		$("#frm").submit();
	}
	
	$(function() {
		if("${result }" != ""){
			alert("${result}")
		}
		
		if("${cmd}" == "INFO"){
			$("select[name=station_grp_seq]").val("${info.station_grp_seq}");
			
// 			"<c:forEach items='${stationName }' var='lang'>"
// 				$("#"+"${lang.lang_cls_cd}").val("${lang.station_name}");
// 			"</c:forEach>"
			
// 			$("#checkName").val($("#LAG_001").val());
			
// 			$("#remote_station_name").val("${info.remote_station_name }");
// 			$("#remote_latitude").val("${info.remote_latitude }");
// 			$("#remote_logitude").val("${info.remote_logitude }");
			
			if('${info.remote_use_yn }' == "Y"){
				$("#remote_use_y").prop('checked', true);
			}else if('${info.remote_use_yn }' == "N"){
				$("#remote_use_n").prop('checked', true);
			}
			
// 			if("${info.device_id}" != ""){
// 				$("select[name=device_id]").append("<option value='${info.device_id}' selected>${info.device_id}");
// 			}
			
			//$("#btn_addCode").on("click",this.clickAddCodeFormFnc);
			
			commcodeEdit.initBtn('');
		}
		
		
// 		$("[name='remote_use_yn']").on("change",  function(){
// 			var radioVal = $(':radio[name="remote_use_yn"]:checked').val();
// 		});
		
// 		commonAjax.getCommonCode("RAK", function(data){
// 			if(data !== null && data.codeList !== null) {
// 				var code = new Array();
// 				for(var i =0; i <data.codeList.length ;i++) {
// 					code.push(data.codeList[i]);
// 				}
// 				commCdBox.makeComboBox('CC', '${info.station_se_cd}', code, "station_se_cd");
// 			}
// 		});
		
// 		commonAjax.getCommonCode("ENT", function(data){
// 			if(data !== null && data.codeList !== null) {
// 				var code = new Array();
// 				 for(var i =0; i <data.codeList.length ;i++) {
// 						 code.push(data.codeList[i]);
// 				 }
// 				 commCdBox.makeComboBox('CC', '${info.rack_entrps_cd}', code, "rack_entrps_cd");
// 			}
// 		});
		
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
		if(flag == "UPDATE"){
// 			fn_update( id );
			$("#cmd").val("UPDATE");
			$("#remote_return_seq").val(id);
// 			var radioVal = $(':radio[name="remote_use_yn"]:checked').val();
// 			if('${info.remote_use_yn }' == radioVal  ){
// // 				frm.histYn.value = 'N';
// 			} else {
// 				frm.histYn.value = 'Y';
// 			}
			
			//var target = document.getElementsByName("selectBox");
			if (confirm('<spring:message code="common.save.msg"/>')){
				$("#frm").attr({method : "post", action : "/admin/manage/station/stationGrpRemoteReturnModify.do"}).submit();
			}
			
			/*	
			$.post("/admin/manage/station/stationGrpRemoteReturnModify.do", $("#frm").serialize()  , function(data) {
				
				if(data.rtMsg == "성공"){
					alert('<spring:message code="success.common.save" />');
					fn_list();
				}else{
					alert('<spring:message code="fail.request.msg" />');
				}
			});
			*/
		}
	}
	
// 	var doubleClick = true;	
	
	function fn_delete(id){
		$("#cmd").val("DELETE");
		$("#remote_return_seq").val(id);
		
		if(confirm('<spring:message code="common.delete.msg"/>')){
			$("#frm").attr("action", "/admin/manage/station/stationGrpRemoteReturnModify.do");
			$("#frm").submit();
		}
	}
	
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
	
	
// function fn_beaconDupChkFnc(serialNo ,mode){
// 	if( $("#stationGrpRemoteReturnList["+serialNo+"].serialNo").val() === '' ) {
// 		alert("체크 할 ID를 입력 해주세요.");
// 		return;
// 	}
	
// 	if(!isAlNumber($("#SserialNo"+serialNo).val())) {
// 		alert("영문,숫자로만 입력 해주세요.");
// 		$("#deviceId").val('').focus();
// 		return;
// 	}
	
// 	var lengthChk = $("#SserialNo"+serialNo).val();
// 	if( lengthChk.length < 14 ) {
// 		alert("체크 할 ID를 14자리로 해주세요.");
// 		return;
// 	}
	
// 	var chkId = $("#SserialNo"+serialNo).val();
// 	var type ="serial";
// 	var oldDeviceId = "";
	
// 	if(mode =='update'){
// 		oldDeviceId = $("[name='stationGrpRemoteReturnList["+serialNo+"].deviceId']").val();
// 	}
	
// 	commonAjax.postAjax(
// 			"<c:out value='/beacon/dupIdCheckAjax.do'/>"
// 			, "json"
// 			, { chkId : chkId , chkType : type }
// 			, function(data){
// 				  if(data) {
// 					  if((data.isDup === "true")) {
						
// 						  if(data.resultVo != null && data.resultVo.nowLocateId !=null && data.resultVo.nowLocateId !=''){
							  
// 							  if(confirm(data.resultVo.stationName+data.resultVo.centerName+ '에 이미 등록된 비콘입니다 변경하시겠습니까?')) {
// 								  $('#SdeviceId'+serialNo).val(data.resultVo.deviceId);
								  
// 								  //바로 등록 ㄱㄱ
// 								fn_matchingBeacon(data.resultVo.deviceId,oldDeviceId);
// 							  } else {
								  
// 							  }
// 						  } else {
// 							  $('#SdeviceId'+serialNo).val(data.resultVo.deviceId);
// 							  fn_matchingBeacon(data.resultVo.deviceId,oldDeviceId);
// 						  }
						  
// 					  } else {
// 						  alert("등록 되지 않은 시리얼 번호 입니다.");
// 					  }
// 				  }
// 			  }
// 		);
// 	}
	
// function fn_matchingBeacon(deviceId, oldDeviceId){
// 	var station_grp_seq ='${info.station_grp_seq}';
// 	//var nowLocateClsCd = '${info.station_cls_cd}';
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
								<li class="tab on"><button type="button">대리반납정거장 정보</button></li>
								<!-- <li class="tab"><button type="button">사용 이력</button></li> -->
							</ul>
							<div class="tabCon on">
							<fieldset>
								<table  class="tb_type02 mt20">
									<caption>대리반납정거장 상세</caption>
									<colgroup>
										<col style="width:25%"/>
										<col style="width:75%"/>
									</colgroup>
									<tbody>
										<tr>
											<th class="top"><em>*</em>아파트</th>
											<td class="top">
												<select name="station_grp_seq" id="station_grp_seq" class="select-category02">
													<option value="">선택</option>
													<c:forEach items="${groupList}" var="group">
														<option value="${group.station_grp_seq }">${group.station_grp_name }</option>
													</c:forEach>
												</select>
											</td>
										</tr>
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
												<!-- <input type="hidden" id="station_grp_seq" name="station_grp_seq"> -->
												<input type="hidden" id="remote_return_seq" name="remote_return_seq">
												<input type="hidden" id="cmd" name="cmd" value="${cmd }">
										
										<tr>
											<th><em>*</em>대리정거장명</th>
											<td class="lengcase1">
												<input type="text" name="remote_station_name" id="remote_station_name" value="${info.remote_station_name}"/>
												<%-- 
												<c:forEach items="${codeList }" var="code" varStatus="idx">
													<p><label>${code.comCdName }</label><span class="input-text11"><input type="text" name="nameList" id="${code.comCd }" /></span>
														<c:if test="${idx.index == 0 }">
															<button class="btnType02" onclick="fn_duplStationNameCheck(); return false;">중복확인</button>
														</c:if>
														<input type="hidden" name="codeList" value="${code.comCd }" maxlength="50">
													</p>
												</span>
												</c:forEach>
												 --%>
												 
											</td>
										</tr>
										
										
										<tr>
											<th>위도/경도</th>
											<td>
												<p>
													<span class="input-text02"><input type="text" class="input-text03" id="remote_latitude" name="remote_latitude" value="${info.remote_latitude}"/> / </span>
												</p>
												<p>
													<span class="input-text02"><input type="text" class="input-text03" id="remote_logitude" name="remote_logitude" value="${info.remote_logitude}"/></span>
													<button class="btnType02" onclick="goMapAddr();" type="button">지도보기</button>
												</p>
											</td>
										</tr>
										<tr>
											<th><em>*</em>대리 사용 여부</th>
											<td>
												<span>
													<span class="input-rd01"><input type="radio" name="remote_use_yn" id="remote_use_y" value="Y"><label for="remote_use_y">사용</label></span>
													<span class="input-rd01"><input type="radio" name="remote_use_yn" id="remote_use_n" value="N"><label for="remote_use_n">미사용</label></span>
												</span>
											</td>
										</tr>
										
										</tr>
									</tbody>
								</table>
						
								
								<div class="btnArea">
									<c:if test="${cmd == 'INFO'}">
										<span class="left" onclick="fn_list(); return false;"><button class="btnType01 bc_gray">목록</button></span>
										<span class="right" onclick="vallidateModify('UPDATE','${info.remote_return_seq}'); return false;"><button class="btnType01 bc_green">저장</button></span>
										<span class="right" onclick="fn_delete('${info.remote_return_seq}'); return false;"><button class="btnType01 bc_green">삭제</button></span>
									</c:if>
								</div>
								
							</fieldset>
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
						<th class="top">아파트</th>
						<td class="top">
<!-- 							<span class="input-text07"> -->
<!-- 							<input type="text" name="" id="" readonly="readonly" value="" /> -->
<!-- 							<input type="text" name="remote_station_name" id="remote_station_name"/> -->
<!-- 							</span> -->
<!-- 							<span class="input-text07"> -->
<!-- 							<select name="station_grp_seq"> -->
<!-- 								<option value="">선택</option> -->
<%-- 								<c:forEach items="${groupList}" var="group"> --%>
<%-- 									<option value="${group.station_grp_seq }">${group.station_grp_name }</option> --%>
<%-- 								</c:forEach> --%>
<!-- 							</select> -->
<!-- 							</span> -->
						</td>
					</tr>
					<tr>
						<th class="top">대리반납정거장명</th>
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
						   <input type="hidden" name="stationGrpRemoteReturnList[0].beaconId" value="0"/>
		  				 </td>
					</tr> -->
					<tr>
						<th>위도/경도</th>
						<td>
							 <span class="pwtableblock">
								<!-- <input type="text"  name="stationGrpRemoteReturnList[0].serialNo" id="SserialNo0" placeholder="위도/경도" value=""/> -->
								<!-- <a href="#" id="0" onclick="fn_beaconDupChkFnc([this.id],'insert');return false;">저장</a> -->
								<!-- <a href="#" id="0" onclick="fn_matchingBeacon2([this.id],'delete');return false;">삭제</a> -->
												<p><span class="input-text02"><input type="text" class="input-text03" id="remote_latitude" name="remote_latitude" value="${info.remote_latitude}" placeholder="위도"/> / </span></p>
												<p><span class="input-text02"><input type="text" class="input-text03" id="remote_logitude" name="remote_logitude" value="${info.remote_logitude}" placeholder="경도"/></span>
												<button class="btnType02" onclick="goMapAddr();" type="button">지도보기</button></p>
							</span>
						</td>
						
					</tr>
					<tr>
						<th>대리 사용 여부</th>
						<td>
							<!-- 
							<span class="pwtableblock">
								  <input type="text"  name="stationGrpRemoteReturnList[0].serialNo" id="SserialNo0" placeholder="위도/경도" value=""/>
								 
								  <a href="#" id="0" onclick="fn_beaconDupChkFnc([this.id],'insert');return false;">저장</a>
								  <a href="#" id="0" onclick="fn_matchingBeacon2([this.id],'delete');return false;">삭제</a>
							</span>
							 -->
							<span class="input-rd01"><input type="radio" name="remote_use_yn" id="Sremote_use_y0" value=""><label for="remote_use_y">사용</label>
							<!-- <input type="radio" name="remote_use_yn" id="remote_use_y" value="Y"><label for="remote_use_y">사용</label> -->
							</span>
							<span class="input-rd01"><input type="radio" name="remote_use_yn" id="Sremote_use_n0" value=""><label for="remote_use_n">미사용</label>
							<!-- <input type="radio" name="remote_use_yn" id="remote_use_n" value="N"><label for="remote_use_n">미사용</label> -->
							</span>
						</td>
					</tr>
				</table>
			</div>
		</div>
		</section>
</body>
</html>

