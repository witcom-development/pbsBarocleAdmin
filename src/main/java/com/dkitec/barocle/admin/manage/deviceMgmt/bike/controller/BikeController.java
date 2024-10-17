/*
 * @Package Name : com.dkitec.barocle.admin.manage.DeviceMgmt.controller
 * @파일명          : DeviceMgmtController.java
 * @작성일          : 2015. 4. 15.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 15.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.manage.deviceMgmt.bike.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.admin.login.vo.UserSessionVO;
import com.dkitec.barocle.admin.maintenance.repair.bike.service.RepairBikeService;
import com.dkitec.barocle.admin.maintenance.repair.bike.vo.RepairBikeVO;
import com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.BikeService;
import com.dkitec.barocle.admin.manage.deviceMgmt.bike.vo.BikeVO;
import com.dkitec.barocle.admin.status.rentStatus.vo.BikeRentalVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.DateUtil;
import com.dkitec.barocle.util.webutil.HttpUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * @파일명          : DeviceMgmtController.java
 * @작성일          : 2015. 4. 15.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 15.   |   ymshin   |  최초작성
 */
@Controller
@RequestCategory(value="BikeController")
public class BikeController extends BaseController {
	@Resource(name="bikeService") private BikeService bikeService;
	@Resource(name="repairBikeService") private RepairBikeService repairBikeService;
	
	protected static Logger log = LoggerFactory.getLogger(BikeController.class);
	private static final String RETURN_URL = "/admin/manage/service/bike/";
	
	@RequestMapping(value = "/getBikeList.do")
	@RequestName("getBikeList")
	public String getBikeList(@ModelAttribute @Valid BikeVO bikeVo,BindingResult bResult ,HttpServletRequest request,ModelMap model) throws Exception {
		
    	String targetUrl = RETURN_URL.concat("opr_bik_list");
    	String bizName = "자전거 조회 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        boolean result = false;
        String todayDate = DateUtil.getSystemDate("yyyy-MM-dd");
        if (bikeVo.getSearchBgnDe() == null || bikeVo.getSearchBgnDe() == ""){
        	bikeVo.setSearchBgnDe(todayDate.substring(0, 4)+"-01-01");
        }
        if (bikeVo.getSearchEndDe() == null || bikeVo.getSearchEndDe() == ""){
        	bikeVo.setSearchEndDe(todayDate);
        }
        //전체검색을 위한 코드 변경
        if (bikeVo.getBikeStatusCd() == null || bikeVo.getBikeStatusCd() ==""){
        	bikeVo.setBikeStatusCd("BKS_003");
        }
        if (bikeVo.getBikeStatusCd() != null && bikeVo.getBikeStatusCd().equals("all")){
        	bikeVo.setBikeStatusCd("");
        }
        try {
        	if(bikeVo.getViewFlg().equals(MODE_EXCEL)) {
    			bikeVo.setPagingYn("N");
    		}
    		int totCnt = bikeService.getBikeListCount(bikeVo);
    		PaginationInfo paginationInfo = getPagingInfo(bikeVo.getCurrentPageNo(), totCnt);
    		PaginationInfo paginationMobileInfo = getPagingMobileInfo(bikeVo.getCurrentPageNo(), totCnt);
    		bikeVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
    		bikeVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
    		
    		List<BikeVO> resultList = bikeService.getBikeList(bikeVo);
    		model.addAttribute("searchCondition",bikeVo );
    		model.addAttribute("paginationInfo", paginationInfo);
    		model.addAttribute("paginationMobileInfo",paginationMobileInfo);
    		model.addAttribute("BikeList", resultList);
    		if(bikeVo.getViewFlg().equals(MODE_EXCEL)) {
    			targetUrl = RETURN_URL.concat("opr_bik_list_excel");
    		}
    		result = true;
		} catch (CfoodException e){
			throw new CfoodException(getMessage("fail.common.msg"));
		}
        
		return result ? targetUrl : ERROR_PAGE;
	}
	
