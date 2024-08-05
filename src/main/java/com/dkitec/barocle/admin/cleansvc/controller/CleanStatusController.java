package com.dkitec.barocle.admin.cleansvc.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.dkitec.barocle.admin.cleansvc.service.CleanStatusService;
import com.dkitec.barocle.admin.cleansvc.vo.CleanStatusExcelVO;
import com.dkitec.barocle.admin.cleansvc.vo.CleanStatusVO;
import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.admin.login.vo.UserSessionVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.HttpUtil;


@Controller
@RequestCategory(value="CleanStatusController")
public class CleanStatusController extends BaseController {
	protected static Logger log = LoggerFactory.getLogger(CleanStatusController.class);
	
	private static final String RETURN_URL = "/admin/cleansvc/";
	
	@Resource(name="CleanStatusService") private CleanStatusService cleanStatusService;
	
	@RequestMapping(value = "/cleanStatus.do")
	@RequestName("cleanStatus")
	public String cleanStatus(@ModelAttribute @Valid CleanStatusVO cleanVO, HttpServletRequest request,ModelMap model) throws Exception{
		String targetUrl = RETURN_URL.concat("cleanStatus");
		String bizName = "방역단 근태관리 화면";
		HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력
		
		boolean result = false;
		
		try {
			userSessionVO = (UserSessionVO) EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
			
			cleanVO.setAdminId(userSessionVO.getUsrId());
			cleanVO.setReg_id(userSessionVO.getUsrId());
			cleanVO.setClean_type("A");
			
			List<CleanStatusVO> r_cvo_a = cleanStatusService.getLastClean(cleanVO); 
			model.addAttribute("cleanListA", r_cvo_a);
			
			cleanVO.setClean_type("B");
			List<CleanStatusVO> r_cvo_b = cleanStatusService.getLastClean(cleanVO); 
			model.addAttribute("cleanListB", r_cvo_b);
			
			//CleanStatusVO r_cvo = new CleanStatusVO();
			
			
			/*
			testVO.setObj(testLogicService.testService());			 
			System.out.println(testVO.getObj());
			model.addAttribute("test", testVO.getObj());
			*/
			result = true;
		} catch (CfoodException e) {
			throw new CfoodException("admin.cleansvc.CleanStatus", e.getMessage());
		}
		
		return result ? targetUrl : ERROR_PAGE;
	}
	
	
	@RequestMapping(value = "/cleanStatusList.do")
	@RequestName("cleanStatusList")
	public String cleanStatusList(@ModelAttribute @Valid CleanStatusVO cleanVO1, HttpServletRequest request,ModelMap model) throws Exception{
		String targetUrl = RETURN_URL.concat("cleanStatusList");
		String bizName = "방역단 근태목록 화면";
		HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력
		
		boolean result = false;
		
		try {
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");			
			
			
			if(cleanVO1.getSearchBgnDe() == null && cleanVO1.getSearchEndDe() == null){
			
				cleanVO1.setSearchEndDe(sdf.format(cal.getTime()));		
				cal.add(Calendar.DAY_OF_MONTH, -6);
				cleanVO1.setSearchBgnDe(sdf.format(cal.getTime()));
			}
			
			if(cleanVO1.getClean_type() == null && cleanVO1.getClean_type() == null){
				cleanVO1.setClean_type("A");
			}
			//cleanVO1.setReg_id("");
			
			
			List<CleanStatusVO> r_cvo_ = cleanStatusService.getLastClean(cleanVO1); 
			
			model.addAttribute("cleanListA", r_cvo_);			
			model.addAttribute("searchCondition", cleanVO1);
			result = true;
		} catch (CfoodException e) {
			throw new CfoodException("admin.cleansvc.CleanStatusList", e.getMessage());
		}
		
		return result ? targetUrl : ERROR_PAGE;
	}
	
