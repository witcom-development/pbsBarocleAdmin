package com.dkitec.barocle.admin.maintenance.check.lock.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.admin.login.vo.UserSessionVO;
import com.dkitec.barocle.admin.maintenance.check.lock.service.CheckLockService;
import com.dkitec.barocle.admin.maintenance.check.lock.vo.CheckLockVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.HttpUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="CheckLockController")
public class CheckLockController extends BaseController {
	protected static Logger log = LoggerFactory.getLogger(CheckLockController.class);
	@Resource(name="checkLockService")
	
	private CheckLockService checkLockService;
	
	private static final String RETURN_URL = "/admin/maintenance/check/lock/";

	@RequestMapping(value="/checkLockList.do")
	@RequestName(value="getCheckLockList")
	public String getCheckLockList(@ModelAttribute @Valid CheckLockVO checkLockVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("che_std_list");
		String bizName = "거치대 점검관리 화면";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			if(checkLockVo.getViewFlg().equals(MODE_EXCEL)){
				checkLockVo.setPagingYn("N");
			}else{
				checkLockVo.setPagingYn("Y");
			}
			
			/*checkLockVo.setPagingYn("Y");*/
			
			if(checkLockVo.getChkType() == null){
				checkLockVo.setChkType("S");
			}

			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			
			if(checkLockVo.getSearchBgnDe() == null && checkLockVo.getSearchEndDe() == null){
				checkLockVo.setSearchEndDe(sdf.format(cal.getTime()));
				cal.add(Calendar.DAY_OF_MONTH, -6);
				checkLockVo.setSearchBgnDe(sdf.format(cal.getTime()));
			}
			
			int totCnt = checkLockService.getCheckLockListCount(checkLockVo);
			PaginationInfo paginationInfo = getPagingInfo(checkLockVo.getCurrentPageNo(), totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(checkLockVo.getCurrentPageNo(), totCnt);
			
			checkLockVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			checkLockVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<CheckLockVO> resultList = checkLockService.getCheckLockList(checkLockVo);
					
			model.addAttribute("searchCondition", checkLockVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("CheckLockList", resultList);
			
			if(checkLockVo.getViewFlg().equals(MODE_EXCEL)) {
				resultPage = RETURN_URL.concat("che_std_list_excel");
    		}
			
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.maintenance.che_std_list");
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}

	@RequestMapping(value="/exeLockSelectCheck.do")
	@RequestName(value="exeLockSelectCheck")
	public String exeLockSelectCheck(@ModelAttribute @Valid CheckLockVO checkLockVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		
		String bizName = "거치대 선택점검";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        
        try {
        	UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
            if(userSessionVO == null){
            	throw new CfoodException(getMessage("error.invalidSession"));
            }
            checkLockVo.setModId(userSessionVO.getUsrId());
            
			checkLockService.exeLockSelectCheck(checkLockVo);
            
			model.addAttribute(RESULT_MESSAGE, "Success");
			model.addAttribute(CHECK_RESULT, 0);
		} catch (Exception e) {
			throw new CfoodException("admin.system.maintenance.exeLockSelectCheck");
		}
		return JSONVIEW;
	}
	
	@RequestMapping(value="/exeLockAllCheck.do")
	@RequestName(value="exeLockAllCheck")
	public String exeLockAllCheck(@ModelAttribute @Valid CheckLockVO checkLockVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		
		String bizName = "거치대 전체점검";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			checkLockVo.setPagingYn("N");
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			if(checkLockVo.getSearchBgnDe() == null && checkLockVo.getSearchEndDe() == null){
				checkLockVo.setSearchEndDe(sdf.format(cal.getTime()));
				cal.add(Calendar.DAY_OF_MONTH, -6);
				checkLockVo.setSearchBgnDe(sdf.format(cal.getTime()));
			}
			
			List<CheckLockVO> resultList = checkLockService.getCheckLockList(checkLockVo);

			UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
			if(userSessionVO == null){
				throw new CfoodException(getMessage("error.invalidSession"));
			}
			
			checkLockVo.setModId(userSessionVO.getUsrId());
			checkLockService.exeLockAllCheck(checkLockVo, resultList);
            
			model.addAttribute(RESULT_MESSAGE, "Success");
			model.addAttribute(CHECK_RESULT, 0);
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.maintenance.exeLockAllCheck");
		}

		return JSONVIEW;
	}
}