	@RequestMapping(value = "/moveBikeEditForm.do")
	@RequestName("moveBikeEditForm")
	public String moveBikeEditForm(@ModelAttribute BikeVO bikeVo,HttpServletRequest request,ModelMap model) throws Exception {

		String bizName = "자전거 등록,수정 화면 이동";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        
        String targetUrl = RETURN_URL.concat("opr_bik_detail");
        
		BikeVO resultVo = null;
		BikeVO currentInfo = null;
		BikeVO logInfoVo = null;
		List<BikeRentalVO> rentalList = null;
		PaginationInfo paginationInfo = null;
		PaginationInfo paginationMobileInfo = null;
		
		RepairBikeVO repairBikeVo = new RepairBikeVO();
		PaginationInfo paginationInfoRepair = null;
		PaginationInfo paginationMobileInfoRepair = null;
		List<RepairBikeVO> resultListRepair = null;
		boolean result = false;
		try {
			if(bikeVo.getViewFlg().equals(CRUD_C)) {
				resultVo = new BikeVO();
				currentInfo = new BikeVO();
				rentalList = new ArrayList<BikeRentalVO>();
			} else if(bikeVo.getViewFlg().equals(MODE_EXCEL)) {
    			bikeVo.setPagingYn("N");
    			
    			int totCount = bikeService.getBikeHistoryInfoCount(bikeVo);
				paginationInfo = getPagingInfo(bikeVo.getCurrentPageNo(), totCount);
				paginationMobileInfo = getPagingMobileInfo(bikeVo.getCurrentPageNo(), totCount);
				bikeVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
				bikeVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
				resultVo = bikeService.getBikeInfo(bikeVo);
				currentInfo = bikeService.getBikeCurrentInfo(bikeVo);
				rentalList =  bikeService.getBikeHistoryInfo(bikeVo);
				
    			targetUrl = RETURN_URL.concat("opr_bik_hist_excel");
    		}else if(bikeVo.getViewFlg().equals(CRUD_U) || bikeVo.getViewFlg().equals(CRUD_R)) {
			/*else{*/
    			
    			if(bikeVo.getTabNum() == null){//처음에는 탭값이 없음
    				
    				bikeVo.setTabNum("1");
    				
    			}
    			
				Calendar cal = Calendar.getInstance();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				String nowDay = sdf.format(cal.getTime());
				String strDay = sdf.format(cal.getTime());
				
    			
				resultVo = bikeService.getBikeInfo(bikeVo);
				
    			if("1".equals(bikeVo.getTabNum())){//탭 상세정보
    				
    				
    			}else if("2".equals(bikeVo.getTabNum())){//탭 이력정보
    				
    				int totCount = 0;
    				
    				if(bikeVo.getSearchBgnDe() == null || "".equals(bikeVo.getSearchBgnDe())){
    					
    					cal.add(Calendar.DAY_OF_MONTH, -7);
    					strDay = sdf.format(cal.getTime());
    					
	    				bikeVo.setSearchBgnDe(strDay);
	    				bikeVo.setSearchEndDe(nowDay);
	    				
	    				totCount = bikeService.getBikeHistoryInfoCount(bikeVo);
	    				
	    				//2020-10-19 : 1달을 조회 후, 결과 값이 0일 때는 6개월까지, 없으면 1년
	    				
	    				if(totCount == 0){//1개월 조회
	    					
	    					cal = Calendar.getInstance();
	    					
	    					cal.add(Calendar.MONTH,-1);
	    					
	    					strDay = sdf.format(cal.getTime());
	    					
	    					bikeVo.setSearchBgnDe(strDay);
	    					
	    					totCount = bikeService.getBikeHistoryInfoCount(bikeVo);
	    					
	    					if(totCount == 0){//6개월 조회
	    						
	    						cal.add(Calendar.MONTH,-5);
	    						
	    						strDay = sdf.format(cal.getTime());
	    						
	    						bikeVo.setSearchBgnDe(strDay);
	    						
	    						totCount = bikeService.getBikeHistoryInfoCount(bikeVo);
	    						
	    						if(totCount == 0){//1년 조회
	    							
	    							cal.add(Calendar.MONTH,-6);
		    						
		    						strDay = sdf.format(cal.getTime());
		    						
		    						bikeVo.setSearchBgnDe(strDay);
		    						
		    						totCount = bikeService.getBikeHistoryInfoCount(bikeVo);	
	    							
	    						}
	    						
	    					}
	    					
	    				}
    				
    				}else{
    					
    					totCount = bikeService.getBikeHistoryInfoCount(bikeVo);
    					
    				}
    				
    				paginationInfo = getPagingInfo(bikeVo.getCurrentPageNo(), totCount);
    				paginationMobileInfo = getPagingMobileInfo(bikeVo.getCurrentPageNo(), totCount);
    				bikeVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
    				bikeVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
    				
    				rentalList =  bikeService.getBikeHistoryInfo(bikeVo);
    				
    				currentInfo = bikeService.getBikeCurrentInfo(bikeVo);
    				
    			}else if("3".equals(bikeVo.getTabNum())){//탭 수리이력
    				
    				repairBikeVo.setPagingYn("Y"); 
    				
    				repairBikeVo.setBikeId( bikeVo.getBikeId());
    				int totCntRepair = repairBikeService.getRepairBikeLisHistCount(repairBikeVo);
    				   
    				paginationInfoRepair = getPagingInfo(bikeVo.getCurrentPageNo(), totCntRepair);
    				paginationMobileInfoRepair = getPagingMobileInfo(bikeVo.getCurrentPageNo(), totCntRepair);
    				
    				repairBikeVo.setFirstRecordIndex(paginationInfoRepair.getFirstRecordIndex());
    				repairBikeVo.setRecordCountPerPage(paginationInfoRepair.getRecordCountPerPage());
    				
    				resultListRepair = repairBikeService.getRepairBikeHistList(repairBikeVo);
    				
    				currentInfo = bikeService.getBikeCurrentInfo(bikeVo);
    				
    			}else if("4".equals(bikeVo.getTabNum())){//탭 로그정보
    				
    				logInfoVo = bikeService.getBikeLog(bikeVo);
    				
    			}
    			
			}
			
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo",paginationMobileInfo);
			model.addAttribute("bikeVo"        , resultVo);
			model.addAttribute("rentalList"    , rentalList);
			model.addAttribute("currentInfo"   , currentInfo);
			model.addAttribute("logInfo"   , logInfoVo);
			model.addAttribute("bike"          , bikeVo);
			
			model.addAttribute("paginationInfoRepair", paginationInfoRepair);
			model.addAttribute("paginationMobileInfoRepair",paginationMobileInfoRepair);
			model.addAttribute("repairBikeVo"        , repairBikeVo);
			model.addAttribute("resultListRepair"    , resultListRepair);
			
			result = true;
		} catch (CfoodException e) {
			throw new CfoodException(getMessage("fail.common.msg"));
		}
		
		return result ? targetUrl : ERROR_PAGE;
	}
	
	
	@RequestMapping(value="/bike/dupIdCheckAjax.do")
	@RequestName("dupIdCheckAjax")
	public String dupIdCheckAjax(@ModelAttribute BikeVO bikeVo, ModelMap model, HttpServletRequest request ) throws Exception {
		String bizName = "bikeID,NO 중복 체크 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        boolean isDup = false;
        String resultMsg = "등록가능 합니다.";
		BikeVO resultVo = bikeService.getChkBikeIDnNo(bikeVo);
		String target = "";
		if(resultVo == null) {
			resultVo = new BikeVO();
		} else {
			if(resultVo.getBikeId().equals(bikeVo.getBikeId()) && !resultVo.getBikeNo().equals(bikeVo.getBikeNo())) {
				target = "id";
				isDup = true;
				resultMsg = "자전거 ID가 중복됩니다.";
			}
			if(!resultVo.getBikeId().equals(bikeVo.getBikeId()) && resultVo.getBikeNo().equals(bikeVo.getBikeNo())) {
				target = "no";
				isDup = true;
				resultMsg = "자전거 번호가 중복됩니다.";
			} 
            if(resultVo.getBikeId().equals(bikeVo.getBikeId()) && resultVo.getBikeNo().equals(bikeVo.getBikeNo())) {
            	target = "both";
				isDup = true;
				resultMsg = "이미 등록된 번호입니다.";
			}
			
		}
		
		model.addAttribute(RESULT, isDup);
		model.addAttribute("target",target);
		model.addAttribute(RESULTMSG, resultMsg);
		return JSONVIEW;
	} 
	
