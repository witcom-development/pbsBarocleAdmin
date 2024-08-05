package com.dkitec.barocle.exception.handler;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.Locale;
import java.util.Properties;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.MessageSource;
import org.springframework.validation.BindException;
import org.springframework.validation.BindingResult;
import org.springframework.web.HttpMediaTypeException;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.admin.login.vo.MenuAuthVO;
import com.dkitec.barocle.logging.Log;
import com.dkitec.barocle.logging.LogRepository;
import com.dkitec.barocle.util.webutil.StringUtil;

import egovframework.rte.fdl.property.EgovPropertyService;

@ControllerAdvice
public class ExceptionHandlerAdvice {

	@Resource(name="exceptionProps") private Properties exceptionProps;
	@Resource(name="errorSource") private MessageSource errorSource;
	@Resource(name = "propertiesService") protected EgovPropertyService propertiesService;

	private ModelAndView handleAsCfoodException(HttpServletRequest request, Throwable e,
			Class<? extends Throwable> eType) {

		return handleAsCfoodException(request, null, e, eType);
	}

	private ModelAndView handleAsCfoodException(HttpServletRequest request, String message, Throwable e,
			Class<? extends Throwable> eType) {

		return handleCfoodException(request, new CfoodException(
				exceptionProps.getProperty(eType.getName()), message, e));
	}

	@ExceptionHandler(HttpMediaTypeException.class)
	public ModelAndView handleHttpMediaTypeException(
			HttpMediaTypeException e) throws HttpMediaTypeException {

		throw e;
	}

	@ExceptionHandler(HttpRequestMethodNotSupportedException.class)
	public ModelAndView handleHttpRequestMethodNotSupportedException(
			HttpRequestMethodNotSupportedException e) throws HttpRequestMethodNotSupportedException {

		throw e;
	}

	@ExceptionHandler(BindException.class)
	public ModelAndView handleBindException(HttpServletRequest request, BindException e) {

		BindingResult result = e.getBindingResult();
		String message = null;

		if (result.hasErrors()) {
			message = result.getAllErrors().get(0).getDefaultMessage();
		}

		return handleAsCfoodException(request, message, e, BindException.class);
	}

	@ExceptionHandler(Throwable.class)
	public ModelAndView handleThrowable(HttpServletRequest request, Exception e) {

		return handleAsCfoodException(request, e, Throwable.class);
	}


