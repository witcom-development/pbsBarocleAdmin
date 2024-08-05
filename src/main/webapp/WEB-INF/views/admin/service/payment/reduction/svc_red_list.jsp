<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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
                <!--conteent S-->
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
						<form id="frm"></form>
                        <form id="searchFrm" name="searchFrm">
							<div class="shBox">
			                    <input type="hidden" name="viewFlg" value="" />
			                    <input type="hidden" name="paymentMethodCdName" value="" />
			                    <input type="hidden" name="paymentSeq" value="" />
			                    <input type="hidden" name="paymentDttm" value="" />
			                    <fieldset>
									<legend>검색조건</legend>
									<div class="shBoxSection">
										<div class="section">
											<label for="bb22" class="laType02">등록일</label>
											<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" id="bb22" name="startReductionDttm" readonly/></span>
											<span class="dash">~</span>
											<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" name="endReductionDttm" readonly/></span>
										</div>
										<div class="section pright">
											<label for="usrSearchType" class="laType02">감면자</label>
											<select class="select-category06" id="usrSearchType" name="usrSearchType">
												<option value="">선택</option>
											</select>
											<span class="input-text08"><input type="text" class="" maxlength=20 name="usrSearchKey"></span>
										</div>
										<div class="section">
											<label for="bb33" class="laType02">감면구분</label>
											<select class="select-category01" id="reductionType" name="reductionType">
												<option value="">선택</option>
											</select>
											<button class="btn-srh03 btncase1" id="searchBtn"><img src="/images/searchIcon.gif" alt="검색"></button>
										</div>
									</div>
								</fieldset>
							</div>
						<!--검색조건 E-->
						<p class="tb_numlist">총 ${paginationInfo.getTotalRecordCount()} 건</p>
						<table class="tb_type01">
							<colgroup>
								<col style="width:14%"/>
								<col style="width:14%"/>
								<col style="width:14%"/>
								<col style="width:8%"/>
								<col style="width:8%"/>
								<col style="width:15%"/>
								<!--[if gt IE 8]><!--><col style="width:19%" class="mhid"/><!--<![endif]-->
							</colgroup>
							<thead>
								<tr>
									<th>이름</th>
									<th>감면 구분</th>
									<th>사실여부</th>
									<th>한부모 사실 여부</th>
									<th>건수</th>
									<th>결과 </th>
									<!--[if gt IE 8]><!--><th class="mhid">등록일시</th><!--<![endif]-->
								</tr>
							</thead>
							<tbody>
							<c:forEach var="result" items="${reductionList}" varStatus="status">
								<tr>
									<td>${result.tgtrNm}</td>
									<td>
										<c:choose>
										<c:when test="${result.reductionType eq 'RDT_001'}">
										국가유공자
										</c:when>
										<c:when test="${result.reductionType eq 'RDT_002'}">
										기초생활수급자
										</c:when>
										<c:when test="${result.reductionType eq 'RDT_003'}">
										한부모가족
										</c:when>
										</c:choose>
									</td>
									<td>${result.fctYn}</td>
									<td>${result.oprnYn}</td>
									<td>${result.cnt}</td>
									<td>${result.resultYn}</td>
									<!--[if gt IE 8]><!--><td class="mhid tc">${result.regDttm}</td><!--<![endif]-->
								</tr>
							</c:forEach>
							</tbody>
						</table>
						<c:if test='${fn:length(reductionList) == 0}'>
						<table class="tb_type01 mbt0">
							<tr>
								<td style="text-align:center"><spring:message code="search.nodata.msg" /></td>
							</tr>
						</table>
						</c:if>
					<c:choose>
						<c:when test="${fn:length(reductionList) > 0}">
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
						<div class="btnArea tr">
							<!--[if gt IE 8]><!--><!-- <button class="btnType01 mhid" id="excelViewBtn">엑셀</button> --><!--<![endif]-->
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
        //initialize
        reduction.commonCode();
        reduction.initBtn();

        var calDay = new Date();
        var dayOfMonth = calDay.getDate();
        calDay.setDate(dayOfMonth - 7);
        var startDay = DateUtil.dateFmt(calDay);
        var endDay = DateUtil.dateFmt(new Date());
        
        var sDate = '${searchCondition.startReductionDttm}' !== '' ? '${searchCondition.startReductionDttm}' : startDay;
        var eDate = '${searchCondition.endReductionDttm}' !== '' ? '${searchCondition.endReductionDttm}' : endDay;
        var usrSearchKey = '${searchCondition.usrSearchKey}' !== '' ? '${searchCondition.usrSearchKey}' : '';
        
        $("[name='startReductionDttm']").val(sDate);
        $("[name='endReductionDttm']").val(eDate);
        $("[name='usrSearchKey']").val(usrSearchKey);
        
        $("#usrSearchType").trigger('change');
        
        var totalPageCount = '${paginationInfo.totalPageCount}' == '' ? 1 : Number('${paginationInfo.totalPageCount}');
   		$('#prevPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			reduction.pageSelect(currentPageNo-1);
		});
		$('#nextPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			reduction.pageSelect(currentPageNo+1);
		});
		$('#movePage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			var regExp = /^[1-9]?[0-9]/;
			if(!regExp.test(currentPageNo) ||(totalPageCount < currentPageNo)){
				alert('현재 페이지 값이 정상적이지 않습니다.');
			}else{
				reduction.pageSelect(currentPageNo);
			}
		});
    });
    
    
    var reduction = {};
    reduction.usrSearchType = "${searchCondition.usrSearchType}";
    reduction.commonCode = function () {
    	var _this = reduction;
        
      	//사용자
      	customCodeList = [{comCd:"1", comCdName:"이름"}];
      	commCdBox.makeComboBox('CC', _this.usrSearchType, customCodeList, "usrSearchType");
    	commonAjax.getCommonCode("RDT"
                , function(data){
                    if(data !== null && data.codeList !== null) {
                        commCdBox.makeComboBox("CC", '${searchCondition.reductionType}', data.codeList, "reductionType");
                       
                    }
                }
            );
    };
    
    reduction.initBtn = function () {
    	var _this = reduction;
        $("#searchBtn").on("click", this.searchDataFnc);
        $("#excelViewBtn").on("click", this.excelDataFnc);
        
        $("#usrSearchType").on('change', function(e){
        	var tId = e.target.id;
        	var idx = $("#"+tId+" option:selected").index();
        	
        	if(idx > 0) {
        		if(idx < 4){
        			$("[name=usrSearchKey]").attr("readonly",false);
        			$("[name=usrSearchKey]").css("display","");
        			$("[name=paymentMethodCd]").css("display","none");
        			$("[name=paymentMethodCd]").val("");
        			//$("[name=paymentMethodCdName]").val("");
        		} else {
        			$("[name=paymentMethodCd]").css("display","");
        			$("[name=usrSearchKey]").css("display","none");
        		}
        	} else {
        		$("[name=usrSearchKey]").attr("readonly",true);
        		$("[name=usrSearchKey]").css("display","");
        		$("[name=usrSearchKey]").val("");
        		$("[name=paymentMethodCd]").css("display","none");
        		$("[name=paymentMethodCd]").val("");
        		//$("[name=paymentMethodCdName]").val("");
        	}
        });
    };
    
    reduction.searchDataFnc = function(e) {
    	if(DateUtil.checkDateTerm( $( "[name='startReductionDttm']").val(),  $( "[name='endReductionDttm']").val()) !== 'ok') {
            alert("검색 조건의 시작 날이 종료 날보다 큽니다.");
            return false;
        }
    	
    	if(DateUtil.diffDays( $("[name='startReductionDttm']").val(),  $("[name='endReductionDttm']").val(), '-') >= 31){
    		alert("조회기간은 31일 이내로 설정해주세요.");
    		return false;
    	} 
    	
//대여번호_2017.07.04_JHN
    	/* if($("#usrSearchType").val() == "RENT_SERIAL_NO"){
    		var num_check=/^[0-9]*$/;
    		var rentSerialNo = $("[name='usrSearchKey']").val().replace(/[^0-9]/g, '');;
    		
        	if(num_check.test(rentSerialNo)){
        		if(!(rentSerialNo.length == 8)){
        			alert("대여번호는 8자리 숫자만 입력 가능합니다.");
        			return false;
        		} 
        	} else {
        		alert("숫자만 입력할 수 있습니다.");
        		return false;
        	}
    	} */
    	
    	$("[name='usrSearchKey']").val($("[name='usrSearchKey']").val().replace(/ /g, ''));	// 공백제거
    	
        $("input:hidden[name='viewFlg']").val('list');
        $("[name='currentPageNo']").val(1);
        $("#searchFrm").attr({method : "post", action : "<c:out value='/getReductionList.do'/>"}).submit();
    };
    
    reduction.pageSelect = function(cPage) {
        $("input:hidden[name='viewFlg']").val('list');
        $("[name='currentPageNo']").val(cPage);
        $("#searchFrm").attr({method : "post", action : "<c:out value='/getReductionList.do'/>"}).submit();
    };
    </script>
</body>
</html>
