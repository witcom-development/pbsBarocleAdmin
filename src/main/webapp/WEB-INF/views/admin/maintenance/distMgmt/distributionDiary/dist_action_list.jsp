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
	개발일시 : 2022-01-19
	개발자   : 양재영
	내용     : 회수작업 실적 조회 화면
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
                        	<input type="hidden" name="retTypeName" value="" />
                        	<input type="hidden" name="centerName" value="" />
                        	
                        	<fieldset>
								<legend>검색 옵션</legend>
								<div class="shBoxSection">
									 
									<div class="section">
										<label for="bb22" class="laType02">기간</label>
										<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" name="searchBgnDe" title="선택 날짜" id="bb22" readonly/></span>
										<span class="dash">~</span>
										<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" name="searchEndDe" title="선택 날짜" readonly/></span>
									</div>  
  									<div class="section pright center">
										<label for="aa1" class="laType02">센터</label>
										<select class="select-category02" name="centerId" id="centerSlt">
											<option value="">선택</option>
										</select>
									</div>
  									<div class="section">
										<label for="aa1" class="laType02">이름</label>
										 <input type="text" name="searchAdminName"/>
									</div>
									
									<div class="section pright center">
										<label for="aa1" class="laType02">회수사유</label>
										<select class="select-category02" name="retType" id="retType">
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
										<col style="width:8%;"/>
										<col style="width:10%;"/>
										<col style="width:10%;"/>
										<col style="width:12%;"/>
										<col style="width:40%;"/>
										<col style="width:15%;"/>
										 
									</colgroup>
									<thead>
									    <tr>
									      <th>이동일자</th>
									      <th>센터</th>
									      <th>팀</th>
									      <th>작업구분</th>
									      <th>작업자</th>
									      <th>자전거번호</th>
									      <th>주소</th>
									      <th>처리결과</th>
									    </tr>
									</thead>
									<tbody>
									<c:forEach items="${dsList}" var="item" varStatus="stat">
										 	<tr>
												<td style="text-align:center;">${item.regDttm}</td>								    
												<td style="text-align:center;">${item.centerName}</td>								    
												<td style="text-align:center;">${item.teamName}</td>								    
												<td style="text-align:center;">${item.retType}</td>								    
												<td style="text-align:right;word-break:break-all">${item.adminName}</td>
												<td style="text-align:center;">${item.bikeNo}</td>								    
												<td style="text-align:left;">${item.addr}</td>								    
												<td style="text-align:left;">${item.followName}</td>								    
											</tr>										      	
									</c:forEach>
									</tbody> 
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
    		var searchBgnDe  = '${searchCondition.searchBgnDe}' !== '' ? '${searchCondition.searchBgnDe}' : '';
    		var searchEndDe  = '${searchCondition.searchEndDe}' !== '' ? '${searchCondition.searchEndDe}' : '';
    		var searchAdminName  = '${searchCondition.searchAdminName}' !== '' ? '${searchCondition.searchAdminName}' : '';
    		var searchRetType  = '${searchCondition.retType}' !== '' ? '${searchCondition.retType}' : '';
    		
    		$('[name="searchBgnDe"]').val(searchBgnDe);
    		$('[name="searchEndDe"]').val(searchEndDe);
    		$('[name="searchAdminName"]').val(searchAdminName);
    	 
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
			 	var initValue = searchCenter.replace(",","");
			 	if(initValue!=''){
			 		$("#centerSlt").val(initValue).prop("selected",true);
			 	 } 
			});
    		
			commonAjax.getCommonCode("RET", function(data){
				if(data !== null && data.codeList !== null) {
					var code = new Array();
		             for(var i =0; i <data.codeList.length ;i++) {
		                     code.push(data.codeList[i]);
		             }
		             commCdBox.makeComboBox('CC', searchRetType, code, "retType");
				}
			});
    		
        });
    	
    	$("#searchBtn").on("click",function(e){
			e.preventDefault();
	        $("[name='viewFlg']").val("list");

	         
	        $("#searchFrm").submit();
	         
		});
    	
		$("#excelViewBtn").on("click",function(e){
			e.preventDefault();
	        $("[name='retTypeName']").val($("[name='retType'] option:selected").text());
	        $("[name='centerName']").val($("[name='centerId'] option:selected").text());
	        $("[name='viewFlg']").val("excel");
	         
	        $("#searchFrm").submit();
	         
		});
           
           
    </script>
</body>
</html>