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

<script type="text/javaScript" language="javascript" >

$(document).ready(function() {
	
	if("${type}" == "U" ){
		$("select[name=admin_cls_cd]").val("${inputFrm.admin_cls_cd }");
		$('#inputFrm #usrGrpCd :not(:selected)').remove();
		menuTebleSetting('menuGrpTable');
	}
	
	
	$("#checkAll").click(function(){
		
		if($("#checkAll").prop("checked")){
			
			$("input[name=crudCheckBox]").prop("checked", true);
			$("input[name=readYn]").prop("checked", true);
			$("input[name=creYn]").prop("checked", true);
			$("input[name=updateYn]").prop("checked", true);
			$("input[name=delYn]").prop("checked", true);
			
			$("#checkSearch").prop("checked", true);
			$("#checkInsert").prop("checked", true);
			$("#checkUpdate").prop("checked", true);
			$("#checkDelete").prop("checked", true);
			
		}else{
			$("input[name=crudCheckBox]").prop("checked", false);
			$("input[name=readYn]").prop("checked", false);
			$("input[name=creYn]").prop("checked", false);
			$("input[name=updateYn]").prop("checked", false);
			$("input[name=delYn]").prop("checked", false);
			
			$("#checkSearch").prop("checked", false);
			$("#checkInsert").prop("checked", false);
			$("#checkUpdate").prop("checked", false);
			$("#checkDelete").prop("checked", false);
			
		}
		
		
	});
	
	$("#checkSearch").click(function(){
		if($("#checkSearch").prop("checked")){
			$("input[name=readYn]").prop("checked", true);
		}else{
			$("input[name=readYn]").prop("checked", false);
		}
	});
	$("#checkInsert").click(function(){
		if($("#checkInsert").prop("checked")){
			$("input[name=creYn]").prop("checked", true);
		}else{
			$("input[name=creYn]").prop("checked", false);
		}
	});
	$("#checkUpdate").click(function(){
		if($("#checkUpdate").prop("checked")){
			$("input[name=updateYn]").prop("checked", true);
		}else{
			$("input[name=updateYn]").prop("checked", false);
		}
	});
	$("#checkDelete").click(function(){
		if($("#checkDelete").prop("checked")){
			$("input[name=delYn]").prop("checked", true);
		}else{
			$("input[name=delYn]").prop("checked", false);
		}
	});
	
	
	
});


/* 글 목록 화면 function */
function groList() {
   	document.searchFrm.action = "<c:url value='/admin/system/userGroup/groupList.do'/>";
   	document.searchFrm.submit();
}

/* 글 등록 function */
function groInsert() {
	
		
	if(!$("select[name=admin_cls_cd]").val()){
		alert('<spring:message code="fail.input.emptyValue1" arguments="관리구분"/>');
		$("select[name=admin_cls_cd]").focus();
		return;
	}
	if(!$("input[name=grpName]").val()){
		alert('<spring:message code="fail.input.emptyValue1" arguments="그룹이름"/>');
		$("input[name=grpName]").focus();
		return;
	}
	
	if(!$("textarea[name=grpDesc]").val()){
		alert('<spring:message code="fail.input.emptyValue1" arguments="그룹설명"/>');
		$("textarea[name=grpDesc]").focus();
		return;
	}
	
	var frm = document.inputFrm;
	var searchFrm = document.searchFrm;
	
	
	$("input[name=usrGrpCd]").val($("select[name=admin_cls_cd]").val());
	
		$.ajax({
			type:"POST",
			asyn : true,
			url:"<c:url value='/admin/system/userGroup/groInsert.do'/>",
			data : $("#inputFrm").serialize(),
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			dataType:"json",
			success:function(data){
				if(data.result == "ok"){
					if(data.checkResult > 0){
						alert('<spring:message code="success.common.save" />');
						window.location.href="<c:url value='/admin/system/userGroup/groupList.do'/>";
					}else{
						alert('<spring:message code="fail.request.msg" />');
					}
				}else if(data.result == "error"){
					alert('<spring:message code="fail.request.msg" />');
				}else{
					alert('<spring:message code="fail.request.msg" />');
				}
			}, error: function(request, status, error) {
				alert('<spring:message code="fail.request.msg" />');
			}
		});
	
}

/* 글 수정 function */
function groUpdate() {

	var frm = document.inputFrm;
	var searchFrm = document.searchFrm;
	
		$.ajax({
			type:"POST",
			asyn : true,
			url:"<c:url value='/admin/system/userGroup/groUpdate.do'/>",
			data : $("#inputFrm").serialize(),
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			dataType:"json",
			success:function(data){

				if(data.result == "ok"){
					
					if(data.checkResult > 0){
						alert('<spring:message code="success.common.save" />');
						//groList();
					}else{
						alert('<spring:message code="fail.request.msg" />');
					}
 
				}else if(data.result == "error"){
					alert('<spring:message code="fail.request.msg" />');
				}else{
					alert('<spring:message code="fail.request.msg" />');
				}

			}, error: function(request, status, error) {
				alert('<spring:message code="fail.request.msg" />');
			}
		});
	
}

