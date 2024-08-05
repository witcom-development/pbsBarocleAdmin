package com.dkitec.barocle.admin.service.policyMgmt.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.StringTokenizer;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindException;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.admin.login.vo.UserSessionVO;
import com.dkitec.barocle.admin.service.membermgmt.service.SafetyCertDiscountService;
import com.dkitec.barocle.admin.service.membermgmt.vo.MemberMgmtVO;
import com.dkitec.barocle.admin.service.membermgmt.vo.SafetyCertDiscountVO;
import com.dkitec.barocle.admin.service.policyMgmt.service.PolicyMgmtService;
import com.dkitec.barocle.admin.service.policyMgmt.vo.ChargePolicyMgmtVO;
import com.dkitec.barocle.admin.service.policyMgmt.vo.ChargePolicyMgmtVO.chargeUpdateValid;
import com.dkitec.barocle.admin.service.policyMgmt.vo.ChargePolicyMgmtVO.specialChargeDeleteValid;
import com.dkitec.barocle.admin.service.policyMgmt.vo.PenaltyPolicyMgmtVO;
import com.dkitec.barocle.admin.service.policyMgmt.vo.PenaltyPolicyMgmtVO.penaltyDeleteValid;
import com.dkitec.barocle.admin.service.policyMgmt.vo.PenaltyPolicyMgmtVO.penaltyInsertValid;
import com.dkitec.barocle.admin.service.policyMgmt.vo.PenaltyPolicyMgmtVO.penaltyUpdateValid;
import com.dkitec.barocle.admin.service.policyMgmt.vo.TransferPolicyMgmtVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.sms.SmsSender;
import com.dkitec.barocle.util.sms.vo.SmsMessageVO;
import com.dkitec.barocle.util.webutil.HttpUtil;
import com.dkitec.barocle.util.webutil.UracleUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="PolicyMgmtController")
@RequestMapping(value="/admin/service/policyMgmt")
public class PolicyMgmtController extends BaseController {

	protected static Logger log = LoggerFactory.getLogger(PolicyMgmtController.class);
	
	@Resource(name="policyMgmtService") private PolicyMgmtService policyMgmtService;
	@Resource(name = "safetyCertDiscountService") private SafetyCertDiscountService safetyCertDiscountService;
	
	@RequestName("formChargePolicy")
	@RequestMapping(value="/formChargePolicy.do")
	public String formChargePolicy(@ModelAttribute @Valid ChargePolicyMgmtVO chargePolicyMgmtVO, BindingResult bResult, ModelMap model, HttpServletRequest request) {
		
		boolean result = false;
		String targetUrl = "/admin/service/policy/cha/svc_cha_detail";
		String bizName = "요금 정책 화면";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		if(!bResult.hasErrors()) {
			List<ChargePolicyMgmtVO> rentChargePolicyList = policyMgmtService.listRentChargePolicy();
			//List<ChargePolicyMgmtVO> premiunRentChargePolicyList = policyMgmtService.listPremiumRentChargePolicy();	//프리미엄 요금 정책 목록_20160614_JJH 20180315 별도 관리 안함 시간제로 변경
			List<ChargePolicyMgmtVO> addChargePolicyList = policyMgmtService.listAddChargePolicy();
			//List<ChargePolicyMgmtVO> addPremiumChargePolicyList = policyMgmtService.listAddPremiumChargePolicy();	//프리미엄 추가 요금 정책 목록_20160614_JJH 20180315 별도 관리 안함 시간제로 변경
			//List<ChargePolicyMgmtVO> memSpecialChargePolicyList = policyMgmtService.listSpecialChargePolicy("BIL_006");
			//List<ChargePolicyMgmtVO> nonmemSpecialChargePolicyList = policyMgmtService.listSpecialChargePolicy("BIL_007");
			List<ChargePolicyMgmtVO> rentMMList = policyMgmtService.listRentMM();
			//List<ChargePolicyMgmtVO> premiumRentMMList = policyMgmtService.PremiumlistRentMM();	//프리미엄 요금제 자전거 정책_20160614_JJH
			
			java.util.List<java.util.Map> premiumUseYnList = policyMgmtService.premiumUseYnList();
			
			log.debug("##### formChargePolicy ##### ==> " + premiumUseYnList.toString());
			
			model.addAttribute("premiumUseYnList", premiumUseYnList);	//프리미엄 요금제 사용여부_20160614_JJH
			
			log.debug("##### PolicyMgmtController svc_cha_detail ##### ==> " + addChargePolicyList.toString());
			
			model.addAttribute("rentChargePolicyList", rentChargePolicyList);
			//model.addAttribute("premiunRentChargePolicyList", premiunRentChargePolicyList);	//프리미엄 요금 정책 목록_20160614_JJH 20180315 별도 관리 안함 시간제로 변경
			model.addAttribute("addChargePolicyList", addChargePolicyList);
			//model.addAttribute("addPremiumChargePolicyList", addPremiumChargePolicyList);	//프리미엄 추가 요금 정책 목록_20160614_JJH 20180315 별도 관리 안함 시간제로 변경
			//model.addAttribute("memSpecialChargePolicyList", memSpecialChargePolicyList);
			//model.addAttribute("nonmemSpecialChargePolicyList", nonmemSpecialChargePolicyList);
			model.addAttribute("rentMMList", rentMMList);
			//model.addAttribute("premiumRentMMList", premiumRentMMList);	//프리미엄 요금제 자전거 정책_20160614_JJH
			
			result = true;
		}
		
		return result ? targetUrl : ERROR_PAGE;
	}
	
