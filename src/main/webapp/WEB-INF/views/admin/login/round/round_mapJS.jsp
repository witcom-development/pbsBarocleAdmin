<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script type="text/javascript">
var currentStatus = {};

function initMap(){
	
	var mHeigth = ($(window).height()/2);
	var mWidth  = $("#initMapSize").width();
	var mmw     = mWidth/10;
	    mWidth  = mWidth-mmw;
	if(screen.height > 1000) mHeigth = 500;
	
	nMap.setOption(mWidth,mHeigth);
	nMap.windowHeight = mHeigth;
	
	var oPoint = new naver.maps.LatLng(nMap.defaultLatitude ,nMap.defaultLongitude);	
	
	nMap.map = new naver.maps.Map("mapDiv", {
        size: new naver.maps.Size(mWidth, mHeigth),
        center: new naver.maps.LatLng(37.5675451, 126.9773356), //지도의 초기 중심 좌표
        useStyleMap: true,
        zoom: 15, 											//지도의 초기 줌 레벨
        minZoom: 8, 										//지도의 최소 줌 레벨
        zoomControl: true, 									//줌 컨트롤의 표시 여부
        zoomControlOptions: { 
        	position: naver.maps.Position.RIGHT_BOTTOM		//줌 컨트롤의 옵션
        }
    });
	nMap.map.setOptions("mapTypeControl", true); //지도 유형 컨트롤의 표시 여부 
}

var _this = currentStatus;
currentStatus.stationGrpSeq = '${condition.stationGrpSeq}';
currentStatus.stationId     = '${condition.stationId}';
currentStatus.viewType    = '${condition.viewType}' === "" ? "list" :'${condition.viewType}' ;
currentStatus.initSearchForm = function(){

	nMap.viewType = '${condition.viewType}';
	nMap.defaultLevel ='${condition.defaultLevel}' === '' ? '8' : '${condition.defaultLevel}';
	currentStatus.initBtn();
};

currentStatus.initBtn = function() {
	$("#searchBtn").on("click", this.searchStation);
	$("#list > tbody > tr").on("click",'a', this.moveStationDetail);
	$("#sortSlt").on('change', function(){
		$("[name='lsalign']").prop('checked', false);
	});
	$("[name='lsalign']").on("change", _this.setColumnSortInfo);
};

