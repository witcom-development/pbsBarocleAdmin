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
                        <form id="frm">
                            <input type="hidden" name="viewFlg" value="${invent.getViewFlg()}">
                            <input type="hidden" name="partCd" value="">
                            <input type="hidden" name="centerId" value="">
                            <input type="hidden" name="partName" value="">
                            <input type="hidden" name="centerName" value="">
                            <input type="hidden" name="useClsCd" value="STK_001">
                            <input type="hidden" name="searchStartDate" value="${inventVo.getSearchStartDate() }">
                            <input type="hidden" name="searchEndDate" value="${inventVo.getSearchEndDate() }">
                            <fieldset>
                                <legend>재고내역</legend>
                                <table class="tb_type02 mt20">
                                    <colgroup>
                                        <col style="width:25%"/>
                                        <col style="width:75%"/>
                                    </colgroup>
                                    <tbody>
                                        <tr>
                                            <th class="top"><em>*</em> 센터명</th>
                                            <td class="top">
                                                <select class="select-category01" id="centerSlt">
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
                                            </td>
                                        </tr>
                                        <tr>
                                            <th><em>*</em> 부품명</th>
                                            <td>
                                                <select class="select-category01"  id="partSlt">
                                                    <option value="">선택</option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th><em>*</em> 수량</th>
                                            <td>
                                                <span class="input-text08"><input type="text"class="tr"   maxlength="5" id="stockQunt" name='stockQunt' value="${inventData.stockQunt}" /></span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th><em>*</em> 수정이유</th>
                                            <td>
                                               <span class="input-text07"><input type="text" maxlength="200" id="modReasonDesc" name='modReasonDesc' value="" /></span>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </fieldset>
                        <div class="btnArea">
                            <span class="left"><button type="button" id="listPageBtn" class="btnType01 bc_gray">목록</button></span>
                            <span class="right"><button type="button" id="editBtn" class="btnType01 bc_green">저장</button></span>   
                        </div>
                        <section id="historyBlock" style="display: none;">
                            <p class="head">재고 이력</p>
                            <table class="tb_type01 mt20">
                                <colgroup>
                                    <col style="width:10%"/>
                                    <col style="width:15%" class="mhid"/>
                                    <col style="width:15%"/>
                                    <col style="width:30%"/>
                                    <col style="width:20%"/>
                                </colgroup>
                                <thead>
                                    <tr>
                                        <th>구분</th>
                                        <th class="mhid">수정자</th>
                                        <th>사용량</th>
                                        <th>수정 이유</th>
                                        <th>날짜</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="history" items="${history}" varStatus="loop">
                                    <tr>
                                        <td class="tc pr10">${history.useClsCdName}</td>
                                        <td class="pl10 mhid">${history.modId }</td>
                                        <td class="tr pr10">${history.partQunt}</td>
                                        <td class="pl10">${history.modReasonDesc }</td>
                                        <td class="tc">${history.modDttm }</td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                            <c:if test='${fn:length(history) == 0}'>
                            <table class="tb_type01 nbt0">
                                <tr><td style="text-align:center"><spring:message code="search.nodata.msg" /></td></tr>
                            </table>
                            </c:if>
                        </section>
					<c:choose>
						<c:when test="${fn:length(history) > 0}">
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
							<span class="right"><button class="btnType01" id="excelViewBtn" title="엑셀다운로드">엑셀다운로드</button></span>
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
        inventDetail.initView('${invent.getViewFlg()}');
        inventDetail.initBtn();
        inventDetail.initCommbo('${invent.getViewFlg()}');
        
        var totalPageCount = '${paginationInfo.totalPageCount}' == '' ? 1 : Number('${paginationInfo.totalPageCount}');
   		$('#prevPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			inventDetail.pageSelect(currentPageNo-1);
		});
		$('#nextPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			inventDetail.pageSelect(currentPageNo+1);
		});
		$('#movePage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			var regExp = /^[1-9]?[0-9]/;
			if(!regExp.test(currentPageNo) ||(totalPageCount < currentPageNo)){
				alert('현재 페이지 값이 정상적이지 않습니다.');
			}else{
				inventDetail.pageSelect(currentPageNo);
			}
		});
    });
    var inventDetail = {};
    inventDetail.centerId = '${invent.getCenterId()}';
    inventDetail.partCd = '${invent.getPartCd()}';
    inventDetail.viewFlg = '${invent.getViewFlg()}';
    inventDetail.initView = function(vFlg) {
        if(vFlg === 'U') {
            $("#historyBlock").css('display', 'block');
            $("#centerSlt").prop("disabled", true);
            $("#partSlt").prop("disabled", true);
            $("[name='useClsCd']").val('STK_003');
        } else {
            $(".tb_type02 tbody tr").eq(3).css('display', 'none');
        }
    };
    
    inventDetail.initBtn = function() {
    	var _this =  inventDetail
    	$("#editBtn").on("click", this.exeStockPartEdit);
    	$("#excelViewBtn").on("click",{listType : "excel"},this.exeListFnc);
        $("#listPageBtn").on("click", function(e){
            e.preventDefault();
            _this.moveListPage(1);
        });
    };
    inventDetail.moveListPage = function(pNo) {
    	 $("[name='currentPageNo']").val(pNo);
    	 $("[name='partCd']").val('');
    	 $("[name='centerId']").val('');
         $("[name='viewFlg']").val('list');
    	 $("#frm").attr({method :'post', action : '/getStockInventList.do'}).submit();
    	
    };
    inventDetail.initCommbo = function(vFlg) {
        var _this = inventDetail;
        //부품코드
        commonAjax.getCommonCode("PAR", function(data) {
             if(data !== null && data.codeList !== null) {
                 commCdBox.makeComboBox('CC',_this.partCd,data.codeList, "partSlt");
             }
        });
     
        //센터 
        /*commonAjax.getCenterCode( 
            function(data) {
                if(data !== null && data.centerList !== null) {
                    commCdBox.makeComboBox('C', _this.centerId, data.centerList, "centerSlt");
                }
            }
        );*/
        $("#centerSlt").val(inventDetail.centerId);
        
    };
    inventDetail.exeStockPartEdit = function(){
    	if($("#centerSlt").val() === ""){
    		alert("센터를 선택해 주세요.");
    		return false;
    	}
    	if($("#partSlt").val() === ""){
            alert("부품을 선택해 주세요");
            return false;
        }
    	if($("#stockQunt").val() === ""){
            alert("수량을 선택해 주세요");
            return false;
        }
    	if(!isNumeric($("#stockQunt").val())){
            alert("숫자형식이어야 합니다.");
            $("#stockQunt").val('').focus();
            return false;
        }
    	if(inventDetail.viewFlg === 'U') {
	    	if($("#reasonSlt").val() === ""){
	            alert("수정이유를 선택해 주세요.");
	            return false;
	        }
    	}
    	$("[name='partCd']").val($("#partSlt").val());
    	$("[name='centerId']").val($("#centerSlt").val());
    	commonAjax.postAjax("/exeStockInventEdit.do", "json",$("#frm").serialize()
    		,function(data){
    		     if(data)	{
    		    	 if(data.checkResult > 0){
    		    		 alert(data.resultMessage);
    		    		 if(inventDetail.viewFlg === 'C') {
    		    			 inventDetail.moveListPage(1);
    		    		 } else {
    		    			 $("#frm").attr({method : 'post',action: '/moveStockInventEditForm.do'}).submit();
    		    		 }
    		    	 } else {
    		    		 alert(data.resultMessage);
    		    		 return false;
    		    	 }
    		     }
    	});
    };
    inventDetail.pageSelect = function(pageNo) {
        var _this = inventDetail;
        $("[name='currentPageNo']").val(pageNo);
        $("[name='centerId']").val(_this.centerId);
        $("[name='partCd']").val(_this.partCd);
        $("[name='viewFlg']").val('U');
        $("#frm").attr({method : 'post', action : '/moveStockInventEditForm.do'}).submit();
    }
    
    inventDetail.exeListFnc = function(e) {
        e.preventDefault();
        var listType = e.data.listType;
        $("[name='currentPageNo']").val(1);
    	$("[name='partCd']").val($("#partSlt").val());
    	$("[name='centerId']").val($("#centerSlt").val());
        $("[name='partName']").val($("#partSlt option:selected").text());
        $("[name='centerName']").val($("#centerSlt option:selected").text());
        $("[name='viewFlg']").val(listType);
        $("#frm").attr({method : 'post', action : '/moveStockInventEditForm.do'}).submit();
    };
    </script>
</body>
</html>