package com.dkitec.barocle.admin.service.paymentmgmt.failpayment.controller;

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
import com.dkitec.barocle.admin.service.paymentmgmt.failpayment.service.FailPaymentService;
import com.dkitec.barocle.admin.service.paymentmgmt.failpayment.vo.FailPaymentVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.HttpUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="FailPaymentController")
//@RequestMapping(value="/admin/service/paymentmgmt")
public class FailPaymentController extends BaseController {
protected static Logger log = LoggerFactory.getLogger(FailPaymentController.class);
	
	@Resource(name = "failPaymentService") private FailPaymentService failPaymentService;
	
	private static final String RETUR_URL = "/admin/service/payment/failpay/";
	private static final String POP_URL = "/admin/common/popup/";
	
	@RequestName(value="getFailPaymentList")
	@RequestMapping(value = "/getFailPaymentList.do")
	public String getFailPaymentList(@ModelAttribute @Valid FailPaymentVO failPaymentVO, BindingResult bResult, ModelMap model, HttpServletRequest request) throws Exception {
		
		String targetUrl = RETUR_URL.concat("svc_pay_err");
    	String bizName = "결제실패 내역 조회 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        boolean result = false;
        
        try {
        	failPaymentVO.setPagingYn("Y");
			if(failPaymentVO.getViewFlg() != null && failPaymentVO.getViewFlg().equals(MODE_EXCEL)) {
				failPaymentVO.setPagingYn("N");
			} 
        	
        	int sizeList = failPaymentService.getFailPaymentListCount(failPaymentVO);
        	
			PaginationInfo paginationInfo = getPagingInfo(failPaymentVO.getCurrentPageNo(), sizeList);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(failPaymentVO.getCurrentPageNo(), sizeList);
			failPaymentVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			failPaymentVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<FailPaymentVO> resultList = failPaymentService.getFailPaymentList(failPaymentVO);
			
			model.addAttribute("searchCondition", failPaymentVO);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo",paginationMobileInfo);
			model.addAttribute("failPaymentList", resultList);

			result =true;
        }catch(CfoodException e) {
        	throw new CfoodException(getMessage("fail.common.msg"));
        }
        
        if(failPaymentVO.getViewFlg().equals(MODE_EXCEL)) {
			targetUrl =  RETUR_URL.concat("svc_pay_err_excel");
		}
		
        return result ? targetUrl : ERROR_PAGE;
	}
}
