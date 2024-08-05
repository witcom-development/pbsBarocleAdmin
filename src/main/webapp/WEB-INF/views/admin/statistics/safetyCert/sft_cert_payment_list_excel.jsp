<%@ page language="java" contentType="application/vnd.ms-excel;charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<% 
    response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode("인증제 합격자 세부 내역.xls", "UTF8"));
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
                    <td style="width:200px;" class="condition" ><label class="laType02">일</label></td>
                    <td style="width:400px;">
                    	${searchCondition.searchStartDate} ~ ${searchCondition.searchEndDate}
                    </td>
                    <td style="width:200px;" class="condition" ><label class="laType02">검색구분</label></td>
                    <td style="width:400px;">
                    <c:if test='${searchCondition.searchParameter != ""}'>
                    	${searchCondition.searchParameter}
                    </c:if>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
    <!--검색조건 E-->
    <div style="width:1200px;text-align:right;margin:10px;">
          <label class="laType02"><b>결제건수 : 총 ${paginationInfo.totalRecordCount } 건
								대상인원 : ${targetMemberNum } 명<br>
								할인누적요금: (합계) ${totalFee } 원</b></label>
    </div>
    <table class="tb_type01" style="width : 1200px;">
		<thead> 
			<tr>
				<th>아이디</th>
				<th>이용권종류</th>
				<th>결제금액</th>
				<th>할인금액</th>
				<th>결제일자</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="result" items="${dataList}" varStatus="status">
			<tr>
				<td>${result.mb_id}</td>
				<td>${result.cls_cd }</td>
				<td class="tc"><fmt:formatNumber pattern="#,###" value="${result.tot_amt }"></fmt:formatNumber></td>
				<td class="tc"><fmt:formatNumber pattern="#,###" value="${result.disAmt }"></fmt:formatNumber></td>
				<td class="tc">
					<fmt:parseDate var="dateString" value="${result.payment_dttm }" pattern="yyyy-MM-ddHH:mm:ss" />
					<fmt:formatDate value="${dateString}" pattern="yyyy-MM-dd HH:mm" />	
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</body>
</html>
