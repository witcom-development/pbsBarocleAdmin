<%@ page language="java" contentType="application/vnd.ms-excel;charset=euc-kr"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
    response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode("정비직원실적조회.xls", "UTF8"));
    response.setHeader("Content-Description", "JSP Generated Data");
    
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko">
<head>
<title>SPB</title>
<meta content="text/html; charset=KSC5601" http-equiv="content-type" />

<link href="https://abc.bikeseoul.com/css/solbit200525.css" rel="stylesheet" type="text/css" />

<style type="text/css">

.tb-sb-1{width: 100%;}
.tb-sb-1 td {font-size:9px;}
.tb-sb-1 th {font-size:9px;}
.widscr span {font-size:9px;}

</style>

</head>
<body>
    <div class="shBox">
    	<table class="border">
    		<thead class="logo">
    			<tr><th colspan="17" class="text-center">정비원 실적 조회 결과</th></tr>
			</thead>
			<tr>
				<td class="text-center">기간</td>
				<td colspan="16">
					 ${searchCondition.searchBgnDe} ~ ${searchCondition.searchEndDe}
				</td>	
			</tr>
		</table>
	</div>
	<br/>
     <!--검색조건 E-->
		<div class="widscr mt5">
			<c:choose>
				<c:when test="${fn:length(wrkPerfList) ne 0 }">                       	
                   <table class="tb-sb-1">
						<thead>
						    <tr>
						      <td class="text-center" rowspan="2" style="width:8%;">센터</td>
						      <td class="text-center" rowspan="2" style="width:7%;">이름</td>
						      <td class="text-center" rowspan="2" style="width:5%;">&nbsp;구분&nbsp;</td>
						      <td class="text-center" colspan="12" style="width:67%;">정비내역</td>
							  <td class="text-center" colspan="2" style="width:13%;">완료대수</td>
						    </tr>
						    <tr>
						      <td class="text-center">단말기</td>
						      <td class="text-center">&nbsp;벨&nbsp;</td>
						      <td class="text-center">&nbsp;핸들&nbsp;</td>
						      <td class="text-center">브레<br/>이크</td>
						      <td class="text-center">변속기</td>
						      <td class="text-center">타이어<br/>튜브</td>
						      <td class="text-center">&nbsp;체인&nbsp;</td>
						      <td class="text-center">체인<br/>받이</td>
						      <td class="text-center">물받이</td>
						      <td class="text-center">스탠드</td>
						      <td class="text-center">&nbsp;기타&nbsp;</td>
						      <td class="text-center">&nbsp;계&nbsp;</td>
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
						      	<td class="text-center" rowspan="3">${item.repairCenterName }</td>
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
					<tfoot>    
					    <tr>
					      <td class="text-center" colspan="2">수리완료</td>
					      <td class="text-center" colspan="2">총계</td>
					      <td class="text-center" colspan="3">${searchCondition.repairTotCnt}</td>
					      <td class="text-center" colspan="2">단말기</td>
					      <td class="text-center" colspan="3">${searchCondition.repairTermCnt}</td>
					      <td class="text-center" colspan="2">자전거</td>
					      <td class="text-center" colspan="3">${searchCondition.repairBikeCnt}</td>
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
</body>
</html>