var nMap = {};
nMap.map = null;
nMap.mapZoom = null; 
nMap.eventFlg = false;
nMap.infoWindowData = [];
nMap.defaultSize = null;
nMap.targetViewData = [];
nMap.defaultLatitude = 37.5675451;
nMap.defaultLongitude = 126.9773356;
nMap.stationImgFilePath='';
nMap.defaultLevel = 9;
nMap.popType = '';
nMap.infoWindowType = '';
nMap.viewType="";
nMap.windowHeight = 0;
nMap.oInfoWnd = null;
nMap.locationMarker = null;
var markers = []; 
var oldMarkersLen = 0;

//파랑
//nMap.markerImages = ["/images/inc/icon_b0.png","/images/inc/icon_b1.png","/images/inc/icon_b2.png","/images/inc/icon_b3.png","/images/inc/icon_b4.png"];
//nMap.markerSmallImages = ["/images/inc/icon_s0.png","/images/inc/icon_s1.png","/images/inc/icon_s2.png","/images/inc/icon_s3.png","/images/inc/icon_s4.png"];
nMap.markerImages = ["/images/inc/icon_b0.png","/images/inc/icon_b2.png","/images/inc/icon_b3.png","/images/inc/icon_b3.png","/images/inc/icon_b3_b.png"];
nMap.markerSmallImages = ["/images/inc/icon_s0.png","/images/inc/icon_s2.png","/images/inc/icon_s3.png","/images/inc/icon_s3.png","/images/inc/icon_s3.png"];

//빨강
nMap.markerErrImages = ["/images/inc/icon_b1.png","/images/inc/icon_b1.png","/images/inc/icon_b1.png","/images/inc/icon_b1.png","/images/inc/icon_b1.png"];
nMap.markerSmallErrImages = ["/images/inc/icon_s1.png","/images/inc/icon_s1.png","/images/inc/icon_s1.png","/images/inc/icon_s1.png","/images/inc/icon_s1.png"];

//검정
nMap.markerStopImages = ["/images/inc/icon_b0.png","/images/inc/icon_b0.png","/images/inc/icon_b0.png","/images/inc/icon_b0.png","/images/inc/icon_b0.png"];
nMap.markerSmallStopImages = ["/images/inc/icon_s0.png","/images/inc/icon_s0.png","/images/inc/icon_s0.png","/images/inc/icon_s0.png","/images/inc/icon_s0.png"];

nMap.setMap = function() {
	if(nMap.map !== null){
		return false;
	}
	//var mSize = nMap.getCalcMapSize($("body").attr("id"));

	//nMap.setOption(mSize.w,mSize.h);	
	//nMap.windowHeight = mSize.h;
	
	/* Naver API 3.0*/
	//navigator.geolocation.getCurrentPosition
	var oPoint = new naver.maps.LatLng(nMap.defaultLatitude ,nMap.defaultLongitude);	
	nMap.map = new naver.maps.Map("mapDiv", {
        //size: new naver.maps.Size(764, 500),
        center: new naver.maps.LatLng(37.5675451, 126.9773356), //지도의 초기 중심 좌표
        zoom: 10, //지도의 초기 줌 레벨
        minZoom: 5, //지도의 최소 줌 레벨
        //mapTypeControl: true,
        zoomControl: false, //줌 컨트롤의 표시 여부
        zoomControlOptions: { //줌 컨트롤의 옵션
        position: naver.maps.Position.BOTTOM_RIGHT
        }
    });	
	//nMap.map.setOptions("mapTypeControl", true); //지도 유형 컨트롤의 표시 여부
};
nMap.initMap  = function() {
	$("#mapDiv").empty();
	nMap.map = null;
    nMap.setMap();
    nMap.detectCoveredMarker = true;
};

//window resize  이벤트 발생후 지도 사이즈가 변경 된후  call.
nMap.resizableMapView = function(oCustomEvent){
	//alert('resizableMapView');
	console.log('resizableMapView-->'+oCustomEvent.size.height +","+ oCustomEvent.size.width);
};

//지도 초기화용 option을 설정 . 지도 축적 레벨,지도 사이즈
nMap.setOption = function(pWidth, pHeigth) {
	nMap.defaultSize =  {width : pWidth, height : pHeigth} ;
};

