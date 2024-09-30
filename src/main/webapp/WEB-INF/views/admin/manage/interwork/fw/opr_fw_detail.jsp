<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html>
<html lang="ko">
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
                <tiles:insertAttribute name="left"  />
                <!--left menu E-->
				<!--content S-->
				<div class="content">
					<div class="subject">
						<p class="pageTitle">F/W Update</p>
						<span>운영관리 &gt; 연동 관리 &gt; <em>F/W Update</em></span>
					</div>
					<div class="page">
						<form id="fwFormFrm" name="fwFormFrm" enctype="multipart/form-data"	>
						<input type="hidden" id="firmwareSeq" name="firmwareSeq">
						<input type="hidden" name="updateCanStrTime">
						<input type="hidden" name="updateCanEndTime">
						<input type="hidden" name="allUpdateYn">
						<input type="hidden"  id= "updateBeginSerialNo" name="updateBeginSerialNo">
						<input type="hidden"  id="updateEndSerialNo" name="updateEndSerialNo">
							<fieldset>
								<p class="head mt20">F/W 정보</p>
								<table class="tb_type02 mt20">
									<colgroup>
										<col style="width:25%" />
										<col style="width:75%" />
									</colgroup>
									<tbody>
										<tr>
											<th class="top"><em>*</em> F/W 구분</th>
											<td class="top">
											<c:choose>
												<c:when test="${fn:contains(viewFlg, 'U')}">
													<input type="hidden" name="firmwareClsCd" value="${firmware.firmwareClsCd }"/>
													<select class="select-category01" id="firmwareClsCd" disabled="disabled">
												</c:when>
												<c:otherwise>
													<select class="select-category01" id="firmwareClsCd" name="firmwareClsCd">
												
												</c:otherwise>
											</c:choose>
		                                               <option value="">선택</option>
		                                            </select>
											</td>
										</tr>
										<tr>
											<th><em>*</em> F/W 제조사</th>
											<td>
													<select class="select-category01" id="companyCd" name="companyCd">
		                                               <option value="">선택</option>
		                                            </select>
											</td>
										</tr>
										<tr>
											<th><em>*</em> 장치구분</th>
											<td>
												<select class="select-category01" id="deviceModlCd" name="deviceModlCd">
													<option value="">선택</option>
													<%-- <option value="DM2" <c:if test="${firmware.deviceModlCd == 'DM2'}">selected="selected"</c:if>>단말기</option> --%>
													<option value="DM4" <c:if test="${firmware.deviceModlCd == 'DM4'}">selected="selected"</c:if>>QR단말기</option>
													<%-- <option value="DM6" <c:if test="${firmware.deviceModlCd == 'DM6'}">selected="selected"</c:if>>전기단말기</option> --%>
												</select>
											</td>
											</tr>
										<tr>
											<th><em>*</em> F/W Version</th>
											<td><span class="input-text08">
											<c:choose>
												<c:when test="${updateStartYn }">
													<input type="text" id="firmwareVer" name="firmwareVer" readonly="readonly"/>
												</c:when>
												<c:otherwise>	
													<input type="text" id="firmwareVer" name="firmwareVer"/>
												</c:otherwise>
											</c:choose>	
											</span></td>
										</tr>
										<tr>
											<th><em>*</em> 사용여부</th>
											<td>
												<span class="input-rd01"><input type="radio" id="a4" name="useYn" value="Y" checked="checked"/><label for="a4">사용</label></span>
												<span class="input-rd01"><input type="radio" id="a5" name="useYn" value="N"/><label for="a5">미사용</label></span>
											</td>
										</tr>
										<tr id="updateCan">
											<th><em>*</em> 업데이트 가능시간</th>
											<td>
												<select id="updateCanStrHH">
													<option value="">선택</option>
													<c:forEach var="i" begin="0" end="23">
														<c:choose>
															<c:when test="${i < 10}">
																<option value="0${i}">0${i}</option>
															</c:when>
															<c:otherwise>
																<option value="${i}">${i}</option>
															</c:otherwise>
														</c:choose>
													</c:forEach>
												</select>시
												<select id="updateCanStrMM">
													<option value="">선택</option>
													<c:forEach var="i" begin="0" end="59">
														<c:choose>
															<c:when test="${i < 10}">
																<option value="0${i}">0${i}</option>
															</c:when>
															<c:otherwise>
																<option value="${i}">${i}</option>
															</c:otherwise>
														</c:choose>
													</c:forEach>
												</select>분
												~
												<p class="pwtableblock">
												<select id="updateCanEndHH">
													<option value="">선택</option>
													<c:forEach var="i" begin="0" end="23">
														<c:choose>
															<c:when test="${i < 10}">
																<option value="0${i}">0${i}</option>
															</c:when>
															<c:otherwise>
																<option value="${i}">${i}</option>
															</c:otherwise>
														</c:choose>
													</c:forEach>
												</select>시
												<select id="updateCanEndMM">
													<option value="">선택</option>
													<c:forEach var="i" begin="0" end="59">
														<c:choose>
															<c:when test="${i < 10}">
																<option value="0${i}">0${i}</option>
															</c:when>
															<c:otherwise>
																<option value="${i}">${i}</option>
															</c:otherwise>
														</c:choose>
													</c:forEach>
												</select>분
												</p>
											</td>							
										</tr>
										<tr id="updateCanBike">
											<th><em>*</em> 업데이트 자전거</th>
											<td>
												<span class="input-rd01"><input type="radio" id="a6" name="allUpdate" value="Y" checked="checked"/><label for="a6">전체</label></span>
												<span class="input-rd01"><input type="radio" id="a7" name="allUpdate" value="N"/><label for="a7">자전거 번호</label></span>
												<c:set var="sBike" value="${fn:substring(firmware.updateBeginSerialNo,4,9) }"/>
												<c:set var="eBike" value="${fn:substring(firmware.updateEndSerialNo,4,9) }"/>
												<span class="input-text08">BRC- <input type="text" id="sBikeNum" name="sBikeNum" value="${sBike }"/> ~ BRC- <input type="text" id="eBikeNum" name="eBikeNum"  value="${eBike }"/></span>
											</td>
										</tr>
									</tbody>
								</table>
								
								<c:choose>
									<c:when test="${fn:contains(viewFlg, 'I')}">
										<div id="upload1">
										<p class="head">F/W 파일 정보</p>
										<table class="tb_type02 mt20">
											<colgroup>
												<col style="width:25%" />
												<col style="width:75%" />
											</colgroup>
											<tbody>
												<tr>
													<th >파일</th>
													<td >
														<span>
															<input type="file" id="firmwareFile" name="firmwareFile" style="width: 350px"/>
															<input type="hidden" name="firmwareFileNoList" value="0"/>
															<input type='hidden' name='firmwareFileStateList' value='I'/>
														</span>
													</td>
												</tr>
											</tbody>
										</table>
										</div>
										<div id="upload2" style="display:none;">
										<p class="head">F/W 파일 정보&nbsp;&nbsp;<button class="fullBtn" type="button" id="rowAddBtn"><img src="/images/btn_addAnswer.png" alt="rowAddBtn" /></button></p>
										<table class="tb_type02 mt20">
											<colgroup>
												<col style="width:25%" />
												<col style="width:75%" />
											</colgroup>
											<tbody id="addTemplate">
												<tr>
													<th >파일
														<select name=firmwareFileNoList>
															<option value="">선택</option>
															<c:forEach var="i" begin="0" end="99">
																<option value="${i}">${i}</option>
															</c:forEach>
														</select>
														<input type='hidden' name='firmwareFileStateList' value='I'/>
													</th>
													<td ><span><input type="file" id="firmwareFile" name="firmwareFile" style="width: 350px"/></span></td>
												</tr>
											</tbody>
										</table>
										</div>
									</c:when>
									<c:when test="${fn:contains(viewFlg, 'U')}">
										<c:choose>
											<c:when test="${fn:contains(firmware.firmwareClsCd, 'FWD_002') || fn:contains(firmware.firmwareClsCd, 'FWD_003')}">
												<div id="upload2">
												<p class="head">F/W 파일 정보&nbsp;&nbsp;
												<c:if test="${!updateStartYn }">
													<button class="fullBtn" type="button" id="rowAddBtn"><img src="/images/btn_addAnswer.png" alt="rowAddBtn" /></button>
												</c:if>
												</p>
												<table class="tb_type02 mt20">
													<colgroup>
														<col style="width:25%" />
														<col style="width:75%" />
													</colgroup>
													<tbody id="addTemplate">
														<c:forEach var="result" items="${firmwareFileList }" varStatus="status" >
														<tr>
															<th>파일
																<select disabled="disabled">
																	<option value="">선택</option>
																	<c:forEach var="i" begin="0" end="99">
																		<c:choose>
																			<c:when test="${result.firmwareFileNo == i}">
																				<option value="${i}" selected="selected">${i}</option>
																			</c:when>
																			<c:otherwise>
																				<option value="${i}">${i}</option>
																			</c:otherwise>
																		</c:choose>
																	</c:forEach>
																</select>
																<c:if test="${!updateStartYn }">
																	&nbsp;<button class="fullBtn" type="button" onclick="fwForm.rowDel(this)" id="${result.firmwareFileNo },${result.fileSavePath },${result.fileName }"><img src="/images/btn_delAnswer.png" alt=""/></button>
																</c:if>	
																<input type="hidden" name="firmwareFileNoList" value="${result.firmwareFileNo }"/>
																<input type="hidden" name="fileSavePathList" value="${result.fileSavePath }"/>
																<input type="hidden" name="firmwareFileStateList" value="U"/>
															</th>
															<td>
																<span>
																	<c:if test="${!updateStartYn }">
																		<input type="file" id="firmwareFile" name="firmwareFile" style="width: 350px"/> 
																	</c:if>
																	(${result.fileName })
																	<input type="hidden" name="oldFileNameList" value="${result.fileName }"/>
																</span>
															</td>
														</tr>
														</c:forEach>
													</tbody>
												</table>
												</div>
											</c:when>
											<c:otherwise>
												<div id="upload1">
												<p class="head">F/W 파일 정보</p>
												<table class="tb_type02 mt20">
													<colgroup>
														<col style="width:25%" />
														<col style="width:75%" />
													</colgroup>
													<tbody>
														<c:forEach var="result" items="${firmwareFileList }" varStatus="status">
														<tr>
															<th >파일</th>
															<td >
																<span>
																	<input type="file" id="firmwareFile" name="firmwareFile" style="width: 350px"/>
																	<input type="hidden" name="fileSavePathList" value="${result.fileSavePath  }"/>
																	<input type="hidden" name="oldFileNameList" value="${result.fileName }"/>
																	<input type="hidden" name="firmwareFileNoList" value="0"/>
																	<input type="hidden" name="firmwareFileStateList" value="U"/>&nbsp;
																	(${result.fileName })
																</span>
															</td>
														</tr>
														</c:forEach>
													</tbody>
												</table>
												</div>
											</c:otherwise>	
										</c:choose>
									</c:when>
								</c:choose>
								
								<div class="btnArea">
									<span class="left"><button class="btnType01 bc_gray" type="button" id="fwFormListBtn">목록</button></span>
									<span class="right">
									<c:if test="${fn:contains(viewFlg, 'U')}">
										<button class="btnType01" type="button" id="fwFormDelBtn">삭제</button>
									</c:if>
										<button class="btnType01 bc_green" type="button" id="fwFormSaveBtn">저장</button>
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
		fwForm.initBtn();
		fwForm.commonCode();
		fwForm.initVal();
		fwForm.checkIsSuccess();
	});
	
	var fwForm = {};
	
	var template = "<tr id='addTr'>";
	template += "<th>파일 ";
	template += "<select name='firmwareFileNoList'>";
	template += "<option value=''>선택</option>";
	template += "<c:forEach var='i' begin='0' end='99'>";
	template += "<option value='${i}'>${i}</option>";
	template += "</c:forEach>";
	template += "</select>";
	template += "&nbsp;&nbsp;<button class='fullBtn' type='button' onclick='fwForm.rowDel(this)'><img src='/images/btn_delAnswer.png' alt=''/></button>";
	template += "<input type='hidden' name='firmwareFileStateList' value='I'/>";
	template += "</th>";
	template += "<td><span><input type='file' id='firmwareFile' name='firmwareFile' style='width: 350px'/></span></td>";
	template += "</tr>";
	
	fwForm.initBtn = function () {
		
		$("#fwFormListBtn").on("click", this.moveList);

		$("#rowAddBtn").on("click", function(){
			$("#addTemplate").append(template);
		});

		$("#firmwareClsCd").on("change", function(e){
			var str = e.target.value;
			if(str == 'FWD_001') {
				$("#upload2").hide();
				$("#upload1").show();
			} else {
				$("#upload1").hide();
				$("#upload2").show();
			}
		});
		
		$("#fwFormSaveBtn").on("click", this.chkSubmitData);
		
		$("#fwFormDelBtn").on("click", this.delFirmware);
	};
	
	fwForm.initVal = function () {
		
		if("${viewFlg }" == 'U') {
			$("input:hidden[name='firmwareSeq']").val("${firmware.firmwareSeq}");
			$("#firmwareClsCd").val("${firmware.firmwareClsCd}");
			$("#companyCd").val("${firmware.companyCd}");
			$("#firmwareVer").val("${firmware.firmwareVer}");
			$("input:radio[name='useYn']:input[value='${firmware.useYn}']").prop("checked", true);
			
			$("input:radio[name='allUpdate']:input[value='${firmware.allUpdateYn}']").prop("checked", true);
			
			var updateCanStr = ("${firmware.updateCanStrTime}").split(":");
			var updateCanEnd = ("${firmware.updateCanEndTime}").split(":");
			
			$("#updateCanStrHH").val(updateCanStr[0]);
			$("#updateCanStrMM").val(updateCanStr[1]);
			$("#updateCanEndHH").val(updateCanEnd[0]);
			$("#updateCanEndMM").val(updateCanEnd[1]);
			
		}
	}
	
	fwForm.checkIsSuccess = function() {
		if("${isSuccess}" == "true") {
			alert("저장 성공하였습니다.");
			if("${viewFlg }" == 'I')
				fwForm.moveList();
		} else if("${isSuccess}" == "false") {
			alert("저장 실패하였습니다.");
			if("${viewFlg }" == 'I')
				fwForm.moveList();
		}
	};
	
	fwForm.commonCode = function () {
	    //상태코드
		commonAjax.getCommonCode("FWD", function(data) {
			if(data !== null && data.codeList !== null) {
				commCdBox.makeComboBox('CC', "${firmware.firmwareClsCd}", data.codeList, "firmwareClsCd");	
			}
	    })

	    
	    commonAjax.getCommonCode("CPN", function(data) {
			if(data !== null && data.codeList !== null) {
	        	 var code = new Array();
	             for(var i =0; i <data.codeList.length ;i++) {
	            	 code.push(data.codeList[i]);
	             }
				commCdBox.makeComboBox('CC', "${firmware.companyCd}", code, "companyCd");	
			}
	    })
	};
	
	fwForm.moveList = function() {
		$("[name='firmwareClsCd']").val("");
		$("#fwFormFrm").attr({method : "post", action : "/admin/manage/interworkMgmt/listFirmware.do"}).submit();
	};
	
	fwForm.rowDel = function (e) {
		var parent = e.parentNode.parentNode;
		var firmwareFileInfo = (e.id).split(",");
		
		if(e.id != "") {
			
			if(confirm("삭제 하시겠습니까?")) {
		    	commonAjax.postAjax("/admin/manage/interworkMgmt/delFirmwareFileAjax.do", "json", 
		   				{firmwareSeq : $("input:hidden[name='firmwareSeq']").val(), firmwareFileNo : firmwareFileInfo[0],
		    			fileSavePath : firmwareFileInfo[1], fileName : firmwareFileInfo[2]}, 
		   				function(data) {
			   				if(data) {
								if(data.isDel == "true") {
									alert("삭제되었습니다.");
									$(parent).remove();
								} else {
									alert("삭제 실패하였습니다.");
								}
							}	
				});
			}
		} else {
			$(parent).remove();
		}
	};
	
	fwForm.delFirmware = function() {
		if(confirm("삭제 하시겠습니까?")) {
			commonAjax.postAjax("/admin/manage/interworkMgmt/delFirmware.do", "json", 
	   				$("#fwFormFrm").serialize(), 
	   				function(data) {
		   				if(data) {
							if(data.isDel == "true") {
								alert("삭제되었습니다.");
								fwForm.moveList();
							} else {
								alert("삭제 실패하였습니다.");
							}
						}	
			});
		}
	}
	
    fwForm.chkSubmitData = function() {
    	
    	if($("#firmwareClsCd").val() == "") {
    		alert("F/W 구분을 선택해주세요.");
    		$("#firmwareClsCd").focus();
    		return false;
    	}
    	
    	if($("#companyCd").val() == "") {
    		alert("F/W 제조사를 선택해주세요.");
    		$("#companyCd").focus();
    		return false;
    	}
    	
    	if($("#firmwareVer").val() == "") {
    		alert("F/W Version을 입력해주세요.");
    		$("#firmwareVer").focus();
    		return false;
    	}
    	
    	var re = /^[0-9.]+$/;
    	if(!re.test($("#firmwareVer").val())) {
    		alert("F/W Version은 숫자와 '.'만 입력 가능합니다.");
    		$("#firmwareVer").val("").focus();
    		return false;
    	}
    	
    	var rst = false;
    	$("#updateCan").find("select").each(function(idx) {
    		if($(this).val() == "") {
        		alert("업데이트 가능시간을 선택해주세요.");
        		$(this).focus();
        		rst = true;
        		return false;
        	}
    	});
    	if(rst)
    		return false;
    	
    	var numCheck = /^[0-9]+$/;
    	if($('[name="allUpdate"]:checked').val() == "N"){
    		// 부분 업뎃
    		if($("#sBikeNum").val() == "" || $("#eBikeNum").val() == ""){
    			alert("자전거 번호를 입력해주세요.");
    			return false;
    		}
    		if(!numCheck.test($("#sBikeNum").val())) {
    			alert("자전거번호는 숫자만 입력 가능합니다.");
        		$("#sBikeNum").val("").focus();
        		return false;
    		}
    		if(!numCheck.test($("#eBikeNum").val())) {
    			alert("자전거번호는 숫자만 입력 가능합니다.");
        		$("#eBikeNum").val("").focus();
        		return false;
    		}
    		if($("#sBikeNum").val().length>5 || $("#eBikeNum").val().length>5){
    			alert("자전거번호는 5자리 이하만 입력 가능합니다.");
    			return false;
    		}
    		if($("#sBikeNum").val()>$("#eBikeNum").val()){
    			alert("뒷번호보다 앞번호가 더 클 수 없습니다.");
    			$("#sBikeNum").focus();
    			return false;
    		}
    	}
    	
    	var fileInfo;
		if($("#firmwareClsCd").val() == 'FWD_001') {
			fileInfo = $("#upload1");
		} else {
			fileInfo = $("#upload2");
		}
		
		var fileNo = $(fileInfo).find("[name='firmwareFileNoList']");
    	$(fileNo).each(function(idx) {
    		if($(this).val() == "") {
        		alert("파일 번호를 선택해주세요.");
        		$(this).focus();
        		rst = true;
        		return false;
        	}
    	});
    	if(rst)
    		return false;
    	
    	$(fileNo).each(function(i) {
    		$(fileNo).each(function(j) {
        		if(i != j) {
					if($(fileNo).eq(j).val() == $(fileNo).eq(i).val()) {
						alert("파일 번호가 중복됩니다.");
						$(fileNo).eq(j).val("").focus();
		        		rst = true;
		        		return false;
					}         			
        		}
        	})
    	});
    	if(rst)
    		return false;
    	
    	if('${viewFlg }' == 'U') {
    		$("#addTr").find("#firmwareFile").each(function() {
	    		if($(this).val() == "") {
	    			alert("펌웨어 파일을 선택해주세요.");
	    			rst = true;
	        		return false;
	    		}
	    	});
		} else if('${viewFlg }' == 'I') {
			$(fileInfo).find("#firmwareFile").each(function() {
	    		if($(this).val() == "") {
	    			alert("펌웨어 파일을 선택해주세요.");
	    			rst = true;
	        		return false;
	    		}
	    	});
		}
    	if(rst)
    		return false;
    	
    	$("input:hidden[name='updateCanStrTime']").val($("#updateCanStrHH").val() + ":" + $("#updateCanStrMM").val());
    	$("input:hidden[name='updateCanEndTime']").val($("#updateCanEndHH").val() + ":" + $("#updateCanEndMM").val());
    	
    	$("input:hidden[name='allUpdateYn']").val($('[name="allUpdate"]:checked').val());
    	
    	if($('[name="allUpdate"]:checked').val() == "N"){
    		var setSBikeNum, setEBikeNum;
    		setSBikeNum = setBikeFormat($("#sBikeNum").val());
    		setEBikeNum = setBikeFormat($("#eBikeNum").val());
    		$("#updateBeginSerialNo").val(setSBikeNum);
    		$("#updateEndSerialNo").val(setEBikeNum);
    	}
    	
    	commonAjax.postAjax("/admin/manage/interworkMgmt/chkFirmwareVerAjax.do", "json", 
   				{firmwareVer : $("#firmwareVer").val(), firmwareClsCd : $("#firmwareClsCd").val(), firmwareSeq : $("#firmwareSeq").val(), companyCd : $("#companyCd").val()}, function(data) {
   			if(data) {
				if((data.isVerOk == "true")) {
					alert("같거나 높은 F/W Version이 있습니다.");
		    		return false;
				} else {
	    			if($("#firmwareClsCd").val() == 'FWD_001') {
	    				$("#upload2").remove();
	    			} else {
	    				$("#upload1").remove();
	    			}
	    			
					if('${viewFlg }' == 'U') {
						$("#fwFormFrm").attr({method : "post", action : "/admin/manage/interworkMgmt/modFirmware.do"}).submit();
			    	} else if('${viewFlg }' == 'I') {
			    		$("#fwFormFrm").attr({method : "post", action : "/admin/manage/interworkMgmt/insertFirmwareFile.do"}).submit();
					}
	    		}
			}
		});
    }
    
    function setBikeFormat(num) {
    	 var zero = '';

    	 if (num.length < 5) {
    	  for (i = 0; i < 5 - num.length; i++)
    	   zero += '0';
    	 }
    	 return "BRC-"+zero + num;
    	}
    
</script>
</body>
</html>