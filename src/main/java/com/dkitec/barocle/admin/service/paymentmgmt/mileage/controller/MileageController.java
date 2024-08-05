package com.dkitec.barocle.admin.service.paymentmgmt.mileage.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
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
import com.dkitec.barocle.admin.service.paymentmgmt.mileage.service.MileageService;
import com.dkitec.barocle.admin.service.paymentmgmt.mileage.vo.MileageVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.HttpUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="MileageController")
public class MileageController extends BaseController {
	protected static Logger log = LoggerFactory.getLogger(MileageController.class);
	
	@Resource(name = "mileageService") private MileageService mileageService;
	
	private static final String RETUR_URL = "/admin/service/payment/mileage/";
	
	@RequestName(value="getMileageList")
	@RequestMapping(value = "/getMileageList.do")
	public String getMileageList(@ModelAttribute @Valid MileageVO mileageVO, BindingResult bResult, ModelMap model, HttpServletRequest request) throws Exception {
		
		String targetUrl = RETUR_URL.concat("svc_mil_list");
    	String bizName = "마일리지 내역 조회 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        boolean result = false;
        
        try {
			
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowDay = sdf.format(cal.getTime());
			
			if(mileageVO.getSearchStrDate() == null){
				mileageVO.setSearchStrDate(nowDay);
			}
			if(mileageVO.getSearchEndDate() == null){
				mileageVO.setSearchEndDate(nowDay);
			}
			
        	mileageVO.setPagingYn("Y");
			if(mileageVO.getViewFlg() != null && mileageVO.getViewFlg().equals(MODE_EXCEL)) {
				mileageVO.setPagingYn("N");
			} 
        	
			int count = mileageService.getMileageHistCount(mileageVO);
			
			PaginationInfo paginationInfo = getPagingInfo(mileageVO.getCurrentPageNo(), count);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(mileageVO.getCurrentPageNo(), count);
			mileageVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			mileageVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<MileageVO> resultList = null;
			resultList = mileageService.getMileageHistList(mileageVO);
			
			int totalSum = 0;
			totalSum = mileageService.getMileageHistTotalSum(mileageVO);
			
			model.addAttribute("searchCondition", mileageVO);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo",paginationMobileInfo);
			model.addAttribute("totalSum", totalSum);
			model.addAttribute("mileageList", resultList);

			result =true;
        }catch(CfoodException e) {
        	throw new CfoodException(getMessage("fail.common.msg"));
        }
        
        if(mileageVO.getViewFlg().equals(MODE_EXCEL)) {
			targetUrl =  RETUR_URL.concat("svc_mil_list_excel");
		}
		
        return result ? targetUrl : ERROR_PAGE;
	}
	
}
