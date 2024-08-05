package com.dkitec.barocle.admin.maintenance.inspect.bike.controller;

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
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.admin.login.vo.UserSessionVO;
import com.dkitec.barocle.admin.maintenance.inspect.bike.service.InspectBikeService;
import com.dkitec.barocle.admin.maintenance.inspect.bike.vo.InspectBikeVO;
import com.dkitec.barocle.admin.maintenance.repair.bike.service.RepairBikeService;
import com.dkitec.barocle.admin.maintenance.repair.bike.vo.RepairBikeVO;
import com.dkitec.barocle.admin.system.usermgmt.service.UserMgmtService;
import com.dkitec.barocle.admin.system.usermgmt.vo.UserMgmtVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.HttpUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="InspectBikeController")
public class InspectBikeController extends BaseController {
	protected static Logger log = LoggerFactory.getLogger(InspectBikeController.class);
	
	@Resource(name="inspectBikeService") private InspectBikeService inspectBikeService;
	@Resource(name="repairBikeService") private RepairBikeService repairBikeService;
	@Resource(name = "userMgmtService") private UserMgmtService usrService;
	
	private static final String RETURN_URL = "/admin/maintenance/inspect/bike/";
	
	@RequestMapping(value="/inspectBikeList.do")
	@RequestName(value="getInspectBikeList")
	public String getInspectBikeList(@ModelAttribute @Valid InspectBikeVO inspectBikeVo, BindingResult result, HttpServletRequest request, UserMgmtVO usrVO, Model model) throws Exception {
		
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("che_bike_list");
		String bizName = "자전거 장애관리 화면";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		UserSessionVO userSessionVO = null;
		
		try {
			userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
			if(userSessionVO == null){
	        	throw new CfoodException(getMessage("error.invalidSession"));
	        }
			usrVO.setUsrId(userSessionVO.getUsrId());
			UserMgmtVO usrInfo = usrService.getUsrInfo(usrVO);
			userSessionVO.setAssignStationGrpId(usrInfo.getAssignStationGrpId());
			inspectBikeVo.setStationGrpId(userSessionVO.getAssignStationGrpId());
			
		} catch (Exception e) {
			throw new CfoodException(getMessage("fail.common.msg"));
		}
		
		try{
			inspectBikeVo.setPagingYn("Y");
			
			if(inspectBikeVo.getMode() != null && inspectBikeVo.getMode().equals("excel")){
				resultPage = RETURN_URL.concat("che_bike_list_excel");
				inspectBikeVo.setPagingYn("N");
			}
			
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			
			if(inspectBikeVo.getSearchBgnDe() == null && inspectBikeVo.getSearchEndDe() == null){
				inspectBikeVo.setSearchEndDe(sdf.format(cal.getTime()));
				cal.add(Calendar.DAY_OF_MONTH, -6);
				inspectBikeVo.setSearchBgnDe(sdf.format(cal.getTime()));
			}
			
			int totCnt = inspectBikeService.getInspectBikeListCount(inspectBikeVo);
			PaginationInfo paginationInfo = getPagingInfo(inspectBikeVo.getCurrentPageNo(), totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(inspectBikeVo.getCurrentPageNo(), totCnt);
			
			inspectBikeVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			inspectBikeVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<InspectBikeVO> resultList = inspectBikeService.getInspectBikeList(inspectBikeVo);
					
			model.addAttribute("searchCondition", inspectBikeVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("InspectBikeList", resultList);
			
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.maintenance.che_bike_list");
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestMapping(value = "/moveInspectBikeEditForm.do")
	@RequestName(value="moveInspectBikeEditForm")
	public String moveInspectBikeEditForm(@ModelAttribute RepairBikeVO repairBikeVo, HttpServletRequest request, ModelMap model) throws Exception {

		String bizName = "분배팀 자전거 수리 등록,수정 화면 이동";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        
        RepairBikeVO resultVo = null;
		boolean result = false;
		try {
			if(repairBikeVo.getViewFlg().equals(CRUD_C)) {
				resultVo = new RepairBikeVO();
				resultVo.setBikeStatusComCd(repairBikeVo.getBikeStatusComCd());
				resultVo.setBikeStatusName(repairBikeVo.getBikeStatusName());
			} else {
				resultVo = repairBikeService.getRepairBikeInfo(repairBikeVo);
				resultVo.setRepairCodeList(repairBikeService.getRepairCodeList(resultVo.getRepairSeq()));
			}
			model.addAttribute("repairBikeInfo"        , resultVo);
			model.addAttribute("repairBike"          , repairBikeVo);
			result = true;
		} catch (Exception e) {
			throw new CfoodException("admin.system.maintenance.che_bik_detail");
		}
		
		return result ? RETURN_URL.concat("che_bik_detail") : ERROR_PAGE;
	}
	
	@RequestName(value="regTeamAjax")
	@RequestMapping(value="/regTeamAjax.do")
	public String regAdminAjax(@Validated @Valid InspectBikeVO inspectBikeVo, BindingResult bResult, ModelMap model, HttpServletRequest request) {
		
		String bizName = "담당자 등록";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		model.addAttribute(RESULT_MESSAGE, "fail");
		
		if(inspectBikeService.insertTeamInfo(inspectBikeVo)>0){
			model.addAttribute(RESULT_MESSAGE, "Success");
			model.addAttribute(CHECK_RESULT, 0);
		}		
		
		return JSONVIEW;
		
	}

}
