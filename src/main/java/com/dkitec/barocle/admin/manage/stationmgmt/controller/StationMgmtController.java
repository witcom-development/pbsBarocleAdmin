package com.dkitec.barocle.admin.manage.stationmgmt.controller;
import java.io.StringReader;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;
import org.apache.log4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.client.RestTemplate;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.dkitec.barocle.admin.customer.notice.vo.NoticeVO;
import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.admin.login.vo.UserSessionVO;
import com.dkitec.barocle.admin.manage.deviceMgmt.ap.service.ApService;
import com.dkitec.barocle.admin.manage.deviceMgmt.ap.vo.ApVO;
import com.dkitec.barocle.admin.manage.deviceMgmt.beacon.service.BeaconService;
import com.dkitec.barocle.admin.manage.deviceMgmt.beacon.vo.BeaconVO;
import com.dkitec.barocle.admin.manage.stationgroup.service.StationGroupMgmtService;
import com.dkitec.barocle.admin.manage.stationgroup.vo.StationGroupMgmtVO;
import com.dkitec.barocle.admin.manage.stationmgmt.service.StationMgmtService;
import com.dkitec.barocle.admin.manage.stationmgmt.vo.StationMgmtVO;
import com.dkitec.barocle.admin.manage.stationmgmt.vo.StationMgmtVO.searchCheck;
import com.dkitec.barocle.admin.system.commonCodeMgmt.service.CommonCodeService;
import com.dkitec.barocle.admin.system.commonCodeMgmt.vo.CommonCodeVO;
import com.dkitec.barocle.base.IConstants;
import com.dkitec.barocle.util.sms.SendType;
import com.dkitec.barocle.util.sms.vo.SmsMessageVO;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/** 
 * 관리자 스테이션 (대여소) 관리 Controller
 * @파일명		  : StationStatusController.java
 * @작성일		  : 2015. 4. 17.
 * @작성자		  : pts
 * @수정내용
 * -------------------------------------------------------------
 *	  수정일	  |	  수정자	  |			  수정내용
 * -------------------------------------------------------------
 **/


@Controller
@RequestCategory(value="StationMgmtController")
@RequestMapping(value="/admin/manage/station")
public class StationMgmtController {
	
	protected static org.slf4j.Logger log = LoggerFactory.getLogger(StationMgmtController.class);
	private Logger logger = Logger.getLogger(this.getClass());
	
	@Resource(name = "propertiesService") protected EgovPropertyService propertiesService;
	@Resource(name = "stationMgmtService") protected StationMgmtService stationMgmtService;
	@Resource(name = "stationGroupMgmtService") protected StationGroupMgmtService stationGroupMgmtService;
	@Resource(name = "commonCodeService") private CommonCodeService commonCodeService;
	@Resource(name = "apService") private ApService apService;
	@Resource(name = "beaconService") private BeaconService beaconService;
	
	@Autowired protected MessageSource messageSource;
	
	/**
	 * 공통 리턴화면 
	 * @param methodName
	 * @return
	 */
	protected String getReturnUrl(String methodName) {
		return "/admin/manage/station/" + methodName;
	}
	
	public String getMessage(String messageCode) {
		return this.getMessage(messageCode, null);
	}
	
	public String getMessage(String messageCode, Object[] messageParam) {
		return messageSource.getMessage(messageCode, messageParam, Locale.getDefault());
	}
	
