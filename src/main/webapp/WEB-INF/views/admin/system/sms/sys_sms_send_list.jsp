<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %> 
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
<jsp:scriptlet>

pageContext.setAttribute("newline", "\r\n");

</jsp:scriptlet>
<script type="text/javaScript">
	$(document).ready(function(){

		if("${searchParam.searchParameter}" != ""){
			$("#searchParameter").val("${searchParam.searchParameter}");
		}
		
		if("${searchParam.searchValue}" != "" && "${searchParam.searchParameter}" != ""){
			$("#searchValue").val("${searchParam.searchValue}");
		}
	});
	
	function search_chg(){
		if($("#searchParameter").val() == ""){
			$("#searchValue").val("");
		}
	}
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
											<label for="sDate" class="laType02">등록일</label>
											<span class="selectDate input-datepick04"><input id="sDate" name="searchStartDate" type="text" class="datepicker input-datepick04" title="선택 날짜" readonly="true" value="${searchParam.searchStartDate}"/></span>
											<span class="dash">~</span>
											<span class="selectDate input-datepick04"><input id="eDate" name="searchEndDate" type="text" class="datepicker input-datepick04" title="선택 날짜" readonly="true" value="${searchParam.searchEndDate}"/></span>
										</div>
										<div class="section pright">
											<label for="aa1" class="laType02">구분</label>
											<select class="select-category03" id="searchParameter" name="searchParameter" style="width: 80px;" onchange="search_chg();">
												<option value="">선택</option>
												<option value="1">전화번호</option>
												<option value="2">관리자ID</option>
											</select>
											<span class="input-text08"><input type="text" class="" id="searchValue" name="searchValue" style="width: 27%;"></span>
											<button class="btn-srh03 btncase1" onclick="checkSubmit();"><img src="/images/searchIcon.gif" alt="검색" /></button>
										</div>
									</div>
									
								</fieldset>
						</div>
						<!--검색조건 E-->
						<p class="tb_numlist">총${ paginationInfo.getTotalRecordCount()} 건</p>
						<table class="tb_type01" id="smsinfo">
							<colgroup>
								<col style="width:30%"/>
								<col style="width:30%"/>
								<col style="width:30%"/>
								<col style="width:30%"/>
							</colgroup>
							<thead>
								<tr>
									<th>수신 전화번호</th>
									<th>발송여부</th>
									<th>발송 관리자</th>
									<th>등록일</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${fn:length(smsList) > 0 }">
										<c:forEach items="${smsList}" var="smsList" varStatus="status">
											<tr>
												<c:set var="SQUOT">'</c:set>
												<c:set var="str2" value="${fn:replace(smsList.msg, newline, ' ')}" />
												<c:set var="str3" value="${fn:replace(str2, SQUOT, '’')}" />
												<td><a href="#" onclick="msgAl('<c:out value="${str3}"/>'); return false;">${smsList.viewTel }</a></td>
												<td>${smsList.stateChk }</td>
												<td>${smsList.sendAdminId }</td>
												<td>${smsList.sendDt }</td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td colspan="4" style="text-align: center;"><spring:message code="search.nodata.msg" /></td>
										</tr>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					<c:choose>
						<c:when test="${fn:length(smsList) > 0}">
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
						</fieldset>
					</form>
						
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
						checkSubmit();
					}else{
						linkPage(currentPageNo);
					}
				});
			});
		
			var previousValue;
			$("input").on('focus',function(){
				previous = this.value;
			}).change(function(){
				var sDate = $("#sDate").val();
				var eDate = $("#eDate").val();
				if(sDate!=''&&eDate!=''&&sDate>eDate){
					alert("수정일 시작 시간이 종료 시간보다 빠를 수 없습니다.");
					$(this).val(previous);
				}
			});
			
			function msgAl(msg){
				alert("SMS 내용 : "+msg);
			}
			
			function checkSubmit(){ 
				$("[name='currentPageNo']").val(1);
				$("#frm").attr('action','/admin/service/policyMgmt/sendSmsList.do').submit();
				return true;
			}
			
			function linkPage(pageNo){
				$("[name='currentPageNo']").val(pageNo);
		        $("#frm").attr({method : "post", action : "<c:out value='/admin/service/policyMgmt/sendSmsList.do'/>"}).submit();
			}
			
		</script>
				
		<!--footer S-->
			<tiles:insertAttribute name="footer" />
		<!--footer E-->
	</div>
</body>
</html>
