<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<!-- 
	개발일시 : 2020-07-07
	개발자   : 김시성
	내용     : 자전거찾기 팝업
	TODO :  
	
	ASIS : 자전거 ID를 입력했을 경우에는 장애정보와 신고항목을 보여주고
	       입력하지 않았을 경우에는 보여주지 않는다.
	       (=서버에 부담이 크기때문)
	       
	       자전거 ID를 입력하지 않으면 아예 보여주지 않음. - 20200909
	        
 -->
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
	                        <label for="a1" class="laType02">번호</label>
	                        <span class="input-text07"><input type="text" name="bikeNo" style="width:30%;"/></span>
	                        <button class="btnType02" id="searchPopBtn">조회</button>
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
					</form>
                </div>
            </div>
            <table class="tb_type01 mt20">
                <colgroup>
                    <col style="width:35%"/>
                    <col style="width:"/>
                </colgroup>
                <thead>
                    <tr>
                        <th>자전거번호</th>
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
        
        initView(p.searchType);
        makeCombo();
    	$("#cancelBtn").on("click", function(e) {
    		e.preventDefault();
    		window.close();
    	});
        
    });
    var p = {};
    function makeCombo () {
    	commonAjax.getCommonCode("BKS"
            ,function(data){
                 if(data !== null && data.codeList !== null) {
                     commCdBox.makeComboBox("CC", '', data.codeList, "aa1");
                 }
             }
        );
    }
    function initView(param){
    	/** 단말기 수정화면에서 자전거 번호를 검색할 경우.*/
    	if(param === 'T') {
    		$("[name=deviceStatusCd]").prop("disabled", true);
    		$("#a111").prop("disabled", true);
    		$("[name='searchType']").val(param);
    		 $("#searchPopBtn").trigger('click');
    	}
    	
    }
    
    function searchDevice(e) {
    	e.preventDefault();
    	e.stopPropagation();
    	$(".tb_type01 tbody").empty();
    	if($("#a111").val() !== '') {
    		$("[name='searchType']").val($("#a111").val());
    	}
    	
    	$(".tb_type01 colgroup").empty();
    	
    	if($("[name='bikeNo']").val() != ''){
    		
    		var $col1 = $("<col>").css("width","18%");
    		var $col2 = $("<col>").css("width","20%");
    		var $col3 = $("<col>").css("width","48%");
    		var $col4 = $("<col>").css("width","14%");
    		
    		$(".tb_type01 colgroup").append([$col1,$col2,$col3,$col4]);
    		
    		$(".tb_type01 thead tr").empty();
    		
    		var $th1 = $("<th>").text("자전거번호");
    		var $th2 = $("<th>").text("현재상태");
    		var $th3 = $("<th>").text("장애내용");
    		var $th4 = $("<th>").text("신고");
    			
    		$(".tb_type01 thead tr").append([$th1,$th2,$th3,$th4]);
    		
    		
    	}else{
    		
    		var $col1 = $("<col>").css("width","35%");
    		var $col2 = $("<col>").css("width","");
    		
    		$(".tb_type01 colgroup").append([$col1,$col2]);
    		
    		$(".tb_type01 thead tr").empty();
    		
    		var $th1 = $("<th>").text("자전거번호");
    		var $th2 = $("<th>").text("현재상태");
    			
    		$(".tb_type01 thead tr").append([$th1,$th2]);
    		
    	}
    	
    	commonAjax.postAjax("/common/pop/findOutDeviceInfoDtlObs.do", "json", $("#searchFrm").serialize()
    	    ,function(data){
    		     if(data){
    		         if(data.deviceList != null) {
    		             var dSize = data.deviceList.length;
    		        	 if(dSize> 0) {
    		        		 
                             for(var i=0; i< dSize; i+=1) {
                            	 
                            	 var $td1 = $("<td>").addClass("pl10").append( $("<a>",{href :'#'}).text(data.deviceList[i].bikeNo).on("click", {bikeId: data.deviceList[i].bikeId, bikeNo: data.deviceList[i].bikeNo, deviceStatusName: data.deviceList[i].deviceStatusName, batReplaceTime: data.deviceList[i].batReplaceTime},clickBikeNo ));
                                 var $td2 = $("<td>").addClass("pl10").text(data.deviceList[i].deviceStatusName);
                                 
                                 if($("[name='bikeNo']").val() != ''){
                                	 
                                 	var $td3 = $("<td>").addClass("pl10").text(data.deviceList[i].faultContent == null ? '' : data.deviceList[i].faultContent);
                                 	var $td4 = $("<td>").addClass("pl10").text(data.deviceList[i].reportContent == null ? '' : data.deviceList[i].reportContent);
                                 	
                                 }
                                 
                                 if($("[name='bikeNo']").val() != ''){
                                	
                                 	$(".tb_type01 tbody").append($("<tr>")).append([$td1,$td2,$td3,$td4]);
                                 	
                                 }else{
                                	 
                                	$(".tb_type01 tbody").append($("<tr>")).append([$td1,$td2]); 
                                	 
                                 }
                             }
                             
                         }else if(dSize == 0 ){
                        	 
                        	 
                        	  if($("[name='bikeNo']").val() != ''){
                             	
	 	                        $(".tb_type01 tbody").append($("<tr>")).append($("<td>", {'colspan' : 4, 'class' : 'text-center'}).text("no data"));
                              	
                              }else{
                             	 
	 	                        $(".tb_type01 tbody").append($("<tr>")).append($("<td>", {'colspan' : 2, 'class' : 'text-center'}).text("no data"));
                             	 
                              }
 	                        
     		        	 }
    		        	 
    		         } else {
    		        	if(data.resultMessage !== '') {
    		        		alert(data.resultMessage);
    		        		return false;
    		        	} else {
	                        $(".tb_type01 tbody").append($("<tr>")).append($("<td>", {'colspan' : 2}).text("no data"));
    		        	}
                     }
    		     }
    		}
    	);
    	
    }
    
    function clickBikeNo(e) {
    	e.preventDefault();
    	if( p.searchType === 'T' || p.searchType === 'R' || e.data.deviceStatusName == '정상(대기중)' || e.data.deviceStatusName == '수리완료'){
    		var bikeId = e.data.bikeId;
        	var bikeNo = e.data.bikeNo;
        	var batReplaceTime = e.data.batReplaceTime;
        	opener.setBikeId(bikeId, bikeNo, batReplaceTime);
        	window.close();
    	}
    }
    
    </script>
</body>
</html>