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
<link href="/css/jquery-ui.css" rel="stylesheet" type="text/css" />
<tiles:insertAttribute name="resource"/>
<script src="https://unpkg.com/formdata-polyfill"></script>
<style type="text/css">
	#preview{
         z-index: 9999;
         position:absolute;
         border:0px solid #ccc;
         background:#333;
         padding:1px;
         display:none;
         color:#fff;
     }
</style>
</head>
<body>
    <div class="allwrap">
        <!--모바일 메뉴 S-->
        <tiles:insertAttribute name="header"/>
        <!--모바일 메뉴 E-->
        <!--Head S-->
        <tiles:insertAttribute name="head"/>
        <!--Head E-->
        <div id="body">
            <div class="cont">
                <!--left menu S-->
                <tiles:insertAttribute name="left"/>
                <!--left menu E-->
                <!--conteent S-->
                <form id="frm"  name="frm" enctype="multipart/form-data" method="POST">
                	<input type="hidden" name="enfrcReturnHistSeq"   value="${resultInfo.enfrcReturnHistSeq}">
                	<input type="hidden" id="enfrcReturnStationId" name="enfrcReturnStationId"   value="${resultInfo.enfrcReturnStationId}">
                	<input type="hidden" id="changeStationId" name="changeStationId"   value="${resultInfo.enfrcReturnStationId}">
                	<input type="hidden" name="parkingLocation"   value="${resultInfo.parkingLocation}">
                	<input type="hidden" name="parkingLocationYn"     value="">
                	<input type="hidden" name="comptCd"   value="${resultInfo.comptCd}">
                	
		            <input type="hidden" name="deviceCnncCd"     value="${resultInfo.deviceCnncCd}">
		            <input type="hidden" name="enfrcReturnCd"     value="${resultInfo.enfrcReturnCd}">
		            <input type="hidden" name="photoYn"     value="${resultInfo.photoYn}">
		            <input type="hidden" name="emrgncyYn"     value="${resultInfo.emrgncyYn}">
		            <input type="hidden" name="latitude"     value="${resultInfo.latitude}">
		            <input type="hidden" name="longitude"     value="${resultInfo.longitude}">
		            
		            <input type="hidden" name="addr"     value="${resultInfo.addr}">
		            <input type="hidden" name="enfrcReturnDesc"     value="${resultInfo.enfrcReturnDesc}">
		            <input type="hidden" name="enfrcGubunCd"     value="${resultInfo.enfrcGubunCd}">
		            <input type="hidden" name="parkingLocationDesc"     value="${resultInfo.parkingLocationDesc}">
		            <input type="hidden" name="parkingLocationReason"     value="${resultInfo.parkingLocationReason}">
		            
		            <input type="hidden" name="centerId"   value="">
		            <input type="hidden" name="teamId"     value="">
		            
					<iframe name="ifrm" width="0" height="0"></iframe>            
                <div class="content">
                    <div class="subject">
                        <!--subject path S-->
                        <tiles:insertAttribute name="subject" />
                        <!--subject path E-->
                    </div>
                    <div class="page">
                         <table class="tb_type02 mt20">
                            <colgroup>
                                <col style="width:25%">
                                <col style="width:75%">
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th class="top">자전거 번호</th>
                                    <td class="top">${resultInfo.rentBikeNo}</td>
                                </tr>
                                <tr>
                                    <th>대여소 선택</th> <!-- 널값아닐시  from 태그에도 값 추가해야함 -->
                                    <td>
                                    	<script>$("select").styledSelect();</script>
								        <fieldset class="fld_sch">
								        <legend class="screen_out">검색어를 입력하세요</legend>
								            <div class="box_search">                    
								                <span class="input-text02">
								                	<input type="text" style="width:440px;" id="searchValue" value="${resultInfo.stationName}" name="searchValue" title="검색어 입력" placeholder="검색어를 입력하세요" autocomplete="off">
								                </span>
								                
								            </div>
								        </fieldset>
				        				<input type="hidden" name="searchType" id="searchType">
                                    </td>
                                </tr>
                                <tr>
                                    <th>임의장소</th>
                                    <td>
                                    	주 소 : <span class="input-text04"><input type="text" id="addr" style="width:400px;" name="addrDiv" value="${resultInfo.addr}" readonly></span> <button class="btnType02" onclick="goMapAddr();" type="button">지도보기</button><br/>
                                    	상 세 : <span class="input-text04"><input id="parkingLocationDiv" style="width:400px;" name="parkingLocationDiv" type="text"  value="${resultInfo.parkingLocation}"/></span>
                                    	<input type="text" id="latitude" value="${resultInfo.latitude}" style="display: none;"><input type="text" id="longitude" value="${resultInfo.longitude}" style="display: none;">
                                    </td>
                                </tr>
								 <tr>
                                    <th>선택 배정팀</th>
                                    <td>
                                    	배정팀 : <input type="text" id="teamName" value="${resultInfo.teamName}" readonly> 
                                    	&nbsp;&nbsp; &rArr; &nbsp;&nbsp;배정팀 변경 : 
                                    	<select id="enfrcCenterId">
                                    		<option value="">센터선택</option>
                                    		<c:forEach var="result" items="${codeList}" varStatus="status">
												<option value="${result.comCd}" ><c:out value="${result.comCdName}"/></option>
											</c:forEach>
                                    	</select>
                                    	<select id="enfrcTeamId">
                                    		<option value="">팀선택</option>
                                    		<c:forEach var="result" items="${teamList}" varStatus="status">
													<option value="${result.comCd}" ><c:out value="${result.comCdName}"/></option>
											</c:forEach>
                                    	</select>
                                    </td>
                                </tr>
								
								
                                <c:if test="${resultInfo.enfrcGubunCd == '1'}"><!-- 방치신고 -->
                                <tr>
		                        	<th>방치신고사유</th>
		                        	<td>
			                        	<span class="input-rd01"><input type="radio" id="a1" name="radioChkType1" value="1" ${resultInfo.parkingLocationReason == '1' ? 'checked':''}><label for="a1">시민신고</label></span>
			                        	<br/>
										<span class="input-rd01"><input type="radio" id="a2" name="radioChkType1" value="2" ${resultInfo.parkingLocationReason == '2' ? 'checked':''}><label for="a2">배송팀 발견</label></span>
										<br/>
										<p><span class="input-rd01"><input type="radio" id="a3" name="radioChkType1" value="3" ${resultInfo.parkingLocationReason == '3' ? 'checked':''}><label for="a3">기타</label></span>
										<br/>
										<span class="input-text13">메모 : <input id="parkingLocationDescText" name="parkingLocationDescText" type="text"  value="${resultInfo.parkingLocationDesc} "/></span>
									</td>
		                        </tr>
		                        </c:if>
		                        <c:if test="${resultInfo.enfrcGubunCd == '0'}"><!-- 강제반납 -->
		                        <tr>
		                        	<th>미반납 사유</th>
			                        <td>
			                        	<c:forEach items="${nrrList}" var="code" varStatus="status">
				                        	<c:if test="${status.count ==1}">
												<span class="input-rd01"><input type="radio" id="b${status.count}" name="radioChkType2" value="${code.comCd}" ${code.comCd == resultInfo.enfrcReturnCd ? 'checked':''}><label for="b${status.count}">${code.comCdName}</label></span>
											</c:if>
											<c:if test="${status.count !=1}">
												<br/><span class="input-rd01"><input type="radio" id="b${status.count}" name="radioChkType2" value="${code.comCd}" ${code.comCd == resultInfo.enfrcReturnCd ? 'checked':''}><label for="b${status.count}">${code.comCdName}</label></span>
											</c:if>
										</c:forEach>
										<br/>
										<span class="input-text13">메모 : <input id="enfrcReturnDescDiv" name="enfrcReturnDescDiv" type="text"  value="${fn:escapeXml(resultInfo.enfrcReturnDesc)}"/></span>
									</td>
		                        </tr>
                                
                                <tr>
			                        <th>잠금장치 연결</th>
			                        <td>
			                        	<span class="input-rd01"><input type="radio" id="a1" name="radioChkType3" value="1" ${resultInfo.deviceCnncCd == '1' ? 'checked':''}><label for="a1">예</label></span>
										<span class="input-rd01"><input type="radio" id="a2" name="radioChkType3" value="2" ${resultInfo.deviceCnncCd == '2' ? 'checked':''}><label for="a2">아니오</label></span>
										<span class="input-rd01"><input type="radio" id="a3" name="radioChkType3" value="3" ${resultInfo.deviceCnncCd == '3' ? 'checked':''}><label for="a3">불확실</label></span>
									</td>
			                    </tr>
                                </c:if>
		                        <tr>
		                        	<th>등록자 ID</th>
		                        	<td>${resultInfo.agentId}</td>
		                        </tr>
                                                 
                                <tr>
                                    <th>등록 시간</th>
                                    <td>${resultInfo.regDttm}</td>
                                </tr>
                                <tr>
                                    <th>사진 유/무</th>
                                    <td>${resultInfo.photoYn }</td>
                                </tr>

                				<tr>
                					<th>등록 사진</th>
                					<td>
                						<c:if test="${enfrcFileList[0] eq null}">
               					 		 <div id="loadImg1Div" style="display: none;"><span>사진1</span> <img id="loadImg1" class="loadImg" width="120px;" height="100px;" src="" /></div>
                						</c:if>
                						<c:if test="${enfrcFileList[0] ne null}">
               					 		 <div id="loadImg1Div" style="display: inline;"><span>사진1</span> <img id="loadImg1" class="loadImg" width="120px;" height="100px;" src="${enfrcFileList[0].fileSavePath}/${enfrcFileList[0].fileName}" /></div>
                						</c:if>
                						<c:if test="${enfrcFileList[1] eq null}">
               					 		 <div id="loadImg2Div" style="display: none;"><span>&nbsp;&nbsp;사진2</span> <img id="loadImg2" class="loadImg" width="120px;" height="100px;" src="" /></div>
                						</c:if>
                						<c:if test="${enfrcFileList[1] ne null}">
               					 		  <div id="loadImg2Div" style="display: inline;"><span>&nbsp;&nbsp;사진2</span> <img id="loadImg2" class="loadImg" width="120px;" height="100px;" src="${enfrcFileList[1].fileSavePath}/${enfrcFileList[1].fileName}" /></div>
                						</c:if>
                						<c:if test="${enfrcFileList[2] eq null}">
               					 		 <div id="loadImg3Div" style="display: none;"><span>&nbsp;&nbsp;사진3</span> <img id="loadImg3" class="loadImg" width="120px;" height="100px;" src="" /></div>
                						</c:if>
                						<c:if test="${enfrcFileList[2] ne null}">
               					 		 <div id="loadImg3Div" style="display: inline;"><span>&nbsp;&nbsp;사진3</span> <img id="loadImg3" class="loadImg" width="120px;" height="100px;" src="${enfrcFileList[2].fileSavePath}/${enfrcFileList[2].fileName}" /></div>
                						</c:if>
                					</td>
                				</tr>
                                
                                
                                <tr>
                               		<th>사진업로드</th>
                               		<td>
                               			<span>
											<input type="file" id="enfrcFile1" name="enfrcFile" style="width: 250px" onchange="LoadImg(this,1)"/>
											<input type="hidden" name="enfrcFileNoList" value="0"/>
											<input type='hidden' name='enfrcFileStateList' value='I'/>
											<button class="btnType02" onclick="clearFileBtn(1);" type="button">취소</button>
										</span><br/>
										<span>
											<input type="file" id="enfrcFile2" name="enfrcFile" style="width: 250px" onchange="LoadImg(this,2)"/>
											<input type="hidden" name="enfrcFileNoList" value="1"/>
											<input type='hidden' name='enfrcFileStateList' value='I'/>
											<button class="btnType02" onclick="clearFileBtn(2);" type="button">취소</button>
										</span><br/>
										<span>
											<input type="file" id="enfrcFile3" name="enfrcFile" style="width: 250px" onchange="LoadImg(this,3)"/>
											<input type="hidden" name="enfrcFileNoList" value="2"/>
											<input type='hidden' name='enfrcFileStateList' value='I'/>
											<button class="btnType02" onclick="clearFileBtn(3);" type="button">취소</button>
										</span>
                               		</td>
                               
                                </tr>  
                              
                				
                                
                                <tr>
                                    <th>긴급여부</th>
                                    <td><span class="input-ck01"><input type="checkbox" id="d1" ${resultInfo.emrgncyYn == 'Y' ? 'checked':''}><label for="d1"></label></span></td>
                                </tr>
                                <tr>
                                    <th>현재 상태</th>
                                    <td><c:if test="${resultInfo.rentBikeStat eq '정상(대기중)'}">정상 대기중</c:if>				 	
										<c:if test="${resultInfo.rentBikeStat ne '정상(대기중)'}">${resultInfo.rentBikeStat}</c:if></td>
                                </tr>
                                
                                
                                <tr>
                                    <th>처리완료 여부</th>
                                    <td>
                                    	<c:if test="${resultInfo.comptCd != '0' && resultInfo.comptCd != ''}">
											완료
										</c:if>
										<c:if test="${resultInfo.comptCd == '0' || resultInfo.comptCd == ''}">
											미처리
										</c:if>
                                    </td>
                                </tr>
                                
                             <c:if test="${resultInfo.comptCd != '0' && resultInfo.comptCd != ''}">
                             	<tr>
                                    <th>처리유형</th>
                                    <td>
                                    	<c:choose>
                                    		<c:when test="${resultInfo.comptCd == '1'}">재배치</c:when>
                                    		<c:when test="${resultInfo.comptCd == '2'}">회수후 재배치</c:when>
                                    		<c:when test="${resultInfo.comptCd == '3'}">센터입고</c:when>
                                    		<c:when test="${resultInfo.comptCd == '4'}">정상 대기중</c:when>
                                    		<c:when test="${resultInfo.comptCd == '5'}">자전거 없음</c:when>
                                    		<c:when test="${resultInfo.comptCd == '6'}">대여중</c:when>
                                    		<c:when test="${resultInfo.comptCd == '7'}">자동조치</c:when>
                                    		<c:when test="${resultInfo.comptCd == '8'}">배정팀 변경요청</c:when>
                                    	</c:choose>
                                    </td>
                                </tr>
                             	<tr>
		                        	<th>처리자 ID</th>
		                        	<td>${resultInfo.regId}</td>
		                        </tr>
                                                 
                                <tr>
                                    <th>처리 시간</th>
                                    <td>${resultInfo.comptDttm}</td>
                                </tr>
                                
                             </c:if>
                                
                                <%-- <tr>
                                	 <th>배정팀</th>
                                	 <td>
                                	 	${resultInfo.centerName}_${resultInfo.teamName}
                                	 </td>
                                </tr> --%>
                            </tbody>
                        </table>
                        <div class="btnArea tl">
                            <span class="left"><button class="btnType01 mb10" id="listBtn">목록</button></span>
                            <span class="right">
                                <button class="btnType01 mb10" id="updateBtn">수정</button>
                            </span>
                        </div>
                    </div>
                </div>
                </form>
                <!--conteent E-->
            </div>
        </div>
        <!--footer S-->
        <tiles:insertAttribute name="footer"/>
        <!--footer E-->
    </div>
    <script type="text/javascript" src="/js/common_barocle.js"></script>
