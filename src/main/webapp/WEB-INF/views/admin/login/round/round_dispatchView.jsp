<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<c:set var="date" value="<%= new java.util.Date() %>"></c:set>
	<c:set var="nowDateFormat"><fmt:formatDate value="${date}" pattern="MM-dd" /></c:set>
</head> 
<body>

	<div id="dispchDiv">
			<div style="float: left; padding-left: 2%; vertical-align: middle; ">근무일 : ${nowDateFormat}  
			</div>
			<div style="float: right; margin-bottom:3px; ">
				 	<button id="btnWrkSubmit" class="s-btn s-btn-success">저장</button>
					<button id="btnWrkUpdate" class="s-btn s-btn-success" style="display: none;">수정</button>
			</div>		
	<form id="workForm">
		<table class="tb_type02">
			<colgroup>
				<col style="width:25%">
				<col style="width:75%">
				<%-- <col style="width:55%"> --%>
			</colgroup>
			<tbody>
				<tr>
					<th class="top">근무시간</th>
					<td class="top">
					<input class="otherTime" name="workTime" type="hidden">
					<div class="row">
					  	<div class="col-md-4 d-flex align-items-center py-1">  <!-- style="max-width:120px;" -->
							<input type="radio" id="timeRd_8" name="timeRd" value="8"/> &nbsp; 8시간  &nbsp; 
							<input type="radio" id="timeRd_4" name="timeRd" value="4"/> &nbsp; 4시간  	
						</div>
						<div class="col-md-6 d-flex align-items-start">
						 
							<select id="timeSt" style="display : inline-block;">
								<option value="0">선택</option>
								<option value="1">1시간</option>
								<option value="2">2시간</option>
								<option value="3">3시간</option>
								<option value="4">4시간</option>
								<option value="5">5시간</option>
								<option value="6">6시간</option>
								<option value="7">7시간</option>
								<option value="8">8시간</option>
								<option value="9">9시간</option>
								<option value="10">10시간</option>
								<option value="11">11시간</option>
								<option value="12">12시간</option>
							</select>
						</div>
					</div>
					</td>
				</tr>
				<tr>
					<th>근무 외 시간</th>
					<td>
						<select name="dtlCd" style="display : inline-block;">
							<option value="">없음</option>
						</select>
						
						<input name="dtlTime" type="hidden"/>
						
						<select id="dtlTimeSt" style="display : inline-block;">
							<option value="0">선택</option>
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
							<option value="6">6</option>
							<option value="7">7</option>
							<option value="8">8</option>
						</select>
						<span>시간</span>
					</td>
				</tr>
				<tr id="etcTr" style="display: show;">
					<th>
						<span>기타 사유 입력 </span>
					</th>
					<td>
						<input name="etc" type="text" style="display : inline-block; width : 90%;"/>
					</td>
				</tr>
				
				
			</tbody>
			
			
		</table>
		
		<input type="hidden" name="adminId" value="${UserSessionVO.usrId}"/>
		<input type="hidden" name="etcBikeSeq" value=""/>
		<input type="hidden" name="workSeq" value=""/>
		<input type="hidden" name="workDiv" value="3"/>
		<input type="hidden" name="centerId" value="CEN300"/>
		
	</form>
		<!-- <div class="my-2 text-left"> <button id="btnTest" class="s-btn s-btn-info s-btn-sm py-0 px-2">+</button>  <button id="btnTest2" class="s-btn s-btn-secondary s-btn-sm py-0 px-2"> - </button></div> -->
		
		
				
		<hr class="s-hr my-3">

						<form id="dispchForm">

							<div style="float: left; padding-left: 2%;">운행일자 : 
								<span class="selectDate input-datepick04">
									<input type="text" class="datepicker input-datepick04" title="선택 날짜" readonly id="vcleDate" name="vcleDate" value="" readonly/>
								</span>						
							</div>
							<div style="float: right; margin-bottom:3px; ">
								<button id="btnDispchSubmit" type="button" class="s-btn s-btn-success">저장</button>
								<button id="btnDispchUpdate" type="button" class="s-btn s-btn-success" style="display: none;">수정</button>
							</div>
							
							<table class="tb_type02">
								<colgroup>
									<col style="width:30%">
									<col style="width:23%">
									<col style="width:23%">
									<col style="width:23%">
								</colgroup>
								<thead>
									<tr>
										<th rowspan="2">차량번호</th>
										<th colspan="2">운행시간</th>
										<th rowspan="2">운행구분</th>
									</tr>
									<tr>
										<th>시작</th>
										<th>종료</th> 
									</tr>		
								</thead>	
								<tbody>
									<tr class="vcleType">
										<td rowspan="2">
											<!-- <select id="vcleNo" name="vcleNo" style="display : inline-block;"><option value=""></option></select> -->
											
											<input id="vcleName" type="text" name="vcleName"> 
											
										</td>
										<td>
											<select id="startTime" name="startTime" style="display : inline-block;"><option value=""></option></select>
										</td>
										<td>
											<select id="endTime" name="endTime" style="display : inline-block;"><option value=""></option></select>
										</td>
										<td>
											<select id="driverType" name="driverType" style="display : inline-block;">
												<option value=""></option><option value="A">운전</option><option value="B">동승</option>
											</select>
										</td>
									</tr>
									<tr class="vcleType">
										<td colspan="3">
												출고 <input name="bfMileage" type="text" style="display : inline-block; width : 60px;"/>&nbsp;<span>km</span>
												입고 <input name="afMileage" type="text" style="display : inline-block; width : 60px;"/>&nbsp;<span>km</span>&nbsp;
										</td>
									</tr>	
									<tr class="vcleType1" style="display : none;">
										<td rowspan="2">
											<select id="vcleNo1" name="vcleNo1"><option value=""></option></select>
										</td>
										<td>
											<select id="startTime1" name="startTime1"><option value=""></option></select>
										</td>
										<td>
											<select id="endTime1" name="endTime1"><option value=""></option></select>
										</td>
										<td>
											<select id="driverType1" name="driverType1">
												<option value=""></option><option value="A">운전</option><option value="B">동승</option>
											</select>
										</td>
									</tr>
									<tr class="vcleType1" style="display : none;">
										<td colspan="3">
												출고 <input name="bfMileage1" type="text" style="display : inline-block; width : 60px;"/>&nbsp;<span>km</span>
												입고 <input name="afMileage1" type="text" style="display : inline-block; width : 60px;"/>&nbsp;<span>km</span>&nbsp;
										</td>
									</tr>	
									<tr class="vcleType2" style="display : none;">
										<td rowspan="2">
											<select id="vcleNo2" name="vcleNo2" ><option value=""></option></select>
										</td>
										<td>
											<select id="startTime2" name="startTime2" ><option value=""></option></select>
										</td>
										<td>
											<select id="endTime2" name="endTime2"><option value=""></option></select>
										</td>
										<td>
											<select id="driverType2" name="driverType2">
												<option value=""></option><option value="A">운전</option><option value="B">동승</option>
											</select>
										</td>
									</tr>
									<tr class="vcleType2" style="display : none;">
										<td colspan="3">
												출고 <input name="bfMileage2" type="text" style="display : inline-block; width : 60px;"/>&nbsp;<span>km</span>
												입고 <input name="afMileage2" type="text" style="display : inline-block; width : 60px;"/>&nbsp;<span>km</span>&nbsp;
										</td>
									</tr>	
								</tbody>
							</table>
						
						<input type="hidden" name="adminId" value="${UserSessionVO.usrId}"/>
						<input type="hidden" name="vcleSeq" value=""/>
						<input type="hidden" name="vcleNo" value=""/>
							
						</form>
														
					</div>
					
</body>
<script> 
    function initDispatch(){
    	// 차량관련
    	dispatch.ajax("mainVcle");
    	// 근태등록 관련
    	workList.ajax("getCd");
		workList.ajax("mainWork");
    }		
    
    $("#driverType").change( function() {
    	if(this.value == "B") {
    		alert("출고값이 초기화 되었습니다. 다시 입력 부탁드립니다.");
    		$("#dispchDiv [name='bfMileage']").val("");
    	};
    })
    
</script>
</html>