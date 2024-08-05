<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<script type="text/javascript">
	
	$(".ui-date-wrap").remove();
	
	function initDiary(){
		diaryList.init();
		diaryList.btnInit();
	}
	var diaryList = {};
	diaryList.init = function(){
		this.ajax("getDiary");
	}
	diaryList.ajax = function(data){
		if(data === "getDiary"){
	    	$.ajax({
				url: "getDistributionDiaryAjax.do",
				type: "post",
				async: false,
				data : $("#formDiary").serialize(),
				success: function(data){
					var distInfoVO = data.distInfoVO;
					/*********** 주요실적 **********/
					var searchCondition = data.searchCondition;
					if( searchCondition ){
						$("input[name='adminId']").val(searchCondition.adminId);
						$("input[name='searchDate']").val(searchCondition.searchDate);
					}
					/********** 주요실적 **********/
					if(distInfoVO){
						$(".onSiteActionCnt").text(distInfoVO.onSiteActionCnt);
						$(".bikeRobbedCnt").text  (distInfoVO.bikeRobbedCnt)  ;
						$(".warehousingCnt").text (distInfoVO.warehousingCnt) ;
						$(".bikeReplaceCnt").text (distInfoVO.bikeReplaceCnt) ;
						$(".bikeMoveCnt").text    (distInfoVO.bikeMoveCnt) ;
						$(".adminName").text      (distInfoVO.adminName) ;

						$(".afMileage").text      (distInfoVO.afMileage)      ;
						$(".bfMileage").text      (distInfoVO.bfMileage)      ;
						$(".refuel").text         (distInfoVO.refuel)         ;
						$(".vcleNo").text         (distInfoVO.vcleNo)         ;
						$(".teamName").text       (distInfoVO.teamName)       ;
						$(".centerName").text     (distInfoVO.centerName)       ;
					}
					/********** 분배목록 **********/
					if( data.distList ){
						var html = "";
						for(key in data.distList){
							
						 	html += '<tr>';
							html += '<td>'+data.distList[key].workTime+'</td>';
							html += '<td>'+data.distList[key].workPlace+'</td>';
							html += '<td>'+data.distList[key].workClassifi+'</td>';
							html += '<td>'+data.distList[key].bikeNo+'</td>';
							html += '<td>'+data.distList[key].etc+'</td>';
							html += '</tr>';	
						}
						$("#dynamicTbody").empty();
						$("#dynamicTbody").append(html);
					}
				},
				error : function(data){
					alert("분배일지 조회에 실패했습니다.");
				}
	    	});
			
		}
	}
	diaryList.btnInit = function(){
		var today = new Date();
		var dd = today.getDate();
		var mm = today.getMonth()+1; //January is 0!
		var yyyy = today.getFullYear();
		var todayFmt = yyyy+"-"+mm+"-"+dd;
		$("#btnSearchDatePrev").css("cursor","pointer");
		$("#btnSearchDateNext").css("cursor","pointer");
		/* $("#btnSearchDateNext").css("display",""); */
		/* datepicker 설정 S */
		/* var options = $(".datepicker").datepicker('option','all');
		options.maxDate = new Date();
		$(".datepicker").datepicker('option',options);
		$("#ui-datepicker-div").toggle(); */
		/* datepicker 설정 E */
		$("[name='searchDate']").change(function(){
			$("[name='modifyDate']").val(0);
			diaryList.mSubmit();
		})
		
/* 		if($("#formDiary [name='searchDate']").val() === todayFmt){//검색날짜가 당일이라면 다음버튼 효과제거
			$("#btnSearchDateNext").css("display","none");    			
		} */
		
		$("#btnSearchDatePrev").on("click",function(e){
	
			$("[name='modifyDate']").val(-1);
			//$("#formDiary").attr({method :"post", action :"/viewDistributionDiary.do"}).submit(); : 기존 관리자 페이지용
			diaryList.mSubmit();
			
		});
		
		$("#btnSearchDateNext").on("click",function(e){
			
			$("[name='modifyDate']").val(1);
			//$("#formDiary").attr({method :"post", action :"/viewDistributionDiary.do"}).submit(); : 기존 관리자 페이지용
			
			diaryList.mSubmit();
			
		});
		
	}
	
	diaryList.mSubmit = function(){
		
		var today = new Date();
		var dd = today.getDate();
		var mm = today.getMonth()+1; //January is 0!
		var yyyy = today.getFullYear();
		
		var todayFmt = yyyy+"-"+mm+"-"+dd;
		
		this.init();
		/* 
		$("#btnSearchDateNext").css("display","show");
		
		if($("#formDiary [name='searchDate']").val() === todayFmt){
			$("#btnSearchDateNext").css("display","none");    			
		}
		 */
	}
	 
</script>
</head>
<body>
						<div name="diaryDiv" id="diaryDiv" >
							<form id="formDiary">
								<input type="hidden" name="adminId" value="${searchCondition.adminId }" />
								<input type="hidden" name="modifyDate" value="0" />
							
								<div style="text-align: left; padding-left: 2%; margin-bottom:10px">
									<span>일자 : </span>
									<span id="btnSearchDatePrev">←</span>
									<span class="selectDate">
										<input type="text" name="searchDate" size="10" title="선택 날짜" value="${searchCondition.searchDate}" id="searchDate" readonly />
									</span>
									<span id="btnSearchDateNext"> → </span>
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
										<th class="text-center">주유량</th>
										<td class="text-center">
											<span class="refuel"></span>
										</td>
										<th class="text-center">주행거리</th>
										<td class="text-center" colspan="2">
											전 : &nbsp;<span class="bfMileage"></span><br/>후 : &nbsp;<span class="afMileage"></span>
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
										<th class="top text-center">경정비</th>
										<td class="top text-center"><span class="onSiteActionCnt"></span></td>
										<th class="top text-center">자전거없음</th>
										<td class="top text-center"><span class="bikeRobbedCnt"></span></td>
										<th class="top text-center">입고</th>
										<td class="top text-center"><span class="warehousingCnt"></span></td>
									</tr>
									<tr>
										<th class="text-center">자전거이동</th>
										<td class="text-center"><span class="bikeMoveCnt"></span></td>
										<th class="text-center">재배치</th>
										<td class="text-center"><span class="bikeReplaceCnt"></span></td>
										<th class="text-center">기타</th>
										<td class="text-center"><span class="etcCnt"></span></td>
									</tr>
								</thead>	
							</table>
							
							<h2 style="font-weight: bold; margin-top: 5px; margin-bottom: 5px;">분배목록</h2>
							
							<table id="tableDistList" class="tb_type03">
								<colgroup>
									<col style="width:20%">
									<col style="width:20%">
									<col style="width:20%">
									<col style="width:20%">
									<col style="width:20%">
								</colgroup>
								<thead>
									<tr>
										<th class="top text-center">작업시간</th>
										<th class="top text-center">작업장소</th>
										<th class="top text-center">작업구분</th>
										<th class="top text-center">자전거번호</th>
										<th class="top text-center">비고</th>
									</tr>
								</thead>
								<tbody id="dynamicTbody"></tbody>
							</table>
							
						</div>
	</body>
</html>