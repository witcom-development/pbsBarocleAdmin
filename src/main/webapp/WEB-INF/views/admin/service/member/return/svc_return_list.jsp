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
						<div class="shBox_m mt20">
							<div class="downtitle">
								<div class="title">
									<p>검색조건</p><span><button><img src="/images/srh_open.png" alt="검색조건 열기" /></button></span>
								</div>
							</div>
						</div>
						<!-- 모바일 검색조건 E-->
						<!--검색조건 S-->
						<div class="shBox">
							<form id="returnRentalFrm" name="returnRentalFrm" method="post">
							<input type="hidden" name="page" id="page">
							<input type="hidden" name="recommendSeq" id="recommendSeq" value=""/>
							<input type="hidden" name="totalPage" id="totalPage" value="${paginationInfo.totalPageCount}">
							<input type="hidden" name="pageNo" id="pageNo" value="${paginationInfo.currentPageNo}">
								<fieldset>
									<legend>검색조건</legend>
									<div class="shBoxSection">
										<div class="section">
											<label for="modStrDate" class="laType02">등록일</label>
											<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" id="searchStartDate" name="searchStartDate" readonly/></span>
											<span class="dash">~</span>
											<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" id="searchEndDate" name="searchEndDate" readonly/></span>
										</div>
										<div class="section">
											<label for="aa1" class="laType02" style="margin-top: 5px; width: 100px;">마일리지 부여 여부</label>
											<select class="select-category07" id="searchParameter" name="searchParameter" style="width: 200px;">
												<option value="">선택</option>
												<option value="N">해당사항없음</option>
												<option value="Y">완료</option>
											</select>
										</div>
										<div class="section">
											<label for="aa1" class="laType02">구분</label>
											<select class="select-category07" id="searchParameter2" name="searchParameter2" style="width: 105px;">
												<option value="ID">ID</option>
												<option value="PHONE">휴대번호</option>
											</select>
											
											<span class="input-text08"><input type="text" class="" id="searchValue" name="searchValue" style="width: 113px; ma"></span>
											
											<button class="btn-srh03 btncase1 mdbtncase1" id= "searchBtn"><img src="/images/searchIcon.gif" alt="검색" /></button>
										</div>
									</div>
								</fieldset>
								
						</div>
						<!--검색조건 E-->
						<p class="tb_numlist">총 ${paginationInfo.getTotalRecordCount() } 건</p>
						<form id="returnRentalListFrm">
						<table id="urlTable" class="tb_type01">
							<colgroup>
								<col style="width:16%"/>
								<col style="width:24%"/>
								<col style="width:22%"/>
								<col style="width:16%"/>
								<col style="width:22%"/>
							</colgroup>
							<thead>
								<tr>
									<th>ID</th>
									<th>반납대여소</th>
									<th>반납일시</th>
									<th>마일리지 부여 여부</th>
									<th>등록일</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach var="result" items="${returnList }" varStatus="status">
						        <tr>
						            
						            <td class="pl10"><a href="#" onclick="fn_MemberDetail('${result.recommendSeq }'); return false;">${result.usr_id }</a></td>
						            <td class="pl10">
						               ${result.station_nm }
						            </td>
						            <td class="pl10">
						                ${result.return_dttm }
						            </td>
						            <td class="pl10">
						                ${result.mileage_yn }
						            </td>
						            <td class="pl10">
						                ${result.reg_dttm }
						            </td>
						        </tr>
						    </c:forEach>
						    <c:if test='${fn:length(returnList) == 0}'>
						        <tr>
						            <td style="text-align:center" colspan="5"><spring:message code="search.nodata.msg" /></td>
					            </tr>
					        </c:if>
							</tbody>
						</table>
						</form>
					<c:choose>
						<c:when test="${fn:length(returnList) > 0}">
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
							<span><input name="currentPageNo" id="currentPageNo" type="number" value="${paginationInfo.currentPageNo}"/><em>/ ${paginationInfo.totalPageCount}</em><button id="movePage">이동</button></span>
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
    
