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
<script type="text/javaScript" language="javascript">
/* 글 수정 화면 function */
function usrInfo(usrId) {
	document.searchFrm.usrId.value = usrId;
   	document.searchFrm.action = "<c:url value='/admin/system/userMgmt/userInfo.do'/>";
   	document.searchFrm.submit();		
}
/* 글 등록 화면 function */
function goUsrInsertForm() {
   	document.searchFrm.action = "<c:url value='/admin/system/userMgmt/usrInsertForm.do'/>";
   	document.searchFrm.submit();		
}

/* 글 목록 화면 function */
function searchUsrList() {
	linkPage(1);
}
/* pagination 페이지 링크 function */
function linkPage(pageNo){
	document.searchFrm.currentPageNo.value = pageNo;
	document.searchFrm.action = "<c:url value='/admin/system/userMgmt/userList.do'/>";
   	document.searchFrm.submit();
}

$(function() {
	$("select[name=searchType]").val("${searchFrm.searchType}");
	$("select[name=searchUsrGrpCd]").val("${searchFrm.searchUsrGrpCd}");
	if('${searchFrm.accs_ctrl_yn }' == "Y"){
		$("#accs_ctrl_yn").prop('checked', true);
	}
});
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
				<!--conteent S-->
                <div class="content">
					<div class="subject">
						<p class="pageTitle">운영자 목록</p>
						<span>시스템 관리 &gt; <em>운영자 목록</em></span>
					</div>
					<div class="page">
					    <form:form commandName="searchFrm" name="searchFrm" method="post">
		                <input type="hidden" name="usrId" />
						<!-- 모바일 검색조건 S-->
						<div class="shBox_m">
							<div class="downtitle">
								<div class="title">
									<p>검색조건</p><span><button type="button"><img src="/images/srh_open.png" alt="검색조건 열기" /></button></span>
								</div>
							</div>
						</div>
						<!-- 모바일 검색조건 E-->
						<!--검색조건 S-->
						<div class="shBox">
							<fieldset>
								<legend>검색 옵션</legend>
								<div class="shBoxSection">
									<div class="section">
										<label for="a1" class="laType02">그룹명</label>
										<select class="select-category03" id="searchUsrGrpCd" name="searchUsrGrpCd">
											<option value="">선택</option>
											<c:forEach var="nameList" items="${groNameList }">
												<option value="${nameList.usrGrpCd }">${nameList.grpName }</option>
											</c:forEach>
										</select>
									</div>
									<div class="section pright">
										<label for="aa1" class="laType02">구분</label>
										<select class="select-category07" id="searchType"	name="searchType">
											<option value="">선택</option>
											<option value="name">이름</option>
											<option value="id">ID</option>
										</select>
										<span class="input-text08"><input type="text" class="" name="searchUsrName"	id="searchUsrName" value="${searchFrm.searchUsrName}"/></span>
									</div>
									
									<div class="section">
										<label for="a1" class="laType02">접근제어</label>
										<span class="checkbox"><input type="checkbox" name="accs_ctrl_yn" id="accs_ctrl_yn" value="Y" /></span>
										<button class="btn-srh03 btncase1" onclick="searchUsrList(); return false;"><img src="/images/searchIcon.gif" alt="검색"></button>
									</div>
								</div>
							</fieldset>
						</div>
						<!--검색조건 E-->
						<p class="tb_numlist">
							총 ${paginationInfo.totalRecordCount } 건
						</p>
						<table class="tb_type01">
							<colgroup>
								<col style="width:5%"/>
								<col style="width:15%"/>
								<col style="width:15%"/>
								<col style="width:15%"/>
								<col style="width:15%"/>
								<col style="width:15%"/>
								<col style="width:15%"/>
							</colgroup>
							<thead>
								<tr>
									<th><input type="checkbox" id="chkAll"/></th>
									<th>ID</th>
									<th>이름</th>
									<th>그룹명</th>
									<th>휴대번호</th>
									<th>수정일</th>
									<th>사용유무</th>
								</tr>
							</thead>
							<tbody>
								<c:if test="${fn:length(usrList) > 0 }">                  
									<c:forEach var="result" items="${usrList}" varStatus="status">
		                                <tr>
		                                    <td class="tc"><input type="checkbox"/></td>
		                                    <td style="text-align: left; padding-left: 1%;"><a href="#"  onclick="usrInfo('<c:out value="${result.usrId}"/>')" ><c:out value="${result.usrId}"/></a></td>
		                                    <td style="text-align: left; padding-left: 1%;"><c:out value="${result.usrName}"/></td>
		                                    <td style="text-align: left; padding-left: 1%;"><c:out value="${result.grpName}"/></td>
		                                    <td class="tc"><c:out value="${result.mpnNo}"/></td>
		                                    <td class="tc"><c:out value="${result.modDate}"/></td>
		                                    <td class="tc"><c:if test="${result.useYn eq 'Y'}">사용</c:if><c:if test="${result.useYn eq 'N'}">정지</c:if></td>
		                                </tr>
									</c:forEach>
								</c:if>
                            	<c:if test="${fn:length(usrList) == 0 }">  
	                                <tr>
	                                	<td colspan="6" class="tc"><spring:message code="info.nodata.msg" /></td>
	                                </tr>
								</c:if>
							</tbody>
						</table>
					<c:choose>
						<c:when test="${fn:length(usrList) > 0}">
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
	                    </form:form>
						<div class="btnArea">
							<span class="right" >
								<button type="button" class="btnType01" id="selectSmsBtn">선택발송</button>
	                            <button type="button" class="btnType01" id="allSmsBtn">전체발송</button>
								<button type="button" class="btnType01 bc_green" onclick="goUsrInsertForm(); return false;">등록</button>
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
	$(function(){
		 $("#chkAll").on("click", function(e){
	         if( $("#chkAll").prop("checked")) {
	             $(".tb_type01 > tbody > tr").find('input:checkbox').prop("checked", true);
	         } else {
	             $(".tb_type01 > tbody > tr").find('input:checkbox').prop("checked", false);
	         }
	     });
		 $(".tb_type01 > tbody > tr").on("change",'input' ,function(e){
	         if(!$(this).prop("checked")) {
	             $("#chkAll").prop("checked", false);
	         } 
	     });
	     $("#selectSmsBtn").on("click", {smsType : ''}, showSmsPopup);
	     $("#allSmsBtn").on("click", {smsType : 'ALL'}, showSmsPopup);
	     
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
	
	function showSmsPopup(e) {
		e.preventDefault();
        e.stopPropagation();
        if( $('body').find(".winNewPop") !== undefined && $('body').find(".winNewPop").length >0 ) {
            $('body').find(".winNewPop").remove();
        }
        var mpnNoList = [];
        if(e.data.smsType ==='ALL') {
            if(Number('${fn:length(usrList)}') === 0) {
                alert("발송할 데이터가 없습니다.");
                return false;
            }
            
            var $a = $("<a>", {'href' : '/admin/system/userMgmt/getSmsAllAdminMpnNo.do', 'title' : 'sms', 'data-width' :"450" ,'data-height' :"550", 'data-pmt' : '&UsrMpnNo=&'+$("#searchFrm").serialize() }).addClass("winNewPop modal");
            $('body').first().append($a);
            $(".winNewPop").trigger("click");
            
            /* commonAjax.postAjax("/admin/system/userMgmt/getSmsAllAdminMpnNo.do", "json", $("#searchFrm").serialize()
                ,function(data) {
                     if(data) {
                         var pSize = data.adminSmsList.length;
                         for(var i=0; i< pSize; i++) {
                        	 if(data.adminSmsList[i].mpnNo !== "") {
	                             mpnNoList.push(data.adminSmsList[i].mpnNo);
                        	 }
                         }
                         
                     }
                }
            ); */
        } else {
            $(".tb_type01 > tbody > tr").each(function(idx) {
                if($(this).find("input[type='checkbox']").is(':checked')) {
                	if($(this).children().eq(4).text() !== '') {
	                    mpnNoList.push($(this).children().eq(4).text());
                	}
                }
            });
            if(mpnNoList.length === 0){
                alert("선택 발송할 전화번호를 선택해 주세요.");
                return false;
            }
            var $a = $("<a>", {'href' : '/common/pop/showSmsPopup.do', 'title' : 'sms', 'data-width' :"450" ,'data-height' :"550", 'data-pmt' : '&UsrMpnNo='+mpnNoList.toString() }).addClass("winNewPop modal");
            $('body').first().append($a);
            $(".winNewPop").trigger("click");
        }
	}
	</script>
</body>
</html>

