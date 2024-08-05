<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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

<style type="text/css">
	h2 {
		font-size: x-large;
		margin-top: 40px; margin-bottom: 20px;
	}
	.text-right {
		text-align: right;
	}
	
	input:-moz-read-write {background-color: yellow;}   /* Firefox */
	input:read-write {background-color: yellow;}
	input:-moz-read-only {background-color: pink;}      /* Firefox */
	input:read-only {background-color: pink; } 
	input[readonly], select[readonly], textarea[readonly] {
		background-color: white !important;
		border-color: white;
		text-align: right;
		font-size: 100%;
	}
</style>
<script type="text/javascript" src="/js/common_barocle.js?ver=0403"></script>
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
                <tiles:insertAttribute name="left"  />
                <!--left menu E-->
				<!--conteent S-->
				<div class="content">
					<div class="subject">
                        <!--subject path S-->
                        <tiles:insertAttribute name="subject" />
                        <!--subject path E-->
                    </div>
					 <!--검색조건 S-->
				
<form id="updateForm">	
	<input type="hidden" name="regType" id="regType"/>
					  
			          <h2>□ 전월 자전거 이용통계<span id="lowExplorer" style="font-size:medium;font-weight: normal;color:grey;display: none">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;※ 본 페이지는 크롬버전에 최적화되어있습니다.</span></h2>
			          <table class="tb_type01" id="annualBikeUse">
			             <colgroup>
			                 <col style="width:15%"/>
			                 <col style="width:15%"/>
			                 <col style="width:15%"/>
			                 <col style="width:15%"/>
			                 <col style="width:15%"/>
			                 <col style="width:15%"/>
			             </colgroup>
			               <thead>
			                 <tr>
			                     <th colspan="2">구분</th>
			                     <th>${dataList.label04_90}</th>
			                     <th>${dataList.label04_91}</th>
			                     <th>증감(건)</th>
			                     <th>증감율(%)</th>
			                 </tr>
			             </thead>
			             <tbody>
			                 <tr>
 								 <td rowspan="4">대여건수(건)</td>
 								 <td>정기권</td>
			                     <td class="text-right">${dataList.label03_01}</td>
			                     <td class="text-right">${dataList.label03_02}</td>
			                     <td class="text-right">${dataList.label03_03}</td>
			                     <td class="text-right">${dataList.label03_04}</td>
			                 </tr>
			                  <tr>
 								 <td>일일권</td>
			                     <td class="text-right">${dataList.label03_05}</td>
			                     <td class="text-right">${dataList.label03_06}</td>
			                     <td class="text-right">${dataList.label03_07}</td>
			                     <td class="text-right">${dataList.label03_08}</td>
			               	</tr>	
			               	 <tr  style="font-weight: bold;">
 								 <td>합계</td>
			                     <td class="text-right">${dataList.label03_09}</td>
			                     <td class="text-right">${dataList.label03_10}</td>
			                     <td class="text-right">${dataList.label03_11}</td>
			                     <td class="text-right">${dataList.label03_12}</td>
			               	</tr>		
			               	 <tr>
 								 <td>일평균</td>
			                     <td class="text-right">${dataList.label03_13}</td>
			                     <td class="text-right">${dataList.label03_14}</td>
			                     <td class="text-right">${dataList.label03_15}</td>
			                     <td class="text-right">${dataList.label03_16}</td>
			               	</tr>	
			               	<tr>
 								 <td rowspan="3">판매금액(천원)</td>
 								 <td>정기권</td>
			                     <td class="text-right">${dataList.label04_01}</td>
			                     <td class="text-right">${dataList.label04_02}</td>
			                     <td class="text-right">${dataList.label04_03}</td>
			                     <td class="text-right">${dataList.label04_04}</td>
			                 </tr>
			                  <tr>
 								 <td>일일권</td>
			                     <td class="text-right">${dataList.label04_05}</td>
			                     <td class="text-right">${dataList.label04_06}</td>
			                     <td class="text-right">${dataList.label04_07}</td>
			                     <td class="text-right">${dataList.label04_08}</td>
			               	</tr>	
			               	<tr style="font-weight: bold;">
 								 <td>합계</td>
			                     <td class="text-right">${dataList.label04_09}</td>
			                     <td class="text-right">${dataList.label04_10}</td>
			                     <td class="text-right">${dataList.label04_11}</td>
			                     <td class="text-right">${dataList.label04_12}</td>
			               	</tr>
			               	<tr>
 								 <td colspan="2">평균 이동거리(km/통행)</td>
			                     <td class="text-right">${dataList.label05_01}</td>
			                     <td class="text-right">${dataList.label05_02}</td>
			                     <td class="text-right">${dataList.label05_03}</td>
			                     <td class="text-right">${dataList.label05_04}</td>
			               	</tr>
			               	<tr>
 								 <td colspan="2">평균 이용시간(분/통행)</td>
			                     <td class="text-right">${dataList.label05_11}</td>
			                     <td class="text-right">${dataList.label05_12}</td>
			                     <td class="text-right">${dataList.label05_13}</td>
			                     <td class="text-right">${dataList.label05_14}</td>
			               	</tr>	     
			               </tbody>
			           </table>						 
					 
					 
			          <h2>□ 연도별 동기 누적 이용통계 추이( ${dataList.label06_99} )
			          </h2>
			          <div id="chart_div" style="width: 800px; height: 350px;"></div>			 
					 
					 <h2>□ 자전거 운영현황<input type="text" name="label01_07" id="label01_07" value='${fn:escapeXml(dataList.label01_07)}' class="read-only" readonly style="width:170px;text-align: center; font-size:medium;"></span>
					 	<span class="right">  
							<a href='javascript:void(0);' onclick="showPopup1()" class="btnType01" style="display: none" id="changeLink1">변경</a>
							<a href='javascript:void(0);' onclick="formSave(1)" class="btnType01" style="display: none" id="saveLink1">저장</a>
						</span>
					 </h2>
					 
			         <table class="tb_type01">
			             <colgroup>
			                 <col style="width:34%"/>
			                 <col style="width:34%"/>
			                 <col style="width:32%"/>
			             </colgroup>
			             <thead>
			                 <tr>
			                     <th>총괄현황</th>
			                     <th>실시간현황</th>
			                     <th>비고</th>
			                 </tr>
			             </thead>
			             <tbody>
			                 <tr>
			                     <td class="title">
			                        <div class="statulist" style="line-height: 30px;">
			                            <p style="font-size: large; font-weight: bold;">자전거(A) : <span>총 
			                            	<input style="width: 70px;" type="text" name="label01_01" id="label01_01" value='${dataList.label01_01}' class="read-only" readonly	onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">대</span></p>
			                            <p>┌&nbsp;&nbsp;입고예정(B) : <span> <input style="width: 70px;" type="text" name="label01_02" id="label01_02" value='${dataList.label01_02}' class="read-only" readonly
			                            	onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">대</span></p>
			                            <p>└&nbsp;&nbsp;폐기예정(C) : <span> <input style="width: 70px;" type="text" name="label01_03" id="label01_03" value='${dataList.label01_03}' class="read-only" readonly
			                            	onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">대</span></p>
			                         </div>
			                     </td>   
			                     <td class="title"  style="line-height: 30px;vertical-align: middle;">
			                     	<div class="statulist" style="line-height: 30px;">
			                            <p style="font-size: large; font-weight: bold;">현장 배치 : <span> ${dataList.label02_06}대</span></p>
			                            <p>&nbsp;&nbsp;- 대여대기(E) :  <span>${dataList.label02_01}대</span> </p>
			                            <p>&nbsp;&nbsp;- 정상대여중 (F) : <span> ${dataList.label02_02}대</span></p>
			                            <p>&nbsp;&nbsp;- 고장신고 (G) :   <span> ${dataList.label02_03}대</span></p>
			                            <hr style="border: dotted 2px grey;"/>
			                            <p>&nbsp;&nbsp;- 센터보관 (H) :   <span> ${dataList.label02_04}대</span></p>
			                         </div>   
			                     </td>
			                       <td class="title"  style="vertical-align: middle;line-height: 30px; color: gray;">
						                            대여대기 : 대여소에서 대여 대기<br/>
						                            정상대여 : 시민 이용중<br/>
						                            고장신고 : 대여소내 고장신고 자전거<br/>
						                            센터보관 : QR전환 및 정비, QR A/S<br/>
						                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
						                            	배송차량 탑재, 행사용 등</br>
						              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp※ QR단말기 부착대기(I) :   <span>
			                            	<input style="width: 35px;" type="text" name="label02_08" id="label02_08" value='${dataList.label02_08}' class="read-only" readonly	onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">대</span>              	
			                       </td>
			                   </tr>
			               		<tr style="background-color:Azure ;">
			               			<td>
			               			 <div class="statulist" style="vertical-align: middle;">
			               				 <p style="font-size: large; font-weight: bold;">실자전거수량(D)<span> ${dataList.label02_05}대</span></p>
			               			 </div> 
			               			</td>
			               			<td>
			               			 <div class="statulist" style="vertical-align: middle;">
			                             <p>→ 가동율 : <span> ${dataList.label02_07}</span></p>
			                          </div>   
			               			</td> 
			               			<td style=" color: gray;">
			               				* D = A-(B+C) = E+F+G+H <br/>
			               				* 가동율 : E+F+H(500)/D
			               			</td>
			               		</tr>	    
			               </tbody>
			           </table>

			          <h2>□ 시설 운영현황 <span><input type="text" name="label01_06" id="label01_06" value='${fn:escapeXml(dataList.label01_06)}' class="read-only" readonly style="width:170px;text-align: center; font-size:medium;"></span>
			            <span class="right">  
							<a href='javascript:void(0);' onclick="showPopup2()" class="btnType01"  style="display: none" id="changeLink2">변경</a>
							<a href='javascript:void(0);' onclick="formSave(2)" class="btnType01"  style="display: none"  id="saveLink2">저장</a>
						</span> 
			          </h2>
			          
			          <table class="tb_type01">
			             <colgroup>
			                 <col style="width:50%"/>
			                 <col style="width:50%"/>
			             </colgroup>
			             <tbody>
			                 <tr>
			                     <td class="title">
			                        <div class="statulist" style="line-height: 30px;">
			                            <p>&nbsp;&nbsp;대여소 수량 :<span><input type="text" name="label01_04" id="label01_04" value='${dataList.label01_04}' class="read-only" readonly
			                            	onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"
			                            >곳</span></p>
			                         </div>
			                     </td>   
			                     <td class="title"  style="line-height: 30px;vertical-align: middle;">
			                     	<div class="statulist" style="line-height: 30px;">
			                            <p>&nbsp;&nbsp;거치대 수량 :<span> <input type="text" name="label01_05" id="label01_05" value='${dataList.label01_05}' class="read-only" readonly
			                            	onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"
			                            >대</span></p>
			                         </div>   
			                     </td>
			                      
			               	</tr>	    
			               </tbody>
			           </table>
			            
