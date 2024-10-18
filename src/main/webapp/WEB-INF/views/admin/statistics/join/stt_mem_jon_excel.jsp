<%@ page language="java" contentType="application/vnd.ms-excel;charset=euc-kr"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
    response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode("회원가입통계.xls", "UTF8"));
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
                    <td style="width:200px;" class="condition" ><label class="laType02">기간</label></td>
                    <td style="width:400px;" colspan="6">${searchCondition.searchBgnDe} ~ ${searchCondition.searchEndDe}</td>
                    <td style="width:200px;" colspan="2" class="condition" ><label class="laType02">사용자구분</label></td>
                    <td style="width:400px;" colspan="6">
                    <c:if test='${searchCondition.userType == "USR_001"}'>내국인</c:if>
                   <%--  <c:if test='${searchCondition.userType == "USR_002"}'>외국인</c:if> --%>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
    <!--검색조건 E-->
    
						※ 전체 기간
						<table class="tb_type03 tb_right" style="width:100%">
							<thead> 
								<tr>
									<th>구분</th>
									<th>합계</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td style="text-align: center">합계</td>
									<td><fmt:formatNumber value="${memjoinList[0].totAgeTotal}" pattern="#,###" />     </td>
								</tr>
								
							</tbody>
						</table>
						</div>
						<br/>
						※ 선택 기간
						<table class="tb_type03 tb_right" style="width:100%">
							<thead> 
								<tr>
									<th>구분</th>
									<th>합계</th>
								</tr>
							</thead>
							<tbody>
								
								<tr>
									<td style="text-align: center">합계</td>
									<td><fmt:formatNumber value="${memjoinList[0].searchAgeTotal}" pattern="#,###" />     </td>
								</tr>
								
							</tbody>
						</table>
						</div>
</body>
</html>
