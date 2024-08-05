package com.dkitec.barocle.admin.manage.stationgroup.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.admin.login.vo.UserSessionVO;
import com.dkitec.barocle.admin.manage.stationgroup.service.StationGroupMgmtService;
import com.dkitec.barocle.admin.manage.stationgroup.vo.StationGroupMgmtVO;
import com.dkitec.barocle.admin.manage.stationgroup.vo.StationGroupMgmtVO.groupName_DuplCheck;
import com.dkitec.barocle.admin.manage.stationgroup.vo.StationGroupMgmtVO.searchCheck;
import com.dkitec.barocle.admin.manage.stationgroup.vo.StationGroupMgmtVO.seqCheck;
import com.dkitec.barocle.admin.manage.stationmgmt.service.StationMgmtService;
import com.dkitec.barocle.admin.manage.stationmgmt.vo.StationMgmtVO;
import com.dkitec.barocle.admin.system.commonCodeMgmt.service.CommonCodeService;
import com.dkitec.barocle.admin.system.commonCodeMgmt.vo.CommonCodeVO;
import com.dkitec.barocle.base.IConstants;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/** 
 * 관리자 스테이션 그룹관리 Controller
 * file	: StationStatusController.java
 * date	: 2015. 4. 17.
 * 
 **/


@Controller
@RequestCategory(value="StationGroupMgmtController")
@RequestMapping(value="/admin/manage/stationGroup")
public class StationGroupMgmtController {
	private Logger logger = Logger.getLogger(this.getClass());
	@Resource(name = "propertiesService") protected EgovPropertyService propertiesService;
	@Resource(name = "commonCodeService") private CommonCodeService commonCodeService;
	@Resource(name = "stationMgmtService") protected StationMgmtService stationMgmtService;
	@Resource(name = "stationGroupMgmtService") protected StationGroupMgmtService stationGroupMgmtService;
	
	/**
	 * 공통 리턴화면 
	 * @param methodName
	 * @return
	 */
	protected String getReturnUrl(String methodName) {
		return "/admin/manage/stationGroup/" + methodName;
	}
	
