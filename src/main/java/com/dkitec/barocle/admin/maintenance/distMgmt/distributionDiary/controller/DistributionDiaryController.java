package com.dkitec.barocle.admin.maintenance.distMgmt.distributionDiary.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.admin.login.vo.UserSessionVO;
import com.dkitec.barocle.admin.maintenance.distMgmt.distributionDiary.service.DistributionDiaryService;
import com.dkitec.barocle.admin.maintenance.distMgmt.distributionDiary.vo.DistCoWorkDtlVO;
import com.dkitec.barocle.admin.maintenance.distMgmt.distributionDiary.vo.DistCoWorkVO;
import com.dkitec.barocle.admin.maintenance.distMgmt.distributionDiary.vo.DistWorkVO;
import com.dkitec.barocle.admin.maintenance.distMgmt.distributionDiary.vo.DistributionDiaryVO;
import com.dkitec.barocle.admin.manage.deviceMgmt.bike.service.BikeService;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.DateUtil;
import com.dkitec.barocle.util.webutil.HttpUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@Controller
@RequestCategory("DistributionDiaryController")
public class DistributionDiaryController extends BaseController {
	protected static Logger log = LoggerFactory.getLogger(DistributionDiaryController.class);
	private static final String RETURN_URL = "/admin/maintenance/distMgmt/distributionDiary/";
	
	@Resource(name="distributionDiaryService") private DistributionDiaryService distributionDiaryService;
	@Resource(name="bikeService") private BikeService bikeService;	
	
