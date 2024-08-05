<script type="text/javascript">
	
	var workList = {};	   // 근무실적
	var dispatch = {};	  // 차량
       
    workList.wrkValidationCheck = function(){
    	
     	if( this.orgWorkVO ) {
    		
    		var workVO = this.orgWorkVO;
    		
    		if($("#dispchDiv [name='workTime']").val() == workVO.workTime && $("[name='dtlCd']").val() == workVO.dtlCd ){
    			
    			if($("#dispchDiv [name='dtlTime']").val() == "0" || !$("#dispchDiv [name='dtlTime']")) $("#dispchDiv [name='dtlTime']").val("0");
				
    			if($("#dispchDiv [name='dtlCd']") == 'WRK_001'){
    				
					if(workVO.etc != $("#dispchDiv [name='etc']").val() || workVO.dtlTime != $("#dispchDiv [name='dtlTime']").val() ){
						return true;
					}
					
				}else{
				
					if(workVO.dtlTime != $("#dispchDiv [name='dtlTime']").val() ){
						return true;
					}
					
				}
    		} 
/* 전일
    		if ( $("#dispchDiv :input:radio[name=workDiv]:checked").val() != workVO.workDiv ) {
    			return true;
    		} 
 */
    		if ( $("#dispchDiv [name='dtlTimeSt']").val() != workVO.dtlTimeSt ) {
    			return true;
    		} 

    		if ( $("#dispchDiv [name='etc']").val() != workVO.etc ) {
    			return true;
    		}
    		
    		
    		
    		// 근태 수기 입출고 수정사항
    		if ( $("#dispchDiv [name='moveBikeCnt']").val() != workVO.moveBikeCnt ) {
    			return true;
    		}
    		
    		if ( $("#dispchDiv [name='moveBikeCd']").val() != workVO.moveBikeCd ) {
    			return true;
    		}
    		
    		if ( $("#dispchDiv [name='moveEtc']").val() != workVO.moveEtc ) {
    			return true;
    		}
    		
    		if ( $("#dispchDiv [name='relocateBikeCnt']").val() != workVO.relocateBikeCnt ) {
    			return true;
    		}
    		
    		if ( $("#dispchDiv [name='relocateBikeCd']").val() != workVO.relocateBikeCd ) {
    			return true;
    		}
    		
    		if ( $("#dispchDiv [name='relocateEtc']").val() != workVO.relocateEtc ) {
    			return true;
    		}
    		 
    		return false;
    	} 
    }

	//순회정비 외 사유 선택박스 -> 출장,기타....
	$("#dispchDiv [name='dtlCd']").on("change",function(){var item = $(this).val();});
	//근무시간 선택박스
	$("#dispchDiv #timeSt").on("change",function(){
		
		var item = $(this).val();
	
		if(item == "4" || item == "8"){
			
			$("#dispchDiv #timeRd_"+item).prop("checked", true);
			
		}else $("#dispchDiv [name='timeRd']").prop("checked", false);
		
		$("#dispchDiv [name='workTime']").val(item);
		
	});
	
	$("#dispchDiv #dtlTimeSt").on("change",function(){//순회정비 외 시간 선택박스
		
		var item = $(this).val();
		
		$("#dispchDiv [name='dtlTime']").val(item);
		
	});
	
	$("#dispchDiv [name='timeRd']").click(function(){//근무시간 라디오박스
		var item = $(this).val();
		$("#dispchDiv [name='workTime']").val(item);
		$("#dispchDiv #timeSt").val(item);
		
	});
	
	// 20210824 추가
	$("#dispchDiv #vcleDate").on("change",function(){// 날짜 변경시
		dispatch.ajax ("mainVcle");
	});
	 
	
    $("#dispchDiv #btnWrkUpdate").click(function(){//근태입력 수정버튼
    	if(workList.wrkValidationCheck() != false) workList.ajax("updateWork");
    	else alert("변경사항이 없습니다.");
    })
    
    $("#dispchDiv #btnWrkSubmit").click(function(){//근태입력 저장버튼
		workList.ajax("insertWork");
    });//근태입력 저장버튼 E		    	
	
    
    workList.ajax = function(data){
    	
    	if(data == "mainWork"){//당일날 근태 입력 했다면 화면에 그 값을 보여줌.
    		
	    	$.ajax({
				url: "/distributionDiary/getMainWorkAjax.do",
				type: "post", 
				data : "adminId=${UserSessionVO.usrId}",
				success: function(data){
					
					var workVO = data.workVO;
					if(!workVO.workTime){
					}else{
						workList.orgWorkVO = data.workVO;
						$("#dispchDiv [name='workTime']").val(workVO.workTime);
						
						$("#dispchDiv [name='timeRd']").each(function(){
						
							if($(this).val() == workVO.workTime){
								
								$(this).prop("checked",true);
								
							}
							
						});
						/* 
						$("#dispchDiv [name='workDiv']").each(function(){
							
							if($(this).val() == workVO.workDiv){
								
								$(this).prop("checked",true);
								
							}
							
						});
						 */
						
						$("#dispchDiv [name='workSeq']").val(workVO.workSeq);
						$("#dispchDiv #timeSt").val(workVO.workTime);
						$("#dispchDiv [name='dtlCd']").val(workVO.dtlCd);
						$("#dispchDiv [name='dtlTime']").val(workVO.dtlTime == '' ? 0 : workVO.dtlTime);
						$("#dispchDiv #dtlTimeSt").val(workVO.dtlTime);
						$("#dispchDiv [name='etc']").val(workVO.etc);
						
						 
						$("#dispchDiv [name='relocateBikeCnt']").val(workVO.relocateBikeCnt);
						$("#dispchDiv [name='relocateBikeCd']").val(workVO.relocateBikeCd);
						$("#dispchDiv [name='relocateEtc']").val(workVO.relocateEtc);
						
						$("#dispchDiv [name='moveBikeCnt']").val(workVO.moveBikeCnt);
						$("#dispchDiv [name='moveBikeCd']").val(workVO.moveBikeCd);
						$("#dispchDiv [name='moveEtc']").val(workVO.moveEtc);
						
						setDisplay( "#dispchDiv #btnWrkUpdate" , "show");
						setDisplay( "#dispchDiv #btnWrkSubmit" , "hide");
					}	
				}, error : function(){
					alert("근태조회 실패"); 
				}
			});
    	
    	}else if(data == "getCd"){//근태 입력 순회정비 외 사유 selectbox 데이터 불러오기.
    		
    		commonAjax.getCommonCode("WRK",function(data){
    			
    			for(var i = 0; i<data.codeList.length;i++){
    				
    				var code = data.codeList[i];
    				var option = $("<option value='"+code.comCd+"'>"+code.comCdName+"</option>");    		
	    			$("#dispchDiv [name='dtlCd']").append(option); 
	    			
    			}
    			
    		});
    	
    	}else if(data.indexOf("insertWork") > -1 || data.indexOf("updateWork") > -1){
    		
    		var url;
    		if(data == "insertWork") url = "/distributionDiary/insertDistWorkAjax.do";
    		if(data == "updateWork") url = "/distributionDiary/updateDistWorkAjax.do";
    		
      		var dr = true;
        	var workSeq  = nvl( $("#dispchDiv [name='workSeq']").val(), "");
        	var workTime = nvl( $("#dispchDiv [name='workTime']").val() , "0");
        	var dtlCd   = nvl( $("#dispchDiv [name='dtlCd']").val(), "");
        	var dtlTime = nvl( $("#dispchDiv [name='dtlTime']").val() , "0" );
        	/* var workDiv =  nvl( $("#dispchDiv :input:radio[name=workDiv]:checked").val() , ""); */
 
        	var regExp = /^[0-9]*$/; 							// 정규식으로 추가 근무 시간 숫자 체크 처리
        	if(!regExp.test(dtlTime)) {
        		
        		alert("순회정비 외 시간에 숫자만 입력하세요.");
        		dr = false;
        		return true;
        	}
        	 
        	
        	var etc = $("#dispchDiv [name='etc']").val();
        	
        	if(workTime == '0' || workTime == '' || workTime == null || workTime.length == 0){ 
        		
        	    $("#dispchDiv [name='workTime']").focus();
        	    alert("근무시간을 입력하세요.");
        		dr = false;
        		return true;
        		
        	}
        	
        	if(Number(workTime)>8){		// 근무시간 8시간 초과 시 확인알림 창
        		
        		var result = confirm(workTime+"시간이 맞습니까?");
        		if(result == false) {
        			$("#dispchDiv #timeSt").focus();
        			return true;
        		}
        		
        	}
        	
        	if(Number(dtlTime) > Number(workTime)){
        		$("#dispchDiv #dtlTimeSt").focus();
        		alert("순회정비 외 시간이 근무시간을 초과하였습니다. \n"+workTime+"시간 보다 적게 입력하세요.");
        		dr = false;
        		return true;
        	}
        	/* 
        	if( workDiv == '' ){
        		
        		$("#dispchDiv #workDiv_1").focus();
        		alert("근무 구분을 선택하세요.(오전, 오후, 전일)");
        		dr = false;
        		return true;
        		
        	}
        	 */
        	if(dtlCd =='' && dtlTime != '0'){
        		
        		$("#dispchDiv [name='dtlCd']").focus();
        		alert("순회정비 외 업무를 선택하세요.");
        		dr = false;
        		return true;
        		
        	}else if(dtlCd == 'WRK_001' && etc == '' ){
        		
        		$("#dispchDiv [name='etc']").focus();
        		alert("기타 사유를 입력하세요.");
    	    	dr = false;
    	    	return true;
    	    	
    	    }else if(dtlCd != '' && dtlTime == '0'){
    	    	
        		$("#dispchDiv #dtlTimeSt").focus();
        		alert("순회정비 외 시간을 입력하세요.");
        		dr = false;
        		return true;
        		
        	}
        	
    		if(dr){//문제없을 때만 저장 처리
    			
    			var params = {};
    			params.adminId = '${UserSessionVO.usrId}';
    			params.workSeq = workSeq;
    			params.workTime = workTime;
    			params.dtlCd = dtlCd;
    			params.dtlTime = dtlTime;
    			/* params.workDiv = workDiv; */
    			params.etc = etc;
    			 
    			var succMsg;
    			if(data.indexOf("insertWork") > -1) succMsg = "등록되었습니다."
    			else if(data.indexOf("updateWork") > -1) succMsg = "수정되었습니다."	
    			
    			$.ajax({
    				type : "post",
    				url : url, 
    				data : params,
    				success : function(data){
    					
    					if( data.isSuccess == "1") {
	    					alert(succMsg);
	    					if(succMsg == "등록되었습니다.") window.location.reload();
	    					else{
	    						this.orgWorkVO;
	    					}
    					} else {
    						alert("저장에 실패하였습니다. 팀 지정이 되었는지 확인부탁드립니다.")
    					}
    					
    				},
    				error : function(data){
    					alert("실패했습니다.");
    				}
    			});
    		
    		}else{//문제있으니 아무것도 안함.
    			
    			alert("입력사항을 확인하세요.");
    		
    		}
    		
    	}
    	
    }
	
    dispatch.vcleInfoList = null;		// 자동차 최종 이동거리 세팅용
    
	$("#dispchDiv #btnDispchUpdate").click(function(){	dispatch.ajax("updateVcle");});
    $("#dispchDiv #btnDispchSubmit").click(function(){ dispatch.ajax("insertVcle");});
    
	dispatch.ajax = function(data){
		
		if(data == "mainVcle") {//당일날 차량 등록 했다면 화면에 그 값을 보여줌.
			
	    	
	    	var bgnDate = nvl( $("#dispchDiv #vcleDate").val(), "");
	    	
	    	$.ajax({
				url: "getMainDistVcleAjax.do",
				type: "post",
				async: false,
				// 조회조건
				data : "adminId="+ dispatch.adminId+"&SearchBgnDe=" + bgnDate ,
				success: function(data){
					
					var vcleVO = data.vcleVO;
					var vcleInfoList = data.vcleInfoList;
					dispatch.vcleInfoList = data.vcleInfoList;
					var swkCdList = data.swkCdList;
					
					// 조회 조건
					$("#dispchDiv #vcleDate").val( data.searchCarBgnDe );
					/*	TODO 
					if(vcleInfoList){
						for(var i =0; i< vcleInfoList.length; i++){
							if(vcleInfoList[i].useYn === "Y"){
								$("#dispchDiv #vcleNo").append("<option value='"+vcleInfoList[i].vcleNoSeq+"'>"+vcleInfoList[i].vcleNo+"</option>");
								$("#dispchDiv #vcleNo1").append("<option value='"+vcleInfoList[i].vcleNoSeq+"'>"+vcleInfoList[i].vcleNo+"</option>");
								$("#dispchDiv #vcleNo2").append("<option value='"+vcleInfoList[i].vcleNoSeq+"'>"+vcleInfoList[i].vcleNo+"</option>");
							}
						}
					}
					
					  */
					
					// 차량 근무시간 동적생성
					if ( $("#dispchDiv #startTime option").size()  < 2 ) {
						for( var i=1; i<25; i++ ){
					    	$("#dispchDiv #startTime").append("<option value='"+i+"'>"+i+"시</option>");
					    	$("#dispchDiv #startTime1").append("<option value='"+i+"'>"+i+"시</option>");
					    	$("#dispchDiv #startTime2").append("<option value='"+i+"'>"+i+"시</option>");
					    	$("#dispchDiv #endTime").append("<option value='"+i+"'>"+i+"시</option>");
					    	$("#dispchDiv #endTime1").append("<option value='"+i+"'>"+i+"시</option>");
					    	$("#dispchDiv #endTime2").append("<option value='"+i+"'>"+i+"시</option>");
						}
					}		
					
					if( vcleVO.vcleSeq != null && vcleVO.vcleSeq != 0 && vcleVO.vcleSeq != '') {
												
						dispatch.orgVcleVO = data.vcleVO;
						$("#dispchDiv [name='vcleSeq']").val(vcleVO.vcleSeq);
						$("#dispchDiv [name='vcleNo']").val(vcleVO.vcleNoSeq);
						$("#dispchDiv [name='vcleName']").val(vcleVO.vcleNo);
						
						/* if( vcleVO.vcleNo1 ) $("#dispchDiv [name='vcleNo1']").val(vcleVO.vcleNoSeq1);
						if( vcleVO.vcleNo2 ) $("#dispchDiv [name='vcleNo2']").val(vcleVO.vcleNoSeq2); */
						
						$("#dispchDiv [name='startTime']").val(vcleVO.startTime);
						/* if( vcleVO.startTime1 ) $("#dispchDiv [name='startTime1']").val(vcleVO.startTime1);
						if( vcleVO.startTime2 ) $("#dispchDiv [name='startTime2']").val(vcleVO.startTime2); */
						
						$("#dispchDiv [name='endTime']").val(vcleVO.endTime);
						/* if( vcleVO.endTime1 ) $("#dispchDiv [name='endTime1']").val(vcleVO.endTime1);
						if( vcleVO.endTime2 ) $("[name='endTime2']").val(vcleVO.endTime2); */
						
						$("#dispchDiv [name='bfMileage']").val(vcleVO.bfMileage);
						/* if( vcleVO.bfMileage1 ) $("#dispchDiv [name='bfMileage1']").val(vcleVO.bfMileage1);
						if( vcleVO.bfMileage2 ) $("#dispchDiv [name='bfMileage2']").val(vcleVO.bfMileage2); */
						
						$("#dispchDiv [name='afMileage']").val(vcleVO.afMileage);
						/* if( vcleVO.afMileage1 ) $("#dispchDiv [name='afMileage1']").val(vcleVO.afMileage1);
						if( vcleVO.afMileage2 ) $("#dispchDiv [name='afMileage2']").val(vcleVO.afMileage2); */
						
						$("#dispchDiv [name='driverType']").val(vcleVO.driverType);
						/* if( vcleVO.driverType1 ) $("#dispchDiv [name='driverType1']").val(vcleVO.driverType1);
						if( vcleVO.driverType2 ) $("#dispchDiv [name='driverType2']").val(vcleVO.driverType2); */

						// $("[name='refuel']").val(vcleVO.refuel);
						
						// $("[name='vcleStusCd']:input[value='"+vcleVO.vcleStusCd+"']").attr("checked",true);
						 
						/* 
						setDisplay( "#dispchDiv  #btnDispchUpdate" , "show");
						// setDisplay( "#chkVcleStusUpdate" , "show");
						setDisplay( "#dispchDiv  #btnDispchSubmit" , "hide");
						// 차량 등록 되었을 경우
						if( $("#dispchDiv  #vcleNo").val() ) {	setDisplay( "#dispchDiv  .vcleType1" , "show");
						} else {					setDisplay( "#dispchDiv  .vcleType1" , "hide");	setDisplay( "#dispchDiv  .vcleType2" , "hide");
						}
						if( $("#dispchDiv  #vcleNo1").val() ) { setDisplay( "#dispchDiv  .vcleType1" , "show");	setDisplay( "#dispchDiv  .vcleType2" , "show");
						} else {														setDisplay( "#dispchDiv  .vcleType2" , "hide");
						}
						
						if( $("#dispchDiv #vcleNo2").val() ) {										setDisplay( "#dispchDiv .vcleType2" , "show");			
						}
						 */
					} else {
						
						dispatch.orgVcleVO = null;
						$("#dispchDiv [name='vcleSeq']").val("");
						$("#dispchDiv [name='vcleNo']").val("");
						
						/* if( vcleVO.vcleNo1 ) $("#dispchDiv [name='vcleNo1']").val("");
						if( vcleVO.vcleNo2 ) $("#dispchDiv [name='vcleNo2']").val(""); */
						
						$("#dispchDiv [name='startTime']").val("");
						/* if( vcleVO.startTime1 ) $("#dispchDiv [name='startTime1']").val("");
						if( vcleVO.startTime2 ) $("#dispchDiv [name='startTime2']").val(""); */
						
						$("#dispchDiv [name='endTime']").val("");
						/* if( vcleVO.endTime1 ) $("#dispchDiv [name='endTime1']").val("");
						if( vcleVO.endTime2 ) $("[name='endTime2']").val(""); */
						
						$("#dispchDiv [name='bfMileage']").val("");
						/* if( vcleVO.bfMileage1 ) $("#dispchDiv [name='bfMileage1']").val("");
						if( vcleVO.bfMileage2 ) $("#dispchDiv [name='bfMileage2']").val(""); */
						
						$("#dispchDiv [name='afMileage']").val("");
						/* if( vcleVO.afMileage1 ) $("#dispchDiv [name='afMileage1']").val("");
						if( vcleVO.afMileage2 ) $("#dispchDiv [name='afMileage2']").val(""); */
						
						$("#dispchDiv [name='driverType']").val("");
						/* if( vcleVO.driverType1 ) $("#dispchDiv [name='driverType1']").val("");
						if( vcleVO.driverType2 ) $("#dispchDiv [name='driverType2']").val("");
 
						setDisplay( "#dispchDiv  #btnDispchUpdate" , "hide");
						// setDisplay( "#chkVcleStusUpdate" , "show");
						setDisplay( "#dispchDiv  #btnDispchSubmit" , "show");
						
						setDisplay( "#dispchDiv  .vcleType1" , "hide");
						setDisplay( "#dispchDiv  .vcleType2" , "hide"); */
					}
					
					
				}, error : function(){
					alert("순회정비원 차량조회 실패"); 
				}
			});
		
		} else if(data.indexOf("insertVcle") > -1 || data.indexOf("updateVcle") > -1){
	  		var form = $("#dispchDiv #dispchForm").serialize();
	  		var formSplit = form.split("&");
	    	var paramList = {
	    			vcleSeq		: null,
	    			vcleNo 		: null,		vcleNo1 	: null,		vcleNo2 	: null,
	    			startTime   : null,		startTime1  : null,		startTime2  : null,
	    			endTime     : null,		endTime1    : null,		endTime2    : null,
	    			driverType  : null,		driverType1 : null,		driverType2 : null,
	    			driverType  : null,		driverType1 : null,		driverType2 : null,
	    			bfMileage   : null,		bfMileage1  : null,		bfMileage2  : null,
	    			afMileage   : null,		afMileage1  : null,		afMileage2  : null,
	    			// refuel 		: null,		
	    			// vcleStusCd  : null,		
	    			adminId		: null, 	vcleDate    : null
	    		};
	    	
	  		for(var i in formSplit){
	  			var key = formSplit[i].split("=")[0];
	  			var value = formSplit[i].split("=")[1];
	  			if(value != ""){
	  				for(var paramKey in paramList ){
	  					if( key == paramKey ){
	  						
	  						console.log( key + " : " +  paramKey  + " : " + value )
	  						
	  						paramList[paramKey] = value;
	  					}
	  				}
	  			} 
	  		}
	  		
	  		// 삭제 구분자 추가
	  		paramList["delYN"]  = "";
	  		paramList["delYN1"] = "";
	  		paramList["delYN2"] = "";
	  		 
	  		if( !fn_save_befor_validate(paramList) ) return;
	    	
	    	$.ajax({
				type : "post",
				url  : "/insertDistVcleAjax.do",
				data : paramList,
				success : function(data){
					if (data.IS_SUCC) {
						alert("정상적으로 저장이 되었습니다.");
						dispatch.ajax("mainVcle");
					} else {
						alert("저장에 실패하였습니다.");
					}
					
				},
				error : function(data){
					alert("실패했습니다.");
				}
			});
			
		}
		
	}

	function fn_save_befor_validate(paramList) {
		 
		
		if( paramList.vcleNo != null && paramList.vcleNo !="" ) {
	    	
			if( !isValidation( "#dispchDiv #vcleNo"     , paramList.vcleNo    , "차량번호를 선택하세요."        , "null"   )) return false;
	    	if( !isValidation( "#dispchDiv #startTime"  , paramList.startTime , "운행시작 시간를 선택하세요."    , "null"   )) return false;
	    	if( !isValidation( "#dispchDiv #driverType" , paramList.driverType, "운행구분을 선택하세요."		   , "null"   )) return false;
	    	if( !isValidation( "#dispchDiv #bfMileage"  , paramList.bfMileage , "출고 값을 입력하세요."     	   , "null" )) return false;
	    	if( !isValidation( "#dispchDiv #bfMileage"  , paramList.bfMileage , "출고 값에 숫자만 입력하세요."   , "number" )) return false;
	    	if( !isValidation( "#dispchDiv #afMileage"  , paramList.afMileage , "입고 값에 숫자만 입력하세요."   , "number" )) return false;
  		} else {
  			
  			if( !isValidation( "#dispchDiv #vcleNo"     , paramList.vcleNo    , "차량번호를 선택하세요."        , "null"   )) return false;
  			
  		}
  		
    	if( paramList.vcleNo1 != null && paramList.vcleNo1 !="" ) {
    		if( !isValidation( "#dispchDiv #driverType1" , paramList.driverType1, "운행구분을 선택하세요."		 , "null"   )) return false;
    		if( !isValidation( "#dispchDiv #startTime1"  , paramList.startTime1 , "운행시작 시간를 선택하세요."    , "null"   )) return false;
	    	if( !isValidation( "#dispchDiv #bfMileage1"  , paramList.bfMileage1 , "출고 값을 입력하세요."     , "null"    )) return false;
	    	if( !isValidation( "#dispchDiv #afMileage1"  , paramList.afMileage1 , "출고 값에  숫자만 입력하세요."  , "number" )) return false;
    		if( !isValidation( "#dispchDiv #bfMileage1"  , paramList.bfMileage1 , "주행거리에 숫자만 입력하세요."  , "number" )) return false;
    	}
    	
    	if( paramList.vcleNo2 != null && paramList.vcleNo2 !="" ) {
    		if( !isValidation( "#dispchDiv #driverType2" , paramList.driverType1, "운행구분을 선택하세요."		 , "null"   )) return false;
    		if( !isValidation( "#dispchDiv #startTime2"  , paramList.startTime2 , "운행시작 시간를 선택하세요."    , "null"   )) return false;
    		if( !isValidation( "#dispchDiv #bfMileage2"  , paramList.bfMileage2 , "출고 값에 값을 입력하세요."     , "null" )) return false;
	    	if( !isValidation( "#dispchDiv #bfMileage2"  , paramList.bfMileage2 , "출고 값에  숫자만 입력하세요."  , "number" )) return false;
	    	if( !isValidation( "#dispchDiv #afMileage2"  , paramList.afMileage2 , "입고 값에 숫자만 입력하세요."  , "number" )) return false;
    	}
    	// 차량번호 중복 체크
    	if( paramList.vcleNo == paramList.vcleNo1  && ( paramList.vcleNo1 != null && paramList.vcleNo1 != "" ) ) {
    		alert("첫번째 차량과 두번째 차량번호가 중복되었습니다.");   	$('#dispchDiv #vcleNo1').focus();	return false;
    	}
    	
    	if( paramList.vcleNo == paramList.vcleNo2  && ( paramList.vcleNo2!= null && paramList.vcleNo2 != "" ) ) {
    		alert("첫번째 차량과 세번째 차량번호가 중복되었습니다.");	$('#dispchDiv #vcleNo2').focus(); 	return false;
    	}
    	
    	if( paramList.vcleNo1 == paramList.vcleNo2 && ( paramList.vcleNo1 != null && paramList.vcleNo1 != "" ) ) {
    		alert("두번째 차량과 세번째 차량번호가 중복되었습니다." +  paramList.vcleNo1 + " : " + paramList.vcleNo2 );  	$('#dispchDiv #vcleNo2').focus();	return false;
    	}
    	
    	// 운행거리 채크
    	if( parseInt( paramList.bfMileage  ) > parseInt( paramList.afMileage ) ) {
    		alert("출고 값이 입고 값보다 클수는 없습니다. " );   	$('#dispchDiv #afMileage').focus();	return false;
    	}
    	
    	if( parseInt( paramList.bfMileage1  ) > parseInt( paramList.afMileage1 ) ) {
    		alert("출고 값이 입고 값보다 클수는 없습니다. " );   	$('#dispchDiv #afMileage1').focus();	return false;
    	}
    	
    	if( parseInt( paramList.bfMileage2  ) > parseInt( paramList.afMileage2 ) ) {
    		alert("출고 값이 입고 값보다 클수는 없습니다. " );   	$('#dispchDiv #afMileage2').focus();	return false;
    	}
    	
    	// 차량시간 체크
    	if( parseInt( paramList.startTime  ) <= 15 && parseInt( paramList.startTime  ) > parseInt( paramList.endTime ) ) {
    		alert("시작 시간이 종료시간보다 클수는 없습니다. " );   	$('#dispchDiv #endTime').focus();	return false;
    	}
    	
    	if( parseInt( paramList.startTime1  ) <= 15 && parseInt( paramList.startTime1 ) > parseInt( paramList.endTime1 ) && ( parseInt( paramList.startTime1 ) != null && parseInt( paramList.startTime1 ) > 0 ) ) {
    		alert("시작 시간이 종료시간보다 클수는 없습니다. ");   	$('#dispchDiv #endTime1').focus();	return false;
    	}
    	
    	if( parseInt( paramList.startTime2  ) <= 15 && parseInt( paramList.startTime2 ) > parseInt( paramList.endTime2 ) && ( parseInt( paramList.startTime2 ) != null && parseInt( paramList.startTime2 ) > 0 ) ) {
    		alert("시작 시간이 종료시간보다 클수는 없습니다. ");   	$('#dispchDiv #endTime2').focus();	return false;
    	}
    	
    	if( parseInt( paramList.startTime  ) > parseInt( paramList.startTime1 ) && ( parseInt( paramList.startTime1 ) != null && parseInt( paramList.startTime1 ) > 0 ) ) {
    		alert("첫번째 차량 시작 시간이 두번째 차량 시작 시간보다 클수는 없습니다.");   	$('#dispchDiv #startTime1').focus();	return false;
    	}
    	
    	if( parseInt( paramList.startTime  ) > parseInt( paramList.startTime2 ) ) {
    		alert("첫번째 차량 시작 시간이 세번째 차량 시작 시간보다 클수는 없습니다.");   	$('#dispchDiv #startTime2').focus();	return false;
    	}
    	
    	if( parseInt( paramList.endTime  ) > parseInt( paramList.startTime1 ) ) {
    		alert("첫번째 종료 시작 시간이 두번째 차량 시작 시간보다 크거나 같을 수 없습니다.");   	$('#dispchDiv #startTime1').focus();	return false;
    	}
    	
    	if( parseInt( paramList.endTime  ) > parseInt( paramList.startTime2 ) && ( parseInt( paramList.startTime1 ) != null && parseInt( paramList.startTime1 ) > 0 ) ) {
    		alert("첫번째 종료 시간이 세번째 차량 시작 시간보다 크거나 같을 수 없습니다.");   	$('#dispchDiv #startTime2').focus();	return false;
    	}
    	
    	if( parseInt( paramList.startTime1 ) > parseInt( paramList.startTime2 ) && ( parseInt( paramList.startTime1 ) != null && parseInt( paramList.startTime1 ) > 0 ) ) {
    		alert("두번째 차량 시작 시간이 세번째 차량 시작 시간보다 클수는 없습니다.");   	$('#startTime2').focus();	return false;
    	}
    	
    	if( parseInt( paramList.endTime1 ) > parseInt( paramList.startTime2 ) && ( parseInt( paramList.endTime1 ) != null && parseInt( paramList.endTime1 ) > 0 ) ) {
    		alert("두번째 차량 종료 시간이 세번째 차량 시작 시간보다 크거나 같을 수는 없습니다.");   	$('#dispchDiv #startTime2').focus();	return false;
    	}
    	
    	return true;
	}
	
