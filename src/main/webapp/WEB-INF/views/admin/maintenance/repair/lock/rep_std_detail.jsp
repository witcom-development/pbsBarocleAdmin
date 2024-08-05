<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
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
					<tiles:insertAttribute name="left" />
				<!--left menu E-->
				<!--content S-->
				<div class="content">
					<div class="subject">
                        <!--subject path S-->
                        <tiles:insertAttribute name="subject" />
                        <!--subject path E-->
					</div>
					<div class="page">
						<form id="frm">
                            <input type="hidden" name="searchBgnDe"  value="${repairBeaconInfo.searchBgnDe}" />
                            <input type="hidden" name="searchEndDe"  value="${repairBeaconInfo.searchEndDe}" />
                            <input type="hidden" name="pageNo" value="${repairBeaconInfo.getCurrentPageNo() }"/>
                            <input type="hidden" name="division" value="${repairBeaconInfo.division}"/>
                            <input type="hidden" name="repairSeq" value="${repairBeaconInfo.repairSeq}"/>      
                            <input type="hidden" name="faultSeq" value="${repairBeaconInfo.faultSeq}"/>      
                            <input type="hidden" name="repairCode" value=""/>
                            
                            <input type="hidden" name="stationId" id ="stationId" value="${repairBeaconInfo.stationId}"/>
                            
                            <input type="hidden" name="viewFlg" value="${repairBeaconInfo.viewFlg}"/>
                            
							<fieldset>
								<legend>거치대 등록 / 상세 / 수정</legend>
								<table class="tb_type02 mt20">
									<colgroup>
										<col style="width:25%"/>
										<col style="width:75%"/>
									</colgroup>
									<tbody>
										<tr>
											<th class="top"><em>*</em> 대여소번호</th>
											<td class="top">
												<span class="input-text07"><input type="text" name="rackId" /></span>
												<button class="winNewPop modal btnType02" title="검색" id="stationSearch">검색</button>
												
												<%-- </c:if> --%>
											</td>
										</tr>
										<tr>
											<th> 대여소명</th>
											<td>
												<label id="stationName">
												<c:if test="${repairBeaconInfo.stationName != ''  && repairBeaconInfo.stationName != null}">
												${repairBeaconInfo.stationName}
												</c:if> 
												</label>
											</td>
										</tr> 
										<tr>
											<th><em>*</em> 수리구분</th>
											<td id="repairDivision">
											</td>
										</tr>
										<tr>
											<th>조치사항</th>
											<td>
												 <span class="input-text21">
												 	<input type="text" name="beaconReport" id="beaconReport" value="${repairBeaconInfo.beaconReport}"/>
												</span>  
											</td>
										</tr>
										<tr>
											<th>특이사항</th>
											<td>
												<span class="input-text21">
													<input type="text" name="repairReport" id="repairReport" value="${repairBeaconInfo.repairReport}"/>
												</span>
											</td>
										</tr>
									</tbody>
								</table>
								<div class="btnArea">
									<span class="left"><button class="btnType01 bc_gray" id="moveRepairLockList">목록</button></span>
									<span class="right">
										<button type="button" class="btnType01 bc_green" id="exeRepairLockEdit">저장</button>
									</span>
								</div>
							</fieldset>
						</form>
					</div>
				</div>
				<!--content E-->
			</div>
		</div>
		<!--footer S-->
			<tiles:insertAttribute name="footer" />
		<!--footer E-->
	</div>
	
	<script type="text/javascript" src="/js/common_barocle.js"></script>
    <script type="text/javascript">
	    $(function() {
	    	 
	   		repairLockInfo.initBtn();
	   		var repairSeq = '${repairBeaconInfo.repairSeq}' !== '' ? '${repairBeaconInfo.repairSeq}' : '';
		    var rackId = '${repairBeaconInfo.rackId}' !== '' ? '${repairBeaconInfo.rackId}' : '${repairBeaconInfo.rackId}';
			var repairCodeList = '${repairBeaconInfo.repairCodeList}' !== '' ? '${repairBeaconInfo.repairCodeList}' : '';
			/* var stationName = '${repairBeaconInfo.stationName}' !== '' ? '${repairBeaconInfo.stationName}' : ''; */
			
			var stationId = '${repairBeaconInfo.stationId}' !== '' ? '${repairBeaconInfo.stationId}' : '';
			
			$("#stationId").val( stationId);
			/* $("#stationName").val( stationName ); */
			$("[name='rackId']").val(rackId);
			commonAjax.getCommonCode("REL", function(data){
	    		if(data !== null && data.codeList !== null) {
	           	 	
	    			
	    			for(var i = 0; i < data.codeList.length; i++){
	            		$('<span class="pwtableblock input-ck02"><input type="checkbox" id="c'+i+'" value="'+data.codeList[i].comCd+'"/><label for="c'+i+'">'+data.codeList[i].comCdName+'</label></span>').appendTo('#repairDivision');
	           	 	
	           	 	}
	           	 	
	           		var repairCode = repairCodeList.replace(' ', '').replace('[', '').replace(']', '').split(',');	// 추후 수정
		 			  for(var i=0; i < repairCode.length; i++) {
		     			$("input[value='"+repairCode[i].replace(' ', '')+"'").prop('checked', true);
		     		}   
	            }
	    	});
	    });
	    
	    var repairLockInfo = {};
	    
	    repairLockInfo.initBtn = function(){
	    	var _this = repairLockInfo;
	    	$("#moveRepairLockList").on("click", this.moveRepairLockList);
	    	$('#exeRepairLockEdit').on("click", this.exeRepairLockEdit);
	    	$("#stationSearch").on("click", this.stationSearch);
	    }
	    
	    $("[name='rackId']").keyup(function(e){
	    	var inputLength = $(this).val().length; //입력한 값의 글자수
	    	if( inputLength < 3 ) return false;
	    	
	    	repairLockInfo.stationSearch(e);
	    	return false;
	    });
	    
	    // 대여소 목록 조회
	    repairLockInfo.stationSearch = function (e) {
	    	e.preventDefault();
	    	
	    	var stationNum  = $("[name='rackId']").val();
	    	
	    	if( stationNum.length < 3 ) return false;
	    	
	    	commonAjax.postAjax("/getStationInfoAjax.do", 'json', {stationNo:stationNum}
          			, function(data){
          				
          	        	if(data.resultMessage == true ){
          	        		if( data.dsVO != null ) {
	          	        		$("#stationName").text( data.dsVO.stationName);
	          	        		$("#stationId").val( data.dsVO.stationId);
	          	        		
	          	        		console.log( $("#stationId").val() + " : " + data.dsVO.stationId );
	          	        		
          	        		} else {
          	        			alert("해당 대여소는 미존재합니다.");
          	        			return false;
          	        		}
          	        	}else{
          	        		alert('오류가 발생하였습니다.');
          	        	}
	              	}
	  	        );
	    	return false;
	    };
	    
	    repairLockInfo.moveRepairLockList = function (e) {
	    	e.preventDefault();
	        $("#frm").attr({method :"post", action :"/repairLockList.do"}).submit();
	    };
	    
	    repairLockInfo.exeRepairLockEdit = function (e) {
	    	e.preventDefault();
	    	
	    	if($('[name="rackId"]').val() == "" || $('[name="rackId"]').val() == undefined){
	    		alert('<spring:message code="fail.input.emptyValue2" arguments="대여소번호"/>');
	    		$('[name="rackId"]').focus();
	    		return;
	    	}
	    	
	    	var repairCode = "";
	    	$('input[type="checkbox"]:checked').each(function(e){
	    		if(repairCode.length > 0){
	    			repairCode = repairCode+",";
	    		}
				repairCode = repairCode+$(this).val();
			});
	    	
	    	if(repairCode.length == 0){
	    		alert('<spring:message code="fail.input.emptyValue1" arguments="수리구분"/>');
	    		return;
	    	}
	    	/* 
	    	$("#lockReport").val($("#lockReportTxt").val());
	    	$("#repairReport").val($("#repairReportTxt").val());
	    	 */
	    	$('[name="repairCode"]').val(repairCode);
	    	
      		$('#exeRepairLockEdit').attr('disabled', true);
	    	
    	 	 commonAjax.postAjax("/insertRepairLockAjax.do", 'json', $("#frm").serialize()
         			, function(data){
    	 		 
         	        	if(data.resultMessage == 'Success'){
         	        		alert('등록이 완료되었습니다.');
         	        		$('#exeRepairLockEdit').attr('disabled', false);
         	        		$("#frm").attr({method :"post", action :"/repairLockList.do"}).submit();
         	        	}else{
         	        		alert('오류가 발생하였습니다.');
         	        		$('#exeRepairLockEdit').attr('disabled', false);
         	        	}
              	}
  	        );
    	 	 
	    }
	    
	</script>
</body>
</html>