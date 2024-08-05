<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
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
					<tiles:insertAttribute name="left" />
				<!--left menu E-->
				<!--content S-->
				<div class="content">
					<div class="subject">
						<p class="pageTitle">회원가입현황</p>
						<span>통계 &gt; <em>회원가입현황</em></span>
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
						<div class="shBox">
							<form id="searchFrm">
								<fieldset>
									<legend>검색 옵션</legend>
									<div class="shBoxSection">
										<div class="section">
											<label for="searchBgnDe" class="laType02">기간</label>
											<span>
												<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" id="searchBgnDe" name="searchBgnDe" readonly/></span>
												<span class="dash">~</span>
												<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" id="searchEndDe" name="searchEndDe" readonly/></span>
											</span>
										</div>
										<div class="section pright">
											<label for="userType" class="laType02">사용자구분</label>
											<select class="select-category02" id="userType" name="userType">
												<option value="">선택</option>
												<option value="USR_001">내국인</option>
												<!-- <option value="USR_002">회원-외국인</option> -->
											</select>
											<button type="button" id="searchBtn" class="btn-srh03 btncase1"><img src="/images/searchIcon.gif" alt="검색" /></button>
										</div>
									</div>
								</fieldset>
							</form>
						</div>
						<!--검색조건 E-->
						<p class="tb_numlist"></p>
						<div class="widscr mt5">
						
						<p class="head2"><em>전체기간</em></p>
						<table class="tb_type03 tb_right" style="width:100%">
							<thead> 
								<tr>
									<th>구분</th>
									<th>~10대</th>
									<th>20대</th>
									<th>30대</th>
									<th>40대</th>
									<th>50대</th>
									<th>60대</th>
									<th>70대~</th>
									<th>연령정보<br/>없      음</th>
									<th>합계</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="tc">
									<c:choose>
										<c:when test="${memjoinList[0].userType eq ''}">남여정보<br/>없   음</c:when>
										<c:otherwise>${memjoinList[0].userType}</c:otherwise>
									</c:choose>
									</td>
									<td><fmt:formatNumber value="${memjoinList[0].totAge10}" pattern="#,###" />		</td>
									<td><fmt:formatNumber value="${memjoinList[0].totAge20}" pattern="#,###" />     </td>
									<td><fmt:formatNumber value="${memjoinList[0].totAge30}" pattern="#,###" />     </td>
									<td><fmt:formatNumber value="${memjoinList[0].totAge40}" pattern="#,###" />     </td>
									<td><fmt:formatNumber value="${memjoinList[0].totAge50}" pattern="#,###" />     </td>
									<td><fmt:formatNumber value="${memjoinList[0].totAge60}" pattern="#,###" />     </td>
									<td><fmt:formatNumber value="${memjoinList[0].totAge70}" pattern="#,###" />     </td>
									<td><fmt:formatNumber value="${memjoinList[0].totEtc}" pattern="#,###" />     </td>
									<td><fmt:formatNumber value="${memjoinList[0].totAge10+memjoinList[0].totAge20+memjoinList[0].totAge30+memjoinList[0].totAge40+memjoinList[0].totAge50+memjoinList[0].totAge60+memjoinList[0].totAge70+memjoinList[0].totEtc}" pattern="#,###" />     </td>
								</tr>
								<tr>
									<td class="tc">
									<c:choose>
										<c:when test="${memjoinList[1].userType eq ''}">남여정보<br/>없   음</c:when>
										<c:otherwise>${memjoinList[1].userType}</c:otherwise>
									</c:choose>
									</td> 
									<td><fmt:formatNumber value="${memjoinList[1].totAge10}" pattern="#,###" />		</td>
									<td><fmt:formatNumber value="${memjoinList[1].totAge20}" pattern="#,###" />     </td>
									<td><fmt:formatNumber value="${memjoinList[1].totAge30}" pattern="#,###" />     </td>
									<td><fmt:formatNumber value="${memjoinList[1].totAge40}" pattern="#,###" />     </td>
									<td><fmt:formatNumber value="${memjoinList[1].totAge50}" pattern="#,###" />     </td>
									<td><fmt:formatNumber value="${memjoinList[1].totAge60}" pattern="#,###" />     </td>
									<td><fmt:formatNumber value="${memjoinList[1].totAge70}" pattern="#,###" />     </td>
									<td><fmt:formatNumber value="${memjoinList[1].totEtc}" pattern="#,###" />     </td>
									<td><fmt:formatNumber value="${memjoinList[1].totAge10+memjoinList[1].totAge20+memjoinList[1].totAge30+memjoinList[1].totAge40+memjoinList[1].totAge50+memjoinList[1].totAge60+memjoinList[1].totAge70+memjoinList[1].totEtc}" pattern="#,###" />     </td>
								</tr>
								<tr>
									<td class="tc">
									<c:choose>
										<c:when test="${memjoinList[2].userType eq ''}">남여정보<br/>없   음</c:when>
										<c:otherwise>${memjoinList[2].userType}</c:otherwise>
									</c:choose>
									</td>
									<td><fmt:formatNumber value="${memjoinList[2].totAge10}" pattern="#,###" />		</td>
									<td><fmt:formatNumber value="${memjoinList[2].totAge20}" pattern="#,###" />     </td>
									<td><fmt:formatNumber value="${memjoinList[2].totAge30}" pattern="#,###" />     </td>
									<td><fmt:formatNumber value="${memjoinList[2].totAge40}" pattern="#,###" />     </td>
									<td><fmt:formatNumber value="${memjoinList[2].totAge50}" pattern="#,###" />     </td>
									<td><fmt:formatNumber value="${memjoinList[2].totAge60}" pattern="#,###" />     </td>
									<td><fmt:formatNumber value="${memjoinList[2].totAge70}" pattern="#,###" />     </td>
									<td><fmt:formatNumber value="${memjoinList[2].totEtc}" pattern="#,###" />     </td>
									<td><fmt:formatNumber value="${memjoinList[2].totAge10+memjoinList[2].totAge20+memjoinList[2].totAge30+memjoinList[2].totAge40+memjoinList[2].totAge50+memjoinList[2].totAge60+memjoinList[2].totAge70+memjoinList[2].totEtc}" pattern="#,###" />     </td>
								</tr>
								
								<tr>
									<td style="background:gray;color:white;text-align: center">합계</td>
									<td style="background:gray;color:white;"><fmt:formatNumber value="${memjoinList[0].totAge10+memjoinList[1].totAge10+memjoinList[2].totAge10}" pattern="#,###" />		</td>
									<td style="background:gray;color:white;"><fmt:formatNumber value="${memjoinList[0].totAge20+memjoinList[1].totAge20+memjoinList[2].totAge20}" pattern="#,###" />     </td>
									<td style="background:gray;color:white;"><fmt:formatNumber value="${memjoinList[0].totAge30+memjoinList[1].totAge30+memjoinList[2].totAge30}" pattern="#,###" />     </td>
									<td style="background:gray;color:white;"><fmt:formatNumber value="${memjoinList[0].totAge40+memjoinList[1].totAge40+memjoinList[2].totAge40}" pattern="#,###" />     </td>
									<td style="background:gray;color:white;"><fmt:formatNumber value="${memjoinList[0].totAge50+memjoinList[1].totAge50+memjoinList[2].totAge50}" pattern="#,###" />     </td>
									<td style="background:gray;color:white;"><fmt:formatNumber value="${memjoinList[0].totAge60+memjoinList[1].totAge60+memjoinList[2].totAge60}" pattern="#,###" />     </td>
									<td style="background:gray;color:white;"><fmt:formatNumber value="${memjoinList[0].totAge70+memjoinList[1].totAge70+memjoinList[2].totAge70}" pattern="#,###" />     </td>
									<td style="background:gray;color:white;"><fmt:formatNumber value="${memjoinList[0].totEtc+memjoinList[1].totEtc+memjoinList[2].totEtc}" pattern="#,###" />     </td>
									<td style="background:gray;color:white;"><fmt:formatNumber value="${memjoinList[0].totAge10+memjoinList[0].totAge20+memjoinList[0].totAge30+memjoinList[0].totAge40+memjoinList[0].totAge50+memjoinList[0].totAge60+memjoinList[0].totAge70+memjoinList[1].totAge10+memjoinList[1].totAge20+memjoinList[1].totAge30+memjoinList[1].totAge40+memjoinList[1].totAge50+memjoinList[1].totAge60+memjoinList[1].totAge70+memjoinList[2].totAge10+memjoinList[2].totAge20+memjoinList[2].totAge30+memjoinList[2].totAge40+memjoinList[2].totAge50+memjoinList[2].totAge60+memjoinList[2].totAge70+memjoinList[0].totEtc+memjoinList[1].totEtc+memjoinList[2].totEtc}" pattern="#,###" />     </td>
								</tr>
								
							</tbody>
						</table>
						</div>
						<p class="head2"><em>선택기간</em></p>
						<table class="tb_type03 tb_right" style="width:100%">
							<thead> 
								<tr>
									<th>구분</th>
									<th>~10대</th>
									<th>20대</th>
									<th>30대</th>
									<th>40대</th>
									<th>50대</th>
									<th>60대</th>
									<th>70대~</th>
									<th>연령정보<br/>없      음</th>
									<th>합계</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="tc">
									<c:choose>
										<c:when test="${memjoinList[0].userType eq ''}">남여정보<br/>없   음</c:when>
										<c:otherwise>${memjoinList[0].userType}</c:otherwise>
									</c:choose>
									</td>
									<td><fmt:formatNumber value="${memjoinList[0].searchAge10}" pattern="#,###" />		</td>
									<td><fmt:formatNumber value="${memjoinList[0].searchAge20}" pattern="#,###" />     </td>
									<td><fmt:formatNumber value="${memjoinList[0].searchAge30}" pattern="#,###" />     </td>
									<td><fmt:formatNumber value="${memjoinList[0].searchAge40}" pattern="#,###" />     </td>
									<td><fmt:formatNumber value="${memjoinList[0].searchAge50}" pattern="#,###" />     </td>
									<td><fmt:formatNumber value="${memjoinList[0].searchAge60}" pattern="#,###" />     </td>
									<td><fmt:formatNumber value="${memjoinList[0].searchAge70}" pattern="#,###" />     </td>
									<td><fmt:formatNumber value="${memjoinList[0].searchEtc}" pattern="#,###" />     </td>
									<td><fmt:formatNumber value="${memjoinList[0].searchAge10+memjoinList[0].searchAge20+memjoinList[0].searchAge30+memjoinList[0].searchAge40+memjoinList[0].searchAge50+memjoinList[0].searchAge60+memjoinList[0].searchAge70+memjoinList[0].totEtc}" pattern="#,###" />     </td>
								</tr>
								<tr>
									<td class="tc">
									<c:choose>
										<c:when test="${memjoinList[1].userType eq ''}">남여정보<br/>없   음</c:when>
										<c:otherwise>${memjoinList[1].userType}</c:otherwise>
									</c:choose>
									</td> 
									<td><fmt:formatNumber value="${memjoinList[1].searchAge10}" pattern="#,###" />		</td>
									<td><fmt:formatNumber value="${memjoinList[1].searchAge20}" pattern="#,###" />     </td>
									<td><fmt:formatNumber value="${memjoinList[1].searchAge30}" pattern="#,###" />     </td>
									<td><fmt:formatNumber value="${memjoinList[1].searchAge40}" pattern="#,###" />     </td>
									<td><fmt:formatNumber value="${memjoinList[1].searchAge50}" pattern="#,###" />     </td>
									<td><fmt:formatNumber value="${memjoinList[1].searchAge60}" pattern="#,###" />     </td>
									<td><fmt:formatNumber value="${memjoinList[1].searchAge70}" pattern="#,###" />     </td>
									<td><fmt:formatNumber value="${memjoinList[1].searchEtc}" pattern="#,###" />     </td>
									<td><fmt:formatNumber value="${memjoinList[1].searchAge10+memjoinList[1].searchAge20+memjoinList[1].searchAge30+memjoinList[1].searchAge40+memjoinList[1].searchAge50+memjoinList[1].searchAge60+memjoinList[1].searchAge70+memjoinList[1].totEtc}" pattern="#,###" />     </td>
								</tr>
								<tr>
									<td class="tc">
									<c:choose>
										<c:when test="${memjoinList[2].userType eq ''}">남여정보<br/>없   음</c:when>
										<c:otherwise>${memjoinList[2].userType}</c:otherwise>
									</c:choose>
									</td>
									<td><fmt:formatNumber value="${memjoinList[2].searchAge10}" pattern="#,###" />		</td>
									<td><fmt:formatNumber value="${memjoinList[2].searchAge20}" pattern="#,###" />     </td>
									<td><fmt:formatNumber value="${memjoinList[2].searchAge30}" pattern="#,###" />     </td>
									<td><fmt:formatNumber value="${memjoinList[2].searchAge40}" pattern="#,###" />     </td>
									<td><fmt:formatNumber value="${memjoinList[2].searchAge50}" pattern="#,###" />     </td>
									<td><fmt:formatNumber value="${memjoinList[2].searchAge60}" pattern="#,###" />     </td>
									<td><fmt:formatNumber value="${memjoinList[2].searchAge70}" pattern="#,###" />     </td>
									<td><fmt:formatNumber value="${memjoinList[2].searchEtc}" pattern="#,###" />     </td>
									<td><fmt:formatNumber value="${memjoinList[2].searchAge10+memjoinList[2].searchAge20+memjoinList[2].searchAge30+memjoinList[2].searchAge40+memjoinList[2].searchAge50+memjoinList[2].searchAge60+memjoinList[2].searchAge70+memjoinList[2].totEtc}" pattern="#,###" />     </td>
								</tr>
								
								<tr>
									<td style="background:gray;color:white;text-align: center">합계</td>
									<td style="background:gray;color:white;"><fmt:formatNumber value="${memjoinList[0].searchAge10+memjoinList[1].searchAge10+memjoinList[2].searchAge10}" pattern="#,###" />		</td>
									<td style="background:gray;color:white;"><fmt:formatNumber value="${memjoinList[0].searchAge20+memjoinList[1].searchAge20+memjoinList[2].searchAge20}" pattern="#,###" />     </td>
									<td style="background:gray;color:white;"><fmt:formatNumber value="${memjoinList[0].searchAge30+memjoinList[1].searchAge30+memjoinList[2].searchAge30}" pattern="#,###" />     </td>
									<td style="background:gray;color:white;"><fmt:formatNumber value="${memjoinList[0].searchAge40+memjoinList[1].searchAge40+memjoinList[2].searchAge40}" pattern="#,###" />     </td>
									<td style="background:gray;color:white;"><fmt:formatNumber value="${memjoinList[0].searchAge50+memjoinList[1].searchAge50+memjoinList[2].searchAge50}" pattern="#,###" />     </td>
									<td style="background:gray;color:white;"><fmt:formatNumber value="${memjoinList[0].searchAge60+memjoinList[1].searchAge60+memjoinList[2].searchAge60}" pattern="#,###" />     </td>
									<td style="background:gray;color:white;"><fmt:formatNumber value="${memjoinList[0].searchAge70+memjoinList[1].searchAge70+memjoinList[2].searchAge70}" pattern="#,###" />     </td>
									<td style="background:gray;color:white;"><fmt:formatNumber value="${memjoinList[0].searchEtc+memjoinList[1].searchEtc+memjoinList[2].searchEtc}" pattern="#,###" />     </td>
									<td style="background:gray;color:white;"><fmt:formatNumber value="${memjoinList[0].searchAge10+memjoinList[0].searchAge20+memjoinList[0].searchAge30+memjoinList[0].searchAge40+memjoinList[0].searchAge50+memjoinList[0].searchAge60+memjoinList[0].searchAge70+memjoinList[1].searchAge10+memjoinList[1].searchAge20+memjoinList[1].searchAge30+memjoinList[1].searchAge40+memjoinList[1].searchAge50+memjoinList[1].searchAge60+memjoinList[1].searchAge70+memjoinList[2].searchAge10+memjoinList[2].searchAge20+memjoinList[2].searchAge30+memjoinList[2].searchAge40+memjoinList[2].searchAge50+memjoinList[2].searchAge60+memjoinList[2].searchAge70+memjoinList[0].searchEtc+memjoinList[1].searchEtc+memjoinList[2].searchEtc}" pattern="#,###" />     </td>
								</tr>
								
							</tbody>
						</table>
						</div>
					<%-- 	
						<p class="head2"><em>새싹 오픈 현황</em></p>
						<div class="widscr mt5">
						<table class="tb_type01" style="min-width:700px">
							<colgroup>
								<col style="width:12%"/>
								<col style="width:12%"/>
								<col style="width:12%"/> 
								<col style="width:12%"/> 
								<col style="width:12%"/> 
							</colgroup>
							<thead> 
								<tr>
									<th rowspan="2" style="vertical-align: middle;">일자</th>
									<th colspan="3">회원가입</th>
									<th rowspan="2" style="vertical-align: middle;">대여</th> 
								</tr>
								<tr>
									<th>13세</th>
									<th>14세</th>
									<th>15세</th>
								</tr>
							</thead>
							<tbody>
							<c:set var="sum13" value="0"></c:set>
							<c:set var="sum14" value="0"></c:set>
							<c:set var="sum15" value="0"></c:set>
							<c:set var="cntSum" value="0"></c:set>
							<c:forEach var="result" items="${miniBikeList}" varStatus="status">

								<c:set var="sum13" value="${result.totAge30+sum13}"></c:set>
								<c:set var="sum14" value="${result.totAge40+sum14}"></c:set>
								<c:set var="sum15" value="${result.totAge50+sum15}"></c:set>
								<c:set var="cntSum" value="${result.totAgeTotal+cntSum}"></c:set>
							
                                <tr>
                                    <td align="center">${result.userType}</td>
                                    <td align="right"><fmt:formatNumber value="${result.totAge30}" pattern="#,###"/></td>
                                    <td align="right"><fmt:formatNumber value="${result.totAge40}" pattern="#,###"/></td>
                                    <td align="right"><fmt:formatNumber value="${result.totAge50}" pattern="#,###"/></td>
                                    <td align="right"><fmt:formatNumber value="${result.totAgeTotal}" pattern="#,###"/></td>
                                </tr>
                                
                            	<c:if test="${status.last }">
                            	
                            		<tr>
	                                    <td align="center">누적</td>
	                                    <td align="right"><fmt:formatNumber value="${sum13}" pattern="#,###"/></td>
	                                    <td align="right"><fmt:formatNumber value="${sum14}" pattern="#,###"/></td>
	                                    <td align="right"><fmt:formatNumber value="${sum15}" pattern="#,###"/></td>
	                                    <td align="right"><fmt:formatNumber value="${cntSum}" pattern="#,###"/></td>
                                	</tr>
                                	
                            	</c:if>
                            	    
                            </c:forEach>
                                
                            <c:if test="${fn:length(miniBikeList) eq 0 }">
								<table class="tb_type01 nbt0">
									<tr><td style="text-align:center"><spring:message code="search.nodata.msg" /></tr>
								</table>
							</c:if>							
							</tbody>
						</table> --%>
						</div>						
						
						<div class="btnArea">
							<span class="right"><button type="button" id="excelBtn" class="btnType01">엑셀다운로드</button></span>
						</div>
						
					</div>
				</div>
				<!--content E-->
			</div> 
		</div>
		<!--footer S-->
			<tiles:insertAttribute name="footer" />
		<!--footer E-->
	</div>
	
	<script type="text/javascript" src="/js/common_barocle.js"></script>
    <script type="text/javascript">
   	$(function() {
		$('[name="searchBgnDe"]').val('${searchCondition.searchBgnDe}');
		$('[name="searchEndDe"]').val('${searchCondition.searchEndDe}');
		$('[name="userType"]').val('${searchCondition.userType}');
		
		$("#searchBtn").on("click", function(){
			$("#searchFrm").attr({method : 'post', action : '/join/joinStatistics.do'}).submit();
		});
		$("#excelBtn").on("click", function(){
			$("#searchFrm").attr({method : 'post', action : '/join/joinStatisticsExcel.do'}).submit();
		});
   	});
    </script>
</body>
</html>