	@RequestMapping(value="/bikeDataEditExe.do")
	@RequestName("bikeDataEditExe")
	public String bikeDataEditExe(@ModelAttribute @Valid BikeVO bikeVo, BindingResult bResult, ModelMap model,HttpServletRequest request) throws Exception {
		String bizName = "자전거 등록, 수정";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		int result = 0;
		String resultMessage = "저장이 성공했습니다.";
		UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
		if(userSessionVO == null){
            throw new CfoodException(getMessage("error.invalidSession"));
        }
		try {
			List<ObjectError> errorList = bResult.getAllErrors();
			if(errorList.size() > 0) {
				for(ObjectError err : errorList) {
					resultMessage = err.getDefaultMessage();
				}
			} else {
				bikeVo.setAdminId(userSessionVO.getUsrId());
		        if(bikeVo.getViewFlg().equals(CRUD_C)) {
		        	result = bikeService.addNewBikeDevice(bikeVo);
		        } else {
		        	BikeVO oldInfo = bikeService.getOldBikeInfo(bikeVo.getBikeId());
		        	result = bikeService.setBikeDevice(bikeVo, oldInfo);
		        }
			}
		} catch (Exception e) {
			throw new CfoodException(getMessage("fail.common.msg"));
		}
        model.addAttribute(RESULT_MESSAGE, resultMessage);
        model.addAttribute(RESULT, result);
		
		return JSONVIEW;
	}

	
	@RequestMapping(value="/bike/regularChkReg.do")
	@RequestName("setBikeLasChkDttm")
	public String setBikeLasChkDttm(@ModelAttribute BikeVO bikeVo, ModelMap model,HttpServletRequest request) throws Exception {
		String bizName = "정기점검 일괄 등록";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        
        UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
        if(userSessionVO == null){
            throw new CfoodException(getMessage("error.invalidSession"));
        }
        int result  =0;
		List<BikeVO> resultList = null;
		try {
			if(bikeVo.getChkType() != null && bikeVo.getChkType().equals("all")) {
				bikeVo.setPagingYn(N);
				//전체 검색 관련 변경
				if (bikeVo.getBikeStatusCd() != null && bikeVo.getBikeStatusCd() =="all"){
		        	bikeVo.setBikeStatusCd("");
		        }
				resultList = bikeService.getBikeList(bikeVo);
			} else {
				resultList = bikeVo.getBikeList();
				
			}
			result = bikeService.setBikeLasChkDttm(resultList, userSessionVO.getUsrId());
		} catch (Exception e) {
			throw new CfoodException(getMessage("fail.common.msg"));
		}
		model.addAttribute(CHECK_RESULT, result);
		return JSONVIEW;
	}
	
