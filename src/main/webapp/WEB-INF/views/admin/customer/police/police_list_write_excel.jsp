<%@ page language="java" contentType="application/vnd.ms-excel;charset=euc-kr"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
    response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode("수사 협조 리스트.xls", "UTF8"));
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

<c:choose>
    <c:when test="${fn:length(policeExcelList3) != 0 }">
     <div style="width:1200px;text-align:right;margin:10px;">
     </div> 
        <table class="tb_type01">
			<thead>
				<tr>
					<th>검색일자</th>
					<th>조회 기준</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>${from_Date}일 ${from_Hour}시 ~ ${to_Date}일 ${to_Hour}시</td>
					<td>자전거 번호(${bike_No})</td>
				</tr>
			</tbody>
        </table>  
        <table class="tb_type01">
			<colgroup>
				<col style="width:20%"/>
				<col style="width:20%"/>
				<col style="width:20%"/>
				<col style="width:20%"/>
				<col style="width:20%"/>
				<col style="width:30%"/>
				<col style="width:30%"/>
			</colgroup>
			<thead>
				<tr>
					<th>자전거번호</th>
					<th>대여 대여소</th>
					<th>반납 대여소</th>
					<th>연락처</th>
					<th>대여시간</th>
					<th>반납시간</th>
					<th>회원ID</th>
				</tr>
			</thead>
            <tbody>
				<c:choose>
					<c:when test="${fn:length(policeExcelList3) > 0 }">
						<c:forEach items="${policeExcelList3}" var="policeVO3" varStatus="status">
							<tr>
								<td class="tc">${policeVO3.bikeNo}</td>
								<td class="tc">${policeVO3.rentStationName}</td>
								<td class="tc">${policeVO3.returnStationName}</td>
								<td class="title">
									<c:out value="${policeVO3.mpnNo}"/>
								</td>
								<td>${policeVO3.rentDttm}</td>
								<td class="tc">${policeVO3.returnDttm}</td>
								<td class="tc">${policeVO3.mbId}</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td class="tc" colspan="7"><spring:message code="search.nodata.msg" /></td>
						</tr>
					</c:otherwise>
				</c:choose>
			</tbody>
        </table>    

    </c:when>
    <c:otherwise>
        <div style="width:1200px;text-align:right;margin:10px;">
        </div>
        <table class="tb_type01">
			<thead>
				<tr>
					<th>검색일자</th>
					<th>조회 기준</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>${from_Date}일 ${from_Hour}시 ~ ${to_Date}일 ${to_Hour}시</td>
					<td>대여 대여소(${station_Id})</td>
				</tr>
			</tbody>
        </table> 
            <table class="tb_type01">
                <colgroup>
                    <col style="width:20%"/>
                    <col style="width:20%"/>
                    <col style="width:20%"/>
                    <col style="width:20%"/>
                    <col style="width:20%"/>
                    <col style="width:30%"/>
                    <col style="width:30%"/>
                </colgroup>
                <thead>
                    <tr>
                        <th>대여 대여소</th>
                        <th>반납 대여소</th>
                        <th>연락처</th>
                        <th>대여시간</th>
                        <th>반납시간</th>
                        <th>자전거번호</th>
                        <th>회원ID</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${fn:length(policeExcelList) > 0 }">
                            <c:forEach items="${policeExcelList}" var="policeVO" varStatus="status">
                                <tr>
                                    <td class="tc">${policeVO.rentStationName}</td>
                                    <td class="tc">${policeVO.returnStationName}</td>
                                    <td class="title">
                                        <c:out value="${policeVO.mpnNo}"/>
                                    </td>
                                    <td>${policeVO.rentDttm}</td>
                                    <td class="tc">${policeVO.returnDttm}</td>
                                    <td class="tc">${policeVO.bikeNo}</td>
                                    <td class="tc">${policeVO.mbId}</td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td class="tc" colspan="7"><spring:message code="search.nodata.msg" /></td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        <c:choose>
            <c:when test="${fn:length(policeExcelList) > 0}">
                <div class="drpaging">
            </c:when>
            <c:otherwise>
                <div class="drpaging" style="display:none;">
            </c:otherwise>
        </c:choose>
            </div>
        
        
            <br></br>
            <br></br>
        
            
        <table class="tb_type01">
			<thead>
				<tr>
					<th>검색일자</th>
					<th>조회 기준</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>${from_Date}일 ${from_Hour}시 ~ ${to_Date}일 ${to_Hour}시</td>
					<td>반납 대여소(${station_Id})</td>
				</tr>
			</tbody>
        </table>   
        <div style="width:1200px;text-align:right;margin:10px;">
        </div>
            <table class="tb_type01">
                <colgroup>
                    <col style="width:20%"/>
                    <col style="width:20%"/>
                    <col style="width:20%"/>
                    <col style="width:20%"/>
                    <col style="width:20%"/>
                    <col style="width:30%"/>
                    <col style="width:30%"/>
                </colgroup>
                <thead>
                    <tr>
                        <th>대여 대여소</th>
                        <th>반납 대여소</th>
                        <th>연락처</th>
                        <th>대여시간</th>
                        <th>반납시간</th>
                        <th>자전거번호</th>
                        <th>회원ID</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${fn:length(policeExcelList2) > 0 }">
                            <c:forEach items="${policeExcelList2}" var="policeVO2" varStatus="status">
                                <tr>
                                    <td class="tc">${policeVO2.rentStationName}</td>
                                    <td class="tc">${policeVO2.returnStationName}</td>
                                    <td class="title">
                                        <c:out value="${policeVO2.mpnNo}"/>
                                    </td>
                                    <td>${policeVO2.rentDttm}</td>
                                    <td class="tc">${policeVO2.returnDttm}</td>
                                    <td class="tc">${policeVO2.bikeNo}</td>
                                    <td class="tc">${policeVO2.mbId}</td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td class="tc" colspan="7"><spring:message code="search.nodata.msg" /></td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        <c:choose>
            <c:when test="${fn:length(policeExcelList2) > 0}">
                <div class="drpaging">
            </c:when>
            <c:otherwise>
                <div class="drpaging" style="display:none;">
            </c:otherwise>
        </c:choose>
    </c:otherwise>
</c:choose>
</body>
</html>




  