	/**
	 * 정거장 목록 조회
	 * @param manager
	 * @param result
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestName(value="stationList")
	@RequestMapping(value="stationList")
	public String stationList(@Validated(searchCheck.class)  StationMgmtVO stationVo, BindingResult result, ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		if (!result.hasErrors()) {
			model.put("result", "");
		} else {
			model.put("result", result.getAllErrors().get(0).getDefaultMessage());
			return getReturnUrl("opr_sta_list");
		}
		
		stationVo.setLang(request.getLocale().getLanguage());
		
		boolean bResult = false;
		List<StationMgmtVO> stationList = null;
		List<StationGroupMgmtVO> group = null;
		
		stationVo.setRecordCountPerPage(propertiesService.getInt("pageUnit"));
		stationVo.setPageSize(propertiesService.getInt("pageSize"));
		// 페이징 처리
		
		PaginationInfo paginationInfo = new PaginationInfo();
		PaginationInfo paginationMobileInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(stationVo.getCurrentPageNo());
		paginationMobileInfo.setCurrentPageNo(stationVo.getCurrentPageNo());
		
		paginationInfo.setRecordCountPerPage(stationVo.getPageSize());
		paginationInfo.setPageSize(stationVo.getRecordCountPerPage());
		
		paginationMobileInfo.setRecordCountPerPage(stationVo.getPageSize());
		paginationMobileInfo.setPageSize(propertiesService.getInt("pageMobileSize"));
		
		stationVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
		stationVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		
		try {
			// total count
			paginationInfo.setTotalRecordCount(stationMgmtService.getStationListCnt(stationVo));
			paginationMobileInfo.setTotalRecordCount(stationMgmtService.getStationListCnt(stationVo));
			// 목록 조회
			stationList = stationMgmtService.getStationList(stationVo);
			
			log.debug("##### StationMgmtController stationVo ##### ==>" + stationVo.toString());
			log.debug("##### StationMgmtController stationList ##### ==>" + stationList.toString());
			
			StationGroupMgmtVO vo = new StationGroupMgmtVO();
			vo.setLang(request.getLocale().getLanguage());
			// 그룹명 조회
			group = stationGroupMgmtService.getStationGroupNameList(vo);
			
			bResult = true;
		} catch (Exception e) {
			new CfoodException("admin.manage.station.stationList", e.getMessage());
		}
		
		model.put("searchVO",stationVo );
		model.put("paginationInfo", paginationInfo);
		model.put("paginationMobileInfo", paginationMobileInfo);
		model.put("stationList", stationList);
		model.put("group", group);
		
		return bResult? getReturnUrl("opr_sta_list") : IConstants.ERROR_PAGE;
	}
	
	/**
	 * 원격반납정거장 목록 조회
	 * @param manager
	 * @param result
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestName(value="stationGrpRemoteReturnList")
	@RequestMapping(value="stationGrpRemoteReturnList")
	public String stationGrpRemoteReturnList(@Validated(searchCheck.class)  StationMgmtVO stationVo, BindingResult result, ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		if (!result.hasErrors()) {
			model.put("result", "");
		} else {
			model.put("result", result.getAllErrors().get(0).getDefaultMessage());
			return getReturnUrl("opr_staGrpRemoteReturn_list");
		}
		
		stationVo.setLang(request.getLocale().getLanguage());
		
		boolean bResult = false;
		List<StationMgmtVO> stationList = null;
		List<StationGroupMgmtVO> group = null;
		
		stationVo.setRecordCountPerPage(propertiesService.getInt("pageUnit"));
		stationVo.setPageSize(propertiesService.getInt("pageSize"));
		// 페이징 처리
		
		PaginationInfo paginationInfo = new PaginationInfo();
		PaginationInfo paginationMobileInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(stationVo.getCurrentPageNo());
		paginationMobileInfo.setCurrentPageNo(stationVo.getCurrentPageNo());
		
		paginationInfo.setRecordCountPerPage(stationVo.getPageSize());
		paginationInfo.setPageSize(stationVo.getRecordCountPerPage());
		
		paginationMobileInfo.setRecordCountPerPage(stationVo.getPageSize());
		paginationMobileInfo.setPageSize(propertiesService.getInt("pageMobileSize"));
		
		stationVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
		stationVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		try {
			// total count
			paginationInfo.setTotalRecordCount(stationMgmtService.getStationGrpRemoteReturnListCnt(stationVo));
			paginationMobileInfo.setTotalRecordCount(stationMgmtService.getStationGrpRemoteReturnListCnt(stationVo));
			
			stationList = stationMgmtService.getStationGrpRemoteReturnList(stationVo);		// 목록 조회
			
			log.debug("##### StationMgmtController stationVo ##### ==>" + stationVo.toString());
			log.debug("##### StationMgmtController stationList ##### ==>" + stationList.toString());
			
			StationGroupMgmtVO vo = new StationGroupMgmtVO();
			vo.setLang(request.getLocale().getLanguage());
			
			group = stationGroupMgmtService.getStationGroupNameList(vo);	// 그룹명 조회
			
			bResult = true;
		} catch (Exception e) {
			new CfoodException("admin.manage.station.stationList", e.getMessage());
		}
		
		model.put("searchVO",stationVo );
		model.put("paginationInfo", paginationInfo);
		model.put("paginationMobileInfo", paginationMobileInfo);
		model.put("stationList", stationList);
		model.put("group", group);
		
		return bResult? getReturnUrl("opr_staGrpRemoteReturn_list") : IConstants.ERROR_PAGE;
	}
	
	/**
	 * 정거장 목록 엑셀 출력
	 * @param manager
	 * @param result
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestName(value="stationListExcel")
	@RequestMapping(value="stationListExcel")
	public String stationListExcel(@Validated(searchCheck.class)  StationMgmtVO stationVo, BindingResult result, ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		if (!result.hasErrors()) {
			model.put("result", "");
		} else {
			model.put("result", result.getAllErrors().get(0).getDefaultMessage());
			return getReturnUrl("opr_sta_list");
		}
		
		stationVo.setLang(request.getLocale().getLanguage());
		
		boolean bResult = false;
		List<StationMgmtVO> stationList = null;
		
		// 페이징 처리
		PaginationInfo paginationInfo = new PaginationInfo();
		
		try {
			
			stationVo.setExcel("EXCEL");
			// total count
			paginationInfo.setTotalRecordCount(stationMgmtService.getStationListCnt(stationVo));
			// 목록 조회
			stationList = stationMgmtService.getStationList(stationVo);
			bResult = true;
		} catch (Exception e) {
			new CfoodException("admin.manage.station.stationListExcel");
		}
		
		model.put("searchVO",stationVo );
		model.put("paginationInfo", paginationInfo);
		model.put("stationList", stationList);
		
		return bResult? getReturnUrl("opr_sta_list_excel") : IConstants.ERROR_PAGE;
		
	}
	
	/**
	 * 정거장 등록 화면 이동
	 * @param manager
	 * @param result
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	@RequestName(value="stationRegist")
	@RequestMapping(value="stationRegist", method = RequestMethod.POST)
	public String stationGroupRegist(StationGroupMgmtVO stationVo, BindingResult result, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		List<StationGroupMgmtVO> groupList = null;
		List<ApVO> aplist = null;
		List<CommonCodeVO> codeList = null;
		boolean bResult = false;
		String resultPage = "/admin/manage/station/opr_sta_detail";
		
		stationVo.setLang(request.getLocale().getLanguage());
		
		UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
		if(userSessionVO == null){
			throw new CfoodException(getMessage("error.invalidSession"));
		}
		
		try {
			groupList = stationGroupMgmtService.getStationGroupNameList(stationVo);		// 정거장 그룹 목록 조회
			aplist =  stationMgmtService.getApList();				// 센터에 속한 AP디바이스 리스틎 조회
			
			CommonCodeVO cVo = new CommonCodeVO();
			cVo.setComUpCd("LAG");
			cVo.setLang(IConstants.LANG_KR);
			codeList = commonCodeService.getComCodeInfo(cVo);			// 다국어 공통 코드 조회
			bResult = true;
			//stationVo.setTeam_seq(userSessionVO.getUsrId());
		} catch (Exception e) {
			e.printStackTrace();
			new CfoodException("admin.manage.station.stationRegist");
		}
		
 		model.put("codeList", codeList);
		model.put("cmd", "INSERT");
		model.put("groupList", groupList);
		model.put("aplist", aplist);
		
		return bResult ? resultPage : IConstants.ERROR_PAGE;
	}
	
	/**
	 * 원격반납정거장 등록 화면 이동
	 * @param manager
	 * @param result
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	@RequestName(value="stationGrpRemoteReturnRegist")
	@RequestMapping(value="stationGrpRemoteReturnRegist", method = RequestMethod.POST)
	public String stationGrpRemoteReturnRegist(StationGroupMgmtVO stationVo, BindingResult result, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		List<StationGroupMgmtVO> groupList = null;
//		List<ApVO> aplist = null;
		List<CommonCodeVO> codeList = null;
		boolean bResult = false;
		String resultPage = "/admin/manage/station/opr_staGrpRemoteReturn_add";
		
		stationVo.setLang(request.getLocale().getLanguage());
		
		UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
		if(userSessionVO == null){
			throw new CfoodException(getMessage("error.invalidSession"));
		}
		
		try {
			groupList = stationGroupMgmtService.getStationGroupNameList(stationVo);		// 정거장 그룹 목록 조회
//			aplist =  stationMgmtService.getApList();				// 센터에 속한 AP디바이스 리스틎 조회
			
			CommonCodeVO cVo = new CommonCodeVO();
			cVo.setComUpCd("LAG");
			cVo.setLang(IConstants.LANG_KR);
			codeList = commonCodeService.getComCodeInfo(cVo);			// 다국어 공통 코드 조회
			bResult = true;
			//stationVo.setTeam_seq(userSessionVO.getUsrId());
		} catch (Exception e) {
			e.printStackTrace();
			new CfoodException("admin.manage.station.stationRegist");
		}
		
 		model.put("codeList", codeList);
		model.put("cmd", "INSERT");
		model.put("groupList", groupList);
//		model.put("aplist", aplist);
		
		return bResult ? resultPage : IConstants.ERROR_PAGE;
	}
	
	/**
	 * 정거장 상세정보 Ajax
	 * @param manager
	 * @param model
	 * @param request
	 * @param response
	 * @return JSON
	 */
	@RequestName(value="stationInfoAjax")
	@RequestMapping(value="stationInfoAjax", method = RequestMethod.POST)
	public String stationInfoAjax(StationGroupMgmtVO sVo, ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		boolean bResult = false;
		StationMgmtVO  info = null;
		try {
			info = stationMgmtService.getStationInfo(sVo);	//상세정보 조회
			bResult = true;
		} catch (Exception e) {
			e.printStackTrace();
			new CfoodException("admin.manage.station.stationInfo");
		}
		
		model.addAttribute("info", info);
		model.addAttribute("CHECK_RESULT", bResult);
		
		return IConstants.JSONVIEW;
	}
	
