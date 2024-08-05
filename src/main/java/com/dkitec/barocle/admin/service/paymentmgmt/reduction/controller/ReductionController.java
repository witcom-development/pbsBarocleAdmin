package com.dkitec.barocle.admin.service.paymentmgmt.reduction.controller;

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
import com.dkitec.barocle.admin.service.paymentmgmt.reduction.service.ReductionService;
import com.dkitec.barocle.admin.service.paymentmgmt.reduction.vo.ReductionVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.HttpUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="ReductionController")
//@RequestMapping(value="/admin/service/paymentmgmt")
public class ReductionController extends BaseController {
	protected static Logger log = LoggerFactory.getLogger(ReductionController.class);
	
	@Resource(name = "reductionService") private ReductionService reductionService;
	
	private static final String RETUR_URL = "/admin/service/payment/reduction/";
	private static final String POP_URL = "/admin/common/popup/";
	
	@RequestName(value="getReductionList")
	@RequestMapping(value = "/getReductionList.do")
	public String getReductionList(@ModelAttribute @Valid ReductionVO reductionVO, BindingResult bResult, ModelMap model, HttpServletRequest request) throws Exception {
		
		String targetUrl = RETUR_URL.concat("svc_red_list");
    	String bizName = "초과요금 조회 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        boolean result = false;
        
        try {
        	reductionVO.setPagingYn("Y");
			if(reductionVO.getViewFlg() != null && reductionVO.getViewFlg().equals(MODE_EXCEL)) {
				reductionVO.setPagingYn("N");
			} 
			if(reductionVO.getUsrSearchKey()!=null && reductionVO.getUsrSearchKey()!="")
				reductionVO.setUsrSearchKey(new String(reductionVO.getUsrSearchKey().getBytes("ISO-8859-1"), "UTF-8"));
        	
        	int sizeList = reductionService.getReductionListCount(reductionVO);
        	
			PaginationInfo paginationInfo = getPagingInfo(reductionVO.getCurrentPageNo(), sizeList);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(reductionVO.getCurrentPageNo(), sizeList);
			reductionVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			reductionVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<ReductionVO> resultList = reductionService.getReductionList(reductionVO);
			
			model.addAttribute("searchCondition", reductionVO);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo",paginationMobileInfo);
			model.addAttribute("reductionList", resultList);

			result =true;
        }catch(CfoodException e) {
        	throw new CfoodException(getMessage("fail.common.msg"));
        }
        
        if(reductionVO.getViewFlg().equals(MODE_EXCEL)) {
			targetUrl =  RETUR_URL.concat("svc_ovr_list_excel");
		}
		
        return result ? targetUrl : ERROR_PAGE;
	}
	
}
