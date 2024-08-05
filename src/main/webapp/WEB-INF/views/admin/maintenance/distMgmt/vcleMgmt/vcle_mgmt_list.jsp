<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />
<meta name="description=" Content="" />
<title><tiles:insertAttribute name="title"/></title>
<tiles:insertAttribute name="resource"/>
</head>
<body>
<!-- solbit test-테스트 페이지  S   -->
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
						<form id="searchFrm">
						<!-- 모바일 검색조건 E-->
						<!--검색조건 S-->
							<div class="shBox">
                        	<input type="hidden" name="viewFlg" value="" />
                        	<input type="hidden" name="adminId" value="" />
                        	<fieldset>
								<legend>검색 옵션</legend>
								<div class="shBoxSection">
									<div class="section">
										<label for="bb22" class="laType02">기간</label>
										<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" name="searchBgnDe" title="선택 날짜" id="bb22" readonly/></span>
										<span class="dash">~</span>
										<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" name="searchEndDe" title="선택 날짜" readonly/></span>
									</div>
									<div class="section pright">
										<label for="aa1" class="laType02">차량</label>
										<select class="select-category01" name="searchVcleNo" id="vcleSlt">
											<option value="">선택</option>
										</select>
									</div>
									
									<div class="section">
										<label for="bb22" class="laType02">센터</label>
										<select class="select-category01" name="centerId" id="centerId">
											<option value="">선택</option>
										</select>
										
									</div>
									
									
									<div class="section pright">
										<label for="aa2" class="laType02">분배원</label>
										<span class="input-text07"><input type="text" name="searchAdmin" class="" value=""/></span>
									</div>
									<button id="searchBtn" class="btn-srh03 btncase1"><img src="/images/searchIcon.gif" alt="검색"></button>
								</div>
							</fieldset>
						</div>
                       	<!-- 검색조건  E -->
                       	<!-- 검색결과 S -->
						<p class="tb_numlist">총 ${ paginationInfo.getTotalRecordCount()} 건</p>
						<div class="widscr mt5">
							<c:choose>
								<c:when test="${fn:length(vcleList) ne 0 }">
		                        	<table class="tb_type03 my-3">
		                        		<caption>분배원 차량 조회</caption>
		                        		<colgroup>
		                        			<col style="width:11%">
		                                    <col style="width:13%">
		                                    <col style="width:12%">
		                                    <col style="width:14%">
		                                    <col style="width:14%">
		                                    <col style="width:12%">
		                                    <col style="width:12%">
		                        		</colgroup>
		                        		<thead>
		                        			<tr>
												<th class="top text-center" rowspan="2">차량번호</th>
                        						<th class="top text-center" rowspan="2">운행날짜</th>
                        						<th class="top text-center" rowspan="2">운행시작</th>
                        						<th class="top text-center" rowspan="2">운행종료</th>
                        						<th class="top text-center" rowspan="2">운전자</th>
                        						<th class="top text-center" rowspan="2">동승자</th>
                        						<th class="top text-center" colspan="2">주행거리(km)</th>
		                        			</tr>
		                        			<tr>
                        						<th class="text-center">출고 시</th>
                        						<th class="text-center">입고 시</th>
		                        			</tr>
		                        		</thead>
		                        		<tbody id="tbodyTarget">
		                        		
			                        		<c:forEach items="${vcleList}" var="list" varStatus="vst">
			                        		
				                        		<fmt:parseDate value="${list.vcleDate}" var="vclePlanDate" pattern="yyyy-MM-dd" />
			                        			
			                        			<tr>
				                        			<td class="text-center"><c:out value="${list.vcleNo}"></c:out></td>
			                        				<td class="text-center"><fmt:formatDate value="${vclePlanDate}" pattern="MM-dd" /></td>
				                        			
				                        			<%-- <td class="text-center"><c:out value="${list.shiftWorkCdName}"></c:out></td> --%>
				                        			
				                        			<td class="text-right"><c:out value="${list.startTime}"></c:out></td>
				                        			<td class="text-right"><c:out value="${list.endTime}"></c:out></td>
				                        			
				                        			<td class="text-center"><c:out value="${list.driverName}"></c:out></td>
				                        			<td class="text-center"><c:out value="${list.adminNames}"></c:out></td>
				                        			<td class="text-right"><fmt:formatNumber value="${list.bfMileage}" pattern="#,###" /></td>
				                        			<td class="text-right"><fmt:formatNumber value="${list.afMileage}" pattern="#,###" /></td>
			                        			</tr>
			                        		</c:forEach>
		                        		</tbody>
		                       		</table>
		                       	</c:when>	
	                            <c:otherwise>
	                                <table class="tb_type01 nbt0">
			                            <tr><td style="text-align:center"><spring:message code="search.nodata.msg" /></td></tr>
			                        </table>
								</c:otherwise>
							</c:choose>
                       	</div>
                    	<!-- 검색결과 E -->
                    	<!-- 버튼구역 S  -->
                    	<div class="btnArea">
							<span class="right">
								<!-- <button class="btnType01" id="excelViewBtn" title="엑셀다운로드">엑셀다운로드</button>  -->
							</span>
						</div>
                    	<!-- 버튼구역 E  -->
                    	<!-- 페이징 S  -->
                    	<div>
                    	<c:choose>
							<c:when test="${fn:length(vcleList) > 0}">
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
						</div>
                    	<!-- 페이징 E  -->	
						</form>
					</div>
                </div>
                <!--conteent E-->
            </div>
        </div>
        </div>   
        <!--footer S-->
        <tiles:insertAttribute name="footer" />
        <!--footer E-->
    <script type="text/javascript" src="/js/common_barocle.js"></script>
    <script type="text/javascript">
    $(function(){
    	
    	distVcleInfo.init();
    	
    	/*********** 검색구간 정보 S  ***********/
    	
    	var date = new Date;
		date.setDate(date.getDate()-6);
		var fromday = DateUtil.dateFmt(new Date()); /* DateUtil.dateFmt(date); 당일로 변경*/
		var today = DateUtil.dateFmt(new Date());
 		var sDate = '${searchCondition.searchBgnDe}' !== '' ? '${searchCondition.searchBgnDe}' : fromday;
		var eDate = '${searchCondition.searchEndDe}' !== '' ? '${searchCondition.searchEndDe}' : today;
		var searchVcleNo = '${searchCondition.searchVcleNo}' !== '' ? '${searchCondition.searchVcleNo}' : '';
		var searchAdmin = '${searchCondition.searchAdmin}' !== '' ? '${searchCondition.searchAdmin}' : '';
		var adminId = '${searchCondition.adminId}' !== '' ? '${searchCondition.adminId}' : '<%= com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil.getSessionAttribute(request, "usrId") %>';
		var centerId = '${searchCondition.centerId}' !== '' ? '${searchCondition.centerId}' : '';
		
		$("[name='searchBgnDe']").val(sDate);
		$("[name='searchEndDe']").val(eDate);
		$("[name='searchAdmin']").val(searchAdmin);
		$("[name='searchVcleNo']").val(searchVcleNo);
		$("[name='adminId']").val(adminId);
		
		commonAjax.getCommonCode("DEC", 
        function(data) {
	         if(data !== null && data.codeList !== null) {
	        	 var code = new Array();
	             for(var i =0; i <data.codeList.length ;i++) {
	                     code.push(data.codeList[i]);
	             }
	             commCdBox.makeComboBox('CC', '', code, "centerId");
	         }
		});
		
		$("[name='centerId']").val(centerId);
		
    	/*********** 검색구간 정보 E  ***********/
    	
		/*********** 페이징  S ***********/
		
    	var totalPageCount = '${paginationInfo.totalPageCount}' == '' ? 1 : Number('${paginationInfo.totalPageCount}');
   		$('#prevPage').on("click",function(){
   			
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			distVcleInfo.pageSelect(currentPageNo-1);
			
		});
		$('#nextPage').on("click",function(){
			
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			distVcleInfo.pageSelect(currentPageNo+1);
			
		});
		$('#movePage').on("click",function(){
			
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			var regExp = /^[1-9]?[0-9]/;
			
			if(!regExp.test(currentPageNo) ||(totalPageCount < currentPageNo)){
				
				alert('현재 페이지 값이 정상적이지 않습니다.');
				
			}else{
				
				distVcleInfo.pageSelect(currentPageNo);
				
			}
			
		});
		
		/*********** 페이징  E ***********/
		
		/*********** 화면단 이벤트 리스너 S ***********/
				
		
		$("#searchBtn").on("click",function(e){
			
			e.preventDefault();
			
			$("[name='viewFlg']").val("list");
			
			$("#searchFrm").attr({method : 'post', action :'/getDistVcleList.do'}).submit();
			
		});
		
		/*$("#excelViewBtn").on("click",function(e){
			
			e.preventDefault();
	         
	         $("[name='currentPageNo']").val(1);

	         $("[name='viewFlg']").val("excel");
	         
	         $("#searchFrm").attr({method : 'post', action : '/getDistVcleList.do'}).submit();
	         
		});*/
		
		/*********** 화면단 이벤트 리스너 E ***********/
		
		
    });

    /*********** 변수 & 함수 S ***********/
    
   	var distVcleInfo = {};
   	
   	distVcleInfo.init = function(){
   		
   		$.ajax({
			url: "getVcleInfoListAjax.do",
			type: "post",
			async: false,
			success: function(data){
				
					var vcleInfoList = data.vcleInfoList;
					
					if(!vcleInfoList){
					}else{
						
						for(var i =0; i< vcleInfoList.length; i++){
							
							if(vcleInfoList[i].useYn === "Y"){
								
								var option = $('<option/>');
								option.attr({ 'value': vcleInfoList[i].vcleNoSeq }).text(vcleInfoList[i].vcleNo);
								$('[name="searchVcleNo"]').append(option);
								
							}
							
						}
						
					}
					
			}, error : function(){
				alert("분배원 차량조회 실패"); 
			}
			
		});
   		
   	};
   	
   	distVcleInfo.pageSelect = function(pageNo) {
       	$("[name='currentPageNo']").val(pageNo);
       	$("[name='viewFlg']").val('list');
       	
       	$("#searchFrm").attr({method : 'post', action :'/getDistVcleList.do'}).submit();
       	
    };
    
    /*********** 변수 & 함수 E ***********/
    
    </script>
</body>
</html>