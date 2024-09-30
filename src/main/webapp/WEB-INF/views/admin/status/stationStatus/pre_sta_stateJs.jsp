
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
			interval: 2000 // 2초마다 새로고침
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
			// 2021.05.25 배터리 비율 표시
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
		   		 stationName ="(기존)"+ "${info.stationName}";
			 </c:when>
			 <c:when test="${info.stationSeCd == 'RAK_002'}"> 
		   		 totalCount = Number("${info.parkingQRBikeCnt}") + Number("${info.parkingELECBikeCnt}");
		   		 stationName ="(신규)"+ "${info.stationName}";
			 </c:when>
			 <c:when test="${info.stationSeCd == 'RAK_003'}"> 
		   		 totalCount = Number("${info.parkingBikeTotCnt}") + Number("${info.parkingQRBikeCnt}") ;
		   		 stationName ="(기존)"+ "${info.stationName}";
			 </c:when>
			 <c:when test="${info.stationSeCd == 'RAK_004'}"> 
				 totalCount = Number("${info.parkingQRBikeCnt}") + Number("${info.parkingELECBikeCnt}");
				 stationName ="(신규)"+ "${info.stationName}";
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
		
		//2020-11-13 : 마커 필터 작업
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
		
		//마커 삭제 : 다 지운 후 다시 마커 삽입
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
			
			//배터리부족한 자전거 총 개수 표시를 위해 저장
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
		
		//배터리부족한 자전거 총 개수 표시
		$(".listalign").append('<span class="batLowBike" style="float: right; position: relative; top: 6px;">배터리부족 건수 : '+currentStatus.batLowBikeCnt+'</span>');
		
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
		// 2018-11-25 새창열기로 변경
		$("#searchFrm").attr({action : "<c:out value='/moveCurrentStationDetail.do'/>", method : "post" }).submit();
	};
	
	function getClickHandlerLostMove(rentBikeNo, latitude,longitude, modDttm, regDttm) {
		return function(e) {
		 
			//var href = "nmap://place?lat=" + latitude + "&lng=" + longitude   + "&name=" +  rentBikeNo + "&zoom=20&appname=com.example.myapp"; 
			
			var href = "nmap://route/car?dlat=" + latitude + "&dlng=" + longitude   + "&dname=" +  rentBikeNo + "&zoom=20&appname=bikeSeoul";
			
			var cont = '<DIV  id="infoBox" style="border:2px solid #555; background:#fff; font-family:dotum; width:230px; text-align:left;line-height:150%;" >';
			cont += '	   <p style="border-bottom:1px solid #c9c9c9; font-size:14px;color:#333; position:relative; text-decoration:underline">';
			cont += '		   <a href="#" style="position:absolute; top:3px; right:10px" class="mpclose"><img  name="close" src="/images/stationClose.gif" alt="대여소 정보닫기" /></a>';
			cont += '	   </p>';
			cont += '	   <ul style="display:inline-block; vertical-align:middle; font-size:14px;margin:5px;">';
			cont += '		   <li>자전거 번호  : <span style="color:#000099;">'+rentBikeNo+'</span></li>';
			cont += '		   <li>최종신호	 : <span style="color:#000099;">'+ modDttm+'</span></li>';
			cont += '		   <li>갱신 시간	: <span style="color:#000099;">'+regDttm+'</span></li>';
			cont += '		   <li><p class="cacao" style="background:blue;color:white;">카카오지도로 길찾기</p></li>';


			cont += '		   <li><p class="naver" style="background:green;color:white;"><a target="_blank()"  href="';
			cont += href;
			cont += '"> 네이버지도로 길찾기(앱전용)</a></p></li>';		
			
			cont += '	   </ul>';
			cont += '   </DIV>';
			
			var infoWindow = new naver.maps.InfoWindow({
				content: cont
			});
			
			///////////////////2020-11-10 모바일 최적화 작업 (줌 레벨에 따라 동젹변경) - start/////////////////
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
	   		
	   		nMap.map.setCenter(center); //2020-11-04 : 마커를 중앙으로 이동
			///////////////////2020-11-10 모바일 최적화 작업(줌 레벨에 따라 동젹변경) - end/////////////////
	   		
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
			cont += '		   <a href="#" style="position:absolute; top:3px; right:10px" class="mpclose"><img  name="close" src="/images/stationClose.gif" alt="대여소 정보닫기" /></a>';
			cont += '	   </p>';
			cont += '	   <ul style="display:inline-block; vertical-align:middle; font-size:14px;margin:5px;">';
			cont += '		   <li>자전거 번호  : <span style="color:#000099;">'+rentBikeNo+'</span></li>';
			cont += '		   <li>위치 상세보기  : <span class="detail" style="color:#000099;">'+'<a href="#"> 상세보기</a>'+'</span></li>';
			cont += '		   <li>강반 상세보기  : <span class="exeImpul" style="color:#000099;">'+'<a href="#"> 상세보기</a>'+'</span></li>';
			cont += '	   </ul>';
			cont += '   </DIV>';
			
			var infoWindow = new naver.maps.InfoWindow({
				content: cont
			});	

			var center = new naver.maps.LatLng(e.coord);
			
	   		nMap.map.setCenter(e.coord); //2020-11-04 : 마커를 중앙으로 이동
	   		
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
		cont += '		   <div style="position:absolute; top:3px; right:3px; width: 40px; height: 40px;" class="mpclose"><a href="#"><img  name="close" style="width: auto; position: relative; top: 8px; left: 8px;" src="/images/stationClose.gif" alt="대여소 정보닫기" /></a></div>';
		cont += '	   </p>';
		cont += '	   <ul style="display:inline-block; vertical-align:middle; font-size:14px;margin:5px;">';
		cont += '		   <li>LCD/QR/새싹 : <span style="color:#000099;">'+rackInfo+'</span></li>';
//		cont += '		   <li>자전거  : <span style="color:#000099;">'+bikeInfo+'</span></li>';
		cont += '		   <li>거치율(%)  : <span style="color:#000099;">'+shared+'%</span></li>';
		cont += '		   <li><p class="cacao" style="background:blue;color:white;">카카오지도로 길찾기</p></li>';


		cont += '		   <li><p class="naver" style="background:green;color:white;"><a target="_blank()" href="';
		cont += href;
		cont += '"> 네이버지도로 길찾기(앱전용)</a></p></li>';		
		
		cont += '	   </ul>';
		cont += '	   <p style="text-align:center; margin-bottom:-16px;"><img src="/images/stationPos.png" style="display:block; margin:0 auto;width:21px;height:16px;" alt="" /></p>';
		cont += '   </DIV>';	
	   	
		var infoWindow = new naver.maps.InfoWindow({
				content: cont
			});	
		
		///////////////////2020-11-10 모바일 최적화 작업 (줌 레벨에 따라 동젹변경) - start/////////////////
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
   		
   		nMap.map.setCenter(center); //2020-11-04 : 마커를 중앙으로 이동
   		
   		infoWindow.open(nMap.map,e.coord);
   		///////////////////2020-11-10 모바일 최적화 작업 (줌 레벨에 따라 동젹변경) - end/////////////////
   		
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
		cont += '		   <div style="position:absolute; top:3px; right:3px; width: 40px; height: 40px;" class="mpclose"><a href="#"><img  name="close" style="width: auto; position: relative; top: 8px; left: 8px;" src="/images/stationClose.gif" alt="대여소 정보닫기" /></a></div>';
		cont += '	   </p>';
		cont += '	   <ul style="display:inline-block; vertical-align:middle; font-size:14px;margin:5px;">';
						for(var i = 0; i < bikeNo.length; i++){
							
		cont += '		   <li>자전거  : <span style="color:#000099;">'+bikeNo[i]+'</span></li>';
		
						}
		cont += '		   <li><p class="cacao" style="background:blue;color:white;">카카오지도로 길찾기</p></li>';
		cont += '		   <li><p class="naver" style="background:green;color:white;"><a target="_blank()" href="';
		cont += 					href;
		cont += '				"> 네이버지도로 길찾기(앱전용)</a></p></li>';  
		cont += '	   </ul>';
		cont += '	   <p style="text-align:center; margin-bottom:-16px;"><img src="/images/stationPos.png" style="display:block; margin:0 auto;width:21px;height:16px;" alt="" /></p>';
		cont += '   </DIV>';	
	   	
		var infoWindow = new naver.maps.InfoWindow({
				content: cont
			});	
		
		///////////////////2020-11-10 모바일 최적화 작업 (줌 레벨에 따라 동젹변경) - start/////////////////
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
			
			nMap.map.setCenter(center); //2020-11-04 : 마커를 중앙으로 이동
			
			infoWindow.open(nMap.map,e.coord);
			///////////////////2020-11-10 모바일 최적화 작업 (줌 레벨에 따라 동젹변경) - end/////////////////
			
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
				alert('현재 페이지 값이 정상적이지 않습니다.');
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

			// 20210422 필터링 추가
			setTableGrid("ASC");
	   }
   
   );
   
   function numberWithCommas(x) {
	   return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
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
					headers[j].onclick = function() { SortTable( table, n , sortType )	};
				}( tables[i], j ) 
			);
		}
	}		
   }
   
