<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%
	Calendar cal = Calendar.getInstance();
	cal.add(Calendar.MONTH, -1);
	int minYear = 2010;
	int nowYear = cal.get(Calendar.YEAR);
	SimpleDateFormat sdf = new SimpleDateFormat("MM");
	String nowMonth = sdf.format(cal.getTime());
	//sdf = new SimpleDateFormat("dd");
	//String nowDay = sdf.format(cal.getTime());
%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />
<meta name="description=" Content="" />
<tiles:insertAttribute name="resource" />
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
						<!--subject path S-->
						<tiles:insertAttribute name="subject" />
						<!--subject path E-->
					</div>
					<div class="page">
						<!-- 모바일 검색조건 S-->
						<div class="shBox_m">
							<div class="downtitle">
								<div class="title">
									<p>검색조건</p>
									<span><button>
											<img src="/images/srh_open.png" alt="검색조건 열기" />
										</button></span>
								</div>
							</div>
						</div>
						<!-- 모바일 검색조건 E-->
						<!--검색조건 S-->
						<form id="searchFrm">
							<div class="shBox">
								<!-- <input type="hidden" name="viewFlg" value="" /> -->
								<input type="hidden" name="dateType" />
								<input type="hidden" name="searchBgnMt" />
								<input type="hidden" name="searchEndMt" />
								<input type="hidden" name="searchBgnYe" />
								<input type="hidden" name="searchEndYe" />
								<fieldset>
								<legend>검색 옵션</legend>
									<div class="shBoxSection">
										<div class="section radbox">
											<label class="laType02">구분</label> 
											<span> 
												<span class="input-rd01"><input data-chn="daymth1" type="radio" id="month" name="dType" value="M" checked>
												<label for="month"> 월</label></span>
												<span class="input-rd01"><input data-chn="daymth1" type="radio" id="year" name="dType" value="Y" >
												<label for="year"> 연</label></span>
											</span>
										</div>
										<div class="section pright">
											<label for="bb22" class="laType02">월  / 연</label>
											<p class="daymth1">
												<select name="searchBgnYear">
													<%
														for (int i = minYear; i < (nowYear + 1); i++) {
													%>
													<option value="<%=i%>"><%=i%></option>
													<%
														}
													%>
												</select> 
												<span class="inputMt">
												<select name="searchBgnMonth">
													<option value="01">01</option>
													<option value="02">02</option>
													<option value="03">03</option>
													<option value="04">04</option>
													<option value="05">05</option>
													<option value="06">06</option>
													<option value="07">07</option>
													<option value="08">08</option>
													<option value="09">09</option>
													<option value="10">10</option>
													<option value="11">11</option>
													<option value="12">12</option>
												</select> 
												</span>
												<span class="dash">~</span> 
												<select name="searchEndYear">
													<%
														for (int i = minYear; i < (nowYear + 1); i++) {
													%>
													<option value="<%=i%>"><%=i%></option>
													<%
														}
													%>
												</select> 
												<span class="inputMt">
												<select name="searchEndMonth">
													<option value="01">01</option>
													<option value="02">02</option>
													<option value="03">03</option>
													<option value="04">04</option>
													<option value="05">05</option>
													<option value="06">06</option>
													<option value="07">07</option>
													<option value="08">08</option>
													<option value="09">09</option>
													<option value="10">10</option>
													<option value="11">11</option>
													<option value="12">12</option>
												</select>
												</span>
											</p>
											<button id="searchBtn" class="btn-srh03 btncase1">
												<img src="/images/searchIcon.gif" alt="검색" id="searchBtn">
											</button>
										</div>
									</div>
								</fieldset>
							</div>
							<div>
						    <div class="widscr mt5">
							<br>
							<h2>총 정비실적</h2>
							<br>
							<table class="tb_type01" style="min-width:1000px">
							<!--검색조건 E-->
								<thead>
									<tr>
									<%-- <c:if test=""> --%>
									    <th class="top text-center" rowspan="2">연</th>
									    <th class="top text-center" rowspan="2">월</th>
									<%-- <c:if test=""> --%>
									    <th class="top text-center" rowspan="2">기본점검(대수)</th>
									    <th class="top text-center" colspan="5">전륜</th>
									    <th class="top text-center" colspan="4">후륜</th>
									    <th class="top text-center" colspan="5">구동</th>
									    <th class="top text-center" colspan="3">케이블</th>
									    <th class="top text-center" colspan="3">중복</th>
									    <th class="top text-center" rowspan="2">계</th>
									</tr>
									<tr>
										<td class="tc">타이어</td>
										<td class="tc">펑크</td>
										<td class="tc">물받이</td>
										<td class="tc">V브레이크</td>
										<td class="tc">패드</td>
										<td class="tc">타이어</td>
										<td class="tc">펑크</td>
										<td class="tc">물받이</td>
										<td class="tc">롤러 브레이크</td>
										<td class="tc">체인</td>
										<td class="tc">스탠드</td>
										<td class="tc">페달</td>
										<td class="tc">B.B</td>
										<td class="tc">크랭크</td>
										<td class="tc">변속기</td>
										<td class="tc">(앞)브레이크</td>
										<td class="tc">(뒤)브레이크</td>
										<td class="tc">크랭크+B.B</td>
										<td class="tc">(앞)타이어+펑크</td>
										<td class="tc">(뒤)타이어+펑크</td>
									</tr>
								</thead>
								<tbody>
								<%--  <c:set var="prevDttm" value=""/>  --%>
									<c:forEach var="result" items="${ReportMallStt}" varStatus="status">
									<tr>
										<!-- <td class="text-center" rowspan="2" style="width:50px;"> -->
										<td class="tc">${result.repairYear}</td>
									    <td class="tc">${result.repairMonth}</td>
										<td class="tc">${result.rec_001}</td>
										<td class="tc">${result.rec_002}</td>
										<td class="tc">${result.rec_003}</td>
										<td class="tc">${result.rec_004}</td>
										<td class="tc">${result.rec_005}</td>
										<td class="tc">${result.rec_006}</td>
										<td class="tc">${result.rec_007}</td>
										<td class="tc">${result.rec_008}</td>
										<td class="tc">${result.rec_009}</td>
										<td class="tc">${result.rec_010}</td>
										<td class="tc">${result.rec_011}</td>
										<td class="tc">${result.rec_012}</td>
										<td class="tc">${result.rec_013}</td>
										<td class="tc">${result.rec_014}</td>
										<td class="tc">${result.rec_015}</td>
										<td class="tc">${result.rec_016}</td>
										<td class="tc">${result.rec_017}</td>
										<td class="tc">${result.rec_018}</td>
										<td class="tc">${result.rec_019}</td>
										<td class="tc">${result.rec_020}</td>
										<td class="tc">${result.rec_021}</td>
									</tr>
									<%-- <tr>
										<!-- <td class="tc">금액</td> -->
										<td class="tc">${result.price_001}</td>
										<td class="tc">${result.price_002}</td>
										<td class="tc">${result.price_003}</td>
										<td class="tc">${result.price_004}</td>
										<td class="tc">${result.price_005}</td>
										<td class="tc">${result.price_006}</td>
										<td class="tc">${result.price_007}</td>
										<td class="tc">${result.price_008}</td>
										<td class="tc">${result.price_009}</td>
										<td class="tc">${result.price_010}</td>
										<td class="tc">${result.price_011}</td>
										<td class="tc">${result.price_012}</td>
										<td class="tc">${result.price_013}</td>
										<td class="tc">${result.price_014}</td>
										<td class="tc">${result.price_015}</td>
										<td class="tc">${result.price_016}</td>
										<td class="tc">${result.price_017}</td>
										<td class="tc">${result.price_018}</td>
										<td class="tc">${result.price_019}</td>
										<td class="tc">${result.price_020}</td>
										<td class="tc">${result.price_021}</td>
									</tr> --%>
								</c:forEach> 
								<c:if test="${fn:length(ReportMallStt) eq 0  }">
									<table class="tb_type01 nbt0">
										<tr><td style="text-align:center"><spring:message code="search.nodata.msg" /></td></tr>
									</table>
								</c:if>
								</tbody>
							</table>
							<c:choose>
								<c:when test="${fn:length(ReportMallStt) > 0 }">
									<div class="drpaging"></div>
								</c:when>
								<c:otherwise>
									<div class="drpaging" style="display: none;"></div>
								</c:otherwise>
							</c:choose>
							</div>
						</form>
					</div>
					<!-- <div class="btnArea">
							<span class="right"><button type="button" id="excelBtn" class="btnType01">엑셀다운로드</button></span>
					</div> -->
				</div>
			</div>
			<!--content E-->
		</div>
	</div>
	<!--footer S-->
	<tiles:insertAttribute name="footer" />
	<!--footer E-->
	</div>

	<script type="text/javascript" src="/js/common_barocle.js"></script>
	<script type="text/javascript">
    $(function() {
    	reportMallStt.initBtn();

   		$('[name="searchBgnMonth"]').val('${searchCondition.searchBgnMt}');
		$('[name="searchEndMonth"]').val('${searchCondition.searchEndMt}');
		
		var dateType = '${searchCondition.dateType == null ? "M" : searchCondition.dateType}';
   		$('[name="dateType"]').val(dateType);
   		
   		if(dateType == "M"){
   			var searchBgnMt = '${searchCondition.searchBgnMt}';
   			var searchEndMt = '${searchCondition.searchEndMt}';
   			$('[name="searchBgnMt"]').val(searchBgnMt);
   			$('[name="searchEndMt"]').val(searchEndMt);
   			$('[name="searchBgnYear"]').val(searchBgnMt.substring(0,4));
   	   		$('[name="searchBgnMonth"]').val(searchBgnMt.substring(4,6));
   	   		$('[name="searchEndYear"]').val(searchEndMt.substring(0,4));
   	   		$('[name="searchEndMonth"]').val(searchEndMt.substring(4,6));
   		}else if(dateType == "Y"){
   			var searchBgnYe = '${searchCondition.searchBgnYe}';
   			var searchEndYe = '${searchCondition.searchEndYe}';
   			$('[name="searchBgnYe"]').val(searchBgnYe);
   			$('[name="searchEndYe"]').val(searchEndYe);
   			$('[name="searchBgnYear"]').val(searchBgnYe);
   	   		$('[name="searchEndYear"]').val(searchEndYe);
   		}
   		
   		if($('[name="dateType"]').val() == 'M'){
			$('.daymth1').css('display','inline-block');
   			$('#month').attr("checked", true);
   		}
   		if($('[name="dateType"]').val() == 'Y'){
   			$('.daymth1').css('display','inline-block');
   			$('.inputMt').css('display','none');
   			$('#year').attr("checked", true);
   		}
   		
   		$('[name="dType"]').on("click", function(){
   			if($(this).attr("id") == 'month'){
   				$('.daymth1').css('display','inline-block');
   				$('.inputMt').css('display','inline-block');
   	   			$('[name="searchBgnMt"]').val($('[name="searchBgnYear"]').val()+$('[name="searchBgnMonth"]').val());
   				$('[name="searchEndMt"]').val($('[name="searchEndYear"]').val()+$('[name="searchEndMonth"]').val());
   				$('[name="dateType"]').val('M');
   			}else if($(this).attr("id") == 'year'){
   				$('.daymth1').css('display','inline-block');
   				$('.inputMt').css('display','none');
   	   			$('[name="searchBgnYe"]').val($('[name="searchBgnYear"]').val());
   	   			$('[name="searchEndYe"]').val($('[name="searchEndYear"]').val());
   				$('[name="dateType"]').val('Y');
   			}
   		});
   		
   		$('[name="searchBgnYear"]').on('change', function(){
   			$('[name="searchBgnMt"]').val($('[name="searchBgnYear"]').val()+$('[name="searchBgnMonth"]').val());
   			$('[name="searchBgnYe"]').val($('[name="searchBgnYear"]').val());
   		});
   		$('[name="searchBgnMonth"]').on('change', function(){
   			$('[name="searchBgnMt"]').val($('[name="searchBgnYear"]').val()+$('[name="searchBgnMonth"]').val());
   		});
   		$('[name="searchEndYear"]').on('change', function(){
   			$('[name="searchEndMt"]').val($('[name="searchEndYear"]').val()+$('[name="searchEndMonth"]').val());
   			$('[name="searchEndYe"]').val($('[name="searchEndYear"]').val());
   		});
   		$('[name="searchEndMonth"]').on('change', function(){
   			$('[name="searchEndMt"]').val($('[name="searchEndYear"]').val()+$('[name="searchEndMonth"]').val());
   		}); 
   	});
   		
   	 var reportMallStt = {};

   	 reportMallStt.initBtn = function(){
     	$("#searchBtn").on("click",{listType: "list"},this.exeListFnc);
     	//$("#excelBtn").on("click",{listType: "list"},this.exeExcelFnc);
     } 
   	 reportMallStt.exeListFnc = function(e) {
		 //e.preventDefault();
		 //var listType = e.data.listType;
		if($("[name='searchBgnMt']").val() > $("[name='searchEndMt']").val()) {
	           alert('<spring:message code="fail.input.daterange"/>');
	           return false;
	   	}
		
		if($('[name="dateType"]').val() == 'Y'){
	   		if($("[name='searchBgnYe']").val() > $("[name='searchEndYe']").val()) {
	           	alert('<spring:message code="fail.input.daterange"/>');
	           	return false;
	   		}
		}
		if($('[name="dateType"]').val() == 'M'){
			if($("[name='searchBgnMt']").val() > $("[name='searchEndMt']").val()){
				alert('<spring:message code="fail.input.daterange"/>');
		    	return false;
		    }
		}	
         //$("[name='viewFlg']").val(listType);
         $("#searchFrm").attr({method : 'post', action : '/bikeMallRepairStt.do'}).submit();
     };

    </script>
</body>
</html>