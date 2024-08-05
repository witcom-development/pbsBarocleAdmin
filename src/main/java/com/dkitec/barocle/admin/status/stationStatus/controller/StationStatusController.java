/*
 * @Package Name : com.dkitec.barocle.admin.status.stationStaus.controller
 * @파일명          : StationStatusController.java
 * @작성일          : 2015. 5. 18.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 5. 18.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.status.stationStatus.controller;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
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
import org.springframework.web.bind.annotation.RequestMapping;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.admin.login.vo.UserSessionVO;
import com.dkitec.barocle.admin.manage.deviceMgmt.beacon.service.BeaconService;
import com.dkitec.barocle.admin.manage.deviceMgmt.beacon.vo.BeaconVO;
import com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.BikeService;
import com.dkitec.barocle.admin.manage.deviceMgmt.bike.vo.BikeVO;
import com.dkitec.barocle.admin.status.rentStatus.service.RentStatusService;
import com.dkitec.barocle.admin.status.rentStatus.vo.BikeRentalVO;
import com.dkitec.barocle.admin.status.stationStatus.service.StationStatusService;
import com.dkitec.barocle.admin.status.stationStatus.vo.StationStatusVO;
import com.dkitec.barocle.admin.status.stationStatus.vo.StationVO;
import com.dkitec.barocle.admin.system.teammgmt.service.TeamMgmtService;
import com.dkitec.barocle.admin.system.teammgmt.vo.TeamMgmtVO;
import com.dkitec.barocle.admin.system.usermgmt.service.UserMgmtService;
import com.dkitec.barocle.admin.system.usermgmt.vo.UserMgmtVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.base.IConstants;
import com.dkitec.barocle.util.webutil.DateUtil;
import com.dkitec.barocle.util.webutil.HttpUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * @파일명          : StationStatusController.java
 * @작성일          : 2015. 5. 18.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 5. 18.   |   ymshin   |  최초작성
 */
@Controller
@RequestCategory(value="StationStatusController")
public class StationStatusController extends BaseController {

	protected static Logger log = LoggerFactory.getLogger(StationStatusController.class);
	private static final String RETURN_URL = "/admin/status/stationStatus/";
	/** Service */
	@Resource(name="stationStatusService") private StationStatusService stationStatusService;
	@Resource(name="rentStatusService") private RentStatusService rentStatusService;
	@Resource(name = "teamMgmtService") private TeamMgmtService teamService;	// 20200812 대여소 현황에서, 팀정보 위한 추가
	@Resource(name="beaconService") private BeaconService beaconService;
	@Resource(name="bikeService") private BikeService bikeService;
	@Resource(name = "userMgmtService") private UserMgmtService usrService;
	
	@RequestMapping(value="/getBikeBatLowStationAjax.do")
	@RequestName("getBikeBatLowStationAjax")
	public String getBikeBatLowStationAjax(@ModelAttribute StationStatusVO statusVo, ModelMap model, HttpServletRequest request) {
		String bizName = "자전거 배터리 부족 대여소 조회";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		boolean result = false;
		
		UserSessionVO userSessionVO = null;
		
		try {
			userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
			if(userSessionVO == null){
	        	throw new CfoodException(getMessage("error.invalidSession"));
	        }
		} catch (Exception e) {
			throw new CfoodException(getMessage("fail.common.msg"));
		}
		
        try {
        	
        	List<StationStatusVO> bikeBatLowStationList = stationStatusService.getBikeBatLowStationList(statusVo);
        	
        	
        	model.addAttribute(IConstants.RESULT_MESSAGE , IConstants.OK);
        	model.addAttribute("bikeBatLowStationList", bikeBatLowStationList);
        	
        	result = true;
        }catch(CfoodException e) {
        	throw new CfoodException("fail.common.msg", e.getMessage());
        }
        
        return result ?  JSONVIEW : ERROR_PAGE;
	}
	
