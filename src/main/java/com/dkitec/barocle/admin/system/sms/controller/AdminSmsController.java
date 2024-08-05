package com.dkitec.barocle.admin.system.sms.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.CacheManager;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.dkitec.barocle.admin.common.vo.SmsSendVo;
import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.admin.login.vo.UserSessionVO;
import com.dkitec.barocle.admin.system.sms.service.SmsService;
import com.dkitec.barocle.admin.system.sms.vo.AdminSmsVO;
import com.dkitec.barocle.admin.system.sms.vo.SmsVO;
import com.dkitec.barocle.admin.system.usergroupmgmt.service.UserGroupMgmtService;
import com.dkitec.barocle.admin.system.usergroupmgmt.vo.UserGroupMgmtVO;
import com.dkitec.barocle.admin.system.usermgmt.service.UserMgmtService;
import com.dkitec.barocle.admin.system.usermgmt.vo.UserMgmtVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.HttpUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="AdminSmsController")
public class AdminSmsController extends BaseController {
	
	@Resource(name = "smsService") private SmsService smsService;

	@Resource(name = "userGroupMgmtService") private UserGroupMgmtService groService;
	
    @Resource(name = "userMgmtService") private UserMgmtService usrService;
	
	@Autowired private transient CacheManager cacheManager;
	
	protected static Logger log = LoggerFactory.getLogger(AdminSmsController.class);
	
	
	@RequestMapping(value="/admin/system/sms/getAdminSmsTpl.do")
	@RequestName("getAdminSmsTpl")
	public String getAdminSmsTpl(@ModelAttribute SmsSendVo smsVo, ModelMap model, HttpServletRequest request) {
		
		String bizName = "관리자SMS 발송구분 조회";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		try {
			
			List<SmsSendVo> smsList = smsService.getAdminSmsTpl(smsVo);
			model.addAttribute("smsMsgList", smsList);
		
		} catch (Exception e) {
			throw new CfoodException("admin.system.sms.getAdminSmsTpl",e.getMessage());
		}
		return JSONVIEW;
	}
	
	/*
	 * 관리자SMS 발송
	 */
	@RequestMapping(value="/admin/system/sms/reqSendAdminSms.do")
	@RequestName("reqSendAdminSms")
	public String reqSendAdminSms(@ModelAttribute @Valid AdminSmsVO admSmsVo, ModelMap model, HttpServletRequest request){
		String bizName = "관리자SMS 발송.";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		boolean result = false;
		
		try {
				if(admSmsVo.getReqResDate() == null || admSmsVo.getReqResDate() == ""){
					
					Date dt = new Date();
					SimpleDateFormat sDate = new SimpleDateFormat("yyyy-MM-dd HH:mm");
					
					admSmsVo.setReqResDate(sDate.format(dt));
					
				}
				
				if(admSmsVo.getReqSendAdmTelNo() == null || admSmsVo.getReqSendAdmTelNo() == "") admSmsVo.setReqSendAdmTelNo("02-542-7781");
				
				int i = smsService.insertReqAdmSms(admSmsVo);
				
				if(i == 1){
					
					result = true;
					
				}else{
					
					result = false;
					
				}
				
		} catch (Exception e) {
			throw new CfoodException("admin.system.sms.reqSendAdminSms",e.getMessage());
		}
		model.addAttribute(CHECK_RESULT, result);
		
		return JSONVIEW;
	}	
	
	/*
	 * 관리자SMS 목록 조회
	 */
	@RequestName(value="getSmsAdminList")
	@RequestMapping(value="/admin/system/sms/getReqAdminSmsList.do")
	public String getSmsAdminList(@ModelAttribute @Valid AdminSmsVO admSmsVo, BindingResult result, HttpServletRequest request, Model model) {
		String bizName = "관리자SMS 목록 조회.";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		boolean bResult = false;
		String resultPage = "/admin/system/sms/sys_sms_admin_list";
		
		try{
			
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			
			if(admSmsVo.getSearchBgnDe() == null && admSmsVo.getSearchEndDe() == null){
				
				admSmsVo.setSearchEndDe(sdf.format(cal.getTime()));
				admSmsVo.setSearchBgnDe(sdf.format(cal.getTime()));
				
			}
			
			int totCnt = smsService.getReqAdmSmsListCnt(admSmsVo);
			PaginationInfo paginationInfo = getPagingInfo(admSmsVo.getCurrentPageNo(), totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(admSmsVo.getCurrentPageNo(), totCnt);
			
			admSmsVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			admSmsVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<AdminSmsVO> admSmsList = smsService.getReqAdmSmsList(admSmsVo);
			
			model.addAttribute("searchCondition", admSmsVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("admSmsList", admSmsList);

			bResult = true;		// 정상
		} catch (Exception e) {
			throw new CfoodException("admin.system.sms.getSmsAdminList",e.getMessage());
		}
		
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	/*
	 * 관리자SMS 상세 조회
	 */
	@RequestName(value="getSmsAdminDtl")
	@RequestMapping(value="/admin/system/sms/getReqAdminSmsDtl.do")
	public String getSmsAdminDtl(@ModelAttribute @Valid AdminSmsVO admSmsVo, BindingResult result, HttpServletRequest request, Model model) {
		String bizName = "관리자SMS 상세 조회.";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		boolean bResult = false;
		String resultPage = "/admin/system/sms/sys_sms_admin_detail";
		
		try{
			
			AdminSmsVO rVo = new AdminSmsVO();
			rVo = smsService.getReqAdmSmsDtl(admSmsVo);
			
			List<AdminSmsVO> nameList = smsService.getReqAdmSmsDtlName(rVo.getReqSmsSeq());
			List<String> adminGrpNameCnt = smsService.getAdminGrpNameCnt(rVo.getReqSmsSeq());
			
			model.addAttribute("reqSmsVo",rVo);
			model.addAttribute("nameList",nameList);
			model.addAttribute("adminGrpNameCnt",adminGrpNameCnt);
			model.addAttribute("searchCondition",admSmsVo);
			
			bResult = true;		// 정상
		} catch (Exception e) {
			throw new CfoodException("admin.system.sms.getSmsAdminDtl",e);
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	/*
	 * 관리자SMS 등록 화면
	 */
	@RequestName(value="getSmsAdmin")
	@RequestMapping(value="/admin/system/sms/smsAdmin.do")
	public String getSmsAdmin(SmsVO smsVO, UserMgmtVO usrVO, BindingResult result, HttpServletRequest request, Model model) {
		String bizName = "관리자SMS 등록 화면.";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력		
		
		boolean bResult = false;
		String resultPage = "/admin/system/sms/sys_sms_admin";
		
		try{
			
			UserSessionVO uVo = (UserSessionVO) EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
			
			String sendTelNo = smsService.getSendAdminTelNo(uVo.getUsrId());
			
			List<UserGroupMgmtVO> groCodeList = smsService.getGroupNameList();
			
			List<UserMgmtVO> usrList = smsService.getAdminList();
			
			model.addAttribute("sendTelNo",sendTelNo);
			model.addAttribute("groCodeList",groCodeList);
			model.addAttribute("usrList",usrList);
			bResult = true;		// 정상
		} catch (Exception e) {
			throw new CfoodException("admin.system.sms.smsAdmin",e.getMessage());
		}
		
		return bResult ? resultPage : ERROR_PAGE;
	}

}
