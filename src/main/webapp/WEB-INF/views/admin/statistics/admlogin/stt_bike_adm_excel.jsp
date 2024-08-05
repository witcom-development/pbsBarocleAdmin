<%@ page language="java" contentType="application/vnd.ms-excel;charset=euc-kr"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
    response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode("운영자접속현황.xls", "UTF8"));
    response.setHeader("Content-Description", "JSP Generated Data");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko">
<head>
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
                    <td style="width:200px;" class="condition" ><label class="laType02">관리구분</label></td>
                    <td style="width:400px;">
                    <c:if test='${searchCondition.adminType == ""}'>전체</c:if>
                    <c:if test='${searchCondition.adminType == "ADM_001"}'>운영 관리자</c:if>
                    <c:if test='${searchCondition.adminType == "ADM_002"}'>유인대여소 관리자</c:if>
                    <c:if test='${searchCondition.adminType == "ADM_003"}'>센터 관리자</c:if>
                    <c:if test='${searchCondition.adminType == "ADM_004"}'>유지보수 관리자</c:if>
                    <c:if test='${searchCondition.adminType == "ADM_005"}'>재배치 관리자</c:if>
                    </td>
                    <td style="width:200px;" class="condition" ><label class="laType02">기간</label></td>
                    <td style="width:400px;">${searchCondition.searchBgnDe} ~ ${searchCondition.searchEndDe}</td>
                </tr>
                <tr>
                    <td style="width:200px;" class="condition" ><label class="laType02">이름</label></td>
                    <td style="width:400px;">${searchCondition.searchName}</td>
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
				<th>그룹명</th>
				<th>이름명</th>
				<th>ID</th>
				<th>로그인 일시</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="result" items="${dataList}" varStatus="status">
	        <tr>
	            <td>${result.adminGrpName}</td>
	            <td>${result.adminName}</td>
	            <td>${result.adminId}</td>
	            <td>${result.loginDttm }</td>
	        </tr>
	    </c:forEach>    
	    <c:if test="${fn:length(dataList) eq 0 }">
			<table class="tb_type01 nbt0">
				<tr><td style="text-align:center"><spring:message code="search.nodata.msg" /></td></tr>
			</table>
		</c:if>
		</tbody>
	</table>
</body>
</html>
