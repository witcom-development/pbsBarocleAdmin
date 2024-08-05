<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

<!-- 
	개발일시 : 2020-09-17
	개발자   : 김시성
	내용     : 관리자 문자 발송 상세
	TODO : 
	ASIS : 기존 전송상태 확인 로직은 마지막 전송문자의 전송상태 확인작업이였으나
	       변경로직은 모든 전송문자의 전송상태 확인작업 - 2020-09-25
	       
 -->
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
					<tiles:insertAttribute name="left" />
				<!--left menu E-->
				<!--content S-->
				<div class="content">
					<div class="subject">
						<!--subject path S-->
							<tiles:insertAttribute name="subject" />
						<!--subject path E-->
					</div>
					<div class="page">
						<form id="frm" name="frm" method="post" accept-charset="utf-8" >
							<input type="hidden" id="searchBgnDe" name="searchBgnDe" value="${searchCondition.searchBgnDe}" />
							<input type="hidden" id="searchEndDe" name="searchEndDe" value="${searchCondition.searchEndDe}" />
							<input type="hidden" id="searchAdmin" name="searchAdmin" value="${searchCondition.searchAdmin}" />
							<input type="hidden" id="currentPageNo" name="currentPageNo" value="${searchCondition.currentPageNo}" />
							<fieldset>
								<legend>관리자 SMS 상세</legend>
								<table class="tb_type02 mt20">
									<colgroup>
										<col style="width:25%"/>
										<col style="width:75%"/>
									</colgroup>
									<tbody>
										<tr>
											<th class="top">제목</th>
											<td class="top">
												<span class="input-text05">${reqSmsVo.reqTitle}</span>
											</td>
										</tr>
										<tr>
											<th>발송자</th>
											<td>
												<span class="input-text05">
													${reqSmsVo.adminName}
												</span>
											</td>
										</tr>
										<tr>
											<th>발송 타입</th>
											<td>
												<span class="input-text05">
													<c:if test="${not empty reqSmsVo.reqSendType}">
														카카오톡
													</c:if>
													<c:if test="${empty reqSmsVo.reqSendType}">
														문자
													</c:if>
												</span>
											</td>
										</tr>								
										<tr>
											<th>발송 상태</th>
											<td>
												<span class="input-text05">
												
													<c:set var="sendTypeCmptCnt" value="0" />
													<c:set var="sendTypeErrorCnt" value="0" />
													<c:set var="sendTypeNotCmptCnt" value="0" />
													
													<c:forEach items="${nameList}" var="list" varStatus="vrs">
													
														<c:if test="${not empty list.sendResultCd}">
														
															<c:if test="${list.sendResultCd eq 'OK' }" >
																<c:set var="sendTypeCmptCnt" value="${sendTypeCmptCnt+1}" />
															</c:if>
															
															<c:if test="${list.sendResultCd ne 'OK' }" >
																<c:set var="sendTypeErrorCnt" value="${sendTypeErrorCnt+1}" />
															</c:if>
															
														</c:if>
														<c:if test="${empty list.sendResultCd}">
															<c:set var="sendTypeNotCmptCnt" value="${sendTypeNotCmptCnt+1}" />
														</c:if>
														
													</c:forEach>
													
													전송완료 : ${sendTypeCmptCnt} 건<br/>전송오류 : ${sendTypeErrorCnt} 건<br/>전송대기 : ${sendTypeNotCmptCnt} 건
													
													<c:if test="${sendTypeErrorCnt ne '0'}">
													
														<br/>
														<br/>
														<div id="sendErrorTag"></div>

														<c:forEach items="${nameList}" var="list" varStatus="vrs">
														
															<c:if test="${not empty list.sendResultCd && list.sendResultCd ne 'OK'}">
																<div class="sendErrorDiv">${list.adminName}(${list.adminPno}) : ${list.sendResultCd}</div>
															</c:if>
															
														</c:forEach>														
													</c:if>
												</span>
											</td>
										</tr>																				
										<tr>
											<th>수신 대상</th>
											<td>
												<span class="input-text05">
													
													<c:forEach items="${adminGrpNameCnt}" var="list">
														${list}
														<br/>
													</c:forEach>
													
												</span>
											</td>
										</tr>		
										<tr>
											<th>발송 예약 날짜</th>
											<td>
												<span class="input-text05">
													${reqSmsVo.reqResDate}
												</span>
											</td>
										</tr>								
										<tr>
											<th><span>내용</span></th>
											<td>
												<c:out value="${reqSmsVo.reqContent}" />
											</td>
										</tr>
									</tbody>
								</table>
								<div class="btnArea">
									<span class="left"><button class="btnType01 bc_gray" id="moveAdminSmsList">목록</button></span>
								</div>
							</fieldset>
						</form>
					</div>
				</div>
				<!--content E-->
			</div>
		</div>
		<!--footer S-->
			<tiles:insertAttribute name="footer" />
		<!--footer E-->
	</div>
    <script type="text/javascript" src="/js/common_barocle.js"></script>
    <script type="text/javascript">
    	
    	$(function(){
    		
    		$("#moveAdminSmsList").on("click", function(e){
    			
    			e.preventDefault();
    			
    		    $("#frm").attr({method :"post", action :"/admin/system/sms/getReqAdminSmsList.do"}).submit();    			
    			
    		});
    		
    		
    		$(".sendErrorDiv").each(function(){
    			
    			sendErrorArr.push(this);
    			
    			$(this).hide();
    			sendErrorCnt = sendErrorCnt+1;
    			
    		})
    		
    		if(sendErrorCnt > 0){
    			
    			$("#sendErrorTag").append("<button type='button' onclick='openPopUp()' style='color: blue;'>전송오류 건</button>");
    			
    		}else{
    			
    			$("#sendErrorTag").hide();
    			
    		}
    		
    	})
    	
    	var openWin;
    	var sendErrorCnt = 0;
    	var sendErrorArr = [];
    	
    	function openPopUp(){
    		
    		window.name = "parentForm";
    		
    		openWin = window.open("/common/pop/getReqAdminDtlPop.do","childForm","width=400, height=600, resizable=no, scrollbars = yes");
    		
    		
    	}
    	
    	function pushData(){
    		
    		if(sendErrorCnt > 0 ){
    			
	    		for(var i =0; i <sendErrorArr.length; i++){
	    			
	    			$(sendErrorArr[i]).show();
	    			
	    			openWin.document.getElementById("sendErrorTag").appendChild(sendErrorArr[i]);
	    		
	    		};
    		
    		}
    		
    	}
    	
    </script>
</body>
</html>
