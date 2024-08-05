<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link rel="stylesheet" type="text/css" href="/css/w3.css" >
</head>
<body>
<!-- 
	bikeNoSearchFuc : 자전거 조회 함수  com_login_suc_dist.jsp
 -->
	<div class="displayChk">	
	
		<form id="bikefrm" autocomplete="off">
			<div style="float: left;">운행중 자전거 :${wholeStatusTotCnt.rentStableTotCnt}대</div>
			<div style="float: right;">
				자전거 번호 : 
				<input type="text" id="bikeNoSearch" name="searchWord" style="width:30%;" />
				<button id="bikeSearchBtn" class="btn-srh03"><img src="/images/searchIcon.gif" alt="검색"></button>
				<button id="bikeSearchResetBtn" class="btn-srh03" ><img src="/images/position_re.png" alt="검색초기화" style="margin-bottom : 0px" /></button>
			</div>
			<br/>
			
			<table class="tb_type01 mt20">
					<colgroup>
						<col style="width:31%">
						<col style="width:31%">
						<col style="width:32%">									
						<col style="width:31%">									
						<col style="width:32%">									
						<col style="width:30%">									
					</colgroup>
					<thead>
						<tr>
							<th>자전거번호</th>
							<th>대여소/센터</th>
							<th>자전거상태</th>
							<th>장애</th>										
							<th>최종보고</th>										
							<th>배터리상태</th>										
						</tr>
					</thead>
					<!--  대여소 센터 노출 -->
					<tbody>
                         <tr>
                             <td class="tc" id="rentBikeNo"></td>
                             <td class="tc" id="stationName"></td>
                             <td class="tc" id="rentBikeStat"></td>	                                    
                             <td class="tc" id="faultName"></td>	                                    
                             <td class="tc" id="regDttm"></td>	    		                              
                             <td class="tc" id="bikeSeCd"></td>	                                    
                         </tr>
                     </tbody>
				</table>
			<input type="hidden" name="rentBikeId" value="">
			<input type="hidden" name="rentBikeNo" value="">
			<input type="hidden" name="rentHistSeq" value="">
			<input type="hidden" name="rentSeq" value="">
			<input type="hidden" name="rentStatusCd" value="">
			<input type="hidden" name="rentBikeStat" value="">
			<input type="hidden" name="faultSeq" value="">
			<input type="hidden" name="faultName" value="">
			<input type="hidden" name="rentStationId" value="">
			<input type="hidden" name="stationName" value="">
			<input type="hidden" name="regDttm" value="">
			<input type="hidden" name="bikeSeCd" value="">
			<input type="hidden" name="lang" value="LAG_001">
			<input type="hidden" name="adminId" value="${UserSessionVO.usrId}">
		</form>
		
		<span id="cautionText" style="color: red; font-size: 12px; display:none;">주의) 대여중인 자전거는 강제반납만 가능합니다.</span><br/>
		
		<div style="text-align: center; margin-bottom: 10px;">
			<button style="background: #1E821E" class="btnType01" type="button" id="bikeMoveBtn" onclick="goQrScan('move')">자전거이동</button>
			<button style="background: #1E821E" class="btnType01" type="button" id="bikeReplaceBtn" onclick="goQrScan('relocateNew')">재배치완료New</button>
		</div>
		<div style="text-align: center; margin-bottom: 10px;">
			<button  class="btnType01" type="button" id="bikeRobbedBtn">자전거없음</button>
			<button  class="btnType01" type="button" id="findBike">위치찾기</button>
		</div>
		<div style="text-align: center;">
			<button style="background: #FFCD28;font-weight:bold; color: #906D3B" class="btnType01" type="button" id="onSiteActionBtn">경정비</button>
			<button class="btnType01" type="button" id="bikeReceiveBtn">입고처리</button>
			
			<h3>신규 테스트용</h3>
			<button style="background: #FFCD28;font-weight:bold; color: #906D3B" type="button" id="bikeReceiveBtnNew" class="w3-button w3-green w3-large" >현장정비</button>
			<button type="button" id="displayChk_bikeMoveCenter" class="w3-button w3-green w3-large">회수(예정)</button>
		</div>
	</div>
	
	<form id="linkForm">
		<input type="hidden" name="bikeNo" value="">
		<input type="hidden" name="bikeId" value="">
		<input type="hidden" name="rentBikeNo" value="">
		<input type="hidden" name="rentBikeId" value="">						
		<input type="hidden" name="lang" value="">
		<input type="hidden" name="viewFlg" value="">
		<input type="hidden" name="follow" value="">
		
		<input type="hidden" name="tabNum" value="">
		<!--  대여소 링크 팝업호출용 moveRentStationInfo  -->
		<input type="hidden" name="stationId" value="">
		
		<!-- 회수관련 param -->
		<!-- TODO 팝업 호출시 초기화 필요 -->
		<input type="hidden" name="actType" 	value="">
		<input type="hidden" name="actBikeId" 	value="">
		
		<!-- 팝업 에러방지용 -->
		<input type="hidden" name="teamName" 	id="teamName" 	value="">
	    <input type="hidden" name="searchValue" 	id="searchValue" 	value="">
	    <input type="hidden" name="e2" 	id="e2" 	value="">
		<!-- 팝업 에러방지용 -->
		<input  type="hidden" name="addr" 		id="addr" 		value="" readonly>
	    <input  type="hidden" name="parkingLocationDiv" 	id="parkingLocationDiv" 	value="">
	    <input  type="hidden" name="latitude" 	id="latitude"	value="" readonly>
	    <input  type="hidden" name="longitude" id="longitude" 	value="" readonly>
		
		<input type="hidden" name="currentPageNo" value="1">
	</form>
	
	
	
	<div id="divMoveCenter" class="w3-modal">
	    <div class="w3-modal-content w3-card-4 w3-animate-zoom" style="max-width:600px">
	
	      <div class="w3-center"><br>
	        <span onclick="document.getElementById('divMoveCenter').style.display='none'" class="w3-button w3-xlarge w3-hover-red w3-display-topright" title="Close Modal">&times;</span>
	        <h3 style="text-decoration: underline;">자전거 회수</h3>
	      </div>
	
	      <form class="w3-container" id="form_bikeMoveCenter">
	        <div class="w3-section">
	        	<ul class="w3-ul">
		          <li><input class="w3-radio" type="radio" name="bikeMoveCenter_bikeReturn" value="RET_001"><label><b>&nbsp;도난회수</b></label>
		          <input class="w3-radio" type="radio" name="bikeMoveCenter_bikeReturn" value="RET_002"><label><b>&nbsp;방치회수</b></label>
		          <input class="w3-radio" type="radio" name="bikeMoveCenter_bikeReturn" value="RET_005"><label><b>&nbsp;분실회수</b></label></li>
		          <li>
		          	  <input class="w3-radio" type="radio" name="bikeMoveCenter_bikeReturn" value="RET_004"><label><b>&nbsp;사고입고</b></label>
		          		<input class="w3-radio" type="radio" name="bikeMoveCenter_bikeReturn" value="RET_003"><label><b>&nbsp;고장입고</b>
		          </label>
		          </li>
	          </ul>
			  <label>후속조치 :
					<select name="bikeMoveCenter_follow" id="follow">
						<option value="">선택</option>
						<option value="FOL_001">현장 재배치</option>
						<option value="FOL_002">센터 입고</option>
					</select>
			</label>	          

	        </div>
			<div class="mapBox" id="searchMap" style="height: 35%;width: 45%;"><!--style="height:500px" 는 영역 표시를 위한 임시값입니다. 트리구조 삽입후 삭제하셔야 합니다.-->
            </div>	
	      </form>
			
	      <div class="w3-container w3-border-top w3-padding-16 w3-light-grey">
	        <button id="divMoveCenter_btnsearchPlace" type="button" class="w3-button w3-blue">위치찾기</button>
	        <button id="divMoveCenter_btnSave" type="button" class="w3-button w3-blue">저장</button>
	      </div>
	
	    </div>
  </div>
	
