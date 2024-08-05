<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" /> 
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
<meta name="description=" Content="" />
<title><tiles:insertAttribute name="title"/></title>
<tiles:insertAttribute name="resource"/>
</head>
<body>
<div class="allwrap">
        <!--모바일 메뉴 S-->
        <tiles:insertAttribute name="header"/>
        <!--모바일 메뉴 E-->
        <!--Head S-->
        <tiles:insertAttribute name="head"/>
        <!--Head E-->
        <div id="body">
            <div class="cont">
                <!--left menu S-->
                <tiles:insertAttribute name="left"/>
                <!--left menu E-->
                <!--conteent S-->
                <div id="content" class="content">
                    <div class="subject">
                        <!--subject path S-->
                        <tiles:insertAttribute name="subject" />
                        <!--subject path E-->
                    </div>
                    <div class="page">
                        <!-- 모바일 검색조건 S-->
                        <div class="shBox_m" style="display: none">
                            <div class="downtitle">
                                <div class="title">
                                    <p>검색조건</p><span><button><img src="/images/srh_open.png" alt="검색조건 열기" /></button></span>
                                </div>
                            </div>
                        </div>
                        <!-- 모바일 검색조건 E-->
                        <!--검색조건 S-->
                        <table class="tb_type01 mhid">
                            <colgroup>
                                <col style="width:15%"/>
                                <col style="width:15%"/>
                                <col style="width:15%"/>
                                <col style="width:15%"/>
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>총괄</th>
                                    <th>배치현황</th>
                                    <th>대폐(2,337)</th>
                                    <th>기타</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="title">
                                        <div class="statulist">
                                            <p>대여소 : <span id="a_1">${wholeStatusTot.stationTotCnt }</span></p>
                                            <p>거치대 : <span id="a_2"> ${wholeStatusTot.rackTotCnt }</span></p>
                                            <p>자전거: <span id="a_3">25,000</span></p>
                                              <%-- ${ wholeStatusTot.bikeTotCnt} --%>
                                             <p></p> 
                                        </div>
                                    </td>
                                    <td class="title">
                                        <div class="statulist">
                                            
                                            <p>대여대기 :<span id="b_1">${wholeStatusTot.standByBikeTotCnt }</span></p>
                                            <p>정상 대여중 : <span id="b_2">${wholeStatusTot.rentStableTotCnt }</span></p>
                                            <p>고장 신고    : <span id="b_3">${wholeStatusTot.brokenBikeTotCnt }</span></p>
                                            
                                        </div>
                                    </td>
                                    <td class="title">
                                        <div class="statulist">
                                            
                                            <p>자전거   : <span id="c_1">774</span></p>
                                            <p>단말기 : <span id="c_2">1563</span></p>
                                            
                                        </div>
                                    </td>
                                    <td class="title">
                                        <div class="statulist">
                                        
			      							<p>자전거분실 :     <span id="d_1">4</span></p>
                                            <p>출고대기 및 정비 : <span id="d_2"></span></p>
                                            <p>도난 분실 추정 : <span id="d_2">${fn:length(bikeLostList)}</span></p>
									    </div>
                                    </td>
                                    
                                </tr>
                            </tbody>
                        </table>
                        <%-- <div class="staBox mapguide mhid">
                            <p>거치율(%) 기존</p>
                            <span><em><img src="/images/icon_b1_76.png" alt="76이상" /></em>76이상</span>
                            <!-- <span><em><img src="/images/staOn_s100p.png" alt="76~130" /></em>76~130</span> -->
                            <span><em><img src="/images/icon_b1_26.png" alt="26~75" /></em>26~75</span>
                            <!-- <span><em><img src="/images/staOn_s50p.png" alt="26~50" /></em>26~50</span> -->
                            <span><em><img src="/images/icon_b1_1.png" alt="1~25" /></em>1~25</span>
                            <span><em><img src="/images/icon_b1_0.png" alt="0" /></em>0</span>
                            <!-- <span><em><img src="/images/staErr_s0p.png" alt="장애" /></em>장애</span> -->
                            <p> 신규</p>
                            <span><em><img src="/images/icon_b2_76.png" alt="76이상" /></em>76이상</span>
                            <span><em><img src="/images/icon_b2_26.png" alt="26~75" /></em>26~75</span>
                            <span><em><img src="/images/icon_b2_1.png" alt="1~25" /></em>1~25</span>
                            <span><em><img src="/images/icon_b2_0.png" alt="0" /></em>0</span>
                            <!-- <span><em><img src="/images/icon_b1.png" alt="기존정거장" /></em>기존정거장</span> -->
                            <!-- <span><em><img src="/images/icon_b2.png" alt="신규정거장" /></em>신규정거장</span> -->
                            <span><a href="<c:out value='/common/pop/showStationStatusPop.do'/>" class="winNewPop btnType02"  data-screen="fullscreen" title="대여소 현황" data-width="" data-height="" data-pmt="&defaultLevel=8">전체화면</a></span>
                            
                        </div> --%>
                        <form id="searchFrm"  style="display:none;">
                        	<div class="shBox" style="display: none">
	                            <input type="hidden" name="stationOrderType" value="${condition.stationOrderType}">
	                            <input type="hidden" name="sharedOrderType" value="${condition.sharedOrderType}">
	                            <input type="hidden" name="orderColumn"   value="${condition.orderColumn}">
	                            <input type="hidden" name="viewType"      value="${condition.viewType }">
	                            <input type="hidden" name="stationId"  id="stationId"   value="${condition.stationId }">
	                            <input type="hidden" name="stationGrpSeq" id="stationGrpSeq" value="${condition.stationGrpSeq }">
	                            <input type="hidden" name="defaultLevel" value="${condition.defaultLevel }">
	                            <input type="hidden" name="paramSearchWord" id="paramSearchWord" value="${condition.paramSearchWord}">
	                            <input type="hidden" name="paramSearchType" id="paramSearchType" value="${condition.paramSearchType}">
                                <fieldset>
                                    <legend>검색 옵션</legend>
                                    <div class="shBoxSection">
                                        <div class="section">
                                            <label for="bb22" class="laType03">아파트</label>
                                            <select class="select-category02" id="bb22" style="width: 210px;">
                                                <option value="">선택</option>
                                            </select>
                                        </div>
                                        <div class="section pright etccase3">
                                            <label for="aa21" class="laType03">대여소명</label>
                                            <select class="select-category02" id="aa21">
                                                <option value="">선택</option>
                                            </select>
                                            <button type="button" name="searchBtn" id="searchBtn" class="btn-srh03 btncase1" ><img src="/images/searchIcon.gif" alt="검색"/></button>
                                        </div>
                                        <div class="section">
                                            <label for="searchStationName" class="laType03">대여소명</label>
                                            <!-- <select  id="searchType"  name="searchType">
                                                <option value="">선택</option>
                                                <option value="NUM">대여소번호</option>
                                                <option value="NAME">대여소명</option>
                                            </select> -->
                                            <span class="input-text12"><input type="text" class="" id="searchWord" value="${condition.paramSearchWord}"/></span>
                                            <button type="button" name="reSet" id="reSetBtn" class="btn-srh03 btncase1" style="color:white"></button>
                                            
                                        </div>

                                        <div class="section pright etccase3">
                                            
                                            <label for="batteryStusCd" class="laType03">센터/팀</label>
                                            <select id="batteryStusCd" name="batteryStusCd" style="width:80px">
                                                <option value="">선택</option>
                                            </select>&nbsp;
                                            <select id="searchType" name="searchType" required="true"  style="width:auto">
                                                <option value="">선택</option>
                                            </select>
                                        </div>
                                         <div class="section">
                                            <label for="stationSeCd" class="laType03">대여소 구분</label>
                                            <select class="select-category02" id="a12" name="stationSeCd">
                                                <option value="">선택</option>
                                                <option value="RAK_001">(LCD+QR 반납가능)</option>
                                                <!-- <option value="RAK_002">신규</option> -->
                                            </select>
                                        </div>
                                    </div>
                                </fieldset>
                        	</div>
                        </form>
                        <!--검색조건 E-->
                        <div id="mapDiv" class="mt20" ></div>
                        
                        
                        <div class="listalign mt20" style="margin-bottom : 5px;">
                            <%-- <select name="sortSlt" id="sortSlt" class="mr10">
                                <option value="">선택</option>
                                <option value="S" <c:if test='${ condition.orderColumn eq "S"}'>selected="selected"</c:if>>대여소</option>
                                <option value="P" <c:if test='${ condition.orderColumn eq "P" }'>selected="selected"</c:if>>거치율</option>
                            </select>
                            <label><input name="lsalign" type="radio" value="ASC" class="vm" <c:if test="${condition.stationOrderType eq 'ASC'  or condition.sharedOrderType eq 'ASC'}">checked="checked"</c:if>/> 오름차순</label>
                            <label><input name="lsalign" type="radio" value="DESC" class="vm ml10" <c:if test="${condition.stationOrderType eq 'DESC' or condition.sharedOrderType eq 'DESC'}">checked="checked"</c:if>/> 내림차순</label>
                             <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 건수 : ${fn:length(stationList)} -테스트대여소 포함</span> --%>
                        </div>
                        <table class="tb_type01" id="list">
                            <colgroup>
                                <col style="width:30%"/>
                                <col style="width:30%"/>
                                <col style="width:30%"/>
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>자전거번호</th>
                                    <th>최종신호</th>
                                    <th>갱신시간</th>
                                </tr>
                            </thead>
                            <tbody> 
                         
                             <c:forEach var="info" items="${bikeLostList}" varStatus="status" end="100" >
                                <tr>
					                <td class="title tc">
					                	${info.bikeNo }
					                </td>
					                <td class="title tc">
					                	${info.modDttm }
					                </td>
					                <td class="title tc">
					                	${info.regDttm }
					                </td>
					            </tr> 
					        </c:forEach>
					        <c:if test="${fn:length(bikeLostList) == 0 }">
					            <tr><td colspan="3" style="text-align: center;"><spring:message code="search.nodata.msg" /></td></tr>
					        </c:if>
                            </tbody>
                        </table>
					<%-- <c:choose>
						<c:when test="${fn:length(stationList) > 0}">
							<div class="drpaging">
						</c:when>
						<c:otherwise>
							<div class="drpaging" style="display:none;">
						</c:otherwise>
					</c:choose>
						<c:choose>
						<c:when test="${paginationInfo.currentPageNo > 1}">
							<a id="prevPage" href="#"><img src="/images/p_prev.gif" alt="이전 페이지" /></a>
						</c:when>
						<c:otherwise>
							<a href="#"><img src="/images/p_prev.gif" alt="이전 페이지" /></a>
						</c:otherwise>
						</c:choose>
						<span><input name="currentPageNo" type="number" value="${paginationInfo.currentPageNo}"/><em>/ ${paginationInfo.totalPageCount}</em><button id="movePage">이동</button></span>
						<c:choose>
						<c:when test="${paginationInfo.currentPageNo < paginationInfo.totalPageCount}">
						<a id="nextPage" href="#"><img src="/images/p_next.gif" alt="다음 페이지" /></a>
						</c:when>
						<c:otherwise>
							<a href="#"><img src="/images/p_next.gif" alt="다음 페이지" /></a>
						</c:otherwise>
						</c:choose>
						</div> --%>
                    </div>
                </div>
                <!--conteent E-->
            </div>
        </div>
        <!--footer S-->
        <tiles:insertAttribute name="footer"/>
        <!--footer E-->
    </div>

    <!-- <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=04rAq4jj3SZHhhFh7tPX&callback=draw"></script> -->
    
	<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=4791tlnwi5&callback=draw"></script>
    
  <!-- <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=782hpigcuy&callback=draw"></script> -->
    
    
    <script type="text/javascript" src="/js/stationCommonMapv.js"></script>
    <script type="text/javascript" src="/js/common_barocle.js"></script>
    
    <style type="text/css">
    .jb-wrap {
    margin: 0px;
    padding: 0px;
    border: 0px solid transparent;
    display: block;
    user-select: none;
    -webkit-user-drag: none;
    box-sizing: content-box !important;
    max-width: none !important;
    max-height: none !important;
    min-width: 0px !important;
    min-height: 0px !important;
    position: absolute;
    cursor: pointer;
    width: 25px;
    height: 30px;
    left: -10px;
    top: -30px;
    
	}
	.jb-wrap img {
	  width: 100%;
	  vertical-align: middle;
	}
	.jb-text {
	  position: absolute;
	  top:45%;
	  left:50%;
	  transform: translate(-50%, -50%);                                                                   
	  z-index: 2;
	  text-align: center;
	  color:#000;
	  font-weight: bold;
	  font-size: 9px;
	}
	 
	 .jb-text-red {
	  position: absolute;
	  top:45%;
	  left:50%;
	  transform: translate(-50%, -50%);                                                                   
	  z-index: 2;
	  text-align: center;
	  color:red;
	  font-weight: bold;
	  font-size: 9px;
	}
    </style>
    
    <script type="text/javascript">
    
    
	var markersN = [];
	var markersS = [];
    
    function draw(){
    	
    	var trafficLayer = new naver.maps.TrafficLayer({
    	    interval: 2000 // 2초마다 새로고침
    	});
    	
    	var img = {icon: {}};
		var opt = {};
		var markerOptions = {icon: {}};
		
		var totalCount = 0;
		var stationName = ""; 
		
    	/* <c:forEach var="impulse" items="${exeImpulseList}" varStatus="status1">
			markerOptions.position = new naver.maps.LatLng("${impulse.latitude}",  "${impulse.longitude}");
			markerOptions.map = nMap.map;
	        //markerOptions.icon.url = "/images/ico_01.png";
	        markerOptions.icon.content = "<img src='/images/ico_01.png' alt=''>";
	        markerOptions.type     = "station";
	        var marker = new naver.maps.Marker(markerOptions);
	        markersN.push(marker);
	          naver.maps.Event.addListener(marker, 'click', getClickHandlerMove("${impulse.rentBikeNo}"
                    , "${impulse.enfrcReturnHistSeq}"
                    , "${impulse.latitude}"
                    , "${impulse.longitude}"
                    
	          )); 
			marker.setMap(nMap.map);
		</c:forEach> */
		
		
    	<c:forEach var="bks" items="${bikeLostList}" varStatus="status1">
			markerOptions.position = new naver.maps.LatLng("${bks.xPos}",  "${bks.yPos}");
			markerOptions.map = nMap.map;
        //markerOptions.icon.url = "/images/ico_01.png";
        	markerOptions.icon.content = "<img src='/images/icon_bike_big4.png' alt='' style='width: 30px'>";
        	markerOptions.type     = "station";
        	var marker = new naver.maps.Marker(markerOptions);
        	markersN.push(marker);
        	
        	
           naver.maps.Event.addListener(marker, 'click', getClickHandlerLostMove("${bks.bikeNo}"
                , "${bks.xPos}"
                , "${bks.yPos}"
                , "${bks.modDttm}"
                , "${bks.regDttm}"
                
          ));  
		marker.setMap(nMap.map);
	</c:forEach>		
		
		
    	/* <c:forEach var="info" items="${stationList}" varStatus="status">
	    	<c:if test="${status.last}" >
	    		nMap.map.setCenter(new naver.maps.LatLng("${info.stationLatitude}","${info.stationLongitude}"));
	    	</c:if>
			markerOptions.position = new naver.maps.LatLng("${info.stationLatitude}",  "${info.stationLongitude}");
	        markerOptions.map = nMap.map;
	        <c:choose>
	         <c:when test="${info.stationSeCd == 'RAK_001'}"> 
	       		 totalCount = Number("${info.parkingBikeTotCnt}") + Number("${info.parkingQRBikeCnt}") ;
	       		 stationName ="(기존)"+ "${info.stationName}";
	         </c:when>
	         <c:when test="${info.stationSeCd == 'RAK_002'}"> 
	       		 totalCount = Number("${info.parkingQRBikeCnt}") + Number("${info.parkingELECBikeCnt}");
	       		 stationName ="(신규)"+ "${info.stationName}";
	         </c:when>
	         <c:when test="${info.stationSeCd == 'RAK_003'}"> 
		   		 totalCount = Number("${info.parkingBikeTotCnt}") + Number("${info.parkingQRBikeCnt}") ;
		   		 stationName ="(기존)"+ "${info.stationName}";
		     </c:when>
		     <c:when test="${info.stationSeCd == 'RAK_004'}"> 
				 totalCount = Number("${info.parkingQRBikeCnt}") + Number("${info.parkingELECBikeCnt}");
				 stationName ="(신규)"+ "${info.stationName}";
		 	</c:when>
		 	</c:choose>
		 	
	       
	        markerOptions.icon.content = "<div><img src='${info.stationAddr}'></div>";
	        
	        //alert("${info.stationSeCd}");
	        //markerOptions.icon.url = "${info.stationAddr}";
	        markerOptions.type     = "station";
	        var marker = new naver.maps.Marker(markerOptions);
			marker.setMap(nMap.map);
	  		naver.maps.Event.addListener(marker, 'click', getClickHandler("${info.stationId}"
	  				                                                   // , "${info.stationName}"
	  				                                                    , stationName
																		, "${info.parkingBike}"  
																		, "${info.systemWarning}"
																		, "${info.shared}"
																		, "${info.stationLatitude}"
																		, "${info.stationLongitude}" ));
	  		markersS.push(marker);
	  		
    	</c:forEach> 
    	*/
    	
    	reDrawIndex++;
    }
    
    reDraw = function (){
    	
    	nMap.initMap();
    	switch ( reDrawIndex %3 ){
    	case 0 :
		    for (var mIndex = 0; mIndex < markersN.length; mIndex++) {
		        marker = markersN[mIndex]
	            marker.setMap(nMap.map);
	    	
		    }
		    for (var mIndex = 0; mIndex < markersS.length; mIndex++) {
		        marker = markersS[mIndex]
	            marker.setMap(nMap.map);

		    	if( mIndex == ( markersS.length - 1)) {
		    		nMap.map.setCenter( marker.position );
		    	}
		    
		    }
    	
    	case 1 :
		    for (var mIndex = 0; mIndex < markersN.length; mIndex++) {
		        marker = markersN[mIndex]
	            marker.setMap(nMap.map);
		        
		    	if( mIndex == ( markersN.length - 1)) {
		    		nMap.map.setCenter( marker.position );
		    	}

		    }
		break;    
    	case 2 :
		    for (var mIndex = 0; mIndex < markersS.length; mIndex++) {
		        marker = markersS[mIndex]
	            marker.setMap(nMap.map);
		    	if( mIndex == ( markersS.length - 1)) {
		    		nMap.map.setCenter( marker.position );
		    	}
		    }
		break;
    	}
    	
    	$("#reSetBtn").html(reDrawIndex %3 );
    	reDrawIndex++;
	}
    
    linkStation = function(stationId) {
    	$("[name='stationId']").val(stationId);
    	// 2018-11-25 새창열기로 변경
    	$("#searchFrm").attr({action : "<c:out value='/moveCurrentStationDetail.do'/>", method : "post", target:"_blank"}).submit();
    };
    
    
    function getClickHandlerLostMove(rentBikeNo, latitude,longitude, modDttm, regDttm) {
        return function(e) {
    	 
        	var cont = '<DIV  id="infoBox" style="border:2px solid #555; background:#fff; font-family:dotum; width:230px; text-align:left;line-height:150%;" >';
        	cont += '       <p style="border-bottom:1px solid #c9c9c9; font-size:14px;color:#333; position:relative; text-decoration:underline">';
        	cont += '           <a href="#" style="position:absolute; top:3px; right:10px" class="mpclose"><img  name="close" src="/images/stationClose.gif" alt="대여소 정보닫기" /></a>';
        	cont += '       </p>';
        	cont += '       <ul style="display:inline-block; vertical-align:middle; font-size:14px;margin:5px;">';
        	cont += '           <li>자전거 번호  : <span style="color:#000099;">'+rentBikeNo+'</span></li>';
        	cont += '           <li>최종신호     : <span style="color:#000099;">'+ modDttm+'</span></li>';
        	cont += '           <li>갱신 시간    : <span style="color:#000099;">'+regDttm+'</span></li>';
        	cont += '           <li><p class="cacao" style="background:blue;color:white;">카카오지도로 길찾기</p></li>';
        	cont += '       </ul>';
            cont += '   </DIV>';
        	
            var infoWindow = new naver.maps.InfoWindow({
            	content: cont
        	});	
	   		var center = new naver.maps.LatLng(latitude,longitude);
	   		infoWindow.open(nMap.map,center);
	   		
   			$("#infoBox a img").on("click", function(e){
    	       	e.preventDefault();
    	       	infoWindow.close(nMap.map,center);
            });
	 
			$("#infoBox ul .cacao").on("click", function(e){
    	       	e.preventDefault();
    	       	$("#searchFrm").attr({action : "http://map.kakao.com/link/to/'" +  ',' + latitude +',' + longitude , method : "post", target:"_blank"}).submit();
            });
	   		
        }	    	 
    }    
    
    
    
    function getClickHandlerMove(rentBikeNo, enfrcReturnHistSeq, latitude,longitude) {
        return function(e) {
    	 
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
	   		var center = new naver.maps.LatLng(latitude,longitude);
	   		infoWindow.open(nMap.map,center);
		    	
	    	 		$("#infoBox a img").on("click", function(e){
		    	       	e.preventDefault();
		    	       	infoWindow.close(nMap.map,center);
		            });
	    	
	     			$("#infoBox ul .detail").on("click", function(e){
		    	       	e.preventDefault();
		    	       	
		    	       	var pwidth = 600;
		    			var pheight = 730;
		    			var winL = (screen.width-pwidth)/2;
		    			var winT = (screen.height-pheight)/2;
		    			var lat = "";
		    			var lon = "";
		    			
		    			window.open("/common/pop/entrcReutnViewPop.do?outptt=%uC704%uCE58%uC9C0%uB3C4%uCC3E%uAE30&latitude="+ lat +"&longitude=" + lon + "&enfrcReturnHistSeq=" + enfrcReturnHistSeq , "winpop2", "width=600, height=730, top="+winT+", left="+winL+" , scrollbars=yes");
		            }); 
	     			
	     			$("#infoBox ul .exeImpul").on("click", function(e){
		    	       	e.preventDefault();
		    	       	var pwidth = 600;
		    			var pheight = 730;
		    			var winL = (screen.width-pwidth)/2;
		    			var winT = (screen.height-pheight)/2;
		    			var lat = "";
		    			var lon = "";
		    			window.open("/getExeImpulseList.do?searchWord=" + rentBikeNo , "winpop2", "width=600, height=730, top="+winT+", left="+winL+" , scrollbars=yes");
		            }); 
	    	 
	    			$("#infoBox ul .cacao").on("click", function(e){
		    	       	e.preventDefault();
		    	       	$("#searchFrm").attr({action : "http://map.kakao.com/link/to/'" + '' + ',' + latitude +',' + longitude , method : "post", target:"_blank"}).submit();
		            });  
	        }
    }    
    
    
    
    function getClickHandler(stationId, stationName, rackInfo, bikeInfo, shared, latitude,longitude) {
        return function(e) {
    	
    	var cont = '<DIV  id="infoBox" style="border:2px solid #555; background:#fff; font-family:dotum; width:230px; text-align:left;line-height:150%;" >';
    	cont += '       <p style="border-bottom:1px solid #c9c9c9; font-size:14px;color:#333; position:relative; text-decoration:underline">';
    	cont += '           <span style="margin:10px 0 10px 10px; font-weight:bold; display:block;">'+stationName+'</span>';
    	cont += '           <a href="#" style="position:absolute; top:-3px; right:10px" class="mpclose"><img  name="close" src="/images/stationClose.gif" alt="대여소 정보닫기" /></a>';
    	cont += '       </p>';
    	cont += '       <ul style="display:inline-block; vertical-align:middle; font-size:14px;margin:5px;">';
    	cont += '           <li>LCD/QR/전체(고장): <span style="color:#000099;">'+rackInfo+'</span></li>';
//    	cont += '           <li>자전거  : <span style="color:#000099;">'+bikeInfo+'</span></li>';
    	cont += '           <li>거치율(%)  : <span style="color:#000099;">'+shared+'%</span></li>';
    	cont += '           <li><p class="cacao" style="background:blue;color:white;">카카오지도로 길찾기</p></li>';
    	cont += '       </ul>';
    	cont += '       <p style="text-align:center; margin-bottom:-16px;"><img src="/images/stationPos.png" style="display:block; margin:0 auto;width:21px;height:16px;" alt="" /></p>';
        cont += '   </DIV>';	
       	
        var infoWindow = new naver.maps.InfoWindow({
            	content: cont
        	});	
        	
   		var center = new naver.maps.LatLng(latitude,longitude);
   		infoWindow.open(nMap.map,center);
	    	
    			$("#infoBox a img").on("click", function(e){
	    	       	e.preventDefault();
	    	       	infoWindow.close(nMap.map,center);
	            });
    	
     			$("#infoBox p span").on("click", function(e){
	    	       	e.preventDefault();
	    	       	$("[name='stationId']").val(stationId);
	    	       	$("#searchFrm").attr({action : "<c:out value='/moveCurrentStationDetail.do'/>", method : "post", target:"_blank"}).submit();
	            }); 
    	 
    			$("#infoBox ul .cacao").on("click", function(e){
	    	       	e.preventDefault();
	    	       	$("#searchFrm").attr({action : "http://map.kakao.com/link/to/'" + stationName + ',' + latitude +',' + longitude , method : "post", target:"_blank"}).submit();
	            });
        }
    }
    
    
    $(function(){
    	

    	
    	if("${condition.stationGrpSeq}" != ""){
			$("#bb22").val("${condition.stationGrpSeq}");
		}
    	
    	if("${condition.stationId}" != ""){
			$("#aa21").val("${condition.stationId}");
		}
    	
    	if("${condition.stationSeCd}" != ""){
			$("#a12").val("${condition.stationSeCd}");
		}

    	nMap.viewType = '${condition.viewType}';
    	nMap.defaultLevel ='${condition.defaultLevel}' === '' ? '8' : '${condition.defaultLevel}';

    	nMap.setMap(); 
    	currentStatus.initBtn();
    	currentStatus.initCommbo();

    	var totalPageCount = '${paginationInfo.totalPageCount}' == '' ? 1 : Number('${paginationInfo.totalPageCount}');
   		$('#prevPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			currentStatus.pageSelect(currentPageNo-1);
		});
		$('#nextPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			currentStatus.pageSelect(currentPageNo+1);
		});
		$('#movePage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			var regExp = /^[1-9]?[0-9]/;
			if(!regExp.test(currentPageNo) ||(totalPageCount < currentPageNo)){
				alert('현재 페이지 값이 정상적이지 않습니다.');
			}else{
				currentStatus.pageSelect(currentPageNo);
			}
		});
		
		$("#searchType").on("change", function(e){
 			$("[name='paramSearchType']").val($("#searchType").val());
			$("#searchWord").val('');
        });

        $("#batteryStusCd").change(function(){
		    find_team(false);
	    });
 

	var a_1	   = parseInt($("#a_1").text()); 
	var a_2    = parseInt($("#a_2").text()); 
	var a_3    = parseInt($("#a_3").text()); 
	var b_1	   = parseInt(  $("#b_1").text().replace( ",","") ); 
	var b_2    = parseInt(  $("#b_2").text().replace( ",","") ); 
	var b_3    = parseInt(  $("#b_3").text().replace( ",","") ); 
	var c_1	   = parseInt($("#c_1").text()); 
	var c_2    = parseInt($("#c_2").text()); 
	var d_1	 = parseInt($("#d_1").text()); 

	var sum = b_1 + b_2 + b_3 + c_1  + c_2 + d_1;	
	$("#d_2").text( 25000  - sum );

    });
    
    var currentStatus = {};
    var _this = currentStatus;
    currentStatus.stationGrpSeq = '${condition.stationGrpSeq}';
    currentStatus.stationId     = '${condition.stationId}';
    currentStatus.viewType    = '${condition.viewType}' === "" ? "list" :'${condition.viewType}' ;
    currentStatus.stationSeCd   = '${condition.stationSeCd}';
    var reDrawIndex = 1;
    
    //{stationGrpSeq : '' stationList : [{stationId : '', latitude : '', longitude : ''}]}
    currentStatus.initBtn = function() {
    	$("#searchBtn").on("click", this.searchStation);
    	
    	$("#reSetBtn").on("click", reDraw );
    	
    	$("#bb22").on("change", function(e){
    		var tId = e.target.id;
            var idx = $("#"+tId+" option:selected").index();
            var subList =$("#"+tId).data().sub_data;
            $("#aa21 option").not(':eq(0)').remove();
            var sltsubData = subList[(idx-1)];
            if(sltsubData !== undefined) {
                if(sltsubData.length > 0) {
                    commCdBox.makeComboBox("S", _this.stationId, sltsubData, "aa21");
                }
            }
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
		             commCdBox.makeComboBox('CC', '', code, "batteryStusCd");
		         }
		});

        // 20190514 팀구분 존재할 경우 처리
        if ( "${condition.batteryStusCd}" != "") {
            $("#batteryStusCd").val("${condition.batteryStusCd}");
            find_team( true )
		} 
        
      //정거장 구분2
        /* commonAjax.getCommonCode("RAK", function(data) {
             if(data !== null && data.codeList !== null) {
            	 commCdBox.makeComboBox('CC',_this.stationSeCd, data.codeList, "a12");
             }
        }); */

    };

    currentStatus.searchStation = function(e) {
    	e.preventDefault();
    	
    	nMap.defaultLevel ='${condition.defaultLevel}' === '' ? '8' : '${condition.defaultLevel}';
    	currentStatus.viewType = 'search';
    	$("[name='viewType']").val('search');
    	$("[name='stationGrpSeq']").val($("#bb22").val());
    	$("[name='stationId']").val($("#aa21").val());
    	$("[name='defaultLevel']").val(nMap.defaultLevel);
    	$("[name='paramSearchWord']").val($("#searchWord").val());
    	$("[name='paramSearchType']").val($("#searcType").val());
    	currentStatus.initData(1, 'search');
    	
    };
    
    
    currentStatus.setColumnSortInfo = function(e) {
    	e.preventDefault();
    	if($("#sortSlt").val() === ''){
    		return false;
    	}
    	var tTarget = $("#sortSlt").val();
        $("[name='orderColumn']").val(tTarget);
        currentStatus.viewType = 'sort';
        if(tTarget === 'S') {
            $("[name='stationOrderType']").val($("[name='lsalign']:checked").val());
            $("[name='sharedOrderType']").val('');
        } else {
            $("[name='sharedOrderType']").val($("[name='lsalign']:checked").val());
            $("[name='stationOrderType']").val('');
        }
        currentStatus.initData(1, 'sort');
    };
   
    currentStatus.moveStationDetail = function(e) {
    	e.preventDefault();
    	$("[name='stationId']").val(e.target.id);
    	// 2018-11-25 새창열기로 변경
    	//$("#searchFrm").attr({action : "<c:out value='/moveCurrentStationDetail.do'/>", method : "post", target:"_blank"}).submit();
    	//2020-02-21 앱 사용으로 페이지 이동으로 변경
    	$("#searchFrm").attr({action : "<c:out value='/moveCurrentStationDetail.do'/>", method : "post"}).submit();
    };
    
    
    
    currentStatus.pageSelect = function(pageNo) {
    	this.initData(pageNo, 'list');
    };
    
    currentStatus.initData = function(pNo, pType) { 

		if($("#searchWord").val() != ''){
			$("[name='stationGrpSeq']").val($("#bb22").val());
	    	$("[name='stationId']").val($("#aa21").val());
			pType = "search";
		}
        $("[name='viewType']").val(pType);
        $("[name='currentPageNo']").val(pNo);
        $("[name='defaultLevel']").val(nMap.defaultLevel);	
        $("[name='paramSearchWord']").val($("#searchWord").val());
        $("[name='paramSearchType']").val($("#searchType").val());
 
        $("#searchFrm").attr({action: '/getQrLostStatus.do', method : "post"}).submit();
    };

    function find_team( flag ){
        
        var select = "<option value=\"\">선택</option>"
        var center = $("#batteryStusCd").val();
        if($("#batteryStusCd").val() == ''){
            $("#searchType").find("option").remove().end();
            $("#searchType").append(select);
        }else{
            $("#searchType").find("option").remove().end();
            $("#searchType").append(select);
            
            $.post("/admin/system/userMgmt/srchTeamList.do", "centerId="+center  , function(data) {
                
                for(var i=0; i < data.teamList.length; i++){
                    $("#searchType").append("<option value='"+data.teamList[i].teamSeq+"'>"+ data.teamList[i].teamNm +"</option>");
                }						

                // 초기 조회일 경우
                if ( flag ) {
                    
                    if("${condition.paramSearchType}" != ""){
		                $("#searchType").val("${condition.paramSearchType}");
		            }
                    
                }
                
            });
        }
	}   

    

    </script>
    
</body>
</html>