/* 글 삭제 function */
function groDelete() {
	var frm = document.inputFrm;
	var searchFrm = document.searchFrm;
	
	
	var confirmMsg1 = '<spring:message code="common.delete.alert.msg" />';
	var confirmMsg2 = '<spring:message code="common.delete.msg3" />';
	
	if(confirm(confirmMsg1 + "\n" + confirmMsg2)){
		$.ajax({
			type:"POST",
			asyn : true,
			url:"<c:url value='/admin/system/userGroup/groDelete.do'/>",
			data : $("#inputFrm").serialize(),
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			dataType:"json",
			success:function(data){

				if(data.result == "ok"){
					
					if(data.checkResult > 0){
						alert('<spring:message code="success.common.save" />');
						
						window.location.href="<c:url value='/admin/system/userGroup/groupList.do'/>";
					}else{
						alert('<spring:message code="fail.request.msg" />');
					}

				}else if(data.result == "error"){
					alert('<spring:message code="fail.request.msg" />');
				}else{
					alert('<spring:message code="fail.request.msg" />');
				}

			}, error: function(request, status, error) {
				alert('<spring:message code="fail.request.msg" />');
			}
		});
	}
}

function allCheck(obj, acrud){
	
	var isChecked = false;
	
	var crudCheckBoxList = document.menuGrp.crudCheckBox;
	
	if(acrud == 'A') {
		isChecked = obj.checked;
		
		for(var i =0; i < crudCheckBoxList.length; i++){
			crudCheckBoxList[i].checked = obj.checked;
			crudCheck(crudCheckBoxList[i]);
		}
	} else if(acrud == 'R') {
		isChecked = $('input:checkbox[name="allCheckBoxR"]').is(':checked');
		$('input:checkbox[name="readYn"]').each(function() {
			this.checked = isChecked;
		});
	} else if(acrud == 'C') {
		isChecked = $('input:checkbox[name="allCheckBoxC"]').is(':checked');
		$('input:checkbox[name="creYn"]').each(function() {
			this.checked = isChecked;
		});
	} else if(acrud == 'U') {
		isChecked = $('input:checkbox[name="allCheckBoxU"]').is(':checked');
		$('input:checkbox[name="updateYn"]').each(function() {
			this.checked = isChecked;
		});
	} else if(acrud == 'D') {
		isChecked = $('input:checkbox[name="allCheckBoxD"]').is(':checked');
		$('input:checkbox[name="delYn"]').each(function() {
			this.checked = isChecked;
		});
	}
	
	if(!isChecked) {
		$('input:checkbox[name="crudCheckBox"]').attr("checked", false);
	}
	
}

function crudCheck(obj){
	var elementInputs = obj.parentNode.parentNode.getElementsByTagName("input");

	var checked = obj.checked;

	if(elementInputs != null){
		for(var i=0; i < elementInputs.length; i++){
			if(elementInputs[i] != null && elementInputs[i].type == "checkbox" ){
				elementInputs[i].checked = checked;
			}
		}
	}
	
}

function crudCheckYn(obj){
	
	var elementInputs = obj.parentNode.parentNode.getElementsByTagName("input");

	var crudCheckBox;
	var crudCheckBoxYn = true;
	var checkBoxCnt = 0;
	
	if(elementInputs != null){
		for(var i=0; i < elementInputs.length; i++){
			//alert(elementInputs[i].nodeName + " / " + elementInputs[i].type + " / " + elementInputs[i].nodeValue);
			if(elementInputs[i] != null && elementInputs[i].type == "checkbox" ){
				if(crudCheckBoxYn){
					crudCheckBox = elementInputs[i];
					crudCheckBoxYn = false;
				}else{
					if(elementInputs[i].checked){
						checkBoxCnt++;	
					}
				}
				//table.deleteRow(elementInputs[i].value);
			}
		}
		if(checkBoxCnt == 4){
			crudCheckBox.checked = true;
		}else{
			crudCheckBox.checked = false;
		}
		
	}
	
}

