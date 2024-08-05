<%@page import="com.dkitec.barocle.base.IConstants"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html>
<%@ page import="java.util.*"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.text.SimpleDateFormat"%>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" /> 
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />
<meta name="description=" Content="" />
<title><tiles:insertAttribute name="title"/></title>
<tiles:insertAttribute name="resource"/>
<style type="text/css">
	.trTop{border: 2px solid #888888; border-Bottom: none;}
	.trBottom{border: 2px solid #888888; border-top: none;}
	.bgcolor{background-color: #fcfcfc;}
	.bgcolor2{background-color: #eeeeee;}
</style>
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
                                    <p>검색조건  </p><span><button><img src="/images/srh_open.png" alt="검색조건 열기" /></button></span>
                                </div>
                            </div>
                        </div>
                         
                        <!-- 모바일 검색조건 E-->
                        <!--검색조건 S-->
                        <form id="frm"></form>
                        <form id="searchFrm">
                        	<div class="shBox" style="position:relative;">
                                <input type="hidden" name="viewFlg" value="" />
                                <input type="hidden" name="enfrcReturnHistSeq" value="" />
                                <input type="hidden" name="currentSearchTime" value="${searchCondition.currentSearchTime}" />
                                <input type="hidden" name="sortType" value="" />
                                <input type="hidden" name="comptCd" value="" />
                                <input type="hidden" name="procCd" value="" />
                                <input type="hidden" name="parkingLocationReason" value="" />
                                <!-- 대여현황목록 회원정보 연동 링크 start_cms_20161104 -->
                                <input type="hidden" name="usr_seq"	id="usr_seq">
                                <input type="hidden" name="bikeMYID" id="bikeMYID" value="${usrId}">
                              
                                
                                <!-- end -->
                                <fieldset>
                                    <legend>검색 옵션</legend>
                                    <div class="shBoxSection">
										<div class="section">
											<label for="bb22" class="laType02">반납일</label>
											<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" name="searchStartDate" title="선택 날짜" id="bb22" readonly/></span>
											<span class="dash">~</span>
											<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" name="searchEndDate" title="선택 날짜" readonly/></span>
										</div>
										<div class="section pright">
											<label for="aa1" class="laType02">자전거번호 및 주소</label>
											
											<span class="input-text07">
											<c:if test='${searchCondition.bikeNoYn == "N"}'>
											 	<input type="text"  id="searchWord" name="searchWord" value="${searchCondition.centerId}" class="" style="width:100px;" readonly="readonly"/>
											</c:if>
											<c:if test='${searchCondition.bikeNoYn != "N"}'>
											 	<input type="text"  id="searchWord" name="searchWord" value="${searchCondition.centerId}" class="" style="width:100px;"/>
											</c:if>
											</span>
											
											 <label for="aa1" class="laType02" style="width:40px; margin-right: 0px; font-size:10px;">번호없음</label>
											 <span class="input-text07">
											 <c:if test='${searchCondition.bikeNoYn == "N"}'>
											 	<input type="checkbox" name="bikeNoYn" id="bikeNoYn" value="N" style="width:14px; vertical-align: middle;" checked="checked">
											 </c:if>
											  <c:if test='${searchCondition.bikeNoYn != "N"}'>
											 	<input type="checkbox" name="bikeNoYn" id="bikeNoYn" value="N" style="width:14px; vertical-align: middle;">
											 </c:if>
											 </span>
											 
											 <label for="aa_my" class="laType02" style="margin-left:10px; width:40px; margin-right: -10px; font-size:10px;">MYID</label>
											 <span class="input-text07">
											 <c:if test='${searchCondition.bikeMYIDYn == "N"}'>
											 	<input type="checkbox" name="bikeMYIDYn" id="bikeMYIDYn" value="N" style="width:14px; vertical-align: middle;" checked="checked">
											 </c:if>
											  <c:if test='${searchCondition.bikeMYIDYn != "N"}'>
											 	<input type="checkbox" name="bikeMYIDYn" id="bikeMYIDYn" value="N" style="width:14px; vertical-align: middle;">
											 </c:if>
											 </span>
											 
											
										</div>
                                        <div class="section ">    
                                            <label for="center" class="laType02">센터</label>
											<select class="select-category02" name="centerId" id="centerId">
                                                <option value="">선택</option>
                                                <c:forEach var="result" items="${codeList}" varStatus="status">
													<c:if test="${searchCondition.centerId == result.comCd}">
													<option value="${result.comCd}" selected="selected"><c:out value="${result.comCdName}"/></option>
													</c:if>
													<c:if test="${searchCondition.centerId != result.comCd}">
													<option value="${result.comCd}" ><c:out value="${result.comCdName}"/></option>
													</c:if>
												</c:forEach>
                                            </select>
                                           </div>
                                            <div class="section pright"> 
                                            <label for="team" class="laType02">팀</label>
											<select class="select-category02" id="teamId"	name="teamId">
												<option value="">선택</option>
												<c:forEach var="result" items="${teamList}" varStatus="status">
													<c:if test="${searchCondition.teamId == result.comCd}">
													<option value="${result.comCd}" selected="selected"><c:out value="${result.comCdName}"/></option>
													</c:if>
													<c:if test="${searchCondition.teamId != result.comCd}"> 
													<option value="${result.comCd}" ><c:out value="${result.comCdName}"/></option>
													</c:if>
												</c:forEach>
											</select>
											
											</div>
											<div class="section">
											<label for="lockState" class="laType02">미반납 사유</label>
											<select class="select-category02" name="enfrcReturnCd" id="enfrcReturnCd">
                                               <option value="">선택</option>
                                                <c:forEach var="result" items="${nrrList}" varStatus="status">
													<c:if test="${searchCondition.enfrcReturnCd == result.comCd}">
													<option value="${result.comCd}" selected="selected"><c:out value="${result.comCdName}"/></option>
													</c:if>
													<c:if test="${searchCondition.enfrcReturnCd != result.comCd}">
													<option value="${result.comCd}" ><c:out value="${result.comCdName}"/></option>
													</c:if>
												</c:forEach>
                                            </select>
                                       	 </div>
                                       	 <div class="section pright"> 
                                       	 <label for="procCdLb" class="laType02">처리유형</label>
	                                       	 <select class="select-category02" name="procCdS" id="procCdS">
	                                               <option value="">선택</option>
	                                               <option value="1" <c:if test="${searchCondition.procCd eq '1'}">selected="selected"</c:if>>재배치</option>
	                                               <option value="2" <c:if test="${searchCondition.procCd eq '2'}">selected="selected"</c:if>>회수후 재배치</option>
	                                               <option value="3" <c:if test="${searchCondition.procCd eq '3'}">selected="selected"</c:if>>센터입고</option>
	                                               <option value="4" <c:if test="${searchCondition.procCd eq '4'}">selected="selected"</c:if>>정상 대기중</option>
	                                               <option value="6" <c:if test="${searchCondition.procCd eq '6'}">selected="selected"</c:if>>대여중</option>
	                                               <option value="5" <c:if test="${searchCondition.procCd eq '5'}">selected="selected"</c:if>>자전거 없음</option>
	                                               <option value="7" <c:if test="${searchCondition.procCd eq '7'}">selected="selected"</c:if>>자동조치</option>
	                                               <option value="8" <c:if test="${searchCondition.procCd eq '8'}">selected="selected"</c:if>>배정팀 변경요청</option>
	                                			   <option value="9" <c:if test="${searchCondition.procCd eq '9'}">selected="selected"</c:if>>자전거 강제복구</option>
	                                				
													
	                                        </select>
                                       	 </div>
                                       	 <div class="section">
											<label for="procCdLb" class="laType02">방치신고<br>사유</label>
                                       	 	<select class="select-category02" name="parkingLocationReasonCd" id="parkingLocationReasonCd">
                                               <option value="">선택</option>
	                                           <option value="1" <c:if test="${searchCondition.parkingLocationReason eq '1'}">selected="selected"</c:if>>시민신고</option>
	                                           <option value="2" <c:if test="${searchCondition.parkingLocationReason eq '2'}">selected="selected"</c:if>>배송팀 발견</option>
	                                           <option value="3" <c:if test="${searchCondition.parkingLocationReason eq '3'}">selected="selected"</c:if>>기타</option>
	                                           <option value="4" <c:if test="${searchCondition.parkingLocationReason eq '4'}">selected="selected"</c:if>>앱신고</option>
                                            </select>
											
											
                                       	 </div>
                                       	 <div class="section pright">
                                       	 	<label for="comptCdLb" class="laType02">처리완료<br>여부</label>
											<select class="select-category02" name="comptCdS" id="comptCdS">
                                               <option value="">선택</option>
	                                           <option value="1" <c:if test="${searchCondition.comptCd ne '0' && searchCondition.comptCd ne null && searchCondition.comptCd ne ''}">selected="selected"</c:if>>처리</option>
	                                           <option value="0" <c:if test="${searchCondition.comptCd eq '0'}">selected="selected"</c:if>>미처리</option>
                                            </select>
                                       	 <button id="searchBtn" class="btn-srh03 btncase1"><img src="/images/searchIcon.gif" alt="검색"></button>
                                       	 </div>
									</div>
                                </fieldset>
                        	</div>
                        
                        <!--검색조건 E-->
                            <fieldset>
                                <div class="lralign mt20">
                                    <p>&nbsp;</p>
                                    <p>총 ${paginationInfo.getTotalRecordCount()} 건</p>
                                </div>
                                <table class="tb_type01 mt20">
                                    <colgroup>
										<col style="width:8%;">
										<col style="width:8%;">
										<col style="width:8%;">
										<col style="width:8%;">
										<col style="width:8%;">
										<col style="width:8%;">
										<col style="width:8%;">
										<col style="width:10%;">
										<col style="width:8%;">
										<col style="width:6%;">
										<col style="width:8%;">
										<col style="width:12%;">
										<col style="display:none"/>
									</colgroup>
									<tbody id="innerResult23423">
									<c:forEach items="${resultList}" var="list">
									<tr class="trTop">
										<td class="tc bgcolor">No</td>
										
										<c:if test="${not empty list.rentBikeNo}">
											<td class="tc" colspan="2"><a href="#" id="${ list.enfrcReturnHistSeq}">${fn:substringAfter(list.rentBikeNo,'-')}</a></td>
										</c:if>
										<c:if test="${empty list.rentBikeNo}">
											<td class="tc" colspan="2"><a href="#" id="${ list.enfrcReturnHistSeq}">번호없음</a></td>
										</c:if>
										<td class="tc bgcolor">장소</td>
										<td class="tl" colspan="6">
											<c:if test="${list.parkingLocationReason eq '4'}">
											<span style="color: blue;">[앱신고]</span>
											</c:if>
											<c:choose>
												<c:when test="${list.stationName ne null}">
													<c:if test="${list.emrgncyYn == 'Y'}">
														<span style="color: red;">[긴급] </span>
													</c:if>
													${list.stationName }
												</c:when>
												<c:otherwise>
													<c:if test="${list.emrgncyYn == 'Y'}">
														<span style="color: red;">[긴급] </span>
													</c:if>
														${list.addr }
													<c:if test="${list.parkingLocation ne null && list.parkingLocation ne ''}">
														 (${list.parkingLocation })
													</c:if>
												</c:otherwise>
											</c:choose>
										</td>
										<c:set var="today" value="<%=new java.util.Date()%>"/>
										<fmt:formatDate var="strNow" type="date" value="${today}" pattern="yyyy-MM-dd"/>	
											
										<!-- <td class="tc bgcolor">일시</td> --> 
										<fmt:parseDate value="${list.regDttm}" var="regDttm" pattern="yyyy-MM-dd HH:mm:ss"/> 	
										<td class="tc" colspan="2"><fmt:formatDate value="${regDttm}" pattern="MM-dd"/>&nbsp;<fmt:formatDate value="${regDttm}" pattern="HH:mm"/>
										
										<fmt:parseDate value="${strNow}" var="strPlanDate" pattern="yyyy-MM-dd"/>
										<fmt:parseNumber value="${strPlanDate.time / (1000*60*60*24)}" integerOnly="true" var="strDate"></fmt:parseNumber>
										<fmt:parseDate value="${list.regDttm}" var="endPlanDate" pattern="yyyy-MM-dd"/>
										<fmt:parseNumber value="${endPlanDate.time / (1000*60*60*24)}" integerOnly="true" var="endDate"></fmt:parseNumber>
										<c:if test="${ ((endDate - strDate)  < 0) && (list.comptCd == '0' || list.comptCd == '')}">
										<b> [${endDate - strDate }일]</b>
										</c:if>
										</td>
										
									</tr>
									
									<tr class="trBottom">
										
										<td class="tc bgcolor">상태</td>
										 <td class="tc" colspan="6">
										 <c:if test="${list.rentBikeStat eq '정상(대기중)'}">정상 대기중</c:if>				 	
										 <c:if test="${list.rentBikeStat ne '정상(대기중)'}">${list.rentBikeStat}</c:if>
										 <%-- ${list.rentBikeStat} 코드수정시 c:if 삭제후 적용--%>	
										 
										 
										  <%-- (사유:${list.deviceReturnCdNm}<c:if test="${list.parkingLocationDesc ne null}">[${list.parkingLocationDesc}]</c:if>) --%>
										  
										  
										  		<c:choose>
										  			<c:when test="${list.enfrcGubunCd == '0'}">
										  				( 사유:
										  				${list.deviceReturnCdNm}
										  				<c:if test="${list.enfrcReturnDesc ne null && list.enfrcReturnDesc ne ''}"> - ${list.enfrcReturnDesc}</c:if>
										  				 )
										  			</c:when>
										  			<c:when test="${list.enfrcGubunCd == '1'}">
										  				( 사유:
										  				<c:choose>
										  					<c:when test="${list.parkingLocationReason == '1'}">시민신고</c:when>
										  					<c:when test="${list.parkingLocationReason == '2'}">배송팀발견</c:when>
										  					<c:when test="${list.parkingLocationReason == '3'}">기타
										  					</c:when>
										  				</c:choose>
										  				<c:if test="${list.parkingLocationDesc ne null && list.parkingLocationDesc ne ''}"> - ${list.parkingLocationDesc}</c:if>
										  				 )
										  			</c:when>
										  		</c:choose>
										 	
										 </td>
										
										<c:if test="${list.photoYn == 'Y'}">
										 <td class="tc">
										 	<a href="#" id="${ list.enfrcReturnHistSeq}" name="photo" style="font-weight: bolder;"><%-- <img src="/images/pictureIcon.png" id="${ list.enfrcReturnHistSeq}" alt="사진보기" /> --%>[사진]</a> 
										 </td>
										</c:if>
										<c:if test="${list.photoYn == 'N'}">
										  <td class="tc"><a href="#" id="${ list.enfrcReturnHistSeq}" name="photo" style="font-weight: bolder; color: #6478FF;">[지도]</a></td>
										</c:if>
										
										<td class="tc bgcolor2" colspan="3">
											<c:if test="${list.comptCd != '0' && list.comptCd != ''}">
											<c:choose>
												<c:when test="${list.comptCd == '1'}">재배치</c:when>
												<c:when test="${list.comptCd == '2'}">회수후 재배치</c:when>
												<c:when test="${list.comptCd == '3'}">센터입고</c:when>
												<c:when test="${list.comptCd == '4'}">정상 대기중</c:when>
												<c:when test="${list.comptCd == '5'}">자전거 없음</c:when>
												<c:when test="${list.comptCd == '6'}">대여중</c:when>
												<c:when test="${list.comptCd == '7'}">자동조치</c:when>
												<c:when test="${list.comptCd == '8'}">배정팀 변경요청</c:when>
												<c:when test="${list.comptCd == '9'}">자전거 강제복구</c:when>
												
												<c:otherwise>기타</c:otherwise>
											</c:choose>
		                                    </c:if>
		                                    <c:if test="${list.comptCd == '0' || list.comptCd == ''}">
													<select name="procCdL" id="procCdL">
		                                               <option value="">처리결과</option>
		                                               <option value="1">재배치</option>
		                                               <option value="2">회수후 재배치</option>
		                                               <option value="3">센터입고</option>
		                                               <option value="4">정상 대기중</option>
		                                               <option value="6">대여중</option>
		                                               <option value="5">자전거 없음</option>
		                                               <option value="7">자동조치</option>
		                                               <option value="8">배정팀 변경요청</option>
		                                               
		                                               <c:choose>
		                                               		<c:when test="${usrGrpCd eq '15' }">
																<option value="9">자전거 강제복구</option>															
															</c:when>				
															<c:when test="${usrGrpCd eq '14' }">
																<option value="9">자전거 강제복구</option>															
															</c:when>		
															<c:when test="${usrGrpCd eq '12' }">
																<option value="9">자전거 강제복구</option>															
															</c:when>		
															<c:when test="${usrGrpCd eq '7' }">
																<option value="9">자전거 강제복구</option>															
															</c:when>		
	                                               		</c:choose>
		                                               
		                                        </select>
											</c:if>  
										</td>									
										<td class="tc bgcolor2">
											<c:if test="${list.comptCd != '0'  && list.comptCd != ''}">
												완료<button class="btnType05">취소</button>
											</c:if>
											<c:if test="${list.comptCd == '0' || list.comptCd == ''}">
												
												<button class="btnType02">등록</button>
											</c:if>
										</td>
										<td style="display:none" id="enfrcReturnHistSeq">${list.enfrcReturnHistSeq}</td>   

										<!-- 20200115 -->
										<td style="display:none" id="rentBikeId">${list.rentBikeId}</td>   
										<td style="display:none" id="rentBikeNo">${list.rentBikeNo}</td>   
									    <!-- 20200115 END -->
									    
									</tr>
									</c:forEach>
                                </table>
                                <c:if test="${fn:length(resultList) == 0 }">
                                <table class="tb_type01 nbt0">
                                    <tr><td style="text-align:center"><spring:message code="search.nodata.msg" /></td></tr>
                                </table>
                                </c:if>
						<c:choose>
							<c:when test="${fn:length(resultList) > 0}">
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
                                <!-- <div class="btnArea tr">
	                                <button class="btnType01 mb10" id="selectSmsBtn">선택발송</button>
	                                <button class="btnType01 mb10" id="allSmsBtn">전체발송</button>
	                                <button class="btnType01 mb10 mhid" id="excelBtn">엑셀</button>
                                </div> -->
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
        //initialize
        exeImpulse.initBtn();
        
        var sDate = '${searchCondition.searchStartDate}' != '' ? '${searchCondition.searchStartDate}' : '';
		var eDate = '${searchCondition.searchEndDate}' != '' ? '${searchCondition.searchEndDate}' : '';
		
		$("[name='searchStartDate']").val(sDate);
		$("[name='searchEndDate']").val(eDate);
		$("[name='searchWord']").val('${searchCondition.searchWord}');
       // alert('${searchCondition.centerId}');
        var totalPageCount = '${paginationInfo.totalPageCount}' == '' ? 1 : Number('${paginationInfo.totalPageCount}');
   		$('#prevPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			exeImpulse.pageSelect(currentPageNo-1);
		});
		$('#nextPage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			exeImpulse.pageSelect(currentPageNo+1);
		});
		$('#movePage').on("click",function(){
			var currentPageNo = Number($('[name="currentPageNo"]').val());
			var regExp = /^[1-9]?[0-9]/;
			if(!regExp.test(currentPageNo) ||(totalPageCount < currentPageNo)){
				alert('현재 페이지 값이 정상적이지 않습니다.');
			}else{
				exeImpulse.pageSelect(currentPageNo);
			}
		});
		
		$("#bikeNoYn").change(function() {
   			var checked = $(this).prop('checked');
   			if(checked){
   				$("#searchWord").val("").attr("readonly",true);
   			} else {
   				$("#searchWord").removeAttr("readonly");
   			}
    	});
    });
    
    
    var exeImpulse = {};
    
    exeImpulse.initBtn = function () {
    	var _this = exeImpulse;
        $("#searchBtn").on("click", this.searchDataFnc);
        $(".btnType02").on("click", this.procDataFnc);
        //$(".tb_type01").on("click","a", this.moveexeImpulseDetail);
        $(".tb_type01 > tbody > tr").on("click", "a", this.moveexeImpulseDetail);
        $(".btnType05").on("click", this.procDataCenFnc);
    };
    
    exeImpulse.searchDataFnc = function(e) {
    	if(DateUtil.checkDateTerm( $( "[name='searchStartDate']").val(),  $( "[name='searchEndDate']").val()) !== 'ok') {
            alert("검색 조건의 시작 날이 종료 날보다 큽니다.");
            return false;
        }
    	
    	//$("#userId").val($("#userId").val().replace(/ /g, ''));	// 공백제거
    	
    	//$("[name='viewFlg']").val('list');
        $("[name='comptCd']").val($("[name='comptCdS']").val());
        $("[name='procCd']").val($("[name='procCdS']").val());
        $("[name='parkingLocationReason']").val($("[name='parkingLocationReasonCd']").val());
        $("[name='currentPageNo']").val(1);
        $("#searchFrm").attr({method : "post", action : "<c:out value='/getExeImpulseList.do'/>"}).submit();
    };
   
    exeImpulse.pageSelect = function(cPage) {
        //$("[name='viewFlg']").val('list');
        $("[name='currentPageNo']").val(cPage);
        $("[name='comptCd']").val($("[name='comptCdS']").val());
        $("[name='procCd']").val($("[name='procCdS']").val());
        $("[name='parkingLocationReason']").val($("[name='parkingLocationReasonCd']").val());
        $("#searchFrm").attr({method : "post", action : "<c:out value='/getExeImpulseList.do'/>"}).submit();
    };
    
    exeImpulse.procDataFnc = function(cPage) {
    	var checkBtn = $(this);
    	var tr = checkBtn.parent().parent();
    	var td = tr.children();
    	//alert(td.eq(5).text());
    	//alert(td.eq(3).find("option:selected").val());
    	$("[name='enfrcReturnHistSeq']").val(td.eq(5).text());
    	$("[name='comptCd']").val(td.eq(3).find("option:selected").val());
    	
    	
    	var comptCd = $("[name='comptCd']").val();
    	
    	var rentBikeId = td.eq(6).text() ;
    	var rentBikeNo = td.eq(7).text() ;
    	
    	var enfrcReturnHistSeq = $("[name='enfrcReturnHistSeq']").val();
    	var comptCd = $("[name='comptCd']").val();
    	if(enfrcReturnHistSeq =="" || comptCd ==""){
    		alert("완료 유형을 선택하세요");
    		return;
    		
    	} else {
     		$.ajax({
				url : "/compExeImpulseProc.do",
				type : "get",
				data : { "enfrcReturnHistSeq" : enfrcReturnHistSeq, "comptCd" : comptCd},
				contentType: "charset=utf-8",
				async : false,
				success : function(dataView){
					 
					
					
					if ( comptCd == "3" ) {
						if ( confirm("수리 입고를 등록하시겠습니까?") ) {
							
							
							var locateInfo = "/moveRepairBikeEditForm.do?viewFlg=C&bikeId=" + rentBikeId + "&bikeNo=" + rentBikeNo;  
							//window.location.href= locateInfo ;
							window.open( locateInfo, '_blank' ) ;
							
							
						} else {
							alert("완료처리 되었습니다.");	
						}	
					} else {
						alert("완료처리 되었습니다.");	
					}
				},
				
				error : function(){ alert("완료처리 실패 하였습니다."); }
			});
    	}
    	
    };
    
    exeImpulse.procDataCenFnc = function(cPage) {
    	var checkBtn = $(this);
    	var tr = checkBtn.parent().parent();
    	var td = tr.children();
    	$("[name='enfrcReturnHistSeq']").val(td.eq(5).text());
    	
    	var enfrcReturnHistSeq = $("[name='enfrcReturnHistSeq']").val();
    	var comptCd = "0";
    	
    	if(enfrcReturnHistSeq =="" || comptCd ==""){
    		alert("완료 유형을 선택하세요");
    	} else {
        //alert(carNo);
         $.ajax({
				url : "/compExeImpulseProc.do",
				type : "get",
				data : { "enfrcReturnHistSeq" : enfrcReturnHistSeq, "comptCd" : comptCd},
				contentType: "charset=utf-8",
				async : false,
				success : function(dataView){
					alert("완료처리 되었습니다.");
					
				},
				error : function(){ alert("완료처리 실패 하였습니다."); }
			}); 
    	}
    	
    };
    
    exeImpulse.moveexeImpulseDetail = function(e) {
    	if($(this).attr('name') == "photo"){
    		goMapAddr(e.target.id);
    	}else{
    		$("[name='enfrcReturnHistSeq']").val(e.target.id);
    		$("#searchFrm").attr({action: '/moveExeImpulseDetail.do', method :"post"}).submit();
    	}
    };
    
	function goMapAddr(seq){
		
		
		/* if(!$("#station_latitude").val() && !$("#station_longitude").val()){
			alert('<spring:message code="fail.input.emptyValue2" arguments="위경도"/>');
			return;
		} */
		var pwidth = 600;
		var pheight = 730;
		var winL = (screen.width-pwidth)/2;
		var winT = (screen.height-pheight)/2;
		//var lat = $("#station_latitude").val();
		//var lon = $("#station_longitude").val();
		var lat = "";
		var lon = "";
		
		window.open("/common/pop/entrcReutnViewPop.do?outptt=%uC704%uCE58%uC9C0%uB3C4%uCC3E%uAE30&latitude="+ lat +"&longitude=" + lon + "&enfrcReturnHistSeq=" + seq , "winpop2", "width=600, height=730, top="+winT+", left="+winL+" , scrollbars=yes");

	}
    </script>
</body>
</html>