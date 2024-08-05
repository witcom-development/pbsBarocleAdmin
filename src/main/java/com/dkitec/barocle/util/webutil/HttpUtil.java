package com.dkitec.barocle.util.webutil;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;

public class HttpUtil {
	/**
	 * 메소드 설명을 삽입하십시오. 작성 날짜: (2003-09-24 오후 6:08:47)
	 * 
	 * @return java.lang.String
	 * @param parameters
	 *            java.util.Vector
	 * @param index
	 *            int
	 */
	public static String getParameter(String[] parameters, int index) {

		return getParameter(parameters, index, null);
	}

	/**
	 * 메소드 설명을 삽입하십시오. 작성 날짜: (2003-09-24 오후 6:08:47)
	 * 
	 * @return java.lang.String
	 * @param parameters
	 *            java.util.Vector
	 * @param index
	 *            int
	 */
	public static String getParameter(String[] parameters, int index,
			String defaultString) {

		if (parameters != null && index < parameters.length) {
			return (String) parameters[index];
		} else {
			return defaultString;
		}
	}

	/**
	 * 메소드 설명을 삽입하십시오. 작성 날짜: (2003-09-24 오후 6:08:47)
	 * 
	 * @return java.lang.String
	 * @param parameters
	 *            java.util.Vector
	 * @param index
	 *            int
	 */
	public static String getParameter(Vector parameters, int index) {

		return getParameter(parameters, index, null);
	}

	/**
	 * 메소드 설명을 삽입하십시오. 작성 날짜: (2003-09-24 오후 6:08:47)
	 * 
	 * @return java.lang.String
	 * @param parameters
	 *            java.util.Vector
	 * @param index
	 *            int
	 */
	public static String getParameter(Vector parameters, int index,
			String defaultString) {

		if (parameters != null && index < parameters.size()) {
			return (String) parameters.elementAt(index);
		} else {
			return defaultString;
		}
	}

	/**
	 * request로부터 parameterName에 해당하는 값을 얻어오는데<br>
	 * 만일에 존재하지 않으면 defaultValue로 대체해서 리턴한다.
	 */
	public static String getParameter(HttpServletRequest request,
			String parameterName, String defaultValue) {
		String paramValue = request.getParameter(parameterName);
		if (paramValue == null || paramValue.length() == 0)
			paramValue = defaultValue;
		return paramValue;
	}

	/**
	 * isParameterRequired이 true이면<br>
	 * request에서 꺼내온 것이 null일 경우 Exception 발생한다.<br>
	 * null이면 안되는 파라메터인 경우에 사용한다.<br>
	 * ex) String temp = LCUtil.getParameter(request,"TEMP",true);
	 */
	public static String getParameter(HttpServletRequest request,
			String parameterName, boolean isParameterRequired) throws Exception {
		String paramValue = request.getParameter(parameterName);

		if ((isParameterRequired) && (paramValue == null))
			throw new Exception("Parameter " + parameterName
					+ " was not specified.");

		return paramValue;
	}


	/**
	 * 메소드 설명을 삽입하십시오. 작성 날짜: (2002-11-12 오후 12:38:55)
	 * 
	 * @return java.lang.String
	 * @param request
	 *            javax.servlet.http.HttpServletRequest
	 */
	public static String getParameterString(HttpServletRequest request) {
		Enumeration parameterKeys = request.getParameterNames();
		StringBuffer parameterString = new StringBuffer();
		while (parameterKeys.hasMoreElements()) {
			String keyName = (String) parameterKeys.nextElement();
			String value = request.getParameter(keyName);
			parameterString.append("&").append(keyName).append("=")
					.append(value);
		}

		String urlParameters = (request.getQueryString() != null || parameterString
				.length() > 0) ? "?" : "";

		// if(request.getQueryString() != null) urlParameters +=
		// request.getQueryString();

		if (urlParameters.length() < 2 && parameterString.length() > 1)
			parameterString.deleteCharAt(0);

		urlParameters += parameterString.toString();

		return urlParameters;
	}

