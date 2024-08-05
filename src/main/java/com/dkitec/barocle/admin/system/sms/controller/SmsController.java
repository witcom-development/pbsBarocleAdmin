package com.dkitec.barocle.admin.system.sms.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.CacheManager;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.admin.system.sms.service.SmsService;
import com.dkitec.barocle.admin.system.sms.vo.SmsVO;
import com.dkitec.barocle.admin.system.sms.vo.SmsVO.SmsDeleteVal;
import com.dkitec.barocle.admin.system.sms.vo.SmsVO.SmsEditVal;
import com.dkitec.barocle.admin.system.sms.vo.SmsVO.SmsInsertVal;
import com.dkitec.barocle.admin.system.sms.vo.SmsVO.SmsListVal;
import com.dkitec.barocle.admin.system.sms.vo.SmsVO.SmsUpdateVal;
import com.dkitec.barocle.base.BaseController;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="SuspensionController")
@RequestMapping(value="/admin/system/sms")
public class SmsController extends BaseController {
	
	@Resource(name = "smsService") private SmsService smsService;
	
	@Autowired private transient CacheManager cacheManager;
	
	protected static Logger log = LoggerFactory.getLogger(SmsController.class);
	
	private final String[] smsSearchParameter = {"searchValue","searchStartDate","searchEndDate"};
	
