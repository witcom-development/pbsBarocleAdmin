/*
 * 지도용  js
 * 1)사용자,관리자 공용으로 
 * 2)
 * 
*/
var nMap = {};
/**
 *  변수들 
 * */
nMap.map = null;
nMap.defaultSize = null;
nMap.oInfoWnd = null;
nMap.viewType = '';
nMap.defaultLevel = 10;
nMap.eventFlg = false;
nMap.infoWindowData = [];
nMap.labelData = [];
nMap.targetViewData = [];
nMap.isPop = false;
//지도 디폴트 좌표 (서울 시청).
nMap.defaultLatitude = 37.5675451;
nMap.defaultLongitude = 126.9773356;
nMap.windowHeight = 0;
/**
 *  marker 이미지 Array 
 *  markerImages-> 보통
 *  markerSmallImages -> 작은 이미지 
 *  markerErrImages -> 장애 보통 
 *  markerSmallErrImages -> 장애 보통 작은 이미지
 * */
nMap.markerImages = ["/images/staOn_s0p.png","/images/staOn_s25p.png","/images/staOn_s50p.png","/images/staOn_s75p.png","/images/staOn_s100p.png"];
nMap.markerErrImages = ["/images/staErr_s0p.png","/images/staErr_s25p.png","/images/staErr_s50p.png","/images/staErr_s75p.png","/images/staErr_s100p.png"];
nMap.markerSmallImages = ["/images/staOn_ss0p.png","/images/staOn_ss25p.png","/images/staOn_ss50p.png","/images/staOn_ss75p.png","/images/staOn_ss100p.png"];
nMap.markerSmallErrImages = ["/images/staErr_ss0p.png","/images/staErr_ss25p.png","/images/staErr_ss50p.png","/images/staErr_ss75p.png","/images/staErr_ss100p.png"];
nMap.makerStopImages      = ['/images/staStop_s0p.png','/images/staStop_s25p.png','/images/staStop_s50p.png','/images/staStop_s75p.png','/images/staStop_s100p.png'];
nMap.makerSmallStopImages = ['/images/staStop_ss0p.png','/images/staStop_ss25p.png','/images/staStop_ss50p.png','/images/staStop_ss75p.png','/images/staStop_ss100p.png'];

nMap.initMap  = function() {
    nMap.map = null;
    $("#mapDiv").empty();
    nMap.setMap();
    nMap.detectCoveredMarker = true;
};

nMap.setMap = function() {
	var mSize = nMap.getCalcMapSize();
	nMap.setOption(mSize.w,mSize.h);
	nMap.windowHeight = mSize.h;
	var oPoint = new nhn.api.map.LatLng(nMap.defaultLatitude , nMap.defaultLongitude);
	nhn.api.map.setDefaultPoint('LatLng');
	
	nMap.map = new nhn.api.map.Map("mapDiv",{point :oPoint // 지도 중심점의 좌표
											,zoom : nMap.defaultLevel  // 지도의 축척 레벨
											,mapMode : 0 // 지도 모드(0 : 일반 지도, 1 : 겹침 지도, 2 : 위성 지도)
											,enableWheelZoom : false
											,enableDragPan : true
											,enableDblClickZoom : false
											,activateBicycleMap : true // 자전거 지도 활성화 여부
											,activateTrafficMap : false
											,activateRealtyMap : true
											,minMaxLevel : [ 1, 14 ]
											,size : nMap.defaultSize
											,detectCoveredMarker : true 
											}
	);
	nMap.oInfoWnd = new nhn.api.map.InfoWindow(); 
	nMap.oInfoWnd.setVisible(false);
	nMap.map.addOverlay(nMap.oInfoWnd);
	
    var mapZoom = new nhn.api.map.ZoomControl(); // - 줌 컨트롤 선언
    mapZoom.setPosition({left:5, bottom:5}); // - 줌 컨트롤 위치 지정.
    mapZoom.setCenterMarkOptions(true); // - 줌 컨트롤 위치 지정.
    nMap.map.addControl(mapZoom); // - 줌 컨트롤 추가.
    nMap.map.attach('resize', nMap.resizableMapView);
    nMap.map.attach('click', nMap.clickZoonBtn);
};
//대여소 검색시 대여소별로 중심 좌표를 변경.
nMap.clickZoonBtn = function(e) {
	
};
nMap.setMapCenterPosi = function(pCenterX, pCenterY) {
	nMap.map.setCenter(new nhn.api.map.LatLng(pCenterX,pCenterY));
};

