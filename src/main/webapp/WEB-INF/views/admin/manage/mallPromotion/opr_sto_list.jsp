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
	function linkPage(pageNo){ location.href = "/admin/manage/mallPromotion/mallPromotionList.do?currentPageNo="+pageNo+"<c:out value='${parameterInfo}' escapeXml='false'/>"; }
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
							<form:form id="frm" commandName="form" action="/admin/manage/mallPromotion/mallPromotionList.do" accept-charset="utf-8">
								<fieldset>
									<legend>검색조건</legend>
									<div class="shBoxSection">
										<div class="section">
											<label for="stationGrpSeq" class="laType02">아파트</label>
												<select class="select-category02" id="stationGrpSeq" name="stationGrpSeq">
													<option value="">선택</option>
												</select>
										</div>
										<div class="section pright">
											<label for="stationID" class="laType02">대여소</label>
												<select class="select-category02" id="stationID" name="stationID">
													<option value="">선택</option>
												</select>
										</div>
										<div class="section">
											<label for="typeClsCD" class="laType02">업종</label>
												<select class="select-category02" id="typeClsCD" name="typeClsCD">
													<option value="">선택</option>
												</select>
												<button class="btn-srh03 btncase1" onclick="$('#frm').submit();"><img src="/images/searchIcon.gif" alt="검색" /></button>
										</div>
									</div>
								</fieldset>
							</form:form>
						</div>
						<!--검색조건 E-->
						<p class="tb_numlist">총  <c:out value="${mallPromotionView.totalRecordCount}" /> 건</p>
						<table class="tb_type01">
							<colgroup>
								<col style="width:20%" />
								<col style="width:20%" />
								<col style="width:10%" />
								<col style="width:auto" />
								<col style="width:20%" />
								<!--[if gt IE 8]><!--><col style="width:12%"  class="mhid"/><!--<![endif]-->
							</colgroup>
							<thead>
								<tr>
									<th>아파트</th>
									<th>대여소</th>
									<th>업종</th>
									<th>상가 명</th>
									<th>전화번호</th>
									<!--[if gt IE 8]><!--><th class="mhid">수정일</th><!--<![endif]-->
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${fn:length(mallPromotionList) > 0 }">
										<c:forEach items="${mallPromotionList}" var="mallPromotionList" varStatus="status">
											<tr>
												<td class="tc"><c:out value="${mallPromotionList.stationGrpName}" /></td>
												<td class="tc"><c:out value="${mallPromotionList.stationName}" /></td>
												<td class="tc"><c:out value="${mallPromotionList.cdDesc1}" /></td>
												<td class="title"><a href="/admin/manage/mallPromotion/mallPromotionEdit.do?mode=edit&shopADSeq=${mallPromotionList.shopADSeq}<c:if test="${mallPromotionView.currentPageNo!=0}">&currentPageNo=<c:out value='${mallPromotionView.currentPageNo}'/></c:if><c:out value='${parameterInfo}'/>"><c:out value="${mallPromotionList.shopName}" /></a></td>
												<td class="tc"><c:out value="${mallPromotionList.shopTelNO}" /></td>
												<!--[if gt IE 8]><!--><td class="tc"><fmt:formatDate value="${mallPromotionList.modDttm}" pattern="yyyy.MM.dd"/></td><!--<![endif]-->
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td class="tc" colspan="6"><spring:message code="search.nodata.msg" /></td>
										</tr>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					<c:choose>
						<c:when test="${fn:length(mallPromotionList) > 0}">
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
						<div class="btnArea">
							<span class="right"><button class="btnType01 bc_green" onclick="location.href='/admin/manage/mallPromotion/mallPromotionEdit.do<c:if test="${mallPromotionView.currentPageNo ne '' && mallPromotionView.currentPageNo ne null}">?currentPageNo=<c:out value='${mallPromotionView.currentPageNo}'/></c:if><c:out value='${parameterInfo}' escapeXml='false'/>';">등록</button></span>
						</div>
					</div>
				</div>
				<!--content E-->
			</div>
		</div>
		
		<script type="text/javaScript">
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
		
			/* 아파트 */
			<%-- 언어설정 : $.getJSON('/admin/manage/mallPromotion/getStationGroup.do?mLang=LAG_001',function(data){ --%>
			$.getJSON('/admin/manage/mallPromotion/getStationGroup.do',function(data){
				$.each(data.dataList,function(key,val){
					$("#stationGrpSeq").append('<option value="' + this.stationGrpSeq + '">' + this.stationGrpName + '</option>');
				})
				var initValue = '<c:out value="${mallPromotionView.stationGrpSeq}"/>';
				if(initValue!=''){ $("#stationGrpSeq").val(initValue); }
			})
			/* 초기 대여소 목록 */
			<c:if test="${mallPromotionView.stationGrpSeq>0}">
				$.getJSON('/admin/manage/mallPromotion/getStationID.do?stationGrpSeq=<c:out value="${mallPromotionView.stationGrpSeq}"/>',function(data){
					$.each(data.dataList,function(key,val){
						$("#stationID").append('<option value="' + this.stationID + '">' + this.stationName + '</option>');
					})
					var initValue = '<c:out value="${mallPromotionView.stationID}"/>';
					if(initValue!=''){ $("#stationID").val(initValue); }
				});
			</c:if>
			/* 대여소 목록 */
			$("#stationGrpSeq").change(function(){
				$.getJSON('/admin/manage/mallPromotion/getStationID.do?stationGrpSeq='+$("#stationGrpSeq option:selected").val(),function(data){
					$("#stationID").empty();
					$("#stationID").append('<option value="">선택</option>');
					$.each(data.dataList,function(key,val){
						$("#stationID").append('<option value="' + this.stationID + '">' + this.stationName + '</option>');
						if(this.stationID=='<c:out value="${mallPromotionView.stationID}"/>'){ $("#stationID").val('<c:out value="${mallPromotionView.stationID}"/>'); }
					})
				});
			});
			/* 업종 */
			$.getJSON('/admin/manage/center/getSysCode.do?sysCode=KSS',function(data){
				$.each(data.dataList,function(key,val){
					$("#typeClsCD").append('<option value="' + this.comCD + '">' + this.comCdName + '</option>');
				})
				var initValue = '<c:out value="${mallPromotionView.typeClsCD}"/>';
				if(initValue!=''){ $("#typeClsCD").val(initValue); }
			})
		</script>
		
		<!--footer S-->
			<tiles:insertAttribute name="footer" />
		<!--footer E-->
	</div>
</body>
</html>

