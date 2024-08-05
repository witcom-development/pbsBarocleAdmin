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
						<form id="tranFrm" name="tranFrm">
							<div class="shBox">
							<input type="hidden" name="viewFlg"/>
							<input type="hidden" name="transferPolicySeq"/>
								<fieldset>
									<legend>검색조건</legend>
									<div class="shBoxSection">
										<div class="section">
											<label for="applyStrDate" class="laType02">적용기간</label>
											<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" id="applyStrDate" name="applyStrDate" readonly/></span>
											<span class="dash">~</span>
											<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" id="applyEndDate" name="applyEndDate" readonly/></span>
										</div>
										<div class="section pright etccase1">
											<button class="btn-srh03 btncase1 mdbtncase1" id="searchBtn"><img src="/images/searchIcon.gif" alt="검색" /></button>
										</div>
									</div>
								</fieldset>
							</div>
						<!--검색조건 E-->
						<p class="tb_numlist">총 ${paginationInfo.getTotalRecordCount() } 건</p>
						<table id="urlTable" class="tb_type01">
							<colgroup>
								<col style="width:auto"/>
								<col style="width:20%"/>
								<col style="width:17%"/>
								<col style="width:18%"/>
								<col style="width:18%"/>
							</colgroup>
							<thead>
								<tr>
									<th>적용 기간</th>
									<th>일 최대 적립 포인트</th>
									<th>1회 적립 포인트</th>
									<th>최소 사용 포인트</th>
									<th>최대 사용 포인트</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach var="result" items="${transferPolicyList }" varStatus="status">
						        <tr>
						            <td>
						                <a href="#" id="${result.transferPolicySeq }">${result.applyStrDate } ~ ${result.applyEndDate }</a>
						            </td>
						            <td>
						                ${result.ddMaxAccMileage }
						            </td>
						            <td >
						                ${result.tmsAccMileage }
						            </td>
						            <td>
						                ${result.minUseMileage }
						            </td>
						            <td>
						                ${result.maxUseMileage }
						            </td>
						        </tr>
						    </c:forEach>
						    <c:if test='${fn:length(transferPolicyList) == 0}'>
						        <tr>
						            <td style="text-align:center" colspan="5"><spring:message code="search.nodata.msg" /></td>
					            </tr>
					        </c:if>
							</tbody>
						</table>
					<c:choose>
						<c:when test="${fn:length(transferPolicyList) > 0}">
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
						<div class="btnArea">
							<span class="right"><button class="btnType01 bc_green" id="tranRegBtn">등록</button></span>
						</div>
					</div>
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
		transfer.initBtn();
		
		$("#applyStrDate").val("${searchParam.applyStrDate}");
		$("#applyEndDate").val("${searchParam.applyEndDate}");
		
		var totalPageCount = '${paginationInfo.totalPageCount}' == '' ? 1 : Number('${paginationInfo.totalPageCount}');
   		$('#prevPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			transfer.pageSelect(currentPageNo-1);
		});
		$('#nextPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			transfer.pageSelect(currentPageNo+1);
		});
		$('#movePage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			var regExp = /^[1-9]?[0-9]/;
			if(!regExp.test(currentPageNo) ||(totalPageCount < currentPageNo)){
				alert('현재 페이지 값이 정상적이지 않습니다.');
			}else{
				transfer.pageSelect(currentPageNo);
			}
		});
	});
	
	var transfer = {};
	transfer.initBtn = function () {
		$("#searchBtn").on("click", this.searchForm);
		$("#urlTable > tbody > tr").on("click", "a", this.moveEditForm);
		$("#tranRegBtn").on("click", this.moveRegForm);
	};
	
	transfer.pageSelect = function(cPage) {
        $("[name='currentPageNo']").val(cPage);
        $("#tranFrm").attr({method : "post", action : "/admin/service/policyMgmt/listTransferPolicy.do"}).submit();
        
        return false;
    };
    
	transfer.searchForm = function(e) {
		if(DateUtil.checkDateTerm( $( "[name='applyStrDate']").val(),  $( "[name='applyEndDate']").val()) !== 'ok') {
            alert("검색 조건의 시작 날이 종료 날보다 큽니다.");
            return false;
        }
		
		$("[name='currentPageNo']").val(1);
        $("#tranFrm").attr({method : "post", action : "/admin/service/policyMgmt/listTransferPolicy.do"}).submit();
        
        return false;
    };
    
	transfer.moveEditForm = function(e) {
    	var transferPolicySeq = e.target.id;
    	$("input:hidden[name='viewFlg']").val('U');
    	$("input:hidden[name='transferPolicySeq']").val(transferPolicySeq);
        $("#tranFrm").attr({method : "post", action : "/admin/service/policyMgmt/formTransferPolicy.do"}).submit();
        
        return false;
    };

    transfer.moveRegForm = function(e) {
    	$("input:hidden[name='viewFlg']").val('I');
		$("#tranFrm").attr({method : "post", action : "/admin/service/policyMgmt/formTransferPolicy.do"}).submit();
		
		return false;
    };
</script>

</body>
</html>