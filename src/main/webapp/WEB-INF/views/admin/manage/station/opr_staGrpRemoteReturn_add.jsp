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
	
	/* 페이지 로드 */
	$(document).ready(function(){
		/* 목록 버튼 클릭시 */
		$('#btn_list').click(function() {
			fn_list();
		});
		
	});
	
	function fn_duplStationNameCheck(){
		
		if(!$("#remote_station_name").val()){
			alert('<spring:message code="fail.input.emptyValue1" arguments="정거장 명"/>');
			return;
		}
		
		$.post("/admin/manage/station/remoteStationNumberCheck.do", "station_name=" + $("#remote_station_name").val()  , function(data) {
			if(data.result == "ok"){
				alert('<spring:message code="success.duplicationCheck.isNot" arguments="정거장 명"/>');
				$("#checkName").val($("#remote_station_name").val());
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
	});
	
	function vallidateModify( flag, id ){
		if(!$("select[name=station_grp_seq]").val()){
			alert('<spring:message code="fail.input.emptyValue1" arguments="아파트"/>');
			$("select[name=station_grp_seq]").focus();
			return false;
		}
		
		var temp  = false;
		$("input[name=nameList]").each(function(){
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
		
		if(!$("#station_latitude").val() && !$("#station_longitude").val()){
			alert('<spring:message code="fail.input.emptyValue2" arguments="위경도"/>');
			return;
		}
		
		if(!$("input[name=station_use_yn]").is(":checked")){
			alert('<spring:message code="fail.input.emptyValue2" arguments="사용여부"/>');
			return false;
		}
		
		fn_regist();
	}
	
	var doubleClick = true;
	var succMsg = '<spring:message code="success.common.save" />';
	var failMsg = '<spring:message code="fail.request.msg" />';
	
	function fn_regist(){
		$("#cmd").val("INSERT");
		if(doubleClick){
			doubleClick = false;
			$("#frm").attr({method : "post", action : "/admin/manage/station/stationGrpRemoteReturnModify.do"}).submit();
		}
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
											<th><em>*</em>대리반납 정거장 명</th>
											<td class="lengcase1">
												<span class="input-text11"><input type="text" name="remote_station_name" id="remote_station_name" /></span>
												<button class="btnType02" onclick="fn_duplStationNameCheck(); return false;">중복확인</button>
												<input type="hidden" name="codeList" value="LAG_001" maxlength="50">
												<input type="hidden" id="cmd" name="cmd" value="${cmd }">
											</td>
										</tr>
										<tr>
											<th><em>*</em>위도/경도</th>
											<td>
												<input type="hidden" name="station_addr1" id="station_addr1" readonly />
												<input type="hidden" name="station_addr2" id="station_addr2" readonly/>
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
									</tbody>
								</table>
								<div class="btnArea">
									<span class="left"><button id="btn_list" class="btnType01 bc_gray">목록</button></span>
									<span class="right" onclick="vallidateModify('INSERT'); return false;"><button class="btnType01 bc_green">저장</button></span>
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
		<tiles:insertAttribute name="footer" />
		<!--footer E-->
	</div>
	
</body>
</html>

