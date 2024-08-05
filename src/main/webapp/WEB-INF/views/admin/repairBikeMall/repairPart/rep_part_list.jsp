<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%
	Calendar cal = Calendar.getInstance();
	int minYear = 2015;
	int nowYear = cal.get(Calendar.YEAR);
	SimpleDateFormat sdf = new SimpleDateFormat("MM");
	String nowMonth = sdf.format(cal.getTime());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" /> 
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />
<meta name="description=" Content="" />
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
                                <input type="hidden" name="repairOursrcPriceSeq" value="" />
                                <input type="hidden" name="viewFlg" value="" /> 
								<fieldset>
									<legend>검색 옵션</legend>
									<div class="shBoxSection">
										<div class="section">
											<label for="bb22" class="laType02">부품명</label>
											<select class="select-category02" name="comCd">
												<option value="">선택</option>
											</select>
										</div>
										<div class="section pright">
											<label for="a1" class="laType02">연도</label>
											<select class="select-category02" name="priceYmd">
												<option value="">선택</option>
												<%
													for(int i = nowYear; i > (minYear-1); i--){
												%>
													<option value="<%=i%>"><%=i%></option>
												<%
													}
												%>
											</select>
											<button id="searchBtn" class="btn-srh03 btncase1"><img src="/images/searchIcon.gif" alt="검색" id="searchBtn"></button>
										</div>
									</div>
								</fieldset>
							</div>
						<!--검색조건 E-->
						<p class="tb_numlist">총 ${ paginationInfo.getTotalRecordCount()}건</p>
						<table class="tb_type01">
							<colgroup>
								<col style="width:25%"/>
								<col style="width:25%"/>
								<col style="width:25%"/>
								<col style="width:25%"/>
							</colgroup>
							<thead>
								<tr>
									<th>부품명</th>
									<th>수리단가</th>
									<th>적용년도</th>
									<th>등록연월</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="result" items="${RepairPartList}" varStatus="status">
								<tr>
									<td style="display: none;">${result.repairOursrcPriceSeq}</td>
									<td class="tc"><a href="#" id="${result.repairOursrcPriceSeq}">${result.partName}</a></td>
									<td class="tc"><fmt:formatNumber pattern="#,###" value="${result.price }"></fmt:formatNumber>원</td>
									<td class="tc">${result.priceYmd}</td>
									<fmt:parseDate var="dateString" value="${result.regDttm }" pattern="yyyy-MM-ddHH:mm:ss" />
									<td class="tc"><fmt:formatDate value="${dateString}" pattern="yyyy-MM"/></td>
								</tr>								
								</c:forEach>
								<c:if test="${fn:length(RepairPartList) eq 0 }">
									<table class="tb_type01 nbt0">
										<tr><td style="text-align:center"><spring:message code="search.nodata.msg" /></td></tr>
									</table>
								</c:if>
							</tbody>
						</table>  
						<c:choose>
						<c:when test="${fn:length(RepairPartList) > 0}">
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
						<div class="btnArea">
							<span class="right"><button class="btnType01 bc_green mb10" id="regist">등록</button></span>
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
   		partPriceList.initBtn();
		
		var totalPageCount = '${paginationInfo.totalPageCount}' == '' ? 1 : Number('${paginationInfo.totalPageCount}');
   		$('#prevPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			partPriceList.pageSelect(currentPageNo-1);
		});
		$('#nextPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			partPriceList.pageSelect(currentPageNo+1);
		});
		$('#movePage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			var regExp = /^[1-9]?[0-9]/;
			if(!regExp.test(currentPageNo) ||(totalPageCount < currentPageNo)){
				alert('현재 페이지 값이 정상적이지 않습니다.');
			}else{
				partPriceList.pageSelect(currentPageNo);
			}
		});
		
		commonAjax.getCommonCode("REC", function(data){
    		if(data !== null && data.codeList !== null) {
    			for(var i = 0; i < data.codeList.length; i++){
    				if(data.codeList[i].comCd == '${searchCondition.comCd}')
    					$("<option value='"+data.codeList[i].comCd+"' selected>"+data.codeList[i].comCdName+"</option>").appendTo('[name="comCd"]');
    				else
	        			$("<option value='"+data.codeList[i].comCd+"'>"+data.codeList[i].comCdName+"</option>").appendTo('[name="comCd"]');
    			}
    		}
    	});
		
		var priceYmd = '${searchCondition.priceYmd}';
		if(priceYmd != null || priceYmd != ''){
			$("[name=priceYmd]").val(priceYmd);
		}

	});
    
	var partPriceList = {};
    
	partPriceList.initBtn = function(){
    	$("#searchBtn").on("click",{listType: "list"},this.exeListFnc);
    	$("#regist").on("click",{viewFlg: "C"}, this.exeMoveDetailFnc);
    	$(".tb_type01 > tbody > tr").on("click", "a",{viewFlg : "U"}, this.exeMoveDetailFnc);
    }
    
	partPriceList.exeListFnc = function(e) {
        e.preventDefault();
        var listType = e.data.listType;
        
        $("[name='currentPageNo']").val(1);
        
        $("[name='viewFlg']").val(listType);
        $("#searchFrm").attr({method : 'post', action : '/repairPartPriceList.do'}).submit();
    };
    
    partPriceList.pageSelect = function(pageNo) {
    	$("[name='currentPageNo']").val(pageNo);
    	$("[name='viewFlg']").val('list');
    	$("#searchFrm").attr({action :'/repairPartPriceList.do', method : 'post'}).submit();
    };
    
    partPriceList.exeMoveDetailFnc = function(e) {
        e.preventDefault();
        var viewFlg = e.data.viewFlg;
        
        $("[name='viewFlg']").val(viewFlg);
        $("[name='repairOursrcPriceSeq']").val(e.target.id);
        	
        $("#searchFrm").attr({method : 'post', action : "<c:url value='/movePartPriceEditForm.do'/>"}).submit();
    }
    
    
    </script>
</body>
</html>