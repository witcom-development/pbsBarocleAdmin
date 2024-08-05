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
         
			
			<span class="input-text08 ml10 mr10" style="display: none;"><input id="latitude" name="latitude" type="text" value="${info.latitude}" readonly/></span>
			<span class="input-text08 ml10 " style="display: none;"><input id="longitude" name="longitude" type="text" value="${info.longitude}" readonly/></span>
			<%-- <table style="width:100%; ">
				<tr>
					<td width="10%;" align="center"><span>주소:</span></td><td width="73%;"><span class="ml10"><input id="addr" name="addr" type="text" value="${info.addr}" style="width: 90%;" readonly/></span></td>
					<td align="left" width="17%" style="vertical-align:middle;" rowspan="2">
					<a href=" nmap://route/car?dlat=${info.latitude}&dlng=${info.longitude}&dname=${info.parkingLocation}&appname=bikeSeoul">
					길찾기</a></td>
				</tr>
				<tr >
					<td width="10%;" align="center"><span>상세:</span></td><td width="73%;"><span class="ml10"><input id="parkingLocation" name="parkingLocation" type="text" value="${info.parkingLocation}" style="width: 90%;" readonly/></span></td>
				</tr>
			</table> --%>
			
            <div class="didBox pop">
				<div class="mapBox" id="mapDiv" style="height: 70%;width: 40%;"><!--style="height:500px" 는 영역 표시를 위한 임시값입니다. 트리구조 삽입후 삭제하셔야 합니다.-->
                </div>
			</div>
			
               
			<!-- <div class="btnArea">
                <span class="right">
                	<button class="btnType01" id="cancelBtn">닫기</button>
                </span>
            </div> -->
        </div>
    </div>
    <a href="#" class="popclose"><img src="/images/btn_close.png" alt="팝업닫기" /></a>
    <%-- <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v2/maps.js?clientId=${naverMapApiKey}"></script> --%>
    <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=4791tlnwi5"></script>
    <!-- <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=782hpigcuy"></script> -->
    <script type="text/javascript" src="/js/common_barocle.js"></script>
    <script type="text/javascript">
    
    $(function(){
    	
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
    	} else{
    		alert("자전거 정보가 없습니다.");
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
    	
    	if($("#latitude").val() !=''){
	    	var marker = new naver.maps.Marker({
	    	    position: oPoint,
	    	    map: nMap.map
	    	});
    	}

    });
    </script>
</body>
</html>