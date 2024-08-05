<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
 
	<div class="coWorkFormDiv" id="coWorkFormDiv">
				
<!-- 		<div class="text-right my-2">
			<button id="btnCoworkSave" class="s-btn s-btn-success">저장</button>
			<button id="btnCoworkDelete" class="s-btn s-btn-success">삭제</button>
		</div> -->
								
		<form id="coWorkForm">
			<input type="hidden" name="regId" value="${UserSessionVO.usrId}">
			<input type="hidden" name="coWorkId" value="${UserSessionVO.usrId}">		<!-- 합동근무자 -->
			<input type="hidden" name="coworkInfoSeq" value="">
			<input type="hidden" name="coworkDtlSeq" value="">
			<input type="hidden" name="coworkName" value="">
			<input type="hidden" name="workCenterId" value="${UserSessionVO.centerId}">
		
		<table class="tb_type02" id="coWorkDiv">
			<colgroup>
				<col style="width:20%">
				<col style="width:60%">
				<col style="width:20%"> 
			</colgroup>
			<thead>
				<tr>
					<th>작업시간</th>
					<th>작업명칭</th>
					<th>참가여부</th>
				</tr>	
			</thead>
			<tbody id="coWorkDynamicTbody">
				
				<!-- 
				<tr>
					<th class="top" style="text-align:center">
						<span><label for="workFrHour">시작시간</label></span>
					</th>
					<td class="top">
						<select id="workFrHour" name="workFrHour" style="display : inline-block;"><option value=""></option></select>
					</td>
					<th class="top" style="text-align:center">
						<span><label for="workToHour">종료시간</label></span>
					</th>
					<td class="top">
						 <select id="workToHour" name="workToHour" style="display : inline-block;"><option value=""></option></select>
					</td>
				</tr>
				<tr>
					<th>작업</th>
					<td>
						<div class="row">
							<div class="col-md-6 d-flex align-items-start">
								<select id="workType" name="workType" style="display : inline-block;">
									<option value="">선택</option>
									<option value="Cd1">상차</option>
									<option value="Cd2">하차</option>
									<option value="Cd9">기타</option>
								</select>
							</div>
						</div>
					</td>
					<th>
						<span>자전거</span>
					</th>
					<td>
						<input name="bikeCnt" placeholder="수량입력" type="text" onKeyup="this.value=this.value.replace(/[^-0-9]/g,'');" style="display : inline-block; width : 85%;"/>대
					</td>
				</tr>	
				<tr>
					<th>작업내용</th>
					<td colspan="3"><input name="workDtl" type="text" style="display : inline-block; width : 90%;"/></td>
				</tr>
				<tr>
					<th>참여인원</th>
					<td colspan="3"><input name="workCnt" type="text" readonly="readonly"></input></td>
				</tr>
				<tr>
					<th>참여</th>
					<td colspan="3">
						<button id="btnWrkerAdd" type="button" style="color: #fff; background-color: #28a745; border: solid; border-color: #28a745; padding: 1px;">신청</button>
						<button id="btnWrkerMemDelete" type="button" style="color: #fff; background-color: #28a745; border: solid; border-color: #28a745; padding: 1px;">취소</button>
					
					</td>
				</tr> -->
				 
				</tbody>
					
			</table>
				
			<input type="hidden" name="adminId" value="${UserSessionVO.usrId}"/>

			</form>

			</div>
			
			<div name="msmvBikeListDiv" id="msmvBikeListDiv" style="display:none;">
				조회영역
			</div>
			
		