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
<!-- daumeditor -->
<!-- 다음에디터 추가 start  -->
<script type="text/javascript" src="<c:url value='/daumeditor/js/editor_loader.js?environment=production'/>" charset="utf-8"></script>
<link type="text/css" rel="stylesheet" href="<c:url value='/daumeditor/css/editor.css'/>"/>
<script type="text/javascript">
	<%-- 현재 메뉴의 값을 절대적으로 표시하야 함. --%> var currentPageName = "mobilesurvey";
</script>
<!-- 다음에디터 추가 end  -->
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
						<div class="tabWrap type3">
							<ul class="tabBox">
								<li class="tab on"><button type="button">내역</button></li>
								<c:if test="${surveyView.qustnrSeq>0}">
									<li class="tab"><button type="button">결과</button></li>
								</c:if>
							</ul>
							<div class="tabCon on">
								<form id="tx_editor_form" name="tx_editor_form" method="post" accept-charset="utf-8" onsubmit="return false;">
									<input type="hidden" id="mode" name="mode" value="${surveyView.mode}" />
									<input type="hidden" id="qustnrSeq" name="qustnrSeq" value="${surveyView.qustnrSeq}" />
									<input type="hidden" id="etcYn" name="etcYn" value="" />
									<input type="hidden" id="qustnrItemID" name="qustnrItemID" value="" />
									<fieldset>
										<legend>모바일설문작성</legend>
										<table class="tb_type02 mt20">
											<colgroup>
												<col style="width:25%" />
												<col style="width:75%" />
											</colgroup>
											<tbody>
												<tr>
													<th class="top">제목</th>
													<td class="top">
														<c:choose>
															<c:when test="${fn:length(surveyView.qustnrTitle)>0}">
																<span class="input-text05"><input id="qustnrTitle" name="qustnrTitle" type="text" value="${surveyView.qustnrTitle}" maxlength="100"></span>
															</c:when>
															<c:otherwise>
																<span class="pholder input-text05"><label for="qustnrTitle">100자이내</label><input id="qustnrTitle" name="qustnrTitle" type="text" maxlength="100"></span>
															</c:otherwise>
														</c:choose>
													</td>
												</tr>
												<tr>
													<th>설문시작일</th>
													<td>
														<fmt:formatDate value="${surveyView.qustnrStrDttm}" pattern="yyyy-MM-dd" var="qustnrStrDttm"/>
														<span class="selectDate input-datepick02"><input id="qustnrStrDttm" name="qustnrStrDttm" type="text" class="datepicker input-datepick02" title="선택 날짜" value="${qustnrStrDttm}" readonly="true"/></span>
													</td>
												</tr>
												<tr>
													<th>설문종료일</th>
													<td>
														<fmt:formatDate value="${surveyView.qustnrEndDttm}" pattern="yyyy-MM-dd" var="qustnrEndDttm"/>
														<span class="selectDate input-datepick02"><input id="qustnrEndDttm" name="qustnrEndDttm" type="text" class="datepicker input-datepick02" title="선택 날짜" value="${qustnrEndDttm}" readonly="true"/></span>
													</td>
												</tr>
												<%-- <tr>
													<th>비고</th>
													<td>
														<span class="input-text05">
                                                            <textarea style="width: 510px" rows="10" cols="68" id="qustnrWritngGuideContent" name="qustnrWritngGuideContent" >${surveyView.qustnrWritngGuideContent}</textarea>
                                                        </span>
													</td>
												</tr> --%>
												<!-- 다음에디터 추가 start  -->
												<tr class="editorLine">
													<th><span>비고</span></th>
													<td class="editor">
														<!--daum editor S-->
														<tiles:insertAttribute name="daum_editor"/>
														<div style="display:none;"><textarea id="bor_HTML_content" name="content"></textarea></div>
														<!--daum editor E-->
													</td>
												</tr>
												<!-- 다음에디터 추가 end  -->
											</tbody>
										</table>
										
										<div id="questions" class="questionBoxWrap">
										
											<c:if test="${fn:length(surveyView.surveyQestVO) > 0 }">
												<c:forEach items="${surveyView.surveyQestVO}" var="surveyQestList" varStatus="status">
													<div id="question_${status.index}" class="questionBox">
														<input type="hidden" id="surveyQestVO[${status.index}].flag" name="surveyQestVO[${status.index}].flag" value="true" />
														<input type="hidden" id="con" name="con" value="${status.index}" />
														<input type="hidden" id="surveyQestVO[${status.index}].action" name="surveyQestVO[${status.index}].action" value="update" />
														<input type="hidden" id="surveyQestVO[${status.index}].qustnrSeq" name="surveyQestVO[${status.index}].qustnrSeq" value="${surveyQestList.qustnrSeq}" />
														<input type="hidden" id="surveyQestVO[${status.index}].qustnrQesitmID" name="surveyQestVO[${status.index}].qustnrQesitmID" value="${surveyQestList.qustnrQesitmID}" />
														<input type="hidden" id="surveyQestVO[${status.index}].qestnOrd" name="surveyQestVO[${status.index}].qestnOrd" value="${surveyQestList.qestnOrd}" />
														<div class="btn_delQ"><button class="btnType04" onclick="survey.delQuestion(${status.index}); return false;"><img src="/images/btn_delQ.png" alt="질문 ${status.index}삭제" /></button></div>
														<div class="layTbWrap">
															<table class="layTb">
																<colgroup>
																	<col style="width:120px"/>
																	<col style="width:90%"/>
																
																</colgroup>
																<tbody>
																	<tr>
																		<td>질문 <c:out value="${status.count}" /></td>
																		<td><span class="pholder input-text20"><label for="surveyQestVO[${status.index}].qestnContent"></label><input id="surveyQestVO[${status.index}].qestnContent" name="surveyQestVO[${status.index}].qestnContent" type="text" value="${surveyQestList.qestnContent}" /></span></td>
																	</tr>
																	<tr>
																		<td>답변</td>
																		<td>
																			<table class="tb_type01 addSt">
																				<colgroup>
																					<col style="width:20px"/>
																					<col style="width:83%"/>
																					<col style="width:20px"/>
																				</colgroup>
																				<thead>
																					<tr>
																						<th>NO</th>
																						<th class="sd">답변</th>
																						<th class="last"><button class="fullBtn" onclick="survey.addItem(${status.index}); return false;"><img src="/images/btn_addAnswer.png" alt="" /></button></th>
																					</tr>
																				</thead>
																				<tbody id="question${status.index}item">
																					<c:if test="${fn:length(surveyQestList.surveyQestItemVO) > 0 }">
																						<c:forEach items="${surveyQestList.surveyQestItemVO}" var="surveyQestItemList" varStatus="statusItem">
																							<tr id="question_${status.index}_item_${statusItem.index}">
																								<td><c:out value="${statusItem.count}" /></td>
																								<td class="sd"><span class="input-text21">
																									<input id="surveyQestVO[${status.index}].surveyQestItemVO[${statusItem.index}].itemContent" name="surveyQestVO[${status.index}].surveyQestItemVO[${statusItem.index}].itemContent" type="text" value="${surveyQestItemList.itemContent}" maxlength="500" />
																									<input type="hidden" id="surveyQestVO[${status.index}].surveyQestItemVO[${statusItem.index}].flag" name="surveyQestVO[${status.index}].surveyQestItemVO[${statusItem.index}].flag" value="true" />
																									<input type="hidden" id="surveyQestVO[${status.index}].surveyQestItemVO[${statusItem.index}].action" name="surveyQestVO[${status.index}].surveyQestItemVO[${statusItem.index}].action" value="update" />
																									<input type="hidden" id="surveyQestVO[${status.index}].surveyQestItemVO[${statusItem.index}].qustnrSeq" name="surveyQestVO[${status.index}].surveyQestItemVO[${statusItem.index}].qustnrSeq" value="${surveyQestItemList.qustnrSeq}" />
																									<input type="hidden" id="surveyQestVO[${status.index}].surveyQestItemVO[${statusItem.index}].qustnrQesitmID" name="surveyQestVO[${status.index}].surveyQestItemVO[${statusItem.index}].qustnrQesitmID" value="${surveyQestItemList.qustnrQesitmID}" />
																									<input type="hidden" id="surveyQestVO[${status.index}].surveyQestItemVO[${statusItem.index}].qustnrItemID" name="surveyQestVO[${status.index}].surveyQestItemVO[${statusItem.index}].qustnrItemID" value="${surveyQestItemList.qustnrItemID}" />
																									<input type="hidden" id="surveyQestVO[${status.index}].surveyQestItemVO[${statusItem.index}].itemOrd" name="surveyQestVO[${status.index}].surveyQestItemVO[${statusItem.index}].itemOrd" value="${surveyQestItemList.itemOrd}" />
																								</span></td>
																								<td class="last"><button class="fullBtn" onclick="survey.delItem(${status.index},${statusItem.index}); return false;"><img src="/images/btn_delAnswer.png" alt="" /></button></td>
																							</tr>
																						</c:forEach>
																					</c:if>
																				</tbody>
																			</table>
																		</td>
																	</tr>
																	<tr>
																		<td>기타의견 여부<br>(선택시 사용 ) </td>
																			<td>
																				<c:if test="${surveyQestList.etcYn eq 'Y' }">
																					<span class="pwtableblock input-ck02"><input type="checkbox" id="etcYnChk" name="etcYnChk" checked="checked" value="${status.index}"/><label for="premiumSeason">&nbsp;&nbsp;기타의견 등록</label></span>
																				</c:if>
																				<c:if test="${surveyQestList.etcYn eq 'N' || surveyQestList.etcYn eq null || surveyQestList.etcYn eq ''}">
																					<span class="pwtableblock input-ck02"><input type="checkbox" id="etcYnChk" name="etcYnChk" value="${status.index}"/><label for="premiumSeason">&nbsp;&nbsp;기타의견 등록</label></span>
																				</c:if>
																			</td>
																		</tr>
																</tbody>
															</table>
														</div>
													</div>
												</c:forEach>
											</c:if>
										</div>	
										
										<div class="btn_addQ">
											<button class="btnType03" onclick="survey.addSurvey(); return false;"><img src="/images/btn_addQ.png" alt="설문추가하기" /></button>
										</div>
										<div class="btnArea">
											<span class="left"><button class="btnType01 bc_gray" onclick="location.href='/admin/customer/survey/surveyList.do?currentPageNo=<c:out value="${surveyView.currentPageNo}"/><c:out value="${parameterInfo}" escapeXml="false"/>';">목록</button></span>
											<span class="right">
												<c:if test="${surveyView.qustnrSeq>0}">
													<button class="btnType01" onclick="deleteContent('<c:out value="${surveyView.qustnrSeq}"/>');">삭제</button>
												</c:if>
												<button class="btnType01 bc_green" onclick="return saveContent();">등록</button>
											</span>	
										</div>
									</fieldset>
								</form>
							</div>
							<div class="tabCon">
								<%--<form action="demo">--%>
									<fieldset>
										<legend>모바일설문 결과 </legend>
										<div class="answerBoxWrap">
										
								<c:set var="currentQustnrQesitmID" value="" />
								<c:forEach items="${surveyResultList}" var="surveyResultQustList" varStatus="status">
									<c:choose>
										<c:when test="${currentQustnrQesitmID ne surveyResultQustList.qustnrQesitmID}">
											<div class="answerBox mt20">
												<div class="layTbWrap">
													<table class="layTb">
														<colgroup>
															<col style="width:60px"/>
															<col style="width:90%"/>
														</colgroup>
														<tbody>
															<tr>
																<td>질문 <c:out value="${surveyResultQustList.qestnOrd}" /></td>
																<td><c:out value="${surveyResultQustList.qestnContent}" /></td>
															</tr>
															<tr>
																<td>답변</td>
																<td>
																	<table class="tb_type01">
																		<colgroup>
																			<col style="width:30px"/>
																			<col style="width:58%"/>
																			<col style="width:40px"/>
																			<col style="width:40px"/>
																		</colgroup>
																		<thead>
																			<tr>
																				<th>NO</th>
																				<th>답변</th>
																				<th>선택수</th>
																				<th>%</th>
																			</tr>
																		</thead>
																		<tbody>
																	<c:forEach items="${surveyResultList}" var="surveyResultItemList" varStatus="status">
																		<c:if test="${surveyResultQustList.qustnrQesitmID eq surveyResultItemList.qustnrQesitmID}">
																			
																			<tr>
																			
																				<td><c:out value="${surveyResultItemList.itemOrd}" /> </td>
																				<td>
																					<c:if test="${surveyResultItemList.etcChk eq 'Y' }">
																						<a href="#" onClick="detailPop('${surveyResultItemList.qustnrItemID}'); return false">${surveyResultItemList.itemContent}</a>
																					</c:if>
																					<c:if test="${surveyResultItemList.etcChk != 'Y' }">
																						${surveyResultItemList.itemContent}
																					</c:if>
																				</td>
																				<td><c:out value="${surveyResultItemList.qustnrItemIDCount}" /></td>
																				<td><c:out value="${surveyResultItemList.percentQuantity}" /></td>
																			</tr>
																		</c:if>
																	</c:forEach>
																		</tbody>
																	</table>
																</td>
															</tr>
														</tbody>
													</table>
												</div>
											</div>
											<c:set var="currentQustnrQesitmID" value="${surveyResultQustList.qustnrQesitmID}" />
										</c:when>
										<c:otherwise>
											<c:set var="currentQustnrQesitmID" value="${surveyResultQustList.qustnrQesitmID}" />
										</c:otherwise>
									</c:choose>
								</c:forEach>
										
										</div>
										<div class="btnArea">
											<span class="left"><button class="btnType01 bc_gray" onclick="location.href='/admin/customer/survey/surveyList.do?currentPageNo=<c:out value="${surveyView.currentPageNo}"/><c:out value="${parameterInfo}" escapeXml="false"/>';">목록</button></span>
											<span class="right"><button class="btnType01 mb10 mhid" onclick="location.href='/admin/customer/survey/surveyEdit.do?mode=excel&qustnrSeq=<c:out value="${surveyView.qustnrSeq}"/><c:out value="${parameterInfo}" escapeXml="false"/>';">엑셀</button></span>
