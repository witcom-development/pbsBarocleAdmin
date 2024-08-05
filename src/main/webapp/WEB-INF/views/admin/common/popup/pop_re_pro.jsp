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
<script src="/js/select/jquery.styled-select-box_main.js"></script>
<link href="/css/jquery-ui.css" rel="stylesheet" type="text/css" />
<%@ include file="../popup/pop_resource.jsp" %>

<!-- 강제반납 popup -->
<script type="text/javascript">
if('${resultMessage}' !== "") {
	alert('${resultMessage}');
	window.close();
}
</script>
</head>
<body>
    <h1 class="popTt"></h1>
    <div class="cntbox">
        <%-- <form id="frm">
            <input type="hidden" name="rentSeq"    value="${ info.rentSeq }">
            <input type="hidden" name="useMi" value="">
            <input type="hidden" name="voucherSeq" value="${ info.voucherSeq }">
            <input type="hidden" name="rendClsCd"  value="${ info.rentClsCd }">
            <input type="hidden" name="usrSeq"     value="${ info.userSeq }">
            <input type="hidden" name="adminId"     value="${ adminId}">
            <input type="hidden" name="enfrcReturnStationId"     value="">
            <input type="hidden" name="deviceCnncCd"     value="">
            <input type="hidden" name="enfrcReturnCd"     value="">
            <input type="hidden" name="photoYn"     value="">
            <input type="hidden" name="emrgncyYn"     value="">
            <input type="hidden" name="parkingLocation"     value="">
            <input type="hidden" name="parkingLocationYn"     value="">
            <input type="hidden" name="latitude"     value="">
            <input type="hidden" name="longitude"     value="">
            
            
        </form> --%>
        <div class="allwrap pop">
        	<div style="float: right; font-size:12px;">
        		<input type="checkbox" id="f1" style="vertical-align: middle;">분실신고
        	</div>
            <table class="tb_type02 mt20">
                <colgroup>
                    <col style="width:25%">
                    <col style="width:75%">
                </colgroup>
                <tbody>
                    <tr>
                        <th class="top">자전거 번호</th>
                        <td class="top">${info.rentBikeNo}</td>
                    </tr>
                    <%-- <tr>
                        <th>처리자명</th>
                        <td>${adminId}</td>
                    </tr> --%>
                    <tr>
                        <th>대여시간(분)</th>
                        <td><span class="input-text04"><input id="elapseTime" type="text"  value="${info.elapseTime}"/></span></td>
                    </tr>
                     <tr>
                        <th>대여소/<br>임의장소</th>
                        <td>
                        	<span class="input-rd01"><input type="radio" id="e1" name="radioChkType4" value="1"  checked="checked"><label for="b1">대여소 선택</label></span>
	        				<script>$("select").styledSelect();</script>
					        <!-- <fieldset class="fld_sch">
					        <legend class="screen_out">검색어를 입력하세요</legend> -->
					            <!-- <div class="box_search">    -->                 
					                <span class="input-text13"><input type="text" id="searchValue" value="" name="searchValue" title="검색어 입력" placeholder="검색어를 입력하세요"></span>
					            <!-- </div>
					        </fieldset> -->
	        				<input type="hidden" name="searchType" id="searchType">
	        				<br/><br/>
	        				<span class="input-rd01"><input type="radio" id="e2" name="radioChkType4" value="2" ><label for="b2">임의 장소</label></span>
	        				<button class="btnType02" onclick="goMapAddr();" type="button">지도보기</button>
	        				
                        	<br/>
                        	주&nbsp;소 : <span class="input-text07"><input type="text" style="width: 70%;" id="addr" value="" name="addr_tmp" title="주소 입력" placeholder="" readonly="readonly"></span>
                        	<br/>
                        	상&nbsp;세 : <span class="input-text13"><input id="parkingLocationDiv" style="width: 70%;" name="parkingLocationDiv" type="text"  value="" readonly="readonly" /></span>
                        	<br>
                        		<span class="input-text07"><input type="text" style="display:none;" id="latitude" value="" name="latitude_tmp" title="위도 입력" placeholder=""></span>
                        		<span class="input-text07"><input type="text" style="display:none;" id="longitude" value="" name="longitude_tmp" title="경도 입력" placeholder=""></span>
	        				
                    	</td>
                    </tr>
                    <tr>
                        <th>선택 배정팀</th>
                        <td><input type="text" id="teamName" readonly="readonly"></td>
                    </tr>
                    
                    
                    <!-- <tr>
                        <th>반납대여소</th>
                        <td><span class="input-text04" id="enfrcReturnStationIdDiv"></span></td>
                    </tr> -->
                   
                    
                    <tr>
                        <th>미반납 사유</th>
                        <td>
                        	<!-- <span class="input-rd01"><input type="radio" id="b1" name="radioChkType2" value="1" ><label for="b1">통신장애</label></span>
							<span class="input-rd01"><input type="radio" id="b2" name="radioChkType2" value="2" ><label for="b2">자가잠금 미해재</label></span>
							<span class="input-rd01"><input type="radio" id="b3" name="radioChkType2" value="3" ><label for="b3">자가잠금 운행</label></span>
							<span class="input-rd01"><input type="radio" id="b4" name="radioChkType2" value="4" ><label for="b4">교차잠금</label></span>
							<span class="input-rd01"><input type="radio" id="b5" name="radioChkType2" value="5" ><label for="b5">기타</label></span> -->
							<c:forEach items="${codeList}" var="code" varStatus="status">
							<c:if test="${status.count ==1}">
							<span class="input-rd01"><input type="radio" id="b${status.count}" name="radioChkType2" value="${code.comCd}" checked="checked"><label for="b${status.count}">${code.comCdName}</label></span>
							</c:if>
							<c:if test="${status.count !=1}">
							<br/><span class="input-rd01"><input type="radio" id="b${status.count}" name="radioChkType2" value="${code.comCd}" ><label for="b${status.count}">${code.comCdName}</label></span>
							</c:if>
							</c:forEach>
							<br/>
							<span class="input-text13">메모 : <input id="enfrcReturnDescDiv" name="enfrcReturnDescDiv" type="text"  value=""/></span>
						</td>
                    </tr>
                    
                    <tr>
                        <th>잠금장치 연결</th>
                        <td>
                        	<span class="input-rd01"><input type="radio" id="a1" name="radioChkType1" value="1" checked="checked"><label for="a1">예</label></span>
							<span class="input-rd01"><input type="radio" id="a2" name="radioChkType1" value="2" ><label for="a2">아니오</label></span>
							<span class="input-rd01"><input type="radio" id="a3" name="radioChkType1" value="3" ><label for="a3">불확실</label></span>
							<span class="input-ck01"><input type="checkbox" id="d1"><label for="d1">긴급</label></span>
						</td>
                    </tr>
                    <!-- <tr>
                        <th>임의장소/<br>기타사유<br>(1.장소,2.시간, 3.상태)</th>
                        <td>
                        	<span class="pwtableblock input-ck02"><input type="checkbox" id="e1"><label for="e1">임의장소 반납</label></span>
                        	<span class="input-text04"><input id="parkingLocationDiv" name="parkingLocationDiv" type="text"  value=""/></span>
                        </td>
                    </tr> -->
                    <!-- <tr>
                        <th>GPS 좌표</th>
                        <td>
                        	주&nbsp;&nbsp;&nbsp;소 : <span class="input-text07"><input type="text" style="width: 70%;" id="addr" value="" name="addr_tmp" title="주소 입력" placeholder=""></span>
                        	<br>
                        	위경도 : <span class="input-text07"><input type="text" style="width: 32%;" id="latitude" value="" name="latitude_tmp" title="위도 입력" placeholder=""></span>
                        		  <span class="input-text07"><input type="text" style="width: 32%;" id="longitude" value="" name="longitude_tmp" title="경도 입력" placeholder=""></span>
                        	<br>
                        	<button class="btnType02" onclick="goMapAddr();" type="button">지도보기</button>
                        </td>
                    </tr> -->
                    <tr>
                        <th>사진 첨부</th>
                        <td>
                        	<span class="input-rd01"><input type="radio" id="c1" name="radioChkType3" value="Y" ><label for="c1">유</label></span>
							<span class="input-rd01"><input type="radio" id="c2" name="radioChkType3" value="N" checked="checked"><label for="c2">무</label></span>
							<br><br><!-- 파일업로드 준비중입니다. -->
							
							<form id="frm"  name="frm" enctype="multipart/form-data" method="POST">
					            <input type="hidden" name="rentSeq"    value="${ info.rentSeq }">
					            <input type="hidden" name="useMi" value="">
					            <input type="hidden" name="voucherSeq" value="${ info.voucherSeq }">
					            <input type="hidden" name="rendClsCd"  value="${ info.rentClsCd }">
					            <input type="hidden" name="usrSeq"     value="${ info.userSeq }">
					            <input type="hidden" name="adminId"     value="${ adminId}">
					            <input type="hidden" name="enfrcReturnStationId"     value="">
					            <input type="hidden" name="deviceCnncCd"     value="">
					            <input type="hidden" name="enfrcReturnCd"     value="">
					            <input type="hidden" name="photoYn"     value="">
					            <input type="hidden" name="emrgncyYn"     value="">
					            <input type="hidden" name="parkingLocation"     value="">
					            <input type="hidden" name="parkingLocationYn"     value="">
					            <input type="hidden" name="latitude"     value="">
					            <input type="hidden" name="longitude"     value="">
					            
					            <input type="hidden" name="enfrcReturnDesc"     value="">
					            <input type="hidden" name="addr"     value="">
					            <input type="hidden" name="enfrcGubunCd"     value="0">
					            
					            <input type="hidden" name="lostBikeYn"     value="N">
					            
					            
					            
					      
							<span>
								<input type="file" id="enfrcFile" name="enfrcFile" style="width: 250px"/>
								<input type="hidden" name="enfrcFileNoList" value="0"/>
								<input type='hidden' name='enfrcFileStateList' value='I'/>
							</span>
							<span>
								<input type="file" id="enfrcFile" name="enfrcFile" style="width: 250px"/>
								<input type="hidden" name="enfrcFileNoList" value="1"/>
								<input type='hidden' name='enfrcFileStateList' value='I'/>
							</span>
							<span>
								<input type="file" id="enfrcFile" name="enfrcFile" style="width: 250px"/>
								<input type="hidden" name="enfrcFileNoList" value="2"/>
								<input type='hidden' name='enfrcFileStateList' value='I'/>
							</span>
							  </form> 
						</td>
                    </tr>
                    <!-- <tr>
                        <td colspan="2" style="border: 0px;"><p style="font-weight: bold;">(주의:강제 반납 이후 해당 자전거를 확인하시고 관리자 설치를 진행해주세요. 그 전까지 해당 자전거는 대여 불가능 합니다.)</p></td>
                    </tr>
                    <tr>
                        <td colspan="2" style="border: 0px;"><p style="font-weight: bold;">
                        	<span class="pwtableblock input-ck01"><input type="checkbox" id="d1"><label for="d1">긴급 처리 요청 </label></span>
               			</p></td>
                    </tr> -->
                </tbody>
            </table>
            <div class="btnArea">
                <span class="right">
	                <button class="btnType01" id="impulseReturnBtn">저장</button>
	                <button class="btnType01" id="cancelBtn">취소</button>
                </span>
            </div>
        </div>
    </div>
    <a href="#" class="popclose"><img src="/images/btn_close.png" alt="팝업닫기" /></a>
    <script type="text/javascript" src="/js/common_barocle.js"></script>
    <script type="text/javascript">
    var autocompleteStationName = new Array();
    $(function() {
    	 var rentSta = {};
    	    var $this = rentSta;
    	    rentSta.rentStationGrpSeq = '';
    	    rentSta.rentStationId = '';	
    	$("#cancelBtn").on("click", function(e){
    		closePop();
    	});
    	$("#impulseReturnBtn").on("click", exeImpulseBikeReturn);
    	$("#searchValue").on("click" , searhText);
    	
    	
    	
    	commonAjax.getAjax("/common/pop/findStationAllInfo.do", "json", $("#frm").serialize()
                ,function(data){
    		
    		           if(data != null && data.stationList != null) {
    					for( var i in data.stationList ) {
    						
    						var stationName = data.stationList[i].stationName;
    						
    						if(stationName.indexOf("3거리") > -1){
    							stationName = stationName.replace("3거리","삼거리");
    							
    						}
    						if(stationName.indexOf("4거리") > -1){
    							stationName = stationName.replace("4거리","사거리");
    						}
    						
             				autocompleteStationName.push(
             						{
             							label : stationName,
             							stationId : data.stationList[i].stationId,
             							teamNm : data.stationList[i].teamNm
             						}
             				);
             				
             			}
                     }          
                 }
            );   
    	
    	$('input[name="radioChkType1"]').change(function() {
    		$('input[name="radioChkType1"]').each(function() {
    			var value = $(this).val();
    			var checked = $(this).prop('checked');
    			if(checked){
    				//alert(value);
    				if(value=="1")
    					$("#d1").prop('checked', false);
    				if(value=="2" || value=="3")
    					$("#d1").prop('checked', true);
    			}
    		});
    	});
    	
    	$('input[name="radioChkType4"]').change(function() {
    		$('input[name="radioChkType4"]').each(function() {
    			var value = $(this).val();
    			var checked = $(this).prop('checked');
    			if(checked){
    				$("#teamName").val('');
    				//alert(value);
    				if(value=="1"){
    					$("#parkingLocationDiv").val('');
    					$("#addr").val('');
    					$("#latitude").val('');
    					$("#longitude").val('');
    				}
    				if(value=="2"){
    					$("#searchValue").val('');
    					$('input[name="enfrcReturnStationId"]').val("");
    				}
    			}
    		});
    	});
    	
    	$('#enfrcFile').change(function() {
    		$("#c1").prop("checked", true);
    	});
    	
    	/* commonAjax.getCommonCode("DAL", function(data) {
            if(data !== null && data.codeList !== null) {
                commCdBox.makeComboBox('CC','',data.codeList, "partSlt");
            }
       	}); */
    	
    });
   
    function exeImpulseBikeReturn() {
    	var radioChkType1 = $(':radio[name="radioChkType1"]:checked').val();
    	var radioChkType2 = $(':radio[name="radioChkType2"]:checked').val();
    	var radioChkType3 = $(':radio[name="radioChkType3"]:checked').val();
    	var radioChkType4 = $(':radio[name="radioChkType4"]:checked').val();
    	var parkingLocation = $("#parkingLocationDiv").val();
    	$("input:hidden[name='deviceCnncCd']").val(radioChkType1);
    	$("input:hidden[name='enfrcReturnCd']").val(radioChkType2);
    	$("input:hidden[name='photoYn']").val(radioChkType3);
    	$("input:hidden[name='parkingLocation']").val(parkingLocation);
    	var emrgncyYn = $("input:checkbox[id='d1']").is(":checked");
    	var parkingLocYn = $("input:radio[id='e1']").is(":checked");
    	
    	$("input:hidden[name='latitude']").val($('#latitude').val());
    	$("input:hidden[name='longitude']").val($('#longitude').val());
    	
    	$("input:hidden[name='enfrcReturnDesc']").val($('#enfrcReturnDescDiv').val());
    	$("input:hidden[name='addr']").val($('#addr').val());
    	
    	if(emrgncyYn)
		{
			$("input[name='emrgncyYn']").val('Y');
		}else{
			$("input[name='emrgncyYn']").val('N');
		}
    	if(!parkingLocYn)
		{
			$("input[name='parkingLocationYn']").val('Y');
		}else{
			$("input[name='parkingLocationYn']").val('N');
		}
    	
    	if($("#elapseTime").val() === '') {
    		alert("대여시간을 입력해 주세요.");
    		return;
    	}
    	/* if($("input:hidden[name='enfrcReturnStationId']").val()=== '' && parkingLocation ==='' && radioChkType2 != 'NRR_006') {
    		alert("강제반납 인근 정거장을 선택해 주시거나 임의장소를 입력해주세요.");
    		return;
    	} */
    	$("[name='useMi']").val($("#elapseTime").val() );
    	/* commonAjax.getAjax("/common/pop/exeImpulseBikeReturn.do", "json", $("#frm").serialize()
            ,function(data){
                 if(data) {
                     alert(data.resultMessage);
                     if(data.checkResult > 0) {
                    	closePop();
                     } 
                 }          
             }
        ); */
        
        
 		var lostBikeChk = $("#f1").is(':checked');
 		if(lostBikeChk){
			$("input[name='lostBikeYn']").val('Y');
		} else {
			$("input[name='lostBikeYn']").val('N');
		}
        
        
        var fileCnt = 0;
        $("input[name=enfrcFileStateList]").each(function(idx){
        	var value = $(this).val();
        	var eqValue = $("input[name=enfrcFile]:eq(" + idx + ")").val() ;
        	//alert((value + ":" + eqValue));
        	if(eqValue != '')
        		fileCnt++;
        });
        
        //alert("fileCnt : " + fileCnt);

        if(radioChkType3 == "Y" && fileCnt == 0){
        	alert("사진첨부 유무를 확인해주세요.");
        	return false;
        }else if(radioChkType3 == "N" && fileCnt != 0){
        	alert("사진첨부 유무를 확인해주세요.");
            return false;
        }
        
        
        if(radioChkType4=="1"){
			if($("input:hidden[name='enfrcReturnStationId']").val()===''){
				alert("대여소를 선택해주세요. ");
				return false;
				
			}else{//2020-11-24 : 임시폐쇄 대여소 체크
				
				var confirmYn = true;
				commonAjax.postAjax("/admin/manage/station/stationInfoAjax.do", "json", {station_id:$("input:hidden[name='enfrcReturnStationId']").val()}
			            ,function(data){
			            	
			                 if(data && data.CHECK_RESULT == true ) {
			                	 
			                    if(data.info.station_use_yn == "T"){
			                    	
			                    	confirmYn = confirm("이 대여소는 임시폐쇄 상태입니다.\r그래도 저장하시겠습니까?");
			                    	
			                    	
			                    }
			                    
			                 }
			                 
			    		});
				
				if(!confirmYn) return false;
				
			}	
  		} else if(radioChkType4=="2"){
			if($("input:hidden[name='addr']").val()==='' || $("input:hidden[name='latitude']").val()==='' || $("input:hidden[name='longitude']").val()===''){
				alert("임의장소 선택 시 지도보기로 주소를 선택해주세요. ");
				return false;
			}	
  		}
       $("#frm").attr({action: '/common/pop/exeImpulseBikeReturn.do'}).submit();
        
    }
    function closePop() {
    	window.close();
    }
    
    function searhText(){
			
		$("#searchValue").autocomplete({
        	 source : autocompleteStationName 
        	,matchContains: true
	        ,selectFirst: false
	        ,minLength: 2
	        ,autoFocus:true
	        
	        , select : function(e, ui, data ){
	        	  // 2019.02.20 추가
	        	 //alert('1'); 
	        	$("input:hidden[name='enfrcReturnStationId']").val(ui.item.stationId);
	     		//$("#enfrcReturnStationIdDiv").html(ui.item.label);
	        	$("#teamName").val(ui.item.teamNm);
	        	$("#e1").prop("checked",true);
	        	$("#addr").val("");
	        	$("#parkingLocationDiv").val("");
	        	
	        }
	    });
    }
    
function goMapAddr(){
		
		
		/* if(!$("#station_latitude").val() && !$("#station_longitude").val()){
			alert('<spring:message code="fail.input.emptyValue2" arguments="위경도"/>');
			return;
		} */
		var pwidth = 600;
		var pheight = 680;
		var winL = (screen.width-pwidth)/2;
		var winT = (screen.height-pheight)/2;
		//var lat = $("#station_latitude").val();
		//var lon = $("#station_longitude").val();
		var lat = "";
		var lon = "";
		
		window.open("/common/pop/updLocationMapPop.do?outptt=%uC704%uCE58%uC9C0%uB3C4%uCC3E%uAE30&latitude="+ lat +"&longitude=" + lon , "winpop2", "width=600, height=770, top="+winT+", left="+winL , "scrollbars=yes");

	}
    </script>
</body>
</html>