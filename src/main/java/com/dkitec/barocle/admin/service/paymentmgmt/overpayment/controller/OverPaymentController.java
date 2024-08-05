package com.dkitec.barocle.admin.service.paymentmgmt.overpayment.controller;

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
import com.dkitec.barocle.admin.service.paymentmgmt.overpayment.service.OverPaymentService;
import com.dkitec.barocle.admin.service.paymentmgmt.overpayment.vo.OverPaymentVO;
import com.dkitec.barocle.admin.service.paymentmgmt.payment.vo.PaymentVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.HttpUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="OverPaymentController")
//@RequestMapping(value="/admin/service/paymentmgmt")
public class OverPaymentController extends BaseController {
	protected static Logger log = LoggerFactory.getLogger(OverPaymentController.class);
	
	@Resource(name = "overPaymentService") private OverPaymentService overPaymentService;
	
	private static final String RETUR_URL = "/admin/service/payment/over/";
	private static final String POP_URL = "/admin/common/popup/";
	
	@RequestName(value="getOverPaymentList")
	@RequestMapping(value = "/getOverPaymentList.do")
	public String getOverPaymentList(@ModelAttribute @Valid PaymentVO paymentVO, BindingResult bResult, ModelMap model, HttpServletRequest request) throws Exception {
		
		String targetUrl = RETUR_URL.concat("svc_ovr_list");
    	String bizName = "초과요금 조회 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        boolean result = false;
        
        try {
        	paymentVO.setPagingYn("Y");
			if(paymentVO.getViewFlg() != null && paymentVO.getViewFlg().equals(MODE_EXCEL)) {
				paymentVO.setPagingYn("N");
			} 
        	
        	int sizeList = overPaymentService.getOverPaymentListCount(paymentVO);
        	
			PaginationInfo paginationInfo = getPagingInfo(paymentVO.getCurrentPageNo(), sizeList);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(paymentVO.getCurrentPageNo(), sizeList);
			paymentVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			paymentVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<OverPaymentVO> resultList = overPaymentService.getOverPaymentList(paymentVO);
			
			model.addAttribute("searchCondition", paymentVO);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo",paginationMobileInfo);
			model.addAttribute("overPaymentList", resultList);

			result =true;
        }catch(CfoodException e) {
        	throw new CfoodException(getMessage("fail.common.msg"));
        }
        
        if(paymentVO.getViewFlg().equals(MODE_EXCEL)) {
			targetUrl =  RETUR_URL.concat("svc_ovr_list_excel");
		}
		
        return result ? targetUrl : ERROR_PAGE;
	}
	
}
