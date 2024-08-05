<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Calendar"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<%
	Calendar cal = Calendar.getInstance();
	int nowYear = cal.get(Calendar.YEAR);
	int nowMonth = cal.get(Calendar.MONTH)+1;
	int day = cal.get(Calendar.DAY_OF_MONTH);
	int hour = cal.get(Calendar.HOUR_OF_DAY);
	int min = cal.get(Calendar.MINUTE);
	int sec = cal.get(Calendar.SECOND);
	
	String fileName =  nowYear + "년" + nowMonth + "월"+ day + "일" + hour + "시"+ min +"분" + sec +"초" + "바로클포정비실적.xls" ;
	
    response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode( fileName , "UTF-8"));
    /* response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode("정비보고서.doc", "UTF-8")); */
	/* response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode("정비보고서.hwp", "UTF-8")); */
    response.setHeader("Content-Description", "JSP Generated Data");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" /> 
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />
<meta name="description=" Content="" />
</head>
<body>
<meta content="text/html; charset=KSC5601" http-equiv="content-type" />
<style>
.tb_type01 th {text-align:center;padding:5% 0;}
.tb_type01 td {text-align:center;padding:5% 0}
.tb_type01 {width:100%;border:1px solid #000000;font-size:15px;table-layout:fixed}
.tb_type01 th {text-align:center;padding:1px 0;background:#eff5f8;border-top:1px solid #000000;border-right:1px solid #000000}
.tb_type01 td {text-align:center;padding:10px 2px;border:1px solid #000000}
.tb_type01 td.txRight {text-align:right;}
.tb_condition {width : 1200px}
/* .tb_condition th {text-align:center;padding:15px 0;} */
.tb_condition th {text-align:center;padding:15px 0;background:#eff5f8;border:1px solid #000000; font-size: 20px;}
.tb_condition th.condition {width:1200px;text-align:center;padding:15px 0; font-size: 27px;}
.tb_condition th.condition2 {width:1200px;text-align:center;padding:15px 0; font-size: 16px;}
.tb_condition td {text-align:center;padding:10px 2px;border:0px solid #000000}
/*label*/
.laType02 {margin-right:5px;display:inline-block;font-size:11px;}
</style>
</head>
<body>

<h1 style="text-align:center;"> ${statMonth} 월 정비 보고서</h1>
    <div style="height:200px; width:100%;text-align:center; margin-top:10px;">
    </div>

    <table class="tb_type01" style="width : 100%;">
        <thead>
            <tr>
                <th>연번</th>
                <th>점포명</th>
                <th>자전거번호</th>
                
                <th>등록일시</th>
                <th>인수일자</th>
                <th>인계일자</th>
                <th>검수일자</th>
                
                
                <th  class="case1">기본교정</th>
                
                <th class="case1">프레임</th>
                <th class="case1">포크</th>
                <th class="case1">안장</th>
                <th class="case1">싯포스트</th>
                <th class="case1">싯클램프</th>
                <th class="case1">QR레버</th>
                <th class="case2">변속레버</th>
                <th class="case2">변속기</th>
                <th class="case2">변속케이블</th>
                <th class="case2">변속보호대</th>
                <th class="case3_1">앞_휠셋</th>
                <th class="case3_1">앞_타이어</th>
                <th class="case3_1">앞_튜브</th>
                <th class="case3_1">앞_물받이</th>
                
                <th class="case3_2">뒤_휠셋</th>
                <th class="case3_2">뒤_타이어</th>
                <th class="case3_2">뒤_튜브</th>
                <th class="case3_2">뒤_물받이(구)</th>
                <th class="case3_2">뒤_물받이(신)</th>
                
                <th class="case4">핸들스템</th>
                <th class="case4">핸들바</th>
                <th class="case4">핸들그립</th>
                
                <th class="case5">크랭크암</th>
                <th class="case5">바텀브라킷</th>
                <th class="case5">체인</th>
                <th class="case5">페달</th>
                
				<th class="case6">레버</th>
                <th class="case6">앞_V</th>
                <th class="case6">앞_케이블</th>
                <th class="case6">앞_패드</th>
                <th class="case6">뒤_롤브레이크</th>
                <th class="case6">뒤_케이블</th>
                
 				<th class="case7">전조등(구형)</th>
 				<th class="case7">전조등(신형)</th>
 				<th class="case7">다이나모케이블</th>
 				<th class="case7">후미등</th>
 				<th class="case7">벨</th>
 				<th class="case7">바구니</th>
 				<th class="case7">스텐드</th>
 				<th class="case7">체인커버</th>

                <th>정비건수</th>
                <th>정비금액</th>
            </tr>
        </thead>
          
          <tbody>
          <c:forEach var="result" items="${ReportMallList}" varStatus="status">
			<tr>
			 
				<td>${status.count}</td>
                <td>${result.centerName}</td>
                <td>${result.centerNo}</td>
                <td>${result.regDttm}</td>
                <td>${result.transDttm}</td>
                <td>${result.takeDttm}</td>
                <td>${result.collectDttm}</td>
                
                <td class="case1"><fmt:formatNumber pattern="#,###" value="${result.rec_001 }"></fmt:formatNumber></td>  
                <td class="case1"><fmt:formatNumber pattern="#,###" value="${result.rec_002 }"></fmt:formatNumber></td>        <!--프레임</td>      -->                 
                <td class="case1"><fmt:formatNumber pattern="#,###" value="${result.rec_003 }"></fmt:formatNumber></td>        <!--포크</td>        -->                
                <td class="case1"><fmt:formatNumber pattern="#,###" value="${result.rec_004 }"></fmt:formatNumber></td>        <!--안장</td>        -->                
                <td class="case1"><fmt:formatNumber pattern="#,###" value="${result.rec_005 }"></fmt:formatNumber></td>        <!--싯포스트</td>    -->                  
                <td class="case1"><fmt:formatNumber pattern="#,###" value="${result.rec_006 }"></fmt:formatNumber></td>        <!--싯클램프</td>    -->                  
                <td class="case2"><fmt:formatNumber pattern="#,###" value="${result.rec_007 }"></fmt:formatNumber></td>        <!--QR레버</td>      -->                
                <td class="case2"><fmt:formatNumber pattern="#,###" value="${result.rec_008 }"></fmt:formatNumber></td>        <!--변속레버</td>    -->                  
                <td class="case2"><fmt:formatNumber pattern="#,###" value="${result.rec_009 }"></fmt:formatNumber></td>        <!--변속기</td>      -->                 
                <td class="case2"><fmt:formatNumber pattern="#,###" value="${result.rec_010}"></fmt:formatNumber></td>         <!--변속케이블</td>  -->                   
                <td class="case3_1"><fmt:formatNumber pattern="#,###" value="${result.rec_011}"></fmt:formatNumber></td>            <!--변속보호대</td>  -->              
                <td class="case3_1"><fmt:formatNumber pattern="#,###" value="${result.rec_012}"></fmt:formatNumber></td>            <!--앞_휠셋</td>           -->      
                <td class="case3_1"><fmt:formatNumber pattern="#,###" value="${result.rec_013}"></fmt:formatNumber></td>            <!--앞_타이어</td>         -->       
                <td class="case3_1"><fmt:formatNumber pattern="#,###" value="${result.rec_014}"></fmt:formatNumber></td>            <!--앞_튜브</td>           -->      
                <td class="case3_2"><fmt:formatNumber pattern="#,###" value="${result.rec_015}"></fmt:formatNumber></td>            <!--앞_물받이</td>         -->       
                <td class="case3_2"><fmt:formatNumber pattern="#,###" value="${result.rec_016}"></fmt:formatNumber></td>            <!--뒤_휠셋</td>           -->      
                <td class="case3_2"><fmt:formatNumber pattern="#,###" value="${result.rec_017}"></fmt:formatNumber></td>            <!--뒤_타이어</td>         -->       
                <td class="case3_2"><fmt:formatNumber pattern="#,###" value="${result.rec_018}"></fmt:formatNumber></td>            <!--뒤_튜브</td>           -->      
                <td class="case3_2"><fmt:formatNumber pattern="#,###" value="${result.rec_019}"></fmt:formatNumber></td>            <!--뒤_물받이(구)</td>     -->        
                <td class="case4">  <fmt:formatNumber pattern="#,###" value="${result.rec_020}"></fmt:formatNumber></td>            <!--뒤_물받이(신)</td>     -->                              
                <td class="case4">  <fmt:formatNumber pattern="#,###" value="${result.rec_021}"></fmt:formatNumber></td>                   <!--조향부</td>    -  -->    
                <td class="case4">  <fmt:formatNumber pattern="#,###" value="${result.rec_022}"></fmt:formatNumber></td>                   <!--핸들바</td>    -  -->    
                <td class="case5">  <fmt:formatNumber pattern="#,###" value="${result.rec_023}"></fmt:formatNumber></td>                   <!--핸들그립</td>  -  -->     
                <td class="case5">  <fmt:formatNumber pattern="#,###" value="${result.rec_024}"></fmt:formatNumber></td>                   <!--크랭크암</td>  -  -->     
                <td class="case5">  <fmt:formatNumber pattern="#,###" value="${result.rec_025}"></fmt:formatNumber></td>                   <!--바텀브라킷</td>-  -->      
                <td class="case5">  <fmt:formatNumber pattern="#,###" value="${result.rec_026}"></fmt:formatNumber></td>                   <!--체인</td>      -  -->   
				<td class="case6">  <fmt:formatNumber pattern="#,###" value="${result.rec_027}"></fmt:formatNumber></td>                   <!--페달</td>      -  -->   
                <td class="case6">  <fmt:formatNumber pattern="#,###" value="${result.rec_028}"></fmt:formatNumber></td>                   <!--레버</td>      -  -->   
                <td class="case6">  <fmt:formatNumber pattern="#,###" value="${result.rec_029}"></fmt:formatNumber></td>                   <!--앞_V</td>      -  -->  
                <td class="case6">  <fmt:formatNumber pattern="#,###" value="${result.rec_030}"></fmt:formatNumber></td>                   <!--앞_케이블</td> -  -->     
                                                                                                                                             
                <td class="case6">  <fmt:formatNumber pattern="#,###" value="${result.rec_031}"></fmt:formatNumber></td>                   <!--앞_패드</td>   -  -->                            
                <td class="case6">  <fmt:formatNumber pattern="#,###" value="${result.rec_032}"></fmt:formatNumber></td>                   <!--뒤_롤브레이크</-  -->       
 				<td class="case7">  <fmt:formatNumber pattern="#,###" value="${result.rec_033}"></fmt:formatNumber></td>                   <!--뒤_케이블</td> -  -->     
 				<td class="case7">  <fmt:formatNumber pattern="#,###" value="${result.rec_034}"></fmt:formatNumber></td>                   <!--전조등(구형)</t-  -->      
 				<td class="case7">  <fmt:formatNumber pattern="#,###" value="${result.rec_035}"></fmt:formatNumber></td>                   <!--전조등(신형)</t-  -->      
 				<td class="case7">  <fmt:formatNumber pattern="#,###" value="${result.rec_036}"></fmt:formatNumber></td>                   <!--다이나모케이블<-  -->        
 				<td class="case7">  <fmt:formatNumber pattern="#,###" value="${result.rec_037}"></fmt:formatNumber></td>                   <!--후미등</td>    -  -->    
 				<td class="case7">  <fmt:formatNumber pattern="#,###" value="${result.rec_038}"></fmt:formatNumber></td>                   <!--벨</td>        -  -->  
 				<td class="case7">  <fmt:formatNumber pattern="#,###" value="${result.rec_039}"></fmt:formatNumber></td>                   <!--바구니</td>    -  -->    
 				<td class="case7">  <fmt:formatNumber pattern="#,###" value="${result.rec_040}"></fmt:formatNumber></td>                   <!--스텐드</td>    -  -->    
 				<td class="case7">  <fmt:formatNumber pattern="#,###" value="${result.rec_041}"></fmt:formatNumber></td>                   <!--체인커버</td>  -  -->     
                <td> <fmt:formatNumber pattern="#,###" value="${result.totCnt}"></fmt:formatNumber></td>  <!-- 정비건수</td> -->            <!--체인커버</td>  -  -->                                                                    
                <td> <fmt:formatNumber pattern="#,###" value="${result.totAmt}"></fmt:formatNumber></td>  <!-- 정비금액</td>  -->                                                              
				<%--  
				<td class="tc">${result.repairCnt}건</td>
				<td class="tc"><fmt:formatNumber pattern="#,###" value="${result.totPrice }"></fmt:formatNumber>원</td>
				 --%> 
			</tr>								
			</c:forEach>
			</tbody>
    </table>

</body>
</html>