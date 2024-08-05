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
	function linkPage(pageNo){ location.href = "/admin/customer/notice/noticeList.do?currentPageNo="+pageNo+"<c:out value='${parameterInfo}' escapeXml='false'/>"; }
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
									<legend>공지일 검색 옵션</legend>
									<div class="shBoxSection">
										<div class="section">
											<label for="sDate" class="laType02">공지기간</label>
											<span class="selectDate input-datepick04"><input id="sDate" name="searchStartDate" type="text" class="datepicker input-datepick04" title="선택 날짜" readonly="true" value="${noticeView.searchStartDate}"/></span>
											<span class="dash">~</span>
											<span class="selectDate input-datepick04"><input id="eDate" name="searchEndDate" type="text" class="datepicker input-datepick04" title="선택 날짜" readonly="true" value="${noticeView.searchEndDate}"/></span>
										</div>
										<div class="section pright">
											<label for="a1" class="laType03">공지여부</label>
											<span>
												<span class="input-rd01"><input type="radio" id="useAll" name="mainNoticeYN" value="A" <c:if test="${noticeView.mainNoticeYN!='Y|N'}">checked="checked"</c:if>><label for="useAll">전체</label></span>
												<span class="input-rd01"><input type="radio" id="useY" name="mainNoticeYN" value="Y" <c:if test="${noticeView.mainNoticeYN=='Y'}">checked="checked"</c:if>><label for="useY">공개</label></span>
												<span class="input-rd01"><input type="radio" id="useN" name="mainNoticeYN" value="N" <c:if test="${noticeView.mainNoticeYN=='N'}">checked="checked"</c:if>><label for="useN">비공개</label></span>
											</span>
										</div>
										<div class="section">
											<label for="searchValue" class="laType02">제목</label>
											<span class="input-text07">
												<input type="text" id="searchValue" name="searchValue" class="input-text07" value="${noticeView.searchValue}" maxLength="32"/>
											</span>
											<button class="btn-srh03 btncase1" onclick="checkSubmit();"><img src="/images/searchIcon.gif" alt="검색" /></button>
										</div>
									</div>
								</fieldset>
						</div>
						<!--검색조건 E-->
						<p class="tb_numlist">총 <c:out value="${noticeView.totalRecordCount}"/>건</p>
						<table class="tb_type01">
							<caption>고객센터</caption>
								<colgroup>
									<col style="width:30%"/>
									<col style="width:10%"/>
									<col style="width:10%"/>
									<col style="width:12.5%"/>
									<col style="width:12.5%"/>
								</colgroup>
							<thead>
								<tr>
									<th>제목</th>
									<th>공지대상</th>
									<th>공지여부</th>
									<th>공지시작일</th>
									<th>공지종료일</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${fn:length(noticeList) > 0 }">
										<c:forEach items="${noticeList}" var="noticeList" varStatus="status">
											<tr>
												<td class="title"><a href="/admin/customer/notice/noticeEdit.do?mode=edit&noticeSeq=<c:out value='${noticeList.noticeSeq}'/><c:if test="${noticeView.currentPageNo!=0}">&currentPageNo=<c:out value='${noticeView.currentPageNo}'/></c:if><c:out value='${parameterInfo}' escapeXml='false'/>"><c:out value="${noticeList.noticeTitle}"/></a></td>
												<td class="title">
													<c:if test="${fn:indexOf(noticeList.siteClsCD,'admin')>-1}">관리자</c:if>
													<c:if test="${fn:indexOf(noticeList.siteClsCD,',')>-1}">,</c:if>
													<c:if test="${fn:indexOf(noticeList.siteClsCD,'user')>-1}">사용자</c:if>
												<td class="tc">
													<c:choose>
														<c:when test="${noticeList.mainNoticeYN=='Y'}">공개</c:when>
														<c:otherwise>비공개</c:otherwise>
													</c:choose>
												</td>
												<td class="tc"><fmt:formatDate value="${noticeList.postStrDttm}" pattern="yyyy-MM-dd"/></td>
												<td class="tc"><fmt:formatDate value="${noticeList.postEndDttm}" pattern="yyyy-MM-dd"/></td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td class="tc" colspan="5"><spring:message code="search.nodata.msg" /></td>
										</tr>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					<c:choose>
						<c:when test="${fn:length(noticeList) > 0}">
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
							<span class="right"><button class="btnType01 bc_green" onclick="location.href='/admin/customer/notice/noticeEdit.do<c:if test="${noticeView.currentPageNo ne '' && noticeView.currentPageNo ne null}">?currentPageNo=<c:out value='${noticeView.currentPageNo}'/></c:if><c:out value='${parameterInfo}' escapeXml='false'/>';">등록</button></span>
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
				} else { 
					$("#frm").attr('action','/admin/customer/notice/noticeList.do').submit(); 
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
					alert("공지 종료일이 시작일보다 빠를 수 없습니다.");
					$(this).val(previous);
				}
			});
		</script>
		
		<!--footer S-->
			<tiles:insertAttribute name="footer" />
		<!--footer E-->
	</div>
</body>
</html>
		