	@RequestMapping(value = "/cleanStatusExcelList.do")
	@RequestName("cleanStatusList")
	public String cleanStatusExcelList(@ModelAttribute @Valid CleanStatusVO cleanVO1, HttpServletRequest request,ModelMap model) throws Exception{
		String targetUrl = RETURN_URL.concat("cleanStatusExcelList");
		String bizName = "방역단 근태목록 화면";
		HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력
		
		boolean result = false;
		
		try {
			String statMonth = "";
			
			if ( cleanVO1.getSearchBgnDe() == "" || cleanVO1.getSearchBgnDe() == null ) {
				Calendar cal = Calendar.getInstance();
				int nowYear = cal.get(Calendar.YEAR);
				int nowMonth = cal.get(Calendar.MONTH) + 1;
				
				statMonth = nowYear + "-" + nowMonth;
			} else {
				statMonth = cleanVO1.getSearchBgnDe().substring(0,7);
			}
			
			model.addAttribute("statMonth", statMonth);
			
			List<CleanStatusExcelVO> r_cvo_ = cleanStatusService.getLastCleanExcel(cleanVO1); 
			model.addAttribute("cleanListA", r_cvo_);			
			model.addAttribute("searchCondition", cleanVO1);
			result = true;
		} catch (CfoodException e) {
			throw new CfoodException("admin.cleansvc.CleanStatusList", e.getMessage());
		}
		
		
		return result ? targetUrl : ERROR_PAGE;
	}
	
	
	
	@RequestMapping(value = "/cleanStatusDetail.do")
	@RequestName("cleanStatusDetail")
	public String cleanStatusDetail(@ModelAttribute @Valid CleanStatusVO cleanVO, HttpServletRequest request,ModelMap model) throws Exception{
		String targetUrl = RETURN_URL.concat("cleanStatusDetail");
		String bizName = "방역단 근태상세 화면";
		HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력
		
		boolean result = false;
		
		try {
			userSessionVO = (UserSessionVO) EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");			
			cleanVO.setAdminId(userSessionVO.getUsrId());
			cleanVO.setReg_id(userSessionVO.getUsrId());
			/*
			testVO.setObj(testLogicService.testService());			 
			System.out.println(testVO.getObj());
			model.addAttribute("test", testVO.getObj());
			*/
			model.addAttribute("cVO", cleanVO);
			result = true;
		} catch (CfoodException e) {
			throw new CfoodException("admin.cleansvc.CleanStatusDetail", e.getMessage());
		}
		
		return result ? targetUrl : ERROR_PAGE;
	}
	
	
	@RequestMapping(value = "/cleanNotice.do")
	@RequestName("cleanNotice")
	public String cleanNotice(@ModelAttribute @Valid CleanStatusVO cleanVO, HttpServletRequest request,ModelMap model) throws Exception{
		String targetUrl = RETURN_URL.concat("cleanStatusNotice");
		String bizName = "방역단준수사항";
		HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력
		
		boolean result = false;
		
		try {
			
			
			
			result = true;
		} catch (CfoodException e) {
			throw new CfoodException("admin.cleansvc.CleanStatusNotice", e.getMessage());
		}
		
		return result ? targetUrl : ERROR_PAGE;
	}
	
	
	
	@RequestMapping(value = "/cleanStatusReg.do")
	@RequestName("cleanStatusReg")
	public String cleanStatusReg(@ModelAttribute @Valid CleanStatusVO cleanVO, HttpServletRequest request,ModelMap model) throws Exception{
		String targetUrl = RETURN_URL.concat("cleanStatusDetail");
		String bizName = "방역단근태입력";
		HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력
		
		boolean result = false;
		int rt = -1;
		
		model.addAttribute(CHECK_RESULT, rt);
		try {
			
			userSessionVO = (UserSessionVO) EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");			
			cleanVO.setAdminId(userSessionVO.getUsrId());
			cleanVO.setReg_id(userSessionVO.getUsrId());
			
			Date dt = new Date();
			SimpleDateFormat sDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			SimpleDateFormat sDateDt = new SimpleDateFormat("yyyy-MM-dd");
			
				
			
			cleanVO.setReg_dttm(sDate.format(dt));
			cleanVO.setReg_dt(sDateDt.format(dt));
			rt = cleanStatusService.insertClean(cleanVO);
			
			model.addAttribute(CHECK_RESULT, rt);			
			
			
		} catch (CfoodException e) {
			throw new CfoodException("admin.cleansvc.CleanStatusReg", e.getMessage());		
			
		}
		
		return JSONVIEW;
	}
	
}
