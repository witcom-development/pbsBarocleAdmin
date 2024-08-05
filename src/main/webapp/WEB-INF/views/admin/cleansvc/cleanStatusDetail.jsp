<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />
<meta name="description=" Content="" />
<title><tiles:insertAttribute name="title"/></title>
<tiles:insertAttribute name="resource"/>
</head>
<body>
<!-- solbit test-테스트 페이지  S   -->
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
                    <div class="page">

						<!-- 검색조건  S -->
                       	<form id="searchFrm">
							<input type="hidden" name="reg_lat">
							<input type="hidden" name="reg_long">
							<input type="hidden" name="clean_type" value="${cVO.clean_type}">
							
	                        <div class="shBox- border pt-2 pl-2 bg-light">	                        	
	                        	<fieldset>
									<div class="shBoxSection">
	
										<div class="section pleft">
											<label for="aa2" class="laType02">ID </label>
											<span class="input-text07"><input type="text" id="reg_id" readonly="readonly" name="reg_id" class="" value="${cVO.reg_id}" /></span>
										</div>
										<div class="section pright">
											<label for="aa1" class="laType02"><c:if test="${cVO.clean_type eq 'A'}">출근위치</c:if><c:if test="${cVO.clean_type eq 'B'}">퇴근위치</c:if></label>
											<span class="input-text07"><input type="text" id="reg_addr" readonly="readonly" name="reg_addr" class=""/></span>
										</div>
										<div class="section pleft">
											<label for="aa2" class="laType02"><c:if test="${cVO.clean_type eq 'A'}">출근시간</c:if><c:if test="${cVO.clean_type eq 'B'}">퇴근시간</c:if></label>
											<span class="input-text07">시간은 출/퇴근 신고 기준으로 측정됩니다</span>
										</div>
	
									</div>
								</fieldset>
							</div>

						</form>
                       	<!-- 검색조건  E -->
                       	
                       <div id="upp" class="shBox- border pt-2 pl-2 bg-light">
	                    <div id="map" style="border:1px solid #000;position: fixed; top: 0px; left: 0px; width: 100%; height: 65%; margin:0;padding:0; ">
					 		
						</div>
						</div>
                       	

                       	
                       	<div id="stWorkOn">
	                       	<div class="d-flex justify-content-center">
	                       		<div id="reg_clean" class="s-btn s-btn-success px-4 btnWork m-1"><c:if test="${cVO.clean_type eq 'A'}">출근신고</c:if><c:if test="${cVO.clean_type eq 'B'}">퇴근신고</c:if></div>
	                       		<div class="s-btn s-btn-outline-success px-4 btnWorkBack m-1"><a href="javascript:history.go(-1)">뒤로가기</a></div>
	                       	</div>
						</div>
						
						
						
                    </div>
                 </div>
             </div>
      	</div>
                       	
</body>

