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
						<p class="pageTitle">팀 관리</p>
						<span>시스템 관리 &gt; <em>팀 관리</em></span>
					</div>
					<div class="page">
						<form:form id="inputFrm" role="form" accept-charset="utf-8" modelAttribute="inputFrm" onsubmit="return false;">
							<form:input type="hidden" id="mode" path="mode" />
							<form:input type="hidden" id="teamSeq" path="teamSeq" />
							<fieldset>
								<table class="tb_type02 mt20">
									<colgroup>
										<col style="width:25%">
										<col style="width:75%">
									</colgroup>
									<tbody>
										<tr>
											<th class="top"><em>*</em> 배송 센터</th>
											<td class="top">
												<select class="select-category03" id="centerId"	name="centerId">
													<option value="">선택</option>
														<c:forEach var="result" items="${centerList}" varStatus="status">
															<c:if test="${inputFrm.centerId == result.comCd}">
																<option value="${result.comCd}" selected="selected"><c:out value="${result.comCdName}"/></option>
															</c:if>
															<c:if test="${inputFrm.centerId != result.comCd}">
																<option value="${result.comCd}" ><c:out value="${result.comCdName}"/></option>
															</c:if>
														</c:forEach>
												</select>
											</td>
										</tr>
										<tr>
											<th><em>*</em> 팀 명</th>
											<td>
												<select class="select-category03" id="teamId"	name="teamId">
													<option value="">선택</option>
														<c:forEach var="result" items="${teamList}" varStatus="status">
															<c:if test="${inputFrm.teamId == result.comCd}">
																<option value="${result.comCd}" selected="selected"><c:out value="${result.comCdName}"/></option>
															</c:if>
															<c:if test="${inputFrm.teamId != result.comCd}">
																<option value="${result.comCd}" ><c:out value="${result.comCdName}"/></option>
															</c:if>
														</c:forEach>
												</select>
											</td>
										</tr>
										<tr>
											<th><em>*</em> 대표 연락처 1</th>
											<td>
												<span class="input-text08"><form:input id="mpnNo1" path="mpnNo1" type="text" maxLength="12" /></span>
											</td>
										</tr>
										<tr>
											<th><em>&nbsp;</em> 대표 연락처 2</th>
											<td>
												<span class="input-text08"><form:input id="mpnNo2" path="mpnNo2" type="text" maxLength="12" /></span>
											</td>
										</tr>
									</tbody>
								</table>
								<div class="btnArea">
									<span class="left" onclick="teamList(); return false;"><button class="btnType01 bc_gray">목록</button></span>
									<c:if test="${ type == 'U' }">
										<span class="right" onclick="teamUpdate(); return false;"><button class="btnType01 bc_green">저장</button></span>
										<span class="right" onclick="teamDelete(); return false;"><button class="btnType01 bc_green">삭제</button></span>
									</c:if>
									<c:if test="${ type == 'C' }">
										<span class="right" onclick="teamInsert(); return false;"><button class="btnType01 bc_green">저장</button></span>
									</c:if>
								</div>
							</fieldset>
						</form:form>

					</div>
				</div>
				<!--content E-->
			</div>
		</div>
		<form:form commandName="searchFrm" name="searchFrm" method="post">
			<form:hidden path="pageIndex" />
			<form:hidden path="centerId" />
			<form:hidden path="teamId" />
		</form:form>
		
		<script type="text/javascript">
			/* 글 목록 화면 function */
			function teamList() {
			   	document.searchFrm.action = "<c:url value='/admin/system/teamMgmt/teamList.do'/>";
			   	document.searchFrm.submit();
			}
		
			function deleteContent(teamSeq){
				if(confirm("삭제 하시겠습니까?")){
					location.href = "/admin/system/teamMgmt/teamDelete.do?mode=delete&teamSeq="+teamSeq;
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
				
				if($.trim($("#mpnNo1").val())==''){
					alert("대표 연락처를 입력해 주세요.");
					$("#mpnNo1").focus();
					return false;
				}
				if(mode=='insert'){
					$("#frm").attr('action','/admin/system/teamMgmt/teamInsert.do');
				} else if(mode=='update'){
					$("#frm").attr('action','/admin/system/teamMgmt/teamUpdate.do');
				}
				document.getElementById('frm').submit();
				alert('저장이 완료되었습니다.');
				return true;
			}
			
			/* 글 등록 function */
			function teamInsert() {
				
				var frm = document.inputFrm;
				var searchFrm = document.searchFrm;
				
				if($.trim($("#mpnNo1").val())==''){
					alert("대표 연락처를 입력해 주세요.");
					$("#mpnNo1").focus();
					return false;
				}
				
				$("input[name=usrGrpCd]").val($("select[name=admin_cls_cd]").val());
				
					$.ajax({
						type:"POST",
						asyn : true,
						url:"<c:url value='/admin/system/teamMgmt/teamInsert.do'/>",
						data : $("#inputFrm").serialize(),
						contentType : "application/x-www-form-urlencoded; charset=UTF-8",
						dataType:"json",
						success:function(data){
							if(data.result == "ok"){
								if(data.checkResult > 0){
									alert('<spring:message code="success.common.save" />');
									window.location.href="<c:url value='/admin/system/teamMgmt/teamList.do'/>";
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
			function teamUpdate() {

				var frm = document.inputFrm;
				var searchFrm = document.searchFrm;
				
					$.ajax({
						type:"POST",
						asyn : true,
						url:"<c:url value='/admin/system/teamMgmt/teamUpdate.do'/>",
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
		</script>
		
		<script type="text/javascript">
			$(document).ready(function(){
				/* 에러 메시지  */
				var alertValue = "<c:out value='${resultError.errorMessage}'/>";
				var mode = $("#frm").children("#mode").val();
				if(mode == "update"){
					$('#appVerInfo').attr("readonly", true);
				}
			});
		</script>
		
		<!--footer S-->
			<tiles:insertAttribute name="footer" />
		<!--footer E-->
	</div>
</body>
</html>
