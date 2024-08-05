package com.dkitec.barocle.admin.maintenance.inspect.ap.controller;

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
import com.dkitec.barocle.admin.maintenance.inspect.ap.service.InspectApService;
import com.dkitec.barocle.admin.maintenance.inspect.ap.vo.InspectApVO;
import com.dkitec.barocle.admin.maintenance.repair.ap.vo.RepairApVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.HttpUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="InspectApController")
public class InspectApController extends BaseController {
	protected static Logger log = LoggerFactory.getLogger(InspectApController.class);
	@Resource(name="inspectApService")
	
	private InspectApService inspectApService;
	
	private static final String RETURN_URL = "/admin/maintenance/inspect/ap/";

	@RequestMapping(value="/inspectApList.do")
	@RequestName(value="getInspectApList")
	public String getInspectApList(@ModelAttribute @Valid InspectApVO inspectApVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("che_ap_list");
		String bizName = "자전거 장애관리 화면";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			inspectApVo.setPagingYn("Y");
			
			if(inspectApVo.getMode() != null && inspectApVo.getMode().equals("excel")){
				resultPage = RETURN_URL.concat("che_ap_list_excel");
				inspectApVo.setPagingYn("N");
			}
			
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			
			if(inspectApVo.getSearchBgnDe() == null && inspectApVo.getSearchEndDe() == null){
				inspectApVo.setSearchEndDe(sdf.format(cal.getTime()));
				cal.add(Calendar.DAY_OF_MONTH, -6);
				inspectApVo.setSearchBgnDe(sdf.format(cal.getTime()));
			}
			
			
			int totCnt = inspectApService.getInspectApListCount(inspectApVo);
			PaginationInfo paginationInfo = getPagingInfo(inspectApVo.getCurrentPageNo(), totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(inspectApVo.getCurrentPageNo(), totCnt);
			
			inspectApVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			inspectApVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<InspectApVO> resultList = inspectApService.getInspectApList(inspectApVo);
					
			model.addAttribute("searchCondition", inspectApVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("InspectApList", resultList);
			
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.maintenance.che_ap_list");
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestMapping(value="/inspectApRegist.do")
	@RequestName(value="inspectApRegist")
	public String inspectApRegist(@ModelAttribute @Valid InspectApVO inspectApVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("che_ap_reg");
		String bizName = "자전거 장애관리 등록 화면";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
			String adminId = userSessionVO == null ? "test" : userSessionVO.getUsrId();
			/*inspectApVo.setPagingYn("Y");
			
			if(inspectApVo.getMode() != null && inspectApVo.getMode().equals("excel")){
				resultPage = RETURN_URL.concat("che_ap_list_excel");
				inspectApVo.setPagingYn("N");
			}
			
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			
			if(inspectApVo.getSearchBgnDe() == null && inspectApVo.getSearchEndDe() == null){
				inspectApVo.setSearchEndDe(sdf.format(cal.getTime()));
				cal.add(Calendar.DAY_OF_MONTH, -6);
				inspectApVo.setSearchBgnDe(sdf.format(cal.getTime()));
			}
			
			
			int totCnt = inspectApService.getInspectApListCount(inspectApVo);
			PaginationInfo paginationInfo = getPagingInfo(inspectApVo.getCurrentPageNo(), totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(inspectApVo.getCurrentPageNo(), totCnt);
			
			inspectApVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			inspectApVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<InspectApVO> resultList = inspectApService.getInspectApList(inspectApVo);
					
			model.addAttribute("searchCondition", inspectApVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("InspectApList", resultList);
			*/
			model.addAttribute("adminId", adminId);
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.maintenance.che_ap_list");
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestMapping(value = "/insertInspectApAjax.do")
	@RequestName(value="insertInspectApAjax")
	public String insertInspectApAjax(@ModelAttribute InspectApVO inspectApVo, HttpServletRequest request, ModelMap model) throws Exception {

		String bizName = "무선AP 장애 등록";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        
		try {
			InspectApVO tmpVo = inspectApVo;
			
			inspectApService.insertInspectAp(inspectApVo);
			
			model.addAttribute(RESULT_MESSAGE, "Success");
			model.addAttribute(CHECK_RESULT, 0);
			
		} catch (Exception e) {
			throw new CfoodException("admin.system.maintenance.insertInspectApAjax");
		}
		return JSONVIEW;
	}

}
