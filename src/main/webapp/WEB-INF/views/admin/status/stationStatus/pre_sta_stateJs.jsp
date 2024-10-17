
<!-- <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=zc9ttduqic&callback=draw"></script> -->
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=0tvu3iygqg&callback=draw"></script>
<script type="text/javascript" src="/js/stationCommonMapv.js"></script>
<script type="text/javascript" src="/js/common_barocle.js"></script>
<script type="text/javascript">
	
	var markersN = [];
	var markersS = [];
	var markersB = [];
	
	function draw(){
		
		var trafficLayer = new naver.maps.TrafficLayer({
			interval: 2000 // 2ì´ë§ë¤ ìë¡ê³ ì¹¨
		});
		
		var img = {icon: {}};
		var opt = {};
		var markerOptions = {icon: {}};
		
		var totalCount = 0;
		var stationName = ""; 
		
		<c:forEach var="impulse" items="${exeImpulseList}" varStatus="status1">
			markerOptions.position = new naver.maps.LatLng("${impulse.latitude}",  "${impulse.longitude}");
			markerOptions.map = nMap.map;
			//markerOptions.icon.url = "/images/ico_01.png";
			markerOptions.icon.content = "<img src='/images/icon_bike_big3.png' alt='' style='width: 30px'>";
			markerOptions.type	 = "station";
			var marker = new naver.maps.Marker(markerOptions);
			markersN.push(marker);
			  naver.maps.Event.addListener(marker, 'click', getClickHandlerMove("${impulse.rentBikeNo}"
					, "${impulse.enfrcReturnHistSeq}"
					, "${impulse.latitude}"
					, "${impulse.longitude}"
					
			  )); 
			marker.setMap(nMap.map);
		</c:forEach>
		
		
		<c:forEach var="bks" items="${bikeLostList}" varStatus="status1">
			markerOptions.position = new naver.maps.LatLng("${bks.xPos}",  "${bks.yPos}");
			markerOptions.map = nMap.map;
		//markerOptions.icon.url = "/images/ico_01.png";
			// 2021.05.25 ë°°í°ë¦¬ ë¹ì¨ íì
			var addBatt = "";
			if( parseInt( "${bks.devBatt}" ) < 50 ) {
				addBatt= "<span style='color:red; background:white;border:1px solid grey'>" + "${bks.devBatt}" + "%</span><br/>"
			} else {
				addBatt= "<span style='color:black; background:white;border:1px solid grey'>" + "${bks.devBatt}" + "%</span><br/>"
			}
			markerOptions.icon.content = addBatt + "<img src='/images/icon_bike_big4.png' alt='' style='width: 30px'>";
			markerOptions.type	 = "station";
			var marker = new naver.maps.Marker(markerOptions);
			markersN.push(marker);
			
			
		   naver.maps.Event.addListener(marker, 'click', getClickHandlerLostMove("${bks.bikeNo}"
				, "${bks.xPos}"
				, "${bks.yPos}"
				, "${bks.modDttm}"
				, "${bks.regDttm}"
				
		  ));  
		marker.setMap(nMap.map);
	</c:forEach>		
		
		
		<c:forEach var="info" items="${stationList}" varStatus="status">
			<c:if test="${status.last}" >
				nMap.map.setCenter(new naver.maps.LatLng("${info.stationLatitude}","${info.stationLongitude}"));
			</c:if>
			markerOptions.position = new naver.maps.LatLng("${info.stationLatitude}",  "${info.stationLongitude}");
			markerOptions.map = nMap.map;
			<c:choose>
			 <c:when test="${info.stationSeCd == 'RAK_001'}"> 
		   		 totalCount = Number("${info.parkingBikeTotCnt}") + Number("${info.parkingQRBikeCnt}") ;
		   		 stationName = "${info.stationName}";
			 </c:when>
			 <c:when test="${info.stationSeCd == 'RAK_002'}"> 
		   		 totalCount = Number("${info.parkingQRBikeCnt}") + Number("${info.parkingELECBikeCnt}");
		   		 stationName = "${info.stationName}";
			 </c:when>
			 <c:when test="${info.stationSeCd == 'RAK_003'}"> 
		   		 totalCount = Number("${info.parkingBikeTotCnt}") + Number("${info.parkingQRBikeCnt}") ;
		   		 stationName = "${info.stationName}";
			 </c:when>
			 <c:when test="${info.stationSeCd == 'RAK_004'}"> 
				 totalCount = Number("${info.parkingQRBikeCnt}") + Number("${info.parkingELECBikeCnt}");
				 stationName = "${info.stationName}";
		 	</c:when>
		 	</c:choose>
		 	
			markerOptions.icon.content = "<div><img src='${info.stationAddr}'></div>";
			
			markerOptions.type	 = "station";
			var marker = new naver.maps.Marker(markerOptions);
			marker.setMap(nMap.map);
	  		naver.maps.Event.addListener(marker, 'click', getClickHandler("${info.stationId}"
	  																   // , "${info.stationName}"
	  																	, stationName
																		, "${info.parkingBike}"  
																		, "${info.systemWarning}"
																		, "${info.shared}"
																		, "${info.stationLatitude}"
																		, "${info.stationLongitude}" ));
	  		markersS.push(marker);
	  		
		</c:forEach>
		
		reDrawIndex++;
		
		//2020-11-13 : ë§ì»¤ íí° ìì
		currentStatus.orgMarkersN = markersN;
		currentStatus.orgMarkersS = markersS;
		
	}
	
	reDraw = function (){
		
		nMap.initMap();
		switch ( reDrawIndex %3 ){
		case 0 :
			for (var mIndex = 0; mIndex < markersN.length; mIndex++) {
				marker = markersN[mIndex]
				marker.setMap(nMap.map);
			
			}
			for (var mIndex = 0; mIndex < markersS.length; mIndex++) {
				marker = markersS[mIndex]
				marker.setMap(nMap.map);

				if( mIndex == ( markersS.length - 1)) {
					nMap.map.setCenter( marker.position );
				}
			
			}
		
		case 1 :
			for (var mIndex = 0; mIndex < markersN.length; mIndex++) {
				marker = markersN[mIndex]
				marker.setMap(nMap.map);
				
				if( mIndex == ( markersN.length - 1)) {
					nMap.map.setCenter( marker.position );
				}

			}
		break;	
		case 2 :
			for (var mIndex = 0; mIndex < markersS.length; mIndex++) {
				marker = markersS[mIndex]
				marker.setMap(nMap.map);
				if( mIndex == ( markersS.length - 1)) {
					nMap.map.setCenter( marker.position );
				}
			}
		break;
		}
		
		$("#reSetBtn").html(reDrawIndex %3 );
		reDrawIndex++;
	}
	
	function batdraw(data){
		
		//ë§ì»¤ ì­ì  : ë¤ ì§ì´ í ë¤ì ë§ì»¤ ì½ì
		markerRemoveAll();
		
		
		var img = {icon: {}};
		var opt = {};
		var markerOptions = {icon: {}};
		
		var totalCount = 0;
		var stationName = ""; 
		
		var bikeBatLowStationListCnt = data.bikeBatLowStationList.length;
		
		for(var i = 0; i < bikeBatLowStationListCnt; i++){
			
			var bikeBatLow = data.bikeBatLowStationList[i];
			
			markerOptions.position = new naver.maps.LatLng(bikeBatLow.stationLatitude,  bikeBatLow.stationLongitude);
			markerOptions.map = nMap.map;
			
			//ë°°í°ë¦¬ë¶ì¡±í ìì ê±° ì´ ê°ì íìë¥¼ ìí´ ì ì¥
			currentStatus.batLowBikeCnt += Number(bikeBatLow.parkingBikeTotCnt);
			
			var bikeCnt = bikeBatLow.parkingBikeTotCnt+"";
			var left = -0.2;
			var bottom = '0';
			
			if(bikeCnt.length == 1){
				
				if(Number(bikeCnt) == 1){
				}else{
					
					left += (bikeCnt-1) * -1.65;
					
				}
				
			}else{
				
				var tenUnit = bikeCnt.substring(0,1);
				var oneUnit = bikeCnt.substring(1);
				
				if(Number(oneUnit) == 0){
					
					left += 9 * -1.65;
					
					bottom = (tenUnit - 1) * 1.65;
					
				}else{
					
					if(Number(oneUnit) == 1){
					}else{
						
							
						left += (oneUnit-1) * -1.65;
						
					}
					
					bottom = tenUnit * 1.65 ;
				}
				
			}
				
			markerOptions.icon.content = "<div style='width: 32px; height: 32px; overflow: hidden;'><img src='/images/mapIcon/number/numbers_red_icons_s.png' style='width: auto; position: relative; left: "+left+"cm; bottom: "+bottom+"cm;' /></div>";
			markerOptions.type	 = "station";
			
			var marker = new naver.maps.Marker(markerOptions);
			
			markersB.push(marker);
			
			naver.maps.Event.addListener(marker, 'click', getClickHandlerBat(bikeBatLow.parkingBike
					, bikeBatLow.bikeStatusName
					, bikeBatLow.stationId
					, bikeBatLow.stationName
					, bikeBatLow.stationLatitude
					, bikeBatLow.stationLongitude
					
			  ));		 
			
			if(i == (bikeBatLowStationListCnt -1 ) ){
				
		   		var center = new naver.maps.LatLng(bikeBatLow.stationLatitude, bikeBatLow.stationLongitude);
		   		nMap.map.setCenter(center);
				
			}
			
			marker.setMap(nMap.map);
			
		}
		
		//ë°°í°ë¦¬ë¶ì¡±í ìì ê±° ì´ ê°ì íì
		$(".listalign").append('<span class="batLowBike" style="float: right; position: relative; top: 6px;">ë°°í°ë¦¬ë¶ì¡± ê±´ì : '+currentStatus.batLowBikeCnt+'</span>');
		
	}
	
	function markerRemoveAll(){
		
		for(var i =0; i <markersN.length; i++){
			markersN[i].setMap(null);
		}
		
		for(var i =0; i <markersS.length; i++){
			markersS[i].setMap(null);
		}
		
		for(var i =0; i <markersB.length; i++){
			markersB[i].setMap(null);
		}
		
	}
	
	
	linkStation = function(stationId) {
		$("[name='stationId']").val(stationId);
		// 2018-11-25 ìì°½ì´ê¸°ë¡ ë³ê²½
		$("#searchFrm").attr({action : "<c:out value='/moveCurrentStationDetail.do'/>", method : "post" }).submit();
	};
	
	function getClickHandlerLostMove(rentBikeNo, latitude,longitude, modDttm, regDttm) {
		return function(e) {
		 
			//var href = "nmap://place?lat=" + latitude + "&lng=" + longitude   + "&name=" +  rentBikeNo + "&zoom=20&appname=com.example.myapp"; 
			
			var href = "nmap://route/car?dlat=" + latitude + "&dlng=" + longitude   + "&dname=" +  rentBikeNo + "&zoom=20&appname=bikeSeoul";
			
			var cont = '<DIV  id="infoBox" style="border:2px solid #555; background:#fff; font-family:dotum; width:230px; text-align:left;line-height:150%;" >';
			cont += '	   <p style="border-bottom:1px solid #c9c9c9; font-size:14px;color:#333; position:relative; text-decoration:underline">';
			cont += '		   <a href="#" style="position:absolute; top:3px; right:10px" class="mpclose"><img  name="close" src="/images/stationClose.gif" alt="ëì¬ì ì ë³´ë«ê¸°" /></a>';
			cont += '	   </p>';
			cont += '	   <ul style="display:inline-block; vertical-align:middle; font-size:14px;margin:5px;">';
			cont += '		   <li>ìì ê±° ë²í¸  : <span style="color:#000099;">'+rentBikeNo+'</span></li>';
			cont += '		   <li>ìµì¢ì í¸	 : <span style="color:#000099;">'+ modDttm+'</span></li>';
			cont += '		   <li>ê°±ì  ìê°	: <span style="color:#000099;">'+regDttm+'</span></li>';
			cont += '		   <li><p class="cacao" style="background:blue;color:white;">ì¹´ì¹´ì¤ì§ëë¡ ê¸¸ì°¾ê¸°</p></li>';


			cont += '		   <li><p class="naver" style="background:green;color:white;"><a target="_blank()"  href="';
			cont += href;
			cont += '"> ë¤ì´ë²ì§ëë¡ ê¸¸ì°¾ê¸°(ì±ì ì©)</a></p></li>';		
			
			cont += '	   </ul>';
			cont += '   </DIV>';
			
			var infoWindow = new naver.maps.InfoWindow({
				content: cont
			});
			
			///////////////////2020-11-10 ëª¨ë°ì¼ ìµì í ìì (ì¤ ë ë²¨ì ë°ë¼ ëì ¹ë³ê²½) - start/////////////////
			var zlvl = nMap.map.getZoom()- 15;
			var zlat, zlng;
			
			if(zlvl == 0){
				
				zlat = (e.coord.lat()+0.00155);
				zlng = (e.coord.lng()+0.00155);
				
			}else if( zlvl > 0){
				
				if( zlvl < 5){
				
		   			zlat = (e.coord.lat()+ (0.00155*(1/zlvl*0.38) ) );
		   			zlng = (e.coord.lng()+ (0.00155*(1/zlvl*0.4) ) );
		   		
				}else{
					
					zlat = (e.coord.lat()+ (0.00155*(1/zlvl*0.2) ) );
		   			zlng = (e.coord.lng()+ (0.00155*(1/zlvl*0.095) ) );
					
				}
				
			}else if( zlvl < 0){
				
				if(zlvl < -3){
					
					zlat = (e.coord.lat()+ (-0.00155*(zlvl*(zlvl*-1.35) ) ) );
					zlng = (e.coord.lng()+ (-0.00155*(zlvl*(zlvl*-1.35) ) ) );
					
				}else{
					
					zlat = (e.coord.lat()+ (-0.00155*(zlvl+zlvl) ) );
					zlng = (e.coord.lng()+ (-0.00155*(zlvl+zlvl) ) );
					
				}
				
			}
			 
	   		var center = new naver.maps.LatLng(zlat, zlng);
	   		infoWindow.open(nMap.map,e.coord);
	   		
	   		nMap.map.setCenter(center); //2020-11-04 : ë§ì»¤ë¥¼ ì¤ìì¼ë¡ ì´ë
			///////////////////2020-11-10 ëª¨ë°ì¼ ìµì í ìì(ì¤ ë ë²¨ì ë°ë¼ ëì ¹ë³ê²½) - end/////////////////
	   		
   			$("#infoBox a img").on("click", function(e){
			   	e.preventDefault();
			   	infoWindow.close(nMap.map,center);
			});
	 
		/* 	$("#infoBox ul .cacao").on("click", function(e){
			   	e.preventDefault();
			   	$("#searchFrm").attr({action : "http://map.kakao.com/link/to/'" +  ',' + latitude +',' + longitude , method : "post", target:"_blank"}).submit();
			}); */
	   		
		}			 
	}	
	
	function getClickHandlerMove(rentBikeNo, enfrcReturnHistSeq, latitude,longitude) {
		return function(e) {
		 
			//var href = "nmap://place?lat=" + latitude + "&lng=" + longitude   + "&name=" +  rentBikeNo + "&zoom=20&appname=com.example.myapp";
			var href = "nmap://route/car?dlat=" + latitude + "&dlng=" + longitude   + "&dname=" +  rentBikeNo + "&zoom=20&appname=bikeSeoul";
			
			
			var cont = '<DIV  id="infoBox" style="border:2px solid #555; background:#fff; font-family:dotum; width:230px; text-align:left;line-height:150%;" >';
			cont += '	   <p style="border-bottom:1px solid #c9c9c9; font-size:14px;color:#333; position:relative; text-decoration:underline">';
			cont += '		   <a href="#" style="position:absolute; top:3px; right:10px" class="mpclose"><img  name="close" src="/images/stationClose.gif" alt="ëì¬ì ì ë³´ë«ê¸°" /></a>';
			cont += '	   </p>';
			cont += '	   <ul style="display:inline-block; vertical-align:middle; font-size:14px;margin:5px;">';
			cont += '		   <li>ìì ê±° ë²í¸  : <span style="color:#000099;">'+rentBikeNo+'</span></li>';
			cont += '		   <li>ìì¹ ìì¸ë³´ê¸°  : <span class="detail" style="color:#000099;">'+'<a href="#"> ìì¸ë³´ê¸°</a>'+'</span></li>';
			cont += '		   <li>ê°ë° ìì¸ë³´ê¸°  : <span class="exeImpul" style="color:#000099;">'+'<a href="#"> ìì¸ë³´ê¸°</a>'+'</span></li>';
			cont += '	   </ul>';
			cont += '   </DIV>';
			
			var infoWindow = new naver.maps.InfoWindow({
				content: cont
			});	

			var center = new naver.maps.LatLng(e.coord);
			
	   		nMap.map.setCenter(e.coord); //2020-11-04 : ë§ì»¤ë¥¼ ì¤ìì¼ë¡ ì´ë
	   		
	   		infoWindow.open(nMap.map,e.coord);
				
			 		$("#infoBox a img").on("click", function(e){
					   	e.preventDefault();
					   	infoWindow.close(nMap.map,center);
					});
			
		 			$("#infoBox ul .detail").on("click", function(e){
					   	e.preventDefault();
					   	
					   	var pwidth = 600;
						var pheight = 730;
						var winL = (screen.width-pwidth)/2;
						var winT = (screen.height-pheight)/2;
						var lat = "";
						var lon = "";
						
						window.open("/common/pop/entrcReutnViewPop.do?outptt=%uC704%uCE58%uC9C0%uB3C4%uCC3E%uAE30&latitude="+ lat +"&longitude=" + lon + "&enfrcReturnHistSeq=" + enfrcReturnHistSeq , "winpop2", "width=600, height=730, top="+winT+", left="+winL+" , scrollbars=yes");
					}); 
		 			
		 			$("#infoBox ul .exeImpul").on("click", function(e){
					   	e.preventDefault();
					   	var pwidth = 600;
						var pheight = 730;
						var winL = (screen.width-pwidth)/2;
						var winT = (screen.height-pheight)/2;
						var lat = "";
						var lon = "";
						window.open("/getExeImpulseList.do?searchWord=" + rentBikeNo , "winpop2", "width=600, height=730, top="+winT+", left="+winL+" , scrollbars=yes");
					}); 
			 
					$("#infoBox ul .cacao").on("click", function(e){
					   	e.preventDefault();
					   	$("#searchFrm").attr({action : "http://map.kakao.com/link/to/'" + '' + ',' + latitude +',' + longitude , method : "post", target:"_blank"}).submit();
					});  
					

				/* 	$("#infoBox ul .naver").on("click", function(e){
					   	e.preventDefault();
					   	$("#searchFrm").attr({action : "nmap://map?lat=" + latitude + "&lng=" + longitude   + "&zoom=20&appname=com.example.myapp" , method : "post", target:"_blank"}).submit();
					}); */
			}
	}	
	
	
	
	function getClickHandler(stationId, stationName, rackInfo, bikeInfo, shared, latitude,longitude) {
		return function(e) {
		
	   var href = "nmap://route/car?lat=" + latitude + "&lng=" + longitude   + "&name=" +  stationName + "&zoom=20&appname=com.example.myapp"; 	
	   
	   
		var cont = '<DIV  id="infoBox" style="border:2px solid #555; background:#fff; font-family:dotum; width:230px; text-align:left;line-height:150%;" >';
		cont += '	   <p style="border-bottom:1px solid #c9c9c9; font-size:14px;color:#333; position:relative; text-decoration:underline">';
		cont += '		   <span style="margin:10px 0 10px 10px; font-weight:bold; display:block;">'+stationName+'</span>';
		cont += '		   <div style="position:absolute; top:3px; right:3px; width: 40px; height: 40px;" class="mpclose"><a href="#"><img  name="close" style="width: auto; position: relative; top: 8px; left: 8px;" src="/images/stationClose.gif" alt="ëì¬ì ì ë³´ë«ê¸°" /></a></div>';
		cont += '	   </p>';
		cont += '	   <ul style="display:inline-block; vertical-align:middle; font-size:14px;margin:5px;">';
		cont += '		   <li>자전거 갯수 : <span style="color:#000099;">'+rackInfo+'</span></li>';
//		cont += '		   <li>ìì ê±°  : <span style="color:#000099;">'+bikeInfo+'</span></li>';
//		cont += '		   <li>ê±°ì¹ì¨(%)  : <span style="color:#000099;">'+shared+'%</span></li>';
		cont += '		   <li><p class="cacao" style="background:blue;color:white;">카카오지도로 길찾기</p></li>';


		cont += '		   <li><p class="naver" style="background:green;color:white;"><a target="_blank()" href="';
		cont += href;
		cont += '">네이버지도로 길찾기(앱전용)</a></p></li>';		
		
		cont += '	   </ul>';
		cont += '	   <p style="text-align:center; margin-bottom:-16px;"><img src="/images/stationPos.png" style="display:block; margin:0 auto;width:21px;height:16px;" alt="" /></p>';
		cont += '   </DIV>';	
	   	
		var infoWindow = new naver.maps.InfoWindow({
				content: cont
			});	
		
		///////////////////2020-11-10 ëª¨ë°ì¼ ìµì í ìì (ì¤ ë ë²¨ì ë°ë¼ ëì ¹ë³ê²½) - start/////////////////
		var zlvl = nMap.map.getZoom()- 15;
		var zlat, zlng;
		
		if(zlvl == 0){
			
			zlat = (e.coord.lat()+0.00155);
			zlng = (e.coord.lng()+0.00155);
			
		}else if( zlvl > 0){
			
			if( zlvl < 5){
			
	   			zlat = (e.coord.lat()+ (0.00155*(1/zlvl*0.38) ) );
	   			zlng = (e.coord.lng()+ (0.00155*(1/zlvl*0.4) ) );
	   		
			}else{
				
				zlat = (e.coord.lat()+ (0.00155*(1/zlvl*0.2) ) );
	   			zlng = (e.coord.lng()+ (0.00155*(1/zlvl*0.095) ) );
				
			}
			
		}else if( zlvl < 0){
			
			if(zlvl < -3){
				
				zlat = (e.coord.lat()+ (-0.00155*(zlvl*(zlvl*-1.35) ) ) );
				zlng = (e.coord.lng()+ (-0.00155*(zlvl*(zlvl*-1.35) ) ) );
				
			}else{
				
				zlat = (e.coord.lat()+ (-0.00155*(zlvl+zlvl) ) );
				zlng = (e.coord.lng()+ (-0.00155*(zlvl+zlvl) ) );
				
			}
			
		}
		 
   		var center = new naver.maps.LatLng(zlat, zlng);
   		
   		nMap.map.setCenter(center); //2020-11-04 : ë§ì»¤ë¥¼ ì¤ìì¼ë¡ ì´ë
   		
   		infoWindow.open(nMap.map,e.coord);
   		///////////////////2020-11-10 ëª¨ë°ì¼ ìµì í ìì (ì¤ ë ë²¨ì ë°ë¼ ëì ¹ë³ê²½) - end/////////////////
   		
				$("#infoBox .mpclose").on("click", function(e){
				   	e.preventDefault();
				   	infoWindow.close(nMap.map,center);
				});
		
	 			$("#infoBox p span").on("click", function(e){
				   	e.preventDefault();
				   	$("[name='stationId']").val(stationId);
				   	$("#searchFrm").attr({action : "<c:out value='/moveCurrentStationDetail.do'/>", method : "post" }).submit();
				}); 
		 
				$("#infoBox ul .cacao").on("click", function(e){
				   	e.preventDefault();
				   	$("#searchFrm").attr({action : "http://map.kakao.com/link/to/'" + stationName + ',' + latitude +',' + longitude , method : "post", target:"_blank"}).submit();
				});

		}
	}
	
	function getClickHandlerBat(parkingBike, bikeStatusName, stationId, stationName, latitude, longitude) {
		
		return function(e) {
		
		var bikeNo;
		
		if(parkingBike.indexOf(",") > -1){
			
			bikeNo = parkingBike.split(",");
			
		}else{
			
			bikeNo = [];
			bikeNo.push(parkingBike);
			
		}
		
		var href = "nmap://route/car?lat=" + latitude + "&lng=" + longitude   + "&name=" +  stationName + "&zoom=20&appname=com.example.myapp";
			
		var cont = '<DIV  id="infoBox" style="border:2px solid #555; background:#fff; font-family:dotum; width:230px; text-align:left;line-height:150%;" >';
		cont += '	   <p style="border-bottom:1px solid #c9c9c9; font-size:14px;color:#333; position:relative; text-decoration:underline">';
		cont += '		   <span style="margin:10px 0 10px 10px; font-weight:bold; display:block;">'+stationName+'</span>';
		cont += '		   <div style="position:absolute; top:3px; right:3px; width: 40px; height: 40px;" class="mpclose"><a href="#"><img  name="close" style="width: auto; position: relative; top: 8px; left: 8px;" src="/images/stationClose.gif" alt="ëì¬ì ì ë³´ë«ê¸°" /></a></div>';
		cont += '	   </p>';
		cont += '	   <ul style="display:inline-block; vertical-align:middle; font-size:14px;margin:5px;">';
						for(var i = 0; i < bikeNo.length; i++){
							
		cont += '		   <li>ìì ê±°  : <span style="color:#000099;">'+bikeNo[i]+'</span></li>';
		
						}
		cont += '		   <li><p class="cacao" style="background:blue;color:white;">ì¹´ì¹´ì¤ì§ëë¡ ê¸¸ì°¾ê¸°</p></li>';
		cont += '		   <li><p class="naver" style="background:green;color:white;"><a target="_blank()" href="';
		cont += 					href;
		cont += '				"> ë¤ì´ë²ì§ëë¡ ê¸¸ì°¾ê¸°(ì±ì ì©)</a></p></li>';  
		cont += '	   </ul>';
		cont += '	   <p style="text-align:center; margin-bottom:-16px;"><img src="/images/stationPos.png" style="display:block; margin:0 auto;width:21px;height:16px;" alt="" /></p>';
		cont += '   </DIV>';	
	   	
		var infoWindow = new naver.maps.InfoWindow({
				content: cont
			});	
		
		///////////////////2020-11-10 ëª¨ë°ì¼ ìµì í ìì (ì¤ ë ë²¨ì ë°ë¼ ëì ¹ë³ê²½) - start/////////////////
		var zlvl = nMap.map.getZoom()- 15;
		var zlat, zlng;
		
		if(zlvl == 0){
			
			zlat = (e.coord.lat()+0.00155);
			zlng = (e.coord.lng()+0.00155);
			
		}else if( zlvl > 0){
			
			if( zlvl < 5){
			
	   			zlat = (e.coord.lat()+ (0.00155*(1/zlvl*0.38) ) );
	   			zlng = (e.coord.lng()+ (0.00155*(1/zlvl*0.4) ) );
	   		
			}else{
				
				zlat = (e.coord.lat()+ (0.00155*(1/zlvl*0.2) ) );
	   			zlng = (e.coord.lng()+ (0.00155*(1/zlvl*0.095) ) );
				
			}
			
		}else if( zlvl < 0){
			
			if(zlvl < -3){
				
				zlat = (e.coord.lat()+ (-0.00155*(zlvl*(zlvl*-1.35) ) ) );
				zlng = (e.coord.lng()+ (-0.00155*(zlvl*(zlvl*-1.35) ) ) );
				
			}else{
				
				zlat = (e.coord.lat()+ (-0.00155*(zlvl+zlvl) ) );
				zlng = (e.coord.lng()+ (-0.00155*(zlvl+zlvl) ) );
				
			}
			
		}
		 
			var center = new naver.maps.LatLng(zlat, zlng);
			
			nMap.map.setCenter(center); //2020-11-04 : ë§ì»¤ë¥¼ ì¤ìì¼ë¡ ì´ë
			
			infoWindow.open(nMap.map,e.coord);
			///////////////////2020-11-10 ëª¨ë°ì¼ ìµì í ìì (ì¤ ë ë²¨ì ë°ë¼ ëì ¹ë³ê²½) - end/////////////////
			
				$("#infoBox .mpclose").on("click", function(e){
				   	e.preventDefault();
				   	infoWindow.close(nMap.map,center);
				});
		
	 			$("#infoBox p span").on("click", function(e){
				   	e.preventDefault();
				   	$("[name='stationId']").val(stationId);
				   	//$("#searchFrm").attr({action : "<c:out value='/moveCurrentStationDetail.do'/>", method : "post", target:"_blank"}).submit();
				   	
				   	var objArr = [
	   		   				   {commend:"remove",selector:".ttbtncase1"}
	   		   				  ,{commend:"remove",selector:".nmt"}
	   		   			   	  ,{commend:"remove",selector:"#bikeTbl"}
	   		   			   	  ,{commend:"remove",selector:"#armTbl"}
	   		   				  ,{commend:"remove",selector:"#armTbl"}
	   		   			   	 ];
				   	
				   	window.open('/moveCurrentStationDetail.do?stationId='+stationId);
				   	
				});
	 			
				$("#infoBox ul .cacao").on("click", function(e){
				   	e.preventDefault();
				   	$("#searchFrm").attr({action : "http://map.kakao.com/link/to/'" + stationName + ',' + latitude +',' + longitude , method : "post", target:"_blank"}).submit();
				});
		 
		}
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
			   
			 if($("#div_ajax_load_image").length != 0) {
					$("#div_ajax_load_image").css({
						   "top": top+"px",
						   "left": left+"px"
					});
					$("#div_ajax_load_image").show();
			 } else {
					  $('body').append('<div id="div_ajax_load_image" style="position:absolute; top:' + top + 'px; left:' + left + 'px; width:' + width + 'px; height:' + height + 'px; z-index:9999; background:#f0f0f0; filter:alpha(opacity=50); opacity:alpha*0.5; margin:auto; padding:0; "><img src="/images/ajax_loader3.gif" style="width:50px; height:50px;"></div>');
			 }
		 
		}else{
			
			$("#div_ajax_load_image").remove();
			
		}
	}
	
	$(function(){
		<%
   			javax.servlet.http.HttpSession s = request.getSession();
   			com.dkitec.barocle.admin.login.vo.UserSessionVO uVo = (com.dkitec.barocle.admin.login.vo.UserSessionVO)s.getAttribute("userSessionVO");
   		%>
   		
		var usrGrpCd ='<%= uVo.getUsrGrpCd()%>';
		if(usrGrpCd === '1'){
			$("#filterDiv").hide();
		}
		
		if("${condition.stationGrpSeq}" != ""){
			$("#bb22").val("${condition.stationGrpSeq}");
		}
		
		if("${condition.stationId}" != ""){
			$("#aa21").val("${condition.stationId}");
		}
		
		if("${condition.stationSeCd}" != ""){
			$("#a12").val("${condition.stationSeCd}");
		}

		nMap.viewType = '${condition.viewType}';
		nMap.defaultLevel ='${condition.defaultLevel}' === '' ? '8' : '${condition.defaultLevel}';

		nMap.setMap(); 
		currentStatus.initBtn();
		currentStatus.initCommbo();
		currentStatus.initMapMarkerFilter();

		var totalPageCount = '${paginationInfo.totalPageCount}' == '' ? 1 : Number('${paginationInfo.totalPageCount}');
   		$('#prevPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			currentStatus.pageSelect(currentPageNo-1);
		});
		$('#nextPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			currentStatus.pageSelect(currentPageNo+1);
		});
		$('#movePage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			var regExp = /^[1-9]?[0-9]/;
			if(!regExp.test(currentPageNo) ||(totalPageCount < currentPageNo)){
				alert('íì¬ íì´ì§ ê°ì´ ì ìì ì´ì§ ììµëë¤.');
			}else{
				currentStatus.pageSelect(currentPageNo);
			}
		});
		
		$("#searchType").on("change", function(e){
 			$("[name='paramSearchType']").val($("#searchType").val());
			$("#searchWord").val('');
		});

		$("#batteryStusCd").change(function(){
			$("[name='defaultTeamYn']").val("N");
			find_team(false);
		});

			// 20210422 íí°ë§ ì¶ê°
			setTableGrid("ASC");
	   }
   
   );
   
   function numberWithCommas(x) {
	   return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
   }

   
   function setTableGrid(sortType){

		// ëª¨ë  table í¤ëì í´ë¦­ ì´ë²¤í¸ë¥¼ ì¤ì íë¤.  list
	var tables = document.getElementsByTagName("table");

	for( var i = 0; i < tables.length; ++i )
	{
		var headers = tables[i].getElementsByTagName("th");
		for( var j = 0; j < headers.length; ++j )
		{
			// ì§ì­ ì í¨ë²ìì ìì±í  ì¤ì²© í¨ì
			(function(table,n)	{
					headers[j].onclick = function() { SortTable( table, n , sortType )	};
				}( tables[i], j ) 
			);
		}
	}		
   }
   
