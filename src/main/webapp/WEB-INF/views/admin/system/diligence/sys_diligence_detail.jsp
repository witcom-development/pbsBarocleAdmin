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
						<form:form id="frm" commandName="form" accept-charset="utf-8" modelAttribute="dalView" onsubmit="return false;">
							<form:input type="hidden" id="mode" path="mode" />
							<input type="hidden" name="dclzCd" value="">
							<input type="hidden" name="confmCd" value="A">
							
							<%-- <form:input type="hidden" id="smsSeq" path="smsSeq" /> --%>
							<fieldset>
								<table class="tb_type02 mt20">
									<colgroup>
										<col style="width:25%">
										<col style="width:75%">
									</colgroup>
									<tbody>
										<tr>
											<th class="top"><em>*</em> 휴가종류</th>
											<td class="top">
												
											<select class="select-category01"  id="partSlt" name="">
                                                    <option value="">선택</option>
                                                </select>
											</td>
										</tr>
										<tr>
											<th><em>*</em> 휴가 시작일</span></th>
											<td>
												<span class="selectDate input-datepick04">
												<input type="text" class="datepicker input-datepick04" name="dclzStrDt"  title="선택 날짜" id="bb11" readonly value=""/></span>
											</td>
										</tr>
										<tr>
											<th><em>*</em> 휴가 종료일</span></th>
											<td>
												<span class="selectDate input-datepick04">
												<input type="text" class="datepicker input-datepick04" name="dclzEndDt"  title="선택 날짜" id="bb22" readonly value=""/></span>
											</td>
										</tr>
										<tr>
											<th><em>*</em> 휴가제출사유</span></th>
											<td>
												<span class="input-text07"><form:input id="prvonsh" path="prvonsh" type="text" maxLength="32" /></span>
											</td>
										</tr>
									</tbody>
								</table>
								<div class="btnArea">
									<span class="left"><button class="btnType01 bc_gray" onclick="location.href='/admin/system/diligence/dalList.do?currentPageNo=<c:out value="${smsView.currentPageNo}"/><c:out value="${parameterInfo}" escapeXml="false"/>';">목록</button></span>
									<span class="right">
										<%-- <c:if test="${smsView.smsSeq>0&&smsView.autoSendYN eq 'N'}">
											<button class="btnType01" onclick="deleteContent('<c:out value="${smsView.smsSeq}"/>');">삭제</button>
										</c:if> --%>
									<button class="btnType01 bc_green" onclick="return saveContent();">저장</button></span>
								</div>
							</fieldset>
						</form:form>
					</div>
				</div>
				<!--content E-->
			</div>
		</div>
		<script type="text/javascript" src="/js/common_barocle.js"></script>
		<script type="text/javascript">
		$(function() {		
		commonAjax.getCommonCode("DAL", function(data) {
            if(data !== null && data.codeList !== null) {
                commCdBox.makeComboBox('CC','',data.codeList, "partSlt");
            }
       	});
		});
		
		
			function deleteContent(smsSeq){
				if(confirm("삭제 하시겠습니까?")){
					location.href = "/admin/system/sms/smsDelete.do?mode=delete&smsSeq="+smsSeq;
				} else return false;
			}
			function saveContent(){
				if($.trim($("#partSlt").val())==''){
					alert("휴가구분을 입력해 주세요.");
					$("#prvonsh").focus();
					return false;
				}
				if($.trim($("#prvonsh").val())==''){
					alert("사요를 입력해 주세요.");
					$("#prvonsh").focus();
					return false;
				}
				if($.trim($("#bb11").val())==''){
					alert("휴가시작일을 입력해 주세요.");
					$("#bb11").focus();
					return false;
				}
				if($.trim($("#bb22").val())==''){
					alert("휴가종료일을 입력해 주세요.");
					$("#bb22").focus();
					return false;
				}
				var mode = $("#frm").children("#mode").val();
				alert(mode);
				$("[name='dclzCd']").val($("#partSlt").val());
				
				//if(mode=='insert'){
				
					$("#frm").attr('action','/admin/system/diligence/dalInsert.do');
				
				//} else if(mode=='update'){
				//	$("#frm").attr('action','/admin/system/sms/smsUpdate.do');
				//} else {
				//	alert("모드 값이 설정되지 않았습니다.");
				//	return false;
				//}
				document.getElementById("frm").submit();
				return true;
			}
		</script>
		
		<!--footer S-->
			<tiles:insertAttribute name="footer" />
		<!--footer E-->
	</div>
</body>
</html>
