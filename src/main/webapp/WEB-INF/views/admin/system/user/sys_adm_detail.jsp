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



<c:if test="${ inputFrm.usrId != '' && inputFrm.usrId!=null }">
	<c:set var="type" value="U" />
</c:if>

<c:if test="${ inputFrm.usrId == '' || inputFrm.usrId==null }">
	<c:set var="type" value="I" />
</c:if>


<script type="text/javascript" src="/js/common_barocle.js"></script>
<script type="text/javaScript" language="javascript" >

function init(){
	$(".stationAdmin").css("display", "none");
	$(".centerAdmin").css("display", "none");
	$(".relocateAdmin").css("display", "none");
	$(".teamAdmin").css("display", "none");
}
 
/*
 * 아이디 확인
 * 특이사항 : 영문 시작
 * 범위 : 영문 숫자
 * 길이 : 5자리 이상20자리 이하
 */
function isId(text){
	var regexp = /^[a-zA-Z]{1}[\w]{4,19}$/;
	return regexp.test(text);
}



/* 목록 화면 function */
function usrList() {
   	document.searchFrm.action = "<c:url value='/admin/system/userMgmt/userList.do'/>";
   	document.searchFrm.submit();		
}

/* 아이디 체크 function */
function idCheckFn(textId, idCheck){
	
	
	var textIdObj = document.getElementById(textId);

	if(textIdObj.value == ""){
		alert('<spring:message code="fail.input.emptyValue2" arguments="아이디"/>');
		return;
	}
	
	if(!isId(textIdObj.value)){
		//alert("아이디를 조건에 맞게 입력하세요.");
		alert('<spring:message code="fail.input.onlyNumEng" arguments="아이디"/>');
		textIdObj.value="";
		return;
	}
	
	$.ajax({
		type:"POST",
		asyn : true,
		url:"<c:url value='/admin/system/userMgmt/idCheckAjax.do'/>",
		data : $("#inputFrm").serialize(),
		contentType : "application/x-www-form-urlencoded; charset=UTF-8",
		dataType:"json",
		success:function(data){
			if(data.result == "ok"){
				if(data.checkResult > 0){
					//alert(data.resultMessage);
					alert('<spring:message code="fail.duplicated.data" arguments="아이디"/>');
					document.getElementById(idCheck).value="";
				}else{
					//alert(data.resultMessage);
					alert('<spring:message code="success.idCheck.notId" arguments="아이디"/>');
					document.getElementById(idCheck).value="Y";
				}

			}else if(data.result == "error"){
				alert('<spring:message code="fail.request.msg" />');
				document.getElementById(idCheck).value="";
			}else{
				alert('<spring:message code="fail.request.msg" />');
				document.getElementById(idCheck).value="";
			}

		}, error: function(request, status, error) {
			alert('<spring:message code="fail.request.msg" />');
		}
	});

}

