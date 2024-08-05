package com.dkitec.barocle.admin.service.paymentmgmt.refund.controller;

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
import com.dkitec.barocle.admin.service.paymentmgmt.refund.service.RefundService;
import com.dkitec.barocle.admin.service.paymentmgmt.refund.vo.RefundVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.HttpUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="RefundController")
//@RequestMapping(value="/admin/service/paymentmgmt")
public class RefundController extends BaseController {
	protected static Logger log = LoggerFactory.getLogger(RefundController.class);
	
	@Resource(name = "refundService") private RefundService refundService;
	
	private static final String RETUR_URL = "/admin/service/payment/rep/";
	private static final String POP_URL = "/admin/common/popup/";
	
	@RequestName(value="getRefundList")
	@RequestMapping(value = "/getRefundList.do")
	public String getRefundList(@ModelAttribute @Valid RefundVO refundVO, BindingResult bResult, ModelMap model, HttpServletRequest request) throws Exception {
		
		String targetUrl = RETUR_URL.concat("svc_rep_list");
    	String bizName = "환불내역 조회 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        boolean result = false;
        
        try {
        	refundVO.setPagingYn("Y");
			if(refundVO.getViewFlg() != null && refundVO.getViewFlg().equals(MODE_EXCEL)) {
				refundVO.setPagingYn("N");
			} 
        	
			RefundVO countList = null;
			if(refundVO.getSearchType() != null && refundVO.getSearchType().equals("02")){
				countList = refundService.getCancelPaymentListCount(refundVO);
			} else {
				countList = refundService.getRefundListCount(refundVO);
			}
			
			PaginationInfo paginationInfo = getPagingInfo(refundVO.getCurrentPageNo(), countList.getSearchCount());
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(refundVO.getCurrentPageNo(), countList.getSearchCount());
			refundVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			refundVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<RefundVO> resultList = null;
			if(refundVO.getSearchType() != null && refundVO.getSearchType().equals("02")){
				resultList = refundService.getCancelPaymentList(refundVO);
			} else {
				resultList = refundService.getRefundList(refundVO);
			}
			
			model.addAttribute("searchCondition", refundVO);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo",paginationMobileInfo);
			model.addAttribute("searchTotAmt", countList.getSearchTotAmt());
			model.addAttribute("refundList", resultList);

			result =true;
        }catch(CfoodException e) {
        	throw new CfoodException(getMessage("fail.common.msg"));
        }
        
        if(refundVO.getViewFlg().equals(MODE_EXCEL)) {
			targetUrl =  RETUR_URL.concat("svc_rep_list_excel");
		}
		
        return result ? targetUrl : ERROR_PAGE;
	}
	
}
