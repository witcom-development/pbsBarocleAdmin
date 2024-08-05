<%@ page language="java" contentType="application/vnd.ms-excel;charset=euc-kr"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
    response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode("이용자별이용통계.xls", "UTF8"));
    response.setHeader("Content-Description", "JSP Generated Data");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko">
<head>
<meta content="text/html; charset=KSC5601" http-equiv="content-type" />
<title></title>
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
                    <td style="width:200px;" class="condition" colspan="2"><label class="laType02">구분</label></td>
                    <td style="width:400px;" colspan="3">
                    <c:if test='${searchCondition.dateType == "D"}'>일</c:if>
                    <c:if test='${searchCondition.dateType == "M"}'>월</c:if>
                    </td>
                    <td style="width:200px;" class="condition" colspan="2"><label class="laType02">일/월</label></td>
                    <td style="width:400px;" colspan="3">
                    <c:if test='${searchCondition.dateType == "D"}'>${searchCondition.searchBgnDe} ~ ${searchCondition.searchEndDe}</c:if>
                    <c:if test='${searchCondition.dateType == "M"}'>${searchCondition.searchBgnMt} ~ ${searchCondition.searchEndMt}</c:if>
                    </td>
                </tr>
                <tr>
                    <td style="width:200px;" class="condition" colspan="2"><label class="laType02">대여횟수</label></td>
                    <td style="width:400px;" colspan="3">
                    <c:if test='${searchCondition.sortType == "A"}'>오름차순</c:if>
                    <c:if test='${searchCondition.sortType == "D"}'>내림차순</c:if>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
    <!--검색조건 E-->
    
    <table>
    	<tr></tr>
    	<tr>
    		<td>
    			<div style="width:1200px;text-align:left;margin:10px;">
			    	<label class="laType02"><b>총 합계</b></label>
			    </div>
    			<table class="tb_type01" style="width : 1200px;">
					<tr>
						<th rowspan="2">대여<p>구분</p></th>
						<th>정기</th>
						<th>일일<br />(회원)</th>
						<th>일일<br />(비회원)</th>
						<th>단체</th>
					</tr>
					<tr>
						<td>${rentTypeDataList[0].useCntSum}</td>
						<td>${rentTypeDataList[1].useCntSum}</td>
						<td>${rentTypeDataList[2].useCntSum}</td>
						<td>${rentTypeDataList[3].useCntSum}</td>
					</tr>
				</table>
			</td>
    		<td>
    			<div style="width:1200px;text-align:left;margin:10px;">
			    	<label class="laType02"><b>일/월 평균</b></label>
			    </div>
			    <table class="tb_type01" style="width : 1200px;">
			    	<tr>
						<th rowspan="2">대여<p>구분</p></th>
						<th>정기</th>
						<th>일일<br />(회원)</th>
						<th>일일<br />(비회원)</th>
						<th>단체</th>
					</tr>
					<tr>
						<td><fmt:formatNumber value="${rentTypeDataList[0].useCntAvg}" pattern="0.00"></fmt:formatNumber></td>
						<td><fmt:formatNumber value="${rentTypeDataList[1].useCntAvg}" pattern="0.00"></fmt:formatNumber></td>
						<td><fmt:formatNumber value="${rentTypeDataList[2].useCntAvg}" pattern="0.00"></fmt:formatNumber></td>
						<td><fmt:formatNumber value="${rentTypeDataList[3].useCntAvg}" pattern="0.00"></fmt:formatNumber></td>
					</tr>
			    </table>
    		</td>
    	</tr>
    	<tr></tr>
    	<tr>
    		<td>
    			<table class="tb_type01" style="width : 1200px;">
					<tr>
						<th rowspan="2">이용<p>합계</p></th>
