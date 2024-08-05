/*
 * @Package Name : com.dkitec.barocle.admin.manage.DeviceMgmt.controller
 * @파일명          : DeviceMgmtController.java
 * @작성일          : 2015. 4. 15.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 15.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.manage.deviceMgmt.terminal.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.admin.login.vo.UserSessionVO;
import com.dkitec.barocle.admin.manage.deviceMgmt.bike.vo.BikeVO;
import com.dkitec.barocle.admin.manage.deviceMgmt.terminal.service.TerminalService;
import com.dkitec.barocle.admin.manage.deviceMgmt.terminal.vo.TerminalVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.DateUtil;
import com.dkitec.barocle.util.webutil.HttpUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * @파일명          : DeviceMgmtController.java
 * @작성일          : 2015. 4. 15.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 15.   |   ymshin   |  최초작성
 */
@Controller
@RequestCategory(value="TerminalController")
public class TerminalController extends BaseController {
	
	protected static Logger log = LoggerFactory.getLogger(TerminalController.class);
	private static final String TARGET_URL = "/admin/manage/service/dev/";
	
	@Resource(name="terminalService") private TerminalService terminalService;
	
	@RequestMapping(value = "/getTerminalList.do")
	@RequestName("getTerminalList")
	public String getTerminalList(@ModelAttribute @Valid TerminalVO terminalVo, BindingResult bResult, HttpServletRequest request,ModelMap model) throws Exception {
		
		String targetUrl = TARGET_URL.concat("opr_dev_list");
    	String bizName = "단말기 조회 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        boolean result = false;
        String todayDate = DateUtil.getSystemDate("yyyy-MM-dd");
        if (terminalVo.getSearchBgnDe() == null || terminalVo.getSearchBgnDe() == ""){
        	terminalVo.setSearchBgnDe(todayDate.substring(0, 4)+"-01-01");
        }
        if (terminalVo.getSearchEndDe() == null || terminalVo.getSearchEndDe() == ""){
        	terminalVo.setSearchEndDe(todayDate);
        }
        try {
        	if(terminalVo.getViewFlg().equals(MODE_EXCEL)) {
    			terminalVo.setPagingYn("N");
    		}
    		
    		int totCnt = terminalService.getTerminalListCount(terminalVo);
    		PaginationInfo paginationInfo = getPagingInfo(terminalVo.getCurrentPageNo(), totCnt);
    		PaginationInfo paginationMobileInfo = getPagingMobileInfo(terminalVo.getCurrentPageNo(), totCnt);
    		terminalVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
    		terminalVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
    		
    		List<BikeVO> resultList = terminalService.getTerminalList(terminalVo);
    		
    		model.addAttribute("searchCondition",terminalVo );
    		model.addAttribute("paginationInfo", paginationInfo);
    		model.addAttribute("paginationMobileInfo",paginationMobileInfo);
    		model.addAttribute("terminalList", resultList);
    	
    		if(terminalVo.getViewFlg().equals(MODE_EXCEL)) {
    			targetUrl = TARGET_URL.concat("opr_dev_list_excel");
    		}
    		result = true;
		} catch (Exception e) {
			throw new CfoodException(getMessage("fail.common.msg"));
		}
        
		return result ? targetUrl : ERROR_PAGE;
	}
	@RequestMapping(value = "/moveTerminalEditForm.do")
	@RequestName("moveTerminalEditForm")
	public String moveTerminalEditForm(@ModelAttribute @Valid TerminalVO terminalVo, BindingResult bResult, HttpServletRequest request,ModelMap model) throws Exception {
		
		String bizName = "단말기 등록,수정 화면 이동";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        boolean result = false;
        
        try {
        	TerminalVO resultVo = null;
        	List<TerminalVO> infoList = new ArrayList<TerminalVO>();
        	if(terminalVo.getViewFlg().equals(CRUD_C)) {
        		resultVo = new TerminalVO();
        	} else {
        		resultVo = terminalService.getTerminalInfo(terminalVo);
        		infoList = terminalService.getTerminalAndBikeHistory(terminalVo);
        	}
        	
        	model.addAttribute("terminal"     , terminalVo);
        	model.addAttribute("infoList"     , infoList);
        	model.addAttribute("terminalVo"   , resultVo);
        	model.addAttribute("searchCondition", terminalVo);
        	result = true;
		} catch (CfoodException e) {
			throw new CfoodException(getMessage("fail.common.msg"));
		}
		
		return result ? TARGET_URL.concat("opr_dev_detail") : ERROR_PAGE;
	}

	@RequestMapping(value="/terminalDataEditExe.do")
	public String TerminalDataEditExe(@ModelAttribute @Valid TerminalVO terminalVo,  BindingResult bResult,ModelMap model, HttpServletRequest request ) throws Exception {
		
	    String bizName = "단말기 등록,수정 ";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        
        UserSessionVO userSessionVo = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
        String admin = userSessionVo == null ? "test" :userSessionVo.getUsrId();
        int result = 0;
        String resultMessage = "저장에 성공했습니다.";
        try {
        	List<ObjectError> allError = bResult.getAllErrors();
        	if(allError.size() > 0) {
        		for(ObjectError err : allError) {
        			resultMessage = err.getDefaultMessage();
        		}
        	} else {
        		if(terminalVo.getViewFlg().equals(CRUD_C)) {
        			result = terminalService.addNewTerminalData(terminalVo,admin);
        		} else {
        			result = terminalService.setTerminalData(terminalVo, admin);
        		}
        	}
		} catch (Exception e) {
			throw new CfoodException(getMessage("fail.common.msg"));
		}
		model.addAttribute(RESULT_MESSAGE, resultMessage);
		model.addAttribute(CHECK_RESULT, result);
		return JSONVIEW;
	}
	
	@RequestMapping(value="/terminal/dupIdCheckAjax.do")
	@RequestName("moveTerminalEditForm")
	public String dupIdCheckAjax(TerminalVO terminalVo, ModelMap model, HttpServletRequest request ) throws Exception {
		String bizName = "단말기Id 중복 체크 ";
	    HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
	    
		boolean isDup = false;
		isDup = terminalService.isChkIdDup(terminalVo);
		model.addAttribute("isDup", String.valueOf(isDup));
		return JSONVIEW;
	}
}
