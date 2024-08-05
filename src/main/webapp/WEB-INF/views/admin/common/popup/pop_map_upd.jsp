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
			검색방법 :&nbsp;&nbsp;<div style="width: 205px;border: 2px solid green;display: inline-block;padding: 2px;margin: 2px;">&nbsp;&nbsp;<input type="radio" name="searchType" value="1" checked="checked">주소검색&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="searchType" value="2">명칭검색&nbsp;&nbsp;</div><br/>
			
			<input id="searchWord" name="searchWord" type="text" value="" style="width: 280px;"/>&nbsp;<button class="btnType02" id="searchTypeBtn">검색</button> 
			
		
			
			<div id="wrap" style="display:none;border:1px solid;width:500px;overflow-y:scroll;max-height:500px;margin:5px 0;position:relative;">
				<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnFoldWrap" style="width:20px;height:20px;cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" alt="접기 버튼">
			</div>
            <div id="wrap2" style="display:none;width:98%;max-height:50%;margin:5px 0;position:relative;"></div>
			
			<br/><br/>
			<span>선택주소 : </span><span class="input-text03 ml10"><input id="addr" name="addr" type="text" value="" style="width: 300px;" readonly="readonly"/></span><br/>
			<span>상세주소 : </span><span class="input-text03 ml10"><input id="parkingLocationDiv" name="parkingLocationDiv" type="text" value="" style="width: 300px;"/></span><br/>
			<div style="display: none;"><span>위도 : </span><span class="input-text03 ml10 mr10"><input id="latitude" name="latitude" type="text" value="${latitude}" /></span></div>
			<div style="display: none;"><span>경도 : </span><span class="input-text03 ml10"><input id="longitude" name="longitude" type="text" value="${longitude}"/></span></div>
			<!-- <form id="frm"  name="frm" method="POST"> -->
			<!-- </form> -->
			
			
            <div class="didBox pop">
				<div class="mapBox" id="mapDiv" style="height: 80%;width: 40%;"><!--style="height:500px" 는 영역 표시를 위한 임시값입니다. 트리구조 삽입후 삭제하셔야 합니다.-->
                </div>
			</div>
			<div class="btnArea">
                <span class="right">
                	<button class="btnType01" id="cancelBtn">취소</button>
                </span>
                <span class="right">
                	<button class="btnType01" id="setBtn">적용</button>
                </span>
            </div>
        </div>
    </div>
    
    <a href="#" class="popclose"><img src="/images/btn_close.png" alt="팝업닫기" /></a>
    <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=36ekhr17e2&callback=draw&submodules=geocoder"></script>
    <!-- <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=782hpigcuy&submodules=geocoder"></script> -->
    <!-- http -->
    <!-- <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> -->
    <!-- https -->
  <!--   <script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script> -->
    <script type="text/javascript" src="/js/common_barocle.js"></script>
    <script type="text/javascript">
  
    
    //$(function(){
    	$("#cancelBtn").on("click", function(e) {
    		opener.parent.document.getElementById('latitude').value = "";
     	    opener.parent.document.getElementById('longitude').value = "";
     	    opener.parent.document.getElementById('addr').value = "";
     	    opener.parent.document.getElementById('parkingLocationDiv').value = "";
    		window.close();
    	});
    	
    	$("#setBtn").on("click", function(e) {
    		e.preventDefault();
    		var latitude = $("#latitude").val();
    		var longitude = $("#longitude").val();
    		
    		if(!latitude || !longitude){
    			alert("주소를 다시 선택해주세요.");
    			return false;
    		}
    		
    		$.ajax({
    			url : "/common/pop/findTeamName.do",
    			type : "POST",
    			data : {"latitude" : latitude,
    					"longitude" :  longitude},
    			dataType	: 'json',
    			success : function(data){
    				if(data.teamName){
	    				opener.parent.document.getElementById('parkingLocationDiv').value = $("#parkingLocationDiv").val();
	    				opener.parent.document.getElementById('teamName').value = data.teamName;
	    				opener.parent.document.getElementById('searchValue').value = "";
	    				$(opener.document).find("#e2").prop("checked",true);
	    	    		window.close();
    				} else{
    					alert("다시 시도해주세요.");
    				}
    			},
    			error : function(){
    				alert("데이터를 가져오는데 실패 하였습니다.");
    			}
    		});
    		
    	});
    	
    	$("#searchWord").on("keydown",function(key){
    		if(key.keyCode == 13) $("#searchTypeBtn").trigger("click");
    	});
    	
    	/* $("#searchPlaces").on("click",function(){
    		$("#placeSearchDiv").css('display','inline');
    		//element_wrap.style.display = 'none';
    	}); */
    	
    	var nMap = {};
        nMap.map = null;
        nMap.defaultLatitude = 37.5675451;
    	nMap.defaultLongitude = 126.9773356;
        $("#mapDiv").empty();
      
        nMap.detectCoveredMarker = true;
    
    	//var mSize = nMap.getCalcMapSize();
    	var mSize = {width : 600, height : 500};

    	//nMap.setOption(mSize.w,mSize.h);	
    	//nMap.windowHeight = mSize.h;
    	
    	/* Naver API 3.0*/
    	if($("#latitude").val() !=''){
    		nMap.defaultLatitude = $("#latitude").val();
    		nMap.defaultLongitude = $("#longitude").val();
    	}
    	
    	
    	var oPoint = new naver.maps.LatLng(nMap.defaultLatitude ,nMap.defaultLongitude);	
    	
    	nMap.map = new naver.maps.Map("mapDiv", {
            size: new naver.maps.Size( 600, 500),
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
    	    map: nMap.map
    	});

    	naver.maps.Event.addListener(nMap.map, 'click', function(e) {
    	    marker.setPosition(e.coord);
    	    $("#latitude").val(e.coord.y);
    	    $("#longitude").val(e.coord.x);
    	    
    	    opener.parent.document.getElementById('latitude').value = e.coord.y;
    	    opener.parent.document.getElementById('longitude').value = e.coord.x;
    	    
    	    
    	    naver.maps.Service.reverseGeocode({
    	        location: new naver.maps.LatLng(e.coord.y, e.coord.x),
    	    }, function(status, response) {
    	        if (status !== naver.maps.Service.Status.OK) {
    	            return alert('Something wrong!');
    	        }
    	        // do Something
    	        var items = response.result.items;
    	        var item = items[0];
    	          // alert(item.address);
    	           
    	           $("#addr").val(item.address);
    	           opener.parent.document.getElementById('addr').value = item.address;
    	    });
    	    
    	 
    	    
    	});
