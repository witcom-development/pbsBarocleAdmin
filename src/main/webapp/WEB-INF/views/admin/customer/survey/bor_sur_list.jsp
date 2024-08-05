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
<script type="text/javaScript">
	$(document).ready(function(){
		/* 에러 메시지  */
		var alertValue = "<c:out value='${resultError.errorMessage}'/>";
		if(alertValue!=""){ alert(alertValue); }
	});
	function linkPage(pageNo){ location.href = "/admin/customer/survey/surveyList.do?currentPageNo="+pageNo+"<c:out value='${parameterInfo}' escapeXml='false'/>"; }
</script>
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
						<div class="shBox">
							<form id="frm" name="frm" accept-charset="utf-8">
								<fieldset>
									<legend>공시기간 검색 옵션</legend>
									<div class="shBoxSection">
										<div class="section">
											<label for="sDate" class="laType02">공시기간</label>
											<span class="selectDate input-datepick04"><input id="sDate" name="searchStartDate" type="text" class="datepicker input-datepick04" title="선택 날짜" readonly="true" value="${surveyView.searchStartDate}" /></span>
											<span class="dash">~</span>
											<span class="selectDate input-datepick04"><input id="eDate" name="searchEndDate" type="text" class="datepicker input-datepick04" title="선택 날짜" readonly="true" value="${surveyView.searchEndDate}" /></span>
										</div>
										<div class="section pright">
											<label for="searchValue" class="laType02">제목</label>
											<span class="input-text07"><input id="searchValue" name="searchValue" type="text" class="input-text07" value="${surveyView.searchValue}" maxLength="32"/></span>
											<button class="btn-srh03 btncase1" onclick="checkSubmit();"><img src="/images/searchIcon.gif" alt="검색" /></button>
										</div>
									</div>
								</fieldset>
						</div>
						<!--검색조건 E-->
						<p class="tb_numlist">총 <c:out value="${surveyView.totalRecordCount}"/>건</p>
						<table class="tb_type01">
							<colgroup>
								<col style="width:40%"/>
								<col style="width:10%"/>
								<col style="width:15%"/>
								<col style="width:15%"/>
								<col style="width:15%"/>
							</colgroup>
							<thead>
								<tr>
									<th>제목</th>
									<th>설문여부</th>
									<th>설문시작일</th>
									<th>설문종료일</th>
									<th>수정일</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${fn:length(surveyList) > 0 }">
										<c:forEach items="${surveyList}" var="surveyList" varStatus="status">
											<tr>
												<td class="title"><a href="/admin/customer/survey/surveyEdit.do?mode=edit&qustnrSeq=<c:out value='${surveyList.qustnrSeq}'/><c:if test="${surveyView.currentPageNo!=0}">&currentPageNo=<c:out value='${surveyView.currentPageNo}'/></c:if><c:out value='${parameterInfo}' escapeXml='false'/>"><c:out value="${surveyList.qustnrTitle}" /></a></td>
												<td class="tc">
													<fmt:formatDate value="${surveyList.qustnrStrDttm}" pattern="yyyyMMdd" var="qustnrStrDttm" />
													<fmt:formatDate value="${surveyList.qustnrEndDttm}" pattern="yyyyMMdd" var="qustnrEndDttm" />
													<c:choose>
														<c:when test="${getTodayDate<=qustnrEndDttm&&getTodayDate>=qustnrStrDttm}">OPEN</c:when>
														<c:otherwise>CLOSED</c:otherwise>
													</c:choose>
												</td>
												<td class="tc"><fmt:formatDate value="${surveyList.qustnrStrDttm}" pattern="yyyy.MM.dd"/></td>
												<td class="tc"><fmt:formatDate value="${surveyList.qustnrEndDttm}" pattern="yyyy.MM.dd"/></td>
												<td class="tc"><fmt:formatDate value="${surveyList.modDttm}" pattern="yyyy.MM.dd"/></td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td colspan="5"><spring:message code="search.nodata.msg" /></td>
										</tr>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					<c:choose>
						<c:when test="${fn:length(surveyList) > 0}">
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
							<span class="right"><button class="btnType01 bc_green" onclick="location.href='/admin/customer/survey/surveyEdit.do<c:if test="${surveyView.currentPageNo ne '' && surveyView.currentPageNo ne null}">?currentPageNo=<c:out value='${surveyView.currentPageNo}'/></c:if><c:out value='${parameterInfo}' escapeXml='false'/>';">등록</button></span>
						</div>
					</div>
				</div>
				<!--content E-->
			</div>
		</div>
		
		<script type="text/javascript">
			$(function() {	
				var totalPageCount = '${paginationInfo.totalPageCount}' == '' ? 1 : Number('${paginationInfo.totalPageCount}');
		   		$('#prevPage').on("click",function(){
					var currentPageNo = Number($('[name="currentPageNo"]').val());
					linkPage(currentPageNo-1);
				});
				$('#nextPage').on("click",function(){
					var currentPageNo = Number($('[name="currentPageNo"]').val());
					linkPage(currentPageNo+1);
				});
				$('#movePage').on("click",function(){
					var currentPageNo = Number($('[name="currentPageNo"]').val());
					var regExp = /^[1-9]?[0-9]/;
					if(!regExp.test(currentPageNo) ||(totalPageCount < currentPageNo)){
						alert('현재 페이지 값이 정상적이지 않습니다.');
					}else{
						linkPage(currentPageNo);
					}
				});
			});
			function checkSubmit(){
				if($("#sDate").val()!=''&&$("#eDate").val()!=''&&$("#sDate").val()>$("#eDate").val()){
					alert("공지 종료일이 시작일보다 빠를 수 없습니다.");
					return false;
				} else { $("#frm").attr('action','/admin/customer/survey/surveyList.do').submit(); }
				return true;
			}
			var previousValue;
			$("input").on('focus',function(){
				previous = this.value;
			}).change(function(){
				var sDate = $("#sDate").val();
				var eDate = $("#eDate").val();
				if(sDate!=''&&eDate!=''&&sDate>eDate){
					alert("공지 종료일이 시작일보다 빠를 수 없습니다.");
					$(this).val(previous);
				}
			});
		</script>
		
		<!--footer S-->
		<div id="footer">
			<tiles:insertAttribute name="footer" />
		</div>
		<!--footer E-->
	</div>
</body>
</html>
