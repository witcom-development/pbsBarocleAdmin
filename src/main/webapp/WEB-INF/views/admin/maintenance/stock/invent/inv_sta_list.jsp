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
<!-- 
	개발일시 : 2020-11-20
	개발자   : 김시성
	내용     : 재고목록에 나오는 센터와 재고부품
	ASIS : 검색조건인 센터명 값 페이징 이동 시 유지되도록 처리 - 2020-11-20 
	TODO : 정비센터 코드들을 변경했기 때문에 센터코드 호출 ajax 주석 처리하고 하드코딩하였음
	       나중에 다시 하드코딩부분을 다시 변경작업을 해야하고 재고부품도 변경 한 수리항목과 맞춰야함 
 -->
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
                        <form id="searchFrm">
                        	<div class="shBox">
                                <input type="hidden" name="viewFlg" value="">
                                <input type="hidden" name="partCd" value="">
                                <input type="hidden" name="centerId" value="">
                                <input type="hidden" name="partName" value="">
                                <input type="hidden" name="centerName" value="">
                                <fieldset>
                                    <legend>검색 옵션</legend>
                                    <div class="shBoxSection">
                                        <div class="section pright">
                                            <label for="a1" class="laType02">센터 명</label>
                                            <select  class="select-category03" id="a1" >
                                                <option value="">선택</option>
												<option id="center_CEN001" value="CEN001">상암 운영센타</option>
												<option id="center_CEN002" value="CEN002">영남주차장</option>
												<option id="center_CEN003" value="CEN003">중랑센터</option>
												<option id="center_CEN006" value="CEN006">여의도 운영센터</option>
												<option id="center_CEN007" value="CEN007">종묘보관소</option>
												<option id="center_CEN008" value="CEN008">훈련원센터</option>
												<option id="center_CEN010" value="CEN010">강남이수센터</option>
												<option id="center_CEN090" value="CEN090">개화센터</option>
												<option id="center_CEN311" value="CEN311">천왕정비센터</option>                                                
                                            </select>
                                        </div>
                                        <div class="section">
                                            <label for="a11" class="laType02">부품</label>
                                            <select class="select-category04" id="a11">
                                                <option value="">선택</option>
                                            </select>
                                            <button type="button" id="searchBtn" class="btn-srh03 btncase1"><img src="/images/searchIcon.gif" alt="검색"></button>
                                        </div>
                                    </div>
                                </fieldset>
                        	</div>
                        <!--검색조건 E-->
                        <p class="tb_numlist">총 ${paginationInfo.getTotalRecordCount() }건</p>
                        <table class="tb_type01">
                            <colgroup>
                                <col style="width:45%"/>
                                <col style="width:35%"/>
                                <col style="width:20%"/>
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>센터 명</th>
                                    <th>부품</th>
                                    <th>수량</th>
                                </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="parts" items="${inventList}" varStatus="loop">
                                <tr>
                                    <td class="title"><a href="#" id="${parts.centerId }" data-param="${parts.partCd}">${parts.centerName }</a></td>
                                    <td class="pl10">${parts.partName }</td>
                                    <td class="tr pr10">${parts.stockQunt }</td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                        <c:if test='${fn:length(inventList) == 0}'>
                        <table class="tb_type01 nbt0">
                            <tr><td style="text-align:center"><spring:message code="search.nodata.msg" /></td></tr>
                        </table>
                        </c:if>
					<c:choose>
						<c:when test="${fn:length(inventList) > 0}">
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
                        	<button class="btnType01 mb10" id="excelViewBtn" title="엑셀다운로드">엑셀다운로드</button>
                            <a href="<c:out value='/common/pop/STOCK/openUploadPop.do'/>" id="bulkUploadBtn" class="winNewPop btnType01 mb10 mhid" title="엑셀업로드" data-width="450" data-height="380" data-pmt="" >입고 엑셀 업로드</a>
                            <button type="button" class="btnType01 mb10" id="addBtn">입고</button>
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
    	stockInvent.initCombo();
    	stockInvent.initBtn();
    	
    	if(stockInvent.centerId != null) $("#a1").val(stockInvent.centerId);
    	
    	var totalPageCount = '${paginationInfo.totalPageCount}' == '' ? 1 : Number('${paginationInfo.totalPageCount}');
   		$('#prevPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			stockInvent.pageSelect(currentPageNo-1);
		});
		$('#nextPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			stockInvent.pageSelect(currentPageNo+1);
		});
		$('#movePage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			var regExp = /^[1-9]?[0-9]/;
			if(!regExp.test(currentPageNo) ||(totalPageCount < currentPageNo)){
				alert('현재 페이지 값이 정상적이지 않습니다.');
			}else{
				stockInvent.pageSelect(currentPageNo);
			}
		});
    });
    
    var stockInvent = {};
    stockInvent.centerId = '${searchCondition.getCenterId()}';
    stockInvent.partCd = '${searchCondition.getPartCd()}';
    
    stockInvent.initBtn = function() {
    	$("#searchBtn").on("click", this.exeSearch);
    	$("#excelViewBtn").on("click",{listType : "excel"},this.exeListFnc);
        $("#addBtn").on("click", {viewType : 'C'}, this.moveDetailPage);
        $(".tb_type01 tbody tr").find('a').on("click",{viewType : 'U'}, this.moveDetailPage );
    };
    
    stockInvent.exeSearch = function(e) {
    	e.preventDefault();
        $("[name='viewFlg']").val("list");
        $("[name='currentPageNo']").val(1);
        $("[name='partCd']").val($("#a11").val());
        $("[name='centerId']").val($("#a1").val());
        stockInvent.exeList();
    	
    };
    stockInvent.initCombo = function() {
    	var _this = stockInvent;
    	//상태코드
        commonAjax.getCommonCode("PAR", function(data) {
             if(data !== null && data.codeList !== null) {
                 commCdBox.makeComboBox('CC',_this.partCd,data.codeList, "a11");
             }
        });
        //센터 - 2020-11-20 : 정비센터 코드변경으로 인해 주석처리
        /*commonAjax.getCenterCode( 
            function(data) {
                if(data !== null && data.centerList !== null) {
                    commCdBox.makeComboBox('C', _this.centerId, data.centerList, "a1");
                }
            }
        );*/
    };
    stockInvent.moveDetailPage = function(e) {
    	e.preventDefault();
    	var vType = e.data.viewType;
    	$("[name='viewFlg']").val(vType);
    	
    	if(vType === "U") {
    		$("[name='partCd']").val($(this).attr("data-param"));;
    		$("[name='centerId']").val(e.target.id);
    		
    	}
    	$("#searchFrm").attr({method : 'post',action: '/moveStockInventEditForm.do'}).submit();
    	
    };
    stockInvent.pageSelect = function(pageNo) {
    	$("[name='viewFlg']").val("list");
        $("[name='currentPageNo']").val(pageNo);
        $("[name='centerId']").val($("#a1").val());
        stockInvent.exeList();
    };
    stockInvent.exeList = function() {
    	$("#searchFrm").attr({method : 'post',action: '/getStockInventList.do'}).submit();
    };
    
    stockInvent.exeListFnc = function(e) {
        e.preventDefault();
        var listType = e.data.listType;
        $("[name='partCd']").val($("#a11").val());
        $("[name='centerId']").val($("#a1").val());
        $("[name='partName']").val($("#a11 option:selected").text());
        $("[name='centerName']").val($("#a1 option:selected").text());
        $("[name='currentPageNo']").val(1);
        $("[name='viewFlg']").val('excel');
        $("#searchFrm").attr({method : 'post', action : '/getStockInventList.do'}).submit();
    };
    
    </script>
</body>
</html>