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
                        <p class="pageTitle">무선 AP</p>
                        <span>운영관리 &gt; 장치관리 &gt; <em>무선 AP</em></span>
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
                            <form id="frm"></form>
                            <form id="searchFrm" name="searchFrm">
			                    <input type="hidden" name="viewFlg" value="" />
			                    <input type="hidden" name="deviceId" value="" />
			                    <input type="hidden" name="deviceStatusName" value="" />
			                    <input type="hidden" name="stationGrpName" value="" />
			                    <input type="hidden" name="stationName" value="" />
			                    <input type="hidden" name="chkType" value="" />
                                <fieldset>
                                    <legend>검색 옵션</legend>
                                    <div class="shBoxSection">
                                        <div class="section">
                                            <label for="bb22" class="laType02">등록일</label>
                                            <span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" id="bb22"  name="searchBgnDe"readonly/></span>
                                            <span class="dash">~</span>
                                            <span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" title="선택 날짜" name="searchEndDe" readonly/></span>
                                        </div>
                                        <div class="section pright">
                                            <label for="a1" class="laType02">상태</label>
                                            <select id="a1" name="deviceStatusCd">
                                               <option value="">선택</option>
                                            </select>
                                        </div>
                                        <div class="section">
                                            <label for="aa1" class="laType02">아파트</label>
                                            <select class="select-category04" id="aa1"  name="stationGrpSeq">
                                                <option value="">선택</option>
                                            </select>
                                        </div>
                                        <div class="section pright">
                                            <label for="aa21" class="laType02">대여소명</label>
                                            <select class="select-category02" id="aa21" name="stationId">
                                                <option value="">선택</option>
                                            </select>
                                        </div>
                                        <div class="section etccase3">
                                            <label for="a1" class="laType02">정기점검</label>
                                            <select id="a1" name="rglChkSearch">
                                               <option value="">선택</option>
                                               <option value="20">20일전</option>
                                               <option value="10">10일전</option>
                                               <option value="5">5일전</option>
                                               <option value="3">3일전</option>
                                            </select>
                                            <button class="btn-srh03 btncase1" type="button" id="searchBtn"><img src="/images/searchIcon.gif" alt="검색"></button>
                                        </div>
                                    </div>
                                </fieldset>
                       		</div>
                        <!--검색조건 E-->
                        <p class="tb_numlist">총 ${paginationInfo.getTotalRecordCount() } 건</p>
                        <table class="tb_type01">
                            <caption>무선 AP</caption>
                                <colgroup>
                                    <col style="width:8%"/>
	                                <col style="width:15%"/>
	                                <col style="width:auto"/>
	                                <col style="width:15%"/>
	                                <col style="width:15%"/>
	                                <col style="width:15%"  class="mhid"/>
                                </colgroup>
                            <thead>
                                <tr>
                                    <th><input type="checkbox" id="allChk"></th>
                                    <th>무선AP</th>
                                    <th>대여소/센터</th>
                                    <th>상태</th>
                                    <th>납품처</th>
                                    <th  class="mhid">등록일</th>
                                </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="result" items="${APList}" varStatus="status">
                                <tr>
                                    <td class="tc"><input type="checkbox" name="chk"></td>
                                    <td class="pl10"><a href="#" id="ap_${status.index}">${result.deviceId}</a></td>
                                    <td class="pl10">${result.stationName}</td>
                                    <td class="pl10">${result.deviceStatusName}</td>
                                    <td class="pl10">${result.entrpsCdNm}</td>
                                    <td class="tc mhid">${result.regDttm}</td>
                                </tr>
                            </c:forEach>    
                            </tbody>
                        </table>
                        <c:if test='${fn:length(APList) == 0}'>
                        <table class="tb_type01 nbt0">
                            <tr><td style="text-align:center"><spring:message code="search.nodata.msg" /></td></tr>
                        </table>
                        </c:if>
					<c:choose>
						<c:when test="${fn:length(APList) > 0}">
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
                            <button class="btnType01 mb10" id="ragularChkBtn"  title="정기점검 일괄 등록">정기점검 일괄 등록</button>
                            <button class="btnType01  mb10 mhid" id="excelViewBtn" title="엑셀다운로드">엑셀다운로드</button>
                            <a href="<c:out value='/common/pop/DEV_003/openUploadPop.do'/>" id="bulkUploadBtn" class="winNewPop btnType01 mb10 mhid" title="엑셀업로드" data-width="450" data-height="355" data-pmt="">엑셀업로드</a>
                            <button class="btnType01 bc_green mb10" id="moveEditFormBtn" title="등록">등록</button>
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
	        ap.commonCode();
	        ap.initBtn();
	        //var today = DateUtil.dateFmt(new Date());
	        var sDate = '${searchCondition.searchBgnDe}' !== '' ? '${searchCondition.searchBgnDe}' : "";
	        var eDate = '${searchCondition.searchEndDe}' !== '' ? '${searchCondition.searchEndDe}' : "";
	     
	        $( "[name='searchBgnDe']").val(sDate);
	        $( "[name='searchEndDe']").val(eDate);
	        
	        var totalPageCount = '${paginationInfo.totalPageCount}' == '' ? 1 : Number('${paginationInfo.totalPageCount}');
	   		$('#prevPage').on("click",function(){
				var currentPageNo = Number($('[name="currentPageNo"]').val());
				ap.pageSelect(currentPageNo-1);
			});
			$('#nextPage').on("click",function(){
				var currentPageNo = Number($('[name="currentPageNo"]').val());
				ap.pageSelect(currentPageNo+1);
			});
			$('#movePage').on("click",function(){
				var currentPageNo = Number($('[name="currentPageNo"]').val());
				var regExp = /^[1-9]?[0-9]/;
				if(!regExp.test(currentPageNo) ||(totalPageCount < currentPageNo)){
					alert('현재 페이지 값이 정상적이지 않습니다.');
				}else{
					ap.pageSelect(currentPageNo);
				}
			});
	    });
	    
	    var ap = {};
	    ap.deviceStatusCd = "${searchCondition.deviceStatusCd}";
	    ap.stationGrpSeq  = "${searchCondition.stationGrpSeq}";
	    ap.stationId      = "${searchCondition.stationId}";
	    ap.commonCode = function () {
	    	var _this = ap;
	        //상태코드
	        commonAjax.getCommonCode("APS", function(data) {
	        	 if(data !== null && data.codeList !== null) {
	                 commCdBox.makeComboBox('CC',_this.deviceStatusCd,data.codeList, "a1");
	             }
	        });
	        //스테이션 
	        commonAjax.getStationCode( 
	                function(data) {
	                    if(data != null && data.stationList != null) {
	                        commCdBox.makeComboBox('S',_this.stationGrpSeq,data.stationList, "aa1");
	                        $("#aa1").trigger('change');
	                    }
	                }
	        );
	        $("[name='rglChkSearch']").val("${searchCondition.rglChkSearch}");
	        
	    };
	  
	    ap.initBtn = function () {
	    	var _this = ap;
	        $("#ragularChkBtn").on("click", this.exeRegularChk);
	        $("#searchBtn").on("click", this.searchDataFnc);
	        $("#excelViewBtn").on("click", this.excelDataFnc);
	        $("#moveEditFormBtn").on("click",{ viewFlg : 'C'},this.moveDetailPage );
	        $(".tb_type01 > tbody > tr").on('click', 'a',{ viewFlg : 'U'}, this.moveDetailPage);
	        
	        $("#allChk").on("click", function(e){
	        	if(this.checked) {
	                $("[name='chk']").prop('checked', true);
	            } else {
	                $("[name='chk']").prop('checked', false);
	            }
	        });
	        
	        $("#aa1").on('change', function(e){
	        	var tId = e.target.id;
	        	var idx = $("#"+tId+" option:selected").index();
	        	var subList =$("#"+tId).data().sub_data;
	        	$("#aa21 option").not(':eq(0)').remove();
	        	var sltsubData = subList[(idx-1)];
	        	if(sltsubData !== undefined) {
		        	if(sltsubData.length > 0) {
			        	commCdBox.makeComboBox("S",_this.stationId,sltsubData, "aa21");
		        	}
	        	}
	        });
	        
	    };
	    
	    ap.exeRegularChk = function(e) {
	        e.preventDefault();
	        var pData = null;
	        var allStr= "";
	     
	            $("#frm").empty();
	            var i =0;
	            $(".tb_type01 > tbody > tr").each(function(idx) {
	                var $input1 = null;
	                
	                if($(this).find("input:checkbox").prop("checked")) {
	                     $input1 = $("<input>", {type : "hidden", name: "apList["+i+"].deviceId"}).val($(this).find("a").text()); 
	                     $("#frm").append($input1);
	                     i++;
	                }
	                
	            });
	            if(i===0) {
	            	alert("일괄 등록할 AP를 선택해 주세요.");
	            	return false;
	            }
	             $("#frm").append($("[name='chkType']").val(""));
	            pData = $("#frm").serialize();
	        
	        var anw = confirm("선택하신 "+allStr+" AP의 정기 점검 일자를  오늘 날짜로 일괄등록 하시겠습니까?");
	        
	        if(anw) {
	            commonAjax.postAjax("/ap/regularChkReg.do", "json", pData
	                ,function(data){
	                      if(data) {
	                          if(data.checkResult > 0){
	                              alert("등록이 완료 되었습니다.");
	                              if($("#allChk").prop("checked")) {
	                                  $("#chkAll").trigger("click");
	                               } else {
	                                   $("[name='chk']").prop('checked', false);
	                               }
	                               return false;
	                          }
	                     }
	            });
	        }
	    };
	   
	    ap.searchDataFnc = function(e) {
	    	e.preventDefault();
	    	e.stopPropagation();
	    	
	    	if(DateUtil.checkDateTerm( $( "[name='searchBgnDe']").val(),  $( "[name='searchEndDe']").val()) !== 'ok') {
	    		$( "[name='searchBgnDe']").val('');
	    		$( "[name='searchEndDe']").val('');
                alert("검색 조건의 시작 날이 종료 날보다 큽니다.");
                return false;
            }
	    	
	        $("input:hidden[name='viewFlg']").val('list');
	        $("[name='currentPageNo']").val(1);
	        $("#searchFrm").attr({method : "post", action : "<c:out value='/getApList.do'/>"}).submit();
	    };
	    ap.excelDataFnc = function(e) {
	        $("input:hidden[name='viewFlg']").val('excel');
	        $("input:hidden[name='deviceStatusName']").val($("#a1 option:selected").text());
	        $("input:hidden[name='stationGrpName']").val($("#aa1 option:selected").text());
	        $("input:hidden[name='stationName']").val($("#aa21 option:selected").text());
	        $("#searchFrm").attr({method : "post", action : "<c:out value='/getApList.do'/>"}).submit();
	    };
	    ap.moveEditForm = function(e) {
	        e.preventDefault();
	        var tId = e.target.id;
	        $("input:hidden[name='viewFlg']").val('U');
	        $("input:hidden[name='deviceId']").val($("#"+tId).text());
	        $("#searchFrm").attr({method : "post", action : "<c:out value='/moveAPEditForm.do'/>"}).submit();
	    };
	    ap.pageSelect = function(cPage) {
	        $("input:hidden[name='viewFlg']").val('list');
	        $("[name='currentPageNo']").val(cPage);
	        $("#searchFrm").attr({method : "post", action : "<c:out value='/getApList.do'/>"}).submit();
	    };
	    ap.moveDetailPage  = function(e) {
            $("input:hidden[name='deviceId']").val(this.text);
            $("input:hidden[name='viewFlg']").val(e.data.viewFlg);
            $("#searchFrm").attr({method : "post", action : "<c:out value='/moveAPEditForm.do'/>"}).submit();
        };
	    </script>
</body>
</html>