//

		var element_wrap = document.getElementById('wrap');
		var element_wrap2 = document.getElementById('wrap2');
		
		$("#btnFoldWrap").on("click", function(e) {
			  element_wrap.style.display = 'none';
		});

		
		$("#searchTypeBtn").on("click",function(){
			$("#wrap2").empty();
			if($("input[name=searchType]:checked").val()=='1'){
				geocode();
			}else{
				searchPlaces();
			}
		});
		
		/* 
		$("#sample3_execDaumPostcode").on("click", function(e) {
			
			 element_wrap2.style.display = 'none';
			 //$("#placeSearchDiv").css('display','none');
			
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
	        	        var item = response.v2.addresses[0];
	        	      //alert(item.y);
	        	        marker.setPosition(naver.maps.Point(item.x, item.y));
	        	        nMap.map.setCenter(naver.maps.Point(item.x, item.y));
	            	    $("#latitude").val(item.y);
	            	    $("#longitude").val(item.x);
	            	    opener.parent.document.getElementById('latitude').value = item.y;
	            	    opener.parent.document.getElementById('longitude').value = item.x;
	            	    opener.parent.document.getElementById('addr').value = addr;
	                    
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
		
		
		
		
		$("#sample3_searchPlaces").on("click", function(e) {
			 
			element_wrap.style.display = 'none';
	                //var text= $("#query").val();
	                var queryString = jQuery("#frm").serialize();
	                
	             // 검색 결과 가져오기
	            	$.ajax({
	        			url : "/common/pop/searchPlaces.do",
	        			type : "POST",
	        			//data : queryString,
	        			//data : $("#frm").serialize(),
	        			data : {"searchWord" : $("#searchWord").val()},
	        			dataType	: 'json',
	        			//contentType: "charset=utf-8",
	        			success : function(data){
	        				var json = JSON.parse(data.response);
	        				var places = json.places;
	        				if(places.length  == 0) {
	        					alert("검색어에 해당하는 결과가 없습니다.");
	        					return false;
	        				}
	        				var jsonHtml ='<table class="tb_type02 mt20">';
	        					jsonHtml += "<th class='tc'>장소명</th><th class='tc'>도로명주소</th><th class='tc'>지번주소</th>"
	        				for (var i=0; i<places.length; i++) {
	        		            place = places[i];
	        		            jsonHtml += "<tr><td>" + place.name 
	        		                     + "</td><td><a href=\"javascript:displayCood('"+place.x+"','"+place.y+"','"+place.road_address+"');\">"+ place.road_address +"</a>"
	        		                     + "</td><td><a href=\"javascript:displayCood('"+place.x+"','"+place.y+"','"+place.jibun_address+"');\">"+ place.jibun_address +"</a>"
	        		                     //+ "</td><td>" + place.phone_number+"</td></tr>";
	        		                     + "</td></tr>";
	        		            
	        		        }
	        				jsonHtml += "</table>";
	        				$("#wrap2").html(jsonHtml);
	        			},
	        			error : function(){
	        				alert("데이터를 가져오는데 실패 하였습니다.");
	        			}
	        		});
	                
	           

	        // iframe을 넣은 element를 보이게 한다.
	        element_wrap2.style.display = 'block';
		});
 
		 */
 
		
		function searchPlaces(){
			 
		//	 console.log( opener.parent.document.getElementById('latitude').value );
			element_wrap.style.display = 'none';
	                //var text= $("#query").val();
	                var queryString = jQuery("#frm").serialize();
	             // 검색 결과 가져오기
	            		$.ajax({
	            		    url: 'https://dapi.kakao.com/v2/local/search/keyword.json?y=37.564214&x=127.001699&radius=10000&query=' + encodeURIComponent(  $("#searchWord").val() ),
	            		    headers: { 'Authorization': 'KakaoAK cbde7d3769bc3bd62f010a8cc2a2b118'}, 
	            		    type: 'GET'
	            		}).done(function(data) {
	        				
	        				var places = data.documents;
	        				if(places.length  == 0) {
	        					alert("검색어에 해당하는 결과가 없습니다.");
	        					return false;
	        				}
	        				
	        				var jsonHtml ='<table class="tb_type02 mt20">';
	        					jsonHtml += "<th class='tc'>장소명</th><th class='tc'>도로명주소</th><th class='tc'>지번주소</th>"
	        				for (var i=0; i< places.length; i++) {
	        		            place = places[i];
	        		            jsonHtml += "<tr><td>" + place.place_name 
	        		                     + "</td><td><a href=\"javascript:displayCood('"+place.x+"','"+place.y+"','"+place.address_name+"');\">"+ place.address_name +"</a>"
	        		                     + "</td><td><a href=\"javascript:displayCood('"+place.x+"','"+place.y+"','"+place.address_name+"');\">"+ place.address_name +"</a>"
	        		                     + "</td></tr>";
	        		            
	        		        }
	        				jsonHtml += "</table>";
	        				$("#wrap2").html(jsonHtml);  
	            			
	            		});	            		
	            		
	            		
	            		/*
	            			$.ajax({
	            		url : "/common/pop/searchPlaces.do",
	        			type : "POST",
	        			data : {"searchWord" : $("#searchWord").val()},
	        			dataType	: 'json',
	        			success : function(data){
	        				var json = JSON.parse(data.response);
	        				var places = json.places;
	        				if(places.length  == 0) {
	        					alert("검색어에 해당하는 결과가 없습니다.");
	        					return false;
	        				}
	        				var jsonHtml ='<table class="tb_type02 mt20">';
	        					jsonHtml += "<th class='tc'>장소명</th><th class='tc'>도로명주소</th><th class='tc'>지번주소</th>"
	        				for (var i=0; i<places.length; i++) {
	        		            place = places[i];
	        		            jsonHtml += "<tr><td>" + place.name 
	        		                     + "</td><td><a href=\"javascript:displayCood('"+place.x+"','"+place.y+"','"+place.road_address+"');\">"+ place.road_address +"</a>"
	        		                     + "</td><td><a href=\"javascript:displayCood('"+place.x+"','"+place.y+"','"+place.jibun_address+"');\">"+ place.jibun_address +"</a>"
	        		                     + "</td></tr>";
	        		            
	        		        }
	        				jsonHtml += "</table>";
	        				$("#wrap2").html(jsonHtml);
	        			},
	        			error : function(){
	        				alert("데이터를 가져오는데 실패 하였습니다.");
	        			}
	        			
	    	        		});
	        			*/
	        			
	        		
	                
	           

	        // iframe을 넣은 element를 보이게 한다.
	        element_wrap2.style.display = 'block';
		}
		
		
		function geocode(){
			element_wrap.style.display = 'none';
            var queryString = jQuery("#frm").serialize();
            
         // 검색 결과 가져오기
        	$.ajax({
    			url : "/common/pop/geocode.do",
    			type : "POST",
    			data : {"searchWord" : $("#searchWord").val()},
    			dataType	: 'json',
    			success : function(data){
    				var json = JSON.parse(data.response);
    				var addresses = json.addresses;
    				if(addresses.length  == 0) {
    					alert("검색어에 해당하는 결과가 없습니다.");
    					return false;
    				}
    				var jsonHtml ='<table class="tb_type02 mt20">';
    					jsonHtml += "<th class='tc'>도로명주소</th><th class='tc'>지번주소</th>"
    				for (var i=0; i<addresses.length; i++) {
    					address = addresses[i];
    		            jsonHtml += "<tr><td><a href=\"javascript:displayCood('"+address.x+"','"+address.y+"','"+address.roadAddress+"');\">"+ address.roadAddress +"</a>"
    		                     + "</td><td><a href=\"javascript:displayCood('"+address.x+"','"+address.y+"','"+address.jibunAddress+"');\">"+ address.jibunAddress +"</a>"
    		                     + "</td></tr>";
    		            
    		        }
    				jsonHtml += "</table>";
    				$("#wrap2").html(jsonHtml);
    			},
    			error : function(){
    				alert("데이터를 가져오는데 실패 하였습니다.");
    			}
    		});
            
       

    // iframe을 넣은 element를 보이게 한다.
    element_wrap2.style.display = 'block';
		}
		
   // });
    
    function displayCood(x,y,addr){
    	
    	console.log( "x : " + x);
    	console.log( "y : " + y);
    	
        $("#latitude").val(y);
	    $("#longitude").val(x);
	    document.getElementById("addr").value = addr;
	    opener.parent.document.getElementById('latitude').value = y;
	    opener.parent.document.getElementById('longitude').value = x;
	    opener.parent.document.getElementById('addr').value = addr;
	    marker.setPosition(naver.maps.Point(x, y));
        nMap.map.setCenter(naver.maps.Point(x, y));
	    var element_wrap_ = document.getElementById('wrap');
	    var element_wrap2_ = document.getElementById('wrap2');
		  element_wrap_.style.display = 'none';
		  element_wrap2_.style.display = 'none';
		  //$("#placeSearchDiv").css('display','none');
	}
   
</script>
</body>
</html>