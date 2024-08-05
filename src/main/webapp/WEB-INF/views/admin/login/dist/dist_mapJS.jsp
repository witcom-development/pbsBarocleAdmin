<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
</head>
<body>

<script type="text/javascript">

var currentStatus = {};
function initMap(){
	var mHeigth = ($(window).height()/2);
	var mWidth  = $("#initMapSize").width();
	var mmw     = mWidth/10;
	    mWidth  = mWidth-mmw;
	if(screen.height > 1000) {
		mHeigth = 500;
	}
	
	nMap.setOption(mWidth,mHeigth);
	
	nMap.windowHeight = mHeigth;
	
	/* Naver API 3.0*/
	var oPoint = new naver.maps.LatLng(nMap.defaultLatitude ,nMap.defaultLongitude);	
	
	nMap.map = new naver.maps.Map("mapDiv", {
        size: new naver.maps.Size(mWidth, mHeigth),
        center: new naver.maps.LatLng(37.5675451, 126.9773356), //지도의 초기 중심 좌표
        useStyleMap: true,
        zoom: 15, //지도의 초기 줌 레벨
        minZoom: 8, //지도의 최소 줌 레벨
        zoomControl: true, //줌 컨트롤의 표시 여부
        zoomControlOptions: { //줌 컨트롤의 옵션
        //style: naver.maps.ZoomControlStyle.SMALL,	
        position: naver.maps.Position.RIGHT_BOTTOM
        }
    });	

	nMap.map.setOptions("mapTypeControl", true); //지도 유형 컨트롤의 표시 여부 

}

var _this = currentStatus;
currentStatus.stationGrpSeq = '${condition.stationGrpSeq}';
currentStatus.stationId     = '${condition.stationId}';
currentStatus.viewType    = '${condition.viewType}' === "" ? "list" :'${condition.viewType}' ;
currentStatus.initSearchForm = function(){
	if("${condition.stationGrpSeq}" != ""){
		$("#bb22").val("${condition.stationGrpSeq}");
	}
	nMap.viewType = '${condition.viewType}';
	nMap.defaultLevel ='${condition.defaultLevel}' === '' ? '8' : '${condition.defaultLevel}';
    $("#paramCenterId").change(function(){
    	$("[name='defaultTeamYn']").val("N");
	    find_team(false);
    });
	currentStatus.initBtn();
	currentStatus.initCommbo();
};

currentStatus.initBtn = function() {
	$("#searchBtn").on("click", this.searchStation);
	
	$("#bb22").on("change", function(e){
		var tId = e.target.id;
        var idx = $("#"+tId+" option:selected").index();
        var subList =$("#"+tId).data().sub_data;
	});
	
	$("#list > tbody > tr").on("click",'a', this.moveStationDetail);
	$("#sortSlt").on('change', function(){
		$("[name='lsalign']").prop('checked', false);
	});
	$("[name='lsalign']").on("change", _this.setColumnSortInfo);
	
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
	             commCdBox.makeComboBox('CC', '', code, "paramCenterId");
	         }
	});
    
    // 20220120 센터 설정
    if( !isEmpty( G_usrCenterId )) {
    	$("#paramCenterId").val( G_usrCenterId );
    	
    	find_team(true);
    	
    }
    
    
};

currentStatus.searchStation = function(e) {
	e.preventDefault();
	nMap.defaultLevel ='${condition.defaultLevel}' === '' ? '8' : '${condition.defaultLevel}';
	currentStatus.viewType = 'search';
	$("[name='viewType']").val('search');
	$("[name='stationGrpSeq']").val($("#bb22").val());
	$("[name='defaultLevel']").val(nMap.defaultLevel);
	$("[name='paramSearchWord']").val($("#searchWord").val());
	currentStatus.initData(1, 'search');
};

