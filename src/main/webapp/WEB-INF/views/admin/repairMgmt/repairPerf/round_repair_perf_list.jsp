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
										<label for="bb22" class="laType02">기간</label>
										<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" name="searchBgnDe" title="선택 날짜" id="bb22" readonly/></span>
										<span class="dash">~</span>
										<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" name="searchEndDe" title="선택 날짜" readonly/></span>
									</div>
									<div class="section pright">
										<label for="aa2" class="laType02">정비직원</label>
										<span class="input-text07"><input type="text" name="searchAdmin" class=""/></span>
									</div>
									<div class="section">
										<label for="aa1" class="laType02">강남북 구분</label>
										<select class="select-category02" name="searchCenter" id="centerSlt">
											<option value="">선택</option>
											<option value="CEN314">강남</option>
											<option value="CEN313">강북</option>
										</select>
									</div>
									
									<button id="searchBtn" class="btn-srh03 btncase1"><img src="/images/searchIcon.gif" alt="검색"></button>
								</div>
							</fieldset>
						</div>
                       	<!-- 검색조건  E -->

                       	<!-- 검색결과 S -->
                       	<br>
                       	<div>
							
							<h2 style="margin-top: 20px; margin-bottom: 20px">정비실적</h2>
							<c:choose>
								<c:when test="${fn:length(wrkPerfList) ne 0 }">                       	
	                       		<table class="tb-sb-1">
									<colgroup>
	                       				<col style="width:10%">
	                       				<col style="width:10%">
	                       				<col style="width:10%">
	                       				<col style="width:10%">
	                       				<col style="width:10%">
	                       				<col style="width:10%">
	                       				<col style="width:10%">
	                       				<col style="width:10%">
	                       				<col>
	                       			</colgroup>
									<thead>
									    <tr>
									      <td class="text-center">센터구분</td>
									      <td class="text-center">이름</td>
									      <td class="text-center">비콘</td>
									      <td class="text-center">거치대</td>
									      <td class="text-center">AP</td>
									      <td class="text-center">안내간판</td>
									      <td class="text-center">수리<br/>공구대</td>
									      <td class="text-center">기타</td>
									      <td class="text-center">합계</td>
									      <td class="text-center">대여소<br/>방문</td>
									    </tr>
									</thead>
									<tbody>
									<c:set var="itemCheck" value="1" />
									<c:set var="centerCheck" value="" />
									<c:set var="nameCheck" value="" />
									<c:forEach items="${wrkPerfList}" var="item" varStatus="stat">
										<tr class="rebTr">
										 
											<td class="text-center">${item.centerName}</td>								    
											<td class="text-center">${item.adminName}</td>								    
											<td class="text-right">${item.r01}</td>								    
											<td class="text-right">${item.r02}</td>
											<td class="text-right">${item.r03}</td>
											<td class="text-right">${item.r04}</td>
											<td class="text-right">${item.r05}</td>
											<td class="text-right">${item.r06}</td>
											<td class="text-right">${item.tot}</td>
											<td class="text-right">${item.stationCnt}</td>
											
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
						<br/>
						<h2 style="margin-top: 20px; margin-bottom: 20px">상세실적(1일 단위 조회시간 조회)</h2>
						<c:choose>
								<c:when test="${fn:length(perfDtlList) ne 0 }">                       	
	                       		<table class="tb-sb-1">
									<colgroup>
	                       				<col style="width:10%">
	                       				<col style="width:20%">
	                       				<col style="width:20%">
	                       				<col style="width:20%">
	                       				<col style="width:10%">
	                       				<col style="width:10%">
	                       				<col style="width:10%">
	                       				<col>
	                       			</colgroup>
									<thead>
									    <tr>
									      <td class="text-center">센터구분</td>
									      <td class="text-center">대여소</td>
									      <td class="text-center">이름</td>
									      <td class="text-center">시간</td>
									      <td class="text-center">구분</td>
									      <td class="text-center">상세내용</td>
									      <td class="text-center">작업구분</td>
									    </tr>
									</thead>
									<tbody>
									<c:set var="itemCheck" value="1" />
									<c:set var="centerCheck" value="" />
									<c:set var="nameCheck" value="" />
									<c:forEach items="${perfDtlList}" var="item" varStatus="stat">
										<tr class="rebTr">
											<td class="text-center">${item.centerName}</td>								    
											<td class="text-center">${item.stationName}</td>								    
											<td class="text-center">${item.adminName}</td>								    
											<td class="text-center">${item.regDttm}</td>								    
											<td class="text-center">${item.repairMain}</td>
											<td class="text-center">${item.repairName}</td>
											<td class="text-center">${item.repairType}</td>
										</tr>		
									</c:forEach>
									</tbody>
									<tfoot>    
									    <tr>
									    </tr>
									</tfoot>    
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
                    <div class="right my-3"><input type="button"  id="printBtn" value="프린트" class="s-btn s-btn-primary" onclick="javascript:fnContentPrint('searchResultArea');"></div>
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
        	
        	var date = new Date;
    		date.setDate(date.getDate()-6);
    		var fromday = DateUtil.dateFmt(new Date()); /* DateUtil.dateFmt(date); 당일로 변경*/
    		var today = DateUtil.dateFmt(new Date());
     		var sDate = '${searchCondition.searchBgnDe}' !== '' ? '${searchCondition.searchBgnDe}' : fromday;
    		var eDate = '${searchCondition.searchEndDe}' !== '' ? '${searchCondition.searchEndDe}' : today;
    		var searchAdmin = '${searchCondition.searchAdmin}' !== '' ? '${searchCondition.searchAdmin}' : '';
    		var searchCenter = '${searchCondition.searchCenter}' !== '' ? '${searchCondition.searchCenter}' : '';
    		
    		wrkPerfInfo.searchCenterId = searchCenter;
    		
    		$("[name='searchBgnDe']").val(sDate);
    		$("[name='searchEndDe']").val(eDate);
    		$("[name='searchAdmin']").val(searchAdmin);
    		$("[name='searchCenter']").val(searchCenter);
    		
        	/*********** 검색구간 정보 E  ***********/
    		
    		wrkPerfInfo.init();
    		
        });

        /*********** 변수 & 함수 S ***********/
        
       	var wrkPerfInfo = {};
        
        wrkPerfInfo.init = function(){
        	
	    	var _this = this;
			$("#searchBtn").on("click",function(e){
				e.preventDefault();
				$("[name='viewFlg']").val("list");
				$("#searchFrm").attr({method : 'post', action : '/getRoundRepairPerf.do'}).submit();
			});
	    	
			$("#excelViewBtn").on("click",function(e){
				e.preventDefault();
		         $("[name='currentPageNo']").val(1);
		         $("[name='viewFlg']").val("excel");
		         $("#searchFrm").attr({method : 'post', action : '/getRoundRepairPerf.do'}).submit();
			});

        }
        
        
        /*********** 변수 & 함수 E ***********/
           

    </script>
</body>
</html>