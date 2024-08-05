<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
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
<body id="body">
    <h1 class="popTt"></h1>
    <div class="cntbox">
        <div class="allwrap pop">
            <div class="shBox_pop">
                <form id="searchFrm">
                    <input type="hidden" name="stationOrderType" value="">
                    <input type="hidden" name="sharedOrderType" value="">
                    <input type="hidden" name="orderColumn"   value="">
                    <input type="hidden" name="viewType"      value="list">
                    <input type="hidden" name="stationId"     value="">
                    <input type="hidden" name="stationGrpSeq" value="">
                    <input type="hidden" name="defaultLevel" value="${defaultLevel}">
                    <div class="shBoxSection">
                        <span class="section pwtableblock"><label for="a1" class="laType02">아파트</label>
                            <select class="select-category03" id="a1">
                                <option value="">전체</option>
                            </select>
                        </span>
                        <span class="section pwtableblock"><label for="aa1" class="laType02">대여소 명</label>
                            <select class="select-category03" id="aa1">
                               <option value="">전체</option>
                            </select>
                            <button type="button" class="btnType02" id="searchBtn">조회</button>
                         </span>
                         <p style="font-size:20px;font-weight:bold;">조회일시 :<label id="searchDateTime"></label></p>
                    </div>
                </form>
            </div>
            <div  id="content" class="didBox pop">
                <div class="leftBox" id="mapDiv"><!--style="height:500px" 는 영역 표시를 위한 임시값입니다. 트리구조 삽입후 삭제하셔야 합니다.-->
                </div>
                <div class="listalign mt20">
                    <select name="sortSlt" id="sortSlt" class="mr10">
                        <option value="">선택</option>
                        <option value="S">대여소</option>
                        <option value="P">거치율</option>
                    </select>
                    <label><input name="lsalign" type="radio" value="ASC" class="vm" /> 오름차순</label>
                    <label><input name="lsalign" type="radio" value="DESC" class="vm ml10" /> 내림차순</label>
                </div>
                <div class="rightBox">
                    <table class="tb_type01">
                        <colgroup>
                            <col style="width:30%"/>
                            <col style="width:20%"/>
                            <col style="width:20%"/>
                            <col style="width:20%"/>
                        </colgroup>
                        <thead>
                            <tr>
                                <th>대여소</th>
                                <th>거치대 (점검)</th>
                                <th>자전거 (점검)</th>
                                <th>거치율</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <a href="#" class="popclose"><img src="/images/btn_close.png" alt="팝업닫기" /></a>
    <section style="display: none;">
        <table id="cloneT">
            <tr>
                <td class="title">상암 1</td>
                <td>10/20(1)</td>
                <td>10/20(3)</td>
                <td>10</td>
            </tr> 
        </table>
       <div id="infoDiv" class="mpblue infolf" >
            <div class="stamapinfo noimginfo">
                <p class="stamtitle"><span>월드컵경기장역 3번출구</span> <a href="return false;" class="mpclose"><img src="/images/stationClose.gif" alt="대여소 정보닫기" /></a></p>
                <p class="staimg"><img src="/images/mapNoimg.gif" alt="" /></p>
                    <ul>
                         <li>거치대 : <span>10/20</span></li>
                         <li>자전거 : <span>10/20</span></li>
                         <li>지연반납 : <span>10</span></li>
                         <li>점유율 : <span>60%</span></li>
                    </ul>
                <p class="stamappos"><img src="/images/stationPos.png" style="width: 21px;height: 16px;" alt=""/></p>
            </div>
       </div>z
    </section>
    
    <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=4791tlnwi5&callback=draw"></script>
    <script type="text/javascript" src="/js/common_barocle.js"></script>
    <script type="text/javascript" src="/js/stationCommonMapv.js"></script>
    <script type="text/javascript">
    
    function draw(){
    	<c:forEach var="info" items="${stationList}">
        //지도용 데이터 편집.
        var flg = false;
        
        if("${info.equipmentFaultYN}" === 'Y') {
            flg = true;
        }   
        nMap.targetViewData.push({stationId  : "${info.stationId}"
                                 ,stationName: "${info.stationName}" 
                                 ,latitude   : "${info.stationLatitude}"
                                 ,longitude  : "${info.stationLongitude}"
                                 ,rackInfo   : "${info.parkingRack}"+"/"+"${info.rackTotCnt}"+"("+"${info.brokenRackTotCnt}"+")"
                                 ,bikeInfo   : "${info.parkingBikeTotCnt}"+"/"+"${info.parkingRack}"+"("+"${info.brokenBikeTotCnt}"+")"
                                 ,longTerm   : "${info.longTermNonReturnTotCnt}"
                                 ,shared     : "${info.shared}"
                                 ,currnetStatus : "${info.currnetStatus}"
                                 ,stationUseYn: "${info.stationUseYn}"
                                 ,stationImgFileName: "${info.stationImgFileName}"
                                 ,mainStationYn: "${info.mainStationYn}"
                                 ,deviceBroken  : flg}); 
    	</c:forEach>
    	// nMap.makeStationMapInfo();
    }
    
    
    $(function(){
    	nMap.isPop = true;
        initSetCombo();
        initSetData(popData.type);
            
        $("#searchBtn").on("click", searchStation);
        $("#a1").on("change", function(e){
            var tId = e.target.id;
            var idx = $("#"+tId+" option:selected").index();
            var subList =$("#"+tId).data().sub_data;
            $("#aa1 option").not(':eq(0)').remove();
            var sltsubData = subList[(idx-1)];
            if(sltsubData !== undefined) {
                if(sltsubData.length > 0) {
                    commCdBox.makeComboBox("S", '${searchCondition.stationId}', sltsubData, "aa1");
                }
            }
        });
        $("#sortSlt").on('change', function(){
            $("[name='lsalign']").prop('checked', false);
        });
        $("[name='lsalign']").on("change", setColumnSortInfo);
        
/*        
        setInterval(function(){
    		$("[name='stationGrpSeq']").val($("#a1").val());
    		$("[name='stationId']").val($("#aa1").val());
    		$("[name='defaultLevel']").val( nMap.map.getLevel());
    		popData.defaultLevel =nMap.map.getLevel();
    		popData.type = 'list';
    		if($("#a1").val() !=="") {
    			popData.type = "search";
    		}
    		initSetData(popData.type);
    	}, 50000);
  */      
        
    });    
    var popData = {
    	 stationOrderType : '${searchCondition.stationOrderType}'
        ,orderColumn : '${searchCondition.orderColumn}'
        ,type : 'pop'
        ,viewType : '${searchCondition.viewType}' === "" ? "list" :'${searchCondition.viewType}'
        ,defaultLevel : nMap.defaultLevel
    };
    function searchStation(e) {
        e.preventDefault();
        e.stopPropagation();
        popData.viewType = "search";
/*        
        popData.defaultLevel =nMap.map.getLevel();
 */       
        $("[name='viewType']").val(popData.viewType);
/*        
        $("[name='defaultLevel']").val(nMap.map.getLevel());
 */      
        
        $("[name='stationGrpSeq']").val($("#a1").val());
        $("[name='stationId']").val($("#aa1").val());
        var t = popData.viewType;
        if($("#a1").val() === "") {
        	t = "list";
        }
        initSetData(t);
    }
  
    function initSetCombo() {
        //스테이션 
        commonAjax.getStationCode( 
            function(data) {
                if(data != null && data.stationList != null) {
                    $("#a1 option").not(':eq(0)').remove();
                    commCdBox.makeComboBox('S', '${searchCondition.stationGrpSeq}', data.stationList, "a1");
                    $("#a1").trigger("change");
                }
            }
        );
    }
    
    function initSetData(type) {
    	
    	if(popData.viewType !== 'sort') {
    		
    		
    		
	    	var sWidth  = $(".didBox").width()/2;
	    	var sHeight = $(window).innerHeight() - ($(".shBox_pop").height()+135);
	    	$("#mapDiv").empty();
	    	$("#mapDiv").css("height", sHeight);
	    	$(".rightBox").css({"height":(sHeight -80) , "overflow" : "auto"});
	    	
	    	var searchDttm = DateUtil.dateFmt(new Date())+" "+DateUtil.getCurrentTime();
	    	$("#searchDateTime").text(searchDttm);
	    	nMap.map = null;
	    	nMap.viewType = type;
	    	nMap.defaultLevel = popData.defaultLevel;
	        nMap.setOption(sWidth,sHeight); 
	        nMap.setMap();
    	}
      
        popData.orderColumn      = $("[name='orderColumn']").val();
        popData.stationOrderType =  $("[name='stationOrderType']").val();
        popData.sharedOrderType  =  $("[name='sharedOrderType']").val();
                
        commonAjax.postAjax("/getStationStautsList.do", "json", $("#searchFrm").serialize()
            ,function(data){
                if(data.result) {
                    makeStationListView(data.stationList);
                } else {
                	
                }
            }
        );
    }
    function makeStationListView(listData){
        $(".tb_type01 > tbody").empty();
        if(listData.length > 0){
            var lSize = listData.length;
            nMap.targetViewData = [];
            for(var i=0; i < lSize; i++) {
                var $tr = $("#cloneT > tbody > tr").clone();
                $tr.children().eq(0).text(listData[i].stationName);
                $tr.children().eq(1).text( listData[i].parkingRack+"/"+listData[i].rackTotCnt+"("+listData[i].brokenRackTotCnt+")");
                $tr.children().eq(2).text( listData[i].parkingBikeTotCnt+"/"+listData[i].parkingRack+"("+listData[i].brokenBikeTotCnt+")");
                $tr.children().eq(3).text( listData[i].shared);
                $(".tb_type01 > tbody").append($tr);
                
                //지도용 데이터 편집.
    		    var flg = false;
    		    if(listData[i].equipmentFaultYN === 'Y') {
    		        flg = true;
    		    }
                nMap.targetViewData.push({stationId: listData[i].stationId
					                    ,stationName: listData[i].stationName 
					                    ,latitude : listData[i].stationLatitude
					                    ,longitude :listData[i].stationLongitude
					                    ,rackInfo : listData[i].parkingRack+"/"+listData[i].rackTotCnt+"("+listData[i].brokenRackTotCnt+")"
					                    ,bikeInfo : listData[i].parkingBikeTotCnt+"/"+listData[i].parkingRack+"("+listData[i].brokenBikeTotCnt+")"
					                    ,longTerm : listData[i].longTermNonReturnTotCnt
					                    ,shared : listData[i].shared
					                    ,currnetStatus : listData[i].currnetStatus
					                    ,stationUseYn: listData[i].stationUseYn
					                    ,stationImgFileName: listData[i].stationImgFileName
					                    ,mainStationYn: listData[i].mainStationYn
					                    ,deviceBroken  : flg});   
			            }
        } else {
            $(".tb_type01 > tbody").append('<table class="tb_type01 nbt0"><tr><td style="text-align:center"><spring:message code="search.nodata.msg" /></td></tr></table>');
        }
        if(popData.viewType !=='sort') {
           
        	 nMap.makeStationMapInfo();
        } 
    }
    function setColumnSortInfo(e) {
        e.preventDefault();
        if($("#sortSlt").val() === ''){
            return false;
        }
        var tTarget = $("#sortSlt").val();
        popData.viewType= "sort";
        $("[name='viewType']").val('sort');
        $("[name='orderColumn']").val(tTarget);
        if(tTarget === 'S') {
            $("[name='stationOrderType']").val($("[name='lsalign']:checked").val());
            $("[name='sharedOrderType']").val('');
        } else {
            $("[name='sharedOrderType']").val($("[name='lsalign']:checked").val());
            $("[name='stationOrderType']").val('');
        }
        
        initSetData();
    }
    </script>
</body>