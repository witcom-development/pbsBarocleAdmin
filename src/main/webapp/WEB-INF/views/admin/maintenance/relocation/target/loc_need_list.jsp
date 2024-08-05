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
									<p>검색조건</p><span><button><img src="/images/srh_open.png" alt="검색조건 열기" /></button></span>
								</div>
							</div>
						</div>
						<!-- 모바일 검색조건 E-->
						<!--검색조건 S-->
						<form id="searchFrm">
							<div class="shBox">
								<input type="hidden" name="sortType" id="sortType"/>
								<input type="hidden" name="sortValue" id="sortValue"/>
								<input type="hidden" name="mode" id="mode" value="list" />
                                <input type="hidden" name="stationGrpName" id="stationGrpName" value="" />
                                <input type="hidden" name="stationName" id="stationName" value="" />
                                <input type="hidden" name="thresholdValue" id="thresholdValue" value="" />
                                <input type="hidden" name="viewFlg" value="" />
                                
								<fieldset>
									<legend>검색 옵션</legend>
									<div class="shBoxSection">
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
											<label for="a3" class="laType02">거치율</label>
											<select class="select-category03" name="threshold" id="threshold">
												<option value="">선택</option>
												<option value="high">임계치 초과</option>
												<option value="low">임계치 이하</option>
											</select>
											<button class="btn-srh03 btncase1"><img src="/images/searchIcon.gif" alt="검색"></button>
										</div>
									</div>
								</fieldset>
							</div>
						<!--검색조건 E-->
						<div class="listalign mt20">
                            <select name="sortSlt" class="mr10" id="sortSlt">
                                <option value="">선택</option>
                                <option value="bike">총 자전거 수</option>
                                <option value="cascade">Cascade 수</option>
                            </select>
                            <label><input name="sortVal" id="sortVal" class="vm" type="radio" value="ASC"> 오름차순</label>
                            <label><input name="sortVal" id="sortVal" class="vm ml10" type="radio" value="DESC"> 내림차순</label>
                            <div class=" tb_numlist" style="float: right;">총 ${ paginationInfo.getTotalRecordCount()} 건</div>
                        </div>
						<table class="tb_type01">
							<colgroup>
								<col style="width:20%"/>
								<col style="width:20%"/>
								<col style="width:15%"/>
								<col style="width:15%"/>
								<col style="width:15%"/>
								<col style="width:15%"/>
							</colgroup>
							<thead>
								<tr>
									<th>아파트</th>
									<th>대여소</th>
									<th>거치대수</th>
									<th>반납 가능 수</th>
									<th>Cascade 수</th>
									<th>총 자전거 수</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="result" items="${RelocationNeedList}" varStatus="status">
                                <tr>
                                	<td>${result.stationGrp}</td>
                                	<td>${result.stationName == '' ? result.stationId : result.stationName}</td>
	                                <td>${result.rockCnt}</td>
									<c:choose>
										<c:when test="${result.thresholdValue < result.thresholdLow}">
											<td style="color:red">${result.returnableCnt}</td>
										</c:when>
										<c:when test="${result.thresholdValue > result.thresholdHigh}">
											<td style="color:red">${result.returnableCnt}</td>
										</c:when>
										<c:otherwise>
											<td>${result.returnableCnt}</td>
										</c:otherwise>
									</c:choose>
                                    <td>${result.cascadeRackCnt}</td>
                                    <td>${result.bikeTotCnt}</td>
                                </tr>
                            </c:forEach>    
                            <c:if test="${fn:length(RelocationNeedList) eq 0 }">
								<table class="tb_type01 nbt0">
									<tr><td style="text-align:center"><spring:message code="search.nodata.msg" /></td></tr>
								</table>
							</c:if>
							</tbody>
						</table>
					<c:choose>
						<c:when test="${fn:length(RelocationNeedList) > 0}">
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
   		relocationNeedList.initCombo();
   		relocationNeedList.initBtn();
		
		var today = DateUtil.dateFmt(new Date());
		var sDate = '${searchCondition.searchBgnDe}' !== '' ? '${searchCondition.searchBgnDe}' : today;
		var eDate = '${searchCondition.searchEndDe}' !== '' ? '${searchCondition.searchEndDe}' : today;
		var stationGrpSeq = '${searchCondition.stationGrpSeq}' !== '' ? '${searchCondition.stationGrpSeq}' : '';
		var stationId = '${searchCondition.stationId}' !== '' ? '${searchCondition.stationId}' : '';
		var threshold = '${searchCondition.threshold}' !== '' ? '${searchCondition.threshold}' : '';
		var sortType = '${searchCondition.sortType}' !== '' ? '${searchCondition.sortType}' : '';
		var sortValue = '${searchCondition.sortValue}' !== '' ? '${searchCondition.sortValue}' : '';
		
		$("[name='searchBgnDe']").val(sDate);
		$("[name='searchEndDe']").val(eDate);
		$("[name='stationGrpSeq']").val(stationGrpSeq);
		$("[name='stationId']").val(stationId);
		$("[name='threshold']").val(threshold);
		$("[name='sortType']").val(sortType);
		$("[name='sortSlt']").val(sortType);
		$("[name='sortValue']").val(sortValue);
		if('${searchCondition.sortValue}' != ''){
			$("[name='sortVal']:input[value='${searchCondition.sortValue}']").prop('checked', true);
		}
		
		var totalPageCount = '${paginationInfo.totalPageCount}' == '' ? 1 : Number('${paginationInfo.totalPageCount}');
   		$('#prevPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			relocationNeedList.pageSelect(currentPageNo-1);
		});
		$('#nextPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			relocationNeedList.pageSelect(currentPageNo+1);
		});
		$('#movePage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			var regExp = /^[1-9]?[0-9]/;
			if(!regExp.test(currentPageNo) ||(totalPageCount < currentPageNo)){
				alert('현재 페이지 값이 정상적이지 않습니다.');
			}else{
				relocationNeedList.pageSelect(currentPageNo);
			}
		});
	});
    
    var relocationNeedList = {};
    relocationNeedList.stationGrpSeq = '${searchCondition.stationGrpSeq}';
    relocationNeedList.stationId = '${searchCondition.stationId}';
    
    relocationNeedList.initCombo = function(){
    	var _this = relocationNeedList;

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
    
    relocationNeedList.initBtn = function(){
    	var _this = relocationNeedList;
    	
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
    	$("[name='sortVal']").on("change", this.sortSelect);
    	$("#excelViewBtn").on("click",{listType: "excel"},this.exeExcelFnc);
    }
    
    relocationNeedList.exeListFnc = function(e) {
        e.preventDefault();
        var listType = e.data.listType;
        $("[name='viewFlg']").val(listType);
        if(DateUtil.checkDateTerm( $( "[name='searchBgnDe']").val(),  $( "[name='searchEndDe']").val()) != 'ok') {
            alert('<spring:message code="fail.input.daterange"/>');
            return false;
        }
        $("[name='currentPageNo']").val(1);
      
        $("#searchFrm").attr({method : 'post', action : '/relocationNeedList.do'}).submit();
    };
    
    relocationNeedList.exeExcelFnc = function(e) {
        e.preventDefault();
        var listType = e.data.listType;
        $("[name='viewFlg']").val(listType);
        $("#stationGrpName").val($("#stationGrpSlt option:selected").text());
        $("#stationName").val($("#stationIdSlt option:selected").text());
        $("#thresholdValue").val($("#threshold option:selected").text());
        
        $("[name='sortType']").val($("[name='sortSlt']").val());
		$("[name='sortValue']").val($("#sortVal").val());
		
        $("#searchFrm").attr({method : 'post', action : '/relocationNeedList.do'}).submit();
        
        $("#mode").val("list");
    };
    
    relocationNeedList.pageSelect = function(pageNo) {
    	$("[name='currentPageNo']").val(pageNo);
    	$("[name='viewFlg']").val('list');
    	$("#searchFrm").attr({action :'/relocationNeedList.do', method : 'post'}).submit();
    };

    relocationNeedList.sortSelect = function(e) {
        e.preventDefault();
        if($("[name='sortSlt']").val() == ""){
        	return;
        }
        $("[name='sortType']").val($("[name='sortSlt']").val());
		$("[name='sortValue']").val($(this).val());
		$("[name='viewFlg']").val('list');
    	$("#searchFrm").attr({action :'/relocationNeedList.do', method : 'post'}).submit();
    };
    </script>
</body>
</html>