</form> 
			
				   </div>
				</div>
			</div>
			
				
		</div>
		
		
		
		
</body>

<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawVisualization);

      function drawVisualization() {
        // Some raw data (not necessarily accurate)
        var data = google.visualization.arrayToDataTable([
          ['Month', '대여건수(건)', '판매금액(천원)', ],
          ['${dataList.label06_91}',  parseInt('${dataList.label06_01}'),      parseInt('${dataList.label06_11}')  ],
          ['${dataList.label06_92}',  parseInt('${dataList.label06_02}'),      parseInt('${dataList.label06_12}')  ],
          ['${dataList.label06_93}',  parseInt('${dataList.label06_03}'),      parseInt('${dataList.label06_13}')  ],
          ['${dataList.label06_94}',  parseInt('${dataList.label06_04}'),      parseInt('${dataList.label06_14}')  ],
          ['${dataList.label06_95}',  parseInt('${dataList.label06_05}'),      parseInt('${dataList.label06_15}')  ]
        ]);

        var options = {
   
          series: {
        	  0: {type: 'bars', axis:'rent'},
        	  1: {type: 'line', axis:'amt'}
          },
          legend: { position: 'top', textStyle: { fontSize: 16} },
        };

        var chart = new google.visualization.ComboChart(document.getElementById('chart_div'));
        chart.draw(data, options);
      } 

	var isChange = false;
	
	
	var usrGrpCd = "${userSessionVO.usrGrpCd}";
	
    $(function() {
    	
         var browse = navigator.userAgent.toLowerCase(); 
        
        if( (navigator.appName == 'Netscape' && browse.indexOf('trident') != -1) || (browse.indexOf("msie") != -1)) {
             $("#lowExplorer").show();        
        } else {
             $("#lowExplorer").hide();        
        }
    	
	    $('input').prop('readonly', true);
	 	// input, select에 change event가 일어날 경우
		switch( usrGrpCd ) {
		
		case "12" :
		case "13" :
		case "14" :
			$('#changeLink1').show();
			$('#changeLink2').show();
			$('#saveLink1').show();
			$('#saveLink2').show();
		break;	
		default :
			$('#changeLink1').hide();
			$('#changeLink2').hide();
			
			$('#saveLink1').hide();
			$('#saveLink2').hide();
		}
	 	
	 	$("input, select").change(function(e){
			 isChange  = true;
			 
			 switch( e.target.id ){
			 
			 case "label01_01":
			 case "label01_02":
			 case "label01_03":
			 case "label01_07":
			 case "label02_08":		
				 $('#saveLink1').show();
				 break;
			 // saveLink1
			 case "label01_04":
			 case "label01_05":
			 case "label01_06":
				 $('#saveLink2').show();
				 break;
			 }
			 
			 // alert( e.target.value )
			 // alert( e.target.id )  TODO 
		});
	 	
	 	$("input, select").focusout(function(e){
			
	 		if( (navigator.appName == 'Netscape' && browse.indexOf('trident') != -1) || (browse.indexOf("msie") != -1)) {
	 			isChange  = true;
				 
				 switch( e.target.id ){
				 
				 case "label01_01":
				 case "label01_02":
				 case "label01_03":
				 case "label01_07":
				 case "label02_08":
					 $('#saveLink1').show();
					 break;
				 // saveLink1
				 case "label01_04":
				 case "label01_05":
				 case "label01_06":
					 $('#saveLink2').show();
					 break;
				 }
			 
			 // alert( e.target.value )
			 // alert( e.target.id )  TODO 
	 		}
		});
	 	
	
	 	// userSessionVO.getUsrGrpCd()
	 	
	});
    
	function showPopup1(e){
		if(isChange) {
			alert("저장을 먼저 하고, 변경 해주세요");
			return;
		}
		$('#label01_01').prop('readonly', false);
		$('#label01_02').prop('readonly', false);
		$('#label01_03').prop('readonly', false);
		$('#label01_07').prop('readonly', false);
		$('#label02_08').prop('readonly', false);
		
	}
    
	function showPopup2(e){
		if(isChange) {
			alert("저장을 먼저 하고, 변경 해주세요");
			return;
		}
		$('#label01_04').prop('readonly', false);
		$('#label01_05').prop('readonly', false);
		$('#label01_06').prop('readonly', false);
		
	}
	
	function formSave(type) {
		$('#regType').val(type);
		
		if(!isChange) {
			alert("변경된 값이 없습니다.");
			return;
		}
		 
		commonAjax.postAjax("/use/updateDashBoardMain.do", "json",   $("#updateForm").serialize()
    		,function(data){
    		   if(data) {
    	
    			   var result= data.result;
				 
    			  if( result == "1" ) {
    				  alert("정상적으로 저장이 되었습니다.");
    				  location.reload();
    			  } else {
    				  alert("저장에 실패아였습니다. 재조회 후 다시 등록부탁드립니다.")
    			  }
    			  
    		   }
    		}
    	);
	}
      
    </script>
</html>