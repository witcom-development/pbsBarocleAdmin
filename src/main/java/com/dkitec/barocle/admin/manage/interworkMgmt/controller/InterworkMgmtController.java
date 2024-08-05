package com.dkitec.barocle.admin.manage.interworkMgmt.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.admin.login.vo.UserSessionVO;
import com.dkitec.barocle.admin.manage.interworkMgmt.service.InterworkMgmtService;
import com.dkitec.barocle.admin.manage.interworkMgmt.vo.InterworkMgmtVO;
import com.dkitec.barocle.admin.manage.interworkMgmt.vo.InterworkMgmtVO.FwDeleteValid;
import com.dkitec.barocle.admin.manage.interworkMgmt.vo.InterworkMgmtVO.FwFileDeleteValid;
import com.dkitec.barocle.admin.manage.interworkMgmt.vo.InterworkMgmtVO.FwInsertValid;
import com.dkitec.barocle.admin.manage.interworkMgmt.vo.InterworkMgmtVO.FwUpdateValid;
import com.dkitec.barocle.admin.manage.interworkMgmt.vo.InterworkMgmtVO.FwVerCheckValid;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.HttpUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="InterworkMgmtController")
@RequestMapping(value="/admin/manage/interworkMgmt")
public class InterworkMgmtController extends BaseController {

	protected static Logger log = LoggerFactory.getLogger(InterworkMgmtController.class);
	
	@Resource(name="interworkMgmtService") private InterworkMgmtService interworkMgmtService;
	
	@RequestName(value="formCritical")
	@RequestMapping(value="/formCritical.do")
	public String formCritical(@ModelAttribute @Valid InterworkMgmtVO interworkMgmtVO, BindingResult bResult, ModelMap model, HttpServletRequest request) {
		
        boolean result = false;
    	String targetUrl = "/admin/manage/interwork/critical/opr_cri_detail";
    	String bizName = "임계치 기준관리 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        
        if(!bResult.hasErrors()) {
	        List<InterworkMgmtVO> criticalList = new ArrayList<InterworkMgmtVO>();
	        InterworkMgmtVO vo = null;
	        
	        vo = new InterworkMgmtVO();
	        vo.setCriticalName("배터리");
	        vo.setCriticalMinUseYn("N");
	        vo.setCriticalMin("30");
	        vo.setCriticalMaxUseYn("Y");
	        vo.setCriticalMax("80");
	        criticalList.add(vo);
	
	        vo = new InterworkMgmtVO();
	        vo.setCriticalName("CPU");
	        vo.setCriticalMinUseYn("Y");
	        vo.setCriticalMin("20");
	        vo.setCriticalMaxUseYn("N");
	        vo.setCriticalMax("750");
	        criticalList.add(vo);
	        
	//        List<InterworkMgmtVO> criticalList = interworkMgmtService.listCritical();
	        
	        model.addAttribute("criticalList", criticalList);
	        
	        result = true;
        }
        
        return result ? targetUrl : ERROR_PAGE;
	}

	@RequestName(value="modCritical")
	@RequestMapping(value="/modCritical.do")
	public String modCritical(@ModelAttribute @Valid InterworkMgmtVO interworkMgmtVO, BindingResult bResult, ModelMap model, HttpServletRequest request) {
		
        boolean result = false;
        String targetUrl = "redirect:/admin/manage/interworkMgmt/formCritical.do";
        String bizName = "임계치 기준 수정 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        
        if(!bResult.hasErrors()) {
        	interworkMgmtService.modCritical(interworkMgmtVO);
        	
        	result = true;
        }
        
        return result ? targetUrl : ERROR_PAGE;
	}
	
