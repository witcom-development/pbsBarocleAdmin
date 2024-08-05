<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%
	Calendar cal = Calendar.getInstance();
	int minYear = 2010;
	int nowYear = cal.get(Calendar.YEAR);
	SimpleDateFormat sdf = new SimpleDateFormat("MM");
	String nowMonth = sdf.format(cal.getTime());
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" /> 
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />
<meta name="description=" Content="" />
<title><tiles:insertAttribute name="title"/></title>
<tiles:insertAttribute name="resource"/>

<style>
   .mapSSS {
    font-size: .6em;
    width: 1em;
    border-radius: 8em;
    padding: .1em  .2em;
    line-height: 1.25em;
    border: 1px solid blue;
    display: inline-block;
    background:blue;
    text-align: center;
    color:white  
  }
   
</style>

</head>
<body>
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
					<tiles:insertAttribute name="left" />
				<!--left menu E-->
				<!--content S-->
				<div class="content">
					<div class="subject">
						<p class="pageTitle">주요 이동경로 현황</p>
						<span>통계 &gt;  <em>주요 이동경로 현황</em></span>
					</div>
					<div class="page">
						<!-- 모바일 검색조건 S-->
						<div class="shBox_m">
							<div class="downtitle">
								<div class="title">
									<p>검색조건</p><span><button><img src="/images/srh_open.png" alt="검색조건 열기" /></button></span>
								</div>
							</div>
						</div>
						<!-- 모바일 검색조건 E-->
						<!--검색조건 S-->
						<div class="shBox">
							<form id="searchFrm">
								<fieldset>
									<legend>검색 옵션</legend>
									<div class="shBoxSection">
										<div class="section radbox">
											<label for="bb22" class="laType02">기간</label>
											<p class="daymth1">
												<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" name="searchBgnDe" readonly/></span>
												<span class="dash">~</span>
												<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" name="searchEndDe" readonly/></span>
											</p>
										</div>
										<div class="section pright">
										</div>
										<div class="section"  style="margin-top: 5px;">
											<label for="rentStationGrpSlt" class="laType02">대여 아파트</label>
											<select class="select-category02" name="rentStationGrp" id="rentStationGrpSlt" style="width: 233px;">
                                                <option value="">선택</option>
                                            </select>
										</div>
										<div class="section pright"  style="margin-top: 5px;">
											<label for="rentStationIdSlt" class="laType02">대여 대여소</label>
											<select class="select-category02" name="rentStationId" id="rentStationIdSlt"  style="width: 233px;">
                                                <option value="">선택</option>
                                            </select>
										</div>
										<div class="section"  style="margin-top: 2px;">
											<label for="returnStationGrpSlt" class="laType02">반납 아파트</label>
											<select class="select-category02" name="returnStationGrp" id="returnStationGrpSlt"  style="width: 233px;">
                                                <option value="">선택</option>
                                            </select>
										</div>
										<div class="section pright" style="margin-top: 2px;">
											<label for="returnStationIdSlt" class="laType02">반납 대여소</label>
											<select class="select-category02" name="returnStationId" id="returnStationIdSlt"  style="width: 233px;">
                                                <option value="">선택</option>
                                            </select>
										</div>
										<div class="section">
											<label for="searchName" class="laType02">자전거번호</label>
											<span class="input-text07"><input id="searchBikeNo" name="searchBikeNo" type="text"  class="input-text07"  maxLength="5"  style="width: 221px;"></span>
											<button type="button" id="searchBtn" class="btn-srh03 btncase1"><img src="/images/searchIcon.gif" alt="검색" /></button>
										</div>
									</div>
								</fieldset>
							</form>
						</div>
						
						<div id="mapDiv" style="border: 1px; width:1000px; height: 700px">
						
						</div>
					</div>
				</div>
				<!--content E-->
			</div>
		</div>	
			<!--footer S-->
				<tiles:insertAttribute name="footer" />
			<!--footer E-->
	</div>
		
	
    <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=4791tlnwi5"></script>
	<script type="text/javascript" src="/js/common_barocle.js"></script>
    <script type="text/javascript">
    
   	$(function() {
   		
   		//$('#loadingBarDiv').css('display','none');
   		var _this = routeStatistics;
   		_this.initCombo();
   		
		$('[name="searchBgnDe"]').val('${searchCondition.searchBgnDe}');
		$('[name="searchEndDe"]').val('${searchCondition.searchEndDe}');
   		
   		$("#rentStationGrpSlt").on('change', function(e){
        	var tId = e.target.id;
        	var idx = $("#"+tId+" option:selected").index();
        	var subList =$("#"+tId).data().sub_data;
        	$("#rentStationIdSlt option").not(':eq(0)').remove();
        	var sltsubData = subList[(idx-1)];
        	if(sltsubData !== undefined) {
	        	if(sltsubData.length > 0) {
		        	commCdBox.makeComboBox("S",_this.stationId,sltsubData, "rentStationIdSlt");
	        	}
        	}
        });
   		
   		$("#returnStationGrpSlt").on('change', function(e){
        	var tId = e.target.id;
        	var idx = $("#"+tId+" option:selected").index();
        	var subList =$("#"+tId).data().sub_data;
        	$("#returnStationIdSlt option").not(':eq(0)').remove();
        	var sltsubData = subList[(idx-1)];
        	if(sltsubData !== undefined) {
	        	if(sltsubData.length > 0) {
		        	commCdBox.makeComboBox("S",_this.stationId,sltsubData, "returnStationIdSlt");
	        	}
        	}
        });
   		
   		$('#searchBtn').on('click', function(e){
			e.preventDefault();
			sw=screen.availWidth;
	        
	        px=sw/2 - 100;
			//$('#loadingBarDiv').css('left', px);
	        
	        if(DateUtil.checkDateTerm( $( "[name='searchBgnDe']").val(),  $( "[name='searchEndDe']").val()) != 'ok') {
	            alert('<spring:message code="fail.input.daterange"/>');
	            return false;
	        }
   			
	        if($('[name="searchBgnDe"]').val() == ""){
	        	alert('기간을 지정해 주세요.');
	        	return false;
	        }
   			
	        if($('[name="searchEndDe"]').val() == ""){
	        	alert('기간을 지정해 주세요.');
	        	return false;
	        }
	        
	        if($('[name="rentStationId"]').val() == "" && $('[name="returnStationId"]').val() == "" && $('[name="searchBikeNo"]').val() == ""){
	        	alert('자전거 번호를 입력해 주세요.');
	        	return false;
	        }
	        
	      /*   if($('[name="rentStationId"]').val() != "" && $('[name="searchBikeNo"]').val() == ""){
	        	alert('자전거 번호를 입력해 주세요.');
	        	return false;
	        }
	        
	        if($('[name="returnStationId"]').val() != "" && $('[name="searchBikeNo"]').val() == ""){
	        	alert('자전거 번호를 입력해 주세요.');
	        	return false;
	        } */
	        
	        /* if($('[name="returnStationId"]').val() == ""){
	        	alert('반납 대여소를 지정해 주세요.');
	        	return false;
	        } */

	        // 로딩바 처리 
			fn_loading();
	        
	        var routeData;

	        $.ajax({
				url : "/route/getRouteData.do",
				type : "post",
				dataType : "json",
				data : $('#searchFrm').serialize(),
				async : false,
				success : function(data){
					routeData = data.dataList;
					fn_unloading();
				},
				error : function(jqXHR, textStatus,errorThrown){
					if(jqXHR.status === 500 || jqXHR.status === 200){
						alert("에러가 발생했습니다. : " + textStatus);
					}
					fn_unloading();
				}
			});
	        
	        $('#mapDiv').empty();
 
	        var mapOptions = {
	            mapTypeControl: true,
                mapTypeControlOptions: {
                    style: naver.maps.MapTypeControlStyle.BUTTON,
                    position: naver.maps.Position.TOP_RIGHT
                },
                zoomControl: true,
                zoomControlOptions: {
                    style: naver.maps.ZoomControlStyle.SMALL,
                    position: naver.maps.Position.TOP_RIGHT
                },
                scaleControl: true,
                scaleControlOptions: {
                    position: naver.maps.Position.RIGHT_CENTER
                },
                logoControl: true,
                logoControlOptions: {
                    position: naver.maps.Position.TOP_LEFT
                },
                mapDataControl: true,
                mapDataControlOptions: {
                    position: naver.maps.Position.BOTTOM_LEFT
                }
            };

	        
            var map = new naver.maps.Map(document.getElementById('mapDiv'), mapOptions);
            var marker = null;
            
	        if(routeData.length > 0) {
		     	
	        	for(var i = 0; i < routeData.length; i++){
	        		
	        		 var contentText = "<span class='mapSSS'>" + i + "</span>" ;
	        			
	        		  marker = new naver.maps.Marker({
	      	            position: new naver.maps.LatLng(routeData[i].moveLatitude, routeData[i].moveLongitude),
	      	            map: map,
	      	          	icon : {
	      	          		content :  contentText 
	      	          	}   

	        		 
	      	        }
	        		  
	        		  );
	      	     
        		  	if( i == ( routeData.length - 1)) {
	  		    		map.setCenter( marker.position );
	  		    	}
	        	}
	        }  	
	      
   		});
   	});
   	
   	var routeStatistics = {};
   	routeStatistics.rentStationGrp = '${searchCondition.rentStationGrp}';
   	routeStatistics.rentStationId = '${searchCondition.rentStationId}';
   	routeStatistics.returnStationGrp = '${searchCondition.returnStationGrp}';
   	routeStatistics.returnStationId = '${searchCondition.returnStationId}';
   	
   	routeStatistics.initCombo = function(){
    	var _this = routeStatistics;

    	//대여 아파트 
        commonAjax.getStationCode( 
	        function(data) {
	            if(data != null && data.stationList != null) {
	                commCdBox.makeComboBox('S',_this.rentStationGrp, data.stationList, "rentStationGrpSlt");
	                $("#rentStationGrpSlt").trigger('change');
	            }
	        }
        );
    	
    	//반납 아파트 
        commonAjax.getStationCode( 
	        function(data) {
	            if(data != null && data.stationList != null) {
	                commCdBox.makeComboBox('S',_this.returnStationGrp, data.stationList, "returnStationGrpSlt");
	                $("#returnStationGrpSlt").trigger('change');
	            }
	        }
        );
    };

    var lodBarCtl = {
        id        : "loadingBarDiv"
        ,cnt    : 0
        ,init    : function(id, cnt) {
            lodBarCtl.id = id;
            lodBarCtl.cnt = cnt;
        }
        ,openAdd    : function() {
            lodBarCtl.cnt++;
            $("#"+lodBarCtl.id).show();
        }
        ,open    : function(cnt) {
            if(arguments.length>0) {
                lodBarCtl.cnt = arguments[0];
            }
            
            $("#"+lodBarCtl.id).show();
        }
        ,close    : function() {
            lodBarCtl.cnt--;
            if(lodBarCtl.cnt<=0) {
                $("#"+lodBarCtl.id).hide();
            }
        }
    };

    <%-- 자전거 번호 숫자만 입력하도록 키이벤트줌. cms_20161103--%>
    $('#searchBikeNo').keypress(function (event) {
        if (event.which && ((event.which <= 47) || (event.which >= 58)) && event.which != 8) {
          event.preventDefault();
        }
    });
   
    
    </script>
    <div id='loadingBarDiv' style="display:none; background:gray; position:absolute; top:0px; left:0px; width:100%; height:100%; padding-top:450px; z-Index:9999;"><img src='/images/load-indicator.gif' border='0' alt="로딩바" /></div>
    </body>
</html>