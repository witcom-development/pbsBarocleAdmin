<%@ page language="java" contentType="application/vnd.ms-excel;charset=euc-kr"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
    response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode("회수조회.xls", "UTF8"));
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
                    <td style="width:200px;" class="condition" ><label class="laType02">등록일</label></td>
                    <td style="width:400px;">${searchCondition.searchBgnDe} ~ ${searchCondition.searchEndDe}</td>
                    <td style="width:200px;" class="condition" ><label class="laType02">상태</label></td>
	                <td style="width:400px;">${searchCondition.bikeStatusName}</td>
                </tr>
                <tr>
                    <td style="width:200px;" class="condition" ><label class="laType02">선택</label></td>
                    <td style="width:400px;">${searchCondition.searchTypeName}
                    <c:if test="${searchCondition.searchWord ne ''}">
                        /${searchCondition.searchWord}
                    </c:if>
                    </td>
                    <td style="width:200px;" class="condition" ></td>
                    <td style="width:400px;"></td>
                </tr>
            </tbody>
        </table>
    </div>
    <div style="width:1200px;text-align:right;margin:10px;">
          <label class="laType02"><b>총 ${paginationInfo.getTotalRecordCount() } 건</b></label>
    </div>
    <!--검색조건 E-->
   <table class="tb_type01">
                            <colgroup>
                                 
                                        <col style="width:13%"/>
                                        <col style="width:10%"/>
                                        <col style="width:10%"/>
                                        <col style="width:20%"/>
                                        <col style="width:12%"/>
                                        <col style="width:10%"/>
                                        <col style="width:10%"/>
                                    
                            </colgroup>
                            <thead>
                                <tr>
                                       
                                            <th>자전거번호</th>
                                            <th>이전상태</th>
                                            <th>현재상태</th>
                                            <th>등록일시</th>
                                            <th>회수담당자</th>
                                            <th>회수일자</th>
                                            <th>상세내용</th>
                                       
                                </tr>
                            </thead>
                            <c:if test="${fn:length(BikeList) > 0 }">
                            <tbody>
                                <c:forEach var="bike" items="${BikeList}" varStatus="loop">
                                    <tr>
	                                   	<td class="tc"><a href="/moveBikeEditForm.do?viewFlg=U&bikeNo=${bike.bikeNo}&bikeId=${bike.bikeId}" id="${bike.bikeId}" target="_blank">${bike.bikeNo}</a></td>
                                        <td class="tc">${bike.bikeStatusCd }</td>
                                        <td class="tc">${bike.bikeStatusName}</td>
                                        <td class="tc">${bike.regDttm}</td>
                                        <td class="tc">${bike.adminId}</td>
                                        <td class="tc">${bike.modDttm}</td>
                                        <td class="tc">${bike.batteryStusCd}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                            </c:if>
                        </table>
</body>
</html>