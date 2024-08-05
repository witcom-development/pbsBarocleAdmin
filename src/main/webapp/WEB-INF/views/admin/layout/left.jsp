<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
	
	<div class="leftmenu">
		<dl>
			<c:choose>
				<c:when test="${menuValueMap.menuCode ne null &&menuValueMap. menuCode ne '' && fn:length(menuAuthList)>0 }">
					<c:forEach items="${menuAuthList}" var="depth1" varStatus="status1">
						<c:if test="${depth1.menuCd eq menuValueMap.menuCode}">
							<dt><c:out value="${depth1.menuName}"/></dt>
							<c:if test="${depth1.readYn eq 'Y' && depth1.menuCd < 990}">
								<c:forEach items="${depth1.menuGrpList}" var="depth2" varStatus="status2">
									<c:if test="${depth2.readYn eq 'Y'}">
										<%-- check depth --%>
										<c:set var="setDepth" value="3" />
										<c:if test="${fn:length(depth2.menuGrpList)>0}">
											<c:forEach items="${depth2.menuGrpList}" var="depth3" varStatus="status3">
												<c:if test="${fn:length(depth3.menuGrpList)>0}">
													<c:set var="setDepth" value="4" />
												</c:if>
											</c:forEach>
										</c:if>
										<c:choose>
											<c:when test="${fn:length(depth2.menuGrpList)>0}">
												<dd>
													<c:choose>
														<c:when test="${setDepth >= 4}"><a href="#"><c:out value="${depth2.menuName}"/></a></c:when>
														<c:otherwise><a href="${depth2.srcLink}"><c:out value="${depth2.menuName}"/></a></c:otherwise>
													</c:choose>
													<c:if test="${fn:length(depth2.menuGrpList)>0}">
														<ul id="toggleUL${status2.count}">
															<c:forEach items="${depth2.menuGrpList}" var="depth3" varStatus="status3">
																<c:if test="${fn:length(depth3.menuGrpList)>0}">
																	<c:if test="${depth3.readYn eq 'Y'}">
																		<c:choose>
																			<c:when test="${fn:indexOf(depth3.srcLink,'.do')>0}">
																				<c:forEach items="${depth3.menuGrpList}" var='depth4' varStatus="status4">
																					<c:if test="${menuValueMap.requestURI eq depth4.srcLink}"><c:set var="toggleAt" value="${status2.count}"/></c:if>
																				</c:forEach> 
																				<li><a href="${depth3.srcLink}"><c:out value="${depth3.menuName}" /></a></li>
																			</c:when>
																			<c:otherwise>
																				<li><a href="#"><c:out value="${depth3.menuName}" /></a></li>
																			</c:otherwise>
																		</c:choose>
																	</c:if>
																</c:if>
															</c:forEach>
														</ul>
													</c:if>
												</dd>
											</c:when>
											<c:otherwise>
												<dd><a href="${depth2.srcLink}"><c:out value="${depth2.menuName}"/></a></dd>
											</c:otherwise>
										</c:choose>
									</c:if>
								</c:forEach>
							</c:if>
						</c:if>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<dt>사용자 권한이 없습니다.</dt>
				</c:otherwise>
			</c:choose>
		</dl>
	</div>
	
	<script type="text/javascript">
		$(function(){
			$("#toggleUL<c:out value='${toggleAt}'/>").css('display','block');
		});
	</script>