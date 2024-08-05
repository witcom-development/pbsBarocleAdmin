<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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

<style>
  .naverMapMarker{
    font-size: 0.8em;
    width: 0.8em;
    border-radius: 1.5em;
    padding: .1em  .2em;
    line-height: 1.25em;
    border: 1px solid #333;
    display: inline-block;
    color:red;
    background: white;
    text-align: center;
  }
   
	/* CSS */
	.button-3 {
	  appearance: none;
	  background-color: #2ea44f;
	  border: 1px solid rgba(27, 31, 35, .15);
	  border-radius: 6px;
	  box-shadow: rgba(27, 31, 35, .1) 0 1px 0;
	  box-sizing: border-box;
	  color: #fff;
	  cursor: pointer;
	  display: inline-block;
	  font-family: -apple-system,system-ui,"Segoe UI",Helvetica,Arial,sans-serif,"Apple Color Emoji","Segoe UI Emoji";
	  font-size: 14px;
	  font-weight: 600;
	  line-height: 20px;
	  padding: 6px 16px;
	  position: relative;
	  text-align: center;
	  text-decoration: none;
	  user-select: none;
	  -webkit-user-select: none;
	  touch-action: manipulation;
	  vertical-align: middle;
	  white-space: nowrap;
	}
	
	.button-3:focus:not(:focus-visible):not(.focus-visible) {
	  box-shadow: none;
	  outline: none;
	}
	
	.button-3:hover {
	  background-color: #2c974b;
	}
	
	.button-3:focus {
	  box-shadow: rgba(46, 164, 79, .4) 0 0 0 3px;
	  outline: none;
	}
	
	.button-3:disabled {
	  background-color: #94d3a2;
	  border-color: rgba(27, 31, 35, .1);
	  color: rgba(255, 255, 255, .8);
	  cursor: default;
	}
	
	.button-3:active {
	  background-color: #298e46;
	  box-shadow: rgba(20, 70, 32, .2) 0 1px 0 inset;
	}
