<%@page import="com.dkitec.barocle.base.IConstants"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<!DOCTYPE html>
<html lang="ko">
<head>
<!-- 
	개발일시 : 2021-06-23
	개발자   : 양재영
	내용     : 분배원 실적 조회 화면
	TODO : 
 -->
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" /> 
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />
<meta name="description=" Content="" />
<title><tiles:insertAttribute name="title"/></title>
<tiles:insertAttribute name="resource"/>
<style type="text/css" media="print">
    @page 
    {
        size: auto;  
        margin-top: 10mm;  
        margin-bottom: 0mm;  
    }
</style>
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
						<!-- 검색조건  S -->
                       	<form id="searchFrm">
                       	<div id="searchResultArea">
                        <div class="shBox">
                        
                        	<input type="hidden" name="viewFlg" value="" />
                        	<input type="hidden" name="etc" id="etc"/>
                        	
                        	<fieldset>
								<legend>검색 옵션</legend>
								<div class="shBoxSection">
									<div class="section">
										<label for="bb22" class="laType02">기간</label>
										<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" name="searchBgnDe" title="선택 날짜" id="bb22" readonly/></span>
									</div>	
									<div class="section pright center">
										<label for="aa1" class="laType02">센터</label>
										<select class="select-category02" name="centerId" id="centerSlt">
											<option value="">선택</option>
										</select>
									</div>
									
									<div class="section">
										<label for="etc" class="laType02">합계만 표출</label>
										<input type="checkbox" name="etc1" id="etc1"/>
									</div>
									
									<div class="section pright employee" >
										<label for="aa2" class="laType02">직원 ID</label>
										<span class="input-text07"><input type="text" name="adminName" class=""/></span>
									</div>
									<div class="section pright" style="visibility: hidden;display: none;">
										<select class="select-category03" id="teamSeq" name="teamSeq">
											<option value="">선택</option>
										</select>
									</div>
									<button id="searchBtn" class="btn-srh03 btncase1"><img src="/images/searchIcon.gif" alt="검색"></button>
								</div>
							</fieldset>
						</div>
                       	<!-- 검색조건  E -->

                       	<!-- 검색결과 S -->
                       	<br>
                       	<div>
							<p class="tb_numlist">총 ${fn:length(dsList)} 건</p>                       	
	                       		<table class="tb_type01">
									
									<colgroup>
										<col style="width:13%;"/>
										<col style="width:8%;"/>
										<col style="width:15%;"/>
										<col style="width:10%;"/>
										<col style="width:10%;"/>
										<col style="width:10%;"/>
										<col style="width:10%;"/>
										
										<col style="width:10%;"/>
										<col style="width:10%;"/>
										<col style="width:10%;"/>
										<col style="width:10%;"/>
										<%-- <col style="width:10%;"/> --%>
										<col style="width:10%;"/>
									</colgroup>
									<thead>
									    <tr>
									      <th>이름</th>
									      <th>구분</th>
									      <th>차량<br/>번호</th>
									      <th>대여소<br/>번호</th>
									      <th>배송<br/>시각</th>
									      <th>공동<br/>근무</th>
									      <th>이동</th>
									      
									      <th>재배치</th>
									      <th>경정비</th>
									      <th>입고</th>
									      <th>강반</th>
									      <!-- <th>방치</th> -->
									      <th>고장</th>
									    </tr>
									</thead>
									<tbody>
											<c:set var = "darTp001Cnt" value = "0" />
											<c:set var = "darTp002Cnt" value = "0" />
											<c:set var = "darTp003Cnt" value = "0" />
											<c:set var = "darTp005Cnt" value = "0" />
											<c:set var = "darTp006Cnt" value = "0" />
											<c:set var = "darTp008Cnt" value = "0" />
									<c:forEach items="${dsList}" var="item" varStatus="stat">
										 	<tr>
										 		<c:if test="${item.workTime eq '999' }"><c:set var = "darTp001Cnt" value = "${darTp001Cnt + item.darTp001Cnt}"/></c:if>
										 		<c:if test="${item.workTime eq '999' }"><c:set var = "darTp002Cnt" value = "${darTp002Cnt + item.darTp002Cnt}"/></c:if>
										 		<c:if test="${item.workTime eq '999' }"><c:set var = "darTp003Cnt" value = "${darTp003Cnt + item.darTp003Cnt}"/></c:if>
										 		<c:if test="${item.workTime eq '999' }"><c:set var = "darTp005Cnt" value = "${darTp005Cnt + item.darTp005Cnt}"/></c:if>
										 		<c:if test="${item.workTime eq '999' }"><c:set var = "darTp006Cnt" value = "${darTp006Cnt + item.darTp006Cnt}"/></c:if>
										 		<c:if test="${item.workTime eq '999' }"><c:set var = "darTp008Cnt" value = "${darTp008Cnt + item.darTp008Cnt}"/></c:if>
										 	
												<td style="text-align:center;<c:if test="${item.workTime eq '999' }">background:beige;font-weight:bold;</c:if>">${fn:replace(item.adminName, newLineChar, "<br/>")}</td>								    
												<td style="text-align:center;<c:if test="${item.workTime eq '999' }">background:beige;font-weight:bold;</c:if>">${item.workClassifi}</td>								    
												<td style="text-align:center;<c:if test="${item.workTime eq '999' }">background:beige;font-weight:bold;</c:if>">${item.vcleNo}</td>								    
												<td style="text-align:center;<c:if test="${item.workTime eq '999' }">background:beige;font-weight:bold;</c:if>">${item.stationNo}</td>								    
												<td style="text-align:right;<c:if test="${item.workTime eq '999' }">background:beige;font-weight:bold;</c:if>">
												<c:choose>
													<c:when test="${item.workTime eq '50' }">공동작업</c:when>
													<c:when test="${item.workTime eq '99' }">수기입출고</c:when>
													<c:when test="${item.workTime eq '999' }">합계</c:when>
													<c:otherwise>${item.workTime}</c:otherwise></c:choose>
												</td>								    
																								
												<td style="text-align:right;<c:if test="${item.workTime eq '999' }">background:beige;font-weight:bold;</c:if>">${item.etc}</td>								    
												<td style="text-align:right;<c:if test="${item.workTime eq '999' }">background:beige;font-weight:bold;</c:if>">${item.darTp001Cnt}</td>
																				    
												<td style="text-align:right;<c:if test="${item.workTime eq '999' }">background:beige;font-weight:bold;</c:if>">${item.darTp002Cnt}</td>								    
												<td style="text-align:right;<c:if test="${item.workTime eq '999' }">background:beige;font-weight:bold;</c:if>">${item.darTp003Cnt}</td>								    
												<td style="text-align:right;<c:if test="${item.workTime eq '999' }">background:beige;font-weight:bold;</c:if>">${item.darTp005Cnt}</td>								    
												<td style="text-align:right;<c:if test="${item.workTime eq '999' }">background:beige;font-weight:bold;</c:if>">${item.darTp006Cnt}</td>								    
												<td style="text-align:right;<c:if test="${item.workTime eq '999' }">background:beige;font-weight:bold;</c:if>">${item.darTp008Cnt}</td>								    
										    </tr>										      	
									</c:forEach>
											
									</tbody> 
									 
									 <tfoot>
									 		<tr>
												<td style="text-align:right;background:#CCE1FF;font-weight:bold;" id="adminName">총합</td>								    
												<td style="text-align:right;background:#CCE1FF;font-weight:bold;"></td>								    
												<td style="text-align:right;background:#CCE1FF;font-weight:bold;"></td>								    
												<td style="text-align:right;background:#CCE1FF;font-weight:bold;" id="stationNo"></td>								    
												<td style="text-align:right;background:#CCE1FF;font-weight:bold;" id="workTime"></td>								    
												<td style="text-align:right;background:#CCE1FF;font-weight:bold;" id="etc"></td>								    
												<td style="text-align:right;background:#CCE1FF;font-weight:bold;" id="darTp001Cnt"><c:out value="${darTp001Cnt}"/></td>								    
												<td style="text-align:right;background:#CCE1FF;font-weight:bold;" id="darTp002Cnt"><c:out value="${darTp002Cnt}"/></td>								    
												<td style="text-align:right;background:#CCE1FF;font-weight:bold;" id="darTp003Cnt"><c:out value="${darTp003Cnt}"/></td>								    
												<td style="text-align:right;background:#CCE1FF;font-weight:bold;" id="darTp005Cnt"><c:out value="${darTp005Cnt}"/></td>								    
												<td style="text-align:right;background:#CCE1FF;font-weight:bold;" id="darTp006Cnt"><c:out value="${darTp006Cnt}"/></td>								    
												<td style="text-align:right;background:#CCE1FF;font-weight:bold;" id="darTp008Cnt"><c:out value="${darTp008Cnt}"/></td>								    
											</tr>
									 </tfoot>
									 
	                       		</table>
                   	 </div> 
                    </div>
                    <!-- <div class="right my-3"><input type="button"  id="printBtn" value="프린트" class="s-btn s-btn-primary" onclick="javascript:fnContentPrint('searchResultArea');"></div>
                     -->
                     <div class="right my-3" style="margin-right:10px;"><input type="button"  id="excelViewBtn" value="엑셀다운로드" class="s-btn s-btn-primary"></div>
                     
                  	<!-- 검색결과 E -->
                       	
                    </form>
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
    		
    		var searchCenter = '${searchCondition.centerId}' !== '' ? '${searchCondition.centerId}' : '';
    		var adminName    = '${searchCondition.adminName}' !== '' ? '${searchCondition.adminName}' : '';
    		var searchBgnDe  = '${searchCondition.searchBgnDe}' !== '' ? '${searchCondition.searchBgnDe}' : '';
    		var centerName   = '${searchCondition.centerName}' !== '' ? '${searchCondition.centerName}' : '';
    		var etc   = '${searchCondition.etc}' !== '' ? '${searchCondition.etc}' : '';
    		
    		$('[name="searchBgnDe"]').val(searchBgnDe);
    		$('[name="adminName"]').val(adminName);
    		
    		if( etc == "1" ){
    			$('input:checkbox[id="etc1"]').attr("checked", true);
    		}
    		
    		// 분배직원
    		switch ( '${usrGprCd}' ) {
    		// 분배직원
    		case "5" :
    			$('.center').css("display","none");
    			$('.center').hide();
    			
    			$('.employee').css("display","none");
    			$('.employee').hide();
    			break;
    		// 분배반장
    		case "11" :
    			$('.center').css("display","none");
    			$('.center').hide();
    			break;
    		}
    		
    		/* 소속 팀 */
			$.getJSON('/admin/manage/relocationCar/getTeamList.do',function(data){
				
				data.dataList.sort(function(a, b) { // 오름차순
				    return a.centerNm < b.centerNm ? -1 : a.centerNm > b.centerNm ? 1 : 0;
				});
				
				var bfCenterNm ="";
				
				$.each(data.dataList,function(key,val){
					$("#teamSeq").append('<option value="' + this.teamSeq + '">' + this.centerNm + '|' + this.teamNm + '</option>');
					
					if ( bfCenterNm != this.centerNm ) {
						$("#centerSlt").append('<option value="' + this.centerId + '">' + this.centerNm  + '</option>');
						
						bfCenterNm = this.centerNm;
					}
				})
				
				var initValue = searchCenter;
				if(initValue!=''){ $("#centerSlt").val(searchCenter); } 
			});
    		
    		 
    		
        });
    	
    	$("#searchBtn").on("click",function(e){
			e.preventDefault();
 			
			if( $('input[name="etc1"]').is(":checked")) {
				$('input[name="etc"]').val("1");
			} else {
				$('input[name="etc"]').val("0");
			}
			
		    $("[name='viewFlg']").val("list");
			$("#searchFrm").submit();
		});

		$("#excelViewBtn").on("click",function(e){
			e.preventDefault();

			if( $('input[name="etc1"]').is(":checked")) {
				$('input[name="etc"]').val("1");
			} else {
				$('input[name="etc"]').val("0");
			}
			
	        $("[name='viewFlg']").val("excel");
	         
	        $("#searchFrm").submit();
	         
		});    	
    	
        /*********** 변수 & 함수 S ***********/
         
        
        /*********** 변수 & 함수 E ***********/
           

    </script>
</body>
</html>