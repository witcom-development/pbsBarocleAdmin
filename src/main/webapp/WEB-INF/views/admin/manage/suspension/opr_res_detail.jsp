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
						<form:form id="frm" commandName="form" accept-charset="utf-8" modelAttribute="suspensionView" onsubmit="return false;">
							<form:input type="hidden" id="mode" path="mode" />
							<form:input type="hidden" id="delaySeq" path="delaySeq" />
							<fieldset>
								<table class="tb_type02 mt20">
									<colgroup>
										<col style="width:25%" />
										<col style="width:75%" />
									</colgroup>
									<tbody>
										<tr>
											<th class="top"><em>*</em> 운휴일</th>
											<td class="top">
												<fmt:formatDate value="${suspensionView.delayStrDate}" pattern="yyyy-MM-dd" var="delayStrDate"/>
												<span class="selectDate input-datepick02"><input id="delayStrDate" name="delayStrDate" type="text" class="datepicker input-datepick02" title="선택 날짜" onchange="getDay();" readonly="true" value="${delayStrDate}" /></span>
												<span class="dash">~</span>
												<fmt:formatDate value="${suspensionView.delayEndDate}" pattern="yyyy-MM-dd" var="delayEndDate"/>
												<span class="selectDate input-datepick02"><input id="delayEndDate" name="delayEndDate" type="text" class="datepicker input-datepick02" title="선택 날짜" onchange="getDay();" readonly="true" value="${delayEndDate}" /></span>
												<div class="resdayarea">
													<span>운휴일자</span>
													<input id="delayDate" name="delayDate" type="text" class="" readonly="true"/>
												</div>
											</td>
										</tr>
										<tr>
											<th><em>*</em> 정기권 일괄 변경</th>
											<td>
												<span class="input-rd01"><input type="radio" id="ticketChngYN1" name="ticketChngYN" value="Y" <c:if test="${suspensionView.ticketChngYN ne 'N'}">checked="true"</c:if> <c:if test="${suspensionView.ticketChngYN eq 'N'}">disabled="true"</c:if>/><label for="ticketChngYN1">Y</label></span>
												<span class="input-rd01"><input type="radio" id="ticketChngYN2" name="ticketChngYN" value="N" <c:if test="${suspensionView.ticketChngYN ne 'Y'}">checked="true"</c:if> <c:if test="${suspensionView.ticketChngYN eq 'Y'}">disabled="true"</c:if>/><label for="ticketChngYN2">N</label></span>
												<p class="mt10">(운휴일자에 해당하는 정기권 이용자의 이용기간을  일괄적으로 추가함)</p>
											</td>
										</tr>
										<tr>
											<th><em>*</em> 운휴 사유</th>
											<td><form:textarea id="delayReasonDesc" path="delayReasonDesc" class="detatextarea" /> <br />(500자 이내)</td>
										</tr>
										<tr>
											<th>수정일</th>
											<td><fmt:formatDate value="${suspensionView.modDttm}" pattern="yyyy.MM.dd"/></td>
										</tr>
										<tr>
											<th>수정자</th>
											<td><c:out value="${suspensionView.adminName}" /><c:if test="${suspensionView.modID ne '' && suspensionView.modID ne null}">(<c:out value="${suspensionView.modID}" />)</c:if></td>
										</tr>
									</tbody>
								</table>
								<div class="btnArea">
									<span class="left"><button class="btnType01 bc_gray" onclick="location.href='/admin/manage/suspension/suspensionList.do?currentPageNo=<c:out value="${suspensionView.currentPageNo}"/><c:out value="${parameterInfo}" escapeXml="false"/>';">목록</button></span>
									<c:if test="${suspensionView.ticketChngYN eq 'N'}">
										<span class="right"><button class="btnType01 bc_green" onclick="saveContent();">저장</button></span>
									</c:if>
								</div>
							</fieldset>
						</form:form>
					</div>
				</div>
				<!--content E-->
			</div>
		</div>
		
		<script type="text/javascript">
			function saveContent(){
				/* 운휴일 */
				if($("#delayStrDate").val()==''){ alert("운휴 시작 날짜를 선택해 주세요."); return false; }
				if($("#delayEndDate").val()==''){ alert("운휴 종료 날짜를 선택해 주세요."); return false; }
				if($("#delayStrDate").val()>$("#delayEndDate").val()){
					alert("운휴 종료 날짜는 시작 날짜보다 빠를 수 없습니다.");
					return false;
				}
					/* 운휴 중복 */
					var susDupCheck = 1;
					var delayStrDate = $("#delayStrDate").val();
					var delayEndDate = $("#delayEndDate").val();
					var delaySeq = $("#delaySeq").val();
					if($("#delayStrDate").val()!=''&&$("#delayEndDate").val()!=''){
						$.ajax({
							url : "/admin/manage/suspension/suspensionValid.do?delayStrDate="+delayStrDate+"&delayEndDate="+delayEndDate+"&delaySeq="+delaySeq,
							type : "get",
							async : false,
							contentType: "charset=utf-8",
							success : function(dataView){ 
								susDupCheck = dataView.suspensionValid;
								if(susDupCheck>0){ susDupCheck = 1;} else{ susDupCheck=0; }
							}, error : function(){ alert("데이터를 가져오는데 실패 하였습니다."); }
						});
					}
					if(susDupCheck>0){ alert("중복되는 운휴일이 있습니다."); return false; }	
				/* 운휴사유 */
				if($("#delayReasonDesc").val()==''){ alert("운휴 사유를 입력해 주세요."); return false; }
				var mode = $("#frm").children("#mode").val();

				var url = "";
				
				if(mode=='insert'){
					url = "/admin/manage/suspension/suspensionInsert.do";
				} else if(mode=='update'){
					url = "/admin/manage/suspension/suspensionUpdate.do";
				}
				
				$.ajax({
					type		: 'post',
					url			: url,
					dataType	: 'json',
					data		: $("#frm").serialize(),
					success		: function( data ) {
						if(data.resultMessage == 'Success'){
          	        		alert('저장이 완료되었습니다.');
          	      			location.href("/admin/manage/suspension/suspensionEdit.do?mode=edit&delaySeq="+data.delaySeq);
          	        	}else{
          	        		alert('저장이 실패하였습니다.');
          	        	}
					},
					error : function(jqXHR, textStatus,errorThrown){
						if(jqXHR.status === 500 || jqXHR.status === 200){
							alert("에러가 발생했습니다.");
						}
						//console.log(textStatus);
					}
				});

				return true;
			}
			function getDay(){
				var sDate = new Date($("#delayStrDate").val());
				var eDate = new Date($("#delayEndDate").val());
				if(sDate!=''&&eDate!=''&&sDate<=eDate){
					var days = Math.abs((eDate.getTime()-sDate.getTime())/(24*60*60*1000)) + 1;
					$("#delayDate").val(days);
				}
			}
		</script>
		
		<script type="text/javascript">
			var previousValue;
			$("input").on('focus',function(){
				previous = this.value;
			}).change(function(){
				var delayStrDate = $("#delayStrDate").val();
				var delayEndDate = $("#delayEndDate").val();
				if(delayStrDate!=''&&delayEndDate!=''&&delayStrDate>delayEndDate){
					alert("운휴 종료일이 시작일보다 빠를 수 없습니다.");
					$(this).val(previous);
				}
			});
		</script>
		
		<script type="text/javascript">
			$(document).ready(function(){
				/* 에러 메시지  */
				var alertValue = "<c:out value='${resultError.errorMessage}'/>";
				if(alertValue!=""){ alert(alertValue); }
				var maxLength = 500;
				$("#delayReasonDesc").keyup(function(event){
					var currentLength = 0;
					var cutLength = 0;
					for(var i=0; i<$("#delayReasonDesc").val().length; i++){
						currentLength += ($("#delayReasonDesc").val().charCodeAt(i)>128) ? 2 : 1;
						if(currentLength<=maxLength){ cutLength++; }
					}
					if(currentLength>maxLength){
						alert("500byte이내 입력을 해주세요.");
						$(this).val($(this).val().substr(0,cutLength)); 
					}
		        });
				getDay();
			});
		</script>
		
		<!--footer S-->
			<tiles:insertAttribute name="footer" />
		<!--footer E-->
	</div>
</body>
</html>
