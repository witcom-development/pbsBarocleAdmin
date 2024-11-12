/*
 * @Package Name : com.dkitec.barocle.admin.status.rentStatus.controller
 * @파일명          : RentStatusController.java
 * @작성일          : 2015. 5. 15.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 5. 15.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.status.rentStatus.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Random;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.admin.login.vo.UserSessionVO;
import com.dkitec.barocle.admin.maintenance.check.bike.vo.CheckBikeVO;
import com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.BikeService;
import com.dkitec.barocle.admin.manage.deviceMgmt.bike.vo.BikeVO;
import com.dkitec.barocle.admin.manage.stationgroup.service.StationGroupMgmtService;
import com.dkitec.barocle.admin.manage.stationgroup.vo.StationGroupMgmtVO;
import com.dkitec.barocle.admin.status.rentHistory.service.RentHistoryService;
import com.dkitec.barocle.admin.status.rentHistory.vo.PenaltyVO;
import com.dkitec.barocle.admin.status.rentStatus.service.RentStatusService;
import com.dkitec.barocle.admin.status.rentStatus.vo.BikeRentalVO;
import com.dkitec.barocle.admin.system.commonCodeMgmt.service.CommonCodeService;
import com.dkitec.barocle.admin.system.commonCodeMgmt.vo.CommonCodeVO;
import com.dkitec.barocle.admin.system.usermgmt.service.UserMgmtService;
import com.dkitec.barocle.admin.system.usermgmt.vo.UserMgmtVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.base.IConstants;
import com.dkitec.barocle.util.sms.SendType;
import com.dkitec.barocle.util.sms.SmsSender;
import com.dkitec.barocle.util.sms.vo.SmsMessageVO;
import com.dkitec.barocle.util.webutil.DateUtil;
import com.dkitec.barocle.util.webutil.HttpUtil;
import com.dkitec.barocle.util.webutil.StringUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * @파일명          : RentStatusController.java
 * @작성일          : 2015. 5. 15.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 5. 15.   |   ymshin   |  최초작성
 */
@Controller
@RequestCategory(value="RentStatusController")
public class RentStatusController extends BaseController {

	protected static Logger log = LoggerFactory.getLogger(RentStatusController.class);
	private static final String RETURN_URL = "/admin/status/rentStatus/";
	@Resource(name="rentStatusService") private RentStatusService rentStatusService;
	@Resource(name="rentHistoryService") private RentHistoryService rentHistoryService;
	@Resource(name = "commonCodeService") private CommonCodeService codeService;
	@Resource(name = "userMgmtService") private UserMgmtService usrService;
	@Resource(name = "stationGroupMgmtService") protected StationGroupMgmtService stationGroupMgmtService;
	 
	@Resource(name="bikeService") private BikeService bikeService;
	
