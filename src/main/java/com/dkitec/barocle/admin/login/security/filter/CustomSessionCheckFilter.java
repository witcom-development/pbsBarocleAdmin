package com.dkitec.barocle.admin.login.security.filter;

import java.io.IOException;

import javax.annotation.Resource;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.util.StringUtils;
import org.springframework.web.filter.GenericFilterBean;

import com.dkitec.barocle.admin.login.service.LoginService;
import com.dkitec.barocle.admin.login.vo.MenuAuthVO;
import com.dkitec.barocle.admin.login.vo.UserSessionVO;

public class CustomSessionCheckFilter extends GenericFilterBean {
	protected static Logger log = LoggerFactory
			.getLogger(CustomSessionCheckFilter.class);

	@Resource(name = "loginService") private LoginService loginService;

	public CustomSessionCheckFilter() {
	}

	@SuppressWarnings("unused")
	public void doFilter(ServletRequest req, ServletResponse res,
			FilterChain chain) throws IOException, ServletException {

		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) res;
		HttpSession session = request.getSession(false);

		String rootPath = request.getContextPath();
		UserSessionVO userSessionVO = null;

		// 사용자의 접속 IP
		String remoteIp = request.getRemoteAddr();
		if (StringUtils.isEmpty(remoteIp))
			remoteIp = request.getHeader("x-forwarded-for");

		// 사용자 크리덴셜
		final Authentication authentication = SecurityContextHolder
				.getContext().getAuthentication();

		if (session != null) {
			try {
				String requestUrl = request.getRequestURL().toString();
				int lastIndex = requestUrl.lastIndexOf(".");
				String urlType = "";

				if (requestUrl.length() > lastIndex) {
					urlType = requestUrl.substring(lastIndex + 1);
				} else {
					return;
				}

				if ("do".equals(urlType)) {
					userSessionVO = (UserSessionVO) EgovSessionCookieUtil
							.getSessionAttribute(request, "userSessionVO");
					
					if (userSessionVO == null) {
						// 세션이 없을 경우 세션이 없이 접속이 가능한 페이지인지 확인한다.
						response.sendRedirect("/login.do");
						return;
					} else {
						// 접근이 가능한 페이지인지 체크한다.
						MenuAuthVO menuAuthVO = new MenuAuthVO();
						menuAuthVO.setSrcLink(request.getRequestURI().replace(request.getContextPath(), ""));
						menuAuthVO.setUsrGrpCd(userSessionVO.getUsrGrpCd());
						
						log.debug("##### 이용권한 ##### == > " + menuAuthVO.getSrcLink() + ", " + menuAuthVO.getUsrGrpCd());
						
						MenuAuthVO menuUrlAuth = null;
						String menuUrl = menuAuthVO.getSrcLink();
						String fullUrl = request.getRequestURI();
						int comCodeCheck =fullUrl.indexOf("commonCode");
						
						boolean passCheck = false;
						if(menuUrl.equals("/login.do")){
							//로그인 페이지 예외 처리
							passCheck = true;
						} else if(menuUrl.equals("/noPermissions.do")){
							//권한없음 페이지 예외 처리
							passCheck = true;
						} else if(menuUrl.equals("/main.do")){
							//메인 페이지 예외 처리
							passCheck = true;
						} else if(comCodeCheck > 0){
							//공통코드 조회 예외 처리
							passCheck = true;
						} else {
							menuUrlAuth = loginService.getMenuUrlAuth(menuAuthVO);
						}
						
						if(menuUrlAuth != null) {
							String[] urlAuth = menuUrlAuth.getType().split(",");
							String typeC = "";
							String typeR = "";
							String typeU = "";
							String typeD = "";
							String authCheck = "";
							
							for(int i=0; i<urlAuth.length; i++){
								if("C".equals(urlAuth[i])){
									typeC = urlAuth[i];
									authCheck = "Y";
								} else if("R".equals(urlAuth[i])){
									typeR = urlAuth[i];
									authCheck = "Y";
								} else if("U".equals(urlAuth[i])){
									typeU = urlAuth[i];
									authCheck = "Y";
								} else if("D".equals(urlAuth[i])){
									typeD = urlAuth[i];
									authCheck = "Y";
								} else {
									authCheck = "N"; //추가 : 2017.03.07
								}
							}
							
							if ("Y".equals(authCheck)) {
								//권한 있음
							} else {
								response.sendRedirect("/noPermissions.do?msgCode=NO_PERMISSIONS");
								return; //추가 : 2017.03.07
							}
						}
						
						if(menuUrlAuth == null) {
							if(passCheck){
								//
							} else {
//								response.sendRedirect("/noPermissions.do?msgCode=NOT_PAGE");
//								return; //추가 : 2017.03.07
							}
						}
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("/login.do");
				return;
			}
		}

		chain.doFilter(request, response);
	}
}
