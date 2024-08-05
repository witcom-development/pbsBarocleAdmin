<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />
<meta name="description=" Content="" />
<tiles:insertAttribute name="resource" />
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
									<p>검색조건</p>
									<span><button>
											<img src="/images/srh_open.png" alt="검색조건 열기" />
										</button></span>
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
								<input type="hidden" name="repairOutsrcMainSeq" value="" />
								<input type="hidden" name="adminId" value="" />
								<fieldset>
									<legend>검색 옵션</legend>
									<div class="shBoxSection">
										<div class="section">
											<label for="bb22" class="laType02">등록일</label> 
											<span class="selectDate input-datepick04">
											<input type="text" class="datepicker input-datepick04" name="searchBgnDe" title="선택 날짜" id="bb22" readonly value="${opinionBoardView.searchStartDate}"/></span> 
											<span class="dash">~</span> 
											<span class="selectDate input-datepick04">
											<input type="text" class="datepicker input-datepick04" name="searchEndDe" title="선택 날짜" readonly /></span>
										</div>
										<div class="section pright">
											<label for="a1" class="laType02">상태</label> <span> 
											<span class="input-rd01"> 
													<input type="radio" id="a2" name="transYn" value="A"
													<c:if test="${searchCondition.transYn!='N|Y'}">checked="checked"</c:if> />
													<label for="a2">전체</label></span> 
													<span class="input-rd01">
													<input type="radio" id="a3" name="transYn" value="N" 
													<c:if test="${searchCondition.transYn=='N'}">checked="checked"</c:if> />
													<label for="a3">인계중</label></span> 
													<span class="input-rd01">
													<input type="radio" id="a4" name="transYn" value="Y" 
													<c:if test="${searchCondition.transYn=='Y'}">checked="checked"</c:if> />
													<label for="a4">인계(인수)완료</label></span>
											</span>
										</div>
										<div class="section">
											<label for="a11" class="laType02">점포명</label>
											<!-- 점포명으로 검색할 경우 등록일 선택 필수!! -->
											<select class="select-category02" id ="centerId" name="centerId">
												<option value="">선택</option>
												<c:forEach var="bikeMall" items="${bikeMallList}" varStatus="status">
													<option value="${bikeMall.centerId}" <c:if test="${bikeMall.centerId eq searchCondition.centerId}">selected</c:if>>${bikeMall.centerName}</option>
												</c:forEach>
											</select>
										</div>
										<div class="section pright">
											<label for="a12" class="laType02">등록자</label> 
											<span class="input-text12"><input type="text" id="adminName" name="adminName" value="${searchCondition.adminName}"/></span> 
											</div>
										<div class="section pright">
										<label for="chkYn" class="laType03">ID로 검색</label>
										<span class="input-text12"><input type="text" id="userId" name="userId" value="${searchCondition.userId}"/></span> 
										<c:if test='${searchCondition.chkYn == "Y"}'> 
											 <input type="checkbox" name="chkYn" id="chkYn" value="Y" checked>
										</c:if>
										<c:if test='${searchCondition.chkYn != "Y"}'>
											 <input type="checkbox" name="chkYn" id="chkYn" value="" >
										</c:if> 
										<button id="searchBtn" class="btn-srh03 btncase1">
											<img src="/images/searchIcon.gif" alt="검색" id="searchBtn">
										</button>
										</div>
									</div>
								</fieldset>
							</div>
							<!--검색조건 E-->
							
							
							<p class="tb_numlist">총 ${ paginationInfo.getTotalRecordCount()}
								건</p>
							<table class="tb_type01">
								<colgroup>
									<col style="width: 15%" />
									<col style="width: 18%" />
									<col style="width: 12%" />
									<col style="width: 15%" />
									<col style="width: 25%" />
									<col style="width: 7%" />
								</colgroup>
								<thead>
									<tr>
										<th>자전거 번호</th>
										<th>등록일자</th>
										<th>등록자</th>
										<th>고장내용</th>
										<th>점포명</th>
										<th>인계상태</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="result" items="${RepairBikeList}" varStatus="status">
										<tr>
											<td style="display: none;">${result.repairOursrcSeq}</td>
											<td class="tc"><%-- ${result.bikeNo} --%>
												<a href="#" id="mvDetl,${result.repairOutsrcMainSeq},${result.collectYn}" target="_blank">${result.bikeNo}</a>
											</td>
											<td class="tc"><%-- ${result.regDttm } --%>
												<fmt:parseDate var="dateString" value="${result.regDttm }" pattern="yyyy-MM-dd HH:mm:ss" />
												<fmt:formatDate value="${dateString}" pattern="yyyy-MM-dd HH:mm"/>
											</td>
											<td class="tc">${result.adminName}</td>
											<td class="tc"><%-- ${result.brokenType} --%>
												<fmt:parseNumber value="${result.brokenType}" integerOnly="true" var="brkCnt" scope="page"/>
												<c:choose>
													<c:when test="${result.brokenType=='1'}">
														<a href="#" id="showBrk,${result.repairOursrcSeq},${result.collectYn}">기본교정</a>
													</c:when>
													<c:otherwise>
													<%-- <a href="javascript:showBroken(${result.repairOursrcSeq})">기본교정 외 <c:out value="${brkCnt-1 }"/>건</a> --%>
													<%-- <a href="<c:out value='/moveBrokenParts.do'/>"
													class="winNewPop" title="고장내용 상세" 
				                                    data-width="450" data-height="300"
				                                    data-pmt="&viewFlg=view&repairOursrcSeq=${result.repairOursrcSeq}">기본교정 외 <c:out value="${brkCnt-1 }"/>건</a> --%>
													<a href="#" id="showBrk,${result.repairOursrcSeq},${result.collectYn}">기본교정 외 <c:out value="${brkCnt-1 }"/>건</a>
													</c:otherwise>
												</c:choose>
											</td>
											<td class="tc">${result.centerName}</td>
											<td class="tc">
													<c:choose>
														<c:when test="${result.transYn=='Y'}">인계완료</c:when>

														<c:when test="${result.transYn=='N'}">인계중</c:when>
														
													</c:choose>
												</td>
											<%-- <td style="text-align: center">${result.transYn}</td> --%>
										</tr>
									</c:forEach>
									<c:if test="${fn:length(RepairBikeList) eq 0 }">
										<table class="tb_type01 nbt0">
											<tr>
												<td style="text-align: center"><spring:message code="search.nodata.msg" /></td>
											</tr>
										</table>
									</c:if>
								</tbody>
							</table>
							<c:choose>
								<c:when test="${fn:length(RepairBikeList) > 0}">
									<div class="drpaging">
								</c:when>
								<c:otherwise>
									<div class="drpaging" style="display: none;">
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
							<span><input name="currentPageNo" type="number" value="${paginationInfo.currentPageNo}" /><em>/${paginationInfo.totalPageCount}</em>
								<button id="movePage">이동</button></span>
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
							<button class="btnType01 bc_green mb10" id="moveRepairBikeEditMallForm">등록</button>
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
					
			$("#userId").val('${searchUser.usrId }');
			$("input[name='chkYn']").prop("checked",true);
			
			$("#chkYn").click(function(){
		    	if ($(this).is(":checked")) {
		    		  $("#userId").val('${searchUser.usrId }');
		              $("#userId").show();
		        } else {
		              $("#userId").hide();
		        }
		    });
			
			var totalPageCount = '${paginationInfo.totalPageCount}' == '' ? 1
					: Number('${paginationInfo.totalPageCount}');
			$('#prevPage').on("click", function() {
				var currentPageNo = Number($('[name="currentPageNo"]').val());
				repairBikeList.pageSelect(currentPageNo - 1);
			});
			$('#nextPage').on("click", function() {
				var currentPageNo = Number($('[name="currentPageNo"]').val());
				repairBikeList.pageSelect(currentPageNo + 1);
			});
			$('#movePage').on("click", function() {
						var currentPageNo = Number($('[name="currentPageNo"]').val());
						var regExp = /^[1-9]?[0-9]/;
						if (!regExp.test(currentPageNo)|| (totalPageCount < currentPageNo)) {   
							alert('현재 페이지 값이 정상적이지 않습니다.');
						} else {
							repairBikeList.pageSelect(currentPageNo);
						}
					});
		});

		var repairBikeList = {};
		
		repairBikeList.initBtn = function() {

			var date = new Date;
			date.setDate(date.getDate()-6);
			var fromday = DateUtil.dateFmt(date);
			var today = DateUtil.dateFmt(new Date());
			 
			var sDate = '${searchCondition.searchBgnDe}' !== '' ? '${searchCondition.searchBgnDe}' : '';
			var eDate = '${searchCondition.searchEndDe}' !== '' ? '${searchCondition.searchEndDe}' : '';
	
			$("[name='searchBgnDe']").val(sDate);
			$("[name='searchEndDe']").val(eDate);
			
			$("#searchBtn").on("click", {listType : "list"}, this.exeListFnc);
			$("#moveRepairBikeEditMallForm").on("click", {listType : "C"}, this.moveEditForm);
			$(".tb_type01 > tbody > tr").on("click", "a",{listType : "U"}, this.moveEditForm);
			
		}

		repairBikeList.exeListFnc = function(e) {
			e.preventDefault();
			var listType = e.data.listType;

			if($("[name='searchBgnDe']").val() != '' && $( "[name='searchEndDe']").val() != ''){
				if (DateUtil.checkDateTerm($("[name='searchBgnDe']").val(), $("[name='searchEndDe']").val()) != 'ok') {
					alert('<spring:message code="fail.input.daterange"/>');
					return false;
				}
				if (DateUtil.diffDays($("[name='searchBgnDe']").val(), $("[name='searchEndDe']").val(), '-') >= 365) {
					alert("조회기간은  1년 이내로 설정해주세요.");
					return false;
				}
			}
			/* 등록일 선택 안했으면 다시 선택하도록 설정 */
			 /* if (DateUtil.checkTerm($("[name='searchBgnDe']").val(), $("[name='searchEndDe']").val()) == null){
				 alert("등록일을 선택하세요.");
				 return false;
			 }  */
			 
			
			$("[name='currentPageNo']").val(1);

			$("[name='viewFlg']").val(listType);
			
			$("#searchFrm").attr({
				method : 'post',
				action : '/transRepairBikeMallList.do'
			}).submit();	
		};

		repairBikeList.pageSelect = function(pageNo) {
			$("[name='currentPageNo']").val(pageNo);
			$("[name='viewFlg']").val('list');
		    $("#searchFrm").attr({
				action : '/transRepairBikeMallList.do',
				method : 'post'
				}).submit();
		};	   
		
		repairBikeList.moveEditForm = function(e) {
			e.preventDefault();
			var listType = e.data.listType;
			var detailInfo = (e.target.id).split(",");
			
			$("[name='viewFlg']").val(listType);
			
			
			if(detailInfo[0] == 'mvDetl'){
				$("[name='repairOutsrcMainSeq']").val(detailInfo[1]);
				$("[name='collectYn']").val(detailInfo[2]);
				$("#searchFrm").attr({method : 'post',	action : '/moveTransferBikeEditForm.do'}).submit();
			}else if(listType == "C"){
				$("#searchFrm").attr({method : 'post',	action : '/moveTransferBikeEditForm.do'}).submit();
			}else{
				//$("#searchFrm").attr({method : 'post',	action : '/moveBrokenParts.do'}).submit();
				// alert(detailInfo[1]);
				window.open("/moveBrokenParts.do?viewFlg=view&repairOursrcSeq="+detailInfo[1]+"&collectYn="+detailInfo[2], "winpop2", "width=500, height=300", "scrollbars=yes");
			}
			
			/* if(listType == "U"){
				$("[name='repairOutsrcMainSeq']").val(e.target.id);
			} */
			// $("#searchFrm").attr({method : 'post',	action : '/moveTransferBikeEditForm.do'}).submit();
		};
		
		function showBroken(infoSeq){
			alert(infoSeq);
			/* /moveBrokenParts.do */
		}
	</script>
</body>
</html>