nMap.makeStationMapInfo = function(rSize) {
    var _this = nMap;
	if(typeof _this.targetViewData !== 'object') {
	    return;
	}
	_this.infoWindowType = _this.infoWindowType === "" ?'station' : _this.infoWindowType;
	var lSize = _this.targetViewData.length;
	//alert(lSize);
	//alert(oldMarkersLen);
	if(lSize > 0) {
		for(var i=oldMarkersLen; i<oldMarkersLen + rSize; i+=1) {
		//for(var i=0; i<3; i+=1) {
			//arg[0] ->  거치율.  arg[1] -> 장애유무
			var bFlg =  _this.targetViewData[i].deviceBroken;
			
			if(_this.infoWindowType === 'app'){
				//app용 장애유무는 체크하지 않음.
				bFlg = false;
			}
			// 거치수
			//  var sIcon =  _this.getBikeInfoImgSrc( _this.targetViewData[i].bikeInfo, bFlg);
			// 거치율
				
			 var sIcon =  _this.getSharedImgSrc(  _this.targetViewData[i].shared,  _this.targetViewData[i].deviceBroken,  _this.targetViewData[i].stationUseYn,  _this.targetViewData[i].teamNm);
			
			//var sURL = sIcon.icon.url;
			var sContent =  sIcon.icon.content;
			var sSize= sIcon.icon.size;
			//alert(sSize);
			//alert("df"+sSize.w);
			var markerOptions = {
    				position: new naver.maps.LatLng(_this.targetViewData[i].latitude,  _this.targetViewData[i].longitude),
    				map:nMap.map,
    				icon: {
        				//url: sURL,
        				//size: sSize,
        				content: sContent,
            	        size: sSize,
            	        //anchor: new naver.maps.Point(11, 35),
					title :  _this.targetViewData[i].stationName      				
    					}
			    };	
			    
            var marker = new naver.maps.Marker(markerOptions);
			
            
			markers.push(marker);
			naver.maps.Event.addListener(markers[i], 'click', getClickHandler(i));
		}
		
		oldMarkersLen = oldMarkersLen + rSize;
		
		//_this.map.attach('click', _this.showInfoWindow);
		/**
		 * TODO:지도중앙 계산. 아파트별
		 * */
		if(nMap.viewType === "search" ){
			var idx = (lSize-1);
			nMap.setMapCenterPosi(_this.targetViewData[idx].latitude, _this.targetViewData[idx].longitude);
		}
	} else {
		var imgSrc =nMap.getHitImg(_this.map.getSize().height);
		var opt = {imgSrc :imgSrc.src, imgWidth : imgSrc.w,  imgHeight : imgSrc.h, latitude : _this.defaultLatitude, longitude : _this.defaultLongitude, title :  "대여소", smallImg: '/images/inc/staMap_shit.png'};
		var marker = nMap.makeMarker(opt);
		//marker.setMap(_this.map);
		//_this.map.addOverlay(marker);
	}
};

