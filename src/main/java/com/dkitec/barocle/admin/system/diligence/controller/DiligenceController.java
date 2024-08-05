package com.dkitec.barocle.admin.system.diligence.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.admin.system.diligence.service.DiligenceService;
import com.dkitec.barocle.admin.system.diligence.vo.DiligenceVO;
import com.dkitec.barocle.admin.system.sms.vo.SmsVO;
import com.dkitec.barocle.admin.system.sms.vo.SmsVO.SmsEditVal;
import com.dkitec.barocle.admin.system.sms.vo.SmsVO.SmsInsertVal;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.base.IConstants;
import com.dkitec.barocle.util.webutil.HttpUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="DiligenceAndLazinessController")
@RequestMapping(value="/admin/system/diligence")
public class DiligenceController extends BaseController {
	
	@Resource(name = "diligenceService") private DiligenceService diligenceService;
	
	protected static Logger log = LoggerFactory.getLogger(DiligenceController.class);
		
	@RequestName(value="dalList")
    @RequestMapping(value="dalList")
    public String dalList(
    		HttpServletRequest request,
    		DiligenceVO dalVO,
    		ModelMap model)
            throws Exception {

        String bizName = "운영자 관리 목록 조회";
        HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력

        boolean bResult = true;
        String resultMsg = IConstants.OK;
        
        try {
	        	
        	dalVO.setRecordCountPerPage(propertiesService.getInt("pageUnit"));
        	dalVO.setPageSize(propertiesService.getInt("pageSize"));
	    	
	    	/** pageing setting */
	    	PaginationInfo paginationInfo = new PaginationInfo();
	    	PaginationInfo paginationMobileInfo = new PaginationInfo();
	    	
			paginationInfo.setCurrentPageNo(dalVO.getCurrentPageNo());
			paginationMobileInfo.setCurrentPageNo(dalVO.getCurrentPageNo());
			
			paginationInfo.setRecordCountPerPage(dalVO.getPageSize());
			paginationInfo.setPageSize(dalVO.getRecordCountPerPage());
			
			paginationMobileInfo.setRecordCountPerPage(dalVO.getPageSize());
			paginationMobileInfo.setPageSize(propertiesService.getInt("pageMobileSize"));
			
			dalVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			dalVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
	
			int totCnt = diligenceService.getDiligenceListCnt(dalVO);
			paginationInfo.setTotalRecordCount(totCnt);
			paginationMobileInfo.setTotalRecordCount(totCnt);
			
	        List<DiligenceVO> dalList = diligenceService.getDiligenceList(dalVO);
	        model.addAttribute("dalList", dalList);
	        model.addAttribute("paginationInfo", paginationInfo);
	        model.addAttribute("paginationMobileInfo", paginationMobileInfo);
	    	model.addAttribute("searchFrm", dalVO);
	    	model.addAttribute("dalVO", dalVO);
			
	    

        } catch(Exception e) {
        	//TODO 에러 처리
        	bResult = false;
        	resultMsg = e.getMessage();	// 에러 메세지.
        	//new CfoodException("admin.system.user.userList");
        } finally {
        	
			model.addAttribute(IConstants.RESULT, bResult ? IConstants.OK : IConstants.ERROR);
			model.addAttribute(IConstants.RESULTMSG, resultMsg);
			
        }

        return bResult ? "/admin/system/diligence/sys_diligence_list" : IConstants.ERROR_PAGE;

    } 
	
	@RequestName(value="editDal")
	@RequestMapping(value="/dalEdit.do")
	public String editDal(DiligenceVO dalVO , BindingResult result, HttpServletRequest request, Model model) {
		
		/* Validator error */
		//if(result.hasErrors()){ throw new CfoodException("admin.system.sms.smsEdit.bindingexception"); }
		
		boolean bResult = false;
		String resultPage = "/admin/system/diligence/sys_diligence_detail";
		
		try{
			DiligenceVO resultVO = new DiligenceVO();
			
			/*if(smsVO.getSmsSeq()>0){	//* smsSeq>0 ? edit | write
				resultVO = (SmsVO)smsService.viewSms(dalVO);
				resultVO.setMode("update");
			} else {
				resultVO.setMode("insert");
			}*/
			resultVO.setMode("insert");
			// 현재 화면를 가져온다.
			resultVO.setCurrentPageNo(dalVO.getCurrentPageNo());
						
			// 현재 화면의 검색 파라미터 값을 지정한다.
			//model.addAttribute("parameterInfo",super.setGivenParameterValue(request,this.smsSearchParameter));
			model.addAttribute("dalView",resultVO);
			
			bResult = true;		// 정상
			
		} catch (Exception e) {
			throw new CfoodException("admin.system.sms.smsEdit",e);
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestName(value="insertDal")
	@RequestMapping(value="/dalInsert.do")
	public String insertDal(DiligenceVO dalVO, BindingResult result, HttpServletRequest request, Model model) {
		
		/* Validator error */
		/*if(result.hasErrors()){
			model.addAttribute("smsView",smsVO);
			model.addAttribute("resultError",super.setResultMessage(result));
			return "/admin/system/sms/sys_sms_detail";
		}*/
		
		boolean bResult = false;
		int resultInt;
		String resultPage = "redirect:/admin/system/dal/dalList.do";
		
		try{
			/* get set session */
			try{
				dalVO.setRegId((String)EgovSessionCookieUtil.getSessionAttribute(request, "usrId"));
				//smsVO.setAdminName((String)EgovSessionCookieUtil.getSessionAttribute(request, "usrName"));
			} catch(Exception e) {
				throw new CfoodException("admin.system.sms.smsInsert.NullSessionException",e);
			}
			
			DiligenceVO returnVO = null;
			
			bResult = true;		// 정상
			
			//if(MODE_INSERT.equalsIgnoreCase(smsVO.getMode())){
			resultInt = diligenceService.insertDiligence(dalVO);
			//} else bResult = false;
			
			//if(bResult){ resultPage += String.valueOf(returnVO.getSmsSeq()); }
			
		} catch (Exception e) {
			throw new CfoodException("admin.system.sms.smsInsert",e);
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	

}