	@RequestName("modChargePolicy")
	@RequestMapping(value="/modChargePolicy.do")
	public String modChargePolicy(@Validated(chargeUpdateValid.class) ChargePolicyMgmtVO chargePolicyMgmtVO, BindingResult bResult, ModelMap model, HttpServletRequest request) {
		
		String bizName = "요금 정책 수정 화면";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		log.debug("##### PolicyMgmtController modChargePolicy ##### ==> " + chargePolicyMgmtVO.toString());
		
		boolean isSuccess = false;
		isSuccess = policyMgmtService.modChargePolicy(chargePolicyMgmtVO);

		//shoh2999
		StringTokenizer paymentClsCdSt = new StringTokenizer(chargePolicyMgmtVO.getPaymentClsCd(),",");
		
		for (int index = 0; paymentClsCdSt.hasMoreElements() ;index++) {
			List disRate = chargePolicyMgmtVO.getDisRateList();
			SafetyCertDiscountVO sVo = new SafetyCertDiscountVO();
			sVo.setComCd(paymentClsCdSt.nextToken());
			sVo.setDisRate((String)disRate.get(index));
			try {
				int certDisResult = safetyCertDiscountService.setSafetyCertDiscount(sVo );
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		model.addAttribute("isSuccess", String.valueOf(isSuccess));
		
		return JSONVIEW;
	}
	
	@RequestName("delSpecialTimeChargePolicy")
	@RequestMapping(value="/delSpecialTimeChargePolicyAjax.do")
	public String delSpecialTimeChargePolicy(@Validated(specialChargeDeleteValid.class) ChargePolicyMgmtVO chargePolicyMgmtVO, BindingResult bResult, ModelMap model, HttpServletRequest request) {
		
		String bizName = "특례 시간 요금 정책 삭제";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		boolean isDel = false;
		isDel = policyMgmtService.delSpecialTimeChargePolicy(chargePolicyMgmtVO);
		model.addAttribute("isDel", String.valueOf(isDel));
		
		return JSONVIEW;
	}

	@RequestName("listPenaltyPolicy")
	@RequestMapping(value="/listPenaltyPolicy.do")
	public String listPenaltyPolicy(@ModelAttribute @Valid PenaltyPolicyMgmtVO penaltyPolicyMgmtVO, BindingResult bResult, ModelMap model, HttpServletRequest request) {
		
		boolean result = false;
		String targetUrl = "/admin/service/policy/penalty/svc_pen_list";
		String bizName = "벌점 정책 목록 화면";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		if(!bResult.hasErrors()) {
			penaltyPolicyMgmtVO.setTotalRecordCount(policyMgmtService.listPenaltyPolicyCount(penaltyPolicyMgmtVO));
	
			PaginationInfo paginationInfo = getPagingInfo(penaltyPolicyMgmtVO.getCurrentPageNo(), penaltyPolicyMgmtVO.getTotalRecordCount());
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(penaltyPolicyMgmtVO.getCurrentPageNo(), penaltyPolicyMgmtVO.getTotalRecordCount());
			penaltyPolicyMgmtVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			penaltyPolicyMgmtVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<PenaltyPolicyMgmtVO> penaltyPolicyList = policyMgmtService.listPenaltyPolicy(penaltyPolicyMgmtVO);
			
			model.addAttribute("searchParam", penaltyPolicyMgmtVO);
			model.addAttribute("penaltyPolicyList", penaltyPolicyList);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			
			result = true;
		}
			
		return result ? targetUrl : ERROR_PAGE;
	}
	
	@RequestName("formPenaltyPolicy")
	@RequestMapping(value="/formPenaltyPolicy.do")
	public String formPenaltyPolicy(@ModelAttribute @Valid PenaltyPolicyMgmtVO penaltyPolicyMgmtVO, BindingResult bResult, ModelMap model, HttpServletRequest request) {
		
		boolean result = false;
		String targetUrl = "/admin/service/policy/penalty/svc_pen_detail";
		String bizName = "벌점 정책 등록/수정/삭제 화면";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		if(!bResult.hasErrors()) {
			String viewFlg = penaltyPolicyMgmtVO.getViewFlg();
			
			if("U".equals(viewFlg)) {
				List<PenaltyPolicyMgmtVO> penaltyPolicyList = policyMgmtService.listPenaltyPolicy(penaltyPolicyMgmtVO);
				model.addAttribute("formPenaltyPolicy", penaltyPolicyList.get(0));
			} 
			
			model.addAttribute("viewFlg", viewFlg);
			
			result = true;
		}
		
		return result ? targetUrl : ERROR_PAGE;
	}
	
	@RequestName("duplCdCheckAjax")
	@RequestMapping(value="/duplCdCheckAjax.do")
	public String duplCdCheckAjax(@RequestParam(value="penaltyCd") String penaltyCd, ModelMap model, HttpServletRequest request) {
		
		String bizName = "범점 코드 중복 체크";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		boolean isCdDupl = false;
		isCdDupl = policyMgmtService.isPenaltyCdDupl(penaltyCd);
		model.addAttribute("isCdDupl", String.valueOf(isCdDupl));
		
		return JSONVIEW;
	}
	
	@RequestName("insertPenaltyPolicy")
	@RequestMapping(value="/insertPenaltyPolicy.do")
	public String insertPenaltyPolicy(@Validated(penaltyInsertValid.class) PenaltyPolicyMgmtVO penaltyPolicyMgmtVO, BindingResult bResult, ModelMap model, HttpServletRequest request) {
		
		String bizName = "벌점 정책 등록";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		boolean isSuccess = false;

		try{
			UserSessionVO userSessionVO = (UserSessionVO) EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
			
			penaltyPolicyMgmtVO.setRegId(userSessionVO.getUsrId());
			penaltyPolicyMgmtVO.setModId(userSessionVO.getUsrId());
			
			isSuccess = policyMgmtService.insertPenaltyPolicy(penaltyPolicyMgmtVO);
			model.addAttribute("isSuccess", String.valueOf(isSuccess));
		} catch(Exception e) {
			throw new CfoodException("fail.common.msg");
		}
		
		return JSONVIEW;
	}
	
	@RequestName("modPenaltyPolicy")
	@RequestMapping(value="/modPenaltyPolicy.do")
	public String modPenaltyPolicy(@Validated(penaltyUpdateValid.class) PenaltyPolicyMgmtVO penaltyPolicyMgmtVO, BindingResult bResult, ModelMap model, HttpServletRequest request) {
		
		String bizName = "벌점 정책 수정";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		boolean isSuccess = false;

		try{
			UserSessionVO userSessionVO = (UserSessionVO) EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
			
			penaltyPolicyMgmtVO.setModId(userSessionVO.getUsrId());
			
			isSuccess = policyMgmtService.modPenaltyPolicy(penaltyPolicyMgmtVO);
			model.addAttribute("isSuccess", String.valueOf(isSuccess));
		} catch(Exception e) {
			throw new CfoodException("");
		}
		
		return JSONVIEW;
	}
	
	@RequestName("applyPenaltyCheckAjax")
	@RequestMapping(value="/applyPenaltyCheckAjax.do")
	public String applyPenaltyCheckAjax(@RequestParam(value="penaltyCd") String penaltyCd, ModelMap model, HttpServletRequest request) {
		
		boolean isCdApply = false;
		isCdApply = policyMgmtService.isPenaltyApply(penaltyCd);
		model.addAttribute("isCdApply", String.valueOf(isCdApply));
		
		return JSONVIEW;
	}
	
	@RequestName("delPenaltyPolicy")
	@RequestMapping(value="/delPenaltyPolicy.do")
	public String delPenaltyPolicy(@Validated(penaltyDeleteValid.class) PenaltyPolicyMgmtVO penaltyPolicyMgmtVO, BindingResult bResult, ModelMap model, HttpServletRequest request) {
		
		String bizName = "벌점 정책 삭제";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		boolean isSuccess = false;
		isSuccess = policyMgmtService.delPenaltyPolicy(penaltyPolicyMgmtVO);
		model.addAttribute("isSuccess", String.valueOf(isSuccess));
		
		return JSONVIEW;
	}
	
	@RequestName("listTranferPolicy")
	@RequestMapping(value="/listTransferPolicy.do")
	public String listTranferPolicy(@ModelAttribute @Valid TransferPolicyMgmtVO transferPolicyMgmtVO, BindingResult bResult, ModelMap model, HttpServletRequest request) {
		
		boolean result = false;
		String targetUrl = "/admin/service/policy/mileage/svc_tran_list";
		String bizName = "환승 정책 목록 화면";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		if(!bResult.hasErrors()) {
			transferPolicyMgmtVO.setTotalRecordCount(policyMgmtService.listTransferPolicyCount(transferPolicyMgmtVO));
	
			PaginationInfo paginationInfo = getPagingInfo(transferPolicyMgmtVO.getCurrentPageNo(), transferPolicyMgmtVO.getTotalRecordCount());
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(transferPolicyMgmtVO.getCurrentPageNo(), transferPolicyMgmtVO.getTotalRecordCount());
			transferPolicyMgmtVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			transferPolicyMgmtVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<TransferPolicyMgmtVO> transferPolicyList = policyMgmtService.listTransferPolicy(transferPolicyMgmtVO);
			
			model.addAttribute("searchParam", transferPolicyMgmtVO);
			model.addAttribute("transferPolicyList", transferPolicyList);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			
			result = true;
		}
		
		return result ? targetUrl : ERROR_PAGE;
	}
	
	@RequestName("formTransferPolicy")
	@RequestMapping(value="/formTransferPolicy.do")
	public String formTransferPolicy(@ModelAttribute @Valid TransferPolicyMgmtVO transferPolicyMgmtVO, BindingResult bResult, ModelMap model, HttpServletRequest request) {
		
		boolean result = false;
		String targetUrl = "/admin/service/policy/mileage/svc_tran_detail";
		String bizName = "환승 정책 등록/수정/삭제 화면";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		if(!bResult.hasErrors()) {
			String viewFlg = transferPolicyMgmtVO.getViewFlg();
			
			if("U".equals(viewFlg)) {
				List<TransferPolicyMgmtVO> transferPolicyList = policyMgmtService.listTransferPolicy(transferPolicyMgmtVO);
				model.addAttribute("formTransferPolicy", transferPolicyList.get(0));
			} 
			
			model.addAttribute("viewFlg", viewFlg);
			
			result = true;
		}
		
		return result ? targetUrl : ERROR_PAGE;
	}
	
	@RequestName("duplDateCheckAjax")
	@RequestMapping(value="/duplDateCheckAjax.do")
	public String duplDateCheckAjax(@ModelAttribute @Valid TransferPolicyMgmtVO transferPolicyMgmtVO, BindingResult bResult, ModelMap model, HttpServletRequest request) {
		
		String bizName = "환승 정책 기간 중복 확인";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		boolean isDateDupl = false;
		isDateDupl = policyMgmtService.isTransferDateDupl(transferPolicyMgmtVO);
		model.addAttribute("isDateDupl", String.valueOf(isDateDupl));
		
		return JSONVIEW;
	}
	
	@RequestName("insertTransferPolicy")
	@RequestMapping(value="/insertTransferPolicy.do")
	public String insertTransferPolicy(@ModelAttribute @Valid TransferPolicyMgmtVO transferPolicyMgmtVO, BindingResult bResult, ModelMap model, HttpServletRequest request) {
		
		String bizName = "환승 정책 등록";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		boolean isSuccess = false;
		isSuccess =  policyMgmtService.insertTransferPolicy(transferPolicyMgmtVO);
		model.addAttribute("isSuccess", String.valueOf(isSuccess));
		
		return JSONVIEW;
	}
	
	@RequestName("modTransferPolicy")
	@RequestMapping(value="/modTransferPolicy.do")
	public String modTransferPolicy(@ModelAttribute @Valid TransferPolicyMgmtVO transferPolicyMgmtVO, BindingResult bResult, ModelMap model, HttpServletRequest request) {
		
		String bizName = "환승 정책 수정";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		boolean isSuccess = false;
		isSuccess =  policyMgmtService.modTransferPolicy(transferPolicyMgmtVO);
		model.addAttribute("isSuccess", String.valueOf(isSuccess));
		
		return JSONVIEW;
	}
	
	@RequestName("delTransferPolicy")
	@RequestMapping(value="/delTransferPolicy.do")
	public String delTransferPolicy(@ModelAttribute @Valid TransferPolicyMgmtVO transferPolicyMgmtVO, BindingResult bResult, ModelMap model, HttpServletRequest request) {
		
		String bizName = "환승 정책 삭제";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		boolean isSuccess = false;
		isSuccess =  policyMgmtService.delTransferPolicy(transferPolicyMgmtVO);
		model.addAttribute("isSuccess", String.valueOf(isSuccess));
		
		return JSONVIEW;
	}
	
	//프리미엄 요금제 자전거 정책_20160620_JJH
	@RequestName("getPremiumSelectionList")
	@RequestMapping(value="/getPremiumSelectionList.do")
	public String getPremiumSelectionList(@ModelAttribute @Valid ChargePolicyMgmtVO chargePolicyMgmtVO, BindingResult bResult, ModelMap model, HttpServletRequest request) {
		
			java.util.List<java.util.Map> premiumUseYnList = policyMgmtService.premiumUseYnList();
			
			log.debug("##### formChargePolicy ##### ==> " + premiumUseYnList.toString());
			
			model.addAttribute("premiumUseYnList", premiumUseYnList);	//프리미엄 요금제 사용여부_20160614_JJH
		
		return JSONVIEW;
	}
	
	/*
	 * SMS 발송 등록 폼
	 */
	@RequestMapping(value="/sendSmsAddForm.do")
	@RequestName("sendSmsAddForm")
	public String sendSmsAddForm(@ModelAttribute MemberMgmtVO memberVo, BindingResult bResult, ModelMap model, HttpServletRequest request){
		boolean result = false;
		String targetUrl = "/admin/system/sms/sys_sms_send_form";
		String bizName = "SMS 발송  등록 폼";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		if(!bResult.hasErrors()) {
			result = true;
		}
		return result ? targetUrl : ERROR_PAGE;
	}
	
	/*
	 * SMS 발송 상세정보 
	 */
	@RequestMapping(value="/sendSmsList.do")
	@RequestName("sendSmsList")
	public String sendSmsList(@ModelAttribute MemberMgmtVO memberVo, BindingResult bResult, ModelMap model, HttpServletRequest request){
		boolean result = false;
		String targetUrl = "/admin/system/sms/sys_sms_send_list";
		String bizName = "환승 정책 목록 화면";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		List<MemberMgmtVO> memberMgmtVO = null;
		
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		if(memberVo.getSearchStartDate() == null && memberVo.getSearchEndDate() == null){
			memberVo.setSearchEndDate(sdf.format(cal.getTime()));
			memberVo.setSearchStartDate(sdf.format(cal.getTime()));
		}
		
		if(!bResult.hasErrors()) {
			memberVo.setTotalRecordCount(policyMgmtService.smsSendListCnt(memberVo));
			
			PaginationInfo paginationInfo = getPagingInfo(memberVo.getCurrentPageNo(), memberVo.getTotalRecordCount());
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(memberVo.getCurrentPageNo(), memberVo.getTotalRecordCount());
			memberVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			memberVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			memberMgmtVO = policyMgmtService.smsSendList(memberVo);
			model.addAttribute("searchParam", memberVo);
			model.addAttribute("smsList", memberMgmtVO);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			
			result = true;
		}
		
		return result ? targetUrl : ERROR_PAGE;
	}
	
	/*
	 * SMS 발송 상세정보 
	 */
	@RequestMapping(value="/sendLongSmsList.do")
	@RequestName("sendLongSmsList")
	public String sendlongSmsList(@ModelAttribute MemberMgmtVO memberVo, BindingResult bResult, ModelMap model, HttpServletRequest request) throws BindException{
		boolean result = false;
		String targetUrl = "/admin/system/sms/sys_long_sms_send_list";
		String bizName = "장기 미반납 목록 화면";
		
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		
		List<MemberMgmtVO> memberMgmtVO = null;
		
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		if(memberVo.getSearchStartDate() == null && memberVo.getSearchEndDate() == null){
			memberVo.setSearchEndDate(sdf.format(cal.getTime()));
			memberVo.setSearchStartDate(sdf.format(cal.getTime()));
			memberVo.setSearchParameter("2");
			memberVo.setSearchValue("F");
		}
		
		if(!bResult.hasErrors()) {
			
			memberVo.setTotalRecordCount(policyMgmtService.smsLongSendListCnt(memberVo));
	
			PaginationInfo paginationInfo = getPagingInfo(memberVo.getCurrentPageNo(), memberVo.getTotalRecordCount());
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(memberVo.getCurrentPageNo(), memberVo.getTotalRecordCount());
			memberVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			memberVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			memberMgmtVO = policyMgmtService.smsLongSendList(memberVo);
			model.addAttribute("searchParam", memberVo);
			model.addAttribute("smsList", memberMgmtVO);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			
			result = true;
		} else {
		
			throw new BindException(bResult);
			
		}
		
		return result ? targetUrl : ERROR_PAGE;
	}
	
	
	/*
	 * SMS 발송 
	 */
	@RequestMapping(value="/sendSms.do")
	@RequestName("sendSms")
	public String sendSms(@ModelAttribute @Valid MemberMgmtVO memberVo, ModelMap model, HttpServletRequest request){
		String bizName = "SMS 전송.";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		List<SmsMessageVO> smsMsgList = new ArrayList<SmsMessageVO>();
		SmsMessageVO smsMsgVo = null;
		
		String subTitle = (String)request.getParameter("subTitle");
		
		boolean result = false;
		try {
				smsMsgVo = new SmsMessageVO();
				smsMsgVo.setDestno(memberVo.getPhonNo());
				smsMsgVo.setReqdttm(memberVo.getBookDate());
				smsMsgVo.setMsg(memberVo.getSmsMsg());
				smsMsgVo.setSenderId(memberVo.getSenderId());	//sms 발신인ID_cms_20161209
				smsMsgList.add(smsMsgVo);
				SmsSender.sender(smsMsgList);		//sms 전송 테이블 insert
				SmsSender.senderHistory(smsMsgList);	//sms history 테이블 이력
				UracleUtil.sendMessage(memberVo.getPhonNo(), memberVo.getSmsMsg(), subTitle);
				result = true;	
		} catch (Exception e) {
			throw new CfoodException("fail.sms.send",e);
		}
		model.addAttribute(CHECK_RESULT, result);
		
		return JSONVIEW;
	}
	
	/*
	 * SMS 발송 상세정보 
	 */
	@RequestMapping(value="/pushSendList.do")
	@RequestName("pushSendList")
	public String pushSendList(@ModelAttribute MemberMgmtVO memberVo, BindingResult bResult, ModelMap model, HttpServletRequest request){
		boolean result = false;
		String targetUrl = "/admin/system/sms/sys_push_send_list";
		String bizName = "PUSH 발송 목록 화면";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		List<MemberMgmtVO> memberMgmtVO = null;
		
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		if(memberVo.getSearchStartDate() == null && memberVo.getSearchEndDate() == null){
			memberVo.setSearchEndDate(sdf.format(cal.getTime()));
			memberVo.setSearchStartDate(sdf.format(cal.getTime()));
		}
		
		if(!bResult.hasErrors()) {
			memberVo.setTotalRecordCount(policyMgmtService.pushSendListCnt(memberVo));
	
			PaginationInfo paginationInfo = getPagingInfo(memberVo.getCurrentPageNo(), memberVo.getTotalRecordCount());
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(memberVo.getCurrentPageNo(), memberVo.getTotalRecordCount());
			memberVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			memberVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			memberMgmtVO = policyMgmtService.pushSendList(memberVo);
			model.addAttribute("searchParam", memberVo);
			model.addAttribute("smsList", memberMgmtVO);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			
			result = true;
		}
		
		return result ? targetUrl : ERROR_PAGE;
	}
}