currentStatus.initData = function(pNo, pType) { 

	if($("#searchWord").val() != ''){
		$("[name='stationGrpSeq']").val($("#bb22").val());
    	// $("[name='stationId']").val($("#aa21").val());
		pType = "search";
	}
    $("[name='defaultLevel']").val(nMap.defaultLevel);	
    $("[name='paramSearchWord']").val($("#searchWord").val());
    var params = $("#searchFrm").serialize();
    postAjaxLoading("start");
    $.ajax({
		type : "post",
		url : "/getStationCurrentStatusAjaxNew.do",
		data : params,
		success : function(data){
			
			if( data.reulst == false ) {
				alert("조회에 실패했습니다. ")
				postAjaxLoading("end");
				return;
			}
			
			redraw(data);
			
	 		 $("#stationBody").empty();
	 		var rowData= ""; 
			$.each(data.stationList, function (idx, el) {
			      rowData += "<tr>";
			      rowData += '<td>' + el.stationName + '</td>';
			      rowData += '<td style="text-align:center">' + el.parkingBike + '</td>';
			      rowData += '<td style="text-align:right">' + el.shared + '</td>';
			      rowData += '<td style="text-align:right">' + el.day7 + '</td>';
			      rowData += '<td style="text-align:right">' + el.day1 + '</td>';
			      rowData += '</tr>';
			      
			}); 
			$("#stationBody").append(rowData);
			
			// 필터링 추가
			setTableGrid();
			
			postAjaxLoading("end");		
		},
		error : function(data){
			alert("조회에 실패했습니다.");
			postAjaxLoading("end");
		}
	});
	
};

