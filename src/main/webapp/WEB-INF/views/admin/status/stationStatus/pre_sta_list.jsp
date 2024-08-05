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
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
<meta name="description=" Content="" />
<title><tiles:insertAttribute name="title"/></title>
<tiles:insertAttribute name="resource"/>
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
                <div id="content" class="content">
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
                        <%-- <table class="tb_type01 mhid">
                            <colgroup>
                                <col style="width:15%"/>
                                <col style="width:15%"/>
                                <col style="width:15%"/>
                                <col style="width:15%"/>
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>전체11</th>
                                    <th>장애중</th>
                                    <th>자전거 일반 현황</th>
                                    <th>자전거 대여현황</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="title">
                                        <div class="statulist">
                                            <p>대여소 : <span>${wholeStatusTot.stationTotCnt }</span></p>
                                            <p>거치대 : <span> ${wholeStatusTot.rackTotCnt }</span></p>
                                            <p>자전거(폐기,분실 제외) :<span>  ${ wholeStatusTot.bikeTotCnt}</span></p>
                                            <p>자전거(폐기,분실) :<span>  ${ wholeStatusTot.bikeTotErrorCnt}</span></p>
                                        </div>
                                    </td>
                                    <td class="title">
                                        <div class="statulist">
                                            <p>자전거 : <span>${brokenStatusTot.brokenBikeTotCnt }</span></p>
                                            <p>거치대 : <span>${brokenStatusTot.brokenBikeTotCnt }</span></p>
                                            <p>무선AP : <span>${brokenStatusTot.brokenApTotCnt }</span></p>
                                        </div>
                                    </td>
                                    <td class="title">
                                        <div class="statulist">
                                            <p>대기중 :<span>${bikeStatusTot.standByBikeTotCnt }</span></p>
                                            <p>수리중 : <span>${bikeStatusTot.repairingBikeTotCnt }</span></p>
                                            <p>수리완료 : <span>${bikeStatusTot.repairingCompleteTotCnt }</span></p>
                                            <p>센터입고 :<span>${bikeStatusTot.warehousedBikeTotCnt }</span></p>
                                        </div>
                                    </td>
                                    <td class="title">
                                        <div class="statulist">
                                            <p>정상 대여중 : <span>${rentStatusTot.rentStableTotCnt }</span></p>
                                            <p>장기 미반납 : <span>${rentStatusTot.longTermNonReturnTotCnt}</span></p>
                                            <p>강제 반납 : <span>${bikeStatusTot.impulseBikeReturnTotCnt}</span></p>
                                            <p>배치 이동   : <span>${bikeStatusTot.movePlacementotCnt }</span></p>
                                        </div>
                                    </td>
                                    
                                </tr>
                            </tbody>
                        </table> --%>
                       <%--  <div class="staBox mapguide mhid">
                            <p>거치율(%)</p>
                            <!-- <span><em><img src="/images/staOn_s100p.png" alt="" /></em>76~100</span>
                            <span><em><img src="/images/staOn_s75p.png" alt="" /></em>51~75</span>
                            <span><em><img src="/images/staOn_s50p.png" alt="" /></em>26~50</span>
                            <span><em><img src="/images/staOn_s25p.png" alt="" /></em>1~25</span>
                            <span><em><img src="/images/staOn_s0p.png" alt="" /></em>0</span>
                            <span><em><img src="/images/staErr_s0p.png" alt="" /></em>장애</span>
                            <span><em><img src="/images/staStop_s0p.png" alt="" /></em>사용정지</span> -->
                            <!-- <span><em><img src="/images/inc/icon_b4.png" alt="" /></em>0대</span>
                            <span><em><img src="/images/inc/icon_b1.png" alt="" /></em>1~3대</span>
                            <span><em><img src="/images/inc/icon_b2.png" alt="" /></em>4~6대</span>
                            <span><em><img src="/images/inc/icon_b3.png" alt="" /></em>7대 이상</span>
                            <span><em><img src="/images/inc/icon_b0.png" alt="" /></em>장애</span>
                            <span><em><img src="/images/inc/icon_b0.png" alt="" /></em>사용정지</span> -->
                            <span><em><img src="/images/inc/icon_b2.png" alt="" /></em>0 ~ 25%</span>
                            <span><em><img src="/images/inc/icon_b3.png" alt="" /></em>25 ~ 100%</span>
                            <span><em><img src="/images/inc/icon_b3_b.png" alt="" /></em>100% 이상</span>
                            <span><em><img src="/images/inc/icon_b1.png" alt="" /></em>장애</span>
                            <span><em><img src="/images/inc/icon_b0.png" alt="" /></em>사용정지</span>
                            
                            <a href="<c:out value='/common/pop/showStationStatusPop.do'/>" class="winNewPop btnType02 thid"  data-screen="fullscreen" title="대여소 현황" data-width="" data-height="" data-pmt="&defaultLevel=8">전체화면</a>
                        </div> --%>
                        <form id="searchFrm" >
                        	<div class="shBox">
	                            <input type="hidden" name="stationOrderType" value="${condition.stationOrderType}">
	                            <input type="hidden" name="sharedOrderType" value="${condition.sharedOrderType}">
	                            <input type="hidden" name="orderColumn"   value="${condition.orderColumn}">
	                            <input type="hidden" name="viewType"      value="${condition.viewType }">
	                            <input type="hidden" name="stationId"  id="stationId"   value="${condition.stationId }">
	                            <input type="hidden" name="stationGrpSeq" id="stationGrpSeq" value="${condition.stationGrpSeq }">
	                            <input type="hidden" name="defaultLevel" value="${condition.defaultLevel }">
	                            <input type="hidden" name="paramSearchWord" id="paramSearchWord" value="${condition.paramSearchWord}">
	                            <input type="hidden" name="paramSearchType" id="paramSearchType" value="${condition.paramSearchType}">
                                <fieldset>
                                    <legend>검색 옵션</legend>
                                    <div class="shBoxSection">
                                        <div class="section">
                                            <label for="bb22" class="laType03">아파트</label>
                                            <select class="select-category02" id="bb22" style="width: 210px;">
                                                <option value="0">선택</option>
                                            </select>
                                        </div>
                                        <div class="section pright etccase3">
                                            <label for="aa21" class="laType03">대여소명</label>
                                            <select class="select-category02" id="aa21">
                                                <option value="">선택</option>
                                            </select>
                                            <button type="button" name="searchBtn" id="searchBtn" class="btn-srh03 btncase1" ><img src="/images/searchIcon.gif" alt="검색"/></button>
                                        </div>
                                        <div class="section">
                                            <label for="searchType" class="laType03">구분</label>
                                            <select  id="searchType"  name="searchType">
                                                <option value="">선택</option>
                                                <option value="NUM">대여소번호</option>
                                                <option value="NAME">대여소명</option>
                                            </select>
                                            <span class="input-text12"><input type="text" class="" id="searchWord" value="${condition.paramSearchWord}"/></span>
                                        </div>
                                        <div class="section pright etccase3">
                                            <label for="searchStationName" class="laType03">자전거구분</label>
                                            <select class="select-category02" id="a11" name="stationSeCd" style="width: 210px;">
                                                <option value="">선택</option>
                                            </select>
                                        </div>
                                    </div>
                                </fieldset>
                        	</div>
                        
                        <!--검색조건 E-->
                        <!-- <div id="mapDiv" class="mt20" style="width:100%; height:600px;"></div> -->
                        
                        
                        <div class="listalign mt20" style="margin-bottom : 5px;">
                            <select name="sortSlt" id="sortSlt" class="mr10">
                                <option value="">선택</option>
                                <option value="S" <c:if test='${ condition.orderColumn eq "S"}'>selected="selected"</c:if>>대여소</option>
                                <option value="P" <c:if test='${ condition.orderColumn eq "P" }'>selected="selected"</c:if>>거치율</option>
                            </select>
                            <label><input name="lsalign" type="radio" value="ASC" class="vm" <c:if test="${condition.stationOrderType eq 'ASC'  or condition.sharedOrderType eq 'ASC'}">checked="checked"</c:if>/> 오름차순</label>
                            <label><input name="lsalign" type="radio" value="DESC" class="vm ml10" <c:if test="${condition.stationOrderType eq 'DESC' or condition.sharedOrderType eq 'DESC'}">checked="checked"</c:if>/> 내림차순</label>
                            <label style="float:right"><select name="recordCountPerPage" id="recordCountPerPage" class="mr10">
                                <option value="10" <c:if test='${ paginationInfo.recordCountPerPage eq "10"}'>selected="selected"</c:if>>10</option>
                                <option value="20" <c:if test='${ paginationInfo.recordCountPerPage eq "20"}'>selected="selected"</c:if>>20</option>
                                <option value="50" <c:if test='${ paginationInfo.recordCountPerPage eq "50"}'>selected="selected"</c:if>>50</option>
                            </select></label>
                        </div>
                        <table class="tb_type01" id="list">
                            <colgroup>
                                <col style="width:30%"/>
                                <col style="width:20%"/>
                                <col style="width:15%"/>
                                <col style="width:10%"/>
                                <col style="width:15%"/>
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>대여소</th>
                                    <th title="자전거 거치중 수/전체 거치대수(점검수)">거치대 (점검)</th>
                                    <th title="연결반납 자전거 수/전체 자전거 수(점검수)">자전거 (점검)</th>
                                    <th>거치율(%)</th>
                                    <th>상태</th>
                                </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="info" items="${stationList}" varStatus="status">
                                <c:if test="${status.count > ((paginationInfo.currentPageNo -1) * paginationInfo.recordCountPerPage)}">
                                <c:if test="${status.count <= (paginationInfo.currentPageNo * paginationInfo.recordCountPerPage)}">
                                <tr>
					                <td class="title tl"><a href="#" id="${ info.stationId }">
					                <c:if test="${info.stationSeCd eq 'RAK_001' }">(LCD+QR 반납가능)</c:if>
                                    <%-- <c:if test="${info.stationSeCd ne 'RAK_001' }">(신규)</c:if> --%>
                                        ${ info.stationName }</a></td>
					                <td class="title tr pr10" title="자전거 거치중 수/전체 거치대수(점검수)">${ info.parkingRack }/${ info.rackTotCnt }(${ info.brokenRackTotCnt })</td>
					                <td class="title tr pr10" title="연결반납 자전거 수/전체 자전거 수(점검수)">${ info.parkingBikeTotCnt }/${ info.parkingRack }(${ info.brokenBikeTotCnt })</td>
					                <td class="title tr pr10">${ info.shared }</td>
					                <td class="title pl10">
					                    <c:choose>
					                       <c:when test="${info.stationUseYn eq 'N' }">사용정지</c:when>
					                       <c:when test="${info.currnetStatus eq 'Y' }">운휴</c:when>
					                       <c:otherwise>운영중</c:otherwise>
   					                    </c:choose>
					                </td>
					            </tr>
					            </c:if>
					            </c:if> 
					        </c:forEach>
					        <c:if test="${fn:length(stationList) == 0 }">
					            <tr><td colspan="5" style="text-align: center;"><spring:message code="search.nodata.msg" /></td></tr>
					        </c:if>
                            </tbody>
                        </table>
					<c:choose>
						<c:when test="${fn:length(stationList) > 0}">
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
                    </div>
                </div>
                <!--conteent E-->
            </div>
        </div>
        <!--footer S-->
        <tiles:insertAttribute name="footer"/>
        <!--footer E-->
    </div>

 
 
    <!-- <script type="text/javascript" src="/js/stationCommonMap.js"></script> -->
    <!-- <script type="text/javascript" src="/js/stationCommonMapv4.js"></script> -->
    <script type="text/javascript" src="/js/common_barocle.js"></script>
    <script type="text/javascript">
    $(function(){

    	var sigugun = '';
        var centerGu;
        var centerGuNo;
        var moveCount = 0;
        
    	if("${condition.paramSearchType}" != ""){
			$("#searchType").val("${condition.paramSearchType}");
		}
    	
    	if("${condition.stationGrpSeq}" != ""){
			$("#bb22").val("${condition.stationGrpSeq}");
		}
    	
    	if("${condition.stationId}" != ""){
			$("#aa21").val("${condition.stationId}");
		}
    	
    	currentStatus.initBtn();
    	currentStatus.initCommbo();
    	
    	var totalPageCount = '${paginationInfo.totalPageCount}' == '' ? 1 : Number('${paginationInfo.totalPageCount}');
   		$('#prevPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			currentStatus.pageSelect(currentPageNo-1);
		});
		$('#nextPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			currentStatus.pageSelect(currentPageNo+1);
		});
		$('#movePage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			var regExp = /^[1-9]?[0-9]/;
			if(!regExp.test(currentPageNo) ||(totalPageCount < currentPageNo)){
				alert('현재 페이지 값이 정상적이지 않습니다.');
			}else{
				currentStatus.pageSelect(currentPageNo);
			}
		});
		
		$("#searchType").on("change", function(e){
			
			$("[name='paramSearchType']").val($("#searchType").val());
			$("#searchWord").val('');
        }); 
		
    });
    
    var currentStatus = {};
    var _this = currentStatus;
    currentStatus.stationGrpSeq = '${condition.stationGrpSeq}';
    currentStatus.stationId     = '${condition.stationId}';
    currentStatus.viewType    = '${condition.viewType}' === "" ? "list" :'${condition.viewType}' ;
    currentStatus.stationSeCd     = '${condition.stationSeCd}';
    
     currentStatus.initBtn = function() {
    	$("#searchBtn").on("click", this.searchStation);
    	$("#bb22").on("change", function(e){
    		var tId = e.target.id;
            var idx = $("#"+tId+" option:selected").index();
            var subList =$("#"+tId).data().sub_data;
            $("#aa21 option").not(':eq(0)').remove();
            var sltsubData = subList[(idx-1)];
            if(sltsubData !== undefined) {
                if(sltsubData.length > 0) {
                    commCdBox.makeComboBox("S", _this.stationId, sltsubData, "aa21");
                }
            }
    	});
    	
    	$("#list > tbody > tr").on("click",'a', this.moveStationDetail);
    	$("#sortSlt").on('change', function(){
    		$("[name='lsalign']").prop('checked', false);
    	});
    	$("[name='lsalign']").on("change", _this.setColumnSortInfo);
    	$("[name='recordCountPerPage']").on("change", _this.setColumnSortInfo);
    	
    	
    };
    currentStatus.initCommbo = function() {
        commonAjax.getStationCode( 
            function(data) {
                if(data != null && data.stationList != null) {
                    $("#bb22 option").not(':eq(0)').remove();
                    commCdBox.makeComboBox('S', _this.stationGrpSeq, data.stationList, "bb22");
                    $("#bb22").trigger("change");
                }
            }
        );
        
      //정거장 구분
        commonAjax.getCommonCode("RAK", function(data) {
             if(data !== null && data.codeList !== null) {
            	 commCdBox.makeComboBox('CC',_this.stationSeCd, data.codeList, "a11");
             }
        });
    };
   
    currentStatus.searchStation = function(e) {
    	var currentPageNo = Number($('[name="currentPageNo"]').val());
		currentStatus.pageSelect(currentPageNo);
		
		var regExp = /^[1-9]?[0-9]/;
		if(!regExp.test(currentPageNo) ||(totalPageCount < currentPageNo)){
			alert('현재 페이지 값이 정상적이지 않습니다.');
		}else{
			currentStatus.pageSelect(currentPageNo);
		}
    	
    };
    
    
    currentStatus.setColumnSortInfo = function(e) {
    	e.preventDefault();
    	if($("#sortSlt").val() === ''){
    		return false;
    	}
    	var tTarget = $("#sortSlt").val();
        $("[name='orderColumn']").val(tTarget);
        currentStatus.viewType = 'sort';
        if(tTarget === 'S') {
            $("[name='stationOrderType']").val($("[name='lsalign']:checked").val());
            $("[name='sharedOrderType']").val('');
        } else {
            $("[name='sharedOrderType']").val($("[name='lsalign']:checked").val());
            $("[name='stationOrderType']").val('');
        }
        currentStatus.initData(1, 'sort');
    };
    
   
   
    currentStatus.moveStationDetail = function(e) {
    	e.preventDefault();
    	$("[name='stationId']").val(e.target.id);
    	$("#searchFrm").attr({action : "<c:out value='/moveCurrentStationDetail.do'/>", method : "post"}).submit();
    };
    
    function moveStationDetail2(moveStationId){
    	//alert(moveStationId);
    	$("[name='stationId']").val(moveStationId);
    	$("#searchFrm").attr({action : "<c:out value='/moveCurrentStationDetail.do'/>", method : "post"}).submit();
    }
    
    
    currentStatus.pageSelect = function(pageNo) {
    	this.initData(pageNo, 'list');
    };
    
    currentStatus.initData = function(pNo, pType) { 
   
		//if($("#searchWord").val() != ''){
			$("[name='stationGrpSeq']").val($("#bb22").val());
	    	$("[name='stationId']").val($("#aa21").val());
			pType = "search";
		//}
        $("[name='viewType']").val(pType);
        $("[name='currentPageNo']").val(pNo);
        $("[name='recordCountPerPage']").val($("#recordCountPerPage").val());
        $("[name='paramSearchWord']").val($("#searchWord").val());
        $("[name='paramSearchType']").val($("#searchType").val());
        $("#searchFrm").attr({action: '/getStationCurrentList.do', method : "post"}).submit();
        //currentStatus.getStationStatusListClean();
    };

    
    var deviceName = '';
    var appOsType = '';
    
   

	function searchGuNum(centerGu) {
		if (centerGu === "종로구") {
			centerGuNo = 10;
		} else if (centerGu === "중구") {
			centerGuNo = 11;
		} else if (centerGu === "마포구") {
			centerGuNo = 12;
		} else if (centerGu === "서대문구") {
			centerGuNo = 13;
		} else if (centerGu === "성동구") {
			centerGuNo = 14;
		} else if (centerGu === "광진구") {
			centerGuNo = 15;
		} else if (centerGu === "동대문구") {
			centerGuNo = 16;
		} else if (centerGu === "영등포구") {
			centerGuNo = 17;
		} else if (centerGu === "양천구") {
			centerGuNo = 18;
		} else if (centerGu === "용산구") {
			centerGuNo = 19;
		} else if (centerGu === "은평구") {
			centerGuNo = 20;
		} else if (centerGu === "강동구") {
			centerGuNo = 21;
		} else if (centerGu === "강서구") {
			centerGuNo = 22;
		} else if (centerGu === "송파구") {
			centerGuNo = 23;
		} else if (centerGu === "성북구") {
			centerGuNo = 24;
		} else if (centerGu === "중랑구") {
			centerGuNo = 25;
		} else if (centerGu === "노원구") {
			centerGuNo = 26;
		} else if (centerGu === "도봉구") {
			centerGuNo = 27;
		} else if (centerGu === "금천구") {
			centerGuNo = 28;
		} else if (centerGu === "구로구") {
			centerGuNo = 29;
		} else if (centerGu === "동작구") {
			centerGuNo = 30;
		} else if (centerGu === "관악구") {
			centerGuNo = 31;
		} else if (centerGu === "서초구") {
			centerGuNo = 32;
		} else if (centerGu === "강남구") {
			centerGuNo = 33;
		} else if (centerGu === "강북구") {
			centerGuNo = 34;
		}
		//alert(centerGuNo);
		 $("#bb22").val(centerGuNo);
		$("[name='stationGrpSeq']").val($("#bb22").val());
		var idx = $("#bb22"+" option:selected").index();
       var subList =$("#bb22").data().sub_data;
       $("#aa21 option").not(':eq(0)').remove();
       var sltsubData = subList[(idx-1)];
       //alert(sltsubData);
       if(sltsubData !== undefined) {
           if(sltsubData.length > 0) {
               commCdBox.makeComboBox("S", _this.stationId, sltsubData, "aa21");
           }
       }
      // currentStatus.getStationStatusList();
		
	}
    
     

    
    </script>
    
</body>
</html>