function SortTable( table, n, sortType )
{
	// table ì tbody tag ê° ë°ëì ì¡´ì¬íë¤ê³  ê°ì íë¤.
	var tbody = table.tBodies[0];
	var rows = tbody.getElementsByTagName( "tr" );
	// ë°°ì´ë¡ ìì±í í, ë°°ì´ë¡ ì ë ¬íë¤.
	rows = Array.prototype.slice.call( rows, 0 );
	
	var upValue = 1;
	var downValue = -1;
	
	if(  sortType == "DESC" ) {
		upValue = 1;
		downValue = -1;
	} else {
		upValue = -1;
		downValue = 1;
	} 
	
	
	rows.sort( function( row1, row2 ) {
		
		var cell1 = row1.getElementsByTagName("td")[n];
		var cell2 = row2.getElementsByTagName("td")[n];
		var value1 = cell1.textContent || cell1.innerText;
		var value2 = cell2.textContent || cell2.innerText;
		// ëì¬ì , íëª
		if (n == 0 || n == 3 ) {
		
			if( value1 < value2 ) return upValue;
			if( value1 > value2 ) return downValue;
		
		// ìì ê±°, ê±°ì¹ì¨	
		} else {
			
			if( parseInt(value1) < parseInt(value2) ) return upValue;
			if( parseInt(value1) > parseInt(value2) ) return downValue;
			
		}
			return 0;
		}
	);
  

	// ì ë ¬ë ë°°ì´ë¡ row ë¥¼ ë¤ì ì ì¥íë¤. ë¬¸ìì ì´ë¯¸ ì¡´ì¬íë node ë ì½ìíë©´ í´ë¹ node ë ìëì¼ë¡ ì ê±°ëê³  ì ìì¹ì ì ì¥ëë¤.
	for( var i = 0; i < rows.length; ++i )
	{
		tbody.appendChild( rows[i] );
	}
}
   
   
   var currentStatus = {};
   var _this = currentStatus;
   currentStatus.stationGrpSeq = '${condition.stationGrpSeq}';
   currentStatus.stationId	 = '${condition.stationId}';
   currentStatus.viewType	= '${condition.viewType}' === "" ? "list" :'${condition.viewType}' ;
   currentStatus.stationSeCd   = '${condition.stationSeCd}';
   var reDrawIndex = 1;
   
   //{stationGrpSeq : '' stationList : [{stationId : '', latitude : '', longitude : ''}]}
   currentStatus.initBtn = function() {
   	$("#searchBtn").on("click", this.searchStation);
   	
   	$("#reSetBtn").on("click", reDraw );
   	
   	$("#bb22").on("change", function(e){
   		var tId = e.target.id;
		   var idx = $("#"+tId+" option:selected").index();
		   var subList =$("#"+tId).data().sub_data;
		   $("#aa21 option").not(':eq(0)').remove();
		   var sltsubData = subList[(idx-1)];
		   if(sltsubData !== undefined) {
			   if(sltsubData.length > 0) {
				   commCdBox.makeComboBox("S", _this.stationId, sltsubData, "aa21");
			   }
		   }
   	});
   	
   	$("#list > tbody > tr").on("click",'a', this.moveStationDetail);
  	
   	$("[name='lsalign']").on('change', function(  ){
   		setTableGrid($(":input:radio[name=lsalign]:checked").val())
   	});
   	
   };
   
   currentStatus.initCommbo = function() {
   	//ì¤íì´ì 
	   commonAjax.getStationCode( 
		   function(data) {
			   if(data != null && data.stationList != null) {
				   $("#bb22 option").not(':eq(0)').remove();
				   commCdBox.makeComboBox('S', _this.stationGrpSeq, data.stationList, "bb22");
				   $("#bb22").trigger("change");
			   }
		   }
	   );

	   // 20190512 íêµ¬ë¶ ì¶ê°
	   commonAjax.getCommonCode("DEC", 
		   function(data) {
			 if(data !== null && data.codeList !== null) {
				 var code = new Array();
				 for(var i =0; i <data.codeList.length ;i++) {
						 code.push(data.codeList[i]);
				 }
				 commCdBox.makeComboBox('CC', '', code, "batteryStusCd");
			 }
	});

	   // 20190514 íêµ¬ë¶ ì¡´ì¬í  ê²½ì° ì²ë¦¬
	   if ( "${condition.batteryStusCd}" != "") {
		   $("#batteryStusCd").val("${condition.batteryStusCd}");
		   find_team( true )
	} else {
		
		// 20200812 
		if ( "${centerId}" != "" ) {
			$("#batteryStusCd").val( "${centerId}" );
			find_team( true )	
		}
		
	} 
   };

   currentStatus.searchStation = function(e) {
   	e.preventDefault();
   	
   	nMap.defaultLevel ='${condition.defaultLevel}' === '' ? '8' : '${condition.defaultLevel}';
   	currentStatus.viewType = 'search';
   	$("[name='viewType']").val('search');
   	$("[name='stationGrpSeq']").val($("#bb22").val());
   	$("[name='stationId']").val($("#aa21").val());
   	$("[name='defaultLevel']").val(nMap.defaultLevel);
   	$("[name='paramSearchWord']").val($("#searchWord").val());
   	$("[name='paramSearchType']").val($("#searcType").val());
   	currentStatus.initData(1, 'search');
   	
   };
	  
   currentStatus.moveStationDetail = function(e) {
   	e.preventDefault();
   	$("[name='stationId']").val(e.target.id);
   	// 2018-11-25 ìì°½ì´ê¸°ë¡ ë³ê²½
   	//$("#searchFrm").attr({action : "<c:out value='/moveCurrentStationDetail.do'/>", method : "post", target:"_blank"}).submit();
   	//2020-02-21 ì± ì¬ì©ì¼ë¡ íì´ì§ ì´ëì¼ë¡ ë³ê²½
   	$("#searchFrm").attr({action : "<c:out value='/moveCurrentStationDetail.do'/>", method : "post"}).submit();
   };
   
   
   
   currentStatus.pageSelect = function(pageNo) {
   	this.initData(pageNo, 'list');
   };
   
   currentStatus.initData = function(pNo, pType) { 

	if($("#searchWord").val() != ''){
		$("[name='stationGrpSeq']").val($("#bb22").val());
		$("[name='stationId']").val($("#aa21").val());
		pType = "search";
	}
	   $("[name='viewType']").val(pType);
	   $("[name='currentPageNo']").val(pNo);
	   $("[name='defaultLevel']").val(nMap.defaultLevel);	
	   $("[name='paramSearchWord']").val($("#searchWord").val());
	   $("[name='paramSearchType']").val($("#searchType").val());

	   $("#searchFrm").attr({action: '/getStationCurrentStatus.do', method : "post"}).submit();
   };
   
   currentStatus.getBikeBatLowStationList = function(e){
   	e.preventDefault();
   	
   	$("[name='stationGrpSeq']").val($("#bb22").val());
	   $("[name='stationId']").val($("#aa21").val());
	   $("[name='viewType']").val('search');
	   $("[name='paramSearchWord']").val($("#searchWord").val());
	   $("[name='paramSearchType']").val($("#searchType").val());
	   
	   var currentPageNo = $("[name='currentPageNo']").val();

	if(currentPageNo === "") $("[name='currentPageNo']").val("0");
	   
	   var params = $("#searchFrm").serialize();
	   
	   postAjaxLoading("start");
	   
   	$.ajax({
   		type : "post",
   		url : "/getBikeBatLowStationAjax.do",
   		data : params,
   		success : function(data){
   			
   			$(".batLowBike").remove();
   			currentStatus.batLowBikeCnt = 0;
   			batdraw(data);
   			postAjaxLoading("end");
   		},
   		error : function(data){
   			alert("ì¡°íì ì¤í¨íìµëë¤.");
   			postAjaxLoading("end");
   		}
   	});
   	
   }
   
   //2020-11-17 : íí° ì´ë²¤í¸ ì¶ê°
   currentStatus.filterEventFnc = function(filter){
   	
   	var filterclass = $(filter).attr('class');
   	
   	if(filterclass === "filterExit"){
   		
   		$("#filterLabel span").each(function(){
   			
 				$(this).css("color","");
 				
   		});
   		
   	}else{
   		
		$("#filterLabel span").each(function(){
   			
			if( filterclass === $(this).attr('class')){
				
  				$(this).css("color","blue");
  				
			}else{
				
 					$(this).css("color","");
 					
			}
   		});
   		
   	}
   	
   }
   
   //2020-11-13 : ë§µ ë§ì»¤ íí°ì¶ê° ìì
   currentStatus.lastFilter = null;
   currentStatus.initMapMarkerFilter = function(){
   	
   	var width = $("#filterDiv").width();
   	$("#filterLabel").width(width);
   	
   	$(window).resize(function(){
   		
   		nMap.resize();
   		var width = $("#filterDiv").width();
	   	$("#filterLabel").width(width);
	   	
   	});
   	
   	$(".filterLstBike").on("click",function(){
   		
   		if(currentStatus.lastFilter != "Lst"){// íí°ì¬ì© - ë¶ì¤
   			
   			currentStatus.filterEventFnc(this);
   			
   			//ë§ì»¤ ì­ì 
			markerRemoveAll();
   			
			markersN = currentStatus.orgMarkersN;
			markersS = currentStatus.orgMarkersS;
			
   			//ë§ì»¤ ìì±
   			for(var i =0; i <markersN.length; i++){
   				
   				if(markersN[i]._beforeBoxedIcon.content.indexOf("icon_bike_big4") > -1){
   					markersN[i].setMap(nMap.map);
   				}
   			}
   			
   		}
   		
   		currentStatus.lastFilter = "Lst";
   	});
   	
   	$(".filterRtnBike").on("click",function(){
   		
   		if(currentStatus.lastFilter != "Rtn"){// íí°ì¬ì© - ê°ë°
   			
   			currentStatus.filterEventFnc(this);
   			
   			//ë§ì»¤ ì­ì 
			markerRemoveAll();
   			
			markersN = currentStatus.orgMarkersN;
			markersS = currentStatus.orgMarkersS;
			
   			//ë§ì»¤ ìì±
   			for(var i =0; i <markersN.length; i++){
   				
   				if(markersN[i]._beforeBoxedIcon.content.indexOf("icon_bike_big3") > -1 ){
   					markersN[i].setMap(nMap.map);
   				}
   			}
   			
   		}
   		
   		currentStatus.lastFilter = "Rtn";
   	});
   	
   	$(".filterExcess").on("click",function(){
   		
   		if(currentStatus.lastFilter != "Excess"){// íí°ì¬ì© - ê±°ì¹ì´ê³¼
   			
   			currentStatus.filterEventFnc(this);
   			
   			//ë§ì»¤ ì­ì 
			markerRemoveAll();
   			
			markersN = currentStatus.orgMarkersN;
			markersS = currentStatus.orgMarkersS;
			
   			//ë§ì»¤ ìì±
   			for(var i =0; i <markersS.length; i++){
   				
   				if(markersS[i]._beforeBoxedIcon.content.indexOf("staStop_ss150p.png") > -1){
   					markersS[i].setMap(nMap.map);
   				}
   			}
   			
   		}
   		
   		currentStatus.lastFilter = "Excess";
   	});
   	
   	$(".filterErr").on("click",function(){
   		
   		if(currentStatus.lastFilter != "Err"){// íí°ì¬ì© - ê³ ì¥ëì¬ì
   			
   			currentStatus.filterEventFnc(this);
   			
   			//ë§ì»¤ ì­ì 
			markerRemoveAll();
   			
			markersN = currentStatus.orgMarkersN;
			markersS = currentStatus.orgMarkersS;
			
   			//ë§ì»¤ ìì±
   			for(var i =0; i <markersS.length; i++){
   				
   				if(markersS[i]._beforeBoxedIcon.content.indexOf("mapIcon/E/") > -1){
   					markersS[i].setMap(nMap.map);
   				}
   			}
   			
   		}
   		
   		currentStatus.lastFilter = "Err";
   	});
   	
   	$(".filterTeamp").on("click",function(){
   		
   		if(currentStatus.lastFilter != "Teamp"){// íí°ì¬ì© - ê±°ì¹ì´ê³¼
   			
   			currentStatus.filterEventFnc(this);
   			
   			//ë§ì»¤ ì­ì 
			markerRemoveAll();
   			
			markersN = currentStatus.orgMarkersN;
			markersS = currentStatus.orgMarkersS;
			
   			//ë§ì»¤ ìì±
   			for(var i =0; i <markersS.length; i++){
   				
   				if(markersS[i]._beforeBoxedIcon.content.indexOf("mapIcon/T/") > -1){
   					markersS[i].setMap(nMap.map);
   				}
   			}
   			
   		}
   		
   		currentStatus.lastFilter = "Teamp";
   	});
   	
   	$(".filterBat").on("click",function(e){
   		
  			currentStatus.filterEventFnc(this);
  			
  			//ë§ì»¤ ì­ì 
  			markerRemoveAll();
  			
  			//ë§ì»¤ ìì±
  			currentStatus.getBikeBatLowStationList(e);
   		
   	});
   	
   	$(".filterExit").on("click",function(){// íí°ì¬ì© - ì´ê¸°í
   		
   		if(currentStatus.lastFilter != null){
   			
   			currentStatus.filterEventFnc(this);
   			
   			//ë§ì»¤ ì­ì 
			markerRemoveAll();
			
			markersN = currentStatus.orgMarkersN;
			markersS = currentStatus.orgMarkersS;
			
			//ë§ì»¤ ìì±
			for(var i =0; i <markersN.length; i++){
				markersN[i].setMap(nMap.map);
   			}
			
			for(var i =0; i <markersS.length; i++){
				markersS[i].setMap(nMap.map);
   			}
   		
   		}
   		
   		currentStatus.lastFilter = null;
   	});
   	
   }

   function find_team( flag ){
	   
	   var select = "<option value=\"\">ì í</option>"
	   var center = $("#batteryStusCd").val();
	   if($("#batteryStusCd").val() == ''){
		   $("#searchType").find("option").remove().end();
		   $("#searchType").append(select);
	   }else{
		   $("#searchType").find("option").remove().end();
		   $("#searchType").append(select);
		   
		   $.post("/admin/system/userMgmt/srchTeamList.do", "centerId="+center  , function(data) {
			   
			   for(var i=0; i < data.teamList.length; i++){
				   $("#searchType").append("<option value='"+data.teamList[i].teamSeq+"'>"+ data.teamList[i].teamNm +"</option>");
			   }						

			   // ì´ê¸° ì¡°íì¼ ê²½ì°
			   if ( flag ) {
				   if("${condition.paramSearchType}" != ""){
					$("#searchType").val("${condition.paramSearchType}");
				} else {
					
					// ë³¸ì¸ì íì ë³´ê° ìì ê²½ì°
					 $("#searchType").val("${teamSeq}");
				}
				   
			   }
			   
		   });
	   }
}   
   
   
   
</script>   