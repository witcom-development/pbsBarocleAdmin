<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
	<tiles:insertAttribute name="header"/>
	<!--모바일 메뉴 E-->
	<!--Head S-->
	<tiles:insertAttribute name="head"/>
	<!--Head E-->
	<div id="body">
		<div class="cont">
			<!--left menu S-->
			<tiles:insertAttribute name="left"/>
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
					<form id="frm"></form>
					<form id="searchFrm" onkeydown="return captureReturnKey(event)">
						<div class="shBox">
							<input type="hidden" name="viewFlg" value="" />
							<input type="hidden" name="returnStationGrpName" value="" />
							<input type="hidden" name="returnStationName" value="" />
							<input type="hidden" name="rentHistSeq" value="" />
							<!-- 대여이력  회원정보 연동 링크 start_cms_20161104 -->
							<input type="hidden" name="usr_seq"	id="usr_seq">
							<!-- end -->
							<!-- <fieldset> -->
								<legend>검색 옵션</legend>
								<div class="shBoxSection">
									<div class="section">
										<label for="bb22" class="laType03">대여일</label>
										<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" id="bb22" name="searchStartDate" readonly/></span>
										<span class="dash">~</span>
										<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" name="searchEndDate"  readonly/></span>
									</div>
									
									<div class="section pright">
										<label for="aa1" class="laType03">구분</label>
										<select class="select-category07" id="searchParameter" name="searchParameter" style="width: 110px;">
											<option value="PHONE">휴대전화번호</option>
											<option value="ID">ID</option>
											<option value="RENT_NO">대여번호</option>
										</select>
										<span class="input-text08"><input type="text" name="searchWord"/></span>
									</div>
									
									<div class="section">
										<label for="a22" class="laType03">반납 아파트</label>
										<select class="select-category03" id="a22" name="returnStationGrpSeq">
											<option value="">선택</option>
										</select>
									</div>
									<div class="section pright">
										<label for="aaa21" class="laType03">반납대여소</label>
										<select class="select-category03" id="aaa21" name="returnStationId">
											<option value="">선택</option>
										</select>
										<button type="button" class="btn-srh03 btncase1" id="searchBtn"><img src="/images/searchIcon.gif" alt="검색" /></button>
									</div>
									<div class="section">
										<label for="a22" class="laType03">자전거구분</label>
										<select class="select-category03" id="a11" name="bikeSeCd">
											<option value="">선택</option>
										</select>
									</div>
								</div>
				   		</div>
					<!--검색조건 E-->
							<p class="tb_numlist mt20">총 ${paginationInfo.getTotalRecordCount()} 건</p>
							<table class="tb_type01">
								<colgroup>
									<col style="width:5%"/>
									<col style="width:18%"/>
									<col style="width:20%"/>
									<col style="width:20%"/>
									<col style="width:12%"/>
									<col style="width:18%"/>
									<!--[if gt IE 8]><!--><col style="width:10%" class="mhid"/><!--<![endif]-->
								</colgroup>
								<thead>
									<tr>
										<th>대여<br/>구분</th>
										<th>대여일시</th>
										<th>대여대여소</th>
										<th>반납대여소</th>
										<th>자전거번호</th>
										<th>회원</th>
										<!--[if gt IE 8]><!--><th class="mhid">이용시간<br/>(분)</th><!--<![endif]-->
									</tr>
								</thead>
								<tbody>
									<c:forEach var="rent" items="${rentList}" varStatus="loop">
									<tr>
										<td class="pl10">${ rent.rentClsCdName}</td>
										<td class="pl10">${ rent.rentDttm}</td>
										<td class="pl10">${ rent.rentStationName}</td>
										<td class="pl10">${ rent.returnStationName}</td>
										<td class="pl10"><a href="#" id="${ rent.rentHistSeq}">${ rent.rentBikeNo}</a></td>
										<%-- 대여이력 기존 소스 start
										<td class="pl10">${ rent.mbId}</td>
										--%>
										<!-- 대여이력 회원정보 연동 링크 start_cms_20161104 -->
										<td class="pl10" ><a href="#"  id="${rent.usrSeq },${rent.voucherSeq}" name="usrSeq" value="${rent.usrClsCd}">${ rent.mbId}</a></td>
										<!-- end -->
										<!--[if gt IE 8]><!--><td class="mhid tr pr10">${ rent.useMi}</td><!--<![endif]-->
									</tr>
									</c:forEach>
								</tbody>
							</table>
							<c:if test="${fn:length(rentList) == 0 }">
							<table class="tb_type01 nbt0">
								<tr><td style="text-align:center"><spring:message code="search.nodata.msg" /></td></tr>
							</table>
							</c:if>
						<c:choose>
							<c:when test="${fn:length(rentList) > 0}">
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
							<!-- <div class="btnArea tr">
								<button class="btnType01 mb10 mhid" id="excelBtn">엑셀</button>
							</div> -->
					  <!-- </fieldset> -->
				   </form>
				</div>
			</div>
			<!--conteent E-->
		</div>
	</div>
	<!--footer S-->
	<tiles:insertAttribute name="footer"/>
	<!--footer E-->
	</div>
	<script type="text/javascript" src="/js/common_barocle.js"></script>
	<script type="text/javascript">
	$(function(){
		rentHist.initBtn();
		rentHist.initCommbo();
		
		var date = new Date;
		date.setDate(date.getDate()-180);
		var fromday = DateUtil.dateFmt(date); /* DateUtil.dateFmt(date); 당일로 변경*/
		var today = DateUtil.dateFmt(new Date());
		var sDate = '${searchCondition.searchStartDate}' !== '' ? '${searchCondition.searchStartDate}' : fromday;
		var eDate = '${searchCondition.searchEndDate}'   !== '' ? '${searchCondition.searchEndDate}' : today;
		
		$( "[name='searchStartDate']").val(sDate);
		$( "[name='searchEndDate']").val(eDate);
		
		var totalPageCount = '${paginationInfo.totalPageCount}' == '' ? 1 : Number('${paginationInfo.totalPageCount}');
		$('#prevPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			rentHist.pageSelect(currentPageNo-1);
		});
		$('#nextPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			rentHist.pageSelect(currentPageNo+1);
		});
		$('#movePage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			var regExp = /^[1-9]?[0-9]/;
			if(!regExp.test(currentPageNo) ||(totalPageCount < currentPageNo)){
				alert('현재 페이지 값이 정상적이지 않습니다.');
			}else{
				rentHist.pageSelect(currentPageNo);
			}
		});
	});
	
	var rentHist = {};
	rentHist.returnStationGrpSeq = '${searchCondition.returnStationGrpSeq}';
	rentHist.returnStationId = '${searchCondition.returnStationId}';
	rentHist.searchWord = '${searchCondition.searchWord}';
	rentHist.searchParameter = '${searchCondition.searchParameter}';
	rentHist.bikeSeCd = '${searchCondition.bikeSeCd}';
	
	rentHist.initBtn = function() {
		var _this = rentHist;
		$("#searchBtn").on('click',{viewType : 'list'},this.exeListPage);
		$("#excelBtn").on('click',{viewType : 'excel'},this.exeListPage);
		
		$("#a22").on('change', function(e){
			var tId = e.target.id;
			var idx = $("#"+tId+" option:selected").index();
			var subList =$("#"+tId).data().sub_data;
			$("#aaa21 option").not(':eq(0)').remove();
			var sltsubData = subList[(idx-1)];
			if(sltsubData !== undefined) {
				if(sltsubData.length > 0) {
					commCdBox.makeComboBox("S", _this.returnStationId, sltsubData, "aaa21");
				}
			}
		});
		$(".tb_type01").on("click","a", this.moveRentHistDetail);
		
		$("[name='searchWord']").val(_this.searchWord);
		
		if(_this.searchParameter == "" || _this.searchParameter == null){
		   	$("[name='searchParameter']").val("PHONE");
		}else{
			$("[name='searchParameter']").val(_this.searchParameter);
		}
	   
	};
	rentHist.initCommbo = function() {
		var _this = rentHist;
		
		//스테이션 
		commonAjax.getStationCode( 
				function(data) {
					if(data != null && data.stationList != null) {
						$("#a22 option").not(':eq(0)').remove();
						commCdBox.makeComboBox('S', _this.returnStationGrpSeq, data.stationList, "a22");
						$("#a22").trigger("change");
					}
				}
		);
	  //자전거 구분
		commonAjax.getCommonCode("BIK", function(data) {
			 if(data !== null && data.codeList !== null) {
				 commCdBox.makeComboBox('CC',_this.bikeSeCd, data.codeList, "a11");
			 }
		});
	};
	rentHist.moveRentHistDetail = function(e) {
		e.preventDefault();
		<%-- 대여이력 회원정보 연동 링크 start_cms_20161104 --%>
		if($(this).attr('name') == "usrSeq"){
//2017.07.03_JHN_비회원 이용절차 개선
//	 		$("#usr_seq").val(e.target.id);
//	 		$("#searchFrm").attr({action: '/admin/service/member/memberInfo.do', method :"post"}).submit();
			var pData = e.target.id.split(",");
			var usrClsCd = $(this).attr('value');
			//alert("usrClsCd = "+usrClsCd);
			if(usrClsCd == "USR_003"){
				$("#frm").empty()
				 .append($('<input>', {type : 'hidden',name : 'serialNoUsrSeq'}).val(pData[0]))
				 .append($('<input>', {type : 'hidden',name : 'serialNoVoucherSeq'}).val(pData[1]))
					 .attr({action:'/admin/service/member/rentSerialNumDetail.do', method : 'post'}).submit();
				//return false;
			} else {
				$("#usr_seq").val(pData[0]);
				$("#searchFrm").attr({action: '/admin/service/member/memberInfo.do', method :"post"}).submit();				
			}
		}else{
			<%-- end --%>	
			$("[name='rentHistSeq']").val(e.target.id);
			$("#searchFrm").attr({action: '/moveRentHistoryDetail.do', method :"post"}).submit();
		}
	};
	rentHist.pageSelect = function(pageNo) {
		rentHist.getRenHistory('list', pageNo);
	};
	rentHist.exeListPage = function(e) {
		e.preventDefault();

		rentHist.getRenHistory(e.data.viewType, 1);
	};
	
	// null 체크
	rentHist.nullCheck = function(value) {
		if (value === null) return true; 
		if (typeof value === 'string' && value === '') return true;
		if (typeof value === 'undefined') return true;
		return false;
	}
	
	rentHist.getRenHistory = function(pVtype, pPageNo) {
		$("#searchFrm").serialize();
		if(pVtype === 'list') {
			if(DateUtil.checkDateTerm( $( "[name='searchStartDate']").val(), $( "[name='searchEndDate']").val())!== 'ok') {
				alert("검색 조건의 시작 날이 종료 날보다 큽니다.");
				return false;
			}
		}
		
		$("[name='searchWord']").val($("[name='searchWord']").val().replace(/ /g, ''));	// 공백제거
		//대여번호_2017.07.04_JHN
		if($("#searchParameter option:selected").val() == "RENT_NO"){
			var num_check=/^[0-9]*$/;
			var rentSerialNo = $("[name='searchWord']").val();
			
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
		
		if ( rentHist.nullCheck(  $("[name='searchWord']").val()) ) {
			alert(  $("[name='searchParameter']").val() + "값이 미입력 되었습니다. ");
			$("[name='searchWord']").focus();
			return false;
		}
		
		$("[name='currentPageNo']").val(pPageNo);
		$("[name='viewFlg']").val(pVtype);
		if(pVtype === "excel") {
			$("[name='returnStationGrpName']").val($("[name='returnStationGrpSeq'] option:selected").text());
			$("[name='returnStationName']").val($("[name='returnStationId'] option:selected").text());
		}
		if($("#searchParameter option:selected").val() == "RENT_NO"){
			if(num_check.test(rentSerialNo)){
				if((rentSerialNo.length == 8)){
					$("#searchFrm").attr({action: '/getRentHistoryList.do', method :"post"}).submit();
				}
			}
		}else{
			$("#searchFrm").attr({action: '/getRentHistoryList.do', method :"post"}).submit();
		}
		
	};
	
	function captureReturnKey(e) {
		if(e.keyCode==13 && e.srcElement.type != 'textarea')
		return false;
	}
	</script>
</body>
</html>