<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta content="text/html; charset=KSC5601" http-equiv="content-type" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" /> 
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />
<meta name="description=" Content="" />
<title><tiles:insertAttribute name="title"/></title>
<tiles:insertAttribute name="resource"/>
<script type="text/javascript" src="/js/common_barocle.js"></script>
<script type="text/javascript">
	$(function() {
		
		if("${result }" != ""){
			alert("${result}")
		}
		
		
		if("${cmd}" == "INFO"){
			
			"<c:forEach items='${stationName }' var='lang'>"
			
				$("#"+"${lang.lang_cls_cd}").val("${lang.station_name}");
			"</c:forEach>"
			
			$("#checkName").val($("#LAG_001").val());
			
			
			if("${info.device_id}" != ""){
				$("select[name=device_id]").append("<option value='${info.device_id}' selected>${info.device_id}");
			}
			
			//$("#addCode").on("click",this.clickAddCodeFormFnc);
			 commcodeEdit.initBtn('');
		}
		
	});
	
	var doubleClick = true;
	
	function fn_update( id ){
		$("#cmd").val("UPDATE");
		$("#station_id").val(id);
		
		if (confirm('<spring:message code="common.save.msg"/>')){
			$("#frm").attr({method : "post", action : "/admin/manage/station/stationModify.do"}).submit();
		}
		
	}
	
    
    var commcodeEdit = {};
    commcodeEdit.subBoxSize = parseInt('${fn:length(beaconList)}');
    //commcodeEdit.comUpCd = '${codeVO.comCd}';
    commcodeEdit.initBtn = function(pUpCd) {
        $("#comCd").focusin(function() {
            $("#comCd").val('');
            $("#dupCheck").val('N');
        });
       
        $("#dupCodeCheck").on("click",this.dupCodeCheckFnc);
        $("#moveListBtn").on("click",function(e) {
        	e.preventDefault();
        	e.stopPropagation();
            $("#frm").attr({method : 'post', action: "<c:url value='/getCommonCodeList.do'/>"}).submit();
        });
        $("#dataEditBtn").on("click",this.dataEditExecFnc);
        $("#addCode").on("click",this.clickAddCodeFormFnc);
        
        
        $("#dupSerialChk").on("click",{ type : "serial"}, this.beaconDupChkFnc);
        
        
    };
    
    commcodeEdit.clickAddCodeFormFnc = function(e) {
    	e.preventDefault();
        e.stopPropagation();
        this.blur();
    	var _this = commcodeEdit;
        _this.addCodeFormFnc();
    };
    commcodeEdit.chkNumber = function(e) {
    	var r = numbersonly(e,false);
    	if(!r){
    		alert('숫자만 입력 가능합니다.');
    		$(this).val('');
    		return false;
    	}
    };
    commcodeEdit.removeBox = function(e) {
    	var _this = commcodeEdit;
    	e.preventDefault();
        e.stopPropagation();
        $(this).parent().parent().remove();
        _this.subBoxSize -= 1;
    };
    commcodeEdit.addCodeFormFnc = function(){
    	var _this = commcodeEdit;
        var rIdx    = parseInt(_this.subBoxSize);
        var $cloneDiv = $("#cloneDiv .questionBox").clone();
        var upCode = _this.comUpCd;
        var surffix = "_00"+(rIdx +1);
        if(rIdx > 8) {
            surffix = "_0"+(rIdx +1);
        }
        upCode  = upCode+surffix;
        $cloneDiv.find("table").addClass('tb_type02'); 
        $cloneDiv.find("button").on("click", _this.removeBox);
        if(rIdx === 0) {
            
        	$cloneDiv.find("table tr").eq(1).find("input:hidden").eq(1).val(upCode);
        	$cloneDiv.find("table tr").eq(1).find("input:text").on('keyup',_this.chkNumber);
          
        	$(".questionBoxWrap").append($cloneDiv);
            
        } else {
        	
        	$cloneDiv.find("table tr").eq(1).find("input[type='text']").eq(0).attr('name', 'beaconList['+rIdx+'].deviceId');
        	$cloneDiv.find("table tr").eq(1).find("input[type='text']").eq(0).attr('id', 'beaconList['+rIdx+'].deviceId');
        	
        	//$cloneDiv.find("table tr").eq(2).find("input[type='hidden']").eq(0).attr('name', 'beaconList['+rIdx+'].beaconId');
        	
        	$cloneDiv.find("table tr").eq(2).find("input[type='text']").eq(0).attr('name', 'beaconList['+rIdx+'].serialNo');
        	$cloneDiv.find("table tr").eq(2).find("input[type='text']").eq(0).attr('id', 'SserialNo'+rIdx);
        	
        	$cloneDiv.find("table tr").eq(2).find("a").eq(0).attr('id', rIdx);
        	 
        	
           $(".questionBoxWrap").first().prepend($cloneDiv);
            
        }
        _this.subBoxSize +=1;
    };
    
    
    
