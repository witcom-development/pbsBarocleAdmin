package com.dkitec.barocle.admin.login.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.dkitec.barocle.admin.board.distribute.service.DistributeBoardService;
import com.dkitec.barocle.admin.board.distribute.vo.DistributeBoardVO;
import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.admin.login.service.LoginService;
import com.dkitec.barocle.admin.login.vo.LoginHistoryVO;
import com.dkitec.barocle.admin.login.vo.MenuAuthVO;
import com.dkitec.barocle.admin.login.vo.UserSessionVO;
import com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.BikeService;
import com.dkitec.barocle.admin.manage.deviceMgmt.bike.vo.BikeVO;
import com.dkitec.barocle.admin.status.rentStatus.service.RentStatusService;
import com.dkitec.barocle.admin.status.rentStatus.vo.BikeRentalVO;
import com.dkitec.barocle.admin.status.stationStatus.controller.StationStatusController;
import com.dkitec.barocle.admin.status.stationStatus.service.StationStatusService;
import com.dkitec.barocle.admin.status.stationStatus.vo.StationStatusVO;
import com.dkitec.barocle.admin.system.MenuMgmt.service.MenuMgmtService;
import com.dkitec.barocle.admin.system.teammgmt.service.TeamMgmtService;
import com.dkitec.barocle.admin.system.teammgmt.vo.TeamMgmtVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.base.IConstants;
import com.dkitec.barocle.util.webutil.HttpUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="LoginController")
//@RequestMapping(value="/admin/login")
public class LoginController extends BaseController {
	protected static Logger log = LoggerFactory
			.getLogger(LoginController.class);

	@Resource(name = "loginService") private LoginService loginService;
	@Resource(name = "menuMgmtService") private MenuMgmtService menuMgmtService;
	@Resource(name="stationStatusService") private StationStatusService stationStatusService;	
	
	@RequestName(value="login")
	@RequestMapping(value = "/login.do")
	public String login(Model model) {
		model.addAttribute("mainPage", "Y");
		return "/admin/login/com_login";
	}
	
//////////////////////////분배팀 화면 리뉴얼 테스트 : 2020-11-20////////////////////////
	@Resource(name="rentStatusService") private RentStatusService rentStatusService;
	@Resource(name="bikeService") private BikeService bikeService;

	@Resource(name = "teamMgmtService") private TeamMgmtService teamService;
//////////////////////////분배팀 화면 리뉴얼 테스트 : 2020-11-20////////////////////////	
	
	
	@RequestName(value="getLoginInfo")
	@RequestMapping(value = "/main.do")
	public String getLoginInfo(UserSessionVO userSessionVO, LoginHistoryVO loginHistoryVO,
			BindingResult result, HttpServletRequest request,
			HttpServletResponse response, Model model) throws Exception {
 
		String resultPage = "/admin/login/com_login_suc";
		String bizName = "메인";
		HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력
		boolean bResult = false;
		userSessionVO = (UserSessionVO) EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
		if ( userSessionVO == null ) {
			bResult = false;
		} else {
			
			// 분배원의 경우 분배 화면로 이동
			if (  "5".equals( userSessionVO.getUsrGrpCd() ) ) {
				resultPage = "/admin/login/dist/com_login_suc_dist";
				model.addAttribute("distBoardList", distributeBoardService.listDistributeBunBae());
				model.addAttribute("parameterInfo",super.setGivenParameterValue(request,this.distributeSearchParameter));
				model.addAttribute("UserSessionVO", userSessionVO);
				bResult = true;
				
			} else {
				
				bResult = login(userSessionVO, loginHistoryVO, model, bResult);
				
			}
		}	
		return bResult ? resultPage : ERROR_PAGE;
		
	}
	

	private final String[] distributeSearchParameter = {"searchValue","searchStartDate","searchEndDate"};
	@Resource(name = "distributeBoardService") private DistributeBoardService distributeBoardService;
	@RequestName(value="moveBunBae")
	@RequestMapping(value = "/moveBunBae.do")
	public String moveBunBae(UserSessionVO userSessionVO, BindingResult result, HttpServletRequest request,
			HttpServletResponse response, Model model) throws Exception {

		userSessionVO = (UserSessionVO) EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");

		String resultPage = "/admin/login/dist/com_login_suc_dist";
		model.addAttribute("distBoardList", distributeBoardService.listDistributeBunBae());
		model.addAttribute("parameterInfo",super.setGivenParameterValue(request,this.distributeSearchParameter));
		model.addAttribute("UserSessionVO", userSessionVO);
		
		return  resultPage;
	}
	
