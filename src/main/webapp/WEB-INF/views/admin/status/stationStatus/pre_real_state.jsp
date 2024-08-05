<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%
     String toDate = new java.text.SimpleDateFormat("yyyy.MM.dd     HH:mm:ss").format(new java.util.Date());
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" /> 
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />
<meta name="description=" Content="" />
<title><tiles:insertAttribute name="title"/></title>
<tiles:insertAttribute name="resource"/>
</head>
<body>
<div class="allwrap">
        <!--모바일 메뉴 S-->
        <tiles:insertAttribute name="header"/>
        <!--모바일 메뉴 E-->
        <!--Head S-->
        <tiles:insertAttribute name="head"/>
        <!--Head E-->
        <div id="body">
            <div class="cont">
                <!--left menu S-->
                <tiles:insertAttribute name="left"/>
                <!--left menu E-->
                <!--conteent S-->
                <div id="content" class="content">
                    <div class="subject">
                        <!--subject path S-->
                        <tiles:insertAttribute name="subject" />
                        <!--subject path E-->
                    </div>
                    <div class="page">
                        <div>
							<p class="tb_numlist" style="margin-right: 5px; font-size: 15px; margin-top: 30px;" >조회일시 : <%=toDate %></p>
						</div>
                        <h1 class="popTt2">실시간 매출 현황</h1>
                        <table class="tb_type01  ">
                            <colgroup>
                                <col style="width:15%"/>
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>전체</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="title">
                                        <div class="statulist">
                                            <p>결제 총액:<span>${realStatusVo.bilTot }</span></p>
                                        </div>
                                    </td>
                                    
                                </tr>
                            </tbody>
                        </table>
                        <table class="tb_type04  ">
                            <colgroup>
                                <col style="width:15%"/>
                                <col style="width:15%"/>
                                <col style="width:15%"/>
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>정기</th>
                                    <th>일일</th>
                                    <th>프리미엄 (2시간)</th>
                                </tr>
                            </thead>
                                    <td class="title">
                                        <div style='float:left;'>
                                        	7일   :
                                        </div>
                                        <div style='text-align:right; margin-right: 3px;'> 
									       ${realStatusVo.bil001Amt }
									    </div> 
									    <div style='float:left;'>
                                        	30일  :
                                        </div>
                                        <div style='text-align:right; margin-right: 3px;'> 
									       ${realStatusVo.bil002Amt }
									    </div>
									   <%--  <div style='float:left;'>
                                        	90일  :
                                        </div>
                                        <div style='text-align:right; margin-right: 3px;'> 
									       ${realStatusVo.bil003Amt }
									    </div>  --%>
									    <div style='float:left;'>
                                        	180일  :
                                        </div>
                                        <div style='text-align:right; margin-right: 3px;'> 
									       ${realStatusVo.bil004Amt }
									    </div>
									    <div style='float:left;'>
                                        	365일  :
                                        </div>
                                        <div style='text-align:right; margin-right: 3px;'> 
									       ${realStatusVo.bil005Amt }
									    </div>
                                    </td>
                                    <td class="title">
                                        <%-- <div class="statulist">
                                            <p> 회원 : <span>${realStatusVo.bil006Amt }</span></p>
                                            <p>비회원 : <span>${realStatusVo.bil007Amt }</span></p>
                                        </div> --%>
                                        <div style='float:left;'>
                                        	회원  :
                                        </div>
                                        <div style='text-align:right; margin-right: 3px;'> 
									       ${realStatusVo.bil006Amt }
									    </div>
									    <div style='float:left;'>
                                        	비회원  :
                                        </div>
                                        <div style='text-align:right; margin-right: 3px;'> 
									       ${realStatusVo.bil007Amt }
									    </div>
                                    </td>
                                    <td class="title">
                                        <%-- <div class="statulist">
                                            <p>정기-7일        : <span>${realStatusVo.bil011Amt }</span></p>
                                            <p>정기-30일     : <span>${realStatusVo.bil012Amt }</span></p>
                                            <p>정기-90일     : <span>${realStatusVo.bil013Amt } </span></p>
                                            <p>정기-180일   : <span>${realStatusVo.bil014Amt }  </span></p> 
                                            <p>정기-365일   : <span>${realStatusVo.bil015Amt } </span></p>
                                            <p>일일 - 회원     : <span>${realStatusVo.bil016Amt } </span></p>
                                            <p>일일 - 비회원  : <span>${realStatusVo.bil017Amt } </span></p>
                                        </div> --%>
                                        <div style='float:left;'>
                                        	일일 회원   :
                                        </div>
                                        <div style='text-align:right; margin-right: 3px;'> 
									        ${realStatusVo.bil016Amt }
									    </div> 
									    <div style='float:left;'>
                                        	일일 비회원   :
                                        </div>
                                        <div style='text-align:right; margin-right: 3px;'> 
									        ${realStatusVo.bil017Amt }
									    </div> 
                                    </td>
                                </tr>
                            </tbody>
                            </table>
                            <table class="tb_type04  ">
                            <colgroup>
                                <col style="width:15%"/>
                                <col style="width:15%"/>
                                <col style="width:15%"/>
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>단체</th>
                                    <th>초과요금</th>
                                    <th>보증금</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="title">
                                        <%-- <div class="statulist">
                                            <p>단체:<span>${realStatusVo.bil008Amt }</span></p>
                                        </div> --%>
                                        <div style='float:left;'>
                                        	단체:
                                        </div>
                                        <div style='text-align:right; margin-right: 3px;'> 
									        ${realStatusVo.bil008Amt }
									    </div>
                                    </td>
                                    <td class="title">
                                        <%-- <div class="statulist">
                                            <p>초과요금 : <span>${realStatusVo.bil009Amt }</span></p>
                                        </div> --%>
                                        <div style='float:left;'>
                                        	초과요금 :
                                        </div>
                                        <div style='text-align:right; margin-right: 3px;'> 
									        ${realStatusVo.bil009Amt }
									    </div>
                                    </td>
                                    <td class="title">
                                        <%-- <div class="statulist">
                                            <p>보증금 : <span>${realStatusVo.bil010Amt }</span></p>
                                        </div> --%>
                                        <div style='float:left;'>
                                        	보증금 :
                                        </div>
                                        <div style='text-align:right; margin-right: 3px;'> 
									        ${realStatusVo.bil010Amt }
									    </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <br>
                        <h1 class="popTt2">홈페이지 가입현황</h1>
                        <table class="tb_type01  ">
                            <colgroup>
                                <col style="width:15%"/>
                                <col style="width:15%"/>
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>전체</th>
                                    <th>금일</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="title">
                                        <%-- <div class="statulist">
                                            <p>가입자수 : <span>${realStatusVo.totCnt }</span></p>
                                        </div> --%>
                                        <div style='float:left;'>
                                        	가입자수 :
                                        </div>
                                        <div style='text-align:right; margin-right: 3px;'> 
									        ${realStatusVo.totCnt }
									    </div>
                                    </td>
                                    <td class="title">
                                        <%-- <div class="statulist">
                                            <p>가입자수 : <span>${realStatusVo.yoilCnt }</span></p>
                                        </div> --%>
                                        <div style='float:left;'>
                                        	가입자수 :
                                        </div>
                                        <div style='text-align:right; margin-right: 3px;'> 
									        ${realStatusVo.yoilCnt }
									    </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        
                         <br>
                        <h1 class="popTt2">상/하위 대여소</h1>
                        <table class="tb_type01  ">
                            <colgroup>
                                <col style="width:15%"/>
                                <col style="width:15%"/>
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>상위</th>
                                    <th>하위</th>
                                    
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="result" items="${stationList}" varStatus="status">
	                                <tr>
		                                    <td class="title" style="font-size: 12px; text-align: left;">
		                                        <div class="statulist">
		                                            <p>${result.highStation}</p>
		                                        </div>
		                                    </td>
		                                    <td class="title" style="font-size: 12px; text-align: left;">
		                                        <div class="statulist">
		                                            <p>${result.lowStation}</p>
		                                        </div>
		                                    </td>
	                                </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        
                         <br>
                        <h1 class="popTt2">전체 및 지역별 이용건수</h1>
                        <table class="tb_type01  ">
                            <colgroup>
                                <col style="width:30%"/>
                                <col style="width:65%"/>
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>전체</th>
                                    <th>지역별</th>
                                    
                                </tr>
                            </thead>
                            <tbody>
	                                <tr>
	                                    <td class="title" style="font-size: 12px; text-align: left;">
	                                        <%-- <div class="statulist">
											 	<p>건수 : <span>${realStatusVo.tot }</span></p>
	                                        </div> --%>
	                                        <div style='float:left;'>
	                                        	건수 :
	                                        </div>
	                                        <div style='text-align:right; margin-right: 3px;'> 
										        ${realStatusVo.tot }
										    </div>
	                                    </td>
	                                    <td class="title" style="font-size: 12px; text-align: left;">
	                                    	<table  class="tb_type01  " style="margin-top: -8px; margin-bottom: -8px;">
	                                    		<c:forEach var="result" items="${stationList2}" varStatus="status">
		                                    		<tr>
		                                    			<td class="title" style="font-size: 12px; text-align: center;">
					                                        <p>${result.stationGrpName} : &nbsp;&nbsp;<span>${result.stationClsCd }</span></p>
					                                    </td>
		                                    		</tr>
	                                    		</c:forEach>
	                                    	</table>
	                                        
	                                    </td>
	                                </tr>  
                            </tbody>
                        </table>
                        
                         <br>
                        <h1 class="popTt2">지역별 배치현황</h1>
                        <table class="tb_type01  ">
                            <colgroup>
                                <col style="width:30%"/>
                                <col style="width:65%"/>
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>전체</th>
                                    <th>지역별</th>
                                    
                                </tr>
                            </thead>
                            <tbody>
	                                <tr>
	                                    <td class="title" style="font-size: 12px; text-align: left;">
	                                       <%--  <div class="statulist">
											 	<p>전체 이용건수 : <span>${realStatusVo.totRelocateCnt }</span></p>
	                                        </div> --%>
	                                        <div style='float:left;'>
	                                        	건수 :
	                                        </div>
	                                        <div style='text-align:right; margin-right: 3px;'> 
										        ${realStatusVo.totRelocateCnt }
										    </div>
	                                    </td>
	                                    <td class="title" style="font-size: 12px; text-align: left;">
	                                    	<table  class="tb_type01  " style="margin-top: -8px; margin-bottom: -8px;">
	                                    		<c:forEach var="result" items="${stationList3}" varStatus="status">
		                                    		<tr>
		                                    			<td class="title" style="font-size: 12px; text-align: center;">
					                                        <p><span>${result.stationGrpNm }</span></p>
					                                    </td>
		                                    		</tr>
	                                    		</c:forEach>
	                                    	</table>
	                                        
	                                    </td>
	                                </tr>  
                            </tbody>
                        </table>

                        <br>
                       <%--  <h1 class="popTt2">자전거 재고 현황</h1>
                        <table class="tb_type01  ">
                            <colgroup>
                                <col style="width:30%"/>
                                <col style="width:65%"/>
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>전체</th>
                                    <th>사용(운영) 중</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="title">
                                        <div class="statulist">
                                            <p>건수 : <span>${realStatusVo.bikeCnt }</span></p>
                                        </div>
                                        <div style='float:left;'>
                                        	건수 :
                                        </div>
                                        <div style='text-align:right; margin-right: 3px;'> 
									        ${realStatusVo.bikeCnt }
									    </div>
                                    </td>
                                     <td class="title" style="font-size: 12px; text-align: left;">
	                                    	<table  class="tb_type01  " style="margin-top: -8px; margin-bottom: -8px;">
	                                    		<c:forEach var="result" items="${stationList4}" varStatus="status">
		                                    		<tr>
		                                    			<td class="title" style="font-size: 12px; text-align: center;">
					                                        <p>${result.bikeStusCnt} </p>
					                                    </td>
		                                    		</tr>
	                                    		</c:forEach>
	                                    	</table>
	                                        
	                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        
                        <br>
                        <h1 class="popTt2">공지사항</h1>
                        <table class="tb_type01  ">
                            <colgroup>
                                <col style="width:40%"/>
                                <col style="width:15%"/>
                                <col style="width:12%"/>
                                <col style="width:12%"/>
                                <col style="width:12%"/>
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>제목</th>
                                    <th>공지대상</th>
                                    <th>공지여부</th>
                                    <th>공지시작일</th>
                                    <th>공지종료일</th>
                                </tr>
                            </thead>
                            <tbody>
                           		<c:forEach var="result" items="${stationList5}" varStatus="status">
                            		<tr>
                            		   <td class="title" style="text-align:left; margin-top: -4px;">
                                   			<p><a href="/admin/customer/notice/noticeEdit.do?mode=edit&noticeSeq=<c:out value='${result.noticeSeq}'/>">${result.noticeTitle} </a></p>
		                               </td>
		                               <td class="title">
		                                   <p>${result.siteClsCd}</p>
		                               </td>
		                               <td class="title" style="text-align:center;">
		                                   <p>${result.mainNoticeYn}</p>
		                               </td>
		                               <td class="title" style="text-align:center;">
		                                   <p>${result.postStrDttm}</p>
		                               </td>
		                               <td class="title" style="text-align:center;">
		                                   <p>${result.postEndDttm}</p>
		                               </td>
		                          	</tr>
                           		</c:forEach>
                            </tbody>
                        </table> --%>
                    </div>
                </div>
                <!--conteent E-->
            </div>
        </div>
        <!--footer S-->
        <tiles:insertAttribute name="footer"/>
        <!--footer E-->
    </div>
   
    
</body>
</html>