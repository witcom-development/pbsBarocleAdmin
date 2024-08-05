<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html>
<html lang="ko">
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
                <tiles:insertAttribute name="left"  />
                <!--left menu E-->
				<!--content S-->
				<div class="content">
					<form id="penFrm" name="penFrm">
					<input type="hidden" name="viewFlg"/>
					<input type="hidden" name="penaltyCd"/>
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
									<p>검색조건</p><span><button type="button"><img src="/images/srh_open.png" alt="검색조건 열기" /></button></span>
								</div>
							</div>
						</div>
						<!-- 모바일 검색조건 E-->
						<!--검색조건 S-->
						<div class="shBox">
							<fieldset>
								<legend>검색조건</legend>
								<div class="shBoxSection">
									<div class="section">
										<label for="schPenaltyName" class="laType02">별점명</label>
										<span class="input-text07"><input type="text" class="" id="schPenaltyName" name="penaltyName" /></span>
									</div>
									<div class="section pright etccase1">
										<button class="btn-srh03 btncase1 mdbtncase1" id="searchBtn"><img src="/images/searchIcon.gif" alt="검색" /></button>
									</div>
								</div>
							</fieldset>
						</div>
						<!--검색조건 E-->
						<p class="tb_numlist">총 ${paginationInfo.getTotalRecordCount() } 건</p>
						<table class="tb_type01" id="urlTable">
							<colgroup>
								<col style="width:21%"/>
								<col style="width:21%"/>
								<col style="width:21%"/>
								<col style="width:16%"/>
								<col style="width:21%"/>
							</colgroup>
							<thead>
								<tr>
									<th>벌점 명</th>
									<th>벌점 코드</th>
									<th>벌점 점수</th>
									<th>수정자</th>
									<th>수정일</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach var="result" items="${penaltyPolicyList }" varStatus="status">
						        <tr>
						            <td>
						                <a href="#" id="${result.penaltyCd }">${result.penaltyName }</a>
						            </td>
						            <td>
						                ${result.penaltyCd }
						            </td>
						            <td >
						                ${result.penaltyPoint }
						            </td>
						            <td>
						                ${result.modId }
						            </td>
						            <td>
						                ${result.modDttm }
						            </td>
						        </tr>
						    </c:forEach>
						    <c:if test='${fn:length(penaltyPolicyList) == 0}'>
						        <tr>
						            <td style="text-align:center" colspan="5"><spring:message code="search.nodata.msg" /></td>
					            </tr>
					        </c:if>
							</tbody>
						</table>
					<c:choose>
						<c:when test="${fn:length(penaltyPolicyList) > 0}">
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
						<div class="btnArea">
							<span class="right"><button class="btnType01 bc_green" id="penRegBtn">등록</button></span>
						</div>
					</div>
					</form>
				</div>
				<!--conteent E-->
            </div>
        </div>
        <!--footer S-->
        <tiles:insertAttribute name="footer" />
        <!--footer E-->
    </div>

<script type="text/javascript" src="/js/common_barocle.js"></script>
<script type="text/javascript">
	$(function() {
		penalty.initBtn();
		
		$("#schPenaltyName").val("${searchParam.penaltyName}")
		
		var totalPageCount = '${paginationInfo.totalPageCount}' == '' ? 1 : Number('${paginationInfo.totalPageCount}');
   		$('#prevPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			penalty.pageSelect(currentPageNo-1);
		});
		$('#nextPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			penalty.pageSelect(currentPageNo+1);
		});
		$('#movePage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			var regExp = /^[1-9]?[0-9]/;
			if(!regExp.test(currentPageNo) ||(totalPageCount < currentPageNo)){
				alert('현재 페이지 값이 정상적이지 않습니다.');
			}else{
				penalty.pageSelect(currentPageNo);
			}
		});
	});
	
	var penalty = {};
	penalty.initBtn = function () {
		$("#searchBtn").on("click", this.searchForm);
		$("#urlTable > tbody > tr").on("click", "a", this.moveEditForm);
		$("#penRegBtn").on("click", this.moveRegForm);
	};
	
	penalty.pageSelect = function(cPage) {
        $("[name='currentPageNo']").val(cPage);
        $("#penFrm").attr({method : "post", action : "/admin/service/policyMgmt/listPenaltyPolicy.do"}).submit();
        
        return false;
    };
	
	penalty.searchForm = function(e) {
		$("[name='currentPageNo']").val(1);
        $("#penFrm").attr({method : "post", action : "/admin/service/policyMgmt/listPenaltyPolicy.do"}).submit();
        
        return false;
    };
    
	penalty.moveEditForm = function(e) {
    	var penCd = e.target.id;
    	$("input:hidden[name='viewFlg']").val('U');
    	$("input:hidden[name='penaltyCd']").val(penCd);
        $("#penFrm").attr({method : "post", action : "/admin/service/policyMgmt/formPenaltyPolicy.do"}).submit();
        
        return false;
    };

    penalty.moveRegForm = function(e) {
    	$("input:hidden[name='viewFlg']").val('I');
		$("#penFrm").attr({method : "post", action : "/admin/service/policyMgmt/formPenaltyPolicy.do"}).submit();
		
		return false;
    };
</script>	
</body>
</html>