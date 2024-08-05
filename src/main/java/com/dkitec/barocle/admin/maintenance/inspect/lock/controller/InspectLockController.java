package com.dkitec.barocle.admin.maintenance.inspect.lock.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

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

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.dkitec.barocle.admin.maintenance.inspect.lock.service.InspectLockService;
import com.dkitec.barocle.admin.maintenance.inspect.lock.vo.InspectLockVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.HttpUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="InspectLockController")
public class InspectLockController extends BaseController {
	protected static Logger log = LoggerFactory.getLogger(InspectLockController.class);
	@Resource(name="inspectLockService")
	
	private InspectLockService inspectLockService;
	
	private static final String RETURN_URL = "/admin/maintenance/inspect/lock/";

	@RequestMapping(value="/inspectLockList.do")
	@RequestName(value="getInspectLockList")
	public String getInspectLockList(@ModelAttribute @Valid InspectLockVO inspectLockVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("che_std_list");
		String bizName = "거치대 장애관리 화면";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			inspectLockVo.setPagingYn("Y");

			if(inspectLockVo.getMode() != null && inspectLockVo.getMode().equals("excel")){
				resultPage = RETURN_URL.concat("che_std_list_excel");
				inspectLockVo.setPagingYn("N");
			}
			
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			
			if(inspectLockVo.getSearchBgnDe() == null && inspectLockVo.getSearchEndDe() == null){
				inspectLockVo.setSearchEndDe(sdf.format(cal.getTime()));
				cal.add(Calendar.DAY_OF_MONTH, -6);
				inspectLockVo.setSearchBgnDe(sdf.format(cal.getTime()));
			}
			
			int totCnt = inspectLockService.getInspectLockListCount(inspectLockVo);
			PaginationInfo paginationInfo = getPagingInfo(inspectLockVo.getCurrentPageNo(), totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(inspectLockVo.getCurrentPageNo(), totCnt);
			
			inspectLockVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			inspectLockVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<InspectLockVO> resultList = inspectLockService.getInspectLockList(inspectLockVo);
					
			model.addAttribute("searchCondition", inspectLockVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("InspectLockList", resultList);
			
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.maintenance.che_std_list");
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}

}
