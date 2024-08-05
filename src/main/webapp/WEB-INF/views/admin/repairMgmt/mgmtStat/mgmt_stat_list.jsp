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
	개발일시 : 2020-06-29
	개발자   : 김시성
	내용     : 관리팀 통계 조회 화면
	TODO : 
	       
	ASIS : 통계테이블을 사용하는 쿼리로 수정
	       단말기 완료대수 추가 - 2020-09-24
	       자전거 정비 인원 현황 합계 추가 - 2020-09-24 
	       통계 쿼리 완전 갈아엎음에 따라 화면도 갈아엎자 - 2020-11-04
	       
 -->
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" /> 
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />
<meta name="description=" Content="" />
<title><tiles:insertAttribute name="title"/></title>
<tiles:insertAttribute name="resource"/>
<style type="text/css">

h2 {
	margin-top: -6px;
	margin-bottom: -6px;
}

.stt {

	font-weight: bold; 
	color: blue;

}

.mtt {

	color: #33335a; 
	background: #eff5f8; 
	font-weight: bold;
	
}

</style>
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
						<!-- 검색조건  S -->
                       	<div id="searchResultArea">
	                       	<form id="searchFrm">
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
										</div>
										<button id="searchBtn" class="btn-srh03 btncase1"><img src="/images/searchIcon.gif" alt="검색"></button>
									</div>
								</fieldset>
							</div>
	                       	<!-- 검색조건  E -->                       	
	                       	<!-- 검색결과 S -->
							<c:choose>
								<c:when test="${fn:length(mgmtStatVO.adminStatusList) > 0 || fn:length(mgmtStatVO.repairStatusList) > 0}">
								<div class="mt10">
									<h2>자전거 정비 인원 현황</h2>
									<c:choose>
										<c:when test="${fn:length(mgmtStatVO.adminStatusList) > 0}">     

										<c:set var="nCenCnt" value="0" />	
										<c:set var="nAdmCnt" value="0" />	
										<c:set var="sCenCnt" value="0" />
										<c:set var="sAdmCnt" value="0" />
										
										<c:set var="workTimeCnt" value="0" />
										<c:set var="dtlTimeCnt" value="0" />
									  	<c:forEach items="${mgmtStatVO.adminStatusList}" var="item" varStatus="stat">
									  
								  			<c:if test="${item.repairCenterUp eq '강북' && not empty item.repairCenterName }">
								  				<c:set var="nCenCnt" value="${nCenCnt+1}" />
								  				<c:set var="nAdmCnt" value="${nAdmCnt+item.repairAdminNamesCnt}" />
								  			</c:if>
								  		
								  			<c:if test="${item.repairCenterUp eq '강남' && not empty item.repairCenterName }">
								  				<c:set var="sCenCnt" value="${sCenCnt+1}" />
								  				<c:set var="sAdmCnt" value="${sAdmCnt+item.repairAdminNamesCnt}" />
								  			</c:if>
								  			
								  			<c:set var="workTimeCnt" value="${workTimeCnt+item.repairWorkTime}" />
								  			<c:set var="dtlTimeCnt" value="${dtlTimeCnt+item.repairDtlTime}" />
								  		
									  	</c:forEach>
										           	
			                       		<table class="tb-sb-1 my-3">
			                       			<colgroup>
			                       				<col style="width:10%;">
			                       				<col style="width:15%;">
			                       				<col style="width:30%">
			                       				<col style="width:35%">
			                       			</colgroup>
			                       			<thead>
			                       				<tr>
			                       					<td class="top text-center stt" >합계</td>
			                       					<td class="top text-center stt" >정비인원(${nAdmCnt+sAdmCnt})</td>
			                       					<td class="top text-center stt" >근무시간(${workTimeCnt})</td>
			                       					<td class="top text-center stt" >정비 외 시간(${dtlTimeCnt})</td>
			                       				</tr>
			                       			</thead>
											<tbody id="temp">
											  	
											  	<c:forEach items="${mgmtStatVO.adminStatusList}" var="item" varStatus="stat">
											  	
													<tr>
											  		
											  		<c:if test="${not empty item.repairCenterUp && empty item.repairCenterName }">
														
														<c:if test="${item.repairCenterUp eq '강북' && empty item.repairCenterName }">
															  <td class="text-center" rowspan="${nCenCnt+1}">강북(${nAdmCnt}명)</td>
													  	</c:if>
													  	
														<c:if test="${item.repairCenterUp eq '강남' && empty item.repairCenterName }">
															  <td class="text-center" rowspan="${sCenCnt+1}">강남(${sAdmCnt}명)</td>
														</c:if>
															
											  		</c:if>
													
													<c:if test="${not empty item.repairCenterUp && not empty item.repairCenterName }">
														
														<td class="text-center">
															${fn:replace(fn:replace(item.repairCenterName,"정비센터", ""),"일반","")}
 															(${item.repairAdminNamesCnt})
														</td>
											      		<td class="text-center">${item.repairWorkTime}</td>
											      		<td class="text-center">${item.repairDtlTime}</td>
											      		
											      	</c:if>
											      		
													</tr>
													
												</c:forEach>
												
											</tbody>      
			                       		</table>
			                       	</c:when>
			                       	</c:choose>
	                       		</div>
	                       		<div>
									<h2>정비현황(건)</h2>
	                       		<table class="tb-sb-1 my-3" id="repairTable">
									<thead>
									    <tr>
									      <td class="top text-center" rowspan="2">-</td>
									      <td class="top text-center" rowspan="2" style="width:50px;">구분</td>
									      <td class="top text-center" colspan="12">정비내역</td>
									      <td class="top text-center" colspan="2">완료대수</td>
									    </tr>
									    <tr>
									      <td class="text-center">단말기</td>
									      <td class="text-center">벨</td>
									      <td class="text-center">핸들</td>
									      <td class="text-center" style="width:80px;">브레이크</td>
									      <td class="text-center">변속기</td>
									      <td class="text-center">타이어<br>튜브</td>
									      <td class="text-center">체인</td>
									      <td class="text-center">체인받이</td>
									      <td class="text-center">물받이</td>
									      <td class="text-center">스탠드</td>
									      <td class="text-center">기타</td>
									      <td class="text-center">계</td>
									      <td class="text-center">단말기</td>
									      <td class="text-center">자전거</td>
									    </tr>
									</thead>
									<tbody id="repairPerfBody">
									<c:set var="statusCenterName" value="" />
									<c:forEach items="${mgmtStatVO.repairStatusList}" var="item" varStatus="stat">
									
										<tr>
											<c:if test="${item.divsnCnt eq '1'}">	
								      			<td class="text-center" rowspan="2">${fn:replace(fn:replace(item.statusCenterName,"정비센터", ""),"일반","")}</td>
								      		</c:if>
								      		
								      		<c:if test="${item.divsnCnt eq '3' || item.divsnCnt eq '4' }">
											  	<c:if test="${item.divsnCnt eq '3'}">
												  	<td class="text-center stt" rowspan="2">
												  		${item.statusCenterUp}
												  	</td>
											  	</c:if>
										  	</c:if>	
									  		<c:choose>
									  			<c:when test="${item.divsnCnt eq '1'}"><td class="text-center">점검</td></c:when>
									  			<c:when test="${item.divsnCnt eq '2'}"><td class="text-center">정비</td></c:when>
									  			<c:when test="${item.divsnCnt eq '3'}"><td class="text-center stt">점검</td></c:when>
									  			<c:when test="${item.divsnCnt eq '4'}"><td class="text-center stt">정비</td></c:when>
									  		</c:choose>
											<c:if test="${item.divsnCnt eq '1'  || item.divsnCnt eq '2' }">  
													<td class="text-center">${item.termCnt}</td>								    
													<td class="text-center">${item.bellCnt}</td>								    
													<td class="text-center">${item.handleCnt}</td>								    
													<td class="text-center">${item.brakeCnt}</td>								    
													<td class="text-center">${item.transCnt}</td>								    
													<td class="text-center">${item.ttCnt}</td>								    
													<td class="text-center">${item.chainCnt}</td>								    
													<td class="text-center">${item.chainCvCnt}</td>								    
													<td class="text-center">${item.trghCnt}</td>								    
													<td class="text-center">${item.standCnt}</td>								    
													<td class="text-center">${item.etcCnt}</td>								    
													<td class="text-center">${item.sumCnt}</td>
											</c:if>
											<c:if test="${item.divsnCnt eq '3'  || item.divsnCnt eq '4' }">  
													<td class="text-center stt">${item.termCnt}</td>								    
													<td class="text-center stt">${item.bellCnt}</td>								    
													<td class="text-center stt">${item.handleCnt}</td>								    
													<td class="text-center stt">${item.brakeCnt}</td>								    
													<td class="text-center stt">${item.transCnt}</td>								    
													<td class="text-center stt">${item.ttCnt}</td>								    
													<td class="text-center stt">${item.chainCnt}</td>								    
													<td class="text-center stt">${item.chainCvCnt}</td>								    
													<td class="text-center stt">${item.trghCnt}</td>								    
													<td class="text-center stt">${item.standCnt}</td>								    
													<td class="text-center stt">${item.etcCnt}</td>								    
													<td class="text-center stt">${item.sumCnt}</td>
											</c:if>	
											
											<c:if test="${item.divsnCnt eq '1' || item.divsnCnt eq '3' }">
												<c:if test="${item.divsnCnt eq '1'}">
													<td class="text-center" rowspan="2">${item.cmptTermCnt}</td>	
													<td class="text-center" rowspan="2">${item.bikeCnt}</td>
												</c:if>
												<c:if test="${item.divsnCnt eq '3' }">
													<td class="text-center stt" rowspan="2">${item.cmptTermCnt}</td>	
													<td class="text-center stt" rowspan="2">${item.bikeCnt}</td>
												</c:if>
											</c:if>
										</tr>
										</c:forEach>
									</tbody>
	                       		</table>               		                       		
	                       		</div>
	                       	</c:when>	
                      		<c:otherwise>
                                <table class="tb_type01 nbt0">
		                            <tr><td style="text-align:center"><spring:message code="search.nodata.msg" /></td></tr>
		                        </table>
							</c:otherwise>
						</c:choose>
                    </div>
                    <div class="right my-3"><input type="button" value="프린트" class="s-btn s-btn-primary" onclick="javascript:fnContentPrint('searchResultArea');"></div>
                    <div class="right my-3" style="margin-right:10px;"><input type="button"  id="excelViewBtn" value="엑셀다운로드" class="s-btn s-btn-primary"></div>
                  	<!-- 검색결과 E -->
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
    	
    	/*********** 검색구간 정보 S  ***********/
    	
    	var date = new Date;
		date.setDate(date.getDate()-6);
		var fromday = DateUtil.dateFmt(date);
		var today = DateUtil.dateFmt(new Date());
 		var sDate = '${searchCondition.searchBgnDe}' !== '' ? '${searchCondition.searchBgnDe}' : fromday;
		var eDate = '${searchCondition.searchEndDe}' !== '' ? '${searchCondition.searchEndDe}' : today;
		
		
		$("[name='searchBgnDe']").val(sDate);
		$("[name='searchEndDe']").val(eDate);
		
    	/*********** 검색구간 정보 E  ***********/
    	
    	
		$("#searchBtn").on("click",function(e){
			e.preventDefault();
			
		    $("[name='viewFlg']").val("list");
		    
			$("#searchFrm").submit();
		});
		
	    
		$("#excelViewBtn").on("click",function(e){
			
			e.preventDefault();
	         
	        $("[name='viewFlg']").val("excel");
	         
	        $("#searchFrm").submit();
	         
		});
	    
	    // 마지막 row 색 변경
	    $("#repairPerfBody").find("tr").eq(22).attr("class", "text-center mtt");
	    $("#repairPerfBody").find("tr").eq(23).attr("class", "text-center mtt"); 
		
 
    })
    </script>
</body>
</html>