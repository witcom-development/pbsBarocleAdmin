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
			<span>위도 : </span><span class="input-text03 ml10 mr10"><input id="latitude" name="latitude" type="text" value="${latitude}" /></span>
			<span>경도 : </span><span class="input-text03 ml10"><input id="longitude" name="longitude" type="text" value="${longitude}"/></span>
			<button class="btnType02" id="sample3_execDaumPostcode">주소검색</button> 
			
			<div id="placeSearchDiv" style="display: none;"><span>&nbsp;&nbsp;명칭검색어 :&nbsp;</span>
			
			<input id="searchWord" name="searchWord" type="text" value="" style="width: 150px;"/><button class="btnType02" id="sample3_searchPlaces">검색</button></div>
			<br/><br/>
			<span>주 소 : </span><span class="input-text03 ml10"><input id="addr" name="addr" type="text" value="" style="width: 300px;" readonly="readonly"/></span><br/>
			<span>상 세 : </span><span class="input-text03 ml10"><input id="parkingLocationDiv" name="parkingLocationDiv" type="text" value="" style="width: 300px;"/></span><br/>
			<!-- <form id="frm"  name="frm" method="POST"> -->
			<!-- </form> -->
			
			<div id="wrap" style="display:none;border:1px solid;width:500px;overflow-y:scroll;max-height:500px;margin:5px 0;position:relative;">
				<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnFoldWrap" style="width:20px;height:20px;cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" alt="접기 버튼">
			</div>
			<div id="wrap2" style="display:none;width:98%;max-height:50%;margin:5px 0;position:relative;"></div>
			<div class="didBox pop">
				<div class="mapBox" id="mapDiv" style="height: 80%;width: 40%;"><!--style="height:500px" 는 영역 표시를 위한 임시값입니다. 트리구조 삽입후 삭제하셔야 합니다.-->
				</div>
			</div>
			<div class="btnArea">
				<span class="right">
					<button class="btnType01" id="closeBtn">닫기</button>
				</span>
			</div>
		</div>
	</div>
	
	<a href="#" class="popclose"><img src="/images/btn_close.png" alt="팝업닫기" /></a>
	<!-- <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=4791tlnwi5&callback=draw&submodules=geocoder"></script> -->
	<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=1if4e5yo6i&callback=draw&submodules=geocoder"></script>
	<!-- <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=782hpigcuy&submodules=geocoder"></script> -->
	<!-- http -->
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<!-- https -->
	<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
	<script type="text/javascript" src="/js/common_barocle.js"></script>
	<script type="text/javascript">
  		
		var marker = null;
		var nMap = {};
		
		$(document).ready(function(){ 
				onInitMap();
				addressBtnSet();
			}
		);
		
		$("#closeBtn").on("click", function(e) {
			e.preventDefault();
			window.close();
		});
		
		function onInitMap(){
			
			nMap.map = null;
			
			nMap.defaultLatitude = 	( "${latitude}"  == "" ? "37.5675451" : "${latitude}" );
			nMap.defaultLongitude = ( "${longitude}" == "" ? "126.9773356" : "${longitude}" );
			
			$("#mapDiv").empty();
			nMap.detectCoveredMarker = true;
			
			
			
			nMap.map = new naver.maps.Map("mapDiv", {
				size: new naver.maps.Size( 600, 400),
				center: new naver.maps.LatLng(37.5675451, 126.9773356), //지도의 초기 중심 좌표
				zoom: 14, //지도의 초기 줌 레벨
				minZoom: 1, //지도의 최소 줌 레벨
				zoomControl: true, //줌 컨트롤의 표시 여부
				zoomControlOptions: { //줌 컨트롤의 옵션
					position: naver.maps.Position.LEFT_BOTTOM
				}
			});
			
			try{
				
				if(parseInt(nMap.defaultLatitude) > 36 && parseInt(nMap.defaultLongitude) > 125){
					
					var defaultLatLng = new naver.maps.LatLng(nMap.defaultLatitude, nMap.defaultLongitude);
					nMap.map.setCenter(defaultLatLng);
					
				}
				
			}catch(e){
				console.log(e);
			}
			
			marker = new naver.maps.Marker({
				position: new naver.maps.LatLng(nMap.defaultLatitude ,nMap.defaultLongitude),
				map: nMap.map
			});
	
			naver.maps.Event.addListener(nMap.map, 'click', function(e) {
				marker.setPosition(e.coord);
				$("#latitude").val(e.coord.y);
				$("#longitude").val(e.coord.x);
				
				opener.parent.document.getElementById('station_latitude').value = e.coord.y;
				opener.parent.document.getElementById('station_longitude').value = e.coord.x;
				
				naver.maps.Service.reverseGeocode({
					location: new naver.maps.LatLng(e.coord.y, e.coord.x),
					orders:addr
				}, function(status, response) {
					if (status !== naver.maps.Service.Status.OK) {
						return alert('네이버 맵 서비스 에러!');
					}
					// do Something
					var items = response.result.items;
					
					var isRoadAdressIdx = 0; 
					for( var i in items ){
						if (items[i].isRoadAddress == true ) {
							isRoadAdressIdx = i;
							break;
						}
					}
					
   					var item = items[isRoadAdressIdx];
   					 $("#addr").val(item.address);
   						opener.parent.document.getElementById('station_addr1').value = item.address;
						opener.parent.document.getElementById('station_addr2').value = $("#parkingLocationDiv").val();
				});
				
			});
			
		}
		
		function addressBtnSet() {
			var element_wrap = document.getElementById('wrap');
	 		
	 		$("#btnFoldWrap").on("click", function(e) {
	 			  element_wrap.style.display = 'none';
	 		});

	 		$("#sample3_execDaumPostcode").on("click", function(e) {
	 			
	 			 $("#placeSearchDiv").css('display','none');
	 			
	 			 // 현재 scroll 위치를 저장해놓는다.
	 			var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
	 			new daum.Postcode({
	 				oncomplete: function(data) {
	 					// 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

	 					// 각 주소의 노출 규칙에 따라 주소를 조합한다.
	 					// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	 					var addr = ''; // 주소 변수
	 					var extraAddr = ''; // 참고항목 변수

	 					//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	 					if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	 						addr = data.roadAddress;
	 					} else { // 사용자가 지번 주소를 선택했을 경우(J)
	 						addr = data.jibunAddress;
	 					}

	 					// 우편번호와 주소 정보를 해당 필드에 넣는다.
	 					document.getElementById("addr").value = addr;

	 					// iframe을 넣은 element를 안보이게 한다.
	 					// (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
	 					element_wrap.style.display = 'none';

	 					// 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
	 					document.body.scrollTop = currentScroll;
	 					//alert(addr);
	 					
	 					naver.maps.Service.geocode({
	 						query: addr
	 					}, function(status, response) {
	 						if (status !== naver.maps.Service.Status.OK) {
	 							return alert('Something wrong!');
	 						}
	 						
	 						var result = response.result; // 검색 결과의 컨테이너
	 						var item   = response.v2.addresses[0];
	 						console.log( item );
	 						
	 						marker.setPosition(naver.maps.Point(item.x, item.y));
	 						nMap.map.setCenter(naver.maps.Point(item.x, item.y));
	 						$("#latitude").val(item.y);
	 						$("#longitude").val(item.x);
	 						opener.parent.document.getElementById('station_latitude').value = item.y;
	 						opener.parent.document.getElementById('station_longitude').value = item.x;
	 						opener.parent.document.getElementById('station_addr1').value = addr;
	 					   opener.parent.document.getElementById('station_addr2').value = $("#parkingLocationDiv").val();
	 						
	 					});
	 					
	 				},
	 				// 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
	 				onresize : function(size) {
	 					element_wrap.style.height = size.height+'px';
	 				},
	 				width : '100%',
	 				height : '100%'
	 			}).embed(element_wrap);

	 			// iframe을 넣은 element를 보이게 한다.
	 			element_wrap.style.display = 'block';
	 		});
		}	
	</script>
	
</body>
</html>


			
	 