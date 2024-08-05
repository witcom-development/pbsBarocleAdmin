<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" /> 
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />
<meta name="description=" Content="" />
<tiles:insertAttribute name="resource"/>

<script type = "text/javascript" src = "https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.min.js"></script>
<script type = "text/javascript" src = "https://html2canvas.hertzen.com/dist/html2canvas.min.js"></script>
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
									<p>검색조건</p><span><button><img src="/images/srh_open.png" alt="검색조건 열기" /></button></span>
								</div>
							</div>
						</div>
						<!-- 모바일 검색조건 E-->
						<!--검색조건 S-->
						<form id="searchFrm">
							<div class="shBox">
								<input type="hidden" name="viewFlg" value="" />
                                <input type="hidden" name="repairOursrcSeq" value="" />
                                <input type="hidden" name="adminId" value="" />
                                <input type="hidden" name="months" value="" />
                                <!-- 정비보고서 출력용 변수 -->
                                <input type="hidden" name="repairYear" value="" />
                                <input type="hidden" name="repairMonth" value="" />
                                <input type="hidden" name="takeId" value="" />
                                <!-- 내역통보 저장용 변수 -->
                                <input type="hidden" name="repairPrice" value="" />
                                <input type="hidden" name="bikeRepairNum" value="" />
                                <input type="hidden" name="msg" value="" />
                                <input type="hidden" name="destno" value="" />
                                
                                <%-- <input type="hidden" name="transId" value="<%= com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil.getSessionAttribute(request, "usrId") %>" /> --%>
								<fieldset>
									<legend>검색 옵션</legend>
									<div class="shBoxSection">
										<div class="section">
											<label for="bb22" class="laType02">등록일</label>
											<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" name="searchBgnDe" title="선택 날짜" id="bb22" readonly/></span>
											<span class="dash">~</span>
											<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" name="searchEndDe" title="선택 날짜" readonly/></span>
										</div>
										<div class="section pright">
											<label for="a11" class="laType02">점포명</label>
											<!-- 점포명으로 검색할 경우 등록일 선택 필수!! -->
											<select class="select-category02" name="centerId">
												<option value="">선택</option>
												<c:forEach var="bikeMall" items="${bikeMallList}" varStatus="status">
												<option value="${bikeMall.centerId}" <c:if test="${bikeMall.centerId eq searchCondition.centerId}">selected</c:if>>${bikeMall.centerName}</option>
												</c:forEach>
											</select>
											<button id="searchBtn" class="btn-srh03 btncase1"><img src="/images/searchIcon.gif" alt="검색" id="searchBtn"></button>
										</div>
									</div>
								</fieldset>
							</div>
						<input id="printPDF" style="float: right; padding: 10px; margin: 10px; background: green;" class="btnType01" onClick="printWindow();" value="PDF 다운로드"></button>	
						<button id="searchExcel" style="float: right; padding: 10px; margin: 10px; background: green;" class="btnType01">전체 실적 엑셀 다운로드</button>	
						<!--검색조건 E-->
						<table class="tb_type01 mt20">
							<colgroup>
								<col style="width:10%"/>
								<col style="width:30%"/>
								<col style="width:8.5%"/>
								<col style="width:10%"/>
								<col style="width:14.5%"/>
								<col style="width:14.5%"/>
								<col style="width:14.5%"/>
								<col style="width:11.5%"/>
							</colgroup>
							<thead>
								<tr>
									<th>해당년월</th>
									<th>점포명</th>
									<th>정비(건)</th>
									<th>단가(총합)</th>
									<th>보고서 출력</th>
									<th>내역통보(점주)</th>
									<th>내역통보날짜</th>
									<th>건별</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="result" items="${ReportMallList}" varStatus="status">
								<tr>
									<%-- <fmt:parseDate var="dateString" value="${result.regDttm }" pattern="yyyy-MM-ddHH:mm:ss" />
									<td class="tc"><fmt:formatDate value="${dateString}" pattern="yyyy-MM"/></td> --%>
									<td class="tc">${result.months}</td>
									<td class="tc">${result.centerName}</td>
									<td class="tc">${result.repairCnt}건</td>
									<td class="tc"><fmt:formatNumber pattern="#,###" value="${result.totPrice }"></fmt:formatNumber>원</td>
									<td class="tc"><button class="btnType02" id="btnPrint">보고서 출력</button></td>
									<td class="tc"><button class="btnType05" id="btnSendSms">내역통보</button></td>
									<td style="display: none;">${result.mpnNo}</td>
									<td style="display: none;">${result.adminId}</td>
									<fmt:parseDate var="dateString" value="${result.sendDttm }" pattern="yyyy-MM-ddHH:mm:ss" />
									<td class="tc"><fmt:formatDate value="${dateString}" pattern="MM-dd HH:mm"/></td>
									<td class="tc"><button class="btnType07" id="btnSendBike">건별</button></td>
								</tr>								
								</c:forEach>
								<c:if test="${fn:length(ReportMallList) eq 0 }">
									<table class="tb_type01 nbt0">
										<tr><td style="text-align:center"><spring:message code="search.nodata.msg" /></td></tr>
									</table>
								</c:if>
							</tbody>
						</table>  
						<c:choose>
						<c:when test="${fn:length(ReportMallList) > 0}">
							<div class="drpaging">
						</c:when>
						<c:otherwise>
							<div class="drpaging" style="display:none;">
						</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${paginationInfo.currentPageNo > 1}">
								<a id="prevPage" href="#"><img src="/images/p_prev.gif" alt="이전 페이지" /></a>
							</c:when>
							<c:otherwise>
								<a href="#"><img src="/images/p_prev.gif" alt="이전 페이지" /></a>
							</c:otherwise>
						</c:choose>
						<span><input name="currentPageNo" type="number" value="${paginationInfo.currentPageNo}"/><em>/ ${paginationInfo.totalPageCount}</em><button id="movePage">이동</button></span>
						<c:choose>
							<c:when test="${paginationInfo.currentPageNo < paginationInfo.totalPageCount}">
							<a id="nextPage" href="#"><img src="/images/p_next.gif" alt="다음 페이지" /></a>
							</c:when>
							<c:otherwise>
								<a href="#"><img src="/images/p_next.gif" alt="다음 페이지" /></a>
							</c:otherwise>
						</c:choose>
						</form>
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
	
	<script type="text/javascript" src="/js/common_barocle.js"></script>
    <script type="text/javascript">
    $(function() {
   		reportMallList.initBtn();
		
   		var transBikeList = {};
		var totalPageCount = '${paginationInfo.totalPageCount}' == '' ? 1 : Number('${paginationInfo.totalPageCount}');
   		$('#prevPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			transBikeList.pageSelect(currentPageNo-1);
		});
		$('#nextPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			transBikeList.pageSelect(currentPageNo+1);
		});
		$('#movePage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			var regExp = /^[1-9]?[0-9]/;
			if(!regExp.test(currentPageNo) ||(totalPageCount < currentPageNo)){
				alert('현재 페이지 값이 정상적이지 않습니다.');
			}else{
				transBikeList.pageSelect(currentPageNo);
			}
		});
		transBikeList.pageSelect = function(pageNo) {
	    	$("[name='currentPageNo']").val(pageNo);
	    	$("[name='viewFlg']").val('list');
	    	$("#searchFrm").attr({method : 'post', action : '/bikeMallReportAdmin.do'}).submit();
	    };		
		
		
	
		
		
		$(".btnType05").click(function(){ 	/// 내역통보 문자 전송
	    	var hpno = $(this).parent().next().text();
			var month = $(this).parent().prev().prev().prev().prev().prev().text().substring(5);
			var mallName = $(this).parent().prev().prev().prev().prev().text();
			var repairCnt = $(this).parent().prev().prev().prev().text();
			var totCnt = $(this).parent().prev().prev().text();
			var adminId = $(this).parent().next().next().text();
	    	var msg = "바로클포 "+month+"월 정비내역 안내\n점포명 : "+mallName+"\n정비건수 : "+repairCnt+"\n수리비용 지급 :  "+totCnt;
	    	
	    	month = $(this).parent().prev().prev().prev().prev().prev().text();
	    	
	    	/* $("[name='destno']").val(hpno);
			$("[name='months']").val(month);
			$("[name='adminId']").val(adminId);
			$("[name='bikeRepairNum']").val(repairCnt);
			$("[name='repairPrice']").val(totCnt);
			$("[name='msg']").val(msg); */
	    		    	
	    	if(confirm(msg+"\n\n해당 메세지를 전송하시겠습니까?")){
		    	$.ajax({
					url : "/sendRepMonthReport.do",
					type : "post",
					dataType : "json",
					data : {msg:msg, destno:hpno, adminId:adminId, months:month, bikeRepairNum:repairCnt, repairPrice:totCnt},
					/* data : $("#searchFrm").serialize(), */
					async : false,
			   		beforeSubmit: function (data,form,option) {
						return true;
					},
					success : function(data){
						if(data.resultMessage == "Success"){
							alert(mallName+"\n내역통보 완료 되었습니다.");
							location.reload();
						}
					},
					error : function(jqXHR, textStatus,errorThrown){
						if(jqXHR.status === 500 || jqXHR.status === 200){
							alert("에러가 발생했습니다. : " + textStatus);
						}
					}
				});
	    	}
		});
		
		$(".btnType02").click(function(){ 	/// 보고서 출력
			var repairYear = $(this).parent().prev().prev().prev().prev().text().substring(0,4);
			var repairMonth = $(this).parent().prev().prev().prev().prev().text().substring(5);
			var takeId = $(this).parent().next().next().next().text();
			
			$("[name='repairYear']").val(repairYear);
			$("[name='repairMonth']").val(repairMonth);
			$("[name='takeId']").val(takeId);
				
			$("#searchFrm").attr({method : 'post', action : '/bikeMallReportExcel.do'}).submit();
			
		});
		
		// 건별 실적
		$(".btnType07").click(function(){ 	/// 보고서 출력
			
			// 현재 클릭된 Row(<tr>)
			var tr = $(this).parent().parent();
			var td = tr.children();
				
			// tr.text()는 클릭된 Row 즉 tr에 있는 모든 값을 가져온다.
			var repairYear = td.eq(0).text().substring(0,4);
			var repairMonth = td.eq(0).text().substring(6,7);
			var takeId = td.eq(7).text();
			$("[name='repairYear']").val(repairYear);
			$("[name='repairMonth']").val(repairMonth);
			$("[name='takeId']").val(takeId);
			$("#searchFrm").attr({method : 'post', action : '/bikeMallReportBikeExcel.do'}).submit();
		});
		
		$("#searchExcel").click(function(){ 	/// 보고서 출력
		//	$("[name='repairYear']").val(repairYear);
		//	$("[name='repairMonth']").val(repairMonth);
			$("#searchFrm").attr({method : 'post', action : '/bikeMallReportExcelAdmin.do'}).submit();
		});
	});
    
	var reportMallList = {};
    
	reportMallList.initBtn = function(){
		var date = new Date;
		date.setDate(date.getDate()-6);
		var fromday = DateUtil.dateFmt(date);
		var today = DateUtil.dateFmt(new Date());
		var sDate = '${searchCondition.searchBgnDe}' !== '' ? '${searchCondition.searchBgnDe}' : fromday;
		var eDate = '${searchCondition.searchEndDe}' !== '' ? '${searchCondition.searchEndDe}' : today;
		
		$("[name='searchBgnDe']").val(sDate);
		$("[name='searchEndDe']").val(eDate);
		
    	$("#searchBtn").on("click",{listType: "list"},this.exeListFnc);
    	//$("#btnPrint").on("click", this.exePrintReportFnc);
    	//$("#btnSendSms").on("click", this.exeSendSmsFnc);
    }
    
	reportMallList.exeListFnc = function(e) {
        e.preventDefault();
        var listType = e.data.listType;

        if($("[name='searchBgnDe']").val() != '' && $( "[name='searchEndDe']").val() != ''){
	        if(DateUtil.checkDateTerm( $( "[name='searchBgnDe']").val(),  $( "[name='searchEndDe']").val()) != 'ok') {
	            alert('<spring:message code="fail.input.daterange"/>');
	            return false;
	        }
	        if(DateUtil.diffDays( $("[name='searchBgnDe']").val(),  $("[name='searchEndDe']").val(), '-') >= 365){
	    		alert("조회기간은  1년 이내로 설정해주세요.");
	    		return false;
	    	} 
        }

        $("[name='currentPageNo']").val(1);
        
        $("[name='viewFlg']").val(listType);
        $("#searchFrm").attr({method : 'post', action : '/bikeMallReportAdmin.do'}).submit();
    };
    
    reportMallList.pageSelect = function(pageNo) {
    	$("[name='currentPageNo']").val(pageNo);
    	$("[name='viewFlg']").val('list');
    	$("#searchFrm").attr({action :'/bikeMallReportAdmin.do', method : 'post'}).submit();
    };
    
    reportMallList.exeUdtInfoFnc = function(e) {
    	
    	e.preventDefault();
    	var udtFlag = e.data.flag;
    	var seq = "";
    	// var transId = $("[name='transId']").val();
    	
    	if(udtFlag === 'trans') {
    		seq = $(this).parent().prev().prev().prev().text();
    	}else{
    		seq = $(this).parent().prev().prev().prev().prev().prev().prev().prev().text();
    	}
    	$("[name='viewFlg']").val(udtFlag);
    	
    	//$("#searchFrm").attr({method : 'post', action : '/moveTransferBikeEditForm.do'}).submit();
    	$.ajax({
			url : "/checkTransferBikeAjax.do",
			type : "post",
			dataType : "json",
			data : {viewFlg:udtFlag,repairOursrcSeq:seq},
			async : false,
	   		beforeSubmit: function (data,form,option) {
				return true;
			},
			success : function(data){
				if(data.resultMessage == "Success"){
					alert("인수(인계)가 완료되었습니다.");
					location.reload();
				}
			},
			error : function(jqXHR, textStatus,errorThrown){
				if(jqXHR.status === 500 || jqXHR.status === 200){
					alert("에러가 발생했습니다. : " + textStatus);
				}
			}
		});
    	
    }    
    
    
 // 숫자 타입에서 쓸 수 있도록 format() 함수 추가
    Number.prototype.format = function(){
        if(this==0) return 0;

        var reg = /(^[+-]?\d+)(\d{3})/;
        var n = (this + '');

        while (reg.test(n)) n = n.replace(reg, '$1' + ',' + '$2');

        return n;
    };

    // 문자열 타입에서 쓸 수 있도록 format() 함수 추가
    String.prototype.format = function(){
        var num = parseInt(this);
        if( isNaN(num) ) return "0";

        return num.format();
    };
    
    </script>

	<div id="pdf_wrap">
	<img src="/images/logo.png" alt="아파트 자전거 공공">
			<div class="header"> 
	 	    	<h1 style="text-align:center;"><span class='month'>4</span>월 정비 보고서</h1>
		        <div style="text-align:right">관리번호:<span class='centerNo'></span></div>
	 	    </div>
		    <div class="subheader">
			    <span class="column20">점포명</span><span class="column30" id='centerName'>테스트 점포</span>
			    <span class="column20">대표자</span><span class="column30" id='takeName'>테트스 대표자</span>
			 </div>
			 
			 <div class="row">
			 
				 <table class="tb_type01" style="width : 100%;">
			        <thead>
			            <tr>
			                    <th width="24%" colspan="3">항목</th>
				                <th width="8%">정비(건)</th>
				                <th width="12%">금액(원)</th>
				                <th colspan="3">항목</th>
				                <th>정비(건)</th>
				                <th>금액(원)</th>
			            </tr>
			        </thead>
			        <tbody>
			        	<tr>
			        		<td colspan="3">기본교정</td>
			        		<td style="text-align: right" class="rec_001"></td>
			                <td  style="text-align: right" class="price_001"></td>
			                
			        		<td rowspan="3">조향부</td>
			        		<td colspan="2">핸들스템</td>
			        		<td style="text-align: right" class="rec_021"></td>
			                <td  style="text-align: right" class="price_021"></td>
			        	</tr>
			        	<tr>
			        		<td rowspan="6">차체.시트부</td>
			        		<td colspan="2">프레임</td>
			        		<td style="text-align: right" class="rec_002"></td>
			                <td  style="text-align: right" class="price_002"></td>
			                
			        		<td colspan="2">핸들바</td>
			        		<td style="text-align: right" class="rec_022"></td>
			                <td  style="text-align: right" class="price_022"></td>          
			            </tr>
			        	<tr>
			        		<td colspan="2">포크</td>
			        		<td style="text-align: right" class="rec_003"></td>
			                <td  style="text-align: right" class="price_003"></td>
			        		<td colspan="2">핸들그립</td>
			        		<td style="text-align: right" class="rec_023"></td>
			                <td  style="text-align: right" class="price_023"></td>
			            </tr>
			            <tr>
			        		<td colspan="2">안장</td>
			        		<td style="text-align: right" class="rec_004"></td>
			                <td  style="text-align: right" class="price_004"></td>
			
			        		<td rowspan="4">구동부</td>
			        		<td colspan="2">크랭크암</td>
			        		<td style="text-align: right" class="rec_024"></td>
			                <td  style="text-align: right" class="price_024"></td>
			            </tr>
			        	<tr>
			        		<td colspan="2">싯포스트</td>
			        		<td style="text-align: right" class="rec_005"></td>
			                <td  style="text-align: right" class="price_005"></td>
			
			        		<td colspan="2">바텀브래킷</td>
			        		<td style="text-align: right" class="rec_025"></td>
			                <td  style="text-align: right" class="price_025"></td>
			            </tr>
			        	<tr>
			        		<td colspan="2">싯클램프</td>
			        		<td style="text-align: right" class="rec_006"></td>
			                <td  style="text-align: right" class="price_006"></td>
			
			        		<td colspan="2">체인</td>
			        		<td style="text-align: right" class="rec_026"></td>
			                <td  style="text-align: right" class="price_026"></td>
			            </tr>
			        	<tr>
			        		<td colspan="2">QR레버</td>
			        		<td style="text-align: right" class="rec_007"></td>
			                <td  style="text-align: right" class="price_007"></td>
			                
			        		<td colspan="2">페달</td>
			        		<td style="text-align: right" class="rec_027"></td>
			                <td  style="text-align: right" class="price_027"></td>
			            </tr>
			        	<tr>
			        		<td rowspan="4">변속부</td>
			        		<td colspan="2">변속레버</td>
			        		<td style="text-align: right" class="rec_008"></td>
			                <td  style="text-align: right" class="price_008"></td>
			
			        		<td rowspan="6">제동부</td>
			        		<td colspan="2">브레이크레버</td>
			        		<td style="text-align: right" class="rec_028"></td>
			                <td  style="text-align: right" class="price_028"></td>
			            </tr>
			        	<tr>
			        		<td colspan="2">변속기</td>
			        		<td style="text-align: right" class="rec_009"></td>
			                <td  style="text-align: right" class="price_009"></td>
			
			        		<td rowspan="3">앞</td>
			        		<td>V브레이크</td>
			        		<td style="text-align: right" class="rec_029"></td>
			                <td  style="text-align: right" class="price_029"></td>
			            </tr>
			        	<tr>
			        		<td colspan="2">변속기케이블</td>
			        		<td style="text-align: right" class="rec_010"></td>
			                <td  style="text-align: right" class="price_010"></td>
			
			        		<td>브레이크케이블</td>
			        		<td style="text-align: right" class="rec_030"></td>
			                <td  style="text-align: right" class="price_030"></td>
			            </tr>
			        	<tr>
			        		<td colspan="2">변속기보호대</td>
			        		<td style="text-align: right" class="rec_011"></td>
			                <td  style="text-align: right" class="price_011"></td>
			
			        		<td>패드</td>
			        		<td style="text-align: right" class="rec_031"></td>
			                <td  style="text-align: right" class="price_031"></td>
			            </tr>
			        	<tr>
			        		<td rowspan="9">주행부</td>
			        		<td rowspan="4" >전륜</td>
			        		<td>휠셋</td>
			        		<td style="text-align: right" class="rec_012"></td>
			                <td  style="text-align: right" class="price_012"></td>
			
			        		<td rowspan="2">뒤</td>
			        		<td>브레이크케이블</td>
			        		<td style="text-align: right" class="rec_033"></td>
			                <td  style="text-align: right" class="price_033"></td>
			            </tr>
			        	<tr>
			        		<td>타이어</td>
			        		<td style="text-align: right" class="rec_013"></td>
			                <td  style="text-align: right" class="price_013"></td>
			                
			        		<td>롤브레이크</td>
			        		<td style="text-align: right" class="rec_032"></td>
			                <td  style="text-align: right" class="price_032"></td>
			            </tr>
			        	<tr>
			        		<td>튜브</td>
			        		<td style="text-align: right" class="rec_014"></td>
			                <td  style="text-align: right" class="price_014"></td>
			
			        		<td rowspan="8">기타부</td>
			        		<td rowspan="2">전조등</td>
			        		<td>구형</td>
			        		<td style="text-align: right" class="rec_034"></td>
			                <td  style="text-align: right" class="price_034"></td>
			            </tr>
			        	<tr>
			        		<td>물받이</td>
			        		<td style="text-align: right" class="rec_015"></td>
			                <td  style="text-align: right" class="price_015"></td>
			
			        		<td>신형</td>
			        		<td style="text-align: right" class="rec_035"></td>
			                <td  style="text-align: right" class="price_035"></td>
			            </tr>
			        	<tr>
			        		<td rowspan="5">후륜</td>
			        		<td>휠셋</td>
			        		<td style="text-align: right" class="rec_016"></td>
			                <td  style="text-align: right" class="price_016"></td>
			
			        		<td colspan="2">다이나모케이블</td>
			        		<td style="text-align: right" class="rec_036"></td>
			                <td  style="text-align: right" class="price_036"></td>
			            </tr>
			        	<tr>
			        		<td>타이터</td>
			        		<td style="text-align: right" class="rec_017"></td>
			                <td  style="text-align: right" class="price_017"></td>
			
			        		<td colspan="2">후미등</td>
			        		<td style="text-align: right" class="rec_037"></td>
			                <td  style="text-align: right" class="price_037"></td>
			            </tr>
			        	<tr>
			        		<td>튜브</td>
			        		<td style="text-align: right" class="rec_018"></td>
			                <td  style="text-align: right" class="price_018"></td>
			                
			        		<td colspan="2">벨</td>
			        		<td style="text-align: right" class="rec_038"></td>
			                <td  style="text-align: right" class="price_038"></td>
			            </tr>
			        	<tr>
			        		<td>물받이(구형)</td>
			        		<td style="text-align: right" class="rec_019"></td>
			                <td  style="text-align: right" class="price_019"></td>
			
			        		<td colspan="2">바구니</td>
			        		<td style="text-align: right" class="rec_039"></td>
			                <td  style="text-align: right" class="price_039"></td>
			            </tr>
			        	<tr>
			        		<td>물받이(신형)</td>
			        		<td style="text-align: right" class="rec_020"></td>
			                <td  style="text-align: right" class="price_020"></td>
			                
			        		<td colspan="2">스탠드</td>
			        		<td style="text-align: right" class="rec_040"></td>
			                <td  style="text-align: right" class="price_040"></td>
			            </tr>
			        	<tr>
			        		<td colspan="5"></td>
			        		<td colspan="2">체인커버</td>
			        		<td style="text-align: right" class="rec_041"></td>
			                <td  style="text-align: right" class="price_041"></td>
			            </tr>
			            
			        </tbody>
		        </table>	
			 </div>
			 
			  <div class="footerTop">
			 	<div style="width: 48%">
			 		<div>○ 정비건수 총 </div><div id='bikeCnt'></div><div id='totCnt'></div>
			 	</div>
			 	<div style="width: 48%">
			 		<div> 합   계 :</div><div id='totAmt'></div>
			 	</div>
			 </div> 
			 <hr/>
			 <div class="footer"">
				
				 <h3 class="writeDate" style="text-align: center; padding-top:30px">2021-04</h3>   
				 <h3  style="text-align: right; padding-right:50px;">작 성 자 :  관리소 담당  <span class="takeName"></span>(인)</h3>
			 </div>
			 
    </div> 
     
     

