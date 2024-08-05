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
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />
<meta name="description=" Content="" />
<title><tiles:insertAttribute name="title"/></title>
<tiles:insertAttribute name="resource"/>
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
                <tiles:insertAttribute name="left"  />
                <!--left menu E-->
                <!--conteent S-->
                <div id="content" class="content">
                    <div class="subject">
                        <!--subject path S-->
                        <tiles:insertAttribute name="subject" />
                        <!--subject path E-->
                    </div>
                    <div class="page">
                        <div id="mapDiv" class="mt20" style="height:350px;border:1px solid #dedede"><!--지도 삽입후 style은 삭제하고 사용-->
                        </div>
                        <div class="btnArea">
                            <span class="right"><button id="updatingBtn" class="btnType01">위치갱신</button></span>
                        </div>
                        <div class="lralign mt20">
	                        <p>조회기간 :<label id="searchDateTime"></label></p>
	                        <p>총 <span id="carTotCnt"><em></em></span> 대</p>
                        </div>
                        <table class="tb_type01 mt20">
                            <colgroup>
                                <col style="width:40%"/>
                                <col style="width:30%"/>
                                <col style="width:30%"/>
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>차종</th>
                                    <th>배치차량 번호</th>
                                    <th>최종 갱신일시</th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                    <!--conteent E-->
                </div>
            </div>
        </div>
	    <!--footer S-->
		<tiles:insertAttribute name="footer" />
		<!--footer E-->
    </div>
    <section style="display: none;">
        <table id="cloneTbl">
            <tr><td></td><td><a href="#" style="color : #6699FF;"></a></td><td class="tc"></td></tr>
        </table>
    </section>
    <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=4791tlnwi5"></script>
    <!-- <script type="text/javascript" src="/js/map_naver.js"></script> -->
    <script type="text/javascript" src="/js/common_barocle.js"></script>
    <script type="text/javascript" src="/js/stationCommonMap.js"></script>
    <script type="text/javascript">
    $(function(){
    	nMap.setMap();
    	relocation.initData();
    	$("#searchDateTime").val();
    	$("#updatingBtn").on("click", function(e){
    		e.preventDefault();
    		relocation.initData();
    	});
    	/* setInterval(function() {
    		relocation.initData();
    	}, 500000); */
    });
    var relocation = {};
    relocation.initData = function() {
    	var ccTime = DateUtil.dateFmt(new Date())+" "+DateUtil.getCurrentTime();
    	$("#searchDateTime").text(ccTime);
    	
    	var _this = relocation;
    	commonAjax.getAjax("<c:out value='/getRelocationBikeStatusList.do'/>", 'json', {}
    	    ,function(data){
    	    	if(data){
    	    		relocation.makeRelocationBikeData(data.relocationList);
    	    	}
    	    }
    	);
    };
    relocation.makeRelocationBikeData = function(pData) {
    	nMap.initMap();
    	$(".tb_type01 > tbody").empty();
    	if(pData !== null) {
    		var rSize = pData.length;
    		if(rSize >0 ) {
	    		for(var i=0; i<rSize; i+=1) {
	    		    var $tr = $("#cloneTbl > tbody > tr").clone();
	    		    $tr.find('td').eq(0).text(pData[i].carModlName);
	    		    $tr.find('a').text(pData[i].carNo).on("click",{carNo : pData[i].carNo , latitude :pData[i].nowLocLatitude, longitude :pData[i].nowLocLongitude }, relocation.reloadCarLocate);
	    		    $tr.find('td').eq(2).text(pData[i].locInfoModDttm);
	    		    
	    		    $(".tb_type01 > tbody").append($tr);
	    		    
	                nMap.targetViewData.push({carNo : pData[i].carNo, latitude :pData[i].nowLocLatitude,  longitude :pData[i].nowLocLongitude});
	    		}
    		} else {
    			$(".tb_type01").after('<table class="tb_type01 nbt0"><tr><td style="text-align:center"><spring:message code="search.nodata.msg" /></td></tr></table>');
    		}
    		$("#carTotCnt > em").text(rSize);
    	}
    	//relocation
    	//지도 표시.
    	nMap.setRelocationBikeMap();
    };
    relocation.reloadCarLocate = function(e) {
    	e.preventDefault();
    	nMap.initMap();
    	var pData = [e.data];
    	nMap.targetViewData = pData;
        nMap.setRelocationBikeMap();
    };
    </script>
</body>
</html>