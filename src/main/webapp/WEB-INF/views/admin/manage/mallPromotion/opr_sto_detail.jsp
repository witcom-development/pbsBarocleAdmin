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
						<form:form id="frm" commandName="form" accept-charset="utf-8" modelAttribute="mallPromotionView" onsubmit="return false;">
							<form:input type="hidden" id="mode" path="mode" />
							<form:input type="hidden" id="shopADSeq" path="shopADSeq" />
							<fieldset>
								<table class="tb_type02 mt20">
									<colgroup>
										<col style="width:25%" />
										<col style="width:75%" />
									</colgroup>
									<tbody>
										<tr>
											<th class="top"><em>*</em> 아파트</th>
											<td class="top">
												<select class="select-category03" id="stationGrpSeq" name="stationGrpSeq">
													<option value="">선택</option>
												</select>
											</td>
										</tr>
										<tr>
											<th><em>*</em> 대여소</th>
											<td>
												<select class="select-category03" id="stationID" name="stationID">
													<option value="">선택</option>
												</select>
											</td>
										</tr>
										<tr>
											<th><em>*</em> 업종/상가명</th>
											<td>
												<select class="select-category03" id="typeClsCD" name="typeClsCD" typeClsCD"">
													<option value="">선택</option>
												</select>
												<span class="input-text07"><form:input id="shopName" path="shopName" type="text" maxlength="100" /></span>
											</td>
										</tr>
										<tr>
											<th><em>*</em> 홍보문구</th>
											<td><form:textarea id="adTextDesc" path="adTextDesc" class="detatextarea" /><br />(500자 이내)</td>
										</tr>
										<tr>
											<th><em>*</em> 주소</th>
											<td>
												<div><span class="input-text03"><form:input id="station_full_post_no" path="shopPostNO" type="text" readonly="true" /></span> <button class="btnType02" onclick="goPopup(); return false;">주소찾기</button></div>
												<p class="mt10"><span class="input-text05"><form:input id="station_addr1" path="shopAddr1" type="text" readonly="true" /></span></p>
												<p class="mt10"><span class="input-text05"><form:input id="station_addr2" path="shopAddr2" type="text" /></span></p>
											</td>
										</tr>
										<tr>
											<th><em>*</em> 전화번호</th>
											<td>
												<span class="input-text03 m110 mr10"><form:input id="shopTelNO1" path="shopTelNO1" type="text" numberOnly="true" maxlength="3" /></span>
												<span class="input-text03 m110 mr10"><form:input id="shopTelNO2" path="shopTelNO2" type="text" numberOnly="true" maxlength="4" /></span>
												<span class="input-text03 m110 mr10"><form:input id="shopTelNO3" path="shopTelNO3" type="text" numberOnly="true" maxlength="4" /></span>
											</td>
										</tr>
										<tr>
											<th>위경도</th>
											<td>
											<span>위도 : </span><span class="input-text03 ml10 mr10"><form:input id="station_latitude" path="shopLatitude" type="text" /></span>
											<p class="pwtableblock"><span>경도 : </span><span class="input-text03 ml10"><form:input id="station_longitude" path="shopLongitude" type="text" /></span>&nbsp;&nbsp;&nbsp;<a title="위치지도찾기" class="winNewPop btnType02 thid" href="/common/pop/showLocationMapPop.do" data-pmt="&latitude=${mallPromotionView.shopLatitude}&longitude=${mallPromotionView.shopLongitude}" data-height="680" data-width="600">지도보기</a> </p>
											<p class="mt10">(주소를 입력하시고 저장하면 자동으로 입력됨)</p>
											</td>
										</tr>
										<tr>
											<th>수정일</th>
											<td><fmt:formatDate value="${mallPromotionView.modDttm}" pattern="yyyy.MM.dd"/></td>
										</tr>
									</tbody>
								</table>
								<div class="btnArea">
									<span class="left"><button class="btnType01 bc_gray" onclick="location.href='/admin/manage/mallPromotion/mallPromotionList.do?currentPageNo=<c:out value="${mallPromotionView.currentPageNo}"/><c:out value="${parameterInfo}" escapeXml="false"/>';">목록</button></span>
									<span class="right">
									<c:if test="${mallPromotionView.shopADSeq>0}">
										<button class="btnType01" onclick="deleteContent('<c:out value="${mallPromotionView.shopADSeq}"/>');">삭제</button>
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
			function deleteContent(shopADSeq){
				if(confirm("삭제 하시겠습니까?")){
					location.href = "/admin/manage/mallPromotion/mallPromotionDelete.do?mode=delete&shopADSeq="+shopADSeq;
				} else return false;
			}
			function saveContent(){
				/* 아파트 */
				if($("#stationGrpSeq").val()==''){ alert("아파트을 선택해 주세요."); return false; }
				/* 대여소 */
				if($("#stationID").val()==''){ alert("대여소를 선택해 주세요."); return false; }
				/* 업종 */
				if($("#typeClsCD").val()==''){ alert("업종을 선택해 주세요."); return false; }
				/* 상가명 */
				if($("#shopName").val()==''){ alert("상가명을 입력해 주세요."); return false; }
				/* 홍보문구 */
				if($("#adTextDesc").val()==''){ alert("홍보문구를 입력해 주세요."); return false; }
				/* 우편번호 */
				if($("#station_full_post_no").val()==''){ alert("주소찾기로 주소를 등록해 주세요."); return false; }
				/* 주소1 */
				if($("#shopAddr1").val()==''||$("#shopAddr2").val()==''){ alert("주소찾기로 주소를 등록해 주세요."); return false; }
				/* 전화번호 */
				if($("#shopTelNO1").val()==''||$("#shopTelNO2").val()==''||$("#shopTelNO3").val()==''){ alert("전화번호를 입력해주세요."); return false; }
				/* 위경도 */
				if($("#station_latitude").val()==''||$("#station_longitude").val()==''){ alert("위경도를 입력해 주세요."); return false; }
				var mode = $("#frm").children("#mode").val();
				
				var url = "";
				
				if(mode=='insert'){
					url = "/admin/manage/mallPromotion/mallPromotionInsert.do";
				} else if(mode=='update'){
					url = "/admin/manage/mallPromotion/mallPromotionUpdate.do";
				}
				
				$.ajax({
					type		: 'post',
					url			: url,
					dataType	: 'json',
					data		: $("#frm").serialize(),
					success		: function( data ) {
						if(data.resultMessage == 'Success'){
          	        		alert('저장이 완료되었습니다.');
          	      			location.href("/admin/manage/mallPromotion/mallPromotionEdit.do?mode=edit&shopADSeq="+data.shopADSeq);
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
			/* 아파트 */
			$.getJSON('/admin/manage/mallPromotion/getStationGroup.do',function(data){
				$.each(data.dataList,function(key,val){
					$("#stationGrpSeq").append('<option value="' + this.stationGrpSeq + '">' + this.stationGrpName + '</option>');
				});
				var initValue = '<c:out value="${mallPromotionView.stationGrpSeq}"/>';
				if(initValue!=''){ $("#stationGrpSeq").val(initValue); }
			});
			/* 초기 대여소 목록 */
			var param = '';
			<c:if test="${mallPromotionView.stationGrpSeq>0}">param = '?stationGrpSeq=+<c:out value="${mallPromotionView.stationGrpSeq}"/>'; </c:if>
			$.getJSON('/admin/manage/mallPromotion/getStationID.do'+param,function(data){
				$.each(data.dataList,function(key,val){
					$("#stationID").append('<option value="' + this.stationID + '">' + this.stationName + '</option>');
				})
				var initValue = '<c:out value="${mallPromotionView.stationID}"/>';
				if(initValue!=''){ $("#stationID").val(initValue); }
			});
			/* 대여소 목록 */
			$("#stationGrpSeq").change(function(){
				$.getJSON('/admin/manage/mallPromotion/getStationID.do?stationGrpSeq='+$("#stationGrpSeq option:selected").val(),function(data){
					$("#stationID").empty();
					$("#stationID").append('<option value="">선택</option>');
					$.each(data.dataList,function(key,val){
						$("#stationID").append('<option value="' + this.stationID + '">' + this.stationName + '</option>');
						if(this.stationID=='<c:out value="${mallPromotionView.stationID}"/>'){ $("#stationID").val('<c:out value="${mallPromotionView.stationID}"/>'); }
					})
				});
			});
			/* 업종 */
			$.getJSON('/admin/manage/center/getSysCode.do?sysCode=KSS',function(data){
				$.each(data.dataList,function(key,val){
					$("#typeClsCD").append('<option value="' + this.comCD + '">' + this.comCdName + '</option>');
				})
				var initValue = '<c:out value="${mallPromotionView.typeClsCD}"/>';
				if(initValue!=''){ $("#typeClsCD").val(initValue); }
			})
		</script>
		
		<script type="text/javascript">
			$(document).on("keyup", "input:text[numberOnly]", function() {$(this).val( $(this).val().replace(/[^0-9]/gi,"") );});
			$(document).ready(function(){
				/* 에러 메시지  */
				var alertValue = "<c:out value='${resultError.errorMessage}'/>";
				if(alertValue!=""){ alert(alertValue); }
				var maxLength = 500;
				$("#adTextDesc").keyup(function(event){
					var currentLength = 0;
					var cutLength = 0;
					for(var i=0; i<$("#adTextDesc").val().length; i++){
						currentLength += ($("#adTextDesc").val().charCodeAt(i)>128) ? 2 : 1;
						if(currentLength<=maxLength){ cutLength++; }
					}
					if(currentLength>maxLength){
						alert("500byte이내 입력을 해주세요.");
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

