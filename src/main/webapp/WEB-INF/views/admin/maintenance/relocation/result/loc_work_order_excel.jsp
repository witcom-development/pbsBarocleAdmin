<%@ page language="java" contentType="application/vnd.ms-excel;charset=euc-kr"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
    response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode("재배치내역상세.xls", "UTF8"));
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
                    <td style="width:200px;" class="condition" ><label class="laType02">일자</label></td>
                    <td style="width:400px;">${searchCondition.searchBgnDe } ~ ${searchCondition.searchEndDe }</td>
                    <td style="width:200px;" class="condition" ><label class="laType02">대여소 번호</label></td>
                    <td style="width:400px;"><c:if test="${searchCondition.stationId != null }">${searchCondition.stationId}</c:if>
                </tr> 
            </tbody>
        </table>
    </div>
    
    <div style="width:1200px;text-align:right;margin:10px;">
          <label class="laType02"><b>총 ${paginationInfo.getTotalRecordCount() } 건</b></label>
    </div>
    <!--검색조건 E-->
    <table class="tb_type01" style="width : 1200px;">
	           
	            <colgroup>
						<col style="width:20%"/>
						<col style="width:15%"/>
						<col style="width:25%"/>
						<col style="width:25%"/>
						<col style="width:10%"/>
						<col style="width:10%"/>
						<col style="width:10%"/>
					</colgroup>
					<thead>
						<tr>
							<th>센터</th>
							<th>팀</th>
							<th>대여소</th>
							<th>일자</th>
							<th>시간</th>
							<th>거치된건수</th>
							<th>재배치수량</th>
							<th>상세내용 </th> 
						</tr>
					</thead>
					<tbody>
						<c:forEach var="result" items="${RelocationStateDetail}" varStatus="status">
	                             <tr>
	                                 <td class="tc">${result.stationGrp}</td>
	                                 <td>${result.returnableCnt}</td>
	                                 <td>${result.fromStationName}</td>
	                                 <td class="tc">${result.relocateStrDttm}</td>
	                                 <td class="tc">${result.relocateEndDttm}</td>
	                                 <td class="tc">${result.rockCnt}</td>
	                                 <td class="tc">${result.relocateCnt}</td>
	                                 <td class="tc">${result.moveCnt1}</td>
	                             </tr>
	                         </c:forEach>    
					<c:if test="${fn:length(RelocationStateDetail) eq 0 }">
						<table class="tb_type01 nbt0">
							<tr><td style="text-align:center"><spring:message code="search.nodata.msg" /></td></tr>
						</table>
					</c:if>
        </tbody>
    </table>
</body>
</html>