function SortTable( table, n, sortType )
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
	} else {
		upValue = -1;
		downValue = 1;
	} 
	
	
	rows.sort( function( row1, row2 ) {
		
		var cell1 = row1.getElementsByTagName("td")[n];
		var cell2 = row2.getElementsByTagName("td")[n];
		var value1 = cell1.textContent || cell1.innerText;
		var value2 = cell2.textContent || cell2.innerText;
		// 대여소 , 팀명
		if (n == 0 || n == 3 ) {
		
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
   	//스테이션 
	   commonAjax.getStationCode( 
		   function(data) {
			   if(data != null && data.stationList != null) {
				   $("#bb22 option").not(':eq(0)').remove();
				   commCdBox.makeComboBox('S', _this.stationGrpSeq, data.stationList, "bb22");
				   $("#bb22").trigger("change");
			   }
		   }
	   );

	   // 20190512 팀구분 추가
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

	   // 20190514 팀구분 존재할 경우 처리
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
   	// 2018-11-25 새창열기로 변경
   	//$("#searchFrm").attr({action : "<c:out value='/moveCurrentStationDetail.do'/>", method : "post", target:"_blank"}).submit();
   	//2020-02-21 앱 사용으로 페이지 이동으로 변경
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
   			alert("조회에 실패했습니다.");
   			postAjaxLoading("end");
   		}
   	});
   	
   }
   
   //2020-11-17 : 필터 이벤트 추가
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
   
   //2020-11-13 : 맵 마커 필터추가 작업
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
   		
   		if(currentStatus.lastFilter != "Lst"){// 필터사용 - 분실
   			
   			currentStatus.filterEventFnc(this);
   			
   			//마커 삭제
			markerRemoveAll();
   			
			markersN = currentStatus.orgMarkersN;
			markersS = currentStatus.orgMarkersS;
			
   			//마커 생성
   			for(var i =0; i <markersN.length; i++){
   				
   				if(markersN[i]._beforeBoxedIcon.content.indexOf("icon_bike_big4") > -1){
   					markersN[i].setMap(nMap.map);
   				}
   			}
   			
   		}
   		
   		currentStatus.lastFilter = "Lst";
   	});
   	
   	$(".filterRtnBike").on("click",function(){
   		
   		if(currentStatus.lastFilter != "Rtn"){// 필터사용 - 강반
   			
   			currentStatus.filterEventFnc(this);
   			
   			//마커 삭제
			markerRemoveAll();
   			
			markersN = currentStatus.orgMarkersN;
			markersS = currentStatus.orgMarkersS;
			
   			//마커 생성
   			for(var i =0; i <markersN.length; i++){
   				
   				if(markersN[i]._beforeBoxedIcon.content.indexOf("icon_bike_big3") > -1 ){
   					markersN[i].setMap(nMap.map);
   				}
   			}
   			
   		}
   		
   		currentStatus.lastFilter = "Rtn";
   	});
   	
   	$(".filterExcess").on("click",function(){
   		
   		if(currentStatus.lastFilter != "Excess"){// 필터사용 - 거치초과
   			
   			currentStatus.filterEventFnc(this);
   			
   			//마커 삭제
			markerRemoveAll();
   			
			markersN = currentStatus.orgMarkersN;
			markersS = currentStatus.orgMarkersS;
			
   			//마커 생성
   			for(var i =0; i <markersS.length; i++){
   				
   				if(markersS[i]._beforeBoxedIcon.content.indexOf("staStop_ss150p.png") > -1){
   					markersS[i].setMap(nMap.map);
   				}
   			}
   			
   		}
   		
   		currentStatus.lastFilter = "Excess";
   	});
   	
   	$(".filterErr").on("click",function(){
   		
   		if(currentStatus.lastFilter != "Err"){// 필터사용 - 고장대여소
   			
   			currentStatus.filterEventFnc(this);
   			
   			//마커 삭제
			markerRemoveAll();
   			
			markersN = currentStatus.orgMarkersN;
			markersS = currentStatus.orgMarkersS;
			
   			//마커 생성
   			for(var i =0; i <markersS.length; i++){
   				
   				if(markersS[i]._beforeBoxedIcon.content.indexOf("mapIcon/E/") > -1){
   					markersS[i].setMap(nMap.map);
   				}
   			}
   			
   		}
   		
   		currentStatus.lastFilter = "Err";
   	});
   	
   	$(".filterTeamp").on("click",function(){
   		
   		if(currentStatus.lastFilter != "Teamp"){// 필터사용 - 거치초과
   			
   			currentStatus.filterEventFnc(this);
   			
   			//마커 삭제
			markerRemoveAll();
   			
			markersN = currentStatus.orgMarkersN;
			markersS = currentStatus.orgMarkersS;
			
   			//마커 생성
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
  			
  			//마커 삭제
  			markerRemoveAll();
  			
  			//마커 생성
  			currentStatus.getBikeBatLowStationList(e);
   		
   	});
   	
   	$(".filterExit").on("click",function(){// 필터사용 - 초기화
   		
   		if(currentStatus.lastFilter != null){
   			
   			currentStatus.filterEventFnc(this);
   			
   			//마커 삭제
			markerRemoveAll();
			
			markersN = currentStatus.orgMarkersN;
			markersS = currentStatus.orgMarkersS;
			
			//마커 생성
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
	   
	   var select = "<option value=\"\">선택</option>"
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

			   // 초기 조회일 경우
			   if ( flag ) {
				   if("${condition.paramSearchType}" != ""){
					$("#searchType").val("${condition.paramSearchType}");
				} else {
					
					// 본인의 팀정보가 있을 경우
					 $("#searchType").val("${teamSeq}");
				}
				   
			   }
			   
		   });
	   }
}   
   
   
   
</script>   