	@RequestMapping(value="/getStationCurrentStatusAjax.do")
	@RequestName("getStationCurrentStatusAjax")
	public String getStationCurrentStatusAjax(@ModelAttribute StationStatusVO statusVo, ModelMap model, HttpServletRequest request) {
		
		String bizName = "대여소 현황 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		boolean result = false;
		StationStatusVO wholeStatusTotCnt = null;
		PaginationInfo paginationInfo = null;
		PaginationInfo paginationMobileInfo = null;
		List<StationStatusVO> stationList = null;
		
		List<BikeRentalVO> exeImpulseList = null; // 2020.01.31 강제반납 추가
		List<BikeVO> bikeLostList = null; // 2020.01.31 강제반납 추가
		
		UserSessionVO userSessionVO = null;
		
		try {
			userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
			if(userSessionVO == null){
	        	throw new CfoodException(getMessage("error.invalidSession"));
	        }
		} catch (Exception e) {
			throw new CfoodException(getMessage("fail.common.msg"));
		}
		
        try {
        	
        	wholeStatusTotCnt  = stationStatusService.getStationStatusTotCnt(IConstants.LANG_KR);	//대여소 현황목록_전체_JJH
        	
        	if ( "1".equals(userSessionVO.getUsrGrpCd()) 
        			|| statusVo.getParamSearchType() != null
        			|| statusVo.getParamSearchWord() != null
        			) {
        		
        		int sizeList = stationStatusService.getStationListCount(statusVo);						//검색조건 LIST 총 갯수_JJH
        		paginationInfo = getPagingInfo(statusVo.getCurrentPageNo(), sizeList);
        		paginationMobileInfo = getPagingMobileInfo(statusVo.getCurrentPageNo(), sizeList);
        		paginationInfo.setRecordCountPerPage(100);
        		paginationMobileInfo.setRecordCountPerPage(100);
        		if(statusVo.getRecordCountPerPage() > 5) {
        			paginationInfo.setRecordCountPerPage(statusVo.getRecordCountPerPage());
        			paginationMobileInfo.setRecordCountPerPage(statusVo.getRecordCountPerPage());
        		}
        		statusVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
        		statusVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());	
        		
        		stationList  = stationStatusService.getStationStautsList(statusVo);						//검색조건 LIST 목록_JJH
        		
        		// 강반 내역 조회 20200131 추가
        		if( statusVo.getBatteryStusCd() != null ) {
        			exeImpulseList = getEmpluseList(statusVo);
        		}
        		
        		// 분실 조회 20200131 추가
        		if( statusVo.getBatteryStusCd() != null ) {
        			bikeLostList = bikeService.getBikeLostLog();
        		}
        		
        	}
        	
			result = true;
			
		}catch(CfoodException e) {
        	throw new CfoodException("fail.common.msg", e.getMessage());
        }
        
