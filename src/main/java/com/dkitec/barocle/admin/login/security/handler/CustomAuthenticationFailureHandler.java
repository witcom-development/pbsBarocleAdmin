package com.dkitec.barocle.admin.login.security.handler;

import java.io.IOException;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.barocle.admin.login.service.LoginService;
import com.dkitec.barocle.admin.login.vo.UserSessionVO;

public class CustomAuthenticationFailureHandler implements AuthenticationFailureHandler {
	protected static Logger log = LoggerFactory.getLogger(AuthenticationFailureHandler.class);
	
	@Resource(name = "loginService") private LoginService loginService;
	
	private String loginidname; 		// 로그인 id값이 들어오는 input 태그 name
	private String loginpasswdname; 	// 로그인 password 값이 들어오는 input 태그 name
	private String loginredirectname; 	// 로그인 성공시 redirect 할 URL이 지정되어 있는 input 태그 name
	private String exceptionmsgname; 	// 예외 메시지를 request의 Attribute에 저장할 때 사용될 key 값
	private String defaultFailureUrl; 	// 화면에 보여줄 URL(로그인 화면)

	public CustomAuthenticationFailureHandler() {
		this.loginidname = "j_username";
		this.loginpasswdname = "j_password";
		this.loginredirectname = "loginRedirect";
		this.exceptionmsgname = "securityexceptionmsg";
		this.defaultFailureUrl = "/login.do?fail=true";
	}

	public String getLoginidname() {
		return loginidname;
	}

	public void setLoginidname(String loginidname) {
		this.loginidname = loginidname;
	}

	public String getLoginpasswdname() {
		return loginpasswdname;
	}

	public void setLoginpasswdname(String loginpasswdname) {
		this.loginpasswdname = loginpasswdname;
	}

	public String getExceptionmsgname() {
		return exceptionmsgname;
	}

	public String getLoginredirectname() {
		return loginredirectname;
	}

	public void setLoginredirectname(String loginredirectname) {
		this.loginredirectname = loginredirectname;
	}

	public void setExceptionmsgname(String exceptionmsgname) {
		this.exceptionmsgname = exceptionmsgname;
	}

	public String getDefaultFailureUrl() {
		return defaultFailureUrl;
	}

	public void setDefaultFailureUrl(String defaultFailureUrl) {
		this.defaultFailureUrl = defaultFailureUrl;
	}

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception)
			throws IOException, ServletException, CfoodException {
		
		String loginid = request.getParameter(loginidname);
		String loginpasswd = request.getParameter(loginpasswdname);
		String loginRedirect = request.getParameter(loginredirectname);
		
		int resultUpdate = 0;
		UserSessionVO userSessionVO = new UserSessionVO();

		request.setAttribute(loginidname, loginid);
		request.setAttribute(loginpasswdname, loginpasswd);
		request.setAttribute(loginredirectname, loginRedirect);
		
		
		try {
			userSessionVO.setUsrId(loginid);

			int loginFailCnt = loginService.getLoginFailCnt(userSessionVO);
			
			if(loginFailCnt > 4){
				defaultFailureUrl = defaultFailureUrl+"&failOver=true";
			}
			resultUpdate = loginService.setLoginFailCnt(userSessionVO);
		} catch (CfoodException ce) {
			throw new CfoodException("com.dkitec.barocle.admin.login.security.handler.AuthenticationFailureHandler");
		}
			
		// Request 객체의 Attribute에 예외 메시지 저장
		//request.setAttribute(exceptionmsgname, exception.getMessage());
		//request.getRequestDispatcher(defaultFailureUrl).forward(request, response);
		response.sendRedirect(defaultFailureUrl);
	}
}
