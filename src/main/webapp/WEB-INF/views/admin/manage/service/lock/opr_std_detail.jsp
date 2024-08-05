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
                        <form id="frm">
                            <input type="hidden"  name="dupCheck" value="N" />
                            <input type="hidden"  name="useYn"  value="Y" />
                            <%-- <input type="hidden"  name="locateId"  value="${armInfo.locateId}" />
                            <input type="hidden"  name="locateClsCd"  value="${armInfo.locateClsCd}" /> --%>
                            <input type="hidden"  name="locateId"  value="CC_111" />
                            <input type="hidden"  name="locateClsCd"  value="C" />
                            <input type="hidden"  name="viewFlg"  value="${arm.getViewFlg()}" />
                            <input type="hidden"  name="searchBgnDe"  value="${arm.getSearchBgnDe()}" />
                            <input type="hidden"  name="searchEndDe"  value="${arm.getSearchEndDe()}" />
                            <input type="hidden"  name="rackStatusCd"   value="" />
                            <fieldset>
                                <table  class="tb_type02 mt20">
                                    <colgroup>
                                        <col style="width:25%"/>
                                        <col style="width:75%"/>
                                    </colgroup>
                                    <tbody>
                                        <tr>
                                            <th class="top">거치대 ID</th>
                                            <td class="top">
                                                <span class="input-text03p"><input type="text" class="input-text03p" name="rackId" value="${ armInfo.rackId}"  <c:if test="${ armInfo.rackId ne null }">readonly="readonly" </c:if>/></span>
                                                <c:if test="${ armInfo.rackId eq null }">
                                                <button class="btnType02" id="dupCodeCheck" >중복확인</button>
                                                </c:if>
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
                                            <th>아파트 / 대여소</th>
                                            <td>
                                                <select class="select-category02" id="stationGrpSlt" name="stationGrpSeq">
                                                    <option value="">선택</option>
                                                </select>
                                                <span class="dash">/</span>
                                                <span class="pwtableblock">
                                                    <select class="select-category02" id="stationSlt" name="stationId">
                                                        <option value="">선택</option>
                                                    </select>
                                                </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>대여소 거치대 번호</th>
                                            <td>
                                                <span class="input-text09">
                                                    <input type="text" class="tr" maxlength="3" id="stationEquipOrder"  name="stationEquipOrder" required="required" value="${armInfo.stationEquipOrder }"/>
                                                </span>
                                                <p class="pwtableblock">(대여소에 설치된 순번 - 동일 대여소에서 중복 불가)</p>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th><em>*</em> 상태</th>
                                            <td>
                                                <select class="select-category02" id="statusSlt" disabled="disabled" >
                                                    <option value="">선택</option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>최종 정기 점검일</th>
                                            <td>
                                                <span class="input-text08"><input type="text" class="input-text08" name="lastChkDttm" value="${armInfo.lastChkDttm }" readonly /></span>
                                                <c:if test="${ arm.getViewFlg() eq 'U' }">
                                                <a href="<c:out value='/common/pop/DEV_004/showRegularChkPop.do'/>" id="regularChkPop" class="winNewPop modal btnType02" title="정기점검" data-width="450" data-height="590"  data-pmt="&equipmentId=${armInfo.rackId}&mode=U">정기점검</a>
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
                                                <span><input type="text" name="regDttm" value="${armInfo.regDttm}" readonly /></span>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                                <div class="btnArea">
                                    <span class="left"><button class="btnType01 bc_gray" id="moveListPage">목록</button></span>
                                    <span class="right"><button class="btnType01 bc_green" id="armEditExe" >저장</button></span>
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
    $(function() {
        armDetail.initBtn();
        armDetail.initCombo();
    });
    
    var armDetail = {};
    armDetail.locateClsCd = "${armInfo.locateClsCd}";
    armDetail.locateId = "${armInfo.locateId}";
    armDetail.rackStatusCd = "${armInfo.rackStatusCd}";
    armDetail.stationId = "";
    armDetail.stationGrpSeq = "";
    armDetail.stationEquipOrder = "${armInfo.stationEquipOrder }";
    armDetail.entrpsCd = '${armInfo.entrpsCd}';
    armDetail.viewFlg = '${arm.getViewFlg()}';
    armDetail.initBtn = function() {
        $("#dupCodeCheck").on("click", this.deviceIdDupFnc);
        $("#armEditExe").on("click  ", this.exeArmEdit);
        $("#moveListPage").on("click", this.clickMoveListPage);
        $("#stationGrpSlt").on("change", this.setStationCombo);
        $("#centerSlt").on("change", function() {
        	$("#stationGrpSlt").val('');
        	$("#stationSlt").val('');
        	$("#stationEquipOrder").val('');
        	armDetail.stationId  = "";
        	if(armDetail.viewFlg === "C") {
		        $("#statusSlt").val("RAS_004");
        	}
        });
       /*  $("[name='stationEquipOrder']").focusin( function(e){
        	$("[name='stationEquipOrder']").val("");
        }); */
    };
    armDetail.initCombo = function() {
    	 var _this = armDetail;
    	 if( _this.locateClsCd === 'S' ) {
             var s = _this.locateId.split("/");
             _this.stationGrpSeq = s[0];
             _this.stationId     = s[1];
         }
    	 /* if(_this.stationEquipOrder !== '' && _this.locateClsCd === 'S'){
    		 $("[name='stationEquipOrder']").val(_this.stationEquipOrder).attr('readonly', true);
    	 } */
    	 //센터 
         commonAjax.getCenterCode( 
                function(data) {
                    if(data !== null && data.centerList !== null) {
                    	$("#centerSlt option").not(':eq(0)').remove();
                        var pVal = _this.locateId;
                        if(_this.locateClsCd === "S") {
                            pVal = "";
                        }
                        commCdBox.makeComboBox('C', pVal, data.centerList, "centerSlt");
                    }
                }
         );
    	// 납품처 
         commonAjax.getCommonCode("ENT", function(data) {
             if(data !== null && data.codeList !== null) {
                 commCdBox.makeComboBox('CC',_this.entrpsCd, data.codeList, "entrpsSlt");
             }
         });
         //상태코드
         commonAjax.getCommonCode("RAS", function(data) {
             if(data !== null && data.codeList !== null) {
                 $("#statusSlt option").not(':eq(0)').remove();
                 commCdBox.makeComboBox('CC',_this.rackStatusCd,data.codeList, "statusSlt");
             }
         });
	     //스테이션 
	     commonAjax.getStationCode( 
              function(data) {
                  if(data != null && data.stationList != null) {
                      $("#stationGrpSlt option").not(':eq(0)').remove();
                      commCdBox.makeComboBox('S', _this.stationGrpSeq,data.stationList, "stationGrpSlt");
                      if(_this.locateClsCd === 'S') {
                          $("#stationGrpSlt").trigger("change");
                      }
                      
                  }
              }
      );
	     if( $("[name='viewFlg']").val() === 'U' ) {
	        	$("#entrpsSlt").prop('disabled', true);
	        }
    };
    
    armDetail.setStationCombo = function(e) {
    	var _this = armDetail;
    	if($("#centerSlt").val() !== '') {
	    	$("#centerSlt").val('');
    		if(armDetail.viewFlg === 'C') {
		    	$("#statusSlt").val("RAS_003");
    		}
    	}
    	$("#stationSlt option").not(":eq(0)").remove();
    	var tId = e.target.id;
        var idx = $("#"+tId+" option:selected").index();
        var subList =$("#"+tId).data().sub_data;
        var sltsubData = subList[(idx-1)];
        if(sltsubData !== undefined ) {
	        if(sltsubData.length > 0) {
	            commCdBox.makeComboBox("S", _this.stationId, sltsubData, "stationSlt");
	        }
        }
    };
    armDetail.exeArmEdit = function(e) {
    	e.preventDefault();
    	e.stopPropagation();
    	var _this = armDetail;
    	if(_this.inputValidChk()) {
    		if($("#centerSlt").val() !== '') {
                $("[name='locateClsCd']").val('C');
                $("[name='stationEquipOrder']").val('');
                $("[name='locateId']").val($("#centerSlt").val());
            }
            if($("#stationSlt").val() !== '') {
                $("[name='locateClsCd']").val('S');
                $("[name='locateId']").val($("#stationSlt").val());
            }
            $("[name='rackStatusCd']").val($("#statusSlt").val());
    		commonAjax.postAjax("/exeArmDeviceAjax.do", "json", $("#frm").serialize()
    			,function(data){
    		         if(data){
    		             if(data.checkResult > 0 ){
    		                  alert(data.resultMessage);
    		                  if(armDetail.viewFlg === 'C') {
	    		            	 _this.moveListPage();
    		                  }
    		             } else {
    		                 alert(data.resultMessage);
    		            	 if(data.checkResult === -1) {
    		            	     $("[name='stationEquipOrder']") .val("").focus();
    		                 } else {
    		            	     $("[name='dupCheck']").val("N");
    		                 }
	            		     return false;
    		             }
    		         }
    		    }
    		);
    	}
    	
    };
    armDetail.inputValidChk = function(){
    	
    	if($("#rackId").val() === '') {
    		alert("거치대 Id를 입력해 주세요.");
    		return false;
    	}
    	if(armDetail.viewFlg === 'C' && $("[name='dupCheck']").val() === 'N') {
            alert("거치대Id 중복체크를 해주세요.");
            return false;
        }
    	if($("#centerSlt").val() !== '' && $("#stationGrpSlt").val() !== '') {
    		alert("센터나 대여소 둘중에 하나만 선택해 주세요.");
    		$("#centerSlt").val('');
    		$("#stationGrpSlt").val('');
    		return false;
    	}
    	if($("#stationGrpSlt").val() !== '' && $("#stationSlt").val() == '') {
    		alert("대여소를 선택해 주세요.");
    		return false;
    	}
    	if($("#stationSlt").val() !== '' && $("[name='stationEquipOrder']").val() === '') {
            alert("거치대 번호를 입력 해주세요.");
            $("[name='stationEquipOrder']").focus();
            return false;
        }
    	
    	if($("[name='stationEquipOrder']").val() !== '' && !isNumeric($("[name='stationEquipOrder']").val())) {
    		alert("숫자 3자리까지 입력 가능합니다.");
    		return false;
    	}
    	
    	if($("#statusSlt").val() === ''){
    		alert("거치대 상태를 선택 해주세요.");
    		return false;
    	}
    	return true;
    };
    armDetail.clickMoveListPage = function(e) {
    	e.preventDefault();
    	e.stopPropagation();
    	var _this = armDetail;
    	_this.moveListPage();
    };
    armDetail.moveListPage = function() {
    	 $("[name='rackStatusCd']").val("${arm.getRackStatusCd()}");
         $("[name='stationGrpSeq']").val("${arm.getStationGrpSeq()}");
         $("[name='stationId']").val("${arm.getStationId()}");
         $("#frm").attr({action : "/getArmList.do", method : "post"}).submit();
    };
    armDetail.deviceIdDupFnc = function(e) {
        e.preventDefault();
        if( $("[name='rackId']").val() === "") {
            alert("단말기ID를 입력해 주세요.");
            return false;
        }
        if(!isAlNumber( $("[name='rackId']").val())) {
            alert("영문과 숫자여야 합니다.");
            $("[name='rackId']").val('').focus();
            return false;
        }
        commonAjax.postAjax("/arm/dupIdCheckAjax.do", "json", {rackId : $("[name='rackId']").val()}
        , function(data){
            if(data) {
                var result = (data.isDup === "true");
                if(result) {
                    alert("이미 등록된 거치대 입니다.");
                    $("[name='dupCheck']").val("N");
                    return false;
                } else {
                    alert("등록 가능한 거치대 입니다.");
                    $("[name='dupCheck']").val("Y");
                    return false;
                }
            }
            
        });
    };
    
    function setNewLastChkDttm(pChkDttm) {
    	$("[name='lastChkDttm']").val(pChkDttm);
    }
    </script>
</body>
</html>