function fn_beaconDupChkFnc(serialNo ,mode){
		
	
	if( $("#beaconList["+serialNo+"].serialNo").val() === '' ) {
        alert("체크 할 ID를 입력 해주세요.");
        return;
    }
	
	if(!isAlNumber($("#SserialNo"+serialNo).val())) {
        alert("영문,숫자로만 입력 해주세요.");
        $("#deviceId").val('').focus();
        return;
    }
	
	var lengthChk = $("#SserialNo"+serialNo).val();
	if( lengthChk.length < 14 ) {
        alert("체크 할 ID를 14자리로 해주세요.");
        return;
    }
	
    var chkId = $("#SserialNo"+serialNo).val();
    var type ="serial";
    var oldDeviceId = "";
 
    if(mode =='update'){
    	oldDeviceId = $("[name='beaconList["+serialNo+"].deviceId']").val();
    	
    }
		
    commonAjax.postAjax(
            "<c:out value='/beacon/dupIdCheckAjax.do'/>"
            , "json"
            , { chkId : chkId , chkType : type }
            , function(data){
                  if(data) {
                      if((data.isDup === "true")) {
                    	
                    	  if(data.resultVo != null && data.resultVo.nowLocateId !=null && data.resultVo.nowLocateId !=''){
                    		  
	                    	  if(confirm(data.resultVo.stationName+data.resultVo.centerName+ '에 이미 등록된 비콘입니다 변경하시겠습니까?')) {
	                    		  $('#SdeviceId'+serialNo).val(data.resultVo.deviceId);
	                    		  
	                    		  //바로 등록 ㄱㄱ
	                    		fn_matchingBeacon(data.resultVo.deviceId,oldDeviceId);
	                          } else {
	                        	  
	                          }
                    	  } else {
                    		  $('#SdeviceId'+serialNo).val(data.resultVo.deviceId);
                    		  fn_matchingBeacon(data.resultVo.deviceId,oldDeviceId);
                    	  }
                          
                      } else {
                          alert("등록 되지 않은 시리얼 번호 입니다.");
                      }
                  }                
              }
        );
	
	}
	
function fn_matchingBeacon(deviceId, oldDeviceId){
	var station_id ='${info.station_id}';
	commonAjax.postAjax(
            "<c:out value='/beacon/matchingBeaconAjax.do'/>"
            , "json"
            , { stationId : station_id, deviceId : deviceId, oldDeviceId : oldDeviceId }
            , function(data){
                      
                         location.reload(); 
                      
              }
        );
}

function fn_matchingBeacon2(deviceId, oldDeviceId){
	
	deviceId = $("#SserialNo"+deviceId).val();
	
	commonAjax.postAjax(
            "<c:out value='/beacon/delConnBeaconAjax.do'/>"
            , "json"
            , {deviceId : deviceId}
            , function(data){
            	if(data.checkResult > 0){
    				alert(data.resultMessage);
    				location.reload();
    			}
                      
              }
        );
}



</script>

<script type="text/javascript">
	 String.prototype.trim = function(){
	      return this.replace(/\s/g, "");
	  }

</script>

