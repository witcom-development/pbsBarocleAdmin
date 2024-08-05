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
<link rel="stylesheet" href="/css/w3.css">
		 
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
						<!-- <div id="filterDiv" class="staBox mapguide" style="margin-top:10px"> --> 
							<div class="w3-panel w3-leftbar w3-border-green">
								최근 일주일간 대여소별 배송직원 방문 횟수에 따른 등급설정
							</div>
							<fieldset>
  							<legend> 최근 일주일간 대여소별 배송직원 방문 횟수에 따른 등급설정 </legend>
							<ul id="summary" class="w3-navbar w3-center" style="padding:0 10px 5px 10px;">
							  <li style="width:17%" id="summary_A"></li>
							  <li style="width:16%" id="summary_B"></li>
							  <li style="width:16%" id="summary_C"></li>
							  <li style="width:16%" id="summary_D"></li>
							  <li style="width:16%" id="summary_E"></li>
							  <li style="width:18%" id="summary_F"></li>
							</ul>
							<ul class="w3-navbar w3-center" style="padding:0 10px 0 10px;">
							  <li style="width:17%"><label for="filterA"><input type="checkbox" class="w3-check" id="filterA"> A(10↑) </label></li>
							  <li style="width:16%"><label for="filterB"><input type="checkbox" class="w3-check" id="filterB"> B(6↑) </label></li>
							  <li style="width:16%"><label for="filterC"><input type="checkbox" class="w3-check" id="filterC"> C(3↑) </label></li>
							  <li style="width:16%"><label for="filterD"><input type="checkbox" class="w3-check" id="filterD"> D(1↑) </label></li>
							  <li style="width:16%"><label for="filterE"><input type="checkbox" class="w3-check" id="filterE"> E(0) </label></li>
							  <!-- <li style="width:13%"><a id="filterALL" href="#" onclick="fn_filter('ALL');return false;">전체</a></li> -->
							  <li style="width:18%"><a href="/relocationStateStationMapExcel.do" class="w3-button w3-border w3-border-green w3-round-large">Excel Dwon</a></li>
							</ul>
 							</fieldset>
							
							<!--     <p>London is the most populous city in the United Kingdom,
							    with a metropolitan area of over 9 million inhabitants.</p> -->
							</div>
							
						<div id="map" style="border:1px solid #000; top: 20px; left: 0px; width: 700px; height: 650px; margin:10px;padding:0; ">						
				 		</div>
						
						<p class="tb_numlist" style="margin-top:30px;">총 </p>
						
						<table class="tb_type01" id="list" style="margin-top:10px;">
					        <colgroup>
					            <col style="width:15%;" />
					            <col style="width:10%" />
					            <col style="width:30%" />
					            <col style="width:7%" />
					            <col style="width:7%" />
					            <col style="width:7%" />
					            <col style="width:7%" />
					        </colgroup>
					        <thead>
					            <tr>
					                <th>센터</th>
					                <th>구</th>
					                <th>대여소</th>
					                <th>등급</th>
					                <th>총 건수</th>
					                <th>이동 방문</th>
					                <th>배치 방문</th>
					            </tr>
					        </thead>
					        <tbody id="stationBody"> 
					        </tbody>
						</table>
						</div> 
					</div>
				 
						
				<!--content E-->
		</div>
		<!--footer S-->
			<tiles:insertAttribute name="footer" />
		<!--footer E-->
	</div>
	</div>
	<script type="text/javascript" src="/js/common_barocle.js"></script>
	
	<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=4791tlnwi5&&submodules=panorama,geocoder,drawing,visualization"></script>
	
	<script type="text/javascript" src="/js/MarkerClustering.js"></script>
	
    <script type="text/javascript">

  	//기본 중심좌표
	var MAP_lat =  37.5716184;
	var MAP_lng = 127.0360526;
	var isGPS = false;  	
	var oCenterPoint = new naver.maps.LatLng(MAP_lat, MAP_lng);
	var myPoint = new naver.maps.LatLng(MAP_lat, MAP_lng);
	var defaultLevel = 12;
    var searchList = null;
	var oMap = new naver.maps.Map (
		document.getElementById('map'), {
			point : oCenterPoint,
			zoom : defaultLevel,
			enableWheelZoom : true,
			enableDragPan : true,
			mapTypeControl: false,
			enableDblClickZoom : false,
			mapMode : 0,
			activateTrafficMap : false,
			activateBicycleMap : false,
			minMaxLevel : [ 7, 11 ]
	});
	
	var sortType ="ASC";
	
	var markers = [];
	var markerA = {
            style: "circle",
            radius: 3,
            fillColor: "green",
            fillOpacity: 1,
            strokeColor: "black",
            strokeStyle: "solid",
            strokeWeight: 0.2
        },
        markerB = {
            style: "circle",
            radius: 3,
            fillColor: "blue",
            fillOpacity: 1,
            strokeColor: "black",
            strokeStyle: "solid",
            strokeWeight: 0.2
        },
        markerC = {
			style: "circle",
            radius: 3,
            fillColor: "brown",
            fillOpacity: 1,
            strokeColor: "black",
            strokeStyle: "solid",
            strokeWeight: 0.2
        },
        markerD = {
			style: "circle",
            radius: 3,
            fillColor: "#ffd400",
            fillOpacity: 1,  
            strokeColor: "black",
            strokeStyle: "solid",
            strokeWeight: 0.2
        },
        markerE = {
			style: "circle",
            radius: 3,
            fillColor: "black",
            fillOpacity: 1,
            strokeColor: "black",
            strokeStyle: "solid",
            strokeWeight: 0.2
        };    
	 
	    
 	// 지도 크기 변경
    function resizeMap(nWidth, nHeight) {
    	var pSize = new naver.maps.Size(nWidth, nHeight);
    	if(oMap != null) oMap.setSize(pSize);
    }
    
    function draw() {
    	
    	$.ajax({
    		type : "post",
    		url : "/relocationStateStationMapAjax.do",
    		data : null,
    		success : function(data){
    			
    			if( data.reulst == false ) {
    				alert("조회에 실패했습니다. ")
    				return;
    			}
    			// redraw(data.dsList);
    			// redrawTable(data.dsList);
    			searchList = data.dsList;
    			var cnt_A = 0, cnt_B = 0, cnt_C = 0, cnt_D = 0, cnt_E = 0, cnt_F = 0;
    			$.each( searchList, function (idx, el) {
    	   			var icon = "";
    	   			switch( el.imgSrc ){
    	   			case "A" :	cnt_A++;	break;
    	   			case "B" :	cnt_B++;	break;
    	   			case "C" :	cnt_C++;	break;
    	   			case "D" :	cnt_D++;	break;
    	   			case "E" :	cnt_E++;	break;
    	   			}
    			});
    			
    			cnt_F = cnt_A + cnt_B + cnt_C + cnt_D + cnt_E;
    			
	   			$("#summary_A").html( "<span style='color:green'>●</span>" + cnt_A + "(" + Math.round( cnt_A / cnt_F * 100 ) +"%)");  
	   			$("#summary_B").html( "<span style='color:blue'>●</span>" + cnt_B + "(" + Math.round( cnt_B / cnt_F * 100 ) +"%)");  
	   			$("#summary_C").html( "<span style='color:brown'>●</span>" + cnt_C + "(" + Math.round( cnt_C / cnt_F * 100 ) +"%)");  
	   			$("#summary_D").html( "<span style='color:#ffd400'>●</span>" + cnt_D + "(" + Math.round( cnt_D / cnt_F * 100 ) +"%)");  
	   			$("#summary_E").html( "<span style='color:black'>●</span>" + cnt_E + "(" + Math.round( cnt_E / cnt_F * 100 ) +"%)");  
	   			$("#summary_F").text(cnt_F + "(100%)");  
    			
	   			 


    		},
    		error : function(data){
    			alert("조회에 실패했습니다.");
    			// postAjaxLoading("end");
    		}
    	});
    }  
	
    function redraw(dsList){
    	
    	var markerOptions = {icon: {}};
    	
    	for(var i =0; i <markers.length; i++){
    		markers[i].setMap(null);
    	}
    	
   	    $.each( dsList, function (idx, el) {
	   	    	markerOptions.position = new naver.maps.LatLng(el.stationLatitude,  el.stationLongitude);
	   			markerOptions.map = oMap.map;
	   			
	   			var setIcon = "";
	   			switch( el.imgSrc ){
	   			case "A" :	setIcon = markerA;	break;
	   			case "B" :	setIcon = markerB;	break;
	   			case "C" :	setIcon = markerC;	break;
	   			case "D" :	setIcon = markerD;	break;
	   			case "E" :	setIcon = markerE;	break;
	   			default  : markerE;
	   			}
	   			
	   			markerOptions.icon = setIcon;
	   			var marker = new naver.maps.Marker(markerOptions);
	   			marker.setMap(oMap);
	   			
	   			naver.maps.Event.addListener(marker, 'click', getClickHandlerMove(el.centerName, el.stationGrpName, el.stationName, el.totCnt, el.moveCnt, el.relocateCnt )); 
	   			 
	   			markers.push(marker);  
		}); 
    }
    
    function redrawTable(dsList){
    	$("#stationBody").empty();
 		var rowData= "";
 		var idxx   = 0;
		$.each( dsList, function (idx, el) {
			
		    	  rowData += "<tr>";
			      rowData += '<td style="text-align:center">' + el.centerName + '</td>';
			      rowData += '<td style="text-align:center">' + el.stationGrpName + '</td>';
			      rowData += '<td style="text-align:left">' + el.stationName + '</td>';
			      rowData += '<td style="text-align:center">' + el.imgSrc + '</td>';
			      rowData += '<td style="text-align:right">' + el.totCnt + '</td>';
			      rowData += '<td style="text-align:right">' + el.relocateCnt + '</td>';
			      rowData += '<td style="text-align:right">' + el.moveCnt + '</td>';
		    	  rowData += '</tr>';
		}); 
		$("#stationBody").append(rowData);
		$(".tb_numlist").text(" 총 " + dsList.length + " 건" );
    }
     

    function fn_filter(type){
    	postAjaxLoading("start");
    	
   		$("#filterA").removeClass("w3-green");
   		$("#filterB").removeClass("w3-green");
   		$("#filterC").removeClass("w3-green");
   		$("#filterD").removeClass("w3-green");
   		$("#filterE").removeClass("w3-green");
   		$("#filterF").removeClass("w3-green");
    	
   		if ( type == "ALL" ){
   			redraw(searchList);
   			redrawTable(searchList);
   			postAjaxLoading("end");
   			return;
   		}
   		
    	var newDsList = searchList.filter(function(element){
			    	        return element.imgSrc == type;
			    	    });

    	redraw(newDsList);
		redrawTable(newDsList);
		
		$("#filter" + type ).addClass("w3-green");
		
		postAjaxLoading("end");
    }
    

    function postAjaxLoading(param) {
    	
    	if(param == "start"){
			
			 var width = 0;
		     var height = 0;
		     var left = 0;
		     var top = 0;
		     
		     width = 50;
		     height = 50;
		       
		     top = ( $(window).height() - height ) / 2 + $(window).scrollTop();
		     left = ( $(window).width() - width ) / 2 + $(window).scrollLeft();
		     
		     if( ( $("#div_ajax_load_image").length  > 0) ) {
		    	 
		            $("#div_ajax_load_image").css({
		                   "top": top+"px",
		                   "left": left+"px"
		            });
		            $("#div_ajax_load_image").show();
		     } else {
		    	 
		              $('body').append('<div id="div_ajax_load_image" style="position:absolute; top:' + top + 'px; left:' + left + 'px; width:' + width + 'px; height:' + height + 'px; z-index:9999; background:#f0f0f0; filter:alpha(opacity=50); opacity:alpha*0.5; margin:auto; padding:0; "><img src="/images/ajax_loader3.gif" style="width:50px; height:50px;"></div>');
		              $("#div_ajax_load_image").show();
		     }
	     
		}else{
			
			$("#div_ajax_load_image").remove();
			
		}
    }

    function getClickHandlerMove(centerName, stationGrpName, stationName, totCnt, moveCnt, relocateCnt) {
        return function(e) {
    	 
        	var cont = '<div  id="infoBox" class="w3-panel w3-pale-green w3-bottombar w3-border-green w3-border" style="margin:0 5px">';
	        	cont += '       <p>';
	        	cont += '           <a href="#" style="position:absolute; top:23px; right:10px" class="mpclose"><img  name="close" src="/images/stationClose.gif" style="background:#ddffdd" alt="대여소 정보닫기" /></a>';
	        	cont += '       </p>';
	        	cont += '       <ul style="padding:10px">';
	        	cont += '           <li>센&nbsp;&nbsp;터 : ' + centerName  + '</li>';
	        	cont += '           <li>지역구 : ' + stationGrpName  + '</li>';
	        	cont += '           <li>명&nbsp;&nbsp;칭 : ' + stationName  + '</li>';
	        	cont += '           <li>전체건수 : ' + totCnt  + ' (이동 : ' + moveCnt + ' / 배치 : ' + relocateCnt   +') </li>';
	        	cont += '       </ul>';
	            cont += '   </div>';
	        		
	            var infoWindow = new naver.maps.InfoWindow({
	            	content: cont,
	            	backgroundColor : "#ddffdd",
	            		anchorColor : "#ddffdd"
	        	});	
	            var center = new naver.maps.LatLng(e.coord);
	            	
	            oMap.setCenter(e.coord); //2020-11-04 : 마커를 중앙으로 이동
	       		infoWindow.open(oMap,e.coord);   
	       		$("#infoBox a img").on("click", function(e){
	    	       	e.preventDefault();
	    	       	infoWindow.close(oMap,center);
	            });
            }
    }    
    
    function updateScreen(){

   		var filterArr = "";
   		if ( $("#filterA").is(":checked") ) filterArr += "A";
   		if ( $("#filterB").is(":checked") ) filterArr += "B";
   		if ( $("#filterC").is(":checked") ) filterArr += "C";
   		if ( $("#filterD").is(":checked") ) filterArr += "D";
   		if ( $("#filterE").is(":checked") ) filterArr += "E";
   		var newDsList = searchList.filter(function(element){
   			return ( filterArr.indexOf( element.imgSrc) >= 0 );
   		   });
   		
      	 redraw(newDsList);
		 redrawTable(newDsList);
		 
		 postAjaxLoading("end");

    }
    
    function SortTable( table, n  )
    {
    	// table 에 tbody tag 가 반드시 존재한다고 가정한다.
    	var tbody = table.tBodies[0];
    	var rows = tbody.getElementsByTagName( "tr" );
    	
    	// 배열로 생성한 후, 배열로 정렬한다.
    	rows = Array.prototype.slice.call( rows, 0 );
    	
    	var upValue = 1;
    	var downValue = -1;
    	
    	if(  sortType == "DESC" ) {
    		upValue = 1;
    		downValue = -1;
    		
    		sortType ="ASC";
    		
    	} else {
    		upValue = -1;
    		downValue = 1;
    		
    		sortType ="DESC";
    	} 
    	
    	rows.sort( function( row1, row2 ) {
    		
    	    var cell1 = row1.getElementsByTagName("td")[n];
    	    var cell2 = row2.getElementsByTagName("td")[n];
    	    
    	    var value1 = cell1.textContent || cell1.innerText;
    	    var value2 = cell2.textContent || cell2.innerText;
    		// 센터, 구, 대여소, 등급
    		if (n == 0 || n == 1 || n == 2 || n == 3 ) {
    		
    			if( value1 < value2 ) return upValue;
    		    if( value1 > value2 ) return downValue;
    		
    		// 자전거, 거치율    
    		} else {
    			if( parseInt(value1) < parseInt(value2) ) return upValue;
    		    if( parseInt(value1) > parseInt(value2) ) return downValue;
    		}
    			return 0;
    		}
    	);
      

    	// 정렬된 배열로 row 를 다시 저장한다. 문서에 이미 존재하는 node 는 삽입하면 해당 node 는 자동으로 제거되고 새 위치에 저장된다.
    	for( var i = 0; i < rows.length; ++i )
    	{
    		tbody.appendChild( rows[i] );
    	}
    }
    
    function setTableGrid(sortType){
    	
    	// 모든 table 헤더에 클릭 이벤트를 설정한다.  list
    	var tables = document.getElementsByTagName("table");
    		
    	for( var i = 0; i < tables.length; ++i )
    	{
    		var headers = tables[i].getElementsByTagName("th");
    		for( var j = 0; j < headers.length; ++j )
    		{
    			// 지역 유효범위에 생성할 중첩 함수
    			(function(table,n)	{
    					headers[j].onclick = function() { SortTable( table, n  )	};
    				}( tables[i], j ) 
    			);
    		}
    	}    	
    }
    
   	$(function() {
   	 	
   		draw();
   	 	
   		// 필터링 추가
		setTableGrid();
   	 	
   	 //	$(".w3-check").on("change", this.che);
   	   $(".w3-check").change(function(){
   			postAjaxLoading("start");
   			setTimeout(updateScreen, 1000);
	   		}
   	   
   	   );
   	   
   	})
    
    </script>
</body>
</html>