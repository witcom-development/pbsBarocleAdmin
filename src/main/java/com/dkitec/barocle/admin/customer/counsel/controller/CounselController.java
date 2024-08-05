package com.dkitec.barocle.admin.customer.counsel.controller;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.dkitec.barocle.admin.customer.counsel.service.CounselService;
import com.dkitec.barocle.admin.customer.counsel.vo.CounselVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.HttpUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="CounselController")
@RequestMapping(value="/admin/customer/counsel")
public class CounselController extends BaseController {
	
	@Resource(name = "counselService") private CounselService counselService;
	
	private static final String RETURN_URL = "/admin/customer/counsel/";
	
	protected static Logger log = LoggerFactory.getLogger(CounselController.class);
	
	@RequestName(value="getCounselList")
	@RequestMapping(value="/counselList.do")
	public String getCounselList(@ModelAttribute @Valid CounselVO counselVo, BindingResult result ,HttpServletRequest request,ModelMap model){
		
		boolean bResult = true;
		String targetUrl = RETURN_URL.concat("bor_cou_list");
		
		try {
			int totCnt = counselService.getCounselListCount(counselVo);
			PaginationInfo paginationInfo = getPagingInfo(counselVo.getCurrentPageNo(), 10, 10, totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(counselVo.getCurrentPageNo(), 10, 10, totCnt);
			
			counselVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			counselVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<CounselVO> resultList = counselService.getCounselList(counselVo);
			List<CounselVO> conslLcdList = counselService.getConslLcdList(counselVo);

			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("searchParam", counselVo);
			model.addAttribute("CounselList", resultList);
			model.addAttribute("LcdList", conslLcdList);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}


		return bResult? targetUrl : ERROR_PAGE;
	}
	
	@RequestMapping(value="/conslMcdListAjax.do")
	@RequestName(value="conslMcdListAjax")
	public String conslMcdListAjax(@ModelAttribute CounselVO counselVo, HttpServletRequest request, ModelMap model) throws Exception{
		
		String bizName = "바로클포 수리완료 처리";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		try {
			List<CounselVO> resultList = counselService.getConslMcdList(counselVo);
			model.addAttribute(RESULT_MESSAGE, "Success");
			model.addAttribute("McdList", resultList);
			model.addAttribute(CHECK_RESULT, 0);
		} catch (Exception e) {
			throw new CfoodException("admin.repairBikeMall.repairBike.updateRepairTnsBike");
		}
		
		return JSONVIEW;
	}
	

}
