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
<title><tiles:insertAttribute name="title"/></title>
<tiles:insertAttribute name="resource"/>

<!-- 
	개발일시 : 2020-09-16
	개발자   : 김시성
	내용     : 관리자 문자 발송 목록
	TODO : 
	ASIS : 발송상태 추가 - 2020.09.22
	       
 -->
</head>
<body>
<!-- solbit test-테스트 페이지  S   -->
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
                        <div class="shBox_m">
                            <div class="downtitle">
                                <div class="title">
                                    <p>검색조건</p><span><button><img src="/images/srh_open.png" alt="검색조건 열기" /></button></span>
                                </div>
                            </div>
                        </div>
                        <!-- 모바일 검색조건 E-->
                       	<!-- 검색조건  S -->
                       	<form id="searchFrm">
                        <div class="shBox">
                        	<input type="hidden" name="reqSmsSeq" value="" />
                        	<fieldset>
								<legend>검색 옵션</legend>
								<div class="shBoxSection">
									<div class="section">
										<label for="bb22" class="laType02">기간</label>
										<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" name="searchBgnDe" title="선택 날짜" id="bb22" readonly/></span>
										<span class="dash">~</span>
										<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" name="searchEndDe" title="선택 날짜" readonly/></span>
									</div>
									<div class="section pright">
										<label for="aa2" class="laType02">발송자</label>
										<span class="input-text07"><input type="text" name="searchAdmin" class="" value=""/></span>
									<button id="searchBtn" class="btn-srh03 btncase1"><img src="/images/searchIcon.gif" alt="검색"></button>
									</div>
								</div>
							</fieldset>
						</div>
                       	<!-- 검색조건  E -->
                       	<!-- 검색결과 S -->
						<p class="tb_numlist">총 ${ paginationInfo.getTotalRecordCount()} 건</p>
						<div class="widscr mt5">
							<c:choose>
								<c:when test="${fn:length(admSmsList) ne 0 }">
		                        	<table class="tb_type02 my-3">
		                        		<caption>관리자 문자 전송 조회</caption>
		                        		<colgroup>
		                        			<col style="width:20%">
		                                    <col style="width:20%">
		                                    <col style="width:20%">
		                                    <col style="width:20%">
		                                    <col style="width:20%">
		                        		</colgroup>
		                        		<thead>
		                        			<tr>
												<th class="top text-center">발송자</th>
                        						<th class="top text-center">제목</th>
                        						<th class="top text-center">발송시간</th>
                        						<th class="top text-center">발송상태</th>
                        						<th class="top text-center">작성날짜</th>
		                        			</tr>
		                        		</thead>
		                        		<tbody id="tbodyTarget">
		                        			
			                        		<c:forEach items="${admSmsList}" var="list" varStatus="vst">
			                        			
			                        			<tr>
			                        				<td class="text-center">
			                        					${list.adminName}
			                        				</td>
			                        				
			                        				<td class="text-center">
			                        					<a href="#" onclick="openSmsDtl(${list.reqSmsSeq})" style="color: blue;">${list.reqTitle}</a>
			                        				</td>
			                        				
			                        				<td class="text-center">
			                        					${list.reqResDate}
			                        				</td>
			                        				
			                        				<td class="text-center">
			                        				
			                        					<c:if test="${list.reqSendYn eq 'Y'}">
			                        						완료
			                        					</c:if>
			                        					
			                        					<c:if test="${list.reqSendYn eq 'N'}">
			                        						미완료
			                        					</c:if>
			                        					
			                        				</td>
			                        				
			                        				<td class="text-center">
			                        					${list.regDttm}
			                        				</td>
			                        				
			                        			</tr>
			                        			
			                        		</c:forEach>
			                        		
		                        		</tbody>
		                       		</table>
		                       	</c:when>	
	                            <c:otherwise>
	                                <table class="tb_type01 nbt0">
			                            <tr><td style="text-align:center"><spring:message code="search.nodata.msg" /></td></tr>
			                        </table>
								</c:otherwise>
							</c:choose>
                       	</div>
                    	<!-- 검색결과 E -->
                    	<!-- 버튼구역 S  -->
                    	
                    	<!-- 버튼구역 E  -->
                    	<!-- 페이징 S  -->
                    	<div>
                    	<c:choose>
							<c:when test="${searchCondition.searchAprd eq 'N'}">
								<div class="drpaging" style="display:none;">
							</c:when>
							<c:when test="${fn:length(admSmsList) > 0}">
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
                    	<!-- 페이징 E  -->	
						</form>
					</div>
                </div>
                <!--conteent E-->
            </div>
        </div>
        </div>
        <!--footer S-->
        <tiles:insertAttribute name="footer" />
        <!--footer E-->
    <script type="text/javascript" src="/js/common_barocle.js"></script>
    <script type="text/javascript">
    $(function(){
    	
    	/****** 그룹 별 화면 show hide 처리 S ******/
    	
    	
    	/****** 그룹 별 화면 show hide 처리 E ******/
    	
    	/*********** 검색구간 정보 S  ***********/
    	
    	var date = new Date;
		date.setDate(date.getDate()-6);
		var fromday = DateUtil.dateFmt(new Date()); /* DateUtil.dateFmt(date); 당일로 변경*/
		var today = DateUtil.dateFmt(new Date());
 		var sDate = '${searchCondition.searchBgnDe}' !== '' ? '${searchCondition.searchBgnDe}' : fromday;
		var eDate = '${searchCondition.searchEndDe}' !== '' ? '${searchCondition.searchEndDe}' : today;
		var searchAdmin = '${searchCondition.searchAdmin}' !== '' ? '${searchCondition.searchAdmin}' : '';
		
		$("[name='searchBgnDe']").val(sDate);
		$("[name='searchEndDe']").val(eDate);
		$("[name='searchAdmin']").val(searchAdmin);
		
    	/*********** 검색구간 정보 E  ***********/
		
		/*********** 페이징  S ***********/
		
    	var totalPageCount = '${paginationInfo.totalPageCount}' == '' ? 1 : Number('${paginationInfo.totalPageCount}');
   		$('#prevPage').on("click",function(){
   			
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			admSmsInfo.pageSelect(currentPageNo-1);
			
		});
		$('#nextPage').on("click",function(){
			
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			admSmsInfo.pageSelect(currentPageNo+1);
			
		});
		$('#movePage').on("click",function(){
			
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			var regExp = /^[1-9]?[0-9]/;
			
			if(!regExp.test(currentPageNo) ||(totalPageCount < currentPageNo)){
				
				alert('현재 페이지 값이 정상적이지 않습니다.');
				
			}else{
				
				admSmsInfo.pageSelect(currentPageNo);
				
			}
			
		});
		
		/*********** 페이징  E ***********/
		
		/*********** 화면단 이벤트 리스너 S ***********/
		
		$("#searchBtn").on("click",function(e){
			
			e.preventDefault();
			
			$("[name='viewFlg']").val("list");
			
			$("#searchFrm").attr({method : 'post', action :'/admin/system/sms/getReqAdminSmsList.do'}).submit();
			
		});
		
		
		
		/*********** 화면단 이벤트 리스너 E ***********/
		
		admSmsInfo.init();
		
    });

    /*********** 변수 & 함수 S ***********/
    
   	var admSmsInfo = {};
   	
   	admSmsInfo.init = function(){

   		
   	};
   	
   	admSmsInfo.pageSelect = function(pageNo) {
       	$("[name='currentPageNo']").val(pageNo);
       	$("[name='viewFlg']").val('list');
       	
       	$("#searchFrm").attr({method : 'post', action :'/admin/system/sms/getReqAdminSmsList.do'}).submit();
       	
    };
    
    /*********** 변수 & 함수 E ***********/
    
    function openSmsDtl(seq){
		
    	$("[name='reqSmsSeq']").val(seq);
    	$("#searchFrm").attr({method : 'post', action :'/admin/system/sms/getReqAdminSmsDtl.do'}).submit();
	
    }		
    </script>
</body>
</html>