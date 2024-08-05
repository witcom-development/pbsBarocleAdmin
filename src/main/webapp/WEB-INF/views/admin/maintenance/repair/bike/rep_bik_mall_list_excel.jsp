<%@ page language="java" contentType="application/vnd.ms-excel;charset=euc-kr"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
    response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode("바로클포 수리리스트.xls", "UTF8"));
    response.setHeader("Content-Description", "JSP Generated Data");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko">
<head>
<title></title>
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
                    <td style="width:200px;" class="condition" ><label class="laType02">수리 일자</label></td>
                    <td style="width:400px;">${searchCondition.searchBgnDe} ~ ${searchCondition.searchEndDe}</td>
                    <td style="width:200px;" class="condition" ><label class="laType02">구분</label></td>
	                <td style="width:400px;">${searchCondition.division == 'adminId' ? '유지보수자명' : '자전거번호'}</td>
	                <td style="width:400px;">${searchCondition.divisionValue}</td>
                </tr>
                <tr>
                    <td style="width:200px;" class="condition" ><label class="laType02">상태</label></td>
                    <td style="width:400px;" colspan="4">
                    	<c:if test="${searchCondition.repairCmptYn eq 'Y' }">수리완료</c:if>
                    	<c:if test="${searchCondition.repairCmptYn eq 'N' }">수리중</c:if>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
    <div style="width:1200px;text-align:right;margin:10px;">
          <label class="laType02"><b>총 ${paginationInfo.getTotalRecordCount() } 건</b></label>
    </div>
    <!--검색조건 E-->
<%--     <table class="tb_type01" style="width : 1200px;">
        <thead>
            <tr>
                <th>자전거 번호</th>
				<th>유지보수자명</th>
				<th>상태</th>
				<th>수리일자</th>
				<th>완료일자</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="result" items="${RepairBikeList}" varStatus="loop">
                <tr>
                    <td>${result.bikeNo}</td>
                    <td>${result.bikeId}</td>
                    <td>${result.adminId}</td>
                    <td>${result.repairCmptYn == 'Y' ? '수리완료' : '수리중'}</td>
                    <td>${result.repDttm }</td>
                    <td>${result.cmptDttm }</td>
                </tr>
            </c:forEach>
            <c:if test="${fn:length(RepairBikeList) == 0 }">
                <tr><td colspan="5">no data</td></tr>
            </c:if>
        </tbody>
    </table> --%>
    
		<table class="tb_type01">
			<colgroup>
				<col style="width:11%"/>
				<col style="width:8%"/>
				<col style="width:8%"/>
				<col style="width:32%"/>
				<col style="width:20%"/>
				<col style="width:20%"/>
				<col style="width:20%"/>
				<col style="width:5%"/>	<!-- 완료 -->
			</colgroup>
			<thead>
				<tr>
					<th>자전거</th>
					<th>담당자</th>
					<th>상태</th>
					<th>센터</th>
					<th>등록일자</th>
					<th>완료일자</th>
					<th>정비구분</th>
					<th>비용</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="result" items="${RepairBikeList}" varStatus="status">
                           		<tr>
                                 <td style="text-align:center"><a href="#">${result.bikeNo}</a></td>
                                 <td style="text-align:center">${result.adminId}</td>
                                 <td style="text-align:center">${result.repairCmptYn == 'Y' ? '수리완료' : '수리중'}</td>
                                 <td>${result.centerName}</td>
                                 <td>${result.repDttm }</td>
                                 <td>${result.cmptDttm }</td>
                                 <td>${result.bikeStatusComCd}</td>
                                 <td>${result.bikeStatusName}</td>
                             </tr>
                         </c:forEach>    
                        	<c:if test="${fn:length(RepairBikeList) eq 0 }">
					<table class="tb_type01 nbt0">
						<tr><td style="text-align:center"><spring:message code="search.nodata.msg" /></td></tr>
					</table>
				</c:if>
			</tbody>
		</table>    
    
</body>
</html>