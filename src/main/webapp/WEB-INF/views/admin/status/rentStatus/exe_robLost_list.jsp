<%@page import="com.dkitec.barocle.base.IConstants"%>
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
                        <form id="frm"></form>
                        <form id="searchFrm"> 	
                        	<div class="shBox">
                                <input type="hidden" name="viewFlg" value="" />
                                <input type="hidden" name="bikeNo" value="" />
                                <input type="hidden" name="chkType" value="" />
                                <input type="hidden" name="bikeId" value="" />
                                <input type="hidden" name="searchTypeName" value="" />
                                <input type="hidden" name="bikeStatusName" value="" />
                                
                                <fieldset>
                                    <legend>검색 옵션</legend>
                                    <div class="shBoxSection">
                                        <div class="section">
                                            <label for="bb22" class="laType02">등록일</label>
                                            <span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04"  name="searchBgnDe"  title="선택 날짜" id="bb22" readonly/></span>
                                            <span class="dash">~</span>
                                            <span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04"  name="searchEndDe"  title="선택 날짜" readonly/></span>
                                        </div>
                                        <div class="section pright">
                                            
                                            <label for="a1" class="laType02">상태</label>
                                            
                                            <select class="select-category02" id="a1" name="bikeStatusCd">
												<option value="BKS_099">도난추정</option>
                                                <option value="BKS_020">분실</option>
                                            </select>

                                        </div>
                                        <div class="section">
                                            <label for="aa1" class="laType02">구분</label>
                                            <select  id="aa1"  name="searchType">
                                                <option value="">선택</option>
                                                <option value="B">자전거번호</option>
                                            </select>
                                            <span class="input-text12"><input type="text" class="" name="searchWord"/></span>
                                        </div>
                                        <button type="button" id="searchBtn" class="btn-srh03 btncase1"><img src="/images/searchIcon.gif" alt="검색" ></button>        
                                    </div>
                                </fieldset>
                        </div>
                        <!--검색조건 E-->
                        <p class="tb_numlist">총 ${ paginationInfo.getTotalRecordCount()} 건</p>
                        <table class="tb_type01">
                            <colgroup>
                           
                                        <%--자전거번호--%>
                                        <col style="width:18%"/>
                                        <%--지역구--%>
                                        <col style="width:15%"/>
                                        <%--반납대여소명--%>
                                        <col style="width:22%"/>
                                        <col style="width:22%"/>
                                        <col style="width:10%"/>
                                        <col style="width:18%"/>
                                        <col style="width:8%"/>
                                  
                            </colgroup>
                            <thead>
                                <tr>
                                    
                                            <th>자전거</br>번호</th>
                                            <th>지역구</th>
                                            <th>반납대여소명</th>
                                            <th>반납일시</th>
                                            <th>강반</th>
                                            <!-- <th>최종신호</th> -->
                                            <th>등록일자</th>
                                            <th>경과</br>일자</th>
                                     
                                    
                                </tr>
                            </thead>
                            <c:if test="${fn:length(BikeList) > 0 }">
                            <tbody>
                                <c:forEach var="bike" items="${BikeList}" varStatus="loop">
                                    <tr>
	                                        <td class="tc"><a href="#" id="${bike.bikeId}" target="_blank">${bike.bikeNo}</a></td>
                                         
                                                <%--지역구--%>
                                                    <td class="tc">${bike.centerId}</td>
                                                <%--반납대여소명--%>
                                                    <td class="tc">${bike.stationName}</td>
                                                <%--반납일시--%>
                                                <td class="tc">
                                                    ${fn:substring(bike.lostDate, 0, 10)}</br>
                                                    ${fn:substring(bike.lostDate, 11,19)}
                                                </td>        
                                                <%--강제반납--%>
                                                <td class="tc">${bike.bikeStatusName}</td>
                                                <%--최종신호--%>
                                                <%-- <td class="tc">
                                                    ${fn:substring(bike.entrpsCd, 0, 10)}</br>
                                                    ${fn:substring(bike.entrpsCd, 11,19)}
                                                </td> --%>
                                                <%--등록일자--%>
                                                <td class="tc">
                                                    ${fn:substring(bike.regDttm, 0, 10)}</br>
                                                    ${fn:substring(bike.regDttm, 11,19)}    
                                                </td>
                                                <%--경과일자--%>
                                                <td class="tc">${bike.locateStrDttm}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                            </c:if>
                        </table>
                        <c:if test="${fn:length(BikeList) == 0 }">
                        <table class="tb_type01 nbt0">
                            <tr><td style="text-align:center"><spring:message code="search.nodata.msg" /></td></tr>
                        </table>
                        </c:if>
					<c:choose>
						<c:when test="${fn:length(BikeList) > 0}">
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
                            <button class="btnType01 mb10 mhid" id="excelViewBtn" title="엑셀다운로드">엑셀다운로드</button>
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

         //initialize
        bikeList.commonCode();
        bikeList.initBtn();
        var sDate = '${searchCondition.searchBgnDe}' !== '' ? '${searchCondition.searchBgnDe}' : "";
        var eDate = '${searchCondition.searchEndDe}' !== '' ? '${searchCondition.searchEndDe}' : "";
     
        $( "[name='searchBgnDe']").val(sDate);
        $( "[name='searchEndDe']").val(eDate);

        var totalPageCount = '${paginationInfo.totalPageCount}' == '' ? 1 : Number('${paginationInfo.totalPageCount}');
   		$('#prevPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			bikeList.pageSelect(currentPageNo-1);
		});
		$('#nextPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			bikeList.pageSelect(currentPageNo+1);
		});
		$('#movePage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			var regExp = /^[1-9]?[0-9]/;
			if(!regExp.test(currentPageNo) ||(totalPageCount < currentPageNo)){
				alert('현재 페이지 값이 정상적이지 않습니다.');
			}else{
				bikeList.pageSelect(currentPageNo);
			}
		});
        
    });

    var bikeList = {};
    bikeList.bikeStatusCd = '${searchCondition.bikeStatusCd}';
    bikeList.searchType = '${searchCondition.searchType}';
    bikeList.searchWord = '${searchCondition.searchWord}';
    bikeList.commonCode = function() {
        var _this = bikeList;
	
             
         $("#aa1").val(_this.searchType);
         $("[name='searchWord']").val(_this.searchWord);
         $("[name='bikeStatusCd']").val(_this.bikeStatusCd);
    };

    bikeList.initBtn = function () {
        
        $("#aa1").on("change", function(e){
            if($("#aa1").val() !== "") {
        		$("[name='searchWord']").val('');
        	}
        });

        // 2019-10-16 추가 포커스 갈때 우선 자전거 번호로
        $("[name='searchWord']").focus(function(){
            if ( $("#aa1").val() == null ||  $("#aa1").val() == "" ){
                $("#aa1").val("B");
            }
        });

        // 2019-10-16 추가 포커스 OUT일 때 우선 자전거 번호로
        $("[name='searchWord']").blur(function(){
            if ( $("[name='searchWord']").val() == null ||  $("[name='searchWord']").val() == "" ){
                $("#aa1").val("");
            }
        });
         

        $(".tb_type01 > tbody > tr").on("click", "a",{ viewFlg : 'U'},  this.moveEditForm);
        $("#moveBikeEditForm").on("click",{ viewFlg : 'C'}, this.moveEditForm);
        $("#excelViewBtn").on("click",{listType : "excel"},this.exeListFnc);
        $("#searchBtn").on("click",{listType: "list"},this.exeListFnc);

        
    };
    
    bikeList.exeListFnc = function(e) {
        e.preventDefault();
        e.stopPropagation();
        
        var listType = e.data.listType;
        
        if(DateUtil.checkDateTerm( $( "[name='searchBgnDe']").val(),  $( "[name='searchEndDe']").val()) !== 'ok') {
        	$( "[name='searchBgnDe']").val('searchBgnDe');
        	$( "[name='searchEndDe']").val('searchBgnDe');
            alert("검색 조건의 시작 날이 종료 날보다 큽니다.");
            return false;
        }
		
        
        if($("#aa1").val() !== '' && $("[name='searchWord']").val() === '') {
            alert("선택한 항목의 키워드를 입력해 주세요.");
            return false;
        }
        $("[name='currentPageNo']").val(1);
        if(listType === 'excel') {
            $("[name='bikeStatusName']").val($("#a1 option:selected").text());
            $("[name='searchTypeName']").val($("#aa1 option:selected").text());
        } 
        $("[name='viewFlg']").val(listType);
        
        $("#searchFrm").attr({method : 'post', action : '/getRobLostManageList.do'}).submit();
        
    };
    
    bikeList.pageSelect = function(pageNo) {
        
        $("[name='currentPageNo']").val(pageNo);
        $("[name='viewFlg']").val('list');
        $("#searchFrm").attr({action :'/getRobLostManageList.do', method : 'post'}).submit();
    };
 	
    bikeList.moveEditForm = function(e){
        e.preventDefault();
        e.stopPropagation();
        
        var viewFlg = e.data.viewFlg;
        
        var bikeId = $(this).attr('id');
        var idChk = !bikeId;
        
        var bikeNo = $(this).text();
        var noChk = !bikeNo;
        
        if(!idChk && !noChk) window.open('/moveBikeEditForm.do?viewFlg='+viewFlg+'&bikeNo='+bikeNo+'&bikeId='+bikeId,'_blank');
        
    }
     
    </script>
</body>
</html>