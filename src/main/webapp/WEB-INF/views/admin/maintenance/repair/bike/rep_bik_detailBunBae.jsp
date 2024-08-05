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
 <link rel="stylesheet" type="text/css" href="/css/w3.css" >	  
</head>

<body>
	<div class="w3-container w3-margin-top">
		<form id="frm">
			<fieldset>
				
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
				<input type="hidden" name="repairCmptYn" id="repairCmptYn" value="Y"/>
				<input type="hidden" name="bikeNo" id="bikeNo"  />
				<!-- 20190201 양재영 추가 -->
				<input type="hidden" name="adminId" id="adminId">
				<input type="hidden" name="bikeId" readonly />
				<legend>자전거 등록 / 상세 / 수정</legend>
				<div style="padding:3px;">
				<h4>
					<span>자전거번호 :&nbsp; &nbsp;</span><span id="_bikeNo"></span>
				</h4>	
					<span class="right">
						<button type="button" class="btnType01 bc_green" id="exeRepairBikeEdit">저장</button>
					</span>
				</div>	
				<h4>경정비</h4>
				<div class="w3-panel w3-topbar w3-bottombar w3-border-red w3-pale-red w3-padding-8">
			  		<table>
			  		<tr>
			  			<td style="width:130px;"><input class="w3-check"   type="checkbox" class="w3-check"  id="c9" value="REB_009"><label for="c9">스탠드</label></td>
						<td><input class="w3-check"   type="checkbox" class="w3-check"  id="c23" value="REB_024"><label for="c23">타이어.튜브</label></td>
					</tr>
					<tr>
						<td><input class="w3-check"   type="checkbox" class="w3-check"  id="c18" value="REB_018"><label for="c18">물받이</label></td>
						<td><input class="w3-check"   type="checkbox" class="w3-check"  id="c30" value="REB_057"><label for="c30">배터리 교체(분배용)</label></td>
					</tr>
					</table>
				 </div>
				<h4>기타정비</h4> 
				<div class="w3-panel w3-topbar w3-bottombar w3-border-blue w3-pale-blue w3-padding-8"> 
			 		<table>
					<tr>
				 		<td><input  type="checkbox" class="w3-check"  id="c0" value="REB_001"><label for="c0">배터리 수리</label></td>
						<td><input  type="checkbox" class="w3-check"  id="c1" value="REB_002"><label for="c1">셀프락</label></td>
					</tr>
					<tr>
						<td><input  type="checkbox" class="w3-check"  id="c2" value="REB_003"><label for="c2">잠금장치 모터, 모터캠</label></td>
						<td><input  type="checkbox" class="w3-check"  id="c3" value="REB_004"><label for="c3">대여장치 PCB</label></td>
					</tr>
					<tr>
						<td><input  type="checkbox" class="w3-check"  id="c4" value="REB_005"><label for="c4">발전기</label></td>
						<td><input  type="checkbox" class="w3-check"  id="c5" value="REB_006"><label for="c5">시스템 케이블</label></td>
					</tr>
					<tr>
						<td><input  type="checkbox" class="w3-check"  id="c6" value="REB_029"><label for="c6">통신케이블</label></td>
						<td><input  type="checkbox" class="w3-check"  id="c7" value="REB_007"><label for="c7">잠금장치 덮개</label></td>
					</tr>
					<tr>
						<td><input  type="checkbox" class="w3-check"  id="c8" value="REB_008"><label for="c8">대여장치 덮개</label></td>
						<td><input  type="checkbox" class="w3-check"  id="c10" value="REB_010"><label for="c10">포크</label></td>
					</tr>
					<tr>
						<td><input  type="checkbox" class="w3-check"  id="c11" value="REB_011"><label for="c11">바퀴(림)</label></td>
						<td><input  type="checkbox" class="w3-check"  id="c12" value="REB_032"><label for="c12">벨</label></td>
					</tr>
					<tr>
						<td><input  type="checkbox" class="w3-check"  id="c13" value="REB_013"><label for="c13">바구니</label></td>
						<td><input  type="checkbox" class="w3-check"  id="c14" value="REB_012"><label for="c14">라이트</label></td>
					</tr>
					<tr>
						<td><input  type="checkbox" class="w3-check"  id="c15" value="REB_014"><label for="c15">구동부</label></td>
						<td><input  type="checkbox" class="w3-check"  id="c16" value="REB_015"><label for="c16">B.B</label></td>
					</tr>
					<tr>
						<td><input  type="checkbox" class="w3-check"  id="c17" value="REB_016"><label for="c17">크랭크, 페달</label></td>
						<td><input  type="checkbox" class="w3-check"  id="c19" value="REB_019"><label for="c19">스템</label></td>
					</tr>
					<tr>
						<td><input  type="checkbox" class="w3-check"  id="c20" value="REB_020"><label for="c20">핸들</label></td>
						<td><input  type="checkbox" class="w3-check"  id="c21" value="REB_021"><label for="c21">변속기</label></td>
					</tr>
					<tr>
						<td><input  type="checkbox" class="w3-check"  id="c22" value="REB_022"><label for="c22">안장</label></td>
						<td><input  type="checkbox" class="w3-check"  id="c24" value="REB_023"><label for="c24">브레이크</label></td>
					</tr>
					<tr>
						<td><input  type="checkbox" class="w3-check"  id="c25" value="REB_033"><label for="c25">싯포스트</label></td>
						<td><input  type="checkbox" class="w3-check"  id="c26" value="REB_030"><label for="c26">싯클램프,QR레버</label></td>
					</tr>
					<tr>
						<td><input  type="checkbox" class="w3-check"  id="c28" value="REB_027"><label for="c28">체인</label></td>
						<td><input  type="checkbox" class="w3-check"  id="c29" value="REB_028"><label for="c29">체인커버</label></td>
					</tr>
					<tr>
						<td><input  type="checkbox" class="w3-check"  id="c27" value="REB_025"><label for="c27">기타</label></td>
						<td></td>
					</tr>
					</table>
				</div> 
				 
			</fieldset>
		</form>
	</div>
	
	<script type="text/javascript" src="/js/common_barocle.js"></script>
    <script type="text/javascript">
	    $(function() {
	    	
	    	repairBikeInfo.mInit();
	   		repairBikeInfo.initBtn();
	   		var repairSeq = '${repairBikeInfo.repairSeq}' !== '' ? '${repairBikeInfo.repairSeq}' : '';
		    var bikeNo = '${repairBikeInfo.bikeNo}' !== '' ? '${repairBikeInfo.bikeNo}' : '${repairBike.bikeNo}';
		    var bikeId = '${repairBikeInfo.bikeId}' !== '' ? '${repairBikeInfo.bikeId}' : '${repairBike.bikeId}';
			var repairCodeList = '${repairBikeInfo.repairCodeList}' !== '' ? '${repairBikeInfo.repairCodeList}' : '';

			// 2019-02-01추가
			var adminId = '<%= com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil.getSessionAttribute(request, "usrId") %>';
			$("[name='adminId']").val(adminId);
			
			$("[name='bikeNo']").val(bikeNo);
			$("#_bikeNo").text(bikeNo);
			$("[name='bikeId']").val(bikeId);
			
	    });
	    
	    var lineCnt = 0;
	    var repairBikeInfo = {};
	    var mInit = {};
	    repairBikeInfo.centerId = '${repairBikeInfo.centerId}' !== '' ? '${repairBikeInfo.centerId}' : '';
	    repairBikeInfo.adminId = '${repairBikeInfo.adminId}' !== '' ? '${repairBikeInfo.adminId}' : '';
	    
		repairBikeInfo.mInit = function(){
    		
	    	if(!parent.opener || !parent.opener.bikeSearch || !parent.opener.bikeSearch.repairType){
	    	}else{
	    		mInit.bikeSearch = parent.opener.bikeSearch;
	    	}
	    	
    		if(!parent.bikeSearch || !parent.bikeSearch.repairType){
    		}else{
    			
    			mInit.bikeSearch = parent.bikeSearch;
    		}
	    }
	    
	    repairBikeInfo.initBtn = function(){
	    	var _this = repairBikeInfo;
	    	$("#moveRepairBikeList").on("click", this.moveRepairBikeList);
	    	$('#exeRepairBikeEdit').on("click", this.exeRepairBikeEdit);
	    	$('#moveNewMgmtPage').on("click",this.moveNewMgmtPage);
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

	    	$('[name="repairCode"]').val(repairCode);
    		$("#bikeReport").val($("#bikeReportTxt").val());
    		$("#repairReport").val($("#repairReportTxt").val());
    		$('#exeRepairBikeEdit').attr('disabled', true);
	    	    		
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
	          	    			mInit.bikeSearch.repairYn = "Y";
		          	    		alert("정상적으로 등록이 되었습니다.");
	          	    			self.close();
	          	        	} else {
	          	        		alert('오류가 발생하였습니다.');
	          	        		$('#exeRepairBikeEdit').attr('disabled', false);
	          	        	}
	          	        	
	    				}
              	}
  	        );
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