function menuGrpUpdate(){
	
		
	try{
		
	var inputFrm = document.inputFrm;
	var frm = document.menuGrp;
	var searchFrm = document.searchFrm;

	var menuGrpFrm = formCreate("menuGrpList","post",'','');

	formInput(menuGrpFrm,"usrGrpCd",inputFrm.usrGrpCd.value);	
	
	for(var i = 0; i < frm.depth1Cd.length; i++){
		formInput(menuGrpFrm,"menuGrpList["+i+"].depth1Cd",frm.depth1Cd[i].value);	
		formInput(menuGrpFrm,"menuGrpList["+i+"].depth2Cd",frm.depth2Cd[i].value);	
		formInput(menuGrpFrm,"menuGrpList["+i+"].depth3Cd",frm.depth3Cd[i].value);	
		formInput(menuGrpFrm,"menuGrpList["+i+"].depth4Cd",frm.depth4Cd[i].value);	
		if(frm.readYn[i].checked){	formInput(menuGrpFrm,"menuGrpList["+i+"].readYn","Y");	}else{	formInput(menuGrpFrm,"menuGrpList["+i+"].readYn","N");	}
		if(frm.creYn[i].checked){	formInput(menuGrpFrm,"menuGrpList["+i+"].creYn","Y");	}else{	formInput(menuGrpFrm,"menuGrpList["+i+"].creYn","N");	}
		if(frm.updateYn[i].checked){	formInput(menuGrpFrm,"menuGrpList["+i+"].updateYn","Y");	}else{	formInput(menuGrpFrm,"menuGrpList["+i+"].updateYn","N");	}
		if(frm.delYn[i].checked){	formInput(menuGrpFrm,"menuGrpList["+i+"].delYn","Y");	}else{	formInput(menuGrpFrm,"menuGrpList["+i+"].delYn","N");	}
	}

	//if(confirm("메뉴 권한을 수정 하시겠습니까?")){
		$.ajax({
			type:"POST",
			asyn : true,
			url:"<c:url value='/admin/system/userGroup/grpMenuUpdate.do'/>",
			data : $(menuGrpFrm).serialize(),
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			dataType:"json",
			success:function(data){
	
				if(data.result == "ok"){
					
					if(data.checkResult > 0){
						alert('<spring:message code="success.common.save" />');
						//groList();
					}else{
						alert('<spring:message code="success.common.save" />');
					}

				}else if(data.result == "error"){
					alert(data.resultMessage);
				}else{
					alert('<spring:message code="fail.request.msg" />');
				}

			}, error: function(request, status, error) {
				alert('<spring:message code="fail.request.msg" />');
			}
		});
	//}
	
	
	} catch (e) {
		alert(e)
	}
	
	
}

/* 폼: 생성 */
function formCreate(nm, mt, at, tg) {
	var f = document.createElement("form");
	f.name = nm;
	f.method = mt;
	f.action = at;
	f.target = tg ? tg : "_self";
	return f;
}
/* 폼: 인풋 생성 */
function formInput(f, n, v) {
	var i = document.createElement("input");
	i.type = "hidden";
	i.name = n;
	i.value = v;
	// f.appendChild(i);
	f.insertBefore(i, null);
	// f.insertBefore(i);
	return f;
}
</script>


<script type="text/javascript">
    $(function () {
        $('.remaining').each(function () {
            // count 정보 및 count 정보와 관련된 textarea/input 요소를 찾아내서 변수에 저장한다.
            var $maxcount = $('.maxcount', this);
            var $count = $('.count', this);
            var $input = $("#contents");
 
            // .text()가 문자열을 반환하기에 이 문자를 숫자로 만들기 위해 1을 곱한다.
            var maximumByte = $maxcount.text() * 1;
            // update 함수는 keyup, paste, input 이벤트에서 호출한다.
            var update = function () {
                var before = $count.text() * 1;
                var str_len = $input.val().length;
                var cbyte = 0;
                var li_len = 0;
                for (i = 0; i < str_len; i++) {
                    var ls_one_char = $input.val().charAt(i);
                    if (escape(ls_one_char).length > 4) {
                        cbyte += 2; //한글이면 2를 더한다
                    } else {
                        cbyte++; //한글아니면 1을 다한다
                    }
                    if (cbyte <= maximumByte) {
                        li_len = i + 1;
                    }
                }
                // 사용자가 입력한 값이 제한 값을 초과하는지를 검사한다.
                if (parseInt(cbyte) > parseInt(maximumByte)) {
                    alert('<spring:message code="fail.file.maxSize" arguments="그룹설명,500Byte"/>');
                    
                    var str = $input.val();
                    var str2 = $input.val().substr(0, li_len);
                    $input.val(str2);
                    var cbyte = 0;
                    for (i = 0; i < $input.val().length; i++) {
                        var ls_one_char = $input.val().charAt(i);
                        if (escape(ls_one_char).length > 4) {
                            cbyte += 2; //한글이면 2를 더한다
                        } else {
                            cbyte++; //한글아니면 1을 다한다
                        }
                    }
                }
                $count.text(cbyte);
            };
            // input, keyup, paste 이벤트와 update 함수를 바인드한다
            $input.bind('input keyup keydown paste change', function () {
                setTimeout(update, 0)
            });
            update();
        });
    });
