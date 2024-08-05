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
						<form:form id="frm" role="form" accept-charset="utf-8" modelAttribute="appVersionView" onsubmit="return false;">
							<form:input type="hidden" id="mode" path="mode" />
							<form:input type="hidden" id="appSeq" path="appSeq" />
							<fieldset>
								<table class="tb_type02 mt20">
									<colgroup>
										<col style="width:25%">
										<col style="width:75%">
									</colgroup>
									<tbody>
										<tr>
											<th class="top"><em>*</em> OS구분</th>
											<td class="top">
												<%-- 
												<c:forEach items="${appVersionView.codeOSS}" var="codeOss" varStatus="status">
													<span class="input-rd01"><input type="radio" id="osClsCD${status.index}" name="osClsCD" value="${codeOss.comCD}" <c:if test="${codeOss.comCD eq appVersionView.osClsCD}">checked="true"</c:if>><label for="osClsCD${status.index}"><c:out value="${codeOss.cdDesc1}" /></label></span>
												</c:forEach>
												 --%>
												<span class="input-rd01"><input type="radio" id="osClsCD" name="osClsCD" value="${codeOss.comCD}" checked="true"><label for="osClsCD">Android</label></span>
											</td>
										</tr>
									<%--
										<tr>
											<th><em>*</em> 메시지 구분</th>
											<td>
												<c:forEach items="${appVersionView.codeUDT}" var="codeUdt" varStatus="status">
													<span class="input-rd01"><input type="radio" id="updateClsCD${status.index}" name="updateClsCD" value="${codeUdt.comCD}" <c:if test="${codeUdt.comCD eq appVersionView.updateClsCD}">checked="true"</c:if>><label for="updateClsCD${status.index}"><c:out value="${codeUdt.cdDesc1}" /></label></span>
												</c:forEach>
											</td>
										</tr>
									--%>
										<tr>
											<th><em>*</em> APP 마켓주소</th>
											<td>
												<span class="input-text07"><form:input id="downloadPath" path="downloadPath" type="text" maxLength="200" /></span>
											</td>
										</tr>
										<tr>
											<th><em>*</em> 버전정보</th>
											<td>
												<span class="input-text08"><form:input id="appVerInfo" path="appVerInfo" type="text" maxLength="12" /></span>
											</td>
										</tr>
										<tr>
											<th><em>*</em> 메시지 내용<br/><span class="brIn">(200byte 이내)</span></th>
											<td>
												<form:textarea id="msgContent" path="msgContent" class="detatextarea"/>
											</td>
										</tr>
									</tbody>
								</table>
								<div class="btnArea">
									<span class="left"><button class="btnType01 bc_gray" onclick="location.href='/admin/system/appVersion/appVersionList.do?currentPageNo=<c:out value="${appVersionView.currentPageNo}"/><c:out value="${parameterInfo}" escapeXml="false"/>'">목록</button></span>
									<span class="right"><button class="btnType01 bc_green" onclick="saveContent();">저장</button></span>
								</div>
							</fieldset>
						</form:form>
					</div>
				</div>
				<!--content E-->
			</div>
		</div>
		
		<script type="text/javascript">
			function deleteContent(appSeq){
				if(confirm("삭제 하시겠습니까?")){
					location.href = "/admin/system/appVersion/appVersionDelete.do?mode=delete&appSeq="+appSeq;
				} else return false;
			}
			function saveContent(){
				var mode = $("#frm").children("#mode").val();
				<%-- 
				if($("input[name=osClsCD]:radio:checked").length<1){
					alert("OS 구분을 선택해 주세요.");
					return false;
				}
				if($("input[name=updateClsCD]:radio:checked").length<1){
					alert("메세지 구분을 선택해 주세요.");
					return false;
				}
				 --%>
				if($.trim($("#downloadPath").val())==''){
					alert("마켓주소를 입력해 주세요.");
					$("#downloadPath").focus();
					return false;
				}
				if($.trim($("#appVerInfo").val())==''){
					alert("버전정보를 입력해 주세요.");
					$("#appVerInfo").focus();
					return false;
				}
				
				var regExp = /^[0-9]+[.]+[0-9]+[.]+[0-9]$/;
				if($.trim($("#appVerInfo").val())!=''&&!regExp.test($.trim($("#appVerInfo").val()))){
					alert("버전정보를 형식에 맞게 입력해주세요.\n예)1.0.0");
					$("#appVerInfo").focus();
					return false;
				}
				
				
				if(mode == "insert"){
					/* 최신버전 확인 */
					var appDupCheck = 0;
					var appVerInfo = $("#appVerInfo").val();
					if(appVerInfo!=''){
						$.ajax({
							url : "/admin/system/appVersion/appVersionConfirm.do?appVerInfo="+appVerInfo,
							type : "get",
							async : false,
							contentType: "charset=utf-8",
							success : function(dataView){
								appDupCheck = dataView.appVerInfoReturn;
								if(appDupCheck>0){ appDupCheck = 1;} else{ appDupCheck=0; }
							}, error : function(){ alert("데이터를 가져오는데 실패 하였습니다."); }
						});
					}
					if(appDupCheck<1){ alert("입력하신 버전 정보가 최신이 아닙니다."); return false; }
				}
				if($.trim($("#msgContent").val())==''){
					alert("메세지 내용을 입력해 주세요.");
					$("#msgContent").focus();
					return false;
				}
				if(mode=='insert'){
					$("#frm").attr('action','/admin/system/appVersion/appVersionInsert.do');
				} else if(mode=='update'){
					$("#frm").attr('action','/admin/system/appVersion/appVersionUpdate.do');
				}
				document.getElementById('frm').submit();
				alert('저장이 완료되었습니다.');
				return true;
			}
		</script>
		
		<script type="text/javascript">
			$(document).ready(function(){
				/* 에러 메시지  */
				var alertValue = "<c:out value='${resultError.errorMessage}'/>";
				var mode = $("#frm").children("#mode").val();
				if(mode == "update"){
					$('#appVerInfo').attr("readonly", true);
				}
				if(alertValue!=""){ alert(alertValue); }
				var maxLength = 200;
				$("#msgContent").keyup(function(event){
					var currentLength = 0;
					var cutLength = 0;
					for(var i=0; i<$("#msgContent").val().length; i++){
						currentLength += ($("#msgContent").val().charCodeAt(i)>128) ? 2 : 1;
						if(currentLength<=maxLength){ cutLength++; }
					}
					if(currentLength>maxLength){
						alert("200byte이내 입력을 해주세요.");
						$(this).val($(this).val().substr(0,cutLength)); 
					}
		        });
			});
		</script>
		
		<!--footer S-->
			<tiles:insertAttribute name="footer" />
		<!--footer E-->
	</div>
</body>
</html>
