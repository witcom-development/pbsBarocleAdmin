<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>
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
	개발일시 : 2021-07-23
	개발자   : 양재영
	내용     : 분배직원 근태 조회 화면
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
						<p class="pageTitle"><c:forEach items="${menuPathList}" var="menuPath" varStatus="status"><c:if test="${status.last}"><c:out value="${menuPath}" />(<c:out value="${searchCondition.adminGrpName}" />)</c:if></c:forEach></p>
						<span>
							<c:forEach items="${menuPathList}" var="menuPath" varStatus="status">
								<c:choose>
									<c:when test="${!status.last}"><c:out value="${menuPath}"/> &gt; </c:when>
									<c:otherwise><em><c:out value="${menuPath}"/></em></c:otherwise>
								</c:choose>
							</c:forEach>
						</span>
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
                        	<input type="hidden" name="viewFlg" value="" />
                        	<input type="hidden" name="adminId" value="" />
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
										<label for="aa2" class="laType02">분배직원</label>
										<span class="input-text07"><input type="text" name="searchAdmin" class="" value=""/></span>
									</div>
									<div class="section">
										<label for="stationGrpSlt" class="laType02">승인여부</label>
										<select class="select-category02" name="searchAprd">
                                               <option value="">선택</option>
                                               <option value="N">미승인</option>
                                               <option value="Y">승인</option>
                                           </select>
									</div>
									<div class="section pright">
										<label for="aa1" class="laType02">센터</label>
										<select class="select-category01" name="searchCenter" id="centerSlt">
											<option value="">선택</option>
										</select>
									</div>
									<button id="searchBtn" class="btn-srh03 btncase1"><img src="/images/searchIcon.gif" alt="검색"></button>
								</div>
							</fieldset>
						</div>
                       	<!-- 검색조건  E -->
                       	<!-- 검색결과 S -->
						<p class="tb_numlist">총 ${ paginationInfo.getTotalRecordCount()} 건</p>
						<div class="widscr mt5">
							<c:choose>
								<c:when test="${fn:length(workList) ne 0 }">
		                        	<table class="tb_type02 my-3">
		                        		<caption>분배원 근태 정보 조회</caption>
		                        		<colgroup>
		                        			<col style="width:9%">
		                                    <col style="width:7%">
		                                    <col style="width:7%">
		                                    <col style="width:13%">
		                                    <col style="width:11%">
		                                    <col style="width:13%">
		                                    <col style="width:13%">
		                                    <col style="width:8%">
		                                    <col style="width:10%">
		                        		</colgroup>
		                        		<thead>
		                        			<tr>
												<th class="top text-center">근무일</th>
                        						<th class="top text-center">근무<br/>시간</th>
                        						<th class="top text-center">근무<br/>유형</th>
                        						<th class="top text-center">분배 외 시간</th>
                        						<th class="top text-center">근무자</th>
                        						<th class="top text-center">수기출고</th>
                        						<th class="top text-center">수기입고</th>
                        						<th class="top text-center">승인 <input type="checkbox" id="chkApproved" value=""/></th>
                        						<th class="top text-center">승인자</th>
		                        			</tr>
		                        		</thead>
		                        		<tbody id="tbodyTarget">
		                        		
		                        			<c:set var="date" value="<%= new java.util.Date() %>" />
		                        			<c:set var="nowDateFormat"><fmt:formatDate value="${date}" pattern="yyyy-MM-dd" /></c:set>
		                        			<fmt:parseDate value="${nowDateFormat}" var="nowPlanDate" pattern="yyyy-MM-dd"/>
		                        			<fmt:parseNumber value="${nowPlanDate.time / (1000*60*60*24)}" integerOnly="true" var="nowDate"></fmt:parseNumber>
		                        			
			                        		<c:forEach items="${workList}" var="list" varStatus="vst">
			                        		
			                        			<input name="workSeqArr${vst.index}" type="hidden" value="${list.workSeq}"/>
			                        			
				                        		<fmt:parseDate value="${list.workDate}" var="workPlanDate" pattern="yyyy-MM-dd" />
				                        		<fmt:parseNumber value="${workPlanDate.time / (1000*60*60*24)}" integerOnly="true" var="workDate"></fmt:parseNumber>                        			
			                        			
			                        			<tr>
			                        				<td class="text-center"><fmt:formatDate value="${workPlanDate}" pattern="MM-dd" /></td>
				                        			
				                        			<td class="text-center"><c:out value="${list.workTime}"></c:out></td>
				                        			
				                        			<td class="text-center">
				                        			${fn:replace(list.workDiv, newLineChar, "<br/>")} </td>
				                        			
			                        				<td class="text-center">
			                        				${fn:replace(list.dtlName, newLineChar, "<br/>")} </td>
				                        			 
				                        			
				                        			<td class="text-center"><c:out value="${list.adminName}"></c:out></td>
				                        			
				                        			<td class="text-center">
				                        			${fn:replace(list.moveBikeCd, newLineChar, "<br/>")}
													</td>
				                        			<td class="text-center">
				                        			
				                        			${fn:replace(list.relocateBikeCd, newLineChar, "<br/>")}
				                        			
													</td>
				                        			
					                        		<c:if test="${list.isChangeAble == 1 }">
	    						                       	<c:if test="${list.approved eq 'Y'}" var="checkValue">
						                        			<td class="text-center"><input type="checkbox" class="chkApproved" name="chkApproved${vst.index}" onfocus="this.oldVal = this.checked; this.idx = ${vst.index};" checked=<c:out value="${checkValue}"/>></td>
				                        				</c:if>
				                        				
				                        				<c:if test="${list.approved ne 'Y'}">
						                        			<td class="text-center"><input type="checkbox" class="chkApproved" name="chkApproved${vst.index}" onfocus="this.oldVal = this.checked; this.idx = ${vst.index};"></td>
				                        				</c:if>
				                        				
				                        			</c:if>
				                        			
					                        		<c:if test="${list.isChangeAble == 0 }">
	    						                       	<c:if test="${list.approved eq 'Y'}" var="checkValue">
						                        			<td class="text-center"><input type="checkbox" disabled="disabled" class="chkApproved" name="chkApproved${vst.index}" onfocus="this.oldVal = this.checked; this.idx = ${vst.index};" checked=<c:out value="${checkValue}"/>></td>
				                        				</c:if>
				                        				
				                        				<c:if test="${list.approved ne 'Y'}">
						                        			<td class="text-center"><input type="checkbox" disabled="disabled" class="chkApproved" name="chkApproved${vst.index}" onfocus="this.oldVal = this.checked; this.idx = ${vst.index};"></td>
				                        				</c:if>
				                        				
				                        			</c:if>
				                        				  
				                        			<td class="text-center"><c:out value="${list.approverName}"></c:out></td>
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
                    	<div class="btnArea">
							<span class="right">
								<button class="btnType01" id="approvedBtn">승인 처리</button>
								<button class="btnType01" id="excelViewBtn" title="엑셀다운로드">엑셀다운로드</button>
							</span>
						</div>
                    	<!-- 버튼구역 E  -->
                    	<!-- 페이징 S  -->
                    	<div>
                    	<c:choose>
							<c:when test="${searchCondition.searchAprd eq 'N'}">
								<div class="drpaging" style="display:none;">
							</c:when>
							<c:when test="${fn:length(workList) > 0}">
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
    	
    	switch('${searchCondition.adminGrpName}'){
				
			case "분배" :
				
				$("#approvedBtn").hide();
				$("#chkApproved").hide();		
				$("[name='searchAdmin']").closest('div').hide();
				
			case "분배반장" :
				
				$("#excelViewBtn").hide();
				$("[name='searchCenter']").closest('div').attr("style","visibility:hidden");
				
			break;
			
			case "관리운영그룹" :
			case "관리팀" :
			break;
			
			default :

				$("#approvedBtn").hide();
				$("#chkApproved").hide();		
				$("[name='searchAdmin']").closest('div').hide();				
				$("#excelViewBtn").hide();
				$("[name='searchCenter']").closest('div').attr("style","visibility:hidden");
				
			break;	
			
    	}
    	
    	/****** 그룹 별 화면 show hide 처리 E ******/
    	
    	/*********** 검색구간 정보 S  ***********/
    	repairWorkInfo.init();
    	
    	var date = new Date;
		date.setDate(date.getDate()-6);
		var fromday = DateUtil.dateFmt(new Date()); /* DateUtil.dateFmt(date); 당일로 변경*/
		var today = DateUtil.dateFmt(new Date());
 		var sDate = '${searchCondition.searchBgnDe}' !== '' ? '${searchCondition.searchBgnDe}' : fromday;
		var eDate = '${searchCondition.searchEndDe}' !== '' ? '${searchCondition.searchEndDe}' : today;
		var searchAdmin = '${searchCondition.searchAdmin}' !== '' ? '${searchCondition.searchAdmin}' : '';
		var searchCenter = '${searchCondition.searchCenter}' !== '' ? '${searchCondition.searchCenter}' : '';
		var searchAprd = '${searchCondition.searchAprd}' !== '' ? '${searchCondition.searchAprd}' : '';
		var adminId = '${searchCondition.adminId}' !== '' ? '${searchCondition.adminId}' : '';
		repairWorkInfo.searchCenterId = searchCenter;		
		
		$("[name='searchBgnDe']").val(sDate);
		$("[name='searchEndDe']").val(eDate);
		$("[name='searchAdmin']").val(searchAdmin);
		$("[name='searchCenter']").val(searchCenter);
		$("[name='searchAprd']").val(searchAprd);
		$("[name='adminId']").val(adminId);
		
    	/*********** 검색구간 정보 E  ***********/
    	
    	
    	/*********** 승인여부 원본 저장 S ***********/
    	
		repairWorkInfo.orgApdArr = Aprvd();
    	
		/*********** 승인여부 원본 저장 E ***********/
		
		/*********** 페이징  S ***********/
		
    	var totalPageCount = '${paginationInfo.totalPageCount}' == '' ? 1 : Number('${paginationInfo.totalPageCount}');
   		$('#prevPage').on("click",function(){
   			
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			repairWorkInfo.pageSelect(currentPageNo-1);
			
		});
		$('#nextPage').on("click",function(){
			
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			repairWorkInfo.pageSelect(currentPageNo+1);
			
		});
		$('#movePage').on("click",function(){
			
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			var regExp = /^[1-9]?[0-9]/;
			
			if(!regExp.test(currentPageNo) ||(totalPageCount < currentPageNo)){
				
				alert('현재 페이지 값이 정상적이지 않습니다.');
				
			}else{
				
				repairWorkInfo.pageSelect(currentPageNo);
				
			}
			
		});
		
		/*********** 페이징  E ***********/
		
		/*********** 화면단 이벤트 리스너 S ***********/
				
		$(document).on('change','.chkApproved',function(){//승인 체크박스 이벤트리스너 : 값을 저장해 둔다. 맨처음 값과 비교하기 위해
			if(repairWorkInfo.chgApdArr == null){
				
				repairWorkInfo.chgApdArr = [];
				repairWorkInfo.chgApdArr[this.idx] = this.checked;
				
			}else{
				
				repairWorkInfo.chgApdArr[this.idx] = this.checked;
			}
		});
		
		$("#chkApproved").on('change', function(){//일괄 승인 체크박스 : 일괄 체크박스 체크 & 해제 하며 그 값들을 저장해 둔다. 맨처음 값과 비교하기 위해
			
			var dr = $(this).is(":checked");
			var arr = repairWorkInfo.orgApdArr;
			var chgArr = [arr.length];
			
			if(dr){//체크일 때
				
				$(".chkApproved").each(function(idx,el){
					
					if($(this).is(":disabled") == false){//승인가능 날짜제한 당일 지난 건은 disabled 처리 하였음.
						
						var item = el.checked;
						
						if(item == false){
							
							var name = "chkApproved"+idx;
							chgArr[idx] = true;
							$('input:checkbox[name="'+name+'"]').prop("checked",true);
							
						}
						
					}
					
				});
			
			}else{//해제일 때
				
				$(".chkApproved").each(function(idx,el){
					
					var item = el.checked;
					
					if(item == true){
						
						var name = "chkApproved"+idx;
						chgArr[idx] = false;
						$('input:checkbox[name="'+name+'"]').prop("checked",false);
						
					}
					
				});
				
			}
			
			repairWorkInfo.chgApdArr = chgArr;
			
		});
		
		$("#approvedBtn").on('click',function(e){//승인저장 버튼 : 맨처음 받아온 aprroved 값과 화면에서 처리한 aprroved 값들을 비교해 바뀐 것만 처리
			e.preventDefault();
			var chkArr = [];
			var workSeqArr = [];
			
			var checkChange = false;
			
			if(repairWorkInfo.chgApdArr != null){
				
				for(var idx in repairWorkInfo.orgApdArr){
					
					if(repairWorkInfo.chgApdArr[idx] == true || repairWorkInfo.chgApdArr[idx] == false){
						
						if(repairWorkInfo.orgApdArr[idx] != repairWorkInfo.chgApdArr[idx]){
							
							chkArr[idx] = repairWorkInfo.chgApdArr[idx] == true ? 'Y' : 'N';
							workSeqArr[idx] = $("input:hidden[name='workSeqArr"+idx+"']").val();
							
							checkChange = true;
							
						}
						
					}
					
				}
				
				if(checkChange){
					
					var params = {};
					params.approverId = '<%= com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil.getSessionAttribute(request, "usrId") %>';
					params.workSeqArr = workSeqArr;
					params.approvedArr = chkArr;
					
					$.ajax({
						type : "post",
						url : "/distributionDiary/updateDistWorkAprvdAjax.do",
						traditional : true,
						data : params,
						success : function(data){
							
							var cnt = 0;
							
							for(var i=0; i< workSeqArr.length; i++){
								
								if(workSeqArr[i] != null) cnt++;
								
							}
							alert(cnt+"명 승인처리 되었습니다.");
							window.location.reload();
						},
						error : function(data){
							alert("승인처리 실패했습니다.");
						}
					});
					
				}else{
					
					alert("변경사항이 없습니다.");
					
				}
				
			}else{
				
				alert("승인처리할 인원을 선택해주세요.");
				
			}
			
		});
		
		$("#searchBtn").on("click",function(e){
			
			e.preventDefault();
			
			$("[name='viewFlg']").val("list");
			
			$("#searchFrm").attr({method : 'post', action :'/distributionDiary/getDistWork.do'}).submit();
			
		});
		
		$("#excelViewBtn").on("click",function(e){
			
			e.preventDefault();
	         
	         $("[name='currentPageNo']").val(1);

	         $("[name='viewFlg']").val("excel");
	         
	         $("#searchFrm").attr({method : 'post', action : '/distributionDiary/getDistWork.do'}).submit();
	         
		});
		
		/*********** 화면단 이벤트 리스너 E ***********/
		

    });

    /*********** 변수 & 함수 S ***********/
    
   	var repairWorkInfo = {};
   	repairWorkInfo.orgApdArr;
   	repairWorkInfo.chgApdArr;
   	
   	repairWorkInfo.init = function(){
        
   		if ( $("#centerSlt option").size()  < 2 ) {
	   		commonAjax.getCommonCode("DEC", 
	                function(data) {
	        	         if(data !== null && data.codeList !== null) {
	        	        	 var code = new Array();
	        	             for(var i =0; i <data.codeList.length ;i++) {
	        	                     code.push(data.codeList[i]);
	        	             }
	        	             commCdBox.makeComboBox('CC', '', code, "centerSlt");
	        	         }
	        	}); 
   		}	
   	};
 
   	repairWorkInfo.pageSelect = function(pageNo) {
       	$("[name='currentPageNo']").val(pageNo);
       	$("[name='viewFlg']").val('list');
       	
       	$("#searchFrm").attr({method : 'post', action :'/distributionDiary/getDistWork.do'}).submit();
       	
    };
    
    function Aprvd(){
    	
    	this.result = [];
    	var _this = this;
    	
    	$(".chkApproved").each(function(){
    		
    		var val = $(this).is(":checked");
    		_this.result.push(val);
    		
    	});
    	
    	return this.result;
    	
    }
    
    /*********** 변수 & 함수 E ***********/
    
    </script>
</body>
</html>