nMap.resizableMapView = function(oCustomEvent){
	//alert('resizableMapView');
	//alert('resizableMapView-->'+oCustomEvent.size.height +","+ oCustomEvent.size.width);
};
//지도 초기화용 option을 설정 . 지도 축적 레벨,지도 사이즈
nMap.setOption = function(pWidth, pHeigth) {
	nMap.defaultSize =  {width : pWidth, height : pHeigth} ;
};
nMap.makeStationMapInfo = function() {
    var _this = nMap;
	if(typeof _this.targetViewData !== 'object') {
	    return;
	}
	var lSize = _this.targetViewData.length;
	
	var centerStation = {};
	for(var i=0; i<lSize; i+=1) {
		//arg[0] ->  거치율.  arg[1] -> 장애유무
		var sIcon =  _this.getSharedImgSrc(  _this.targetViewData[i].shared,  _this.targetViewData[i].deviceBroken,  _this.targetViewData[i].stationUseYn);
		var opt = {imgSrc :sIcon, imgWidth : 38,  imgHeight : 48
				, latitude : _this.targetViewData[i].latitude
				, longitude :  _this.targetViewData[i].longitude 
				, title :  _this.targetViewData[i].stationName
				, smallImg: ""};
		var marker = nMap.makeMarker(opt);
	
        if(nMap.viewType ==="list") {
        	centerStation.lat = nMap.defaultLatitude;
        	centerStation.long = nMap.defaultLongitude;
        } else if(nMap.viewType ==="search") {
        	if(_this.targetViewData[i].mainStationYn === 'Y') {
            	centerStation.lat = _this.targetViewData[i].latitude;
            	centerStation.long= _this.targetViewData[i].longitude;
            }
        }
        
		_this.infoWindowData.push({sId  : _this.targetViewData[i].stationName
								  ,info : [{stationName : _this.targetViewData[i].stationName
									       ,stationId : _this.targetViewData[i].stationId
					                       ,rackInfo : _this.targetViewData[i].rackInfo
					                       ,bikeInfo : _this.targetViewData[i].bikeInfo
					                       ,longTerm : _this.targetViewData[i].longTerm
					                       ,shared   : _this.targetViewData[i].shared   
					                       ,stationImg : _this.targetViewData[i].stationImgFileName}]
		});
		_this.map.addOverlay(marker);
	}
	//검색을 할경우에 지도 중앙을 검색 결과의 중간값으로 셋팅
	var latitude = '';
	var longitude = '';

	if(nMap.viewType === "search" && ( $("#stationGrpSeq").val() != '' || $("#paramSearchWord").val() != '') ) {

		latitude = centerStation.lat;
		longitude =  centerStation.long;

		if( Object.keys(centerStation).length === 0) {
			if(lSize >0){
				lSize =lSize-1;
			}
			
			latitude = _this.targetViewData[lSize].latitude;
			longitude= _this.targetViewData[lSize].longitude;
		}
		nMap.setMapCenterPosi(latitude, longitude);
	}
	_this.map.attach('click', _this.showInfoWindow);
	/**
	 * TODO:지도중앙 계산. 아파트별
	 * */
	/*var cc = _this.map.getCenter();
	_this.map.setCenter(cc);*/
};
nMap.makeMarker = function(pMarkerOpt) {
	var sIcon = null;
	if(typeof pMarkerOpt.imgSrc === 'string') {
		sIcon = new nhn.api.map.Icon(pMarkerOpt.imgSrc,{width : pMarkerOpt.imgWidth, height : pMarkerOpt.imgHeight });
	} else {
		sIcon = pMarkerOpt.imgSrc;
	}
	
	var marker = new nhn.api.map.Marker(sIcon
			,{point : new nhn.api.map.LatLng( pMarkerOpt.latitude,  pMarkerOpt.longitude)  // 마커의 좌표
			, zIndex : 100 // 마커의 zIndex
			, title :  pMarkerOpt.title // 타이틀
			, smallSrc : pMarkerOpt.smallImg
			}
	);
	return marker;
	
};
nMap.showInfoWindow = function(oCustomEvent) {
	//alert('showInfoWindow');
	//이전에 열려있는 info창을 닫기
	var _this = nMap;
	if(oCustomEvent === undefined){
		return;
	}
	var oTarget  = oCustomEvent.target;
	if (oTarget  instanceof nhn.api.map.Marker) {
		if (oCustomEvent.clickCoveredMarker) {
			return false;
		}
	    var tData = oTarget.getTitle();
	    var infoData = null;
	    for(var i=0; i< _this.infoWindowData.length; i+=1){
	        if(_this.infoWindowData[i].sId === tData) {
	        	infoData = _this.infoWindowData[i].info;
	        	break;
	        }
	    }
	    if(infoData === null ){
	    	return;
	    }
	    
	    nMap.oInfoWnd.setPoint(oTarget.getPoint());
	    var cont = '<DIV  id="infoBox" style="border:2px solid #555; background:#fff; font-family:dotum; width:230px; text-align:left;" >';
	    cont += '       <p style="border-bottom:1px solid #c9c9c9; font-size:14px;color:#333; position:relative">';
	    cont += '           <span style="margin:10px 0 10px 10px; font-weight:bold; display:block;">'+infoData[0].stationName+'</span>';
	    cont += '           <a href="#" style="position:absolute; top:-3px; right:10px" class="mpclose"><img src="/images/stationClose.gif" alt="대여소 정보닫기" /></a>';
	    cont += '       </p>';
	    var sImg = infoData[0].stationImg === "" ? "/images/mapNoimg.gif" : "data:image/gif;base64,"+infoData[0].stationImg;
	    var longT = infoData[0].longTerm === null ?"0" :infoData[0].longTerm;
	    cont += '       <p style="display:inline-block; margin:5px; vertical-align:top;"><img src="'+sImg+'" style="width:50px; height:50px" alt="" /></p>';
	    cont += '       <ul style="display:inline-block; vertical-align:middle; font-size:14px;margin:5px;">';
		cont += '           <li>거치대  : <span style="color:#000099;">'+infoData[0].rackInfo+'</span></li>';
		cont += '           <li>자전거  : <span style="color:#000099;">'+infoData[0].bikeInfo+'</span></li>';
//		cont += '           <li>장기미반납  : <span style="color:#000099;">'+longT+'</span></li>';
	    cont += '           <li>거치율(%)  : <span style="color:#000099;">'+infoData[0].shared+'%</span></li>';
	    cont += '       </ul>';
	    cont += '       <p style="text-align:center; margin-bottom:-16px;"><img src="/images/stationPos.png" style="display:block; margin:0 auto;width:21px;height:16px;" alt="" /></p>';
        cont += '   </DIV>';
       
	    nMap.oInfoWnd.setContent(cont);
	    nMap.oInfoWnd.setPosition({right : -115, top : 45});
	    nMap.oInfoWnd.setVisible(true);
	    nMap.oInfoWnd.autoPosition();
	    
	    $("#infoBox a").on("click", function(e){
	       	e.preventDefault();
	       	$('#infoBox').css('display', "none");
        });
	    
	   return;
	}
};

