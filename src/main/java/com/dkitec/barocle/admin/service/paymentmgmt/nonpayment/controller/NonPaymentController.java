package com.dkitec.barocle.admin.service.paymentmgmt.nonpayment.controller;

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
import com.dkitec.barocle.admin.service.paymentmgmt.nonpayment.service.NonPaymentService;
import com.dkitec.barocle.admin.service.paymentmgmt.nonpayment.vo.NonPaymentVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.HttpUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="NonPaymentController")
//@RequestMapping(value="/admin/service/paymentmgmt")
public class NonPaymentController extends BaseController {
	protected static Logger log = LoggerFactory.getLogger(NonPaymentController.class);
	
	@Resource(name = "nonPaymentService") private NonPaymentService nonPaymentService;
	
	private static final String RETUR_URL = "/admin/service/payment/nonpay/";
	private static final String POP_URL = "/admin/common/popup/";
	
	@RequestName(value="getNonPaymentList")
	@RequestMapping(value = "/getNonPaymentList.do")
	public String getNonPaymentList(@ModelAttribute @Valid NonPaymentVO nonPaymentVO, BindingResult bResult, ModelMap model, HttpServletRequest request) throws Exception {
		
		String targetUrl = RETUR_URL.concat("svc_add_list");
    	String bizName = "미납내역 조회 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        boolean result = false;
        
        try {
        	nonPaymentVO.setPagingYn("Y");
        	
        	if( nonPaymentVO.getStationGrpSeq() != null && nonPaymentVO.getStationGrpSeq() != "" && nonPaymentVO.getStationId().equals("")) {
        		nonPaymentVO.setStationIdList(nonPaymentService.getStation(nonPaymentVO.getStationGrpSeq()));
			}
			if(nonPaymentVO.getViewFlg() != null && nonPaymentVO.getViewFlg().equals(MODE_EXCEL)) {
				nonPaymentVO.setPagingYn("N");
			} 
        	
			int sizeList = nonPaymentService.getNonPaymentListCount(nonPaymentVO);
        	
			PaginationInfo paginationInfo = getPagingInfo(nonPaymentVO.getCurrentPageNo(), sizeList);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(nonPaymentVO.getCurrentPageNo(), sizeList);
			nonPaymentVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			nonPaymentVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<NonPaymentVO> resultList = nonPaymentService.getNonPaymentList(nonPaymentVO);
			
			model.addAttribute("searchCondition", nonPaymentVO);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo",paginationMobileInfo);
			model.addAttribute("nonPaymentList", resultList);
			
			result =true;
        }catch(CfoodException e) {
        	throw new CfoodException(getMessage("fail.common.msg"));
        }
        
        if(nonPaymentVO.getViewFlg().equals(MODE_EXCEL)) {
			targetUrl =  RETUR_URL.concat("svc_add_list_excel");
		}
		
        return result ? targetUrl : ERROR_PAGE;
	}
	
	@RequestName(value="getAddPayInfo")
	@RequestMapping(value = "/moveAddPayPop.do")
	public String getAddPayInfo(@ModelAttribute NonPaymentVO nonPaymentVO, BindingResult bResult, ModelMap model, HttpServletRequest request) throws Exception {
		String targetUrl = POP_URL.concat("pop_pay_pro");
    	String bizName = "미납내역 관리자 처리 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        boolean result = false;
        
        try {
	        NonPaymentVO resultVo = null;
	        if(nonPaymentVO.getViewFlg().equals(MODE_UPDATE) || nonPaymentVO.getViewFlg().equals(MODE_VIEW)) {
				//resultVo = nonPaymentService.getAddPayInfo(nonPaymentVO);
			} else {
				resultVo = nonPaymentVO;
			}
	        
			model.addAttribute("nonPaymentVO", resultVo);
			model.addAttribute("viewFlg", nonPaymentVO.getViewFlg());
			
			result =true;
        }catch(CfoodException e) {
        	throw new CfoodException(getMessage("fail.common.msg"));
        }
        
		return result ? targetUrl : ERROR_PAGE;
	}
	
	@RequestName(value="addNonPayment")
	@RequestMapping(value="/addNonPayment.do")
	public String addNonPayment(@ModelAttribute NonPaymentVO nonPaymentVO, BindingResult bindingResult, ModelMap model, HttpServletRequest request ) throws Exception {
		String bizName = "미납내역 관리자 처리";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		String resultMessage = "수정에 성공했습니다.";
		UserSessionVO user = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
		String adminId = user == null ? "test" : user.getUsrId();
		
		int result = 0;
		//if(bindingResult.hasErrors()) {
			//for(ObjectError error : bindingResult.getAllErrors()) {
				//resultMessage = error.getDefaultMessage();
			//}
		//} else {
			if(nonPaymentVO.getViewFlg().equals(MODE_INSERT)) {
				nonPaymentVO.setAdminId(adminId);
				result = nonPaymentService.addNonPayment(nonPaymentVO);
			}
		//}
		model.addAttribute(RESULT_MESSAGE, resultMessage);
		model.addAttribute(RESULT, result);
		
		return JSONVIEW;
	}
}
