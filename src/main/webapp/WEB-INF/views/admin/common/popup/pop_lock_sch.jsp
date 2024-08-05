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
	                    <span class="section pwtableblock">
	                        <label for="a1" class="laType02">대여소</label>
	                        <span class="input-text02"><input type="text" name="stationName"/></span>
	                    </span>
	                    
	                    <span class="section pwtableblock">
	                        <label for="a1" class="laType02">ID</label>
	                        <span class="input-text02"><input type="text" name="rackId" /></span>
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
	                        <button class="btnType02" id="searchPopBtn">조회</button>
	                    </span>
	            	</form>
                </div>
            </div>
            <table class="tb_type01 mt20">
                <colgroup>
                    <col style="width:25%"/>
                    <col style="width:25%"/>
                    <col style="width:25%"/>
                    <col style="width:25%"/>
                </colgroup>
                <thead>
                    <tr>
                        <th>센터/대여소</th>
                        <th>거치대 번호</th>
                        <th>ID</th>
                        <th>현재상태</th>
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
        
    });
    var p = {};
    function makeCombo () {
    	
    	commonAjax.getCommonCode("RAS"
                , function(data){
                    if(data !== null && data.codeList !== null) {
                        commCdBox.makeComboBox("CC", '', data.codeList, "aa1");
                       
                    }
                }
            );
            
    }
    function searchDevice(e) {
    	e.preventDefault();
    	e.stopPropagation();
    	$(".tb_type01 tbody").empty();
    	$("[name='searchType']").val($("#a111").val());
    	commonAjax.postAjax("/common/pop/findOutDeviceInfo.do", "json", $("#searchFrm").serialize()
    			,function(data){
    		         if(data){
    		        	if(data.deviceList != null) {
    		        	    var dSize = data.deviceList.length;
    		        		if(dSize> 0) {
                                for(var i=0; i< dSize; i+=1) {
                                    var $td1 = $("<td>").text(data.deviceList[i].stationName);
                                    var $td2 = $("<td>").text(data.deviceList[i].stationEquipOrder);
                                    var $td3 = $("<td>").append( $("<a>",{href :'#'}).text(data.deviceList[i].rackId).on("click", {rackId: data.deviceList[i].rackId, deviceStatusName: data.deviceList[i].deviceStatusName, stationName: data.deviceList[i].stationName},clickRackId ));
                                    var $td4 = $("<td>").text(data.deviceList[i].deviceStatusName);
                                    
                                    $(".tb_type01 tbody").append($("<tr>")).append([$td1,$td2,$td3,$td4]);
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
    
    function clickRackId(e) {
    	e.preventDefault();

    	if( p.searchType === 'R'|| e.data.deviceStatusName == '정상' || e.data.deviceStatusName == '수리완료'){
	    	var rackId = e.data.rackId;
	    	var stationName = e.data.stationName;
	    	opener.setRackId(rackId, stationName);
	    	window.close();
    	}
    }
    
    </script>
</body>
</html>
