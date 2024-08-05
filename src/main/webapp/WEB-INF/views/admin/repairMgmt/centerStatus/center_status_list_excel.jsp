<%@ page language="java" contentType="application/vnd.ms-excel;charset=euc-kr"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="java.util.Calendar"          %>
<%
Calendar today = Calendar.getInstance();

String getNowDatetime = "" + today.get(Calendar.YEAR) + (today.get(Calendar.MONTH)+1) + today.get(Calendar.DATE) + today.get(Calendar.HOUR) + today.get(Calendar.MINUTE) + today.get(Calendar.SECOND);

    response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode("사업소현황조회_" + getNowDatetime +".xls", "UTF8"));
    response.setHeader("Content-Description", "JSP Generated Data");
    
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko">
<head>
<title>SPB</title>
<meta content="text/html; charset=KSC5601" http-equiv="content-type" />

<link href="https://abc.bikeseoul.com/css/solbit200525.css" rel="stylesheet" type="text/css" />
<link href="https://abc.bikeseoul.com/css/style.css" rel="stylesheet" type="text/css" />

<style type="text/css">
.tb-sb-1 td {font-size:12px;}
.tb-sb-1 th {font-size:12px;}
.widscr span {font-size:12px;}
</style>
</head>
<body>
   	<table class="tb-sb-1">
   		<thead>
   			<tr><th colspan="16" class="text-center"><h2>${statusVO.workCenterName}</h2></th></tr>
		</thead>
		<tr>
			<td colspan="2" class="text-center">기간</td>
			<td colspan="14">
				 ${searchCondition.searchBgnDe} ~ ${searchCondition.searchEndDe}
			</td>	
		</tr>
	</table>
	<br/>
     <!--검색조건 E-->
		<div class="widscr">
			<c:choose>
				<c:when test="${statusVO.repairBikeCnt ne '0' || statusVO.repairTermCnt ne '0' || statusVO.repairWorkAdminsCnt ne '0'}">
				<br/>
				<div>
					<h4>자전거 입출고현황</h4>  
                     <table class="tb-sb-1">
						<thead>
						    <tr>
						      <td class="text-center" colspan="2">구분</td>
						      <td colspan="6" class="text-center">단말기 수리완료</td>
						      <td colspan="6" class="text-center">자전거 수리완료</td>
						      <td colspan="2" class="text-center">비고</td>
						    </tr>
						</thead>
						<tbody id="temp">   
						    <tr>
						      <td class="text-center" colspan="2">일계</td>
						      <td colspan="6" class="text-center">${statusVO.dayTermCnt}</td>
						      <td colspan="6" class="text-center">${statusVO.dayBikeCnt}</td>
						      <td colspan="2" class="text-center"></td>
						    </tr>
						    <tr>
						      <td class="text-center" colspan="2">누계</td>
						      <td colspan="6" class="text-center">${statusVO.repairTermCnt}</td>
						      <td colspan="6" class="text-center">${statusVO.repairBikeCnt}</td>
						      <td colspan="2" class="text-center"></td>
						    </tr>
						</tbody>      
                     </table>
                  </div>
                  <br/>
                  <div>
					<h4>근무현황</h4>           	
                    <table class="tb-sb-1">
						<tbody id="repairPerfBody">   
						    <tr>
						      <td colspan="2" class="text-center">주간근무자(${statusVO.repairWorkAdminsCnt}명)</td>
						      <td colspan="14" class="text-center">${statusVO.repairWorkAdmins}</td>
						    </tr>
						</tbody>      
                    </table>	                       		
                  </div>
                  <br/>
                  <div>
                  	<span style="font-weight: bold;">정비현황</span>
                  	<table class="tb-sb-1">
						<thead>
						    <tr>
						      <td class="text-center" colspan="2">구분</td>
						      <td  colspan="3" class="text-center">근무시간</td>
						      <td  colspan="3" class="text-center">근무 외 시간</td>
						      <td  colspan="3" class="text-center">단말기 수리완료</td>
						      <td  colspan="3" class="text-center">자전거 수리완료</td>
						      <td  colspan="2" class="text-center">비고</td>
						    </tr>
						</thead>
						<tbody id="temp1">
						  <c:forEach items="${statusVO.workAdminList}" var="item" varStatus="status">
						  	<c:if test="${empty item.workAdminName}">										   
							    <tr>
							      <td class="text-center" colspan="2">합계</td>
							      <td  colspan="3" class="text-center">
							      
							      	<c:if test="${not empty item.workTime}">
							      		${item.workTime}
							      	</c:if>
							      	<c:if test="${empty item.workTime}">
							      		0
							      	</c:if>
							      	
							      </td>
							      <td  colspan="3" class="text-center">
							      
							      	<c:if test="${not empty item.workDtlTime}">
							      		${item.workDtlTime}
							      	</c:if>
							      	<c:if test="${empty item.workDtlTime}">
							      		0
							      	</c:if>
							      	
							      </td>							      
							      <td  colspan="3" class="text-center">
							      
								      <c:if test="${not empty item.workAdminTermCnt}">
								      		${item.workAdminTermCnt}
								      </c:if>
								      <c:if test="${empty item.workAdminTermCnt}">
								      		0
								      </c:if>
							      
							      </td>
							      <td  colspan="3" class="text-center">
							      
							      	<c:if test="${not empty item.workAdminBikeCnt}">
							      		${item.workAdminBikeCnt}
							      	</c:if>
							      	<c:if test="${empty item.workAdminBikeCnt}">
							      		0
							      	</c:if>
							      
							      </td>
							      <td  colspan="2" class="text-center"></td>
							    </tr>
						    </c:if>
						  </c:forEach>  
						  <c:forEach items="${statusVO.workAdminList}" var="item" varStatus="status">
						  	<c:if test="${not empty item.workAdminName}">  
							    <tr>
							      <td  colspan="2" class="text-center">${item.workAdminName}</td>
							      <td  colspan="3" class="text-center">${item.workTime}</td>
							      <td  colspan="3" class="text-center">${item.workDtlTime}</td>
							      <c:if test="${empty item.workAdminTermCnt}">
							      	<td colspan="3" class="text-center">0</td>
							      </c:if>
							      <c:if test="${not empty item.workAdminTermCnt}">
							      	<td  colspan="3" class="text-center">${item.workAdminTermCnt}</td>
							      </c:if>
							      <c:if test="${empty item.workAdminBikeCnt}">
							      	<td  colspan="3" class="text-center">0</td>
							      </c:if>
							      <c:if test="${not empty item.workAdminBikeCnt}">
							      	<td   colspan="3"class="text-center">${item.workAdminBikeCnt}</td>
							      </c:if>
							      <c:if test="${empty item.workAdminRemark}">
							      	<td   colspan="2"class="text-center"></td>
							      </c:if>
							      <c:if test="${not empty item.workAdminRemark}">
							      	<td  colspan="2" class="text-center">${item.workAdminRemark}</td>
							      </c:if>
							    </tr>
						    </c:if>
						  </c:forEach>  
						</tbody>      
                    </table>
                  <div>
            	</div>
          	</div>
        
        	<div>
	          	<h4>정비현황(건)</h4>
							<%-- <p class="tb_numlist">총 ${ paginationInfo.getTotalRecordCount()} 건</p>    --%>                    	
							<c:choose>
								<c:when test="${fn:length(wrkPerfList) ne 0 }">                       	
	                       		<table class="tb-sb-1">
									<thead>
									    <tr>
									      <td class="top text-center" rowspan="2" style="width:7%;">이름</td>
									      <td class="top text-center" rowspan="2" style="width:5%;">구분</td>
									      <td class="top text-center" colspan="12" style="width:67%;">정비내역</td>
									      <td class="top text-center" colspan="2" style="width:13%;">완료대수</td>
									    </tr>
									    <tr>
									      <td class="text-center">단말기</td>
									      <td class="text-center">벨</td>
									      <td class="text-center">핸들</td>
									      <td class="text-center">브레<br>이크</td>
									      <td class="text-center">변속기</td>
									      <td class="text-center">타이어<br>튜브</td>
									      <td class="text-center">체인</td>
									      <td class="text-center">체인<br>받이</td>
									      <td class="text-center">물받이</td>
									      <td class="text-center">스탠드</td>
									      <td class="text-center">기타</td>
									      <td class="text-center">계</td>
									      <td class="text-center">단말기</td>
									      <td class="text-center">자전거</td>
									    </tr>
									</thead>
									
									<tbody>
									
									<c:set var="itemCheck" value="1" />
									<c:set var="centerCheck" value="" />
									<c:set var="nameCheck" value="" />
									<c:forEach items="${wrkPerfList}" var="item" varStatus="stat">
									
										<c:if test="${item.divsnCnt eq '1'}">
										    <tr class="rebTr">
										      	<td class="text-center" rowspan="3">${item.repairAdminName}</td>
										      	<td class="text-center">점검</td>
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
																				    
												<td class="text-center" rowspan="3">
													<c:if test="${empty item.cmptTermCnt }">
														0
													</c:if>
													<c:if test="${not empty item.cmptTermCnt }">
														${item.cmptTermCnt}
													</c:if>
												
												</td>
												
												<td class="text-center" rowspan="3">
													<c:if test="${empty item.bikeCnt }">
														0
													</c:if>
													<c:if test="${not empty item.bikeCnt }">
														${item.bikeCnt}
													</c:if>
												
												</td>
																				    
										    </tr>
										    <c:set var="centerCheck" value="${item.repairCenterName}" />
											<c:set var="nameCheck" value="${item.repairAdminName}" />										      	
									    </c:if>
										<c:if test="${item.divsnCnt eq '2' && item.repairCenterName eq centerCheck && item.repairAdminName eq nameCheck}">									    
										    <tr class="parTr">
										      	<td class="text-center">정비</td>
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
										    </tr>										      	
									    </c:if>
 										<c:if test="${item.divsnCnt eq '2' && ( item.repairCenterName ne centerCheck  || item.repairCenterName eq centerCheck ) && item.repairAdminName ne nameCheck}">
 											<tr class="rebTr">
										      	<td class="text-center" rowspan="3">${item.repairCenterName }</td>
										      	<td class="text-center" rowspan="3">${item.repairAdminName}</td>
										      	<td class="text-center">점검</td>
												<td class="text-center">0</td>								    
												<td class="text-center">0</td>								    
												<td class="text-center">0</td>								    
												<td class="text-center">0</td>								    
												<td class="text-center">0</td>								    
												<td class="text-center">0</td>								    
												<td class="text-center">0</td>								    
												<td class="text-center">0</td>								    
												<td class="text-center">0</td>								    
												<td class="text-center">0</td>								    
												<td class="text-center">0</td>								    
												<td class="text-center">0</td>
																				    
												<td class="text-center" rowspan="3">
													<c:if test="${empty item.cmptTermCnt }">
														0
													</c:if>
													<c:if test="${not empty item.cmptTermCnt }">
														${item.cmptTermCnt}
													</c:if>
												
												</td>
												
												<td class="text-center" rowspan="3">
													<c:if test="${empty item.bikeCnt }">
														0
													</c:if>
													<c:if test="${not empty item.bikeCnt }">
														${item.bikeCnt}
													</c:if>
												
												</td>
																				    
										    </tr>									    
										    <tr class="parTr">
										      	<td class="text-center">정비</td>
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
										    </tr>										      	
									    </c:if>
									    <c:if test="${empty item.divsnCnt && itemCheck eq '1' }">
										    <tr class="parTr">
										      	<td class="text-center">정비</td>
												<td class="text-center">0</td>								    
												<td class="text-center">0</td>								    
												<td class="text-center">0</td>								    
												<td class="text-center">0</td>								    
												<td class="text-center">0</td>								    
												<td class="text-center">0</td>								    
												<td class="text-center">0</td>								    
												<td class="text-center">0</td>								    
												<td class="text-center">0</td>								    
												<td class="text-center">0</td>								    
												<td class="text-center">0</td>								    
												<td class="text-center">0</td>								    
										    </tr>										    
									    </c:if>
									    <c:if test="${empty item.divsnCnt}">
										    <tr class="sumTr">
										      	<td class="text-center">계</td>
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
										    </tr>										      	
									    </c:if>
									    <c:set var="itemCheck" value="${item.divsnCnt}"/>
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
        
               		<div style="margin-top: 30px" >
               			
                		<h4>기타내용</h4>
                		<div style="float:left">
                  		<textarea rows="5" cols="90" wrap="hard" id="etcText" name="etcText" ><c:out value="${etcText}" /></textarea>
                  		</div>
                  		<div style="float: right"><a href="#" onclick="fn_setEtcText(); return false;" style="    width:80px;
    background-color: #f8585b;
    border: none;
    color:#fff;
    padding: 12px 0;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 12px;
    margin: 3px;
    cursor: pointer;">저장</a></div>
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