        // 20200812 센터 , 팀정보 세팅
        String centerId = "";
        String teamSeq = "";
        if("N".equals(statusVo.getDefaultTeamYn())){// 2020-11-25 : 사용자가 검색조건인 센터를 변경했는지 확인 절차 추가
        	
        	centerId = statusVo.getBatteryStusCd() != null ? statusVo.getBatteryStusCd() : "";
        	teamSeq  = statusVo.getParamSearchType() != null ? statusVo.getParamSearchType() : "";
        
        }else{
        	
	        if ( userSessionVO.getTeamSeq() != null && !"".equals(userSessionVO.getTeamSeq()) && !"0".equals(userSessionVO.getTeamSeq()) ) {
	        	TeamMgmtVO teamVo = new TeamMgmtVO();
	        	 teamVo.setTeamSeq( userSessionVO.getTeamSeq() );
	        	 TeamMgmtVO resultMap;
				try {
					resultMap = teamService.getTeamInfo( teamVo );
					centerId = resultMap != null ? ( resultMap.getCenterId() != null  ? resultMap.getCenterId() : "" ) : "";
					teamSeq  = userSessionVO.getTeamSeq();
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	        	
	        }
        	
        }
        
		model.addAttribute("wholeStatusTot" , wholeStatusTotCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("paginationMobileInfo",paginationMobileInfo);
		model.addAttribute("stationList" , stationList);
		model.addAttribute("condition" , statusVo);
		
		model.addAttribute("exeImpulseList" , exeImpulseList);
		//20200428
		model.addAttribute("bikeLostList" , bikeLostList);
		
		// 20200812
		model.addAttribute("centerId" , centerId);
		model.addAttribute("teamSeq" , teamSeq);
		
		model.addAttribute("naverMapApiKey",super.propertiesService.getString("naverMapApiKey"));
		return result ?  JSONVIEW : ERROR_PAGE;
	}

	private List<BikeRentalVO> getEmpluseList(StationStatusVO statusVo) {
		List<BikeRentalVO> exeImpulseList;
		SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy-MM-dd");
		Calendar time = Calendar.getInstance();
		String to_dt = format1.format(time.getTime());

		time.add( Calendar.DATE, -3);	
		String from_dt = format1.format(time.getTime());
		 
		BikeRentalVO vo = new BikeRentalVO();
		vo.setSearchStartDate(from_dt);
		vo.setSearchEndDate(to_dt);
		vo.setCenterId(statusVo.getBatteryStusCd());		
		vo.setUsrSeq(statusVo.getParamSearchType());
		vo.setComptCd("0");
		vo.setFirstRecordIndex(0);
		// vo.setRecordCountPerPage(300);
		exeImpulseList = rentStatusService.getExeImpulseReturnList(vo);
		return exeImpulseList;
	}

	private List<BikeRentalVO> getexeImpulseList(StationVO statusVo) {
		List<BikeRentalVO> exeImpulseList;
		BikeRentalVO vo = new BikeRentalVO(); 

		SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy-MM-dd");
		Calendar time = Calendar.getInstance();
		String to_dt = format1.format(time.getTime());

		time.add( Calendar.DATE, -3);	
		String from_dt = format1.format(time.getTime());
		
		vo.setSearchStartDate( from_dt );
		vo.setSearchEndDate( to_dt );
		vo.setCenterId(statusVo.getParamCenterId());		
		vo.setUsrSeq(statusVo.getParamTeamSeq());
		vo.setComptCd("0");
		vo.setFirstRecordIndex(0);
		vo.setRecordCountPerPage(100);
		exeImpulseList = rentStatusService.getExeImpulseReturnList(vo);
		return exeImpulseList;
	}
	
	@RequestMapping(value="/getStationCurrentStatusAjaxNew.do")
	@RequestName("getStationCurrentStatusAjaxNew")
	public String getStationCurrentStatusAjaxNew(@ModelAttribute StationVO statusVo, ModelMap model, HttpServletRequest request) {
		
		boolean result = false;
		List<StationVO> stationList = null;
		List<BikeRentalVO> exeImpulseList = null; // 2020.01.31 강제반납 추가
		List<BikeVO> bikeLostList = null; // 2020.01.31 강제반납 추가
		UserSessionVO userSessionVO = null;

		try {
			userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
			if(userSessionVO != null ) result = true; 
		} catch (Exception e) {}
		
		if( result == false ) {
			model.addAttribute("result" , false);
			return JSONVIEW;
		}
        try {
        		// 대여소 정보
        		stationList  = stationStatusService.getStationStautsListNew(statusVo);						//검색조건 LIST 목록_JJH
        		 // 강반목록
    			exeImpulseList = getexeImpulseList(statusVo);
        		// 분실 조회 20200131 추가
        		bikeLostList = bikeService.getBikeLostLog();
        		
        		result = true;
			
		}catch(CfoodException e) {
			result = false;
        }
        
        model.addAttribute("result" , result);
		model.addAttribute("stationList" , stationList);
		model.addAttribute("condition" , statusVo);
		model.addAttribute("exeImpulseList" , exeImpulseList);
		//20200428
		model.addAttribute("bikeLostList" , bikeLostList);
		return result ?  JSONVIEW : ERROR_PAGE;
	}

	

	@RequestMapping(value="/getStationStautsListRound.do")
	@RequestName("getStationStautsListRound")
	public String getStationStautsListRound(@ModelAttribute StationVO statusVo, ModelMap model, HttpServletRequest request) {
		
		boolean result = false;
		List<StationVO> stationList = null;
		UserSessionVO userSessionVO = null;

		try {
			userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
			if(userSessionVO != null ) result = true; 
		} catch (Exception e) {}
		
		if( result == false ) {
			model.addAttribute("result" , false);
			return JSONVIEW;
		}
        try {
        		// 대여소 정보
        		stationList  = stationStatusService.getStationStautsListRound(statusVo);						//검색조건 LIST 목록_JJH
        		result = true;
			
		}catch(CfoodException e) {
			result = false;
        }
        
        model.addAttribute("result" , result);
		model.addAttribute("stationList" , stationList);
		model.addAttribute("condition" , statusVo);
		return result ?  JSONVIEW : ERROR_PAGE;
	}
	
	
	@RequestMapping(value="/getStationCurrentStatus.do")
	@RequestName("getStationCurrentStatus")
	public String getStationCurrentStatus(@ModelAttribute StationStatusVO statusVo, ModelMap model, HttpServletRequest request, UserMgmtVO usrVO) {
		
		String bizName = "대여소 현황 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		boolean result = false;
		StationStatusVO wholeStatusTotCnt = null;
		PaginationInfo paginationInfo = null;
		PaginationInfo paginationMobileInfo = null;
		List<StationStatusVO> stationList = null;
		
		List<BikeRentalVO> exeImpulseList = null; // 2020.01.31 강제반납 추가
		List<BikeVO> bikeLostList = null; // 2020.01.31 강제반납 추가
		
		UserSessionVO userSessionVO = null;
		
		try {
			userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
			if(userSessionVO == null){
	        	throw new CfoodException(getMessage("error.invalidSession"));
	        }
			usrVO.setUsrId(userSessionVO.getUsrId());
			UserMgmtVO usrInfo = usrService.getUsrInfo(usrVO);
			userSessionVO.setAssignStationGrpId(usrInfo.getAssignStationGrpId());
			statusVo.setStationGrpId(userSessionVO.getAssignStationGrpId());
			
		} catch (Exception e) {
			throw new CfoodException(getMessage("fail.common.msg"));
		}
		
		try {
			
        	wholeStatusTotCnt  = stationStatusService.getStationStatusTotCnt(IConstants.LANG_KR);	//대여소 현황목록_전체_JJH
        	
        	if ( "1".equals(userSessionVO.getUsrGrpCd()) 
        			|| statusVo.getParamSearchType() != null
        			|| statusVo.getParamSearchWord() != null
        			) {
    			
        		int sizeList = stationStatusService.getStationListCount(statusVo);						//검색조건 LIST 총 갯수_JJH
        		paginationInfo = getPagingInfo(statusVo.getCurrentPageNo(), sizeList);
        		paginationMobileInfo = getPagingMobileInfo(statusVo.getCurrentPageNo(), sizeList);
        		paginationInfo.setRecordCountPerPage(100);
        		paginationMobileInfo.setRecordCountPerPage(100);
        		if(statusVo.getRecordCountPerPage() > 5) {
        			paginationInfo.setRecordCountPerPage(statusVo.getRecordCountPerPage());
        			paginationMobileInfo.setRecordCountPerPage(statusVo.getRecordCountPerPage());
        		}
        		statusVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
        		statusVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());	
        		
        		stationList  = stationStatusService.getStationStautsList(statusVo);						//검색조건 LIST 목록_JJH
        		
        		// 강반 내역 조회 20200131 추가
        		if( statusVo.getBatteryStusCd() != null ) {
        			exeImpulseList = getEmpluseList(statusVo);
        		}
        		
        		// 분실 조회 20200131 추가
        		if( statusVo.getBatteryStusCd() != null ) {
        			bikeLostList = bikeService.getBikeLostLog();
        		}
        		
        	}
        	
			result = true;
			
		}catch(CfoodException e) {
        	throw new CfoodException("fail.common.msg", e.getMessage());
        }
        
        // 20200812 센터 , 팀정보 세팅
//        String centerId = "";
//        String teamSeq = "";
//        if("N".equals(statusVo.getDefaultTeamYn())){// 2020-11-25 : 사용자가 센터 변경했는지 확인 절차 추가
//        	
//        	centerId = statusVo.getBatteryStusCd() != null ? statusVo.getBatteryStusCd() : "";
//        	teamSeq  = statusVo.getParamSearchType() != null ? statusVo.getParamSearchType() : "";
//        
//        }else{
//        	
//	        if ( userSessionVO.getTeamSeq() != null && !"".equals(userSessionVO.getTeamSeq()) && !"0".equals(userSessionVO.getTeamSeq()) ) {
//	        	TeamMgmtVO teamVo = new TeamMgmtVO();
//	        	 teamVo.setTeamSeq( userSessionVO.getTeamSeq() );
//	        	 TeamMgmtVO resultMap;
//				try {
//					resultMap = teamService.getTeamInfo( teamVo );
//					centerId = resultMap != null ? ( resultMap.getCenterId() != null  ? resultMap.getCenterId() : "" ) : "";
//					teamSeq  = userSessionVO.getTeamSeq();
//				} catch (Exception e) {
//					// TODO Auto-generated catch block
//					e.printStackTrace();
//				}
//	        	
//	        }
//        	
//        }
		model.addAttribute("wholeStatusTot" , wholeStatusTotCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("paginationMobileInfo",paginationMobileInfo);
		model.addAttribute("stationList" , stationList);
		model.addAttribute("condition" , statusVo);
		
		model.addAttribute("exeImpulseList" , exeImpulseList);
		//20200428
		model.addAttribute("bikeLostList" , bikeLostList);
		
		// 20200812
//		model.addAttribute("centerId" , centerId);
//		model.addAttribute("teamSeq" , teamSeq);
		
		model.addAttribute("naverMapApiKey",super.propertiesService.getString("naverMapApiKey"));
		
		return result ? RETURN_URL.concat("pre_sta_state") : ERROR_PAGE;
	}
 
	
	
	@RequestMapping(value="/getStationStautsList.do")
	@RequestName("getStationStautsList")             
	public String getStationStautsList(@ModelAttribute StationStatusVO mapVo, ModelMap model, HttpServletRequest request) {
		String bizName = "대여소 현황 화면의 목록";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		List<StationStatusVO> stationList = null;
		boolean result = false;
        try {
        	mapVo.setPageYn("N");
        	stationList  = stationStatusService.getStationStautsList(mapVo);//
        	result = true;
		}catch(CfoodException e) {
        	throw new CfoodException(getMessage("fail.common.msg"));
        }
     
        model.addAttribute("result" , result);
        model.addAttribute("stationList" , stationList);
		return JSONVIEW;
	}
	@RequestMapping(value="/moveCurrentStationDetail.do")
	@RequestName("moveCurrentStationDetail")
	public String moveCurrentStationDetail(@ModelAttribute @Valid StationStatusVO mapVo, BindingResult bResult, ModelMap model, HttpServletRequest request) {
		String bizName = "대여소 현황 화면의 목록";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        
        if(bResult.hasErrors()) {
        	for(ObjectError error : bResult.getAllErrors()) {
        		return ERROR_PAGE;
        	}
        } else {
        	model.addAttribute("stationId" , mapVo.getStationId());
        }
        
		
		try {
			userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
			if(userSessionVO == null){
	        	throw new CfoodException(getMessage("error.invalidSession"));
	        }
		} catch (Exception e) {
			throw new CfoodException(getMessage("fail.common.msg"));
		}
		 
		model.addAttribute( "adminSeq" , userSessionVO.getAdminSeq() );
        
        return RETURN_URL.concat("pre_sta_detail");
	}
	
	@RequestMapping(value="/getCurrentStationDetail.do")
	@RequestName("getCurrentStationDetail")
	public String getCurrentStationDetail(@ModelAttribute @Valid StationStatusVO mapVo, BindingResult bResult, ModelMap model, HttpServletRequest request) {
		
		String bizName = "대여소 현황 화면의 목록";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        StationStatusVO stationInfo = null;
        BeaconVO vo = new BeaconVO();
		boolean result = false;
		try {
			 if(bResult.hasErrors()) {
		        for(ObjectError error : bResult.getAllErrors()) {
		        	return ERROR_PAGE;
		        }
		    } else {
				stationInfo  = stationStatusService.getCurrentStationDetail(mapVo);//
				if(stationInfo != null ) {
					stationInfo.setApInfo(stationStatusService.getStationApList(mapVo));
					stationInfo.setBikeList(stationStatusService.getStationBikeList(mapVo));
					stationInfo.setArmList(stationStatusService.getStationArmList(mapVo));
					stationInfo.setArmInfo(stationStatusService.getStationRackTotInfo(mapVo));
					vo.setStationId(mapVo.getStationId());
					vo.setPagingYn("N");
					stationInfo.setBeaconList(beaconService.getBeaconList(vo));
				}
				
		        result = true;
		    }
		}catch(CfoodException e) {
	        throw new CfoodException(getMessage("fail.common.msg"));
	    }catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		log.debug("##### StationStatusController ==> " + stationInfo);
		model.addAttribute(RESULT, result);
		model.addAttribute("stationInfo", stationInfo);
		return JSONVIEW;
	}
	
	@RequestMapping(value="/getStationRealStatus.do")
	@RequestName("getStationRealStatus")
	public String getStationRealStatus(@ModelAttribute StationStatusVO statusVo, ModelMap model, HttpServletRequest request) {
		
		String bizName = "실시간현황관리";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		boolean result = false;
		StationStatusVO realStatusVo = null;		// 실시간 매출현황, 홈화면 가입현황, 자전거 재고현황

		List<StationStatusVO> stationList = null;	// 상하위 대여소
		List<StationStatusVO> stationList2 = null;	// 전체 및 지역별 이용건수
		List<StationStatusVO> stationList3 = null;	// 지역별 배치현황
		List<StationStatusVO> stationList4 = null;	// 운영중 자전거
		
		List<StationStatusVO> stationList5 = null;	// 공지사항 최신항목(5개)
		
        try {
        	
        	Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowDay = sdf.format(cal.getTime());

			statusVo.setSearchDate(nowDay);

        	
        	log.debug("###### getStationCurrentStatus ###### =>" + statusVo.toString());
        	
        	realStatusVo  = stationStatusService.getRealStation(statusVo);			//실시간 매출현황, 홈화면 가입현황, 자전거 재고현황_cms_20161125
		
        	stationList  = stationStatusService.getRealStationList(statusVo);		//상하위 대여소_cms_20161125
			stationList2  = stationStatusService.getRealStationList2(statusVo);		//전체 및 지역별 이용건수_cms_20161125
			stationList3  = stationStatusService.getRealStationList3(statusVo);			//지역별 배치현황_cms_20161125
			stationList4  = stationStatusService.getRealBikeList(statusVo);			//운영중 자전거_cms_20161128
			
			stationList5  = stationStatusService.getNoticeList(statusVo);			//공지사항 최신항목 5개 _cms_20161219
			
        	result = true;
		}catch(CfoodException e) {
        	throw new CfoodException(getMessage("fail.common.msg"));
        }
		model.addAttribute("realStatusVo"  , realStatusVo);
		model.addAttribute("stationList"   , stationList);
		model.addAttribute("stationList2"  , stationList2);
		model.addAttribute("stationList3"  , stationList3);
		model.addAttribute("stationList4"  , stationList4);
		model.addAttribute("stationList5"  , stationList5);
		
		return result ? RETURN_URL.concat("pre_real_state") : ERROR_PAGE;
	}
	
	@RequestMapping(value="/getStationCurrentList.do")
	@RequestName("getStationCurrentList")
	public String getStationCurrentList(@ModelAttribute StationStatusVO statusVo, ModelMap model, HttpServletRequest request) {
		
		String bizName = "대여소 목록 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		boolean result = false;
		PaginationInfo paginationInfo = null;
		PaginationInfo paginationMobileInfo = null;
		List<StationStatusVO> stationList = null;
        try {
        	
        	log.debug("###### getStationCurrentStatus ###### =>" + statusVo.toString());
        	
        	
//			임시***** 그룹코드가 값이 없으면 null값을 넣어준다
    		if(statusVo.getStationGrpSeq() == "") {
    			statusVo.setStationGrpSeq(null);
    		}
    		// ++ batteryStusCd가 null이면 조회가 안됨.... 그냥 빈값 넣어줌
    		if(statusVo.getBatteryStusCd() == null){
    			statusVo.setBatteryStusCd("");
    		}
    		//
        	
        	int sizeList = stationStatusService.getStationListCount(statusVo);						//검색조건 LIST 총 갯수_JJH
			paginationInfo = getPagingInfo(statusVo.getCurrentPageNo(), sizeList);
			paginationMobileInfo = getPagingMobileInfo(statusVo.getCurrentPageNo(), sizeList);
			paginationInfo.setRecordCountPerPage(10);
        	paginationMobileInfo.setRecordCountPerPage(10);
        	if(statusVo.getRecordCountPerPage() > 5) {
        		paginationInfo.setRecordCountPerPage(statusVo.getRecordCountPerPage());
        		paginationMobileInfo.setRecordCountPerPage(statusVo.getRecordCountPerPage());
        	}
			statusVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			statusVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());			
			stationList  = stationStatusService.getStationStautsList(statusVo);						//검색조건 LIST 목록_JJH
        	result = true;
		}catch(CfoodException e) {
        	throw new CfoodException(getMessage("fail.common.msg"));
        }
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("paginationMobileInfo",paginationMobileInfo);
		model.addAttribute("stationList" , stationList);
		model.addAttribute("condition" , statusVo);
		model.addAttribute("naverMapApiKey",super.propertiesService.getString("naverMapApiKey"));
		
		return result ? RETURN_URL.concat("pre_sta_list") : ERROR_PAGE;
	}
	
