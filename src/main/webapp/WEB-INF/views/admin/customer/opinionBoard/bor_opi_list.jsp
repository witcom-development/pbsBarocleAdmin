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

<script type="text/javaScript" >
	$(document).ready(function(){
		/* 에러 메시지  */
		var alertValue = "<c:out value='${resultError.errorMessage}'/>";
		if(alertValue!=""){ alert(alertValue); }
	});
	function linkPage(pageNo){ location.href = "/admin/customer/opinionBoard/opinionBoardList.do?currentPageNo="+pageNo+"<c:out value='${parameterInfo}' escapeXml='false'/>"; }

	function fn_MemberDetail(seq){
		$("#usr_seq").val(seq);
		$("#frm").attr("action", "/admin/service/member/memberInfo.do");
		$("#frm").attr("method","post");
		$("#frm").attr("target","_blank");
		$("#frm").submit();
	}
	
</script>
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
						<div class="shBox">
							<form id="frm" name="frm" accept-charset="utf-8">
								<fieldset>
									<legend>검색조건</legend>
									<div class="shBoxSection">
										<div class="section">
											<label for="sDate" class="laType02">등록일</label>
											<span class="selectDate input-datepick04">
											<input id="sDate" name="searchStartDate" type="text" class="datepicker input-datepick04" title="선택 날짜" readonly="true" value="${opinionBoardView.searchStartDate}" /></span>
											<span class="dash">~</span>
											<span class="selectDate input-datepick04">
											<input id="eDate" name="searchEndDate" type="text" class="datepicker input-datepick04" title="선택 날짜" readonly="true" value="${opinionBoardView.searchEndDate}" /></span>
										</div>
										<div class="section repos pright">
											<label for="a2" class="laType02">답변결과</label>
											<span>
												<span class="input-rd01"><input type="radio" id="a2" name="qnaProcessStusCD" value="A" <c:if test="${opinionBoardView.qnaProcessStusCD!='P|D'}">checked="checked"</c:if>/><label for="a2">전체</label></span>
												<span class="input-rd01"><input type="radio" id="a3" name="qnaProcessStusCD" value="P" <c:if test="${opinionBoardView.qnaProcessStusCD=='P'}">checked="checked"</c:if>/><label for="a3">처리중</label></span>
												<span class="input-rd01"><input type="radio" id="a4" name="qnaProcessStusCD" value="D" <c:if test="${opinionBoardView.qnaProcessStusCD=='D'}">checked="checked"</c:if>/><label for="a4">답변완료</label></span>
											</span>
										</div>
										<div class="section">
											<label for="searchValue" class="laType02" style="margin-left: 10px;">제목</label>
											<span class="input-text07" style="margin-left: -10px;"><input id="searchValue" name="searchValue" type="text" style="width: 223px;" class="input-text07" value="${opinionBoardView.searchValue}" maxLength="32"/></span>
											
										</div>
										<div class="section">
                                            <label for="gubun" style="margin-left: 40px;">구분</label>
                                            <select class="select-category04" id="comCd" name="comCd"  style="margin-left: 20px; width: 220px;">
													<option value="">선택</option>
													<c:forEach items="${gubun }" var="gubun">
														<option value="${gubun.comCd }" <c:if test="${gubun.comCd eq opinionBoardView.comCd}">selected="true"</c:if>>${gubun.cdDesc1 }</option>
													</c:forEach>
												</select>
                                            <button class="btn-srh03 btncase1" onclick="checkSubmit();"><img src="/images/searchIcon.gif" alt="검색" /></button>
                                        </div>
									</div>
								</fieldset>
						</div>
						<!--검색조건 E-->
						<p class="tb_numlist">총 <c:out value="${opinionBoardView.totalRecordCount}"/>건</p>
						<table class="tb_type01">
							<colgroup>
								<col style="width:30%" />
								<col style="width:10%" />
								<col style="width:8%" />
								<col style="width:8%" />
								<col style="width:10%" />
								<col style="width:8%" />
								<col style="width:9%" />
								<col style="width:5%" />
								<col style="width:8%" />
								<col style="width:5%" />
							</colgroup>
							<thead>
								<tr>
									<th>제목</th>
									<th>작성자</th>
									<th>등록일</th>
									<th>공개여부</th>
									<th>담당자</th>
									<th>답변일</th>
									<th>답변결과</th>
									<th>답변기간</th>
									<th>답변기한</th>
									<th>남은기간</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${fn:length(opinionBoardList) > 0 }">
										<c:forEach items="${opinionBoardList}" var="opinionBoardVO" varStatus="status">
											<tr>
												<td class="title">
												<a href="/admin/customer/opinionBoard/opinionBoardEdit.do?mode=edit&qnaSeq=<c:out value='${opinionBoardVO.qnaSeq}'/>
												<c:if test="${opinionBoardView.currentPageNo!=0}">&currentPageNo=<c:out value='${opinionBoardView.currentPageNo}'/></c:if><c:out value='${parameterInfo}' escapeXml='false'/>"><c:out value="${opinionBoardVO.qestnTitle}"/></a></td>
												<td class="tc">
														<a href="#" onclick="fn_MemberDetail('${opinionBoardVO.wrterID}'); return false;">
															<c:out value="${opinionBoardVO.usr_regID}"/>
														</a>	
												</td>
												<td class="tc">
												    <fmt:parseDate var="usr_regDttm" value="${opinionBoardVO.usr_regDttm }" pattern="yyyy-MM-ddHH:mm:ss" />
													<fmt:formatDate value="${usr_regDttm}" pattern="MM-dd"/>
													<%-- <fmt:formatDate value="${opinionBoardVO.usr_regDttm}" pattern="MM-dd"/> --%>
												</td>
												<td class="tc">
													<c:choose>
														<c:when test="${opinionBoardVO.secretYn eq 'Y'}">
															비공개
														</c:when>
														<c:otherwise>
															공개
														</c:otherwise>
													</c:choose>
												</td>
												<td class="tc">
													<c:choose>
														<c:when test="${opinionBoardVO.adminId==null || opinionBoardVO.adminId== ''}">
															<%-- <a href="#" onclick="fn_chooseAdmin(${opinionBoardVO.qnaSeq}); return false;">미지정</a> --%>
															<a href="/common/pop/adminSchPop.do" class="winNewPop modal"  title="담당자 조회" data-width="440" data-height="455" data-pmt="&usrGrpCd=001&qnaSeq=<c:out value='${opinionBoardVO.qnaSeq}'/>">미지정</a>
														</c:when>
														
														<c:when test="${userSessionVO.usrGrpCd == '12'}">
															<a href="/common/pop/adminSchPop.do" class="winNewPop modal"  title="담당자 조회" data-width="440" data-height="455" data-pmt="&usrGrpCd=001&qnaSeq=<c:out value='${opinionBoardVO.qnaSeq}'/>"><c:out value="${opinionBoardVO.adminId}"/></a>
														</c:when>
														<c:when test="${userSessionVO.usrGrpCd == '15'}">
															<a href="/common/pop/adminSchPop.do" class="winNewPop modal"  title="담당자 조회" data-width="440" data-height="455" data-pmt="&usrGrpCd=001&qnaSeq=<c:out value='${opinionBoardVO.qnaSeq}'/>"><c:out value="${opinionBoardVO.adminId}"/></a>
														</c:when>
														
														<c:otherwise>
															<c:out value="${opinionBoardVO.adminId}"/>
														</c:otherwise>
													</c:choose>
												</td>
												<td class="tc">
													<c:choose>
														<c:when test="${opinionBoardVO.qnaProcessStusCD=='D'}">
															<%-- <fmt:formatDate value="${opinionBoardVO.modDttm}" pattern="MM-dd"/> --%>
															<fmt:parseDate var="modDttm" value="${opinionBoardVO.modDttm}" pattern="yyyy-MM-ddHH:mm:ss" />
															<fmt:formatDate value="${modDttm}" pattern="MM-dd"/>
														</c:when>
														<c:otherwise></c:otherwise>
													</c:choose>
												</td>
												<td class="tc">
													<c:choose>
														<c:when test="${opinionBoardVO.qnaProcessStusCD=='D'}">답변완료</c:when>
														<c:otherwise>처리중</c:otherwise>
													</c:choose>
												</td>
												<td class="tc">
													<c:choose>
														<c:when test="${opinionBoardVO.deadline == null || opinionBoardVO.deadline == ''}">
															<%-- <a href="#" onclick="fn_chooseAdmin(${opinionBoardVO.qnaSeq}); return false;"></a> --%>
															<a href="/common/pop/deadlineSchPop.do" class="winNewPop modal"  title="답변기한" data-width="440" data-height="455" data-pmt="&qnaSeq=<c:out value='${opinionBoardVO.qnaSeq}'/>">7일</a>
														</c:when>
														<c:otherwise>
															<c:out value="${opinionBoardVO.deadline}"/>
														</c:otherwise>
													</c:choose>
												</td>
												<td class="tc">
													<%-- <fmt:formatDate value="${opinionBoardVO.deadline_Date}" pattern="MM-dd"/> --%>
													<fmt:parseDate var="deadline_Date" value="${opinionBoardVO.deadline_Date}" pattern="yyyy-MM-ddHH:mm:ss" />
													<fmt:formatDate value="${deadline_Date}" pattern="MM-dd"/></td>
												</td>
												<td class="tc">
												<jsp:useBean id="today" class="java.util.Date" />
												<fmt:formatDate var="now" value="${today}" pattern="yyyyMMdd" />
												<fmt:parseDate var="deadline_Date" value="${opinionBoardVO.deadline_Date}" pattern="yyyy-MM-ddHH:mm:ss" />
												<fmt:formatDate var="deadline_Date" value="${deadline_Date}" pattern="yyyyMMdd" />
													<c:choose>
														<c:when test="${opinionBoardVO.qnaProcessStusCD=='D'}"></c:when>
														<c:when test="${deadline_Date - now le 0}">
															<font color="red">${now - deadline_Date}일</font>
														</c:when>
														<c:otherwise>
															${deadline_Date - now}일
														</c:otherwise>
													</c:choose> 
												</td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td class="tc" colspan="6"><spring:message code="search.nodata.msg" /></td>
										</tr>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					<c:choose>
						<c:when test="${fn:length(opinionBoardList) > 0}">
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
						
						<!--20191111 회원정보 팝업 -->
						<input type="hidden" name="usr_seq"	id="usr_seq">

						</form>
					</div>
				</div>
				
				
				
		<div id="frogue-container" class="position-right-bottom"
              data-chatbot="be43e811-a4e0-4e6e-a400-27b72c0f31b9"
              data-user="사용자ID"
              data-init-key="value"
              ></div>
        <!-- data-init-식별키=값 으로 셋팅하면 챗플로우에 파라미터와 연동가능. 식별키는 소문자만 가능 -->
        <script>
        (function(d, s, id){
            var js, fjs = d.getElementsByTagName(s)[0];
            if (d.getElementById(id)) {return;}
            js = d.createElement(s); js.id = id;
            js.src = "https:\/\/danbee.ai/js/plugins/frogue-embed/frogue-embed.min.js";
            fjs.parentNode.insertBefore(js, fjs);
        }(document, 'script', 'frogue-embed'));
        </script>
				
				
				
				<!--content E-->
			</div>
		</div>
		
		
		
		<script type="text/javascript">
			$(function() {	
				var totalPageCount = '${paginationInfo.totalPageCount}' == '' ? 1 : Number('${paginationInfo.totalPageCount}');
		   		$('#prevPage').on("click",function(){
					var currentPageNo = Number($('[name="currentPageNo"]').val());
					linkPage(currentPageNo-1);
				});
				$('#nextPage').on("click",function(){
					var currentPageNo = Number($('[name="currentPageNo"]').val());
					linkPage(currentPageNo+1);
				});
				$('#movePage').on("click",function(){
					var currentPageNo = Number($('[name="currentPageNo"]').val());
					var regExp = /^[1-9]?[0-9]/;
					if(!regExp.test(currentPageNo) ||(totalPageCount < currentPageNo)){
						alert('현재 페이지 값이 정상적이지 않습니다.');
						checkSubmit();
					}else{
						linkPage(currentPageNo);
					}
				});
			});
			
			function checkSubmit(){
				//검색 버튼 클릭시 페이지 초기화
				$('[name="currentPageNo"]').val(1);
				
				if($("#sDate").val()!=''&&$("#eDate").val()!=''&&$("#sDate").val()>$("#eDate").val()){
					alert("등록 종료일이 시작일보다 빠를 수 없습니다.");
					return false;
				} else { $("#frm").attr('action','/admin/customer/opinionBoard/opinionBoardList.do').submit(); 
					
				}
				return true;
			}
			
			function setAdminID(adminId, qnaSeq){
				$.ajax({
					url : "/admin/customer/opinionBoard/regAdminAjax.do",
					type : "get",
					data : { "adminId" : adminId, "qnaSeq" : qnaSeq},
					contentType: "charset=utf-8",
					success : function(data){
						if(data.resultMessage == 'Success'){
							 $("#frm").attr('action','/admin/customer/opinionBoard/opinionBoardList.do').submit(); 
						}else{
							alert("담당자 등록을 실패하였습니다.");
						}
					},
					error : function(){
						alert("데이터를 가져오는데 실패 하였습니다.");
					}
				});
			}
			
			var previousValue;
			$("input").on('focus',function(){
				previous = this.value;
			}).change(function(){
				var sDate = $("#sDate").val();
				var eDate = $("#eDate").val();
				if(sDate!=''&&eDate!=''&&sDate>eDate){
					alert("등록 종료일이 시작일보다 빠를 수 없습니다.");
					$(this).val(previous);
				}
			});
			
			// 답변기한 수정 등록
			function setDeadline(deadline, qnaSeq){
				$.ajax({
					url : "/admin/customer/opinionBoard/deadlineAjax.do",
					type : "post",
					data : {"deadline" : deadline, "qnaSeq" : qnaSeq },
					contentType: "application/x-www-form-urlencoded; charset=utf-8",
					success : function(data){
						if(data.resultMessage == 'Success'){
							 $("#frm").attr('action','/admin/customer/opinionBoard/opinionBoardList.do').submit(); 
						}else{
							alert("답변기한 수정을 실패하였습니다.");
						}
					},
					error : function(){
						alert("데이터를 가져오는데 실패 하였습니다.");
					}
				});
			}
			
		</script>
		
		<!--footer S-->
			<tiles:insertAttribute name="footer" />
		<!--footer E-->
	</div>
</body>
</html>