<script>


function savePDF(centerName){
	html2canvas($('#pdf_wrap')[0]).then(function(canvas) {
	      var doc = new jsPDF('p', 'mm', 'a4'); //jspdf객체 생성
	      var imgData = canvas.toDataURL('image/png'); //캔버스를 이미지로 변환
	      doc.addImage(imgData, 'PNG', 0, 0); //이미지를 기반으로 pdf생성
	      doc.save( centerName + '.pdf'); //pdf저장
	    });
}

function printWindow() {
	
	if( !confirm("다운로드에 시간이 걸립니다. 진행하시겠습니까?")) return;
	
	 //pdf_wrap을 canvas객체로 변환
		var repairYear = $("[name='searchBgnDe']").val().substring(0,4);
		var repairMonth = $("[name='searchBgnDe']").val().substring(5);
		
		$("[name='repairYear']").val(repairYear);
		$("[name='repairMonth']").val(repairMonth);
		  
		<c:forEach var="result" items="${ReportMallList}" varStatus="status">
		  	//setTimeout(function(){
				$("[name='takeId']").val('${result.adminId}');
			  	$.ajax({
			   		type : "post",
			   		async: false,
			   		url : "/bikeMallReportPDF.do",
			   		data :  $("#searchFrm").serialize(),
			   		success : function(data){
			   			
			   			$("#pdf_wrap .month").html(repairMonth.substring(0,2));
			   			$("#pdf_wrap .centerNo").html(data.ReportMallList.centerNo);
			   			$("#pdf_wrap #centerName").html(data.ReportMallList.centerName);
			   			$("#pdf_wrap #takeName").html(data.ReportMallList.takeName);
			   			
			   			$("#pdf_wrap .rec_001").html(data.ReportMallList.rec_001);
			   			$("#pdf_wrap .rec_002").html(data.ReportMallList.rec_002);
			   			$("#pdf_wrap .rec_003").html(data.ReportMallList.rec_003);
			   			$("#pdf_wrap .rec_004").html(data.ReportMallList.rec_004);
			   			$("#pdf_wrap .rec_005").html(data.ReportMallList.rec_005);
			   			$("#pdf_wrap .rec_006").html(data.ReportMallList.rec_006);
			   			$("#pdf_wrap .rec_007").html(data.ReportMallList.rec_007);
			   			$("#pdf_wrap .rec_008").html(data.ReportMallList.rec_008);
			   			$("#pdf_wrap .rec_009").html(data.ReportMallList.rec_009);
			   			$("#pdf_wrap .rec_010").html(data.ReportMallList.rec_010);
			   			$("#pdf_wrap .rec_011").html(data.ReportMallList.rec_011);
			   			$("#pdf_wrap .rec_012").html(data.ReportMallList.rec_012);
			   			$("#pdf_wrap .rec_013").html(data.ReportMallList.rec_013);
			   			$("#pdf_wrap .rec_014").html(data.ReportMallList.rec_014);
			   			$("#pdf_wrap .rec_015").html(data.ReportMallList.rec_015);
			   			$("#pdf_wrap .rec_016").html(data.ReportMallList.rec_016);
			   			$("#pdf_wrap .rec_017").html(data.ReportMallList.rec_017);
			   			$("#pdf_wrap .rec_018").html(data.ReportMallList.rec_018);
			   			$("#pdf_wrap .rec_019").html(data.ReportMallList.rec_019);
			   			$("#pdf_wrap .rec_020").html(data.ReportMallList.rec_020);
			   			$("#pdf_wrap .rec_021").html(data.ReportMallList.rec_021);
			   			$("#pdf_wrap .rec_022").html(data.ReportMallList.rec_022);
			   			$("#pdf_wrap .rec_023").html(data.ReportMallList.rec_023);
			   			$("#pdf_wrap .rec_024").html(data.ReportMallList.rec_024);
			   			$("#pdf_wrap .rec_025").html(data.ReportMallList.rec_025);
			   			$("#pdf_wrap .rec_026").html(data.ReportMallList.rec_026);
			   			$("#pdf_wrap .rec_027").html(data.ReportMallList.rec_027);
			   			$("#pdf_wrap .rec_028").html(data.ReportMallList.rec_028);
			   			$("#pdf_wrap .rec_029").html(data.ReportMallList.rec_029);
			   			$("#pdf_wrap .rec_030").html(data.ReportMallList.rec_030);
			   			$("#pdf_wrap .rec_031").html(data.ReportMallList.rec_031);
			   			$("#pdf_wrap .rec_032").html(data.ReportMallList.rec_032);
			   			$("#pdf_wrap .rec_033").html(data.ReportMallList.rec_033);
			   			$("#pdf_wrap .rec_034").html(data.ReportMallList.rec_034);
			   			$("#pdf_wrap .rec_035").html(data.ReportMallList.rec_035);
			   			$("#pdf_wrap .rec_036").html(data.ReportMallList.rec_036);
			   			$("#pdf_wrap .rec_037").html(data.ReportMallList.rec_037);
			   			$("#pdf_wrap .rec_038").html(data.ReportMallList.rec_038);
			   			$("#pdf_wrap .rec_039").html(data.ReportMallList.rec_039);
			   			$("#pdf_wrap .rec_040").html(data.ReportMallList.rec_040);
			   			$("#pdf_wrap .rec_041").html(data.ReportMallList.rec_041);

			   			$("#pdf_wrap .price_001").html(parseInt(data.ReportMallList.price_001).format());
			   			$("#pdf_wrap .price_002").html(parseInt(data.ReportMallList.price_002).format());   
			   			$("#pdf_wrap .price_003").html(parseInt(data.ReportMallList.price_003).format());   
			   			$("#pdf_wrap .price_004").html(parseInt(data.ReportMallList.price_004).format());   
			   			$("#pdf_wrap .price_005").html(parseInt(data.ReportMallList.price_005).format());   
			   			$("#pdf_wrap .price_006").html(parseInt(data.ReportMallList.price_006).format());   
			   			$("#pdf_wrap .price_007").html(parseInt(data.ReportMallList.price_007).format());   
			   			$("#pdf_wrap .price_008").html(parseInt(data.ReportMallList.price_008).format());   
			   			$("#pdf_wrap .price_009").html(parseInt(data.ReportMallList.price_009).format());   
			   			$("#pdf_wrap .price_010").html(parseInt(data.ReportMallList.price_010).format());   
			   			$("#pdf_wrap .price_011").html(parseInt(data.ReportMallList.price_011).format());   
			   			$("#pdf_wrap .price_012").html(parseInt(data.ReportMallList.price_012).format());   
			   			$("#pdf_wrap .price_013").html(parseInt(data.ReportMallList.price_013).format());   
			   			$("#pdf_wrap .price_014").html(parseInt(data.ReportMallList.price_014).format());   
			   			$("#pdf_wrap .price_015").html(parseInt(data.ReportMallList.price_015).format());   
			   			$("#pdf_wrap .price_016").html(parseInt(data.ReportMallList.price_016).format());   
			   			$("#pdf_wrap .price_017").html(parseInt(data.ReportMallList.price_017).format());   
			   			$("#pdf_wrap .price_018").html(parseInt(data.ReportMallList.price_018).format());   
			   			$("#pdf_wrap .price_019").html(parseInt(data.ReportMallList.price_019).format());   
			   			$("#pdf_wrap .price_020").html(parseInt(data.ReportMallList.price_020).format());   
			   			$("#pdf_wrap .price_021").html(parseInt(data.ReportMallList.price_021).format());   
			   			$("#pdf_wrap .price_022").html(parseInt(data.ReportMallList.price_022).format());   
			   			$("#pdf_wrap .price_023").html(parseInt(data.ReportMallList.price_023).format());   
			   			$("#pdf_wrap .price_024").html(parseInt(data.ReportMallList.price_024).format());   
			   			$("#pdf_wrap .price_025").html(parseInt(data.ReportMallList.price_025).format());   
			   			$("#pdf_wrap .price_026").html(parseInt(data.ReportMallList.price_026).format());   
			   			$("#pdf_wrap .price_027").html(parseInt(data.ReportMallList.price_027).format());   
			   			$("#pdf_wrap .price_028").html(parseInt(data.ReportMallList.price_028).format());   
			   			$("#pdf_wrap .price_029").html(parseInt(data.ReportMallList.price_029).format());   
			   			$("#pdf_wrap .price_030").html(parseInt(data.ReportMallList.price_030).format());   
			   			$("#pdf_wrap .price_031").html(parseInt(data.ReportMallList.price_031).format());   
			   			$("#pdf_wrap .price_032").html(parseInt(data.ReportMallList.price_032).format());   
			   			$("#pdf_wrap .price_033").html(parseInt(data.ReportMallList.price_033).format());   
			   			$("#pdf_wrap .price_034").html(parseInt(data.ReportMallList.price_034).format());   
			   			$("#pdf_wrap .price_035").html(parseInt(data.ReportMallList.price_035).format());   
			   			$("#pdf_wrap .price_036").html(parseInt(data.ReportMallList.price_036).format());   
			   			$("#pdf_wrap .price_037").html(parseInt(data.ReportMallList.price_037).format());   
			   			$("#pdf_wrap .price_038").html(parseInt(data.ReportMallList.price_038).format());   
			   			$("#pdf_wrap .price_039").html(parseInt(data.ReportMallList.price_039).format());   
			   			$("#pdf_wrap .price_040").html(parseInt(data.ReportMallList.price_040).format());   
			   			$("#pdf_wrap .price_041").html(parseInt(data.ReportMallList.price_041).format());   
			   			$("#pdf_wrap #bikeCnt").html(parseInt(data.ReportMallList.bikeCnt).format() +"대     ");   
			   			$("#pdf_wrap #totCnt").html(parseInt(data.ReportMallList.totCnt).format() +"건");   
			   			$("#pdf_wrap #totAmt").html(parseInt(data.ReportMallList.totAmt).format() +"원");   
			   			
			   			$("#pdf_wrap .writeDate").html(data.ReportMallList.repairYear +"년 " + data.ReportMallList.repairMonth.substr(0,2) +"월" );   
			   			  
			   			var adminName = "박지현"
			   			
			   			if ( parseInt(data.ReportMallList.centerNo) <= parseInt(49) ) {
			   				adminName ="이기충";
			   			}
			   			
			   			$("#pdf_wrap .takeName").html(adminName);   
			   			
			   			savePDF( data.ReportMallList.centerName);
			   		},
			   		error : function(data){
			   		}
			   	}); 
			  	
			//},1000);

			
			
		</c:forEach>   
	}