<script src="/js/select/jquery.styled-select-box_main.js"></script>
    <script type="text/javascript">
    $(document).ready(function(){
    	
    });
    
    /* console.log('${codeList}'); */
    
    //기존 저장 이미지(교체이미지 취소시 사용)
    var img1 = '${enfrcFileList[0].fileSavePath}/${enfrcFileList[0].fileName}';
    var img2 = '${enfrcFileList[1].fileSavePath}/${enfrcFileList[1].fileName}';
    var img3 = '${enfrcFileList[2].fileSavePath}/${enfrcFileList[2].fileName}';
    
    //###(start)사진기능 추가로 인한 스크립트(테스트중)
    var xOffset = 150;
    var yOffset = 30;

    $(document).on("mouseover",".loadImg",function(e){ //마우스 오버시
    	if(!$(this).attr("src")) return false;
        
        $("body").append("<p id='preview'><img src='"+ $(this).attr("src") +"' width='600px' height='400px' /></p>"); //보여줄 이미지를 선언                       
        $("#preview")
            .css("top",(e.pageY - xOffset) + "px")
            .css("left",(e.pageX + yOffset) + "px")
            .fadeIn("fast"); //미리보기 화면 설정 셋팅
    });
     
    $(document).on("mousemove",".loadImg",function(e){ //마우스 이동시
        $("#preview")
            .css("top",(e.pageY - xOffset) + "px")
            .css("left",(e.pageX + yOffset) + "px");
    });
     
    $(document).on("mouseout",".loadImg",function(){ //마우스 아웃시
        $("#preview").remove();
    });
    
    //파일 등록시 img태그 변경
    function LoadImg(data,no){
    	if(data.files && data.files[0]){
    		var reader = new FileReader();
    		reader.onload = function(e){
    			$("#loadImg"+no).attr('src',e.target.result);
    			$("#loadImg"+no+"Div").css("display","inline");
    		}
    		reader.readAsDataURL(data.files[0]);
    	} else {
    		clearFileBtn(no);
    	}
    }
    
  function clearFileBtn(no){
	  
	  var arrImg = [];
		arrImg[0] = img1;    		
		arrImg[1] = img2;    		
		arrImg[2] = img3;
		if(arrImg[no-1] !== "\/"){ //기존 저장이미지 있을시
			$("#loadImg"+no).attr('src',arrImg[no-1]);
			$("#loadImg"+no+"Div").css("display","inline");
		} else { //기존저장이미지 없을시
			$("#loadImg"+no).attr('src',"");
			$("#loadImg"+no+"Div").css("display","none");
		}
		$("#enfrcFile"+no).val("");
		$("#enfrcFile"+no).replaceWith( $("#enfrcFile"+no).clone(true) );
  }
    
  //###(end)사진기능 추가로 인한 스크립트(테스트중)
    
    
    $("#searchValue").on("focus",function(){
   		$("#addr").val("");
   		$("#parkingLocationDiv").val("");
   		$("#teamName").val("");
   		$("#latitude").val("");
   		$("#longitude").val("");
    }); 
    
	$("input").on("keydown",function(key){
		if(key.keyCode == 13) return false;
	});
	
    
    var autocompleteStationName = new Array();
    $(function() {
    	$("#searchValue").on("click" , searhText);
    	
    	commonAjax.getAjax("/common/pop/findStationAllInfo.do", "json", $("#frm").serialize()
                ,function(data){
    		
    		           if(data != null && data.stationList != null) {
    					for( var i in data.stationList ) {
             				autocompleteStationName.push(
             						{
             							label : data.stationList[i].stationName,
             							stationId : data.stationList[i].stationId,
             							teamNm : data.stationList[i].teamNm
             						}
             				);
             				
             			}
                     }          
                 }
            );
    	
    	rentDetail.initBtn('${menuType}');
    	
    });
    
    var rentDetail = {};
    
    rentDetail.initBtn = function(mType){
    	$("#updateBtn").on("click", exeImpulseBikeReturn);
    	$("#listBtn").on("click", function(e){
    		var tUrl = "/getExeImpulseList.do";
    		$("#frm").attr({action: tUrl, method : 'post'}).submit();
    	});
            	
    };
    function exeImpulseBikeReturn() {
    	if(!confirm("내용을 변경하시겠습니까? ")) 
    		return false;
    	
    	
    	if(!$("#searchValue").val()){
    		$("input:hidden[name=enfrcReturnStationId]").val("");
    		$("input:hidden[name=changeStationId]").val("");
    	}
    	
    	var radioChkType1 = ($(':radio[name="radioChkType1"]:checked').val() ? $(':radio[name="radioChkType1"]:checked').val() : ""); //방치신고사유 
    	var radioChkType2 = ($(':radio[name="radioChkType2"]:checked').val() ? $(':radio[name="radioChkType2"]:checked').val() : ""); //미반납사유
    	var radioChkType3 = ($(':radio[name="radioChkType3"]:checked').val() ? $(':radio[name="radioChkType3"]:checked').val() : ""); //잠금장치 연결
    	
    	var addr = $("#addr").val(); //주소
    	var parkingLocation = $("#parkingLocationDiv").val(); //상세
    	
    	var enfrcReturnStationId = $("input:hidden[name=enfrcReturnStationId]").val();
    	
    	$("input:hidden[name='deviceCnncCd']").val(radioChkType3);
    	$("input:hidden[name='enfrcReturnCd']").val(radioChkType2);
    	$("input:hidden[name='parkingLocation']").val(parkingLocation);
    	var emrgncyYn = $("input:checkbox[id='d1']").is(":checked");
    	
    	$("input:hidden[name='latitude']").val($('#latitude').val());
    	$("input:hidden[name='longitude']").val($('#longitude').val());
    	
    	$("input:hidden[name='enfrcReturnDesc']").val($('#enfrcReturnDescDiv').val()); //강제반납 기타
    	$("input:hidden[name='parkingLocationDesc']").val($('#parkingLocationDescText').val()); //방치신고 기타
    	$("input:hidden[name='parkingLocationReason']").val(radioChkType1); //미반납 기타
    	$("input:hidden[name='addr']").val(addr);
    	
    	if(emrgncyYn)
		{
			$("input[name='emrgncyYn']").val('Y');
		}else{
			$("input[name='emrgncyYn']").val('N');
		}
    	if(addr)
		{
			$("input[name='parkingLocationYn']").val('Y');
		}else{
			$("input[name='parkingLocationYn']").val('N');
		}
    	
    	if($("input:hidden[name='comptCd']").val()=='5' && (enfrcReturnStationId != changeStationId)){
    		$("input:hidden[name='comptCd']").val("0");
    	}
    
    	if(!addr && !enfrcReturnStationId){
    		  alert("변경하실 대여소 또는 임의장소를 선택해주세요. ");
    		  return false;
    	}
    	
    	if($("#enfrcCenterId").val() != '' && $("#enfrcTeamId").val() == '' || $("#enfrcCenterId").val() == '' && $("#enfrcTeamId").val() != ''){
   			alert("배정팀을 변경하실 경우 센터와 팀을 꼭 선택해주세요.");
   			return false;
   		} else{
   			$("input:hidden[name='centerId']").val($('#enfrcCenterId').val()); 
   			$("input:hidden[name='teamId']").val($('#enfrcTeamId').val()); 
   		}
    	
    	 var fileCnt = 0;
         $("input[name=enfrcFileStateList]").each(function(idx){
         	var value = $(this).val();
         	var eqValue = $("input[name=enfrcFile]:eq(" + idx + ")").val() ;
         	//alert((value + ":" + eqValue));
         	//console.log(eqValue);
         	if(eqValue != '')
         		fileCnt++;
         });
         //console.log(fileCnt);
         
         if(fileCnt > 0)
        	 $("input[name='photoYn']").val('Y');	 
         
         //alert("fileCnt : " + fileCnt);

        /*  if(radioChkType3 == "Y" && fileCnt == 0){
         	alert("사진첨부 유무를 확인해주세요.");
         	return false;
         }else if(radioChkType3 == "N" && fileCnt != 0){
         	alert("사진첨부 유무를 확인해주세요.");
             return false;
         } */
    	
    	
    	/* console.log("radioChkType1 ="+  radioChkType1);
    	console.log("radioChkType2 ="+  radioChkType2);
    	console.log("radioChkType3 ="+  radioChkType3);
    	
    	console.log("enfrcReturnHistSeq ="+  $("#frm").find("[name=enfrcReturnHistSeq]").val());
   		console.log("enfrcReturnStationId ="+$("#frm").find("[name=enfrcReturnStationId]").val());
   		console.log("changeStationId ="+$("#frm").find("[name=changeStationId]").val());
   		console.log("comptCd ="+$("#frm").find("[name=comptCd]").val());
   		console.log("deviceCnncCd ="+$("#frm").find("[name=deviceCnncCd]").val());
   		console.log("enfrcReturnCd ="+$("#frm").find("[name=enfrcReturnCd]").val());
   		console.log("photoYn ="+$("#frm").find("[name=photoYn]").val());
   		console.log("emrgncyYn ="+$("#frm").find("[name=emrgncyYn]").val());
   		console.log("parkingLocation ="+$("#frm").find("[name=parkingLocation]").val());
   		console.log("parkingLocationYn ="+$("#frm").find("[name=parkingLocationYn]").val());
   		console.log("latitude ="+$("#frm").find("[name=latitude]").val());
   		console.log("longitude ="+$("#frm").find("[name=longitude]").val());
   		console.log("enfrcReturnDesc ="+$("#frm").find("[name=enfrcReturnDesc]").val());
   		console.log("addr ="+$("#frm").find("[name=addr]").val());
   		console.log("enfrcGubunCd ="+$("#frm").find("[name=enfrcGubunCd]").val());
   		console.log("parkingLocationDesc ="+$("#frm").find("[name=parkingLocationDesc]").val());
   		console.log("parkingLocationReason ="+$("#frm").find("[name=parkingLocationReason]").val());
   		console.log("parkingLocationReason ="+$("#frm").find("[name=centerId]").val());
   		console.log("parkingLocationReason ="+$("#frm").find("[name=teamId]").val());
   		
   		
   		console.log("enfrcFile0 ="+$("#frm").find("input[name=enfrcFile]:eq(0)").val());
   		console.log("enfrcFile1 ="+$("#frm").find("input[name=enfrcFile]:eq(1)").val());
   		console.log("enfrcFile2 ="+$("#frm").find("input[name=enfrcFile]:eq(2)").val());
   		
   		
   		console.log($("#frm").serialize()); */ 
   		
    	 /*  commonAjax.getAjax("/updateExeImpulseProc.do", "json", $("#frm").serialize()
                ,function(data){
                     if(data) {
                         //alert(data.resultMessage);
                         if(data.resultMessage == "Success") {
                        	alert("변경이 완료되었습니다.");
                        	$("#frm").attr({action: '/getExeImpulseList.do' , method : 'post'}).submit();
                         } 
                     }          
                 }
            );   */
            
   	/* 	 $("#frm").attr({action: '/updateExeImpulseProc.do'}).submit();  */
   		 
         
         var form = $('#frm')[0];
         var formData = new FormData(form);
        	
         $.ajax({
                url: '/updateExeImpulseProc.do',
                processData: false,
                contentType: false,
                cache:false,
                data: formData,
                type: 'POST',
                complete : function(){
                	alert("수정되었습니다.");
                }
            });	
         return false;  
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
	     		$("#enfrcReturnStationIdDiv").html(ui.item.label);
	     		$("#teamName").val(ui.item.teamNm);
	        }
	    });
    }
    
    
	function goMapAddr(){
		$("#searchValue").val("");
		$("#teamName").val("");
		$("input:hidden[name=enfrcReturnStationId]").val("");
		$("input:hidden[name=changeStationId]").val("");
		
		/* if(!$("#station_latitude").val() && !$("#station_longitude").val()){
			alert('<spring:message code="fail.input.emptyValue2" arguments="위경도"/>');
			return;
		} */
		var pwidth = 700;
		var pheight = 780;
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