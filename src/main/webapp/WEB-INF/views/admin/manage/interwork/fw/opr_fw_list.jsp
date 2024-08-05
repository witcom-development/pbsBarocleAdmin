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
						<form id="fwFrm" name="fwFrm">
							<div class="shBox">
							<input type="hidden" name="viewFlg"/>
							<input type="hidden" name="firmwareSeq"/>
							<input type="hidden" name="firmwareClsName"/>
							<input type="hidden" name="firmwareVer"/>
								<fieldset>
									<legend>검색조건</legend>
									<div class="shBoxSection">
										<div class="section">
											<label for="modStrDate" class="laType02">수정일</label>
											<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" id="modStrDate" name="modStrDate" readonly/></span>
											<span class="dash">~</span>
											<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" id="modEndDate" name="modEndDate" readonly/></span>
										</div>
										<div class="section pright">
                                            <label for="firmwareClsCd" class="laType02">구분</label>
                                            <select class="select-category01" id="firmwareClsCd" name="firmwareClsCd">
                                               <option value="">선택</option>
                                            </select>
											<button class="btn-srh03 btncase1" id="searchBtn"><img src="/images/searchIcon.gif" alt="검색" /></button>
										</div>
										<div class="section">
											<label for="deviceModlCd" class="laType02">장치구분</label>
											<select class="select-category01" id="deviceModlCd" name="deviceModlCd">
												<option value="">선택</option>
												<!-- <option value="DM2">단말기</option> -->
												<option value="DM4">QR단말기</option>
												<!-- 2020-02-06 전기단말기도 DM4로 수정 -->
												<!-- <option value="DM4">전기단말기</option> -->
											</select>
										</div>
									</div>
								</fieldset>
							</div>
						<!--검색조건 E-->
						<p class="tb_numlist">총 ${paginationInfo.getTotalRecordCount() } 건</p>
						<table class="tb_type01" id="urlTable">
							<colgroup>
								<col style="width:15%" />
								<col style="width:auto" />
								<col style="width:auto" />
								<col style="width:auto" />
								<col style="width:15%" />
								<col style="width:20%" />
								<col style="width:20%" />
							</colgroup>
							<thead>
								<tr>
									<th>구분</th>
									<th>단말기<br>구분</th>
									<th>제조사</th>
									<th>F/W Ver</th>
									<th>F/W SIZE (MB)</th>
									<th>수정일</th>
									<th>실행결과(성공/실패)</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach var="result" items="${firmwareList }" varStatus="status">
						        <tr>
 						            <td>
						                ${result.firmwareClsName }
						            </td>
						            <td style="text-align:center">
						            	<c:choose>
						            	<%-- <c:when test="${result.deviceModlCd eq 'DM2'}">단말기</c:when> --%>
						            	<c:when test="${result.deviceModlCd eq 'DM4'}">QR단말기</c:when>
						            	<%-- <c:when test="${result.deviceModlCd eq 'DM5'}">전기단말기</c:when> --%>
						            	</c:choose>
						            </td>
						           <td style="text-align:center">
						            	<c:if test='${result.companyName == null}'>
						            	-
						            	</c:if>
						                 ${result.companyName}
						            </td>
						            <td>
						                <a href="#" id="ver,${result.firmwareSeq }">${result.firmwareVer }</a>
						            </td>
						            <td >
						                ${result.binSize }
						            </td>
						            <td>
						                ${result.regDttm }
						            </td>
						            <td>
						                <a href="#" id="rst,${result.firmwareSeq },${result.firmwareClsName },${result.firmwareVer }">${result.successCnt }/${result.failCnt }</a>
						            </td>
						        </tr>
						    </c:forEach>
							<c:if test='${fn:length(firmwareList) == 0}'>
						        <tr>
						            <td style="text-align:center" colspan="7"><spring:message code="search.nodata.msg" /></td>
					            </tr>
					        </c:if>
							</tbody>
						</table>
					<c:choose>
						<c:when test="${fn:length(firmwareList) > 0}">
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
							<span class="right"><button class="btnType01 bc_green" name="fwRegBtn" id="fwRegBtn">등록</button></span>
