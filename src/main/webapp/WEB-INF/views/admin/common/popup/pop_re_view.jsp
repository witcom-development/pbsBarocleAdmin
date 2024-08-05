<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" /> 
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />
<meta name="description=" Content="" />
<%@ include file="../popup/pop_resource.jsp" %>
</head>
<body>
    <h1 class="popTt"></h1>
    <div class="cntbox">
        <div class="allwrap pop">
          <%--
          	<span class="input-text08 ml10 mr10" style="display: none;"><input id="latitude" name="latitude" type="text" value="${info.latitude}" readonly/></span>
			<span class="input-text08 ml10 " style="display: none;"><input id="longitude" name="longitude" type="text" value="${info.longitude}" readonly/></span>
			<br><span>주소 : </span><span class="ml10"><input id="addr" name="addr" type="text" value="${info.addr}" style="width: 65%;" readonly/></span>
			<br><span>상세 : </span><span class="ml10"><input id="parkingLocation" name="parkingLocation" type="text" value="${info.parkingLocation}" style="width: 65%;" readonly/></span>
			&nbsp;<button class="btnType02" id="naverMapLink">길찾기</button> --%>
			
			<span class="input-text08 ml10 mr10" style="display: none;"><input id="latitude" name="latitude" type="text" value="${info.latitude}" readonly/></span>
			<span class="input-text08 ml10 " style="display: none;"><input id="longitude" name="longitude" type="text" value="${info.longitude}" readonly/></span>
			<table style="width:100%; ">
				<tr>
					<td width="10%;" align="center"><span>주소:</span></td><td width="73%;"><span class="ml10"><input id="addr" name="addr" type="text" value="${info.addr}" style="width: 90%;" readonly/></span></td>
					<td align="left" width="17%" style="vertical-align:middle;" rowspan="2">
					<a href=" nmap://route/car?dlat=${info.latitude}&dlng=${info.longitude}&dname=${info.parkingLocation}&appname=bikeSeoul">
					길찾기</a></td>
				</tr>
				<tr >
					<td width="10%;" align="center"><span>상세:</span></td><td width="73%;"><span class="ml10"><input id="parkingLocation" name="parkingLocation" type="text" value="${info.parkingLocation}" style="width: 90%;" readonly/></span></td>
				</tr>
			</table>
			
            <div class="didBox pop">
				<div class="mapBox" id="mapDiv" style="height: 70%;width: 40%;"><!--style="height:500px" 는 영역 표시를 위한 임시값입니다. 트리구조 삽입후 삭제하셔야 합니다.-->
                </div>
			</div>
			
                <c:forEach var="fileList" items="${enfrcFileList }" varStatus="status" >
                <div>
                                      사진 ${status.count} <br></br>
                 <span style="width: 40%;"><img src="${fileList.fileSavePath}/${fileList.fileName}" alt="" /></span>
                </div>
                </c:forEach>
               
			<div class="btnArea">
                <span class="right">
                	<button class="btnType01" id="cancelBtn">취소</button>
                </span>
            </div>
        </div>
    </div>
    <a href="#" class="popclose"><img src="/images/btn_close.png" alt="팝업닫기" /></a>
    <%-- <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v2/maps.js?clientId=${naverMapApiKey}"></script> --%>
    <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=4791tlnwi5&callback=draw"></script>
    <script type="text/javascript" src="/js/common_barocle.js"></script>
    <script type="text/javascript">
    /* $(function(){
    	$("#cancelBtn").on("click", function(e) {
    		e.preventDefault();
    		window.close();
    	});
    	
    	var nMap = {};
    	nMap.map = null;
    	nMap.defaultLevel = 8;
    	nMap.eventFlg = false;
    	nMap.infoWindowData = [];
    	nMap.labelData = [];
    	nMap.defaultSize = null;
    	nMap.targetViewData = [];
    	nMap.defaultLatitude = 37.5675451;
    	nMap.defaultLongitude = 126.9773356;
    	nMap.initMap  = function() {
    		nMap.targetViewData = [];
    		nMap.map.clearOverlay();
    		//$positionMap.empty();
    	};
    	nMap.defaultLevel = 7;
    	nMap.defaultSize =  {width : 600, height : 380} ;
    	
        var latitude = ${latitude};
		var longitude = ${longitude};
		
   		//var oPoint = new nhn.api.map.LatLng(latitude, longitude);
   		
   		var oPoint;

		if(latitude != 0 && longitude != 0 ){
			oPoint = new nhn.api.map.LatLng(latitude, longitude);
		}else{
			oPoint = new nhn.api.map.LatLng(nMap.defaultLatitude, nMap.defaultLongitude);
		}
   		
   		nhn.api.map.setDefaultPoint('LatLng');
   		
   		console.log( nMap.defaultLevel);
   		nMap.map = new nhn.api.map.Map("mapDiv",{point : oPoint // 지도 중심점의 좌표
   												,zoom : nMap.defaultLevel  // 지도의 축척 레벨
   												,mapMode : 0 // 지도 모드(0 : 일반 지도, 1 : 겹침 지도, 2 : 위성 지도)
   												,enableWheelZoom : false
   												,enableDragPan : true
   												,enableDblClickZoom : false
   												,activateBicycleMap : true // 자전거 지도 활성화 여부
   												,activateTrafficMap : false
   												,activateBicycleMap : false
   												,activateRealtyMap : true
   												,minMaxLevel : [ 1, 14 ]
   												,size : nMap.defaultSize
   												,detectCoveredMarker : true 
   												}
   		);
   	    var mapZoom = new nhn.api.map.ZoomControl(); // - 줌 컨트롤 선언
   	    mapZoom.setPosition({left:5, bottom:5}); // - 줌 컨트롤 위치 지정.
   	    nMap.map.addControl(mapZoom); // - 줌 컨트롤 추가.
    	
    	var oSize = new nhn.api.map.Size(32, 39);
	    var oOffset = new nhn.api.map.Size(7, 19);
	    var oIcon = new nhn.api.map.Icon('/images/staOn_0p.png', oSize, oOffset);
	    
    	var marker;
    	marker = new nhn.api.map.Marker(oIcon,{point : oPoint  // 마커의 좌표
	     ,zIndex : 50 // 마커의 zIndex
	     ,smallSrc : "/images/staOn_s0p.png" // 마커의 작은 이미지(중복 마커 레이어 사용 시 표시됨)
	    });
		nMap.map.addOverlay(marker);
    });   */
    
    $(function(){
 	  /* 	$("#naverMapLink").on("click",function(e){
    		e.preventDefault();
    		var slat = "";
    		var slng = "";
    		
    		var elng = $("#longitude").val();
			var elat = $("#latitude").val();
			var etext = $("#addr").val();
    		
    		if (navigator.geolocation) { // GPS를 지원하면
    			navigator.geolocation.getCurrentPosition(function(position) {
	 				//console.log("좌표:"+position.coords.latitude + ' ' + position.coords.longitude);
	 				slat = position.coords.latitude;
	 				slng = position.coords.longitude;
	 				//console.log("좌표2:"+slat + ' ' + slng);
	 			 	mapLink();
	 			 	
	    			}, function(error) {
	    				console.log(error);
		 			    mapLink();
		 			}, {
		 			      enableHighAccuracy: true,
		 			      maximumAge: 0,
		 			      timeout: 10000
		 			    }
		 			)
	 			} else {
	 			  	 alert('GPS를 지원하지 않습니다');
	 			}
    		
    			function mapLink(){
    				var openNewWindow = window.open();
  	     			url = "https://map.naver.com/index.nhn?slng="+slng+"&slat="+slat+"&stext=출발지&elng="+elng+"&elat="+elat+"&etext="+etext+"&menu=route&pathType=0";
  	     			
  	     			//url = "nmap://route/public?slat=" +  slng + "&slng=" + slat  + "&sname=내위치&dlat=" + elng + "&dlng=" + elat +  "&dname=" + etext + "&appname=bikeSeoul";
  	     					
  	     			openNewWindow.location.href = url;
    			}
    	});
    	 */
    	
    	$("#cancelBtn").on("click", function(e) {
    		e.preventDefault();
    		window.close();
    	});
    	
    	var nMap = {};
        nMap.map = null;
        nMap.defaultLatitude = 37.5675451;
    	nMap.defaultLongitude = 126.9773356;
        $("#mapDiv").empty();
      
        nMap.detectCoveredMarker = true;
        
      //var mSize = nMap.getCalcMapSize();
    	var mSize = {width : 600, height : 470};

    	//nMap.setOption(mSize.w,mSize.h);	
    	//nMap.windowHeight = mSize.h;
    	
    	/* Naver API 3.0*/
    	if($("#latitude").val() !=''){
    		nMap.defaultLatitude = $("#latitude").val();
    		nMap.defaultLongitude = $("#longitude").val();
    	}
    	
		var oPoint = new naver.maps.LatLng(nMap.defaultLatitude ,nMap.defaultLongitude);	
    	
    	nMap.map = new naver.maps.Map("mapDiv", {
            size: new naver.maps.Size( 600, 470),
            center: new naver.maps.LatLng(oPoint), //지도의 초기 중심 좌표
            zoom: 15, //지도의 초기 줌 레벨
            minZoom: 8, //지도의 최소 줌 레벨
            zoomControl: true, //줌 컨트롤의 표시 여부
            zoomControlOptions: { //줌 컨트롤의 옵션
            position: naver.maps.Position.LEFT_BOTTOM
            }
        });	
    	
    	var marker = new naver.maps.Marker({
    	    position: oPoint,
    	    map: nMap.map
    	});

    });
    </script>
</body>
</html>