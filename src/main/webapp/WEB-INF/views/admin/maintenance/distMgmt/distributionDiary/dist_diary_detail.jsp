<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
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
						
						<div name="diaryDiv" id="diaryDiv" style="margin-top: 10px;">
						
							<form id="formDiary">
								<input type="hidden" name="adminId" value="${searchCondition.adminId }" />
								<input type="hidden" name="modifyDate" value="0" />

							
								<div style="text-align: left; padding-left: 2%;">
									<span style="position: relative; bottom: 4.5px;">일자 : </span>
									
									<span>
										<svg id="btnSearchDatePrev" xmlns="http://www.w3.org/2000/svg" width="40" height="20" fill="currentColor" class="bi bi-arrow-left" viewBox="2 0 16 16">
	  										<path fill-rule="evenodd" d="M15 8a.5.5 0 0 0-.5-.5H2.707l3.147-3.146a.5.5 0 1 0-.708-.708l-4 4a.5.5 0 0 0 0 .708l4 4a.5.5 0 0 0 .708-.708L2.707 8.5H14.5A.5.5 0 0 0 15 8z"/>
										</svg>	
									</span>
									<span class="selectDate input-datepick04" style="position: relative; bottom: 4.5px;">
										<input type="text" class="datepicker input-datepick04" name="searchDate" title="선택 날짜" value="${searchCondition.searchDate}" id="searchDate" readonly />
									</span>
									<span>
										<svg id="btnSearchDateNext" xmlns="http://www.w3.org/2000/svg" width="40" height="20" fill="currentColor" class="bi bi-arrow-right" viewBox="0 0 16 16">
	  										<path fill-rule="evenodd" d="M1 8a.5.5 0 0 1 .5-.5h11.793l-3.147-3.146a.5.5 0 0 1 .708-.708l4 4a.5.5 0 0 1 0 .708l-4 4a.5.5 0 0 1-.708-.708L13.293 8.5H1.5A.5.5 0 0 1 1 8z"/>
										</svg>
									</span>
								</div>
								
							</form>
							<table id="tableDistInfo" class="tb_type03">
								<colgroup>
									<col style="width:10%">
									<col style="width:10%">
									<col style="width:10%">
									<col style="width:10%">
									<col style="width:10%">
									<col style="width:10%">
									<col style="width:10%">
									<col style="width:10%">
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
											<span class="afMileage"></span>&nbsp; 
											전&nbsp;<span class="bfMileage"></span>&nbsp;
											후&nbsp;<span class="afMileage"></span>
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
									<col style="width:10%">
									<col style="width:10%">
								</colgroup>
								<thead>
									<tr>
										<th class="top text-center">경정비</th>
										<td class="top text-center">3</td>
										<th class="top text-center">자전거없음</th>
										<td class="top text-center">2</td>
										<td class="top text-center" style="border-bottom: 0px;"></td>
										<th class="top text-center">입고</th>
										<td class="top text-center" colspan="2">3</td>
									</tr>
									<tr>
										<th class="text-center">자전거이동</th>
										<td class="text-center">3</td>
										<th class="text-center">재배치</th>
										<td class="text-center">3</td>
										<td class="text-center" colspan="4" style="border: 0px;"></td>
									</tr>
								</thead>	
							</table>
							<h2 style="font-weight: bold; margin-top: 5px; margin-bottom: 5px;">분배목록</h2>
							  
							
						</div>	
						
					</div>
				</div>
				<!--content E-->
			</div>
		</div>
		<!--footer S-->
			<tiles:insertAttribute name="footer" />
		<!--footer E-->
	</div>
	
	<script type="text/javascript" src="/js/common_barocle.js"></script>
	
    <script type="text/javascript">
    
    $(function() {
    	
    	diaryList.init();
    	diaryList.btnInit();
		
	});
    
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
    				
    				
    				if(!distInfoVO){
    				}else{
    					
	    				var distInfoKeys = Object.getOwnPropertyNames(distInfoVO);
    					
    					$("#tableDistInfo td").each(function(idx,item){
    						
    						$(item).find("*").each(function(i, el){
    							
    							var className = $(el).attr('class');
    							
    							for(var i =0; i <distInfoKeys.length; i++){
    								
    								var key = distInfoKeys[i];
    								
    								if(key === className){
    									
    									if(!distInfoVO[key]){
    									}else{
    										
    										$(el).text("");
    										$(el).text(distInfoVO[key]);
    										
    									}
    								}
    								
    							}
    							
    						})
    						
    						
    					});
    					
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
   		
   		/* datepicker 설정 S */
   		var options = $(".datepicker").datepicker('option','all');
   		
   		options.maxDate = new Date();
   		
   		$(".datepicker").datepicker('option',options);
   		
   		$("#ui-datepicker-div").toggle();
   		
   		/* datepicker 설정 E */
   		
   		$("[name='searchDate']").change(function(){
   			
   			$("[name='modifyDate']").val(0);
   			
   			$("#formDiary").attr({method :"post", action :"/viewDistributionDiary.do"}).submit();
   			
   		})
   		
    	if('${searchCondition.searchDate}' === todayFmt){//검색날짜가 당일이라면 다음버튼 효과제거
    		
    		$("#btnSearchDateNext").css("display","none");    			
    	}
    	
    	$("#btnSearchDatePrev").click(function(){
    		
			$("[name='modifyDate']").val(-1);
			
			$("#formDiary").attr({method :"post", action :"/viewDistributionDiary.do"}).submit();
    		
    	});
    	
    	$("#btnSearchDateNext").click(function(){
    		
			$("[name='modifyDate']").val(1);
			
			$("#formDiary").attr({method :"post", action :"/viewDistributionDiary.do"}).submit();
    		
    	});
    	
    	
    }
    
    
    </script>
</body>
</html>