var sortType ="ASC";

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
var sortType = "ASC";
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
		// 대여소 , 팀명
		if (n == 0 ) {
		
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

currentStatus.getBikeBatLowStationList = function(e){
	e.preventDefault();
	$("[name='stationGrpSeq']").val($("#bb22").val());
    $("[name='viewType']").val('search');
    $("[name='paramSearchWord']").val($("#searchWord").val());

    var params = $("#searchFrm").serialize();
    postAjaxLoading("start");
    
	$.ajax({
		type : "post",
		url : "/getBikeBatLowStationAjax.do",
		data : params,
		success : function(data){
			
			batdraw(data);
			postAjaxLoading("end");		
		},
		error : function(data){
			alert("조회에 실패했습니다.");
			postAjaxLoading("end");
		}
	});
	
}

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


var markersN = [];
var markersS = [];
var markersB = [];

function batdraw(data){
	
	//마커 삭제 : 다 지운 후 다시 마커 삽입
	markerRemoveAll();
	
	
	var markerOptions = {icon: {}};
	
	var bikeBatLowStationListCnt = data.bikeBatLowStationList.length;
	for(var i = 0; i < bikeBatLowStationListCnt; i++){
		
		var bikeBatLow = data.bikeBatLowStationList[i];
		
		markerOptions.position = new naver.maps.LatLng(bikeBatLow.stationLatitude,  bikeBatLow.stationLongitude);
		markerOptions.map = nMap.map;

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

        markerOptions.type     = "station";
        
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
	
}	

function redraw(data){
	
	//마커 삭제 : 다 지운 후 다시 마커 삽입
	markerRemoveAll();
	
	var markerOptions = {icon: {}};
	
	var exeImpulseListCnt = data.exeImpulseList.length;
	for(var i = 0; i < exeImpulseListCnt; i++){
		
		var impulse = data.exeImpulseList[i];
		
		markerOptions.position = new naver.maps.LatLng(impulse.latitude,  impulse.longitude);
		markerOptions.map = nMap.map;
        markerOptions.icon.content = "<img src='/images/icon_bike_big3.png' alt='' style='width: 30px'>";
        markerOptions.type     = "station";
        var marker = new naver.maps.Marker(markerOptions);
         
        markersN.push(marker);
        naver.maps.Event.addListener(marker, 'click', getClickHandlerMove(impulse.rentBikeNo
                , impulse.enfrcReturnHistSeq
                , impulse.latitude
                , impulse.longitude
                
          )); 
		marker.setMap(nMap.map);
	}
	
	var bikeLostListCnt = data.bikeLostList.length;
	for(var i = 0; i < bikeLostListCnt; i++){
		
		var bks = data.bikeLostList[i];
		
		markerOptions.position = new naver.maps.LatLng(bks.xPos,  bks.yPos);
		markerOptions.map = nMap.map;
		
    	var addBatt = "";
    	if( parseInt( bks.devBatt ) < 50 ) {
    		addBatt= "<span style='color:red; background:white;border:1px solid grey'>" + bks.devBatt + "%</span><br/>"
    	} else {
    		addBatt= "<span style='color:black; background:white;border:1px solid grey'>" + bks.devBatt + "%</span><br/>"
    	}
    	
    	markerOptions.icon.content = addBatt + "<img src='/images/icon_bike_big4.png' alt='' style='width: 30px'>";
    	markerOptions.type     = "station";
    	var marker = new naver.maps.Marker(markerOptions);
    	markersN.push(marker);
    	
       naver.maps.Event.addListener(marker, 'click', getClickHandlerLostMove(bks.bikeNo
            , bks.xPos
            , bks.yPos
            , bks.modDttm
            , bks.regDttm
            
      	));
       
		marker.setMap(nMap.map);
	
	}
	
	var stationListCnt = data.stationList.length;
	for(var i = 0; i < stationListCnt; i++){
		
		var info = data.stationList[i];
		
		if(i == (stationListCnt-1) ){
			
			if(info.stationLatitude && info.stationLatitude != '' && info.stationLongitude && info.stationLongitude != '' ){
			 	nMap.map.setCenter(new naver.maps.LatLng(info.stationLatitude,info.stationLongitude));
			}
			
		}
		
		markerOptions.position = new naver.maps.LatLng(info.stationLatitude,  info.stationLongitude);
        markerOptions.map = nMap.map;
        /* markerOptions.icon.content = "<div><img src='"+info.imgSrc+"'></div>"; */
       if ( i < 10 ){
        markerOptions.icon.content = "<div><img src='/images/mapIcon/E/icon_OverError.png'></div>";
    	   
       } else {
    	   markerOptions.icon.content = "<div><img src='"+info.imgSrc+"'></div>";
       }
        
        
        markerOptions.type     = "station";
        var marker = new naver.maps.Marker(markerOptions);
		marker.setMap(nMap.map);
  		naver.maps.Event.addListener(marker, 'click', getClickHandler(info.stationId
  				                                                    , info.stationName
																	, info.parkingBike  
																	, info.systemWarning
																	, info.shared
																	, info.stationLatitude
																	, info.stationLongitude));
  		markersS.push(marker);
  		
	}
	
	//2020-11-13 : 마커 필터 작업
	currentStatus.orgMarkersN = markersN;
    currentStatus.orgMarkersS = markersS;
    
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
	$("#searchFrm").attr({action : "<c:out value='/moveCurrentStationDetail.do'/>", method : "post", target:"_blank"}).submit();
};

function getClickHandlerLostMove(rentBikeNo, latitude,longitude, modDttm, regDttm) {
    return function(e) {
	 
    	//var href = "nmap://place?lat=" + latitude + "&lng=" + longitude   + "&name=" +  rentBikeNo + "&zoom=20&appname=com.example.myapp"; 
    	// var href = "nmap://route/car?dlat=" + latitude + "&dlng=" + longitude   + "&dname=" +  rentBikeNo + "&zoom=20&appname=bikeSeoul";
    	var href = "nmap://navigation?dlat=" + latitude + "&dlng=" + longitude   + "&dname=" +  rentBikeNo +"&zoom=20&appname=kr.co.witcom.smartbike.seoul.admin";
    	
    	var cont = '<DIV  id="infoBox" style="border:2px solid #555; background:#fff; font-family:dotum; width:230px; text-align:left;line-height:150%;" >';
    	cont += '       <p style="border-bottom:1px solid #c9c9c9; font-size:14px;color:#333; position:relative; text-decoration:underline">';
    	cont += '           <a href="#" style="position:absolute; top:3px; right:10px" class="mpclose"><img  name="close" src="/images/stationClose.gif" alt="대여소 정보닫기" /></a>';
    	cont += '       </p>';
    	cont += '       <ul style="display:inline-block; vertical-align:middle; font-size:14px;margin:5px;">';
    	cont += '           <li>자전거 번호  : <span style="color:#000099;">'+rentBikeNo+'</span></li>';
    	cont += '           <li>최종신호     : <span style="color:#000099;">'+ modDttm+'</span></li>';
    	cont += '           <li>갱신 시간    : <span style="color:#000099;">'+regDttm+'</span></li>';
    	cont += '           <li><p class="cacao" style="background:blue;color:white;">카카오지도로 길찾기</p></li>';
    	cont += '           <li><p class="naver" style="background:green;color:white;"><a href="';
    	cont += href;
    	cont += '"> 네이버지도로 길찾기(앱전용)</a></p></li>';    	
    	
    	cont += '       </ul>';
        cont += '   </DIV>';
    	
        var infoWindow = new naver.maps.InfoWindow({
        	content: cont
    	});
        
        var center = new naver.maps.LatLng( getMoblieView(e, "lat"), getMoblieView(e, "lng"));
   		infoWindow.open(nMap.map,e.coord);
   		nMap.map.setCenter(center); //2020-11-04 : 마커를 중앙으로 이동
		///////////////////2020-11-10 모바일 최적화 작업(줌 레벨에 따라 동젹변경) - end/////////////////
   		
			$("#infoBox a img").on("click", function(e){
	       	e.preventDefault();
	       	infoWindow.close(nMap.map,center);
        });
 
    }	    	 
}    

function getClickHandlerMove(rentBikeNo, enfrcReturnHistSeq, latitude,longitude) {
    return function(e) {
	 
    	//var href = "nmap://route/car?dlat=" + latitude + "&dlng=" + longitude   + "&dname=" +  rentBikeNo + "&zoom=20&appname=bikeSeoul";
    	    	var href = "nmap://navigation?dlat=" + latitude + "&dlng=" + longitude   + "&dname=" +  rentBikeNo +"&zoom=20&appname=kr.co.witcom.smartbike.seoul.admin";
    	
    	var cont = '<DIV  id="infoBox" style="border:2px solid #555; background:#fff; font-family:dotum; width:230px; text-align:left;line-height:150%;" >';
    	cont += '       <p style="border-bottom:1px solid #c9c9c9; font-size:14px;color:#333; position:relative; text-decoration:underline">';
    	cont += '           <a href="#" style="position:absolute; top:3px; right:10px" class="mpclose"><img  name="close" src="/images/stationClose.gif" alt="대여소 정보닫기" /></a>';
    	cont += '       </p>';
    	cont += '       <ul style="display:inline-block; vertical-align:middle; font-size:14px;margin:5px;">';
    	cont += '           <li>자전거 번호  : <span style="color:#000099;">'+rentBikeNo+'</span></li>';
    	cont += '           <li>위치 상세보기  : <span class="detail" style="color:#000099;">'+'<a href="#"> 상세보기</a>'+'</span></li>';
    	cont += '           <li>강반 상세보기  : <span class="exeImpul" style="color:#000099;">'+'<a href="#"> 상세보기</a>'+'</span></li>';
    	cont += '       </ul>';
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
	    	       	findBikeLocation( e, latitude, longitude, enfrcReturnHistSeq )
	    			// window.open("/common/pop/entrcReutnViewPop.do?outptt=%uC704%uCE58%uC9C0%uB3C4%uCC3E%uAE30&latitude="+ lat +"&longitude=" + lon + "&enfrcReturnHistSeq=" + enfrcReturnHistSeq , "winpop2", "width=600, height=730, top="+winT+", left="+winL+" , scrollbars=yes");
	            }); 
     			
     			$("#infoBox ul .exeImpul").on("click", function(e){
	    	       	e.preventDefault();
	    	       	moveImpulseInfo(e, rentBikeNo );
	            }); 
    	 
    			$("#infoBox ul .cacao").on("click", function(e){
	    	       	e.preventDefault();
	    	       	$("#searchFrm").attr({action : "http://map.kakao.com/link/to/'" + '' + ',' + latitude +',' + longitude , method : "post", target:"_blank"}).submit();
	            });  
    			
        }
}    



