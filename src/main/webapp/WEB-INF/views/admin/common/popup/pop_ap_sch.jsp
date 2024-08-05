<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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
            <div class="shBox_pop">
                <div class="shBoxSection">
                	<form id="searchFrm">
                        <input type="hidden" name="deviceType" value="${deviceType }">
                        <input type="hidden" name="searchType" value="">
                         <input type="hidden" name="stationGroupId" value="">
                          <input type="hidden" name="stationId" value="">
	                    <span class="section pwtableblock">
	                        <label for="a1" class="laType02">ID</label>
	                        <span class="input-text02"><input type="text" name="apId" /></span>
	                    </span>
	                    <span class="section pwtableblock">
		                        <label for="aa1" class="laType02">상태</label>
		                        <select class="select-category03" name="deviceStatusCd" id="aa1">
		                        	<option value="">전체</option>
		                        </select>
		                    </span>
	                    <span class="section pwtableblock">
	                        <label for="a111" class="laType02">위치</label>
	                        <select class="select-category03" id="a111" >
	                            <option value="">전체</option>
	                            <option value="C">센터</option>
	                            <option value="S">대여소</option>
	                        </select>
	                    </span>
	                    <span class="section pwtableblock">
	                    	<label for="aa11" class="laType02">센터/대여소</label>
	                    	<select class="select-category03" id="search_grp" >
	                    		 <option value="">선택</option>
	                    	</select>
	                    </span>
	                    <span>
	                    	<select class="select-category01" id="search_name" >
	                    		<option value="">선택</option>
	                    	</select>
	                    </span>
	                    <span class="section pwtableblock">
	                        <button class="btnType02" id="searchPopBtn" >조회</button>
	                    </span>
	            	</form>
                </div>
            </div>
            <table class="tb_type01 mt20">
                <colgroup>
                    <col style="width:35%"/>
                    <col style="width:35%"/>
                    <col style="width:30%"/>
                </colgroup>
                <thead>
                    <tr>
                        <th>AP ID</th>
                        <th>S/N</th>
                        <th>현재 상태</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
			<div class="btnArea">
                <span class="right">
                	<button class="btnType01" id="cancelBtn">취소</button>
                </span>
            </div>
        </div>
    </div>
    <a href="#" class="popclose"><img src="/images/btn_close.png" alt="팝업닫기" /></a>
    <script type="text/javascript" src="/js/common_barocle.js"></script>
    <script type="text/javascript">
    $(function() {
        $("#searchPopBtn").on("click", searchDevice);
        p.searchType = '${searchType}' == null ? '' :'${searchType}';
        
        makeCombo();

    	$("#cancelBtn").on("click", function(e) {
    		e.preventDefault();
    		window.close();
    	});
    	
    	$("#a111").change(function(){
    		fn_selectChange1(false);
    	});
    	
    	$("#a111").val("${searchVO.searchType}");
    	if("${searchVO.searchType}" != ""){
    		fn_selectChange(true);
    	}
    	
    	$("#search_grp").change(function(){
    		fn_selectChange(false);
    	});
    	
    	$("#search_grp").val("${searchVO.search_grp}");
    	if("${searchVO.search_grp}" != ""){
    		fn_selectChange(true);
    	}
    	
    });
    var p = {};
    function makeCombo () {    	
    	commonAjax.getCommonCode("APS"
                , function(data){
                    if(data !== null && data.codeList !== null) {
                        commCdBox.makeComboBox("CC", '', data.codeList, "aa1");
                       
                    }
                }
            );            
    }
    
    function fn_selectChange1( flg ){
        	var select = "<option value=\"\">선택</option>"
    		if($("#a111").val() == ''){
    			$("#search_grp").find("option").remove().end();
    			$("#search_grp").append(select);
    			$("#search_name").find("option").remove().end();
    			$("#search_name").append(select);
    		}else{
    			$("#search_grp").find("option").remove().end();
    			$("#search_grp").append(select);
    			$("#search_name").find("option").remove().end();
    			$("#search_name").append(select);
    			
    			if($("#a111").val() == "C"){		// 위치 : 센터
    				commonAjax.getCenterCode( 
    			            function(data) {
    			                if(data !== null && data.centerList !== null) {
    			                    commCdBox.makeComboBox('C', '', data.centerList, "search_grp");
    			                }
    			            }
    			        );
    			}else{		// 위치 : 대여소
    				$.post("/common/pop/groupStationList.do", "station_grp_seq=" + $("#stationGroupId").val()  , function(data) {
    					//alert(data.groupList.length);
    					for(var i=0; i < data.groupList.length; i++){
    						if(flg){
    							if("${searchVO.search_grp}" == data.groupList[i].stationId){
    								$("#search_grp").append("<option value='"+data.groupList[i].stationId+"' selected>"+ data.groupList[i].stationName +"</option>");
    							}else{
    								$("#search_grp").append("<option value='"+data.groupList[i].stationId+"'>"+ data.groupList[i].stationName +"</option>");
    							}
    						}else{
    							$("#search_grp").append("<option value='"+data.groupList[i].stationId+"'>"+ data.groupList[i].stationName +"</option>");
    						}						
    					}
    					
    				});
    			}
    		}
    }
    
	function fn_selectChange( flg ){
		
 		var select = "<option value=\"\">선택</option>"
		if($("#search_grp").val() == ''){
			$("#search_name").find("option").remove().end();
			$("#search_name").append(select);
			
		}else{
			$("#search_name").find("option").remove().end();
			$("#search_name").append(select);
			
			$.post("/admin/manage/station/groupStationList.do", "station_grp_seq=" + $("#search_grp").val()  , function(data) {
				
				for(var i=0; i < data.nameList.length; i++){
					if(flg){
						if("${searchVO.search_name}" == data.nameList[i].station_id){
							$("#search_name").append("<option value='"+data.nameList[i].station_id+"' selected>"+ data.nameList[i].station_name +"</option>");
						}else{
							$("#search_name").append("<option value='"+data.nameList[i].station_id+"'>"+ data.nameList[i].station_name +"</option>");
						}
					}else{
						$("#search_name").append("<option value='"+data.nameList[i].station_id+"'>"+ data.nameList[i].station_name +"</option>");
					}						
				}
				
			});
			
		} 
	}
    
    function searchDevice(e) {
    	e.preventDefault();
    	e.stopPropagation();
    	$(".tb_type01 tbody").empty();
    	$("[name='searchType']").val($("#a111").val());
    	$("[name='stationGroupId']").val($("#search_grp").val());
    	$("[name='stationId']").val($("#search_name").val());
    	commonAjax.postAjax("/common/pop/findOutDeviceInfo.do", "json", $("#searchFrm").serialize()
    			,function(data){
    		         if(data){
    		        	if(data.deviceList != null) {
    		        	    var dSize = data.deviceList.length;
    		        		if(dSize> 0) {
                                for(var i=0; i< dSize; i+=1) { 	
                                	
                                	var $td1 = $("<td>").append( $("<a>",{href :'#'}).text(data.deviceList[i].apId).on("click", {apId: data.deviceList[i].apId, deviceStatusName: data.deviceList[i].deviceStatusName, stationName: data.deviceList[i].stationName},clickApId	 ));
                                    var $td2 = $("<td>").text(data.deviceList[i].serialNo);
                                    var $td3 = $("<td>").text(data.deviceList[i].deviceStatusName);
                                    
                                    $(".tb_type01 tbody").append($("<tr>")).append([$td1,$td2,$td3]);
                                }
                            }
    		        	} else {
    		        		if(data.resultMessage !== '') {
    		        			alert(data.resultMessage);
    		        			return false;''
    		        		} else {
	                            $(".tb_type01 tbody").append($("<tr>")).append($("<td>", {'colspan' : 3}).text("no data"));
    		        		}
    		        		
                        }
    		        	
    		        	 
    		         }
    		   }
    	);
    	
    }
    
    function clickApId(e) {
    	e.preventDefault();

    	if( p.searchType === 'R' || e.data.deviceStatusName == '정상' || e.data.deviceStatusName == '수리완료'){
	    	var apId = e.data.apId;
	    	var stationInfo =  e.data.stationName;
	    	
	    	opener.setApId(apId, stationInfo);
	    	window.close();
    	}
    }
    
    </script>
</body>
</html>