	@RequestMapping(value="/getMissingBikeList.do")
	@RequestName("getMissingBikeList")
	public String getMissingBikeList(@ModelAttribute StationStatusVO statusVo, ModelMap model, HttpServletRequest request) {
		String bizName = "자전거 위치조회 목록 화면";
		//boolean result = false;
		boolean result = true;
		
		return result ? RETURN_URL.concat("pre_misBik_list") : ERROR_PAGE;
	}
	
	@RequestMapping(value="/getQrLostStatus.do")
	@RequestName("getQrLostStatus")
	public String getQrLostStatus(@ModelAttribute StationStatusVO statusVo, ModelMap model, HttpServletRequest request) {
		
		String bizName = "대여소 현황 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		boolean result = false;
		StationStatusVO wholeStatusTotCnt = null;
		PaginationInfo paginationInfo = null;
		PaginationInfo paginationMobileInfo = null;
		List<StationStatusVO> stationList = null;
		
		List<BikeRentalVO> exeImpulseList = null; // 2020.01.31 강제반납 추가
		List<BikeVO> bikeLostList = null; // 2020.01.31 강제반납 추가
		
		UserSessionVO userSessionVO = null;
		
		try {
			userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
			if(userSessionVO == null){
	        	throw new CfoodException(getMessage("error.invalidSession"));
	        }
		} catch (Exception e) {
			throw new CfoodException(getMessage("fail.common.msg"));
		}
		
        try {
        	wholeStatusTotCnt  = stationStatusService.getStationStatusTotCnt(IConstants.LANG_KR);	//대여소 현황목록_전체_JJH
        		
    		int sizeList = stationStatusService.getStationListCount(statusVo);						//검색조건 LIST 총 갯수_JJH
    		paginationInfo = getPagingInfo(statusVo.getCurrentPageNo(), sizeList);
    		paginationMobileInfo = getPagingMobileInfo(statusVo.getCurrentPageNo(), sizeList);
    		paginationInfo.setRecordCountPerPage(100);
    		paginationMobileInfo.setRecordCountPerPage(100);
    		if(statusVo.getRecordCountPerPage() > 5) {
    			paginationInfo.setRecordCountPerPage(statusVo.getRecordCountPerPage());
    			paginationMobileInfo.setRecordCountPerPage(statusVo.getRecordCountPerPage());
    		}
    		statusVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
    		statusVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());			
    		stationList  = stationStatusService.getStationStautsList(statusVo);						//검색조건 LIST 목록_JJH
    		
			SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy-MM-dd");
			Calendar time = Calendar.getInstance();
			String to_dt = format1.format(time.getTime());

			time.add( Calendar.DATE, -3);	
			String from_dt = format1.format(time.getTime());
			
			BikeRentalVO vo = new BikeRentalVO();
			vo.setSearchStartDate(from_dt);
			vo.setSearchEndDate(to_dt);
			vo.setCenterId(statusVo.getBatteryStusCd());		
			vo.setUsrSeq(statusVo.getParamSearchType());
			vo.setComptCd("0");
			vo.setFirstRecordIndex(0);
			vo.setRecordCountPerPage(50);
			exeImpulseList = rentStatusService.getExeImpulseReturnList(vo);

			bikeLostList = bikeService.getBikeLostLog();

        	
			result = true;
			
		}catch(CfoodException e) {
        	throw new CfoodException(getMessage("fail.common.msg"));
        }
        
		model.addAttribute("wholeStatusTot" , wholeStatusTotCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("paginationMobileInfo",paginationMobileInfo);
		model.addAttribute("stationList" , stationList);
		model.addAttribute("condition" , statusVo);
		
		model.addAttribute("exeImpulseList" , exeImpulseList);
		//20200428
		model.addAttribute("bikeLostList" , bikeLostList);
		
		model.addAttribute("naverMapApiKey",super.propertiesService.getString("naverMapApiKey"));
		return result ? RETURN_URL.concat("pre_qr_lost_state") : ERROR_PAGE;
	}
}
