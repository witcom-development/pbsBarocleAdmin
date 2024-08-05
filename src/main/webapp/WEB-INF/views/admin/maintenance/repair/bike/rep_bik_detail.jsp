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
 	
 	<c:if test="${repairBike.viewFlg == 'R'}">
	<script>
		$(document).ready(function(){
			$(".menuArea").css("display","none");
			$(".leftmenu").css("display","none");
			$(".subject").css("margin-bottom","0");
			$(".cont").css('padding-top','0');
			$(".content").css('height','240px');

			$("#footer").css("display","none");
		});
	</script>
	</c:if>
</head>

<body>
	<div class="allwrap">
        <!--모바일 메뉴 S-->
			<tiles:insertAttribute name="header" />
		<!--모바일 메뉴 E-->
		<!--Head S-->
			<tiles:insertAttribute name="head" />
		<!--Head E-->		<div id="body">
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
                            <input type="hidden" name="searchBgnDe"  value="${repairBike.searchBgnDe}" />
                            <input type="hidden" name="searchEndDe"  value="${repairBike.searchEndDe}" />
                            <input type="hidden" name="pageNo" value="${repairBike.getCurrentPageNo() }"/>
                            <input type="hidden" name="division" value="${repairBike.division}"/>
                            <input type="hidden" name="repairSeq" value="${repairBike.repairSeq}"/>        
                            <input type="hidden" name="faultSeq" value="${repairBike.faultSeq}"/>      
                            <input type="hidden" name="repairCode" value=""/>
                            <input type="hidden" name="viewFlg" value="${repairBike.viewFlg}"/>
                            <input type="hidden" name="partsData" />
                            <input type="hidden" name="modifyPartsData" />
                            <input type="hidden" name="bikeReport" id="bikeReport" value=""/>
                            <input type="hidden" name="repairReport" id="repairReport" value=""/>
                            <input type="hidden" name="bikeStusCd" id="bikeStusCd" value="${repairBikeInfo.bikeStusCd}"/>
                            <input type="hidden" name="bikeStatusComCd" id="bikeStatusComCd" value="${repairBikeInfo.bikeStatusComCd}"/>
                            <!-- 20190201 양재영 추가 -->
                            <input type="hidden" name="adminId" id="adminId">
                            
                            
							<fieldset>
								<legend>자전거 등록 / 상세 / 수정</legend>
								<table class="tb_type02 mt20">
									<colgroup>
										<col style="width:25%"/>
										<col style="width:75%"/>
									</colgroup>
									<tbody>
										<tr>
											<th class="top"><em>*</em> 자전거 번호/ID</th>
											<td class="top">
												<span class="input-text08"><input type="text" name="bikeNo" readonly /></span>
												<span class="dash">/</span>
												<span class="input-text08"><input type="text" name="bikeId" style="width:40%" readonly /></span>
												<c:if test="${repairBikeInfo.bikeStatusName == null && repairBike.viewFlg == 'C'}">
												<a href="/common/pop/DEV_001/showFODevicePopDtlObs.do" class="winNewPop modal btnType02" title="자전거찾기" data-width="450" data-height="480"  data-pmt="&searchType=R">찾기</a>
												</c:if>
											</td>
										</tr>
										<tr>
											<th><em>*</em> 유지보수자</th>
											<td>
											<!-- 2019-02-01 이름으로 변경 양재영 -->
											<span class="input-text21">
											
											<c:if test="${repairBikeInfo.adminName != null}">
												"${repairBikeInfo.adminName}"
											</c:if>
											<c:if test="${repairBikeInfo.adminName == null}">
											<%= com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil.getSessionAttribute(request, "usrName") %>
											</c:if>
											
											</span>
						
											<!-- 
												<select disabled="disabled" class="select-category01" name="adminId" id="adminSlt">
													<option value="">선택</option>
												</select> -->
											</td>
										</tr>
										<c:if test="${repairBikeInfo.bikeStatusName != null}">
										<tr>
											<th> 장애구분</th>
											<td>
												<%-- ${repairBikeInfo.bikeStatusName} --%>
												<c:if test="${repairBikeInfo.repairCmptYn != 'Y'}"><select class="select-category01" id="comBikeStatusName" name="comBikeStatusName"></c:if>
												<c:if test="${repairBikeInfo.repairCmptYn == 'Y'}"><select class="select-category01" id="comBikeStatusName" name="comBikeStatusName"  disabled="disabled"></c:if>
														<option value="">선택</option>
												</select>
												</td>
										</tr>
										</c:if>
										<tr>
											<th><em>*</em> 수리구분</th>
											<td id="repairDivision">
											</td>
										</tr>
										<tr>
											<th><em>*</em> 상태</th>
											<td>
												<span class="input-rd01"><input type="radio" name="repairCmptYn" id="a3" value="N"><label for="a3">수리중</label></span>
												<span class="input-rd01"><input type="radio" name="repairCmptYn" id="ab3" value="Y"><label for="ab3">수리완료</label></span>
											</td>
										</tr>
										<tr>
											<th>배터리 교체일자</th>
											<td id="tdBatReplaceTime">
												<c:if test="${empty repairBikeInfo.batReplaceTime}">
													정보없음
												</c:if>	
												<c:if test="${repairBikeInfo.batReplaceTime ne ''}">
													${repairBikeInfo.batReplaceTime}
												</c:if>	
											</td>
										</tr>
										<tr>
											<th><c:if test="${repairBike.viewFlg == 'U'}"><em>*</em></c:if> 보관센터</th>
											<td>
												<select class="select-category01" name="centerId" id="centerSlt">
													<option value="">선택</option>
												</select>
												<p>(보관센터를 선택 하시면 장치의 위치가 해당 센터로 변경됩니다.)</p>
											</td>
										</tr>
										<tr>
											<th>정비내역</th>
											<td>
												<span class="input-text21"><input type="text" name="repairReportTxt" id="repairReportTxt" value="${repairBikeInfo.repairReport}"/></span>
											</td>
										</tr>
										<tr>
											<th>특이사항</th>
											<td>
												<span class="input-text21"><input type="text" name="bikeReportTxt" id="bikeReportTxt" value="${repairBikeInfo.bikeReport}"/></span>
											</td>
										</tr>
									</tbody>
								</table>
							
								<div class="btnArea">
									<span class="left"><button class="btnType01 bc_gray" id="moveRepairBikeList">목록</button></span>
									<span class="right">
										<c:if test="${repairBikeInfo.editRepairYn == 'Y' || repairBikeInfo.repairCmptYn != 'Y'}"><button type="button" class="btnType01 bc_green" id="exeRepairBikeEdit">저장</button></c:if>
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
	    	
	    	repairBikeInfo.mInit();
 	    	repairBikeInfo.init();
	   		repairBikeInfo.initBtn();
	   		repairBikeInfo.initCombo();
	   		var repairSeq = '${repairBikeInfo.repairSeq}' !== '' ? '${repairBikeInfo.repairSeq}' : '';
		    var bikeNo = '${repairBikeInfo.bikeNo}' !== '' ? '${repairBikeInfo.bikeNo}' : '${repairBike.bikeNo}';
		    var bikeId = '${repairBikeInfo.bikeId}' !== '' ? '${repairBikeInfo.bikeId}' : '${repairBike.bikeId}';
		    var repairCmptYn = '${repairBikeInfo.repairCmptYn}' !== '' ? '${repairBikeInfo.repairCmptYn}' : '';
			var repairCodeList = '${repairBikeInfo.repairCodeList}' !== '' ? '${repairBikeInfo.repairCodeList}' : '';
			
			// 2019-02-01추가
			var adminId = '<%= com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil.getSessionAttribute(request, "usrId") %>';
			$("[name='adminId']").val(adminId);
			
			
			$("[name='bikeNo']").val(bikeNo);
			$("[name='bikeId']").val(bikeId);
			$("[name='repairCmptYn']:input[value='"+repairCmptYn+"']").prop('checked', true);
			
			repairBikeInfo.checkNewRepair = 0;
	    	commonAjax.getCommonCode("REB", function(data){

	    		if(data !== null && data.codeList !== null) {
	           	 	for(var i = 0; i < data.codeList.length; i++){
	           		
	           	 		// 20210111 경정비 항목 추가
	           	 		if( "${repairBikeInfo.viewFlg}" == "R" ) {
	           	 			switch ( data.codeList[i].comCd ){
		           	 			case "REB_009" :	// 스탠드
		           	 			case "REB_018" :    // 물받이
		           	 			case "REB_024" :  	// 타이어 튜브
		           	 			case "REB_057" :  	// 배터리 교체
		           	 				$('<span class="pwtableblock input-ck02"><input type="checkbox" id="c'+i+'" value="'+data.codeList[i].comCd+'"/><label for="c'+i+'">'+data.codeList[i].comCdName+'</label></span>').appendTo('#repairDivision');
		           	 			break;	
	           	 			}
	           	 		} else {
		           	 		$('<span class="pwtableblock input-ck02"><input type="checkbox" id="c'+i+'" value="'+data.codeList[i].comCd+'"/><label for="c'+i+'">'+data.codeList[i].comCdName+'</label></span>').appendTo('#repairDivision');
	           	 		}
	           	 	}
	           	 	
	           	 	var repairCode = repairCodeList.replace(' ', '').replace('[', '').replace(']', '').split(',');
	           	 	
		 			for(var i=0; i < repairCode.length; i++) {
		 				
		 				if(repairCode[i].indexOf("INSPB") > -1 ){//2020.08.19 - 신규코드를 기존 페이지에선 보여주지 않기때문에
		 					
		 					if(repairBikeInfo.checkNewRepair == 0){
		 						$('<button type="button" onclick="moveNewMgmtPage(event)">신규 수리항목 보기</button>').appendTo('#repairDivision');
				           	 	repairBikeInfo.checkNewRepair = 1;
		 					}
		 					
		 				}else{
		 					
		 					if($("input[value='"+repairCode[i].replace(' ', '')+"']").length == 0 && repairBikeInfo.checkNewRepair == 0 ){
		 						$('<button type="button" onclick="moveNewMgmtPage(event)">신규 수리항목 보기</button>').appendTo('#repairDivision');
				           	 	repairBikeInfo.checkNewRepair = 1;
		 					} 
		 				
		     				$("input[value='"+repairCode[i].replace(' ', '')+"']").prop('checked', true);
		     			
		 				}
		     			
		     		}
		 			
	            }
	    		
	    	});
			
	    });
	    
	    var lineCnt = 0;
	    var repairBikeInfo = {};
	    repairBikeInfo.init = function(){
			
			//장애구분
		    commonAjax.getCommonCode("ERB", function(data) {
		         if(data !== null && data.codeList !== null) {
		        	 var code = new Array();
		             for(var i =0; i <data.codeList.length ;i++) {
		                 /* if(data.codeList[i].addVal1 === "SEASON" || data.codeList[i].addVal1 === "MDAY") { */
		                     code.push(data.codeList[i]);
		                 //}
		             }
		             commCdBox.makeComboBox('CC', '${repairBikeInfo.bikeStatusComCd}', code, "comBikeStatusName");
		         }
		     });
			
	    }
	    
	    var mInit = {};
	    
	  //2020-12-22 : 신규기능용(현장조치,입고처리 시 팝업(기존 관리자 페이지) 혹은 모달창(신규 모바일 화면) 에서 수리등록 시에 사용함. )
	    repairBikeInfo.mInit = function(){
    		
	    	if(!parent.opener || !parent.opener.bikeSearch || !parent.opener.bikeSearch.repairType){
	    	}else{
	    		mInit.bikeSearch = parent.opener.bikeSearch;
	    	}
	    	
    		if(!parent.bikeSearch || !parent.bikeSearch.repairType){
    		}else{
    			
    			mInit.bikeSearch = parent.bikeSearch;
    		}
    		
    		if(!mInit.bikeSearch){
    		}else{
    			 
	    		if(mInit.bikeSearch.repairType !== ""){
	    			
	    			// 20210111 
	    			if ( "${repairBike.viewFlg}" == 'R' ) {
	    				
	    					$(".menuArea").css("display","none");
	    					$(".leftmenu").css("display","none");
	    					$(".subject").css("margin-bottom","0");
	    					$(".cont").css('padding-top','0');
	    					$(".content").css('height','240px');
 
	    					$("#footer").css("display","none");
	    					
	    					$(".tb_type02 tbody tr").each(function(idx, item){
	    						
	    						if(idx > 2) $(item).css('display','none');
	    					})
	    					;  
	    			}
	    			else 
	    			{
			    			$(".tb_type01").css("display","none");
			    			$("#moveRepairBikeList").css("display","none");
	    				
			    			$(".tb_type02 tbody tr").each(function(idx, item){
								if(idx > 5 ) $(item).css('display','none');
							});   
	    			}
		    			
					if("onSiteAction" === mInit.bikeSearch.repairType){
						
						// 경정비 일경우 수리 완료 2021.08.31
						if ( "${repairBike.viewFlg}" == "R" ) {
							$("[name='repairCmptYn']:input[value='Y']").prop('checked', true);
						} else {
							$("[name='repairCmptYn']:input[value='N']").prop('checked', true);
						}
						
						
					}else if("bikeReceive" === mInit.bikeSearch.repairType){
						
						$("[name='repairCmptYn']:input[value='N']").prop('checked', true);
						$("#centerSlt").parent().parent().css('display','');
					}
					 
	    		}
	    		
    		}
	    }
 
	    repairBikeInfo.centerId = '${repairBikeInfo.centerId}' !== '' ? '${repairBikeInfo.centerId}' : '';
	    repairBikeInfo.adminId = '${repairBikeInfo.adminId}' !== '' ? '${repairBikeInfo.adminId}' : '';
	    
	    repairBikeInfo.initBtn = function(){
	    	var _this = repairBikeInfo;
	    	$("#moveRepairBikeList").on("click", this.moveRepairBikeList);
	    	$('#exeRepairBikeEdit').on("click", this.exeRepairBikeEdit);
	    	$('#moveNewMgmtPage').on("click",this.moveNewMgmtPage);
	    }
	    
	    repairBikeInfo.initCombo = function(){
	    	var _this = repairBikeInfo;
	    	
	    	commonAjax.getCenterCode( 
                function(data) {
                    if(data !== null && data.centerList !== null) {
                        commCdBox.makeComboBox('C', _this.centerId, data.centerList, "centerSlt");
                        $("#centerSlt").append("<option id='center_CEN311' value='CEN311'>천왕정비센터</option>");
                        var centerId = '${repairBikeInfo.centerId}' !== '' ? '${repairBikeInfo.centerId}' : '';
                        $("[name='centerId']").val(centerId);
                    }
                }
	        );
	    	 
	    }
	    
	    repairBikeInfo.moveRepairBikeList = function (e) {
	    	e.preventDefault();
	    	$('[name="repairCmptYn"]').val('${repairAp.repairCmptYn}');
	        $("#frm").attr({method :"post", action :"/repairBikeList.do"}).submit();
	    };
	    
	    repairBikeInfo.exeRepairBikeEdit = function (e) {
	    	
	    	e.preventDefault();
	    	
	    	if($('[name="bikeNo"]').val() == "" || $('[name="bikeNo"]').val() == undefined){
	    		alert('<spring:message code="fail.input.emptyValue2" arguments="자전거번호"/>');
	    		$('[name="bikeNo"]').focus();
	    		return;
	    	}
	    	if($('[name="bikeId"]').val() == "" || $('[name="bikeId"]').val() == undefined){
	    		alert('<spring:message code="fail.input.emptyValue2" arguments="자전거 ID"/>');
	    		$('[name="bikeId"]').focus();
	    		return;
	    	}
	    	if($('[name="adminId"]').val() == "" || $('[name="adminId"]').val() == undefined){
	    		alert('<spring:message code="fail.input.emptyValue2" arguments="유지보수자"/>');
	    		$('[name="adminId"]').focus();
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

	    	if($('[name="repairCmptYn"]:checked').val() == "" || $('[name="repairCmptYn"]:checked').val() == undefined){
	    		alert('<spring:message code="fail.input.emptyValue2" arguments="상태"/>');
	    		$('[name="repairCmptYn"]').focus();
	    		return;
	    	}
	    	
	    	if ( $('[name="viewFlg"]').val() != "R" ) {
      			var centerId = $('[name="centerId"]').val();
				
   				if(centerId == ''){
   					
   					alert("입고처리할 센터를 지정 해야합니다.");
   					return;
    			}
      		}
	    	
	    	
	    	$('[name="repairCode"]').val(repairCode);
	    	
    		$("#bikeReport").val($("#bikeReportTxt").val());
    		
    		$("#repairReport").val($("#repairReportTxt").val());
    		
    		
    		$('#exeRepairBikeEdit').attr('disabled', true);
	    	
      		
      		
      		switch ( $('[name="viewFlg"]').val() ) {
      		
      		case "U" :
      		
	    		var prevCenterId = '${repairBikeInfo.centerId}';
	    		var centerId = $('[name="centerId"]').val();
	    		if(centerId == '' && prevCenterId != centerId){
		    		alert('보관센터가 지정된 상태에서 미지정으로 변환할 수 없습니다.');
		    		$('#exeRepairBikeEdit').attr('disabled', false)
	    			return; 
	    		}
	    		
	    		commonAjax.postAjax("/updateRepairBikeAjax.do", 'json', $("#frm").serialize()
          			, function(data){
          	        	if(data.resultMessage == 'Success'){
          	        		prevCenterId = centerId;
          	        		alert('수정이 완료되었습니다.');
          	        		$('#exeRepairBikeEdit').attr('disabled', false);
          	        		$("#frm").attr({method :"post", action :"/moveRepairBikeEditForm.do"}).submit();
          	        	}else{
          	        		alert('오류가 발생하였습니다.');
          	        		$('#exeRepairBikeEdit').attr('disabled', false);
          	        	}
	              	}
	  	        );
	    		
	    	break;
	    	
      		case "C" :
      			
   				
      			
      		case "R" :
	    		
      			// 팝업 호출일경우 
	    		if(!mInit.bikeSearch){
	    		}else{
	    			
	    			if(mInit.bikeSearch.repairType === "bikeReceive"){
	    				
	    				var centerId = $('[name="centerId"]').val();
	    				
	    				if(centerId == ''){
	    					
	    					alert("입고처리할 센터를 지정 해야합니다.");
	    					$('#exeRepairBikeEdit').attr('disabled', false)
	    					return ;
	    				}
	    			}
	    		}
	    		
	    		commonAjax.postAjax("/insertRepairBikeAjax.do", 'json', $("#frm").serialize()
	    				
          			, function(data){
	    				
	    				if(data.checkRental != null && data.checkRental == "Fail"){
	    					
	    					alert("대여중인 자전거는 등록하실 수 없습니다.");
	    					$("#frm").attr({method :"post", action :"/repairBikeList.do"}).submit();
	    					
	    				}else if(data.checkOverLap != null && data.checkOverLap == "Fail"){
	    					
	    					alert("해당자전거는 이미 당일 수리완료 처리 되어있습니다.");
	    					$("#frm").attr({method :"post", action :"/repairBikeList.do"}).submit();
	    					
	    				}else{
	    				
	          	        	if(data.resultMessage == 'Success'){
		          	    		
		          	    		if(!mInit.bikeSearch){
		          	    			
	          	        			alert('등록이 완료되었습니다.');
		          	        		$('#exeRepairBikeEdit').attr('disabled', false);
		          	        		$("#frm").attr({method :"post", action :"/repairBikeList.do"}).submit();
		          	    				
		          	    		}else{
		          	    					          	    			
		          	    			mInit.bikeSearch.repairYn = "Y";
			          	    		alert("정상적으로 등록이 되었습니다.");
		          	    			self.close();
		          	    		}
	          	        		
	          	        	}else{
	          	        		alert('오류가 발생하였습니다.');
	          	        		$('#exeRepairBikeEdit').attr('disabled', false);
	          	        	}
	          	        	
	    				}
	              	}
	  	        );
	    	break;	
	    		
      		}
	    	
	    }
	    
	    
	    function setBikeId(bikeId, bikeNo, batReplaceTime) {
	    	$("[name='bikeId']").val(bikeId);
	    	$("[name='bikeNo']").val(bikeNo);
	    	
			if(batReplaceTime != '' && batReplaceTime !='null' && batReplaceTime != null){
				
				$("#tdBatReplaceTime").text(batReplaceTime);
				
			}else{
				
				$("#tdBatReplaceTime").text("정보없음");
				
			}
	    	
	    };
	    
	    function moveNewMgmtPage(e) {
	    	
	    	e.preventDefault();
	    	$("#frm").attr({method : 'post', action : '/moveRepairBikeEditMgmtForm.do'}).submit();
	    	
	    }
	    
	</script>
</body>
</html>