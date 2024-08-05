<%@ page language="java" contentType="application/vnd.ms-excel;charset=euc-kr"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
    response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode("회원가입통계.xls", "UTF8"));
    response.setHeader("Content-Description", "JSP Generated Data");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko">
<head>
<title>SPB</title>
<meta content="text/html; charset=KSC5601" http-equiv="content-type" />
<style>
.tb_type01 th {text-align:center;padding:5% 0;}
.tb_type01 td {text-align:center;padding:5% 0}
.tb_type01 {width:100%;border:1px solid #e6e6e6;font-size:15px;table-layout:fixed}
.tb_type01 th {text-align:center;padding:15px 0;background:#eff5f8;border-top:2px solid #5e5e5e;border-right:1px solid #e6e6e6}
.tb_type01 td {text-align:center;padding:10px 2px;border:1px solid #e6e6e6}
.tb_type01 td.title {text-align:left;}
.tb_type01 td.condition {text-align:center;padding:15px 0;background:#FFFF33;}
.tb_type01 td.txRight {text-align:right;}
.tb_type01 td.txLeft {text-align:left;}
.tb_condition {width : 1200px}
.tb_condition td {text-align:center;padding:15px 0;border: 1px solid #e6e6e6;}
.tb_condition td.condition {text-align:center;padding:15px 0;background:#eff5f8;}
/*label*/
.laType02 {margin-right:5px;display:inline-block;font-size:11px;}
</style>
</head>
<body>
 
   <div style="height:200px; width:1200px;text-align:center; margin-top:10px;">
    </div>
    <div>
        <table class="tb_condition">
            <tbody>
                <tr>
                    <td style="width:200px;" class="condition" ><label class="laType02">기간</label></td>
                    <td style="width:400px;" colspan="6">${searchCondition.searchBgnDe} ~ ${searchCondition.searchEndDe}</td>
                    <td style="width:200px;" colspan="2" class="condition" ><label class="laType02">사용자구분</label></td>
                    <td style="width:400px;" colspan="6">
                    <c:if test='${searchCondition.userType == "USR_001"}'>내국인</c:if>
                   <%--  <c:if test='${searchCondition.userType == "USR_002"}'>외국인</c:if> --%>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
    <!--검색조건 E-->
    
						※ 전체 기간
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
						<br/>
						※ 선택 기간
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
	<c:choose>
		<c:when test="${fn:length(miniBikeList) ne 0 }">

						 <table class="tb_type01" style="width : 1200px;">
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
                                
							</tbody>
						</table>
			
        </c:when>	
        <c:otherwise>
			<table class="tb_type01">
				<tr><td style="text-align:center"><spring:message code="search.nodata.msg" /></td></tr>
			</table>
		</c:otherwise>
	</c:choose>
	</div>				
	 --%>
</body>
</html>
