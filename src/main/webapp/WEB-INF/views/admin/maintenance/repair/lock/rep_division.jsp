<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" /> 
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />
<meta name="description=" Content="" />
<title><tiles:insertAttribute name="title"/></title>
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

						<form name="searchFrm" id="searchFrm" method="post">
						<input type="hidden" name="btn_chk"	id="btn_chk" value="${btnChk}" >
						<input type="hidden" name="totalPage" id="totalPage" value="${paginationInfo.totalPageCount}" >
						<input type="hidden" name="comCdArr"	id="comCdArr" value="" >
						<%-- <input type="hidden" name="currentPageNo" id="currentPageNo" value="${paginationInfo.currentPageNo}">  --%>
						<input type="hidden" name="comCd" id="comCd" value="">
						
						
						<div class="page">
						<!-- 모바일 검색조건 S-->
						<div class="tabWrap type3">
							<ul class="tabBox">
								<c:if test="${btnChk == 1 || btnChk == null}">
									<li class="tab on" ><button type="button" id="bike" value="1">자전거</button></li>
									<li class="tab"><button type="button" id="ap" value="2">AP</button></li>
									<li class="tab"><button type="button" id="lock" value="3">거치대</button></li>
								</c:if>	
								<c:if test="${btnChk == 2}">
									<li class="tab" ><button type="button" id="bike" value="1">자전거</button></li>
									<li class="tab on"><button type="button" id="ap" value="2">AP</button></li>
									<li class="tab"><button type="button" id="lock" value="3">거치대</button></li>
								</c:if>	
								<c:if test="${btnChk == 3}">
									<li class="tab" ><button type="button" id="bike" value="1">자전거</button></li>
									<li class="tab"><button type="button" id="ap" value="2">AP</button></li>
									<li class="tab on"><button type="button" id="lock" value="3">거치대</button></li>
								</c:if>	
							</ul>
						</div>
						<!-- 모바일 검색조건 E-->
						<!--검색조건 S-->
						<!--검색조건 E-->
						<p class="tb_numlist" style="margin-top: -10px">총 ${ paginationInfo.getTotalRecordCount()} 건</p>
						<table class="tb_type01">
							<colgroup>
								<col style="width:4%"/>
								<col style="width:40%"/>
								<col style="width:10%"/>
								<col style="width:23%"/>
								<col style="width:23%"/>
							</colgroup>
							<thead>
								<tr>
									<th></th>
									<th>수리구분명</th>
									<th>사용여부</th>
									<th>등록관리자ID</th>
									<th>등록(수정)일자</th>
								</tr>
							</thead>
							<tbody>	
								<c:forEach var="result" items="${RepairDivisionList}" varStatus="status">
	                                <tr>
	                                	<td><span class="input-rd01"><input type="checkbox" name="comChk"  style="margin-left: 4px" value='${result.comCd}'></span></td>
	                                    <td><a href="#" onClick="udtDivision('${result.comCd}'); return false">${result.mlangComCdName}</a></td>
	                                    <td>${result.useYn}</a></td> 
	                                    <td>${result.regId}</a></td> 
	                                    <td>${result.regDttm}</a></td>
	                                </tr>
	                            </c:forEach>    
                           	<c:if test="${fn:length(RepairDivisionList) eq 0 }">
								<table class="tb_type01 nbt0">
									<tr><td style="text-align:center"><spring:message code="search.nodata.msg" /></td></tr>
								</table>
							</c:if>
							</tbody>
						</table>
					<c:choose>
						<c:when test="${fn:length(RepairDivisionList) > 0}">
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
							<span><input name="currentPageNo" id="currentPageNo" type="number" value="${paginationInfo.currentPageNo}"/><em>/ ${paginationInfo.totalPageCount}</em><button id="movePage">이동</button></span>
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
							<span class="right"><button class="btnType01" id="delDivisionEditForm">삭제</button></span>
							<span class="right"><button class="btnType01" id="addDivisionEditForm">추가</button></span>
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
        
		$("#divisionDetail").click(function(){
			$("#btn_chk").val($("#btn_chk").val());
			$("#searchFrm").attr({method : 'post', action : '/divisionEditForm.do'}).submit();
		});
		
		//추가
		$("#addDivisionEditForm").click(function(){
			$("#btn_chk").val($("#btn_chk").val());
			$("#searchFrm").attr({method : 'post', action : '/divisionEditAdd.do'}).submit();
		});
		
		/* $("#udtDivision").click(function(){
			alert($(this).parent().prev().text());
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			$("#btn_chk").val($("#btn_chk").val());
			$("#currentPageNo").val(currentPageNo);
			
			$("#searchFrm").attr({method : 'post', action : '/divisionEditUdt.do'}).submit();
		}); */
		
		//삭제
		$("#delDivisionEditForm").click(function(){
			if($('[name="comChk"]:checked').val() != null){
				if(confirm("삭제 하시겠습니까?")){
					var rentType = "";
			        $('[name="comChk"]:checked').each(function(idx){
			        	if(idx == 0){
			        		rentType = rentType + $(this).val();
			        	}else{
			        		rentType = rentType + "," + $(this).val();
			        	}
			        });
			        $("#comCdArr").val(rentType);
			        $("#searchFrm").attr({method : 'post', action : '/divisionEditDel.do'}).submit();
				}
			}else{
				alert("삭제할 항목을 체크해 주십시오.");
				return false;
			}
		});

		
		//자전거 클릭시
		$("#bike").click(function(){
			if($("#searchStartDate").val()  &&  $("#searchEndDate").val())
				if($("#searchStartDate").val() > $("#searchEndDate").val()){
					alert('<spring:message code="fail.input.daterange" />');
					return;
				}
				$("#currentPageNo").val(1);
				$("#btn_chk").val($("#bike").val());
				
				$("#searchFrm").attr({method : 'post', action : '/repairDivision.do'}).submit();
		});
		
		//AP 클릭시
		$("#ap").click(function(){
			if($("#searchStartDate").val()  &&  $("#searchEndDate").val())
				if($("#searchStartDate").val() > $("#searchEndDate").val()){
					alert('<spring:message code="fail.input.daterange" />');
					return;
				}
				$("#currentPageNo").val(1);
				$("#btn_chk").val($("#ap").val());
				
				$("#searchFrm").attr({method : 'post', action : '/repairDivision.do'}).submit();
		});
		
		//거치대 클릭시
		$("#lock").click(function(){
			if($("#searchStartDate").val()  &&  $("#searchEndDate").val())
				if($("#searchStartDate").val() > $("#searchEndDate").val()){
					alert('<spring:message code="fail.input.daterange" />');
					return;
				}
				$("#currentPageNo").val(1);
				$("#btn_chk").val($("#lock").val());
				
				$("#searchFrm").attr({method : 'post', action : '/repairDivision.do'}).submit();
		});
		
		//next page
		$("#nextPage").click(function(){
			if($("#searchStartDate").val()  &&  $("#searchEndDate").val())
				if($("#searchStartDate").val() > $("#searchEndDate").val()){
					alert('<spring:message code="fail.input.daterange" />');
					return;
				}
				$("#currentPageNo").val(Number($("#currentPageNo").val())+1);
				$("#btn_chk").val($("#btn_chk").val());
				
				$("#searchFrm").attr({method : 'post', action : '/repairDivision.do'}).submit();
		});
		
		//prev page
		$("#prevPage").click(function(){
			if($("#searchStartDate").val()  &&  $("#searchEndDate").val())
				if($("#searchStartDate").val() > $("#searchEndDate").val()){
					alert('<spring:message code="fail.input.daterange" />');
					return;
				}
				$("#currentPageNo").val(Number($("#currentPageNo").val())-1);
				$("#btn_chk").val($("#btn_chk").val());
				
				$("#searchFrm").attr({method : 'post', action : '/repairDivision.do'}).submit();
		});
		
		$("#movePage").click(function(){
			if(Number($("#currentPageNo").val()) > $("#totalPage").val()){
				alert("현재 페이지 값이 정상적이지 않습니다.");
				return false;
			}
		});
		
		
	});
   	
   	function udtDivision(val){
   		var currentPageNo = Number($('[name="currentPageNo"]').val());
		$("#btn_chk").val($("#btn_chk").val());
		$("#currentPageNo").val(currentPageNo);
		$("#comCd").val(val);
		
		$("#searchFrm").attr({method : 'post', action : '/divisionEditUdt.do'}).submit();
   	}
   	
    </script>
</body>
</html>