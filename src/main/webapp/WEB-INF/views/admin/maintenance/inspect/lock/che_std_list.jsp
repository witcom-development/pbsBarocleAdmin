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
						<!-- 모바일 검색조건 E-->
						<!--검색조건 S-->
						<form id="searchFrm">
							<div class="shBox">
								<input type="hidden" name="viewFlg" value="" />
                                <input type="hidden" name="repairSeq" value="" />
                                <input type="hidden" name="faultSeq" value="" />
                                <input type="hidden" name="rackStatusName" value="" />
                                <input type="hidden" name="mode" id="mode" value="list" />
                                <input type="hidden" name="stationGrpName" id="stationGrpName" value="" />
                                <input type="hidden" name="stationName" id="stationName" value="" />
								<fieldset>
									<legend>검색 옵션</legend>
									<div class="shBoxSection">
										<div class="section">
											<label for="bb22" class="laType02">발생일자</label>
											<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" name="searchBgnDe" title="선택 날짜" id="bb22" readonly/></span>
											<span class="dash">~</span>
											<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" name="searchEndDe" title="선택 날짜" readonly/></span>
										</div>
										<div class="section pright">
											<label for="aa1" class="laType02">거치대 ID</label>
											<span class="input-text07"><input type="text" name="rackId" class=""/></span>
										</div>
										<div class="section">
											<label for="stationGrpSlt" class="laType02">아파트</label>
											<select class="select-category02" name="stationGrpSeq" id="stationGrpSlt">
                                                <option value="">선택</option>
                                            </select>
										</div>
										<div class="section pright">
											<label for="stationIdSlt" class="laType02">대여소</label>
											<select class="select-category03" name="stationId" id="stationIdSlt">
												<option value="">선택</option>
											</select>
										</div>
										<div class="section repos">
											<label for="a3" class="laType02">조회 구분</label>
											<span class="input-rd01"><input type="radio" name="chkType" value="S" checked="checked"><label for="a3">현황</label></span>
											<span class="input-rd01"><input type="radio" name="chkType" value="H"><label for="a4">이력</label></span>
											<button id="searchBtn" class="btn-srh03 btncase1"><img src="/images/searchIcon.gif" alt="검색"></button>
										</div>

									</div>
								</fieldset>
							</div>
						<!--검색조건 E-->
						<p class="tb_numlist">총 ${paginationInfo.getTotalRecordCount() } 건</p>
						<table class="tb_type01">
							<colgroup>
								<col style="width:20%"/>
								<col style="width:15%"/>
								<col style="width:20%"/>
								<col style="width:20%"/>
								<!--[if gt IE 8]><!--><col style="width:20%" class="mhid"/><!--<![endif]-->
							</colgroup>
							<thead>
								<tr>
									<th>대여소 / 센터</th>
									<th>거치대 번호</th>
									<th>거치대 ID</th>
									<th>점검구분</th>
									<th>발생일시</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="info" items="${InspectLockList }"  varStatus="loop">
	                                <tr>
	                                    <td>${info.stationName }</td>
	                                    <td>${info.stationEquipOrder }</td>
	                                    <td style="display: none;">${info.repairCmptYn}</td>
	                                    <td style="display: none;">${info.repairSeq}</td>
	                                    <td><a href="#" name="rack_id">${info.rackId}</a></td>
	                                	<td style="display: none;">${info.faultSeq}</td>
	                                    <c:choose>
	                                    <c:when test="${info.rackStatusName == '신고'}">
	                                    	<td><a href="/common/pop/DEV_004/showTroubleReportPop.do"  class="winNewPop modal" title="고장신고" data-width="450" data-height="620" data-pmt="&mode=view&faultSeq=${info.faultSeq}">${info.rackStatusName}</a></td>
	                                    </c:when>
										<c:when test="${info.rackStatusName == '정기점검일 초과' && (searchCondition.chkType == 'S' || searchCondition.chkType == null)}">
											<td><a href="/common/pop/DEV_004/showRegularChkPop.do" class="winNewPop modal" title="정기점검" data-width="450" data-height="588" data-pmt="&mode=M&faultSeq=${info.faultSeq}&equipmentId=${info.rackId}">정기점검일 초과</a></td>
										</c:when>
										<c:when test="${info.rackStatusName == '정기점검일 초과' && searchCondition.chkType == 'H'}">
											<td><a href="/common/pop/DEV_004/showRegularChkPop.do" class="winNewPop modal" title="정기점검" data-width="450" data-height="588" data-pmt="&mode=R&equipmentId=${info.rackId}">정기점검일 초과</a></td>
										</c:when>
										<c:otherwise>
											<td>${info.rackStatusName}</td>
										</c:otherwise>
									</c:choose>
	                                    <td>${info.regDttm }</td>
	                                </tr>
                                </c:forEach>
                                <c:if test="${fn:length(InspectLockList) eq 0 }">
	                                <table class="tb_type01 nbt0">
			                            <tr><td style="text-align:center"><spring:message code="search.nodata.msg" /></td></tr>
			                        </table>
								</c:if>
							</tbody>
						</table>
					<c:choose>
						<c:when test="${fn:length(InspectLockList) > 0}">
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
                            <span class="right"><button class="btnType01" id="excelViewBtn" title="엑셀다운로드">엑셀다운로드</button></span>
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
    	inspectLockList.initCombo();
		inspectLockList.initBtn();
		
		var date = new Date;
		date.setDate(date.getDate()-6);
		var fromday = DateUtil.dateFmt(date);
		var today = DateUtil.dateFmt(new Date());
		var sDate = '${searchCondition.searchBgnDe}' !== '' ? '${searchCondition.searchBgnDe}' : fromday;
		var eDate = '${searchCondition.searchEndDe}' !== '' ? '${searchCondition.searchEndDe}' : today;
		var rackId = '${searchCondition.rackId}' !== '' ? '${searchCondition.rackId}' : '';
		var stationGrpSeq = '${searchCondition.stationGrpSeq}' !== '' ? '${searchCondition.stationGrpSeq}' : '';
		var stationId = '${searchCondition.stationId}' !== '' ? '${searchCondition.stationId}' : '';
		var chkType = '${searchCondition.chkType}' !== '' ? '${searchCondition.chkType}' : 'state';
		
		$("[name='searchBgnDe']").val(sDate);
		$("[name='searchEndDe']").val(eDate);
		$("[name='rackId']").val(rackId);
		$("[name='stationGrpSeq']").val(stationGrpSeq);
		$("[name='stationId']").val(stationId);
		$("[name='chkType']:input[value='"+chkType+"']").prop('checked', true);
		
		var totalPageCount = '${paginationInfo.totalPageCount}' == '' ? 1 : Number('${paginationInfo.totalPageCount}');
   		$('#prevPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			inspectLockList.pageSelect(currentPageNo-1);
		});
		$('#nextPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			inspectLockList.pageSelect(currentPageNo+1);
		});
		$('#movePage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			var regExp = /^[1-9]?[0-9]/;
			if(!regExp.test(currentPageNo) ||(totalPageCount < currentPageNo)){
				alert('현재 페이지 값이 정상적이지 않습니다.');
			}else{
				inspectLockList.pageSelect(currentPageNo);
			}
		});
	});
    
    var inspectLockList = {};
    inspectLockList.rackId = '${searchCondition.rackId}';
    inspectLockList.stationGrpSeq = '${searchCondition.stationGrpSeq}';
    inspectLockList.stationId = '${searchCondition.stationId}';
    inspectLockList.chkType = '${searchCondition.chkType}';
    
    inspectLockList.initCombo = function(){
    	var _this = inspectLockList;

    	//스테이션 
        commonAjax.getStationCode( 
                function(data) {
                    if(data != null && data.stationList != null) {
                        commCdBox.makeComboBox('S',_this.stationGrpSeq,data.stationList, "stationGrpSlt");
                        $("#stationGrpSlt").trigger('change');
                    }
                }
        );
    };
    
    inspectLockList.initBtn = function(){
    	var _this = inspectLockList;
    	$("#searchBtn").on("click",{listType: "list"},this.exeListFnc);
    	$("#stationGrpSlt").on('change', function(e){
        	var tId = e.target.id;
        	var idx = $("#"+tId+" option:selected").index();
        	var subList =$("#"+tId).data().sub_data;
        	$("#stationIdSlt option").not(':eq(0)').remove();
        	var sltsubData = subList[(idx-1)];
        	if(sltsubData !== undefined) {
	        	if(sltsubData.length > 0) {
		        	commCdBox.makeComboBox("S",_this.stationId,sltsubData, "stationIdSlt");
	        	}
        	}
        });
    	$("[name='rack_id']").on("click", this.moveEditForm);
    	$("#excelViewBtn").on("click",{listType: "excel"},this.exeExcelFnc);
    }
    
    inspectLockList.exeListFnc = function(e) {
        e.preventDefault();
        var listType = e.data.listType;

        if(DateUtil.checkDateTerm( $( "[name='searchBgnDe']").val(),  $( "[name='searchEndDe']").val()) != 'ok') {
            alert('<spring:message code="fail.input.daterange"/>');
            return false;
        }
        $("[name='currentPageNo']").val(1);
      
        $("#searchFrm").attr({method : 'post', action : '/inspectLockList.do'}).submit();
    };
    
    inspectLockList.exeExcelFnc = function(e) {
        e.preventDefault();
        var listType = e.data.listType;
        $("#mode").val("excel");
        $("#stationGrpName").val($("#stationGrpSlt option:selected").text());
        $("#stationName").val($("#stationIdSlt option:selected").text());
        
        if(DateUtil.checkDateTerm( $( "[name='searchBgnDe']").val(),  $( "[name='searchEndDe']").val()) != 'ok') {
            alert('<spring:message code="fail.input.daterange"/>');
            return false;
        }
        
        $("#searchFrm").attr({method : 'post', action : '/inspectLockList.do'}).submit();
        
        $("#mode").val("list");
    };
    
    inspectLockList.pageSelect = function(pageNo) {
    	
    	$("[name='currentPageNo']").val(pageNo);
    	$("#searchFrm").attr({action :'/inspectLockList.do', method : 'post'}).submit();
    	
    };
    
    inspectLockList.moveEditForm = function (e) {
    	e.preventDefault();
    	
    	var repairCmptYn = $(this).parent().prev().prev().text();
    	if(repairCmptYn == 'N') {
    		$("[name='viewFlg']").val('U');
    	}else if(repairCmptYn == 'Y') {
    		$("[name='viewFlg']").val('U');
    	}else{
    		$("[name='viewFlg']").val('C');
    	}

    	$("[name='faultSeq']").val($(this).parent().next().text());
    	$("[name='repairSeq']").val($(this).parent().prev().text());
    	$("[name='rackId']").val($(this).text());
    	$("[name='rackStatusName']").val($(this).parent().next().next().text());
    	$("[name='stationName']").val($(this).parent().prev().prev().prev().prev().text());
		
    	
    	$("#searchFrm").attr({method : 'post', action : '/moveRepairLockEditForm.do'}).submit();
    };

    function setNewLastChkDttm(pChkDttm) {
    	$("#searchFrm").attr({action :'/inspectLockList.do', method : 'post'}).submit();
    }
    </script>
</body>
</html>