<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

	<div class="layerMenuArea">
		<div class="dim"></div>
		<div class="layerMenu">
			<div class="lyLoginStatue">
				<form id="logoutForm" action="/j_spring_security_logout" method='POST'>
					<script>
						function formSubmit() {
							document.getElementById("logoutForm").submit();
						}
					</script>
					<span><%= com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil.getSessionAttribute(request, "usrName") %>님</span>
					<c:set var='userName' value='<%= com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil.getSessionAttribute(request, "usrName") %>' />
				</form>
				<button class="btntype" onclick="javascript:formSubmit();">로그아웃</button>
				<button class="close"><img src="/images/btn_close.png" alt="닫기" /></button>
			</div>
			<ul class="dep1">
				<c:choose>
					<c:when test="${fn:length(menuAuthList)>0 }">
						<c:forEach items="${menuAuthList}" var="depth1" varStatus="status1">
							<c:choose>
								<c:when test="${depth1.readYn eq 'Y' && depth1.menuCd < 990 && ( userName eq '노희재' || userName eq '장남훈' || userName eq '송인재'  || depth1.menuCd ne 106) }">
									<li><span><c:out value="${depth1.menuName}" /></span>
									<c:if test="${fn:length(depth1.menuGrpList)>0}">
										<ul id="toggleDep2_${status1.count}" class="dep2">
											<c:forEach items="${depth1.menuGrpList}" var="depth2" varStatus="status2">
												<c:choose>
													<c:when test="${depth2.readYn eq 'Y' && fn:length(depth2.menuGrpList)>0}">
														<%-- check depth --%>
														<c:set var="setDepth" value="3" />
														<c:if test="${fn:length(depth2.menuGrpList)>0}">
															<c:forEach items="${depth2.menuGrpList}" var="depth3" varStatus="status3">
																<c:if test="${fn:length(depth3.menuGrpList)>0}">
																	<c:set var="setDepth" value="4" />
																</c:if>
															</c:forEach>
														</c:if>
															<%-- 현재 uri와 메뉴 uri를 비료하여 화성여부를 설정한다. --%>
															<c:if test="${menuValueMap.requestURI eq depth2.srcLink}">
																<c:set var="toggleAt2" value="${status1.count}" />
															</c:if>
														<c:choose>
															<c:when test="${fn:length(depth2.menuGrpList)>0}">
																<c:choose>
																	<c:when test="${setDepth >= 4}">
																		<li class="more"><span><c:out value="${depth2.menuName}" /></span>
																		<c:if test="${fn:length(depth2.menuGrpList)>0}">
																			<ul id="toggleDep3_${status1.count}_${status2.count}" class="dep3">
																				<c:forEach items="${depth2.menuGrpList}" var="depth3" varStatus="status31">
																					<c:if test="${depth3.readYn eq 'Y'}">
																						<c:choose>
																							<c:when test="${fn:indexOf(depth3.srcLink,'.do')>0}">
																								<%-- 현재 uri와 메뉴 uri를 비료하여 화성여부를 설정한다. --%>
																								<c:forEach items="${depth3.menuGrpList}" var='depth4' varStatus="status4">
																									<c:if test="${menuValueMap.requestURI eq depth4.srcLink}">
																										<c:set var="toggleAt2" value="${status1.count}" />
																										<c:set var="toggleAt3" value="${status2.count}" />
																									</c:if>
																								</c:forEach>
																								<li><span><a href="${depth3.srcLink}"><c:out value="${depth3.menuName}" /></a></span></li>
																							</c:when>
																							<c:otherwise>
																								<li><span><a href="#"><c:out value="${depth3.menuName}" /></a></span></li>
																							</c:otherwise>
																						</c:choose>
																					</c:if>
																				</c:forEach>
																			</ul>
																		</c:if>
																		</li>
																	</c:when>
																	<c:otherwise> <li><a href="${depth2.srcLink}"><c:out value="${depth2.menuName}" /></a> </c:otherwise>
																</c:choose>
															</c:when>
															<c:otherwise>
																<li><a href="${depth2.srcLink}"><c:out value="${depth2.menuName}"/></a></li>
															</c:otherwise>
														</c:choose>
													</c:when>
													<c:when test="${depth2.readYn eq 'Y'}">
															<%-- 현재 uri와 메뉴 uri를 비교하여 활성여부를 설정한다. --%>
															<c:if test="${menuValueMap.requestURI eq depth2.srcLink}">
																<c:set var="toggleAt2" value="${status1.count}" />
															</c:if>
														<li><a href="${depth2.srcLink}"><c:out value="${depth2.menuName}" /></a></li>
													</c:when>
													<c:otherwise></c:otherwise>
												</c:choose>
											</c:forEach>
										</ul>
									</c:if>
									</li>
								</c:when>
								<c:otherwise></c:otherwise>
							</c:choose>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<li><span>사용 권한이 없습니다.</span></li>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>
	</div>
	
	<script type="text/javascript">
		$(function(){
			var toggleAt2 = '<c:out value="${toggleAt2}"/>';
			var toggleAt3 = '<c:out value="${toggleAt3}"/>';
			if(!isNaN(toggleAt2)){
				$("#toggleDep2_"+toggleAt2).css('display','block');
				if(!isNaN(toggleAt3)){
					$("#toggleDep3_"+toggleAt2+"_"+toggleAt3).css('display','block');
				}
			}
		});
	</script>