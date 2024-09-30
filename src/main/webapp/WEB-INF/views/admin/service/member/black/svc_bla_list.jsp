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
							<form id="blackFrm" name="blackFrm">
								<fieldset>
									<legend>검색조건</legend>
									<div class="shBoxSection">
										<div class="section">
											<label for="modStrDate" class="laType02">수정일</label>
											<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" id="modStrDate" name="modStrDate" readonly/></span>
											<span class="dash">~</span>
											<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" id="modEndDate" name="modEndDate" readonly/></span>
										</div>
										<!-- <div class="section pright">
											<label for="mbId" class="laType02">회원 ID</label>
											<span class="input-text08"><input type="text" id="mbId" name="mbId" /></span>
										</div> -->
										<div class="section pright">
											<label for="mbTelNo" class="laType02">휴대폰번호</label>
											<span class="input-text07"><input type="text" id="mbTelNo" name="mbTelNo" /></span>
											<button class="btn-srh03 btncase1 mdbtncase1" type="button" id="searchBtn"><img src="/images/searchIcon.gif" alt="검색" /></button>
										</div>
									</div>
								</fieldset>
								<input type="hidden" name="usr_seq" value=""/>
								<input type="hidden" name="listType" value="B"/>
						</div>
						<!--검색조건 E-->
						<p class="tb_numlist">총 ${paginationInfo.getTotalRecordCount() } 건</p>
						<form id="blackListFrm">
						<table id="urlTable" class="tb_type01">
							<colgroup>
								<col style="width:5%"/>
								<%-- <col style="width:20%"/> --%>
								<col style="width:15%"/>
								<col style="width:30%"/>
								<col style="width:20%"/>
							</colgroup>
							<thead>
								<tr>
									<th><input type="checkbox" id="checkAll"/></th>
									<!-- <th>아이디</th> -->
									<th>휴대폰번호</th>
									<th>등록이유</th>
									<th>수정일</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach var="result" items="${blackListList }" varStatus="status">
						        <tr>
						            <td class="tc">
						                <input type="checkbox" name="delCheckList" value="${result.usrSeq },${result.blkListStrDate }"/>
						            </td>
						            <%-- <td class="pl10">
						                <a href="#" id="${result.usrSeq }">${result.mbId }</a>
						            </td> --%>
						            <td class="pl10">
						                <a href="#" id="${result.usrSeq }">${result.usrMpnNo }</a>
						            </td>
						            <td class="pl10">
						                ${result.blkListReasonCd }
						            </td>
						            <td class="tc">
						                ${result.blkListRegDttm }
						            </td>
						        </tr>
						    </c:forEach>
						    <c:if test='${fn:length(blackListList) == 0}'>
						        <tr>
						            <td style="text-align:center" colspan="4"><spring:message code="search.nodata.msg" /></td>
					            </tr>
					        </c:if>
							</tbody>
						</table>
						</form>
					<c:choose>
						<c:when test="${fn:length(blackListList) > 0}">
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
							<span class="right"><button class="btnType01" type="button" id="blackListDelBtn">선택 해지</button></span>
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
		black.initBtn();
		
		$("#modStrDate").val("${searchParam.modStrDate}");
		$("#modEndDate").val("${searchParam.modEndDate}");
		$("#mbId").val("${searchParam.mbId}");
		$("#mbTelNo").val("${searchParam.mbTelNo}");
		
		var totalPageCount = '${paginationInfo.totalPageCount}' == '' ? 1 : Number('${paginationInfo.totalPageCount}');
   		$('#prevPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			black.pageSelect(currentPageNo-1);
		});
		$('#nextPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			black.pageSelect(currentPageNo+1);
		});
		$('#movePage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			var regExp = /^[1-9]?[0-9]/;
			if(!regExp.test(currentPageNo) ||(totalPageCount < currentPageNo)){
				alert('현재 페이지 값이 정상적이지 않습니다.');
			}else{
				black.pageSelect(currentPageNo);
			}
		});
	});
	
	var black = {};
	black.initBtn = function () {
		$("#searchBtn").on("click", this.searchForm);
		$("#urlTable > tbody > tr").on("click", "a", this.moveUserDetail);
		$("#blackListDelBtn").on("click", this.delBlackList);
		
		$("#checkAll").on("click", function(e) {
			if($(e.target).is(":checked")) {
				$("input[name='delCheckList']").each(function() {
					$(this).prop("checked", true);
				});
			} else {
				$("input[name='delCheckList'").each(function() {
					$(this).prop("checked", false);
				});
			}
		});
	};
	
	black.pageSelect = function(cPage) {
	    $("[name='currentPageNo']").val(cPage);
	    $("#blackFrm").attr({method : "post", action : "/admin/service/member/listBlackList.do"}).submit();
	};

	black.moveList = function() {
		$("#modStrDate").val("");
		$("#modEndDate").val("");
		$("#mbId").val("");
		$("#mbTelNo").val("");
		$("#blackFrm").attr({method : "post", action : "/admin/service/member/listBlackList.do"}).submit();
	}
	
	black.delBlackList = function(e) {
		var succ_cnt = 0;
		if($("input[name='delCheckList']:checked").length > 0) {
			if(confirm("해지하시겠습니까?")) {
				$("input[name='delCheckList']").each(function() {
					if($(this).is(":checked")) {
					var blackListInfo = ($(this).val()).split(",");
					
				    	commonAjax.postAjax("/admin/service/member/delBlackListAjax.do", "json", 
		   				{usrSeq : blackListInfo[0], blkListStrDate : blackListInfo[1]}, 
		   				function(data) {
			   				if(data) {
								if(data.isDel == "true") {
									succ_cnt++;
									if(succ_cnt == $("input[name='delCheckList']:checked").length) {
										alert("해지되었습니다.");
										black.moveList();
									}
								} else {
									alert("해지 실패하였습니다.");
									return;
								}
							}	
						});
					}
				});
			}
		} else {
			alert("선택된 회원이 없습니다.");
		}
	};
	
	black.searchForm = function(e) {
		if(DateUtil.checkDateTerm( $( "[name='modStrDate']").val(),  $( "[name='modEndDate']").val()) !== 'ok') {
            alert("검색 조건의 시작 날이 종료 날보다 큽니다.");
            return false;
        }
		
		$("[name='currentPageNo']").val(1);
	    $("#blackFrm").attr({method : "post", action : "/admin/service/member/listBlackList.do"}).submit();
	};

	black.moveUserDetail = function(e) {
	
		$("#usr_seq").val(e.target.id);
	    $("#blackFrm").attr({method : "post", action : "/admin/service/member/memberInfo.do?usr_seq=" + e.target.id}).submit();
	};


</script>

</body>
</html>