	@RequestMapping(value="/bike/getQRBikeCodeDataInfo.do",method=RequestMethod.POST)
	@RequestName("getQRBikeCodeDataInfo")
	public String getQRBikeCodeDataInfo(@ModelAttribute BikeVO rentalVo, ModelMap model, HttpServletRequest request) throws Exception{
		
		boolean result = false;
		int resultCode = 0;
		String bizName = "QRCode 대여선택 APP 화면 이동";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		BikeVO qrData = null;
		
		try {
			
			UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
			if(userSessionVO == null){
				resultCode = -1;	// login error
				result = true;
			} else {
				
				// qr 단말 기일 경우
				if (rentalVo.getRackId().length() == 5 || rentalVo.getRackId().contains("SSBK-") || rentalVo.getRackId().contains("BRC-") ) {
					
					if (rentalVo.getRackId().contains("SSBK-") || rentalVo.getRackId().contains("BRC-")) {
						
						// 시리얼 번호 획득
						rentalVo.setSerialNo(String.valueOf(Integer.parseInt(rentalVo.getRackId().replace("SSBK-", "").replace("BRC-", ""))));
					} else {
						
						// 자전거 번호 입력
						rentalVo.setBikeNo(rentalVo.getRackId());
					}
					
					
					qrData = bikeService.getQRBikeInfo(rentalVo);
					if (qrData != null) {
						
						if("BKS_010".equals(qrData.getBikeStatusCd())){//2020-11-16 : 대여중 시 작업불가하도록 추가
							
							resultCode = -3;
							
						}else{
						
							if (rentalVo.getRackId().contains("SSBK-") || rentalVo.getRackId().contains("BRC-")) {
								qrData.setDeviceName(rentalVo.getRackId());		// ble Device Name 설정
							} else {
								String tempDeviceName = "";
								for (int i = qrData.getSerialNo().length(); i < 8; i++) {
									tempDeviceName += "0";
								}
								qrData.setDeviceName("BRC-" + tempDeviceName + qrData.getSerialNo());		// ble Device Name 설정
							}
							
						}
						
						result = true;
						
					} else {
						
						qrData = new BikeVO();
						qrData.setDeviceName(rentalVo.getRackId());
						resultCode = -99;	// status error
						result = true;
					}
					
				} else {
					
					resultCode = -2;		// Qr Code error
					qrData = null;
					result = true;
				}
			}
			
		} catch (Exception e) {
            throw new CfoodException(getMessage("fail.request.msg"), e);
		}
		model.addAttribute("qrData", qrData);
		model.addAttribute("resultCode", resultCode);
		model.addAttribute("result", result);
		return JSONVIEW;
		
	}
	