currentStatus.searchStation = function(e) {
	e.preventDefault();
	currentStatus.viewType = 'search';
	$("[name='viewType']").val('search');

	$("[name='defaultLevel']").val(nMap.defaultLevel);
    $("[name='paramSearchWord']").val( _adminId );
	$("[name='stationNo']").val($("#searchWord").val());
    
    var params = $("#searchFrm").serialize();
    postAjaxLoading("start");
    $.ajax({
		type : "post",
		url : "/getStationStautsListRound.do",
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
			     
					var str = 'class="w3-button w3-black">등록';
					var str1 = str, str2 = str, str3 = str, str4 = str, str5 = str, str6 = str;
					
					if ( el.shared != null && el.shared != "" ) {
					 	if( el.shared.indexOf("DEV_006") >= 0 ) str1 = ' class="w3-button w3-blue">수정';
					 	if( el.shared.indexOf("DEV_003") >= 0 ) str2 = ' class="w3-button w3-blue">수정';
					 	if( el.shared.indexOf("DEV_004") >= 0 ) str3 = ' class="w3-button w3-blue">수정';
					 	if( el.shared.indexOf("DEV_007") >= 0 ) str4 = ' class="w3-button w3-blue">수정';
					 	if( el.shared.indexOf("DEV_008") >= 0 ) str5 = ' class="w3-button w3-blue">수정';
					 	if( el.shared.indexOf("DEV_009") >= 0 ) str6 = ' class="w3-button w3-blue">수정';
					} 
				
					rowData += "<tr>";
					
					rowData += '<td style="text-align:center">' + el.stationName  + '</td>';
					
					rowData += '<td style="text-align:center"><a href="#"  onclick="onSiteActionFuc(event, 1 , ' + idx + ');" id="' + el.stationId + "," + el.stationName + "," + el.stationNo  + '" ' + str1 + '</a></td>';
					rowData += '<td style="text-align:center"><a href="#"  onclick="onSiteActionFuc(event, 2 , ' + idx + ');" id="' + el.stationId + "," + el.stationName + "," + el.stationNo  + '" ' + str2 + '</a></td>';
					rowData += '<td style="text-align:center"><a href="#"  onclick="onSiteActionFuc(event, 3 , ' + idx + ');" id="' + el.stationId + "," + el.stationName + "," + el.stationNo  + '" ' + str3 + '</a></td>';
					rowData += '<td style="text-align:center"><a href="#"  onclick="onSiteActionFuc(event, 4 , ' + idx + ');" id="' + el.stationId + "," + el.stationName + "," + el.stationNo  + '" ' + str4 + '</a></td>';
					rowData += '<td style="text-align:center"><a href="#"  onclick="onSiteActionFuc(event, 5 , ' + idx + ');" id="' + el.stationId + "," + el.stationName + "," + el.stationNo  + '" ' + str5 + '</a></td>';
					rowData += '<td style="text-align:center"><a href="#"  onclick="onSiteActionFuc(event, 6 , ' + idx + ');" id="' + el.stationId + "," + el.stationName + "," + el.stationNo  + '" ' + str6 + '</a></td>';
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
 
// 정비 관리 
function onSiteActionFuc(e, type, rowIdx ){
	e.preventDefault();
	
	var url = "";
	var title = "";
		url = '/moveRepairEditForm.do';
	
	switch( type ){
	case 1 :
		title = "비콘 관리";
		$('input[name=repairClsCd]').attr('value',"DEV_006"); 
	break;
	case 2 :
		title = "거치대 관리";
		$('input[name=repairClsCd]').attr('value',"DEV_003");
	break;
	case 3 :
		title = "AP 관리";
		$('input[name=repairClsCd]').attr('value',"DEV_004");
	break;
	
	case 4 :
		title = "안내간판 관리";
		$('input[name=repairClsCd]').attr('value',"DEV_007");
	break;
	case 5 :
		title = "수리공구대 관리";
		$('input[name=repairClsCd]').attr('value',"DEV_008");
	break;	
	case 6 :
		title = "순회정비 기타 관리";
		$('input[name=repairClsCd]').attr('value',"DEV_009");
	break;		
	default :
		alert("개발 중"); return;
	}
	
	$('#team_position_table tr').each(function() {
		if (!this.rowIndex) return; // skip first row
		var teamName = $(this).find("td").eq(0).html();  
		var selPosition = $(this).find('#position option:selected').val();
	});
	
	
	var pData = e.target.id.split(",");
	
	$("#linkForm [name='stationId']").val(pData[0]);
	$("#linkForm [name='stationName']").val(pData[1]);
	$("#linkForm [name='stationNo']").val(pData[2]);
	$("#linkForm [name='rackId']").val(pData[2]);

	$("[name='currentPageNo']").val("0");
	$("[name='viewFlg']").val("R");
	
	$("#linkForm").attr({method : 'post',target : 'modalIframe', action : url}).submit();

	bikeSearch.repairTime = 0;
	bikeSearch.repairYn = "N";
	bikeSearch.repairType = "onSiteAction";
	
	initModalIfarame(title);
	fn_repairTimer();
	 
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

var markerA = {
        style: "circle",
        radius: 20,
        fillColor: "green",
        fillOpacity: 1,
        strokeColor: "black",
        strokeStyle: "solid",
        strokeWeight: 0.2
    }

function redraw(data){
	var markerOptions = {icon: {}};
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
        markerOptions.icon = markerA;
        // markerOptions.type= "station";
        var marker = new naver.maps.Marker(markerOptions);
		marker.setMap(nMap.map);
  		naver.maps.Event.addListener(marker, 'click', getClickHandler(info.stationId
  				                                                    , info.stationName
																	, info.parkingBike  
																	, info.systemWarning
																	, info.shared
																	, info.stationLatitude
																	, info.stationLongitude));
	}
    
}


linkStation = function(stationId) {
	$("[name='stationId']").val(stationId);
	// 2018-11-25 새창열기로 변경
	$("#searchFrm").attr({action : "<c:out value='/moveCurrentStationDetail.do'/>", method : "post", target:"_blank"}).submit();
};

function getClickHandler(stationId, stationName, rackInfo, bikeInfo, shared, latitude,longitude) {
    return function(e) {
	
    //var href = "nmap://route/car?lat=" + latitude + "&lng=" + longitude   + "&name=" +  stationName + "&zoom=20&appname=com.example.myapp";
    
    var href = "nmap://navigation?dlat=" + latitude + "&dlng=" + longitude   + "&dname=" +  stationName +"&zoom=20&appname=kr.co.witcom.smartbike.seoul.admin";
    
	var cont = '<DIV  id="infoBox">';
	cont += '       <p style="border-bottom:1px solid #c9c9c9; font-size:14px;color:#333; position:relative; text-decoration:underline">';
	cont += '           <span style="margin:10px 0 10px 10px; font-weight:bold; display:block;">'+stationName+'</span>';
	cont += '           <div style="position:absolute; top:3px; right:3px; width: 40px; height: 40px;" class="mpclose"><a href="#"><img  name="close" style="width: auto; position: relative; top: 8px; left: 8px;" src="/images/stationClose.gif" alt="대여소 정보닫기" /></a></div>';
	cont += '       </p>';
	cont += '       <ul class="map_ul" >';
	cont += '           <li><p class="cacao" style="background:blue;color:white;">카카오지도(웹전용)</p></li>';
	cont += '           <li><p class="naver" style="background:green;color:white;"><a href="';
    cont += 			href;
    cont += '"> 네이버지도(앱전용)</a></p></li>';    	
	
	cont += '           <li><p class="map_station" style="background:#906D3B;color:white;">대여소관리</p></li>';    
	cont += '           <li><p class="map_beacon" style="background:grey;color:white;">비콘관리</p></li>';    
    
    
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
   	       	              {commend:"remove",selector:".nmt"}
   	       	           	  ,{commend:"remove",selector:"#apTbl"} 
   	       	           	  ,{commend:"remove",selector:"#armTbl"}
   	       	        	  ,{commend:"remove",selector:"#armTbl"}
   	       	           	 ];
    	       	 
    	       	initModalIfarame("대여소상세",objArr,'/moveCurrentStationDetail.do?stationId='+stationId);
    	       	
            }); 
	 
			$("#infoBox ul .cacao").on("click", function(e){
    	       	e.preventDefault();
    	       	$("#searchFrm").attr({action : "http://map.kakao.com/link/to/'" + stationName + ',' + latitude +',' + longitude , method : "post", target:"_blank"}).submit();
            });
			
			
			$("#infoBox ul .map_beacon").on("click", function(e){
    	       	e.preventDefault();
    	       	
    	       	e.preventDefault();
    	       	$("[name='stationId']").val(stationId);
    	       	//$("#searchFrm").attr({action : "<c:out value='/moveCurrentStationDetail.do'/>", method : "post", target:"_blank"}).submit();
    	       	
    	       	var objArr = [
   	       	               /* {commend:"remove",selector:".ttbtncase1"} 
   	       	              ,*/
   	       	               {commend:"remove",selector:".nmt"}
   	       	           	  ,{commend:"remove",selector:"#apTbl"} 
   	       	           	  ,{commend:"remove",selector:"#armTbl"}
   	       	        	  ,{commend:"remove",selector:"#armTbl"}
   	       	        	  ,{commend:"remove",selector:"#footer"}
   	       	           	 ];
    	       	 
    	       	initModalIfarame("비콘상세",objArr,'/getBeaconList.do?stationId='+stationId + "&SearchBgnDe=2015-01-01");
            });

			 
			$("#infoBox ul .map_station").on("click", function(e){
    	       	e.preventDefault();
    	        $("#searchFrm").attr({action : "/admin/manage/station/stationInfo.do?station_id=" + stationId  , method : "post", target:"_blank"}).submit();
    	       /* 	var objArr = [
       	               {commend:"remove",selector:".nmt"}
       	           	  ,{commend:"remove",selector:"#apTbl"} 
       	           	  ,{commend:"remove",selector:"#armTbl"}
       	        	  ,{commend:"remove",selector:"#armTbl"}
       	        	  ,{commend:"remove",selector:"#footer"}
       	           	 ];
	       	 
	       			initModalIfarame("대여소 상세",objArr,'/admin/manage/station/stationInfo.do?station_id='+stationId);
    	      	  */
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