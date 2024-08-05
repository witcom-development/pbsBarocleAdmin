

<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=zc9ttduqic"></script> 
   <script type="text/javascript" src="/js/stationCommonMapv.js"></script>
   <script type="text/javascript" src="/js/common_barocle.js"></script>
   <script type="text/javascript">
   
		var markersN = [];
		var markersS = [];
		var markersL = [];
		var currentStatus = {};
		
		function redraw(data){
			
			//마커 삭제 : 다 지운 후 다시 마커 삽입
			markerRemoveAll();
			
			var img = {icon: {}};
			var opt = {};
			var markerOptions = {icon: {}, map:nMap.map };
			
/* 			data.exeImpulseList.forEach(
					
					function(info){
						markerOptions.position = new naver.maps.LatLng(info.latitude,  info.longitude);
				        markerOptions.title = info.stationName;
				        
				        markerOptions.icon.content = "<div><img src='/images/icon_bike_big3.png'  width='15px'></div>";
				        var marker = new naver.maps.Marker(markerOptions);
				        markersN.push(marker);
					}		
			);

			data.bikeLostList.forEach(
					
					function(info) {
						markerOptions.position = new naver.maps.LatLng(info.xPos,  info.yPos);
			       		markerOptions.icon.content = "<div><img src='/images/icon_bike_big4.png' width='15px'></div>";
			       		var marker = new naver.maps.Marker(markerOptions);
						 
				        markersL.push(marker);
					}		
			); */
  		 
	  		data.stationList.forEach(
				function(info){
					markerOptions.position = new naver.maps.LatLng(info.stationLatitude,  info.stationLongitude);
					
					if( info.stationUseYn == "R") { 
						return;
					}
					
					
					if( info.brokenBikeTotCnt < 3 ){
						
					//	alert(info.brokenBikeTotCnt)
						
						var s = info.stationAddr;
						
						if( info.stationSeCd =="RAK_001" ){
							
							s = info.stationAddr = 
							info.stationAddr = s.substring(1,16) + "Y" + s.substring(17,25) +".png"
							
							
						} else {
							info.stationAddr = info.stationAddr.replace("/E/icon_b3","/Y/icon_b2");
						}
						
						if ( info.stationAddr == "images/mapIcon/Y/icon_b5.png"  ) return;
						if ( info.stationAddr == "images/staStop_Ys150p.pn.png"  ) return;
						
						
					}
					
			        markerOptions.icon.content = "<div><img src='"+info.stationAddr+"'  width='10px' height='10px' ></div>";
			        
			        markerOptions.title = info.stationName;
			        
			        var marker = new naver.maps.Marker(markerOptions);
			        /* 
			   		var infowindow = new naver.maps.InfoWindow({
			   		    content: info.stationName
			   		});
			
			   		naver.maps.Event.addListener(marker, "click", function(e) {
			   			e.preventDefault();
			   			nMap.map.setZoom(17);
						nMap.map.setCenter(new naver.maps.LatLng(info.latitude,  info.longitude));
			   			
			   			if (infowindow.getMap()) {
			   		        infowindow.close();
			   		     	marker.setMap(null);
			   		    } else {
			   		        infowindow.open(nMap.map, marker);
			   		    }
			   		}); */
			   		
					markersS.push(marker);
				}		
			);
			 
	        if( $("#station").hasClass("control-on")) {
			  	markersS.forEach(
			  			
			  			function(marker){
			  				 var mapBounds = nMap.map.getBounds();
							 var marker, position;
							 position = marker.getPosition();

						        if (mapBounds.hasLatLng(position)) {
						            showMarker(nMap.map, marker);
						        } else {
						            hideMarker(nMap.map, marker);
						     }
			  			}
				  ); 
			}
	        
	        
   	        if( $("#fault").hasClass("control-on")) {
	        	markersN.forEach(
					function(marker){marker.setMap(nMap.map)}
				);
			}
	        if( $("#lost").hasClass("control-on")) {
	        	markersL.forEach(
					function(marker){marker.setMap(nMap.map)}
				);
			}   
	        
			currentStatus.orgMarkersN = markersN;
		    currentStatus.orgMarkersS = markersS;
		    currentStatus.orgMarkersL = markersL;
		}
		
	function updateMarkers(map) {

	    var mapBounds = map.getBounds();
	    var marker, position;

	    for (var i = 0; i < markersS.length; i++) {

	        marker = markersS[i]
	        position = marker.getPosition();

	        if (mapBounds.hasLatLng(position)) {
	            showMarker(map, marker);
	        } else {
	            hideMarker(map, marker);
	        }
	    }
	}
	
	function showMarker(map, marker) {
            if (marker.getMap()) return;
            marker.setMap(map);
       }

    function hideMarker(map, marker) {
        if (!marker.getMap()) return;
        marker.setMap(null);
    }
   
   function markerRemoveAll(){
   	
	   	for(var i =0; i <markersN.length; i++){
	   		markersN[i].setMap(null);
	   	}
	   	
	   	for(var i =0; i <markersS.length; i++){
	   		markersS[i].setMap(null);
	   	}
	   	
	   	for(var i =0; i <markersL.length; i++){
	   		markersL[i].setMap(null);
	   	}
   	
   }
   
   linkStation = function(stationId) {
	   	$("[name='stationId']").val(stationId);
	   	// 2018-11-25 새창열기로 변경
	   	$("#searchFrm").attr({action : "<c:out value='/moveCurrentStationDetail.do'/>", method : "post", target:"_blank"}).submit();
   };
    
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
		     
		     if( isEmpty( $("#div_ajax_load_image")) ) {
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
   
   
   var isEmpty = function(value){ if( value == "" || value == null || value == undefined || ( value != null && typeof value == "object" && !Object.keys(value).length ) ){ return true }else{ return false } };

   
   $(function(){
	   
    		nMap.defaultLevel =  14; // ('${userSessionVO.usrId}' === 'monitor' ? '14' : '10' );

	    	/* Naver API 3.0*/
	    	var oPoint = new naver.maps.LatLng(nMap.defaultLatitude ,nMap.defaultLongitude);	
	    	
	    	nMap.map = new naver.maps.Map("mapDiv", {
	            center: new naver.maps.LatLng(37.5675451, 126.9773356), //지도의 초기 중심 좌표
	            useStyleMap: true,
	            zoom: nMap.defaultLevel, //지도의 초기 줌 레벨
	            minZoom: 10, //지도의 최소 줌 레벨
	            enableDragPan : true,
	            zoomControl: true, //줌 컨트롤의 표시 여부
	            zoomControlOptions: { //줌 컨트롤의 옵션
	            	position: naver.maps.Position.LEFT_BOTTOM
	            }
	        });	
	    	
	    	naver.maps.Event.addListener(nMap.map, 'idle', function() {
	    	    updateMarkers(nMap.map);
	    	});
	    	
	    	naver.maps.Event.addListener(nMap.map, 'zoom_changed', function() {
	    		updateMarkers(nMap.map);
	    	});
	    	
	    	// 버튼
		   	setBicle();
		   	setTraffic();
		   	setStationBtn();
		   	seLostBtn();
		   	setFaultBtn();
		   	
		   	setSearchPlaceBtn()
	    	
	    	setStation();
	    	var time = 300;
			var count = document.getElementById("count");
			
	    	setInterval(function(){
				count.value = time +'초 후 목록이 갱신됩니다.';
				time--;
				if ( time == 0 ) {
					setStation();
					time = 300;	
				}
				
			},1000);

       }
   
   );
   
   function setStation(){
	   
	   postAjaxLoading("start");
	   	var params = $("#searchFrm").serialize();
	   	$.ajax({
	   		type : "post",
	   		url : "/getStationCurrentStatusAjax.do",
	   		data : params,
	   		success : function(data){
	   			redraw(data);
	   			postAjaxLoading("end");
	   		},
	   		error : function(data){
	   			postAjaxLoading("end");
	   		}
	   	});
	 
   }
   
   function setBicle(){
	   
	   var bicycleLayer = new naver.maps.BicycleLayer();

	   var btn = $('#bicycle');

	   naver.maps.Event.addListener(nMap.map, 'bicycleLayer_changed', function(bicycleLayer) {
	       if (bicycleLayer) {
	           btn.addClass('control-on');
	           
		   	   	for(var i =0; i <markersS.length; i++){
			   		markersS[i].setMap(null);
			   	}
	           
	       } else {
	           btn.removeClass('control-on');
	       }
	   });

	   btn.on("click", function(e) {
	       e.preventDefault();

	       if (bicycleLayer.getMap()) {
	           bicycleLayer.setMap(null);
	       } else {
	           bicycleLayer.setMap(nMap.map);
	       }
	   });
   }
   
   function setSearchPlaceBtn() {
	   var btn = $('#searchPlaceBtn');
	   
  		btn.on("click", function(e) {
   		    e.preventDefault();

	   		var pwidth = 700;
	 		var pheight = 780;
	 		var winL = (screen.width-pwidth)/2;
	 		var winT = (screen.height-pheight)/2;
	 		var lat = "";
	 		var lon = "";
	 		
	 		window.open("/common/pop/updLocationMapPop.do?outptt=%uC704%uCE58%uC9C0%uB3C4%uCC3E%uAE30&latitude="+ lat +"&longitude=" + lon , "winpop2", "width=600, height=770, top="+winT+", left="+winL , "scrollbars=yes");
	 		
	 		
   		});
  		
  		var btnGo = $('#goPlaceBtn');
  		
  		btnGo.on("click", function(e) {
   		    e.preventDefault();
   		 	
   			var center = new naver.maps.LatLng( $('#latitude').val(),  $('#longitude').val() );
			nMap.map.setCenter(center);
			 
	   		var cityhall = new naver.maps.LatLng(  $('#latitude').val(),  $('#longitude').val() ),
	   		    marker = new naver.maps.Marker({
	   		        map: nMap.map,
	   		        position: cityhall
	   		    });

	   		var contentString = [
	   		        '<div class="iw_inner">',
	   		     	$('#addr').val(),
	   		        '</div>'
	   		    ].join('');
	
	   		var infowindow = new naver.maps.InfoWindow({
	   		    content: contentString
	   		});
	
	   		naver.maps.Event.addListener(marker, "click", function(e) {
	   		    if (infowindow.getMap()) {
	   		        infowindow.close();
	   		     	marker.setMap(null);
	   		        
	   		    } else {
	   		        infowindow.open(nMap.map, marker);
	   		    }
	   		});
	   		
	   		nMap.map.setZoom(17);
	
	   		infowindow.open(nMap.map, marker);
			
			
  		});    
  		
  		
   }
							     

   function setTraffic(){
	   
	   var trafficLayer = new naver.maps.TrafficLayer({
		    interval: 300000 // 5분마다 새로고침 (최소값 5분)
		});
   		var btn = $('#traffic');
   	   
   	   naver.maps.Event.addListener(nMap.map, 'trafficLayer_changed', function(trafficLayer) {
   		    if (trafficLayer) {
   		        btn.addClass('control-on');
   		        $("#autorefresh").parent().show();
   		        $("#autorefresh")[0].checked = true;
   		    } else {
   		        btn.removeClass('control-on');
   		        $("#autorefresh").parent().hide();
   		    }
   		});

   		btn.on("click", function(e) {
   		    e.preventDefault();

   		    if (trafficLayer.getMap()) {
   		        trafficLayer.setMap(null);
   		    } else {
   		        trafficLayer.setMap(nMap.map);
   		    }
   		});

   		$("#autorefresh").on("click", function(e) {
   		    var btn = $(this),
   		        checked = btn.is(":checked");

   		    if (checked) {
   		        trafficLayer.startAutoRefresh();
   		    } else {
   		        trafficLayer.endAutoRefresh();
   		    }
   		});
 
   }
   
	function setStationBtn(){
	// currentStatus.orgMarkersS	   
		$("#station").on("click", function(e) {
   		    var btn = $(this),
   		        checked = btn.hasClass("control-on");

   		    if (checked) {
 	           btn.removeClass('control-on');
 	          	postAjaxLoading("start");
 	           	markersS.forEach(function(marker){marker.setMap(null)});
 	           	postAjaxLoading("end");
 	           
   		    } else {
   		    	btn.addClass('control-on');
   		    	postAjaxLoading("start");
   		    	currentStatus.orgMarkersS.forEach(function(marker) { marker.setMap(nMap.map)} 
   		    	
   		    	);
   		    	postAjaxLoading("end");
   		    }
   		});
		
	}
	
	function seLostBtn(){
		$("#lost").on("click", function(e) {
   		    var btn = $(this),
   		        checked = btn.hasClass("control-on");

   		    if (checked) {
 	           btn.removeClass('control-on');
 	          	postAjaxLoading("start");
 	          	markersL.forEach(function(marker) { marker.setMap(null)});
 	           	postAjaxLoading("end");
 	           
   		    } else {
   		    	btn.addClass('control-on');
   		    	currentStatus.orgMarkersL.forEach(function(marker) { marker.setMap(nMap.map)} );
   		    }
   		});		  
	}
	
	function setFaultBtn(){
		$("#fault").on("click", function(e) {
   		    var btn = $(this),
   		        checked = btn.hasClass("control-on");

   		    if (checked) {
 	           btn.removeClass('control-on');
 	          	postAjaxLoading("start");
 	          	markersN.forEach(function(marker){marker.setMap(null)});
 	           	postAjaxLoading("end");
 	           
   		    } else {
   		    	btn.addClass('control-on');
   		    	postAjaxLoading("start");
   		    	currentStatus.orgMarkersN.forEach(function(marker){marker.setMap(nMap.map)});
   		    	postAjaxLoading("end");
   		    }
   		});	
	}
							    
</script>		

<style>
	 .buttons, #wrap .checkbox {
	    position: absolute;
	    top: 0;
	    left: 0;
	    width:100%;
	    z-index: 1000;
	    padding: 5px;
	}
	
	 .buttons .control-btn {
	    margin: 0 5px 5px 0;
	 }
	 
	.control-btn {
	    margin: 0;
	    color: #555;
	    padding: 2px 6px;
	    background: #fff;
	    border: solid 1px #333;
	    cursor: pointer;
	    -webkit-border-radius: 5px;
	    outline: 0 none;
	    border-radius: 5px;
	    box-shadow: 2px 2px 1px 1px rgba(0, 0, 0, 0.5) !important;
	}
	
	.control-on {
	    background-color: #2780E3;
	    color: #FFF;
	}
	
	.staBox ul {
	   list-style: none; /* Remove default bullets */
	   vertical-align: middle;
	}
	
	.staBox ul li {
	line-height:20px; height:20px}
	
	.staBox ul li img {
		vertical-align: middle;
		width: 10px;
		height: 10px;
	}
	
	 .buttons1 {
	    position: absolute;
	    top: 0;
	    right: 0;
	    width:auto;
	    height:auto;
	    z-index: 1000;
	    padding: 5px;
	}