	/*@RequestName(value="listFirmware")
	@RequestMapping(value="/listFirmware.do")
	public String listFirmware(@ModelAttribute @Valid InterworkMgmtVO interworkMgmtVO, BindingResult bResult, ModelMap model, HttpServletRequest request) {
		
		boolean result = false;
        String targetUrl = "/admin/manage/interwork/fw/opr_fw_list";
        String bizName = "펌웨어 Update 목록 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        
        if(!bResult.hasErrors()) {
			interworkMgmtVO.setTotalRecordCount(interworkMgmtService.listFirmwareCount(interworkMgmtVO));
			
			PaginationInfo paginationInfo = getPagingInfo(interworkMgmtVO.getCurrentPageNo(), interworkMgmtVO.getTotalRecordCount());
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(interworkMgmtVO.getCurrentPageNo(), interworkMgmtVO.getTotalRecordCount());
			interworkMgmtVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			interworkMgmtVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<InterworkMgmtVO> firmwareList = interworkMgmtService.listFirmware(interworkMgmtVO);
			
			model.addAttribute("searchParam", interworkMgmtVO);
			model.addAttribute("firmwareList", firmwareList);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			
			result = true;
        }
        
        return result ? targetUrl : ERROR_PAGE;
	}*/
	//펌웨어 업데이트 접근 권한을 위한 변경_2017.03.27_JHN
	@RequestName(value="listFirmware")
	@RequestMapping(value="/listFirmware.do")
	public String listFirmware(@ModelAttribute @Valid InterworkMgmtVO interworkMgmtVO, BindingResult bResult, ModelMap model, HttpServletRequest request) throws Exception {
		
		boolean result = false;
        String targetUrl = "/admin/manage/interwork/fw/opr_fw_list";
        String bizName = "펌웨어 Update 목록 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        
        //추가 : 접근권한을 확인하기 위해_2017.03.27_JHN
        UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
        
        try {
		        if(!bResult.hasErrors()) {
					interworkMgmtVO.setTotalRecordCount(interworkMgmtService.listFirmwareCount(interworkMgmtVO));
					
					PaginationInfo paginationInfo = getPagingInfo(interworkMgmtVO.getCurrentPageNo(), interworkMgmtVO.getTotalRecordCount());
					PaginationInfo paginationMobileInfo = getPagingMobileInfo(interworkMgmtVO.getCurrentPageNo(), interworkMgmtVO.getTotalRecordCount());
					interworkMgmtVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
					interworkMgmtVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
					
					List<InterworkMgmtVO> firmwareList = interworkMgmtService.listFirmware(interworkMgmtVO);
					
					model.addAttribute("searchParam", interworkMgmtVO);
					model.addAttribute("firmwareList", firmwareList);
					model.addAttribute("paginationInfo", paginationInfo);
					model.addAttribute("paginationMobileInfo", paginationMobileInfo);
					model.addAttribute("userSessionVO", userSessionVO);//추가_2017.03.27_JHN
					
					result = true;
		        }
        } catch(Exception e) {
        	result = false;
        }
        
        return result ? targetUrl : ERROR_PAGE;
	}

	@RequestName(value="listFirmwareUpdateResult")
	@RequestMapping(value="/listFirmwareUpdateResult.do")
	public String listFirmwareUpdateResult(@ModelAttribute @Valid InterworkMgmtVO interworkMgmtVO, BindingResult bResult, ModelMap model, HttpServletRequest request) {
		
		boolean result = false;
        String targetUrl = "/admin/manage/interwork/fw/opr_fw_result";
        String bizName = "펌웨어 Update 결과 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        
        if(!bResult.hasErrors()) {
			interworkMgmtVO.setTotalRecordCount(interworkMgmtService.listFirmwareUpdateResultCount(interworkMgmtVO));
			
			PaginationInfo paginationInfo = getPagingInfo(interworkMgmtVO.getCurrentPageNo(), interworkMgmtVO.getTotalRecordCount());
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(interworkMgmtVO.getCurrentPageNo(), interworkMgmtVO.getTotalRecordCount());
			interworkMgmtVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			interworkMgmtVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<InterworkMgmtVO> firmwareUpdateResultList = interworkMgmtService.listFirmwareUpdateResult(interworkMgmtVO);
			
			model.addAttribute("searchParam", interworkMgmtVO);
			model.addAttribute("firmwareUpdateResultList", firmwareUpdateResultList);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			
			result = true;
        }
        
        return result ? targetUrl : ERROR_PAGE;
	}
	
	@RequestName(value="formFirmware")
	@RequestMapping(value="/formFirmware.do")
	public String formFirmware(@ModelAttribute @Valid InterworkMgmtVO interworkMgmtVO, BindingResult bResult, ModelMap model, HttpServletRequest request) {
		
        boolean result = false;
        String targetUrl = "/admin/manage/interwork/fw/opr_fw_detail";
        String bizName = "펌웨어 등록/수정/삭제 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        
        if(!bResult.hasErrors()) {
	        String viewFlg = interworkMgmtVO.getViewFlg();
	        
	        if("U".equals(viewFlg)) {
	        	InterworkMgmtVO firmware = interworkMgmtService.getFirmware(interworkMgmtVO);
	        	List<InterworkMgmtVO> firmwareFileList = interworkMgmtService.listFirmwareFile(interworkMgmtVO);
	        	boolean updateStartYn = interworkMgmtService.updateStartYn(interworkMgmtVO);
		        model.addAttribute("firmware", firmware);
		        model.addAttribute("firmwareFileList", firmwareFileList);
		        model.addAttribute("updateStartYn", updateStartYn);
	        } 
	        
	        model.addAttribute("viewFlg", viewFlg);
	        model.addAttribute("isSuccess", interworkMgmtVO.getIsSuccess());
	        
	        result = true;
        }
        
        return result ? targetUrl : ERROR_PAGE;
	}
	
