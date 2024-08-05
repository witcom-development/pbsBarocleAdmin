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

<script type="text/javascript">
	
// 아파트명 중복검사
	function fn_duplGroupName(){
		
		//alert($("#LAG_001").val())
		
		if(!$("#LAG_001").val()){
			alert('<spring:message code="fail.input.emptyValue1" arguments="아파트명"/>');
			$("#LAG_001").focus();
			return;
		}
		
		if("${cmd}" == "INFO"){
			if($("#LAG_001").val() == $("#checkName").val()){
				alert('<spring:message code="fail.duplicated.data" arguments="아파트명"/>');
				return;
			}else{
				fn_ServerCheck();
			}
		}else{
			fn_ServerCheck();
		}
		
		
	}
	
	
	function fn_ServerCheck(){
		$.post("/admin/manage/stationGroup/stationGroupNameCheck.do", "station_grp_name=" + $("#LAG_001").val()  , function(data) {
			
			
			if(data.result == "ok"){
				alert('<spring:message code="success.duplicationCheck.isNot" arguments="아파트명"/>');
				$("#checkName").val($("#LAG_001").val());
			}else{
				alert('<spring:message code="fail.duplicated.data" arguments="아파트명"/>');
			}
			
		});
		
	}
	
	function fn_list(){
		
		$("#frm").attr("action" , "/admin/manage/stationGroup/stationGroupList.do");
		
		$("#frm").submit();
	}
	
	function fn_delete( key ){

		
		if("${fn:length(stationList) }" > 0){
			alert('<spring:message code="fail.common.delete4" arguments="해당아파트,하위 정거장"/>');
			
			return;
		}
		
		$("#cmd").val("DELETE");
		$("#station_grp_seq").val(key);
		
		if(confirm('<spring:message code="common.delete.msg"/>')){
			
			
		//	$("#frm").attr("action" , "/admin/manage/stationGroup/stationGroupModify.do");
		//	$("#frm").submit();
			
			$.post("/admin/manage/stationGroup/stationGroupModify.do", $("#frm").serialize()  , function(data) {
				
				if(data.rtMsg == "성공"){
					alert('<spring:message code="success.common.delete"/>')
					fn_list();
				}else{
					alert('<spring:message code="fail.request.msg"/>')
				}
			});
		}
	}
	
	
	var doubleClick = true;
	
	function fn_regist(){
		var temp  = false;
		$("input[name=nameList]").each(function(){
			//alert($(this).val())
			if(!$(this).val()){
				alert('<spring:message code="fail.input.emptyValue1" arguments="아파트명"/>'); 
				$(this).focus();
				temp = true;
				return false;
			}
		});
		
		if(temp){
			return;
		}
		
		if( $("#LAG_001").val() != $("#checkName").val() || !$("#checkName").val()){
			alert('<spring:message code="fail.input.emptyValue2" arguments="중복검사"/>'); 
			return;
		}
		
		
		
// 		if(!$("input[name=comptb_can_yn]").is(":checked")){
// 			alert('<spring:message code="fail.input.emptyValue2" arguments="호환가능 여부"/>'); 
// 			return;
// 		}
		
		
		$("#cmd").val("INSERT");
		
			
		//	$("frm").attr("action", "/admin/manage/stationGroup/stationGroupModify.do");
		//	$("frm").submit();
		
		if(doubleClick){
			doubleClick = false;
			$.post("/admin/manage/stationGroup/stationGroupModify.do", $("#frm").serialize()  , function(data) {
				if(data.rtMsg == "성공"){
					alert('<spring:message code="success.common.save"/>');
					fn_list();
				}else{
					alert('<spring:message code="fail.request.msg"/>');
				}
			});
		}
	}
	
	function fn_update( key){
		
		
		var temp  = false;
		$("input[name=nameList]").each(function(){
			//alert($(this).val())
			if(!$(this).val()){
				
				alert("정거장명을 입력 바랍니다.");
				$(this).focus();
				temp = true;
				return false;
			}
			
		});
		
		if(temp){
			return;
		}
		
		if( $("#LAG_001").val() != $("#checkName").val() || !$("#checkName").val() ){
			alert("아파트명 변경시 중복확인 바랍니다.");
			return;
		}
		
		$("#cmd").val("UPDATE");
		$("#station_grp_seq").val(key);
		
		
			
		//	$("frm").attr("action", "/admin/manage/stationGroup/stationGroupModify.do");
		//	$("frm").submit();
			
		
		$.post("/admin/manage/stationGroup/stationGroupModify.do", $("#frm").serialize()  , function(data) {
			if(data.rtMsg == "성공"){
				alert("저장 되었습니다.");
			}else{
				alert("error");
			}
		});
	}
	
	
	
	$(function() {
		
		if("${result }" != ""){
			alert("${result}")
		}
		
		if("${cmd}" == "INFO"){
			
			$("#station_grp_name").val('${info.station_grp_name }');
			$("#checkName").val('${info.station_grp_name }');
			
			
			
// 			if('${info.comptb_can_yn }' == "Y"){
// 				$("#comptb_can_y").prop('checked', true);
// 			}else{
// 				$("#comptb_can_n").prop('checked', true);
// 			}
			
			
			"<c:forEach items='${multiLang }' var='lang'>"
				
				$("#"+"${lang.lang_cls_cd}").val("${lang.station_grp_name}");

			"</c:forEach>"
			
			
// 			$("select[name=main_station_id]").val('${info.main_station_id }');
		}
			
		
		
	});
	
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
				<form action="" method="post"	name="frm" id="frm">				
					<div class="content">
					<div class="subject">
						<!--subject path S-->
							<tiles:insertAttribute name="subject" />
						<!--subject path E-->
					</div>
					<div class="page">
							<fieldset>
								<table  class="tb_type02 mt20">
									<caption>아파트 상세</caption>
									<colgroup>
										<col style="width:25%"/>
										<col style="width:75%"/>
									</colgroup>
									<tbody>
										
											<tr>
												<th class="top"><em>*</em>아파트명</th>
												<td class="top lengcase1">
													<c:forEach items="${codeList }" var="code" varStatus="idx">
														<p><label>${code.comCdName }</label><span class="input-text11"><input type="text" name="nameList" id="${code.comCd }" maxlength="25" /></span>
															<input type="hidden" name="codeList" value="${code.comCd }" maxlength="25">
														
														<c:if test="${idx.index == 0 }">
															
															<button class="btnType02" onclick="fn_duplGroupName(); return false;">중복확인</button>
															<input type="hidden" id="checkName">
															<input type="hidden" id="cmd" name="cmd">
															<input type="hidden" id="station_grp_seq" name="station_grp_seq">
															<input type="hidden" id="main_station_id" name="main_station_id" value="">
															<input type="hidden" id="comptb_can_yn" name="comptb_can_yn" value="Y">
														</c:if>
													</p>
													</c:forEach>
												</td>
											</tr>
									<%-- 
									<c:if test="${cmd == 'INFO'}">
										<tr>
											<th>대표정거장</th>
											<td>
												<span class="input-text04">
													<select name="	" class="select-category02">
														<option value="">선택</option>
														<c:forEach items="${stationList }" var="station">
															
															<option value="${station.station_id }">${station.station_name }</option>
														
														</c:forEach>
													</select>
												</span>
											</td>
										</tr>
									</c:if>
									 --%>
										<!-- 
										<tr>
											<th><em>*</em>호환가능 여부</th>
											<td>
												<span class="input-rd01"><input type="radio" name="comptb_can_yn" id="comptb_can_y" value="Y"><label for="comptb_can_y">YES</label></span>
												<span class="input-rd01"><input type="radio" name="comptb_can_yn" id="comptb_can_n" value="N"><label for="comptb_can_n">NO</label></span>
											</td>
										</tr>
										 -->
									</tbody>
								</table>
							</fieldset>
						<div class="btnArea">
							<c:if test="${cmd == 'INFO'}">
								<span class="left" onclick="fn_list()"><button class="btnType01 bc_gray">목록</button></span>
								<span class="right" onclick="fn_update('${info.station_grp_seq}'); return false;"><button class="btnType01 bc_green">저장</button></span>
								<span class="right" onclick="fn_delete('${info.station_grp_seq}')"><button class="btnType01" type="button">삭제</button></span>
							</c:if>
							
							<c:if test="${cmd == 'INSERT'}">
								<span class="left" onclick="fn_list()"><button class="btnType01 bc_gray">목록</button></span>
								<span class="right" onclick="fn_regist(); return false;"><button class="btnType01 bc_green">저장</button></span>
							</c:if>
						</div>
						
					</div>
					</div>
				</form>	
				<!--conteent E-->
				<!--content E-->
			</div>
		</div>
		<!--footer S-->
			<tiles:insertAttribute name="footer" />
		<!--footer E-->
	</div>
</body>
</html>
	
