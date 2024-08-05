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
						<form:form id="frm" commandName="form" accept-charset="utf-8" modelAttribute="centerView" onsubmit="return false;">
							<form:input type="hidden" id="mode" path="mode" />
							<form:input type="hidden" id="centerID" path="centerID" />
							<fieldset>
								<table class="tb_type02 mt20">
									<colgroup>
										<col style="width:25%" />
										<col style="width:75%" />
									</colgroup>
									<tbody>
										<tr>
											<th class="top"><em>*</em> 센터 구분</th>
											<td class="top">
												<select class="select-category03" id="centerClsCD" name="centerClsCD" >
													<option value="">선택</option>
												</select>
											</td>
										</tr>
										<tr>
											<th><em>*</em> 자치구</th>
											<td>
												<select class="select-category03" id="districtCD" name="districtCD" >
													<option value="">선택</option>
												</select>
											</td>
										</tr>
										<tr>
											<th><em>*</em> 센터명</th>
											<td><span class="input-text07"><form:input id="centerName" path="centerName" type="text" maxLength="100" /></span></td>
										</tr>
										<tr>
											<th><em>*</em> 전화번호</th>
											<td>
											<span class="input-text03"><form:input id="centerTelNO1" path="centerTelNO1" numberOnly="true" type="text" maxLength="3" /></span> - 
											<p class="pwtableblock">
											<span class="input-text03"><form:input id="centerTelNO2" path="centerTelNO2" numberOnly="true" type="text" maxLength="4" /></span> - 
											<span class="input-text03"><form:input id="centerTelNO3" path="centerTelNO3" numberOnly="true" type="text" maxLength="4" /></span>
											</p>
											</td>
										</tr>
										<tr>
											<th>운영시간</th>
											<td>
											<span class="input-text03"><form:input id="oprStrTime1" path="oprStrTime1" numberOnly="true" type="text" maxLength="2" /></span>시
											<span class="input-text03"><form:input id="oprStrTime2" path="oprStrTime2" numberOnly="true" type="text" maxLength="2" /></span>분 ~
											<p class="pwtableblock">
												<span class="input-text03"><form:input id="oprEndTime1" path="oprEndTime1" numberOnly="true" type="text" maxLength="2" /></span>시
												<span class="input-text03"><form:input id="oprEndTime2" path="oprEndTime2" numberOnly="true" type="text" maxLength="2" /></span>분
											</p>
											</td>
										</tr>
										<tr>
											<th><em>*</em> 사람찾기</th>
											<td><span class="input-text08"><form:input id="chargerName" path="chargerName" type="text" readonly="true" /></span> <a href="/common/pop/showUserFindPop.do" class="winNewPop btnType02 thid"  title="사람찾기" data-width="440" data-height="455" data-pmt="&usrGrpCd=003">사람찾기</a></td>
										</tr>
										<tr>
											<th>비고</th>
											<td><span class="input-text05"><form:input id="centerDesc" path="centerDesc" type="text" maxLength="400" /></span><p class="mt10">(200자 이내)</p></td>
										</tr>
										<tr>
											<th><em>*</em> 주소</th>
											<td>
												<div><span class="input-text03"><form:input id="station_post_no" path="centerPostNO" type="text" readonly="true" /></span> <button class="btnType02" onclick="goPopup(); return false;">주소찾기</button></div>
												<p class="mt10"><span class="input-text05"><form:input id="station_addr1" path="centerAddr1" type="text" readonly="true" /></span></p>
												<p class="mt10"><span class="input-text05"><form:input id="station_addr2" path="centerAddr2" type="text" maxLength="200" /></span></p>
											</td>
										</tr>
										<tr>
											<th><em>*</em> 위경도</th>
											<td>
											<span class="input-text03">위도 : <form:input id="station_latitude" path="centerLatitude" type="text" /></span><span class="input-text03 ml10">경도 : <form:input id="station_longitude" path="centerLongitude" type="text"  /></span>
											<p class="pwtableblock">
											<a title="위치지도찾기" class="winNewPop btnType02 thid" href="/common/pop/showLocationMapPop.do" data-pmt="&latitude=${centerView.centerLatitude}&longitude=${centerView.centerLongitude}" data-height="680" data-width="600">지도보기</a> 
											<p class="pwtableblock">
											</td>
										</tr>
										<tr>
											<th>수정일</th>
											<td><fmt:formatDate value="${centerView.modDttm}" pattern="yyyy.MM.dd"/></td>
										</tr>
										<tr>
											<th>수정자</th>
											<td> <c:out value="${centerView.modName}" /><c:if test="${centerView.modID ne null && centerView.modID ne ''}">(<c:out value="${centerView.modID}" />)</c:if></td>
										</tr>
									</tbody>
								</table>
								<div class="btnArea">
									<span class="left"><button class="btnType01 bc_gray" onclick="location.href='/admin/manage/center/centerList.do?currentPageNo=<c:out value="${centerView.currentPageNo}"/><c:out value="${parameterInfo}" escapeXml="false"/>';">목록</button></span>
									<span class="right"><button class="btnType01 bc_green" onclick="saveContent();">저장</button></span>	
								</div>
							</fieldset>
						</form:form>
					</div>
				</div>
				<!--content E-->
			</div>
		</div>
		<script type="/js/common_barocle.js"></script>
		<script type="text/javaScript">
			function saveContent(){
				/* 센터구분 */
				if($("#centerClsCD option:selected").val()==''){
					alert("센터구분을 선택해 주세요."); return false;
				}
				/* 자치구 */
				if($("#districtCD option:selected").val()==''){
					alert("자치구를 선택해 주세요."); return false;
				}
				/* 센터명 */
				if($("#centerName").val()==''){
					alert("센터명을 입력해 주세요.");
					$("#centerName").focus();
					return false;
				}
				/* 전화번호 */
				if($("#centerTelNO1").val()==''||$("#centerTelNO2").val()==''||$("#centerTelNO3").val()==''){
					alert("전화 번호를 입력해 주세요.");
					$("#centerTelNO1").focus();
					return false;
				}
				/* 운영시간 */
				//if($("#oprStrTime1").val()==''||$("#oprStrTime2").val()==''){ alert("운영 시작 시간을 입력해 주세요."); return false; }
				//if($("#oprEndTime1").val()==''||$("#oprEndTime2").val()==''){ alert("운영 종료 시간을 입력해 주세요."); return false; }
				if($("#oprStrTime1").val()!=''||$("#oprStrTime2").val()!=''||$("#oprEndTime1").val()!=''||$("#oprEndTime2").val()!=''){
					if($("#oprStrTime1").val()>24||$("#oprStrTime1").val()<0||$("#oprEndTime1").val()>24||$("#oprEndTime1").val()<0){
						alert("시간은 0~23시 사이로만 설정이 가능합니다."); $("#oprStrTime1").focus; return false;
					}
					if($("#oprStrTime2").val()>60||$("#oprStrTime2").val()<0||$("#oprEndTime2").val()>60||$("#oprEndTime2").val()<0){
						alert("분은 0~59분 사이로만 설정이 가능합니다."); $("#oprStrTime1").focus; return false;
					}
					var time1 = $("#oprStrTime1").val() + $("#oprStrTime2").val();
					var time2 = $("#oprEndTime1").val() + $("#oprEndTime2").val();
					if(time1>time2){ alert("서비스  운영 종료 시간이 시작 시간보다 빠를 수 없습니다."); $("#oprStrTime1").focus; return false; }
				}
				/* 사람찾기 */
				if($("#chargerName").val()==''){ alert("담당자를 등록해 주세요."); return false; }
// 				/* 비고 */
// 				if($("#centerDesc").val()==''){ alert("비고를 입력해 주세요."); $("#centerDesc").focus; return false; }
				/* 우편번호 */
				if($("#station_full_post_no").val()==''){ alert("주소찾기로 주소를 등록해 주세요."); return false; }
				/* 주소 */
				if($("#shopAddr1").val()==''||$("#shopAddr2").val()==''){ alert("주소찾기로 주소를 등록해 주세요."); return false; }
				/* 위경도 */
				if($("#station_latitude").val()==''||$("#station_longitude").val()==''){ alert("위경도를 입력해 주세요."); return false; }
				var mode = $("#frm").children("#mode").val();
				
				var url = "";
				
				if(mode=='insert'){
					url = "/admin/manage/center/centerInsert.do";
				} else if(mode=='update'){
					url = "/admin/manage/center/centerUpdate.do";
				}
				
				$.ajax({
					type		: 'post',
					url			: url,
					dataType	: 'json',
					data		: $("#frm").serialize(),
					success		: function( data ) {
						if(data.resultMessage == 'Success'){
          	        		alert('저장이 완료되었습니다.');
          	      			location.href("/admin/manage/center/centerEdit.do?mode=edit&centerID="+data.centerId);
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
				
			};
			/* 센터 구분 */
			$.getJSON('/admin/manage/center/getSysCode.do?sysCode=CEN',function(data){
				$.each(data.dataList,function(key,val){
					$("#centerClsCD").append('<option value="' + this.comCD + '">' + this.comCdName + '</option>');
				})
				var initValue = '<c:out value="${centerView.centerClsCD}"/>';
				if(initValue!=''){ $("#centerClsCD").val(initValue); }
			})
			/* 자치구 */
			$.getJSON('/admin/manage/center/getSysCode.do?sysCode=GUG',function(data){
				$.each(data.dataList,function(key,val){
					$("#districtCD").append('<option value="' + this.comCD + '">' + this.comCdName + '</option>');
				})
				var initValue = '<c:out value="${centerView.districtCD}"/>';
				if(initValue!=''){ $("#districtCD").val(initValue); }
			})
			function setAdminID(adminId) {
		    	$("#chargerName").val(adminId);
		    };
		</script>
		
		<script type="text/javascript">
			$(document).on("keyup", "input:text[numberOnly]", function() {$(this).val( $(this).val().replace(/[^0-9]/gi,"") );});
			$(document).ready(function(){
				/* 에러 메시지  */
				var alertValue = "<c:out value='${resultError.errorMessage}'/>";
				if(alertValue!=""){ alert(alertValue); }
			});
		</script>
		
		<!--footer S-->
			<tiles:insertAttribute name="footer" />
		<!--footer E-->
	</div>
</body>
</html>
