<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<script type="text/javascript">
	
	$(".ui-date-wrap").remove();
	
	var diaryList = {inited:false};
		
	function initDiary() {
		
		if( diaryList.inited  == false ) {
			diaryList.btnInit();
			diaryList.inited = true;
		}
		
		diaryList.init();
	}
	
	diaryList.init = function(){
		this.ajax("getDiary");
	}
	
	diaryList.list = null;
	
	diaryList.ajax = function(data){
		if(data === "getDiary"){
			
	    	$.ajax({ 
				url: "getDistributionDiaryAjax.do",
				type: "post",
				async: false,
				data : $("#diaryDiv #formDiary").serialize(),
				success: function(data){
					 
					var distInfoVO = data.distInfo[0];
					/*********** 주요실적 **********/
					var searchCondition = data.searchCondition;
					if( searchCondition ){
						$("#diaryDiv input[name='adminId']").val(searchCondition.adminId);
						$("#diaryDiv input[name='searchDate']").val(searchCondition.searchDate);
					}
					
					console.table( distInfoVO );
					
					/********** 주요실적 **********/
					if(distInfoVO){
						console.log( "distInfoVO.onSiteActionCnt : " + distInfoVO.onSiteActionCnt)
						$("#diaryDiv .onSiteActionCnt").text(distInfoVO.onSiteActionCnt);
						$("#diaryDiv .bikeRobbedCnt").text  (distInfoVO.bikeRobbedCnt)  ;
						$("#diaryDiv .warehousingCnt").text  (distInfoVO.warehousingCnt)  ;
						$("#diaryDiv .darTp006Cnt").text (distInfoVO.darTp006Cnt) ;
						$("#diaryDiv .darTp007Cnt").text (distInfoVO.darTp007Cnt) ;
						$("#diaryDiv .darTp008Cnt").text (distInfoVO.darTp008Cnt) ;
						$("#diaryDiv .darTp009Cnt").text (distInfoVO.darTp009Cnt) ;
						$("#diaryDiv .adminName").text      (distInfoVO.adminName) ;
						$("#diaryDiv .afMileage").text      (distInfoVO.afMileage)      ;
						$("#diaryDiv .bfMileage").text      (distInfoVO.bfMileage)      ;
						$("#diaryDiv .vcleNo").text         (distInfoVO.vcleNo)         ;
						$("#diaryDiv .teamName").text(distInfoVO.teamName);
						$("#diaryDiv .centerName").text(distInfoVO.centerName);
					}
					
					// 차량번호 세팅
					$("form[name='formDiary'] select[name='searchVcleNo'] option").not("[value='ALL']").remove();
					for(var i =0; i< data.distInfoVclList.length; i++){
						$("#diaryDiv #searchVcleNo").append("<option value='"+ data.distInfoVclList[i].vcleNo +"'>"+ data.distInfoVclList[i].vcleNo +"</option>");
					}
					if( searchCondition.searchVcleNo != "" ) {	
						$("#diaryDiv #searchVcleNo").val(searchCondition.searchVcleNo);
					}	
					/********** 분배목록 **********/
					var moveCnt = 0;
					var relocateCnt = 0;
					var onSiteActionCnt = 0;
					var warehousingCnt = 0;
					var darTp006Cnt = 0;
					if( data.distList ){
						var html = "";
						for(key in data.distList){
							
							var workTimeDesc = "";
							switch(  data.distList[key].workTime ){
							case "50" :
								workTimeDesc = "공동작업";
								break;
							case "99" :
								workTimeDesc = "수기등록";
								break;
								default :
									workTimeDesc = data.distList[key].workTime;
							}
							
						 	html += '<tr>';
							html += '<td>'+nvl(data.distList[key].stationNo,'')+'</td>';
							html += '<td>'+data.distList[key].vcleNo+'</td>';
							html += '<td>'+workTimeDesc+'</td>';
							html += '<td>'+data.distList[key].etc+'</td>';
							html += '<td>'+data.distList[key].moveCnt+'</td>';
							html += '<td>'+data.distList[key].relocateCnt+'</td>';
							html += '</tr>';
							
							moveCnt     = moveCnt + parseFloat( data.distList[key].moveCnt);
							relocateCnt = relocateCnt + parseFloat( data.distList[key].relocateCnt);
							/*
							onSiteActionCnt = data.distList[key].onSiteActionCnt;
							warehousingCnt = data.distList[key].warehousingCnt;
							darTp006Cnt  = data.distList[key].darTp006Cnt;
							*/
						}
						
						$("#diaryDiv #dynamicTbody").empty();
						$("#diaryDiv #dynamicTbody").append(html);
					}
					
					diaryList.list = data.distList;
					
					// 주요실적 설정
					  $("#diaryDiv .bikeReplaceCnt").text (relocateCnt) ;
					$("#diaryDiv .bikeMoveCnt").text    (moveCnt) ;
					/*
					$("#diaryDiv .onSiteActionCnt").text(onSiteActionCnt);
					$("#diaryDiv .warehousingCnt").text  (warehousingCnt)  ;
					$("#diaryDiv .darTp006Cnt").text (darTp006Cnt) ; */
					
					// 초기화
					$("#diaryDiv [name='modifyDate']").val(0);
				},
				error : function(data){
					alert("분배일지 조회에 실패했습니다.");
				}
	    	});
			
		}
		
	}
	
	diaryList.btnInit = function(){
		
		$("#diaryDiv #btnSearchDatePrev").css("cursor","pointer");
		$("#diaryDiv #btnSearchDateNext").css("cursor","pointer");
		 
		$("#diaryDiv #btnSearchDatePrev").on("click",function(e){
			$("#diaryDiv [name='modifyDate']").val(-1);
			// $("#searchVcleNo").empty();
			diaryList.mSubmit();
		});
		
		$("#diaryDiv #btnSearchDateNext").on("click",function(e){
			$("[name='modifyDate']").val(1);
			// $("#searchVcleNo").empty();
			diaryList.mSubmit();
		});
		
		$("#diaryDiv [name='searchVcleNo']").change(function(e){
			
			var html = "";
			var moveCnt = 0;
			var relocateCnt = 0;
			
			for(key in diaryList.list){
				if( diaryList.list[key].vcleNo == this.value ) {
				 	html += '<tr>';
					html += '<td>'+diaryList.list[key].stationNo+'</td>';
					html += '<td>'+diaryList.list[key].vcleNo+'</td>';
					html += '<td>'+diaryList.list[key].workTime+'</td>';
					html += '<td>'+diaryList.list[key].etc+'</td>';
					html += '<td>'+diaryList.list[key].moveCnt+'</td>';
					html += '<td>'+diaryList.list[key].relocateCnt+'</td>';
					html += '</tr>';
					
					moveCnt     += parseInt(diaryList.list[key].moveCnt);
					relocateCnt += parseInt(diaryList.list[key].relocateCnt);
					
				} else if  ( this.value == "ALL" ) {
					html += '<tr>';
					html += '<td>'+diaryList.list[key].stationNo+'</td>';
					html += '<td>'+diaryList.list[key].vcleNo+'</td>';
					html += '<td>'+diaryList.list[key].workTime+'</td>';
					html += '<td>'+diaryList.list[key].etc+'</td>';
					html += '<td>'+diaryList.list[key].moveCnt+'</td>';
					html += '<td>'+diaryList.list[key].relocateCnt+'</td>';
					html += '</tr>';
					
					moveCnt     += parseInt(diaryList.list[key].moveCnt);
					relocateCnt += parseInt(diaryList.list[key].relocateCnt);
				}
			}
			
			$("#diaryDiv #dynamicTbody").empty();
			$("#diaryDiv #dynamicTbody").append(html);
			
			// 주요실적 설정
			$("#diaryDiv .bikeReplaceCnt").text (moveCnt) ;
			$("#diaryDiv .bikeMoveCnt").text    (relocateCnt) ;
			
		})
	}
	
	diaryList.mSubmit = function(){
		this.init();
	}
	 
