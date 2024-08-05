/*
 * @Package Name : com.dkitec.barocle.admin.manage.DeviceMgmt.controller
 * @파일명		  : DeviceMgmtController.java
 * @작성일		  : 2015. 4. 15.
 * @작성자		  : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *	  수정일	  |	  수정자	  |			  수정내용
 * -------------------------------------------------------------
 *	2015. 4. 15.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.manage.deviceMgmt.beacon.controller;

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
import com.dkitec.barocle.admin.manage.deviceMgmt.ap.vo.ApVO;
import com.dkitec.barocle.admin.manage.deviceMgmt.beacon.service.BeaconService;
import com.dkitec.barocle.admin.manage.deviceMgmt.beacon.vo.BeaconVO;
import com.dkitec.barocle.admin.manage.stationgroup.service.StationGroupMgmtService;
import com.dkitec.barocle.admin.manage.stationgroup.vo.StationGroupMgmtVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.DateUtil;
import com.dkitec.barocle.util.webutil.HttpUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * @파일명		  : DeviceMgmtController.java
 * @작성일		  : 2015. 4. 15.
 * @작성자		  : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *	  수정일	  |	  수정자	  |			  수정내용
 * -------------------------------------------------------------
 *	2015. 4. 15.   |   ymshin   |  최초작성
 */
@Controller
@RequestCategory(value="BeaconController")
public class BeaconController extends BaseController {
	protected static Logger log = LoggerFactory.getLogger(BeaconController.class);
	
	@Resource(name="beaconService") private BeaconService beaconService;
	@Resource(name="stationGroupMgmtService") private StationGroupMgmtService stationGroupMgmtService;
	
	private static final String RETURN_URL = "/admin/manage/service/beacon/";
	