<script type="text/javascript">
$(document).ready(function(){
	returnRental.initSearch();

});
var returnRental = {};

returnRental.initSearch = function(){
	$("#searchStartDate").val("${searchParam.searchStartDate}");
	$("#searchEndDate").val("${searchParam.searchEndDate}");
	
	if("${searchParam.searchValue}" !== null && "${searchParam.searchValue}" !== ""){
		$("#searchValue").val("${searchParam.searchValue}");
	}
	
	if("${searchParam.searchParameter}" !== null && "${searchParam.searchParameter}" !== ""){
		$("#searchParameter").val("${searchParam.searchParameter}");
	}
	
	if("${searchParam.searchParameter2}" !== null && "${searchParam.searchParameter2}" !== ""){
		$("#searchParameter2").val("${searchParam.searchParameter2}");
	}
}

</script>    
    
    
<script type="text/javascript" src="/js/common_barocle.js"></script>
<script type="text/javascript">
	$(function() {
		$("#nextPage").click(function(){
			if($("#searchStartDate").val()  &&  $("#searchEndDate").val())
				if($("#searchStartDate").val() > $("#searchEndDate").val()){
					alert('<spring:message code="fail.input.daterange" />');
					return;
				}
				//$("#currentPageNo").val(Number($("#currentPageNo").val())+1);
				$("#page").val(Number($("#currentPageNo").val())+1);
				
				
				$("#returnRentalFrm").attr({method : 'post', action : '/admin/service/member/returnRentalList.do'}).submit();
		});
		
		//prev page
		$("#prevPage").click(function(){
			if($("#searchStartDate").val()  &&  $("#searchEndDate").val())
				if($("#searchStartDate").val() > $("#searchEndDate").val()){
					alert('<spring:message code="fail.input.daterange" />');
					return;
				}
				//$("#currentPageNo").val(Number($("#currentPageNo").val())-1);
				$("#page").val(Number($("#currentPageNo").val())-1);
				
				$("#returnRentalFrm").attr({method : 'post', action : '/admin/service/member/returnRentalList.do'}).submit();
		});
		
		$("#movePage").click(function(){
			
			if(Number($("#currentPageNo").val()) > $("#totalPage").val()){
				alert("현재 페이지 값이 정상적이지 않습니다.");
				return false;
			}else{
				$("#page").val(Number($("#currentPageNo").val()));
				$("#returnRentalFrm").attr({method : 'post', action : '/admin/service/member/returnRentalList.do'}).submit();
			}
		});
		
		$("#searchBtn").on("click", function() {
	    	if(DateUtil.checkDateTerm( $( "[name='searchStartDate']").val(),  $( "[name='searchEndDate']").val()) !== 'ok') {
	    		alert("검색 조건의 시작 날이 종료 날보다 큽니다.");
	    		$( "[name='searchStartDate']").val('');
	    		$( "[name='searchEndDate']").val('');
	    		return false;
	    	}
	        //$("[name='currentPageNo']").val("1");
	        $("#page").val("1");
	        $("#returnRentalFrm").attr({method : 'post', action : '/admin/service/member/returnRentalList.do'}).submit();
	    });
	});

	var previousValue;
	$("input").on('focus',function(){
		previous = this.value;
	}).change(function(){
		var sDate = $("#searchStartDate").val();
		var eDate = $("#searchEndDate").val();
		if(sDate!=''&&eDate!=''&&sDate>eDate){
			alert("수정일 시작 시간이 종료 시간보다 빠를 수 없습니다.");
			$(this).val(previous);
		}
	});
	
	function fn_MemberDetail(seq){

		$("#recommendSeq").val(seq);
		
		$("#returnRentalFrm").attr("action", "/admin/service/member/returnRentalDetail.do");

		$("#returnRentalFrm").submit();
	}


</script>

</body>
</html>