nMap.makeStationMapInfoClean = function(rSize,clean) {
    var _this = nMap;
    oldMarkersLen =  clean;
	if(typeof _this.targetViewData !== 'object') {
	    return;
	}
	_this.infoWindowType = _this.infoWindowType === "" ?'station' : _this.infoWindowType;
	var lSize = _this.targetViewData.length;
	if(lSize > 0) {
		for(var i=oldMarkersLen; i<oldMarkersLen + rSize; i+=1) {
		//for(var i=0; i<3; i+=1) {
			//arg[0] ->  거치율.  arg[1] -> 장애유무
			var bFlg =  _this.targetViewData[i].deviceBroken;
			
			if(_this.infoWindowType === 'app'){
				//app용 장애유무는 체크하지 않음.
				bFlg = false;
			}
			
			  //var sIcon =  _this.getBikeInfoImgSrc( _this.targetViewData[i].bikeInfo, bFlg);
			
			 var sIcon =  _this.getSharedImgSrc(  _this.targetViewData[i].shared,  _this.targetViewData[i].deviceBroken,  _this.targetViewData[i].stationUseYn);
			
			//var sURL= sIcon.icon.url;
			 var sContent= sIcon.icon.content;
			var sSize= sIcon.icon.size;
			/*var markerOptions = {
    				position: new naver.maps.LatLng(_this.targetViewData[i].latitude,  _this.targetViewData[i].longitude),
    				map:nMap.map,
    				icon: {
        				url: sURL,
                        size: sSize,
					title :  _this.targetViewData[i].stationName      				
    					}
			    };*/
			var markerOptions = {
    				position: new naver.maps.LatLng(_this.targetViewData[i].latitude,  _this.targetViewData[i].longitude),
    				map:nMap.map,
    				icon: {
        				url: sURL,
        				//size: sSize,
        				content: '<div style="position:relative; background:url(https://www.bikeseoul.com/images/inc/icon_b3.png) no-repeat; cursor: pointer; width: 20px; height: 23px;"><div style="text-align:center; font-size:11px; color:#fff; padding-top:2px">23</div></div>',
            	        size: new naver.maps.Size(22, 35),
					title :  _this.targetViewData[i].stationName      				
    					}
			    };	
			    
            var marker = new naver.maps.Marker(markerOptions);
			
            
			markers.push(marker);
			naver.maps.Event.addListener(markers[i], 'click', getClickHandler(i));
		}
		
		oldMarkersLen = oldMarkersLen + rSize;
		
		//_this.map.attach('click', _this.showInfoWindow);
		/**
		 * TODO:지도중앙 계산. 아파트별
		 * */
		if(nMap.viewType === "search" ){
			var idx = (lSize-1);
			nMap.setMapCenterPosi(_this.targetViewData[idx].latitude, _this.targetViewData[idx].longitude);
		}
	} else {
		var imgSrc =nMap.getHitImg(_this.map.getSize().height);
		var opt = {imgSrc :imgSrc.src, imgWidth : imgSrc.w,  imgHeight : imgSrc.h, latitude : _this.defaultLatitude, longitude : _this.defaultLongitude, title :  "대여소", smallImg: '/images/inc/staMap_shit.png'};
		var marker = nMap.makeMarker(opt);
		//marker.setMap(_this.map);
		//_this.map.addOverlay(marker);
	}
};



nMap.changeMarker = function() {
    
	/*var _this = nMap;
    //var markers = []; 
	if(typeof _this.targetViewData !== 'object') {
	    return;
	}
	_this.infoWindowType = _this.infoWindowType === "" ?'station' : _this.infoWindowType;
	var lSize = _this.targetViewData.length;
	var w = 9, h=10;
	if(nMap.map.zoom >= 8){
		w = 20, h = 23;
	}
	if(lSize > 0) {
		for(var i=0; i<lSize; i+=1) {
			var bFlg =  _this.targetViewData[i].deviceBroken;
			var sIcon =  _this.getBikeInfoImgSrc( _this.targetViewData[i].bikeInfo, bFlg);
			var sURL= sIcon.icon.url;
			
			
			marker = markers[i];
			marker.setIcon({
				url : sURL,
				size : new naver.maps.Size(w, h)
			})
		}
	}*/
};




//대여소 검색시 대여소별로 중심 좌표를 변경.
nMap.setMapCenterPosi = function(pCenterX, pCenterY) {
	nMap.map.setCenter(new naver.maps.LatLng(pCenterX,pCenterY));
};

