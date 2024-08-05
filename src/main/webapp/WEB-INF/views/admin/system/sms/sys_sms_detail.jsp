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
						<form:form id="frm" commandName="form" accept-charset="utf-8" modelAttribute="smsView" onsubmit="return false;">
							<form:input type="hidden" id="mode" path="mode" />
							<form:input type="hidden" id="smsSeq" path="smsSeq" />
							<fieldset>
								<table class="tb_type02 mt20">
									<colgroup>
										<col style="width:25%">
										<col style="width:75%">
									</colgroup>
									<tbody>
										<tr>
											<th class="top"><em>*</em> 발송구분</th>
											<td class="top">
												<span class="input-text07"><form:input id="sendClsName" path="sendClsName" type="text" maxLength="32" /></span>
											</td>
										</tr>
										<tr>
											<th><em>*</em> 내용<br/><span class="brIn">(80byte 이내)</span></th>
											<td>
												<form:textarea id="orignlMsg" path="orignlMsg" class="detatextarea" />
											</td>
										</tr>
										<tr>
											<th>자동발생 여부 /<br />자동발송ID</th>
											<c:choose>
												<c:when test="${smsView.autoSendYN eq 'Y' && (smsView.autoSendID ne null && smsView.autoSendID ne '') }">
													<td> <c:out value="${smsView.autoSendYN}" /> / <c:out value="${smsView.autoSendID}" /> </td>
												</c:when>
												<c:otherwise>
													<td> 아니오 / - </td>
												</c:otherwise>
											</c:choose>
										</tr>
										<tr>
											<th>비고</th>
											<td>
												<span class="input-text07"><form:input id="noteDesc" path="noteDesc" type="text" maxLength="32" /></span>
											</td>
										</tr>
									</tbody>
								</table>
								<div class="btnArea">
									<span class="left"><button class="btnType01 bc_gray" onclick="location.href='/admin/system/sms/smsList.do?currentPageNo=<c:out value="${smsView.currentPageNo}"/><c:out value="${parameterInfo}" escapeXml="false"/>';">목록</button></span>
									<span class="right">
										<c:if test="${smsView.smsSeq>0&&smsView.autoSendYN eq 'N'}">
											<button class="btnType01" onclick="deleteContent('<c:out value="${smsView.smsSeq}"/>');">삭제</button>
										</c:if>
									<button class="btnType01 bc_green" onclick="return saveContent();">저장</button></span>
								</div>
							</fieldset>
						</form:form>
					</div>
				</div>
				<!--content E-->
			</div>
		</div>
		
		<script type="text/javascript">
			function deleteContent(smsSeq){
				if(confirm("삭제 하시겠습니까?")){
					location.href = "/admin/system/sms/smsDelete.do?mode=delete&smsSeq="+smsSeq;
				} else return false;
			}
			function saveContent(){
				if($.trim($("#sendClsName").val())==''){
					alert("발송구분을 입력해 주세요.");
					$("#sendClsName").focus();
					return false;
				}
				if($.trim($("#orignlMsg").val())==''){
					alert("내용을 입력해 주세요.");
					$("#orignlMsg").focus();
					return false;
				}
				var mode = $("#frm").children("#mode").val();
				if(mode=='insert'){
					$("#frm").attr('action','/admin/system/sms/smsInsert.do');
				} else if(mode=='update'){
					$("#frm").attr('action','/admin/system/sms/smsUpdate.do');
				} else {
					alert("모드 값이 설정되지 않았습니다.");
					return false;
				}
				document.getElementById("frm").submit();
				return true;
			}
		</script>
		<!-- 
		<script type="text/javascript">
			$(document).ready(function(){
				/* 에러 메시지  */
				var alertValue = "<c:out value='${resultError.errorMessage}'/>";
				if(alertValue!=""){ alert(alertValue); }
				var maxLength = 80;
				$("#orignlMsg").keyup(function(event){
					var currentLength = 0;
					var cutLength = 0;
					for(var i=0; i<$("#orignlMsg").val().length; i++){
						currentLength += ($("#orignlMsg").val().charCodeAt(i)>128) ? 2 : 1;
						if(currentLength<=maxLength){ cutLength++; }
					}
					if(currentLength>maxLength){
						alert("80byte이내 입력을 해주세요.");
						$(this).val($(this).val().substr(0,cutLength)); 
					}
		        });
			});
		</script>
		 -->
		<!--footer S-->
			<tiles:insertAttribute name="footer" />
		<!--footer E-->
	</div>
</body>
</html>