</script>
     
    
<style>

#pdf_wrap {
 float: right; z-index: 999; position: absolute; width: 750px; height:1070px; padding:20px; 
}

#pdf_wrap tr td{
	height: 28px;
}

.footer  {
	float: left; width : 100%; font-size: large;
}


.footerTop  {
	width : 100%;
}
.footerTop div {
	float: left; font-size: large;
}
.header {
  background-color: #F1F1F1;
  text-align: center;
  padding: 20px;
  margin-top:20px;
  margin-bottom:20px;
}

.header H1 {
	font-size: 35px;
}

.header H2 {
	font-size: 20px;
}

.subheader {
  text-align: center;
  margin : 0 auto;
  border-collapse:collapse;
}

/* Create three equal columns that floats next to each other */
.column {
  float: left;
  width: 33.33%;
  padding: 15px;
}

.column20 {
  float: left;
  width: 13%;
  border:1px solid #708090; 
  font-size: 15px;
  padding: 10px;
  font-weight: bold;
  background: #FAF0E6;
}

.column30 {
  float: left;
  width: 31%;
  text-align: center;
  border:1px solid #708090;
  font-size: 15px;
  padding: 10px;
}

/* Clear floats after the columns */
.row {
  padding: 20px;
  content: "";
  display: table;
  clear: both;
  margin-top: 30px;
}

.tb_type01 td {
	height: 20px;
	padding:3px;
	vertical-align: middle;
}
</style> 
   
    
</body>
</html>