package com.dkitec.barocle.admin.maintenance.repair.bike.controller;

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
import com.dkitec.barocle.admin.maintenance.repair.bike.service.RepairBikeService;
import com.dkitec.barocle.admin.maintenance.repair.bike.vo.RepairBikeVO;
import com.dkitec.barocle.admin.maintenance.stockMgmt.invent.vo.InventVO;
import com.dkitec.barocle.admin.status.rentStatus.service.RentStatusService;
import com.dkitec.barocle.admin.status.rentStatus.vo.BikeRentalVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.DateUtil;
import com.dkitec.barocle.util.webutil.HttpUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="RepairBikeController")
public class RepairBikeController extends BaseController {
	protected static Logger log = LoggerFactory.getLogger(RepairBikeController.class);
	@Resource(name="repairBikeService") private RepairBikeService repairBikeService;
	@Resource(name="rentStatusService") private RentStatusService rentStatusService;
	
	private static final String RETURN_URL = "/admin/maintenance/repair/bike/";

	@RequestMapping(value="/repairBikeList.do")
	@RequestName(value="getRepairBikeList")
	public String getRepairBikeList(@ModelAttribute @Valid RepairBikeVO repairBikeVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("rep_bik_list");
		String bizName = "자전거 장애관리 화면";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			
			if(repairBikeVo.getViewFlg().equals(MODE_EXCEL)){
				repairBikeVo.setPagingYn("N");
			}else{
				repairBikeVo.setPagingYn("Y");
			}

			int totCnt = repairBikeService.getRepairBikeListCount(repairBikeVo);
			PaginationInfo paginationInfo = getPagingInfo(repairBikeVo.getCurrentPageNo(), 10,10, totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(repairBikeVo.getCurrentPageNo(), 10,10, totCnt);
			
			repairBikeVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			repairBikeVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<RepairBikeVO> resultList = repairBikeService.getRepairBikeList(repairBikeVo);
					
			model.addAttribute("searchCondition", repairBikeVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("RepairBikeList", resultList);
			
			if(repairBikeVo.getViewFlg().equals(MODE_EXCEL)) {
				resultPage = RETURN_URL.concat("inv_sta_list_excel");
    		}
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.maintenance.rep_bik_list",ce.getMessage());
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestMapping(value = "/moveRepairBikeEditForm.do")
	@RequestName(value="moveRepairBikeEditForm")
	public String moveRepairBikeEditForm(@ModelAttribute RepairBikeVO repairBikeVo, HttpServletRequest request, ModelMap model) throws Exception {

		String bizName = "자전거 수리 등록,수정 화면 이동";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        
        RepairBikeVO resultVo = null;
		boolean result = false;
		try {
			switch ( repairBikeVo.getViewFlg() ) {
			
			case CRUD_C :
				
			case "R"    :	// 20210117 경정비 항목 입력	
				
				resultVo = new RepairBikeVO();
				resultVo.setBikeStatusComCd(repairBikeVo.getBikeStatusComCd());
				resultVo.setBikeStatusName(repairBikeVo.getBikeStatusName());
				resultVo.setViewFlg( repairBikeVo.getViewFlg() );
				break;

				
			case "Z"    :	// 20220114 고장처리	
				
				resultVo = new RepairBikeVO();
				resultVo.setBikeStatusComCd(repairBikeVo.getBikeStatusComCd());
				resultVo.setBikeStatusName(repairBikeVo.getBikeStatusName());
				resultVo.setViewFlg( repairBikeVo.getViewFlg() );
				break;				
				
			default :
				resultVo = repairBikeService.getRepairBikeInfo(repairBikeVo);
				resultVo.setRepairCodeList(repairBikeService.getRepairCodeList(resultVo.getRepairSeq()));
			}

			model.addAttribute("repairBikeInfo"        , resultVo);
			model.addAttribute("repairBike"          , repairBikeVo);
			result = true;
		} catch (Exception e) {
			throw new CfoodException("fail.common.msg",e.getMessage());
		}
		
		return result ? RETURN_URL.concat("rep_bik_detail") : ERROR_PAGE;
	}
	
	@RequestMapping(value = "/insertBunbaeRepairBike.do")
	@RequestName(value="insertBunbaeRepairBike")
	public String insertBunbaeRepairBike(@ModelAttribute RepairBikeVO repairBikeVo, HttpServletRequest request, ModelMap model) throws Exception {
		String bizName = "자전거 수리 등록,수정 화면 이동";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        RepairBikeVO resultVo = null;
		boolean result = false;
	
		resultVo = new RepairBikeVO();
		resultVo.setBikeStatusComCd(repairBikeVo.getBikeStatusComCd());
		resultVo.setBikeStatusName(repairBikeVo.getBikeStatusName());
		resultVo.setViewFlg( repairBikeVo.getViewFlg() );

		model.addAttribute("repairBikeInfo"        , resultVo);
		model.addAttribute("repairBike"          , repairBikeVo);
		result = true;

		return result ? RETURN_URL.concat("rep_bik_detailBunBae") : ERROR_PAGE;
	} 
	
	@Resource(name="distributionDiaryService") private DistributionDiaryService distributionDiaryService;

	@RequestMapping(value = "/insertRepairBikeAjax.do")
	@RequestName(value="insertRepairBikeAjax")
	public String insertRepairBikeAjax(@ModelAttribute RepairBikeVO repairBikeVo, HttpServletRequest request, ModelMap model) throws Exception {

		String bizName = "자전거 수리 등록";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        
        BikeRentalVO rentalVo = new BikeRentalVO();
        
        UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO"); 
        
        if(userSessionVO == null){
        	throw new CfoodException("error.invalidSession","invalidSession 에러 발생");
        }
        repairBikeVo.setModId(userSessionVO.getUsrId());
        
        boolean onRental = false;
        boolean overLap = false;
        
        try {
        	
        	//2020-11-17 : 대여중 인 자전거 수리등록 방지
        	String bikeStatusCd = repairBikeService.getBikeStatusCd(repairBikeVo);
        	
        	if("BKS_010".equals(bikeStatusCd)) onRental = true;
        	
        	// 2021 05 21 분내직원 동일한날 다건 등록 방지 
        	switch ( userSessionVO.getUsrGrpCd() ) {
        	
        	case "5" :
        	case "11" :
        	case "12" :
        		
        		if(repairBikeVo.getAdminId() == null || "".equals(repairBikeVo.getAdminId())){
        			repairBikeVo.setAdminId(userSessionVO.getUsrId());
        		}
        		int cnt = repairBikeService.selectRepairCurrDate(repairBikeVo);
        		
        		if( cnt >= 1 ) {
        			model.addAttribute("checkOverLap", "Fail");
        			return JSONVIEW;
        		}	
        	}
        	
        	
        	// 대여중 체크
        	if(!onRental){
        	
	        	//2020-10-15 : 개선화면만 적용하기 위해 mode값을 이용해 기존화면 와 개선화면 분기
	        	//가끔 센터값 없이 들어오는 경우 대비
	        	if("newPage".equals(repairBikeVo.getMode()) && ( repairBikeVo.getCenterId() == null || "".equals(repairBikeVo.getCenterId()) ) ){
	            	
	        		if(repairBikeVo.getAdminId() == null || "".equals(repairBikeVo.getAdminId())){
	        			
	        			repairBikeVo.setAdminId(userSessionVO.getUsrId());
	        			
	        		}
	        			
	        		String centerId = repairBikeService.getAdminCenterId(repairBikeVo);
	        		
	        		repairBikeVo.setCenterId(centerId);
	        		
	        	}
	        	
	        	//2020-10-16 ~ 10-20 : 정비팀이 등록할 경우 해당자전거 번호가 당일날 이미 수리등록 되어있는지 확인
		        // 2021-08-27 분배직원만 중복 등록  
        		String centerClsCd = repairBikeService.getCenterClsCd(repairBikeVo);
	        	repairBikeVo.setCenterClsCd(centerClsCd);
	        	if("CEN_004".equals(repairBikeVo.getCenterClsCd())){
		        	String lastDttm = repairBikeService.getRepairCmptDttm(repairBikeVo);
		        	boolean lastChk = false;
		        	if(lastDttm != null && lastDttm.indexOf(" ") > -1){
		        		lastDttm = lastDttm.split(" ")[0];
		        		lastChk = true;
		        	}
		        	if(lastChk){
		        		String todayDate = DateUtil.getSystemDate("yyyy-MM-dd");
		        		if(todayDate.equals(lastDttm)){
		        			model.addAttribute("checkOverLap", "Fail");
		        			overLap = true;
		        		}
		        	}
	        	}
		        	
	        	if(!overLap){
	        		 
	        		// 분배원, 분배직원만 등록(20210705 추가 )
	        		switch ( userSessionVO.getUsrGrpCd() ) {
	        		case "5" :
	        		case "11" :
	        		case "12" :	// 관리운영그룹
	        			// TODO
	        			if( "yang1004".equals(userSessionVO.getUsrId())) {
		        			DistributionDiaryVO vo = new DistributionDiaryVO();
		        			vo.setBikeId(repairBikeVo.getBikeId());
		        			vo.setAdminId(repairBikeVo.getAdminId());
		        			vo.setWorkPlace(repairBikeVo.getStationId());
		        			vo.setCurrBikeStatuCd(bikeStatusCd);
		        			if("R".equals(repairBikeVo.getViewFlg())) {
		        				vo.setWorkClassifi("DAR_TP_004");	// 경정비
		        			} else {
		        				vo.setWorkClassifi("DAR_TP_005");	// 입고
		        			}
		        			distributionDiaryService.setDaiaryBikeStatus(vo);
		        			break;
	        			}	
	        		}
	        		
	        		
		        	String moveYn = "N";
		        	if(repairBikeVo.getCenterId() != null && repairBikeVo.getCenterId() != ""){
			        	moveYn = repairBikeService.getBikeMoveYn(repairBikeVo);
		        	}
					repairBikeVo.setMoveYn(moveYn);//센터 이동을 위한 값_20170907_JHN
		
		        	// 해당 자전거가 강제반납 상태인지 확인 및 강제반납관리 완료처리 19.08.09
					rentalVo.setRentBikeId(repairBikeVo.getBikeId());
					rentalVo.setRegId(repairBikeVo.getModId());
					rentStatusService.checkEnfrc(rentalVo);
					
					// 해당 자전거의 기존 장애건 털기 20.07.13_김시성
					repairBikeService.repairBikeFaultCleanUp(repairBikeVo);
					
		        	//
					repairBikeService.insertRepairBike(repairBikeVo);
					model.addAttribute(RESULT_MESSAGE, "Success");
					model.addAttribute("repairSeq",repairBikeVo.getRepairSeq());
					model.addAttribute(CHECK_RESULT, 0);
					
	        	}
	        	
        	} else{
        		model.addAttribute("checkRental","Fail");
        	}
        	
			return JSONVIEW;
		} catch (Exception e) {
			throw new CfoodException("error.invalidSession",e.getMessage());
		}
		
	}
	
	
	
	
	
	@RequestMapping(value = "/updateRepairBikeAjax.do")
	@RequestName(value="updateRepairBikeAjax")
	public String updateRepairBikeAjax(@ModelAttribute RepairBikeVO repairBikeVo, HttpServletRequest request, ModelMap model) throws Exception {

		String bizName = "자전거 수리 수정";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        
        UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
        if(userSessionVO == null){
        	throw new CfoodException(getMessage("error.invalidSession"));
        }
        repairBikeVo.setModId(userSessionVO.getUsrId());
        
        try {
        	
        	//2020-10-15 : 개선화면만 적용하기 위해 mode값을 이용해 기존화면 와 개선화면 분기
        	//가끔 센터값이 없이 들어오는 경우를 대비한다
        	if("newPage".equals(repairBikeVo.getMode()) && ( repairBikeVo.getCenterId() == null || "".equals(repairBikeVo.getCenterId()) ) ){
        		
        		
        		if(repairBikeVo.getAdminId() == null || "".equals(repairBikeVo.getAdminId())){
        			
        			repairBikeVo.setAdminId(userSessionVO.getUsrId());
        			
        		}
        			
        		String centerId = repairBikeService.getAdminCenterId(repairBikeVo);
        		
        		repairBikeVo.setCenterId(centerId);
        		
        	}
        	
        	String moveYn = "N";
        	if(repairBikeVo.getCenterId() != null && repairBikeVo.getCenterId() != ""){
	        	moveYn = repairBikeService.getBikeMoveYn(repairBikeVo);
        	}
			repairBikeVo.setMoveYn(moveYn);
			
			if("Y".equals(repairBikeVo.getRepairCmptYn())){//수리정보테이블에서 해당 자전거의 이전 정보가 수리중인건들 수리완료 처리
				
				repairBikeService.repairBikeCleanUp(repairBikeVo);
				
			}
			
			repairBikeService.updateRepairBike(repairBikeVo);
			model.addAttribute(RESULT_MESSAGE, "Success");
			model.addAttribute(CHECK_RESULT, 0);
			return JSONVIEW;
		} catch (Exception e) {
			throw new CfoodException("admin.system.maintenance.updateRepairBikeAjax",e.getMessage());
		}
	}
	
	@RequestMapping(value = "/deleteRepairBike.do")
	@RequestName(value="deleteRepairBike")
	public String deleteRepairBike(@ModelAttribute RepairBikeVO repairBikeVo, HttpServletRequest request, ModelMap model) throws Exception {

		String bizName = "자전거 수리 삭제";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        
        
		try {
	        repairBikeService.deleteRepairBike(repairBikeVo);
			model.addAttribute(RESULT_MESSAGE, "Success");
			model.addAttribute(CHECK_RESULT, 0);
		} catch (Exception e) {
			throw new CfoodException("admin.system.maintenance.deleteRepairBike");
		}
		return JSONVIEW;
	}
	
	@RequestMapping(value = "/getRemainPartsCnt.do")
	@RequestName(value="getRemainPartsCnt")
	public String getRemainPartsCnt(@ModelAttribute InventVO inventVo, HttpServletRequest request, ModelMap model) throws Exception {

		String bizName = "자전거 부품 재고 조회";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        
		try {
			String remainPartsCnt = repairBikeService.getRemainPartsCnt(inventVo);
			model.addAttribute("remainPartsCnt", remainPartsCnt);
			model.addAttribute(RESULT_MESSAGE, "Success");
			model.addAttribute(CHECK_RESULT, 0);
		} catch (Exception e) {
			throw new CfoodException("admin.system.maintenance.getRemainPartsCnt",e.getMessage());
		}
		return JSONVIEW;
	}
	
	
	
	
	
	
	
	
	
	/*
	 * 2019.03.14 바로클포
	 */
	@RequestMapping(value="/repairBikeMallList.do")
	@RequestName(value="getRepairBikeMallList")
	public String getRepairBikeMallList(@ModelAttribute @Valid RepairBikeVO repairBikeVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("rep_bik_mall_list");
		String bizName = "자전거 바로클 포 장애관리 화면";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			
			if(repairBikeVo.getViewFlg().equals(MODE_EXCEL)){
				repairBikeVo.setPagingYn("N");
			}else{
				repairBikeVo.setPagingYn("Y");
			}

			int totCnt = repairBikeService.getRepairBikeListMallCount(repairBikeVo);
			PaginationInfo paginationInfo = getPagingInfo(repairBikeVo.getCurrentPageNo(), 10,10, totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(repairBikeVo.getCurrentPageNo(), 10,10, totCnt);
			
			repairBikeVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			repairBikeVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<RepairBikeVO> resultList = repairBikeService.getRepairBikeMallList(repairBikeVo);
					
			model.addAttribute("searchCondition", repairBikeVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("RepairBikeList", resultList);
			
			if(repairBikeVo.getViewFlg().equals(MODE_EXCEL)) {
				resultPage = RETURN_URL.concat("rep_bik_mall_list_excel");
    		}
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.maintenance.rep_bik_mall_list",ce.getMessage());
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestMapping(value = "/moveRepairBikeEditMallForm.do")
	@RequestName(value="moveRepairBikeEditMallForm")
	public String moveRepairBikeMallEditForm(@ModelAttribute RepairBikeVO repairBikeVo, HttpServletRequest request, ModelMap model) throws Exception {

		String bizName = "자전거 수리 등록,수정 화면 이동";
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
			model.addAttribute("repairBike"            , repairBikeVo);
			result = true;
		} catch (Exception e) {
			throw new CfoodException("admin.system.maintenance.moveRepairBikeEditMallForm",e.getMessage() );
		}
		
		return result ? RETURN_URL.concat("rep_bik_mall_detail") : ERROR_PAGE;
	}
}
