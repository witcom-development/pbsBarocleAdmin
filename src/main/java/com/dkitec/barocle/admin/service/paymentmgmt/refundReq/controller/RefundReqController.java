package com.dkitec.barocle.admin.service.paymentmgmt.refundReq.controller;

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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.admin.login.vo.UserSessionVO;
import com.dkitec.barocle.admin.service.paymentmgmt.refundReq.service.RefundReqService;
import com.dkitec.barocle.admin.service.paymentmgmt.refundReq.vo.RefundReqVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.payment.NiceCheckUtil;
import com.dkitec.barocle.util.webutil.HttpUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="RefundReqController")
//@RequestMapping(value="/admin/service/paymentmgmt")
public class RefundReqController extends BaseController {
	protected static Logger log = LoggerFactory.getLogger(RefundReqController.class);
	
	@Resource(name = "refundReqService") private RefundReqService refundReqService;
	
	private static final String RETUR_URL = "/admin/service/payment/refundReq/";
	private static final String POP_URL = "/admin/common/popup/";
	
	@RequestName(value="getRefundReqList")
	@RequestMapping(value = "/getRefundReqList.do")
	public String getRefundList(@ModelAttribute @Valid RefundReqVO refundReqVO, BindingResult bResult, ModelMap model, HttpServletRequest request) throws Exception {
		
		String targetUrl = RETUR_URL.concat("svc_repReq_list");
    	String bizName = "환불신청내역 조회 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        boolean result = false;
        UserSessionVO userSessionVO = (UserSessionVO) EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
        String usrGrpCd = userSessionVO.getUsrGrpCd();
        
        try {
        	refundReqVO.setPagingYn("Y");
			if(refundReqVO.getViewFlg() != null && refundReqVO.getViewFlg().equals(MODE_EXCEL)) {
				refundReqVO.setPagingYn("N");
			} 
        	
			RefundReqVO countList = null;
			if(refundReqVO.getSearchType() != null && refundReqVO.getSearchType().equals("02")){
				countList = refundReqService.getCancelPaymentListCount(refundReqVO);
			} else {
				countList = refundReqService.getRefundListCount(refundReqVO);
			}
			
			PaginationInfo paginationInfo = getPagingInfo(refundReqVO.getCurrentPageNo(), countList.getSearchCount());
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(refundReqVO.getCurrentPageNo(), countList.getSearchCount());
			refundReqVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			refundReqVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<RefundReqVO> resultList = null;
			if(refundReqVO.getSearchType() != null && refundReqVO.getSearchType().equals("02")){
				resultList = refundReqService.getCancelPaymentList(refundReqVO);
			} else {
				resultList = refundReqService.getRefundList(refundReqVO);
			}
			
			model.addAttribute("searchCondition", refundReqVO);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo",paginationMobileInfo);
			model.addAttribute("searchTotAmt", countList.getSearchTotAmt());
			model.addAttribute("refundList", resultList);
			model.addAttribute("usrGrpCd", usrGrpCd);

			result =true;
        }catch(CfoodException e) {
        	throw new CfoodException(getMessage("fail.common.msg"));
        }
		
        return result ? targetUrl : ERROR_PAGE;
	}
	
	@RequestName(value="getRefundReqListExcel")
	@RequestMapping(value = "/getRefundReqListExcel.do")
	public String getRefundListExcel(@ModelAttribute @Valid RefundReqVO refundReqVO, BindingResult bResult, ModelMap model, HttpServletRequest request) throws Exception {
		
		String targetUrl = RETUR_URL.concat("svc_repReq_list_excel");
    	String bizName = "환불신청내역엑셀 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        boolean result = false;
        
        try {
        	refundReqVO.setPagingYn("Y");
			if(refundReqVO.getViewFlg() != null && refundReqVO.getViewFlg().equals(MODE_EXCEL)) {
				refundReqVO.setPagingYn("N");
			} 
        	
			RefundReqVO countList = null;
			if(refundReqVO.getSearchType() != null && refundReqVO.getSearchType().equals("02")){
				countList = refundReqService.getCancelPaymentListCount(refundReqVO);
			} else {
				countList = refundReqService.getRefundListCount(refundReqVO);
			}
			
			PaginationInfo paginationInfo = getPagingInfo(refundReqVO.getCurrentPageNo(), countList.getSearchCount());
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(refundReqVO.getCurrentPageNo(), countList.getSearchCount());
			refundReqVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			refundReqVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<RefundReqVO> resultList = null;
			if(refundReqVO.getSearchType() != null && refundReqVO.getSearchType().equals("02")){
				resultList = refundReqService.getCancelPaymentList(refundReqVO);
			} else {
				resultList = refundReqService.getRefundList(refundReqVO);
			}
			
			model.addAttribute("searchCondition", refundReqVO);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo",paginationMobileInfo);
			model.addAttribute("searchTotAmt", countList.getSearchTotAmt());
			model.addAttribute("refundList", resultList);

			result =true;
        }catch(CfoodException e) {
        	throw new CfoodException(getMessage("fail.common.msg"));
        }
		
        return result ? targetUrl : ERROR_PAGE;
	}	
	
	@RequestName("memberBankAjax")
	@RequestMapping(value="/memberBankAjax.do")
	public String memberBankAjax(@RequestParam(value="usrSeq") String usrSeq, ModelMap model, HttpServletRequest request) {
		
		String bizName = "환불계좌 정보 조회";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        String acnutBank = "";
        acnutBank = refundReqService.getmemberAcnutBank(usrSeq);
        model.addAttribute("acnutBank", acnutBank);
		
		return JSONVIEW;
	}
	
	@RequestName(value="getCheckRefundNum")
	@RequestMapping(value="/getCheckRefundNumAjax.do")
	public String getCheckRefundNum(@ModelAttribute @Valid RefundReqVO refundVO, BindingResult bindingResult, ModelMap model, HttpServletRequest request ) throws Exception {
		String bizName = "환불 계좌검증";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		Map<String, String> rsMap = NiceCheckUtil.bankCheck(refundVO.getBankList(), refundVO.getAcnutNo(), refundVO.getAcnutNm(), "");
		
		model.addAttribute("RESULT_CODE", rsMap.get("RESULT_CODE"));
		model.addAttribute(RESULT_MESSAGE, rsMap.get("RESULT_MSG"));
		model.addAttribute(RESULT, rsMap.get("IS_SUCCESS"));
		
		return JSONVIEW;
	}
	
	@RequestName("cancleRefundReqkAjax")
	@RequestMapping(value="/cancleRefundReqkAjax.do")
	public String cancleRefundReqkAjax(@ModelAttribute @Valid RefundReqVO refundReqVO, ModelMap model, HttpServletRequest request) {
		
		String bizName = "환불신청 취소";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        
        model.addAttribute(RESULT_MESSAGE, "fail");
		if(refundReqService.cancleRefundReq(refundReqVO)>0){
			model.addAttribute(RESULT_MESSAGE, "Success");
		}				
		
		return JSONVIEW;
	}
	
}