function getClickHandler(seq) {
    return function(e) {
        
        //console.log(seq);
        
    	// guide_box 숨김
    	$("#guide_box").css('display', "none");
    	
        var infoData = null;
	
	infoData = nMap.targetViewData[seq];
	var infoW = "226px";

	var today = new Date();
	var year  = today.getFullYear();
	var month = today.getMonth() + 1;
	var date  = today.getDate();
	var time = today.getHours()+":"+today.getMinutes()+":"+today.getSeconds();
	var timehtml = '조회시간 <em style="color:#f1424f">'+year+'.'+month+'.'+date+' '+time+'</em>';


	/*var cont =  '<DIV id="infoBox" style="border:2px solid #001b31; background-color:#fff; margin:0 auto; padding:15px; width:226px; height:170px;">';
    cont += '<p style="border-bottom:2px solid #494949; overflow:hidden; position:relative;top:35px;"><h3 style="margin-top:10px"><span>'+infoData.stationName+'</span></h3>';
    cont += '<button  style="background:url(/images/close.png); width:20px; height:20px; position:absolute; top:0; right:0" id="closeBtn"></button>';
    cont += '<button style="background:url(/images/favorite.png); width:20px; height:20px; position:absolute; top:25px; right:10px; z-index:10001" id="favoriteBtn"></button></p>';
    cont += '<div style="text-align:center; padding:10px 0 5px 0;"><span style="margin-top:10px; display:block">대여가능 자전거</span><p style="font-size:45px; line-height:45px; font-weight:bold; border-bottom:2px solid #dfdfdf; width:100%; padding-bottom:10px;cursor:pointer">'+infoData.bikeInfo+'</p>';
    cont += '<p class="time" style="font-size:11px; text-align:right;">'+timehtml+'</p></div>';
    if(nMap.infoWindowType == 'reco') {
    	cont += '<div style="position:relative;"><a href="" style="background-color:#72ebc9; line-height:35px; width:142px; margin:0 auto; display:block; cursor:pointer; text-align:center; font-size:13px; font-weight:bold">확인</a>';
    } else {
    	cont += '<div style="position:relative;"><a href="" style="background-color:#72ebc9; line-height:35px; width:142px; margin:0 auto; display:block; cursor:pointer; text-align:center; font-size:13px; font-weight:bold">대여</a>';
    }
    
    cont += '</div></DIV>';*/
	var cont = '<DIV  id="infoBox" style="border:2px solid #555; background:#fff; font-family:dotum; width:230px; text-align:left;" >';
    cont += '       <p style="border-bottom:1px solid #c9c9c9; font-size:14px;color:#333; position:relative">';
    cont += '           <span style="margin:10px 0 10px 10px; font-weight:bold; display:block;">'+infoData.stationName+'</span>';
    cont += '           <a href="#" style="position:absolute; top:-3px; right:10px" class="closeBtn"><img src="/images/stationClose.gif" alt="대여소 정보닫기" /></a>';
    cont += '       </p>';
    var sImg = infoData.stationImg === "" ? "/images/mapNoimg.gif" : "data:image/gif;base64,"+infoData.stationImg;
    var longT = infoData.longTerm === null ?"0" :infoData.longTerm;
   // cont += '       <p style="display:inline-block; margin:5px; vertical-align:top;"><img src="'+sImg+'" style="width:50px; height:50px" alt="" /></p>';
    cont += '       <ul style="display:inline-block; vertical-align:middle; font-size:14px;margin:5px;">';
	cont += '           <li>거치대  : <span style="color:#000099;">'+infoData.rackInfo+'</span></li>';
	cont += '           <li>자전거  : <span style="color:#000099;">'+infoData.bikeInfo+'</span></li>';
    cont += '           <li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" id="detailBtn" class="detailBtn">상세정보</a></li>';
//	cont += '           <li>장기미반납  : <span style="color:#000099;">'+longT+'</span></li>';
//    cont += '           <li>거치율(%)  : <span style="color:#000099;">'+infoData.shared+'%</span></li>';
    cont += '       </ul>';
    //cont += '           <p><a href="#" id="detailBtn" class="detailBtn">상세</a></p>';
    cont += '       <p style="text-align:center; margin-bottom:-16px;"><img src="/images/stationPos.png" style="display:block; margin:0 auto;width:21px;height:16px;" alt="" /></p>';
    cont += '   </DIV>';
            
	
   	var infoWindow = new naver.maps.InfoWindow({
        	content: cont
    	});	
    	
	var center = new naver.maps.LatLng(infoData.latitude,infoData.longitude);

	
	infoWindow.open(nMap.map,center);
	
	 $("#infoBox a").on("click", function(e){
		 e.preventDefault();
		/* if(nMap.infoWindowType == 'reco') {
			 infoWindow.close(nMap.map,center);
		 } else {
			 goBikeRent(infoData);
		 }*/
		 
	       	infoWindow.close(nMap.map,center);
        });
	 
	 $("#favoriteBtn").on("click", function(e){
		 e.preventDefault();
		 goFavoriteStation(infoData);
	    //   	infoWindow.close(nMap.map,center);
        });
	 
	 $("#closeBtn").on("click", function(e){
		 e.preventDefault();
	     infoWindow.close(nMap.map,center);
       });
	 
	 $("#detailBtn").on("click", function(e){
		 e.preventDefault();
		 moveStationDetail2(infoData.stationId);
	    //   	infoWindow.close(nMap.map,center);
        });
    }
    
    
    
    
}