<!-- 											<span class="right"><button class="btnType01 mb10 mhid" id="excelBtn">엑셀</button></span> -->
										</div>
									</fieldset>
								<%--</form>--%>
							</div>
						</div>
					</div>
				</div>
				<!--content E-->
			</div>
		</div>
		
		<script type="text/javascript">
		/* 자바 스크립트 2차 배열 선언 */
		var surArray = new Array();
		var _questionCount = <c:out value="${fn:length(surveyView.surveyQestVO)}"/>;	// 모바일설문.질문 번호
		var _itemCount = 0;		// 모바일설문.질문.답변 번호
		</script>
		
		<script type="text/javascript">
		var chk = "";
		var survey = {};
		survey.addSurvey =  function addSurvey(){
			var nextCountValue = _questionCount;
			var surveyAdd = '<div id="question_' + nextCountValue + '" class="questionBox">' +
							'<input type="hidden" id="surveyQestVO[' + nextCountValue + '].flag" name="surveyQestVO[' + nextCountValue + '].flag" value="true" />' +
							'<input type="hidden" id="surveyQestVO[' + nextCountValue + '].action" name="surveyQestVO[' + nextCountValue + '].action" value="insert" />' +
							'<input type="hidden" id="surveyQestVO[' + nextCountValue + '].qustnrSeq" name="surveyQestVO[' + nextCountValue + '].qustnrSeq" value="" />' +
							'<input type="hidden" id="surveyQestVO[' + nextCountValue + '].qustnrQesitmID" name="surveyQestVO[' + nextCountValue + '].qustnrQesitmID" value="" />' +
							'<input type="hidden" id="surveyQestVO[' + nextCountValue + '].qestnrOrd" name="surveyQestVO[' + nextCountValue + '].qestnrOrd" value="" />' +
							'<div class="btn_delQ"><button class="btnType04" onclick="survey.delQuestion(\'' + nextCountValue + '\'); return false;"><img src="/images/btn_delQ.png" alt="" /></button></div>' +
							'<div class="layTbWrap">' +
								'<table class="layTb">' +
									'<colgroup>' +
										'<col style="width:120px"/>' +
										'<col style="width:90%"/>' +
									'</colgroup>' +
									'<tbody>' +
										'<tr>' +
											'<td>질문 ' + (nextCountValue+1) + ' </td>' +
											'<td><span class="pholder input-text20"><label for="surveyQestVO[' + nextCountValue + '].qestnContent" ></label><input id="surveyQestVO[' + nextCountValue + '].qestnContent" name="surveyQestVO[' + nextCountValue + '].qestnContent" type="text" value="" /></span></td>' +
										'</tr>' +
										'<tr>' +
											'<td>답변</td>' +
											'<td>' +
												'<table class="tb_type01 addSt">' +
													'<colgroup>' +
														'<col style="width:20px"/>' +
														'<col style="width:83%"/>' +
														'<col style="width:20px"/>' +
													'</colgroup>' +
													'<thead>' +
														'<tr>' +
															'<th>NO</th>' +
															'<th class="sd">답변</th>' +
															'<th class="last"><button class="fullBtn" onclick="survey.addItem(' + nextCountValue + '); return false;"><img src="/images/btn_addAnswer.png" alt="" /></button></th>' +
														'</tr>' +
													'</thead>' +
													'<tbody id="question' + nextCountValue + 'item">' +
														'<tr id="question_' + nextCountValue + '_item_' + _itemCount + '">' +
															'<td>1</td>' +
															'<td class="sd">' +
															'<span class="pholder input-text21"><label for="surveyQestVO[' + nextCountValue + '].surveyQestItemVO[' + _itemCount + '].itemContent">500자이내</label>' +
																'<input id="surveyQestVO[' + nextCountValue + '].surveyQestItemVO[' + _itemCount + '].itemContent" name="surveyQestVO[' + nextCountValue + '].surveyQestItemVO[' + _itemCount + '].itemContent" type="text" value="" maxlength="500" />' +
																'<input type="hidden" id="surveyQestVO[' + nextCountValue + '].surveyQestItemVO[' + _itemCount + '].flag" name="surveyQestVO[' + nextCountValue+ '].surveyQestItemVO[' + _itemCount + '].flag" value="true" />' +
																'<input type="hidden" id="surveyQestVO[' + nextCountValue + '].surveyQestItemVO[' + _itemCount + '].action" name="surveyQestVO[' + nextCountValue+ '].surveyQestItemVO[' + _itemCount + '].action" value="insert" />' +
																'<input type="hidden" id="surveyQestVO[' + nextCountValue + '].surveyQestItemVO[' + _itemCount + '].qustnrSeq" name="surveyQestVO[' + nextCountValue+ '].surveyQestItemVO[' + _itemCount + '].qustnrSeq" value="" />' +
																'<input type="hidden" id="surveyQestVO[' + nextCountValue + '].surveyQestItemVO[' + _itemCount + '].qustnrQesitmID" name="surveyQestVO[' + nextCountValue+ '].surveyQestItemVO[' + _itemCount + '].qustnrQesitmID" value="" />' +
																'<input type="hidden" id="surveyQestVO[' + nextCountValue + '].surveyQestItemVO[' + _itemCount + '].qustnrItemID" name="surveyQestVO[' + nextCountValue+ '].surveyQestItemVO[' + _itemCount + '].qustnrItemID" value="" />' +
																'<input type="hidden" id="surveyQestVO[' + nextCountValue + '].surveyQestItemVO[' + _itemCount + '].itemOrd" name="surveyQestVO[' + nextCountValue+ '].surveyQestItemVO[' + _itemCount + '].itemOrd" value="" />' +
															'</span></td>' +
															'<td class="last"><button class="fullBtn" onclick="survey.delItem(' + nextCountValue + ',' + _itemCount + '); return false;"><img src="/images/btn_delAnswer.png" alt="" /></button></td>' +
														'</tr>' +
													'</tbody>' +
												'</table>' +
											'</td>' +
										'</tr>' +
										'<tr>' +
										'<td>기타의견 여부<br>(선택시 사용 ) </td>' +
											'<td>' +
												'<span class="pwtableblock input-ck02"><input type="checkbox" id="etcYnChk" name="etcYnChk" value="' + nextCountValue + '"/><label for="premiumSeason">&nbsp;&nbsp;기타의견 등록</label></span>' +
											'</td>' +
										'</tr>' +
									'</tbody>' +
								'</table>' +
							'</div>' +
						'</div>';
			$("#questions").append(surveyAdd);
			surArray[_questionCount] = _itemCount;	// 현재 항목 번호 저장
			++_questionCount;	// 다음 질문 등록 번호 저장
			return false;
		}
		survey.delQuestion = function delQuestion(target){
			$("#question_"+target).remove();
			return false;
		}
		survey.addItem =  function addItem(target){
			var currentQuestion = target;
			if(isNaN(surArray[currentQuestion])){surArray[currentQuestion]=-1;}
			var currentItem = ++surArray[currentQuestion];
			var itemAdd =	'<tr id="question_' + currentQuestion + '_item_' + currentItem + '">' +
							'<td>' + (currentItem+1) + '</td>' +
							'<td class="sd">' +
							'<span class="pholder input-text21"><label for="surveyQestVO[' + currentQuestion + '].surveyQestItemVO[' + currentItem + '].itemContent">500자이내</label>' +
								'<input id="surveyQestVO[' + currentQuestion + '].surveyQestItemVO[' + currentItem + '].itemContent" name="surveyQestVO[' + currentQuestion + '].surveyQestItemVO[' + currentItem + '].itemContent" type="text" value="" maxlength="500" />' +
								'<input type="hidden" id="surveyQestVO[' + currentQuestion + '].surveyQestItemVO[' + currentItem + '].flag" name="surveyQestVO[' + currentQuestion+ '].surveyQestItemVO[' + currentItem + '].flag" value="true" />' +
								'<input type="hidden" id="surveyQestVO[' + currentQuestion + '].surveyQestItemVO[' + currentItem + '].action" name="surveyQestVO[' + currentQuestion+ '].surveyQestItemVO[' + currentItem + '].action" value="insert" />' +
								'<input type="hidden" id="surveyQestVO[' + currentQuestion + '].surveyQestItemVO[' + currentItem + '].qustnrSeq" name="surveyQestVO[' + currentQuestion+ '].surveyQestItemVO[' + currentItem + '].qustnrSeq" value="" />' +
								'<input type="hidden" id="surveyQestVO[' + currentQuestion + '].surveyQestItemVO[' + currentItem + '].qustnrQesitmID" name="surveyQestVO[' + currentQuestion+ '].surveyQestItemVO[' + currentItem + '].qustnrQesitmID" value="" />' +
								'<input type="hidden" id="surveyQestVO[' + currentQuestion + '].surveyQestItemVO[' + currentItem + '].qustnrItemID" name="surveyQestVO[' + currentQuestion+ '].surveyQestItemVO[' + currentItem + '].qustnrItemID" value="" />' +
								'<input type="hidden" id="surveyQestVO[' + currentQuestion + '].surveyQestItemVO[' + currentItem + '].itemOrd" name="surveyQestVO[' + currentQuestion+ '].surveyQestItemVO[' + currentItem + '].itemOrd" value="" />' +
							'</span></td>' +
							'<td class="last"><button class="fullBtn" onclick="survey.delItem(' + currentQuestion + ',' + currentItem + ')"><img src="/images/btn_delAnswer.png" alt="" /></button></td>' +
						'</tr>';
			$("#question"+currentQuestion+"item").append(itemAdd);
			return false;
		}
		survey.delItem = function delItem(target,count){
			$("#question_"+target+"_item_"+count).remove();
			return false;
		}
		function deleteContent(qustnrSeq){
			if(confirm("삭제 하시겠습니까?")){
				location.href = "/admin/customer/survey/surveyDelete.do?mode=delete&qustnrSeq="+qustnrSeq;
			} else return false;
		}
		
		function saveContent() { 
			if(confirm("저장 하시겠습니까?")){
				Editor.save(); 
			}
		}
		
		
		function validForm(editor) {

			validations();
			
			if(chk == "N"){
				return false
			}else{
				if($.trim($("#qustnrTitle").val())==''){
					alert("제목을 입력해 주세요.");
					$("#qustnrTitle").focus();
					return false;
				}
				if($("#qustnrStrDttm").val()==''){
					alert("설문 시작일을 선택해 주세요.");
					$("#qustnrStrDttm").focus();
					return false;
				}
				if($("#qustnrEndDttm").val()==''){
					alert("설문 종료일을 선택해 주세요.");
					$("#qustnrEndDttm").focus();
					return false;
				}
				if($("#qustnrStrDttm").val()>$("#qustnrEndDttm").val()){
					alert("설문 시작일은 설문 종료일보다 빠를 수 없습니다.");
					return false;
				}
				
				/* 다음에디터 추가 start */
				/* 본문 내용이 입력되었는지 검사하는 부분 */
				var validator = new Trex.Validator();
				var content = editor.getContent();
				if(!validator.exists(content)) {
					alert("내용을 입력해 주세요.");
					return false;
				}
				/* 다음에디터 추가 end */
				
				if($.trim($("#qustnrWritngGuideContent").val()).length > 400){
					alert("내용을 400자 까지 입력해 주세요.");
					$("#qustnrWritngGuideContent").focus();
					return false;
				}
				
				var rentType = "";
		        $('[name="etcYnChk"]:checked').each(function(idx){
		        	if(idx == 0){
		        		rentType = rentType + $(this).val();
		        	}else{
		        		rentType = rentType + "," + $(this).val();
		        	}
		        });
		        $("#etcYn").val(rentType);
	
			    var mode = $("#tx_editor_form").children("#mode").val();
				if(mode=='insert'){
					$("#tx_editor_form").attr('action','/admin/customer/survey/surveyInsert.do');
				} else if(mode=='update'){
					$("#tx_editor_form").attr('action','/admin/customer/survey/surveyUpdate.do');
				} else {
					alert("모드 값이 설정되지 않았습니다.");
					return false;
				}
				document.getElementById("tx_editor_form").submit();
				return true;
			}
		}
		
		function validations(){
			var queryString = jQuery("#tx_editor_form").serialize();;
			
			$.ajax({
				url : "/admin/customer/survey/surveyChk.do",
				type : "post",
				dataType : "json",
				data : queryString,
				async : false,
				beforeSubmit: function (data,form,option) {
		            return true;
		        },
				success : function(data){
					if(data.resultMessage == "Success"){
						
						if(data.returnContent != "OK" || data.returnItemContent != "OK"){
							alert("등록되지 않는 질문 또는 답변을 입력해 주십시오.");
							chk = "N";
						}else{
							chk = "Y";
						}
					}
				},
				error : function(request, status,error){
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					if(request.status === 500 || request.status === 200){
					//	alert("에러가 발생했습니다. : " + textStatus);
					}
				   // lodBarCtl.close();
				}
			});
		}
		
		function detailPop(itemId){
			var top = 100;
			var left = 10;
			
			$("#qustnrItemID").val(itemId);
			window.open("/admin/customer/survey/etcPop.do?popqustnrItemID="+itemId ,"pop",  "toolbar=no, location=no, directory=no, scrollbars=yes, resizable=yes, top="+ top +", left="+ left +", width=500, height=300");
		}
		
		
		
		/* 다음에디터 추가 start */
		var config = {
				txHost: '', /* 런타임 시 리소스들을 로딩할 때 필요한 부분으로, 경로가 변경되면 이 부분 수정이 필요. ex) http://xxx.xxx.com */
				txPath: '', /* 런타임 시 리소스들을 로딩할 때 필요한 부분으로, 경로가 변경되면 이 부분 수정이 필요. ex) /xxx/xxx/ */
				txService: 'ntc', /* 수정필요없음. */
				txProject: 'ntc', /* 수정필요없음. 프로젝트가 여러개일 경우만 수정한다. */
				initializedId: "", /* 대부분의 경우에 빈문자열 */
				wrapper: "tx_trex_container", /* 에디터를 둘러싸고 있는 레이어 이름(에디터 컨테이너) */
				form: 'tx_editor_form'+"", /* 등록하기 위한 Form 이름 */
				txIconPath: "/daumeditor/images/icon/editor/", /*에디터에 사용되는 이미지 디렉터리, 필요에 따라 수정한다. */
				txDecoPath: "/daumeditor/images/deco/contents/", /*본문에 사용되는 이미지 디렉터리, 서비스에서 사용할 때는 완성된 컨텐츠로 배포되기 위해 절대경로로 수정한다. */
				canvas: {
		            exitEditor:{
		            	/* 
		                desc:'빠져 나오시려면 shift+b를 누르세요.',
		                hotKey: {
		                    shiftKey:true,
		                    keyCode:66
		                },
		                nextElement: document.getElementsByTagName('button')[0]
		                 */
		            },
					styles: {
						color: "#123456", /* 기본 글자색 */
						fontFamily: "굴림", /* 기본 글자체 */
						fontSize: "10pt", /* 기본 글자크기 */
						backgroundColor: "#fff", /*기본 배경색 */
						lineHeight: "1.5", /*기본 줄간격 */
						padding: "8px" /* 위지윅 영역의 여백 */
					},
					showGuideArea: false,
		            autolink: false
				},
				events: {
					preventUnload: false
				},
				sidebar: {
					attachbox: {
						show: true,
						confirmForDeleteAll: true
					}
				},
				size: {
					contentWidth: 700 /* 지정된 본문영역의 넓이가 있을 경우에 설정 */
				},
		        toolbar: {
		            codehighlight: {
		                styleSheetUrl: ["http://google-code-prettify.googlecode.com/svn/trunk/src/prettify.css"],
		                highlight: function(code){
		                    return prettyPrintOne(code);
		                }
		            },
		            paste: {
		                defaultMode: Trex.Paste.MODE_HTML
		            }
		        }
			};
			EditorJSLoader.ready(function(Editor) {
				var editor = new Editor(config);
			});
			
			
			function setForm(editor) {
				document.getElementById("bor_HTML_content").disabled=true;
		        var i, input;
		        var form = editor.getForm();
		        var qustnrWritngGuideContent = editor.getContent();
		        var textarea = document.createElement('textarea');
		        textarea.name = 'qustnrWritngGuideContent';
		        textarea.value = qustnrWritngGuideContent;

		        if(document.getElementsByName("qustnrWritngGuideContent").length == 0){
			        form.createField(textarea);
		        }
		        
		        $('[name="qustnrWritngGuideContent"]').attr('style', 'display:none');
		        var images = editor.getAttachments('image');
		        for (i = 0; i < images.length; i++) {
		            if (images[i].existStage) {
		                /* alert('attachment information - image[' + i + '] \r\n' + JSON.stringify(images[i].data)); */
		                input = document.createElement('input');
		                input.type = 'hidden';
		                input.name = 'attach_image_info';
		                input.value = JSON.stringify(images[i].data);
		                form.createField(input);
		            }
		        }
		        /* 
		        var files = editor.getAttachments('file');
		        for (i = 0; i < files.length; i++) {
		            input = document.createElement('input');
		            input.type = 'hidden';
		            input.name = 'attach_file';
		            input.value = files[i].data.attachurl;
		            form.createField(input);
		        }
		         */
		        return true;
			}
			
			/* 다음에디터 추가 end */
		</script>
		
		<script type="text/javascript">
			var previousValue;
			$("input").on('focus',function(){
				previous = this.value;
			}).change(function(){
				var sDate = $("#qustnrStrDttm").val();
				var eDate = $("#qustnrEndDttm").val();
				if(sDate!=''&&eDate!=''&&sDate>eDate){
					alert("공지 종료일이 시작일보다 빠를 수 없습니다.");
					$(this).val(previous);
				}
			});
		</script>
		
		<script type="text/javascript">
			$(document).ready(function(){
				/* 에러 메시지  */
				var alertValue = "<c:out value='${resultError.errorMessage}'/>";
				if(alertValue!=""){ alert(alertValue); }
				
				/* 다음에디터 추가 start */
				/* 이미지 */
				var attachments = {};
				attachments['image'] = [];
				<c:if test="${fn:length(daumEditorImageList) > 0 }">
					<c:forEach items="${daumEditorImageList}" var="daumEditorVO" varStatus="status">
						attachments['image'].push({
							'attacher': 'image',
							'data': {
								'imageurl': '<c:out value="${daumEditorVO.imgURL}"/>',
								'filename': '<c:out value="${daumEditorVO.imgName}"/>',
								'filesize': <c:out value="${daumEditorVO.imgSize}"/>,
								'originalurl': '<c:out value="${daumEditorVO.imgURL}"/>'
								/* ,'thumburl': '<c:out value="${daumEditorVO.thumbnailImgURL}"/>' */
							}
						});
					</c:forEach>
				</c:if>
				/* 내용 */
				Editor.modify({
					"attachments": function () { /* 저장된 첨부가 있을 경우 배열로 넘김, 위의 부분을 수정하고 아래 부분은 수정없이 사용 */
						var allattachments = [];
						for (var i in attachments) { allattachments = allattachments.concat(attachments[i]); }
						return allattachments;
					}(),
					"content": document.getElementById("bor_TEXT_content").value
				});
				/* 다음에디터 추가 end */
			
				/* 초기값 */
				<c:if test="${fn:length(surveyView.surveyQestVO) > 0 }">
					<c:forEach items="${surveyView.surveyQestVO}" var="surveyQestList" varStatus="status">
						<c:if test="${fn:length(surveyQestList.surveyQestItemVO) > 0 }">
								<c:forEach items="${surveyQestList.surveyQestItemVO}" var="surveyQestItemList" varStatus="statusItem">
									surArray[<c:out value="${status.index}" />] = <c:out value="${statusItem.index}" />;
								</c:forEach>
						</c:if>
					</c:forEach>
				</c:if>
				/* 초기값 */
				/* 초기 입력 폼 */
				survey.addSurvey(_questionCount);	// 생성
			});
		</script>
		<!-- 다음에디터 추가 start  -->
		<div style="display:none;">
			<textarea id="bor_TEXT_content"><c:out value="${surveyView.qustnrWritngGuideContent}"/></textarea>
		</div>
		<!-- 다음에디터 추가 end  -->
		
		<!--footer S-->
			<tiles:insertAttribute name="footer" />
		<!--footer E-->
	</div>
</body>
</html>