</style>
 
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
						<!-- 모바일 검색조건 S-->
						<div class="shBox_m">
							<div class="downtitle">
								<div class="title">
									<p>검색조건</p><span><button><img src="/images/srh_open.png" alt="검색조건 열기" /></button></span>
								</div>
							</div>
						</div>
						<!-- 모바일 검색조건 E-->
						<!--검색조건 S-->
						<div class="shBox">
							<form id="searchFrm">
								<%-- <input type="hidden" name="adminId" value="${searchCondition.adminId}" /> --%>
								<fieldset>
									<legend>검색 옵션</legend>
									<div class="shBoxSection">
										<div class="section">
											<label for="bb22" class="laType02">일자</label>
											<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" name="searchBgnDe" title="선택 날짜" id="bb22" readonly/></span>
											<span class="dash">~</span>
											<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" name="searchEndDe" title="선택 날짜" readonly/></span>
										</div>
										<div class="section">
											<label for="adminName" class="laType02">직원</label>
											<span class="input-text08"><input type="text" id="adminName" name="adminName" /></span>
											<button type="button" id="searchBtn" class="btn-srh03 btncase1 mdbtncase1"><img src="/images/searchIcon.gif" alt="검색"></button>
										</div>
									</div>
								</fieldset>
							</form>	
						</div>
						<!--검색조건 E-->
						
						<div style="border:1px solid thin; padding: 10px;">	  
							<form id="insertArrangeCallForm">
							  <label>재배치 동선 : </label><select name="req_mem_cnt">
														  <option value="1">1</option>
														  <option value="2" selected="selected">2</option>
														  <option value="3">3</option>
														  <option value="4">4</option>
														</select>
							  <label>차량내 자전거 수</label>
							  <span class="input-text04">	
							  	<select id=initialCount" name="initialCount">
								  <option value="0" selected="selected">0</option>
								  <option value="1">1</option>
								  <option value="2">2</option>
								  <option value="3">3</option>
								  <option value="4">4</option>
								  <option value="5">5</option>
								  <option value="6">6</option>
								  <option value="7">7</option>
								  <option value="8">8</option>
								  <option value="9">9</option>
								  <option value="10">10</option>
								  <option value="11">11</option>
								  <option value="12">12</option>
								  <option value="13">13</option>
								  <option value="14">14</option>
								  <option value="15">15</option>
								</select>
							  </span>
							  <input id=insertArrangeCall" onclick="insertArrangeCall()" class="button-3" value="생성" style="width:65px"></input>
							  <input id=req_latitude" style="visibility: hidden" name="req_latitude"></input>							
							  <input id=req_longitude" style="visibility: hidden" name="req_longitude"></input>
							  
							</form>
						</div>
						<%-- <p class="tb_numlist">총 ${ paginationInfo.getTotalRecordCount()} 건</p> --%>
						
						<p class="tb_numlist"></p>
						
						<div>
							<table class="tb_type01" id="list">
								<colgroup>
									<col style="width:20%"/>
									<col style="width:10%"/>
									<col style="width:10%"/>
									<col style="width:25%"/>
									<col style="width:25%"/>
									<col style="width:25%"/>
									<col style="width:10%"/>
									<col style="width:10%"/>
									<col style="width:10%"/>
								</colgroup>
								<thead>
									<tr>
										<th>요청일자</th>
										<th>요청시간</th>
										<th>재배치<br/>인원</th>
										<th>요청시간 </th> 
										<th>요청자 </th> 
										<th>생성시간</th> 
										<th>완료여부</th>
										<th>동선</th>
										<th>확인</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="result" items="${dsList}" varStatus="status">
	                                <tr>
	                                	<td class="tc">${result.req_ymd}</td>
	                                    <td>${result.req_hour}</td>
	                                    <td class="tc">${result.req_mem_cnt}</td>
	                                    <td class="tc">${result.req_dttm}</td>  
	                                    <td class="tc">${result.adminName}</td>  
	                                    <td class="tc">${result.end_dttm}</td>  
	                                    <td class="tc">${result.req_yn}</td>
	                                    <td>${result.group_seq}</td>
	                                    <td class="tc"><a href="#">view</a></td>
	                                    <td style="visibility:hidden;position:absolute;">${result.call_seq}</td>
	                                </tr>
	                            	</c:forEach>  
								<c:if test="${fn:length(dsList) eq 0 }">
									<table class="tb_type01 nbt0">
										<tr><td style="text-align:center"><spring:message code="search.nodata.msg" /></td></tr>
									</table>
								</c:if>
								</tbody>
							</table>
						</div>
						
						<div style="width: 30%; margin-top:30px; float: left ;">
							<table class="tb_type01" id="appendList">
									<colgroup>
										<col style="width:10%"/>
										<col style="width:30%"/>
										<col style="width:10%"/> 
									</colgroup>
									<thead>
										<tr>
											<th>순서</th>
											<th>대여소번호</th>
											<th>건수</th>
										</tr>
									</thead>
									<tbody id="stationBody">
									</tbody>
							</table>
							
						</div>
						
						<div id="mapDiv" style="width: 40%; margin-top:30px; float: left ; margin:30px" ></div>
						
					</div>
                         
					</div>
				</div>
				<!--content E-->
			</div>
		</div>
		<!--footer S-->
		<%-- <tiles:insertAttribute name="footer" /> --%>
		<!--footer E-->
	
	<script type="text/javascript" src="/js/common_barocle.js"></script>
	<script type="text/javascript" src="/js/stationCommonMapv.js"></script>
	<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=zc9ttduqic"></script>
    <script type="text/javascript">
    
    
    var relocationMap = {};
   	
    $(function() {

   		relocationMap.initBtn();
   		
		var sDate = '${searchCondition.searchBgnDe}' != '' ? '${searchCondition.searchBgnDe}' : '';
		var eDate = '${searchCondition.searchEndDe}' != '' ? '${searchCondition.searchEndDe}' : '';
		
		 $( "[name='searchBgnDe']").val( sDate )
		 $( "[name='searchEndDe']").val( eDate )
		
	});
    
    relocationMap.initBtn = function(){
    	$("#searchBtn").on("click",{listType: "list"},this.exeListFnc);
    	$("#excelViewBtn").on("click",{listType: "excel"},this.exeExcelFnc);
    	
    	$('#list').on('click', 'tbody tr', function(event) {
    	        $(this).addClass('highlight').siblings().removeClass('highlight');
    	      });
    	$("#list > tbody > tr").on("click",'a', this.moveStationDetail);
    	
    	this.initMap();
    	
    	getUsrGpsInfo();
    }
    
    function insertArrangeCall() {
    	
    	$.ajax({
    		type : "post",
    		url : "/insertRelocationArrangeCall.do",
    		data : $("#insertArrangeCallForm").serialize(),
    		success : function(data){
    			if( data.bResult ) {
    				alert("정상 등록되었습니다. 10초 후 재조회 부탁드립니다.");
    			} else {
    			 alert( "정상적으로 처리되지 않았습니다. 재 로그인 후, 다시 실행 부탁드립니다" );
    				
    			}
    		}
    	});	
    	
    	
    }
    
    
    relocationMap.moveStationDetail = function(e){
    	e.preventDefault();
    	
    	var currentRow=$(this).closest("tr"); 
    	var col1=currentRow.find("td:eq(9)").text();	// call_seq
    	var col2=currentRow.find("td:eq(7)").text();	// group_seq
    	var params = {};
		params.call_seq=col1;
		params.group_seq=col2;
		
		$("#stationBody").empty();
		
    	$.ajax({
    		type : "post",
    		url : "/getRelocationArrangeResult.do",
    		data : params,
    		success : function(data){
    			var rowData ="";
    			
    			
    			
    			$.each(data.dsList, function (idx, el) {
    				rowData += "<tr>";
					rowData += '<td style="text-align:center">' + el.move_seq  + '</td>';
					rowData += '<td style="text-align:center">' + el.station_no  + '</td>';
					rowData += '<td style="text-align:center">' + el.move_cnt  + '</td>';
					rowData += '</tr>';
				}); 
			
				$("#stationBody").append(rowData);
				
				console.table( data )
				
		    	// nave map 
		    	redraw(data.dsList);
    		}
    	});	
    	
    	
    }
    
    
    relocationMap.initMap = function(e){
    }
    
    function redraw(data){
    	
    	if ( data.size == 0  ) return;
    	
    	console.table( data );
    	
    	var map = new naver.maps.Map('mapDiv', {
    		size: new naver.maps.Size(400, 400),
    	    center: new naver.maps.LatLng(data[0].req_latitude, data[0].req_longitude),
    	    zoom: 15
    	});

   	    $.each( data, function (idx, el) {
   			var marker = new naver.maps.Marker({
   	    	    position: new naver.maps.LatLng(el.req_latitude,  el.req_longitude),
   	    	    map: map,
   	    	 	title: el.station_no,
   	    	 	icon: {
	   	          	
   	    	 		content: '<div class="naverMapMarker">' + el.move_seq + '</div>',
	   	          	// size: new naver.maps.Size(10, 10),
	   	          	anchor: new naver.maps.Point(11, 35)
	   	      	}
   	    	 	
   	    	});
   			 
		});  
    }
    
    relocationMap.exeListFnc = function(e) {
        e.preventDefault();
        var listType = e.data.listType;

        if(DateUtil.checkDateTerm( $( "[name='searchBgnDe']").val(),  $( "[name='searchEndDe']").val()) != 'ok') {
            alert('<spring:message code="fail.input.daterange"/>');
            return false;
        }
        
        $("#searchFrm").attr({method : 'post', action : '/getRelocationWorkMap.do'}).submit();
    }; 
    
    
    
    
    
    
    
    
    function getUsrGpsInfo() {
		
    	if (navigator.geolocation) {
			var options = {
				enableHighAccuracy : true,
				timeout : 10000,
				maximumAge : 6000
			};
			navigator.geolocation.getCurrentPosition(onSuccessGeolocation, onErrorGeolocation, options);
		} else {
			window.android.gpsStart();
		}
    	/* if (appOsType === undefined || appOsType === "web" || appOsType === "") { //웹, 모바일웹의 경우
				if (navigator.geolocation) {
					var options = {
						enableHighAccuracy : true,
						timeout : 10000,
						maximumAge : 6000
					};
					navigator.geolocation.getCurrentPosition(onSuccessGeolocation, onErrorGeolocation, options);
				} else {
					location.replace(returnSta.replaceUrl);
				}
		} else { //앱으로 접속할 경우
			if (this.deviceType === 'android' || this.deviceType === "Android") {
				window.android.gpsStart();
			}
			if (this.deviceType === 'iPhone' || this.deviceType === "iPad" || this.deviceType === 'ios') {
				window.location = 'toApp://?{"call":"gpsStart"}';
			}
		} */
    };
    
    function findLocation() {
    	deviceType = checkDevice();
    	getUsrGpsInfo();
	};
    
    function onSuccessGeolocation(position) {
    	$( "[name='req_latitude']").val( position.coords.latitude )
    	$( "[name='req_longitude']").val( position.coords.longitude )
    }
    
    function onErrorGeolocation() {
    	alert("gps error");
    }
    
    
    </script>
</body>
</html>