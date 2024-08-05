<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
                        <!--검색조건 S-->
                        <form id="searchFrm" name="searchFrm" class="form-horizontal form-search">
                        	<div class="shBox">
			                    <input type="hidden" name="comCd" value="" />
			                    <input type="hidden" name="viewFlg" value="" />
                                <fieldset>
                                    <legend>검색 옵션</legend>
                                    <div class="shBoxSection">
                                        <div class="section">
                                            <label for="bb22" class="laType02">등록일</label>
                                            <span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04"  name="searchBgnDe"  title="선택 날짜" id="bb22" readonly/></span>
                                            <span class="dash">~</span>
                                            <span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" name="searchEndDe" title="선택 날짜" readonly/></span>
                                        </div>
                                        <div class="section pright">
                                            <label for="aa11" class="laType02">분류명</label>
                                            <span class="input-text07"><input type="text" class="" id="aa11" name="searchWord" value="${searchCondition.searchWord }"/></span>
                                            <button class="btn-srh03 btncase1" id="searchBtn"><img src="/images/searchIcon.gif" alt="검색"></button>
                                        </div>
                                    </div>
                                </fieldset>
                        	</div>
                        <!--검색조건 E-->
                        <p class="tb_numlist">총 ${paginationInfo.getTotalRecordCount()} 건</p>
                        <table class="tb_type01">
                            <colgroup>
                                <col style="width:20%"/>
                                <col style="width:30%"/>
                                <col style="width:30%"/>
                                <col style="width:20%"/>
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>분류코드</th>
                                    <th>분류명</th>
                                    <th>수정자</th>
                                    <th>등록일</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="result" items="${codeList}" varStatus="status">
		                            <tr>
		                                <td class="tc">${result.comCd}</td>
		                                <td><a href="#" id="code_${result.comCd}">[${result.comCdName}]</a></td>
		                                <td >${result.regId}</td>
		                                <td class="tc">${result.regDttm}</td>
		                            </tr>
		                        </c:forEach>
                            </tbody>
                        </table>
                        <c:if test='${fn:length(codeList) == 0}'>
                        <table class="tb_type01 nbt0">
                            <tr><td style="text-align:center"><spring:message code="search.nodata.msg" /></td></tr>
                        </table>  
                        </c:if>
					<c:choose>
						<c:when test="${fn:length(codeList) > 0}">
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
                            <span class="right"><button class="btnType01 bc_green" id="moveEditFormBtn">등록</button></span>
                        </div>
                    </div>
                </div>
                <!--conteent E-->
            </div>
        </div>
        <!--footer S-->
        <tiles:insertAttribute name="footer" />
        <!--footer E-->
    </div>
    <script type="text/javascript" src="/js/common_barocle.js"></script>
	<script type="text/javascript">
	$(function(){
		var today = DateUtil.dateFmt(new Date());
        var sDate = '${searchCondition.searchBgnDe}' !== '' ? '${searchCondition.searchBgnDe}' : '';
        var eDate = '${searchCondition.searchEndDe}' !== '' ? '${searchCondition.searchEndDe}' : '';
     
        $( "[name='searchBgnDe']").val(sDate);
        $( "[name='searchEndDe']").val(eDate);
	    
	    commonCode.initBtn();
	    
	    var totalPageCount = '${paginationInfo.totalPageCount}' == '' ? 1 : Number('${paginationInfo.totalPageCount}');
   		$('#prevPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			commonCode.codePageSelect(currentPageNo-1);
		});
		$('#nextPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			commonCode.codePageSelect(currentPageNo+1);
		});
		$('#movePage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			var regExp = /^[1-9]?[0-9]/;
			if(!regExp.test(currentPageNo) ||(totalPageCount < currentPageNo)){
				alert('현재 페이지 값이 정상적이지 않습니다.');
			}else{
				commonCode.codePageSelect(currentPageNo);
			}
		});
	});
	
	var commonCode = {};
	
	commonCode.initBtn = function() {
	    $("#moveEditFormBtn").on("click", function() {
	        $("input:hidden[name=viewFlg]").val('C');
	        $("#searchFrm").attr({method : 'post', action : "<c:url value='/moveCodeEditForm.do'/>"}).submit();
	    });
	    $("#searchBtn").on("click", function() {
	    	if(DateUtil.checkDateTerm( $( "[name='searchBgnDe']").val(),  $( "[name='searchEndDe']").val()) !== 'ok') {
	    		alert("검색 조건의 시작 날이 종료 날보다 큽니다.");
	    		$( "[name='searchBgnDe']").val('');
	    		$( "[name='searchEndDe']").val('');
	    		return false;
	    	}
	        $("[name='currentPageNo']").val("1");
	        $("#searchFrm").attr({method : 'post', action : "<c:url value='/getCommonCodeList.do'/>"}).submit();
	    });
	    
	    $(".tb_type01 > tbody > tr").on("click","a",this.moveDetailForm);
	    $("#aa11").on('focusin', function(e) {
	    	$(this).val('');
	    });
	    
	};
	commonCode.moveDetailForm = function(e){
	    e.preventDefault();
	    var tId = e.target.id.replace("code_", "");
	    $("[name=comCd]").val(tId);
	    $("[name=viewFlg]").val('U');
	    $("#searchFrm").attr({method : 'post', action : "<c:url value='/moveCodeEditForm.do'/>"}).submit();
	};
	
	commonCode.codePageSelect = function(pageNo) {
		$("[name=viewFlg]").val('list');
	    $("[name=currentPageNo]").val(pageNo);
	    $("#searchFrm").attr({method: 'post', action : "<c:url value='/getCommonCodeList.do'/>"}).submit();
	};
	</script>
</body>
</html>