</style>

<body>

<div id="mapDiv" style="height:100%"></div>
<div class="buttons">
    <input id="count" type="text" class="control-btn" value="300초 후 목록이 갱신됩니다." style="width:160px"/>
    <input id="traffic" type="button" value="교통상황" class="control-btn">
    <input id="bicycle" type="button" value="자전거도로" class="control-btn">
    <input id="station" type="button" value="대여소" class="control-btn control-on">
    <!-- <input id="lost" 	type="button" value="분실" class="control-btn control-on">
    <input id="fault" 	type="button" value="강반" class="control-btn control-on"> -->

    <input id="searchPlaceBtn" 	type="button" value="위치팝업" class="control-btn">
    <input id="goPlaceBtn" 	type="button" value="이동" class="control-btn">
    
    <input id="latitude" 	type="hidden" value="" class="control-btn">
    <input id="longitude" 	type="hidden" value="" class="control-btn">
    <input id="addr" 					type="hidden" value="" class="control-btn">
    <input id="parkingLocationDiv" 		type="hidden" value="" class="control-btn">
    <input id="teamName" 		type="hidden" value="" class="control-btn">
    <input id="searchValue" 		type="hidden" value="" class="control-btn">
    
    
    <div class="checkbox" style="display: block;">
        <input id="autorefresh" type="checkbox" checked="checked" value="1" style="visibility: hidden"><label for="autorefresh"></label>
    </div>
    
