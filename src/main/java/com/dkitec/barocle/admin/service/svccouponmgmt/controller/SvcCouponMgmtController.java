package com.dkitec.barocle.admin.service.svccouponmgmt.controller;

import java.text.ParseException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.admin.login.vo.UserSessionVO;
import com.dkitec.barocle.admin.service.policyMgmt.service.PolicyMgmtService;
import com.dkitec.barocle.admin.service.policyMgmt.vo.ChargePolicyMgmtVO;
import com.dkitec.barocle.admin.service.svccouponmgmt.service.SvcCouponMgmtService;
import com.dkitec.barocle.admin.service.svccouponmgmt.vo.SvcCouponMgmtVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.HttpUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="SvcCouponMgmtController")
public class SvcCouponMgmtController extends BaseController {
	protected static Logger log = LoggerFactory.getLogger(SvcCouponMgmtController.class);
	
	@Resource(name = "svcCouponMgmtService") private SvcCouponMgmtService svcCouponMgmtService;
	@Resource(name="policyMgmtService") private PolicyMgmtService policyMgmtService;
	
	private static final String RETUR_URL = "/admin/service/svccoupon/";
	private static final String POP_URL = "/admin/common/popup/";
	
	@RequestName(value="getSvcCouponList")
	@RequestMapping(value = "/getSvcCouponList.do")
	public String getSvcCouponMgmtList(@ModelAttribute @Valid SvcCouponMgmtVO svcCouponMgmtVO, BindingResult bResult, ModelMap model, HttpServletRequest request) throws Exception {
		
		String targetUrl = RETUR_URL.concat("svc_cou_list");
    	String bizName = "쿠폰 조회 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        boolean result = false;
        
        try {
        	svcCouponMgmtVO.setPagingYn("Y");
			if(svcCouponMgmtVO.getViewFlg() != null && svcCouponMgmtVO.getViewFlg().equals(MODE_EXCEL)) {
				svcCouponMgmtVO.setPagingYn("N");
			} 
			//if(svcCouponMgmtVO.getUsrSearchKey()!=null && svcCouponMgmtVO.getUsrSearchKey()!="")
			//	svcCouponMgmtVO.setUsrSearchKey(new String(svcCouponMgmtVO.getUsrSearchKey().getBytes("ISO-8859-1"), "UTF-8"));
        	
        	int sizeList = svcCouponMgmtService.getSvcCouponListCount(svcCouponMgmtVO);
        	
			PaginationInfo paginationInfo = getPagingInfo(svcCouponMgmtVO.getCurrentPageNo(), sizeList);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(svcCouponMgmtVO.getCurrentPageNo(), sizeList);
			svcCouponMgmtVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			svcCouponMgmtVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<SvcCouponMgmtVO> resultList = svcCouponMgmtService.getSvcCouponList(svcCouponMgmtVO);
			
			model.addAttribute("searchCondition", svcCouponMgmtVO);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo",paginationMobileInfo);
			model.addAttribute("svccouponList", resultList);

			result =true;
        }catch(CfoodException e) {
        	throw new CfoodException(getMessage("fail.common.msg"));
        }
        
        if(svcCouponMgmtVO.getViewFlg().equals(MODE_EXCEL)) {
			targetUrl =  RETUR_URL.concat("svc_cou_list_excel");
		}
		
        return result ? targetUrl : ERROR_PAGE;
	}
	