	@RequestName(value="getSmsList")
	@RequestMapping(value="/smsList.do")
	public String getSmsList(@Validated(SmsListVal.class) SmsVO smsVO, BindingResult result, HttpServletRequest request, Model model) {
		
		/* Validator error */
		if(result.hasErrors()){
			model.addAttribute("smsView",smsVO);
			model.addAttribute("resultError",super.setResultMessage(result));
			return "/admin/system/sms/sys_sms_detail";
		}
		
		boolean bResult = false;
		String resultPage = "/admin/system/sms/sys_sms_list";
		
		try{
			// 총 레코드 개수를 가져온다.
			smsVO.setTotalRecordCount(smsService.listSmsCount(smsVO));
			// 페이징
			PaginationInfo paginationInfo = getPagingInfo(smsVO.getCurrentPageNo(), smsVO.getTotalRecordCount());
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(smsVO.getCurrentPageNo(), smsVO.getTotalRecordCount());
			smsVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			smsVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			// 현재 화면의 정보를 지정한다.
			model.addAttribute("smsView",smsVO);
			// 현재 화면에 표시되는 레코드 목록을 가져온다.
			model.addAttribute("smsList",smsService.listSms(smsVO));
			// 현재 화면의 검색 파라미터 값을 지정한다.
			model.addAttribute("parameterInfo",super.setGivenParameterValue(request,this.smsSearchParameter));
			// 현재 화면에 표시되는 페이징 점보를 리턴한다.
			model.addAttribute("paginationInfo",paginationInfo);
			model.addAttribute("paginationMobileInfo",paginationMobileInfo);
			
			bResult = true;		// 정상
		} catch (Exception e) {
			throw new CfoodException("admin.system.sms.smsList",e);
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestName(value="editSms")
	@RequestMapping(value="/smsEdit.do")
	public String editSms(@Validated(SmsEditVal.class) SmsVO smsVO, BindingResult result, HttpServletRequest request, Model model) {
		
		/* Validator error */
		if(result.hasErrors()){ throw new CfoodException("admin.system.sms.smsEdit.bindingexception"); }
		
		boolean bResult = false;
		String resultPage = "/admin/system/sms/sys_sms_detail";
		
		try{
			SmsVO resultVO = new SmsVO();
			
			if(smsVO.getSmsSeq()>0){	//* smsSeq>0 ? edit | write
				resultVO = (SmsVO)smsService.viewSms(smsVO);
				resultVO.setMode("update");
			} else {
				resultVO.setMode("insert");
			}
			
			// 현재 화면를 가져온다.
			resultVO.setCurrentPageNo(smsVO.getCurrentPageNo());
						
			// 현재 화면의 검색 파라미터 값을 지정한다.
			model.addAttribute("parameterInfo",super.setGivenParameterValue(request,this.smsSearchParameter));
			model.addAttribute("smsView",resultVO);
			
			bResult = true;		// 정상
			
		} catch (Exception e) {
			throw new CfoodException("admin.system.sms.smsEdit",e);
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestName(value="insertSms")
	@RequestMapping(value="/smsInsert.do")
	public String insertSms(@Validated(SmsInsertVal.class) SmsVO smsVO, BindingResult result, HttpServletRequest request, Model model) {
		
		/* Validator error */
		if(result.hasErrors()){
			model.addAttribute("smsView",smsVO);
			model.addAttribute("resultError",super.setResultMessage(result));
			return "/admin/system/sms/sys_sms_detail";
		}
		
		boolean bResult = false;
		String resultPage = "redirect:/admin/system/sms/smsEdit.do?mode=edit&smsSeq=";
		
		try{
			/* get set session */
			try{
				smsVO.setAdminID((String)EgovSessionCookieUtil.getSessionAttribute(request, "usrId"));
				smsVO.setAdminName((String)EgovSessionCookieUtil.getSessionAttribute(request, "usrName"));
			} catch(Exception e) {
				throw new CfoodException("admin.system.sms.smsInsert.NullSessionException",e);
			}
			
			SmsVO returnVO = null;
			
			bResult = true;		// 정상
			
			if(MODE_INSERT.equalsIgnoreCase(smsVO.getMode())){
				returnVO = smsService.insertSms(smsVO);
			} else bResult = false;
			
			if(bResult){ resultPage += String.valueOf(returnVO.getSmsSeq()); }
			
		} catch (Exception e) {
			throw new CfoodException("admin.system.sms.smsInsert",e);
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestName(value="updateSms")
	@RequestMapping(value="/smsUpdate.do")
	public String updateSms(@Validated(SmsUpdateVal.class) SmsVO smsVO, BindingResult result, HttpServletRequest request, Model model) {
		
		/* Validator error */
		if(result.hasErrors()){
			model.addAttribute("smsView",smsVO);
			model.addAttribute("resultError",super.setResultMessage(result));
			return "/admin/system/sms/sys_sms_detail";
		}
		
		boolean bResult = false;
		String resultPage = "redirect:/admin/system/sms/smsEdit.do?mode=edit&smsSeq=";
		
		try{
			/* get set session */
			try{
				smsVO.setAdminID((String)EgovSessionCookieUtil.getSessionAttribute(request, "usrId"));
				smsVO.setAdminName((String)EgovSessionCookieUtil.getSessionAttribute(request, "usrName"));
			} catch(Exception e) {
				throw new CfoodException("admin.system.sms.smsUpdate.NullSessionException",e);
			}
			
			SmsVO returnVO = null;
			
			bResult = true;		// 정상
			
			if(MODE_UPDATE.equalsIgnoreCase(smsVO.getMode())){
				returnVO = smsService.updateSms(smsVO);
				/**
				 * 수정일 : 2016-03-21
				 * 내용 : cache에 저장된 sms 문구 정보를 다시 갱신함 (db 수정하고 cache를 수정하지 않으면 이전 데이타로 보내는 오류 수정을 위해)
				 */
				System.out.println("autoSendID: " + smsVO.getAutoSendID());
				System.out.println("orignlMsg: " + smsVO.getOrignlMsg());
				cacheManager.getCache("smsMessage").put("SMS_012", smsVO.getOrignlMsg());
				System.out.println("#######################: ");
				System.out.println("orignlMsg: " + cacheManager.getCache("smsMessage").get("SMS_012"));
			} else bResult = false;
			
			if(bResult){ resultPage += String.valueOf(returnVO.getSmsSeq()); }
			
		} catch (Exception ce) {
			throw new CfoodException("admin.system.sms.smsUpdate");
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestName(value="deleteSms")
	@RequestMapping(value="/smsDelete.do")
	public String deleteSms(@Validated(SmsDeleteVal.class) SmsVO smsVO, BindingResult result, Model model) {
		
		/* Validator error */
		if(result.hasErrors()){
			model.addAttribute("resultError", "권한이 없습니다.");
			throw new CfoodException("admin.system.sms.smsDelete.bindingexception");
		}
		
		boolean bResult = false;
		String resultPage = "redirect:/admin/system/sms/smsList.do";
		
		try{
			if((smsService.deleteSms(smsVO))>0){ bResult = true; }
		} catch (Exception e) {
			throw new CfoodException("admin.system.sms.smsDelete");
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}

}
