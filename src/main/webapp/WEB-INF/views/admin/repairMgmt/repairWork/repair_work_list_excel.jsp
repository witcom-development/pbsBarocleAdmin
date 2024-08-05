<%@ page language="java" contentType="application/vnd.ms-excel;charset=euc-kr"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
    response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode("정비직원근태정보.xls", "UTF8"));
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
.tb_type01 {width:100%;border:2px solid #212529;font-size:15px;table-layout:fixed}
.tb_type01 th {text-align:center;padding:15px 0;background:#b3c5ce;border-right:thin solid #212529; border-bottom:thin solid #212529;}
.tb_type01 td {text-align:left;padding:10px 2px;border:thin solid #212529; }
.tb_type01 td.txRight {text-align:right;}
.tb_type01 td.txCenter {text-align:center;}
.tb_condition {width:1200px;border: 2px solid #212529;}
.tb_condition th {text-align:center;padding:15px 0;background:#b3c5ce; border-bottom:thin solid #212529;}
.tb_condition td {text-align:center;padding:15px 0;border: thin solid #212529;}
.tb_condition td.condition {width:150px;text-align:center;padding:15px 0;background:#FFFF99;}
.tb_condition label {background:#b3c5ce;}

/*label*/
.laType02 {margin-right:5px;display:inline-block;font-size:11px;}


</style>
</head>
<body>
    <div class="shBox">
    	<table class="tb_condition">
    		<thead class="logo">
    			<tr><th colspan="5">정비원 근태 조회 결과</th></tr>
			</thead>
			<tr>
				<td>
					<label>기간</label>
				</td>
				<td>	
					<span>${searchCondition.searchBgnDe} ~ ${searchCondition.searchEndDe}</span>
				</td>
				<td>
					<label>사업소</label>
				</td>
				<td colspan="2">	
					<span>${searchCondition.searchCenter}</span>
				</td>	
			</tr>
			<tr>
				<td>
					<label>승인여부</label>
				</td>
				<td>	
					<span>
						<c:choose>
							<c:when test="${searchCondition.searchAprd eq 'Y'}">승인</c:when>
							<c:when test="${searchCondition.searchAprd eq 'N'}">미승인</c:when>
							<c:otherwise>
								전체
							</c:otherwise>
						</c:choose>
					</span>
				</td>	
				<td>
					<label>정비직원</label>
				</td>
				<td colspan="2">					
					<span>${searchCondition.searchAdmin}</span>
				</td>	
			</tr>
		</table>
	</div>
    <div style="width:1000px;text-align:right;margin:10px;">
          <label class="laType02"><b>총 ${paginationInfo.getTotalRecordCount() } 건</b></label>
    </div>
     <!--검색조건 E-->
		<div class="widscr mt5">
			<c:choose>
				<c:when test="${fn:length(workList) ne 0 }">
                      	<table class="tb_type01">
                      		<thead>
                      			<tr>
									<th>근무일</th>
	           						<th>근무시간</th>
	           						<th colspan="2">정비 외 시간</th>
	           						<th>근무자</th>
                      			</tr>
                      		</thead>
                      	<tbody id="tbodyTarget">
							<c:forEach items="${workList}" var="list" varStatus="vst">
							
							<fmt:parseDate value="${list.workDate}" var="workPlanDate" pattern="yyyy-MM-dd" />
				            <fmt:parseNumber value="${workPlanDate.time / (1000*60*60*24)}" integerOnly="true" var="workDate"></fmt:parseNumber>  
							
                       			<tr>
                       				<td class="text-center"><fmt:formatDate value="${workPlanDate}" pattern="MM-dd" /></td>
                        			<td class="text-center"><c:out value="${list.workTime}"></c:out></td>
                        			<c:if test="${list.dtlCd ne 'WRK_001'}">
                        				<td><c:out value="${list.dtlName}"></c:out></td>
                        			</c:if>
                        			<c:if test="${list.dtlCd eq 'WRK_001'}">
                        				<td><c:out value="${list.etc}"></c:out></td>
                        			</c:if>
                        			<c:if test="${list.dtlTime ne '0'}">
	                        			<td class="text-center"><c:out value="${list.dtlTime}"></c:out></td>
                        			</c:if>
                        			<c:if test="${list.dtlTime eq '0'}">
	                        			<td></td>
                        			</c:if>                        			
                        			<td class="text-center"><c:out value="${list.adminName}"></c:out></td>
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
</body>
</html>