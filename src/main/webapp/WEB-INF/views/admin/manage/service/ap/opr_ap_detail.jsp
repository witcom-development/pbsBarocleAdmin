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
                <!--conteent S-->
                <div class="content">
                    <div class="subject">
                       <!--subject path S-->
                        <tiles:insertAttribute name="subject" />
                        <!--subject path E-->
                    </div>
                    <div class="page">
                        <form id="frm" name="frm" >
                            <input type="hidden"  name="dupApCheck" value="N" />
                            <input type="hidden"  name="dupSerailCheck" value="N" />
                            <input type="hidden"  name="useYn"  value="Y" />
                            <input type="hidden"  name="locateId"  value="${apVo.locateId}" />
                            <input type="hidden"  name="locateClsCd"  value="${apVo.locateClsCd}" />
                            <input type="hidden"  name="ipV4"  value="" />
                            <input type="hidden"  name="viewFlg"  value="${ap.getViewFlg()}" />
                            <input type="hidden"  name="searchBgnDe"  value="${ap.getSearchBgnDe()}" />
                            <input type="hidden"  name="searchEndDe"  value="${ap.getSearchEndDe()}" />
                            <fieldset>
                                <table  class="tb_type02 mt20">
                                    <caption>무선 AP</caption>
                                    <colgroup>
                                        <col style="width:25%"/>
                                        <col style="width:75%"/>
                                    </colgroup>
                                    <tbody>
                                        <tr>
                                            <th class="top"><em>*</em>무선AP ID</th>
                                            <td class="top">
                                                <span class="input-text08"><input type="text"  id="deviceId" name="deviceId" class="input-text08" maxlength="12" value="${apVo.deviceId}"  <c:if test="${apVo.deviceId  ne null }">readonly="readonly" </c:if>/></span>
                                                <c:if test="${ apVo.deviceId eq null }">
                                                <button class="btnType02" id="dupCodeCheck" >중복확인</button>
                                                </c:if>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th><em>*</em>시리얼 넘버</th>
                                            <td>
                                                <span class="input-text07"><input type="text" id="serialNo" name="serialNo" class="input-text07"  value="${apVo.serialNo}" /></span>
                                                <c:if test="${ apVo.serialNo eq null }">
                                                <button class="btnType02" id="dupSerialChk" >중복확인</button>
                                                </c:if>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>아파트/명</th>
                                            <td>
                                                <select class="select-category08" id="stationGrpSlt">
                                                    <option value="">선택</option>
                                                </select>
                                                <select class="select-category02" id="stationSlt" >
                                                    <option value="">선택</option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>센터</th>
                                            <td>
                                                <select class="select-category02" id="centerSlt" name="centerId">
                                                    <option value="">선택</option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th><em>*</em>상태</th>
                                            <td>
                                                <select class="select-category02" id="statusSlt" name="deviceStatusCd">
                                                    <option value="">선택</option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>무선 AP IP</th>
                                            <td>
                                                <span class="input-text09"><input type="text" class="input-text09" maxlength="3"  name="ip4"/></span>
                                                <span class="input-text09"><input type="text" class="input-text09" maxlength="3"  name="ip4"/></span> 
                                                <span class="input-text09"><input type="text" class="input-text09" maxlength="3"  name="ip4"/></span> 
                                                <span class="input-text09"><input type="text" class="input-text09" maxlength="3"  name="ip4"/></span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>최종 정기 점검일</th>
                                            <td>
                                                <span class="input-text08"><input type="text" id="lastChkDttm" name="lastChkDttm" class="input-text08" value="${apVo.lastChkDttm }"  readonly="readonly"/></span>
                                                <c:if test="${ ap.getViewFlg() eq 'U' }">
                                                <a href="<c:out value='/common/pop/DEV_003/showRegularChkPop.do'/>" class="winNewPop modal btnType02" title="정기점검" data-width="450" data-height="590"  data-pmt="&equipmentId=${apVo.deviceId}&mode=U">정기점검</a>
                                                </c:if>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>납품처</th>
                                            <td>
                                                <select class="select-category02" name="entrpsCd" id="entrpsSlt">
                                                    <option value="">선택</option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>등록일</th>
                                            <td>
                                                <span><input type="text" name="regDttm" value="${apVo.regDttm}" readonly /></span>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                                <div class="btnArea">
                                    <span class="left"><button type="button" class="btnType01 bc_gray" id="moveListBtn">목록</button></span>
                                    <span class="right"><button type="button" class="btnType01 bc_green" id="dataEditBtn">저장</button></span>
                                    <span class="right"><button type="button" class="btnType01" id="nmsBtn">NMS</button></span>
                                </div>
                            </fieldset>
                        </form>
                    </div>
                </div>
                <!--conteent E-->
            </div>
        </div>
        <!--footer S-->
        <tiles:insertAttribute name="footer" />
        <!--footer E-->
    </div>
    <script type="text/javascript" src="/js/common_barocle.js"></script>
    <script type="text/javascript">
    $(function(){
        apForm.initBtn();
        apForm.initCommonCode();
    });
    var apForm = {};
    apForm.locateId = "${apVo.locateId}";
    apForm.locateClsCd = "${apVo.locateClsCd}";
    apForm.statusCd = "${apVo.deviceStatusCd}";
    apForm.ip = "${apVo.ipV4}";
    apForm.staionGrp = "";
    apForm.staionId = "";
    apForm.entrpsCd = '${apVo.entrpsCd}';
    apForm.viewType = '${ap.getViewFlg()}';
    apForm.initBtn = function() {
        //nms버튼 클릭.
        $("#nmsBtn").on("click", function() {
            $("#frm").attr({action : "", target : "_blank"}).submit();
        });
        $("#dupCodeCheck").on("click",{ type : "ap"} ,this.apDupChkFnc);
        $("#moveListBtn").on("click", this.exeList );
        $("#dataEditBtn").on("click", this.editDataExcFnc);
        $("#dupSerialChk").on("click",{ type : "serial"}, this.apDupChkFnc);
        $("#deviceId").on('focusin', function(e){
        	if(apForm.viewType === "C") {
	        	if( $("[name='dupApCheck']").val() === "Y") {
	        		$("[name='dupApCheck']").val('N');
	        	}
	        	$("#deviceId").val('');
        	}
        });
        $("#serialNo").on('focusin', function(e){
            if(apForm.viewType === 'C') {
	        	if( $("[name='dupSerailCheck']").val() === "Y") {
	                $("[name='dupSerailCheck']").val('N');
	            }
	            $("#serialNo").val('');
            }
        });
 
       $("#stationGrpSlt").on('change', function(e){
            e.preventDefault();
            if($("#centerSlt").val() !== '') {
                $("#centerSlt").val('');
            }
            if(apForm.viewType === 'C') {
	            if( $("#stationGrpSlt").val() === ""){
		            $("#statusSlt").val('');
	            } else {
		            $("#statusSlt").val('APS_003');
	            }
            }
            var tId = e.target.id;
            var idx = $("#"+tId+" option:selected").index();
            var subList =$("#"+tId).data().sub_data;
            
            var sltsubData = subList[(idx-1)];
            if(sltsubData !== undefined) {
                if(sltsubData.length > 0) {
                    var cVal = apForm.staionId;
                    commCdBox.makeComboBox("S",cVal, sltsubData, "stationSlt");
                }
            }
        });
        
        $("#centerSlt").on('change',{viewType : '${ap.getViewFlg()}'}, function(e){
            e.preventDefault();
            if( $("#centerSlt").val() === '') {
                $("#statusSlt").val('');
            } else {
                $("#statusSlt").val('APS_004');
                if($("#stationGrpSlt").val() !== '') {
                    $("#stationGrpSlt").val('');
                    $("#stationSlt").val('');
                }
            }
        });
        
        if( $("[name='viewFlg']").val() === 'U' ) {
        	$("#entrpsSlt").prop('disabled', true);
        }
    };
    apForm.exeList = function(e) {
        e.preventDefault();
        apForm.moveList();       
    };
    //목록페이지 이동.
    apForm.moveList = function() {
        $("#statusSlt").val('');
        $("#frm").attr({action : '<c:out value="/getApList.do"/>', method : 'post'}).submit();
    };
    apForm.initCommonCode = function() {
        var _this = apForm;
        if(_this.locateClsCd === 'S') {
            var s = _this.locateId.split("/");
            _this.staionGrp = s[0];
            _this.staionId = s[1];
        }
        //상태코드
        commonAjax.getCommonCode("APS", function(data) {
             if(data !== null && data.codeList !== null) {
                 commCdBox.makeComboBox('CC',_this.statusCd,data.codeList, "statusSlt");
             }
        });
        //스테이션 
        commonAjax.getStationCode( 
               function(data) {
                   if(data !== null && data.stationList !== null ) {
                     var ccVal = _this.staionGrp;
                     commCdBox.makeComboBox('S', ccVal, data.stationList, "stationGrpSlt");
                     if(_this.locateClsCd === 'S') {
                         $("#stationGrpSlt").trigger("change");
                     }
                   }
               }
        );
        //센터 
        commonAjax.getCenterCode( 
                function(data) {
                    if(data !== null && data.centerList !== null) {
                        commCdBox.makeComboBox('C', _this.locateId, data.centerList, "centerSlt");
                    }
                }
        );
        // 납품처 
        commonAjax.getCommonCode("ENT", function(data) {
            if(data !== null && data.codeList !== null) {
                commCdBox.makeComboBox('CC',_this.entrpsCd, data.codeList, "entrpsSlt");
            }
        });
        if(_this.ip !== '') {
            var ips = _this.ip.split(".");
            var iSize = ips.length;
            
            for(var i=0; i< iSize; i+=1) {
                $("[name='ip4']").eq(i).val(ips[i].trim());
            }
        }
    };
  
    apForm.apDupChkFnc = function(e) {
        e.preventDefault();
        e.stopPropagation();
        var type = e.data.type;
        var typeName = e.data.type === "ap" ? "아이디"  : "시리얼";
        var chkId = "";
        if(type === "ap") {
            if( $("#deviceId").val() === '' ) {
                alert("체크 할 ID를 입력 해주세요.");
                return;
            }
            if(!isAlNumber($("#deviceId").val())) {
                alert("영문,숫자로만 입력 해주세요.");
                $("#deviceId").val('').focus();
                return;
            }
            chkId = $("#deviceId").val();
        } else {
            if( $("#serialNo").val() === '' ) {
                alert("체크 할 ID를 입력 해주세요.");
                return;
            }
            if(!isAlNumber($("#serialNo").val())) {
                alert("영문,숫자로만 입력 해주세요.");
                $("#serialNo").val('').focus();
                return;
            }
            chkId = $("#serialNo").val();
        }
      
        commonAjax.postAjax(
            "<c:out value='/ap/dupIdCheckAjax.do'/>"
            , "json"
            , { chkId : chkId , chkType : type }
            , function(data){
                  if(data) {
                      if((data.isDup === "true")) {
                          if(type === "ap") {
                              $("[name='dupApCheck']").val("N");
                              $("#deviceId").val('').focus();
                          } else {
                              $("[name='dupSerailCheck']").val("N");
                              $("#serialNo").val('').focus();
                          }
                          alert("<spring:message code ='fail.dup.id' arguments='"+typeName+"'/>");
                      } else {
                          if(type === "ap") {
                              $("[name='dupApCheck']").val("Y");
                          } else {
                              $("[name='dupSerailCheck']").val("Y");
                          }
                          alert("<spring:message code ='success.dup.id' arguments='"+typeName+"'/>");
                      }
                  }                
              }
        );
    };
    
    apForm.editDataExcFnc = function(e) {
        var _this = apForm;
        //대여소 혹은 센터 둘중 하나만 입력이 가능
        e.preventDefault();
        e.stopPropagation();
        var chk = 0;
        if($("#deviceId").val() === '') {
            alert("무선 AP Id를 입력해 주세요.");
            $("[name='dupCheck']").val("N");
            return false;
        } 
        if(apForm.viewType === 'C' && $("[name='dupApCheck']").val() === 'N') {
            alert("ID중복 확인 체크를 해주세요.");
            return false;
        }
        if($("#serialNo").val() === '') {
            alert("시리얼 번호를 입력해주세요.");
            return false;
        }
        if(!isAlNumber($("#serialNo").val())) {
            alert("시리얼 넘버는 영문,숫자 조합입니다.");
            $("#serialNo").val('').focus();
            return;
        }
        if(apForm.viewType === 'C' && $("[name='dupSerailCheck']").val() === 'N') {
            alert("시리얼 중복 확인 체크를 해주세요.");
            return false;
        }
       
        if( $("#stationGrpSlt").val() !== ''  && $("#stationSlt").val() === '') {
            alert("대여소명을 선택해 주세요.");
            return false;
        }
        if($("#stationSlt").val() === '' && $("#centerSlt").val() === '' ) {
            alert("대여소 또는 센터를 선택해주세요.");
            return false;
        }
        if($("#statusSlt").val() === '') {
            alert("상태를 선택해 주세요.");
            return false;
        }
        if( $("#stationSlt").val() !== '' && $("#statusSlt").val() === 'APS_004') {
            alert("대여소 선택시 상태가 '센터보관'이어서는 안됩니다.");
            return false;
        }
        if($("#stationSlt").val() !== '') {
            $("[name='locateClsCd']").val('S');
            $("[name='locateId']").val($("#stationSlt").val());
        } else if($("#centerSlt").val() !== '') {
        	$("[name='locateClsCd']").val('C');
            $("[name='locateId']").val($("#centerSlt").val());
        }
       
      
        var ipStr = [];
        $("[name='ip4']").each(function () {
            if(this.value !== "") {
                if(!isNumeric(this.value)){
                    alert('AP IP를 확인해주세요.');
                    chk++;
                    return false;
                }
                ipStr.push(this.value.trim());
                chk=0;
            }
        });
       
        if(ipStr.length > 0) {
            $("[name='ipV4']").val(ipStr.join("."));
        }
        
        if($("#lastChkDttm").val() === '') {
             var today = DateUtil.dateFmt(new Date());     
            $("#lastChkDttm").val(today);
        }
        if(chk === 0) {
           commonAjax.postAjax("<c:out value='/exeAPDeviceAjax.do'/>", 'json', $("#frm").serialize()
                ,function(data){
                     if(data !== null && data.checkResult > 0) {
                         alert(data.resultMessage);
                         if(apForm.viewType === 'C') {
                             _this.moveList();
                         }
                     } else {
                         alert(data.resultMessage);
                     }
                 }
            );
        }
    };
    function setNewLastChkDttm(pChkDttm) {
        $("[name='lastChkDttm']").val(pChkDttm);
    }
    //apForm.data
    </script>
</body>
</html>