<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">



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
				url: "/getRoundDiaryAjax.do",
				type: "post",
				async: false,
				data : $("#diaryDiv #formDiary").serialize(),
				success: function(data){
					 var searchCondition = data.searchCondition;
					 if( searchCondition ){
						$("#diaryDiv input[name='adminId']").val(searchCondition.adminId);
						$("#diaryDiv input[name='searchDate']").val(searchCondition.searchDate);
					 }
					/********** 분배목록 **********/
					var DEV_003 = 0, DEV_004 = 0, DEV_006 = 0, DEV_007 = 0, DEV_008 = 0, DEV_009 = 0;
										
					if( data.distList ){
						var html = "";
						for(key in data.distList){
							 
						 	html += '<tr>';
							html += '<td>'+nvl(data.distList[key].stationName,'')+'</td>';
							html += '<td>'+data.distList[key].regDttm+'</td>';
							html += '<td>'+data.distList[key].repairMain+'</td>';
							html += '<td>'+data.distList[key].repairType+'</td>';
							html += '<td>'+data.distList[key].repairName+'</td>';
							html += '</tr>';
							
							switch( data.distList[key].repairClsCd.substr(0,3) ){
							
							case "R01" :	DEV_003++;	break; 
							case "R02" :	DEV_004++;	break; 
							case "R03" :	DEV_006++;	break; 
							case "R04" :	DEV_007++;	break; 
							case "R05" :	DEV_008++;	break; 
							case "R06" :	DEV_009++;	break; 
							}
						}
						$("#diaryDiv #dynamicTbody").empty();
						$("#diaryDiv #dynamicTbody").append(html);
						
						$("#diaryDiv .DEV_003").text (DEV_003) ;
						$("#diaryDiv .DEV_004").text (DEV_004) ;
						$("#diaryDiv .DEV_006").text (DEV_006) ;
						$("#diaryDiv .DEV_007").text (DEV_007) ;
						$("#diaryDiv .DEV_008").text (DEV_008) ;
						$("#diaryDiv .DEV_009").text (DEV_009) ;
					}
					
					diaryList.list = data.distList;
					 
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
			<input type="hidden" name="modifyDate" value="0" />
			  
				<%-- <div style="float: left; padding-left: 2%; margin-bottom:10px">
					<span>일자 : </span>
					<span id="btnSearchDatePrev">←</span>
					<span class="selectDate">
						<input type="text" name="searchDate" size="10" title="선택 날짜" value="${searchCondition.searchDate}" id="searchDate" readonly />
					</span>
					<span id="btnSearchDateNext"> → </span>
				</div> --%>
			</form>
			<br/>	
			<div>
				<h2 style="margin-top: -30px">주요실적</h2>
				
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
							<th class="text-center">비콘</th>
							<td class="text-center"><span class="DEV_003"></span></td>
							<th class="text-center">거치대</th>
							<td class="text-center"><span class="DEV_004"></span></td>
							<th class="text-center">AP</th>
							<td class="text-center"><span class="DEV_006"></span></td>
						</tr>
						<tr>
							<th class="top text-center">안내간판</th>
							<td class="top text-center"><span class="DEV_007"></span></td>
							<th class="top text-center">수리공구대</th>
							<td class="top text-center"><span class="DEV_008"></span>
							<th class="top text-center">기타</th>
							<td class="top text-center"><span class="DEV_009"></span></td>
						</tr>
					</thead>	 
				</table>
				
				<h2>작업목록</h2>
				
				<table id="tableDistList" class="tb_type03">
					<colgroup>
						<col style="width:20%">
						<col style="width:10%">
						<col style="width:10%">
						<col style="width:10%">
						<col style="width:20%">
					</colgroup>
					<thead>
						<tr>
							<th class="top text-center">대여소번호</th>
							<th class="top text-center">시간</th>
							<th class="top text-center">종류</th>
							<th class="top text-center">작업구분</th>
							<th class="top text-center">작업상세내용</th>
						</tr>
					</thead>
					<tbody id="dynamicTbody"></tbody>
				</table>
			</div>
		</div>
	</body>
</html>