	/* 대여일련번호 상세 detail _ 20170512_JHN */
	@RequestName(value="addSvcCouponPop")
	@RequestMapping(value="/addSvcCouponPop.do")
	public String addSvcCouponPop(@ModelAttribute @Valid SvcCouponMgmtVO svcCouponMgmtVO, BindingResult bResult, ModelMap model, HttpServletRequest request) throws ParseException {
		
		boolean result = false;
		String targetUrl = POP_URL.concat("pop_cou_pro");
		String bizName = "쿠폰 등록 팝업";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
        
        if(!bResult.hasErrors()) {
	        List<ChargePolicyMgmtVO> rentChargePolicyList = policyMgmtService.listRentChargePolicy();
	        List<ChargePolicyMgmtVO> addChargePolicyList = policyMgmtService.listAddChargePolicy();
	        List<ChargePolicyMgmtVO> rentMMList = policyMgmtService.listRentMM();
	        
	        java.util.List<java.util.Map> premiumUseYnList = policyMgmtService.premiumUseYnList();
	        
	        log.debug("##### formChargePolicy ##### ==> " + premiumUseYnList.toString());
	        
	        model.addAttribute("premiumUseYnList", premiumUseYnList);	//프리미엄 요금제 사용여부_20160614_JJH
	        
	        log.debug("##### PolicyMgmtController svc_cha_detail ##### ==> " + addChargePolicyList.toString());
	        
	        model.addAttribute("rentChargePolicyList", rentChargePolicyList);
	        model.addAttribute("addChargePolicyList", addChargePolicyList);
	        model.addAttribute("rentMMList", rentMMList);
	        
	        result = true;
        }
		
		return result ? targetUrl : ERROR_PAGE;
	}
	
