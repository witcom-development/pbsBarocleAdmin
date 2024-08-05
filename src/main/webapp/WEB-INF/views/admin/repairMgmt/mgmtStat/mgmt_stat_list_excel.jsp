<%@ page language="java" contentType="application/vnd.ms-excel;charset=euc-kr"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
    response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode("관리팀통계조회.xls", "UTF8"));
    response.setHeader("Content-Description", "JSP Generated Data");
    
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko">
<head>
<title>SPB</title>
<meta content="text/html; charset=KSC5601" http-equiv="content-type" />

<link href="https://abc.bikeseoul.com/css/solbit200525.css" rel="stylesheet" type="text/css" />

<style type="text/css">

.tb-sb-1 td {font-size:9px;}
.tb-sb-1 th {font-size:9px;}
.widscr span {font-size:9px;}
h2{font-size:9px;}

</style>
</head>
<body>
    <div class="shBox">
    	<table class="tb-sb-1">
    		<thead>
    			<tr><th colspan="16" class="text-center">관리팀 통계 조회 결과</th></tr>
			</thead>
			<tr>
				<td class="text-center">기간</td>
				<td colspan="15">
					 ${searchCondition.searchBgnDe} ~ ${searchCondition.searchEndDe}
				</td>	
			</tr>
		</table>
	</div>
     <!--검색조건 E-->
		<div class="widscr">
			<c:choose>
				<c:when test="${fn:length(mgmtStatVO.adminStatusList) > 0 || fn:length(mgmtStatVO.repairStatusList) > 0}">
					<div>
						<span style="font-weight: bold;">자전거 정비 인원 현황</span>
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
								  								                	
	                      		<table class="tb-sb-1">
	                      			<thead>
	                      				<tr>
	                      					<td colspan="4" class="text-center" style="font-weight: bold; color: blue;">합계</td>
	                      					<td colspan="4" class="text-center" style="font-weight: bold; color: blue;">정비인원(${nAdmCnt+sAdmCnt})</td>
	                      					<td colspan="4" class="text-center" style="font-weight: bold; color: blue;">근무시간(${workTimeCnt})</td>
	                      					<td colspan="4" class="text-center" style="font-weight: bold; color: blue;">정비 외 시간(${dtlTimeCnt})</td>
	                      				</tr>
	                      			</thead>
								<tbody id="temp">
												
									<c:set var="lstVal" value="0" />								  	
								  	<c:forEach items="${mgmtStatVO.adminStatusList}" var="item" varStatus="stat">
								  	
										<c:if test="${lstVal eq '0'}">								  	
										<tr>
								  		</c:if>
								  		
								  		<c:if test="${not empty item.repairCenterUp && empty item.repairCenterName }">
											
											<c:if test="${item.repairCenterUp eq '강북' && empty item.repairCenterName }">
												  <td class="text-center" colspan="4" rowspan="${nCenCnt}">강북(${nAdmCnt}명)</td>
												  <c:set var="lstVal" value="1" />
										  	</c:if>
										  	
											<c:if test="${item.repairCenterUp eq '강남' && empty item.repairCenterName }">
												  <td class="text-center" colspan="4" rowspan="${sCenCnt}">강남(${sAdmCnt}명)</td>
												  <c:set var="lstVal" value="1" />
											</c:if>
												
								  		</c:if>
										
										<c:if test="${not empty item.repairCenterUp && not empty item.repairCenterName }">
										  	<c:set var="lstVal" value="0" />
											
											<td class="text-center" colspan="4">
												${fn:replace(fn:replace(item.repairCenterName,"정비센터", ""),"일반","")}
												(${item.repairAdminNamesCnt})
											</td>
								      		<td class="text-center" colspan="4">${item.repairWorkTime}</td>
								      		<td class="text-center" colspan="4">${item.repairDtlTime}</td>
								      		
								      	</c:if>
								      	
								      	<c:if test="${lstVal eq '0' }">		
										</tr>
										</c:if>
									</c:forEach>
																    													
								</tbody>      
	                      		</table>
	                      	</c:when>
	                      	<c:otherwise>
            	
	                      	</c:otherwise>
	                      	</c:choose>
	                </div>
	                <div>
						<span style="font-weight: bold;">정비현황(건)</span>
	                     <table class="tb-sb-1">
							<thead>
							    <tr>
							      <td class="text-center" rowspan="2">-</td>
							      <td class="text-center" rowspan="2" style="width:50px;">구분</td>
							      <td class="text-center" colspan="12">정비내역</td>
							      <td class="text-center" colspan="2">완료대수</td>
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
</body>
</html>