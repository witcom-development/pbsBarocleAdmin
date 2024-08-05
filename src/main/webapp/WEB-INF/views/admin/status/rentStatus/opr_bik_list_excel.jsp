<%@ page language="java" contentType="application/vnd.ms-excel;charset=euc-kr"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
    response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode("자전거리스트.xls", "UTF8"));
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
    <table class="tb_type01" style="width : 1200px;">
                            <colgroup>
                                
                                 <c:choose>

                                    <%-- 자전거이력 --%>
                                    <c:when test="${ searchCondition.bikeStatusCd eq 'BKS_013'}">    
                                        <col style="width:15%"/>
                                        <col style="width:10%"/>
                                        <col style="width:10%"/>
                                        <col style="width:15%"/>
                                        <col style="width:15%"/>
                                        <col style="width:10%"/>
                                    </c:when>


                                    <%-- 강제 분실 --%>
                                    <c:when test="${ searchCondition.bikeStatusCd eq 'BKS_014'}">    
                                        <col style="width:15%"/>
                                        <col style="width:10%"/>
                                        <col style="width:10%"/>
                                        <col style="width:15%"/>
                                        <col style="width:15%"/>
                                        <col style="width:10%"/>
                                        <col style="width:10%"/>
                                    </c:when>
    
                                    <%-- 분실 --%>
                                    <c:when test="${ searchCondition.bikeStatusCd eq 'BKS_007'}">    
                                        <col style="width:15%"/>
                                        <col style="width:25%"/>
                                        <col style="width:10%"/>
                                        <col style="width:10%"/>
                                        <col style="width:15%"/>
                                        <col style="width:10%"/>
                                    </c:when>

                                    <%-- 강제반납 상태조회 --%>
                                    <c:when test="${ searchCondition.bikeStatusCd eq 'BKS_015'}">
                                        <col style="width:5%"/>
										<col style="width:5%"/>
                                        <col style="width:5%"/>
                                        <col style="width:5%"/>                                            
                                        <col style="width:5%"/>                                            
                                        <col style="width:5%"/>                                            
                                        <col style="width:5%"/>                                            
                                        <col style="width:5%"/>                                            
                                        <col style="width:5%"/>                                            
                                    </c:when>   

                                    <%-- 수리중 --%>
                                    <c:when test="${ searchCondition.bikeStatusCd eq 'BKS_005'}">
                                        <col style="width:15%"/>
                                        <col style="width:20%"/>
                                        <col style="width:25%"/>
                                        <col style="width:10%"/>
                                    </c:when>

                                    <%-- 도난추정 --%>
                                    <c:when test="${ searchCondition.bikeStatusCd eq 'BKS_016'}">
                                        <%--자전거번호--%>
                                        <col style="width:15%"/>
                                        <%--지역구--%>
                                        <col style="width:10%"/>
                                        <%--반납대여소명--%>
                                        <col style="width:25%"/>

                                        <col style="width:25%"/>
                                        <col style="width:10%"/>
                                        <col style="width:18%"/>
                                        <col style="width:18%"/>
                                        <col style="width:18%"/>
                                        <col style="width:10%"/>
                                    </c:when>
                                    
                                    <c:otherwise>    
                                        <col style="width:15%"/>
                                        <col style="width:auto"/>
                                        <col style="width:13%"/>
                                        <col style="width:13%"/>
                                        <col style="width:13%"/>
                                        <col style="width:13%"/>
                                        <col style="width:13%"  class="mhid"/>
                                    </c:otherwise>

                                </c:choose>
                            </colgroup>
                            <thead>
                                <tr>
                                
                                    <c:choose>

                                        <%-- 자전거이력 --%>
                                        <c:when test="${ searchCondition.bikeStatusCd eq 'BKS_013'}">    
                                            <th>자전거번호</th>
                                            <th>등록일시</th>
                                            <th>구분</th>
                                            <th>출발지</th>
                                            <th>도착지</th>
                                            <th>상세내용</th>
                                        </c:when> 


                                        <%-- 분실 상세 --%>
                                        <c:when test="${ searchCondition.bikeStatusCd eq 'BKS_014'}">    
                                            <th>자전거번호</th>
                                            <th>이전상태</th>
                                            <th>현재상태</th>
                                            <th>등록일시</th>
                                            <th>회수담당자</th>
                                            <th>회수일자</th>
                                            <th>상세내용</th>
                                        </c:when>   

                                        <%-- 분실 --%>
                                        <c:when test="${ searchCondition.bikeStatusCd eq 'BKS_007'}">    
                                            <th>자전거번호</th>
                                            <th>접수일자</th>
                                            <th>상태</th>
                                            <th>등록자</th>
                                            <th>분실일자</th>
                                            <th>경과일자</th>
                                        </c:when>    

                                        <%-- 강반상태조회 --%>
                                        <c:when test="${ searchCondition.bikeStatusCd eq 'BKS_015'}">
                                            <th>자전거번호</th>
                                            <th>구분</th>
                                            <th>자전거현재상태</th>
                                            <th>미반납사유</th>
                                            <th>현장조치여부</th>
                                            <th>등록자</th>
                                            <th>등록일시</th>
                                            <th>처리자</th>
                                            <th>처리일시</th>
                                        </c:when>

        
                                        <%-- 수리중 --%>
                                        <c:when test="${ searchCondition.bikeStatusCd eq 'BKS_005'}">
                                            <th>자전거번호</th>
                                            <th>수리등록일자</th>
                                            <th>센터</th>
                                            <th>경과일자</th>
                                        </c:when>        

                                        <%-- 도난추정 --%>
                                        <c:when test="${ searchCondition.bikeStatusCd eq 'BKS_016'}">
                                            <th>자전거</br>번호</th>
                                            <th>지역구</th>
                                            <th>반납대여소명</th>
                                            <th>반납일시</th>
                                            
                                            <th>강반</th>

                                            <th>최종신호</th>
                                            <th>상태정보</br>미전송일시</th>
                                            <th>등록일자</th>
                                            <th>경과</br>일자</th>
                                        </c:when>   

                                        <c:otherwise>     
                                            <th>자전거번호</th>
                                            <th>대여소/센터</th>
                                            <th>거치대번호</th>
                                            <th>배터리상태</th>
                                            <th>상태</th>
                                            <th>납품처</th>
                                            <th class="mhid">등록일</th>
                                        </c:otherwise>  
                                    </c:choose>
                                    
                                </tr>
                            </thead>
                            <c:if test="${fn:length(BikeList) > 0 }">
                            <tbody>
                                <c:forEach var="bike" items="${BikeList}" varStatus="loop">
                                    <tr>
	                                        <td class="pl10">${bike.bikeNo}</td>
                                        
                                        <c:choose>
                                        
                                            <%-- 자전거이력 --%>
                                            <c:when test="${ searchCondition.bikeStatusCd eq 'BKS_013'}">    
                                                <td class="pl10">${bike.locateStrDttm}</td>
                                                <td class="pl10">${bike.bikeStatusCd }</td>
                                                <td class="pl10">${bike.bikeStatusName}</td>
                                                <td class="pl10">${bike.adminId}</td>

                                                <td class="pl10">${bike.isParking}</td>
                                            </c:when>                                        
                                        
                                        
                                            <%-- 강반 분실 --%>
                                            <c:when test="${ searchCondition.bikeStatusCd eq 'BKS_014'}">    
                                                <td class="pl10">${bike.bikeStatusCd }</td>
                                                <td class="pl10">${bike.bikeStatusName}</td>
                                                <td class="pl10">${bike.regDttm}</td>
                                                <td class="pl10">${bike.adminId}</td>
                                                <td class="pl10">${bike.modDttm}</td>
                                                <td class="pl10">${bike.batteryStusCd}</td>
                                            </c:when>

                                            <%-- 분실 --%>
                                            <c:when test="${ searchCondition.bikeStatusCd eq 'BKS_007'}">    
                                                <td class="pl10">${bike.modDttm }</td>
                                                <td class="pl10">${bike.bikeStatusName}</td>
                                                <td class="pl10">${bike.entrpsCdNm}</td>
                                                <td class="pl10">${bike.lostDate}</td>
                                                <td class="pl10">${bike.locateStrDttm}</td>
                                            </c:when>

                                            <%-- 강반상태조회 --%>
                                            <c:when test="${ searchCondition.bikeStatusCd eq 'BKS_015'}">
                                                <td class="pl10">${bike.bikeStatusCd }</td>
                                                <td class="pl10">${bike.bikeStatusName }</td>
                                                <td class="pl10">${bike.lostRegId }</td>
                                                <td class="pl10">${bike.entrpsCd }</td>
                                                <td class="pl10">${bike.adminId }</td>
                                                <td class="pl10">${bike.regDttm }</td>
                                                <td class="pl10">${bike.entrpsCdNm }</td>
                                                <td class="pl10">${bike.modDttm }</td>
                                            </c:when>

                                            <%-- 수리중 --%>   
                                            <c:when test="${ searchCondition.bikeStatusCd eq 'BKS_005'}">    
                                                <td class="pl10">${bike.modDttm }</td>
                                                <td class="pl10">${bike.stationName}</td>
                                                <td class="pl10">${bike.locateStrDttm}</td>
                                            </c:when>

                                            <%-- 도난추정 --%>
                                            <c:when test="${ searchCondition.bikeStatusCd eq 'BKS_016'}">
                                                <%--지역구--%>
                                                    <td class="pl10">${bike.centerId}</td>
                                                <%--반납대여소명--%>
                                                    <td class="pl10">${bike.stationName}</td>
                                                <%--반납일시--%>
                                                <td class="pl10">
                                                    ${fn:substring(bike.lostDate, 0, 10)}</br>
                                                    ${fn:substring(bike.lostDate, 11,19)}
                                                </td>        
                                                <%--강제반납--%>
                                                <td class="pl10">${bike.bikeStatusName}</td>
                                                <%--최종신호--%>
                                                <td class="pl10">
                                                    ${fn:substring(bike.entrpsCd, 0, 10)}</br>
                                                    ${fn:substring(bike.entrpsCd, 11,19)}
                                                </td>
                                                <%--상태정보미전송일시--%>
                                                <td class="pl10">
                                                    ${fn:substring(bike.entrpsCdNm, 0, 10)}</br>
                                                    ${fn:substring(bike.entrpsCdNm, 11,19)}
                                                </td>
                                                <%--등록일자--%>
                                                <td class="pl10">
                                                    ${fn:substring(bike.regDttm, 0, 10)}</br>
                                                    ${fn:substring(bike.regDttm, 11,19)}    
                                                </td>
                                                <%--경과일자--%>
                                                <td class="pl10">${bike.locateStrDttm}</td>
                                            </c:when>                                             

                                            <c:otherwise>     
                                                <td class="title pl10">${bike.stationName}</td>
                                                <td class="pl10">${bike.stationEquipOrder}</td>
                                                <td class="pl10">${bike.batteryStusCd}</td>
                                                <td class="pl10">${bike.bikeStatusName}</td>
                                                <td class="pl10">${bike.entrpsCdNm}</td>
                                                <td class="tc mhid">${bike.regDttm }</td>
                                            </c:otherwise>  

                                        </c:choose>    
                                            
                                    </tr>
                                </c:forEach>
                            </tbody>
                            </c:if>
                        </table>
</body>
</html>