	/**
	 * 원격반납정거장  상세정보 Ajax
	 * @param manager
	 * @param model
	 * @param request
	 * @param response
	 * @return JSON
	 */
	@RequestName(value="stationGrpRemoteReturnInfoAjax")
	@RequestMapping(value="stationGrpRemoteReturnInfoAjax", method = RequestMethod.POST)
	public String stationGrpRemoteReturnInfoAjax(StationGroupMgmtVO sVo, ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		boolean bResult = false;
		StationMgmtVO  info = null;
		try {
			info = stationMgmtService.getStationGrpRemoteReturnInfo(sVo);	//상세정보 조회
			bResult = true;
		} catch (Exception e) {
			e.printStackTrace();
			new CfoodException("admin.manage.station.stationGrpRemoteReturnInfo");
		}
		
		model.addAttribute("info", info);
		model.addAttribute("CHECK_RESULT", bResult);
		
		return IConstants.JSONVIEW;
	}
	
	/**
	 * 정거장 상세정보 화면 이동 (수정)
	 * @param manager
	 * @param result
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	@RequestName(value="stationInfo")
	@RequestMapping(value="stationInfo", method = RequestMethod.POST)
	public String stationInfo(StationGroupMgmtVO stationVo, StationMgmtVO sVo, BindingResult result, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		boolean bResult = false;
		StationMgmtVO info = null;
		List<StationMgmtVO> stationName = null;
		List<StationGroupMgmtVO> groupList = null;
		List<ApVO> aplist = null;
		List<CommonCodeVO> codeList = null;
		List<StationMgmtVO> stationUseList = null;
		List<BeaconVO> beaconList = null;
		BeaconVO beaconVo = new BeaconVO();
		
		String resultPage = "/admin/manage/station/opr_sta_detail";
		String resultPage2 = "/admin/manage/station/opr_sta_tmp_close";
		
		stationVo.setLang(request.getLocale().getLanguage());
		
		// 페이징 처리
		sVo.setRecordCountPerPage(propertiesService.getInt("pageUnit"));
		sVo.setPageSize(propertiesService.getInt("pageSize"));
		
		PaginationInfo paginationInfo = new PaginationInfo();
		PaginationInfo paginationMobileInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(sVo.getCurrentPageNo());
		paginationMobileInfo.setCurrentPageNo(sVo.getCurrentPageNo());
		
		paginationInfo.setRecordCountPerPage(sVo.getPageSize());
		paginationInfo.setPageSize(sVo.getRecordCountPerPage());
		
		paginationMobileInfo.setRecordCountPerPage(sVo.getPageSize());
		paginationMobileInfo.setPageSize(propertiesService.getInt("pageMobileSize"));
		
		sVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
		sVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		
		UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
		if(userSessionVO == null){
			throw new CfoodException(getMessage("error.invalidSession"));
		}
		
		try {
			info = stationMgmtService.getStationInfo(stationVo);						//상세정보 조회
			stationName = stationMgmtService.getStationNameInfo(stationVo);				// 스테이션 다국어 명 조회
			groupList = stationGroupMgmtService.getStationGroupNameList(stationVo);		// 그룹 목록 조회
			aplist =  stationMgmtService.getApList();									// 센터에 속한 ap디바이스 목록 조회
			
			//스테이션 이력 조회
			paginationInfo.setTotalRecordCount(stationMgmtService.getStationUseListCnt(sVo));
			paginationMobileInfo.setTotalRecordCount(stationMgmtService.getStationUseListCnt(sVo));
			stationUseList = stationMgmtService.getStationUseList(sVo);
			
			beaconVo.setNowLocateId(sVo.getStation_id());
			beaconVo.setStationId(sVo.getStation_id());
			beaconVo.setPagingYn("N");
			beaconList = beaconService.getBeaconList(beaconVo);		// 비콘 목록 조회
			
			CommonCodeVO cVo = new CommonCodeVO();
			cVo.setComUpCd("LAG");
			cVo.setLang(IConstants.LANG_KR);
			//공통 코드 조회
			codeList = commonCodeService.getComCodeInfo(cVo);
			bResult = true;
		} catch (Exception e) {
			e.printStackTrace();
			new CfoodException("admin.manage.station.stationInfo");
		}
		
		model.put("codeList", codeList);
		model.put("cmd", "INFO");
		model.put("groupList", groupList);
		model.put("aplist", aplist);
		model.put("info", info);
		model.put("stationName", stationName);
		model.put("stationUseList", stationUseList);
		model.put("paginationInfo", paginationInfo);
		model.put("paginationMobileInfo", paginationMobileInfo);
		model.put("beaconList", beaconList);
		
		 if( "5".equals(userSessionVO.getUsrGrpCd() )){
			return bResult ? resultPage2 : IConstants.ERROR_PAGE;
		 }
		 else {
			return bResult ? resultPage : IConstants.ERROR_PAGE;
		 }
	}
	

	/**
	 * 원격반납정거장 상세정보 화면 이동 (수정)
	 * @param manager
	 * @param result
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	@RequestName(value="stationGrpRemoteReturnInfo")
	@RequestMapping(value="stationGrpRemoteReturnInfo", method = RequestMethod.POST)
	public String stationGrpRemoteReturnInfo(StationGroupMgmtVO stationVo, StationMgmtVO sVo, BindingResult result, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		boolean bResult = false;
		StationMgmtVO info = null;
//		List<StationMgmtVO> stationName = null;
		List<StationGroupMgmtVO> groupList = null;
//		List<ApVO> aplist = null;
//		List<CommonCodeVO> codeList = null;
//		List<StationMgmtVO> stationGrpRemoteReturnList1 = null;
//		List<BeaconVO> beaconList = null;
//		BeaconVO beaconVo = new BeaconVO();
		
		String resultPage = "/admin/manage/station/opr_staGrpRemoteReturn_upd";
//		String resultPage2 = "/admin/manage/station/opr_sta_tmp_close";
		
		stationVo.setLang(request.getLocale().getLanguage());
		
		// 페이징 처리
		sVo.setRecordCountPerPage(propertiesService.getInt("pageUnit"));
		sVo.setPageSize(propertiesService.getInt("pageSize"));
		
		PaginationInfo paginationInfo = new PaginationInfo();
		PaginationInfo paginationMobileInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(sVo.getCurrentPageNo());
		paginationMobileInfo.setCurrentPageNo(sVo.getCurrentPageNo());
		
		paginationInfo.setRecordCountPerPage(sVo.getPageSize());
		paginationInfo.setPageSize(sVo.getRecordCountPerPage());
		
		paginationMobileInfo.setRecordCountPerPage(sVo.getPageSize());
		paginationMobileInfo.setPageSize(propertiesService.getInt("pageMobileSize"));
		
		sVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
		sVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
		if(userSessionVO == null){
			throw new CfoodException(getMessage("error.invalidSession"));
		}
		
		try {
			info = stationMgmtService.getStationGrpRemoteReturnInfo1(sVo);						//상세정보 조회
//			stationName = stationMgmtService.getStationNameInfo(stationVo);				// 스테이션 다국어 명 조회
			groupList = stationGroupMgmtService.getStationGroupNameList(stationVo);		// 그룹 목록 조회
//			aplist =  stationMgmtService.getApList();									// 센터에 속한 ap디바이스 목록 조회
			
			//스테이션 이력 조회
//			paginationInfo.setTotalRecordCount(stationMgmtService.getStationUseListCnt(sVo));
//			paginationMobileInfo.setTotalRecordCount(stationMgmtService.getStationUseListCnt(sVo));
//			stationUseList = stationMgmtService.getStationUseList(sVo);
			
//			beaconVo.setNowLocateId(sVo.getStation_id());
//			beaconVo.setStationId(sVo.getStation_id());
//			beaconVo.setPagingYn("N");
//			beaconList = beaconService.getBeaconList(beaconVo);		// 비콘 목록 조회
//			stationGrpRemoteReturnList1 = stationMgmtService.getStationGrpRemoteReturnList1(info);		// 비콘 목록 조회
			
//			CommonCodeVO cVo = new CommonCodeVO();
//			cVo.setComUpCd("LAG");
//			cVo.setLang(IConstants.LANG_KR);
//			//공통 코드 조회
//			codeList = commonCodeService.getComCodeInfo(cVo);
			bResult = true;
		} catch (Exception e) {
			e.printStackTrace();
			new CfoodException("admin.manage.station.stationInfo");
		}
		
//		model.put("codeList", codeList);
		model.put("cmd", "INFO");
		model.put("groupList", groupList);
//		model.put("aplist", aplist);
		model.put("info", info);
//		model.put("stationName", stationName);
//		model.put("stationUseList", stationUseList);
		model.put("paginationInfo", paginationInfo);
		model.put("paginationMobileInfo", paginationMobileInfo);
//		model.put("beaconList", beaconList);
//		model.put("stationGrpRemoteReturnList", stationGrpRemoteReturnList1);
		
//		 if( "5".equals(userSessionVO.getUsrGrpCd() )){
//			return bResult ? resultPage2 : IConstants.ERROR_PAGE;
//		 }
//		 else {
			return bResult ? resultPage : IConstants.ERROR_PAGE;
//		 }
	}
	
	@RequestName(value="juso")
	@RequestMapping(value="juso")
	public String juso(StationGroupMgmtVO stationVo, BindingResult result, ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		stationVo.setLang(request.getLocale().getLanguage());
		
		// juso property values
		Map<String,String> jusoMap = new java.util.HashMap<String,String>();
		jusoMap.put("jusoKey",propertiesService.getString("jusoKey"));
		jusoMap.put("jusoPublicZone",propertiesService.getString("jusoPublicZone"));
		jusoMap.put("jusoPrivateZone",propertiesService.getString("jusoPrivateZone"));
		model.put("juso", jusoMap);
		
		List<StationGroupMgmtVO> groupList = stationGroupMgmtService.getStationGroupNameList(stationVo);
		model.put("groupList", groupList);
		
		return "/admin/manage/pop/jusoPop";
	}
	
	/**
	 * 정거장 번호 중복체크
	 * @param manager
	 * @param result
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestName(value="stationNumberCheck")
	@RequestMapping(value="stationNumberCheck")
	public String stationNumberCheck(StationMgmtVO stationVo, BindingResult result, ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		String rt = stationMgmtService.stationNumberCheck(stationVo);
		model.put("result", rt);
		
		return IConstants.JSONVIEW;
		
	}
	
	/**
	 * 네이버 API 연동 주소 위경도 변환
	 * @param manager
	 * @param result
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestName(value="stationAddrSearch")
	@RequestMapping(value="stationAddrSearch")
	public String stationAddrSearch(StationMgmtVO stationVo, BindingResult result, ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		logger.debug(stationVo);
		String accessKey = propertiesService.getString("naverMapApiKey");
		String apiUrl = "http://openapi.map.naver.com/api/geocode.php?key="+ accessKey +"&encoding=utf-8&coord=latlng&query=" + stationVo.getStation_name();
		String rt = "";
		
		try {
			//REST API URL을 읽어들여 결과 출력한다
			RestTemplate restTemplate = new RestTemplate();
			//String rest = restTemplate.getForObject(apiUrl, String.class);
			String xmlStr = restTemplate.getForObject(apiUrl, String.class);
			
			DocumentBuilderFactory factory  =  DocumentBuilderFactory.newInstance();
			DocumentBuilder builder	=  factory.newDocumentBuilder();
			
			Document document	 =  builder.parse(new InputSource(new StringReader(xmlStr)));
			
			NodeList nodelist1	=  document.getElementsByTagName("x");
			NodeList nodelist2	=  document.getElementsByTagName("y");
			
			if(nodelist1.getLength() > 0){
				
				Node y	  =  nodelist1.item(0).getChildNodes().item(0);
				Node x	  =  nodelist2.item(0).getChildNodes().item(0);
				
				model.put("lat", x.getNodeValue());
				model.put("lon", y.getNodeValue());
				rt = "OK";
			 }else{
				 rt = "위치정보가 없습니다.";
			 }
			 
		} catch (Exception e) {
			e.printStackTrace();
			rt = "FAIL";
			new CfoodException("admin.manage.station.stationAddrSearch");
		}
		
		model.put("result", rt);
		
		return IConstants.JSONVIEW;
		
	}
	
	/**
	 * HTTP Parameter 생성 
	 * @param Map<String, String> 
	 * @return List<NameValuePair>
	 */
	@RequestName(value="convertParam") private List<NameValuePair> convertParam(Map<String, String> params){
		List<NameValuePair> paramList = new ArrayList<NameValuePair>();
		Iterator<String> keys = params.keySet().iterator();
		while(keys.hasNext()){
			String key = keys.next();
			paramList.add(new BasicNameValuePair(key, params.get(key).toString()));
		}
		return paramList;
	}
	
