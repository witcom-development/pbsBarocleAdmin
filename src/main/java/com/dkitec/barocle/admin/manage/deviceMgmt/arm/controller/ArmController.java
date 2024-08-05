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
package com.dkitec.barocle.admin.manage.deviceMgmt.arm.controller;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.admin.login.vo.UserSessionVO;
import com.dkitec.barocle.admin.manage.deviceMgmt.arm.service.ArmService;
import com.dkitec.barocle.admin.manage.deviceMgmt.arm.vo.ArmVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.DateUtil;
import com.dkitec.barocle.util.webutil.HttpUtil;
import com.dkitec.barocle.util.webutil.StringUtil;

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
@RequestCategory(value="ArmController")
public class ArmController extends BaseController {
	
	protected static Logger log = LoggerFactory.getLogger(ArmController.class);
	@Resource(name = "armService") private ArmService armService;
	private static final String RETURN_URL = "/admin/manage/service/lock/";

	@RequestMapping(value = "/getArmList.do")
	@RequestName("getArmList")
	public String getArmList(@ModelAttribute ArmVO armVo, ModelMap model, HttpServletRequest request ) throws Exception  {
		
		String targetUrl = RETURN_URL.concat("opr_std_list");
    	String bizName = "거치대 조회 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        
        List<ArmVO> resultList = null;
        
        String todayDate = DateUtil.getSystemDate("yyyy-MM-dd");
        if (armVo.getSearchBgnDe() == null || armVo.getSearchBgnDe() == ""){
        	armVo.setSearchBgnDe(todayDate.substring(0, 4)+"-01-01");
        }
        if (armVo.getSearchEndDe() == null || armVo.getSearchEndDe() == ""){
        	armVo.setSearchEndDe(todayDate);
        }
        
		if( armVo.getViewFlg().equals(MODE_EXCEL)) {
			armVo.setPagingYn("N");
		}
		//페이징 처리 여부
		if(armVo.getStationId() != null &&( !armVo.getStationGrpSeq().equals("") && armVo.getStationId().equals(""))) {
			armVo.setStationIdList(armService.getStation(armVo.getStationGrpSeq()));
		}
		
		int totCnt = armService.getArmListCount(armVo);
		
		PaginationInfo paginationInfo = getPagingInfo(armVo.getCurrentPageNo(), totCnt);
		PaginationInfo paginationMobileInfo = getPagingMobileInfo(armVo.getCurrentPageNo(), totCnt);
		armVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
		armVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		resultList = armService.getArmList(armVo);
		
		model.addAttribute("searchCondition",armVo );
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("paginationMobileInfo",paginationMobileInfo);
		model.addAttribute("ArmList", resultList);
		
		if(armVo.getViewFlg() != null && armVo.getViewFlg().equals(MODE_EXCEL)) {
			targetUrl = RETURN_URL.concat("opr_std_list_excel");
		}
		
		return targetUrl;
	}
	
	@RequestMapping(value = "/moveArmEditForm.do")
	@RequestName("moveArmEditForm")
	public String moveArmEditForm(@ModelAttribute ArmVO armVo, ModelMap model, HttpServletRequest request ) throws Exception {
		String bizName = "거치대 상세 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		ArmVO resultVo = null;
		if(armVo.getViewFlg().equals(CRUD_C)) {
			resultVo = new ArmVO();
		} else {
			resultVo = armService.getArmInfo(armVo);
		}
		model.addAttribute("arm", armVo);
		model.addAttribute("armInfo", resultVo);
		
		return RETURN_URL.concat("opr_std_detail");
	}
	
	@SuppressWarnings("unused")
	@RequestMapping(value="/exeArmDeviceAjax.do")
	@RequestName("addArmDevice")
	public String addArmDevice(@ModelAttribute @Valid ArmVO armVo, BindingResult bResult, ModelMap model, HttpServletRequest request ) throws Exception {
		String bizName = "거치대 등록 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		int result = 0;
		//TODO: session에 등록된 관리자 ID로 셋팅.
		UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
		String admin = userSessionVO == null ? "test" :userSessionVO.getUsrId();
		armVo.setAdminId(admin);
		String resultMsg = "저장에 성공했습니다.";
		
		try {
			if(bResult.hasErrors()) {
				for(ObjectError e :  bResult.getAllErrors()) {
					resultMsg = e.getDefaultMessage();
				}
			} else {
				boolean isEquipExist  = false;
				ArmVO info = armService.getArmLocateInfo(armVo.getRackId());
				//최초 등록시에는 스테이션으로 등록을 할경우 거치대 번호 체크
				//센터->대여소 변경시 체크, 대여소가 변경 되었을 경우에도 체크
				if(info != null && (armVo.getLocateClsCd().equals("S") && !armVo.getStationEquipOrder().equals(info.getStationEquipOrder())
						|| (info.getLocateClsCd().equals("C") && armVo.getLocateClsCd().equals("S"))
						|| (info.getLocateClsCd().equals(armVo.getLocateClsCd()) && !info.getLocateId().trim().equalsIgnoreCase(armVo.getLocateId().trim())))) {
					//등록할려고 하는 스테이션의 거치대 번호를 체크.
					isEquipExist = armService.isEquipExist(armVo);
					result = -1;
				}
				if(isEquipExist) {
					resultMsg = "이미 등록되어있는 거치대 번호입니다.";
				} else {
					if(armVo.getViewFlg().equals(CRUD_C)) {
						result = armService.addArmDevice(armVo);
					} else {
						result = armService.setArmDevice(armVo, info);
					}
				}
			}
		} catch (Exception e) {
			throw new CfoodException(getMessage("fail.common.msg"));
		}
		
		
		model.addAttribute(RESULTMSG, resultMsg);
		model.addAttribute(CHECK_RESULT, result);
		return JSONVIEW;
	}
	
	@RequestMapping(value="/arm/dupIdCheckAjax.do")
	@RequestName("dupIdCheckAjax")
	public String dupIdCheckAjax(@RequestParam(value="rackId") String rackId, ModelMap model, HttpServletRequest request ) throws Exception {
		String bizName = "거치대 ID 중복 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        
		boolean isDup = false;
		try {
			isDup = armService.isChkIdDup(rackId);
			model.addAttribute("isDup", String.valueOf(isDup));
		} catch (Exception e) {
			throw new CfoodException(getMessage("fail.common.msg"));
		}
		return JSONVIEW;
	}
	@RequestMapping(value="/arm/regularChkReg.do")
	@RequestName("armRegularChkReg")
	public String armRegularChkReg(@ModelAttribute @Valid ArmVO armVo, BindingResult bResult, ModelMap model, HttpServletRequest request ) throws Exception {
		String bizName = "정기점검 등록";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
		int result  =0;
		List<ArmVO> resultList = null;
		try {
			if(armVo.getChkType() != null && armVo.getChkType().equals("all")) {
				armVo.setPagingYn(N);
				resultList = armService.getArmList(armVo);
			} else {
				resultList = armVo.getArmList();
			}
			result = armService.setArmLasChkDttm(resultList, userSessionVO.getUsrIp());
		} catch (Exception e) {
			throw new CfoodException(getMessage("fail.common.msg"));
		}
		model.addAttribute(CHECK_RESULT, result);
		return JSONVIEW;
	}
}
