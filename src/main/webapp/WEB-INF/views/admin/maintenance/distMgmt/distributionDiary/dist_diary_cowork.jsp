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
	개발일시 : 2021-09-03
	개발자   : 양재영
	내용     : 공동근무 실적 조회 화면
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
                        
                        	<input type="hidden" name="viewFlg" 		value="" />
                        	<input type="hidden" name="coworkInfoSeq" 	value="" />
                        	
                        	<fieldset>
								<legend>검색 옵션</legend>
								<div class="shBoxSection">
									<!-- 
									<div class="section">
										<label for="bb22" class="laType02">기간</label>
										<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" name="searchBgnDe" title="선택 날짜" id="bb22" readonly/></span>
										<span class="dash">~</span>
										<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" name="searchEndDe" title="선택 날짜" readonly/></span>
									</div> -->
									<div class="section">
										<label for="bb22" class="laType02">기간</label>
										<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" name="searchBgnDe" title="선택 날짜" id="bb22" readonly/></span>
									</div>	
<!-- 									<div class="section pright center">
										<label for="aa1" class="laType02">센터</label>
										<select class="select-category02" name="centerId" id="centerSlt">
											<option value="">선택</option>
										</select>
									</div> -->
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
										<col style="width:8%;"/>
										<col style="width:30%;"/>
										<col style="width:8%;"/>
										<col style="width:8%;"/>
										<col style="width:30%;"/>
										 
									</colgroup>
									<thead>
									    <tr>
									      <th>작업일자</th>
									      <th>시작<br/>시간</th>
									      <th>종료<br/>시간</th>
									      <th>작업내용</th>
									      <th>자전거<br/>건수</th>
									      <th>참여<br/>자수</th>
									      <th>참여자</th>
									    </tr>
									</thead>
									<tbody>
									<c:forEach items="${dsList}" var="item" varStatus="stat">
										 	<tr>
												<td style="text-align:center;">${item.workDate}</td>								    
												<td style="text-align:center;">${item.workFrHour}</td>								    
												<td style="text-align:center;">${item.workToHour}</td>								    
												<td style="text-align:center;"><a href="#"  id="${item.coworkInfoSeq}">${item.workDtl}</a></td>								    
												<td style="text-align:right;">${item.bikeCnt}</td>																							
												<td style="text-align:right;">${item.workCnt}</td>								    
												<td style="text-align:right;word-break:break-all">${item.coworkName}</td>
											</tr>										      	
									</c:forEach>
									</tbody> 
	                       		</table>
                   	 </div> 
                    </div>
                    
                    <div class="right my-3"><input type="button"  id="btnInsert" value="등록" class="s-btn s-btn-primary"></div>
                    
                    <!-- <div class="right my-3"><input type="button"  id="printBtn" value="프린트" class="s-btn s-btn-primary" onclick="javascript:fnContentPrint('searchResultArea');"></div>
                    <div class="right my-3" style="margin-right:10px;"><input type="button"  id="excelViewBtn" value="엑셀다운로드" class="s-btn s-btn-primary"></div> -->
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
    		var searchBgnDe  = '${searchCondition.searchBgnDe}' !== '' ? '${searchCondition.searchBgnDe}' : '';
    		
    		$('[name="searchBgnDe"]').val(searchBgnDe);
    		
    		/* 소속 팀 */
			$.getJSON('/admin/manage/relocationCar/getTeamList.do',function(data){
				
				data.dataList.sort(function(a, b) { // 오름차순
				    return a.centerNm < b.centerNm ? -1 : a.centerNm > b.centerNm ? 1 : 0;
				});
				
				var bfCenterNm ="";
				
				$.each(data.dataList,function(key,val){
					if ( bfCenterNm != this.centerNm ) {
						$("#centerSlt").append('<option value="' + this.centerId + '">' + this.centerNm  + '</option>');
						
						bfCenterNm = this.centerNm;
					}
				})
				
			 	var initValue = searchCenter;
			 	if(initValue!=''){ $("#centerSlt").val(searchCenter); } 
			});
    		
			coworkList.initBtn();
			 
    		
        });
    	
    	var coworkList = {};
    	
    	coworkList.initBtn = function(){
    		
    		$("#btnInsert").on("click", {viewFlg: "C"}, this.exeMoveDetailFnc);    
    		$(".tb_type01 > tbody > tr").on("click", "a",{viewFlg : "U"}, this.exeMoveDetailFnc);
    		
        	/* $("#searchBtn").on("click",{listType: "list"},this.exeListFnc);
        	$("#regist").on("click",{viewFlg: "C"}, this.exeMoveDetailFnc);
        	 */
        }
    	
    	coworkList.exeMoveDetailFnc = function(e) {
            e.preventDefault();
            var viewFlg = e.data.viewFlg;
            
            $("[name='viewFlg']").val(viewFlg);
            $("[name='coworkInfoSeq']").val(e.target.id);
            
            console.log( $("#searchFrm").serialize())
            
            $("#searchFrm").attr({method : 'post', action : "<c:url value='/distributionDiary/modifyCoworkList.do'/>"}).submit();
        }

        /*********** 변수 & 함수 S ***********/
         
        
        /*********** 변수 & 함수 E ***********/
           
           
    </script>
</body>
</html>