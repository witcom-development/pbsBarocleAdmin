package com.dkitec.barocle.admin.maintenance.repair.beacon.controller;

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
import com.dkitec.barocle.admin.maintenance.distMgmt.distributionDiary.service.DistributionDiaryService;
import com.dkitec.barocle.admin.maintenance.distMgmt.distributionDiary.vo.DistributionDiaryVO;
import com.dkitec.barocle.admin.maintenance.repair.beacon.service.RepairBeaconService;
import com.dkitec.barocle.admin.maintenance.repair.beacon.vo.RepairBeaconVO;
import com.dkitec.barocle.admin.repairMgmt.repairPerf.vo.RepairPerfVO;
import com.dkitec.barocle.admin.repairMgmt.repairWork.vo.RepairWorkVO;
import com.dkitec.barocle.admin.status.stationStatus.vo.StationVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.HttpUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="RepairBeaconController")
public class RepairBeaconController extends BaseController {
	protected static Logger log = LoggerFactory.getLogger(RepairBeaconController.class);
	@Resource(name="repairBeaconService") private RepairBeaconService repairBeaconService;
	@Resource(name="distributionDiaryService") private DistributionDiaryService distributionDiaryService;	
	
	private static final String RETURN_URL = "/admin/maintenance/repair/beacon/";

	@RequestMapping(value="/repairBeaconList.do")
	@RequestName(value="getRepairBeaconList")
	public String getRepairBeaconList(@ModelAttribute @Valid RepairBeaconVO repairBeaconVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("rep_beacon_list");
		String bizName = "비콘장애관리 화면";
		HttpUtil.printServiceLogStart(bizName, log, request);
		 
		try{
			if(repairBeaconVo.getViewFlg().equals(MODE_EXCEL)){
				repairBeaconVo.setPagingYn("N");
			}else{
				repairBeaconVo.setPagingYn("Y");
			}
			/*repairBeaconVo.setPagingYn("Y");*/
			if( repairBeaconVo.getRepairClsCd() == null || "".equals(repairBeaconVo.getRepairClsCd()) ) {
        		repairBeaconVo.setRepairClsCd("DEV_006");
			}		
			
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
				resultPage = RETURN_URL.concat("rep_beacon_list_excel");
    		}
			
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.maintenance.rep_beacon_list");
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}

	@RequestMapping(value = "/moveRepairEditForm.do")
	@RequestName(value="moveRepairEditForm")
	public String moveRepairEditForm(@ModelAttribute RepairBeaconVO repairBeaconVo, HttpServletRequest request, ModelMap model) throws Exception {
		
		String bizName = "비콘수리 등록,수정 화면 이동";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        
        userSessionVO = (UserSessionVO) EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
    	repairBeaconVo.setAdminId(userSessionVO.getUsrId());
        
        RepairBeaconVO resultVo = null;
		boolean result = false;
		try {
			
			if(repairBeaconVo.getViewFlg().equals(CRUD_C)) {
				resultVo = new RepairBeaconVO();
			
			}	else if(repairBeaconVo.getViewFlg().equals("R")) {
				
				resultVo= repairBeaconService.getRepairBeaconInfoCurdate(repairBeaconVo);
				
				if( resultVo != null && 
						resultVo.getRepairSeq().compareTo("0") > 0 ) {
					repairBeaconVo.setRepairSeq(resultVo.getRepairSeq());
					resultVo = repairBeaconService.getRepairBeaconInfo(repairBeaconVo);
					resultVo.setRepairCodeList(repairBeaconService.getRepairCodeList(resultVo.getRepairSeq()));
					
				} else {
					resultVo = repairBeaconVo;
				}
				
			} else {
				resultVo = repairBeaconService.getRepairBeaconInfo(repairBeaconVo);
				resultVo.setRepairCodeList(repairBeaconService.getRepairCodeList(resultVo.getRepairSeq()));
			}
			
			model.addAttribute("repairBeaconInfo"      , resultVo);
			model.addAttribute("repairBeacon"          , repairBeaconVo);
			result = true;
		} catch (Exception e) {
			
			System.out.println(e.getLocalizedMessage());
			
			// throw new CfoodException("admin.system.maintenance.rep_std_detail");
		}
		
		return result ? RETURN_URL.concat("round_station_rep_popup") : ERROR_PAGE;
	}	
	
	
	@RequestMapping(value = "/moveRepairBeaconEditForm.do")
	@RequestName(value="moveRepairBeaconEditForm")
	public String moveRepairBeaconEditForm(@ModelAttribute RepairBeaconVO repairBeaconVo, HttpServletRequest request, ModelMap model) throws Exception {

		String bizName = "비콘수리 등록,수정 화면 이동";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        
        RepairBeaconVO resultVo = null;
		boolean result = false;
		try {
			
			repairBeaconVo.setRepairClsCd("DEV_006");
			
			if(repairBeaconVo.getViewFlg().equals(CRUD_C)) {
				resultVo = new RepairBeaconVO();
			// 비콘 바로 가기 등록버튼	
			}	else if(repairBeaconVo.getViewFlg().equals("R")) {
				resultVo = repairBeaconVo;
			} else {
				resultVo = repairBeaconService.getRepairBeaconInfo(repairBeaconVo);
				resultVo.setRepairCodeList(repairBeaconService.getRepairCodeList(resultVo.getRepairSeq()));
			}
			
			model.addAttribute("repairBeaconInfo"        , resultVo);
			model.addAttribute("repairBeacon"          , repairBeaconVo);
			result = true;
		} catch (Exception e) {
			
			System.out.println(e.getLocalizedMessage());
		}
		
		return result ? RETURN_URL.concat("rep_beacon_detail") : ERROR_PAGE;
	}
	
	
	@RequestMapping(value = "/getStationInfoAjax.do")
	@RequestName(value="getStationInfoAjax")
	public String getStationInfoAjax(@ModelAttribute StationVO stationVo, HttpServletRequest request, ModelMap model) throws Exception {

        try {
        	 
        	StationVO vo = repairBeaconService.getStationInfo(stationVo);
			 
			model.addAttribute(RESULT_MESSAGE, true);
			model.addAttribute(CHECK_RESULT, 0);
			model.addAttribute("dsVO", vo);
			return JSONVIEW;
		} catch (Exception e) {
			model.addAttribute(RESULT_MESSAGE, false);
			
			return JSONVIEW;
		}
        
	}
	
