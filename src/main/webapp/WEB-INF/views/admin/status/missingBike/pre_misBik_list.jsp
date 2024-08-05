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
                                            <label for="bb22" class="laType03">조회날짜</label>
                                            <span class="selectDate input-datepick04"><input id="sDate" name="searchStartDate" type="text" class="datepicker input-datepick04" title="선택 날짜" readonly="true" value="" /></span>
											<span class="dash">~</span>
											<span class="selectDate input-datepick04"><input id="eDate" name="searchEndDate" type="text" class="datepicker input-datepick04" title="선택 날짜" readonly="true" value="" /></span>
                                        </div>
                                        <div class="section pright etccase3">                                            
                                            <label for="batteryStusCd" class="laType03">센터/팀</label>
                                            <select id="batteryStusCd" name="batteryStusCd">
                                                <option value="">선택</option>
                                            </select>&nbsp;
                                            <select id="searchType" name="searchType" required="true">
                                                <option value="">선택</option>
                                            </select>
                                            <button type="button" name="searchBtn" id="searchBtn" class="btn-srh03 btncase1" ><img src="/images/searchIcon.gif" alt="검색"/></button>
                                        </div>
                                    </div>
                                </fieldset>
                        	</div>
                        <!--검색조건 E-->
                        
                        <div id="mapDiv" class="mt20" ></div>
                        
                        <%-- <div class="listalign mt20" style="margin-bottom : 5px;">
                            <select name="sortSlt" id="sortSlt" class="mr10">
                                <option value="">선택</option>
                                <option value="S" <c:if test='${ condition.orderColumn eq "S"}'>selected="selected"</c:if>>대여소</option>
                                <option value="P" <c:if test='${ condition.orderColumn eq "P" }'>selected="selected"</c:if>>거치율</option>
                            </select>
                            <label><input name="lsalign" type="radio" value="ASC" class="vm" <c:if test="${condition.stationOrderType eq 'ASC'  or condition.sharedOrderType eq 'ASC'}">checked="checked"</c:if>/> 오름차순</label>
                            <label><input name="lsalign" type="radio" value="DESC" class="vm ml10" <c:if test="${condition.stationOrderType eq 'DESC' or condition.sharedOrderType eq 'DESC'}">checked="checked"</c:if>/> 내림차순</label>
                             <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 건수 : ${fn:length(stationList)} -테스트대여소 포함</span>
                        </div>
                        <table class="tb_type01" id="list">
                            <colgroup>
                                <col style="width:30%"/>
                                <col style="width:20%"/>
                                <col style="width:15%"/>
                                <col style="width:10%"/>
                                <col style="width:15%"/>
                                <col style="width:10%"/>
                                <col style="width:10%"/>
                                <col style="width:10%;"/>
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>대여소</th>
                                    <th title="자전거 거치중 수/전체 거치대수(점검수)">거치대 (점검)</th>
                                    <th title="연결반납 자전거 수/전체 자전거 수(점검수)">자전거 (점검)</th>
                                    <th>거치율(%)</th>
                                    <th>상태</th>
                                    <th>적정재고량</th>
                                    <th>팀명</th>
                                    <th>재배치요청</th>
                                </tr>
                            </thead>
                            <tbody> 
                            
                             <c:forEach var="info" items="${stationList}" varStatus="status" end="100" >
                                <tr>
					                <td class="title tl"><a href="#" id="${ info.stationId }" >${ info.stationName }</a></td>
					                <td class="title tr pr10" title="자전거 거치중 수/전체 거치대수(점검수)">${info.parkingBike})</td>
					                <td class="title tr pr10" title="연결반납 자전거 수/전체 자전거 수(점검수)">${info.systemWarning})</td>
					                <td class="title tr pr10">${ info.shared }</td>
					                <td class="title pl10">
					                    <c:choose>
					                       <c:when test="${info.stationUseYn eq 'N' }">사용정지</c:when>
					                       <c:when test="${info.stationUseYn eq 'C' }">임시폐쇄</c:when>
					                       <c:when test="${info.currnetStatus eq 'Y' }">운휴</c:when>
					                       <c:otherwise>운영중
					                       </c:otherwise>
   					                    </c:choose>
					                </td>
					                <td  class="title pl10" style="text-align: right;">${info.bikeStusCnt}</td>
					                <td>${info.bikeStatusName}</td>
					                <td class="title pl10" style="text-align: right;">${info.movePlacementotCnt}</td>
					            </tr> 
					        </c:forEach>
					        <c:if test="${fn:length(stationList) == 0 }">
					            <tr><td colspan="8" style="text-align: center;"><spring:message code="search.nodata.msg" /></td></tr>
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
						</div> --%>
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

    <!-- <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=04rAq4jj3SZHhhFh7tPX&callback=draw"></script> -->
    
   <!--  <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=4791tlnwi5&callback=draw"></script> -->
    <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=c2yclia2l7&callback=draw"></script>
    
    <script type="text/javascript" src="/js/stationCommonMapv.js"></script>
    <script type="text/javascript" src="/js/common_barocle.js"></script>

	<script type="text/javascript">
	$(function(){
		nMap.initMap();
		nMap.setMap();
		
		// 20190512 팀구분 추가
        commonAjax.getCommonCode("DEC", 
            function(data) {
		         if(data !== null && data.codeList !== null) {
		        	 var code = new Array();
		             for(var i =0; i <data.codeList.length ;i++) {
		                     code.push(data.codeList[i]);
		             }
		             commCdBox.makeComboBox('CC', '', code, "batteryStusCd");
		         }
		});
		
		$("#batteryStusCd").change(function(){
		    find_team(false);
	    });
		
	});
	
	function find_team( flag ){
        
        var select = "<option value=\"\">선택</option>"
        var center = $("#batteryStusCd").val();
        if($("#batteryStusCd").val() == ''){
            $("#searchType").find("option").remove().end();
            $("#searchType").append(select);
        }else{
            $("#searchType").find("option").remove().end();
            $("#searchType").append(select);
            
            $.post("/admin/system/userMgmt/srchTeamList.do", "centerId="+center  , function(data) {
                
                for(var i=0; i < data.teamList.length; i++){
                    $("#searchType").append("<option value='"+data.teamList[i].teamSeq+"'>"+ data.teamList[i].teamNm +"</option>");
                }						

                // 초기 조회일 경우
                if ( flag ) {
                    
                    if("${condition.paramSearchType}" != ""){
		                $("#searchType").val("${condition.paramSearchType}");
		            }
                    
                }
                
            });
        }
	} 
	
	</script>
    
</body>
</html>
