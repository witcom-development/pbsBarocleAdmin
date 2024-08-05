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
								<input type="hidden" name="stationGrpName" value="" />
								<input type="hidden" name="stationName" value="" />
								<input type="hidden" name="viewFlg" value="" />
                                <input type="hidden" name="faultSeq" value="" />
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
						<div class="widscr mt5">
						<table class="tb_type01">
							<colgroup>
								<col style="width:20%"/>
								<col style="width:15%"/>
								<col style="width:20%"/>
								<col style="width:25%"/>
								<col style="width:15%"/>
								<col style="width:20%"/>
							<c:choose>
								<c:when test="${searchCondition.chkType == 'S' || searchCondition.chkType == null}">
								<col style="width:10%"/>
								</c:when>
								<c:when test="${searchCondition.chkType == 'H'}">
								<col style="width:15%"/>
								<col style="width:15%"/>
								</c:when>
							</c:choose>
							</colgroup>
							<thead>
								<tr>
									<th>대여소 / 센터</th>
									<th>거치대 번호</th>
									<th>거치대 ID</th>
									<th>고장사유</th>
									<th>신고자</th>
									<th>신고일시</th>
								<c:choose>
									<c:when test="${searchCondition.chkType == 'S' || searchCondition.chkType == null}">
									<th>확인</th>
									</c:when>
									<c:when test="${searchCondition.chkType == 'H'}">
									<th>점검자</th>		
									<th>점검일시</th>
									</c:when>
								</c:choose>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="info" items="${CheckLockList}"  varStatus="loop">
	                                <tr>
	                                    <td>${info.stationName}</td>
	                                    <td>${info.stationEquipOrder}</td>
	                                    <td>${info.rackId}</td>
										<td>${info.rackStatusName}</td>
										<td>${info.userId}</td>		
										<td>${info.regDttm}</td>
									<c:choose>
										<c:when test="${searchCondition.chkType == 'S' || searchCondition.chkType == null}">
										<td class="tc"><input type="checkbox" name="checkSeq" value="${info.faultSeq}"/></td>
										</c:when>
										<c:when test="${searchCondition.chkType == 'H'}">
										<td>${info.modId}</td>		
										<td>${info.modDttm}</td>
										</c:when>
									</c:choose>
	                                </tr>
                                </c:forEach>
                                <c:if test="${fn:length(CheckLockList) eq 0 }">
	                                <table class="tb_type01 nbt0">
			                            <tr><td style="text-align:center"><spring:message code="search.nodata.msg" /></td></tr>
			                        </table>
								</c:if>
							</tbody>
						</table>
						</div>
					<c:choose>
						<c:when test="${fn:length(CheckLockList) > 0}">
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
						<c:if test="${searchCondition.chkType == 'S'}">
							<span class="right"><button class="btnType01" id="exeAllCheck">전체점검</button></span>
							<span class="right"><button class="btnType01" id="exeSelectCheck">선택점검</button></span>
						</c:if>
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
    	checkLockList.initCombo();
		checkLockList.initBtn();
		
		var date = new Date;
		date.setDate(date.getDate()-6);
		var fromday = DateUtil.dateFmt(date);
		var today = DateUtil.dateFmt(new Date());
		var sDate = '${searchCondition.searchBgnDe}' !== '' ? '${searchCondition.searchBgnDe}' : fromday;
		var eDate = '${searchCondition.searchEndDe}' !== '' ? '${searchCondition.searchEndDe}' : today;
		var rackId = '${searchCondition.rackId}' !== '' ? '${searchCondition.rackId}' : '';
		var stationGrpSeq = '${searchCondition.stationGrpSeq}' !== '' ? '${searchCondition.stationGrpSeq}' : '';
		var stationId = '${searchCondition.stationId}' !== '' ? '${searchCondition.stationId}' : '';
		var chkType = '${searchCondition.chkType}' !== '' ? '${searchCondition.chkType}' : 'S';
		
		$("[name='searchBgnDe']").val(sDate);
		$("[name='searchEndDe']").val(eDate);
		$("[name='rackId']").val(rackId);
		$("[name='stationGrpSeq']").val(stationGrpSeq);
		$("[name='stationId']").val(stationId);
		$("[name='chkType']:input[value='"+chkType+"']").prop('checked', true);
		
		var totalPageCount = '${paginationInfo.totalPageCount}' == '' ? 1 : Number('${paginationInfo.totalPageCount}');
   		$('#prevPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			checkLockList.pageSelect(currentPageNo-1);
		});
		$('#nextPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			checkLockList.pageSelect(currentPageNo+1);
		});
		$('#movePage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			var regExp = /^[1-9]?[0-9]/;
			if(!regExp.test(currentPageNo) ||(totalPageCount < currentPageNo)){
				alert('현재 페이지 값이 정상적이지 않습니다.');
			}else{
				checkLockList.pageSelect(currentPageNo);
			}
		});
	});
    
    var checkLockList = {};
    checkLockList.rackId = '${searchCondition.rackId}';
    checkLockList.stationGrpSeq = '${searchCondition.stationGrpSeq}';
    checkLockList.stationId = '${searchCondition.stationId}';
    checkLockList.chkType = '${searchCondition.chkType}';
    
    checkLockList.initCombo = function(){
    	var _this = checkLockList;

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
    
    checkLockList.initBtn = function(){
    	var _this = checkLockList;
    	$("#searchBtn").on("click",{listType: "list"},this.exeListFnc);
    	$("#excelViewBtn").on("click",{listType : "excel"},this.exeListFnc);
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
    	$("#exeSelectCheck").on("click", this.exeSelectCheck);
    	$("#exeAllCheck").on("click", this.exeAllCheck);
    }
    
    checkLockList.exeListFnc = function(e) {
        e.preventDefault();
        var listType = e.data.listType;

        if(DateUtil.checkDateTerm( $( "[name='searchBgnDe']").val(),  $( "[name='searchEndDe']").val()) != 'ok') {
            alert('<spring:message code="fail.input.daterange"/>');
            return false;
        }

        if( listType === 'excel') {
             $("input:hidden[name='stationGrpName']").val($("#stationGrpSlt option:selected").text());
             $("input:hidden[name='stationName']").val($("#stationIdSlt option:selected").text());
             $("input:hidden[name='chkType']").val($("#chkType option:checked").val());
    	}
        
        $("[name='currentPageNo']").val(1);
        
        $("[name='viewFlg']").val(listType);
        $("#searchFrm").attr({method : 'post', action : '/checkLockList.do'}).submit();
    };
    
    checkLockList.pageSelect = function(pageNo) {
    	
    	$("[name='currentPageNo']").val(pageNo);
    	$("[name='viewFlg']").val('list');
    	$("#searchFrm").attr({action :'/checkLockList.do', method : 'post'}).submit();
    	
    };
    
    checkLockList.exeSelectCheck = function(e){
    	e.preventDefault();
    	if($('[name="checkSeq"]:checked').val() != undefined){
			if(confirm('<spring:message code="common.save.msg"/>')){
		    	var faultSeq = "";
		    	$('[name="checkSeq"]:checked').each(function(idx){
		    		if(faultSeq.length == 0){
		    			faultSeq = $(this).val();
		    		}else{
		    			faultSeq = faultSeq + "," + $(this).val();
		    		}
		    	});
		    	
		    	$('[name="faultSeq"]').val(faultSeq);
		    	commonAjax.postAjax("/exeLockSelectCheck.do", 'json', $("#searchFrm").serialize()
		   			, function(data){
		   	        	if(data.resultMessage == 'Success'){
		   	        		alert('점검이 완료되었습니다.');
		   	        		$("#searchFrm").attr({method :"post", action :"/checkLockList.do"}).submit();
		   	        	}else{
		   	        		alert('오류가 발생하였습니다.');
		   	        	}
		           	}
		        );
	    	}
    	}else{
    		alert("선택된 값이 없습니다.");
    	}
    }

    checkLockList.exeAllCheck = function(e){
    	e.preventDefault();
    	if($('[name="chkType"]:checked').val() != 'S'){
    		alert('전체점검은 조회구분이 현황일 경우에만 가능합니다.');
    		return;
    	}
		if(confirm('<spring:message code="common.save.msg"/>')){
	    	commonAjax.postAjax("/exeLockAllCheck.do", 'json', $("#searchFrm").serialize()
	   			, function(data){
	   	        	if(data.resultMessage == 'Success'){
	   	        		alert('점검이 완료되었습니다.');
	   	        		$("#searchFrm").attr({method :"post", action :"/checkLockList.do"}).submit();
	   	        	}else{
	   	        		alert('오류가 발생하였습니다.');
	   	        	}
	           	}
	        );
		}
    }
    
    </script>
</body>
</html>