</script>


</head>
<body>

<c:if test="${ inputFrm.usrGrpCd != '' && inputFrm.usrGrpCd!=null }">
	<c:set var="type" value="U" />
</c:if>

<c:if test="${ inputFrm.usrGrpCd == '' || inputFrm.usrGrpCd==null }">
	<c:set var="type" value="I" />
</c:if>

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
<form:form commandName="inputFrm" name="inputFrm" method="post">				
								<div class="content">
					<div class="subject">
						<p class="pageTitle">운영자 그룹 관리 -등록/상세/수정</p>
						<span>시스템 관리 &gt; <em>운영자 그룹 관리</em></span>
					</div>
					<div class="page">
							<fieldset>
								<table  class="tb_type02 mt20">
									<colgroup>
										<col style="width:25%"/>
										<col style="width:75%"/>
									</colgroup>
									<tbody>
										<tr>
											<th class="top"><em>*</em> 관리구분</th>
											<td class="top">
												<form:select path="admin_cls_cd" required="true" title="관리구분" class="select-category02">
													<option value="">선택</option>
													<c:forEach var="result" items="${codeList}" varStatus="status">
														<option value="${result.comCd}" ><c:out value="${result.comCdName}"/></option>
													</c:forEach>
												</form:select>
											</td>
										</tr>
										<tr>
											<th><em>*</em> 그룹이름</th>
											<td>
												<span class="input-text07"><form:input path="grpName" type="text" required="true" title="권한명" maxlength="20"/></span>
												<form:hidden path="usrGrpCd" />
											</td>
										</tr>
										<tr>
											<th><em>*</em> 그룹설명</th>
											<td>
												<form:textarea path="grpDesc" maxlength="500" title="권한설명" class="detatextarea" id="contents"/>
												<span class="right mr2p">
													<span class="remaining">
														<span class="count">0</span>/<span class="maxcount">500</span>Byte
													</span>
												</span>
											</td>
										</tr>
									</tbody>
								</table>
	</form:form>						
	
	
								<div class="btnArea">
									<span class="left" onclick="groList(); return false;"><button class="btnType01 bc_gray">목록</button></span>
									<c:if test="${ type == 'U' }">
										<span class="right" onclick="groUpdate(); return false;"><button class="btnType01 bc_green">저장</button></span>
										<span class="right" onclick="groDelete(); return false;"><button class="btnType01 bc_green">삭제</button></span>
									</c:if>
									<c:if test="${ type == 'I' }">
										<span class="right" onclick="groInsert(); return false;"><button class="btnType01 bc_green">저장</button></span>
									</c:if>
									
								</div>
<c:if test="${ type != 'I'}">


								<form:form commandName="menuGrp" name="menuGrp" id="menuGrp" method="post" >
<c:if test="${ type == 'U' }">								
								<p class="head">메뉴권한 설정</p>
								<table class="tb_type01 mt20" id="menuGrpTable">
									<colgroup>
										<col style="width:10%">
										<col style="width:10%">
										<col style="width:10%">
										<col style="width:15%">
										<col style="width:10%">
										<col style="width:10%">
										<col style="width:10%">
										<col style="width:10%">
										<col style="width:10%">
									</colgroup>
									<thead>
										<tr>
											<th colspan="4">메뉴명</th>
											<th>모두가능<input type="checkbox" class="vm ml10" id="checkAll"/></th>
											<th>조회<input type="checkbox" class="vm ml10" id="checkSearch"/></th>
											<th>등록<input type="checkbox" class="vm ml10" id="checkInsert"/></th>
											<th>수정<input type="checkbox" class="vm ml10" id="checkUpdate"/></th>
											<th>삭제<input type="checkbox" class="vm ml10" id="checkDelete"/></th>
										</tr>
									</thead>
									<tbody>
										