	@RequestName(value="insertFirmwareFile")
	@RequestMapping(value="/insertFirmwareFile.do")
	public String insertFirmwareFile(@Validated(FwInsertValid.class) InterworkMgmtVO interworkMgmtVO, BindingResult bResult, ModelMap model, HttpServletRequest request) {
		
        boolean result = false;
        String targetUrl = "redirect:/admin/manage/interworkMgmt/formFirmware.do";
        String bizName = "펌웨어 등록/수정/삭제 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        
        if(!bResult.hasErrors()) {
        	boolean isSuccess = false;
        	isSuccess = interworkMgmtService.insertFirmwareFile(interworkMgmtVO);
        	model.addAttribute("isSuccess", String.valueOf(isSuccess));
        	model.addAttribute("firmwareSeq", interworkMgmtVO.getFirmwareSeq());
        	model.addAttribute("viewFlg", "I");
	        
	        result = true;
        }
		
		return result ? targetUrl : ERROR_PAGE;
	}
	
	@RequestName(value="modFirmware")
	@RequestMapping(value="/modFirmware.do")
	public String modFirmware(@Validated(FwUpdateValid.class) InterworkMgmtVO interworkMgmtVO, BindingResult bResult, ModelMap model, HttpServletRequest request) {
		
		boolean result = false;
        String targetUrl = "redirect:/admin/manage/interworkMgmt/formFirmware.do";
        String bizName = "펌웨어 등록/수정/삭제 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        
        if(!bResult.hasErrors()) {
        	boolean isSuccess = false;
        	isSuccess = interworkMgmtService.modFirmware(interworkMgmtVO);
        	model.addAttribute("isSuccess", String.valueOf(isSuccess));
        	model.addAttribute("firmwareSeq", interworkMgmtVO.getFirmwareSeq());
        	model.addAttribute("viewFlg", "U");
	        
	        result = true;
        }
		
		return result ? targetUrl : ERROR_PAGE;
	}
	
	@RequestName(value="delFirmwareFileAjax")
	@RequestMapping(value="/delFirmwareFileAjax.do")
	public String delFirmwareFileAjax(@Validated(FwFileDeleteValid.class) InterworkMgmtVO interworkMgmtVO, BindingResult bResult, ModelMap model, HttpServletRequest request) {
		
		String bizName = "펌웨어 파일 삭제";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        
		boolean isDel = false;
		isDel = interworkMgmtService.delFirmwareFile(interworkMgmtVO);
		model.addAttribute("isDel", String.valueOf(isDel));
		
		return JSONVIEW;
	}

	@RequestName(value="delFirmware")
	@RequestMapping(value="/delFirmware.do")
	public String delFirmware(@Validated(FwDeleteValid.class) InterworkMgmtVO interworkMgmtVO, BindingResult bResult, ModelMap model, HttpServletRequest request) {
		
		String bizName = "펌웨어 삭제";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        
		boolean isDel = false;
		isDel = interworkMgmtService.delFirmware(interworkMgmtVO);
		model.addAttribute("isDel", String.valueOf(isDel));
		
		return JSONVIEW;
	}
	
	@RequestName(value="chkFirmwareVerAjax")
	@RequestMapping(value="/chkFirmwareVerAjax.do")
	public String chkFirmwareVerAjax(@Validated(FwVerCheckValid.class) InterworkMgmtVO interworkMgmtVO, BindingResult bResult, ModelMap model, HttpServletRequest request) {
		
		String bizName = "상위 펌웨어 버전 확인";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        
		boolean isVerOk = false;
		isVerOk = interworkMgmtService.chkFirmwareVer(interworkMgmtVO);
		model.addAttribute("isVerOk", String.valueOf(isVerOk));
		
		return JSONVIEW;
	}
}