nMap.makeMarker = function(pMarkerOpt) {
	
	var sIcon = null;
	
	if(typeof pMarkerOpt.imgSrc === 'string') {
		
	 sIcon = {
    		icon: {
        		url: pMarkerOpt.imgSrc,
        		size: new naver.maps.Size(pMarkerOpt.imgWidth, pMarkerOpt.imgHeight)
    		      }
		 };	
				
	} else {
		sIcon = pMarkerOpt.imgSrc;
	}

	var sURL= sIcon.icon.url;
	
	var markerOptions = {
    				position: new naver.maps.LatLng(pMarkerOpt.latitude,  pMarkerOpt.longitude),
    				map:nMap.map,
    				icon: {
        				url: sURL,
    					//content: '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:red;text-align:center;font-weight:bold;background:url(/images/inc/staOn_0p.png);background-size:contain;"><span>1</span></div>2',
    	        //size: new naver.maps.Size(22, 35),
    	        //anchor: new naver.maps.Point(11, 35),
        				content: '<div style="position:relative; background:url(https://www.bikeseoul.com/images/inc/icon_b3.png) no-repeat; cursor: pointer; width: 20px; height: 23px;"><div style="text-align:center; font-size:11px; color:#fff; padding-top:2px"><br>23</div></div>',
            	        //size: new naver.maps.Size(22, 35),
					title :  pMarkerOpt.title        				
    					}
			    };	
			    
        var marker = new naver.maps.Marker(markerOptions);
                          
	return marker;
	
	
};
nMap.showInfoWindow = function(oCustomEvent) {

};
//maker  Icon 생성.
//TODO://반납추천 대여소의 경우 거치율 표시 필요없음.


nMap.getSharedImgSrc = function(pShared, pDeviceBFlg, pStopFlg, teamNm) {
	var _this = nMap;
	var imgSrc = "";
	var w = 20, h=23, p=3;
	var imgSrc = "";
	/*if(nMap.map.zoom >= 8){
		w = 20, h = 23;
	}*/
	var s = parseInt(pShared);
	if(s>100){
		//alert(s);
		w = 35, h = 40, p=12;
	}
	
	if(teamNm==null){
		teamNm='';
	}
		
	//var mLevel = _this.map.getLevel();
	//0%,25%,50%,75%,100%
	//var s = parseInt(pShared);
	var iidx = 0;
	if(s <= 25 ) {iidx=1;} 
	else if( s <= 50) {iidx=2;} 
	else if( s <= 100) {iidx=3;} 
	else if(100 < s ) {iidx=4;} 
	if( s === 0) {iidx=0;} 
	
		if(pDeviceBFlg){
			imgSrc = _this.markerErrImages[iidx];
		} else {
			imgSrc = _this.markerImages[iidx];
		}
		if(pStopFlg === 'N')  {
			imgSrc = _this.makerStopImages[iidx];
		}
	
	var img = {
    			icon: {
        			url: imgSrc,
        			content: '<div style="position:relative; background:url('+imgSrc+') no-repeat; cursor: pointer; width: '+w+'px; height: '+h+'px;"><div style="text-align:center; font-size:11px; color:#fff; padding-top:'+p+'px">'+teamNm+'</div></div>',
        			size: new naver.maps.Size(w,h)
    			      }
		  };	
		
	return img;
}; 


//maker  Icon 생성.
//TODO://반납추천 대여소의 경우 거치율 표시 필요없음.
nMap.getBikeInfoImgSrc = function(pBikeInfo, pDeviceBFlg) {
	var _this = nMap;
	var imgSrc = "", w = 9, h=10;
	var iidx = nMap.getBikeInfoIdx(parseInt(pBikeInfo));
	if(nMap.map.zoom >= 8){
		w = 20, h = 23;
		if(iidx==4){
			w = 30, h = 43;
		}
	}
	//var height = nMap.map.getSize().height;
	if(_this.infoWindowType ==='return') {
		//if(nMap.map.getSize().height < 600) {
		  if(nMap.map.zoom < 8) {
			//w = 17,h=21;
			if(pDeviceBFlg === 'good' || pDeviceBFlg === 'less'){
				imgSrc = nMap.markerSmallImages[4];
			}else if(pDeviceBFlg === 'over') {
				imgSrc = nMap.markerSmallStopImages[4];
			} else {}
		} else {
			if(pDeviceBFlg === 'good' || pDeviceBFlg === 'less'){
				imgSrc = nMap.markerImages[4];
			}else if(pDeviceBFlg === 'over') {
				imgSrc = nMap.markerStopImages[4];
			} else {}
		}
	} else {
		//0%,25%,50%,75%,100%
		//var iidx = nMap.getBikeInfoIdx(parseInt(pBikeInfo));
		//if(nMap.map.getSize().height < 700){
		if(nMap.map.zoom < 10){
			//w = 17,h=21;
			if(pDeviceBFlg){
				imgSrc = _this.markerSmallStopImages[iidx];
			} else {
				imgSrc = _this.markerSmallImages[iidx];
			}
		} else {
			if(pDeviceBFlg){
				imgSrc = _this.markerStopImages[iidx];
			} else {
				imgSrc = _this.markerImages[iidx];
			}
		}
	}
	var img = {
  			icon: {
      			url: imgSrc,
      			size: new naver.maps.Size(w,h)
  			      }
		  };	
		
	return img;
}; 
// 거치 수
nMap.getBikeInfoIdx  = function(s){
	var iidx = 0;
	if(s < 1 ) {
		iidx=4;
	} else if( s <= 3) {
		iidx=1;
	}	else if( s <= 6) {
		iidx=2;
	} else if(6 < s ) {
		iidx=3;
	} 
	if( s === 0) {iidx=4;} 
	
	return iidx;
};