<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=icuxwf317o&callback=draw"></script> 
<!-- <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=guq823qajs&callback=draw"></script> --> 
<script type="text/javascript" src="/js/common_barocle.js"></script>
<script type="text/javascript">
	var isGPS;
	var MAP_lat =  37.5716184;
	var MAP_lng = 127.0360526;
		isGPS = false;
	var wpid;
	var strAddr;

	//기본 중심좌표
	var oCenterPoint = new naver.maps.LatLng(MAP_lat, MAP_lng);
	var myPoint = new naver.maps.LatLng(MAP_lat, MAP_lng);
	var defaultLevel = 12;
	var $window = $(window);
	// 지도 생성

	var infowindow = new naver.maps.InfoWindow();
	
	alert('본인의 현재 위치와 다를 경우 기기의 위치 기능을 사용 설정 한 후 이용해 주세요');
	
	var oMap = new naver.maps.Map(
		document.getElementById('map'), {
			point : oCenterPoint,
			zoom : defaultLevel,
			enableWheelZoom : true,
			enableDragPan : true,
			mapTypeControl: true,
	
			enableDblClickZoom : false,
			mapMode : 0,
			activateTrafficMap : false,
			activateBicycleMap : false,
			minMaxLevel : [ 5, 14 ],
			size : new naver.maps.Size($("#upp").width()-20,$("#map").height()-60)
	});
	
    $window.on('resize', function() {
    	oMap.setSize(getMapSize());
    });

    function getMapSize() {
        var size = new naver.maps.Size($("#upp").width() - 20, $window.height()- 150);
        return size;
    };
    
 	// 지도 크기 변경
    function resizeMap(nWidth, nHeight) {
    	var pSize = new naver.maps.Size(nWidth, nHeight);
    	if(oMap != null) oMap.setSize(pSize);
    }

    function searchCoordinateToAddress(latlng) {
    	
		////////////solbit new type 190125
    	$.ajax({
    	    url : "https://api.vworld.kr/req/address?service=address&request=getAddress&key=652E49DF-36A1-3F0C-AA43-BE68303B507C&type=BOTH&point=" + MAP_lng + "," + MAP_lat ,
    	    type : "GET",
    	    data : {    	    	
    	    },
    	    dataType : "jsonp",    	   
    	    success: function(api) {
    	    	if(api.response.status=='OK')
    	    	{	
    	    		strTemp = api.response.result[0].text;
    	    		strTemp = strTemp.replace('대한민국 ', '');
    	    		strTemp = strTemp.replace('서울특별시', '');
    	    		strTemp = strTemp.replace('한국', '');
    	    		$("#reg_addr").val(strTemp);
    	    	}
    	    	else
    	    	{
    	    		alert('좌표값이 올바르지 않습니다 다시 지도를 검색해주세요');    		
    	    		
    	    		isworkingmap='F';
    	    	}
    	    }
    	});
    	 
    }
    
    function onSuccessGeolocation(position) {
        var location = new naver.maps.LatLng(position.coords.latitude,
                                             position.coords.longitude);

        oMap.setCenter(location); // 얻은 좌표를 지도의 중심으로 설정합니다.
        oMap.setZoom(18); // 지도의 줌 레벨을 변경합니다.

        infowindow.setContent('<div style="padding:20px;">' + '내 현재 위치를 확인하세요' + '</div>');

        infowindow.open(oMap, location);
        
        MAP_lat = position.coords.latitude;
        MAP_lng = position.coords.longitude;
        
		searchCoordinateToAddress(location);
    }

    function onErrorGeolocation() {
    	 var location = new naver.maps.LatLng(MAP_lat,
    			 MAP_lng);
    	 oMap.setCenter(location); // 얻은 좌표를 지도의 중심으로 설정합니다.
         oMap.setZoom(18); // 지도의 줌 레벨을 변경합니다.
         
         infowindow.setContent('<div style="padding:20px;">' + '내 현재 위치를 확인하세요' + '</div>');

         infowindow.open(oMap, location);
         searchCoordinateToAddress(location);
    }
    
	function draw() {
    	findLocation();
    }
    
    // 내위치 찾기 
     function findLocation(){
    	 
		if (navigator.geolocation) {
			  var options = {
				enableHighAccuracy : true,
				timeout : 10000,
				maximumAge : 6000
			};  
			navigator.geolocation.getCurrentPosition(onSuccessGeolocation, onErrorGeolocation, options);
		} else {
			alert("이 브라우저는 Geolocation를 지원하지 않습니다.");
		}
     }
    
    $(function(){
    	
    	$("#reg_clean").on("click",function(e){
    		$("[name='reg_lat']").val(MAP_lat);
    		$("[name='reg_long']").val(MAP_lng);
    		
    		
			if(confirm($("#reg_addr").val()+'의 주소로 신고 하시겠습니까?')) {
			  //$("#searchFrm").attr({method : 'post', action : '/cleanStatusReg.do'}).submit();
			  
			  var params = {};
    			params.reg_id = '';
    			params.reg_name = '';
    			params.clean_type = $("[name='clean_type']").val();
    			
    			params.reg_lat = MAP_lat;
    			params.reg_long = MAP_lng;   
    			
    			params.reg_addr = $("#reg_addr").val();
    			params.reg_addr_detail = $("#reg_addr_detail").val();
    			
    			
    		 var url = "/cleanStatusReg.do";	
    			
				$.ajax({
    				type : "post",
    				url : url,
    				data : params,
    				success : function(data){
    					//if(data.checkResult < 0 ) alert('중복');
    					if (typeof data.checkResult === 'undefined') {
    						alert("출퇴근 신고가 이미 처리 되었습니다. 관리자에게 문의 하세요.");	
    					} else {
    						if(data.checkResult==1) {
    							alert("등록에 성공하였습니다.");
    						} else {
    							alert("출퇴근 신고가 이미 처리 되었습니다. 관리자에게 문의 하세요.");
    						}
    					}
    					
    					
    					location.href='/cleanStatus.do';
    				},
    				error : function(data){
    					alert("실패했습니다.");
    				}
    			});
				
			}
		});
    	
    	naver.maps.Event.once( oMap , 'init_stylemap', function () {
    		
    		var locationBtnHtml = "<div style='padding:10px'><img src='/images/location_re.png'></div>";	// GPS 위치 아이콘
    		
    		var locationCustomControl = new naver.maps.CustomControl(locationBtnHtml, {
	        	position: naver.maps.Position.RIGHT_CENTER
	        });
	        
	        locationCustomControl.setMap( oMap );
	        
	        var domEventListener = naver.maps.Event.addDOMListener(locationCustomControl.getElement(), 'click', function() {
	        	findLocation();
	        });
	               
    	});
    	
    });
    

    </script>
</html>