	@RequestName(value="moveRound")
	@RequestMapping(value = "/moveRound.do")
	public String moveRound(UserSessionVO userSessionVO, BindingResult result, HttpServletRequest request,
			HttpServletResponse response, Model model) throws Exception {

		userSessionVO = (UserSessionVO) EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");

		String resultPage = "/admin/login/round/com_login_suc_round";
		model.addAttribute("distBoardList", distributeBoardService.listDistributeBunBae());
		model.addAttribute("parameterInfo",super.setGivenParameterValue(request,this.distributeSearchParameter));
		model.addAttribute("UserSessionVO", userSessionVO);
		
		return  resultPage;
	}

	@RequestName(value="moveMainPage")
	@RequestMapping(value = "/moveMainPage.do")
	public String moveMainPage(UserSessionVO userSessionVO, LoginHistoryVO loginHistoryVO,
			BindingResult result, HttpServletRequest request,
			HttpServletResponse response, Model model) throws Exception {
 
		String resultPage = "/admin/login/com_login_suc";
		String bizName = "메인";
		HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력
		boolean bResult = false;
		userSessionVO = (UserSessionVO) EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
		if ( userSessionVO == null ) {
			bResult = false;
		} else {
			bResult = login(userSessionVO, loginHistoryVO, model, bResult);
		}	
		return bResult ? resultPage : ERROR_PAGE;
	}
	 
	private boolean login(UserSessionVO userSessionVO, LoginHistoryVO loginHistoryVO, Model model, boolean bResult) {
		try { 
			loginHistoryVO.setUsrId(userSessionVO.getUsrId());
			// 로그인 이력 조회
			int sizeList = loginService
					.getLoginHistoryListCount(loginHistoryVO);
			PaginationInfo paginationInfo = getPagingInfo(loginHistoryVO.getCurrentPageNo(), sizeList);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(loginHistoryVO.getCurrentPageNo(), sizeList);
			loginHistoryVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			loginHistoryVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			List<LoginHistoryVO> resultList = loginService.getLoginHistoryList(loginHistoryVO);
			StationStatusVO wholeStatusTotCnt  = stationStatusService.getStationStatusTotCnt(IConstants.LANG_KR);
			model.addAttribute("wholeStatusTotCnt", wholeStatusTotCnt);
			model.addAttribute("UserSessionVO", userSessionVO);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo",paginationMobileInfo);
			model.addAttribute("LoginHistoryList", resultList);
			bResult = true; // 정상
	
		} catch (CfoodException ce) {
			throw new CfoodException("com.dkitec.barocle.admin.login.getLoginInfo");
		}
		return bResult;
	}
	
	
	@RequestName(value="redirectError")
	@RequestMapping(value = "/error.do")
	public String redirectError(UserSessionVO userSessionVO, LoginHistoryVO loginHistoryVO,
			BindingResult result, HttpServletRequest request,
			HttpServletResponse response, Model model) throws CfoodException {

		return "/admin/common/error";
	}
	
	@RequestName(value="noPermissions")
	@RequestMapping(value = "/noPermissions.do")
	public String noPermissions(MenuAuthVO menuAuthVO, BindingResult result, HttpServletRequest request,
			HttpServletResponse response, Model model) throws CfoodException {
		
		String resultPage = null;
		String bizName = "메인";
		HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력

		boolean bResult = false;
		String msgCode = null;
		
		try {
			msgCode = menuAuthVO.getMsgCode();
			
			if(msgCode.equals("NO_PERMISSIONS")){
				resultPage = "/admin/login/com_no_per";
			} else {
				resultPage = "/admin/login/com_not_page";
			}
		
			bResult = true; // 정상

		} catch (CfoodException ce) {
			throw new CfoodException("com.dkitec.barocle.admin.login.noPermissions");
		}
		
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	

	@RequestName(value="optCheck")
	@RequestMapping(value = "/optCheck.do")
	public String optCheck(MenuAuthVO menuAuthVO, BindingResult result, HttpServletRequest request,
			HttpServletResponse response, Model model) throws CfoodException {

		byte[] buffer = new byte[5 + 5 * 5];
		
		String resultPage = null;
		String bizName = "메인";
		HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력

		boolean bResult = false;
		String msgCode = null;
		
		try {
			msgCode = menuAuthVO.getMsgCode();
			
			if(msgCode.equals("NO_PERMISSIONS")){
				resultPage = "/admin/login/com_no_per";
			} else {
				resultPage = "/admin/login/com_not_page";
			}
		
			bResult = true; // 정상

		} catch (CfoodException ce) {
			throw new CfoodException("com.dkitec.barocle.admin.login.noPermissions");
		}
		
		return bResult ? resultPage : ERROR_PAGE;
	}
	
}