nMap.setStationNearMallMap = function() {
	
	var _this = nMap;
	if(typeof _this.targetViewData !== 'object') {
		return;
	}
	_this.infoWindowType = 'mall';
	var rSize = _this.targetViewData.length;
	//var cSize = Math.abs(rSize/2);
	//var carLocation = [];
	_this.infoWindowData = [];
	
	var imgSrc = nMap.getHitImg(nMap.map.getSize().height);
	for(var i = 0; i < rSize; i+=1) {
		var opt = {imgSrc :imgSrc.src, imgWidth :imgSrc.w,  imgHeight : imgSrc.h, latitude : _this.targetViewData[i].latitude, longitude :_this.targetViewData[i].longitude, title :  _this.targetViewData[i].shopName , smallImg: '/images/inc/staMap_shit.png'};
		var marker = nMap.makeMarker(opt);
		_this.infoWindowData.push({sId : _this.targetViewData[i].shopName
								  ,info : [{stationName : _this.targetViewData[i].stationName
									       ,shopAdSeq   : _this.targetViewData[i].shopAdSeq
					                       ,shopName    : _this.targetViewData[i].shopName
					                       ,shopTelNo   : _this.targetViewData[i].shopTelNo
					                       ,typeClsName : _this.targetViewData[i].typeClsName
					                      }]});
		_this.map.addOverlay(marker);
	}
	_this.map.attach('click', _this.showInfoWindow);
	
	if(rSize === 1){
		_this.map.setCenter(new naver.maps.LatLng(_this.targetViewData[0].latitude, _this.targetViewData[0].longitude));
	} else {
		var cc = _this.map.getCenter();
		_this.map.setCenter(cc);
	}
	
};
nMap.getHitImg = function (pHeight){
	var imgSrc = "/images/inc/staMap_hit.png",iWidth = 38,iHeight=48;
	if(pHeight < 600){
		imgSrc = "/images/inc/staMap_shit.png";
		iWidth = 23;
		iHeight = 28;
	}	
	return {src : imgSrc, w : iWidth, h: iHeight};
	
};

//search by tm128 coordinate
nMap.searchCoordinateToAddress = function (latlng) {
    var tm128 = naver.maps.TransCoord.fromLatLngToTM128(latlng);

    infoWindowAddr.close();

    naver.maps.Service.reverseGeocode({
        location: tm128,
        coordType: naver.maps.Service.CoordType.TM128
    }, function(status, response) {
        if (status === naver.maps.Service.Status.ERROR) {
            return alert('Something Wrong!');
        }

        var items = response.result.items;

        for (var i=0, ii=items.length, item, addrType; i<ii; i++) {
            item = items[i];

            centerGu = item.addrdetail.sigugun;
        }
        searchGuNum(centerGu);
        
        nMap.map.setCenter(latlng);
        if (sigugun.indexOf(centerGu+',') === -1) {
        	station.getMapData({stationGrpSeq : centerGuNo}, "infoBox");
            sigugun = sigugun + centerGu + ',';
        }
    	
    });
}

