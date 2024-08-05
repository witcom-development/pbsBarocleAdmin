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
                                    <p>검색조건</p><span><button><img src="../images/srh_open.png" alt="검색조건 열기" /></button></span>
                                </div>
                            </div>
                        </div>
                        <!-- 모바일 검색조건 E-->
                        <!--검색조건 S-->
                        <form id="searchFrm">
                        	<div class="shBox">
                                <input type="hidden" name="viewFlg" value="">
                                <input type="hidden" name="partBuySeq" value="">
                                <fieldset>
                                    <legend>검색 옵션</legend>
                                    <div class="shBoxSection">
                                        <div class="section">
                                            <label for="bb22" class="laType02">주문일</label>
                                            <span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" name="searchStartDate" title="선택 날짜" id="bb22" readonly/></span>
                                            <span class="dash">~</span>
                                            <span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" name="searchEndDate" title="선택 날짜" readonly/></span>
                                        </div>
                                        <div class="section pright etccase1">
                                            <button class="btn-srh03 btncase1 mdbtncase1" type="button" id="searchBtn"><img src="/images/searchIcon.gif" alt="검색"></button>
                                        </div>
                                    </div>
                                </fieldset>
                        	</div>
                        <!--검색조건 E-->
                        <p class="tb_numlist">총 ${paginationInfo.getTotalRecordCount() }건</p>
                        <table class="tb_type01">
                            <colgroup>
                                <col style="width:20%"/>
                                <col style="width:30%"/>
                                <col style="width:30%"/>
                                <col style="width:20%"/>
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>주문자</th>
                                    <th>주문일자</th>
                                    <th>업체명</th>
                                    <th>가격</th>
                                </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="list" items="${buyList}" varStatus="loop">
                                <tr>
                                    <td class="pl10">${list.buyerName}</td>
                                    <td class="tc pr10"><a href="#" id="${list.partBuySeq }" >${list.buyDate}</a></td>
                                    <td class="pl10">${list.buyCmpyName}</td>
                                    <td class="tr pr10">${list.totBuyPrce}</td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                        <c:if test="${fn:length(buyList) == 0 }">
                        <table class="tb_type01 nbt0">
                            <tr><td style="text-align:center"><spring:message code="search.nodata.msg" /></td></tr>
                        </table>
                        </c:if>
					<c:choose>
						<c:when test="${fn:length(buyList) > 0}">
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
                            <span class="right">
                            	<button class="btnType01 mb10" id="excelViewBtn" title="엑셀다운로드">엑셀다운로드</button>
                            	<button type="button" id="addBtn" class="btnType01 mb10">등록</button>
                            </span>
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
    $(function() {
    	var sDate = '${searchCondition.searchStartDate}' === "" ? "" : '${searchCondition.searchStartDate}';
        var eDate = '${searchCondition.searchEndDate}'   === "" ? "" : '${searchCondition.searchEndDate}';  
        
        $("[name='searchStartDate']").val(sDate);
        $("[name='searchEndDate']").val(eDate);
        
    	stockBuy.initBtn();
    	
    	var totalPageCount = '${paginationInfo.totalPageCount}' == '' ? 1 : Number('${paginationInfo.totalPageCount}');
   		$('#prevPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			stockBuy.pageSelect(currentPageNo-1);
		});
		$('#nextPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			stockBuy.pageSelect(currentPageNo+1);
		});
		$('#movePage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			var regExp = /^[1-9]?[0-9]/;
			if(!regExp.test(currentPageNo) ||(totalPageCount < currentPageNo)){
				alert('현재 페이지 값이 정상적이지 않습니다.');
			}else{
				stockBuy.pageSelect(currentPageNo);
			}
		});
    });
    
    var stockBuy = {};
    stockBuy.initBtn = function(pageNo) {
        $("#searchBtn").on("click", this.searchList);
    	$("#excelViewBtn").on("click",{listType : "excel"},this.exeListFnc);
        $("#addBtn").on("click", {viewType : 'C'}, this.moveDetailPage);
        $(".tb_type01 > tbody > tr").find('a').on('click', {viewType : 'U'}, this.moveDetailPage);
    };
    stockBuy.searchList = function (e){
    	e.preventDefault();
    	if($("[name='searchStartDate']").val() !== '' && $("[name='searchEndDate']").val() !== '') {
            if(DateUtil.checkDateTerm($("[name='searchStartDate']").val(),$("[name='searchEndDate']").val()) !== 'ok') {
                alert("시작날짜가 종료일자 보다 클수 없습니다.");
                return false;
            }
        }
    	stockBuy.exeList(1);
    	
    };
    stockBuy.pageSelect = function(pageNo) {
    	$("[name='viewFlg']").val('list');
    	stockBuy.exeList(pageNo)
    	
    };
    stockBuy.exeList = function(pNo){
    	$("[name='currentPageNo']").val(pNo);
    	$("#searchFrm").attr({method :'post', action : "/getBuyPartsList.do"}).submit();
    };
    stockBuy.moveDetailPage = function(e) {
    	e.preventDefault();
    	var vFlg = e.data.viewType;
    	$("[name='viewFlg']").val(vFlg);
    	if(vFlg === 'U') {
	    	$("[name='partBuySeq']").val(e.target.id);
    	}
    	$("#searchFrm").attr({method :'post', action : "/moveStockBuyDetailInfo.do"}).submit();
    };
    
    stockBuy.exeListFnc = function(e) {
        e.preventDefault();
        var listType = e.data.listType;

        if($("[name='searchStartDate']").val() !== '' && $("[name='searchEndDate']").val() !== '') {
            if(DateUtil.checkDateTerm($("[name='searchStartDate']").val(),$("[name='searchEndDate']").val()) !== 'ok') {
                alert("시작날짜가 종료일자 보다 클수 없습니다.");
                return false;
            }
        }
        $("[name='currentPageNo']").val(1);
        
        $("[name='viewFlg']").val(listType);
        $("#searchFrm").attr({method : 'post', action : '/getBuyPartsList.do'}).submit();
    };
    
    </script>
</body>
</html>