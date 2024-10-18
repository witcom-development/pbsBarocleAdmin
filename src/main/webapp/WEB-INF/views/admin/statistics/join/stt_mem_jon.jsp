<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
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
			<tiles:insertAttribute name="header" />
		<!--모바일 메뉴 E-->
		<!--Head S-->
			<tiles:insertAttribute name="head" />
		<!--Head E-->
		<div id="body">
			<div class="cont">
				<!--left menu S-->
					<tiles:insertAttribute name="left" />
				<!--left menu E-->
				<!--content S-->
				<div class="content">
					<div class="subject">
						<p class="pageTitle">회원가입현황</p>
						<span>통계 &gt; <em>회원가입현황</em></span>
					</div>
					<div class="page">
						<!-- 모바일 검색조건 S-->
						<div class="shBox_m">
							<div class="downtitle">
								<div class="title">
									<p>검색조건</p><span><button><img src="/images/srh_open.png" alt="검색조건 열기" /></button></span>
								</div>
							</div>
						</div>
						<!-- 모바일 검색조건 E-->
						<!--검색조건 S-->
						<div class="shBox">
							<form id="searchFrm">
								<fieldset>
									<legend>검색 옵션</legend>
									<div class="shBoxSection">
										<div class="section">
											<label for="searchBgnDe" class="laType02">기간</label>
											<span>
												<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" id="searchBgnDe" name="searchBgnDe" readonly/></span>
												<span class="dash">~</span>
												<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" id="searchEndDe" name="searchEndDe" readonly/></span>
											</span>
										</div>
									</div>
								</fieldset>
							</form>
						</div>
						<!--검색조건 E-->
						<p class="tb_numlist"></p>
						<div class="widscr mt5">
						
						<p class="head2"><em>전체기간</em></p>
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
									<td style=""><fmt:formatNumber value="${memjoinList[0].totAgeTotal}" pattern="#,###" />		</td>
								</tr>
								
							</tbody>
						</table>
						</div>
						<p class="head2"><em>선택기간</em></p>
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
									<td style=""><fmt:formatNumber value="${memjoinList[0].searchAgeTotal}" pattern="#,###" />     </td>
								</tr>
								
							</tbody>
						</table>
						</div>
						</div>						
						
						<div class="btnArea">
							<span class="right"><button type="button" id="excelBtn" class="btnType01">엑셀다운로드</button></span>
						</div>
						
					</div>
				</div>
				<!--content E-->
			</div> 
		</div>
		<!--footer S-->
			<tiles:insertAttribute name="footer" />
		<!--footer E-->
	</div>
	
	<script type="text/javascript" src="/js/common_spb.js"></script>
    <script type="text/javascript">
   	$(function() {
		$('[name="searchBgnDe"]').val('${searchCondition.searchBgnDe}');
		$('[name="searchEndDe"]').val('${searchCondition.searchEndDe}');
		$('[name="userType"]').val('${searchCondition.userType}');
		
		$("#searchBtn").on("click", function(){
			$("#searchFrm").attr({method : 'post', action : '/join/joinStatistics.do'}).submit();
			fn_loading();
		});
		$("#excelBtn").on("click", function(){
			$("#searchFrm").attr({method : 'post', action : '/join/joinStatisticsExcel.do'}).submit();
		});
   	});
    </script>
</body>
</html>