</body>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=36ekhr17e2&callback=draw&submodules=geocoder"></script>
<script type="text/javascript">
$(function(){
	
	$("#bikeReceiveBtnNew").on('click', function(e){
		e.preventDefault();
		
		// 상태, 보관센터 제거
		fn_repairSet("Z");
	    initModalIfarame("수리항목 등록");
		fn_repairTimer();
	});
	
	$("#displayChk_bikeMoveCenter").on('click', function(e){
		
		e.preventDefault();
		var bikeStatusCd = $("input[name=rentStatusCd]").val();
		var bikeId       = $("input[name=rentBikeId]").val();
		if(bikeId === ""){//자전거 검색 안한상태 : QR촬영 진행
			alert("자전거 검색 후, 확인 부탁드립니다.");
			return;
		}
		//자전거 검색한 상태 : 검색된 값으로 진행
		if(bikeStatusCd === "BKS_010"){// 대기중
			/* if( confirm("분실처리 진행하시겠습니까?")) {
				setDiaryBikeStatus("","분실처리");
			}; */
			alert("현재 대여중인 상태입니다.");
			return;
			
		}
		
		// 팝업 활성화		
		$("#divMoveCenter").css("display", "block");
		
	});
	

    $("#mapDiv").empty();
  
    bikeSearchMap.detectCoveredMarker = true;
	var mSize = {width : 600, height : 500};

	/* Naver API 3.0*/
	if($("#latitude").val() !=''){
		bikeSearchMap.defaultLatitude = $("#latitude").val();
		bikeSearchMap.defaultLongitude = $("#longitude").val();
	}	
	
	var oPoint = new naver.maps.LatLng(bikeSearchMap.defaultLatitude ,bikeSearchMap.defaultLongitude);	
	
	bikeSearchMap.map = new naver.maps.Map("searchMap", {
        size: new naver.maps.Size( 300, 300),
        center: new naver.maps.LatLng(37.5675451, 126.9773356), //지도의 초기 중심 좌표
        zoom: 15, //지도의 초기 줌 레벨
        minZoom: 7, //지도의 최소 줌 레벨
        zoomControl: true, //줌 컨트롤의 표시 여부
        zoomControlOptions: { //줌 컨트롤의 옵션
        position: naver.maps.Position.LEFT_BOTTOM
        }
    });	

	var marker = new naver.maps.Marker({
	    position: oPoint,
	    map: bikeSearchMap.map
	});
	 
	$("#divMoveCenter_btnsearchPlace").on('click', function(e) {
		if ( typeof( window.android_admin ) == undefined || typeof( window.android_admin) == 'undefined' ) {
			if('geolocation' in navigator) {
				var options = {
					enableHighAccuracy : true,
					timeout : 10000,
					//timeout : 100,
					maximumAge : 6000
				};
				alert("gps 체크")
				navigator.geolocation.getCurrentPosition(onSuccessGeolocation, onErrorGeolocation, options);
				
			} else {
				alert("이 브라우저는 Geolocation를 지원하지 않습니다.");
				}
			}
		
			window.android_admin.getGpsData();
		}
	
		
		 
	);
	 
	
    function onSuccessGeolocation(position) {
    	
    	var location = new naver.maps.LatLng(position.coords.latitude,
                position.coords.longitude);

    	var marker = new naver.maps.Marker({
    	    position: location,
    	    map: bikeSearchMap.map
    	});
    	
    	bikeSearchMap.map.setCenter(location); // 얻은 좌표를 지도의 중심으로 설정합니다.
    	bikeSearchMap.map.setZoom(16); // 지도의 줌 레벨을 변경합니다.
    	$("#latitude").val( position.coords.latitude );
    	$("#longitude").val( position.coords.longitude );
	    
    	naver.maps.Service.reverseGeocode({
	        location: new naver.maps.LatLng( position.coords.latitude, position.coords.longitude),
	    }, function(status, response) {
	        if (status !== naver.maps.Service.Status.OK) {
	            return alert('Something wrong!');
	        }
	        // do Something
	        var items = response.result.items;
	        var item = items[0];
	          // alert(item.address);
	         $("#addr").val(item.address);
		    alert( " 주소 : " +  $("#addr").val());
	    });
	    
    }
    
    naver.maps.Event.addListener(bikeSearchMap.map, 'click', function(e) {
	        	
    	marker.setPosition(e.coord);
	    $("#latitude").val(e.coord.y);
	    $("#longitude").val(e.coord.x);
	     
	    naver.maps.Service.reverseGeocode({
	        location: new naver.maps.LatLng(e.coord.y, e.coord.x),
	    }, function(status, response) {
	        if (status !== naver.maps.Service.Status.OK) {
	            return alert('Something wrong!');
	        }
	        // do Something
	        var items = response.result.items;
	        var item = items[0];
          	$("#addr").val(item.address);
		    alert( " 주소 : " +  $("#addr").val());
	    });
	    
	});
    
    function onErrorGeolocation(error) {
    	  alert(`ERROR(${error.code}): ${error.message}`);
    }
	
	$("#divMoveCenter_btnSave").on('click', function(e){
		
		e.preventDefault();
		
		var bikeId      = $("input[name=rentBikeId]").val();
		var retType 	= $('input[name=bikeMoveCenter_bikeReturn]:checked').val();
		var bikeNo 		= $('input[name=rentBikeNo]').val();
		var latitude	= $('input[name=latitude]').val();
		var follow   	= $("#follow option:selected").val();
		
		if( isEmpty(bikeId) || isEmpty(bikeNo) ) {
			alert("자전거 정보가 미입력되었습니다.");
			return;
		}
		
		if( isEmpty(retType) ) {
			alert("회수사유가 미입력되었습니다.");
			return;
		}
		
		var isLocate =false;
		switch( retType ) {
		case "RET_001" :
		case "RET_002" :
		case "RET_004" :			
		case "RET_005" :			
			isLocate = true;
			break;
		default :
			$('input[name=latitude]').val(0);
			$('input[name=longitude]').val(0);
		}
		
		if( isEmpty(latitude) && isLocate ) {
			alert("위치정보 입력은 필수입니다.");
			return;
		}
		
		// 후속조치 입력
		var isFollow = false;
		switch( retType ) {
		case "RET_001" :
		case "RET_002" :
		// case "RET_004" :			
		case "RET_005" :			
			isFollow = true;
			break;
		default :
		}
		
		
		if( isEmpty( follow ) && isFollow ) {
			alert("후속조치 입력은 필수입니다.");
			return;
		}
		
		
		$("input[name=actType]").val(retType);
		$("input[name=bikeNo]").val(bikeNo);
		$("input[name=actBikeId]").val(bikeId);
		$("input[name=follow]").val(follow);
		
		 
		
		// TODO 자전거 상태에 따라 입력해야 할지 
		commonAjax.postAjax("/distActionInsertAjax.do", 'json', $("#linkForm").serialize()
     			, function(data){
				alert( data.resultMessage );
				
				$("input[name=actType]").val("");
				$("input[name=bikeNo]").val("");
				$("input[name=actBikeId]").val("");
				$("input[name=addr]").val("");
				$("input[name=parkingLocationDiv]").val("");
				$("input[name=latitude]").val("");
				$("input[name=longitude]").val("");
				$("#follow option:selected").val("");
          	} 
	    );
		
		// 팝업 활성화		
		$("#divMoveCenter").css("display", "none");
		
	});
	
	
	
});	

</script>

</html>