	/**
	 * 스테이션그룹(아파트) 관리 목록 조회
	 * @param manager
	 * @param result
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestName(value="stationGroupList")
	@RequestMapping(value="stationGroupList")
	public String stationGroupList(@Validated(searchCheck.class)  StationGroupMgmtVO stationVo, BindingResult result, ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		logger.debug(stationVo);
		logger.debug(stationVo.getCurrentPageNo());
		
		if (!result.hasErrors()) {
			model.put("result", "");
		} else {
			logger.debug(result.getAllErrors().get(0).getDefaultMessage());
			model.put("result", result.getAllErrors().get(0).getDefaultMessage());
			return getReturnUrl("opr_stg_list");
		}
		
		stationVo.setLang(request.getLocale().getLanguage());
		
		
		List<StationGroupMgmtVO> list =  null;
		boolean bResult = false;
		
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
			// 전체 카운트 조회
			paginationInfo.setTotalRecordCount(stationGroupMgmtService.getStationGroupListCnt(stationVo));
			paginationMobileInfo.setTotalRecordCount(stationGroupMgmtService.getStationGroupListCnt(stationVo));
			// 목록 조회
			list = stationGroupMgmtService.getStationGroupList(stationVo);
			
			bResult = true;
		} catch (Exception e) {
			e.printStackTrace();
			new CfoodException("admin.manage.stationgroup.stationGroupList");
		}
		// total count
		
		logger.info(list);
		
		model.put("list",	list );
		model.put("searchVO",stationVo );
		model.put("paginationInfo", paginationInfo);
		model.put("paginationMobileInfo", paginationMobileInfo);
		
		return bResult? getReturnUrl("opr_stg_list"): IConstants.ERROR_PAGE;
		
	}
	
	/**
	 * 스테이션그룹(아파트) 등록 화면 이동
	 * @param manager
	 * @param result
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestName(value="stationGroupRegist")
	@RequestMapping(value="stationGroupRegist", method = RequestMethod.POST)
	public String stationGroupRegist(StationGroupMgmtVO stationVo, BindingResult result, ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		boolean bResult = false;
		CommonCodeVO cVo = new CommonCodeVO();
		List<CommonCodeVO> codeList = null;
		
		cVo.setComUpCd("LAG");
		cVo.setLang(IConstants.LANG_KR);
		
		try {
			// 언어 공통코드 조회
			codeList = commonCodeService.getComCodeInfo(cVo);
			bResult = true;
		} catch (Exception e) {
			e.printStackTrace();
			new CfoodException("admin.manage.stationgroup.stationGroupRegist");
		}
		
 		model.put("codeList", codeList);
		model.put("cmd", "INSERT");
		
		return bResult? getReturnUrl("opr_stg_detail"): IConstants.ERROR_PAGE;
		
	}
	
	
	
	/**
	 * 스테이션그룹명(아파트명) 중복 체크
	 * @param manager
	 * @param result
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestName(value="stationGroupNameCheck")
	@RequestMapping(value="stationGroupNameCheck")
	public String stationGroupNameCheck(@Validated(groupName_DuplCheck.class) StationGroupMgmtVO stationVo, BindingResult result, ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		logger.debug(stationVo.getStation_grp_name());
		
		if (!result.hasErrors()) {
			model.put("result", "");
		} else {
			model.put("result", result.getAllErrors().get(0).getDefaultMessage());
			return getReturnUrl("opr_stg_list");
		}
		
		// 그룹명 중복검사
		String rt = stationGroupMgmtService.stationGroupNameCheck(stationVo);
		
		model.put("result", rt);
		
		return IConstants.JSONVIEW;
		
	}
	
	
	/**
	 * 스테이션그룹(아파트) 등록 
	 * @param manager
	 * @param result
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestName(value="stationGroupModify")
	@RequestMapping(value="stationGroupModify", method = RequestMethod.POST)
	public String stationGroupModify(@Validated(seqCheck.class) StationGroupMgmtVO stationVo, BindingResult result, ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		if (!result.hasErrors()) {
			model.put("result", "");
		} else {
			model.put("result", result.getAllErrors().get(0).getDefaultMessage());
			return getReturnUrl("opr_stg_detail");
		}
		
		String rt = "";
		try {
			
			UserSessionVO userSessionVO = (UserSessionVO) EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
			
			stationVo.setUser(userSessionVO.getUsrId());
			stationVo.setLang(request.getLocale().getLanguage());
			// 등록/수정/삭제 처리
			stationGroupMgmtService.stationGroupModify(stationVo);
			rt = "성공";
		} catch (Exception e) {
			e.printStackTrace();
			rt = "실패";
		}
		
		logger.info("결과  : " + rt);
		model.put("rtMsg",	rt );
		
		return IConstants.JSONVIEW;
		
	}
	
	
	/**
	 * 스테이션그룹(아파트)상세조회 
	 * @param manager
	 * @param result
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestName(value="stationGroupInfo")
	@RequestMapping(value="stationGroupInfo", method = RequestMethod.POST)
	public String stationGroupInfo(StationGroupMgmtVO stationVo, BindingResult result, ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		logger.info(stationVo);
		
		StationGroupMgmtVO info = null;
		List<StationGroupMgmtVO> multiLang = null;
		List<CommonCodeVO> codeList = null;
		List<StationMgmtVO> stationList = null;
		boolean bResult = false;
		
		try {
			
			UserSessionVO userSessionVO = (UserSessionVO) EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
			logger.debug(userSessionVO);
			stationVo.setUser(userSessionVO.getUsrId());
			stationVo.setLang(request.getLocale().getLanguage());
			
			// 상세정보 조회
			info = stationGroupMgmtService.getstationGroupInfo(stationVo);
			
			// 다국어명 조회
			stationVo.setLang(null);
			multiLang = stationGroupMgmtService.getMultiStationGroupList(stationVo);
			
			StationMgmtVO vo = new StationMgmtVO();
			vo.setStation_grp_seq(stationVo.getStation_grp_seq());
			vo.setLang(request.getLocale().getLanguage());
			// 해당 그룹에 속한 대여소 조회
			stationList= stationMgmtService.getGroupStationList(vo);
			
			logger.info(multiLang);
			
			CommonCodeVO cVo = new CommonCodeVO();
			cVo.setComUpCd("LAG");
			cVo.setLang(IConstants.LANG_KR);
			// 공통코드 조회
			codeList = commonCodeService.getComCodeInfo(cVo);
			
			bResult = true;
			
		} catch (Exception e) {
			e.printStackTrace();
			new CfoodException("admin.manage.stationgroup.stationGroupInfo");
		}
		
 		model.put("codeList", codeList);
		model.put("info", info);
		model.put("multiLang", multiLang);
		model.put("stationList", stationList);
		model.put("cmd", "INFO");
		
		return bResult? getReturnUrl("opr_stg_detail") : IConstants.ERROR_PAGE;
		
	}
	
	

}