//marker label
nMap.setGPSLoc = function(pLat,pLog){
	var w=40,h=40;
	var src = "/images/inc/icon_position.png";
	if(nMap.map.getSize().height < 600) {
		w=40,h=40;
	}
	nMap.setMapCenterPosi(pLat,pLog);
	var opt = {imgSrc :src, imgWidth : w,  imgHeight : h, latitude :pLat , longitude : pLog, title :  "현재위치", smallImg : "/images/inc/icon_position.png"};
	
	if (nMap.locationMarker === null) {
		nMap.locationMarker = nMap.makeMarker(opt);
		//nMap.map.addOverlay(nMap.makeMarker(opt));
	} else {
		nMap.locationMarker.setPosition(new naver.maps.LatLng(pLat , pLog));
	}
	
    //var mLabel = new naver.maps.MarkerLabel({detectCoveredMarker : true});
    //nMap.map.addOverlay(mLabel);
    //mLabel.setVisible(true,nMap.locationMarker);
    //nMap.map.setCenter(new nhn.api.map.LatLng(pLat , pLog));
	
    //searchCoordinateToAddress(new nhn.api.map.LatLng(pLat , pLog));
};

nMap.getCalcMapSize = function(pId){
	var mWidht = 0;
	var mHeight =0 ;  
	if(nMap.popType === 'single') {
		mHeight = $("#"+pId).innerHeight() -60;
		mWidht =  $("#"+pId).innerWidth();
		if(nMap.infoWindowType === 'mall') {
			var tHeight = $(".popcntbox").height();
			mHeight = mHeight/2;
			if(mHeight > 700) {
				mHeight += tHeight;
			}
			mWidht =  $(".popcntbox").innerWidth() - (parseInt($(".popcntbox").css('padding'))*2);
		}
	} else {
		var leftOff = 0;
		if($("#container").offset() !== undefined) {
			leftOff = (2+$("#container").offset().left);
		}
		if($("#container").innerWidth() < leftOff) leftOff =0;
		var viewHeight = screen.height - ($("header#gnbhead").height()+$(".pwTM").innerHeight()+ $("footer").height());
		var topOff = 0;
		if($(".newmapsta").length > 0) {
			topOff = $(".newmapsta").offset().top -($(".pwPC").height()+$(".pwheader").height());
			if(screen.height <= 500){
				topOff = 30; 
			} else if(screen.height <= 700){
				topOff = 50; 
			} else if(screen.height <= 800) {
				topOff = topOff- 150; 
			} else {
				
			}
			if(viewHeight < topOff) {
				topOff = 0;
			}
		}
		if(nMap.infoWindowType === 'return') {
			topOff = topOff + 450;
		}
		mWidht = $("#container").innerWidth() -3;
		mHeight =viewHeight - topOff;
		if(mHeight < 100) {
			mHeight = viewHeight;
		}
		if($("body").attr("id")=== 'app'){
			//alert("app1");
			/*var conHeight = $(window).innerHeight();
			var top =  $(".ctnox").offset().top + $(".pwheader").innerHeight() + $(".selectitle2").innerHeight();
			mHeight = conHeight - (top-50);
			//var cHeight = mHeight +100;
			$("#app #container").css({"height": mHeight+"px"});*/
		}
		
		if((nMap.infoWindowType !== 'return' && nMap.infoWindowType !== 'app') && screen.height >1000) {
			mHeight = 500;
		}
		
	}
	return {w : mWidht, h :mHeight};
};
window.onresize = function(e){
	nMap.resize();
};

nMap.resize = function(){
	var mSizeOp = nMap.getCalcMapSize($("body").attr("id"));
	var mSize = new naver.maps.Size(mSizeOp.w,nMap.windowHeight);
	//resize 막음
	//nMap.map.setSize(mSize);
	//nMap.map.setLevel(mSizeOp.l);
	
};
//자전거 이동경로를 선으로 표시.
nMap.drawPolyLine = function() {
	var lineRouteLoc = [];
	var oPolyLine = new naver.maps.Polyline();
	if(this.targetViewData.length > 0) {
		var tSize =this.targetViewData.length; 
		for(var i=0; i <tSize; i+=1) {
			lineRouteLoc.push(new naver.maps.LatLng(this.targetViewData[i].moveLatitude , this.targetViewData[i].moveLongitude));
		}
	}
	//nMap.map.setCenter(lineRouteLoc[0]);
	
	oPolyLine.setPoints(lineRouteLoc);
	oPolyLine.setStyle({
		strokeColor : '#FF0000',
		strokeWidth : 10,
		strokeOpacity : 1,
		strokeStyle : 'solid'
	});
	nMap.map.addOverlay(oPolyLine);

};





