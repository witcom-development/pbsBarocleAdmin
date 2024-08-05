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
<!-- 
	개발일시 : 2020-06-12
	개발자   : 김시성
	내용     : 정비직원 실적 조회 화면
	TODO : 
	       
	ASIS : 기존 페이지에서 사용한 예방정비 공통코드는 불러오지않음.
	       (= 기존페이지에 개선 페이지 작성을 위해 수정/등록 한 코드들이 나오지 않게
	          작업했기때문에 부품항목에 매핑할 값이 없음)
		   단말기 수리완료 건수는 단말기 수리자 정보 테이블에 등록한 건수만 카운트
	       자전거 수리완료 건수는 수리정보 테이블에 등록된 건수 카운트
	       통계테이블을 사용하는 쿼리로 변경
	       
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
<!-- solbit test-테스트 페이지  S   -->
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
						<p class="pageTitle"><c:forEach items="${menuPathList}" var="menuPath" varStatus="status"><c:if test="${status.last}"><c:out value="${menuPath}" />(<c:out value="${searchCondition.adminGrpName}" />)</c:if></c:forEach></p>
						<span>
							<c:forEach items="${menuPathList}" var="menuPath" varStatus="status">
								<c:choose>
									<c:when test="${!status.last}"><c:out value="${menuPath}"/> &gt; </c:when>
									<c:otherwise><em><c:out value="${menuPath}"/></em></c:otherwise>
								</c:choose>
							</c:forEach>
						</span>
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
                        	
                        	<fieldset>
								<legend>검색 옵션</legend>
								<div class="shBoxSection">
									<div class="section">
										<label for="bb22" class="laType02">기간</label>
										<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" name="searchBgnDe" title="선택 날짜" id="bb22" readonly/></span>
										<span class="dash">~</span>
										<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" name="searchEndDe" title="선택 날짜" readonly/></span>
									</div>
									<div class="section pright">
										<label for="aa2" class="laType02">정비직원</label>
										<span class="input-text07"><input type="text" name="searchAdmin" class=""/></span>
									</div>
									<div class="section pright">
										<label for="aa1" class="laType02">사업소</label>
										<select class="select-category02" name="searchCenter" id="centerSlt">
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
							<%-- <p class="tb_numlist">총 ${ paginationInfo.getTotalRecordCount()} 건</p>    --%>                    	
							<c:choose>
								<c:when test="${fn:length(wrkPerfList) ne 0 }">                       	
	                       		<table class="tb-sb-1">
									<thead>
									    <tr>
									      <td class="top text-center" rowspan="2" style="width:8%;">센터</td>
									      <td class="top text-center" rowspan="2" style="width:7%;">이름</td>
									      <td class="top text-center" rowspan="2" style="width:5%;">구분</td>
									      <td class="top text-center" colspan="12" style="width:67%;">정비내역</td>
									      <td class="top text-center" colspan="2" style="width:13%;">완료대수</td>
									    </tr>
									    <tr>
									      <td class="text-center">단말기</td>
									      <td class="text-center">벨</td>
									      <td class="text-center">핸들</td>
									      <td class="text-center">브레<br>이크</td>
									      <td class="text-center">변속기</td>
									      <td class="text-center">타이어<br>튜브</td>
									      <td class="text-center">체인</td>
									      <td class="text-center">체인<br>받이</td>
									      <td class="text-center">물받이</td>
									      <td class="text-center">스탠드</td>
									      <td class="text-center">기타</td>
									      <td class="text-center">계</td>
									      <td class="text-center">단말기</td>
									      <td class="text-center">자전거</td>
									    </tr>
									</thead>
									
									<tbody>
									
									<c:set var="itemCheck" value="1" />
									<c:set var="centerCheck" value="" />
									<c:set var="nameCheck" value="" />
									<c:forEach items="${wrkPerfList}" var="item" varStatus="stat">
									
										<c:if test="${item.divsnCnt eq '1'}">
										    <tr class="rebTr">
										      	<td class="text-center" rowspan="3">${item.repairCenterName }</td>
										      	<td class="text-center" rowspan="3">${item.repairAdminName}</td>
										      	<td class="text-center">점검</td>
												<td class="text-center">${item.termCnt}</td>								    
												<td class="text-center">${item.bellCnt}</td>								    
												<td class="text-center">${item.handleCnt}</td>								    
												<td class="text-center">${item.brakeCnt}</td>								    
												<td class="text-center">${item.transCnt}</td>								    
												<td class="text-center">${item.ttCnt}</td>								    
												<td class="text-center">${item.chainCnt}</td>								    
												<td class="text-center">${item.chainCvCnt}</td>								    
												<td class="text-center">${item.trghCnt}</td>								    
												<td class="text-center">${item.standCnt}</td>								    
												<td class="text-center">${item.etcCnt}</td>								    
												<td class="text-center">${item.sumCnt}</td>
																				    
												<td class="text-center" rowspan="3">
													<c:if test="${empty item.cmptTermCnt }">
														0
													</c:if>
													<c:if test="${not empty item.cmptTermCnt }">
														${item.cmptTermCnt}
													</c:if>
												
												</td>
												
												<td class="text-center" rowspan="3">
													<c:if test="${empty item.bikeCnt }">
														0
													</c:if>
													<c:if test="${not empty item.bikeCnt }">
														${item.bikeCnt}
													</c:if>
												
												</td>
																				    
										    </tr>
										    <c:set var="centerCheck" value="${item.repairCenterName}" />
											<c:set var="nameCheck" value="${item.repairAdminName}" />										      	
									    </c:if>
										<c:if test="${item.divsnCnt eq '2' && item.repairCenterName eq centerCheck && item.repairAdminName eq nameCheck}">									    
										    <tr class="parTr">
										      	<td class="text-center">정비</td>
												<td class="text-center">${item.termCnt}</td>								    
												<td class="text-center">${item.bellCnt}</td>								    
												<td class="text-center">${item.handleCnt}</td>								    
												<td class="text-center">${item.brakeCnt}</td>								    
												<td class="text-center">${item.transCnt}</td>								    
												<td class="text-center">${item.ttCnt}</td>								    
												<td class="text-center">${item.chainCnt}</td>								    
												<td class="text-center">${item.chainCvCnt}</td>								    
												<td class="text-center">${item.trghCnt}</td>								    
												<td class="text-center">${item.standCnt}</td>								    
												<td class="text-center">${item.etcCnt}</td>								    
												<td class="text-center">${item.sumCnt}</td>								    
										    </tr>										      	
									    </c:if>
 										<c:if test="${item.divsnCnt eq '2' && ( item.repairCenterName ne centerCheck  || item.repairCenterName eq centerCheck ) && item.repairAdminName ne nameCheck}">
 											<tr class="rebTr">
										      	<td class="text-center" rowspan="3">${item.repairCenterName }</td>
										      	<td class="text-center" rowspan="3">${item.repairAdminName}</td>
										      	<td class="text-center">점검</td>
												<td class="text-center">0</td>								    
												<td class="text-center">0</td>								    
												<td class="text-center">0</td>								    
												<td class="text-center">0</td>								    
												<td class="text-center">0</td>								    
												<td class="text-center">0</td>								    
												<td class="text-center">0</td>								    
												<td class="text-center">0</td>								    
												<td class="text-center">0</td>								    
												<td class="text-center">0</td>								    
												<td class="text-center">0</td>								    
												<td class="text-center">0</td>
																				    
												<td class="text-center" rowspan="3">
													<c:if test="${empty item.cmptTermCnt }">
														0
													</c:if>
													<c:if test="${not empty item.cmptTermCnt }">
														${item.cmptTermCnt}
													</c:if>
												
												</td>
												
												<td class="text-center" rowspan="3">
													<c:if test="${empty item.bikeCnt }">
														0
													</c:if>
													<c:if test="${not empty item.bikeCnt }">
														${item.bikeCnt}
													</c:if>
												
												</td>
																				    
										    </tr>									    
										    <tr class="parTr">
										      	<td class="text-center">정비</td>
												<td class="text-center">${item.termCnt}</td>								    
												<td class="text-center">${item.bellCnt}</td>								    
												<td class="text-center">${item.handleCnt}</td>								    
												<td class="text-center">${item.brakeCnt}</td>								    
												<td class="text-center">${item.transCnt}</td>								    
												<td class="text-center">${item.ttCnt}</td>								    
												<td class="text-center">${item.chainCnt}</td>								    
												<td class="text-center">${item.chainCvCnt}</td>								    
												<td class="text-center">${item.trghCnt}</td>								    
												<td class="text-center">${item.standCnt}</td>								    
												<td class="text-center">${item.etcCnt}</td>								    
												<td class="text-center">${item.sumCnt}</td>								    
										    </tr>										      	
									    </c:if>
									    <c:if test="${empty item.divsnCnt && itemCheck eq '1' }">
										    <tr class="parTr">
										      	<td class="text-center">정비</td>
												<td class="text-center">0</td>								    
												<td class="text-center">0</td>								    
												<td class="text-center">0</td>								    
												<td class="text-center">0</td>								    
												<td class="text-center">0</td>								    
												<td class="text-center">0</td>								    
												<td class="text-center">0</td>								    
												<td class="text-center">0</td>								    
												<td class="text-center">0</td>								    
												<td class="text-center">0</td>								    
												<td class="text-center">0</td>								    
												<td class="text-center">0</td>								    
										    </tr>										    
									    </c:if>
									    <c:if test="${empty item.divsnCnt}">
										    <tr class="sumTr">
										      	<td class="text-center">계</td>
												<td class="text-center">${item.termCnt}</td>								    
												<td class="text-center">${item.bellCnt}</td>								    
												<td class="text-center">${item.handleCnt}</td>								    
												<td class="text-center">${item.brakeCnt}</td>								    
												<td class="text-center">${item.transCnt}</td>								    
												<td class="text-center">${item.ttCnt}</td>								    
												<td class="text-center">${item.chainCnt}</td>								    
												<td class="text-center">${item.chainCvCnt}</td>								    
												<td class="text-center">${item.trghCnt}</td>								    
												<td class="text-center">${item.standCnt}</td>								    
												<td class="text-center">${item.etcCnt}</td>								    
												<td class="text-center">${item.sumCnt}</td>								    
										    </tr>										      	
									    </c:if>
									    <c:set var="itemCheck" value="${item.divsnCnt}"/>
									</c:forEach>
									    
									</tbody>
									<tfoot>    
									    <tr>
									      <td class="text-center" colspan="2">수리완료</td>
									      <td class="text-center" colspan="2">총계</td>
									      <td class="text-center" colspan="3">${searchCondition.repairTotCnt}</td>
									      <td class="text-center" colspan="2">단말기</td>
									      <td class="text-center" colspan="3">${searchCondition.repairTermCnt}</td>
									      <td class="text-center" colspan="2">자전거</td>
									      <td class="text-center" colspan="3">${searchCondition.repairBikeCnt}</td>
									    </tr>
									</tfoot>    
	                       		</table>
	                       	</c:when>	
                      		<c:otherwise>
                                <table class="tb_type01 nbt0">
		                            <tr><td style="text-align:center"><spring:message code="search.nodata.msg" /></td></tr>
		                        </table>
							</c:otherwise>
						</c:choose>
                    </div>
                    </div>
                    <div class="right my-3"><input type="button"  id="printBtn" value="프린트" class="s-btn s-btn-primary" onclick="javascript:fnContentPrint('searchResultArea');"></div>
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

        	/****** 그룹 별 화면 show hide 처리 S ******/
        	
        	switch('${searchCondition.adminGrpName}'){
    				
    			case "정비" :
    				
    				$("#printBtn").hide();
    				$("[name='searchAdmin']").closest('div').hide();
    				
    			case "정비반장" :
    				
    				$("[name='searchCenter']").closest('div').attr("style","visibility:hidden");
    				
    			break;
    			
    			case "관리운영그룹" :
    			case "관리팀" :
    			break;
    			
    			default :

    				$("#printBtn").hide();
    				$("[name='searchAdmin']").closest('div').hide();				
    				$("[name='searchCenter']").closest('div').attr("style","visibility:hidden");
    				
    			break;	
    			
        	}
        	
        	/****** 그룹 별 화면 show hide 처리 E ******/
    		
        	/*********** 검색구간 정보 S  ***********/
        	
        	var date = new Date;
    		date.setDate(date.getDate()-6);
    		var fromday = DateUtil.dateFmt(new Date()); /* DateUtil.dateFmt(date); 당일로 변경*/
    		var today = DateUtil.dateFmt(new Date());
     		var sDate = '${searchCondition.searchBgnDe}' !== '' ? '${searchCondition.searchBgnDe}' : fromday;
    		var eDate = '${searchCondition.searchEndDe}' !== '' ? '${searchCondition.searchEndDe}' : today;
    		var searchAdmin = '${searchCondition.searchAdmin}' !== '' ? '${searchCondition.searchAdmin}' : '';
    		var searchCenter = '${searchCondition.searchCenter}' !== '' ? '${searchCondition.searchCenter}' : '';
    		
    		wrkPerfInfo.searchCenterId = searchCenter;
    		
    		$("[name='searchBgnDe']").val(sDate);
    		$("[name='searchEndDe']").val(eDate);
    		$("[name='searchAdmin']").val(searchAdmin);
    		$("[name='searchCenter']").val(searchCenter);
    		
        	/*********** 검색구간 정보 E  ***********/
    		
    		wrkPerfInfo.init();
    		
        });

        /*********** 변수 & 함수 S ***********/
        
       	var wrkPerfInfo = {};
        
        wrkPerfInfo.init = function(){
        	
	    	var _this = this;
	    	
	    	this.getCenterCode(function(data) {
                	
	            if(data !== null && data.centerList !== null) {
	            	
	                var newDataList = data.centerList.slice(0,11);
	                commCdBox.makeComboBox('C', _this.searchCenterId, newDataList, "centerSlt");
	             
	            }
                    
            });
	    	
	    	
			$("#searchBtn").on("click",function(e){
				
				e.preventDefault();
				
				$("[name='viewFlg']").val("list");
				
				$("#searchFrm").attr({method : 'post', action : '/getRepairPerf.do'}).submit();
				
			});
	    	
			$("#excelViewBtn").on("click",function(e){
				
				e.preventDefault();
		         
		         $("[name='currentPageNo']").val(1);

		         $("[name='viewFlg']").val("excel");
		         
		         $("#searchFrm").attr({method : 'post', action : '/getRepairPerf.do'}).submit();
		         
			});

        }
        
       	wrkPerfInfo.getCenterCode = function(pCb){
       		
    		$.ajax({
    			type 	: "post"
    		   ,url 	: "/getAdmCenterCodeAjax.do"
    		   ,dataType: 'json'
    		   ,async	: false
    		   ,success : function(data){
    				pCb(data);
    				
    			}
    		   ,error : function(data){
    			   
    				alert("센터코드 조회에 실패했습니다.");
    				
    			}
    		});
       		
       	}
        
        /*********** 변수 & 함수 E ***********/
           

    </script>
</body>
</html>