	@RequestMapping(value="/getRentStatusList.do")
	@RequestName("getRentStatusList")
	public String getRentStatusList(@ModelAttribute BikeRentalVO rentalVo, ModelMap model, HttpServletRequest request) {
		String bizName = "대여현황 목록 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		String target = RETURN_URL.concat("pre_rent_state");
		boolean result = false;
		try {
			rentalVo.setPageYn("Y"); //페이징 처리 여부
			int totCnt = rentStatusService.getRentStatusAllCnt(rentalVo);
			PaginationInfo paginationInfo = getPagingInfo(rentalVo.getCurrentPageNo(), totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(rentalVo.getCurrentPageNo(), totCnt);
			rentalVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			rentalVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<CommonCodeVO> resultList = rentStatusService.getRentStatusList(rentalVo);
			
			List<StationGroupMgmtVO> group = null;
			StationGroupMgmtVO vo = new StationGroupMgmtVO();
			vo.setLang(request.getLocale().getLanguage());
			group = stationGroupMgmtService.getStationGroupNameList(vo);
			model.put("group", group);
			
			model.addAttribute("searchCondition",rentalVo );
			model.addAttribute("rentList", resultList);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo",paginationMobileInfo);
			result = true;
			
		} catch (CfoodException e) {
			// TODO: handle exception
			throw new CfoodException("fail.common.msg",e.getMessage());
		}
		
		return result ?  target : ERROR_PAGE;
	}
	
	@RequestMapping(value="/getSmsAllUsrMpnNo.do")
	@RequestName("getSmsAllUsrMpnNo")
	public String getSmsAllUsrMpnNo(@ModelAttribute BikeRentalVO rentalVo, ModelMap model, HttpServletRequest request) {
		String bizName = "조회조건에 해당하는 모든 전화번호.";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        try {
			List<String> usrMpnNoList = rentStatusService.getSmsAllUsrMpnNo(rentalVo);
			model.addAttribute("smsList", usrMpnNoList);
		} catch (CfoodException e) {
			// TODO: handle exception
			throw new CfoodException("fail.common.msg",e.getMessage());
		}
        
        return "/admin/common/popup/pop_sms_pro";
	}
	
	@RequestMapping(value="/moveRentStatusInfo.do")
	@RequestName("getRentStatusInfo")
	public String getRentStatusInfo(@ModelAttribute @Valid BikeRentalVO rentalVo, BindingResult bindingResult, ModelMap model, HttpServletRequest request) {
		String bizName = "대여현황 목록 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		boolean result = false;
		String msg = "";
		try {
			BikeRentalVO rentInfo = null;
			if(bindingResult.hasErrors()) {
				for(ObjectError error : bindingResult.getAllErrors()) {
					msg = error.getDefaultMessage();
				}
			} else {
				rentInfo = rentStatusService.getRentStatusInfo(rentalVo);
				if(rentInfo != null){
	    			List<PenaltyVO> penalty =  rentHistoryService.getPenaltyList(rentInfo);
	    			int pTot = 0;
	    			for(PenaltyVO pVo : penalty) {
	    				pTot += Integer.parseInt( pVo.getPenaltyPoint());
	    			}
	    			rentInfo.setPenaltyTot(String.valueOf(pTot));
	    			rentInfo.setPenaltyList(penalty);
	    			rentInfo.setRentStatusName("대여중");
	    		}
				result = true;
			}
			
			model.addAttribute("rentInfo", rentInfo);
	    	model.addAttribute("menuType", "status");
		} catch (CfoodException e) {
		    throw new CfoodException("fail.common.msg",e.getMessage());
		}
		
		return result ?  "/admin/status/rentHistory/pre_rent_detail" : ERROR_PAGE;
	}
	
	@RequestMapping("/rentTempPwSend.do")
	@RequestName("rentTempPwSend")
	public String rentTempPwSend(@ModelAttribute @Valid BikeRentalVO rentalVo, BindingResult bindingResult, ModelMap model, HttpServletRequest request) {
		String bizName = "대여현황 목록 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		boolean result = false;
		String msg = "";
		try {
		    
			String commonPw = "";
			Random random = new Random();
			String chars[] = "1,2,3,4".split(",");
			for(int i = 1; i <= 4; i++){
				commonPw += chars[random.nextInt(chars.length)];
			}
			rentalVo.setRentEncPwd(commonPw);
			
			int r = rentStatusService.setRentTempPwSend(rentalVo);
			
			SmsMessageVO smsMessageVO = new SmsMessageVO();
        	smsMessageVO.setDestno(rentalVo.getUsrMpnNo());
        	smsMessageVO.setMsg(SendType.SMS_012, commonPw);
        	SmsSender.sender(smsMessageVO);
			
			
			result = true;
	    	
		} catch (CfoodException e) {
		    throw new CfoodException("fail.common.msg",e.getMessage());
		}
	    model.addAttribute(CHECK_RESULT, result);
	    return JSONVIEW;
	}
	
	@RequestMapping(value="/getExeImpulseList.do")
	@RequestName("getExeImpulseList")
	public String getExeImpulseList(@ModelAttribute BikeRentalVO rentalVo, ModelMap model, HttpServletRequest request) throws Exception {
		String bizName = "강제반납 목록 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		String target = RETURN_URL.concat("exe_impulse_list");
		boolean result = false;
		try {
			CommonCodeVO cVo = new CommonCodeVO();
        	List<CommonCodeVO> codeList = null;
        	cVo.setComUpCd("DEC");
        	cVo.setLang(IConstants.LANG_KR);
        	
        	// 배송 센터 공통코드 조회
        	codeList = codeService.getComCodeInfo(cVo);
        	
        	// 팀 공통코드 조회
        	List<CommonCodeVO> teamList = null;
        	cVo.setComUpCd("TEAM");
        	teamList = codeService.getComCodeInfo(cVo);
        	
        	List<CommonCodeVO> nrrList = null;
        	cVo.setComUpCd("NRR");
        	nrrList = codeService.getComCodeInfo(cVo);
        	
        	// 처리유형, 처리완료 조회
        	/*if(rentalVo.getComptCd()!= "0" && rentalVo.getProcCd() != ""){
        		rentalVo.setComptCd(rentalVo.getProcCd());
        	}*/
        	
        	userSessionVO = (UserSessionVO) EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
        	
        	
        	UserMgmtVO usrVO = new UserMgmtVO();
        	
        	usrVO.setUsrId(userSessionVO.getUsrId());
        	UserMgmtVO usrInfo = usrService.getUsrInfo(usrVO);
        	
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			if(rentalVo.getSearchStartDate() == null && rentalVo.getSearchEndDate() == null){
				rentalVo.setSearchEndDate(sdf.format(cal.getTime()));
				cal.add(Calendar.MONTH, -1);
				rentalVo.setSearchStartDate(sdf.format(cal.getTime()));
				rentalVo.setCenterId(usrInfo.getCenter_id());
				//rentalVo.setCenterId("DEC_001");
				
			}        	
			
			rentalVo.setBikeMYID(userSessionVO.getUsrId());
			
			int totCnt = rentStatusService.getExeImpulseReturnListCnt(rentalVo);
			PaginationInfo paginationInfo = getPagingInfo(rentalVo.getCurrentPageNo(), totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(rentalVo.getCurrentPageNo(), totCnt);
			rentalVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			rentalVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<BikeRentalVO> resultList = rentStatusService.getExeImpulseReturnList(rentalVo);
			
			
			
			model.addAttribute("searchCondition",rentalVo );
			model.addAttribute("codeList", codeList);
			model.addAttribute("teamList", teamList);
			model.addAttribute("nrrList", nrrList);
			model.addAttribute("resultList", resultList);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo",paginationMobileInfo);
			
			model.addAttribute("usrId",userSessionVO.getUsrId());
			model.addAttribute("usrGrpCd",userSessionVO.getUsrGrpCd());
			
			result = true;
			
		} catch (CfoodException e) {
			// TODO: handle exception
			throw new CfoodException("fail.common.msg",e.getMessage());
		}
		
		return result ?  target : ERROR_PAGE;
	}
	
	@RequestMapping(value="/compExeImpulseProc.do")
	@RequestName(value="/compExeImpulseProc")
	public String compExeImpulseProc(@ModelAttribute BikeRentalVO rentalVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		
		String bizName = "강제반납 완료처리";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        
        try {
        	UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
            if(userSessionVO == null){
            	throw new CfoodException(getMessage("error.invalidSession"));
            }
            
            //checkBikeVo.setModId(userSessionVO.getUsrId());
            rentalVo.setRegId(userSessionVO.getUsrId());
            rentStatusService.compExeImpulseProc(rentalVo);
            
            // 2020-06-17 자전거 강제 복구일 경우, 자전거를 임의 장소로 변경
            if ( "9".equals(rentalVo.getComptCd())) {
            	
            	rentStatusService.insertParkingInfo(rentalVo);
            	rentStatusService.updateBikeStatus(rentalVo);
            }
            
            
			model.addAttribute(RESULT_MESSAGE, "Success");
			model.addAttribute(CHECK_RESULT, 0);
		} catch (Exception e) {
			throw new CfoodException("admin.system.maintenance.exeBikeSelectCheck", e.getMessage());
		}
		return JSONVIEW;
	}
	
	@RequestMapping(value="/moveExeImpulseDetail.do")
	@RequestName("moveExeImpulseDetail")
	public String moveExeImpulseDetail(@ModelAttribute BikeRentalVO rentalVo, ModelMap model, HttpServletRequest request) {
		String bizName = "강제반납관리 현황 상세화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		String target = RETURN_URL.concat("exe_impulse_detail");
		boolean result = false;
		try {
			CommonCodeVO cVo = new CommonCodeVO();
        	List<CommonCodeVO> codeList = null;
        	cVo.setComUpCd("DEC");
        	cVo.setLang(IConstants.LANG_KR);
        	
        	// 배송 센터 공통코드 조회
        	codeList = codeService.getComCodeInfo(cVo);
        	
        	// 팀 공통코드 조회
        	List<CommonCodeVO> teamList = null;
        	cVo.setComUpCd("TEAM");
        	teamList = codeService.getComCodeInfo(cVo);
        	
        	List<CommonCodeVO> nrrList = null;
        	cVo.setComUpCd("NRR");
        	nrrList = codeService.getComCodeInfo(cVo);
        	
        	// 사진 목록 가져오기
    		List<BikeRentalVO> enfrcFileList = rentStatusService.listEnfrcFile(rentalVo);
			
			BikeRentalVO resultInfo = rentStatusService.getExeImpulseReturnInfo(rentalVo);
			
			model.addAttribute("codeList", codeList);
			model.addAttribute("teamList", teamList);
			model.addAttribute("nrrList", nrrList);
			model.addAttribute("resultInfo", resultInfo);
			
			model.addAttribute("enfrcFileList", enfrcFileList);
			result = true;
			
		} catch (CfoodException e) {
			// TODO: handle exception
			throw new CfoodException("fail.common.msg",e.getMessage());
		}
		
		return result ?  target : ERROR_PAGE;
	}
	
	@RequestMapping(value="/updateExeImpulseProc.do")
	@RequestName(value="/updateExeImpulseProc")
	public String updateExeImpulseProc(@ModelAttribute BikeRentalVO rentalVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		
		String bizName = "강제반납 수정";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        
        try {
        	UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
            if(userSessionVO == null){
            	throw new CfoodException(getMessage("error.invalidSession"));
            }
            //checkBikeVo.setModId(userSessionVO.getUsrId());
            
            //rentalVo.setParkingLocation(new String(rentalVo.getParkingLocation().getBytes("ISO-8859-1"), "UTF-8"));
            //rentalVo.setAddr(new String(rentalVo.getAddr().getBytes("ISO-8859-1"), "UTF-8"));
            //rentalVo.setParkingLocationDesc(new String(rentalVo.getParkingLocationDesc().getBytes("ISO-8859-1"), "UTF-8"));
            //rentalVo.setEnfrcReturnDesc(new String(rentalVo.getEnfrcReturnDesc().getBytes("ISO-8859-1"), "UTF-8"));
            
            rentStatusService.updateExeImpulseProc(rentalVo);
            
			model.addAttribute(RESULT_MESSAGE, "Success");
		} catch (Exception e) {
			throw new CfoodException("admin.system.maintenance.exeBikeSelectCheck",e.getMessage());
		}
		return JSONVIEW;
	}
	
	
	@RequestMapping(value="/bikeNoSearch.do")
	@RequestName(value="/bikeNoSearch")
	public String bikeNoSearch(@ModelAttribute BikeRentalVO rentalVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		
		String bizName =  "자전거 번호 검색";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
       
        try {
        	UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
            if(userSessionVO == null){
            	throw new CfoodException(getMessage("error.invalidSession"));
            }
            
            BikeRentalVO resultOne =  rentStatusService.getSearchBikeNo(rentalVo);
			model.addAttribute(RESULT_MESSAGE, "Success");
			model.addAttribute("result", resultOne);
		} catch (Exception e) {
			throw new CfoodException("admin.system.maintenance.exeBikeSelectCheck",e.getMessage());
		}
		return JSONVIEW;
	}
	
	@RequestMapping(value = "/getRobLostManageList.do")
	@RequestName("getRobLostManageList")
	public String getRobLostManageList(@ModelAttribute @Valid BikeVO bikeVo,BindingResult bResult ,HttpServletRequest request,ModelMap model) throws Exception {
		
    	String targetUrl = RETURN_URL.concat("exe_robLost_list");
    	String bizName = "도난분실상세조회";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        
        boolean result = false;
       
        Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        
        if ( StringUtil.isEmpty(  bikeVo.getSearchBgnDe() ) ) {
        	bikeVo.setSearchBgnDe(sdf.format(cal.getTime()));
        }
        
        if ( StringUtil.isEmpty(  bikeVo.getSearchEndDe() ) ) {
        	bikeVo.setSearchEndDe(sdf.format(cal.getTime()));
        }
        
        if ( StringUtil.isEmpty(  bikeVo.getBikeStatusCd() ) ) {
        	bikeVo.setBikeStatusCd("BKS_099");
        }
        
        if(!StringUtil.isEmpty(  bikeVo.getViewFlg() ) && MODE_EXCEL.equals(bikeVo.getViewFlg())) {
        	targetUrl = RETURN_URL.concat("exe_robLost_list_excel");
        }        

        if(bikeVo.getViewFlg().equals(MODE_EXCEL)) {
        	bikeVo.setPagingYn("N");
        	targetUrl = RETURN_URL.concat("exe_robLost_list_excel");
        }
        
        try {
    		
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
    		result = true;
		} catch (CfoodException e){
			throw new CfoodException("fail.common.msg",e.getMessage());
		}
        
		return result ? targetUrl : ERROR_PAGE;
	}
	
	/*
	 * 도난분실 조회
	 */
	@RequestMapping(value = "/getRobLostManageHistList.do")
	@RequestName("getRobLostManageHistList")
	public String getRobLostManageHistList(@ModelAttribute @Valid BikeVO bikeVo,BindingResult bResult ,HttpServletRequest request,ModelMap model) throws Exception {
		
    	String targetUrl = RETURN_URL.concat("exe_robLostHist_list");
    	String bizName = "도난분실조회";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        
        boolean result = false;
        Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        if (bikeVo.getSearchBgnDe() == null || bikeVo.getSearchBgnDe() == ""){
        	bikeVo.setSearchBgnDe(sdf.format(cal.getTime()));
        }
        if (bikeVo.getSearchEndDe() == null || bikeVo.getSearchEndDe() == ""){
        	bikeVo.setSearchEndDe(sdf.format(cal.getTime()));
        }
        
        if ( StringUtil.isEmpty(  bikeVo.getBikeStatusCd() ) ) {
        	bikeVo.setBikeStatusCd("BKS_099");
        }
        if(!StringUtil.isEmpty(  bikeVo.getViewFlg() ) && MODE_EXCEL.equals(bikeVo.getViewFlg())) {
        	bikeVo.setPagingYn("N");
        	targetUrl = RETURN_URL.concat("exe_robLostHist_list_excel");
        }
        
        try {
    		
        	int totCnt = bikeService.getBikeRobListCount(bikeVo);
        	
    		PaginationInfo paginationInfo = getPagingInfo(bikeVo.getCurrentPageNo(), totCnt);
    		PaginationInfo paginationMobileInfo = getPagingMobileInfo(bikeVo.getCurrentPageNo(), totCnt);
    		
    		bikeVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
    		bikeVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
    		List<BikeVO> resultList = bikeService.getBikeRobList(bikeVo);
    		
    		result = true;
    		
    		model.addAttribute("searchCondition",bikeVo );
    		model.addAttribute("paginationInfo" ,paginationInfo);
    		model.addAttribute("paginationMobileInfo",paginationMobileInfo);
    		model.addAttribute("BikeList", resultList);
    		
		} catch (CfoodException e){
			throw new CfoodException("fail.common.msg",e.getMessage());
		}
        
		return result ? targetUrl : ERROR_PAGE;
	}
	
	@RequestMapping(value = "/getRetrievalHistList.do")
	@RequestName("getRetrievalHistList")
	public String getRetrievalHistList(@ModelAttribute @Valid BikeVO bikeVo,BindingResult bResult ,HttpServletRequest request,ModelMap model) throws Exception {
		
    	String targetUrl = RETURN_URL.concat("exe_rtrvlHist_list");
    	String bizName = "회수조회";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        
        boolean result = false;
        Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        if (bikeVo.getSearchBgnDe() == null || bikeVo.getSearchBgnDe() == ""){
        	bikeVo.setSearchBgnDe(sdf.format(cal.getTime()));
        }
        if (bikeVo.getSearchEndDe() == null || bikeVo.getSearchEndDe() == ""){
        	bikeVo.setSearchEndDe(sdf.format(cal.getTime()));
        }
        
        if ( StringUtil.isEmpty(  bikeVo.getBikeStatusCd() ) ) {
        	bikeVo.setBikeStatusCd("BKS_014");
        }
        
        if(bikeVo.getViewFlg().equals(MODE_EXCEL)) {
        	bikeVo.setPagingYn("N");
        	targetUrl = RETURN_URL.concat("exe_rtrvlHist_list_excel");
		}
		
        try {
    		
    		int totCnt = bikeService.getBikeListCount(bikeVo);
    		PaginationInfo paginationInfo = getPagingInfo(bikeVo.getCurrentPageNo(), totCnt);
    		PaginationInfo paginationMobileInfo = getPagingMobileInfo(bikeVo.getCurrentPageNo(), totCnt);
    		bikeVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
    		bikeVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
    		
    		List<BikeVO> resultList = bikeService.getBikeList(bikeVo);
    		result = true;
    		
    		model.addAttribute("searchCondition",bikeVo );
    		model.addAttribute("paginationInfo", paginationInfo);
    		model.addAttribute("paginationMobileInfo",paginationMobileInfo);
    		model.addAttribute("BikeList", resultList);
    		
		} catch (CfoodException e){
			throw new CfoodException("fail.common.msg",e.getMessage());
		}
        
		return result ? targetUrl : ERROR_PAGE;
	}
	
}
