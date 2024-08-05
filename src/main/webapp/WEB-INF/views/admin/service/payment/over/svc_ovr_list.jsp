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
											<label for="bb22" class="laType02">대여일</label>
											<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" id="bb22" name="startPaymentDttm" readonly/></span>
											<span class="dash">~</span>
											<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" name="endPaymentDttm" readonly/></span>
										</div>
										<div class="section pright">
											<label for="usrSearchType" class="laType02">사용자</label>
											<select id="usrSearchType" name="usrSearchType">
												<option value="">선택</option>
											</select>
											<select id="paymentMethodCd" name="paymentMethodCd" style="display:none">
												<option value="">선택</option>
											</select>
											<span class="input-text08"><input type="text" class="" maxlength=20 name="usrSearchKey"></span>
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
								<col style="width:8%"/>
								<!--[if gt IE 8]><!--><col style="width:19%" class="mhid"/><!--<![endif]-->
							</colgroup>
							<thead>
								<tr>
									<th>아이디</th>
									<th>대여대여소</th>
									<th>반납대여소</th>
									<th>이용시간<br>(분)</th>
									<th>초과시간<br>(분)</th>
									<th>처리구분 </th>
									<th>결제금액</th>
									<!--[if gt IE 8]><!--><th class="mhid">결제일시</th><!--<![endif]-->
								</tr>
							</thead>
							<tbody>
							<% pageContext.setAttribute("newLineChar", "\n"); %>

							<c:forEach var="result" items="${overPaymentList}" varStatus="status">
								<tr>
									<td>${result.usrMainId}</td>
									<c:choose>
                            		<c:when test="${result.rentHistSeq!=null}">
									<td><a href="/common/pop/rentDetailPop.do" class="winNewPop" style="color : #3366FF" title="대여상세" data-width="450" data-height="696" data-pmt="&rentHistSeq=${result.rentHistSeq}">
									${fn:replace(result.rentStationName, newLineChar, "<br/>")}
									</a></td>
									</c:when>
                                    <c:otherwise>
                                    <td>${fn:replace(result.rentStationName, newLineChar, "<br/>")}</td>
                                    </c:otherwise>
                                    </c:choose>
									<td>${fn:replace(result.returnStationName, newLineChar, "<br/>")}</td>
									<td class="tr"><fmt:formatNumber type="number" value="${result.useMi}"/></td>
									<td class="tr"><fmt:formatNumber type="number" value="${result.overMi}"/></td>
									<td>${result.overFeeProcessClsCdName}</td>
									<td class="tr"><fmt:formatNumber type="number" value="${result.overFee}"/></td>
									<!--[if gt IE 8]><!--><td class="mhid tc">${result.paymentDttm}</td><!--<![endif]-->
								</tr>
							</c:forEach>
							</tbody>
						</table>
						<c:if test='${fn:length(overPaymentList) == 0}'>
						<table class="tb_type01 mbt0">
							<tr>
								<td style="text-align:center"><spring:message code="search.nodata.msg" /></td>
							</tr>
						</table>
						</c:if>
					<c:choose>
						<c:when test="${fn:length(overPaymentList) > 0}">
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
        overPay.commonCode();
        overPay.initBtn();

        var calDay = new Date();
        var dayOfMonth = calDay.getDate();
        calDay.setDate(dayOfMonth - 180);
        var startDay = DateUtil.dateFmt(calDay);
        var endDay = DateUtil.dateFmt(new Date());
        
        var sDate = '${searchCondition.startPaymentDttm}' !== '' ? '${searchCondition.startPaymentDttm}' : startDay;
        var eDate = '${searchCondition.endPaymentDttm}' !== '' ? '${searchCondition.endPaymentDttm}' : endDay;
        var usrSearchKey = '${searchCondition.usrSearchKey}' !== '' ? '${searchCondition.usrSearchKey}' : '';
        
        $("[name='startPaymentDttm']").val(sDate);
        $("[name='endPaymentDttm']").val(eDate);
        $("[name='usrSearchKey']").val(usrSearchKey);
        
        $("#usrSearchType").trigger('change');
        
        
        
        var totalPageCount = '${paginationInfo.totalPageCount}' == '' ? 1 : Number('${paginationInfo.totalPageCount}');
   		$('#prevPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			overPay.pageSelect(currentPageNo-1);
		});
		$('#nextPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			overPay.pageSelect(currentPageNo+1);
		});
		$('#movePage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			var regExp = /^[1-9]?[0-9]/;
			if(!regExp.test(currentPageNo) ||(totalPageCount < currentPageNo)){
				alert('현재 페이지 값이 정상적이지 않습니다.');
			}else{
				overPay.pageSelect(currentPageNo);
			}
		});
    });
    
    
    var overPay = {};
    overPay.paymentMethodCd = "${searchCondition.paymentMethodCd}";
    overPay.usrSearchType = "${searchCondition.usrSearchType}";
    overPay.commonCode = function () {
    	var _this = overPay;
        //결제수단
        commonAjax.getCommonCode("BIM", function(data) {
        	 if(data !== null && data.codeList !== null) {
                 commCdBox.makeComboBox('CC', _this.paymentMethodCd,data.codeList, "paymentMethodCd");
             }
        });
      	//사용자
//      	customCodeList = [{comCd:"USR_MPN_NO", comCdName:"휴대폰"},{comCd:"MB_ID", comCdName:"회원ID"},{comCd:"RENT_SERIAL_NO", comCdName:"대여번호"},{comCd:"PAY_MOD", comCdName:"결제수단"}];
      	customCodeList = [{comCd:"USR_MPN_NO", comCdName:"휴대폰"},{comCd:"MB_ID", comCdName:"회원ID"},{comCd:"RENT_SERIAL_NO", comCdName:"대여번호"}];
      	commCdBox.makeComboBox('CC', _this.usrSearchType, customCodeList, "usrSearchType");
    };
    
    overPay.initBtn = function () {
    	var _this = overPay;
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
    
    overPay.searchDataFnc = function(e) {
    	if(DateUtil.checkDateTerm( $( "[name='startPaymentDttm']").val(),  $( "[name='endPaymentDttm']").val()) !== 'ok') {
            alert("검색 조건의 시작 날이 종료 날보다 큽니다.");
            return false;
        }
    	
    	if(DateUtil.diffDays( $("[name='startPaymentDttm']").val(),  $("[name='endPaymentDttm']").val(), '-') >= 181	){
    		alert("조회기간은 180일 이내로 설정해주세요.");
    		return false;
    	} 
    	
    	if(  $("[name='usrSearchKey']").val() == '' ) {
    		
    		alert("조회조건을 입력하시기 바립니다.")
    		return false;
    	}
    	
    	
//대여번호_2017.07.04_JHN
    	if($("#usrSearchType").val() == "RENT_SERIAL_NO"){
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
    	}
    	
    	$("[name='usrSearchKey']").val($("[name='usrSearchKey']").val().replace(/ /g, ''));	// 공백제거
    	
        $("input:hidden[name='viewFlg']").val('list');
        $("[name='currentPageNo']").val(1);
        $("#searchFrm").attr({method : "post", action : "<c:out value='/getOverPaymentList.do'/>"}).submit();
    };
    overPay.excelDataFnc = function(e) {
        $("input:hidden[name='viewFlg']").val('excel');
        $("input:hidden[name='paymentMethodCdName']").val($("#paymentMethodCd option:selected").text());
        $("#searchFrm").attr({method : "post", action : "<c:out value='/getOverPaymentList.do'/>"}).submit();
    };
    overPay.pageSelect = function(cPage) {
        $("input:hidden[name='viewFlg']").val('list');
        $("[name='currentPageNo']").val(cPage);
        $("#searchFrm").attr({method : "post", action : "<c:out value='/getOverPaymentList.do'/>"}).submit();
    };
    </script>
</body>
</html>