</script>
</head>
<body>
		<div name="diaryDiv" id="diaryDiv" >
			<form id="formDiary" name="formDiary">
				<input type="hidden" name="adminId" value="${searchCondition.adminId }" />
				  <!-- <input type="hidden" name="adminId" value=lth1903 /> --> 
				<input type="hidden" name="modifyDate" value="0" />
			  
				<div style="float: left; padding-left: 2%; margin-bottom:10px">
					<span>일자 : </span>
					<span id="btnSearchDatePrev">←</span>
					<span class="selectDate">
						<input type="text" name="searchDate" size="10" title="선택 날짜" value="${searchCondition.searchDate}" id="searchDate" readonly />
					</span>
					<span id="btnSearchDateNext"> → </span>
				</div>
				<div style="float: right; padding-left: 2%; margin-bottom:10px">
					차량번호 : <select id="searchVcleNo" name="searchVcleNo" style="display : inline-block;">
								<option value="ALL">전체조회</option>
					</select>
				</div>	
			</form>
			
			<table id="tableDistInfo" class="tb_type03">
				<colgroup>
					<col style="width:13%">
					<col style="width:13%">
					<col style="width:13%">
					<col style="width:13%">
					<col style="width:13%">
					<col style="width:13%">
					<col style="width:22%">
				</colgroup>
				<thead>
					<tr>
						<th class="top text-center">센터</th>
						<td class="top text-center" colspan="2">
							<span class="centerName"></span>
						</td>
						<th class="top text-center">팀</th>
						<td class="top text-center">
							<span class="teamName"></span>
						</td>
						<th class="top text-center">이름</th>
						<td class="top text-center" colspan="2">
							<span class="adminName"></span>
						</td>
					</tr>
					<tr>
						<th class="text-center">차량번호</th>
						<td class="text-center" colspan="2">
							<span class="vcleNo"></span>
						</td>
						<th class="text-center">주행거리(전)</th>
						<td class="text-center">
							<span class="bfMileage"></span>
						</td>
						<th class="text-center">주행거리(후)</th>
						<td class="text-center" colspan="2">
							<span class="afMileage"></span>
						</td>
					</tr>
				</thead>	
			</table>
			
			<h2 style="font-weight: bold; margin-top: 5px; margin-bottom: 5px;">주요실적</h2>
			
			<table id="tableMainPerf" class="tb_type03">
				<colgroup>
					<col style="width:10%">
					<col style="width:10%">
					<col style="width:10%">
					<col style="width:10%">
					<col style="width:10%">
					<col style="width:10%">
				</colgroup>
				<thead>
					<tr>
						<th class="text-center">자전거이동</th>
						<td class="text-center"><span class="bikeMoveCnt"></span></td>
						<th class="text-center">재배치</th>
						<td class="text-center"><span class="bikeReplaceCnt"></span></td>
						<th class="text-center">강반/방치</th>
						<td class="text-center"><span class="darTp006Cnt"></span></td>
					</tr>
					<tr>
						<th class="top text-center">경정비</th>
						<td class="top text-center"><span class="onSiteActionCnt"></span></td>
						<th class="top text-center">입고</th>
						<td class="top text-center"><span class="warehousingCnt"></span>
						<th class="top text-center">고장처리</th>
						<td class="top text-center"><span class="bikeRobbedCnt"></span></td>
					</tr>
					<!-- <tr>
						<th class="text-center">방치</th>
						<td class="text-center"><span class="darTp007Cnt"></span></td>
						<th class="text-center">고장</th>
						<td class="text-center"><span class="darTp008Cnt"></span></td>
						<th class="text-center">회수</th>
						<td class="text-center"><span class="darTp009Cnt"></span></td>
					</tr> -->
				</thead>	 
			</table>
			
			<h2 style="font-weight: bold; margin-top: 5px; margin-bottom: 5px;">분배목록</h2>
			
			<table id="tableDistList" class="tb_type03">
				<colgroup>
					<col style="width:20%">
					<col style="width:20%">
					<col style="width:10%">
					<col style="width:10%">
					<col style="width:20%">
					<col style="width:20%">
				</colgroup>
				<thead>
					<tr>
						<th class="top text-center">대여소번호</th>
						<th class="top text-center">차량번호</th>
						<th class="top text-center">시간</th>
						<th class="top text-center">협업건수</th>
						<th class="top text-center">이동건수</th>
						<th class="top text-center">배치건수</th>
					</tr>
				</thead>
				<tbody id="dynamicTbody"></tbody>
			</table>
			
		</div>
	</body>
</html>