	/**
	 * request로부터 parameterName에 해당하는 값을 얻어오는데<br>
	 * 만일에 존재하지 않으면 defaultValue로 대체해서 리턴한다.
	 */
	public static String[] getParameterValues(HttpServletRequest request,
			String parameterName, String[] defaultValue) {
		String[] paramValue = request.getParameterValues(parameterName);
		if (paramValue == null)
			paramValue = defaultValue;
		return paramValue;
	}

	/**
	 * isParameterRequired이 true이면<br>
	 * request에서 꺼내온 것이 null일 경우 Exception 발생한다.<br>
	 * null이면 안되는 파라메터인 경우에 사용한다.<br>
	 * ex) String[] temp = LCUtil.getParameterValues(request,"TEMP",true);
	 */
	public static String[] getParameterValues(HttpServletRequest request,
			String parameterName, boolean isParameterRequired) throws Exception {
		String[] paramValue = request.getParameterValues(parameterName);

		if ((isParameterRequired) && (paramValue == null))
			throw new Exception("Parameter " + parameterName
					+ " was not specified.");

		return paramValue;
	}
	/**
	 * request.getAttribute()
	 * request로부터 parameterName에 해당하는 값을 얻어오는데 만일에
	 * 존재하지 않으면 defaultValue로 대체해서 리턴한다.
	 * 작성 날짜: (2001-08-23 오전 10:58:01)
	 * @return java.lang.Object
	 * @param request javax.servlet.http.HttpServletRequest
	 * @param parameterName String
	 * @param defaultValue Object
	 */
	public static Object getAttribute(HttpServletRequest request,String parameterName,Object defaultValue) {
	    Object paramValue = request.getAttribute(parameterName);
	    if (paramValue == null) paramValue = defaultValue;
	    if (paramValue.equals("null")) paramValue = defaultValue;
	    if (paramValue.equals("")) paramValue = defaultValue;
	    return paramValue;
	}
	/**
	 * request.getAttribute()
	 * isParameterRequired이 true이면
	 * request에서 꺼내온 것이 null일 경우 Exception 발생한다.
	 * null이면 안되는 파라메터인 경우에 사용한다.
	 * ex) String temp = (String)LCUtil.getAttribute(request,"TEMP",true);
	 * @return java.lang.Object
	 * @param request javax.servlet.http.HttpServletRequest
	 * @param parameterName String
	 * @param isParameterRequired boolean
	 */
	public static Object getAttribute(HttpServletRequest request,String parameterName,boolean isParameterRequired)
	    throws Exception {
	    Object paramValue = request.getAttribute(parameterName);

	    if ((isParameterRequired) && (paramValue == null))
	        throw new Exception("Parameter " + parameterName + " was not specified.");

	    return paramValue;
	}
	/**
	 * session.getAttribute()
	 * session로부터 parameterName에 해당하는 값을 얻어오는데 만일에
	 * 존재하지 않으면 defaultValue로 대체해서 리턴한다.
	 * 작성 날짜: (2001-08-23 오전 10:58:01)
	 * @return java.lang.Object
	 * @param session javax.servlet.http.HttpSession
	 * @param parameterName String
	 * @param defaultValue Object
	 */
	public static Object getAttribute(HttpSession session,String parameterName,Object defaultValue) {
	    Object paramValue = session.getAttribute(parameterName);
	    if (paramValue == null) paramValue = defaultValue;
	    return paramValue;
	}
	/**
	 * session.getAttribute()
	 * isParameterRequired이 true이면
	 * session에서 꺼내온 것이 null일 경우 Exception 발생한다.
	 * null이면 안되는 파라메터인 경우에 사용한다.
	 * @return java.lang.Object
	 * @param session javax.servlet.http.HttpSession
	 * @param parameterName String
	 * @param isParameterRequired boolean
	 */
	public static Object getAttribute(HttpSession session,String parameterName,boolean isParameterRequired)
	    throws Exception {
	    Object paramValue = session.getAttribute(parameterName);

	    if ((isParameterRequired) && (paramValue == null))
	        throw new Exception("Parameter " + parameterName + " was not specified.");

	    return paramValue;
	}
	/**
	 * request에서 서버의 이름을 가져오는 함수
	 * 
	 * @param request
	 *            사용자 요청
	 * @return 서버이름
	 */
	public static String getServerName(HttpServletRequest request)
			throws Exception {

		String strURL = request.getRequestURL().toString();

		int iStart = (strURL.indexOf("http://") != -1) ? "http://".length() : 0;
		int iEnd = 0;

		if (strURL.indexOf(":", iStart) != -1) {
			iEnd = strURL.indexOf(":", iStart);
		} else if (strURL.indexOf("/", iStart) != -1) {
			iEnd = strURL.indexOf("/", iStart);
		} else {
			iEnd = strURL.length();
		}

		return strURL.substring(iStart, iEnd);
	}
	
