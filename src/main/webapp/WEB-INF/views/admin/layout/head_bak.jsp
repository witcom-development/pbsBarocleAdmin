<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
		<!--Head S-->
		<div id="header">
			<div class="login">
				<div class="loginStatue">
					<!--로그인 여부에 따라 선택 -->
					<!--
					<div class="blogin">
						<a href="#" class="loginButton">로그인</a>
						<a href="#" class="loginButton">회원가입</a>
					</div>
					-->
					<form id="logoutForm" action="/j_spring_security_logout" method='POST'>
					<script>
						function formSubmit() {
							document.getElementById("logoutForm").submit();
						}
					</script>
					<div class="alogin">
						<span><%= com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil.getSessionAttribute(request, "usrName") %>님 접속중</span>
						<a href="javascript:formSubmit()" class="loginButton">로그아웃</a>
					</div>
					</form>
				</div>
			</div>
			<div class="menuArea">
				<div class="menuBox">
					<div class="logo"  ><a href="/main.do"><img src="/images/logo.png" alt="서울자전거 공공" /></a></div>
					<ul class="menu">
						<c:choose>
							<c:when test="${fn:length(menuAuthList)>0 }">
								<c:forEach items="${menuAuthList}" var="depth1" varStatus="status1">
									<c:if test="${depth1.readYn eq 'Y'}">
									<c:set var="gcount" value="0" />
									
									
									<c:forEach items="${depth1.menuGrpList}" var="depth2" varStatus="status2">
										<c:if test="${gcount eq 0}">
											<c:choose>
												<c:when test="${depth2.readYn eq 'Y'}">
													<c:set var="gcount" value="1" />
														<c:choose>
														<c:when test="${fn:length(depth2.srcLink)>0 && depth2.menuCd < 990}">
															<li><a href="${depth2.srcLink}"><c:out value="${depth2.menuName}" /></a></li>
														</c:when>
														<c:when test="${depth2.menuCd < 990}">
															<li><a href="#"><c:out value="${depth2.menuName}" /></a></li>
														</c:when>
														<c:otherwise></c:otherwise>
													</c:choose>
												</c:when>
											
											</c:choose>
										
										</c:if>	
							      </c:forEach>			
									
										
										
										
									</c:if>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<li>사용자 권한이 없습니다.</li>
							</c:otherwise>
						</c:choose>
					</ul>
				</div>
				<div class="menuButton">
					
					<button class="historyBack" onclick="history.back()"><img src="/images/btn_back.png" alt="뒤로가기" /></button>
					<button class="openMenu"><img src="/images/btn_menu.png" alt="메뉴보기" /></button>
					
					<div class="logo"  ><a href="/main.do"><img src="/images/logo.png" alt="서울자전거 공공" /></a></div>
				</div>
			</div>
		</div>
		<!--Head E-->
		<script>
		$('.logo').on("click",function(){
			location.href="/main.do"
		});
		</script>
		
		
		
		
		
		
		
		
		<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
		<!--Head S-->
		<div id="header">
			<div class="login">
				<div class="loginStatue">
					<!--로그인 여부에 따라 선택 -->
					<!--
					<div class="blogin">
						<a href="#" class="loginButton">로그인</a>
						<a href="#" class="loginButton">회원가입</a>
					</div>
					-->
					<form id="logoutForm" action="/j_spring_security_logout" method='POST'>
					<script>
						function formSubmit() {
							document.getElementById("logoutForm").submit();
						}
					</script>
					<div class="alogin">
						<span><%= com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil.getSessionAttribute(request, "usrName") %>님 접속중</span>
						<a href="javascript:formSubmit()" class="loginButton">로그아웃</a>
					</div>
					</form>
				</div>
			</div>
			<div class="menuArea">
				<div class="menuBox">
					<div class="logo"  ><a href="/main.do"><img src="/images/logo.png" alt="서울자전거 공공" /></a></div>
					<ul class="menu">
						<c:choose>
							<c:when test="${fn:length(menuAuthList)>0 }">
								<c:forEach items="${menuAuthList}" var="depth1" varStatus="status1">
									<c:if test="${depth1.readYn eq 'Y'}">
										<c:set var="gcount" value="0" />
										<c:set var="glink" value="" />
										
										<c:forEach items="${depth1.menuGrpList}" var="depth2" varStatus="status2">
										  <c:if test="${gcount eq '0'}">
											<c:choose>											
											<c:when test="${fn:length(depth2.srcLink)>0 and depth2.readYn eq 'Y'}">												
												<c:set var="gcount" value="1" />
												<c:set var="glink" value="${depth2.srcLink}" />
											</c:when>											
											<c:otherwise></c:otherwise>
											</c:choose>
										  </c:if>
										
										
										</c:forEach>
										<c:choose>
										<c:when test="${fn:length(glink)>0}">
										<li><a href="${glink}"><c:out value="${depth1.menuName}" /></a></li>
										</c:when>
										<c:otherwise>
										<li><a href="#"><c:out value="${depth1.menuName}" /></a></li>
										</c:otherwise>
										
										</c:choose>



									</c:if>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<li>사용자 권한이 없습니다.</li>
							</c:otherwise>
						</c:choose>
					</ul>
				</div>
				<div class="menuButton">
					
					<button class="historyBack" onclick="history.back()"><img src="/images/btn_back.png" alt="뒤로가기" /></button>
					<button class="openMenu"><img src="/images/btn_menu.png" alt="메뉴보기" /></button>
					
					<div class="logo"  ><a href="/main.do"><img src="/images/logo.png" alt="서울자전거 공공" /></a></div>
				</div>
			</div>
		</div>
		<!--Head E-->
		<script>
		$('.logo').on("click",function(){
			location.href="/main.do"
		});
		</script>