<c:forEach var="result" items="${menuList}" varStatus="status">
	<c:if test="${result.menuLevel == 1 }">
		<c:if test="${result.downCnt < 1 }">
							<tr>
								<td><c:out value="${result.menuName }" /></td>
								<td></td>
								<td></td>
								<td></td>
								<td align="center">
									<input type="hidden" name="depth1Cd" value="<c:out value='${result.menuCd }' />" />
									<input type="hidden" name="depth2Cd" value="" />
									<input type="hidden" name="depth3Cd" value="" />
									<input type="hidden" name="depth4Cd" value="" />
									<c:if test='${result.readYn == "Y" && result.creYn == "Y" && result.updateYn == "Y" && result.delYn == "Y" }' ><input type="checkbox" name="crudCheckBox" onclick="crudCheck(this);" checked="checked" /></c:if>
									<c:if test='${result.readYn != "Y" || result.creYn != "Y" || result.updateYn != "Y" || result.delYn != "Y" }' ><input type="checkbox" name="crudCheckBox" onclick="crudCheck(this);" /></c:if>
									
								</td>
								<td align="center"><input type="checkbox" onclick="crudCheckYn(this);" name="readYn" <c:if test='${result.readYn == "Y" }' >checked="chekced"</c:if> /></td>
								<td align="center"><input type="checkbox" onclick="crudCheckYn(this);" name="creYn" <c:if test='${result.creYn == "Y" }' >checked="chekced"</c:if> /></td>
								<td align="center"><input type="checkbox" onclick="crudCheckYn(this);" name="updateYn" <c:if test='${result.updateYn == "Y" }' >checked="chekced"</c:if> /></td>
								<td align="center"><input type="checkbox" onclick="crudCheckYn(this);" name="delYn" <c:if test='${result.delYn == "Y" }' >checked="chekced"</c:if> /></td>
							</tr>
		</c:if>
		<c:if test="${result.downCnt > 0 }">
							<tr>
								<td><c:out value="${result.menuName }" /></td>
			<c:set var="left2Cnt" value="0" />
			<c:forEach var="result2" items="${menuList}" varStatus="status2">
