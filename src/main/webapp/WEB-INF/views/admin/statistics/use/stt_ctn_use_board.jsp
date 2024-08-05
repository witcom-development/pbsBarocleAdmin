<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%
	Calendar cal = Calendar.getInstance();
	cal.add(Calendar.MONTH, -1);
	int minYear = 2010;
	int nowYear = cal.get(Calendar.YEAR);
	SimpleDateFormat sdf = new SimpleDateFormat("MM");
	String nowMonth = sdf.format(cal.getTime());
%>
<!DOCTYPE html>
<html>
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
	function linkPage(pageNo){ location.href = "/use/useStatisticsBoard.do?currentPageNo="+pageNo+"<c:out value='${parameterInfo}' escapeXml='false'/>"; }
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
						<p class="pageTitle">월간운영현황</p>
						<span>통계 &gt; <em>월간운영현황</em></span>
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
									<legend>등록일 검색 옵션</legend>
									<div class="shBoxSection">
										<div class="section">
											<label for="sDate" class="laType02">등록일</label>
											<span class="selectDate input-datepick04"><input id="sDate" name="searchStartDate" type="text" class="datepicker input-datepick04" title="선택 날짜" readonly="true" value="${useStatisticsBoardView.searchStartDate}"/></span>
											<span class="dash">~</span>
											<span class="selectDate input-datepick04"><input id="eDate" name="searchEndDate" type="text" class="datepicker input-datepick04" title="선택 날짜" readonly="true" value="${useStatisticsBoardView.searchEndDate}"/></span>
										</div>
										<div class="section">
											<label for="searchValue" class="laType02">제목</label>
											<span class="input-text07"><input id="searchValue" name="searchValue" type="text" class="input-text07" value="${useStatisticsBoardView.searchValue}" maxLength="32"/></span>
											<button class="btn-srh03 btncase1" onclick="checkSubmit();"><img src="/images/searchIcon.gif" alt="검색" /></button>
										</div>
									</div>
								</fieldset>
						</div>
						<!--검색조건 E-->
						<p class="tb_numlist">총 <c:out value="${useStatisticsBoardView.totalRecordCount}"/>건</p>
						<table class="tb_type01">
							<caption>고객센터</caption>
								<colgroup>
									<col style="width:10%"/>
									<col style="width:*"/>
									<col style="width:15%"/>
								</colgroup>
							<thead>
								<tr>
									<th>No</th>
									<th>제목</th>
									<th>등록일</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${fn:length(useStatisticsBoardList) > 0 }">
										<c:forEach items="${useStatisticsBoardList}" var="useStatisticsBoardList" varStatus="status">
											<tr>
												<td class="tc">${useStatisticsBoardList.staticSeq}</td>
												<td class="title"><a href="/use/useStatisticsBoardEdit.do?mode=edit&staticSeq=<c:out value='${useStatisticsBoardList.staticSeq}'/><c:if test="${useStatisticsBoardView.currentPageNo!=0}">&currentPageNo=<c:out value='${useStatisticsBoardView.currentPageNo}'/></c:if><c:out value='${parameterInfo}' escapeXml='false'/>"><c:out value="${useStatisticsBoardList.staticTitle}"/></a></td>
												<td class="tc"><fmt:formatDate value="${useStatisticsBoardList.regDttm}" pattern="yyyy-MM-dd"/></td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td class="tc" colspan="3"><spring:message code="search.nodata.msg" /></td>
										</tr>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>

					<c:choose>
						<c:when test="${fn:length(useStatisticsBoardList) > 0}">
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
							<span class="right"><button class="btnType01 bc_green" onclick="location.href='/use/useStatisticsBoardEdit.do<c:if test="${useStatisticsBoardView.currentPageNo ne '' && useStatisticsBoardView.currentPageNo ne null}">?currentPageNo=<c:out value='${useStatisticsBoardView.currentPageNo}'/></c:if><c:out value='${parameterInfo}' escapeXml='false'/>';">등록</button></span>
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
					alert("종료일이 시작일보다 빠를 수 없습니다.");
					return false;
				} else { 
					$("#frm").attr('action','/use/useStatisticsBoard.do').submit();
					fn_loading();
				}
				return true;
			}
			var previousValue;
			$("input").on('focus',function(){
				previous = this.value;
			}).change(function(){
				var sDate = $("#sDate").val();
				var eDate = $("#eDate").val();
				if(sDate!=''&&eDate!=''&&sDate>eDate){
					alert("종료일이 시작일보다 빠를 수 없습니다.");
					$(this).val(previous);
				}
			});
		</script>

</body>
</html>