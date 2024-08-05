package com.dkitec.barocle.admin.system.savecarbon.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.dkitec.barocle.admin.system.savecarbon.service.SaveCarbonService;
import com.dkitec.barocle.admin.system.savecarbon.vo.SaveCarbonVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.HttpUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="SaveCarbonController")
@RequestMapping(value="/admin/system/savecarbon")
public class SaveCarbonController extends BaseController {
	
	@Resource(name = "saveCarbonService") private SaveCarbonService saveCarbonService;
	
	protected static Logger log = LoggerFactory.getLogger(SaveCarbonController.class);
		
	@RequestName(value="saveCarbonList")
	@RequestMapping(value="/saveCarbonList.do")
	public String editMainSet(@ModelAttribute @Valid SaveCarbonVO saveCarbonVo, BindingResult result, Model model, HttpServletRequest request) {
		
		String bizName = "절감탄소량 조회";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		boolean bResult = false;
		String resultPage = "/admin/system/saveCarbon/sys_savecarbon_list";
		
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); 
		
		java.util.List<SaveCarbonVO> saveCarbonList  = new java.util.ArrayList<SaveCarbonVO>();
		java.util.List<SaveCarbonVO> goalList  = new java.util.ArrayList<SaveCarbonVO>();
		java.util.List<SaveCarbonVO> meansList  = new java.util.ArrayList<SaveCarbonVO>();
		
		if(saveCarbonVo.getSearchStartDate() == null || saveCarbonVo.getSearchStartDate().equals("")){
			
			saveCarbonVo.setSearchStartDate(sdf.format(now));
			saveCarbonVo.setSearchEndDate(sdf.format(now));
		}
		
		int totCnt = saveCarbonService.getSaveCarbonListCnt(saveCarbonVo);
		
		PaginationInfo paginationInfo = getPagingInfo(saveCarbonVo.getCurrentPageNo(), totCnt);
		PaginationInfo paginationMobileInfo = getPagingMobileInfo(saveCarbonVo.getCurrentPageNo(), totCnt);
		
		saveCarbonVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
		saveCarbonVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		//이용목적 List
		goalList = saveCarbonService.getGoalList();
		//이용수단 List
		meansList = saveCarbonService.getMeansList();
		
		saveCarbonList = saveCarbonService.getSaveCarbonList(saveCarbonVo);
		
		String totSaveCarbon = saveCarbonService.getTotalSaveCarbon(saveCarbonVo);
		
		if(saveCarbonList != null)
			bResult = true;
		
		model.addAttribute("saveCarbonList", saveCarbonList);
		model.addAttribute("goalList", goalList);		//이용목적
		model.addAttribute("meansList", meansList);		//이용수단
		model.addAttribute("saveCarbonVo", saveCarbonVo);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totSaveCarbon", totSaveCarbon);
		model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			
		return bResult ? resultPage : ERROR_PAGE;
	}
}