<%-- 			<c:choose> --%>
<%-- 				<c:when test="${sessionUsrGrpCd == '2'}"> --%>
					<c:if test="${result2.menuLevel == 2 && result.menuCd == result2.upMenu}">
						<c:set var="left2Cnt" value="${left2Cnt+1 }" />
							<c:if test="${left2Cnt > 1 }">
								<tr>
									<td><c:out value="${result.menuName }" /></td>
							</c:if>
						<c:if test="${result2.downCnt < 1 }">
									<td><c:out value="${result2.menuName }" /></td>
									<td></td>
									<td></td>
									<td align="center">
										<input type="hidden" name="depth1Cd" value="<c:out value='${result.menuCd }' />" />
										<input type="hidden" name="depth2Cd" value="<c:out value='${result2.menuCd }' />" />
										<input type="hidden" name="depth3Cd" value="" />
										<input type="hidden" name="depth4Cd" value="" />
										<c:if test='${result2.readYn == "Y" && result2.creYn == "Y" && result2.updateYn == "Y" && result2.delYn == "Y" }' ><input type="checkbox" name="crudCheckBox" onclick="crudCheck(this);" checked="checked" /></c:if>
										<c:if test='${result2.readYn != "Y" || result2.creYn != "Y" || result2.updateYn != "Y" || result2.delYn != "Y" }' ><input type="checkbox" name="crudCheckBox" onclick="crudCheck(this);" /></c:if>
									</td>
									<td align="center"><input type="checkbox" onclick="crudCheckYn(this);" name="readYn" <c:if test='${result2.readYn == "Y" }' >checked="chekced"</c:if> /></td>
									<td align="center"><input type="checkbox" onclick="crudCheckYn(this);" name="creYn" <c:if test='${result2.creYn == "Y" }' >checked="chekced"</c:if> /></td>
									<td align="center"><input type="checkbox" onclick="crudCheckYn(this);" name="updateYn" <c:if test='${result2.updateYn == "Y" }' >checked="chekced"</c:if> /></td>
									<td align="center"><input type="checkbox" onclick="crudCheckYn(this);" name="delYn" <c:if test='${result2.delYn == "Y" }' >checked="chekced"</c:if> /></td>
								</tr>
						</c:if>
						<c:if test="${result2.downCnt > 0 }">
									<td><c:out value="${result2.menuName }" /></td>
							<c:set var="left3Cnt" value="0" />
							<c:forEach var="result3" items="${menuList}" varStatus="status3">
								<c:if test="${result3.menuLevel == 3 && result2.menuCd == result3.upMenu}">
									<c:set var="left3Cnt" value="${left3Cnt+1 }" />
									<c:if test="${left3Cnt > 1 }">
								<tr>
									<td><c:out value="${result.menuName }" /></td>
									<td><c:out value="${result2.menuName }" /></td>
									</c:if>
									<c:if test="${result3.downCnt < 1 }">
									
									<td><c:out value="${result3.menuName }" /></td>
									<td></td>
									<td align="center">
										<input type="hidden" name="depth1Cd" value="<c:out value='${result.menuCd }' />" />
										<input type="hidden" name="depth2Cd" value="<c:out value='${result2.menuCd }' />" />
										<input type="hidden" name="depth3Cd" value="<c:out value='${result3.menuCd }' />" />
										<input type="hidden" name="depth4Cd" value="" />
										<c:if test='${result3.readYn == "Y" && result3.creYn == "Y" && result3.updateYn == "Y" && result3.delYn == "Y" }' ><input type="checkbox" name="crudCheckBox" onclick="crudCheck(this);" checked="checked" /></c:if>
										<c:if test='${result3.readYn != "Y" || result3.creYn != "Y" || result3.updateYn != "Y" || result3.delYn != "Y" }' ><input type="checkbox" name="crudCheckBox" onclick="crudCheck(this);" /></c:if>
									</td>
									<td align="center"><input type="checkbox" onclick="crudCheckYn(this);" name="readYn" <c:if test='${result3.readYn == "Y" }' >checked="chekced"</c:if> /></td>
									<td align="center"><input type="checkbox" onclick="crudCheckYn(this);" name="creYn" <c:if test='${result3.creYn == "Y" }' >checked="chekced"</c:if> /></td>
									<td align="center"><input type="checkbox" onclick="crudCheckYn(this);" name="updateYn" <c:if test='${result3.updateYn == "Y" }' >checked="chekced"</c:if> /></td>
									<td align="center"><input type="checkbox" onclick="crudCheckYn(this);" name="delYn" <c:if test='${result3.delYn == "Y" }' >checked="chekced"</c:if> /></td>
								</tr>
									</c:if>
									<c:if test="${result3.downCnt > 0 }">
									<td><c:out value="${result3.menuName }" /></td>
										<c:set var="left4Cnt" value="0" />
										<c:forEach var="result4" items="${menuList}" varStatus="status4">
											<c:if test="${result4.menuLevel == 4 && result3.menuCd == result4.upMenu}">
												<c:set var="left4Cnt" value="${left4Cnt+1 }" />
												<c:if test="${left4Cnt > 1 }">
								<tr>
									<td><c:out value="${result.menuName }" /></td>
									<td><c:out value="${result2.menuName }" /></td>
									<td><c:out value="${result3.menuName }" /></td>
												</c:if>
									<td><c:out value="${result4.menuName }" /></td>
									<td align="center">
										<input type="hidden" name="depth1Cd" value="<c:out value='${result.menuCd }' />" />
										<input type="hidden" name="depth2Cd" value="<c:out value='${result2.menuCd }' />" />
										<input type="hidden" name="depth3Cd" value="<c:out value='${result3.menuCd }' />" />
										<input type="hidden" name="depth4Cd" value="<c:out value='${result4.menuCd }' />" />
										<c:if test='${result4.readYn == "Y" && result4.creYn == "Y" && result4.updateYn == "Y" && result4.delYn == "Y" }' ><input type="checkbox" name="crudCheckBox" onclick="crudCheck(this);" checked="checked" /></c:if>
										<c:if test='${result4.readYn != "Y" || result4.creYn != "Y" || result4.updateYn != "Y" || result4.delYn != "Y" }' ><input type="checkbox" name="crudCheckBox" onclick="crudCheck(this);" /></c:if>
									</td>
									<td align="center"><input type="checkbox" onclick="crudCheckYn(this);" name="readYn" <c:if test='${result4.readYn == "Y" }' >checked="chekced"</c:if> /></td>
									<td align="center"><input type="checkbox" onclick="crudCheckYn(this);" name="creYn" <c:if test='${result4.creYn == "Y" }' >checked="chekced"</c:if> /></td>
									<td align="center"><input type="checkbox" onclick="crudCheckYn(this);" name="updateYn" <c:if test='${result4.updateYn == "Y" }' >checked="chekced"</c:if> /></td>
									<td align="center"><input type="checkbox" onclick="crudCheckYn(this);" name="delYn" <c:if test='${result4.delYn == "Y" }' >checked="chekced"</c:if> /></td>
								</tr>
											</c:if>		
										</c:forEach>
									</c:if>
								</c:if>
							</c:forEach><!-- level 3 -->
						</c:if>
					</c:if>	
				<%-- </c:when>
				
				<c:otherwise>
					<c:if test="${result2.menuLevel == 2 && result.menuCd == result2.upMenu && result2.menuCd ne '102004'}">
						<c:set var="left2Cnt" value="${left2Cnt+1 }" />
							<c:if test="${left2Cnt > 1 }">
								<tr>
									<td><c:out value="${result.menuName }" /></td>
							</c:if>
						<c:if test="${result2.downCnt < 1 }">
									<td><c:out value="${result2.menuName }" /></td>
									<td></td>
									<td></td>
									<td align="center">
										<input type="hidden" name="depth1Cd" value="<c:out value='${result.menuCd }' />" />
										<input type="hidden" name="depth2Cd" value="<c:out value='${result2.menuCd }' />" />
										<input type="hidden" name="depth3Cd" value="" />
										<input type="hidden" name="depth4Cd" value="" />
										<c:if test='${result2.readYn == "Y" && result2.creYn == "Y" && result2.updateYn == "Y" && result2.delYn == "Y" }' ><input type="checkbox" name="crudCheckBox" onclick="crudCheck(this);" checked="checked" /></c:if>
										<c:if test='${result2.readYn != "Y" || result2.creYn != "Y" || result2.updateYn != "Y" || result2.delYn != "Y" }' ><input type="checkbox" name="crudCheckBox" onclick="crudCheck(this);" /></c:if>
									</td>
									<td align="center"><input type="checkbox" onclick="crudCheckYn(this);" name="readYn" <c:if test='${result2.readYn == "Y" }' >checked="chekced"</c:if> /></td>
									<td align="center"><input type="checkbox" onclick="crudCheckYn(this);" name="creYn" <c:if test='${result2.creYn == "Y" }' >checked="chekced"</c:if> /></td>
									<td align="center"><input type="checkbox" onclick="crudCheckYn(this);" name="updateYn" <c:if test='${result2.updateYn == "Y" }' >checked="chekced"</c:if> /></td>
									<td align="center"><input type="checkbox" onclick="crudCheckYn(this);" name="delYn" <c:if test='${result2.delYn == "Y" }' >checked="chekced"</c:if> /></td>
								</tr>
						</c:if>
						<c:if test="${result2.downCnt > 0 }">
									<td><c:out value="${result2.menuName }" /></td>
							<c:set var="left3Cnt" value="0" />
							<c:forEach var="result3" items="${menuList}" varStatus="status3">
								<c:if test="${result3.menuLevel == 3 && result2.menuCd == result3.upMenu && result3.upMenu ne '102004'}">
									<c:set var="left3Cnt" value="${left3Cnt+1 }" />
									<c:if test="${left3Cnt > 1 }">
								<tr>
									<td><c:out value="${result.menuName }" /></td>
									<td><c:out value="${result2.menuName }" /></td>
									</c:if>
									<c:if test="${result3.downCnt < 1 }">
									
									<td><c:out value="${result3.menuName }" /></td>
									<td></td>
									<td align="center">
										<input type="hidden" name="depth1Cd" value="<c:out value='${result.menuCd }' />" />
										<input type="hidden" name="depth2Cd" value="<c:out value='${result2.menuCd }' />" />
										<input type="hidden" name="depth3Cd" value="<c:out value='${result3.menuCd }' />" />
										<input type="hidden" name="depth4Cd" value="" />
										<c:if test='${result3.readYn == "Y" && result3.creYn == "Y" && result3.updateYn == "Y" && result3.delYn == "Y" }' ><input type="checkbox" name="crudCheckBox" onclick="crudCheck(this);" checked="checked" /></c:if>
										<c:if test='${result3.readYn != "Y" || result3.creYn != "Y" || result3.updateYn != "Y" || result3.delYn != "Y" }' ><input type="checkbox" name="crudCheckBox" onclick="crudCheck(this);" /></c:if>
									</td>
									<td align="center"><input type="checkbox" onclick="crudCheckYn(this);" name="readYn" <c:if test='${result3.readYn == "Y" }' >checked="chekced"</c:if> /></td>
									<td align="center"><input type="checkbox" onclick="crudCheckYn(this);" name="creYn" <c:if test='${result3.creYn == "Y" }' >checked="chekced"</c:if> /></td>
									<td align="center"><input type="checkbox" onclick="crudCheckYn(this);" name="updateYn" <c:if test='${result3.updateYn == "Y" }' >checked="chekced"</c:if> /></td>
									<td align="center"><input type="checkbox" onclick="crudCheckYn(this);" name="delYn" <c:if test='${result3.delYn == "Y" }' >checked="chekced"</c:if> /></td>
								</tr>
									</c:if>
									<c:if test="${result3.downCnt > 0 }">
									<td><c:out value="${result3.menuName }" /></td>
										<c:set var="left4Cnt" value="0" />
										<c:forEach var="result4" items="${menuList}" varStatus="status4">
											<c:if test="${result4.menuLevel == 4 && result3.menuCd == result4.upMenu && result4.upMenu ne '102004001' && result4.upMenu ne '102004002'}">
												<c:set var="left4Cnt" value="${left4Cnt+1 }" />
												<c:if test="${left4Cnt > 1 }">
								<tr>
									<td><c:out value="${result.menuName }" /></td>
									<td><c:out value="${result2.menuName }" /></td>
									<td><c:out value="${result3.menuName }" /></td>
												</c:if>
									<td><c:out value="${result4.menuName }" /></td>
									<td align="center">
										<input type="hidden" name="depth1Cd" value="<c:out value='${result.menuCd }' />" />
										<input type="hidden" name="depth2Cd" value="<c:out value='${result2.menuCd }' />" />
										<input type="hidden" name="depth3Cd" value="<c:out value='${result3.menuCd }' />" />
										<input type="hidden" name="depth4Cd" value="<c:out value='${result4.menuCd }' />" />
										<c:if test='${result4.readYn == "Y" && result4.creYn == "Y" && result4.updateYn == "Y" && result4.delYn == "Y" }' ><input type="checkbox" name="crudCheckBox" onclick="crudCheck(this);" checked="checked" /></c:if>
										<c:if test='${result4.readYn != "Y" || result4.creYn != "Y" || result4.updateYn != "Y" || result4.delYn != "Y" }' ><input type="checkbox" name="crudCheckBox" onclick="crudCheck(this);" /></c:if>
									</td>
									<td align="center"><input type="checkbox" onclick="crudCheckYn(this);" name="readYn" <c:if test='${result4.readYn == "Y" }' >checked="chekced"</c:if> /></td>
									<td align="center"><input type="checkbox" onclick="crudCheckYn(this);" name="creYn" <c:if test='${result4.creYn == "Y" }' >checked="chekced"</c:if> /></td>
									<td align="center"><input type="checkbox" onclick="crudCheckYn(this);" name="updateYn" <c:if test='${result4.updateYn == "Y" }' >checked="chekced"</c:if> /></td>
									<td align="center"><input type="checkbox" onclick="crudCheckYn(this);" name="delYn" <c:if test='${result4.delYn == "Y" }' >checked="chekced"</c:if> /></td>
								</tr>
											</c:if>		
										</c:forEach>
									</c:if>
								</c:if>
							</c:forEach><!-- level 3 -->
						</c:if>
					</c:if>	
				</c:otherwise>
			</c:choose> --%>
					
			</c:forEach>
		</c:if>
	</c:if>