	public static HashMap getRequestMap(HttpServletRequest request) {

        HashMap map = new HashMap();
        try {
            Map parameter = request.getParameterMap();

            if (parameter == null)
                return null;

            Iterator it = parameter.keySet().iterator();
            Object paramKey = null;
            String[] paramValue = null;
 
            while (it.hasNext()) {
                paramKey = it.next();
                paramValue = (String[]) parameter.get(paramKey);

                String strKey = paramKey.toString();
                if (paramValue.length > 1) {
                	String[] arrVal = request.getParameterValues(paramKey.toString());
                	
                	for (int nLoop = 0; nLoop < arrVal.length; nLoop ++)
                	{
                	    arrVal[nLoop] = StringUtil.removeXSS(arrVal[nLoop]);
                	}
                	
                    map.put(strKey, arrVal);
                } else {
                    map.put(strKey, (paramValue[0] == null) ? "" : StringUtil.removeXSS(paramValue[0].trim()));
                }
            }
            return map;
        } catch (Exception e) {
            System.out.println("HttpUtil getRequestMap()" + e.toString());
            return null;
        }
    }
	
	/*
	 *  요청 URL + 파라메터 찍기
	 *  2013.11.05
	 *  강산오
	 */
	public static String getRequestUriAndParam(HttpServletRequest request) {
		// 1. getParameter 데이터 처리
		StringBuffer sb = new StringBuffer(request.getRequestURL() + "?");
		
		Map<String, Object> reqMap = new HashMap<String, Object>();
		Map<String, Object> attrMap = new HashMap<String, Object>();
		
		@SuppressWarnings("rawtypes")
		Enumeration paramEnum =  request.getParameterNames();
		int index = 0;
		while(paramEnum.hasMoreElements()) {
			String name = (String)paramEnum.nextElement();
			
			if("member_pw".equals(name) || "admin_pw".equals(name)) {
				continue;
			}
			
			if(index == 0) {
				sb.append(name + "=" + request.getParameter(name));
			} else {
				sb.append("&" + name + "=" + request.getParameter(name));
			}
			reqMap.put(name, request.getParameter(name));
			index++;
		}
		
		// 1. getParameter 데이터가 없으면 getAttribute 데이터 처리
		if(index == 0) {
			@SuppressWarnings("rawtypes")
			Enumeration attrEnum =  request.getAttributeNames();
			while(attrEnum.hasMoreElements()) {
				String name = (String)attrEnum.nextElement();
				
				if("member_pw".equals(name) || "admin_pw".equals(name)) {
					continue;
				}
				
				if(index == 0) {
					sb.append(name + "=" + request.getAttribute(name));
				} else {
					sb.append("&" + name + "=" + request.getAttribute(name));
				}
				attrMap.put(name, request.getAttribute(name));
				index++;
			}
		}
		
		return "★★★★" + "reqMap:" + reqMap + ", attrMap:" + attrMap + " url:" + sb.toString();
	}
	
