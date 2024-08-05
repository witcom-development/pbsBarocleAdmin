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
                        <div class="tabWrap type3">
                            <ul class="tabBox">
                                <li class="tab on"><button type="button" id="tabFirst">상세정보</button></li>
                                <li class="tab"><button type="button" id="tabLast">이력정보</button></li>
                            </ul>
                            <div class="tabCon on">
                                <form id="frm">
                                    <input type="hidden"  name="dupDevChk"    value="N" />
                                    <input type="hidden"  name="dupSerialChk" value="N" />
		                            <input type="hidden"  name="bikeId"  value="" />
		                            <input type="hidden"  name="useYn"   value="Y" />
		                            <input type="hidden"  name="tabNum"  value="${terminal.getTabNum() == null ? '1' : terminal.getTabNum()  }" />
		                            <input type="hidden"  name="locateId"  value="${terminalVo.locateId}" />
		                            <input type="hidden"  name="locateClsCd"  value="${terminalVo.locateClsCd}" />
		                            <input type="hidden"  name="viewFlg" value="${terminal.getViewFlg() }"/>
                                    <input type="hidden"  name="searchBgnDe"  value="${terminal.getSearchBgnDe()}" />
                                    <input type="hidden"  name="searchEndDe"  value="${terminal.getSearchEndDe()}" />
                                    <input type="hidden"  name="deviceStatusCd"  value="${terminal.deviceStatusCd}" />
                                    <input type="hidden"  name="searchVal"  value="${terminalVo.bikeNo}" />
		                            
                                        <table class="tb_type02 mt20">
                                            <caption>단말기 ID</caption>
                                            <colgroup>
                                                <col style="width:25%"/>
                                                <col style="width:75%"/>
                                            </colgroup>
                                            <tbody>
                                                <tr>
                                                    <th class="top"><em>*</em>단말기 ID</th>
                                                    <td class="top">
                                                        <span class="input-text03p"><input type="text" class="input-text03p" id="deviceId" name="deviceId" maxlength="14" value="${terminalVo.deviceId}"  <c:if test="${terminalVo.deviceId  ne null }">readonly="readonly" </c:if>/></span>
                                                        <c:if test="${ terminalVo.deviceId eq null }">
			                                                <button class="btnType02" id="dupCodeCheck" >중복확인</button>
			                                            </c:if>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th><em>*</em>시리얼넘버</th>
                                                    <td>
                                                        <span class="input-text07"><input type="text" class="input-text07" id="serialNo" name="serialNo"  value="${terminalVo.serialNo}"  /></span>
                                                        <c:if test="${ terminalVo.deviceId eq null }">
                                                            <button class="btnType02" id="dupSerialChk" >중복확인</button>
                                                        </c:if>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th>자전거 번호</th>
                                                    <td>
                                                        <span class="input-text08"><input type="text" id="bikeNo" name="bikeNo" value="${ terminalVo.bikeNo }"  readonly="readonly"/></span>
                                                        <a href="/common/pop/DEV_001/showFODevicePop.do" id="searchBikeBtn" class="winNewPop modal btnType02" title="자전거찿기" data-width="450" data-height="480" data-pmt="&searchType=T">검색</a>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th>센터</th>
                                                    <td>
                                                        <select class="select-category02" id="centerSlt"  name="centerId" >
                                                            <option value="">선택</option>
                                                        </select>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th><em>*</em>상태</th>
                                                    <td>
                                                        <select id="statusSlt" class="select-category02">
                                                            <option value="">선택</option>
                                                        </select>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th><em>*</em>단말기 구분</th>
                                                    <td>
                                                        <select id="deviceModlCd" name="deviceModlCd" class="select-category02">
                                                            <option value="">선택</option>
                                                            <option value="DM2" <c:if test="${terminalVo.deviceModlCd == 'DM2'}">selected="selected"</c:if>>기존단말기</option>
                                                            <option value="DM4" <c:if test="${terminalVo.deviceModlCd == 'DM4'}">selected="selected"</c:if>>QR단말기</option>
                                                        </select>
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
                                                <c:if test="${ terminal.viewFlg eq 'U' }">
                                                <tr>
                                                    <th>펌웨어 버전</th>
                                                    <td>
                                                        <span class="input-text12"><input type="text" id="softWareFw" name="softWareFw" maxlength="6" value="${terminalVo.softWareFw}"/></span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th>이미지 버전</th>
                                                    <td>
                                                        <span class="input-text12"><input type="text" id="imageFW" name="imageFW" maxlength="6" value="${terminalVo.imageFW}"/></span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th>음성 버전</th>
                                                    <td>
                                                        <span class="input-text12"><input type="text" id="voiceFW"  name="voiceFW" maxlength="6" value="${terminalVo.voiceFW}"/></span>
                                                    </td>
                                                </tr>
		                                        <tr>
		                                            <th>배터리 정보</th>
		                                            <td>
		                                                <span class="input-text12">
		                                                <c:choose>
				                                    		<c:when test="${terminalVo.batteryStusCd eq 'BAT_001'}">완충</c:when>
				                                    		<c:when test="${terminalVo.batteryStusCd eq 'BAT_002'}">2/3</c:when>
				                                    		<c:when test="${terminalVo.batteryStusCd eq 'BAT_003'}">1/3</c:when>
				                                    		<c:when test="${terminalVo.batteryStusCd eq 'BAT_004'}">방전</c:when>
				                                    		<c:otherwise>${terminalVo.batteryStusCd } &nbsp;&nbsp;(단위 : %)</c:otherwise>
				                                    	</c:choose>
		                                               </span>
		                                            </td>
		                                        </tr>
		                                        <tr>
		                                            <th>현재 대여 상태</th>
		                                            <td>
		                                                <span class="input-text12">
		                                                	<c:choose>
					                                    		<c:when test="${terminalVo.bikeStusCd eq 'BKS_001'}">장애</c:when>
					                                    		<c:when test="${terminalVo.bikeStusCd eq 'BKS_002'}">폐기</c:when>
					                                    		<c:when test="${terminalVo.bikeStusCd eq 'BKS_003'}">정상(대기중)</c:when>
					                                    		<c:when test="${terminalVo.bikeStusCd eq 'BKS_004'}">센터보관</c:when>
					                                    		<c:when test="${terminalVo.bikeStusCd eq 'BKS_005'}">수리중</c:when>
					                                    		<c:when test="${terminalVo.bikeStusCd eq 'BKS_007'}">분실</c:when>
					                                    		<c:when test="${terminalVo.bikeStusCd eq 'BKS_008'}">Cascade</c:when>
					                                    		<c:when test="${terminalVo.bikeStusCd eq 'BKS_009'}">수리완료</c:when>
					                                    		<c:when test="${terminalVo.bikeStusCd eq 'BKS_010'}">대여중</c:when>
					                                    		<c:when test="${terminalVo.bikeStusCd eq 'BKS_011'}">배치이동</c:when>
					                                    		<c:when test="${terminalVo.bikeStusCd eq 'BKS_012'}">강제반납</c:when>
					                                    		<c:when test="${terminalVo.bikeStusCd eq 'BKS_013'}">상차</c:when>
					                                    		<c:when test="${terminalVo.bikeStusCd eq 'BKS_014'}">입고</c:when>
					                                    		<c:when test="${terminalVo.bikeStusCd eq 'BKS_015'}">출고</c:when>
					                                    	</c:choose>
		                                                </span>
		                                            </td>
		                                        </tr>
		                                        <tr>
		                                            <th>고장상태</th>
		                                            <td>
		                                                <span class="input-text12">${terminalVo.errStusCdName}
		                                                	<c:if test="${terminalVo.errStusCdName != null and terminalVo.errStusCdName ne ''}">&nbsp;&nbsp;
		                                                		<button class="btnType05 bc_blue" id="moveInspectList">장애페이지로 이동</button>
		                                                	</c:if>
		                                                </span>
		                                            </td>
		                                        </tr>
		                                        <tr>
		                                            <th>등록일</th>
		                                            <td>
		                                                <span class="input-text12"><input type="text" name="regDttm" value="${terminalVo.regDttm}" readonly /></span>
		                                            </td>
		                                        </tr>
                                                </c:if>
                                            </tbody>
                                        </table>
                                        <div class="btnArea">
                                            <span class="left"><button class="btnType01 bc_gray" id="moveListPage">목록</button></span>
                                            <span class="right"><button class="btnType01 bc_green" id="termianlEditExe" >저장</button></span>
                                        </div>
                                    </fieldset>
                                </form>
                            </div>
                            <div class="tabCon">
                                <div class="shBox_m">
                                    <div class="downtitle">
                                        <div class="title">
                                            <p>검색조건</p><span><button><img src="/images/srh_open.png" alt="검색조건 열기"></button></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="shBox">
                                    <form id="infoFrm">
                                        <fieldset>
                                            <legend>검색 옵션</legend>
                                            <div class="shBoxSection">
                                                <div class="section">
                                                    <label for="bb22" class="laType02">등록일</label>
                                                    <span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" id="bb22" name="searchStartDate" readonly/></span>
		                                            <span class="dash">~</span>
		                                            <span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" name="searchEndDate" readonly/></span>
                                                </div>
                                                <div class="section pright etccase1">
                                                    <button class="btn-srh03" id="searchBtn"><img src="/images/searchIcon.gif" alt="검색" ></button>
                                                </div>
                                            </div>
                                        </fieldset>
                                    </form>
                                </div>
                                <p class="head">단말기 - 자전거 연결 이력</p>
                                <table class="tb_type01 mt20">
                                    <caption>단말기 - 자전거 연결 이력</caption>
                                        <colgroup>
                                            <col style="width:15%">
                                            <col style="width:20%">
                                            <col style="width:20%">
                                            <col style="width:20%">
                                            <col style="width:20%">
                                        </colgroup>
                                    <thead>
                                        <tr>
                                            <th>자전거 번호</th>
                                            <th>연결시작일시</th>
                                            <th>연결 수정자</th>
                                            <th>연결종료일시</th>
                                            <th>종료 수정자</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="history" items="${infoList }" varStatus="info">
                                        <tr>
                                            <td class="pl10">${history.bikeNo}</td>
                                            <td class="tc">${history.locateStrDttm}</td>
                                            <td class="pl10">${history.locateAdminId}</td>
                                            <td class="tc">
                                                <c:if test="${fn:startsWith(history.locateEndDttm,'9999') eq false }">
                                                 ${history.locateEndDttm}
                                                </c:if> 
                                            </td>
                                            <td>${history.locateEndAdminId}</td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                                <c:if test="${fn:length(infoList) == 0 }">
                                <table class="tb_type01 nbt0">
                                    <tr><td style="text-align:center"><spring:message code="search.nodata.msg" /></td></tr>
                                </table>
                                </c:if>
                            </div>
                        </div>
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
    	var onTabNo = Number("${terminal.getTabNum()}");
    	var viewFlg ='${terminal.getViewFlg() }';
    	tDetail.initView(onTabNo, viewFlg);
    	tDetail.initBtn();
    	tDetail.initCombo();
    	
    });
    
    var tDetail = {};
    var $this = tDetail;
    tDetail.locateClsCd = "${terminalVo.locateClsCd}";
    tDetail.locateId = "${terminalVo.locateId}";
    tDetail.deviceStatusCd = "${terminalVo.deviceStatusCd}";
    tDetail.entrpsCd = '${terminalVo.entrpsCd}';
    tDetail.viewType = "${terminal.getViewFlg() }";
    tDetail.deviceModlCd = '${terminalVo.deviceModlCd}';
    //device모델코드 -> DM2
    tDetail.initView = function(onTabNo, viewFlg) {
    	if(viewFlg == 'C') {
    		$(".tabBox").find("li").eq(1).css("display", "none");
    	}
    	if(onTabNo === 1) {
            $('.tabCon').eq(0).addClass("on");
            $('.tabCon').eq(1).removeClass("on");
            $('.tab').eq(0).addClass("on");
            $('.tab').eq(1).removeClass("on");
        } else {
            $('.tabCon').eq(0).removeClass("on");
            $('.tabCon').eq(1).addClass("on");
            $('.tab').eq(0).removeClass("on");
            $('.tab').eq(1).addClass("on");
        }
        var sDate = '${searchCondition.searchStartDate}' === '' ? '' : '${searchCondition.searchStartDate}';
        var eDate = '${searchCondition.searchEndDate}' === '' ? '' : '${searchCondition.searchEndDate}';
        
        $( "[name='searchStartDate']").val(sDate);
        $( "[name='searchEndDate']").val(eDate);
        
        if(viewFlg === "U") {
            //$("#centerSlt").prop("disabled", true); 
            $("#softWareFw").attr("readonly", true);
            $("#imageFW").attr("readonly", true);
            $("#voiceFW").attr("readonly", true); 
           	$("#entrpsSlt").prop('disabled', true);
        } else {
            $("#searchBtn").css("display", "none");
        }
    };
    tDetail.initBtn = function() {
    	$("#termianlEditExe").on("click", this.terminalRegFnc);
    	$("#dupCodeCheck").on("click",{type : "dev"}, this.deviceDupFnc);
    	$("#dupSerialChk").on("click",{type : "serial"}, this.deviceDupFnc);
    	$("#searchBtn").on("click", this.searchInfoHistory);
    	$("#moveListPage").on("click", this.moveListPage);
    	$("#moveInspectList").on("click", this.moveInspectList);
    	$("#centerSlt").on("change", function() {
    		if($("#bikeNo").val() !== "") {
	    	   	var con = confirm('<spring:message code="confrim.change.bike.stus"/>');
	    	   	if(con) {
	    	   		$("#bikeNo").val("");
	    	   	}else {
	    	   		$("#centerSlt").val('');
	    	   		return false;
	    	   	}
    		}
    		if(tDetail.viewType === 'C') {
	    		$("#statusSlt").val('DES_003');
    		}
    	});
    	$("#deviceId").on('focusin', function(e){
    		if(tDetail.viewType === 'C') {
	            if( $("[name='dupDevChk']").val() === "Y") {
	                $("[name='dupDevChk']").val('N');
	            }
	            $("#deviceId").val('');
    		}
        });
        $("#serialNo").on('focusin', function(e){
        	if(tDetail.viewType === 'C') {
	            if( $("[name='dupSerailChk']").val() === "Y") {
	                $("[name='dupSerailChk']").val('N');
	            }
	            $("#serialNo").val('');
        	}
        });
    };
    tDetail.moveListPage = function() {
    	$("[name='deviceStatusCd']").val("");
    	$("[name='searchBgnDe']").val("");
    	$("[name='searchEndDe']").val("");
    	$("#frm").attr({action : "/getTerminalList.do", method : "post"}).submit();
    };
    tDetail.moveInspectList = function() {
    	$("[name='searchBgnDe']").val("");
    	$("[name='searchEndDe']").val("");
    	$("#frm").attr({action : "/inspectBikeList.do", method : "post"}).submit();
    };
    tDetail.deviceDupFnc = function(e) {
    	e.preventDefault();
    	var type = e.data.type;
        var typeName = e.data.type === "dev" ? "아이디"  : "시리얼";
        var chkId = ""; 
    	
        if(type === "dev") {
            if( $("#deviceId").val() === "") {
                alert("단말기ID를 입력해 주세요.");
                return false;
            }
            if(!isAlNumber($("#deviceId").val())){
                alert("영문과 숫자여야 합니다.");
                $("#deviceId").val('').focus();
                return false;
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
    	
    
    	commonAjax.postAjax("/terminal/dupIdCheckAjax.do", "json", { chkId : chkId , chkType : type }
    	, function(data){
    		if(data) {
    			var result = (data.isDup === "true");
    			if(result) {
                    if(type === "dev") {
                        $("[name='dupDevChk']").val("N");
                        $("#deviceId").val('').focus();
                    } else {
                        $("[name='dupSerailChk']").val("N");
                        $("#serialNo").val('').focus();
                    }
                    alert("<spring:message code ='fail.dup.id' arguments='"+typeName+"'/>");
                } else {
                    if(type === "dev") {
                        $("[name='dupDevChk']").val("Y");
                    } else {
                        $("[name='dupSerailChk']").val("Y");
                    }
                    alert("<spring:message code ='success.dup.id' arguments='"+typeName+"'/>");
                }
    		}
    		
    	});
    };
    tDetail.terminalRegFnc = function(e) {
    	e.preventDefault();
    	e.stopPropagation();
    	
    	var _this = tDetail;
    	
    	if(_this.chkInputData()) {
    		if( $("#centerSlt").val() !== '') {
                $("[name='locateClsCd']").val("C");
                $("#bikeNo").val('');
                $("[name='locateId']").val($("#centerSlt").val());
            } else {
            	$("[name='locateClsCd']").val("B");
                $("[name='locateId']").val($("[name='bikeId']").val());
            }
            $("[name='tabNo']").val("1");
            $("[name='deviceStatusCd']").val($("#statusSlt").val());
            commonAjax.postAjax("/terminalDataEditExe.do", 'json', $("#frm").serialize()
                ,function(data) {
                     if(data) {
                         if(data.checkResult > 0) {
                             alert("저장에 성공했습니다.");
                             if(tDetail.viewType  === 'C') {
	                             _this.moveListPage();
                             }
                         }
                     }     
                }
            );
    	}
    };
    
    tDetail.chkInputData = function () {
    	if($("#deviceId").val() === '' ) {
            alert("단말기Id를 입력해 주세요.");
            return false;
        }
    	if(!isAlNumber($("#deviceId").val())){
            alert("영문과 숫자여야 합니다.");
            return false;
        }
    	if(tDetail.viewType  ==='C' &&  $("[name='dupDevChk']").val() === 'N') {
            alert("아이디 중복 확인을 해주세요.");
            return false;
        }
    	
    	if($("#serialNo").val() === '') {
        	alert("단말기 시리얼 넘버를 입력해 주세요.");
            return false;
        }
    	if(tDetail.viewType  ==='C' && $("[name='dupSerailChk']").val() === 'N') {
            alert("시리얼 중복 확인을 해주세요.");
            return false;
        }
    	/* if( $("#centerSlt").val() === '') {
        	alert("단말기를 배치할 곳을 선택해 주세요.");
            return false;
        }  */
    	if($("#statusSlt").val() === '') {
        	alert("단말기 상태를 입력해주세요.");
            return false;
        }
        
        if($("#deviceModlCd").val() === '') {
        	alert("단말기 구분을 선택해주세요.");
            return false;
        }
    	return true;
    };
    tDetail.initCombo = function() {
    	var _this = tDetail;
    	//상태코드
        commonAjax.getCommonCode("DES", function(data) {
            if(data !== null && data.codeList !== null) {
                commCdBox.makeComboBox('CC',_this.deviceStatusCd,data.codeList, "statusSlt");
            }
        });
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
        if(_this.locateClsCd === "B") {
            $('[name="bikeId"]').val(_this.locateId);
        }
    };
    
    tDetail.searchInfoHistory = function(e) {
    	e.preventDefault();
    	$("#infoFrm").append($("[name='tabNum']").val("2"));
    	$("#infoFrm").append($("<input>",{name : "deviceId" , type : "hidden"}).val($("#deviceId").val()));
    	$("#infoFrm").append($("<input>",{name : "viewFlg" , type : "hidden"}).val($("[name='viewFlg']").val()));
    	$("#infoFrm").attr({action : "/moveTerminalEditForm.do", method : "post"}).submit();
    	
    };
    function setBikeId(pId, pNo) {
    	alert("bikeNo : "+pNo+"/ bikeId : "+pId);
        $("[name='bikeNo']").val(pNo);
        $("[name='bikeId']").val(pId);
        $("#centerSlt").val('');
        $("#statusSlt").val('DES_002');
    };
    </script>
</body>
</html>