	@ExceptionHandler(CfoodException.class)
	public ModelAndView handleCfoodException(HttpServletRequest request, CfoodException e) {
		String requestURI = (String)request.getRequestURI();
		
		StringWriter writer = new StringWriter();
		e.printStackTrace(new PrintWriter(writer));

		ModelAndView model = new ModelAndView();
		
		if(!isNull(requestURI)){	// 여기 처리
			if(requestURI.length()>=3){ requestURI = requestURI.substring(0, requestURI.indexOf(".do")+3); }
			java.util.List<MenuAuthVO> menuAuthList = null;		// 메뉴
			String[] tempMenuPathArray = {"","","",""};			// new String[4];
			java.util.List<String> menuPathList = null; 		// 메뉴 경로
			String menuCode = "0";
			
			// TB_SYS_MENU_CD 테이블에 등록되지 않은 URL 중에서 메뉴가 출력되야 할 url 주소를 받아온다.
			String[] allowArray = (propertiesService.getString("allowuri")).split(",");
			boolean allowFlag = false;
			if(!StringUtil.isEmpty(allowArray)){ for(String str: allowArray){ if(str.equalsIgnoreCase(requestURI)){ allowFlag = true; } } }
			
			// 현재 URL의 최상위(depth1) 메뉴 코드를 menuAuthVO session에서 찾아서 menuCode에 입력한다.(WHY?)
			// NOTE : mariadb는 계층적 쿼리를 제공하지 않는다. 재귀호출을 사용할 수 있지만, 여러 방면에서 아래와 같은 방식으로 하기로 결론 지었다.
			com.dkitec.barocle.admin.login.vo.MenuAuthVO menuAuthVO;
			int countCode = 0;
			try {
				menuAuthVO = (MenuAuthVO) EgovSessionCookieUtil.getSessionAttribute(request, "menuAuthVO");
				if(menuAuthVO!=null&&requestURI!=null&&!"".equals(requestURI)){
					menuAuthList = menuAuthVO.getMenuGrpList();
					menuPathList = new java.util.ArrayList<String>();
					if(allowFlag){
						model.addObject("menuAuthList",menuAuthList);	// 허가 받은 uri
					} else {
						// 현재 url의 최상위 메뉴 코드를 가지고 온다.
						// 주의 : 하위 코드의 url에서 최상위 depth의 코드값만 필요하다. (최상위 코드값은 좌측 메뉴를 출력하기 위해 필요하다.)
						Loop : for(MenuAuthVO menuAuthDepth1 : menuAuthList){
							++countCode;
							if(requestURI.equals(menuAuthDepth1.getSrcLink())){ menuCode = menuAuthDepth1.getMenuCd(); break Loop; }
							for(MenuAuthVO menuAuthDepth2 : menuAuthDepth1.getMenuGrpList()){
								++countCode;
								if(requestURI.equals(menuAuthDepth2.getSrcLink())){ menuCode = menuAuthDepth1.getMenuCd(); break Loop; }
								for(MenuAuthVO menuAuthDepth3 : menuAuthDepth2.getMenuGrpList()){
									++countCode;
									if(requestURI.equals(menuAuthDepth3.getSrcLink())){ menuCode = menuAuthDepth1.getMenuCd(); break Loop; }
									for(MenuAuthVO menuAuthDepth4 : menuAuthDepth3.getMenuGrpList()){
										++countCode;
										if(requestURI.equals(menuAuthDepth4.getSrcLink())){ menuCode = menuAuthDepth1.getMenuCd(); break Loop; }
									}
								}
							}
						}
						// 현재 url의 경로를 찾는다.
						int foundDepth = 0;	// uri를 찾은 최대 depth의 경로.
						LoopR : for(MenuAuthVO menuAuthDepth1 : menuAuthList){
							tempMenuPathArray[0] = menuAuthDepth1.getMenuName();
							if(requestURI.equals(menuAuthDepth1.getSrcLink())){ foundDepth = 1; } 
							for(MenuAuthVO menuAuthDepth2 : menuAuthDepth1.getMenuGrpList()){
								tempMenuPathArray[1] = menuAuthDepth2.getMenuName();
								if(requestURI.equals(menuAuthDepth2.getSrcLink())){ foundDepth = 2; }
								for(MenuAuthVO menuAuthDepth3 : menuAuthDepth2.getMenuGrpList()){
									tempMenuPathArray[2] = menuAuthDepth3.getMenuName();
									if(requestURI.equals(menuAuthDepth3.getSrcLink())){ foundDepth = 3; }
									for(MenuAuthVO menuAuthDepth4 : menuAuthDepth3.getMenuGrpList()){
										tempMenuPathArray[3] = menuAuthDepth4.getMenuName();
										if(requestURI.equals(menuAuthDepth4.getSrcLink())){
											foundDepth = 4; break LoopR;
										} else { tempMenuPathArray[3] = ""; }
									}
									if(foundDepth>=3) { break LoopR; } else { tempMenuPathArray[2] = ""; }
								}
								if(foundDepth>=2) { break LoopR; } else { tempMenuPathArray[1] = ""; }
							}
							if(foundDepth>=1) { break LoopR; }
						}
						// 메뉴 경로 list 객체에 넣기.
						for(String str : tempMenuPathArray){ if(!StringUtil.isEmpty(str)){ menuPathList.add(str); } }
						// 메뉴코드가 없을시 메인,팝업과 같은 페이지로 인식함.
						//if(StringUtil.isEmpty(menuCode)){ throw new CfoodException("com.dkitec.barocle.logging.interceptor.LoggingInterceptor.NullMenuAuthException"); }
						if(menuCode!=null&&!"0".equals(menuCode)&&(menuCode.trim()).length()>1){
							java.util.Map<String,String> menuValueMap = new java.util.HashMap<String,String>();
							menuValueMap.put("menuCode",menuCode);			// 현재 uri의 최상위 메뉴 코드
							menuValueMap.put("requestURI",requestURI);		// 현재 uri
							model.addObject("menuValueMap",menuValueMap);
							model.addObject("menuAuthList",menuAuthList);	// 메뉴 목록
							model.addObject("menuPathList",menuPathList);	// 메뉴 경로
						}
					}
				}
			} catch(NullPointerException npe){
				throw new CfoodException("com.dkitec.barocle.logging.interceptor.LoggingInterceptor.NullPointerException",npe);
			} catch (Exception ex) {
				throw new CfoodException("com.dkitec.barocle.logging.interceptor.LoggingInterceptor.Exception",ex);
			}
		}
		
		model.addObject("exception", e);
		model.addObject("stackTrace", writer.toString());
		model.setViewName("/admin/common/error");

		Log log = LogRepository.getLog();

		if (log != null) {
			log.setErrorCode(e.getCode());
			log.setErrorMessage(errorSource.getMessage(e.getCode(), null, Locale.getDefault()));

			Logger errorLogger = LoggerFactory.getLogger("error");
			if (errorLogger.isErrorEnabled()) {
				errorLogger.error("LOG_ID=" + log.getLogId(), e);
			}
		}

		return model;
	}
	
	private static boolean isNull(String str){
		return str == null || str.trim().length() == 0;
	}
}
