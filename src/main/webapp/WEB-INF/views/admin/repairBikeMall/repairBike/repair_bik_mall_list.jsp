<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" /> 
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />
<meta name="description=" Content="" />
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
                                <input type="hidden" name="bikeId" value="" />
                                <input type="hidden" name="repairSeq" value="" />
                                <input type="hidden" name="msg" value="" />
								<fieldset>
									<legend>검색 옵션</legend>
									<div class="shBoxSection">
										<div class="section">
											<label for="bb22" class="laType02">등록일</label>
											<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" name="searchBgnDe" title="선택 날짜" id="bb22" readonly/></span>
											<span class="dash">~</span>
											<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" name="searchEndDe" title="선택 날짜" readonly/></span>
										</div>
										<div class="section pright">
											<label for="a1" class="laType02">상태</label>
											<span>
												<span class="input-rd01"><input type="radio" id="a2" name="repairYn" value="A" <c:if test="${searchCondition.repairYn!='S|H'}">checked="checked"</c:if>/><label for="a2">전체</label></span>
												<span class="input-rd01"><input type="radio" id="a3" name="repairYn" value="S" <c:if test="${searchCondition.repairYn=='S'}">checked="checked"</c:if>/><label for="a3">수리중</label></span>
												<span class="input-rd01"><input type="radio" id="a4" name="repairYn" value="H" <c:if test="${searchCondition.repairYn=='H'}">checked="checked"</c:if>/><label for="a4">수리완료</label></span>
											</span>
										</div>
										
										<div class="section pright">
											<c:if test="${userSessionVO.usrGrpCd ne 21}">
											<label for="a11" class="laType02">점포명</label>
											<!-- 점포명으로 검색할 경우 등록일 선택 필수!! -->
											<select class="select-category02" name="centerId">
											<option value="">선택</option>
											<c:forEach var="bikeMall" items="${bikeMallList}" varStatus="status">
												<option value="${bikeMall.centerId}" <c:if test="${bikeMall.centerId eq searchCondition.centerId}">selected</c:if>>${bikeMall.centerName}</option>
											</c:forEach>
											</select>
											</c:if> 
											<button id="searchBtn" class="btn-srh03 btncase1"><img src="/images/searchIcon.gif" alt="검색" id="searchBtn"></button>
										</div>
									</div>
								</fieldset>
							</div>
						<!--검색조건 E-->
						<div class="lralign mt20">
							<p>당일수리 : ${todayRepairCnt } 건 / 금월수리 : ${monthRepairCnt }건</p>
							<p>총 ${ paginationInfo.getTotalRecordCount()} 건</p>
						</div>
						<%-- <p class="tb_numlist"></p>
						<p class="tb_numlist">총 ${ paginationInfo.getTotalRecordCount()} 건</p> --%>
						<table class="tb_type01 mt20">
							<colgroup>
								<col style="width:7%"/>
								<col style="width:15%"/>
								<col style="width:15%"/>
								<col style="width:25%"/>
								<col style="width:19%"/>
								<col style="width:19%"/>
							</colgroup>
							<thead>
								<tr>
									<th>회수요청<input type="checkbox" id="chkAll"/></th>
									<th>자전거 번호</th>
									<th>인수일자</th>
									<th>고장내역</th>
									<th>수리상태</th>
									<th>검수확인</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="result" items="${RepairBikeList}" varStatus="status">
								<tr>
									<td style="display: none;">${result.repairOursrcSeq}</td>
									<%-- <td style="display: none;">${result.collectYn}</td> --%>
									<%-- <td class="tc"><input type="checkbox" name="checkSeq" value="${result.repairOursrcSeq}"/></td> --%>
										<c:choose>
										<c:when test="${result.repairYn eq 'H' && result.collectYn eq 'N'}">
											<td class="tc"><input type="checkbox" name="checkSeq" value="${result.repairOursrcSeq},${result.centerName},${result.bikeNo},${result.districtCd}"/></td>
										</c:when>
										<c:otherwise>
											<td class="tc"></td>
										</c:otherwise>
									</c:choose>
									<td class="tc">${result.bikeNo}</td>
									<fmt:parseDate var="dateString" value="${result.takeDttm }" pattern="yyyy-MM-ddHH:mm:ss" />
									<td class="tc"><fmt:formatDate value="${dateString}" pattern="yyyy-MM-dd"/></td>
									<td class="tc"><%-- ${result.brokenType} --%>
										<fmt:parseNumber value="${result.brokenType}" integerOnly="true" var="brkCnt" scope="page"/>
										<c:choose>
											<c:when test="${result.brokenType=='1'}">
												<a href="<c:out value='/moveBrokenParts.do'/>"
													class="winNewPop" title="고장내용 상세" 
				                                    data-width="450" data-height="300"
				                                    data-pmt="&viewFlg=view&repairOursrcSeq=${result.repairOursrcSeq}&collectYn=${result.collectYn}">기본교정</a>
				                            </c:when>
											<c:otherwise>
												<a href="<c:out value='/moveBrokenParts.do'/>"
													class="winNewPop" title="고장내용 상세" 
				                                    data-width="450" data-height="300"
				                                    data-pmt="&viewFlg=view&repairOursrcSeq=${result.repairOursrcSeq}&collectYn=${result.collectYn}">기본교정 외 <c:out value="${brkCnt-1 }"/>건</a>
											</c:otherwise>
										</c:choose>
									</td>
									<td class="tc"><%-- ${result.repairYn} --%>
										<c:if test="${result.repairYn eq 'H'}">수리완료</c:if>
										<c:if test="${result.repairYn eq 'S'}">
											<button class="btnType02" id="btnRepair">완료처리</button>
											<!-- <a href="#" class="btnType02" name="btnRepair">완료처리</a> -->
										</c:if>
									</td>
									<td class="tc">
										<c:if test="${result.collectYn eq 'Y'}">검수완료</c:if>
										<c:if test="${result.collectYn eq 'N'}">검수예정</c:if>
									</td>
								</tr>								
								</c:forEach>
								<c:if test="${fn:length(RepairBikeList) eq 0 }">
									<table class="tb_type01 nbt0">
										<tr><td style="text-align:center"><spring:message code="search.nodata.msg" /></td></tr>
									</table>
								</c:if>
							</tbody>
						</table>  
						<c:choose>
						<c:when test="${fn:length(RepairBikeList) > 0}">
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
						</form>
						</div>
						<div class="btnArea">
							<span class="right">
								<button class="btnType01 bc_green mb10" id="sendSMS">회수요청</button>
							</span>
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
   		repairBikeList.initBtn();
   		
   		$("#chkAll").on("click", function(e){
	        if( $("#chkAll").prop("checked")) {
	            $(".tb_type01 > tbody > tr").find('input:checkbox').prop("checked", true);
	        } else {
	            $(".tb_type01 > tbody > tr").find('input:checkbox').prop("checked", false);
	        }
	     });
		
		var totalPageCount = '${paginationInfo.totalPageCount}' == '' ? 1 : Number('${paginationInfo.totalPageCount}');
   		$('#prevPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			repairBikeList.pageSelect(currentPageNo-1);
		});
		$('#nextPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			repairBikeList.pageSelect(currentPageNo+1);
		});
		$('#movePage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			var regExp = /^[1-9]?[0-9]/;
			if(!regExp.test(currentPageNo) ||(totalPageCount < currentPageNo)){
				alert('현재 페이지 값이 정상적이지 않습니다.');
			}else{
				repairBikeList.pageSelect(currentPageNo);
			}
		});
	});

	$(".btnType02").click(function(){ 	/// 수리완료처리
    	var seq = $(this).parent().prev().prev().prev().prev().prev().text();
    	$.ajax({
			url : "/updateRepairTnsBikeAjax.do",
			type : "post",
			dataType : "json",
			data : {repairOursrcSeq:seq},
			async : false,
	   		beforeSubmit: function (data,form,option) {
				return true;
			},
			success : function(data){
				if(data.resultMessage == "Success"){
					alert("수리 완료 처리 되었습니다.");
					location.reload();
				}
			},
			error : function(jqXHR, textStatus,errorThrown){
				if(jqXHR.status === 500 || jqXHR.status === 200){
					alert("에러가 발생했습니다. : " + textStatus);
				}
			}
		});
	});
    
	var repairBikeList = {};
    
    repairBikeList.initBtn = function(){
    	var date = new Date;
		date.setDate(date.getDate()-6);
		var fromday = DateUtil.dateFmt(date);
		var today = DateUtil.dateFmt(new Date());
		var sDate = '${searchCondition.searchBgnDe}' !== '' ? '${searchCondition.searchBgnDe}' : '';
		var eDate = '${searchCondition.searchEndDe}' !== '' ? '${searchCondition.searchEndDe}' : '';
		
		$("[name='searchBgnDe']").val(sDate);
		$("[name='searchEndDe']").val(eDate);
		
    	$("#searchBtn").on("click",{listType: "list"},this.exeListFnc);
    	//$("#btnRepair").on("click", this.repairBikeYn);
    	$("#sendSMS").on("click", this.sendSmsForm);
    	
    	
    }
    
    repairBikeList.exeListFnc = function(e) {
        e.preventDefault();
        var listType = e.data.listType;

        if($("[name='searchBgnDe']").val() != '' && $( "[name='searchEndDe']").val() != ''){
	        if(DateUtil.checkDateTerm( $( "[name='searchBgnDe']").val(),  $( "[name='searchEndDe']").val()) != 'ok') {
	            alert('<spring:message code="fail.input.daterange"/>');
	            return false;
	        }
	        if(DateUtil.diffDays( $("[name='searchBgnDe']").val(),  $("[name='searchEndDe']").val(), '-') >= 365){
	    		alert("조회기간은  1년 이내로 설정해주세요.");
	    		return false;
	    	}
        }

        $("[name='currentPageNo']").val(1);
        
        $("[name='viewFlg']").val(listType);
        $("#searchFrm").attr({method : 'post', action : '/transRepairBikeList.do'}).submit();
    };
    
    repairBikeList.pageSelect = function(pageNo) {
    	$("[name='currentPageNo']").val(pageNo);
    	$("[name='viewFlg']").val('list');
    	$("#searchFrm").attr({action :'/transRepairBikeList.do', method : 'post'}).submit();
    };
    
    repairBikeList.repairBikeYn = function (e) {
    	e.preventDefault();
    	//alert(11111);
    	//$("#searchFrm").attr({method : 'post', action : '/moveTransferBikeEditForm.do'}).submit();
    	var seq = $(this).parent().prev().prev().prev().prev().prev().text();
    	//alert(seq);
    	
    	$.ajax({
			url : "/updateRepairTnsBikeAjax.do",
			type : "post",
			dataType : "json",
			data : {repairOursrcSeq:seq},
			async : false,
	   		beforeSubmit: function (data,form,option) {
				return true;
			},
			success : function(data){
				if(data.resultMessage == "Success"){
					alert("수리 완료 처리 되었습니다.");
					location.reload();
				}
			},
			error : function(jqXHR, textStatus,errorThrown){
				if(jqXHR.status === 500 || jqXHR.status === 200){
					alert("에러가 발생했습니다. : " + textStatus);
				}
			}
		});
    };
    
    repairBikeList.sendSmsForm = function (e) {
    	e.preventDefault();    	
    	//$("#searchFrm").attr({method : 'post', action : '/moveTransferBikeEditForm.do'}).submit();
    	//alert("문자전송");
    	
    	// 회수 요청은 바로클포 점주 계정만 전송 가능 하도록 한다.
    	var grpSeq = "${userSessionVO.usrGrpCd}";
    	var bikeCnt = $("input:checkbox[name=checkSeq]:checked").length;
    	var tmp1 = $('input:checkbox[name=checkSeq]').val();
    	var tmp2 = tmp1.split(',');
    	var guNo = tmp2[3].substring(4);		// 바로클포 자치구

    	/*if(grpSeq !== '21'){
    		alert("회수 요청은 점주만 가능합니다.");
    		return false;
    	}*/
    	if(bikeCnt <= 0){
    		alert("선택된 자전거가 없습니다.");
    		return false;
    	}
    	
    	// 점포명, 자전거 대수, 자전거 번호(1개)로 보낼 메세지 만들기
    	var msg = "바로클포 자전거 회수요청\n점포명 : "+tmp2[1]+" \n자전거 번호 : "+tmp2[2]+" 외 "+(bikeCnt-1)+"대";
    	
    	//alert(msg);
    	$('input:checkbox[name=msg]').val(msg);
    	
    	var confirmText = "";
    	$("input[name=checkSeq]:checked").each(function() {
    		confirmText = confirmText + $(this).parent().next().text() + ' ';
    	});  
    	
    	confirmText = confirmText+ "\n" + bikeCnt +"대의 자전거들을 회수요청 하시겠습니까?";
     	if(confirm(confirmText)){ 
    		// sendPickUpMessage.do
    		$.ajax({
				url : "/sendPickUpMessage.do",
				type : "post",
				dataType : "json",
				data : {msg:msg, districtCd:guNo},
				async : false,
	   			beforeSubmit: function (data,form,option) {
					return true;
				},
				success : function(data){
					if(data.resultMessage == "Success"){
						alert("회수요청 문자가 전송 되었습니다.");
					}
				},
				error : function(jqXHR, textStatus,errorThrown){
					if(jqXHR.status === 500 || jqXHR.status === 200){
						alert("에러가 발생했습니다. : " + textStatus);
					}
				}
			});
     	}else return false;
    }
    
    </script>
</body>
</html>