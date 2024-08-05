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
            <div class="shBox_pop">
                <div class="shBoxSection">
                    <form id="searchFrm">
                        <input type="hidden" name="deviceType" value="${deviceType }">
                        <input type="hidden" name="searchType" value="">
	                    <span class="section pwtableblock">
	                        <label for="a1" class="laType02">ID</label>
	                        <span class="input-text02"><input name="terminalId" type="text" /></span>
	                    </span>
	                    <span class="section pwtableblock">
	                        <label for="aa1" class="laType02">상태</label>
	                        <select class="select-category03" id="aa1" name="deviceStatusCd" >
	                            <option value="">전체</option>
	                        </select>
	                    </span>
	                    <span class="section pwtableblock">
	                        <label for="a111" class="laType02">위치</label>
	                        <select class="select-category03" id="a111" >
	                            <option value="">전체</option>
	                            <option value="C">센터</option>
	                            <option value="B">자전거</option>
	                        </select>
	                        <button class="btnType02" id="searchPopBtn">조회</button>
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
                        <th>단말기 ID</th>
                        <th>S/N</th>
                        <th>현재 상태</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>
    <a href="#" class="popclose"><img src="/images/btn_close.png" alt="팝업닫기" /></a>
    <script type="text/javascript" src="/js/common_barocle.js"></script>
    <script type="text/javascript">
    $(function() {
        $("#searchPopBtn").on("click", searchDevice);
        var searchType = '${searchType}' == null ? '' :'${searchType}';
        if( searchType !== '') {
            $("#a111").val(searchType).prop("disabled", true);
        }
        
        makeCombo();
        
    });
    function makeCombo () {
    	
    	commonAjax.getCommonCode("DES"
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
	                             var $td1 = $("<td>").append( $("<a>",{href :'#'}).text(data.deviceList[i].terminalId).on("click", {deviceID: data.deviceList[i].terminalId },clickDeviceId ));
	                             var $td2 = $("<td>").text(data.deviceList[i].serialNo);
	                             var $td3 = $("<td>").text(data.deviceList[i].deviceStatusName);
	                             
	                             $(".tb_type01 tbody").append($("<tr>")).append([$td1,$td2,$td3]);
	                         }
	                         
	                     } else {
	                         if(data.resultMessage !== '') {
	                             alert(data.resultMessage);
	                             return false;
	                         } else {
	                             $(".tb_type01 tbody").append($("<tr>")).append($("<td>", {'colspan' : 3}).css('text-align','center').text("no data"));
	                         }
	                     }
	    		     } 
    		     }
    		}
    	);
    	
    }
    
    function clickDeviceId(e) {
    	e.preventDefault();
    	var pId = e.data.deviceID;
    	opener.setDeviceId(pId);
    	window.close();
    }
    
    </script>
</body>
</html>