/* 
	$("#dispchForm #vcleNo").on( "change", function() {
		if( $(this).val() != '' ) {
			for(var i =0; i< dispatch.vcleInfoList.length; i++){
				if(dispatch.vcleInfoList[i].vcleNoSeq ===  $(this).val() ){
					$("#dispchDiv [name='bfMileage']").val( dispatch.vcleInfoList[i].afMileage );
				}
			}
		}
	});
	
	$("#dispchForm #vcleNo1").on( "change", function() {
		if( $(this).val() != '' ) {
			for(var i =0; i< dispatch.vcleInfoList.length; i++){
				if(dispatch.vcleInfoList[i].vcleNoSeq ===  $(this).val() ){
					$("#dispchDiv [name='bfMileage1']").val( dispatch.vcleInfoList[i].afMileage );
				}
			}
		}
	});
 
	$("#dispchForm #vcleNo2").on( "change", function() {
		if( $(this).val() != '' ) {
			for(var i =0; i< dispatch.vcleInfoList.length; i++){
				if(dispatch.vcleInfoList[i].vcleNoSeq ===  $(this).val() ){
					$("#dispchDiv [name='bfMileage2']").val( dispatch.vcleInfoList[i].afMileage );
				}
			}
		}
	}); */

	$(function() {    //화면 다 뜨면 시작
	    $("#vcleName").autocomplete({
	        source : function( request, response ) {
	             $.ajax({
	                    type: 'post',
	                    url: "getMainDistVcleAjaxCode.do",
	                    dataType: "json",
	                    data : "vcleNo=" +  $("#vcleName").val() ,
	                    success: function(data) {
	                        //서버에서 json 데이터 response 후 목록에 추가
	                        response(
	                            $.map(  data.vcleInfoList , function(item) {    //json[i] 번째 에 있는게 item 임.
	                            	return {
	                                    label: item.vcleNo + " / " + item.vcleType,    //UI 에서 보여지는 글자, 실제 검색어랑 비교 대상
	                                    value: item.vcleNo,    // 선택값
	                                    vcleNoSeq : item.vcleNoSeq,
	                                    afMileage : item.afMileage
	                                    		
	                                }
	                            })
	                        );
	                    }
	               });
	            },    // source 는 자동 완성 대상
	        select : function(event, ui) {    //아이템 선택시
	            console.log("select");
	        	console.log(ui);//사용자가 오토컴플릿이 만들어준 목록에서 선택을 하면 반환되는 객체
	        	$("#dispchDiv [name='vcleSeq']").val(ui.item.vcleNoSeq);
	        	$("#dispchDiv [name='vcleNo']").val(ui.item.vcleNoSeq);
	        	$("#dispchDiv [name='bfMileage']").val(ui.item.afMileage);
	            
	        },
	        focus : function(event, ui) {    //포커스 가면
	            return false;//한글 에러 잡기용도로 사용됨
	        },
	        minLength: 1,// 최소 글자수
	        autoFocus: true, //첫번째 항목 자동 포커스 기본값 false
	        classes: {    //잘 모르겠음
	            "ui-autocomplete": "highlight"
	        },
	        delay: 500,    //검색창에 글자 써지고 나서 autocomplete 창 뜰 때 까지 딜레이 시간(ms)
//	        disabled: true, //자동완성 기능 끄기
	        position: { my : "right top", at: "right bottom" },    //잘 모르겠음
	        close : function(event ){    //자동완성창 닫아질때 호출
	        
	            // $("#dispchDiv [name='vcleSeq']").val(ui.item.vcleNoSeq);
				// $("#dispchDiv [name='vcleNo']").val(ui.item.vcleNoSeq);	        
	        
	        }
	    });
	}); 
	
	
</script>