function getClickHandler(stationId, stationName, rackInfo, bikeInfo, shared, latitude,longitude) {
    return function(e) {
	
    //var href = "nmap://route/car?lat=" + latitude + "&lng=" + longitude   + "&name=" +  stationName + "&zoom=20&appname=com.example.myapp";
    
    var href = "nmap://navigation?dlat=" + latitude + "&dlng=" + longitude   + "&dname=" +  stationName +"&zoom=20&appname=kr.co.witcom.smartbike.seoul.admin";
    
	var cont = '<DIV  id="infoBox" style="border:2px solid #555; background:#fff; font-family:dotum; width:230px; text-align:left;line-height:150%;" >';
	cont += '       <p style="border-bottom:1px solid #c9c9c9; font-size:14px;color:#333; position:relative; text-decoration:underline">';
	cont += '           <span style="margin:10px 0 10px 10px; font-weight:bold; display:block;">'+stationName+'</span>';
	cont += '           <div style="position:absolute; top:3px; right:3px; width: 40px; height: 40px;" class="mpclose"><a href="#"><img  name="close" style="width: auto; position: relative; top: 8px; left: 8px;" src="/images/stationClose.gif" alt="대여소 정보닫기" /></a></div>';
	cont += '       </p>';
	cont += '       <ul style="display:inline-block; vertical-align:middle; font-size:14px;margin:5px;">';
	cont += '           <li>LCD/QR : <span style="color:#000099;">'+rackInfo+'</span></li>';
	cont += '           <li>거치율(%)  : <span style="color:#000099;">'+shared+'%</span></li>';
	cont += '           <li><p class="cacao" style="background:blue;color:white;">카카오지도로 길찾기</p></li>';


	cont += '           <li><p class="naver" style="background:green;color:white;"><a href="';
    cont += href;
    cont += '"> 네이버지도로 길찾기(앱전용)</a></p></li>';    	
	
	cont += '       </ul>';
	cont += '       <p style="text-align:center; margin-bottom:-16px;"><img src="/images/stationPos.png" style="display:block; margin:0 auto;width:21px;height:16px;" alt="" /></p>';
    cont += '   </DIV>';	
   	
    var infoWindow = new naver.maps.InfoWindow({
        	content: cont
    	});	
     
		var center = new naver.maps.LatLng( getMoblieView(e, "lat"), getMoblieView(e, "lng"));
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
   	       	               /* {commend:"remove",selector:".ttbtncase1"} 
   	       	              ,*/
   	       	              /* {commend:"remove",selector:".nmt"} */
   	       	           	   {commend:"remove",selector:"#apTbl"} 
   	       	           	  ,{commend:"remove",selector:"#armTbl"}
   	       	        	  ,{commend:"remove",selector:"#armTbl"}
   	       	           	 ];
    	       	 
    	       	initModalIfarame("대여소상세",objArr,'/moveCurrentStationDetail.do?stationId='+stationId);
    	       	
            }); 
	 
			$("#infoBox ul .cacao").on("click", function(e){
    	       	e.preventDefault();
    	       	$("#searchFrm").attr({action : "http://map.kakao.com/link/to/'" + stationName + ',' + latitude +',' + longitude , method : "post", target:"_blank"}).submit();
            });

    }
}

