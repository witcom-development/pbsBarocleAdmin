<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no" />
<meta name="description=" Content="" />
<title><tiles:insertAttribute name="title"/></title>
<tiles:insertAttribute name="resource"/>
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
										<label for="bb22" class="laType02">발생일자</label>
										<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" name="searchBgnDe" title="선택 날짜" id="bb22" readonly/></span>
										<span class="dash">~</span>
										<span class="selectDate input-datepick04"><input type="text" class="datepicker input-datepick04" name="searchEndDe" title="선택 날짜" readonly/></span>
									</div>
									<div class="section pright pt-2">
										<label for="aa2" class="laType02">조회구분</label>										
										<span class="input-rd01"><input type="radio" id="a2" name="clean_type" value="A" checked="checked"/><label for="a2">출근</label></span>
										<span class="input-rd01"><input type="radio" id="a3" name="clean_type" value="B" /><label for="a3">퇴근</label></span>
										<span class="input-rd01"><input type="radio" id="a1" name="clean_type" value="" /><label for="a1">전체</label></span>
									</div>
									<div class="section">
										<label for="aa1" class="laType02">아이디</label>
										<span class="input-text07"><input type="text" name="reg_id" class=""/></span>
									</div>

									<div class="section repos">
									<button id="searchBtn" class="btn-srh03 btncase1"><img src="/images/searchIcon.gif" alt="검색"></button>
									</div>
								</div>
							</fieldset>
						</div>
						</div>
						</form>
                       	<!-- 검색조건  E -->

                       	<button id="searchExcel" style="float: right; padding: 10px; margin: 10px; background: green;" class="btnType01">전체 실적 엑셀 다운로드</button>	
                       	
                       	
                       	<div id="stWorkOn">

                       	
							<table class="tb_type01 stWorks">
								<thead>
									<tr>
										<th>아이디</th>
										<th>이름</th>
										<th>구분</th>
										<th>일시</th>
										<th>장소</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="result" items="${cleanListA}" varStatus="status">
									<tr>
										
										<td class="tc">${result.reg_id}</td>
										<td class="tc">${result.reg_name}</td>
										<td class="tc">
										<c:choose>
											<c:when test="${result.clean_type == 'A'}">
											출근
											</c:when>
											<c:when test="${result.clean_type == 'B'}">
											퇴근
											</c:when>
										</c:choose>
										</td>	
										<td class="tc">${result.reg_dttm}</td>										
										<td class="tc">${result.reg_addr} ${result.reg_addr_detail}</td>
									</tr>								
									</c:forEach>
									<c:if test="${fn:length(cleanListA) eq 0 }">
										<table class="tb_type01 nbt0">
											<tr><td style="text-align:center"><spring:message code="search.nodata.msg" /></td></tr>
										</table>
									</c:if>
								</tbody>
							</table>
						</div>
						
						
						
                    </div>
                 </div>
             </div>
      	</div>
<script type="text/javascript" src="/js/common_barocle.js"></script>
<script type="text/javascript">
	$(function() {		
		
		var fromday = DateUtil.dateFmt(new Date()); /* DateUtil.dateFmt(date); 당일로 변경*/		
		var today = DateUtil.dateFmt(new Date());
		//fromday = settingDate;
 		var sDate = '${searchCondition.searchBgnDe}' !== '' ? '${searchCondition.searchBgnDe}' : fromday;
		var eDate = '${searchCondition.searchEndDe}' !== '' ? '${searchCondition.searchEndDe}' : today;
		
		
		var reg_id = '${searchCondition.reg_id}' !== '' ? '${searchCondition.reg_id}' : '';
		var clean_type = '${searchCondition.clean_type}' !== '' ? '${searchCondition.clean_type}' : '';
		
		
		
		$("[name='reg_id']").val(reg_id);
		$("[name='searchBgnDe']").val(sDate);
		$("[name='searchEndDe']").val(eDate);
		$("[name='clean_type']:input[value='"+clean_type+"']").prop('checked', true);
		
		$("#searchBtn").on("click",function(e){
			if(DateUtil.checkDateTerm( $( "[name='searchBgnDe']").val(),  $( "[name='searchEndDe']").val()) != 'ok') {
			      alert('<spring:message code="fail.input.daterange"/>');
			      return false;
			  }	 
			
			  $("#searchFrm").attr({method : 'post', action : '/cleanStatusList.do'}).submit();
		});
		
		
		$("#searchExcel").click(function(){ 	/// 보고서 출력
			
			$("#searchFrm").attr({method : 'post', action : '/cleanStatusExcelList.do'}).submit();
				
		});
	});
	
	
	


      
</script>
                       	
</body>

</html>