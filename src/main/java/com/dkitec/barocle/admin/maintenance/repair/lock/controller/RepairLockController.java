package com.dkitec.barocle.admin.maintenance.repair.lock.controller;

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
import com.dkitec.barocle.admin.maintenance.repair.lock.service.RepairLockService;
import com.dkitec.barocle.admin.maintenance.repair.lock.vo.RepairLockVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.HttpUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="RepairLockController")
public class RepairLockController extends BaseController {
	protected static Logger log = LoggerFactory.getLogger(RepairLockController.class);
	@Resource(name="repairLockService")
	
	private RepairLockService repairLockService;
	
	private static final String RETURN_URL = "/admin/maintenance/repair/lock/";

	@RequestMapping(value="/repairLockList.do")
	@RequestName(value="getRepairLockList")
	public String getRepairLockList(@ModelAttribute @Valid RepairLockVO repairLockVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("rep_std_list");
		String bizName = "거치대 장애관리 화면";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			if(repairLockVo.getViewFlg().equals(MODE_EXCEL)){
				repairLockVo.setPagingYn("N");
			}else{
				repairLockVo.setPagingYn("Y");
			}
			/*repairLockVo.setPagingYn("Y");*/

			int totCnt = repairLockService.getRepairLockListCount(repairLockVo);
			PaginationInfo paginationInfo = getPagingInfo(repairLockVo.getCurrentPageNo(), totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(repairLockVo.getCurrentPageNo(), totCnt);
			
			repairLockVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			repairLockVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<RepairLockVO> resultList = repairLockService.getRepairLockList(repairLockVo);
					
			model.addAttribute("searchCondition", repairLockVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("RepairLockList", resultList);
			
			if(repairLockVo.getViewFlg().equals(MODE_EXCEL)) {
				resultPage = RETURN_URL.concat("rep_std_list_excel");
    		}
			
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.maintenance.rep_std_list");
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}

	@RequestMapping(value = "/moveRepairLockEditForm.do")
	@RequestName(value="moveRepairLockEditForm")
	public String moveRepairLockEditForm(@ModelAttribute RepairLockVO repairLockVo, HttpServletRequest request, ModelMap model) throws Exception {

		String bizName = "거치대 수리 등록,수정 화면 이동";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        
        RepairLockVO resultVo = null;
		boolean result = false;
		try {
			if(repairLockVo.getViewFlg().equals(CRUD_C)) {
				resultVo = new RepairLockVO();
				resultVo.setRackStatusName(repairLockVo.getRackStatusName());
				resultVo.setStationName(repairLockVo.getStationName());
			} else {
				resultVo = repairLockService.getRepairLockInfo(repairLockVo);
				resultVo.setRepairCodeList(repairLockService.getRepairCodeList(resultVo.getRepairSeq()));
			}
			
			model.addAttribute("repairLockInfo"        , resultVo);
			model.addAttribute("repairLock"          , repairLockVo);
			result = true;
		} catch (Exception e) {
			throw new CfoodException("admin.system.maintenance.rep_std_detail");
		}
		
		return result ? RETURN_URL.concat("rep_std_detail") : ERROR_PAGE;
	}
	
	@RequestMapping(value = "/getRemainBikeYn.do")
	@RequestName(value="getRemainBikeYn")
	public String getRemainBikeYn(@ModelAttribute RepairLockVO repairLockVo, HttpServletRequest request, ModelMap model) throws Exception {

		String bizName = "거치대 자전거 거치 여부";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        
        try {
        	RepairLockVO resultVo = repairLockService.getRemainBikeYn(repairLockVo);
			
        	if(resultVo.getRemainYn().equals("Y")){
        		model.addAttribute(RESULT_MESSAGE, "Remain");
        	}else if(resultVo.getRemainYn().equals("N")){
        		model.addAttribute(RESULT_MESSAGE, "Pass");
        	}
			
			model.addAttribute(CHECK_RESULT, 0);
			return JSONVIEW;
		} catch (Exception e) {
			throw new CfoodException("admin.system.maintenance.getRemainBikeYn");
		}
	}
	
	
	@RequestMapping(value = "/insertRepairLockAjax.do")
	@RequestName(value="insertRepairLockAjax")
	public String insertRepairLockAjax(@ModelAttribute RepairLockVO repairLockVo, HttpServletRequest request, ModelMap model) throws Exception {

		String bizName = "거치대 수리 등록";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        
        try {
        	RepairLockVO tmpVo = repairLockVo;
			String[] tmpRepairCode = repairLockVo.getRepairCode().split(",");
			
			String moveYn = "N";
			if(repairLockVo.getCenterId() != null && repairLockVo.getCenterId() != ""){
				moveYn = repairLockService.getLockMoveYn(repairLockVo);
			}
			repairLockVo.setMoveYn(moveYn);
			
			repairLockService.insertRepairLock(repairLockVo);
			repairLockService.deleteRepairLockDetail(repairLockVo);
			for(int i = 0; i < tmpRepairCode.length; i++){
				tmpVo.setRepairCode(tmpRepairCode[i]);
				repairLockService.insertRepairLockDetail(tmpVo);
			}
			model.addAttribute(RESULT_MESSAGE, "Success");
			model.addAttribute(CHECK_RESULT, 0);
			return JSONVIEW;
		} catch (Exception e) {
			throw new CfoodException("admin.system.maintenance.insertRepairLockAjax");
		}
	}
	
	@RequestMapping(value = "/updateRepairLockAjax.do")
	@RequestName(value="updateRepairLockAjax")
	public String updateRepairLockAjax(@ModelAttribute RepairLockVO repairLockVo, HttpServletRequest request, ModelMap model) throws Exception {

		String bizName = "거치대 수리 수정";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        
        try {
        	RepairLockVO tmpVo = repairLockVo;
			String[] tmpRepairCode = repairLockVo.getRepairCode().split(",");
			
			String moveYn = "N";
			if(repairLockVo.getCenterId() != null && repairLockVo.getCenterId() != ""){
				moveYn = repairLockService.getLockMoveYn(repairLockVo);
			}
			repairLockVo.setMoveYn(moveYn);
			
			
			repairLockService.updateRepairLock(repairLockVo);
			repairLockService.deleteRepairLockDetail(repairLockVo);
			for(int i = 0; i < tmpRepairCode.length; i++){
				tmpVo.setRepairCode(tmpRepairCode[i]);
				repairLockService.insertRepairLockDetail(tmpVo);
			}
			model.addAttribute(RESULT_MESSAGE, "Success");
			model.addAttribute(CHECK_RESULT, 0);
			return JSONVIEW;
		} catch (Exception e) {
			throw new CfoodException("admin.system.maintenance.updateRepairLockAjax");
		}
	}
	
	@RequestMapping(value = "/deleteRepairLock.do")
	@RequestName(value="deleteRepairLock")
	public String deleteRepairLock(@ModelAttribute RepairLockVO repairLockVo, HttpServletRequest request, ModelMap model) throws Exception {

		String bizName = "거치대 수리 삭제";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        
       
		try {
			repairLockService.deleteRepairLock(repairLockVo);
			repairLockService.deleteRepairLockDetail(repairLockVo);
			model.addAttribute(RESULT_MESSAGE, "Success");
			model.addAttribute(CHECK_RESULT, 0);
		} catch (Exception e) {
			throw new CfoodException("admin.system.maintenance.deleteRepairLock");
		}
		return JSONVIEW;
	}
}