</head>
<body>
	<div class="allwrap">
			<tiles:insertAttribute name="header" />
		
			<tiles:insertAttribute name="head" />
		<div id="body">
			<div class="cont">
					<tiles:insertAttribute name="left" />
			<form action="" method="post"	name="frm" id="frm"  enctype="multipart/form-data">
		
		
		
				<div class="content">
					<div class="subject">
						<!--subject path S-->
							<tiles:insertAttribute name="subject" />
						<!--subject path E-->
					</div>
					<div class="page">
							<fieldset>
								 <div id="childDiv">
                                    <p class="head ttbtncase1">설치 비콘<span><button type="button" class="btnType05" id="addCode">추가</button></span></p>
	                                <div class="questionBoxWrap">
	                                    <c:forEach var="result"  items="${beaconList}" varStatus="loop">
	                                        <div class="questionBox">
		                                        <div class="addStwrap">
		                                            <table class="tb_type02">
		                                                <colgroup>
		                                                    <col style="width:25%"/>
		                                                    <col style="width:75%"/>
		                                                </colgroup>
		                                                <tbody>
		                                                    <tr>
                                                                <th class="top">코드</th>
                                                                <td class="top">
                                                                    <span class="input-text07"><input type="text" name="beaconList[${loop.index}].deviceId" id="beaconList[${loop.index}].deviceId" readonly="readonly" value="<c:out value='${result.deviceId }'/>" /></span>
                                                                </td>
                                                            </tr>
			                                                <tr>
			                                                    <th>시리얼 번호</th>
			                                                    <td>
			                                                        <span class="input-text07">
			                                                            <input type="text"  name="beaconList[${loop.index}].serialNo" id="SserialNo${loop.index}" placeholder="코드설명1" value="<c:out value='${result.serialNo }'/>"/> 
			                                                            <a href="#" id="${loop.index}" onclick="fn_beaconDupChkFnc([this.id],'update');return false;">저장</a>
			                                                            <a href="#" id="${loop.index}" onclick="fn_matchingBeacon2([this.id],'delete');return false;">삭제</a>
			                                                        </span>
			                                                    </td>
			                                                </tr>
			                                                
		                                               </tbody>
		                                           </table>
		                                       </div>
	                                       </div>
	                                   </c:forEach>
	                                </div>
                                </div>
								
								<div class="btnArea">
									
									<c:if test="${cmd == 'INFO'}">
										<span class="right" onclick="fn_update('${info.station_id}'); return false;"><button class="btnType01 bc_green">저장</button></span>
									</c:if>
								</div>
							</fieldset>
							</div>
							</div>
						</div>
				</form>
				<!--content E-->
			</div>
		</div>
	</div>
	<!--하위코드 추가용 clone  -->
    <section id="cloneDiv" style="display: none;" >
        <div class="questionBox" >
	        <div class="btn_delQ"><button class="btnType04" ><img src="/images/btn_delQ.png" alt="" /></button></div>
	        <div class="addStwrap">
		        <table>
	                <colgroup>
	                    <col style="width:25%"/>
	                    <col style="width:75%"/>
	                </colgroup>
	                <tr style="display: none;"></tr>
		            <tr>
                                   <th class="top">코드</th>
                                   <td class="top">
                                       <span class="input-text07"><input type="text" name="" id="" readonly="readonly" value="" /></span>
                                   </td>
                               </tr>
                      <!-- <tr>
                          <th>순서</th>
                          <td style="display: none" >
            			   <input type="hidden" name="beaconList[0].beaconId" value="0"/>
          				 </td>
                          <td>
                              <span class="input-text07">&nbsp;</span>
                          </td>
                      </tr> -->
                      <tr>
                          <th>시리얼 번호</th>
                          <td>
                             <span class="pwtableblock">
                                  <input type="text"  name="beaconList[0].serialNo" id="SserialNo0" placeholder="시리얼 번호" value=""/>
                                 
                                  <a href="#" id="0" onclick="fn_beaconDupChkFnc([this.id],'insert');return false;">저장</a>
                                  <!-- <a href="#" id="0" onclick="fn_matchingBeacon2([this.id],'delete');return false;">삭제</a> -->
                                  </span>
                                 
                                  
                          </td>
                          
                      </tr>
		        </table>
	        </div>
        </div>
        </section>
</body>
</html>