	@RequestMapping("/viewDistributionDiary.do")
	@RequestName("viewDistributionDiary")
	public String viewDistributionDiary(@ModelAttribute DistributionDiaryVO distributionDiaryVo, ModelMap model, HttpServletRequest request) {
		
		String bizName = "분배일지 화면 이동";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        boolean result = false;
        String resultPage = RETURN_URL.concat("dist_diary_detail");
        UserSessionVO userSessionVO = null;
        
		try {
			userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
        
		try {
			
				if(distributionDiaryVo.getSearchDate() == null || "".equals(distributionDiaryVo.getSearchDate())){
				
					String todayDate = DateUtil.getSystemDate("yyyy-MM-dd");
					
					distributionDiaryVo.setSearchDate(todayDate);
					
				}else{
					
					if(distributionDiaryVo.getModifyDate() != 0){
					
						String modifyDate = distributionDiaryService.getModifyDate(distributionDiaryVo);
						
						distributionDiaryVo.setSearchDate(modifyDate);
					}
					
				}
				
				if(distributionDiaryVo.getAdminId() == null || "".equals(distributionDiaryVo.getAdminId())){
					
					distributionDiaryVo.setAdminId(userSessionVO.getUsrId());
				}
				
			model.addAttribute("searchCondition", distributionDiaryVo);
			
			result = true;
		} catch (Exception e) {
			throw new CfoodException("admin.maintenance.distMgmt.distributionDiary.viewDistributionDiary",e.getMessage());
		}
		
		return result ? resultPage : ERROR_PAGE;
	}
	
	@RequestMapping("/getDistributionDiaryAjax.do")
	@RequestName("getDistributionDiaryAjax")
	public String getDistributionDiaryAjax(@ModelAttribute DistributionDiaryVO distributionDiaryVo, ModelMap model, HttpServletRequest request) {
		
		String bizName = "분배일지 조회";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		boolean result = false;
		UserSessionVO userSessionVO = null;
		
		try {
			userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		try {
			
			if(distributionDiaryVo.getSearchDate() == null || "".equals(distributionDiaryVo.getSearchDate())){
				
				String todayDate = DateUtil.getSystemDate("yyyy-MM-dd");
				
				distributionDiaryVo.setSearchDate(todayDate);
			}else{
				
				if(distributionDiaryVo.getModifyDate() != 0){
					distributionDiaryVo.setSearchDate(distributionDiaryService.getModifyDate(distributionDiaryVo));
				}
				
			}
			
			if(distributionDiaryVo.getAdminId() == null || "".equals(distributionDiaryVo.getAdminId())){
				
				distributionDiaryVo.setAdminId(userSessionVO.getUsrId());
			}
		 
			// 차량번호 조회
			model.addAttribute("distInfoVclList", distributionDiaryService.getDairyVcle(distributionDiaryVo));
			
			List<DistributionDiaryVO> distList = distributionDiaryService.getDairyReport(distributionDiaryVo);
			
			model.addAttribute("distInfo", distributionDiaryService.getDistInfo(distributionDiaryVo));
			
			model.addAttribute("distList", distList);
			
			model.addAttribute("searchCondition", distributionDiaryVo);
			
			result = true;
		} catch (Exception e) {
			result = false;
			throw new CfoodException("admin.maintenance.distMgmt.distributionDiary.getDistributionDiary",e.getMessage());
		}
		
		return JSONVIEW;
	}
	
	@RequestMapping("/setDaiaryBikeStatusAjax.do")
	@RequestName("setDaiaryBikeStatusAjax")
	public String setDaiaryBikeStatusAjax(@ModelAttribute DistributionDiaryVO vo, ModelMap model, HttpServletRequest request) {
		
		String bizName = "자전거 등록";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		boolean result = false;
		UserSessionVO userSessionVO = null;
		
		String resultMessage = "";
		
		try {
			userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
			
			// 관리자 id 설정
			vo.setAdminId(userSessionVO.getUsrId());
			
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
			resultMessage ="로그인 정보가 미존재합니다.";
			result = false;
		}
		
		// 분배원, 분배직원만 등록
		switch ( userSessionVO.getUsrGrpCd() ) {
		case "5" :	// 
		case "11" :	// 분배반장
		case "12" :	// 관리운영그룹
			break;
		default :
			model.addAttribute("result", true);
			model.addAttribute("resultMessage", resultMessage);
			return JSONVIEW;
		
		}
		
		result = true;
		resultMessage = distributionDiaryService.setDaiaryBikeStatus(vo);
		
		model.addAttribute("result", result);
		model.addAttribute("resultMessage", resultMessage);
		
		return JSONVIEW;
	}	
	
	@RequestMapping(value = "/distributionDiary/getStaMemList.do")
	@RequestName("getStaMemList")
	public String getStaMemList(@ModelAttribute @Valid DistributionDiaryVO vo, HttpServletRequest request,ModelMap model) throws Exception {
		String targetUrl = RETURN_URL.concat("dist_sta_mem_list");
		String bizName = "분배원 실적 조회";
		HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력
		boolean result = true;
		
		try {
			userSessionVO = (UserSessionVO) EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
		} catch (CfoodException e) {
			throw new CfoodException("admin.maintenance.distMgmt.distributionDiary.getDistributionDiary" , e.getMessage());
		}
		
		try {
			
				
			if(vo.getViewFlg().equals(MODE_EXCEL)) targetUrl = RETURN_URL.concat("dist_sta_mem_list_excel");
			
			if(vo.getSearchBgnDe() == null && vo.getSearchEndDe() == null){
				
				vo.setSearchEndDe(DateUtil.getSystemDate("yyyy-MM-dd"));
				vo.setSearchBgnDe(DateUtil.getSystemDate("yyyy-MM-dd"));
			}
			
			// 합계만 표출 추가(2022.01.14)
			if ( vo.getEtc() == null || "".equals(vo.getEtc()) || "1".equals(vo.getEtc()) || "true".equals(vo.getEtc()) ){
				vo.setEtc("1");
			} else {
				vo.setEtc("0");
			}
			
			switch ( userSessionVO.getUsrGrpCd() ) {
			// 분배직원
			case "5" :
				vo.setAdminId( userSessionVO.getUsrId() );
				vo.setCenterName( userSessionVO.getUsrId() );
			break;
			
			// 분배반장
			case "11" :
				vo.setCenterName( userSessionVO.getUsrId());
			break;	
			}
			
			List<DistributionDiaryVO> dsList = distributionDiaryService.getStaMemList(vo);
			
			model.addAttribute("usrGprCd", userSessionVO.getUsrGrpCd() );
			model.addAttribute("searchCondition", vo);
			model.addAttribute("dsList", dsList);
			result = true;
		} catch (CfoodException e) {
			throw new CfoodException("admin.maintenance.distMgmt.distributionDiary.getDistributionDiary" , e.getMessage());
		}
		
		return result ? targetUrl : ERROR_PAGE;
	}
	
	@RequestMapping(value = "/distributionDiary/getStaCenterList.do")
	@RequestName("getStaCenterList")
	public String getStaCenterList(@ModelAttribute DistributionDiaryVO vo, HttpServletRequest request,ModelMap model) throws Exception {
		
		String targetUrl = RETURN_URL.concat("center_status_list");
		String bizName = "분배원 센터 실적 조회";
		HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력
		boolean result = true;
		
		try {
			userSessionVO = (UserSessionVO) EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
		} catch (CfoodException e) {
			throw new CfoodException("admin.maintenance.distMgmt.distributionDiary.getDistributionDiary" , e.getMessage());
		}
		
		try {
				
			if(vo.getViewFlg().equals(MODE_EXCEL)) targetUrl = RETURN_URL.concat("center_status_list_excel");
			
			if(vo.getSearchBgnDe() == null && vo.getSearchEndDe() == null){
				
				vo.setSearchEndDe(DateUtil.getSystemDate("yyyy-MM-dd"));
				vo.setSearchBgnDe(DateUtil.getSystemDate("yyyy-MM-dd"));
			}
			
			if(vo.getSearchBgnDe() != null && vo.getSearchEndDe() == null){
				vo.setSearchEndDe(vo.getSearchBgnDe());
			}
			
			switch ( userSessionVO.getUsrGrpCd() ) {
			// 분배직원
			case "5" :
				vo.setCenterName( userSessionVO.getUsrId() );
			break;
			
			// 분배반장
			case "11" :
				vo.setCenterName( userSessionVO.getUsrId());
			break;	
			}
			
			
			List<DistributionDiaryVO> dsList = distributionDiaryService.getStaCenterList(vo);
			
			List<DistributionDiaryVO> dsOfficeList = setOfficeList(dsList);
		    String weather = "";
			if( dsList.size() > 0 ) {
				weather = dsList.get(0).getWeather();
			}
			model.addAttribute("weather", weather);
		    model.addAttribute("dsOfficeList", dsOfficeList);
			model.addAttribute("searchCondition", vo);
			model.addAttribute("dsList", dsList);
			result = true;
		} catch (CfoodException e) {
			throw new CfoodException("admin.maintenance.distMgmt.distributionDiary.getStaCenterList" , e.getMessage());
		}
		
		return result ? targetUrl : ERROR_PAGE;
	}
	
	/*
	 * 통계내역
	 */
	private List<DistributionDiaryVO> setOfficeList(List<DistributionDiaryVO> dsList) {
		
		int bikeMoveCnt = 0;
		int bikeReplaceCnt = 0;
		int adminCnt = 0;
		int warehousingCnt = 0;
		int darTp006Cnt = 0;
		
		int bikeMoveCnt_1 = 0;
		int bikeReplaceCnt_1 = 0;
		int adminCnt_1 = 0;
		int warehousingCnt_1 = 0;
		int darTp006Cnt_1 = 0;
		
		int bikeMoveCnt_2 = 0;
		int bikeReplaceCnt_2 = 0;
		int adminCnt_2 = 0;
		int warehousingCnt_2 = 0;
		int darTp006Cnt_2 = 0;
		 
		for( DistributionDiaryVO dsVO : dsList ) {
		
			// 통계내역으로 설정
		if( !"TEAM_000".equals( dsVO.getTeamSeq())) continue;
		
		switch ( dsVO.getOfficeName() ) {
		
					case "강북관리소" :
						
						bikeMoveCnt    += Integer.parseInt( dsVO.getBikeMoveCnt());
						bikeReplaceCnt += Integer.parseInt( dsVO.getBikeReplaceCnt());
						adminCnt       += Integer.parseInt( dsVO.getEtc());
						warehousingCnt += Integer.parseInt( dsVO.getWarehousingCnt());
						darTp006Cnt    += Integer.parseInt( dsVO.getDarTp006Cnt());
						
						break;
						
					case "강남관리소" :
								
								bikeMoveCnt_1    += Integer.parseInt( dsVO.getBikeMoveCnt());
								bikeReplaceCnt_1 += Integer.parseInt( dsVO.getBikeReplaceCnt());
								adminCnt_1       += Integer.parseInt( dsVO.getEtc());
								warehousingCnt_1 += Integer.parseInt( dsVO.getWarehousingCnt());
								darTp006Cnt_1    += Integer.parseInt( dsVO.getDarTp006Cnt());
								break;
					default :
								bikeMoveCnt_2    += Integer.parseInt( dsVO.getBikeMoveCnt());
								bikeReplaceCnt_2 += Integer.parseInt( dsVO.getBikeReplaceCnt());
								adminCnt_2       += Integer.parseInt( dsVO.getEtc());
								warehousingCnt_2 += Integer.parseInt( dsVO.getWarehousingCnt());
								darTp006Cnt_2    += Integer.parseInt( dsVO.getDarTp006Cnt());
					break;				
				}
		}
		
		List<DistributionDiaryVO> dsOfficeList = new ArrayList<>();
		DistributionDiaryVO dsOfficeMap    = new DistributionDiaryVO();
		dsOfficeMap.setOfficeName("강북관리소");
		dsOfficeMap.setBikeMoveCnt(""+ bikeMoveCnt);
		dsOfficeMap.setBikeReplaceCnt(""+ bikeReplaceCnt);
		dsOfficeMap.setEtc(""+ adminCnt);
		dsOfficeMap.setWarehousingCnt(""+ warehousingCnt);
		dsOfficeMap.setDarTp006Cnt(""+ darTp006Cnt);
		
		dsOfficeList.add(dsOfficeMap);
		
		dsOfficeMap    = new DistributionDiaryVO();
		dsOfficeMap.setOfficeName("강남관리소");
		dsOfficeMap.setBikeMoveCnt(""+ bikeMoveCnt_1);
		dsOfficeMap.setBikeReplaceCnt(""+ bikeReplaceCnt_1);
		dsOfficeMap.setEtc(""+ adminCnt_1);
		dsOfficeMap.setWarehousingCnt(""+ warehousingCnt_1);
		dsOfficeMap.setDarTp006Cnt(""+ darTp006Cnt_1);
		
		dsOfficeList.add(dsOfficeMap);
		
		dsOfficeMap    = new DistributionDiaryVO();
		dsOfficeMap.setOfficeName("기타");
		dsOfficeMap.setBikeMoveCnt(""+ bikeMoveCnt_2);
		dsOfficeMap.setBikeReplaceCnt(""+ bikeReplaceCnt_2);
		dsOfficeMap.setEtc(""+ adminCnt_2);
		dsOfficeMap.setWarehousingCnt(""+ warehousingCnt_2);
		dsOfficeMap.setDarTp006Cnt(""+ darTp006Cnt_2);
		
		dsOfficeList.add(dsOfficeMap);
		
		dsOfficeMap    = new DistributionDiaryVO();
		dsOfficeMap.setOfficeName("합계");
		dsOfficeMap.setBikeMoveCnt   (bikeMoveCnt + bikeMoveCnt_1 + bikeMoveCnt_2 + "");
		dsOfficeMap.setBikeReplaceCnt(bikeReplaceCnt + bikeReplaceCnt_1 + bikeReplaceCnt_2 + "");
		dsOfficeMap.setEtc(adminCnt + adminCnt_1+ adminCnt_2 +"");
		dsOfficeMap.setWarehousingCnt(warehousingCnt + warehousingCnt_1 + warehousingCnt_2 + "");
		dsOfficeMap.setDarTp006Cnt(darTp006Cnt + darTp006Cnt_1 + darTp006Cnt_2 +"");
		
		dsOfficeList.add(dsOfficeMap);
		return dsOfficeList;
	}
	
	
	
	@RequestMapping(value = "/distributionDiary/getMainWorkAjax.do")
	@RequestName("getMainWorkAjax")
	public String getMainWorkAjax(@ModelAttribute @Valid DistWorkVO distWorkVO, HttpServletRequest request,ModelMap model) throws Exception {
		String bizName = "메인화면 분배직원 당일 근태조회";
		HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력
		
		String todayDate = DateUtil.getSystemDate("yyyy-MM-dd");
		try {
			
			distWorkVO.setSearchEndDe(todayDate);
			distWorkVO.setSearchBgnDe(todayDate);
			DistWorkVO workVO = distributionDiaryService.getMaintenWrkerAttD(distWorkVO);
			model.addAttribute("workVO", workVO);
			
			model.addAttribute("isSuccess", "1");
		} catch (CfoodException e) {
		
			model.addAttribute("isSuccess", "0");
			// throw new CfoodException("admin.distMgmt.distributionDiary.getMainWork" , e.getMessage());
		}
		
		
		return JSONVIEW;
	}
	
	
	@RequestMapping(value = "/distributionDiary/updateDistWorkAjax.do")
	@RequestName("updateDistWorkAjax")
	public String updateDistWorkAjax(@ModelAttribute @Valid DistWorkVO distWorkVO, HttpServletRequest request,ModelMap model) throws Exception {
		String bizName = "분배직원 근태수정";
		HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력
		
		String todayDate = DateUtil.getSystemDate("yyyy-MM-dd");
		
		try {
			
			distWorkVO.setWorkDate(todayDate);
			distWorkVO.setModId(distWorkVO.getAdminId());
			
			Date dt = new Date();
			SimpleDateFormat sDate = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			distWorkVO.setModDttm(sDate.format(dt));
			
			distributionDiaryService.updateDistWork(distWorkVO);
			model.addAttribute("isSuccess", "1");
			
		} catch (CfoodException e) {
			
			model.addAttribute("isSuccess", "0");
			
			// throw new CfoodException("admin.distMgmt.distributionDiary.updateDistWork" , e.getMessage());
		}
		
		return JSONVIEW;
	}
	
	@RequestMapping(value = "/distributionDiary/insertDistWorkAjax.do")
	@RequestName("insertDistWorkAjax")
	public String insertDistWorkAjax(@ModelAttribute @Valid DistWorkVO distWorkVO, HttpServletRequest request,ModelMap model) throws Exception {
		String bizName = "분배직원 근태입력";
		HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력
		
		String todayDate = DateUtil.getSystemDate("yyyy-MM-dd");
		
		try {
			
			distWorkVO.setWorkDate(todayDate);
			distWorkVO.setRegId(distWorkVO.getAdminId());
			 
			Date dt = new Date();
			SimpleDateFormat sDate = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			distWorkVO.setRegDttm(sDate.format(dt));
			
			distributionDiaryService.insertDistWork(distWorkVO);
			model.addAttribute("isSuccess", "1");
		} catch (CfoodException e) {
		//	throw new CfoodException("admin.distMgmt.distributionDiary.insertDistWork" , e.getMessage());
			model.addAttribute("isSuccess", "0");
		}
		
		return JSONVIEW;
	}
	@RequestMapping(value = "/distributionDiary/updateDistWorkAprvdAjax.do")
	@RequestName("updateDistWorkAprvdAjax")
	public String updateDistWorkAprvdAjax(@ModelAttribute @Valid DistWorkVO distWorkVO, HttpServletRequest request,ModelMap model) throws Exception {
		String bizName = "분배직원 근태 승인 처리";
		HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력
		
		try {
			
			distributionDiaryService.updateDistWorkAprvd(distWorkVO);
			model.addAttribute("isSuccess", "1");
			
		} catch (CfoodException e) {
		//throw new CfoodException("admin.distMgmt.distributionDiary.updateDistWorkAprvd" , e.getMessage());
		
			model.addAttribute("isSuccess", "0");
		}
		
		return JSONVIEW;
	}
	
	@RequestMapping(value = "/distributionDiary/getDistWork.do")
	@RequestName("getDistWork")
	public String getDistWork(@ModelAttribute @Valid DistWorkVO distWorkVO, HttpServletRequest request,ModelMap model) throws Exception {
		String targetUrl = RETURN_URL.concat("dist_work_list");
		String bizName = "분배직원 근태 정보 조회";
		HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력
		
		boolean result = false;
		
		try {
			
			if(distWorkVO.getViewFlg().equals(MODE_EXCEL) || "N".equals(distWorkVO.getSearchAprd())){//미승인 목록은 페이징처리 하지 말라는 요구사항
				if(distWorkVO.getViewFlg().equals(MODE_EXCEL)){
					targetUrl = RETURN_URL.concat("dist_work_list_excel");
					//엑셀에선 사업소 검색값을 센터아이디가 아닌 센터명으로 변환.
					// distWorkVO.setSearchCenter(distributionDiaryService.getCenterNameWithCenterCode(distWorkVO));
				}
				distWorkVO.setPagingYn("N");
			}else{
				distWorkVO.setPagingYn("Y");
			}
			
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			
			if(distWorkVO.getSearchBgnDe() == null && distWorkVO.getSearchEndDe() == null){
				distWorkVO.setSearchEndDe(sdf.format(cal.getTime()));
				distWorkVO.setSearchBgnDe(sdf.format(cal.getTime()));
			}
			
			if(distWorkVO.getAdminId() == null){
				userSessionVO = (UserSessionVO) EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
				distWorkVO.setAdminId(userSessionVO.getUsrId());
			}
			
			distWorkVO.setAdminGrpName(distributionDiaryService.getAdminGrpName(distWorkVO));
			
			if("분배반장".equals(distWorkVO.getAdminGrpName()) && distWorkVO.getCenterId() == null){
				distWorkVO.setCenterId(distributionDiaryService.getInsertWrkCenterId(distWorkVO));
			}
			
			int totCnt = distributionDiaryService.getMaintenWrkerAttCnt(distWorkVO);
			PaginationInfo paginationInfo = getPagingInfo(distWorkVO.getCurrentPageNo(), totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(distWorkVO.getCurrentPageNo(), totCnt);
			
			distWorkVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			distWorkVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<DistWorkVO> workList = distributionDiaryService.getMaintenWrkerAtt(distWorkVO);
			
			model.addAttribute("searchCondition", distWorkVO);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("workList", workList);
			result = true;
		} catch (CfoodException e) {
			throw new CfoodException("admin.distMgmt.distributionDiary.getDistWork" , e.getMessage());
		}
		
		return result ? targetUrl : ERROR_PAGE;
	}
	
	@RequestMapping(value = "/distributionDiary/getDistRoundWork.do")
	@RequestName("getDistWork")
	public String getDistRoundWork(@ModelAttribute @Valid DistWorkVO distWorkVO, HttpServletRequest request,ModelMap model) throws Exception {
		String targetUrl = RETURN_URL.concat("round_work_list");
		String bizName = "순회 정비직원 근태 정보 조회";
		HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력
		
		boolean result = false;
		
		try {
			
			if(distWorkVO.getViewFlg().equals(MODE_EXCEL) || "N".equals(distWorkVO.getSearchAprd())){//미승인 목록은 페이징처리 하지 말라는 요구사항
				if(distWorkVO.getViewFlg().equals(MODE_EXCEL)){
					targetUrl = RETURN_URL.concat("round_work_list_excel");
					//엑셀에선 사업소 검색값을 센터아이디가 아닌 센터명으로 변환.
					// distWorkVO.setSearchCenter(distributionDiaryService.getCenterNameWithCenterCode(distWorkVO));
				}
				distWorkVO.setPagingYn("N");
			}else{
				distWorkVO.setPagingYn("Y");
			}
			
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			
			if(distWorkVO.getSearchBgnDe() == null && distWorkVO.getSearchEndDe() == null){
				distWorkVO.setSearchEndDe(sdf.format(cal.getTime()));
				distWorkVO.setSearchBgnDe(sdf.format(cal.getTime()));
			}
			
			if(distWorkVO.getAdminId() == null){
				userSessionVO = (UserSessionVO) EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
				distWorkVO.setAdminId(userSessionVO.getUsrId());
			}
			
			distWorkVO.setAdminGrpName(distributionDiaryService.getAdminGrpName(distWorkVO));
			/*
			if("순회정비반장".equals(distWorkVO.getAdminGrpName()) && distWorkVO.getCenterId() == null){
				distWorkVO.setCenterId(distributionDiaryService.getInsertWrkCenterId(distWorkVO));
			}*/
			
			int totCnt = distributionDiaryService.getRoundMaintenWrkerAttCnt(distWorkVO);
			PaginationInfo paginationInfo = getPagingInfo(distWorkVO.getCurrentPageNo(), totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(distWorkVO.getCurrentPageNo(), totCnt);
			
			distWorkVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			distWorkVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<DistWorkVO> workList = distributionDiaryService.getRoundMaintenWrkerAtt(distWorkVO);
			
			model.addAttribute("searchCondition", distWorkVO);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("workList", workList);
			result = true;
		} catch (CfoodException e) {
			throw new CfoodException("admin.distMgmt.distributionDiary.getDistWork" , e.getMessage());
		}
		
		return result ? targetUrl : ERROR_PAGE;
	}
	
	
	
	
	
	
	@RequestMapping("/distributionDiary/getDistCoWorkAjax.do")
	@RequestName("getDistCoWorkAjax")
	public String getDistCoWorkAjax(@ModelAttribute DistCoWorkVO vo, ModelMap model, HttpServletRequest request) {
		
		boolean result = false;
		
		try {
			userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
		} catch (Exception e1) {
			e1.printStackTrace();
			result = false;
		}
		
		try {
			model.addAttribute("searchCondition", vo);
			model.addAttribute("list", distributionDiaryService.getDistCoWork(vo));
			result = true;
		} catch (Exception e) {
			result = false;
			e.printStackTrace();
		}
		// 권한
		model.addAttribute("usrGrpCd", userSessionVO.getUsrGrpCd());
		model.addAttribute("centerId", userSessionVO.getCenterId());
		model.addAttribute("result", result);
		
		return JSONVIEW;
	}
	
	@RequestMapping("/distributionDiary/insertCoWorkAjax.do")
	@RequestName("insertCoWorkAjax")
	public String insertCoWorkAjax(@ModelAttribute DistCoWorkVO vo, ModelMap model, HttpServletRequest request) {
		
		boolean result = false;
		
		try {
			userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		try {
			if ( vo.getCoworkInfoSeq() != null && ( !"".equals(vo.getCoworkInfoSeq()) || "0".compareTo(vo.getCoworkInfoSeq()) < 0 ) ) {
				distributionDiaryService.updateDistCoWork(vo);
			} else {
				distributionDiaryService.insertDistCoWork(vo);
			}
			result = true;
		} catch (Exception e) {
			result = false;
			model.addAttribute("result", result);
			throw new CfoodException("admin.maintenance.distMgmt.distributionDiary.getDistributionDiary",e.getMessage());
		}
		
		model.addAttribute("result", result);
		model.addAttribute("vo", vo);
		
		return JSONVIEW;
	}
	
	@RequestMapping("/distributionDiary/insertCoWorkDtlAjax.do")
	@RequestName("insertCoWorkDtlAjax")
	public String insertCoWorkDtlAjax(@ModelAttribute DistCoWorkDtlVO vo, ModelMap model, HttpServletRequest request) {
		
		boolean result = false;
		
		try {
			userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		try {
			distributionDiaryService.insertDistCoWorkDtl(vo);
			result = true;
		} catch (Exception e) {
			result = false;
			model.addAttribute("result", result);
			e.printStackTrace();
		}
		
		model.addAttribute("result", result);
		model.addAttribute("vo", vo);
		
		return JSONVIEW;
	}
	
	@RequestMapping("/distributionDiary/deleteDistCoWorkAdminAjax.do")
	@RequestName("deleteDistCoWorkAdminAjax")
	public String deleteDistCoWorkAdminAjax(@ModelAttribute DistCoWorkDtlVO vo, ModelMap model, HttpServletRequest request) {
		
		boolean result = false;
		
		try {
			userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		try {
			// 전체 삭제위해
			vo.setCoworkDtlSeq("");
			distributionDiaryService.deleteDistCoWork(vo);
			result = true;
		} catch (Exception e) {
			result = false;
			model.addAttribute("result", result);
			e.printStackTrace();
		}
		
		model.addAttribute("result", result);
		
		return JSONVIEW;
	}
	
	@RequestMapping("/distributionDiary/deleteDistCoWorkMemberAjax.do")
	@RequestName("deleteDistCoWorkMemberAjax")
	public String deleteDistCoWorkMemberAjax(@ModelAttribute DistCoWorkDtlVO vo, ModelMap model, HttpServletRequest request) {
		
		boolean result = false;
		
		try {
			userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		try {
			distributionDiaryService.deleteDistCoWorkDtl(vo);
			result = true;
		} catch (Exception e) {
			result = false;
			model.addAttribute("result", result);
			e.printStackTrace();
		}
		
		
		
		model.addAttribute("result", result);
		
		return JSONVIEW;
	}
	
	@RequestMapping("/distributionDiary/getCoworkList.do")
	@RequestName("getCoworkList")
	public String getCoworkList(@ModelAttribute DistCoWorkVO vo, ModelMap model, HttpServletRequest request) {
		
		String bizName = "공동근무 화면 이동";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        boolean result = false;
        String resultPage = RETURN_URL.concat("dist_diary_cowork");
        UserSessionVO userSessionVO = null;  
        
		try {
			userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		if(vo.getSearchDate() == null || "".equals(vo.getSearchDate())){
			
			String todayDate = DateUtil.getSystemDate("yyyy-MM-dd");
			
			vo.setSearchDate(todayDate);
		}	
        
		try {
			model.addAttribute("searchCondition", vo);
			model.addAttribute("dsList", distributionDiaryService.getCoworkList(vo));
			result = true;
		} catch (Exception e) {
			throw new CfoodException("admin.maintenance.distMgmt.distributionDiary.viewDistributionDiary",e.getMessage());
		}
		
		return result ? resultPage : ERROR_PAGE;
	}
	
	@RequestMapping("/distributionDiary/modifyCoworkList.do")
	@RequestName("modifyCoworkList")
	public String modifyCoworkList(@ModelAttribute DistCoWorkVO vo, ModelMap model, HttpServletRequest request) {
		
		String bizName = "공동근무 화면 이동";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        boolean result = false;
        String resultPage = RETURN_URL.concat("dist_diary_cowork_modify");
        UserSessionVO userSessionVO = null;  
        
		try {
			userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		if(vo.getSearchDate() == null || "".equals(vo.getSearchDate())){
			
			String todayDate = DateUtil.getSystemDate("yyyy-MM-dd");
			
			vo.setSearchDate(todayDate);
		}	
        
		try {
			
			
			model.addAttribute("searchCondition", vo);
			model.addAttribute("userSessionVO"  , userSessionVO);
			
			if( MODE_INSERT.equals(vo.getViewFlg())  || "C".equals(vo.getViewFlg()) ) {
				
				model.addAttribute("dsVO", vo );
				model.addAttribute("size", 0  );
				model.addAttribute("dsCoWorkList",  null );
				
			} else {
				int size = 0;
				List<DistCoWorkVO> a = distributionDiaryService.getCoworkList(vo);
								size = a.size();
				model.addAttribute("size", distributionDiaryService.getCoworkList(vo).size());
				
				model.addAttribute("dsVO", ( size > 0 ? distributionDiaryService.getCoworkList(vo).get(0) : vo ));
				
				model.addAttribute("dsCoWorkList", ( size > 0 ? distributionDiaryService.getCoworkDtlList(vo) : vo ));
			}
			result = true;
		} catch (Exception e) {
			throw new CfoodException("admin.maintenance.distMgmt.distributionDiary.viewDistributionDiary",e.getMessage());
		}
		
		return result ? resultPage : ERROR_PAGE;
	}
	

	@RequestMapping("/distributionDiary/getDistMemberInfo.do")
	@RequestName("getDistMemberInfo")
	public String getDistMemberInfo(@ModelAttribute DistCoWorkVO vo, ModelMap model, HttpServletRequest request) {
		
		boolean result = false;
		
		try {
			userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		try {
			model.addAttribute("list", distributionDiaryService.getDistMemberInfo(vo));
			result = true;
		} catch (Exception e) {
			result = false;
			model.addAttribute("result", result);
			e.printStackTrace();
		}
		
		model.addAttribute("result", result);
		
		return JSONVIEW;
	}
		
	
	
}
