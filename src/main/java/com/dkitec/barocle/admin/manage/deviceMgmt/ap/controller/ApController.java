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
package com.dkitec.barocle.admin.manage.deviceMgmt.ap.controller;

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
import com.dkitec.barocle.admin.manage.deviceMgmt.ap.service.ApService;
import com.dkitec.barocle.admin.manage.deviceMgmt.ap.vo.ApVO;
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
@RequestCategory(value="ApController")
public class ApController extends BaseController {
	
	protected static Logger log = LoggerFactory.getLogger(ApController.class);
	@Resource(name = "apService") private ApService apService;
	
	private static final String RETUR_URL = "/admin/manage/service/ap/";
	
	@RequestMapping(value = "/getApList.do")
	@RequestName("getApList")
	public String getApList(@ModelAttribute @Valid ApVO apVo, BindingResult bResult, ModelMap model, HttpServletRequest request ) throws Exception {
		
    	String targetUrl = RETUR_URL.concat("opr_ap_list");
    	String bizName = "AP 조회 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        boolean result = false;
        String todayDate = DateUtil.getSystemDate("yyyy-MM-dd");
        if (apVo.getSearchBgnDe() == null || apVo.getSearchBgnDe() == ""){
        	apVo.setSearchBgnDe(todayDate.substring(0, 4)+"-01-01");
        }
        if (apVo.getSearchEndDe() == null || apVo.getSearchEndDe() == ""){
        	apVo.setSearchEndDe(todayDate);
        }
        try {
			if( apVo.getStationGrpSeq() != null && apVo.getStationGrpSeq() != "" && apVo.getStationId().equals("")) {
				apVo.setStationIdList(apService.getStation(apVo.getStationGrpSeq()));
			}
			if(apVo.getViewFlg() != null && apVo.getViewFlg().equals(MODE_EXCEL)) {
				apVo.setPagingYn("N");
			} 
			int sizeList = apService.getApListCount(apVo);
			
			PaginationInfo paginationInfo = getPagingInfo(apVo.getCurrentPageNo(), sizeList);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(apVo.getCurrentPageNo(), sizeList);
			apVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			apVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<ApVO> resultList = apService.getApList(apVo);
			
			model.addAttribute("searchCondition",apVo );
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo",paginationMobileInfo);
			model.addAttribute("APList", resultList);
			result =true;
        }catch(Exception e) {
        	throw new CfoodException(getMessage("fail.common.msg"));
        }
		
		if(apVo.getViewFlg().equals(MODE_EXCEL)) {
			targetUrl =  RETUR_URL.concat("opr_ap_list_excel");
		}
		
		return result ? targetUrl : ERROR_PAGE;
	}
	
	
	@RequestMapping(value = "/moveAPEditForm.do")
	@RequestName("moveAPEditForm")
	public String moveAPEditForm(@ModelAttribute ApVO apVo, ModelMap model, HttpServletRequest request )  throws Exception {
		String bizName = "AP 등록,수정 화면 이동";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        boolean result = false;
        try {
			ApVO resultVo = null;
			if(apVo.getViewFlg().equals(CRUD_C)) {
				resultVo = new ApVO();
			} else {
				resultVo = apService.getAPInfo(apVo);
			}
			model.addAttribute("apVo", resultVo);
			model.addAttribute("ap", apVo);
			result = true;
		} catch (Exception e) {
			throw new CfoodException(getMessage("fail.common.msg"));
		}
		
		
		return result ? RETUR_URL.concat("opr_ap_detail") : ERROR_PAGE;
	}
	
	@RequestMapping(value="/exeAPDeviceAjax.do")
	@RequestName("addAPDevice")
	public String addAPDevice(@ModelAttribute @Valid ApVO apVo, BindingResult bResult, ModelMap model, HttpServletRequest request ) throws Exception  {

		String bizName = "AP 등록,수정 처리";
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
				//TODO : session에서 관리자 Id 셋팅.
				UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
				apVo.setLocateAdminId(userSessionVO.getUsrId());

				if(apVo.getViewFlg().equals(CRUD_C)) {
					
					boolean isDupChk = apService.isChkIdDup(apVo);
					if(!isDupChk) {
						//apVo.setDeviceId(null);
						if(apVo.getLocateClsCd().equals("S")) {
							isDupChk = apService.isStationAPExist(apVo);
						}
						if(!isDupChk) {
							result = apService.addAPDevice(apVo);
						} else {
							resultMsg="등록 대여소에 AP가 존재합니다.";
						}
					} else {
						resultMsg="기존등록된 AP가 존재합니다.";
					}
				} else {
					ApVO preData = apService.getApHistoryInfo(apVo);
					boolean isApExist = false; 
					if(!apVo.getLocateClsCd().equals(preData.getLocateClsCd()) && apVo.getLocateClsCd().equals("S")) {
						isApExist = apService.isStationAPExist(apVo);
						if(isApExist) {
							resultMsg="등록 대여소에 AP가 존재합니다.";
						}
					}
					if(!isApExist) {
						preData.setLocateAdminId(userSessionVO.getUsrId());
						result = apService.setAPDevice(apVo, preData);
					}
					
				}
			}
		} catch (Exception e) {
			throw new CfoodException(getMessage("fail.common.msg"));
			
		}
		model.addAttribute(RESULT_MESSAGE, resultMsg);
		model.addAttribute(CHECK_RESULT, result);
		return JSONVIEW;
	}
	
	
	@RequestMapping(value="/ap/dupIdCheckAjax.do")
	@RequestName("dupIdCheckAjax")
	public String dupIdCheckAjax(@ModelAttribute ApVO apVo, ModelMap model, HttpServletRequest request )  throws Exception {
		String bizName = "AP Id 중복 체크";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        
		boolean isDup = false;
		isDup = apService.isChkIdDup(apVo);
		model.addAttribute("isDup", String.valueOf(isDup));
		return JSONVIEW;
	}
	
	@RequestMapping(value="/ap/regularChkReg.do")
	public String regualarChkReg(@ModelAttribute ApVO apVo, ModelMap model, HttpServletRequest request) throws Exception {
		String bizName = "AP 정기점검 일괄등록 중복 체크";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		List<ApVO> apList = null;
		UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
		int result = 0;
		try {
			 if(apVo.getChkType().equals("all")) {
				 apVo.setPagingYn(N);
				 apList = apService.getApList(apVo);
			 } else {
				 apList = apVo.getApList();
			 }
			 result = apService.setRegularChkComplete(apList, userSessionVO.getUsrId());
		} catch (Exception e) {
			throw new CfoodException(getMessage("fail.common.msg"));
		}
		
		model.addAttribute(CHECK_RESULT, result);
		return JSONVIEW;
	}

}