//maker  Icon 생성.
nMap.getSharedImgSrc = function(pShared, pDeviceBFlg, pStopFlg) {
	var _this = nMap;
	var imgSrc = "";
	var w = 23, h=29;
	var mLevel = _this.map.getLevel();
	//0%,25%,50%,75%,100%
	var s = parseInt(pShared);
	var iidx = 0;
	if(s <= 25 ) {iidx=1;} 
	else if( s <= 50) {iidx=2;} 
	else if( s <= 75) {iidx=3;} 
	else if(75 < s ) {iidx=4;} 
	if( s === 0) {iidx=0;} 
	if( mLevel < 7){
		w = 17,h=21;
		if(pDeviceBFlg){
			imgSrc = _this.markerSmallErrImages[iidx];
		} else {
			imgSrc = _this.markerSmallImages[iidx];
		}
		if(pStopFlg === 'N')  {
			imgSrc = _this.makerSmallStopImages[iidx];
		}
	} else {
		if(pDeviceBFlg){
			imgSrc = _this.markerErrImages[iidx];
		} else {
			imgSrc = _this.markerImages[iidx];
		}
		
		if(pStopFlg === 'N')  {
			imgSrc = _this.makerStopImages[iidx];
		}
	}
	var img = new nhn.api.map.Icon(imgSrc,{width : w, height :h });
	return img;
}; 
nMap.getCalcMapSize = function(){
	var pRight = 0;
	if(!isNaN(parseInt($("#content").css("padding-left")))) {
		pRight = parseInt($("#content").css("padding-left"));
	}
	if($(".rightBox")) {
		pRight = $(".rightBox").innerWidth() + 20;
	}
	
	var mWidht = $("#content").innerWidth() -pRight ;
	if($(".shBox_m").css("display") === "block") {
		mWidht = $(".downtitle").innerWidth();
	}
	var mHeigth =(screen.height/2);
	if(  nMap.defaultSize !== null) {
		mHeigth =nMap.defaultSize.height;
	}
	var mLevel = nMap.defaultLevel;
	
	if(!nMap.isPop && screen.height > 1000) {
		mHeigth = 500;
	} if(mWidht > 2000){
		mWidht = 735;
	} if(mWidht < 400){
		mLevel = 6;
	}
	return {l : mLevel,  w : mWidht, h :mHeigth};
};
window.onresize = function(){
	nMap.resize();
};
nMap.resize = function(e){
	//아이폰 사파리 스크롤이벤트(resize)로 들어오는것 막기.
	//최초 height값과 스크롤시 resize계산된 길이값이 틀리면 지도 size변경 금지.
	var mSizeOp = nMap.getCalcMapSize();
	if(nMap.windowHeight !== mSizeOp.h ){
		return false;
	}
	var mSize = new nhn.api.map.Size(mSizeOp.w,nMap.windowHeight);
	nMap.map.setSize(mSize);
	nMap.map.setLevel(mSizeOp.l);
	
	
};
