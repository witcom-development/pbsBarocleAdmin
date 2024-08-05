<%@page import="com.dkitec.barocle.base.IConstants"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<!-- 
	개발일시 : 2021-07-27
	개발자   : 양재영
	내용     : 사업소 현황 조회 화면
	TODO : 통계테이블 을 사용하는 쿼리로 변경해야함.
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

	    .contents { border: 1px solid black; padding: 20px; }
	    .contents h1 { line-height: 2em; font-size: 1.8em}
	    .contents h2 { line-height: 2em; font-size: 1.2em}
        
    }
</style>

<style type="text/css">
    .contents { border: 1px solid black; padding: 20px; }
    .contents h1 { line-height: 2em; font-size: 1.8em}
    .contents h2 { line-height: 2em; font-size: 1.2em}
    #detailList td {text-align: center}
    .scrolltable{
	    table-layout: fixed;
	    border-collapse: collapse;
	    border: 1px solid #888;
	    text-align: right;
	}
	.scrolltable thead {
	    display:block;
	    background: #eff5f8;
	}
	.scrolltable tfoot {
	    display:block;
	    background: #eff5f8;
	    font-weight: bolder;
	}
	.scrolltable tbody{
	    display:block;
	    overflow:auto;
	    height:400px;
	    width: 700px;
	}
	/* 행 장식 */
	.scrolltable th, .scrolltable td {
	  padding: 10px;
	 
	  width: 300px;
	  font-size: 0.875em;
	}
	.scrolltable tbody tr:nth-child(2n+1){
	 /*    background-color: #f0f0f0; */
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
		                        	
		                        	<fieldset>
										<legend>검색 옵션</legend>
										<div class="shBoxSection">
											<div class="section">
												<label for="bb22" class="laType02">기간</label>
												<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" name="searchBgnDe" title="선택 날짜" id="bb22" readonly/></span>
												<span class="dash endDate">~</span>
												<span class="selectDate input-datepick04 endDate"><input type="text" class="datepicker input-datepick04" name="searchEndDe" title="선택 날짜" readonly/></span>
											</div>
											<div class="section pright center">
												<label for="aa1" class="laType02">팀정보</label>
												<select class="select-category02" name="centerId" id="centerSlt">
													<option value="">선택</option>
												</select>
											</div>
											<button id="searchBtn" class="btn-srh03 btncase1"><img src="/images/searchIcon.gif" alt="검색"></button>
										</div>
									</fieldset>
								</div>
							</div>	
						</form>
                       	<!-- 검색조건  E -->
                       	<br/>
                       	<div class="contents" id="contents">
                       		<h1 style="text-align: center">- 공공자전거 관리소 배송일지 -</h1>
	                       	<h2>▣ 일 시 : <span id="searchDate"></span></h2>
	                       	<h2 id="weatherH2">▣ 날 씨 : <span id="weather">${weather}</span></h2>
	                       	<h2>▣ 근무인력 현황 </h2>
                       			<table class="tb_type01" id="detailList">
									
									<colgroup>
										<col style="width:20%;"/>
										<col style="width:10%;"/>
										<col style="width:20%;"/>
										<col style="width:20%;"/>
										<col style="width:20%;"/>
										<col style="width:20%;"/>
									</colgroup>
									<thead>
									    <tr>
									      <th>구분</th>
									      <th>총원</th>
									      <th>이동건수</th>
									      <th>설치건수</th>
									      <th>입고건수</th>
									      <th>강반건수</th>
									    </tr>
									</thead>
									<tbody>
										
										<c:forEach items="${dsOfficeList}" var="item" varStatus="stat">
											<tr>
												<td>${item.officeName}</td>
												<td>${item.etc}</td>
												<td>${item.bikeMoveCnt}</td>
												<td>${item.bikeReplaceCnt}</td>
												<td>${item.warehousingCnt}</td>
												<td>${item.darTp006Cnt}</td>
									
											</tr>
										</c:forEach>
									</tbody>
								</table>	
                       		<h2>▣ 자전거 배송분야 </h2>
                       			<table class="scrolltable">
									<colgroup>
										<col style="width:18%;"/>
										<col style="width:18%;"/>
										<col style="width:18%;"/>
										<col style="width:18%;"/>
										<col style="width:18%;"/>
										<col style="width:18%;"/>
										<col style="width:18%;"/>
									</colgroup>
									<thead>
									    <tr>
									      <th>팀</th>
									      <th>차량번호</th>
									      <th>근무자</th>
									      <th>회수</th>
									      <th>분배</th>
									      <th>입고</th>
									      <th>강반</th>
									    </tr>
									</thead>
									<tbody>
										<c:set var = "memberCnt" value = "0" />
										<c:set var = "moveTotalCnt" value = "0" />
										<c:set var = "replaceTotalCnt" value = "0" />
										<c:set var = "wareTotalCnt" value = "0" />
										<c:set var = "darTp006TotCnt" value = "0" />
										<c:forEach items="${dsList}" var="item" varStatus="stat">
											 	<tr>
													<td style=' <c:if test="${item.teamSeq eq 'TEAM_000' }">background:beige;font-weight:bold;</c:if>'>${item.teamName}</td>								    
													<td style=' <c:if test="${item.teamSeq eq 'TEAM_000' }">background:beige;font-weight:bold;</c:if>'>${item.vcleNo}</td>								    
													<td style=' <c:if test="${item.teamSeq eq 'TEAM_000' }">background:beige;font-weight:bold;</c:if>'>${item.etc}</td>								    
													<td style=' <c:if test="${item.teamSeq eq 'TEAM_000' }">background:beige;font-weight:bold;</c:if>'>${item.bikeMoveCnt}</td>								    
													<td style=' <c:if test="${item.teamSeq eq 'TEAM_000' }">background:beige;font-weight:bold;</c:if>'>${item.bikeReplaceCnt}</td>								    
													<td style=' <c:if test="${item.teamSeq eq 'TEAM_000' }">background:beige;font-weight:bold;</c:if>'>${item.warehousingCnt}</td>								    
													<td style=' <c:if test="${item.teamSeq eq 'TEAM_000' }">background:beige;font-weight:bold;</c:if>'>${item.darTp006Cnt}</td>								    
											    </tr>
											    <c:if test="${item.teamSeq eq 'TEAM_000' }"> 
												    <c:set var= "memberCnt"    	  value="${memberCnt       + item.etc}"/>
												    <c:set var= "moveTotalCnt"    value="${moveTotalCnt    + item.bikeMoveCnt}"/>
												    <c:set var= "replaceTotalCnt" value="${replaceTotalCnt + item.bikeReplaceCnt}"/>
												    <c:set var= "wareTotalCnt"    value="${wareTotalCnt    + item.warehousingCnt}"/>
												    <c:set var= "darTp006TotCnt"  value="${darTp006TotCnt  + item.darTp006Cnt}"/>
											    </c:if>
										</c:forEach>
									
									</tbody>
									<tfoot>
									 <tr>
							            <td>총 합계</td>
							            <td></td>
							            <td><c:out value="${memberCnt}"/></td>
							            <td><c:out value="${moveTotalCnt}"/></td>
							            <td><c:out value="${replaceTotalCnt}"/></td>
							            <td><c:out value="${wareTotalCnt}"/></td>
							            <td><c:out value="${darTp006TotCnt}"/></td>
							        </tr>
									</tfoot>
								</table>
                       	</div>
                       	 
                    <div class="right my-3" style="margin-right:10px;"><input type="button"  id="excelViewBtn" value="엑셀다운로드" class="s-btn s-btn-primary"></div>
                  	<!-- 검색결과 E -->

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
		
		$('[name="searchBgnDe"]').val(searchBgnDe);
		$('[name="searchEndDe"]').val(searchEndDe);
		
		if ( searchEndDe != '' && ( searchBgnDe != searchEndDe )){
			$('#searchDate').html(searchBgnDe + " ~ " + searchEndDe );
			$('.weatherH2').css("display","none");
			$('.weatherH2').hide();
		} else { 
			$('#searchDate').html(searchBgnDe);
		}
		
		// 분배직원 ( id로 리턴 ))
		if ( '${searchCondition.centerName}' ) {
			$('.center').css("display","none");
			$('.center').hide();
			
			$('.endDate').css("display","none");
			$('.endDate').hide();
			$('[name="searchEndDe"]').css("display","none");
			$('[name="searchEndDe"]').hide();
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
	  	
		$("#searchBtn").on("click",function(e){
			e.preventDefault();
/* 			var check = $("[name='searchCenter']").val();
			if(check.length < 1){
				
				alert("사업소를 입력하세요.");
				return true;
			} */
		    $("[name='viewFlg']").val("list");
		    
			$("#searchFrm").submit();
		});
		
	    
		$("#excelViewBtn").on("click",function(e){
			e.preventDefault();
/* 				var check = $("[name='searchCenter']").val();
				if(check.length < 1){
					
					alert("사업소를 입력하세요.");
					return true;
				} */
	        $("[name='viewFlg']").val("excel");
	         
	        $("#searchFrm").submit();
	         
		});
    	  
    })
    </script>
</body>
</html>