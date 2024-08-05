package com.dkitec.barocle.admin.login.security.handler;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.util.StringUtils;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.admin.login.service.LoginService;
import com.dkitec.barocle.admin.login.vo.LoginHistoryVO;
import com.dkitec.barocle.admin.login.vo.MenuAuthVO;
import com.dkitec.barocle.admin.login.vo.UserSessionVO;
import com.dkitec.barocle.admin.system.sms.service.SmsService;

import egovframework.com.cmm.EgovHttpSessionBindingListener;

public class CustomAuthenticationSuccessHandler implements
		AuthenticationSuccessHandler {
	protected static Logger log = LoggerFactory.getLogger(CustomAuthenticationSuccessHandler.class);
	
	@Resource(name = "loginService") private LoginService loginService;
	@Resource(name = "smsService") private SmsService smsService;
	
	private RequestCache requestCache = new HttpSessionRequestCache();
	private String targetUrlParameter;
	private String defaultUrl;
	private boolean useReferer;
	private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();

	public CustomAuthenticationSuccessHandler() {
		targetUrlParameter = "";
		defaultUrl = "/";
		useReferer = false;
	}

	public String getTargetUrlParameter() {
		return targetUrlParameter;
	}

	public void setTargetUrlParameter(String targetUrlParameter) {
		this.targetUrlParameter = targetUrlParameter;
	}

	public String getDefaultUrl() {
		return defaultUrl;
	}

	public void setDefaultUrl(String defaultUrl) {
		this.defaultUrl = defaultUrl;
	}

	public boolean isUseReferer() {
		return useReferer;
	}

	public void setUseReferer(boolean useReferer) {
		this.useReferer = useReferer;
	}

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request,
			HttpServletResponse response, Authentication authentication)
			throws IOException, ServletException, CfoodException {
		// TODO Auto-generated method stub
		List<GrantedAuthority> list = new ArrayList<GrantedAuthority>();
		list = (List<GrantedAuthority>) authentication.getAuthorities();
		
		UserSessionVO userSessionVO = new UserSessionVO();
		MenuAuthVO menuParamVo = new MenuAuthVO();
		LoginHistoryVO loginHistoryVO = new LoginHistoryVO();
		
		userSessionVO.setUsrId(authentication.getName());
		menuParamVo.setUsrGrpCd(list.get(0).getAuthority());
		loginHistoryVO.setUsrId(authentication.getName());
		
		@SuppressWarnings("unused") int resultAdd = 0;
		@SuppressWarnings("unused") int resultUpdate = 0;
		


		
		
		try {
			try {
				
				// 2018-11-07 수정
				String clientIp =  request.getParameter("j_ip");
				
				// 접속 IP 가져오기
				if (null == clientIp || clientIp.length() == 0 ) {
					clientIp = request.getHeader("HTTP_X_FORWARDED_FOR");//웹로직
				}
				
				log.info("HTTP_X_FORWARDED_FOR : " +clientIp);
				if (null == clientIp || clientIp.length() == 0
						|| clientIp.toLowerCase().equals("unknown")) {
					clientIp = request.getHeader("REMOTE_ADDR");
					log.info("REMOTE_ADDR : " +clientIp);
				}
				if (null == clientIp || clientIp.length() == 0
						|| clientIp.toLowerCase().equals("unknown")) {
					clientIp = request.getHeader("X-Forwarded-For");//X-Forwarded-For: client, proxy1, proxy2
					log.info("X-Forwarded-For : " +clientIp);
				}
				if (null == clientIp || clientIp.length() == 0
						|| clientIp.toLowerCase().equals("unknown")) {
					clientIp = request.getHeader("Proxy-Client-IP");
					log.info("Proxy-Client-IP : " +clientIp);
				}
				if (null == clientIp || clientIp.length() == 0
						|| clientIp.toLowerCase().equals("unknown")) {
					clientIp = request.getHeader("HTTP_CLIENT_IP");
					log.info("HTTP_CLIENT_IP : " +clientIp);
				}
				if (null == clientIp || clientIp.length() == 0
						|| clientIp.toLowerCase().equals("unknown")) {
					clientIp = request.getHeader("WL-Proxy-Client-IP");
					log.info("WL-Proxy-Client-IP : " +clientIp);
				}

				if (null == clientIp || clientIp.length() == 0
						|| clientIp.toLowerCase().equals("unknown")) {
					clientIp = request.getRemoteAddr();
					log.debug("getRemoteAddr() : " +clientIp);
				}
 		
				
				userSessionVO = loginService.getLoginInfo(userSessionVO);
				List<MenuAuthVO> menuAuthListVo = loginService.getMenuAuthList(menuParamVo);
				
				//2020-12-04 : 모든 관리자 중복로그인 방지로 변경
				//2020-10-27 : 로그인 성공 시 중복로그인 방지를 위해 세션저장
				EgovHttpSessionBindingListener listener = new EgovHttpSessionBindingListener();
				request.getSession().setAttribute(userSessionVO.getUsrId(), listener);
				
				//2020-10-27 : 운영관리그룹(최고관리자)이 로그인할 때 마다 해당 관리자에게 문자전송
				if("12".equals(userSessionVO.getUsrGrpCd())){//운영관리그룹
					smsService.sendChiefAdminLogin(userSessionVO);
				}
				
				
				MenuAuthVO finMenuAuthVO = new MenuAuthVO();	// session에 저장할 VO
				
				List<MenuAuthVO> menuAuthVo = new ArrayList<MenuAuthVO>();
				List<MenuAuthVO> menuAuthLevalSecVo = new ArrayList<MenuAuthVO>();
				List<MenuAuthVO> menuAuthLevalThiVo = new ArrayList<MenuAuthVO>();
				List<MenuAuthVO> menuAuthLevalfouVo = new ArrayList<MenuAuthVO>();
				
				// 관리자 마지막 로그인 시간 확인, 6개월 이상일 경우 로그인 제한
				if(Integer.parseInt(userSessionVO.getLastLoginDate()) >= 180){
					response.sendRedirect("/login.do?fail=true&loginDate=true");
					return;
				}
				
				if (userSessionVO.getLoginFailCnt() <= 5) {
					userSessionVO.setUsrIp(clientIp);

					//로그인 사용자 정보 저장
					String usrId = userSessionVO.getUsrId();
					String usrName = userSessionVO.getUsrName();
					
					EgovSessionCookieUtil.setSessionAttribute(request, "usrId", usrId);
					EgovSessionCookieUtil.setSessionAttribute(request, "usrName", usrName);
					EgovSessionCookieUtil.setSessionAttribute(request, "userSessionVO", userSessionVO);
					// 2018-11-07 
					EgovSessionCookieUtil.setSessionAttribute(request, "userIp", clientIp);
					
					//메뉴 권한 정보 저장
					int i = 0;
					
					for(i = 0; i < menuAuthListVo.size(); i++){
						// Level 1 메뉴 저장
						if(Integer.parseInt(menuAuthListVo.get(i).getMenuLevel()) == 1) {
							menuAuthVo.add(menuAuthListVo.get(i));
						}
						// Level 2 메뉴 저장
						if(Integer.parseInt(menuAuthListVo.get(i).getMenuLevel()) == 2) {
							menuAuthLevalSecVo.add(menuAuthListVo.get(i));
						}
						// Level 3 메뉴 저장
						if(Integer.parseInt(menuAuthListVo.get(i).getMenuLevel()) == 3) {
							menuAuthLevalThiVo.add(menuAuthListVo.get(i));
						}
						// Level 4 메뉴 저장
						if(Integer.parseInt(menuAuthListVo.get(i).getMenuLevel()) == 4) {
							menuAuthLevalfouVo.add(menuAuthListVo.get(i));
						}
					}
					
					String setSrcLink = "#";
					boolean flagDepth2 = true;
					boolean flagDepth3 = true;
					boolean flagDepth4 = true;
					// Level 1
					for(i = 0; i < menuAuthVo.size(); i++){
						List<MenuAuthVO> tmp1MenuVo = new ArrayList<MenuAuthVO>();
						String menuCd1 = menuAuthVo.get(i).getMenuCd();
						// Level 2
						for(int j = 0; j < menuAuthLevalSecVo.size(); j++){
							if(menuCd1.equals(menuAuthLevalSecVo.get(j).getUpMenu())){
								if(flagDepth2&&"Y".equalsIgnoreCase(menuAuthLevalSecVo.get(j).getReadYn())){
									setSrcLink = menuAuthLevalSecVo.get(j).getSrcLink(); 
									log.info(" 2-depth." + menuCd1 + " " + menuAuthLevalSecVo.get(j).getUpMenu() + setSrcLink);
									flagDepth2 = false;
								}
								tmp1MenuVo.add(menuAuthLevalSecVo.get(j));
								List<MenuAuthVO> tmp2MenuVo = new ArrayList<MenuAuthVO>();
								String menuCd2 = menuAuthLevalSecVo.get(j).getMenuCd();
								// Level 3
								for(int k = 0; k < menuAuthLevalThiVo.size(); k++){
									if(menuCd2.equals(menuAuthLevalThiVo.get(k).getUpMenu())){
										if(flagDepth3&&"Y".equalsIgnoreCase(menuAuthLevalThiVo.get(k).getReadYn())){
											setSrcLink = menuAuthLevalThiVo.get(k).getSrcLink();
											log.info(" 3-depth. " + menuCd2 + " " + menuAuthLevalThiVo.get(k).getUpMenu() + setSrcLink);
											flagDepth3 = false;
										}
										tmp2MenuVo.add(menuAuthLevalThiVo.get(k));
										List<MenuAuthVO> tmp3MenuVo = new ArrayList<MenuAuthVO>();
										String menuCd3 = menuAuthLevalThiVo.get(k).getMenuCd();
										// Level 4
										for(int l = 0; l < menuAuthLevalfouVo.size(); l++){
											if(menuCd3.equals(menuAuthLevalfouVo.get(l).getUpMenu())){
												if(flagDepth4&&"Y".equalsIgnoreCase(menuAuthLevalfouVo.get(l).getReadYn())){
													setSrcLink = menuAuthLevalfouVo.get(l).getSrcLink();
													log.info(" 4-depth. " + menuCd3 + " " + menuAuthLevalfouVo.get(l).getUpMenu() + setSrcLink);
													flagDepth4 = false;
												}
												tmp3MenuVo.add(menuAuthLevalfouVo.get(l));
											}
										}
										menuAuthLevalThiVo.get(k).setMenuGrpList(tmp3MenuVo);
										flagDepth4 = false;
									}
								}
								menuAuthLevalSecVo.get(j).setMenuGrpList(tmp2MenuVo);
								flagDepth3 = false;
							}
						}
						menuAuthVo.get(i).setMenuGrpList(tmp1MenuVo);
						menuAuthVo.get(i).setSrcLink(setSrcLink);
						setSrcLink = "#";
						flagDepth2 = true;
						flagDepth3 = true;
						flagDepth4 = true;
					}
					finMenuAuthVO.setMenuGrpList(menuAuthVo);
					//log.debug("login ===> menuAuthVo : " + menuAuthVo.toString());
					EgovSessionCookieUtil.setSessionAttribute(request, "menuAuthVO", finMenuAuthVO);	// 세션 저장
					
					resultAdd = loginService.addLoginHistory(userSessionVO);
					resultUpdate = loginService
							.setLoginFailReset(userSessionVO);
				} else {
					response.sendRedirect("/login.do?fail=true");
					return;
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} catch (CfoodException ce) {
			throw new CfoodException("com.dkitec.barocle.admin.login.security.handler.CustomAuthenticationSuccessHandler");
		}
		
		clearAuthenticationAttributes(request);

		int intRedirectStrategy = decideRedirectStrategy(request, response);
		switch (intRedirectStrategy) {
		case 1:
			useTargetUrl(request, response);
			break;
		case 2:
			useSessionUrl(request, response);
			break;
		case 3:
			useRefererUrl(request, response);
			break;
		default:
			useDefaultUrl(request, response);
		}
	}

	private void clearAuthenticationAttributes(HttpServletRequest request) {
		HttpSession session = request.getSession(false);

		if (session == null) {
			return;
		}

		session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
	}

	private void useTargetUrl(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		SavedRequest savedRequest = requestCache.getRequest(request, response);
		if (savedRequest != null) {
			requestCache.removeRequest(request, response);
		}
		String targetUrl = request.getParameter(targetUrlParameter);
		redirectStrategy.sendRedirect(request, response, targetUrl);
	}

	private void useSessionUrl(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		SavedRequest savedRequest = requestCache.getRequest(request, response);
		String targetUrl = savedRequest.getRedirectUrl();
		redirectStrategy.sendRedirect(request, response, targetUrl);
	}

	private void useRefererUrl(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		String targetUrl = request.getHeader("REFERER");
		redirectStrategy.sendRedirect(request, response, targetUrl);
	}

	private void useDefaultUrl(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		redirectStrategy.sendRedirect(request, response, defaultUrl);
	}

	/**
	 * 인증 성공후 어떤 URL로 redirect 할지를 결정한다 판단 기준은 targetUrlParameter 값을 읽은 URL이 존재할
	 * 경우 그것을 1순위 1순위 URL이 없을 경우 Spring Security가 세션에 저장한 URL을 2순위 2순위 URL이 없을
	 * 경우 Request의 REFERER를 사용하고 그 REFERER URL이 존재할 경우 그 URL을 3순위 3순위 URL이 없을 경우
	 * Default URL을 4순위로 한다
	 * 
	 * @param request
	 * @param response
	 * @return 1 : targetUrlParameter 값을 읽은 URL 2 : Session에 저장되어 있는 URL 3 :
	 *         referer 헤더에 있는 url 0 : default url
	 */
	private int decideRedirectStrategy(HttpServletRequest request,
			HttpServletResponse response) {
		int result = 0;

		SavedRequest savedRequest = requestCache.getRequest(request, response);

		if (!"".equals(targetUrlParameter)) {
			String targetUrl = request.getParameter(targetUrlParameter);
			if (StringUtils.hasText(targetUrl)) {
				result = 1;
			} else {
				if (savedRequest != null) {
					result = 2;
				} else {
					String refererUrl = request.getHeader("REFERER");
					if (useReferer && StringUtils.hasText(refererUrl)) {
						result = 3;
					} else {
						result = 0;
					}
				}
			}

			return result;
		}

		if (savedRequest != null) {
			result = 2;
			return result;
		}

		String refererUrl = request.getHeader("REFERER");
		if (useReferer && StringUtils.hasText(refererUrl)) {
			result = 3;
		} else {
			result = 0;
		}

		return result;
	}
}
