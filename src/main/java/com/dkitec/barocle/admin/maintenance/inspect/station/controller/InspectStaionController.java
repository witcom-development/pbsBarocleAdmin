package com.dkitec.barocle.admin.maintenance.inspect.station.controller;

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
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.admin.login.vo.UserSessionVO;
import com.dkitec.barocle.admin.maintenance.inspect.station.service.InspectStationService;
import com.dkitec.barocle.admin.maintenance.inspect.station.vo.InspectStationVO;
import com.dkitec.barocle.admin.maintenance.repair.ap.vo.RepairApVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.HttpUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="InspectStationController")
public class InspectStaionController extends BaseController {
	protected static Logger log = LoggerFactory.getLogger(InspectStaionController.class);
	@Resource(name="inspectStationService")
	
	private InspectStationService inspectStationService;
	
	private static final String RETURN_URL = "/admin/maintenance/inspect/station/";

	@RequestMapping(value="/inspectStationList.do")
	@RequestName(value="getInspectStationList")
	public String getInspectStationList(@ModelAttribute @Valid InspectStationVO inspectStationVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("che_sta_list");
		String bizName = "대여소 장애관리 화면";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			inspectStationVo.setPagingYn("Y");
			
			/* 엑셀로 뽑지 않음
			 * if(inspectApVo.getMode() != null && inspectApVo.getMode().equals("excel")){
				resultPage = RETURN_URL.concat("che_sta_list_excel");
				inspectApVo.setPagingYn("N");
			}*/
			
			/* 날짜 검색 하지 않음
			 * Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			
			if(inspectApVo.getSearchBgnDe() == null && inspectApVo.getSearchEndDe() == null){
				inspectApVo.setSearchEndDe(sdf.format(cal.getTime()));
				cal.add(Calendar.DAY_OF_MONTH, -6);
				inspectApVo.setSearchBgnDe(sdf.format(cal.getTime()));
			}*/
			
			
			int totCnt = inspectStationService.getInspectStationListCount(inspectStationVo);
			PaginationInfo paginationInfo = getPagingInfo(inspectStationVo.getCurrentPageNo(), totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(inspectStationVo.getCurrentPageNo(), totCnt);
			
			inspectStationVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			inspectStationVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<InspectStationVO> resultList = inspectStationService.getInspectStationList(inspectStationVo);
					
			model.addAttribute("searchCondition", inspectStationVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("InspectStationList", resultList);
			
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.maintenance.che_sta_list");
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
}
