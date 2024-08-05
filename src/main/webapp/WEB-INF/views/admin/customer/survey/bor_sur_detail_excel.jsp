<%@ page language="java" contentType="application/vnd.ms-excel;charset=euc-kr"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
    response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode("모바일설문결과.xls", "UTF8"));
    response.setHeader("Content-Description", "JSP Generated Data");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko">
<head>
<style>
.tb_type01 th {text-align:center;padding:5% 0;}
.tb_type01 td {text-align:center;padding:5% 0}
.tb_type01 {width:100%;border:1px solid #e6e6e6;font-size:15px;table-layout:fixed}
.tb_type01 th {text-align:center;padding:15px 0;background:#eff5f8;border-top:2px solid #5e5e5e;border-right:1px solid #e6e6e6}
.tb_type01 td {text-align:center;padding:10px 2px;border:1px solid #e6e6e6}
.tb_type01 td.title {text-align:left;}
.tb_type01 td.txRight {text-align:right;}
.tb_type01 td.txLeft {text-align:left;}
.tb_condition {width : 1200px}
.tb_condition td {text-align:center;padding:15px 0;border: 1px solid #e6e6e6;}
.tb_condition td.condition {width:150px;text-align:center;padding:15px 0;background:#FFFF99;}
/*label*/
.laType02 {margin-right:5px;display:inline-block;font-size:11px;}
.mhid {display:none !important}
</style>
</head>
<body>
    <div style="height:200px; width:1200px;text-align:center; margin-top:10px;"></div>
    <div style="margin-top:10px;">
        <table class="tb_condition">
           <tbody>
               <tr>
                   <td style="width:200px;" class="condition" ><label class="laType02">설문일</label></td>
                   <td colspan="6" style="width:400px;"><fmt:formatDate value="${surveyView.qustnrStrDttm}" pattern="yyyy-MM-dd" var="qustnrStrDttm"/>${qustnrStrDttm} ~ <fmt:formatDate value="${surveyView.qustnrEndDttm}" pattern="yyyy-MM-dd" var="qustnrEndDttm"/>${qustnrEndDttm}</td>
               </tr>
               <tr>
                   <td style="width:200px;" class="condition" ><label class="laType02">제목</label></td>
                   <td colspan="6" style="width:400px;">${surveyView.qustnrTitle}</td>
               </tr>
           </tbody>
        </table>
    </div>
    <c:forEach var="surveyResultQustList" items="${surveyResultListExcel}"  varStatus="loop" begin="0" end="0">
	    <div style="width:1200px;text-align:right;margin:10px;">
	          <label class="laType02"><b>총 ${surveyResultQustList.sumTotRespondUnrespond }명(응답자 ${surveyResultQustList.sumQuantity } 명 / 미참가자 ${surveyResultQustList.sumUnrespond } 명 )</b></label>
	    </div>
    </c:forEach>
     <!--검색조건 E-->
    <table class="tb_type01" style="width : 1200px;">
        <thead>
            <tr>
                <th>응답ID</th>
                <th>기타의견</th>
                <th>성별</th>
                <th>연령</th>
                <th>지역</th>
                <th>질문번호</th>
                <th>질문내용</th>
                <th>답변번호</th>
                <th>답변내용</th>
<!--                 <th>카운트</th> -->
<!--                 <th>선택수</th> -->
<!--                 <th>전체 응답의 선택 비율<br /> -->
<!--                 	(선택수 / 총 응답자)</th> -->
            </tr>
        </thead>
        <tbody>
             <c:forEach var="surveyResultQustList" items="${surveyResultListExcel}" varStatus="loop">
             <tr>
                 <td>${surveyResultQustList.qustnrRespondId}</td>
                 <td>${surveyResultQustList.etcYn}</td>
                 <td>${surveyResultQustList.sexCd}</td>
                 <td>${surveyResultQustList.years}</td>
                 <td>${surveyResultQustList.mbAddr1}</td>
                 <td>${surveyResultQustList.qestnOrd}</td>
                 <td>${surveyResultQustList.qestnContent}</td>
                 <c:choose>
                 	<c:when test="${surveyResultQustList.etcYn eq '기타의견'}"><td colspan="1">Q.${surveyResultQustList.qestnOrd}-etc</td></c:when>
                 	<c:otherwise><td>${surveyResultQustList.itemOrd}</td></c:otherwise>
                 </c:choose>
                 <td>${surveyResultQustList.itemContent}</td>
<%--                  <td>${surveyResultQustList.counta}</td> --%>
<%--                  <td>${surveyResultQustList.qustnrItemIDCount}</td> --%>
<%--                  <td>${surveyResultQustList.percentQuantity}</td> --%>
             </tr>
             </c:forEach>
             <c:if test="${fn:length(surveyResultListExcel) == 0 }">
             <tr><td colspan="10">no data</td></tr>    
             </c:if>
        </tbody>
    </table>   
</body>
</html>