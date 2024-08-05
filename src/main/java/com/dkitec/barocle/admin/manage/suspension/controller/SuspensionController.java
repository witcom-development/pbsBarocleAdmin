package com.dkitec.barocle.admin.manage.suspension.controller;

import java.text.ParseException;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.admin.manage.suspension.service.SuspensionService;
import com.dkitec.barocle.admin.manage.suspension.vo.SuspensionVO;
import com.dkitec.barocle.admin.manage.suspension.vo.SuspensionVO.SuspensionDeleteVal;
import com.dkitec.barocle.admin.manage.suspension.vo.SuspensionVO.SuspensionEditVal;
import com.dkitec.barocle.admin.manage.suspension.vo.SuspensionVO.SuspensionListVal;
import com.dkitec.barocle.admin.manage.suspension.vo.SuspensionVO.SuspensionPersistVal;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.StringUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="SuspensionController")
@RequestMapping(value="/admin/manage/suspension")
public class SuspensionController extends BaseController {
	
	@Resource(name = "suspensionService") private SuspensionService suspensionService;
	
	protected static Logger log = LoggerFactory.getLogger(SuspensionController.class);
	
	private final String[] suspensionSearchParameter = {"searchStartDate","searchEndDate"};
	
	@RequestName(value="suspensionList")
	@RequestMapping(value="/suspensionList.do")
	public String getSuspensionList(@Validated(SuspensionListVal.class) SuspensionVO suspensionVO, BindingResult result, HttpServletRequest request, Model model) {
		
		/* Validator error */
		if(result.hasErrors()){
			model.addAttribute("suspensionView",suspensionVO);
			model.addAttribute("resultError",super.setResultMessage(result));
			return "/admin/manage/suspension/opr_res_list";
		}
		
		boolean bResult = false;
		String resultPage = "/admin/manage/suspension/opr_res_list";
		
		try{
			// 총 레코드 개수를 가져온다.
			suspensionVO.setTotalRecordCount(suspensionService.listSuspensionCount(suspensionVO));
			// 페이징
			PaginationInfo paginationInfo = getPagingInfo(suspensionVO.getCurrentPageNo(), suspensionVO.getTotalRecordCount());
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(suspensionVO.getCurrentPageNo(), suspensionVO.getTotalRecordCount());
			suspensionVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			suspensionVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			// 현재 화면의 정보를 지정한다.
			model.addAttribute("suspensionView",suspensionVO);
			// 현재 화면에 표시되는 레코드 목록을 가져온다.
			model.addAttribute("suspensionList",suspensionService.listSuspension(suspensionVO));
			// 현재 화면의 검색 파라미터 값을 지정한다.
			model.addAttribute("parameterInfo",super.setGivenParameterValue(request,this.suspensionSearchParameter));
			// 현재 화면에 표시되는 페이징 점보를 리턴한다.
			model.addAttribute("paginationInfo",paginationInfo);
			model.addAttribute("paginationMobileInfo",paginationMobileInfo);
			
			bResult = true;		// 정상
		} catch (Exception e) {
			throw new CfoodException("admin.manage.suspension.suspensionList",e);
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestName(value="editSuspension")
	@RequestMapping(value="/suspensionEdit.do")
	public String editSuspension(@Validated(SuspensionEditVal.class) SuspensionVO suspensionVO, BindingResult result, HttpServletRequest request, Model model) {
		
		/* Validator error */
		if(result.hasErrors()){ throw new CfoodException("admin.manage.suspension.suspensionEdit.validator"); }
		
		boolean bResult = false;
		String resultPage = "/admin/manage/suspension/opr_res_detail";
		
		try{
			SuspensionVO returnVO = null;
			if(suspensionVO.getDelaySeq()>0){	//* suspensionSeq>0 ? edit | write
				returnVO = (SuspensionVO)suspensionService.viewSuspension(suspensionVO);
				returnVO.setMode("update");
			} else {
				returnVO = new SuspensionVO();
				returnVO.setMode("insert");
			}
			// 현재 화면를 가져온다.
			returnVO.setCurrentPageNo(suspensionVO.getCurrentPageNo());
			// 현재 화면의 검색 파라미터 값을 지정한다.
			model.addAttribute("parameterInfo",super.setGivenParameterValue(request,this.suspensionSearchParameter));
			model.addAttribute("suspensionView",returnVO);
					
			bResult = true;		// 정상
		} catch (Exception e) {
			throw new CfoodException("admin.manage.suspension.suspensionEdit",e);
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestName(value="persistSuspension")
	@RequestMapping(value={"/suspensionInsert.do","/suspensionUpdate.do"})
	public String persistSuspension(@Validated(SuspensionPersistVal.class) SuspensionVO suspensionVO, BindingResult result, HttpServletRequest request, Model model) {
		
		/* Validator error */
		if(result.hasErrors()){
			model.addAttribute("suspensionView",suspensionVO);
			model.addAttribute("resultError",super.setResultMessage(result));
			return "/admin/manage/suspension/opr_res_detail";
		}
		String getPersistMode = suspensionVO.getMode();
		
		/* check uri */
		String requestURI = (String)request.getRequestURI().toString();
		if(requestURI.indexOf("/suspensionInsert.do")>0){ getPersistMode = MODE_INSERT; } 
		else if(requestURI.indexOf("/suspensionUpdate.do")>0){ getPersistMode = MODE_UPDATE; }
		else { throw new CfoodException("admin.manage.suspension.suspensionPersist.NullModeException"); }
		
		/*
		 * Note : 운휴 관리는 운휴 등록시 아래와 같은 조건하에 수행한다.
		 * insert - 겹치는 날짜가 없으며 
		 */
		/* check permission */
		
		try{
			/* get set session */
			try{
				suspensionVO.setRegID((String)EgovSessionCookieUtil.getSessionAttribute(request, "usrId"));
				suspensionVO.setModID((String)EgovSessionCookieUtil.getSessionAttribute(request, "usrId"));
			} catch(Exception e) { throw new CfoodException("admin.manage.suspension.suspensionPersist.NullSessionException",e); }
			
			SuspensionVO returnVO = null;
			
			if(MODE_INSERT.equalsIgnoreCase(getPersistMode)){
				returnVO = suspensionService.insertSuspension(suspensionVO);
				model.addAttribute(RESULT_MESSAGE, "Success");
			} else if(MODE_UPDATE.equalsIgnoreCase(getPersistMode)){
				returnVO = suspensionService.updateSuspension(suspensionVO);
				model.addAttribute(RESULT_MESSAGE, "Success");
			} else model.addAttribute(RESULT_MESSAGE, "Fail");;
			
			model.addAttribute("delaySeq", returnVO.getDelaySeq());
			model.addAttribute(CHECK_RESULT, 0);
		} catch (Exception e) {
			e.printStackTrace();
			throw new CfoodException("admin.manage.suspension.suspensionPersist",e);
		}
			
		return JSONVIEW;
	}
	
	@RequestName(value="deleteSuspension")
	@RequestMapping(value="/suspensionDelete.do")
	public String deleteSuspension(@Validated(SuspensionDeleteVal.class) SuspensionVO suspensionVO, BindingResult result, HttpServletRequest request, Model model) {
		
		/* Validator error */
		if(result.hasErrors()){ throw new CfoodException("admin.manage.suspension.suspensionDelete.validator"); }
		
		boolean bResult = false;
		String resultPage = "redirect:/admin/manage/suspension/suspensionList.do";
		
		try{
			/* get set session */
			try{
				suspensionVO.setModID((String)EgovSessionCookieUtil.getSessionAttribute(request, "usrId"));
			} catch(Exception e) { throw new CfoodException("admin.manage.suspension.suspensionDelete.NullSessionException",e); }
			
			if((suspensionService.deleteSuspension(suspensionVO))>0){ bResult = true; }
		} catch (Exception e) {
			throw new CfoodException("admin.manage.suspension.suspensionDelete",e);
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestName(value="validSuspension")
	@RequestMapping(value="/suspensionValid.do")
	public String validSuspension(HttpServletRequest request, Model model) {
		SuspensionVO suspensionVO = new SuspensionVO();
		if(request.getParameter("delayStrDate")!=null&&request.getParameter("delayEndDate")!=null&&!StringUtil.isEmpty((String)request.getParameter("delayStrDate"))&&!StringUtil.isEmpty((String)request.getParameter("delayEndDate"))){
			java.text.DateFormat format = new java.text.SimpleDateFormat("yyyy-MM-dd");
			try {
				suspensionVO.setDelayStrDate(format.parse((String)request.getParameter("delayStrDate")));
				suspensionVO.setDelayEndDate(format.parse((String)request.getParameter("delayEndDate")));
				suspensionVO.setDelaySeq(Integer.parseInt(request.getParameter("delaySeq")));
				model.addAttribute("suspensionValid",suspensionService.countSuspensionValid(suspensionVO));
			} catch (ParseException e) {
				throw new CfoodException("admin.manage.suspension.suspensionValid",e);
			}
		}
		return JSONVIEW;
	}
	
}