<%-- 							<a href="<c:out value='/ap/openUploadPop.do'/>" id="bulkUploadBtn" class="winNewPop btnType01" title="엑셀 파일 업로드" data-width="450" data-height="235" data-pmt="">일괄등록</a> --%>
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
		fw.initBtn();
		fw.commonCode();
		
		$("#modStrDate").val("${searchParam.modStrDate}");
		$("#modEndDate").val("${searchParam.modEndDate}");
		$("#deviceModlCd").val("${searchParam.deviceModlCd}");
		
		var totalPageCount = '${paginationInfo.totalPageCount}' == '' ? 1 : Number('${paginationInfo.totalPageCount}');
   		$('#prevPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			fw.pageSelect(currentPageNo-1);
		});
		$('#nextPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			fw.pageSelect(currentPageNo+1);
		});
		$('#movePage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			var regExp = /^[1-9]?[0-9]/;
			if(!regExp.test(currentPageNo) ||(totalPageCount < currentPageNo)){
				alert('현재 페이지 값이 정상적이지 않습니다.');
			}else{
				fw.pageSelect(currentPageNo);
			}
		});
	});
	
	var fw = {};
	fw.initBtn = function () {
		$("#searchBtn").on("click", this.searchForm);
		$("#urlTable > tbody > tr").on("click", "a", this.moveForm);
		$("#fwRegBtn").on("click", this.moveRegForm);
	};
	
	fw.commonCode = function () {
	    //상태코드
		commonAjax.getCommonCode("FWD", function(data) {
			if(data !== null && data.codeList !== null) {
				commCdBox.makeComboBox('CC', "${searchParam.firmwareClsCd}", data.codeList, "firmwareClsCd");	
			}
	    })
	};
	
	fw.pageSelect = function(cPage) {
	    $("[name='currentPageNo']").val(cPage);
	    $("#fwFrm").attr({method : "post", action : "/admin/manage/interworkMgmt/listFirmware.do"}).submit();
	    
	    return false;
	};
	
	fw.searchForm = function(e) {
		if(DateUtil.checkDateTerm( $( "[name='modStrDate']").val(),  $( "[name='modEndDate']").val()) !== 'ok') {
            alert("검색 조건의 시작 날이 종료 날보다 큽니다.");
            return false;
        }
		
		$("[name='currentPageNo']").val(1);
	    $("#fwFrm").attr({method : "post", action : "/admin/manage/interworkMgmt/listFirmware.do"}).submit();
	    
	    return false;
	};
	
	fw.moveForm = function(e) {
		
		var firmwareInfo = (e.target.id).split(",");
		
		
		if(firmwareInfo[0] == 'ver') {
			$("input:hidden[name='viewFlg']").val('U');
			$("input:hidden[name='firmwareSeq']").val(firmwareInfo[1]);
		    $("#fwFrm").attr({method : "post", action : "/admin/manage/interworkMgmt/formFirmware.do"}).submit();
		} else if(firmwareInfo[0] == 'rst') {
			$("input:hidden[name='firmwareSeq']").val(firmwareInfo[1]);
			$("input:hidden[name='firmwareClsName']").val(firmwareInfo[2]);
			$("input:hidden[name='firmwareVer']").val(firmwareInfo[3]);
			$("[name='currentPageNo']").val(1);
		    $("#fwFrm").attr({method : "post", action : "/admin/manage/interworkMgmt/listFirmwareUpdateResult.do"}).submit();
		}
		
		return false;
	};

	fw.moveRegForm = function(e) {
		$("input:hidden[name='viewFlg']").val('I');
		$("#fwFrm").attr({method : "post", action : "/admin/manage/interworkMgmt/formFirmware.do"}).submit();
		// $("#fwFrm").attr({method : "post", action : "/admin/manage/interworkMgmt/listFirmwareUpdateResult.do"}).submit();
		
		return false;
	};
</script>
</body>
</html>