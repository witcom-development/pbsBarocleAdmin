<%@ page language="java" contentType="application/vnd.ms-excel;charset=euc-kr"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
    response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode("거치대점검관리리스트.xls", "UTF8"));
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
.tb_type01 td {text-align:left;padding:10px 2px;border:1px solid #e6e6e6}
.tb_type01 td.txRight {text-align:right;}
.tb_type01 td.txCenter {text-align:center;}
.tb_condition {width : 1200px}
.tb_condition td {text-align:center;padding:15px 0;border: 1px solid #e6e6e6;}
.tb_condition td.condition {width:150px;text-align:center;padding:15px 0;background:#FFFF99;}

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
                   <td style="width:200px;" class="condition" ><label class="laType02">발생일자</label></td>
                   <td style="width:400px;">${searchCondition.searchBgnDe} ~ ${searchCondition.searchEndDe}</td>
                   <td style="width:200px;" class="condition" ><label class="laType02">거치대 ID</label></td>
                   <td style="width:400px;">${searchCondition.rackId}</td>
               </tr>
               <tr>
                   <td style="width:200px;" class="condition" ><label class="laType02">아파트</label></td>
                   <td style="width:400px;">${searchCondition.stationGrpName}</td>
                   <td style="width:200px;" class="condition" ><label class="laType02">대여소명</label></td>
                   <td style="width:400px;">${searchCondition.stationName}</td>
               </tr>
                   <td style="width:200px;" class="condition" ><label class="laType02">조회 구분</label></td>
                   <td style="width:400px;" colspan="3">
                   <c:if test="${searchCondition.chkType eq 'S' }">현황</c:if>
                   <c:if test="${searchCondition.chkType eq 'H' }">이력</c:if>
                   </td>
               <tr>
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
                <th>대여소/센터</th>
                <th>거치대 번호</th>
                <th>거치대 ID</th>
                <th>고장사유</th>
                <th>신고자</th>
                <th>신고일시</th>
                <c:if test="${searchCondition.chkType eq 'H' }">
					<th>점검자</th>		
					<th>점검일시</th>
				</c:if>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="info" items="${CheckLockList}"  varStatus="loop">
            <tr>
                <td>${info.stationName }</td>
	            <td>${info.stationEquipOrder}</td>
	            <td>${info.rackId}</td>
				<td>${info.rackStatusName}</td>
				<td>${info.userId}</td>		
				<td>${info.regDttm}</td>
				<c:if test="${searchCondition.chkType eq 'H' }">
					<td>${info.modId}</td>		
					<td>${info.modDttm}</td>
				</c:if>
             </tr>
             </c:forEach>
             <c:if test="${fn:length(CheckBikeList) == 0}">
             <tr><td class="txCenter" colspan="6">no data</td></tr>
             </c:if>
        </tbody>
    </table>
</body>
</html>