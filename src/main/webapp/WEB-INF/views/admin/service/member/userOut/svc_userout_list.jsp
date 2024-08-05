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
						<form id="useroutFrm" name="useroutFrm">
							<div class="shBox">
								<fieldset>
									<legend>검색조건</legend>
									<div class="shBoxSection">
										<div class="section">
											<label for="leaveStrDate" class="laType02">탈퇴일</label>
											<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" id="leaveStrDate" name="leaveStrDate" readonly/></span>
											<span class="dash">~</span>
											<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" id="leaveEndDate" name="leaveEndDate" readonly/></span>
										</div>
										<div class="section pright">
											<label for="a22" class="laType02">회원아이디</label>
											<span class="input-text07"><input type="text" id="mbId" name="mbId" /></span>
											<button class="btn-srh03 btncase1 mdbtncase1"><img src="/images/searchIcon.gif" alt="검색" id="searchBtn"/></button>
										</div>
									</div>
								</fieldset>
							</div>
						<!--검색조건 E-->
						<p class="tb_numlist">총 ${paginationInfo.getTotalRecordCount() } 건</p>
						<table class="tb_type01">
							<colgroup>
								<col style="width:15%"/>
								<%-- <col style="width:18%"/> --%>
								<col style="width:18%"/>
								<col style="width:15%"/>
								<col style="width:15%"/>
								<!--[if gt IE 8]><!--><col style="width:14%" class="mhid"/><!--<![endif]-->
							</colgroup>
							<thead>
								<tr>
									<th>아이디</th>
									<!-- <th>성별</th> -->
									<th>생년월</th>
									<th>탈퇴 이유</th>
									<th>블랙리스트 여부</th>
									<!--[if gt IE 8]><!--><th class="mhid">탈퇴일</th><!--<![endif]-->
								</tr>
							</thead>
							<tbody>
							<c:forEach var="result" items="${userOutList }" varStatus="status">
						        <tr>
						            <td>
						                ${result.mbId }
						            </td>
						            <%-- <td>
						                ${result.sexCd == 'M' ? '남' : '여' }
						            </td> --%>
						            <td >
						                ${result.usrBirthDate }
						            </td>
						            <td>
						                ${result.leaveReasonCd }
						            </td>
						            <td>
						                ${result.blklistYn }
						            </td>
						            <td>
						                ${result.leaveDttm }
						            </td>
						        </tr>
						    </c:forEach>
						    <c:if test='${fn:length(userOutList) == 0}'>
						        <tr>
						            <td style="text-align:center" colspan="5"><spring:message code="search.nodata.msg" /></td>
					            </tr>
					        </c:if>
							</tbody>
						</table>
					<c:choose>
						<c:when test="${fn:length(userOutList) > 0}">
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
		userout.initBtn();
		
		$("#leaveStrDate").val("${searchParam.leaveStrDate}");
		$("#leaveEndDate").val("${searchParam.leaveEndDate}");
		$("#mbId").val("${searchParam.mbId}");
		
		var totalPageCount = '${paginationInfo.totalPageCount}' == '' ? 1 : Number('${paginationInfo.totalPageCount}');
   		$('#prevPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			userout.pageSelect(currentPageNo-1);
		});
		$('#nextPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			userout.pageSelect(currentPageNo+1);
		});
		$('#movePage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			var regExp = /^[1-9]?[0-9]/;
			if(!regExp.test(currentPageNo) ||(totalPageCount < currentPageNo)){
				alert('현재 페이지 값이 정상적이지 않습니다.');
			}else{
				userout.pageSelect(currentPageNo);
			}
		});
	});
	
	var userout = {};
	userout.initBtn = function () {
		$("#searchBtn").on("click", this.searchForm);
	};
	
	userout.pageSelect = function(cPage) {
	    $("[name='currentPageNo']").val(cPage);
	    $("#useroutFrm").attr({method : "post", action : "/admin/service/member/listUserOut.do"}).submit();
	    
	    return false;
	};
	
	userout.searchForm = function(e) {
		if(DateUtil.checkDateTerm( $( "[name='leaveStrDate']").val(),  $( "[name='leaveEndDate']").val()) !== 'ok') {
            alert("검색 조건의 시작 날이 종료 날보다 큽니다.");
            return false;
        }
		if(DateUtil.diffDays( $("[name='leaveStrDate']").val(),  $("[name='leaveEndDate']").val(), '-') >= 31){
    		alert("조회기간은 31일 이내로 설정해주세요.");
    		return false;
    	}
		$("[name='currentPageNo']").val(1);
	    $("#useroutFrm").attr({method : "post", action : "/admin/service/member/listUserOut.do"}).submit();
	    
	    return false;
	};
</script>

</body>
</html>