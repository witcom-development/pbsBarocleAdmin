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
	function linkPage(pageNo){ 
		$("[name='currentPageNo']").val(pageNo);
        $("#frm").attr({method : "post", action : "<c:out value='/admin/customer/counsel/counselList.do'/>"}).submit();
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
									<legend>검색조건</legend>
									<div class="shBoxSection">									
										<div class="section">
											<label for="searchValue" class="laType02">바로클ID</label>
											<span class="input-text07"><input id="custNm" name="custNm" type="text" style="width: 223px;" class="input-text07" value="${searchParam.custNm}" maxLength="32"/></span>
										</div>									
										<div class="section repos pright">
											<label for="searchValue" class="laType02">휴대폰번호</label>
											<span class="input-text07"><input id="talkTno" name="talkTno" type="text" style="width: 223px;" class="input-text07" value="${searchParam.talkTno}" maxLength="13"/></span>
										</div>
										<div class="section">
											<label for="sDate" class="laType02">상담일</label>
											<span class="selectDate input-datepick04"><input id="sDate" name="searchBgnDe" type="text" class="datepicker input-datepick04" title="선택 날짜" readonly="true" value="${searchParam.searchBgnDe}" /></span>
											<span class="dash">~</span>
											<span class="selectDate input-datepick04"><input id="eDate" name="searchEndDe" type="text" class="datepicker input-datepick04" title="선택 날짜" readonly="true" value="${searchParam.searchEndDe}" /></span>
										</div>
										<div class="section repos pright">
											<label for="a2" class="laType02">상담유형(대)</label>
                                            <select class="select-category04" id="conslLcd" name="conslLcd">
												<option value="">선택</option>
												<c:forEach items="${LcdList }" var="lcdList">
													<option value="${lcdList.comCd }" <c:if test="${lcdList.comCd eq searchParam.conslLcd}">selected="true"</c:if>>${lcdList.cdDesc1 }</option>
												</c:forEach>
											</select>
										</div>
										<div class="section">
                                            <label for="gubun">상담이력(중)</label>
                                            <select class="select-category04" id="conslMcd" name="conslMcd">
												<option value="">선택</option>
												<c:forEach items="${McdList }" var="mcdList">
													<option value="${mcdList.comCd }">${mcdList.cdDesc1 }</option>
												</c:forEach>
											</select>
                                            <button class="btn-srh03 btncase1" onclick="checkSubmit();"><img src="/images/searchIcon.gif" alt="검색" /></button>
                                        </div>
									</div>
								</fieldset>
						</div>
						<!--검색조건 E-->
						<p class="tb_numlist">총 <c:out value="${paginationInfo.totalRecordCount}"/>건</p>
						<table class="tb_type01">
							<colgroup>
								<col style="width:14%" />
								<col style="width:10%" />
								<col style="width:10%" />
								<col style="width:10%" />
								<col style="width:10%" />
								<col style="width:12%" />
								<col style="width:28%" />
							</colgroup>
							<thead>
								<tr>
									<th>전화번호</th>
									<th>상담일</th>
									<th>통화시작시간</th>
									<th>통화종료시간</th>
									<th>상담유형(대)</th>
									<th>상담유형(중)</th>
									<th>상담내용</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${fn:length(CounselList) > 0 }">
										<c:forEach items="${CounselList}" var="counselVO" varStatus="status">
										<tr>
											<td style="display: none;">${counselVO.conslSeq}</td>
											<td class="tc">${counselVO.talkTno}</td>
											<td class="tc">${counselVO.conslDate}</td>
											<td class="tc">${counselVO.talkStrtDt}</td>
											<td class="tc">${counselVO.talkEndDt}</td>
											<td class="tc">${counselVO.lcdName}</td>
											<td class="tc">${counselVO.mcdName}</td>
											<td class="tc">${counselVO.requestConslDscrp}</td>
										</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td class="tc" colspan="7"><spring:message code="search.nodata.msg" /></td>
										</tr>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					<c:choose>
						<c:when test="${fn:length(CounselList) > 0}">
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
							<a href="<c:out value='/common/pop/COUNSEL/openUploadPop.do'/>" id="bulkUploadBtn" class="winNewPop btnType01 mb10 mhid" title="엑셀파일업로드" data-width="450" data-height="355" data-pmt="">엑셀업로드</a>
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
						checkSubmit();
					}else{
						linkPage(currentPageNo);
					}
				});
				
				$("#conslLcd").change(function(){
					fn_selectChange(false);
				});
				
				$("#conslLcd").val("${searchParam.conslLcd}");
				if("${searchParam.conslLcd}" != ""){
					fn_selectChange(true);
				}
				
				
			});
			
			function checkSubmit(){
				//검색 버튼 클릭시 페이지 초기화
				$('[name="currentPageNo"]').val(1);
				
				if($("#sDate").val()!=''&&$("#eDate").val()!=''&&$("#sDate").val()>$("#eDate").val()){
					alert("등록 종료일이 시작일보다 빠를 수 없습니다.");
					return false;
				} else { $("#frm").attr('action','/admin/customer/counsel/counselList.do').submit(); 
					
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
					alert("등록 종료일이 시작일보다 빠를 수 없습니다.");
					$(this).val(previous);
				}
			});
			
			function fn_selectChange( flg ){
				var lcd = $("#conslLcd").val();
				
				var select = "<option value=\"\">선택</option>"
				if($("#conslLcd").val() == ''){
					$("#conslMcd").find("option").remove().end();
					$("#conslMcd").append(select);
					
				}else{
					$("#conslMcd").find("option").remove().end();
					$("#conslMcd").append(select);
					$.ajax({
		        		type		: 'post',
		    			url			: '/admin/customer/counsel/conslMcdListAjax.do',
		    			dataType	: 'json',
		    			data		: { "conslLcd" : lcd},
		    			success		: function( data ) {
		    				if(data.resultMessage == 'Success'){
		    					
		    					var uSize = data.McdList.length;
		    					for(var i=0; i < uSize; i +=1) {
		    						var mcdInfo = data.McdList[i];
		    						if(flg){
		    							if("${searchParam.conslMcd}" == mcdInfo.comCd){
											$("#conslMcd").append("<option value='"+mcdInfo.comCd+"' selected>"+ mcdInfo.cdDesc1 +"</option>");
										}else{
											$("#conslMcd").append("<option value='"+mcdInfo.comCd+"'>"+ mcdInfo.cdDesc1 +"</option>");
										}
		    						}else{
										$("#conslMcd").append("<option value='"+mcdInfo.comCd+"'>"+ mcdInfo.cdDesc1 +"</option>");
									}
		    						// $("<option value='"+mcdInfo.comCd+"'>"+mcdInfo.cdDesc1+"</option>").appendTo("#conslMcd");
		    					}
			    				
			    			}else{
			    				alert('상담이력(중) 조회를 실패하였습니다.');
			    			}
			    				},
			    				error : function(jqXHR, textStatus,errorThrown){
			    					if(jqXHR.status === 500 || jqXHR.status === 200){
			    						alert("에러가 발생했습니다.");
			    					}
			    					//console.log(textStatus);
			    				}
		        	});
					
				}
			}
			
		</script>
		
		<!--footer S-->
			<tiles:insertAttribute name="footer" />
		<!--footer E-->
	</div>
</body>
</html>