function getMoblieView(e, type){
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
    if ( type == "lat" ) return zlat;
    if ( type == "lng" ) return zlng;
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
    
    // var href = "nmap://route/car?lat=" + latitude + "&lng=" + longitude   + "&name=" +  stationName + "&zoom=20&appname=com.example.myapp";
    
    var href = "nmap://navigation?dlat=" + latitude + "&dlng=" + longitude   + "&dname=" +  stationName +"&zoom=20&appname=kr.co.witcom.smartbike.seoul.admin";
    
	var cont = '<DIV  id="infoBox" style="border:2px solid #555; background:#fff; font-family:dotum; width:230px; text-align:left;line-height:150%;" >';
	cont += '       <p style="border-bottom:1px solid #c9c9c9; font-size:14px;color:#333; position:relative; text-decoration:underline">';
	cont += '           <span style="margin:10px 0 10px 10px; font-weight:bold; display:block;">'+stationName+'</span>';
	cont += '           <div style="position:absolute; top:3px; right:3px; width: 40px; height: 40px;" class="mpclose"><a href="#"><img  name="close" style="width: auto; position: relative; top: 8px; left: 8px;" src="/images/stationClose.gif" alt="대여소 정보닫기" /></a></div>';
	cont += '       </p>';
	cont += '       <ul style="display:inline-block; vertical-align:middle; font-size:14px;margin:5px;">';
					for(var i = 0; i < bikeNo.length; i++){
						
	cont += '           <li>자전거  : <span style="color:#000099;">'+bikeNo[i]+'</span></li>';
	
					}

	cont += '           <li><p class="cacao" style="background:blue;color:white;">카카오지도로 길찾기</p></li>';				
	cont += '           <li><p class="naver" style="background:green;color:white;"><a href="';
    cont += href;
    cont += '"> 네이버지도로 길찾기(앱전용)</a></p></li>';  					
	cont += '       </ul>';
	cont += '       <p style="text-align:center; margin-bottom:-16px;"><img src="/images/stationPos.png" style="display:block; margin:0 auto;width:21px;height:16px;" alt="" /></p>';
    cont += '   </DIV>';	
   	
    var infoWindow = new naver.maps.InfoWindow({
        	content: cont
    	});	
    
    var center = new naver.maps.LatLng( getMoblieView(e, "lat"), getMoblieView(e, "lng"));
		
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
    	       	
    	       	initModalIfarame("대여소상세",objArr,'/moveCurrentStationDetail.do?stationId='+stationId);
    	       	
            });
 			
			$("#infoBox ul .cacao").on("click", function(e){
    	       	e.preventDefault();
    	       	$("#searchFrm").attr({action : "http://map.kakao.com/link/to/'" + stationName + ',' + latitude +',' + longitude , method : "post", target:"_blank"}).submit();
            });
	 
    }
}

function find_team( flag ){
    
    var select = "<option value=\"\">선택</option>"
    var center = $("#paramCenterId").val();
    
    if($("#paramCenterId").val() == ''){
        $("#paramTeamSeq").find("option").remove().end();
        $("#paramTeamSeq").append(select);
    }else{
        $("#paramTeamSeq").find("option").remove().end();
        $("#paramTeamSeq").append(select);
        
        $.post("/admin/system/userMgmt/srchTeamList.do", "centerId="+center  , function(data) {
            
            for(var i=0; i < data.teamList.length; i++){
                $("#paramTeamSeq").append("<option value='"+data.teamList[i].teamSeq+"'>"+ data.teamList[i].teamNm +"</option>");
            }						

            // 초기 조회일 경우
            if ( flag ) {
					                		 
                if("${condition.paramTeamSeq}" != ""){
		                $("#paramTeamSeq").val("${condition.paramTeamSeq}");

                } else {
	            	//  $("#paramTeamSeq").val("${teamSeq}");
	               	// 20220120 본인 팀보설정
	               	if( !isEmpty( G_usrTeamSeq )) {
		                $("#paramTeamSeq").val( G_usrTeamSeq );
	            	}
	                
	            }
                
            }
            
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

</script>
</body>
</html>