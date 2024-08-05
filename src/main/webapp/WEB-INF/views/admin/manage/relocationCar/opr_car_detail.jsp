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
						<form:form id="frm" commandName="form" accept-charset="utf-8" modelAttribute="relocationCarView" onsubmit="return false;">
							<form:input type="hidden" id="mode" path="mode" />
							<form:input type="hidden" id="relocateCarID" path="relocateCarID" />
							<fieldset>
								<table class="tb_type02 mt20">
										<colgroup>
											<col style="width:25%" />
											<col style="width:75%" />
										</colgroup>
									<tbody>
										<tr>
											<th class="top"><em>*</em> 소속 센터</th>
											<td class="top">
												<select class="select-category03" id="assignCenterID" name="assignCenterID">
													<option value="">선택</option>
												</select>
											</td>
										</tr>
										<tr>
											<th><em>*</em> 차종</th>
											<td><span class="input-text07"><form:input id="carModlName" path="carModlName" type="text" maxLength="32" /></span></td>
										</tr>
										<tr>
											<th><em>*</em> 차량 번호</th>
											<td><span class="input-text07"><form:input id="carNO" path="carNO" type="text" maxLength="32" /></span></td>
										</tr>
										<tr>
											<th><em>*</em> 차량 연식</th>
											<td>
											<span class="input-text03"><form:input id="carModlyyYYMM1" path="carModlyyYYMM1" type="text" numberOnly="true" maxLength="4" /></span> 년
											<select class="ml10" id="carModlyyYYMM2" name="carModlyyYYMM2">
												<option value="">선택</option>
												<option value="01" <c:if test="${relocationCarView.carModlyyYYMM2 eq '01'}">selected="true"</c:if>>01</option>
												<option value="02" <c:if test="${relocationCarView.carModlyyYYMM2 eq '02'}">selected="true"</c:if>>02</option>
												<option value="03" <c:if test="${relocationCarView.carModlyyYYMM2 eq '03'}">selected="true"</c:if>>03</option>
												<option value="04" <c:if test="${relocationCarView.carModlyyYYMM2 eq '04'}">selected="true"</c:if>>04</option>
												<option value="05" <c:if test="${relocationCarView.carModlyyYYMM2 eq '05'}">selected="true"</c:if>>05</option>
												<option value="06" <c:if test="${relocationCarView.carModlyyYYMM2 eq '06'}">selected="true"</c:if>>06</option>
												<option value="07" <c:if test="${relocationCarView.carModlyyYYMM2 eq '07'}">selected="true"</c:if>>07</option>
												<option value="08" <c:if test="${relocationCarView.carModlyyYYMM2 eq '08'}">selected="true"</c:if>>08</option>
												<option value="09" <c:if test="${relocationCarView.carModlyyYYMM2 eq '09'}">selected="true"</c:if>>09</option>
												<option value="10" <c:if test="${relocationCarView.carModlyyYYMM2 eq '10'}">selected="true"</c:if>>10</option>
												<option value="11" <c:if test="${relocationCarView.carModlyyYYMM2 eq '11'}">selected="true"</c:if>>11</option>
												<option value="12" <c:if test="${relocationCarView.carModlyyYYMM2 eq '12'}">selected="true"</c:if>>12</option>
											</select> 월
											</td>
										</tr>
										<tr>
											<th><em>*</em> GPS 단말기</th>
											<td><span class="input-text07"><form:input id="gPSTerminalSerialNO" path="gPSTerminalSerialNO" type="text" maxLength="64" /></span> <button class="btnType02 thid" onclick="gpsDupCheck();">중복확인</button></td>						
										</tr>
										<tr>
											<th>소속 팀</th>
											<td>
												<select class="select-category03" id="teamSeq" name="teamSeq">
													<option value="">선택</option>
												</select>
											</td>
										</tr>
										<tr>
											<th><em>*</em> 거치대 개수</th>
											<td><span class="input-text03"><form:input id="rackCnt" path="rackCnt" type="text" numberOnly="true" maxLength="4" /></span></td>
										</tr>
										<tr>
											<th>비고</th>
											<td><span class="input-text05"><form:input id="carDesc" path="carDesc" type="text" maxLength="200" /></span><p class="mt10">(200자 이내)</p></td>
										</tr>
										<tr>
											<th><em>*</em> 사용여부</th>
											<td>
												<span class="input-rd01"><input type="radio" id="carUseYN1" name="carUseYN" value="Y" <c:if test="${relocationCarView.carUseYN eq 'Y'}">checked="true"</c:if>/><label for="carUseYN1">사용</label></span>
												<span class="input-rd01"><input type="radio" id="carUseYN2" name="carUseYN" value="N"<c:if test="${relocationCarView.carUseYN ne 'Y'}">checked="true"</c:if>/><label for="carUseYN2">미사용</label></span>
											</td>
										</tr>
										<tr>
											<th>수정일</th>
											<td><fmt:formatDate value="${relocationCarView.modDttm}" pattern="yyyy.MM.dd"/></td>
										</tr>
									</tbody>
								</table>
								<div class="btnArea">
									<span class="left"><button class="btnType01 bc_gray" onclick="location.href='/admin/manage/relocationCar/relocationCarList.do?currentPageNo=<c:out value="${relocationCarView.currentPageNo}"/><c:out value="${parameterInfo}" escapeXml="false"/>';">목록</button></span>
									<span class="right"><button class="btnType01 bc_green" onclick="saveContent();">저장</button></span>	
								</div>
							</fieldset>
						</form:form>
					</div>
				</div>
				<!--content E-->
			</div>
		</div>
		
		<script type="text/javaScript">
			var valueGPS = '<c:out value="${relocationCarView.gPSTerminalSerialNO}"/>';
			var gpsCheck = 1;
			var gpsValCheck = false;
			function saveContent(){
				/* 소속 센터 */
				if($("#assignCenterID").val()==''){ alert("소속 센터를 선택해 주세요."); return false; }
				/* 차종 */
				if($("#carModlName").val()==''){ alert("차종을 입력해 주세요."); return false; }
				/* 차량 번호 */
				if($("#carNO").val()==''){ alert("차량 번호를 입력해 주세요."); return false; }
				/* 차량연식 */
				if($("#carModlyyYYMM1").val()==''){ alert("차량연식을 입력해 주세요."); return false; }
				if(isNaN($("#carModlyyYYMM1").val())){ alert("차량연식은 숫자만 입력 가능합니다."); return false; }
				if($("#carModlyyYYMM2").val()==''){ alert("차량연식을 선택해 주세요."); return false; }
				/* GPS 단말기 */
				if($("#gPSTerminalSerialNO").val()==''){ alert("GPS 단말기 S/N을 입력해주세요."); return false; }
				if($("#gPSTerminalSerialNO").val()!=valueGPS&&!gpsValCheck){ alert("GPS 단말기 S/N 중복을 확인해 주세요."); return false; }
				/* 거치대 개수 */
				if($("#rackCnt").val()==0){ alert("거치대 개수를 입력해 주세요."); return false; }
				if(isNaN($("#rackCnt").val())){ alert("거치대 개수는 숫자만 입력 가능합니다."); return false; }
				/* 비고 */
// 				if($("#carDesc").val()==''){ alert("비고를 입력해 주세요."); return false; }
				/* 사용여부 */
				if($("input[name=carUseYN]:radio:checked").val()==''){ alert("사용여부를 선택해 주세요."); return false; }
				var mode = $("#frm").children("#mode").val();
				
				var url = "";
				
				if(mode=='insert'){
					url = "/admin/manage/relocationCar/relocationCarInsert.do";
				} else if(mode=='update'){
					url = "/admin/manage/relocationCar/relocationCarUpdate.do";
				}
				
				$.ajax({
					type		: 'post',
					url			: url,
					dataType	: 'json',
					data		: $("#frm").serialize(),
					success		: function( data ) {
						if(data.resultMessage == 'Success'){
          	        		alert('저장이 완료되었습니다.');
          	      			location.href("/admin/manage/relocationCar/relocationCarEdit.do?mode=edit&relocateCarID="+data.relocateCarId);
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
			};
		</script>
		
		<script type="text/javaScript">
			var valueGPS = '<c:out value="${relocationCarView.gPSTerminalSerialNO}"/>';
			/* 아파트 */
			$.getJSON('/admin/manage/relocationCar/getCenterList.do?centerClsCD=CEN_001',function(data){
				$.each(data.dataList,function(key,val){
					$("#assignCenterID").append('<option value="' + this.centerID + '">' + this.centerName + '</option>');
				})
				var initValue = '<c:out value="${relocationCarView.assignCenterID}"/>';
				if(initValue!=''){ $("#assignCenterID").val(initValue); }
			});
			
			/* 소속 팀 */
			$.getJSON('/admin/manage/relocationCar/getTeamList.do',function(data){
				$.each(data.dataList,function(key,val){
					$("#teamSeq").append('<option value="' + this.teamSeq + '">' + this.centerNm + '|' + this.teamNm + '</option>');
				})
				var initValue = '<c:out value="${relocationCarView.teamSeq}"/>';
				if(initValue!=''){ $("#teamSeq").val(initValue); }
			});
			
			/* GPS 중복 */
			function gpsDupCheck(){
				var gpsDup = $("#gPSTerminalSerialNO").val();
				if(gpsDup==''){ alert("GPS 단말기 S/N을 입력해주세요."); return false; }
				if(gpsDup!=''&& valueGPS==$("#gPSTerminalSerialNO").val()){ alert("사용 가능한 S/N입니다."); gpsValCheck = true; } else {
					$.ajax({
						url : "/admin/manage/relocationCar/gpsDupCheck.do?gpsDup="+gpsDup,
						type : "get",
						contentType: "charset=utf-8",
						async : false,
						success : function(dataView){
							gpsCheck = dataView.gpsCount;
							if(gpsCheck>0){
								alert("사용 불가능한 S/N입니다.");
								gpsValCheck = false;
							} else {
								alert("사용 가능한 S/N입니다.");
								gpsValCheck = true;
							}
						},
						error : function(){ alert("데이터를 가져오는데 실패 하였습니다."); }
					});
				}
				return false;
			}
		</script>
		
		<script type="text/javascript">
			$(document).on("keyup", "input:text[numberOnly]", function() {$(this).val( $(this).val().replace(/[^0-9]/gi,"") );});
			$(document).ready(function(){
				/* 에러 메시지  */
				var alertValue = "<c:out value='${resultError.errorMessage}'/>";
				if(alertValue!=""){ alert(alertValue); }
			});
			$("#gPSTerminalSerialNO").on("change",function(){
				if(valueGPS!=''&&valueGPS==$("#gPSTerminalSerialNO").val()){ gpsValCheck = true; } else { gpsValCheck = false; }
			});
		</script>
		
		<!--footer S-->
			<tiles:insertAttribute name="footer" />
		<!--footer E-->
	</div>
</body>
</html>