//비밀번호 체크
function fn_checkPass(){
	 
	 var check = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9])(?!.*[^A-za-z0-9!@#$%^&*?~]).{7,19}$/;
	 var pw = $("input[name=encPwd]").val();
	 
	 if (!check.test(pw))     {
	        //alert("비밀번호는 문자, 숫자, 특수문자의 조합으로 입력해주세요.");
	        alert('<spring:message code="fail.input.format" arguments="비밀번호"/>');
	        
	        $("input[name=encPwd]").focus();
	        return  false;
	 }
	         
	 if (pw.length < 8 || pw.length > 20) {
	  //alert("비밀번호는 8 ~ 20 자리로 입력해주세요.");
	  alert('<spring:message code="fail.input.minOverLength" arguments="비밀번호,8,20"/>');
	  return false;
	 }
	 return true;
}



function fn_checkCard(){

	var frm = document.inputFrm;

	frm.admin_card_no.value = frm.card_no1.value+'-'+frm.card_no2.value+'-'+frm.card_no3.value+ '-'+frm.card_no4.value;
	var checkVal = frm.card_no1.value+frm.card_no2.value+frm.card_no3.value+frm.card_no4.value;
	if( checkVal.length > 0 ){
		
		if(frm.card_no1.value.length == 4 && frm.card_no2.value.length == 4 && frm.card_no3.value.length == 4 && frm.card_no4.value.length == 4){
			$.ajax({
				type:"POST",
				asyn : true,
				url:"<c:url value='/admin/system/userMgmt/cardCheckAjax.do'/>",
				data : $("#inputFrm").serialize(),
				contentType : "application/x-www-form-urlencoded; charset=UTF-8",
				dataType:"json",
				success:function(data){
					if(data.result == "ok"){
						if(data.resultMessage == "DUPLICATED_CARD"){
							//alert(data.resultMessage);
							alert('<spring:message code="fail.duplicated.data" arguments="관리자 카드"/>');
						}else if(data.resultMessage == "REGISTERD_USER_CARD"){
							alert('<spring:message code="fail.duplicated.data3" arguments="사용자 대여카드"/>');
						}else {
							fn_validate();
						}
						
					}else{
						alert('<spring:message code="fail.request.msg" />');
					}

				}, error: function(request, status, error) {
					alert('<spring:message code="fail.request.msg" />');
				}
			});
		}else{
			alert('<spring:message code="fail.input.emptyValue2" arguments="카드번호"/>');
		}
	}else{
		fn_validate();
	}

}

function fn_validate(){

	if(!$("select[name=usrGrpCd]").val()){
		//alert("그룹 관리구분 선택 바랍니다.");
		alert('<spring:message code="fail.input.emptyValue1" arguments="그룹 관리구분"/>');
		$("select[name=usrGrpCd]").focus();
		return false;
		
	}
	
// 	if(!$("select[name=assign_center_id]").val()){
// 		alert("센터정보는 필수 입력값입니다.");
// 		$("select[name=assign_center_id]").focus();
// 		return false;
// 	}
	
// 	if(($("select[name=usrGrpCd]").val() == 5) && ((!$("select[name=relocateCarCd]").val()) || (!$("select[name=assign_center_id]").val()))){
// 		alert("재배치 관리자는 센터와 재배치차량 정보가 필수 입력값입니다.");
// 		return false;
// 	}
	
	if("${type}" == "I"){
		if(!$("#usrId").val()){
			alert('<spring:message code="fail.input.emptyValue2" arguments="아이디"/>');
			$("#usrId").focus();
			return false;
			
		}
		if(!$("#idCheck").val()){
			alert('<spring:message code="fail.input.emptyValue1" arguments="아이디 중복확인"/>');
			$("#usrId").focus();
			return false;
		}
	}
	
	//비밀번호는 필수값입니다.
	//비밀번호는 8 ~ 20 자리로 입력해주세요.
	if(!$("input[name=encPwd]").val()){
		alert('<spring:message code="fail.input.emptyValue2" arguments="비밀번호"/>');
		$("input[name=encPwd]").focus();
		return false;
	}else{
		if($("input[name=encPwd]").val().length < 8 ) {
			alert('<spring:message code="fail.input.minOverLength" arguments="비밀번호,8,20"/>');
			
			$("input[name=encPwd]").focus();
			return false;
		}
			
		//비밀번호는 문자, 숫자, 특수문자의 조합으로 입력해주세요.
		 /*var regPwd = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9])(?!.*[^A-za-z0-9!@#$%^&*?~]).{7,19}$/;
		 
			    if(!regPwd.test($("input[name=encPwd]").val())){
		     	     alert('<spring:message code="fail.input.emptyValue2" arguments="비밀번호에 영문자  숫자 특수문자"/>');
			       $("input[name=encPwd]").focus();
			        return false;
			    }*/	 
	}
	if(!$("input[name=usrName]").val()){
		alert('<spring:message code="fail.input.emptyValue1" arguments="이름"/>');
		$("input[name=usrName]").focus();
		return false;
	}else{
		if($("input[name=usrName]").val().length < 2){
			alert('<spring:message code="fail.input.minOverLength" arguments="이름,2,20"/>');
			$("input[name=usrName]").focus();
			return false;
		}
		
		var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi;
		
		if(regExp.test($("input[name=usrName]").val())){
			alert('<spring:message code="fail.input.onlyNumEngHan" arguments="이름"/>');
			$("input[name=usrName]").focus();
			return false;
		}
	}
	
	if(!$("input[name=mpnNo1]").val() || !$("input[name=mpnNo2]").val() || !$("input[name=mpnNo3]").val()){
		alert('<spring:message code="fail.input.emptyValue2" arguments="휴대전화 번호"/>');
		return false;
	}
	if(!$("input[name=useYn]").is(":checked")){
		alert('<spring:message code="fail.input.emptyValue1" arguments="사용여부 선택"/>');
		return false;
	}
	
	if(!$("input[name=email]").val()){
		$("input[name=email]").focus();
		alert('<spring:message code="fail.input.emptyValue2" arguments="이메일주소"/>');
		return false;
	}
	
	var regEmail = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
	 if(!regEmail.test($("input[name=email]").val())) {
		alert('<spring:message code="fail.input.email" arguments="이메일주소"/>');
         $("input[name=email]").focus();
         return false;
     }
	
	if(!$("input[name=email_recv_yn]").is(":checked")){
		alert('<spring:message code="fail.input.emptyValue1" arguments="이메일 수신여부 선택"/>');
		return false;
	}

	if($("input[name=adminCardPwd]").val().length > 0 &&
			 $("input[name=adminCardPwd]").val().length < 4){
		alert('<spring:message code="fail.input.chkLength1" arguments="설치 비밀번호, 4"/>');
		$("input[name=adminCardPwd]").focus();
		return false;
	}
	
	
	var frm = document.inputFrm;

	frm.phoneNo.value = frm.phoneNo1.value+'-'+frm.phoneNo2.value+'-'+frm.phoneNo3.value;
	frm.mpnNo.value = frm.mpnNo1.value+'-'+frm.mpnNo2.value+'-'+frm.mpnNo3.value;
	frm.admin_card_no.value = frm.card_no1.value+'-'+frm.card_no2.value+'-'+frm.card_no3.value+ '-'+frm.card_no4.value;
	frm.accs_ctrl_publ_ip.value = frm.ip_no1.value+'.'+frm.ip_no2.value+'.'+frm.ip_no3.value+ '.'+frm.ip_no4.value;
	
	if(frm.mpnNo.value == "--"){
		frm.mpnNo.value = "";
	}
	if(frm.phoneNo.value == "--"){
		frm.phoneNo.value = "";
	}

	if(frm.accs_ctrl_publ_ip.value == "..."){
		frm.accs_ctrl_publ_ip.value = "";
	}
	
	if($("#accessY").is(":checked")){
		if(!frm.ip_no1.value || !frm.ip_no2.value || !frm.ip_no3.value || !frm.ip_no4.value){
			alert('<spring:message code="fail.input.emptyValue2" arguments="접근제어 공인 IP"/>');
			return false;
		}
	} 
	
	
	<c:if test="${ type == 'I' }">
		if(!fn_checkPass()){
			
			return false;
		}
		$.ajax({
			type:"POST",
			asyn : true,
			url:"<c:url value='/admin/system/userMgmt/userInsert.do'/>",
			data : $("#inputFrm").serialize(),
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			dataType:"json",
			success:function(data){
	
				if(data.result == "ok"){
					
					if(data.checkResult > 0){
						alert('<spring:message code="success.common.save" />');
						window.location.href="<c:url value='/admin/system/userMgmt/userList.do'/>";
					}else{
						alert('<spring:message code="fail.request.msg" />');
					}
	
				}else if(data.result == "error"){
					alert('<spring:message code="fail.request.msg" />');
				}else{
					document.getElementById(idCheck).value="";
					alert('<spring:message code="fail.request.msg" />');
				}
	
			}, error: function(request, status, error) {
				alert('<spring:message code="fail.request.msg" />');
			}
		});
	</c:if>
	<c:if test="${ type == 'U' }">
	$.ajax({
		type:"POST",
		asyn : true,
		url:"<c:url value='/admin/system/userMgmt/userUpdate.do'/>",
		data : $("#inputFrm").serialize(),
		contentType : "application/x-www-form-urlencoded; charset=UTF-8",
		dataType:"json",
		success:function(data){

			if(data.result == "ok"){
				
				if(data.checkResult > 0){
					alert('<spring:message code="success.common.save" />');
					$("#preUseYn").val($("[name='useYn']:checked").val());
					
					//location.reload();
					//usrList();
				}else{
					alert('<spring:message code="fail.request.msg" />');
				}

			}else if(data.result == "error"){
				alert('<spring:message code="fail.request.msg" />');
			}else{
				document.getElementById(idCheck).value="";
				alert('<spring:message code="fail.request.msg" />');
			}

		}, error: function(request, status, error) {
			alert('<spring:message code="fail.request.msg" />');
		}
	});
	</c:if>
	
}

function toggleView(target){
	$('#'+target).toggle();
}

$(function() {
	init();
	
	$("#admin_grp_seq").change(function(){
		fn_selectChange();
	});
	
// 	$("#teamCenter").change(function(){
// 		find_team(false);
// 	});
	
	$(".input-text09 input").keyup(function(){
		$(this).val($(this).val().replace(/[^0-9]/g,""));
	});
	/* 
	$("select[name=assign_center_id]").mouseover(function(){
						var grpCd = $("#grpCdSelected").val();
		
		$("[name='assign_center_id'] option").each(function(index,item){
			
			$(this).hide();
			
			var clsCd = "";
			clsCd += item.getAttribute('clscd');
			
			
			if(grpCd == "4" || grpCd == "10"){
				
				if(clsCd.indexOf("CEN_004") > -1) $(this).show();
				
			}else if(grpCd == "21"){
				
				if(clsCd.indexOf("CEN_003") > -1) $(this).show();
			
			// 2021 12 14 순회정비반 추가
			} else if (grpCd == "27" || grpCd == "28" ){
				
				if(clsCd.indexOf("CEN_005") > -1) $(this).show();	
				
			}else{
					
				if ( ("CEN_001").indexOf( clsCd ) == 0 || ("CEN_002").indexOf( clsCd ) == 0 ){
				
					$(this).show();
					 
				}	
					
			}
			
		});	
		
	});	
	 */
	$("select[name=usrGrpCd]").change(function(){
		
		//선택한 그룹에 따라 센터 필터링 처리
		var grpCd = $(this).val().replace(" ","");
		$("#grpCdSelected").val(grpCd);
		
		var str = $("select[name=usrGrpCd] option:selected").attr("title");

		if(str != ""){
			
			$("#admin_cls_cd").val(str.split(":")[0]);
			$("#usrGrpCdLabel").text("관리구분 : " + str.split(":")[1]);
			
			if($("#admin_cls_cd").val() == "ADM_002"){
				$(".stationAdmin").css("display", "");
				$(".centerAdmin").css("display", "");
				$(".relocateAdmin").css("display", "none");
				$("select[name=relocateCarCd]").val("0");
// 				$("select[name=assign_center_id ]").val("0");
				$(".teamAdmin").css("display", "none");
			}else if($("#admin_cls_cd").val() == "ADM_005"){
				$(".centerAdmin").css("display", "");
				$(".stationAdmin").css("display", "none");
				$(".relocateAdmin").css("display", "");
// 				$("select[name=assign_center_id ]").val("0");
				$(".teamAdmin").css("display", "");
			}else if($("#admin_cls_cd").val() == "ADM_006"){
				$(".centerAdmin").css("display", "none");
				$(".stationAdmin").css("display", "none");
				$(".relocateAdmin").css("display", "none");
				$("select[name=relocateCarCd]").val("0");
// 				$("select[name=assign_center_id ]").val("0");
				$(".teamAdmin").css("display", "none");
			}else{
				$(".stationAdmin").css("display", "none");
				$(".centerAdmin").css("display", "");
				$(".relocateAdmin").css("display", "none");
				$("select[name=relocateCarCd]").val("0");
// 				$("select[name=assign_center_id ]").val("0");
				$(".teamAdmin").css("display", "none");
			}
			
		}else{
			$("#admin_cls_cd").val("");
			$("#usrGrpCdLabel").text("관리구분 : ");
			
			$(".stationAdmin").css("display", "none");
			$(".centerAdmin").css("display", "none");
			$(".teamAdmin").css("display", "none");
		}
	});
	
	$(".stationAdmin").css("display", "none");
	$(".centerAdmin").css("display", "none");
	
	
	if("${type}" == "U"){
		$("input[name=usrId]").val("${inputFrm.usrId }");
		$("input[name=usrName]").val("${inputFrm.usrName }");
		$("select[name=usrGrpCd]").val("${inputFrm.usrGrpCd }");
		$("select[name=relocateCarCd]").val("${inputFrm.relocateCarCd }");
		$("select[name=usrGrpCd]").change();
		
		if("${inputFrm.assign_station_id }".split("/").length == 2){
			
			var grpseq = "${inputFrm.assign_station_id }".split("/")[1];
			var stationId = "${inputFrm.assign_station_id }".split("/")[0];
			
			$("select[name=admin_grp_seq]").val(grpseq);
			fn_selectChange(stationId);
		}
		
// 		$("select[name=assign_center_id]").val("${inputFrm.assign_center_id }");

		if("${inputFrm.mpnNo }".split("-").length == 3){
				$("input[name=mpnNo1]").val("${inputFrm.mpnNo }".split("-")[0]);
				$("input[name=mpnNo2]").val("${inputFrm.mpnNo }".split("-")[1]);
				$("input[name=mpnNo3]").val("${inputFrm.mpnNo }".split("-")[2]);
		}
		
		if("${inputFrm.phoneNo }".split("-").length == 3){
			
			$("input[name=phoneNo1]").val("${inputFrm.phoneNo }".split("-")[0]);
			$("input[name=phoneNo2]").val("${inputFrm.phoneNo }".split("-")[1]);
			$("input[name=phoneNo3]").val("${inputFrm.phoneNo }".split("-")[2]);
		}
		
		if("${inputFrm.accs_ctrl_publ_ip }".split(".").length == 4){
			
			$("input[name=ip_no1]").val("${inputFrm.accs_ctrl_publ_ip }".split(".")[0]);
			$("input[name=ip_no2]").val("${inputFrm.accs_ctrl_publ_ip }".split(".")[1]);
			$("input[name=ip_no3]").val("${inputFrm.accs_ctrl_publ_ip }".split(".")[2]);
			$("input[name=ip_no4]").val("${inputFrm.accs_ctrl_publ_ip }".split(".")[3]);
		}
		
		if("${inputFrm.admin_card_no }".split("-").length == 4){
			
			$("input[name=card_no1]").val("${inputFrm.admin_card_no }".split("-")[0]);
			$("input[name=card_no2]").val("${inputFrm.admin_card_no }".split("-")[1]);
			$("input[name=card_no3]").val("${inputFrm.admin_card_no }".split("-")[2]);
			$("input[name=card_no4]").val("${inputFrm.admin_card_no }".split("-")[3]);
		}
			
		
		if('${inputFrm.useYn }' == "Y"){
			$("#useY").prop('checked', true);
		}else{
			$("#useN").prop('checked', true);
		}
		
		if('${inputFrm.email_recv_yn }' == "Y"){
			$("#email_recv_y").prop('checked', true);
		}else{
			$("#email_recv_n").prop('checked', true);
		}
		
		if('${inputFrm.accs_ctrl_yn }' == "Y"){
			$("#accessY").prop('checked', true);
		}else{
			$("#accessN").prop('checked', true);
		}
		
		$("input[name=admin_card_no]").val("${inputFrm.admin_card_no }")

		$("input[name=adminCardPwd]").val("${inputFrm.adminCardPwd }")
		
		//
		$("#preUseYn").val("${inputFrm.useYn}");
		
	}
	
		
	
	deleteAdmin = function(usrMpnNo) {
    	if(confirm('관리자를 삭제하시겠습니까?')){
    		$.ajax({
    			type:"POST",
    			asyn : true,
    			url:"/admin/system/userMgmt/deleteAdminAjax.do",
    			data : "adminID=" + $("input[name=usrId]").val(),
    			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
    			dataType:"json",
    			success:function(data){
    				if(data.result == "ok"){
    					alert('관리자가 삭제되었습니다.');
    					window.location.href="<c:url value='/admin/system/userMgmt/userList.do'/>";
    				}else{
    					alert('관리자가 삭제되지 않았습니다.');
    					window.location.href="<c:url value='/admin/system/userMgmt/userList.do'/>";
    				}}, error:function(data){
    					alert(data.result);
    					alert(data);
    					alert("요청에 실패하였습니다.");
    				}

    			
    		}); 	
    	};
	}
	
});



function fn_selectChange(stationId){
	
	var select = "<option value=\"\">선택</option>"
		
		if($("#admin_grp_seq").val() == ''){
			$("#assign_station_id").find("option").remove().end();
			$("#assign_station_id").append(select);
			
		}else{
			$("#assign_station_id").find("option").remove().end();
			$("#assign_station_id").append(select);
			
			$.post("/admin/manage/station/groupStationList.do", "station_grp_seq=" + $("#admin_grp_seq").val() +"&station_use_yn=Y"  , function(data) {
				
				for(var i=0; i < data.nameList.length; i++){
					if(data.nameList[i].station_id == stationId){
						$("#assign_station_id").append("<option value='"+data.nameList[i].station_id+"' selected=selected>"+ data.nameList[i].station_name +"</option>");
					}else{
						$("#assign_station_id").append("<option value='"+data.nameList[i].station_id+"'>"+ data.nameList[i].station_name +"</option>");
					}
				}
				
			});
			
		}
	
}



function fn_PasswdClear(){
	
	if(confirm("관리자의 비밀번호를 초기화 (barocle135!@#) 하시겠습니까? 변경시에는 저장 버튼 클릭 이후 초기화 됩니다." )){
		$("input[name=PasswdClear]").val("barocle135!@#");
		$("input[name=encPwd]").val("barocle135!@#");
	}
	
}

function number_filter(str_value){
	return str_value.replace(/[^1-4]/gi, ""); 

    
};

$(document).ready(function(){
	<c:if test="${ type == 'U' }">
	find_team(true);
	</c:if>
	<c:if test="${ type == 'I' }">
	find_team(false);
	</c:if>
	// 시민의견수렴 담당팀
	<%-- var cVal = '${inputFrm.team_seq}'; <<<< 20200826 - 운영에서 문제발생 위치 --%>
// 	var cVal = '1';
// 	// team_seq 앞에 0붙이기
// 	var len = 3 - cVal.length;
// 	for(var n=0; n<len ; n++){
// 		cVal = '0' + cVal;
// 	}
	//
	commonAjax.getCommonCode("QIA", function(data){
		if(data !== null && data.codeList !== null) {
			for(var i=0; i < data.codeList.length; i++ ) {
				
				var op = $('<option>',{ id : 'comm_'+data.codeList[i].comCd, value : data.codeList[i].comCd.substring(4) }).text(data.codeList[i].comCdName);
				if(cVal !== '' && cVal === data.codeList[i].comCd.substring(4)) {
					op.attr('selected', true);
				}
// 				$("#team_seq").children().last().after(op);
				
			}
		}
	});

})

// function find_team(flg){
	
// 	var select = "<option value=\"\">선택</option>"
// 	var center = $("#teamCenter").val();
// 	//alert("${inputFrm.team_id}");
// 		 if($("#teamCenter").val() == ''){
// 			$("#team_id").find("option").remove().end();
// 			$("#team_id").append(select);
			
// 		}else{
// 			$("#team_id").find("option").remove().end();
// 			$("#team_id").append(select);
			
// 			$.post("/admin/system/userMgmt/srchTeamList.do", "centerId="+center  , function(data) {
				
// 				for(var i=0; i < data.teamList.length; i++){
// 					if(flg){
// 						if("${inputFrm.team_id}" == data.teamList[i].teamId){
// 							$("#team_id").append("<option value='"+data.teamList[i].teamSeq+"' selected>"+ data.teamList[i].teamNm +"</option>");
// 						}else{
// 							$("#team_id").append("<option value='"+data.teamList[i].teamSeq+"'>"+ data.teamList[i].teamNm +"</option>");
// 						}
// 					}else{
// 						$("#team_id").append("<option value='"+data.teamList[i].teamSeq+"'>"+ data.teamList[i].teamNm +"</option>");
// 					}						
// 				}
				
// 			});
			
// 		}
// }

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
<form:form commandName="inputFrm" name="inputFrm" method="post">
<form:hidden path="phoneNo" />
<form:hidden path="mpnNo" />
<form:hidden path="PasswdClear" />
<form:hidden path="preUseYn" />

	<div class="content">
					<div class="subject">
						<p class="pageTitle">운영자 관리</p>
						<span>시스템 관리 &gt; <em>운영자 관리</em></span>
					</div>
					<div class="page">
					    <div class="tabWrap type3">
							<ul class="tabBox">
								<li class="tab on"><button type="button">운영자 상세</button></li>
								<!-- <li class="tab"><button type="button">사용 이력</button></li> -->
							</ul>
							<div class="tabCon on">
						<form action="demo">
							<input type="hidden" id="grpCdSelected" />
							<fieldset>
								<table  class="tb_type02 mt20">
									<colgroup>
										<col style="width:25%"/>
										<col style="width:75%"/>
									</colgroup>
									<tbody>
										<tr>
											<th class="top"><em>*</em> 그룹/관리구분</th>
											<td class="top">
												<select name="usrGrpCd" required="true" title="그룹" class="select-category02">
													<option value="" title="" >선택</option>
													<c:forEach var="result" items="${groCodeList}" varStatus="status">
														<option value="${result.usrGrpCd}" title="${result.com_cd }:${result.mlang_com_cd_name}" ><c:out value="${result.grpName}"/></option>
													</c:forEach>
												</select> 
												<p class="mt10" id="usrGrpCdLabel" > 관리구분 : 운영 ADMIN</p>
												<input type="hidden" name="admin_cls_cd" id="admin_cls_cd">
											</td>
										</tr>
									<c:if test="${ type == 'I' }">
										<tr>
											<th><em>*</em> ID</th>
											<td>
												<span class="input-text08">
													<input type="text"  name="usrId" id="usrId"  maxlength="20" minlength="5" onkeydown="document.getElementById('idCheck').value='';" 
	                                						onkeyup="document.getElementById('idCheck').value='';" required="true"/>
	                                				<!-- <label>아이디는 영문으로 시작해 영문+숫자로 5자 이상 20자리 이하</label> -->
	                                    				
	                                				<input type="hidden" name="codeCheck" id="idCheck" value=""/>
												</span>
													<button class="btnType02" onclick="idCheckFn('usrId','idCheck'); return false;">중복확인</button>
	                                				<p class="mt10">아이디는 영문으로 시작해 영문, 숫자로 5자 이상 20자리 이하</p>
											</td>
										</tr>
										<tr>
											<th><em>*</em> 비밀번호</th>
											<td>
												<span class="input-text08">
													<form:input path="encPwd" type="password" required="true" maxlength="20" minlength="8" title="비밀번호" class="input-text08"/>
													<p class="mt10">비밀번호는 영대문자, 영소문자,숫자, 특수문자 조합으로 8자리 이상 20자리 이하</p>
												</span>
											</td>
										</tr>
									</c:if>
									
									
									<c:if test="${ type == 'U' }">
									
										<tr>
											<th><em>*</em> ID</th>
											<td>
												<span class="input-text08"><input type="text"  name="usrId"  readonly="readonly"/></span>
											</td>
										</tr>
										<tr>
											<th><em>*</em> 비밀번호</th>
											<td>
												<span class="input-text08">
													<form:input path="encPwd" type="password" required="true" maxlength="20" minlength="8" title="비밀번호" class="input-text08" readonly="readonly"/>
												</span>
												<button class="btnType02" onclick="fn_PasswdClear(); return false;">초기화</button>
												<p class="mt10">비밀번호는 영대문자, 영소문자 ,숫자, 특수문자 조합으로 8자리 이상 20자리 이하</p>
											</td>
										</tr>
										
									</c:if>
									
										<tr>
											<th><em>*</em> 이름</th>
											<td>
												<span class="input-text08">
													<input name="usrName" maxlength="20" minlength="2" required="true" title="이름"  type="text"/>												</span>
												<p class="mt10">이름은 영문/한글로 시작해 영문+한글+숫자로 2자리 이상 20자리 이하</p>
											</td>
										</tr>
										
										<tr class="teamId">
											<th><em>*</em> 소속 아파트</th>
											<td>
												<select class="select-category01" id="teamId" name="teamId">
													<option value="">선택</option>
													<c:forEach items="${aptList }" var="aptList" varStatus="status">
													<option value="${aptList.aptSeq }"><c:out value="${aptList.aptName}"/></option>
													<%-- <c:if test="${inputFrm.center_id == centerList.comCd}">
														<option value="${centerList.comCd }" selected="selected"><c:out value="${centerList.comCdName}"/></option>
													</c:if>
													<c:if test="${inputFrm.center_id != centerList.comCd}">
														<option value="${centerList.comCd }"><c:out value="${centerList.comCdName}"/></option>
													</c:if> --%>
													</c:forEach>
												</select>&nbsp;
												<select class="select-category01" id="team_id" name="team_id" required="true">
													<option value="">선택</option>
												</select>
											</td>
										</tr>
										
										<%-- <tr class="stationAdmin">
											<th>유인대여소</th>
											<td>
												<select class="select-category03" name="admin_grp_seq" id="admin_grp_seq">
													<option value="">아파트</option>
													<c:forEach items="${group }" var="group">
														<option value="${group.station_grp_seq }">${group.station_grp_name }
													</c:forEach>
												</select>
												<select class="select-category03" name="assign_station_id"	id="assign_station_id">
													<option value="">대여소</option>
												</select>
											</td>
										</tr> --%>
										
										<%-- <tr class="teamAdmin">
											<th><em>*</em> 팀</th>
											<td>
												<select class="select-category01" id="teamCenter" name="teamCenter">
													<option value="">선택</option>
													<c:forEach items="${centerList }" var="centerList" varStatus="status">
													<c:if test="${inputFrm.center_id == centerList.comCd}">
														<option value="${centerList.comCd }" selected="selected"><c:out value="${centerList.comCdName}"/></option>
													</c:if>
													<c:if test="${inputFrm.center_id != centerList.comCd}">
														<option value="${centerList.comCd }"><c:out value="${centerList.comCdName}"/></option>
													</c:if>
													</c:forEach>
												</select>&nbsp;
												<select class="select-category01" id="team_id" name="team_id" required="true">
													<option value="">선택</option>
												</select>
											</td>
										</tr> --%>
										
										<tr class="relocateAdmin">
											<th><em>*</em> 재배치차량</th>
											<td>
												<select name="relocateCarCd" class="select-category02" required="true">
													<option value="" >선택</option>
													<c:forEach var="result" items="${relocateCarList}" varStatus="status">
														<option value="${result.RELOCATE_CAR_ID}" ><c:out value="${result.CAR_NO}"/></option>
													</c:forEach>
												</select> 
											</td>
										</tr>
										<tr>
											<th>전화번호</th>
											<td>
												<span class="input-text09"><input type="text" maxlength="4" name="phoneNo1" /></span>
												<span class="dash">-</span>
												<span class="input-text09"><input type="text" maxlength="4" name="phoneNo2"/></span>
												<span class="dash">-</span>
												<span class="input-text09"><input type="text" maxlength="4" name="phoneNo3"/></span>
											</td>
										</tr>
										<tr>
											<th><em>*</em> 휴대번호</th>
											<td>
												<span class="input-text09"><input type="text" maxlength="3" name="mpnNo1"/></span>
												<span class="dash">-</span>
												<span class="input-text09"><input type="text" maxlength="4" name="mpnNo2"/></span>
												<span class="dash">-</span>
												<span class="input-text09"><input type="text" maxlength="4" name="mpnNo3"/></span>
											</td>
										</tr>
										<tr>
											<th><em>*</em> 사용여부</th>
											<td>
												<span class="input-rd01"><input type="radio" id="useY" name="useYn" value="Y"><label for="useY">사용</label></span>
												<span class="input-rd01"><input type="radio" id="useN" name="useYn" value="N"><label for="useN">정지</label></span>
											</td>
										</tr>
										<tr>
											<th><em>*</em> E-mail</th>
											<td>
												<span class="input-text07">
													<form:input path="email" type="text" required="true" title="이메일" maxlenght="40"/>
												</span>
											</td>
										</tr>
										<tr>
											<th><em>*</em> E-mail 수신여부</th>
											<td>
												<span class="input-rd01"><input type="radio" id="email_recv_y" name="email_recv_yn" value="Y"><label for="email_recv_y">수신</label></span>
												<span class="input-rd01"><input type="radio" id="email_recv_n" name="email_recv_yn" value="N"><label for="email_recv_n">미수신</label></span>
											</td>
										</tr>
										<tr>
											<th>관리자 카드</th>
											<td>
													<input type="hidden" name="admin_card_no"/>
												<span class="input-text09">
													<input type="text" name="card_no1" maxlength="4" class="input-text09"/> -
													<input type="text" name="card_no2" maxlength="4" class="input-text09"/> -
													<input type="text" name="card_no3" maxlength="4"/> -
													<input type="text" name="card_no4" maxlength="4"/>
												</span>
											</td>
										</tr>
										<!-- 
										<tr style="display:none;">
											<th>시민의견수렴 담당팀</th>
											<td>
												<select id="team_seq" name="team_seq" class="select-category02" required="true">
													<option value="" >선택</option>
												</select>
											</td>
										</tr>
										 -->
										<tr>
											<th>접근제어 여부</th>
											<td>
												<span class="input-rd01"><input type="radio" id="accessY" name="accs_ctrl_yn" value="Y"><label for="accessY">사용</label></span>
												<span class="input-rd01"><input type="radio" id="accessN" name="accs_ctrl_yn" value="N"><label for="accessN">정지</label></span>
											</td>
										</tr>
										<tr>
											<th>접근제어 공인IP</th>
											<td>
													<input type="hidden" name="accs_ctrl_publ_ip" id="accs_ctrl_publ_ip"/>
												<span class="input-text09">
													<input type="text" name="ip_no1" maxlength="3" class="tr pr10"/> .
													<input type="text" name="ip_no2" maxlength="3" class="tr pr10" /> .
													<input type="text" name="ip_no3" maxlength="3" class="tr pr10"/> .
													<input type="text" name="ip_no4" maxlength="3" class="tr pr10"/>
												</span>
											</td>
										</tr>
										<tr>
											<th>설치 비밀번호</th>
											<td>
												<span class="input-text08">
													<input id="adminCardPwd" name="adminCardPwd" type="password"  maxlength="4" minLength="4" onkeyup="this.value=number_filter(this.value);"/>		
												</span>
												<p class="mt10">1~4 조합의 숫자 4자리 입력</p>
											</td>
										</tr>
									</tbody>
								</table>
								
</form:form>
<form:form commandName="searchFrm" name="searchFrm" method="post">
<form:hidden path="pageIndex" />
<form:hidden path="searchUsrName" />
<form:hidden path="searchUsrGrpCd" />
</form:form>

								<div class="btnArea">
									<span class="left" onClick="usrList(); return false;"><button class="btnType01 bc_gray">목록</button></span>
									<c:if test="${ type == 'U' }">
										<span class="right" onClick="fn_checkCard(); return false;"><button class="btnType01 bc_green">저장</button></span>
									</c:if>
									<c:if test="${ type == 'I' }">
										<span class="right" onClick="fn_checkCard(); return false;"><button class="btnType01 bc_green">저장</button></span>
									</c:if>
									<span class="right" onClick="deleteAdmin(); return false;"><button class="btnType01">관리자 삭제</button></span>
								</div>
							</fieldset>
						</form>
						</div>
						<div class="tabCon">
							<table class="tb_type01">
								<colgroup>
									<%-- <col style="width:15%"/>
									<col style="width:15%"/>
									<col style="width:15%"/>
									<col style="width:15%"/> --%>
									<col style="width:15%"/>
									<col style="width:15%"/>
								</colgroup>
								<thead>
									<tr>
										<!-- <th>ID</th>
										<th>이름</th>
										<th>그룹명</th>
										<th>휴대번호</th> -->
										<th>수정일</th>
										<th>사용유무</th>
									</tr>
								</thead>
								<tbody>
									<c:if test="${fn:length(adminUseList) > 0 }">                  
										<c:forEach var="result" items="${adminUseList}" varStatus="status">
			                                <tr>
			                                    <%-- <td style="text-align: left; padding-left: 1%;"><a href="#"  onclick="usrInfo('<c:out value="${result.usrId}"/>')" ><c:out value="${result.usrId}"/></a></td>
			                                    <td style="text-align: left; padding-left: 1%;"><c:out value="${result.usrName}"/></td>
			                                    <td style="text-align: left; padding-left: 1%;"><c:out value="${result.grpName}"/></td>
			                                    <td class="tc"><c:out value="${result.mpnNo}"/></td> --%>
			                                    <td class="tc"><c:out value="${result.modDate}"/></td>
			                                    <td class="tc"><c:if test="${result.useYn eq 'Y'}">사용</c:if><c:if test="${result.useYn eq 'N'}">정지</c:if></td>
			                                </tr>
										</c:forEach>
									</c:if>
	                            	<c:if test="${fn:length(adminUseList) == 0 }">  
		                                <tr>
		                                	<td colspan="2" class="tc"><spring:message code="info.nodata.msg" /></td>
		                                </tr>
									</c:if>
								</tbody>
							</table>
										
						</div>
						</div>
					</div>
				</div>
				<!--content E-->
			</div>
		</div>
		<!--footer S-->
			<tiles:insertAttribute name="footer" />
		<!--footer E-->
	</div>
</body>
</html>

