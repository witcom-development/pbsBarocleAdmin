<%@page import="com.dkitec.barocle.base.IConstants"%>
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
<!-- 
	개발일시 : 2021-01-17
	개발자   : 양재영
	내용     : 분배직원 경정비 실적 조회 화면
-->
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" /> 
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />
<meta name="description=" Content="" />
<title><tiles:insertAttribute name="title"/></title>
<tiles:insertAttribute name="resource"/>
<style type="text/css" media="print">
    @page 
    {
        size: auto;  
        margin-top: 10mm;  
        margin-bottom: 0mm;  
    }
</style>
</head>
<body>
<!-- solbit test-테스트 페이지  S   -->
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
						<p class="pageTitle"><c:forEach items="${menuPathList}" var="menuPath" varStatus="status"><c:if test="${status.last}"><c:out value="${menuPath}" />(<c:out value="${searchCondition.adminGrpName}" />)</c:if></c:forEach></p>
						<span>
							<c:forEach items="${menuPathList}" var="menuPath" varStatus="status">
								<c:choose>
									<c:when test="${!status.last}"><c:out value="${menuPath}"/> &gt; </c:when>
									<c:otherwise><em><c:out value="${menuPath}"/></em></c:otherwise>
								</c:choose>
							</c:forEach>
						</span>
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
						<!-- 검색조건  S -->
                       	<form id="searchFrm">
                       	<div id="searchResultArea">
                        <div class="shBox">
                        
                        	<input type="hidden" name="viewFlg" value="" />
                        	
                        	<fieldset>
								<legend>검색 옵션</legend>
								<div class="shBoxSection">
									<div class="section">
										<label for="a1" class="laType02">기간</label>
										<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" name="searchBgnDe" title="선택 날짜" id="bb22" readonly/></span>
										<span class="dash">~</span>
										<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" name="searchEndDe" title="선택 날짜" readonly/></span>
									</div>
									<div class="section pright">
										<label for="b1" class="laType02">직원</label>
										<span class="input-text07"><input type="text" name="searchAdmin" class=""/></span>
									</div>
									<div class="section">
										<label for="c1" class="laType02">사업소</label>
										<select class="select-category02" name="searchOffice" id="searchOffice">
											<option value="" title="" >선택</option>
											<c:choose>
												<c:when test="${searchCondition.searchOffice == '강남관리소'}">
													<option value="강남관리소" title="강남관리소" selected="selected">강남관리소</option>
													<option value="강북관리소" title="강북관리소" >강북관리소</option>
												</c:when>
												<c:when test="${searchCondition.searchOffice == '강북관리소'}">
													<option value="강남관리소" title="강남관리소" >강남관리소</option>
												<option value="강북관리소" title="강북관리소" selected="selected">강북관리소</option>
												</c:when>
												<c:otherwise>
													<option value="강남관리소" title="강남관리소" >강남관리소</option>
													<option value="강북관리소" title="강북관리소" >강북관리소</option>
												</c:otherwise>
											</c:choose>
											 
										</select>
											
									</div>

									<div class="section pright">
										<label for="d1" class="laType02">센터</label>
										<select class="select-category02" name="searchCenter" id="centerSlt">
											<option value="" title="" >선택</option>
											<c:forEach items="${teamList }" var="teamList" varStatus="status">
												  <%--  <option value="${teamList.comCd }" selected="selected"><c:out value="${teamList.comCdName}"/></option> --%>  
													<c:if test="${searchCondition.searchCenter == teamList.comCd}">   
														 <option value="${teamList.comCd }" selected="selected"><c:out value="${teamList.comCdName}"/></option> 
													</c:if>
													<c:if test="${searchCondition.searchCenter != teamList.comCd}">   
														 <option value="${teamList.comCd }"><c:out value="${teamList.comCdName}"/></option> 
													</c:if>
											</c:forEach>		
											
										</select>
									</div>
									<button id="searchBtn" class="btn-srh03 btncase1" style="position:initial"><img src="/images/searchIcon.gif" alt="검색"></button>
								</div>
							</fieldset>
						</div>
                       	<!-- 검색조건  E -->

                       	<!-- 검색결과 S -->
                       	<br>
                       	<div>
							<%-- <p class="tb_numlist">총 ${ paginationInfo.getTotalRecordCount()} 건</p>    --%>                    	
							<c:choose>
								<c:when test="${fn:length(wrkLightList) ne 0 }">                       	
	                       		<table class="tb-sb-1">
									<thead>
									    <tr>
									      <td class="top text-center" rowspan="2" style="width:15%;">사업소</td>
									      <td class="top text-center" rowspan="2" style="width:15%;">팀</td>
									      <td class="top text-center" rowspan="2" style="width:15%;">id</td>
									      <td class="top text-center" rowspan="2" style="width:15%;">이름</td>
									      <td class="top text-center" colspan="4" style="width:45%;">정비내역</td>
									      <td class="top text-center" rowspan="2" style="width:10%;">완료건수</td>
									      <td class="top text-center" rowspan="2" style="width:10%;">자전거대수</td>
									    </tr>
									    <tr>
									      <td class="text-center">스탠드</td>
									      <td class="text-center">물받이</td>
									      <td class="text-center">타이어 튜브</td>
									      <td class="text-center">배터리 교체</td>
									    </tr>
									</thead>
									<tbody>
									<c:set var="itemCheck" value="1" />
									<c:set var="centerCheck" value="" />
									<c:set var="nameCheck" value="" />
									<c:forEach items="${wrkLightList}" var="item" varStatus="stat">
									    
									    <c:choose>

											<c:when test="${item.repairCenterName eq '합계'}"><tr class="rebTr" style="background-color:#93DAFF; height: 4em "></c:when>
											<c:when test="${item.repairTeamName eq '합계'}"><tr class="rebTr" style="background-color:#FFAAAF; height: 3em "></c:when>
											<c:when test="${item.repairAdminId eq '합계'}"><tr class="rebTr" style="background-color:#E6FFE6; height: 2em "></c:when>
											<c:otherwise><tr class="rebTr"></c:otherwise>
										</c:choose>
									    
									      	<td class="text-center" >${item.repairCenterName }</td>
									      	<td class="text-center" >${item.repairTeamName }</td>
									      	<td class="text-center" >${item.repairAdminId }</td>
									      	<td class="text-center" >${item.repairAdminName}</td>
											<td class="text-right">${item.REB_009}</td>								    
											<td class="text-right">${item.REB_018}</td>								    
											<td class="text-right">${item.REB_024}</td>								    
											<td class="text-right">${item.REB_057}</td>								    
											<td class="text-right">${item.repairTotCnt}</td>								    
											<td class="text-right">${item.repairBikeCnt}</td>								    
									    </tr>
									</c:forEach>
									    
									</tbody> 
	                       		</table>
	                       	</c:when>	
	                       	
                      		<c:otherwise>
                                <table class="tb_type01 nbt0">
		                            <tr><td style="text-align:center"><spring:message code="search.nodata.msg" /></td></tr>
		                        </table>
							</c:otherwise>
						</c:choose>
                    </div>
                    </div>
                    <div class="right my-3" style="margin-right:10px;"><input type="button"  id="excelViewBtn" value="엑셀다운로드" class="s-btn s-btn-primary"></div>
                  	<!-- 검색결과 E -->
                       	
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

        	/****** 그룹 별 화면 show hide 처리 S ******/
        	switch('${searchCondition.adminGrpName}'){
    				
    			case "분배" :
    				
    				// $("[name='searchAdmin']").closest('div').hide();
    				$("[name='searchAdmin']").attr("readonly",true);
    				$("[name='searchOffice']").closest('div').hide();
    				$("[name='searchCenter']").closest('div').hide();
    				
    			case "분배반장" :
    				
    				$("[name='searchOffice']").closest('div').hide();
    				
    				// $("[name='searchCenter']").closest('div').attr("style","visibility:hidden");
    				
    			break;
    			
    			case "관리운영그룹" :
    			case "관리팀" :
    			break;
    			
    			default :

    			//	$("#printBtn").hide();
    			//	$("[name='searchAdmin']").closest('div').hide();				
    			//	$("[name='searchCenter']").closest('div').attr("style","visibility:hidden");
    				
    			break;	
    			
        	}
        	
        	/****** 그룹 별 화면 show hide 처리 E ******/
    		
        	/*********** 검색구간 정보 S  ***********/
        	
        	var date = new Date;
    		date.setDate(date.getDate()-6);
    		var fromday = DateUtil.dateFmt(new Date()); /* DateUtil.dateFmt(date); 당일로 변경*/
    		var today = DateUtil.dateFmt(new Date());
     		var sDate = '${searchCondition.searchBgnDe}' !== '' ? '${searchCondition.searchBgnDe}' : fromday;
    		var eDate = '${searchCondition.searchEndDe}' !== '' ? '${searchCondition.searchEndDe}' : today;
    		var searchAdmin = '${searchCondition.searchAdmin}' !== '' ? '${searchCondition.searchAdmin}' : '';
    		var searchCenter = '${searchCondition.searchCenter}' !== '' ? '${searchCondition.searchCenter}' : '';
    		
    		wrkLightInfo.searchCenterId = searchCenter;
    		
    		$("[name='searchBgnDe']").val(sDate);
    		$("[name='searchEndDe']").val(eDate);
    		$("[name='searchAdmin']").val(searchAdmin);
    		$("[name='searchCenter']").val(searchCenter);
    		
        	/*********** 검색구간 정보 E  ***********/
    		
    		wrkLightInfo.init();
    		
        });

        /*********** 변수 & 함수 S ***********/
        
       	var wrkLightInfo = {};
        
        wrkLightInfo.init = function(){
        	
	    	var _this = this;
	    	
 			$("#searchBtn").on("click",function(e){
				
				e.preventDefault();
				
				$("[name='viewFlg']").val("list");
				
				$("#searchFrm").attr({method : 'post', action : '/getLightRepairBike.do'}).submit();
				
			});
	    	
			$("#excelViewBtn").on("click",function(e){
				
				e.preventDefault();
		         
		         $("[name='currentPageNo']").val(1);

		         $("[name='viewFlg']").val("excel");
		         
		         $("#searchFrm").attr({method : 'post', action : '/getLightRepairBike.do'}).submit();
		         
			});

        }
          
        /*********** 변수 & 함수 E ***********/
           

    </script>
</body>
</html>