	@RequestMapping(value="/bike/getQRBikeInfo.do",method=RequestMethod.POST)
	@RequestName("getQRBikeInfo")
	public String getQRBikeInfo(@ModelAttribute BikeVO bikeVo, ModelMap model, HttpServletRequest request) throws Exception{
		
		boolean result = false;
		String bikeStatusCd = "";
		String bizName = "QRCode 자전거 상태 조회";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
				
		if(userSessionVO == null){
			result = false;
			 
		} else {
			
			try {
				
					/*if (bikeVo.getRackId().length() == 5 || bikeVo.getRackId().contains("SSBK-") || bikeVo.getRackId().contains("BRC-") ) {
						if (bikeVo.getRackId().contains("SSBK-") || bikeVo.getRackId().contains("BRC-")) {
							// 시리얼 번호 획득
							bikeVo.setSerialNo(String.valueOf(Integer.parseInt(bikeVo.getRackId().replace("SSBK-", "").replace("BRC-", ""))));
						}
					}*/
				bikeVo.setSerialNo(bikeVo.getRackId());
				bikeVo = bikeService.getQRBikeStatusCd(bikeVo);
				if(bikeVo != null && bikeVo.getBikeStatusCd() != null && !"".equals(bikeVo.getBikeStatusCd())){
					bikeStatusCd = bikeVo.getBikeStatusCd();
					result = true;
				}
					
			} catch (Exception e) {
					
					result = false;
					
					throw new CfoodException("fail.request.msg", e.getMessage());
			}
			
		}
		
		model.addAttribute("bikeStatusCd", bikeStatusCd);
		model.addAttribute("result", result);
		return JSONVIEW;
		
	}
	/*
	// 20210828
	@RequestMapping(value="/bike/exeQRBikeRelocateNew.do",method=RequestMethod.POST)
	@RequestName("exeQRBikeRelocateNew")
	public String exeQRBikeRelocateNew(@ModelAttribute BikeVO bikeVo, ModelMap model, HttpServletRequest request) throws Exception{
		
		boolean result = false;
		String bizName = "QRCode 재배치 완료 처리";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
		int cnt = 0;
		if(userSessionVO == null){
			result = false;
		} else {
			try {
				if (bikeVo.getBikeNo().length() == 5 || bikeVo.getBikeNo().contains("SSBK-") || bikeVo.getBikeNo().contains("BRC-") ) {
					if (bikeVo.getBikeNo().contains("SSBK-") || bikeVo.getBikeNo().contains("BRC-")) {
						// 시리얼 번호 획득
						bikeVo.setSerialNo(String.valueOf(Integer.parseInt(bikeVo.getBikeNo().replace("SSBK-", "").replace("BRC-", ""))));
					}
				}	
				 
				bikeVo = bikeService.getQRBikeInfoPhone(bikeVo);
				bikeVo.setAdminId(userSessionVO.getUsrId());
				if(bikeVo != null && bikeVo.getBikeStatusCd() != null && !"".equals(bikeVo.getBikeStatusCd())){
					 cnt = bikeService.setBikeRelocateHistNew(bikeVo);
					 
					 result =true;
				}
				
			} catch (Exception e) {
				result = false;
				e.printStackTrace();
				// throw new CfoodException("fail.request.msg", e.getMessage());
			}
			
		}
		model.addAttribute("bikeVO", bikeVo );
		model.addAttribute("result", result);
		model.addAttribute("cnt", cnt);
		return JSONVIEW;
	}
	*/ 
	// exeQRBikeRelocateNew1 : exeQRBikeRelocateNew UPDATE LOCK으로 인한 건별 처리
	@RequestMapping(value="/bike/exeQRBikeRelocateNew.do",method=RequestMethod.POST)
	@RequestName("exeQRBikeRelocateNew")
	public String exeQRBikeRelocateNew1(@ModelAttribute BikeVO bikeVo, ModelMap model, HttpServletRequest request) throws Exception {

		boolean result = false;
		String bizName = "QRCode 재배치 완료 처리";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
		int cnt = 0;
		if(userSessionVO == null){
			result = false;
		} else {
			try {
				if (bikeVo.getBikeNo().length() == 5 || bikeVo.getBikeNo().contains("SSBK-") || bikeVo.getBikeNo().contains("BRC-") ) {
					if (bikeVo.getBikeNo().contains("SSBK-") || bikeVo.getBikeNo().contains("BRC-")) {
						// 시리얼 번호 획득
						bikeVo.setSerialNo(String.valueOf(Integer.parseInt(bikeVo.getBikeNo().replace("SSBK-", "").replace("BRC-", ""))));
					}
				}	
				 
				bikeVo = bikeService.getQRBikeInfoPhone(bikeVo);
				bikeVo.setAdminId(userSessionVO.getUsrId());
				if(bikeVo != null && bikeVo.getBikeStatusCd() != null && !"".equals(bikeVo.getBikeStatusCd())){

					List<BikeVO> list = bikeService.selectBikeRelocateTarget(bikeVo);
					for( BikeVO vo : list ) {
						cnt = + bikeService.updateBikeRelocateSeq(vo);	
					}
					cnt = list.size();	
					System.out.println("cnt : " +  cnt );
					result =true;
					
				}
				
			} catch (Exception e) {
				result = false;
				e.printStackTrace();
				// throw new CfoodException("fail.request.msg", e.getMessage());
			}
			
		}
		model.addAttribute("bikeVO", bikeVo );
		model.addAttribute("result", result);
		model.addAttribute("cnt", cnt);
		return JSONVIEW;
	}
	