	/**
	 * 정거장 등록 
	 * @param manager
	 * @param result
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	@RequestName(value="stationModify")
	@RequestMapping(value="stationModify", method = RequestMethod.POST)
	public String stationModify(@Validated(searchCheck.class) StationMgmtVO stationVo, BindingResult result, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		boolean bResult = false;
		String targetUrl = "redirect:/admin/manage/station/stationList.do";
		
		UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
		
		String rt = "";
		
		if(userSessionVO == null) {	
			rt = "실패";
			bResult = false;
			throw new CfoodException(getMessage("error.invalidSession"));
		}
		
		if (!result.hasErrors()) {
			model.put("result", "");
		} else if (userSessionVO.getUsrGrpCd().equals("5")){ 
			model.put("result", result.getAllErrors().get(0).getDefaultMessage());
			return getReturnUrl("opr_sta_tmp_close"); // 배송직원용 간략한 대여소 상세화면 
		}else {
			model.put("result", result.getAllErrors().get(0).getDefaultMessage());
			return getReturnUrl("opr_sta_detail");
		}
		
		stationVo.setUser(userSessionVO.getUsrId());
		
		if (userSessionVO.getUsrGrpCd().equals("5")){ 
			stationMgmtService.stationGroupModify05(stationVo); // 배송직원용 간략한 대여소 상세화면 수정할때 
		}else {
			stationMgmtService.stationGroupModify(stationVo, apService);
		}
		
		stationVo.setLang(request.getLocale().getLanguage());
			
		// 수정할때만 적용
//		if (  stationVo.getCmd().equals("UPDATE") ) setNotice(stationVo);	
		
		rt = "성공";	bResult = true;
		model.put("rtMsg",	rt );
		
		return bResult ? targetUrl : IConstants.ERROR_PAGE;
	}
	
	
	/**
	 * 원격반납정거장 등록 
	 * @param manager
	 * @param result
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	@RequestName(value="stationGrpRemoteReturnModify")
	@RequestMapping(value="stationGrpRemoteReturnModify", method = RequestMethod.POST)
	public String stationGrpRemoteReturnModify(@Validated(searchCheck.class) StationMgmtVO stationVo, BindingResult result, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		boolean bResult = false;
		String targetUrl = "redirect:/admin/manage/station/stationGrpRemoteReturnList.do";
		
		UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
		
		String rt = "";
		
		if(userSessionVO == null) {	
			rt = "실패";
			bResult = false;
			throw new CfoodException(getMessage("error.invalidSession"));
		}
		
		if (!result.hasErrors()) {
			model.put("result", "");
		} 
//		else if (userSessionVO.getUsrGrpCd().equals("5")){ 
//			model.put("result", result.getAllErrors().get(0).getDefaultMessage());
//			return getReturnUrl("opr_sta_tmp_close"); // 배송직원용 간략한 대여소 상세화면 
//		}
		else {
			model.put("result", result.getAllErrors().get(0).getDefaultMessage());
			return getReturnUrl("opr_staGrpRemoteReturn_upd");
		}
		
		stationVo.setUser(userSessionVO.getUsrId());
		
//		if (userSessionVO.getUsrGrpCd().equals("5")){ 
//			stationMgmtService.stationGroupModify05(stationVo); // 배송직원용 간략한 대여소 상세화면 수정할때 
//		}else {
			stationMgmtService.stationGrpRemoteReturnGroupModify(stationVo, apService);
//		}
		
		stationVo.setLang(request.getLocale().getLanguage());
			
		// 수정할때만 적용
//		if (  stationVo.getCmd().equals("UPDATE") ) setNotice(stationVo);	
		
		rt = "성공";	bResult = true;
		model.put("rtMsg",	rt );
		
		return bResult ? targetUrl : IConstants.ERROR_PAGE;
	}
	
	
	
	/**
	 * 원격반납정거장 저장 
	 * @param manager
	 * @param result
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	@RequestName(value="saveStationGrpRemoteReturnInfo")
	@RequestMapping(value="saveStationGrpRemoteReturnInfo", method = RequestMethod.POST)
	public String saveStationGrpRemoteReturnInfo(@Validated(searchCheck.class) StationMgmtVO stationVo, BindingResult result, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		boolean bResult = false;
		
		String rt = "";
		UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
		if(userSessionVO == null) {	
			rt = "실패";
			bResult = false;
			throw new CfoodException(getMessage("error.invalidSession"));
		}
		
		if (!result.hasErrors()) {
			model.put("result", "");
		} else {
			model.put("result", result.getAllErrors().get(0).getDefaultMessage());
			return getReturnUrl("opr_staGrpRemoteReturn_upd");
		}
		
		stationVo.setUser(userSessionVO.getUsrId());
		if("INSERT".equals(stationVo.getMode())){
			stationMgmtService.insertStationGrpRemoteReturnInfo(stationVo);
		} else {
			stationMgmtService.updateStationGrpRemoteReturnInfo(stationVo);
		}
		
		stationVo.setLang(request.getLocale().getLanguage());
		
		// 수정할때만 적용
//		if (  stationVo.getCmd().equals("UPDATE") ) setNotice(stationVo);	
		
		rt = "성공";	bResult = true;
		model.put("rtMsg",	rt );
		
		return bResult ? "redirect:/admin/manage/station/stationGrpRemoteReturnList.do" : IConstants.ERROR_PAGE;
	}
	
	
	private void setNotice(StationMgmtVO stationVo) {
		
		NoticeVO nVo = new NoticeVO();
		nVo.setNoticeStationId(nVo.getNoticeStationId());
		int isInsertedNoti = stationMgmtService.getStationNotiCnt(stationVo);
		
		// 공지사항 미등록	
	 
			switch ( stationVo.getStation_use_yn() ) {
			case "T" :					// 임시폐쇄
			case "S" :
				// 대여소 정보 설정
				setNotice( stationVo, stationVo.getStation_use_yn(), stationVo.getUnuse_str_dttm(), stationVo.getReason().replace(",", ""), stationVo.getNameList().get(0));
				
				// 공지사항 내역 존재여부 체크
				if ( isInsertedNoti > 0 ) {
					// 같은 대여소 공지 업데이트  
					stationMgmtService.editTmpCloseNoti(stationVo);
				} else {
					// 공지 새로 등록
					stationMgmtService.addTmpCloseNoti(stationVo);
					// 공지사항 등록 이력 생성
					stationMgmtService.insertTbOprStationNoti(stationVo);
				}	
			break;		
			case "Y" :
				
				// 공지사항 내역 존재체크 
				if ( isInsertedNoti > 0 ) {
					stationMgmtService.deleteTbOprStationNoti(stationVo);
				}
				
				stationMgmtService.NoTmpCloseNoti(stationVo); 	// 공지 해제
				
				// TODO 대상 없음
				// stationMgmtService.deleteTmpCloseSms(smsMsgVo); // 사용으로 전환시 알림톡 내역 삭제
				
			break;	
			}
			
		}
	
	private void setNotice(StationMgmtVO stationVo, String station_use_yn, String strdttm, String reason, String StaName) {
		
		String stationStatus = "";
		
		switch ( station_use_yn ) {
		case "T" : stationStatus = "임시 폐쇄";				break;
		case "S" : stationStatus = "임시 폐쇄(예정)";			break;
		}
		
		stationVo.setTitle( StaName + " 대여소 "  + stationStatus + " 안내");
		
		StringBuilder sb = new StringBuilder();
		sb.append("안녕하세요? \r\n");
		sb.append("아파트 자전거 바로클입니다. \r\n");
		sb.append("\r\n");
		sb.append("\r\n");
		sb.append("아래 대여소를 ");
		sb.append(stationStatus);
		
		sb.append("하오니 \r\n");
		sb.append("이용에 착오 없으시길 바랍니다. \r\n");
		sb.append("\r\n");
		sb.append("\r\n");
		sb.append(stationStatus);
		sb.append("대여소 : ");
		sb.append(StaName);
		sb.append("\r\n");
		sb.append("사용중단기간 : ");
		sb.append(strdttm);
		sb.append(" ~ ");
		sb.append(reason);
		sb.append(" 조치완료 시까지 \r\n");
		
		sb.append("사용중단사유 : ");
		sb.append(reason);
		sb.append("\r\n");
		sb.append("\r\n");
		sb.append("\r\n");
		sb.append("이용에 불편드려 죄송합니다. \r\n");
		sb.append("※ 불편사항 또는 문의사항 연락처 : 02-542-7781 \r\n");
		  
		stationVo.setText(sb.toString());
		stationVo.setHtml(sb.toString().replaceAll("\r\n", "<br>") );
	}
	
	private int sendSmsUserList(StationMgmtVO stationVo,  String station_use_yn, String strdttm, String reason, String StaName) {
		
		String msg = ""; 
		SendType sType = null; 

		switch ( station_use_yn ) {
		case "T" : sType = SendType.SMS_097;	msg = "SMS_097";		break;
		case "S" : sType = SendType.SMS_099;	msg = "SMS_099";		break;
		}
		
		SmsMessageVO smsMsgVo;
		String name;
		// 알림톡 
		List<SmsMessageVO> smsInfo = stationMgmtService.getUsrList(stationVo); // 알림톡 대상 사용자 목록 
		int cnt = smsInfo.size();// 알림톡 전송 건수
			
		name = StaName;
			
		Date dt = new Date();
			
		SimpleDateFormat sDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Calendar cal = Calendar.getInstance();
			
		cal.setTime(dt);
		
		switch ( station_use_yn ) {
		case "T" : cal.add(Calendar.HOUR, 1);		break;
		case "S" : cal.add(Calendar.DATE, +1); 		break;
		}
		
		String today = null;
		today = sDate.format(cal.getTime()); 
			
		List<SmsMessageVO> smsList = new ArrayList<SmsMessageVO>();
		smsMsgVo = new SmsMessageVO();
		
		if(smsInfo.size() > 0 ){
			for(int i=0;i<smsInfo.size();i++) {
				smsMsgVo.setUsr_seq(smsInfo.get(i).getUsr_seq());
				smsMsgVo.setUsr_mpn_no(smsInfo.get(i).getUsr_mpn_no());
				
				smsMsgVo.setMsg(sType, name ,strdttm, reason);
				smsMsgVo.setReqdttm(today);
				stationVo.setTemplateCd(msg);
				smsMsgVo.setStation_id(stationVo.getStation_id());
				smsMsgVo.setAutoSendId(stationVo.getTemplateCd());
				
				stationMgmtService.addTmpCloseSms(smsMsgVo);	// 알림톡 전송 내용 정보 테이블 입력
				stationMgmtService.addTmpCloseSmsDtl(smsMsgVo); // 알림톡 전송 대상자 정보 테이블  입력 
					
				smsList.add(smsMsgVo); 
			} 
		}
		return cnt;
	}

	private void sendAdminSms(StationMgmtVO stationVo, String station_use_yn, String strdttm, String StaName, int cnt) {
		
		String stationStatus = "";
		
		switch ( station_use_yn ) {
		case "T" : stationStatus = "임시 폐쇄";				break;
		case "S" : stationStatus = "임시 폐쇄(예정)";			break;
		}
		
		// 관리자 문자전송 
		Set<String> smsSet = new HashSet<String>();
		
		smsSet.add("01051625065"); // 유상준
		smsSet.add("01063085882"); // 김상선
		smsSet.add("01077950232"); // 양재영
		smsSet.add("01025105693"); // 강명석 
		
		for( String target : smsSet ) {
			
			stationVo.setMsg(StaName + " 대여소가 " +  strdttm + " 부터 " + stationStatus + "되었습니다. " + cnt + " 건의 알림톡이 발송되었습니다. ");
			stationVo.setDestno(target);
			stationMgmtService.insertTmpCloseSmsAdm(stationVo); // 임시폐쇄 안내문자 전송 
		}
	}
	
	/**
	 * 정거장 등록 
	 * @param manager
	 * @param result
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestName(value="groupStationList")
	@RequestMapping(value="groupStationList")
	public String groupStationList(StationMgmtVO stationVo, BindingResult result, ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		stationVo.setLang(request.getLocale().getLanguage());
		logger.debug(stationVo);
		
		List<StationMgmtVO> nameList = stationMgmtService.groupStationList(stationVo);
		
		model.put("nameList", nameList);
		
		return IConstants.JSONVIEW;
		
	}
	
	/**
	 * 비콘 중복체크
	 * @param manager
	 * @param result
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestName(value="beaconCheck")
	@RequestMapping(value="beaconCheck")
	public String beaconCheck(StationMgmtVO stationVo, BindingResult result, ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		String rt = stationMgmtService.beaconCheck(stationVo);
		model.put("result", rt);
		
		return IConstants.JSONVIEW;
		
	}
	

}
