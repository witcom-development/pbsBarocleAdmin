<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
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
								<input type="hidden" name="sortValue" />
								<input type="hidden" name="dstbdiarySeq" value="0" />
								<fieldset>
									<legend>검색 옵션</legend>
									<div class="shBoxSection">
										<div class="section">
											<label for="bb22" class="laType02">분배일</label>
											<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" name="searchBgnDe" title="선택 날짜" id="bb22" readonly/></span>
											<span class="dash">~</span>
											<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" name="searchEndDe" title="선택 날짜" readonly/></span>
										</div>
										<div class="section pright">
											<label for="aa1" class="laType02">담당자명</label>
											<span class="input-text07"><input type="text" name="searchWord" class=""/></span>
										</div>
										<div class="section">
											<button id="searchBtn" class="btn-srh03 btncase1"><img src="/images/searchIcon.gif" alt="검색"></button>
										</div>
									</div>
									
								</fieldset>
							</div>
						<div class="listalign mt20">
                            <div class=" tb_numlist" style="float: right;">총 ${ paginationInfo.getTotalRecordCount()} 건</div>
                        </div>
						<!--검색조건 E-->
						<table class="tb_type01">
							<colgroup>
								<col style="width:15%"/>
								<col style="width:15%"/>
								<col style="width:15%"/>
								<col style="width:10%"/>
								<col style="width:10%"/>
								<col style="width:10%"/>
								<col style="width:10%"/>
								<%-- <col style="width:20%"/> --%>
							</colgroup>
							<thead>
								<tr>
									<th>일자</th>
									<th class="tc">담당자</th>
									<th>팀</th>
									<th>회수</th>
									<th>분배</th>
									<th>입고</th>
									<th>출고</th>
									<!-- <th>상세보기</th> -->
								</tr>
							</thead>
							<tbody>
								<c:forEach var="list" items="${distributionDiaryList}"  varStatus="loop">
	                                <tr>
	                                	<td style="display: none;">${list.dstbdiarySeq}</td>
	                                    <td><a href="#">${list.dstbdiaryDate }</a></td>
	                                    <td>${list.adminNm }</td>
										<td>${list.assignCenterNm }${list.teamNm }</td>
	                                    <td>${list.rtrvlCnt}</td>	
	                                   	<td>${list.dstbCnt}</td>
	                                   	<td>${list.wrhousngCnt}</td>
	                                   	<td>${list.dlivyCnt}</td>
	                                   	<!-- <td>상세보기</td> -->
									</tr>
                                </c:forEach>
                                <c:if test="${fn:length(distributionDiaryList) eq 0 }">
	                                <table class="tb_type01 nbt0">
			                            <tr><td style="text-align:center"><spring:message code="search.nodata.msg" /></td></tr>
			                        </table>
								</c:if>
							</tbody>
						</table>
					<c:choose>
						<c:when test="${fn:length(distributionDiaryList) > 0}">
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
						</form>
						<!-- <div class="btnArea">
							<span class="right">
								<button class="btnType01" id="excelViewBtn" title="엑셀다운로드">엑셀다운로드</button>
							</span>
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
		distributionDiaryList.initBtn();
		
		var sDate = '${searchCondition.searchBgnDe}' != '' ? '${searchCondition.searchBgnDe}' : '';
		var eDate = '${searchCondition.searchEndDe}' != '' ? '${searchCondition.searchEndDe}' : '';
		var searchWord = '${searchCondition.searchWord}' !== '' ? '${searchCondition.searchWord}' : '';
		
		$("[name='searchBgnDe']").val(sDate);
		$("[name='searchEndDe']").val(eDate);
		$("[name='searchWord']").val(searchWord);
		
		var totalPageCount = '${paginationInfo.totalPageCount}' == '' ? 1 : Number('${paginationInfo.totalPageCount}');
   		$('#prevPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			distributionDiaryList.pageSelect(currentPageNo-1);
		});
		$('#nextPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			distributionDiaryList.pageSelect(currentPageNo+1);
		});
		$('#movePage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			var regExp = /^[1-9]?[0-9]/;
			if(!regExp.test(currentPageNo) ||(totalPageCount < currentPageNo)){
				alert('현재 페이지 값이 정상적이지 않습니다.');
			}else{
				distributionDiaryList.pageSelect(currentPageNo);
			}
		});
	});
    
    var distributionDiaryList = {};
    
    distributionDiaryList.initBtn = function(){
    	var _this = distributionDiaryList;
    	$("#searchBtn").on("click",{listType: "list"},this.exeListFnc);
    	$(".tb_type01 > tbody > tr").on("click", "a",{ viewFlg : 'U'},  this.moveEditForm);
    	
    }
    
    distributionDiaryList.exeListFnc = function(e) {
        e.preventDefault();
        var listType = e.data.listType;

        if(DateUtil.checkDateTerm( $( "[name='searchBgnDe']").val(),  $( "[name='searchEndDe']").val()) != 'ok') {
            alert('<spring:message code="fail.input.daterange"/>');
            return false;
        }
        $("[name='currentPageNo']").val(1);
       
        $("[name='viewFlg']").val(listType);
        $("#searchFrm").attr({method : 'post', action : '/getDistributionDiaryList.do'}).submit();
    };
    
    distributionDiaryList.pageSelect = function(pageNo) {
    	$("[name='currentPageNo']").val(pageNo);
    	$("[name='viewFlg']").val('list');
    	$("#searchFrm").attr({action :'/getDistributionDiaryList.do', method : 'post'}).submit();
    	
    };
    distributionDiaryList.moveEditForm = function (e) {
    	e.preventDefault();
    	var pViewFlg = e.data.viewFlg;
    	
    	if(pViewFlg === 'U') {
    		//$("[name='apId']").val($(this).text());
    		$("[name='dstbdiarySeq']").val($(this).parent().prev().text());
    	}else{
    		//$("[name='apId']").val('');
    		//$("[name='repairSeq']").val('');
    	}
    	$("[name='viewFlg']").val(pViewFlg);
    	$("#searchFrm").attr({method : 'post', action : '/viewDistributionDiary.do'}).submit();
    };
    </script>
</body>
</html>