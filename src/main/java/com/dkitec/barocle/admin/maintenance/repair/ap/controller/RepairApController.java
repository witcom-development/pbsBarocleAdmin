package com.dkitec.barocle.admin.maintenance.repair.ap.controller;

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
import com.dkitec.barocle.admin.maintenance.repair.ap.vo.RepairApVO;
import com.dkitec.barocle.admin.maintenance.repair.beacon.service.RepairBeaconService;
import com.dkitec.barocle.admin.maintenance.repair.beacon.vo.RepairBeaconVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.HttpUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="RepairApController")
public class RepairApController extends BaseController {
	protected static Logger log = LoggerFactory.getLogger(RepairApController.class);

	@Resource(name="repairBeaconService") private RepairBeaconService repairBeaconService;
	
	
	private static final String RETURN_URL = "/admin/maintenance/repair/ap/";

	@RequestMapping(value="/repairApList.do")
	@RequestName(value="getRepairApList")
	public String getRepairBeaconList(@ModelAttribute @Valid RepairBeaconVO repairBeaconVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("rep_ap_list");
		String bizName = "AP장애관리 화면";
		HttpUtil.printServiceLogStart(bizName, log, request);
		 
		try{
			if(repairBeaconVo.getViewFlg().equals(MODE_EXCEL)){
				repairBeaconVo.setPagingYn("N");
			}else{
				repairBeaconVo.setPagingYn("Y");
			}
			/*repairBeaconVo.setPagingYn("Y");*/

			repairBeaconVo.setRepairClsCd("DEV_003");
			
			int totCnt = repairBeaconService.getRepairBeaconListCount(repairBeaconVo);
			PaginationInfo paginationInfo = getPagingInfo(repairBeaconVo.getCurrentPageNo(), totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(repairBeaconVo.getCurrentPageNo(), totCnt);
			
			repairBeaconVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			repairBeaconVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<RepairBeaconVO> resultList = repairBeaconService.getRepairBeaconList(repairBeaconVo);
					
			model.addAttribute("searchCondition", repairBeaconVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("RepairBeaconList", resultList);
			
			if(repairBeaconVo.getViewFlg().equals(MODE_EXCEL)) {
				resultPage = RETURN_URL.concat("rep_ap_list_excel");
    		}
			
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.maintenance.rep_beacon_list");
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	 

	@RequestMapping(value = "/moveRepairApEditForm.do")
	@RequestName(value="moveRepairApEditForm")
	public String moveRepairBeaconEditForm(@ModelAttribute RepairBeaconVO repairBeaconVo, HttpServletRequest request, ModelMap model) throws Exception {

		String bizName = "AP 수리 등록,수정 화면 이동";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        
        RepairBeaconVO resultVo = null;
		boolean result = false;
		try {
			
			repairBeaconVo.setRepairClsCd("DEV_003");
			
			if(repairBeaconVo.getViewFlg().equals(CRUD_C)) {
				resultVo = new RepairBeaconVO();
			} else {
				resultVo = repairBeaconService.getRepairBeaconInfo(repairBeaconVo);
				resultVo.setRepairCodeList(repairBeaconService.getRepairCodeList(resultVo.getRepairSeq()));
			}
			 
			
			System.out.println( resultVo ) ;
			System.out.println( repairBeaconVo );
			
			model.addAttribute("repairBeaconInfo"        , resultVo);
			model.addAttribute("repairBeacon"          , repairBeaconVo);
			result = true;
		} catch (Exception e) {
			throw new CfoodException("admin.system.maintenance.rep_std_detail");
		}
		
		return result ? RETURN_URL.concat("rep_ap_detail") : ERROR_PAGE;
	}
	 
	
	@RequestMapping(value = "/insertRepairApAjax.do")
	@RequestName(value="insertRepairApAjax")
	public String insertRepairBeaconAjax(@ModelAttribute RepairBeaconVO repairBeaconVo, HttpServletRequest request, ModelMap model) throws Exception {

		String bizName = "AP 수리 등록";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        
        try {
        	userSessionVO = (UserSessionVO) EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
			
        	repairBeaconVo.setRepairClsCd("DEV_003");
        	repairBeaconVo.setAdminId(userSessionVO.getUsrId());
			repairBeaconService.insertRepairBeacon(repairBeaconVo);
			model.addAttribute(RESULT_MESSAGE, "Success");
			model.addAttribute(CHECK_RESULT, 0);
			return JSONVIEW;
		} catch (Exception e) {
			model.addAttribute(RESULT_MESSAGE, "저장시 에러가 발생되었습니다.");
			model.addAttribute(CHECK_RESULT, 0);
			return JSONVIEW;
		}
	}  
	
}
