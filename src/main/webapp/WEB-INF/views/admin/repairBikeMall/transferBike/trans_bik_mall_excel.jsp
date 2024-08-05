<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page language="java" contentType="application/vnd.ms-excel;charset=euc-kr"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
    response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode("인수인계증.xls", "UTF8"));
    response.setHeader("Content-Description", "JSP Generated Data");
    
    Calendar cal = Calendar.getInstance();
	int minYear = 2010;
	int nowYear = cal.get(Calendar.YEAR);
	SimpleDateFormat sdf = new SimpleDateFormat("MM");
	String nowMonth = sdf.format(cal.getTime());
	sdf = new SimpleDateFormat("dd");
	String nowDay = sdf.format(cal.getTime());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko">
<head>
<title></title>
<meta content="text/html; charset=KSC5601" http-equiv="content-type" />
<style>
.tb_type01 th {text-align:center;padding:5% 0;font-size:9px;}
.tb_type01 td {text-align:center;padding:5% 0}
.tb_type01 {width:100%;border:1px solid #e6e6e6;font-size:15px;table-layout:fixed}
.tb_type01 th {text-align:center;padding:15px 0;background:#eff5f8;border-top:2px solid #5e5e5e;border-right:1px solid #e6e6e6}
.tb_type01 td {text-align:center;padding:10px 2px;border:1px solid #e6e6e6}
.tb_type01 td.txRight {text-align:right;}
.tb_condition {width : 1200px}
.tb_condition th {text-align:center;padding:15px 0;}
.tb_condition th.condition {width:1200px;text-align:center;padding:15px 0; font-size: 27px;}
.tb_condition th.condition2 {width:1200px;text-align:center;padding:15px 0; font-size: 16px;}
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
                    <th class="condition" colspan="44">
                    	<img src="https://abc.bikeseoul.com/images/logo.png"/><label class="laType02">인수인계증</label>
                    </th>
                </tr>
                <tr>
                	<td>&lt;No. &gt;</td>
                	<td colspan="41"></td>
                	<td colspan=="2">[점포보관용]</td>
                </tr>
            </tbody>
        </table>
    </div>
    <table class="tb_type01" style="width : 1200px;">
        <thead>
            <tr>
                <th rowspan="3">연번</th>
                <th rowspan="3">자전거 번호</th>
                <th rowspan="3">기본교정</th>
                <th colspan="40">고&nbsp;장&nbsp;내&nbsp;역&nbsp;(해당항목에 "V" 표기)</th>
                <th rowspan="3">비&nbsp;&nbsp;&nbsp;고</th>
            </tr>
            <tr>
            	<th colspan="6">차체.시트부</th>
            	<th colspan="4">변속부</th>
            	<th colspan="9">주행부</th>
            	<th colspan="3">조향부</th>
            	<th colspan="4">구동부</th>
            	<th colspan="6">제도부</th>
            	<th colspan="8">기타</th>
            </tr>
            <tr>
				<th>프레임</th>
				<th>포크</th>
				<th>안장</th>
				<th>싯포스트</th>
				<th>싯클램프</th>
				<th>QR레버</th>
				<th>변속레버</th>
				<th>변속기</th>
				<th>케이블</th>
				<th>보호대</th>
				<th>전륜 휠셋</th>
				<th>전륜 타이어</th>
				<th>전륜 튜브</th>
				<th>전륜 물받이</th>
				<th>후륜 휠셋</th>
				<th>후륜 타이어</th>
				<th>후륜 튜브</th>
				<th>후륜 물받이(구형)</th>
				<th>후륜 물받이(신형)</th>
				<th>핸들스템</th>
				<th>핸들바</th>
				<th>핸들그립</th>
				<th>크랭크암</th>
				<th>바텀브래킷</th>
				<th>체인</th>
				<th>페달</th>
				<th>브레이크레버</th>
				<th>V브레이크(앞)</th>
				<th>케이블(앞)</th>
				<th>패드(앞)</th>
				<th>롤브레이크(뒤)</th>
				<th>케이블(뒤)</th>
				<th>전조등(구형)</th>
				<th>전조등(신형)</th>
				<th>다이나모 케이블</th>
				<th>후미등</th>
				<th>벨</th>
				<th>바구니</th>
				<th>스탠드</th>
				<th>체인커버</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="info" items="${TransBikeList}" varStatus="loop">
                <tr>
                    <td>${loop.count}</td>
                    <td>${info.bikeNo }</td>
                    <td><c:if test="${fn:contains(info.brokenType, 'REC_001') }">V</c:if></td>
                    <td><c:if test="${fn:contains(info.brokenType, 'REC_002') }">V</c:if></td>
                    <td><c:if test="${fn:contains(info.brokenType, 'REC_003') }">V</c:if></td>
                    <td><c:if test="${fn:contains(info.brokenType, 'REC_004') }">V</c:if></td>
                    <td><c:if test="${fn:contains(info.brokenType, 'REC_005') }">V</c:if></td>
                    <td><c:if test="${fn:contains(info.brokenType, 'REC_006') }">V</c:if></td>
                    <td><c:if test="${fn:contains(info.brokenType, 'REC_007') }">V</c:if></td>
                    <td><c:if test="${fn:contains(info.brokenType, 'REC_008') }">V</c:if></td>
                    <td><c:if test="${fn:contains(info.brokenType, 'REC_009') }">V</c:if></td>
                    <td><c:if test="${fn:contains(info.brokenType, 'REC_010') }">V</c:if></td>
                    <td><c:if test="${fn:contains(info.brokenType, 'REC_011') }">V</c:if></td>
                    <td><c:if test="${fn:contains(info.brokenType, 'REC_012') }">V</c:if></td>
                    <td><c:if test="${fn:contains(info.brokenType, 'REC_013') }">V</c:if></td>
                    <td><c:if test="${fn:contains(info.brokenType, 'REC_014') }">V</c:if></td>
                    <td><c:if test="${fn:contains(info.brokenType, 'REC_015') }">V</c:if></td>
                    <td><c:if test="${fn:contains(info.brokenType, 'REC_016') }">V</c:if></td>
                    <td><c:if test="${fn:contains(info.brokenType, 'REC_017') }">V</c:if></td>
                    <td><c:if test="${fn:contains(info.brokenType, 'REC_018') }">V</c:if></td>
                    <td><c:if test="${fn:contains(info.brokenType, 'REC_019') }">V</c:if></td>
                    <td><c:if test="${fn:contains(info.brokenType, 'REC_020') }">V</c:if></td>
                    <td><c:if test="${fn:contains(info.brokenType, 'REC_021') }">V</c:if></td>
                    <td><c:if test="${fn:contains(info.brokenType, 'REC_022') }">V</c:if></td>
                    <td><c:if test="${fn:contains(info.brokenType, 'REC_023') }">V</c:if></td>
                    <td><c:if test="${fn:contains(info.brokenType, 'REC_024') }">V</c:if></td>
                    <td><c:if test="${fn:contains(info.brokenType, 'REC_025') }">V</c:if></td>
                    <td><c:if test="${fn:contains(info.brokenType, 'REC_026') }">V</c:if></td>
                    <td><c:if test="${fn:contains(info.brokenType, 'REC_027') }">V</c:if></td>
                    <td><c:if test="${fn:contains(info.brokenType, 'REC_028') }">V</c:if></td>
                    <td><c:if test="${fn:contains(info.brokenType, 'REC_029') }">V</c:if></td>
                    <td><c:if test="${fn:contains(info.brokenType, 'REC_030') }">V</c:if></td>
                    <td><c:if test="${fn:contains(info.brokenType, 'REC_031') }">V</c:if></td>
                    <td><c:if test="${fn:contains(info.brokenType, 'REC_032') }">V</c:if></td>
                    <td><c:if test="${fn:contains(info.brokenType, 'REC_033') }">V</c:if></td>
                    <td><c:if test="${fn:contains(info.brokenType, 'REC_034') }">V</c:if></td>
                    <td><c:if test="${fn:contains(info.brokenType, 'REC_035') }">V</c:if></td>
                    <td><c:if test="${fn:contains(info.brokenType, 'REC_036') }">V</c:if></td>
                    <td><c:if test="${fn:contains(info.brokenType, 'REC_037') }">V</c:if></td>
                    <td><c:if test="${fn:contains(info.brokenType, 'REC_038') }">V</c:if></td>
                    <td><c:if test="${fn:contains(info.brokenType, 'REC_039') }">V</c:if></td>
                    <td><c:if test="${fn:contains(info.brokenType, 'REC_040') }">V</c:if></td>
                    <td><c:if test="${fn:contains(info.brokenType, 'REC_041') }">V</c:if></td>
                </tr>
            </c:forEach>
            <c:if test="${fn:length(TransBikeList) == 0 }">
                <tr><td colspan="43">no data</td></tr>
            </c:if>
        </tbody>
    </table>
    <div>※ 기본교정 항목 : 변속기, 체인, 브레이크, 핸들, 안장, 공기망 등 전반적인 점검 및 단순정비 포함</div>
    <table class="tb_condition">
    	<tbody>
                <tr>
                    <th class="condition2" colspan="21">
                    	상기 품목을 정히 인수·인계함<br>
                    	<%=nowYear%>&nbsp;년&nbsp;<%=nowMonth %>&nbsp;월&nbsp;<%=nowDay %>&nbsp;&nbsp;일<br>
                    	인계자 : 바로클&nbsp;${TransferBikeVo.adminId }&nbsp;&nbsp;(인)<br>
                    	인수자 : ${TransferBikeVo.centerName }&nbsp;${TransferBikeVo.adminName }&nbsp;&nbsp;(인)
                    </th>
                </tr>
        </tbody>
    </table>
</body>
</html>