</div>    
 <div class="buttons1">   
     <div class="staBox mapguide" >
           <b style="margin-bottom: 10px">거치율(%)</b>
           <ul>
	           <li><img src="/images/icon_b1_76.png" />&nbsp;76이상</li>
	           <li><img src="/images/icon_b1_26.png" />&nbsp;26~75</li>
	           <li><img src="/images/icon_b1_1.png"  />&nbsp;1~25</li>
	           <li><img src="/images/icon_b1_0.png"  />&nbsp;0</li>
           </ul>
           <br/>
           <b style="margin-bottom: 10px">종류</b>
           
           <ul>
	           <li>	<img src="/images/icon_b1_76.png" />&nbsp;QR,LCD</li>
	           <li><img src="/images/icon_b2_76.png" 	   />&nbsp;QR전용</li>
	           <li><img src="/images/mapIcon/E/icon_b3_4.png" 	   />&nbsp;고장</li>	
	           <!-- <li><img src="/images/icon_bike_b4.png"     />&nbsp;분실</li>
	           <li><img src="/images/icon_bike_b3.png"     />&nbsp;강반</li> -->
	           <li><img src="/images/staStop_ss150p.png"   />&nbsp;초과거치</li>
	           <li><img src="/images/mapIcon/T/icon_b5_0.png"  />&nbsp;임시폐쇄</li>
           </ul>
           
       </div>
</div>
	
     <form id="searchFrm" >
         <input type="hidden" name="stationOrderType" value="${condition.stationOrderType}">
         <input type="hidden" name="sharedOrderType" value="${condition.sharedOrderType}">
         <input type="hidden" name="orderColumn"   value="${condition.orderColumn}">
         <input type="hidden" name="viewType"      value="${condition.viewType}">
         <input type="hidden" name="stationId"  id="stationId"   value="${condition.stationId }">
         <input type="hidden" name="stationGrpSeq" id="stationGrpSeq" value="${condition.stationGrpSeq }">
         <input type="hidden" name="defaultLevel" value="${condition.defaultLevel }">
         <input type="hidden" name="defaultTeamYn" value="${condition.defaultTeamYn}">
         <input type="hidden" name="paramSearchWord" id="paramSearchWord" value="${condition.paramSearchWord}">
         <input type="hidden" name="paramSearchType" id="paramSearchType" value="${condition.paramSearchType}">
         <input type="hidden" name="batteryStusCd" id="batteryStusCd" value="${condition.paramSearchType}">
         <input type="hidden" name="stationSeCd" id="stationSeCd" value="${condition.paramSearchType}">
     </form>       
 
 </body>