	@RequestMapping(value = "/insertRepairBeaconAjax.do")
	@RequestName(value="insertRepairBeaconAjax")
	public String insertRepairBeaconAjax(@ModelAttribute RepairBeaconVO repairBeaconVo, HttpServletRequest request, ModelMap model) throws Exception {

		String bizName = "비콘수리 등록";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        
        try {
        	userSessionVO = (UserSessionVO) EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
			
        	if( repairBeaconVo.getRepairClsCd() == null || "".equals(repairBeaconVo.getRepairClsCd()) ) {
        		repairBeaconVo.setRepairClsCd("DEV_006");
			}
			
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
	
	

	@RequestMapping(value = "/deleteRepairBeaconAjax.do")
	@RequestName(value="deleteRepairBeaconAjax")
	public String deleteRepairBeaconAjax(@ModelAttribute RepairBeaconVO repairBeaconVo, HttpServletRequest request, ModelMap model) throws Exception {

		String bizName = "비콘수리 삭제";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        
        try {
        	userSessionVO = (UserSessionVO) EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
			
        	if( repairBeaconVo.getRepairClsCd() == null || "".equals(repairBeaconVo.getRepairClsCd()) ) {
        		repairBeaconVo.setRepairClsCd("DEV_006");
			}
			
        	repairBeaconVo.setAdminId(userSessionVO.getUsrId());
			repairBeaconService.deleteRepairBeacon(repairBeaconVo);
			model.addAttribute(RESULT_MESSAGE, "Success");
			model.addAttribute(CHECK_RESULT, 0);
			return JSONVIEW;
		} catch (Exception e) {
			model.addAttribute(RESULT_MESSAGE, "저장시 에러가 발생되었습니다.");
			model.addAttribute(CHECK_RESULT, 0);
			return JSONVIEW;
		}
	}
	
	@RequestMapping("/getRoundDiaryAjax.do")
	@RequestName("getRoundbutionDiaryAjax")
	public String getDistributionDiaryAjax(@ModelAttribute RepairBeaconVO vo, ModelMap model, HttpServletRequest request) {
		
		String bizName = "순회정비 일지 조회";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		boolean result = false;
		UserSessionVO userSessionVO = null;
		
		try {
			userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
			result = false;
			return JSONVIEW;
		}
			
		
		try {
	 			if(vo.getSearchDate() == null || "".equals(vo.getSearchDate())){
				/*	String todayDate = DateUtil.getSystemDate("yyyy-MM-dd");
					vo.setSearchDate(todayDate);
				}else{
					if(vo.getModifyDate() != 0){
						distributionDiaryVo.setSearchDate(distributionDiaryService.getModifyDate(distributionDiaryVo));
					}
				}*/
				 
				if(vo.getAdminId() == null || "".equals(vo.getAdminId())){
					vo.setAdminId(userSessionVO.getUsrId());
				}
				
				// 차량번호 조회
				// model.addAttribute("distInfoVclList", distributionDiaryService.getDairyVcle(distributionDiaryVo));
				
				List<RepairBeaconVO> distList = repairBeaconService.getStationDairyInfo(vo);
				// model.addAttribute("distInfo", distributionDiaryService.getDistInfo(distributionDiaryVo));
				model.addAttribute("distList", distList);
				model.addAttribute("searchCondition", vo);
				result = true;
 			}
 			
		} catch (Exception e) {
			result = false;
		}
		
		return JSONVIEW;
	}
		 
}
