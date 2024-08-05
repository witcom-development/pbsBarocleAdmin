/*
 * @Package Name : com.dkitec.barocle.admin.system.commonCodeMgmt.controller
 * @파일명		  : CommonCodeController.java
 * @작성일		  : 2015. 4. 8.
 * @작성자		  : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *	  수정일	  |	  수정자	  |			  수정내용
 * -------------------------------------------------------------
 *	2015. 4. 8.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.system.commonCodeMgmt.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.admin.login.vo.UserSessionVO;
import com.dkitec.barocle.admin.common.vo.TroubleReportVO;
import com.dkitec.barocle.admin.status.rentHistory.vo.PenaltyVO;
import com.dkitec.barocle.admin.system.commonCodeMgmt.service.CommonCodeService;
import com.dkitec.barocle.admin.system.commonCodeMgmt.validator.CommonCodeValidator;
import com.dkitec.barocle.admin.system.commonCodeMgmt.vo.CommonCenterVO;
import com.dkitec.barocle.admin.system.commonCodeMgmt.vo.CommonCodeVO;
import com.dkitec.barocle.admin.system.commonCodeMgmt.vo.CommonStationVO;
import com.dkitec.barocle.admin.system.usermgmt.vo.UserMgmtVO;
import com.dkitec.barocle.util.webutil.HttpUtil;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * @파일명		  : CommonCodeController.java
 * @작성일		  : 2015. 4. 8.
 * @작성자		  : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *	  수정일	  |	  수정자	  |			  수정내용
 * -------------------------------------------------------------
 *	2015. 4. 8.   |   ymshin   |  최초작성
 */
@Controller
@RequestCategory(value="CommonCodeController")
public class CommonCodeController extends CommonCodeValidator {

	
	protected static Logger log = LoggerFactory.getLogger(CommonCodeController.class);
	private static final String RETUR_URL = "/admin/system/commonCode/";
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	@Resource(name = "commonCodeService") private CommonCodeService commonCodeService;
	
