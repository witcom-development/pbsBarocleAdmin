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
                        <form id="searchFrm" >
                        	<div class="shBox">
                                <fieldset>
                                    <legend>검색 옵션</legend>
                                    <div class="shBoxSection">
                                        <div class="section">
                                            <label for="a1" class="laType03">아파트 구분</label>
                                            <select class="select-category04" id="stationGrpSeq" name="stationGrpSeq">
												<option value="">선택</option>
												<%-- <c:forEach items="${group }" var="group">
													<option value="${group.station_grp_seq }" <c:if test="${searchCondition.stationGrpSeq == group.station_grp_seq }">selected</c:if>>${group.station_grp_name }</option>
												</c:forEach> --%>
											</select>
                                        </div>
                                        <div class="section pright etccase3">
                                        	<div class="section">
	                                            <label for="a1" class="laType03">정거장 구분</label>
	                                            <select class="select-category04" id="stationId" name="stationId">
													<option value="">선택</option>
												</select>
	                                        </div>
                                        </div>
                                        
		                                <input type="hidden" name="bikeId"	id="bikeId">
		                                <input type="hidden" name="tabNum"	id="tabNum">
                                    </div>
                                    <div class="shBoxSection">
                                    	<div class="section pright etccase3">
                                        	<label for="a2" class="laType03">자전거번호</label>
                                        	<span class="input-text12"><input type="text" class="" id="bikeNo" name="bikeNo" value="${searchCondition.bikeNo }" placeholder="숫자만 입력" onKeypress="checkEnter(event);"/></span>
                                            <button type="button" name="searchBtn" onclick="fn_search(); return false;" id="searchBtn" class="btn-srh03 btncase1" ><img src="/images/searchIcon.gif" alt="검색"/></button>
                                        </div>
                                    </div>
                                </fieldset>
                        	</div>
                        <!--검색조건 E-->
                        
                        <!-- <div id="mapDiv" class="mt20" ></div> -->
                        <p class="tb_numlist">총 ${ paginationInfo.getTotalRecordCount()} 건</p>
                        <table class="tb_type01" id="list">
                            <colgroup>
                                <col style="width:20%"/>
                                <col style="width:20%"/>
                                <col style="width:20%"/>
                                <col style="width:30%"/> 
                                <col style="width:35%"/> 
                                <col style="width:15%"/>
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>자전거 번호</th>
                                    <th>x좌표</th>
                                    <th>y좌표</th>
                                    <th>요청 아파트</th>
                                    <th>원격 반납 정거장</th>
                                    <th>위치보기</th>
                                </tr>
                            </thead>
                            <tbody> 
                            
                             <c:forEach var="info" items="${resultList}" varStatus="status" >
                                <tr>
					                <td class="title tl"><a href="javascript:bikeLog('${ info.bikeId }', '${ info.bikeNo }');">${ info.bikeNo }</a></td>
					                <td class="title tr pr10">${info.xpos}</td>
					                <td class="title tr pr10">${info.ypos}</td>
					                <td class="title tc pr10">${ info.stationGrpName }</td>
					                <td class="title tc pr10">${ info.remoteStationName }</td>
					                <td class="tc"><a href="javascript:goMapAddr(${info.xpos}, ${info.ypos});" style="font-weight: bolder; color: #6478FF;">[지도]</a></td>
					            </tr> 
					        </c:forEach>
					        <c:if test="${fn:length(resultList) == 0 }">
					            <tr><td colspan="6" style="text-align: center;"><spring:message code="search.nodata.msg" /></td></tr>
					        </c:if>
                            </tbody>
                        </table>
					<c:choose>
						<c:when test="${fn:length(resultList) > 0}">
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

    <!-- <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=c2yclia2l7&callback=draw"></script> -->
    
    <!-- <script type="text/javascript" src="/js/stationCommonMapv.js"></script> -->
    <script type="text/javascript" src="/js/common_barocle.js"></script>

	<script type="text/javascript">

	var stationGrpSeq = '${searchCondition.stationGrpSeq}';
	var stationId = '${searchCondition.stationId}';
	
	$(function(){
		/* $(".tb_type01 > tbody > tr").on("click", "a", this.moveexeImpulseDetail); */
		initBtn();
		initCombo();
		
	});
	
	function initBtn(){
		$("#stationGrpSeq").on('change', function(e){
			var tId = e.target.id;
			var idx = $("#"+tId+" option:selected").index();
			var subList =$("#"+tId).data().sub_data;
			$("#stationId option").not(':eq(0)').remove();
			var sltsubData = subList[(idx-1)];
			if(sltsubData !== undefined) {
				if(sltsubData.length > 0) {
					commCdBox.makeComboBox("S", stationId, sltsubData, "stationId");
				}
			}
		});
	}
	
	function initCombo(){
		// 원격정거장
		commonAjax.getRemoteStationCode( 
				function(data) {
					if(data != null && data.stationList != null) {
						$("#stationId option").not(':eq(0)').remove();
						commCdBox.makeComboBox('S', stationGrpSeq, data.stationList, "stationGrpSeq");
						$("#stationGrpSeq").trigger("change");
					}
				}
		);
	}
	
	function checkEnter(e){
		if(e.keyCode == 13)
			linkPage(1);
	}
	
	function fn_search(){
		linkPage(1);
	}
	
	function linkPage(no){
		
		if($("#bikeNo").val() != ""){
			var num = $("#bikeNo").val();
			var zero = '';

	    	 if (num.length < 5) {
	    	  for (i = 0; i < 5 - num.length; i++)
	    	   zero += '0';
	    	 }
	    	 $("#bikeNo").val("BRC-"+zero + num);
		}
		
		//alert($("#bikeNo").val());

		$("#currentPageNo").val(no);
		$("#searchFrm").attr("action", "/getRequestReturn.do");

		$("#searchFrm").submit();
	}
	
	function bikeLog(id, no){		
		// 자전거 정보 조회 호출
		$("[name='bikeId']").val(id);
		$("[name='bikeNo']").val(no);
		$("[name='viewFlg']").val("U");
		$("[name='tabNum']").val("4");
		$("[name='currentPageNo']").val(1); 
	 	
	    $("#searchFrm").attr({action: '/moveBikeEditForm.do', method :"post",   target :"_blank"  }).submit();
	}
	
	function goMapAddr(x, y){
		
		var pwidth = 600;
		var pheight = 730;
		var winL = (screen.width-pwidth)/2;
		var winT = (screen.height-pheight)/2;
		var lat = x;
		var lon = y;
		
		window.open("/common/pop/showLocationMapPop.do?outptt=%uC704%uCE58%uC9C0%uB3C4%uCC3E%uAE30&latitude="+ lat +"&longitude=" + lon , "winpop", "width=600, height=680, top="+winT+", left="+winL , "scrollbars=yes");

	}
	
	</script>
    
</body>
</html>