	/*
	 *  요청 URL + 파라메터 찍기
	 *  2013.11.05
	 *  강산오
	 */
	public static String getRequestUriAndParamLog(HttpServletRequest request) {
		// 1. getParameter 데이터 처리
		StringBuffer sb = new StringBuffer(request.getRequestURL() + "?");
		
		Map<String, Object> reqMap = new HashMap<String, Object>();
		Map<String, Object> attrMap = new HashMap<String, Object>();
		
		String usrId = "usrid";
		String password = "encP";
		String ctn = "ctn";
		String mpn = "mpn";
		String email = "email";
		String tel = "tel";
		String phone = "phone";
		
		@SuppressWarnings("rawtypes")
		Enumeration paramEnum =  request.getParameterNames();
		int index = 0;
		while(paramEnum.hasMoreElements()) {
			String name = (String)paramEnum.nextElement();
//			20140905 : 개인정보를 로그에 남기지 않기 위해 usrid, encP, ctn, mpn, email, tel, phone가 파라메터 명에 포함된 경우 내용을 로그에 남기지 않습니다.
			if(StringUtil.isMatch(usrId, name)
					|| StringUtil.isMatch(password, name)
					|| StringUtil.isMatch(ctn, name)
					|| StringUtil.isMatch(mpn, name)
					|| StringUtil.isMatch(email, name)
					|| StringUtil.isMatch(tel, name)
					|| StringUtil.isMatch(phone, name)) {
				continue;
			}
			
			if(index == 0) {
				sb.append(name + "=" + request.getParameter(name));
				//System.out.println(name + "=" + request.getParameter(name));
				
			} else {
				sb.append("&" + name + "=" + request.getParameter(name));
				//System.out.println(name + "=" + request.getParameter(name));
			}
			reqMap.put(name, request.getParameter(name));
			index++;
		}
		
		// 1. getParameter 데이터가 없으면 getAttribute 데이터 처리
//		if(index == 0) {
//			@SuppressWarnings("rawtypes")
//			Enumeration attrEnum =  request.getAttributeNames();
//			while(attrEnum.hasMoreElements()) {
//				String name = (String)attrEnum.nextElement();
//				
//				if("oprPasswd".equals(name)) {
//					continue;
//				}
//				
//				if(index == 0) {
//					sb.append(name + "=" + request.getAttribute(name));
//				} else {
//					sb.append("&" + name + "=" + request.getAttribute(name));
//				}
//				attrMap.put(name, request.getAttribute(name));
//				index++;
//			}
//		}
		
		return sb.toString();
	}
	
	/*
	 *  서비스로그 시작 출력
	 */
	public static void printServiceLogStart(String bizName, Logger log, HttpServletRequest request) {
		if(log.isInfoEnabled()) log.info("●● " + bizName + " START");
		
        if(log.isInfoEnabled()) log.info("●● 요청URL: " + getRequestUriAndParamLog(request));
		
//		20140827 파라미터에 개인정보 보유 하지 않도록  인해 파라메터는 남기지 않도록 수정합니다.
//		if(log.isInfoEnabled()) log.info("●● 요청URL: " + request.getRequestURL());
	}
	
	/*
	 *  서비스로그 끝 출력
	 */
	public static void printServiceLogEnd(String bizName, boolean bResult, String resultMsg, Logger log) {
		
		if(log.isInfoEnabled()) {
            if(bResult) {
                    log.info("●● 처리결과: OK");
            } else {
                    log.error("●● 처리결과: " + resultMsg);
            }
     }
     if(log.isInfoEnabled()) log.info("●● " + bizName + " END");
	}
	
	/*
	 * Ajax 요청인지 판단
	 */
	public static boolean isAjaxRequest(HttpServletRequest request) {
		boolean isAjax = false;
		
		String ajaxHeader = request.getHeader("X-Requested-With");
		String originHeader = request.getHeader("ORIGIN");
		
		if((ajaxHeader != null && "xmlhttprequest".equals(ajaxHeader.toLowerCase()))
				|| originHeader != null) {
			isAjax = true;
		}
		
		return isAjax;
	}
	
	
	
	
}