	@RequestMapping(value = "/getBeaconList.do")
	@RequestName("getBeaconList")
	public String getBeaconList(@ModelAttribute @Valid BeaconVO beaconVo,BindingResult bResult ,HttpServletRequest request,ModelMap model) throws Exception {
		
		String targetUrl = RETURN_URL.concat("opr_bea_list");
		String bizName = "비콘 목록 화면";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		List<StationGroupMgmtVO> group = null;
		boolean result = false;
		String todayDate = DateUtil.getSystemDate("yyyy-MM-dd");
		if (beaconVo.getSearchBgnDe() == null || beaconVo.getSearchBgnDe() == ""){
			beaconVo.setSearchBgnDe(todayDate.substring(0, 4)+"-01-01");
		}
		if (beaconVo.getSearchEndDe() == null || beaconVo.getSearchEndDe() == ""){
			beaconVo.setSearchEndDe(todayDate);
		}
		//전체검색을 위한 코드 변경
		
		//그룹 조회
		StationGroupMgmtVO vo = new StationGroupMgmtVO();
		vo.setLang(request.getLocale().getLanguage());
		// 그룹명 조회
		
		try {
			if(beaconVo.getViewFlg().equals(MODE_EXCEL)) {
				beaconVo.setPagingYn("N");
			}
			int totCnt = beaconService.getBeaconListCount(beaconVo);
			PaginationInfo paginationInfo = getPagingInfo(beaconVo.getCurrentPageNo(), totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(beaconVo.getCurrentPageNo(), totCnt);
			beaconVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			beaconVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<BeaconVO> resultList = beaconService.getBeaconList(beaconVo);
			model.addAttribute("searchCondition",beaconVo );
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo",paginationMobileInfo);
			model.addAttribute("BeaconList", resultList);
			group = stationGroupMgmtService.getStationGroupNameList(vo);
			model.addAttribute("group", group);
			if(beaconVo.getViewFlg().equals(MODE_EXCEL)) {
				targetUrl = RETURN_URL.concat("opr_bik_list_excel");
			}
			result = true;
		} catch (CfoodException e){
			throw new CfoodException(getMessage("fail.common.msg"));
		}
		
		return result ? targetUrl : ERROR_PAGE;
	}
	
	@RequestMapping(value = "/moveBeaconEditForm.do")
	@RequestName("moveBeaconEditForm")
	public String moveBeaconEditForm(@ModelAttribute BeaconVO beaconVo, ModelMap model, HttpServletRequest request )  throws Exception {
		String bizName = "BEACON 등록,수정 화면 이동";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		boolean result = false;
		try {
			BeaconVO resultVo = null;
			if(beaconVo.getViewFlg().equals(CRUD_C)) {
				resultVo = new BeaconVO();
			} else {
				resultVo = beaconService.getBeaconInfo(beaconVo);
			}
			model.addAttribute("beaconVo", resultVo);
			model.addAttribute("beacon", beaconVo);
			result = true;
		} catch (Exception e) {
			throw new CfoodException(getMessage("fail.common.msg"));
		}
		
		
		return result ? RETURN_URL.concat("opr_bea_detail") : ERROR_PAGE;
	}
	
	
	@RequestMapping(value="/beacon/dupIdCheckAjax.do")
	@RequestName("dupIdCheckAjax")
	public String dupIdCheckAjax(@ModelAttribute BeaconVO beaconVo, ModelMap model, HttpServletRequest request )  throws Exception {
		String bizName = "BEACON Id 중복 체크";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		boolean isDup = false;
		isDup = beaconService.isChkIdDup(beaconVo);
		model.addAttribute("isDup", String.valueOf(isDup));
		BeaconVO resultVo = null;
		beaconVo.setSerialNo(beaconVo.getChkId());
		resultVo = beaconService.getBeaconInfoBySerial(beaconVo);
		model.addAttribute("resultVo", resultVo);
		return JSONVIEW;
	}
	
	@RequestMapping(value="/exeBeaconDeviceAjax.do")
	@RequestName("addBEACONDevice")
	public String addBEACONDevice(@ModelAttribute @Valid BeaconVO beaconVo, BindingResult bResult, ModelMap model, HttpServletRequest request ) throws Exception  {

		String bizName = "BEACON 등록,수정 처리";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		int result = -1;
		String resultMsg = "저장에 성공했습니다.";
		UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
		if(userSessionVO == null){
			throw new CfoodException(getMessage("error.invalidSession"));
		}
		
		try {
			List<ObjectError> allError =  bResult.getAllErrors();
			if(allError.size() > 0) {
				for( ObjectError e : allError ) {
					resultMsg = e.getDefaultMessage();
				}
			} else {
				beaconVo.setRegId(userSessionVO.getUsrId());
				if(beaconVo.getViewFlg().equals(CRUD_C)) {
					result = beaconService.addBeaconDevice(beaconVo);
				} else {
					result = beaconService.setBeaconDevice(beaconVo);
				}
			}
		} catch (Exception e) {
			throw new CfoodException(getMessage("fail.common.msg"));
			
		}
		model.addAttribute(RESULT_MESSAGE, resultMsg);
		model.addAttribute(CHECK_RESULT, result);
		return JSONVIEW;
	}
	
	@RequestMapping(value="/beacon/matchingBeaconAjax.do")
	@RequestName("matchingBeacon")
	public String matchingBeacon(@ModelAttribute @Valid BeaconVO beaconVo, BindingResult bResult, ModelMap model, HttpServletRequest request ) throws Exception  {
		String bizName = "비콘 매칭 처리";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		int result = -1;
		String resultMsg = "저장에 성공했습니다.";
		
		try {
			List<ObjectError> allError =  bResult.getAllErrors();
			if(allError.size() > 0) {
				for( ObjectError e : allError ) {
					resultMsg = e.getDefaultMessage();
				}
			} else {
				result = beaconService.matchingBeacon(beaconVo);
			}
		} catch (Exception e) {
			throw new CfoodException(getMessage("fail.common.msg"));
		}
		model.addAttribute(RESULT_MESSAGE, resultMsg);
		model.addAttribute(CHECK_RESULT, result);
		return JSONVIEW;
	}
	
	@RequestMapping(value="/beacon/delConnBeaconAjax.do")
	@RequestName("delConnBeacon")
	public String delConnBeacon(@ModelAttribute @Valid BeaconVO beaconVo, BindingResult bResult, ModelMap model, HttpServletRequest request ) throws Exception  {
		String bizName = "BEACON 매칭 삭제";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		int result = -1;
		String resultMsg = "매칭 삭제가 완료되었습니다.";
		
		result = beaconService.delConnBeacon(beaconVo);
		
		model.addAttribute(RESULT_MESSAGE, resultMsg);
		model.addAttribute(CHECK_RESULT, result);
		return JSONVIEW;
	}
	
}