<!-- 						<th colspan="2">성별</th> -->
						<th>이용건수</th>
						<th>이동거리<br />(Km)</th>
						<th>이용시간<br />(분)</th>
					</tr>
					<%-- <tr>
						<td class="tc" colspan="2">${genderDataList[1].mLangComCd}</td>
						<td>${genderDataList[1].useCntSum}</td>
						<td><fmt:formatNumber value="${genderDataList[1].moveDistSum/1000}" pattern="0.00"></fmt:formatNumber></td>
						<td>${genderDataList[1].useMinuteSum}</td>
					</tr> --%>
					<tr>
<%-- 						<td class="tc" colspan="2">${genderDataList[0].mLangComCd}</td> --%>
						<td>${genderDataList[0].useCntSum}</td>
						<td><fmt:formatNumber value="${genderDataList[0].moveDistSum/1000}" pattern="0.00"></fmt:formatNumber></td>
						<td>${genderDataList[0].useMinuteSum}</td>
					</tr>
				</table>
    		</td>
    		<td>
    			<table class="tb_type01" style="width : 1200px;">
			    	<tr>
			    		<th rowspan="2">이용<p>합계</p></th>
<!-- 						<th>성별</th> -->
						<th>이용건수</th>
						<th>이동거리<br />(Km)</th>
						<th>이용시간<br />(분)</th>
					</tr>
					<%-- <tr>
						<td class="tc">${genderDataList[1].mLangComCd}</td>
						<td><fmt:formatNumber value="${genderDataList[1].useCntAvg}" pattern="0.00"></fmt:formatNumber></td>
						<td><fmt:formatNumber value="${genderDataList[1].moveDistAvg/1000}" pattern="0.00"></fmt:formatNumber></td>
						<td><fmt:formatNumber value="${genderDataList[1].useMinuteAvg}" pattern="0.00"></fmt:formatNumber></td>
					</tr> --%>
					<tr>
<%-- 						<td class="tc">${genderDataList[0].mLangComCd}</td> --%>
						<td><fmt:formatNumber value="${genderDataList[0].useCntAvg}" pattern="0.00"></fmt:formatNumber></td>
						<td><fmt:formatNumber value="${genderDataList[0].moveDistAvg/1000}" pattern="0.00"></fmt:formatNumber></td>
						<td><fmt:formatNumber value="${genderDataList[0].useMinuteAvg}" pattern="0.00"></fmt:formatNumber></td>
					</tr>
				</table>
    		</td>
    	</tr>
    	<tr></tr>
    </table>
    
	<div style="width:600px;text-align:left;margin:10px;">
    	<label class="laType02"><b>이용회원 현황</b></label>
    	<div style="width:600px;text-align:right;margin:10px;">
    		<label class="laType02"><b>총 ${ paginationInfo.getTotalRecordCount()} 건</b></label>
   		</div>
    </div>
    
    <table class="tb_type01" style="width : 1200px;">
    	<thead> 
			<tr>
				<th colspan="2">대여 아파트</th>
				<th>사용자구분</th>
				<th>ID</th>
				<th colspan="2">성별</th>
				<th colspan="3">휴대폰번호</th>
				<th>대여횟수</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="result" items="${dataList}" varStatus="status">
            <tr>
                <td colspan="2">${result.paymentType}</td>
                <td>
		            <c:if test='${result.userType == "USR_001"}'>내국인</c:if>
		            <%-- <c:if test='${result.userType == "USR_002"}'>회원-외국인</c:if> --%>
		            <%-- <c:if test='${result.userType == "USR_003"}'>비회원</c:if> --%>
	            </td>
                <td>${result.userId}</td>
                <c:choose>
                	<c:when test="${result.userGender == 'M'}"><td colspan="2">남</td></c:when>
                	<c:when test="${result.userGender == 'F'}"><td colspan="2">여</td></c:when>
                	<c:otherwise><td colspan="2">-</td></c:otherwise>
                </c:choose>
<%--                 <td colspan="2">${result.userGender == 'M' ? '남' : '여'}</td> --%>
                <td colspan="3">${result.userMob}</td>
                <td>${result.rentCnt }</td>
            </tr>
        </c:forEach>    
		</tbody>
	</table>
</body>
</html>
