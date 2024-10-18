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
<META HTTP-EQUIVE="CONTENT-TYPE" CONTENT="TEXT/HTML; CHARSET=KSC5601">
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
                    <td style="width:200px;" class="condition"><label class="laType02">구분</label></td>
                    <td style="width:400px;">
                    <c:if test='${searchCondition.dateType == "D"}'>일</c:if>
                    <c:if test='${searchCondition.dateType == "M"}'>월</c:if>
                    </td>
                    <td style="width:200px;" class="condition"><label class="laType02">날짜</label></td>
                    <td style="width:400px;" colspan="3">
                    <c:if test='${searchCondition.dateType == "D"}'>${searchCondition.searchBgnDe} ~ ${searchCondition.searchEndDe}</c:if>
                    <c:if test='${searchCondition.dateType == "M"}'>${searchCondition.searchBgnMt} ~ ${searchCondition.searchEndMt}</c:if>
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
					<colgroup>
						<col style="width:13%"/>
						<col style="width:15%"/>
						<col style="width:15%"/> 
						<col style="width:14%"/> 
					</colgroup>
					<thead> 
						<tr>
							<th>일자</th>
							<th>대여건수</th> 
							<th>이동거리(Km)</th> 
							<th>이용시간(분)</th>  
						</tr>
					</thead>
					<tbody>
						<c:forEach var="result" items="${dataList}" varStatus="status">
                            <tr>
                                <td style='mso-number-format:"\@";'>${result.getUseMember_date}</td>
                                <td style="text-align: right;"><fmt:formatNumber value="${result.getUseMember_1}" pattern="#,###" /></td>
                                <td style="text-align: right;"><fmt:formatNumber value="${result.getUseMember_2}" pattern="#,###" /></td>
                                <td style="text-align: right;"><fmt:formatNumber value="${result.getUseMember_3}" pattern="#,###" /></td>
                            </tr>
	                     </c:forEach>    
                         <c:if test="${fn:length(dataList) eq 0 }">
							<table class="tb_type01 nbt0">
								<tr>
									<td style="text-align:center">noData</td>
								</tr>
							</table>
						</c:if>
					</tbody>
				</table>
			</td>
    	</tr>
    </table>
    
</body>
</html>