</c:forEach>										
									</tbody>
								</table>
								
</c:if>								
</form:form>

								<div class="btnArea">
									<span class="left" onclick="groList(); return false;"><button class="btnType01 bc_gray">목록</button></span>
									<c:if test="${ type == 'U' }">
										<span class="right" onclick="menuGrpUpdate(); return false;"><button class="btnType01 bc_green">메뉴권한 수정</button></span>
									</c:if>
									<c:if test="${ type == 'I' }">
										<span class="right" onclick="groInsert(); return false;"><button class="btnType01 bc_green">저장</button></span>
									</c:if>
									
								</div>
</c:if>
							</fieldset>
						</form>

						
					</div>
				</div>	
					
<form:form commandName="searchFrm" name="searchFrm" method="post">
	<form:hidden path="pageIndex" />
	<form:hidden path="searchUsrGrpCd" />
	<form:hidden path="searchGrpName" />
	<form:hidden path="usrGrpCd" />
</form:form>				
					
			
<c:if test="${ type == 'U' }">
<script type="text/javascript">

function menuTebleSetting(tableId){
	
		
	
	var menuTable = document.getElementById(tableId);
	var rows = menuTable.rows;
	
	for(var i = 1; i < rows.length; i++){
		rows[i].cells[0].setAttribute("id","cell1_"+i);
		rows[i].cells[1].setAttribute("id","cell2_"+i);
		rows[i].cells[2].setAttribute("id","cell3_"+i);
		//rows[i].cells[3];
	}
	
	for(var i=rows.length ; i>2 ;i--){
		var cell1Value = document.getElementById("cell1_"+(i-1)).innerText;
		var cell2Value = document.getElementById("cell2_"+(i-1)).innerText;
		var cell3Value = document.getElementById("cell3_"+(i-1)).innerText;
		
		var beforeCell1Value = "a1b1c1d1";
		var beforeCell2Value = "a1b1c1d1";
		var beforeCell3Value = "a1b1c1d1";
		if(i > 1){
			   beforeCell1Value = document.getElementById("cell1_"+(i-2)).innerText;
			   beforeCell2Value = document.getElementById("cell2_"+(i-2)).innerText;
			   beforeCell3Value = document.getElementById("cell3_"+(i-2)).innerText;
		}

	    if(cell1Value == beforeCell1Value && cell2Value == beforeCell2Value && cell3Value == beforeCell3Value){
	    	document.getElementById("cell3_"+(i-1)).innerText = "";
	    	document.getElementById("cell3_"+(i-2)).style.borderBottomColor = "#ffffff";
	    }
	    if(cell1Value == beforeCell1Value && cell2Value == beforeCell2Value){
	    	document.getElementById("cell2_"+(i-1)).innerText = "";
	    	document.getElementById("cell2_"+(i-2)).style.borderBottomColor = "#ffffff";
	    }
	    if(cell1Value == beforeCell1Value){
	    	document.getElementById("cell1_"+(i-1)).innerText = "";
	    	document.getElementById("cell1_"+(i-2)).style.borderBottomColor = "#ffffff";
	    }
	}
	

}

</script>
</c:if>
					
				<!--content E-->
			</div>
		</div>
		<!--footer S-->
			<tiles:insertAttribute name="footer" />
		<!--footer E-->
	</div>
</body>
</html>