	@RequestMapping(value="/getCommonCodeList.do")
	@RequestName("getCodeList")
	public String getCodeList (@ModelAttribute @Valid CommonCodeVO codeVO, BindingResult bResult, ModelMap model,HttpServletRequest request) throws Exception {
		
		String bizName = "코드관리 조회 화면";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		boolean result = false;
		try {
			//TODO : 로그인한 사용자의 locale정보로 설정.user정보에 같이
			int totCnt = commonCodeService.getAdmComCodeListCnt(codeVO);
			PaginationInfo paginationInfo = getPagingInfo(codeVO.getCurrentPageNo(), totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(codeVO.getCurrentPageNo(), totCnt);
			codeVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			codeVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<CommonCodeVO> resultList = commonCodeService.getAdmComCodeList(codeVO);
			
			model.addAttribute("searchCondition",codeVO );
			model.addAttribute("codeList", resultList);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo",paginationMobileInfo);
			result = true;
		} catch(Exception e) {
			throw new CfoodException("fail.common.msg", e.getMessage());
		}
	 
		return result ? RETUR_URL.concat("sys_code_list") : ERROR_PAGE;
	}
	
	@RequestMapping(value="/commonCode/getCommonCodeVal.do", method = RequestMethod.POST)
	@RequestName("getCommonCodeVal")
	public String getCommonCodeVal (@ModelAttribute CommonCodeVO codeVo,HttpServletRequest request,ModelMap model) throws Exception {

		String bizName = "select박스용 공통코드 취득 ";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		 try {
			CommonCodeVO resultVo = commonCodeService.getComCodeVal(codeVo);
	 		model.addAttribute("templateNo", resultVo.getAddVal1());
	 	} catch(Exception e) {
	 		throw new CfoodException("fail.common.msg.getlist", e);
	 	}
		return JSONVIEW;
	}
	
	@RequestMapping(value="/setCommonCodeExe.do", method = RequestMethod.POST)
	@RequestName("modifyCodeAjax")
	public String modifyCodeAjax (@ModelAttribute @Valid CommonCodeVO codeVO,  BindingResult bResult, ModelMap model, HttpServletRequest request) throws Exception {
		String bizName = "코드관리 수정";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		int result = 0;
		UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
		String admin = userSessionVO == null ? "test" :userSessionVO.getUsrId();
		
		try {
			String resultMessage = "저장이 성공했습니다";
			List<ObjectError> errorList = bResult.getAllErrors();
			if(errorList.size() > 0) {
				for(ObjectError err : errorList) {
					resultMessage = err.getDefaultMessage();
				}
			} else {
				//TODO : session에서 로그인한 아이디로 셋팅.
				codeVO.setRegId(admin);
				result = commonCodeService.setAdmComCode(codeVO);
			}
			
			model.addAttribute(CHECK_RESULT, result);
			model.addAttribute(RESULT_MESSAGE, resultMessage);
			
		}  catch(Exception e) {
			throw new CfoodException("fail.common.msg", e.getMessage());
		}
		
		
		return JSONVIEW;
	}
	
	@RequestMapping(value="/moveCodeEditForm.do", method = RequestMethod.POST)
	@RequestName("insertCodeForm")
	public String insertCodeForm (@ModelAttribute CommonCodeVO codeVO,HttpServletRequest request,ModelMap model) throws Exception {
		
		String bizName = "코드관리 등록 수정 화면 ("+codeVO.getViewFlg()+")";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		boolean result = false;
		UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
		String admin = userSessionVO == null ? "test" :userSessionVO.getUsrId();
		
		try {
			codeVO.setRegId(admin);
			if(codeVO.getViewFlg().equals(CRUD_C)) {
				model.addAttribute("codeVO", new CommonCodeVO());
				model.addAttribute("childCodeList", new ArrayList<CommonCodeVO>());
			} else {
				Map<Object, Object> map = commonCodeService.getAdmComCodeInfo(codeVO);
				model.addAttribute("codeVO", map.get("parentCode"));
				model.addAttribute("childCodeList", map.get("childCodeList"));
			}
			model.addAttribute("pVo",codeVO);
			result = true;
		}  catch(Exception e) {
			throw new CfoodException("fail.common.msg", e.getMessage());
		}
		
		return result ? RETUR_URL.concat("sys_code_detail") : ERROR_PAGE;
	}
	
	@RequestMapping(value="/isDupCodeChk.do", method = RequestMethod.POST)
	@RequestName("checkCodeAjax")
	public String checkCodeAjax ( @ModelAttribute("codeVO") CommonCodeVO codeVO,HttpServletRequest request, ModelMap model) throws Exception {
		int result = 0;
		String bizName = "코드관리 중복 확인";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
			
		try {
			result = commonCodeService.isExistCode(codeVO.getComUpCd().toUpperCase());
			model.addAttribute(CHECK_RESULT, result);
		} catch(Exception e) {
			throw new CfoodException("fail.common.msg", e.getMessage());
		}
		
		return JSONVIEW;
	}

	@RequestMapping(value="/addCommonCodExe.do")
	@RequestName("insertCodeAjax")
	public String insertCodeAjax (@ModelAttribute("codeVO") @Valid CommonCodeVO codeVO, BindingResult bResult, ModelMap model,HttpServletRequest request) throws Exception {
		int result = 0;
		String bizName = "코드관리 등록";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
		String admin = userSessionVO == null ? "test" :userSessionVO.getUsrId();
		
		try {
			//checkInsertParam(codeVO);
			String resultMessage = "저장이 성공했습니다";
			List<ObjectError> errorList = bResult.getAllErrors();
			if(errorList.size() > 0) {
				for(ObjectError err : errorList) {
					resultMessage = err.getDefaultMessage();
				}
			} else {
				codeVO.setRegId(admin);
				int dspOrdNum = commonCodeService.getUpcodeDspOrdNum();
				codeVO.setDspOrd(String.valueOf(dspOrdNum));
				result = commonCodeService.addAdmComCode(codeVO);
				
			}
			
			model.addAttribute(RESULT_MESSAGE, resultMessage);
			model.addAttribute(CHECK_RESULT, result);
		}  catch(Exception e) {
			throw new CfoodException("fail.common.msg", e.getMessage());
		}
		
		return JSONVIEW;
	}
	
	@RequestMapping(value="/commonCode/getCommonCode.do", method = RequestMethod.POST)
	@RequestName("getCommonCode")
	public String getCommonCode (@RequestParam("comUpCd") String comUpCd,HttpServletRequest request,ModelMap model) throws Exception {
		String bizName = "select박스용 공통코드 취득 ";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		 try {
			CommonCodeVO cVo = new CommonCodeVO();
			cVo.setComUpCd(comUpCd);
			List<CommonCodeVO> codeList = commonCodeService.getComCodeInfo(cVo);
			model.addAttribute("codeList", codeList);
		} catch(Exception e) {
			throw new CfoodException("fail.common.msg", e.getMessage());
		}
		
		return JSONVIEW;
	}
	//////////////////////////////////////////////////////////////////////////////////////////////////////////
	/// 공통 콤보박스 데이터 취득용. start																									//
	////////////////////////////////////////////////////////////////////////////////////////////////////////
	@RequestMapping(value="/commonCode/getStation.do", method = RequestMethod.POST)
	@RequestName("getStation")
	public String getStation (HttpServletRequest request,ModelMap model) throws Exception {
		
		String bizName = "select박스용 대여소 코드 취득 ";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		try {
			CommonStationVO codeVO = new CommonStationVO();
			List<CommonStationVO> stationList = commonCodeService.getComStation(codeVO);
			model.addAttribute("stationList", stationList);
		
		} catch(Exception e) {
			throw new CfoodException("fail.common.msg", e.getMessage());
		}
		
		
		return JSONVIEW;
	}
	@RequestMapping(value="/commonCode/getCenterInfo.do", method = RequestMethod.POST)
	@RequestName("getCenterInfo")
	public String getCenterInfo (HttpServletRequest request,ModelMap model) throws Exception {
		
		String bizName = "select박스용 센터 코드 취득 ";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		try {
			List<CommonCenterVO> centerList = commonCodeService.getCenterInfo();
			model.addAttribute("centerList", centerList);
		} catch(Exception e) {
			throw new CfoodException("fail.common.msg", e.getMessage());
		}
		
		
		return JSONVIEW;
	}
	
	@RequestMapping(value="/commonCode/getCenterMallInfo.do", method = RequestMethod.POST)
	@RequestName("getCenterMallInfo")
	public String getCenterMallInfo (HttpServletRequest request,ModelMap model) throws Exception {
		
		String bizName = "select박스용 센터 코드 취득 ";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		try {
			List<CommonCenterVO> centerList = commonCodeService.getCenterMallInfo();
			model.addAttribute("centerList", centerList);
		} catch(Exception e) {
			throw new CfoodException("fail.common.msg", e.getMessage());
		}
		
		return JSONVIEW;
	}	
	
	
	@RequestMapping(value="/commonCode/getUserGrpInfo.do")
	@RequestName("getUserGrpInfo")
	public String getUserGrpInfo(@ModelAttribute UserMgmtVO userVo, BindingResult bResult, ModelMap model, HttpServletRequest request) {
		
		String bizName = "운영자 데이터";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		List<UserMgmtVO> userList = commonCodeService.getUserInfo(userVo);
		
		model.addAttribute("userList", userList);
		
		return JSONVIEW;
	}
	
	@RequestMapping(value="/commonCode/getRepBikeAdminInfo.do")
	@RequestName("getRepBikeAdminInfo")
	public String getRepBikeAdminInfo(@ModelAttribute UserMgmtVO userVo, BindingResult bResult, ModelMap model, HttpServletRequest request) {
		
		String bizName = "바로클포 운영자 데이터";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		List<UserMgmtVO> userList = commonCodeService.getRepBikeAdminInfo(userVo);
		
		model.addAttribute("userList", userList);
		
		return JSONVIEW;
	}
	
	@RequestMapping(value="/commonCode/getPenaltyCode.do")
	@RequestName("getPenaltyCode")
	public String getPenaltyCode(@ModelAttribute PenaltyVO penaltyVo,ModelMap model, HttpServletRequest request) {
		String bizName = "벌점 데이터";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		List<PenaltyVO> penaltyList = commonCodeService.getPenaltyCode();
		
		model.addAttribute("penaltyList", penaltyList);
		
		return JSONVIEW;
	}
	
	@RequestMapping(value="/commonCode/getFaultList.do")
	@RequestName("getFaultList")
	public String getFaultList(@ModelAttribute TroubleReportVO troubleReportVo,ModelMap model, HttpServletRequest request) {
		String bizName = "벌점 데이터";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		List<TroubleReportVO> faultList = commonCodeService.getFaultList(troubleReportVo);
		
		model.addAttribute("faultList", faultList);
		
		return JSONVIEW;
	}
}
