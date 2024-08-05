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
        <tiles:insertAttribute name="header"/>
        <!--모바일 메뉴 E-->
        <!--Head S-->
        <tiles:insertAttribute name="head"/>
        <!--Head E-->
        <div id="body">
            <div class="cont">
                <!--left menu S-->
                <tiles:insertAttribute name="left"/>
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
                                <!-- 대여현황목록 회원정보 연동 링크 start_cms_20161104 -->
                                <input type="hidden" name="usr_seq"	id="usr_seq">
                                <input type="hidden" name="longTermChk"	id="longTermChk">
                                
                                <input type="hidden" name="bikeId"	id="bikeId">
                                <input type="hidden" name="bikeNo"	id="bikeNo">
                                <input type="hidden" name="tabNum"	id="tabNum">
                                <input type="hidden" name="rentSeq"	id="rentSeq">
                                <!-- end -->
                                <fieldset>
                                    <legend>검색 옵션</legend>
                                    <div class="shBoxSection">
                                        <div class="section">
                                            <label for="mbId" class="laType02"  style="ime-mode:disable;" >회원ID</label>
                                            <input type="text"  id="mbId" name="mbId" >
                                        </div>
                                        <div class="section pright">   
                                            <label for="searchWord" class="laType02">대여번호</label>
                                            <input type="text"  id="searchWord" name="searchWord" >
                                        </div>   
                                        <div class="section">
                                            <label for="rentBikeNo" class="laType02">자전거번호</label>
                                            <input type="text"  id="rentBikeNo" name="rentBikeNo" >
                                         </div>   
                                        <div class="section pright">
                                            <label for="usrMpnNo" class="laType02">전화번호</label>
                                            <input type="text"  id="usrMpnNo" name="usrMpnNo" >
                                        </div>
                                        
                                        <div class="section etccase3">
                                            <label for="c22" class="laType03">장기미반납</label>
                                            <span class="input-ck01"><input type="checkbox" class="vm" id="c22"/></span>
                                            <button type="button"  id="searchBtn"  class="btn-srh03 btncase1"><img src="/images/searchIcon.gif" alt="검색" /></button>
                                        </div>
                                    </div>
                                </fieldset>
                        	</div>
                        <!--검색조건 E-->
                        <%-- <form action="act">
                            <fieldset> --%>
                                <div class="lralign mt20">
                                    <p>조회기간 :<label id="searchDateTime"></label></p>
                                    <p>총 ${paginationInfo.getTotalRecordCount()} 건</p>
                                </div>
                                <table class="tb_type01 mt20">
                                    <colgroup>
                                        <col style="width:5%"/>
                                        <col style="width:10%"/>
                                        <col style="width:3%"/>
                                        <col style="width:22%"/>
                                        <col style="width:11%"/>
                                        <col style="width:8%"  class="mhid"/>
                                        <col style="width:12%"/>
                                        <col style="width:15%" class="mhid"/>
                                        <col style="width:5%" class="mhid"/>
                                    </colgroup>
                                    <thead>
                                        <tr>
                                            <th><input type="checkbox" id="chkAll"/></th>
                                            <th>대여구분</th>
                                            <th>S</th>
                                            <th>대여대여소</th>
                                            <th class="mhid">대여시작시간</th>
                                            <th>경과<br/>시간</th>
                                            <th>자전거번호</th>
                                            <th class="mhid">전화번호</th>
                                            <th class="mhid">로그</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="rent" items="${rentList}" varStatus="loop">
                                        <tr>
                                            <td class="tc"><input type="checkbox" /></td>
                                            <td class="pl10">${rent.rentClsCdName}</td>
                                            <td class="pl10">${rent.returnRackId}</td>
                                            <td class="pl10">${rent.rentStationName }</td>
                                            <td class="mhid tc mhid">${rent.rentDttm }</td>
                                            <td class="tr pr10">${rent.elapseTime }</td>
                                            <td class="pl10"><a href="#" target="_blank" name="rentBikeNo" id="${rent.rentSeq}">${rent.rentBikeNo }</a></td>
                                            <!-- 대여현황목록 회원정보 연동 링크 start_cms_20161104 -->
                                            <td class="mhid tr pr10" ><a href="#" target="_blank" id="${rent.usrSeq},${rent.voucherSeq }" name="usrSeq" value="${rent.usrClsCd }">${rent.usrMpnNo }</a></td>
                                        	<td class="pl10"><a href="#" target="_blank" name="log" id="${rent.rentBikeId},${rent.rentBikeNo }">로그</a></td>
                                        	<!-- end -->
                                        </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                                <c:if test="${fn:length(rentList) == 0 }">
                                <table class="tb_type01 nbt0">
                                    <tr><td style="text-align:center"><spring:message code="search.nodata.msg" /></td></tr>
                                </table>
                                </c:if>
						<c:choose>
							<c:when test="${fn:length(rentList) > 0}">
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
                                <div class="btnArea tr">
	                                <button class="btnType01 mb10" id="selectSmsBtn">선택발송</button>
	                                <button class="btnType01 mb10" id="allSmsBtn">전체발송</button>
	                                <!-- 엑셀 다운로드 제거 -->
	                                <!-- <button class="btnType01 mb10 mhid" id="excelBtn">엑셀</button> -->
                                </div>
                            </fieldset>
                        </form>
                    </div>
                </div>
                <!--conteent E-->
            </div>
        </div>
        <!--footer S-->
        <tiles:insertAttribute name="footer"/>
        <!--footer E-->
    </div>
    <script type="text/javascript" src="/js/common_barocle.js"></script>
    <script type="text/javascript">
    $(function() {
    	rentSta.initBtn();
    	rentSta.initCombo();
    	
    	var totalPageCount = '${paginationInfo.totalPageCount}' == '' ? 1 : Number('${paginationInfo.totalPageCount}');
   		$('#prevPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			rentSta.pageSelect(currentPageNo-1);
		});
		$('#nextPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			rentSta.pageSelect(currentPageNo+1);
		});
		$('#movePage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			var regExp = /^[1-9]?[0-9]/;
			if(!regExp.test(currentPageNo) ||(totalPageCount < currentPageNo)){
				alert('현재 페이지 값이 정상적이지 않습니다.');
			}else{
				rentSta.pageSelect(currentPageNo);
			}
		});
    });
    var rentSta = {};
    var $this = rentSta;
    rentSta.searchWord = '${searchCondition.searchWord}';
    rentSta.mbId = '${searchCondition.mbId}';
    rentSta.rentBikeNo = '${searchCondition.rentBikeNo}';
    rentSta.usrMpnNo = '${searchCondition.usrMpnNo}';
    rentSta.longTermChk = '${searchCondition.longTermChk}';
    rentSta.searchDateTime = '${searchCondition.currentSearchTime}' ===''? DateUtil.dateFmt(new Date())+" "+DateUtil.getCurrentTime() :'${searchCondition.currentSearchTime}';
    
    
    rentSta.initCombo = function() {
    };
    rentSta.initBtn = function() {
        
        $("#searchBtn").on('click',{viewType : 'list'},this.exeListPage);
        $("#excelBtn").on('click' ,{viewType : 'excel'},this.exeListPage);
        $("#bb22").on('change', function(e){
            var tId = e.target.id;
            var idx = $("#"+tId+" option:selected").index();
            var subList =$("#"+tId).data().sub_data;
            $("#aa21 option").not(':eq(0)').remove();
            var sltsubData = subList[(idx-1)];
            if(sltsubData !== undefined) {
                if(sltsubData.length > 0) {
                    commCdBox.makeComboBox("S", $this.rentStationId, sltsubData, "aa21");
                }
            }
        });
        $(".tb_type01 > tbody > tr").on("click", "a", this.moveRentStatusDetail);
        $(".tb_type01 > thead > tr").on("click", "a", function(e){
        	e.preventDefault();
        	e.stopPropagation();
        });
        $("#chkAll").on("click", function(e){
        	if( $("#chkAll").prop("checked")) {
        		$(".tb_type01 > tbody > tr").find('input:checkbox').prop("checked", true);
        	} else {
        		$(".tb_type01 > tbody > tr").find('input:checkbox').prop("checked", false);
        	}
        });
        $("#selectSmsBtn").on("click", {smsType : ''}, this.showSmsPopup);
        $("#allSmsBtn").on("click", {smsType : 'ALL'}, this.showSmsPopup);
       

    	$("[name='searchWord']").val($this.searchWord);
    	$("[name='mbId']").val($this.mbId);
    	$("[name='rentBikeNo']").val($this.rentBikeNo);
    	$("[name='usrMpnNo']").val($this.usrMpnNo);
    	 if($this.longTermChk === 'Y') {
         	$("#c22").prop('checked', true);
         }
         $("#c22").on("change", function(){
             if($(this).prop("checked")) {
                 $("[name='longTermChk']").val('Y');
             } else {
                 $("[name='longTermChk']").val('');
             }
         });
         
        
       
        $("#searchDateTime").text($this.searchDateTime);
    };
    
    rentSta.moveRentStatusDetail = function(e) {
    	e.preventDefault();
    	if($(this).attr('name') == "usrSeq"){
    		var pData = e.target.id.split(",");
    		var usrClsCd = $(this).attr('value');
    		if(usrClsCd == "USR_003"){
    			$("#frm").empty()
                 .append($('<input>', {type : 'hidden',name : 'serialNoUsrSeq'}).val(pData[0]))
                 .append($('<input>', {type : 'hidden',name : 'serialNoVoucherSeq'}).val(pData[1]))
                     .attr({action:'/admin/service/member/rentSerialNumDetail.do', method : 'post', target :"_blank"}).submit();
    			//return false;
    		} else {
        		$("#usr_seq").val(pData[0]);
        	    $("#searchFrm").attr({action: '/admin/service/member/memberInfo.do', method :"post", target :"_blank" }).submit();    			
    		}
    	} else	if($(this).attr('name') == "log"){	
    		
			var pData = e.target.id.split(",");
    		
    		// 자전거 정보 조회 호출
    		$("[name='bikeId']").val(pData[0]);
    		$("[name='bikeNo']").val(pData[1]);
    		$("[name='viewFlg']").val("U");
    		$("[name='tabNum']").val("4");
    		$("[name='currentPageNo']").val(1); 
    	 	
    	    $("#searchFrm").attr({action: '/moveBikeEditForm.do', method :"post",   target :"_blank"  }).submit();
    	    
    		
    	}else{
			
    		// 강반건 호출
    		$("[name='rentSeq']").val(e.target.id);
    	    $("#searchFrm").attr({action: '/moveRentStatusInfo.do', method :"post",  target :"_blank"}).submit();
    	    
    	}
    };
    rentSta.pageSelect = function(pageNo) {	
        $this.getRentStatus('list', pageNo);
    };
    rentSta.exeListPage = function(e) {
    	e.preventDefault();
    	$this.getRentStatus(e.data.viewType, 1);
    };
    rentSta.showSmsPopup = function(e) {
    	e.preventDefault();
    	e.stopPropagation();
    	
    	if( $('body').find(".winNewPop") !== undefined && $('body').find(".winNewPop").length >0 ) {
    		$('body').find(".winNewPop").remove();
    	}
    	var mpnNoList = [];
    	if(e.data.smsType ==='ALL') {
    		if(Number('${fn:length(rentList)}') === 0) {
    			alert("발송할 데이터가 없습니다.");
    			return false;
    		}
    		 var $a = $("<a>", {'href' : '/getSmsAllUsrMpnNo.do', 'title' : 'sms', 'data-width' :"450" ,'data-height' :"550", 'data-pmt' : $("#searchFrm").serialize()}).addClass("winNewPop modal");
             $('body').first().append($a);
             $(".winNewPop").trigger("click");
    	  
    	} else {
    		
    		$(".tb_type01 > tbody > tr").each(function(idx) {
    			if($(this).find("input[type='checkbox']").is(':checked')) {
    				if( $(this).children().eq(7).text().length > 8 ) {
    					mpnNoList.push($(this).children().eq(7).text());
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
    	
    	
    };
    rentSta.getRentStatus = function(pVtype, pPage) {
    	
    	$("[name='currentPageNo']").val(pPage);
        $("[name='viewFlg']").val(pVtype);
        
        $("#searchWord").val($("#searchWord").val().replace(/ /g, ''));		// 공백제거
        
        if(pVtype === "list") {
        	$this.searchDateTime =  DateUtil.dateFmt(new Date())+" "+DateUtil.getCurrentTime();
        	if($("#c22").prop('checked') === true) {
        	    $("[name='longTermChk']").val('Y');
        	}
        	$("[name='currentSearchTime']").val($this.searchDateTime);
        }
        $("#searchFrm").attr({action: '/getRentStatusList.do', method :"post"}).submit();
    	
    };
    </script>
</body>
</html>