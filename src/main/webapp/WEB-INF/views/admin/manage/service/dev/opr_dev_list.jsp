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
                       <!-- 모바일 검색조건 S-->
                        <div class="shBox_m">
                            <div class="downtitle">
                                <div class="title">
                                    <p>검색조건</p><span><button><img src="/images/srh_open.png" alt="검색조건 열기" /></button></span>
                                </div>
                            </div>
                        </div>
                        <!-- 모바일 검색조건 E-->
                        <!--검색조건 S-->
                   		<form  id="searchFrm" name="searchFrm" >
                        	<div class="shBox">
                            
                                <input type="hidden" name="viewFlg" value="" />
                                <input type="hidden" name="deviceId" value="" />
                                <input type="hidden" name="deviceStatusName" value="" />
                                <input type="hidden" name="searchTypeName" value="" />
                                <fieldset>
                                    <legend>검색 옵션</legend>
                                    <div class="shBoxSection">
                                        <div class="section">
                                            <label for="bb22" class="laType02">등록일</label>
                                            <span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" id="bb22" name="searchBgnDe" readonly/></span>
                                            <span class="dash">~</span>
                                            <span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" name="searchEndDe" readonly/></span>
                                        </div>
                                        <div class="section pright">
                                            <label for="a1" class="laType02">상태</label>
                                            <select class="select-category03" id="a1" name="deviceStatusCd">
                                                <option value="">선택</option>
                                            </select>
                                        </div>
                                        <div class="section">
                                            <label for="aa1" class="laType02">조회 구분</label>
                                            <select  id="aa1" name="searchType">
                                                <option value="">선택</option>
                                                <option value="D">단말기ID</option>
                                                <option value="F">펌웨어버전</option>
                                                <option value="S">S/N</option>
                                            </select>
                                            <span class="input-text08"><input type="text" class="" id="searchWord" name="searchWord"/></span>
                                        </div>
                                        <div class="section pright">
                                            <label for="a1" class="laType02">단말기 구분</label>
                                            <select class="select-category03" id="deviceModlCd" name="deviceModlCd">
                                                <option value="">선택</option>
                                                <option value="DM2" <c:if test="${searchCondition.deviceModlCd == 'DM2'}">selected ="seelcted"</c:if>>기존단말기</option>
                                                <option value="DM4" <c:if test="${searchCondition.deviceModlCd == 'DM4'}">selected ="seelcted"</c:if>>QR단말기</option>
                                            </select>
                                            <button type="button" id="searchBtn" class="btn-srh03 btncase1"><img src="/images/searchIcon.gif" alt="검색" ></button>
                                        </div>
                                    </div>
                                </fieldset>
                       		</div>
                        <!--검색조건 E-->
                        <p class="tb_numlist">총${paginationInfo.getTotalRecordCount() } 건</p>
                        <table class="tb_type01">
                            <caption>단말기</caption>
                                <colgroup>
                                    <col style="width:20%"/>
                                    <col style="width:8%"/>
                                    <col style="width:8%" class="mhid"/>
                                    <col style="width:10%"/>
                                    <col style="width:16%"/>
                                    <col style="width:10%"/>
                                    <col style="width:10%"/>
                                    <col style="width:12%"/>
                                    <col style="width:10%" class="mhid"/>
                                    <col style="width:12%" class="mhid"/>
                                </colgroup>
                            <thead>
                                <tr>
                                    <th>단말기ID</th>
                                    <th>배터리정보</th>
                                    <th class="mhid">펌웨어버전</th>
                                    <th >S/N</th>
                                    <th>센터/자전거</th>
                                    <th>대여상태</th>
                                    <th>상태</th>
                                    <th>고장상태</th>
                                    <th class="mhid">납품처</th>
                                    <th class="mhid">등록일</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="terminal" items="${terminalList}" varStatus="loop">
	                                <tr>
	                                    <td class="pl10" ><a href="#">${terminal.deviceId }</a></td>
	                                    <td class="pl10">
	                                    	<c:choose>
	                                    		<c:when test="${terminal.batteryStusCd eq 'BAT_001'}">완충</c:when>
	                                    		<c:when test="${terminal.batteryStusCd eq 'BAT_002'}">2/3</c:when>
	                                    		<c:when test="${terminal.batteryStusCd eq 'BAT_003'}">1/3</c:when>
	                                    		<c:when test="${terminal.batteryStusCd eq 'BAT_004'}">방전</c:when>
	                                    		<c:otherwise>${terminal.batteryStusCd }</c:otherwise>
	                                    	</c:choose>
	                                    </td>
	                                    <td class="pl10 mhid">${terminal.softWareFw }</td>
	                                    <td class="pl10">${terminal.serialNo }</td>
	                                    <td class="pl10">${terminal.locateId }</td>
	                                    <td class="pl10">
	                                    	<c:choose>
	                                    		<c:when test="${terminal.bikeStusCd eq 'BKS_001'}">장애</c:when>
	                                    		<c:when test="${terminal.bikeStusCd eq 'BKS_002'}">폐기</c:when>
	                                    		<c:when test="${terminal.bikeStusCd eq 'BKS_003'}">정상(대기중)</c:when>
	                                    		<c:when test="${terminal.bikeStusCd eq 'BKS_004'}">센터보관</c:when>
	                                    		<c:when test="${terminal.bikeStusCd eq 'BKS_005'}">수리중</c:when>
	                                    		<c:when test="${terminal.bikeStusCd eq 'BKS_007'}">분실</c:when>
	                                    		<c:when test="${terminal.bikeStusCd eq 'BKS_008'}">Cascade</c:when>
	                                    		<c:when test="${terminal.bikeStusCd eq 'BKS_009'}">수리완료</c:when>
	                                    		<c:when test="${terminal.bikeStusCd eq 'BKS_010'}">대여중</c:when>
	                                    		<c:when test="${terminal.bikeStusCd eq 'BKS_011'}">배치이동</c:when>
	                                    		<c:when test="${terminal.bikeStusCd eq 'BKS_012'}">강제반납</c:when>
	                                    		<c:when test="${terminal.bikeStusCd eq 'BKS_013'}">상차</c:when>
	                                    		<c:when test="${terminal.bikeStusCd eq 'BKS_014'}">입고</c:when>
	                                    		<c:when test="${terminal.bikeStusCd eq 'BKS_015'}">출고</c:when>
	                                    	</c:choose>
	                                    </td>
	                                    <td class="pl10">${terminal.deviceStatusName }</td>
	                                    <td class="pl10">${terminal.errStusCdName }</td>
	                                    <td class="tc mhid">${terminal.entrpsCdNm }</td>
	                                    <td class="tc mhid">${terminal.regDttm }</td>
	                                </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <c:if test='${fn:length(terminalList) == 0}'>
                        <table class="tb_type01 nbt0">
                            <tr><td style="text-align:center"><spring:message code="search.nodata.msg" /></td></tr>
                        </table>
                        </c:if>
					<c:choose>
						<c:when test="${fn:length(terminalList) > 0}">
							<div class="drpaging">
						</c:when>
						<c:otherwise>
							<div class="drpaging" style="display:none;">
						</c:otherwise>
					</c:choose>
							<c:choose>
							<c:when test="${paginationInfo.currentPageNo > 1}">
								<a id="prevPage" href="#"><img src="/images/p_prev.gif" alt="이전 페이지" /></a>
							</c:when>
							<c:otherwise>
								<a href="#"><img src="/images/p_prev.gif" alt="이전 페이지" /></a>
							</c:otherwise>
							</c:choose>
							<span><input name="currentPageNo" type="number" value="${paginationInfo.currentPageNo}"/><em>/ ${paginationInfo.totalPageCount}</em><button id="movePage">이동</button></span>
							<c:choose>
							<c:when test="${paginationInfo.currentPageNo < paginationInfo.totalPageCount}">
							<a id="nextPage" href="#"><img src="/images/p_next.gif" alt="다음 페이지" /></a>
							</c:when>
							<c:otherwise>
								<a href="#"><img src="/images/p_next.gif" alt="다음 페이지" /></a>
							</c:otherwise>
							</c:choose>
						</div>
						</form>
                        <div class="btnArea tr">
	                        <button class="btnType01 mb10 mhid" id="excelViewBtn" title="엑셀다운로드 ">엑셀다운로드</button>
	                        <a href="<c:out value='/common/pop/DEV_002/openUploadPop.do'/>" id="bulkUploadBtn" class="winNewPop btnType01 mb10 mhid" title="엑셀업로드" data-width="450" data-height="355" data-pmt="">엑셀업로드</a>
	                        <button class="btnType01 bc_green mb10" id="moveEditFormBtn" title="등록">등록</button>
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
    $(function(){
    	
    	terminalList.initBtn();
    	terminalList.initCombo();
        //var today = DateUtil.dateFmt(new Date());
        var sDate = '${searchCondition.searchBgnDe}' !== '' ? '${searchCondition.searchBgnDe}' : "";
        var eDate = '${searchCondition.searchEndDe}' !== '' ? '${searchCondition.searchEndDe}' : "";
     
        $( "[name='searchBgnDe']").val(sDate);
        $( "[name='searchEndDe']").val(eDate);
        
        var totalPageCount = '${paginationInfo.totalPageCount}' == '' ? 1 : Number('${paginationInfo.totalPageCount}');
   		$('#prevPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			terminalList.pageSelect(currentPageNo-1);
		});
		$('#nextPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			terminalList.pageSelect(currentPageNo+1);
		});
		$('#movePage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			var regExp = /^[1-9]?[0-9]/;
			if(!regExp.test(currentPageNo) ||(totalPageCount < currentPageNo)){
				alert('현재 페이지 값이 정상적이지 않습니다.');
			}else{
				terminalList.pageSelect(currentPageNo);
			}
		});
    });
    var terminalList = {};
    terminalList.deviceStatus = '${searchCondition.deviceStatusCd}';
    terminalList.searchType = '${searchCondition.searchType}';
    terminalList.searchWord = '${searchCondition.searchWord}';
    
    terminalList.initBtn = function() {
    	$("#aa1").on("change", function(e){
            if($("#aa1").val() == "") {
                $("[name='searchWord']").val('');
            }
        });
    	$(".tb_type01 > tbody > tr").on("click","a",{viewFlg : 'U'}, this.moveDtailPage);
    	$("#excelViewBtn").on("click",{listType : 'excel'},this.listFnc);
    	$("#searchBtn").on("click",{listType : 'list'},this.listFnc);
    	$("#moveEditFormBtn").on("click",{viewFlg : 'C'}, this.moveDtailPage);
    	$("#aa1").on("change", function() {
    		$("#searchWord").val("");
    	});
    };
    
    terminalList.moveDtailPage = function (e) {
    	e.preventDefault();
    	e.stopPropagation();
    	
    	var vFlg = e.data.viewFlg;
    	if( vFlg === "U") {
    		$("[name='deviceId']").val(this.text);
    	}
    	$("[name='viewFlg']").val(vFlg);
    	$("#searchFrm").attr({method : "post", action : "<c:out value='/moveTerminalEditForm.do'/>"}).submit();
    };
    terminalList.listFnc = function (e) {
    	e.preventDefault();
      	e.stopPropagation();
    	var listType = e.data.listType;
    	
    	if($("#aa1").val() !== '' && $("#searchWord").val() === ''){
            alert("검색할 "+$("#aa1 option:selected").text()+"를 입력해주세요.");
            return false;
        }  
    	var dChk = DateUtil.checkDateTerm( $("[name='searchBgnDe']").val(),  $("[name='searchEndDe']").val());
        if($( "[name='searchBgnDe']").val() !== '' && dChk !== 'ok') {
            alert("검색 조건의 시작 날이 종료 날보다 큽니다.");
        	$("[name='searchBgnDe']").val('');
        	$("[name='searchEndDe']").val('');
            return false;
        }
    	$("input:hidden[name='viewFlg']").val(listType);
    	$("[name='currentPageNo']").val(1);
    	if( listType === 'excel') {
    	    //if(checkDateTerm)
            $("[name='searchTypeName']").val($("#aa1 option:selected").text());
            $("[name='deviceStatusName']").val($("#a1 option:selected").text());
    		
        }
    	$("#searchFrm").attr({method : "post", action : "<c:out value='/getTerminalList.do'/>"}).submit();
    };
    terminalList.initCombo = function () {
    	var _this = terminalList;
    	//상태코드
        commonAjax.getCommonCode("DES", function(data) {
             if(data !== null && data.codeList !== null) {
            	 var pVal = _this.deviceStatus;
                 commCdBox.makeComboBox('CC',pVal,data.codeList, "a1");
             }
        });
        
        $("#aa1").val(this.searchType);
        $("#searchWord").val(this.searchWord);
    };
    terminalList.pageSelect = function(cPage) {
    	
    	$("input:hidden[name='viewFlg']").val('list');
        $("[name='currentPageNo']").val(cPage);
        $("#searchFrm").attr({method : "post", action : "<c:out value='/getTerminalList.do'/>"}).submit();
    };
    
    </script>
</body>
</html>
