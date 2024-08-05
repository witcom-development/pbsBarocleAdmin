<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page language="java" contentType="application/vnd.ms-excel;charset=euc-kr"  pageEncoding="UTF-8"%>
<%-- <%@ page language="java" contentType="application/vnd.word;charset=UTF-8" pageEncoding="UTF-8"%> --%>
<%-- <%@ page language="java" contentType="application/hwp;charset=UTF-8" pageEncoding="UTF-8"%> --%>
<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
    response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode("정비보고서.xls", "UTF-8"));
    /* response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode("정비보고서.doc", "UTF-8")); */
	/* response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode("정비보고서.hwp", "UTF-8")); */
    response.setHeader("Content-Description", "JSP Generated Data");
	
	Calendar cal = Calendar.getInstance();
	int minYear = 2010;
	int nowYear = cal.get(Calendar.YEAR);
	SimpleDateFormat sdf = new SimpleDateFormat("MM");
	String nowMonth = sdf.format(cal.getTime());
	sdf = new SimpleDateFormat("dd");
	String nowDay = sdf.format(cal.getTime());
%>
<!-- <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<title></title>
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
<h1 style="text-align:center;">(${ReportMallList.repairMonth })월 정비 보고서</h1>
    <div style="height:200px; width:1500px;text-align:center; margin-top:10px;">
    </div>
    <div>
        <table class="tb_condition">
            <tbody>
                <tr>
                	<td colspan="10" style="text-align:right;border:0px">관리번호 : ${ReportMallList.centerNo }호점</td>
                </tr>
                <tr>
                	<th colspan="2">점포명</th>
                	<td colspan="3" style="border:1px">${ReportMallList.centerName }</td>
                	<th colspan="2">대표자</th>
                	<td colspan="3" style="border:1px">${ReportMallList.takeName }</td>
                </tr>
                <tr>
                	<td colspan="10" style="text-align:left;">▣ 기    간 : ${ReportMallList.repairYear }. ${ReportMallList.repairMonth }
                	</td>
                </tr>
                <tr>
                	<td colspan="10" style="text-align:left;">▣ 정    산    내    역</td>
                </tr>
            </tbody>
        </table>
    </div>
    <table class="tb_type01" style="width : 10000px;">
        <thead>
            <tr>
                <th colspan="3">항목</th>
                <th>정비(건)</th>
                <th>금액(원)</th>
                <th colspan="3">항목</th>
                <th>정비(건)</th>
                <th>금액(원)</th>
            </tr>
        </thead>
        <tbody>
        	<tr>
        		<td colspan="3">기본교정</td>
        		<td style="mso-number-format:'\#\,\#\#'">${ReportMallList.rec_001}</td>
                <td style="mso-number-format:'\#\,\#\#'">${ReportMallList.price_001 }</td>
                
        		<td rowspan="3">조향부</td>
        		<td colspan="2">핸들스템</td>
        		<td style="mso-number-format:'\#\,\#\#'">${ReportMallList.rec_021}</td>
                <td style="mso-number-format:'\#\,\#\#'">${ReportMallList.price_021 }</td>
            </tr>
        	<tr>
        		<td rowspan="6">차체.시트부</td>
        		<td colspan="2">프레임</td>
        		<td style="mso-number-format:'\#\,\#\#'">${ReportMallList.rec_002}</td>
                <td style="mso-number-format:'\#\,\#\#'">${ReportMallList.price_002 }</td>
                
        		<td colspan="2">핸들바</td>
        		<td style="mso-number-format:'\#\,\#\#'">${ReportMallList.rec_022}</td>
                <td style="mso-number-format:'\#\,\#\#'">${ReportMallList.price_022 }</td>           
            </tr>
        	<tr>
        		<td colspan="2">포크</td>
        		<td style="mso-number-format:'\#\,\#\#'">${ReportMallList.rec_003}</td>
                <td style="mso-number-format:'\#\,\#\#'">${ReportMallList.price_003 }</td>
                
        		<td colspan="2">핸들그립</td>
        		<td style="mso-number-format:'\#\,\#\#'">${ReportMallList.rec_023}</td>
                <td style="mso-number-format:'\#\,\#\#'">${ReportMallList.price_023 }</td>
            </tr>
        	<tr>
        		<td colspan="2">안장</td>
        		<td style="mso-number-format:'\#\,\#\#'">${ReportMallList.rec_004}</td>
                <td style="mso-number-format:'\#\,\#\#'">${ReportMallList.price_004 }</td>

        		<td rowspan="4">구동부</td>
        		<td colspan="2">크랭크암</td>
        		<td style="mso-number-format:'\#\,\#\#'">${ReportMallList.rec_024}</td>
                <td style="mso-number-format:'\#\,\#\#'">${ReportMallList.price_024 }</td>
            </tr>
        	<tr>
        		<td colspan="2">싯포스트</td>
        		<td style="mso-number-format:'\#\,\#\#'">${ReportMallList.rec_005}</td>
                <td style="mso-number-format:'\#\,\#\#'">${ReportMallList.price_005 }</td>

        		<td colspan="2">바텀브래킷</td>
        		<td style="mso-number-format:'\#\,\#\#'">${ReportMallList.rec_025}</td>
                <td style="mso-number-format:'\#\,\#\#'">${ReportMallList.price_025 }</td>
            </tr>
        	<tr>
        		<td colspan="2">싯클램프</td>
        		<td style="mso-number-format:'\#\,\#\#'">${ReportMallList.rec_006}</td>
                <td style="mso-number-format:'\#\,\#\#'">${ReportMallList.price_006 }</td>

        		<td colspan="2">체인</td>
        		<td style="mso-number-format:'\#\,\#\#'">${ReportMallList.rec_026}</td>
                <td style="mso-number-format:'\#\,\#\#'">${ReportMallList.price_026 }</td>
            </tr>
        	<tr>
        		<td colspan="2">QR레버</td>
        		<td style="mso-number-format:'\#\,\#\#'">${ReportMallList.rec_007}</td>
                <td style="mso-number-format:'\#\,\#\#'">${ReportMallList.price_007 }</td>
                
        		<td colspan="2">페달</td>
        		<td style="mso-number-format:'\#\,\#\#'">${ReportMallList.rec_027}</td>
                <td style="mso-number-format:'\#\,\#\#'">${ReportMallList.price_027 }</td>
            </tr>
        	<tr>
        		<td rowspan="4">변속부</td>
        		<td colspan="2">변속레버</td>
        		<td style="mso-number-format:'\#\,\#\#'">${ReportMallList.rec_008}</td>
                <td style="mso-number-format:'\#\,\#\#'">${ReportMallList.price_008 }</td>

        		<td rowspan="6">제동부</td>
        		<td colspan="2">브레이크레버</td>
        		<td style="mso-number-format:'\#\,\#\#'">${ReportMallList.rec_028}</td>
                <td style="mso-number-format:'\#\,\#\#'">${ReportMallList.price_028 }</td>
            </tr>
        	<tr>
        		<td colspan="2">변속기</td>
        		<td style="mso-number-format:'\#\,\#\#'">${ReportMallList.rec_009}</td>
                <td style="mso-number-format:'\#\,\#\#'">${ReportMallList.price_009 }</td>

        		<td rowspan="3">앞</td>
        		<td>V브레이크</td>
        		<td style="mso-number-format:'\#\,\#\#'">${ReportMallList.rec_029}</td>
                <td style="mso-number-format:'\#\,\#\#'">${ReportMallList.price_029 }</td>
            </tr>
        	<tr>
        		<td colspan="2">변속기케이블</td>
        		<td style="mso-number-format:'\#\,\#\#'">${ReportMallList.rec_010}</td>
                <td style="mso-number-format:'\#\,\#\#'">${ReportMallList.price_010 }</td>

        		<td>브레이크케이블</td>
        		<td style="mso-number-format:'\#\,\#\#'">${ReportMallList.rec_030}</td>
                <td style="mso-number-format:'\#\,\#\#'">${ReportMallList.price_030 }</td>
            </tr>
        	<tr>
        		<td colspan="2">변속기보호대</td>
        		<td style="mso-number-format:'\#\,\#\#'">${ReportMallList.rec_011}</td>
                <td style="mso-number-format:'\#\,\#\#'">${ReportMallList.price_011 }</td>

        		<td>패드</td>
        		<td style="mso-number-format:'\#\,\#\#'">${ReportMallList.rec_031}</td>
                <td style="mso-number-format:'\#\,\#\#'">${ReportMallList.price_031 }</td>
            </tr>
        	<tr>
        		<td rowspan="9">주행부</td>
        		<td rowspan="4" >전륜</td>
        		<td>휠셋</td>
        		<td style="mso-number-format:'\#\,\#\#'">${ReportMallList.rec_012}</td>
                <td style="mso-number-format:'\#\,\#\#'">${ReportMallList.price_012 }</td>

        		<td rowspan="2">뒤</td>
        		<td>브레이크케이블</td>
        		<td style="mso-number-format:'\#\,\#\#'">${ReportMallList.rec_033}</td>
                <td style="mso-number-format:'\#\,\#\#'">${ReportMallList.price_033 }</td>
            </tr>
        	<tr>
        		<td>타이어</td>
        		<td style="mso-number-format:'\#\,\#\#'">${ReportMallList.rec_013}</td>
                <td style="mso-number-format:'\#\,\#\#'">${ReportMallList.price_013 }</td>
                
        		<td>롤브레이크</td>
        		<td style="mso-number-format:'\#\,\#\#'">${ReportMallList.rec_032}</td>
                <td style="mso-number-format:'\#\,\#\#'">${ReportMallList.price_032 }</td>
            </tr>
        	<tr>
        		<td>튜브</td>
        		<td style="mso-number-format:'\#\,\#\#'">${ReportMallList.rec_014}</td>
                <td style="mso-number-format:'\#\,\#\#'">${ReportMallList.price_014 }</td>

        		<td rowspan="8">기타부</td>
        		<td rowspan="2">전조등</td>
        		<td>구형</td>
        		<td style="mso-number-format:'\#\,\#\#'">${ReportMallList.rec_034}</td>
                <td style="mso-number-format:'\#\,\#\#'">${ReportMallList.price_034 }</td>
            </tr>
        	<tr>
        		<td>물받이</td>
        		<td style="mso-number-format:'\#\,\#\#'">${ReportMallList.rec_015}</td>
                <td style="mso-number-format:'\#\,\#\#'">${ReportMallList.price_015 }</td>

        		<td>신형</td>
        		<td style="mso-number-format:'\#\,\#\#'">${ReportMallList.rec_035}</td>
                <td style="mso-number-format:'\#\,\#\#'">${ReportMallList.price_035 }</td>
            </tr>
        	<tr>
        		<td rowspan="5">후륜</td>
        		<td>휠셋</td>
        		<td style="mso-number-format:'\#\,\#\#'">${ReportMallList.rec_016}</td>
                <td style="mso-number-format:'\#\,\#\#'">${ReportMallList.price_016 }</td>

        		<td colspan="2">다이나모케이블</td>
        		<td style="mso-number-format:'\#\,\#\#'">${ReportMallList.rec_036}</td>
                <td style="mso-number-format:'\#\,\#\#'">${ReportMallList.price_036 }</td>
            </tr>
        	<tr>
        		<td>타이터</td>
        		<td style="mso-number-format:'\#\,\#\#'">${ReportMallList.rec_017}</td>
                <td style="mso-number-format:'\#\,\#\#'">${ReportMallList.price_017 }</td>

        		<td colspan="2">후미등</td>
        		<td style="mso-number-format:'\#\,\#\#'">${ReportMallList.rec_037}</td>
                <td style="mso-number-format:'\#\,\#\#'">${ReportMallList.price_037 }</td>
            </tr>
        	<tr>
        		<td>튜브</td>
        		<td style="mso-number-format:'\#\,\#\#'">${ReportMallList.rec_018}</td>
                <td style="mso-number-format:'\#\,\#\#'">${ReportMallList.price_018 }</td>
                
        		<td colspan="2">벨</td>
        		<td style="mso-number-format:'\#\,\#\#'">${ReportMallList.rec_038}</td>
                <td style="mso-number-format:'\#\,\#\#'">${ReportMallList.price_038 }</td>
            </tr>
        	<tr>
        		<td>물받이(구형)</td>
        		<td style="mso-number-format:'\#\,\#\#'">${ReportMallList.rec_019}</td>
                <td style="mso-number-format:'\#\,\#\#'">${ReportMallList.price_019 }</td>

        		<td colspan="2">바구니</td>
        		<td style="mso-number-format:'\#\,\#\#'">${ReportMallList.rec_039}</td>
                <td style="mso-number-format:'\#\,\#\#'">${ReportMallList.price_039 }</td>
            </tr>
        	<tr>
        		<td>물받이(신형)</td>
        		<td style="mso-number-format:'\#\,\#\#'">${ReportMallList.rec_020}</td>
                <td style="mso-number-format:'\#\,\#\#'">${ReportMallList.price_020 }</td>
                
        		<td colspan="2">스탠드</td>
        		<td style="mso-number-format:'\#\,\#\#'">${ReportMallList.rec_040}</td>
                <td style="mso-number-format:'\#\,\#\#'">${ReportMallList.price_040 }</td>
            </tr>
        	<tr>
        		<td colspan="5"></td>
        		<td colspan="2">체인커버</td>
        		<td style="mso-number-format:'\#\,\#\#'">${ReportMallList.rec_041}</td>
                <td style="mso-number-format:'\#\,\#\#'">${ReportMallList.price_041 }</td>
            </tr>
            
        </tbody>
    </table>
    <table class="tb_condition">
	    <tr>
	    	<td colspan="2" style="text-align:right;"><h3>○ 정비건수 총 : </h3></td>
	    	<td style="text-align:right;"><h3>${ReportMallList.bikeCnt}</h3></td>
	    	<td><h3>대</h3></td>
	    	<td style="border:0px; mso-number-format:'\#\,\#\#'"><h3>=${ReportMallList.totCnt}
	    	</h3></td>
	    	
	    	<td><h3>건 합   계 : </h3></td>
	    	<td colspan="3" style="mso-number-format:'\#\,\#\#'"><h3>=${ReportMallList.price_001}+${ReportMallList.price_002}+${ReportMallList.price_003}+${ReportMallList.price_004}+${ReportMallList.price_005}
	    								+${ReportMallList.price_006}+${ReportMallList.price_007}+${ReportMallList.price_008}+${ReportMallList.price_009}+${ReportMallList.price_010}
	    								+${ReportMallList.price_011}+${ReportMallList.price_012}+${ReportMallList.price_013}+${ReportMallList.price_014}+${ReportMallList.price_015}
	    								+${ReportMallList.price_016}+${ReportMallList.price_017}+${ReportMallList.price_018}+${ReportMallList.price_019}+${ReportMallList.price_020}
	    								+${ReportMallList.price_021}+${ReportMallList.price_022}+${ReportMallList.price_023}+${ReportMallList.price_024}+${ReportMallList.price_025}
	    								+${ReportMallList.price_026}+${ReportMallList.price_027}+${ReportMallList.price_028}+${ReportMallList.price_029}+${ReportMallList.price_030}
	    								+${ReportMallList.price_031}+${ReportMallList.price_032}+${ReportMallList.price_033}+${ReportMallList.price_034}+${ReportMallList.price_035}
	    								+${ReportMallList.price_036}+${ReportMallList.price_037}+${ReportMallList.price_038}+${ReportMallList.price_039}+${ReportMallList.price_040}
	    								+${ReportMallList.price_041}
	    	</h3></td>
	    	<td><h3>원</h3></td>
	    </tr>
	    <tr><td colspan="10"><h3><%=nowYear%> 년&nbsp;<%=nowMonth %> 월&nbsp;<%=nowDay %> 일</h3></td></tr>
	    <tr><td colspan="10" style="text-align:right;"><h3>작 성 자 :  관리소 담당 (인)</h3></td></tr>
    </table>
</body>
</html>