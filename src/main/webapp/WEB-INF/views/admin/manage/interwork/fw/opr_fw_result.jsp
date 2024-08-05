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
						<form id="fwUpdateFrm" name="fwUpdateFrm">
							<div class="shBox">
							<input type="hidden" name="firmwareSeq"/>
							<input type="hidden" name="firmwareClsName"/>
							<input type="hidden" name="firmwareVer"/>
								<fieldset>
									<legend>검색 옵션</legend>
									<div class="shBoxSection">
										<div class="section">
											<label for="processStrDate" class="laType02">요청일자</label>
											<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" readonly id="processStrDate" name="processStrDate"/></span>
											<span class="dash">~</span>
											<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" readonly id="processEndDate" name="processEndDate"/></span>
										</div>
										<div class="section pright">
											<label for="aa1" class="laType02">단말기ID</label>
											<span class="input-text07"><input type="text" id="deviceId" name="deviceId" /></span>
										</div>
										<div class="section">
											<label for="successYn" class="laType02">처리결과</label>
											<select class="select-category01" id="successYn" name="successYn">
												<option value="">선택</option>
												<option value="Y">성공</option>
												<option value="N">실패</option>
											</select>
											<button class="btn-srh03 btncase1" id="searchBtn"><img src="/images/searchIcon.gif" alt="검색"></button>
										</div>
									</div>
								</fieldset>
							</div>
						<!--검색조건 E-->
						<p class="head mt10">F/W 구분 : ${searchParam.firmwareClsName} / Ver : ${searchParam.firmwareVer}</p>
						<p class="tb_numlist">총 ${paginationInfo.getTotalRecordCount() } 건</p>
						<table class="tb_type01">
							<colgroup>
								<col style="width:auto" />
								<col style="width:25%" />
								<col style="width:25%" />
								<col style="width:25%" />
							</colgroup>
							<thead>
								<tr>
									<th>단말기 ID</th>
									<th>처리결과</th>
									<th>요청일시</th>
									<th>처리일시</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach var="result" items="${firmwareUpdateResultList }" varStatus="status">
						        <tr>
						            <td>
						                ${result.deviceId }
						            </td>
						            <td>
						            	${result.successYn == 'Y' ? '성공' : '실패'}
					            	</td>
						            <td>
						                ${result.reqDttm }
						            </td>
						            <td>
						                ${result.processDttm }
						            </td>
						        </tr>
						    </c:forEach>
						    <c:if test='${fn:length(firmwareUpdateResultList) == 0}'>
						        <tr>
						            <td style="text-align:center" colspan="4"><spring:message code="search.nodata.msg" /></td>
					            </tr>
					        </c:if>
							</tbody>
						</table>
					<c:choose>
						<c:when test="${fn:length(firmwareUpdateResultList) > 0}">
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
							<span class="left"><button class="btnType01 bc_gray" id="fwListBtn">목록</button></span>
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
		fwUpdate.initBtn();
		
		$("input:hidden[name='firmwareSeq']").val("${searchParam.firmwareSeq}");
		$("input:hidden[name='firmwareClsName']").val("${searchParam.firmwareClsName}");
		$("input:hidden[name='firmwareVer']").val("${searchParam.firmwareVer}");
		$("#successYn").val("${searchParam.successYn}");
		$("#deviceId").val("${searchParam.deviceId}");
		$("#processStrDate").val("${searchParam.processStrDate}");
		$("#processEndDate").val("${searchParam.processEndDate}");
		
		var totalPageCount = '${paginationInfo.totalPageCount}' == '' ? 1 : Number('${paginationInfo.totalPageCount}');
   		$('#prevPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			fwUpdate.pageSelect(currentPageNo-1);
		});
		$('#nextPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			fwUpdate.pageSelect(currentPageNo+1);
		});
		$('#movePage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			var regExp = /^[1-9]?[0-9]/;
			if(!regExp.test(currentPageNo) ||(totalPageCount < currentPageNo)){
				alert('현재 페이지 값이 정상적이지 않습니다.');
			}else{
				fwUpdate.pageSelect(currentPageNo);
			}
		});
	});
	
	var fwUpdate = {};
	fwUpdate.initBtn = function () {
		$("#searchBtn").on("click", this.searchForm);
		$("#fwListBtn").on("click", this.moveFwList);
	};
	
	fwUpdate.pageSelect = function(cPage) {
	    $("[name='currentPageNo']").val(cPage);
	    $("#fwUpdateFrm").attr({method : "post", action : "/admin/manage/interworkMgmt/listFirmwareUpdateResult.do"}).submit();
	    
	    return false;
	};
	
	fwUpdate.searchForm = function(e) {
		if(DateUtil.checkDateTerm( $( "[name='processStrDate']").val(),  $( "[name='processEndDate']").val()) !== 'ok') {
            alert("검색 조건의 시작 날이 종료 날보다 큽니다.");
            return false;
        }
		
		$("[name='currentPageNo']").val(1);
	    $("#fwUpdateFrm").attr({method : "post", action : "/admin/manage/interworkMgmt/listFirmwareUpdateResult.do"}).submit();
	    
	    return false;
	};
	
	fwUpdate.moveFwList = function(e) {
		$("[name='currentPageNo']").val(1);
		$("#fwUpdateFrm").attr({method : "post", action : "/admin/manage/interworkMgmt/listFirmware.do"}).submit();
		
		return false;
	};
</script>
</body>
</html>