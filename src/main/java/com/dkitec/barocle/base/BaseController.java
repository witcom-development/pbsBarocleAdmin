package com.dkitec.barocle.base;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.context.MessageSource;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.barocle.admin.login.vo.UserSessionVO;
import com.dkitec.barocle.util.webutil.StringUtil;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

public class BaseController implements IConstants {

    @Autowired
    protected MessageSource messageSource;
    
    /** EgovPropertyService */
	@Resource(name = "propertiesService") protected EgovPropertyService propertiesService;
	protected UserSessionVO userSessionVO = null;
	
    public String getMessage(String messageCode) {
    	return this.getMessage(messageCode, null);
    }
    
    public String getMessage(String messageCode, Object[] messageParam) {
    	return messageSource.getMessage(messageCode, messageParam, Locale.getDefault());
    }
    
    public static Map<String, String> READ_AUTH_MAP() {
		Map<String, String> map = new LinkedHashMap<String, String>();
		map.put(READ_AUTH_ALL, "관리자");
		map.put(READ_AUTH_MANAGE, "사업팀");
		map.put(READ_AUTH_SERVICE, "제휴사");
		return map;
	}
    
    public String getResultCode(String messageCode) {
    	return messageSource.getMessage("result." + messageCode, null, Locale.getDefault());
    }
    
    public Map<String,String> getJusoKey(){
    	Map<String,String> returnValue = new HashMap<String,String>();
    	returnValue.put("jusoKey",propertiesService.getString("jusoKey"));
    	returnValue.put("jusoPublicZone",propertiesService.getString("jusoPublicZone"));
    	returnValue.put("jusoPrivateZone",propertiesService.getString("jusoPrivateZone"));
    	return returnValue;
    }
    
    /*
     * yyyy-MM-dd 형식의 날짜 값은 java.util.Date 변수에 setValue 하기 위한 메소드
     */
	@InitBinder
	protected void initBinder(WebDataBinder webDataBinder) {
		java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat(DATE_FORMAT);
		dateFormat.setLenient(false);
		webDataBinder.registerCustomEditor(java.util.Date.class, new CustomDateEditor(dateFormat, true));
	}
    
	/* 
	 * 정의된 검색 조건의 내용을 파라미터값으로 전송한다.
	 * HttpServletRequest의 내용을 "&[파라미터명]=[파라미터값]"으로 만들어 준다.
	 */
	protected static String setGivenParameterValue(HttpServletRequest request, String[] str) throws Exception {
		@SuppressWarnings("rawtypes") java.util.Enumeration parameterNames = request.getParameterNames();
		StringBuffer stringBuffer = new StringBuffer();
		String tempParameterName, tempParameterValue;
		try {
			while(parameterNames.hasMoreElements()){
				tempParameterName = String.valueOf(parameterNames.nextElement());
				tempParameterValue = (String)request.getParameter(tempParameterName);
				for(String compareValue : str){
					if(tempParameterName.equals(compareValue)&&!StringUtil.isEmpty(tempParameterValue)){
						stringBuffer.append("&" + tempParameterName + "=" + tempParameterValue);
					}
				}
			}
		} catch (Exception ce) {
			throw new CfoodException("com.dkitec.barocle.base.BaseController.setGivenParameterValue");
		}
		return stringBuffer.toString();
	}
	
	/*
	 * @Validated을 검사하여 오류가 존재하면 해당 오류 코드와 메시지를 출력한다.
	 * 메시지는 우선순위
	 * 1. VO파일에 정의한 에러 메시지
	 * 2. /ValidationMessages.properties에 정의한 메시지 
	 */
	protected Map<String,String> setResultMessage(BindingResult result) {
		Map<String,String> errorMap = new HashMap<String,String>();
		try {
			errorMap.put("errorCode", result.getFieldError().getCode());
			if("com.dkitec.barocle.util.validator.SearchDateValidator".equals(result.getFieldError().getCode())){
				errorMap.put("errorMessage", messageSource.getMessage("com.dkitec.barocle.util.validator.SearchDateValidator", null, Locale.getDefault()));
			} else errorMap.put("errorMessage", result.getFieldError().getDefaultMessage());
		} catch (Exception ce) {
			throw new CfoodException("com.dkitec.barocle.base.BaseController.setResultMessage",ce);
		}
		return errorMap;
	}
    
	protected PaginationInfo getPagingInfo(int currentPageNo, int totalRecordCount) {
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(currentPageNo==0 ? 1 : currentPageNo);
		paginationInfo.setRecordCountPerPage(propertiesService.getInt("pageUnit"));
		paginationInfo.setPageSize(propertiesService.getInt("pageSize"));
		paginationInfo.setTotalRecordCount(totalRecordCount);
		return paginationInfo;
	}
	
	protected PaginationInfo getPagingMobileInfo(int currentPageNo, int totalRecordCount) {
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(currentPageNo==0 ? 1 : currentPageNo);
		paginationInfo.setRecordCountPerPage(propertiesService.getInt("pageUnit"));
		paginationInfo.setPageSize(propertiesService.getInt("pageMobileSize"));
		paginationInfo.setTotalRecordCount(totalRecordCount);
		return paginationInfo;
	}
	
    protected PaginationInfo getPagingInfo(int currentPageNo, int recordCountPerPage, int pageSize, int totalRecordCount) {
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(currentPageNo==0 ? 1 : currentPageNo);
		paginationInfo.setRecordCountPerPage(recordCountPerPage);
		paginationInfo.setPageSize(pageSize);
		paginationInfo.setTotalRecordCount(totalRecordCount);
		return paginationInfo;
	}
    /*
     * 2019.03.14 추가
     */
	protected PaginationInfo getPagingMobileInfo(int currentPageNo, int recordCountPerPage, int pageSize, int totalRecordCount) {
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(currentPageNo==0 ? 1 : currentPageNo);
		paginationInfo.setRecordCountPerPage(recordCountPerPage);
		paginationInfo.setPageSize(pageSize);
		paginationInfo.setTotalRecordCount(totalRecordCount);
		return paginationInfo;
	}
    
    protected static List<String> getEditorImageList(String strArray) throws Exception{
    	List<String> returnList = new LinkedList<String>();
		JSONArray jsonArray = new JSONArray("[" + strArray + "]");
		for(int i=0; i<jsonArray.length(); i++){
			returnList.add(jsonArray.getJSONObject(i).getString("filename"));
		}
     	return returnList;
    }
    
}
