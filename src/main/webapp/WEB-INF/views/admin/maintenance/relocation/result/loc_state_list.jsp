<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
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
									<p>검색조건</p><span><button><img src="../images/srh_open.png" alt="검색조건 열기" /></button></span>
								</div>
							</div>
						</div>
						<!-- 모바일 검색조건 E-->
						<!--검색조건 S-->
						<form id="searchFrm">	
							<div class="shBox">
								<input type="hidden" name="adminId" value=""/>
								<fieldset>
                                    <legend>검색 옵션</legend>
                                    <div class="shBoxSection">
                                        <div class="section pright">
                                        	<select class="select-category07" name="searchType" id="a2">
												<option value="">선택</option>
												<option value="name">이름</option>
												<option value="id">아이디</option>
											</select>
											<span class="input-text08"><input type="text" name="searchValue" /></span>
                                        </div>
                                        <div class="section">
                                            <label for="adminType" class="laType02">관리 구분</label>
											<select class="" name="adminType" id="adminType">
												<option value="">선택</option>
											</select>
                                            <button type="button" id="searchBtn" class="btn-srh03 btncase1 mdbtncase1"><img src="/images/searchIcon.gif" alt="검색"></button>
                                        </div>
                                    </div>
                                </fieldset>
							</div>
						<!--검색조건 E-->
						<p class="tb_numlist">총 ${ paginationInfo.getTotalRecordCount()} 건</p>
						<table class="tb_type01">
							<colgroup>
								<col style="width:20%"/>
								<col style="width:15%"/>
								<col style="width:15%"/>
								<col style="width:20%"/>
								<col style="width:30%"/>
							</colgroup>
							<thead>
								<tr>
									<th>관리 구분</th>
									<th>이름</th>
									<th>ID</th>
									<th>휴대폰</th>
									<th>이메일</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach var="result" items="${RelocationStateList}" varStatus="status">
                                <tr>
                                    <td>${result.adminTypeName}</td>
                                    <td><a href="#" name="adminName">${result.adminName}</a></td>
                                    <td>${result.adminId}</td>
                                    <td>${result.adminPhone}</td>
                                    <td>${result.adminEmail}</td>
                                </tr>
                            </c:forEach>
                            <c:if test="${fn:length(RelocationStateList) eq 0 }">
								<table class="tb_type01 nbt0">
									<tr><td style="text-align:center"><spring:message code="search.nodata.msg" /></td></tr>
								</table>
							</c:if>
							</tbody>
						</table>
					<c:choose>
						<c:when test="${fn:length(RelocationStateList) > 0}">
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
   		relocationStateList.initBtn();
		
		var adminType = '${searchCondition.adminType}' == '' ? 'ADM_005' : '${searchCondition.adminType}';
		var searchType = '${searchCondition.searchType}' == '' ? '' : '${searchCondition.searchType}';
		var searchValue = '${searchCondition.searchValue}' == '' ? '' : '${searchCondition.searchValue}';
		
		commonAjax.getCommonCode("ADM", 
	        function(data) {
	            if(data != null && data.codeList != null) {
	                commCdBox.makeComboBox('CC', adminType ,data.codeList, "adminType");
	                $("#adminType").trigger('change');
	            }
	        }
        );
		
		$("[name='searchType']").val(searchType);
		$("[name='searchValue']").val(searchValue);
		
		var totalPageCount = '${paginationInfo.totalPageCount}' == '' ? 1 : Number('${paginationInfo.totalPageCount}');
   		$('#prevPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			relocationStateList.pageSelect(currentPageNo-1);
		});
		$('#nextPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			relocationStateList.pageSelect(currentPageNo+1);
		});
		$('#movePage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			var regExp = /^[1-9]?[0-9]/;
			if(!regExp.test(currentPageNo) ||(totalPageCount < currentPageNo)){
				alert('현재 페이지 값이 정상적이지 않습니다.');
			}else{
				relocationStateList.pageSelect(currentPageNo);
			}
		});
	});
    
    var relocationStateList = {};
    
    relocationStateList.initBtn = function(){
    	$("#searchBtn").on("click",{listType: "list"},this.exeListFnc);
    	$("[name='adminName']").on("click",this.detailListFnc)
    }
    
    relocationStateList.exeListFnc = function(e) {
        e.preventDefault();
        var listType = e.data.listType;
        $("[name='currentPageNo']").val(1);
      
        $("#searchFrm").attr({method : 'post', action : '/relocationStateList.do'}).submit();
    };
    
    relocationStateList.detailListFnc = function(e) {
    	e.preventDefault();
    	$("[name='adminId']").val($(this).parent().next().text());
    	$("[name='currentPageNo']").val(1);
    	$("#searchFrm").attr({method : 'post', action : '/relocationStateDetail.do'}).submit();
    }
    
    relocationStateList.pageSelect = function(pageNo) {
    	$("[name='currentPageNo']").val(pageNo);
    	$("#searchFrm").attr({action :'/relocationStateList.do', method : 'post'}).submit();
    	
    };
    
    </script>
</body>
</html>