	@RequestMapping(value="/bike/exeQRBikeMove.do",method=RequestMethod.POST)
	@RequestName("exeQRBikeMove")
	public String exeQRBikeMove(@ModelAttribute BikeVO rentalVo, ModelMap model, HttpServletRequest request) throws Exception{
		
		boolean result = false;
		int resultCode = 0;
		String bizName = "QRCode 관리 이동 처리";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
			
		String bikeStatusName = "";
		String bikeNo         = "";
		String useCnt         = "";
		
		if(userSessionVO == null){
			resultCode = -2;
			result = false;
			 
		} else {
			
			try {
					rentalVo.setAdminId(userSessionVO.getUsrId());
					
					// 대여(이동) 진행
					bikeService.exeQrMoveProc(rentalVo);
					
					BikeVO statusVo = bikeService.getBikeCurrentInfo(rentalVo);
					
					if ( statusVo != null ) {
						bikeStatusName = statusVo.getBikeStatusName();
						bikeNo         = statusVo.getBikeNo();
						useCnt         = statusVo.getUseCnt();
					}
					
					log.debug("QR 대여 완료 usrSeq : " + rentalVo.getAdminId() + " bikeId : " + rentalVo.getBikeId() );
					resultCode = 0;
					result = true;
					
			} catch (Exception e) {
					
					resultCode = -1;
					result = false;
					
					log.error(e.getMessage());
				//	throw new CfoodException("fail.request.msg", e.getMessage());
			}
		}
		
		model.addAttribute("resultCode", resultCode);
		model.addAttribute("result", result);
		model.addAttribute("bikeStatusName", bikeStatusName);
		model.addAttribute("bikeNo", bikeNo);
		model.addAttribute("useCnt", useCnt);
		return JSONVIEW;
	}
	
