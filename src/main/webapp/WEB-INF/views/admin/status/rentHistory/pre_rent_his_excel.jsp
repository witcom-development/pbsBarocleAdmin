<%@ page language="java" contentType="application/vnd.ms-excel;charset=euc-kr"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
    response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode("대여이력.xls", "UTF8"));
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
                   <td style="width:200px;" class="condition" ><label class="laType02">대여일</label></td>
                   <td style="width:400px;">${searchCondition.searchStartDate} ~ ${searchCondition.searchEndDate}</td>
                   <td style="width:200px;" class="condition" ><label class="laType02">회원</label></td>
                   <td style="width:400px;">${searchCondition.searchWord}</td>
               </tr>
               <tr>
                   <td style="width:200px;" class="condition" ><label class="laType02">반납 아파트</label></td>
                   <td style="width:400px;">${searchCondition.returnStationGrpName}</td>
                   <td style="width:200px;" class="condition" ><label class="laType02">반납대여소명</label></td>
                   <td style="width:400px;">${searchCondition.returnStationName}</td>
               </tr>
           </tbody>
        </table>
    </div>
    <div style="width:1200px;text-align:right;margin:10px;">
          <label class="laType02"><b>총 ${paginationInfo.getTotalRecordCount() } 건</b></label>
    </div>
     <!--검색조건 E-->
    <table class="tb_type01" style="width : 1200px;">
        <thead>
            <tr>
                <th>대여구분</th>
                <th>대여일시</th>
                <th>대여대여소</th>
                <th>대여거치대</th>
                <th>반납일시</th>
                <th>반납대여소</th>
                <th>반납거치대</th>
                <th>자전거번호</th>
                <th>회원</th>
                <th>회원구분</th>
                <th>이용시간(분)</th>
            </tr>
        </thead>
        <tbody>
             <c:forEach var="rent" items="${rentList}" varStatus="loop">
             <tr>
                 <td>${rent.rentClsCdName}</td>
                 <td>${rent.rentDttm}</td>
                 <td>${rent.rentStationName}</td>
                 <td>${rent.rentRackId}</td>
                 <td>${rent.returnDttm}</td>
                 <td>${rent.returnStationName}</td>
                 <td>${rent.returnRackId}</td>
                 <td>${rent.rentBikeNo}</td>
                 <td>${rent.mbId}</td>
                 <td>${rent.usrClsCdName}</td>
                 <td>${rent.useMi}</td>
             </tr>
             </c:forEach>
             <c:if test="${fn:length(rentList) == 0 }">
             <tr><td colspan="10">no data</td></tr>    
             </c:if>
        </tbody>
    </table>   
</body>
</html>