	@RequestName("addSvcCouponProc")
	@RequestMapping(value="/addSvcCouponProc.do")
	public String addSvcCouponProc(SvcCouponMgmtVO svcCouponMgmtVO, BindingResult bResult, ModelMap model, HttpServletRequest request) {
		
    	String bizName = "쿠폰 등록 실행";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        
        log.debug("##### SvcCouponMgmtController addSvcCouponProc ##### ==> " + svcCouponMgmtVO.toString());
        boolean isSuccess = false;
        try {
			UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
			svcCouponMgmtVO.setAdminId(userSessionVO.getUsrId()); 
			svcCouponMgmtVO.setUsrSeq(userSessionVO.getAdminSeq());
			isSuccess = svcCouponMgmtService.addSvcCouponProc(svcCouponMgmtVO);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
        
        model.addAttribute("isSuccess", String.valueOf(isSuccess));
		
		return JSONVIEW;
	}
	
	@RequestName("delSvcCouponProc")
	@RequestMapping(value="/delSvcCouponProc.do")
	public String delSvcCouponProc(SvcCouponMgmtVO svcCouponMgmtVO, BindingResult bResult, ModelMap model, HttpServletRequest request) {
		
    	String bizName = "쿠폰 삭제 실행";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        
        log.debug("##### SvcCouponMgmtController delSvcCouponProc ##### ==> " + svcCouponMgmtVO.toString());
        
        boolean isSuccess = false;
		isSuccess = svcCouponMgmtService.delSvcCouponProc(svcCouponMgmtVO);
		model.addAttribute("isSuccess", String.valueOf(isSuccess));
		
		return JSONVIEW;
	}
	
	@RequestName("unUseSvcCouponProc")
	@RequestMapping(value="/unUseSvcCouponProc.do")
	public String unUseSvcCouponProc(SvcCouponMgmtVO svcCouponMgmtVO, BindingResult bResult, ModelMap model, HttpServletRequest request) {
		
    	String bizName = "쿠폰 사용불가 실행";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        
        log.debug("##### SvcCouponMgmtController unUseSvcCouponProc ##### ==> " + svcCouponMgmtVO.toString());
        
        boolean isSuccess = false;
		isSuccess = svcCouponMgmtService.unUseSvcCouponProc(svcCouponMgmtVO);
		model.addAttribute("isSuccess", String.valueOf(isSuccess));
		
		return JSONVIEW;
	}
	
	@RequestName("useSvcCouponProc")
	@RequestMapping(value="/useSvcCouponProc.do")
	public String useSvcCouponProc(SvcCouponMgmtVO svcCouponMgmtVO, BindingResult bResult, ModelMap model, HttpServletRequest request) {
		
    	String bizName = "쿠폰 사용가능 실행";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        
        log.debug("##### SvcCouponMgmtController useSvcCouponProc ##### ==> " + svcCouponMgmtVO.toString());
        
        boolean isSuccess = false;
		isSuccess = svcCouponMgmtService.useSvcCouponProc(svcCouponMgmtVO);
		model.addAttribute("isSuccess", String.valueOf(isSuccess));
		
		return JSONVIEW;
	}
	
	/* 유효기간 설정 */
	@RequestName(value="changeDateSvcCouponPop")
	@RequestMapping(value="/changeDateSvcCouponPop.do")
	public String changeDateSvcCouponPop(@ModelAttribute @Valid SvcCouponMgmtVO svcCouponMgmtVO, BindingResult bResult, ModelMap model, HttpServletRequest request) throws ParseException {
		
		boolean result = false;
		String targetUrl = POP_URL.concat("pop_coudate_pro");
		String bizName = "유효기간 설정 팝업";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
        
        if(!bResult.hasErrors()) {
	        
	        model.addAttribute("svcCouponMgmtVO", svcCouponMgmtVO);
	        
	        result = true;
        }
		
		return result ? targetUrl : ERROR_PAGE;
	}
	
	@RequestName("changeDateSvcCouponProc")
	@RequestMapping(value="/changeDateSvcCouponProc.do")
	public String changeDateSvcCouponProc(SvcCouponMgmtVO svcCouponMgmtVO, BindingResult bResult, ModelMap model, HttpServletRequest request) {
		
    	String bizName = "쿠폰 사용가능 실행";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        
        log.debug("##### SvcCouponMgmtController changeDateSvcCouponProc ##### ==> " + svcCouponMgmtVO.toString());
        boolean isSuccess = false;
        try {
			UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
			if(userSessionVO != null) {
				svcCouponMgmtVO.setExtendAdminId(userSessionVO.getUsrId());
				isSuccess = svcCouponMgmtService.changeDateSvcCouponProc(svcCouponMgmtVO);
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
       
		
		model.addAttribute("isSuccess", String.valueOf(isSuccess));
		
		return JSONVIEW;
	}
	
	@RequestName(value="getSvcCouponBuyList")
	@RequestMapping(value = "/getSvcCouponBuyList.do")
	public String getSvcCouponBuytList(@ModelAttribute @Valid SvcCouponMgmtVO svcCouponMgmtVO, BindingResult bResult, ModelMap model, HttpServletRequest request) throws Exception {
		
		String targetUrl = RETUR_URL.concat("svc_couBuy_list");
    	String bizName = "초과요금 조회 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        boolean result = false;
        
        try {
        	svcCouponMgmtVO.setPagingYn("Y");
			if(svcCouponMgmtVO.getViewFlg() != null && svcCouponMgmtVO.getViewFlg().equals(MODE_EXCEL)) {
				svcCouponMgmtVO.setPagingYn("N");
			} 
			
        	int sizeList = svcCouponMgmtService.getSvcCouponBuyListCount(svcCouponMgmtVO);
        	
			PaginationInfo paginationInfo = getPagingInfo(svcCouponMgmtVO.getCurrentPageNo(), sizeList);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(svcCouponMgmtVO.getCurrentPageNo(), sizeList);
			svcCouponMgmtVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			svcCouponMgmtVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<SvcCouponMgmtVO> resultList = svcCouponMgmtService.getSvcCouponBuyList(svcCouponMgmtVO);
			
			model.addAttribute("searchCondition", svcCouponMgmtVO);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo",paginationMobileInfo);
			model.addAttribute("svccouponBuyList", resultList);

			result =true;
        }catch(CfoodException e) {
        	throw new CfoodException(getMessage("fail.common.msg"));
        }
        
        if(svcCouponMgmtVO.getViewFlg().equals(MODE_EXCEL)) {
			targetUrl =  RETUR_URL.concat("svc_couBuy_list_excel");
		}
		
        return result ? targetUrl : ERROR_PAGE;
	}
	
	@RequestName(value="getSvcCouponBuyDetail")
	@RequestMapping(value = "/getSvcCouponBuyDetail.do")
	public String getSvcCouponBuytDetail(@ModelAttribute @Valid SvcCouponMgmtVO svcCouponMgmtVO, BindingResult bResult, ModelMap model, HttpServletRequest request) throws Exception {
		
		String targetUrl = RETUR_URL.concat("svc_couBuy_detail");
    	String bizName = "초과요금 조회 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        boolean result = false;
        
        try {
        	svcCouponMgmtVO.setPagingYn("Y");
			if(svcCouponMgmtVO.getViewFlg() != null && svcCouponMgmtVO.getViewFlg().equals(MODE_EXCEL)) {
				svcCouponMgmtVO.setPagingYn("N");
			} else {
				svcCouponMgmtVO.setCouponName(new String(svcCouponMgmtVO.getCouponName().getBytes("ISO-8859-1"), "UTF-8"));
			}
			
        	int sizeList = svcCouponMgmtService.getSvcCouponBuyDetailListCount(svcCouponMgmtVO);
        	
			PaginationInfo paginationInfo = getPagingInfo(svcCouponMgmtVO.getCurrentPageNo(), sizeList);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(svcCouponMgmtVO.getCurrentPageNo(), sizeList);
			svcCouponMgmtVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			svcCouponMgmtVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<SvcCouponMgmtVO> resultList = svcCouponMgmtService.getSvcCouponBuyDetailList(svcCouponMgmtVO);
			
			model.addAttribute("searchCondition", svcCouponMgmtVO);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo",paginationMobileInfo);
			model.addAttribute("svccouponBuyDetailList", resultList);

			result =true;
        }catch(CfoodException e) {
        	throw new CfoodException(getMessage("fail.common.msg"));
        }
        
        if(svcCouponMgmtVO.getViewFlg().equals(MODE_EXCEL)) {
			targetUrl =  RETUR_URL.concat("svc_couBuy_detail_excel");
		}
		
        return result ? targetUrl : ERROR_PAGE;
	}
	
	@RequestName(value="getSvcCouponUseList")
	@RequestMapping(value = "/getSvcCouponUseList.do")
	public String getSvcCouponUseMgmtList(@ModelAttribute @Valid SvcCouponMgmtVO svcCouponMgmtVO, BindingResult bResult, ModelMap model, HttpServletRequest request) throws Exception {
		
		String targetUrl = RETUR_URL.concat("svc_couUse_list");
    	String bizName = "쿠폰사용 내역 조회 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        boolean result = false;
        
        try {
        	svcCouponMgmtVO.setPagingYn("Y");
			if(svcCouponMgmtVO.getViewFlg() != null && svcCouponMgmtVO.getViewFlg().equals(MODE_EXCEL)) {
				svcCouponMgmtVO.setPagingYn("N");
			} 
			//if(svcCouponMgmtVO.getUsrSearchKey()!=null && svcCouponMgmtVO.getUsrSearchKey()!="")
			//	svcCouponMgmtVO.setUsrSearchKey(new String(svcCouponMgmtVO.getUsrSearchKey().getBytes("ISO-8859-1"), "UTF-8"));
        	
        	int sizeList = svcCouponMgmtService.getSvcCouponUseListCount(svcCouponMgmtVO);
        	
			PaginationInfo paginationInfo = getPagingInfo(svcCouponMgmtVO.getCurrentPageNo(), sizeList);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(svcCouponMgmtVO.getCurrentPageNo(), sizeList);
			svcCouponMgmtVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			svcCouponMgmtVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<SvcCouponMgmtVO> resultList = svcCouponMgmtService.getSvcCouponUseList(svcCouponMgmtVO);
			
			model.addAttribute("searchCondition", svcCouponMgmtVO);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo",paginationMobileInfo);
			model.addAttribute("svccouponUseList", resultList);

			result =true;
        }catch(CfoodException e) {
        	throw new CfoodException(getMessage("fail.common.msg"));
        }
        
        if(svcCouponMgmtVO.getViewFlg().equals(MODE_EXCEL)) {
			targetUrl =  RETUR_URL.concat("svc_cou_list_excel");
		}
		
        return result ? targetUrl : ERROR_PAGE;
	}
	
	@RequestName(value="useCouponStatistics")
	@RequestMapping(value = "/coupon/useCouponStatistics.do")
	public String useCouponStatistics(@ModelAttribute @Valid SvcCouponMgmtVO svcCouponMgmtVO, BindingResult bResult, ModelMap model, HttpServletRequest request) throws Exception {
		
		String targetUrl = RETUR_URL.concat("svc_couStat_use");
    	String bizName = "쿠폰 등록 사용현황 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        boolean result = false;
        
        try {
        	
			
			List<SvcCouponMgmtVO> resultList = svcCouponMgmtService.getSvcCouponStat(svcCouponMgmtVO);
			
			model.addAttribute("searchCondition", svcCouponMgmtVO);
			
			model.addAttribute("svccouponStat", resultList);

			result =true;
        }catch(CfoodException e) {
        	throw new CfoodException(getMessage("fail.common.msg"));
        }
        
        
		
        return result ? targetUrl : ERROR_PAGE;
	}
	
	@RequestName(value="dailyCouponStatistics")
	@RequestMapping(value = "/coupon/dailyCouponStatistics.do")
	public String dailyCouponStatistics(@ModelAttribute @Valid SvcCouponMgmtVO svcCouponMgmtVO, BindingResult bResult, ModelMap model, HttpServletRequest request) throws Exception {
		
		String targetUrl = RETUR_URL.concat("svc_couStat_day");
    	String bizName = "쿠폰 일일 현황 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        boolean result = false;
        
        try {
        	
			
			List<SvcCouponMgmtVO> resultList = svcCouponMgmtService.getSvcCouponDayStat(svcCouponMgmtVO);
			
			model.addAttribute("searchCondition", svcCouponMgmtVO);
			
			model.addAttribute("svccouponDayStat", resultList);

			result =true;
        }catch(CfoodException e) {
        	throw new CfoodException(getMessage("fail.common.msg"));
        }
        
        
		
        return result ? targetUrl : ERROR_PAGE;
	}
	
	@RequestName(value="bilCouponStatistics")
	@RequestMapping(value = "/coupon/bilCouponStatistics.do")
	public String bilCouponStatistics(@ModelAttribute @Valid SvcCouponMgmtVO svcCouponMgmtVO, BindingResult bResult, ModelMap model, HttpServletRequest request) throws Exception {
		
		String targetUrl = RETUR_URL.concat("svc_couStat_bil");
    	String bizName = "쿠폰 일일 현황 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        boolean result = false;
        
        try {
        	
			List<SvcCouponMgmtVO> resultList = svcCouponMgmtService.getSvcCouponBilStat(svcCouponMgmtVO);
			
			model.addAttribute("searchCondition", svcCouponMgmtVO);
			
			model.addAttribute("svccouponBilStat", resultList);

			result =true;
        }catch(CfoodException e) {
        	throw new CfoodException(getMessage("fail.common.msg"));
        }
        
        
		
        return result ? targetUrl : ERROR_PAGE;
	}
	
	@RequestName(value="getCouponMbName")
	@RequestMapping(value = "/coupon/getCouponMbName.do")
	public String getCouponMbName(@ModelAttribute @Valid SvcCouponMgmtVO svcCouponMgmtVO, BindingResult bResult, ModelMap model, HttpServletRequest request) throws Exception {
		
    	String bizName = "쿠폰 일일 현황 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        boolean result = false;
        
        try {
        	
			List<SvcCouponMgmtVO> resultList = svcCouponMgmtService.getCouponMbName(svcCouponMgmtVO);
			
			model.addAttribute("searchCondition", svcCouponMgmtVO);
			
			model.addAttribute("codeList", resultList);

			result =true;
        }catch(CfoodException e) {
        	throw new CfoodException(getMessage("fail.common.msg"));
        }
        
        
		
        return JSONVIEW;
	}
}