	@RequestMapping(value="/bike/exeQRBikeRelocate.do",method=RequestMethod.POST)
	@RequestName("exeQRBikeRelocate")
	public String exeQRBikeRelocate(@ModelAttribute BikeVO rentalVo, ModelMap model, HttpServletRequest request) throws Exception{
		
		boolean result = false;
		int resultCode = 0;
		String bizName = "QRBike 재배치 완료  처리";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
		if(userSessionVO == null){
			resultCode = -1;
			result = false;
		}
		try {
			
			rentalVo.setAdminId(userSessionVO.getUsrId());
			
			// 재배치 완료 처리
			log.debug("QR 재배치 완료 usrSeq : " + rentalVo.getAdminId());
			bikeService.exeQRBikeRelocate(rentalVo);
			result = true;
			
		} catch (Exception e) {
            throw new CfoodException(getMessage("fail.request.msg"), e);
		}
		model.addAttribute("resultCode", resultCode);
		model.addAttribute("result", result);
		return JSONVIEW;
		
	}
	
	
	@RequestMapping(value="/bike/getQRBikeInfoPhone.do",method=RequestMethod.POST)
	@RequestName("getQRBikeInfoPhone")
	public String getQRBikeInfoPhone(@ModelAttribute BikeVO bikeVo, ModelMap model, HttpServletRequest request) throws Exception{
		
		boolean result = false;
		String bizName = "QRCode 자전거 상태 조회";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
				
		if(userSessionVO == null){
			result = false;
		} else {
			try {
				if (bikeVo.getRackId().length() == 5 || bikeVo.getRackId().contains("SSBK-") || bikeVo.getRackId().contains("BRC-") ) {
					if (bikeVo.getRackId().contains("SSBK-") || bikeVo.getRackId().contains("BRC-")) {
						// 시리얼 번호 획득
						bikeVo.setSerialNo(String.valueOf(Integer.parseInt(bikeVo.getRackId().replace("SSBK-", "").replace("BRC-", ""))));
					}
				}	
				bikeVo = bikeService.getQRBikeInfoPhone(bikeVo);
				if(bikeVo != null && bikeVo.getBikeStatusCd() != null && !"".equals(bikeVo.getBikeStatusCd())){
					result = true;
				}
					
			} catch (Exception e) {
				result = false;
				throw new CfoodException("fail.request.msg", e.getMessage());
			}
			
		}
		model.addAttribute("bikeVO", bikeVo );
		model.addAttribute("result", result);
		return JSONVIEW;
		
	}
	
	
	
	
	
	
	
	
	
	
	
}
