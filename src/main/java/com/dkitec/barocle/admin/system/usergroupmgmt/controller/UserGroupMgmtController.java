package com.dkitec.barocle.admin.system.usergroupmgmt.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.admin.login.vo.UserSessionVO;
import com.dkitec.barocle.admin.system.MenuMgmt.service.MenuMgmtService;
import com.dkitec.barocle.admin.system.MenuMgmt.vo.MenuMgmtVO;
import com.dkitec.barocle.admin.system.commonCodeMgmt.service.CommonCodeService;
import com.dkitec.barocle.admin.system.commonCodeMgmt.vo.CommonCodeVO;
import com.dkitec.barocle.admin.system.usergroupmgmt.service.UserGroupMgmtService;
import com.dkitec.barocle.admin.system.usergroupmgmt.validator.UserGroupMgmtValidator;
import com.dkitec.barocle.admin.system.usergroupmgmt.vo.UserGroupMgmtVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.base.IConstants;
import com.dkitec.barocle.util.webutil.HttpUtil;

import egovframework.rte.fdl.cmmn.exception.EgovBizException;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="UserGroupMgmtController")
@RequestMapping(value="/admin/system/userGroup")
public class UserGroupMgmtController extends BaseController {
	
	@Resource(name = "userGroupMgmtService") private UserGroupMgmtService groService;

    @Resource(name = "commonCodeService") private CommonCodeService codeService;

    @Resource(name = "menuMgmtService") private MenuMgmtService  menuService;

    @Resource(name = "userGroupMgmtValidator") private UserGroupMgmtValidator groValidator;
    
	protected static Logger log = LoggerFactory.getLogger(UserGroupMgmtController.class);
    
	
	
	/**
	 * 공통 리턴화면 
	 * @param methodName
	 * @return
	 */
	protected String getReturnUrl(String methodName) {
		return "/admin/system/group/" + methodName;
	}
	
	
	
    /**
     * 권한목록를 조회한다.
     * @param TeamMgmtVO groVO
     * @return 출력화면정보 "/adm/gro/gro_list"
     * @exception Exception
     */
	@RequestName(value="groupList")
    @RequestMapping(value="groupList")
    public String selectGroList(
    		@ModelAttribute("searchVO") UserGroupMgmtVO groVO,
    		HttpServletRequest request,
    		ModelMap model)
            throws Exception {

        String bizName = "권한 목록 조회";
        HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력
        
		String resultCode = IConstants.OK_CODE;
		
                
        boolean bResult = true;
        String resultMsg = IConstants.OK;
        
        try {

        	groVO.setRecordCountPerPage(propertiesService.getInt("pageUnit"));
        	groVO.setPageSize(propertiesService.getInt("pageSize"));
        	
        	/** pageing setting */
        	PaginationInfo paginationInfo = new PaginationInfo();
        	PaginationInfo paginationMobileInfo = new PaginationInfo();
        	
    		paginationInfo.setCurrentPageNo(groVO.getCurrentPageNo());
    		paginationMobileInfo.setCurrentPageNo(groVO.getCurrentPageNo());
    		
    		paginationInfo.setPageSize(groVO.getRecordCountPerPage());
    		paginationInfo.setRecordCountPerPage(groVO.getPageSize());
    		
    		paginationMobileInfo.setRecordCountPerPage(groVO.getPageSize());
    		paginationMobileInfo.setPageSize(propertiesService.getInt("pageMobileSize"));
    		
    		groVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
    		groVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
    		int totCnt = groService.getGroCount(groVO);
    		
    		paginationInfo.setTotalRecordCount(totCnt);
    		paginationMobileInfo.setTotalRecordCount(totCnt);
    		
        	List<UserGroupMgmtVO> groList = groService.getGroList(groVO);
    		
            model.addAttribute("paginationInfo", paginationInfo);
            model.addAttribute("paginationMobileInfo", paginationMobileInfo);
            
        	model.addAttribute("searchFrm", groVO);
        	
        	model.addAttribute("groList", groList);

        	CommonCodeVO cVo = new CommonCodeVO();
        	List<CommonCodeVO> codeList = null;
        	cVo.setComUpCd("ADM");
        	cVo.setLang(IConstants.LANG_KR);
        	
        	// 언어 공통코드 조회
        	codeList = codeService.getComCodeInfo(cVo);
        	
        	
        	model.addAttribute("codeList", codeList);
        	
        } catch(Exception e) {
        	//TODO 에러 처리
        	bResult = false;
        	resultMsg = e.getMessage();	// 에러 메세지.
        	/*resultCode = getResultCode("fail.common.msg");*/
        	LoggerFactory.getLogger(this.getClass()).error(System.getProperty("line.separator") + "[" + e.getStackTrace() + "] " + e.getMessage(), e);
        } finally {
			model.addAttribute(IConstants.RESULT, bResult ? IConstants.OK : IConstants.ERROR);
			model.addAttribute(IConstants.RESULTMSG, resultMsg);
        }
        
//        return bResult ? "/admin/system/group/sys_gra_list" : IConstants.ERROR_PAGE;
        log.debug(getReturnUrl("sys_gra_list"));
        return  getReturnUrl("sys_gra_list") ;

    }

    /**
     * 권한 등록 화면로 이동한다.
     * @param TeamMgmtVO groVO
     * @return 출력화면정보 "/adm/gro/gro_modify"
     * @exception Exception
     */
	@RequestName(value="groInsertForm")
    @RequestMapping(value="groInsertForm")
    public String authGroupInsertForm(
    		UserGroupMgmtVO groVO,
    		HttpServletRequest request,
    		ModelMap model)
            throws Exception {

        String bizName = "권한 등록 화면";
        HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력

		String resultCode = IConstants.OK_CODE;
        
		/** 통합통계로그 메뉴 셋팅 */
		/*StatLogParam statLogParam = RepositoryService.getStatLog();
		statLogParam.setSvcDepth1(depth1);
		statLogParam.setSvcDepth2(depth2);
		statLogParam.setSvcDepth3(getMessage(this.getClass().getSimpleName() + "." + Thread.currentThread().getStackTrace()[1].getMethodName()));*/
                
        boolean bResult = true;
        String resultMsg = IConstants.OK;
        
        try {
        	
        	CommonCodeVO cVo = new CommonCodeVO();
        	List<CommonCodeVO> codeList = null;
        	cVo.setComUpCd("ADM");
        	cVo.setLang(IConstants.LANG_KR);
        	
        	// 언어 공통코드 조회
        	codeList = codeService.getComCodeInfo(cVo);
        	
        	
        	model.addAttribute("usrGrpCdList", groService.getGroCdList());
        	model.addAttribute("codeList", codeList);
        	model.addAttribute("readAuthCdList", null);
	    	model.addAttribute("searchFrm", groVO);
	    	model.addAttribute("inputFrm", new UserGroupMgmtVO());
	    	
        } catch(EgovBizException e) {
        	bResult = false;
        	resultMsg = e.getMessage();	// 에러 메세지.
        	resultCode = getResultCode(e.getMessageKey());
        } catch(Exception e) {
        	//TODO 에러 처리
        	bResult = false;
        	resultMsg = e.getMessage();	// 에러 메세지.
        	resultCode = getResultCode("fail.common.msg");
        	LoggerFactory.getLogger(this.getClass()).error(System.getProperty("line.separator") + "[" + e.getStackTrace() + "] " + e.getMessage(), e);
        } finally {
			model.addAttribute(IConstants.RESULT, bResult ? IConstants.OK : IConstants.ERROR);
			model.addAttribute(IConstants.RESULTMSG, resultMsg);
			/** 통합통계로그 결과코드 셋팅 */
            /*statLogParam.setResultCode(resultCode);*/
        	HttpUtil.printServiceLogEnd(bizName, bResult, resultMsg, log);// 서비스로그 끝 출력
        }
        
        return bResult ? "/admin/system/group/sys_gra_detail" : IConstants.ERROR_PAGE;

    }

    /**
     * 권한 상세 화면로 이동한다.
     * @param TeamMgmtVO groVO
     * @return 출력화면정보 "/adm/gro/gro_modify"
     * @exception Exception
     */
	@RequestName(value="groInfo")
    @RequestMapping(value="groInfo")
    public String groInfo(
    		UserGroupMgmtVO groVO,
    		MenuMgmtVO menuVO,
    		HttpServletRequest request,
    		ModelMap model)
            throws Exception {

        String bizName = "권한 상세 화면";
        HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력

		String resultCode = IConstants.OK_CODE;
        
		/** 통합통계로그 메뉴 셋팅 */
		/*StatLogParam statLogParam = RepositoryService.getStatLog();
		statLogParam.setSvcDepth1(depth1);
		statLogParam.setSvcDepth2(depth2);
		statLogParam.setSvcDepth3(getMessage(this.getClass().getSimpleName() + "." + Thread.currentThread().getStackTrace()[1].getMethodName()));*/
        
		//추가 : 2017.03.06_세션 가져오기
	    UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
		
        boolean bResult = true;
        String resultMsg = IConstants.OK;
        
        try {
        	groValidator.groInfoCheck(groVO);
        	
        	CommonCodeVO cVo = new CommonCodeVO();
        	List<CommonCodeVO> codeList = null;
        	cVo.setComUpCd("ADM");
        	cVo.setLang(IConstants.LANG_KR);
        	
        	// 언어 공통코드 조회
        	codeList = codeService.getComCodeInfo(cVo);
        	
        	model.addAttribute("sessionUsrGrpCd", userSessionVO.getUsrGrpCd());//추가 : 2017.03.07_JHN
        	model.addAttribute("userSessionVO", userSessionVO);//추가 : 2017.03.27_JHN
        	model.addAttribute("codeList", codeList);
	    	model.addAttribute("searchVO", groVO);
	    	model.addAttribute("groVO", groVO);
	
	    	model.addAttribute("searchFrm", groVO);
	    	model.addAttribute("inputFrm", groService.getGroInfo(groVO));
	    	model.addAttribute("type", IConstants.CRUD_U);
	    	model.addAttribute("menuList", menuService.getMenuGrpList(menuVO));
        } catch(EgovBizException e) {
        	bResult = false;
        	resultMsg = e.getMessage();	// 에러 메세지.
        	resultCode = getResultCode(e.getMessageKey());
        } catch(Exception e) {
        	//TODO 에러 처리
        	bResult = false;
        	resultMsg = e.getMessage();	// 에러 메세지.
        	resultCode = getResultCode("fail.common.msg");
        	LoggerFactory.getLogger(this.getClass()).error(System.getProperty("line.separator") + "[" + e.getStackTrace() + "] " + e.getMessage(), e);
        } finally {
			model.addAttribute(IConstants.RESULT, bResult ? IConstants.OK : IConstants.ERROR);
			model.addAttribute(IConstants.RESULTMSG, resultMsg);
			/** 통합통계로그 결과코드 셋팅 */
            /*statLogParam.setResultCode(resultCode);*/
        	HttpUtil.printServiceLogEnd(bizName, bResult, resultMsg, log);// 서비스로그 끝 출력
        }
        
        return bResult ? "/admin/system/group/sys_gra_detail" : IConstants.ERROR_PAGE;

    }
	
    @InitBinder
    protected void initBinder(WebDataBinder binder) {
        binder.setAutoGrowNestedPaths(true); // insert this line
        binder.setAutoGrowCollectionLimit(5000); // insert thist line
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
        binder.registerCustomEditor(String.class, new StringTrimmerEditor(true));
    }
 
    /**
     * 권한을 등록 한다.
     * @param TeamMgmtVO groVO
     * @return 출력화면정보 IConstants.JSONVIEW
     * @exception Exception
     */
	@RequestName(value="groInsert")
    @RequestMapping(value="groInsert")
    public String groInsert(
    		@Valid UserGroupMgmtVO groVO,
    		BindingResult bindingResult,
    		HttpServletRequest request,
    		ModelMap model)
            throws Exception {

        String bizName = "권한 등록";
        HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력

		String resultCode = IConstants.OK_CODE;
        
		/** 통합통계로그 메뉴 셋팅 */
		/*StatLogParam statLogParam = RepositoryService.getStatLog();
		statLogParam.setSvcDepth1(depth1);
		statLogParam.setSvcDepth2(depth2);
		statLogParam.setSvcDepth3(getMessage(this.getClass().getSimpleName() + "." + Thread.currentThread().getStackTrace()[1].getMethodName()));*/
                
        boolean bResult = true;
        String resultMsg = IConstants.OK;
        
        try {
        	
        	
        	UserSessionVO userSessionVO = (UserSessionVO) EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
        	groVO.setReg_id(userSessionVO.getUsrId());
        	
        	
        	
        	groValidator.groInsertCheck(groVO);
        	
        	if(bindingResult.hasErrors()) {
				for(FieldError fe : bindingResult.getFieldErrors()) {
					throw new EgovBizException(messageSource, "fail.input.param.error", new Object[] {fe.getDefaultMessage()}, new Exception());
				}
			}
        	
        	// 중복 체크
        	UserGroupMgmtVO rsGroVO = groService.getGroInfo(groVO);
        	if(rsGroVO != null) {
        		bResult = false;
        		resultMsg = getMessage("fail.duplicated.usrgrp", new String[]{"그룹등급"});
        		resultCode = getResultCode("fail.duplicated.usrgrp");
        	} else {
        		int result = groService.insertGro(groVO);

            	model.addAttribute(IConstants.CHECK_RESULT,result);
            	
            	if(result > 0){
                	resultMsg = getMessage("success.common.insert2", new String[]{getMessage("opr.grp")});
            	}else{
            		bResult = false;
                	resultMsg = getMessage("fail.common.insert2", new String[]{getMessage("opr.grp")});
                	resultCode = getResultCode("fail.common.insert2");
            	}
        	}
        } catch(EgovBizException e) {
        	bResult = false;
        	resultMsg = e.getMessage();	// 에러 메세지.
        	resultCode = getResultCode(e.getMessageKey());
        } catch(Exception e) {
        	//TODO 에러 처리
        	bResult = false;
        	resultMsg = e.getMessage();	// 에러 메세지.
        	resultCode = getResultCode("fail.common.msg");
        	LoggerFactory.getLogger(this.getClass()).error(System.getProperty("line.separator") + "[" + e.getStackTrace() + "] " + e.getMessage(), e);
        } finally {
        	
			model.addAttribute(IConstants.RESULT, bResult ? IConstants.OK : IConstants.ERROR);
			model.addAttribute(IConstants.RESULTMSG, resultMsg);
			/** 통합통계로그 결과코드 셋팅 */
            /*statLogParam.setResultCode(resultCode);*/
        	HttpUtil.printServiceLogEnd(bizName, bResult, resultMsg, log);// 서비스로그 끝 출력
        }
        
      	return  (HttpUtil.isAjaxRequest(request) || bResult) ? IConstants.JSONVIEW : IConstants.ERROR_PAGE;
    }

    /**
     * 권한을 수정 한다.
     * @param TeamMgmtVO groVO
     * @return 출력화면정보 IConstants.JSONVIEW
     * @exception Exception
     */
	@RequestName(value="groUpdate")
    @RequestMapping(value="groUpdate")
    public String groUpdate(
    		@Valid UserGroupMgmtVO groVO,
    		BindingResult bindingResult,
    		HttpServletRequest request,
    		ModelMap model)
            throws Exception {

        String bizName = "권한 수정";
        HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력

		String resultCode = IConstants.OK_CODE;
        
		/** 통합통계로그 메뉴 셋팅 */
		/*StatLogParam statLogParam = RepositoryService.getStatLog();
		statLogParam.setSvcDepth1(depth1);
		statLogParam.setSvcDepth2(depth2);
		statLogParam.setSvcDepth3(getMessage(this.getClass().getSimpleName() + "." + Thread.currentThread().getStackTrace()[1].getMethodName()));*/
                
        boolean bResult = true;
        String resultMsg = IConstants.OK;
        log.debug("#########"+ groVO);
        try {
        	
        	UserSessionVO userSessionVO = (UserSessionVO) EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
        	groVO.setMod_id(userSessionVO.getUsrId());
        	
        	
        	groValidator.groUpdateCheck(groVO);
        	
        	if(bindingResult.hasErrors()) {
				for(FieldError fe : bindingResult.getFieldErrors()) {
					throw new EgovBizException(messageSource, "fail.input.param.error", new Object[] {fe.getDefaultMessage()}, new Exception());
				}
			}
        	
	    	int result = groService.updateGro(groVO);

        	model.addAttribute(IConstants.CHECK_RESULT,result);
        	
        	if(result > 0){
            	resultMsg = getMessage("success.common.update2", new String[]{getMessage("opr.grp")});
        	}else{
        		bResult = false;
            	resultMsg = getMessage("fail.common.update2", new String[]{getMessage("opr.grp")});
            	resultCode = getResultCode("fail.common.update2");
        	}
        } catch(EgovBizException e) {
        	bResult = false;
        	resultMsg = e.getMessage();	// 에러 메세지.
        	resultCode = getResultCode(e.getMessageKey());
        } catch(Exception e) {
        	//TODO 에러 처리
        	bResult = false;
        	resultMsg = e.getMessage();	// 에러 메세지.
        	resultCode = getResultCode("fail.common.msg");
        	LoggerFactory.getLogger(this.getClass()).error(System.getProperty("line.separator") + "[" + e.getStackTrace() + "] " + e.getMessage(), e);
        } finally {
        	
			model.addAttribute(IConstants.RESULT, bResult ? IConstants.OK : IConstants.ERROR);
			model.addAttribute(IConstants.RESULTMSG, resultMsg);
			/** 통합통계로그 결과코드 셋팅 */
            /*statLogParam.setResultCode(resultCode);*/
        	HttpUtil.printServiceLogEnd(bizName, bResult, resultMsg, log);// 서비스로그 끝 출력
        }
        
      	return  (HttpUtil.isAjaxRequest(request) || bResult) ? IConstants.JSONVIEW : IConstants.ERROR_PAGE;

    }

    /**
     * 권한을 삭제 한다.
     * @param TeamMgmtVO groVO
     * @return 출력화면정보 IConstants.JSONVIEW
     * @exception Exception
     */
	@RequestName(value="groDelete")
    @RequestMapping(value="groDelete")
    public String groDelete(
    		UserGroupMgmtVO groVO,
    		HttpServletRequest request,
    		ModelMap model)
            throws Exception {

        String bizName = "권한 삭제";
        HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력

		String resultCode = IConstants.OK_CODE;
        
		/** 통합통계로그 메뉴 셋팅 */
		/*StatLogParam statLogParam = RepositoryService.getStatLog();
		statLogParam.setSvcDepth1(depth1);
		statLogParam.setSvcDepth2(depth2);
		statLogParam.setSvcDepth3(getMessage(this.getClass().getSimpleName() + "." + Thread.currentThread().getStackTrace()[1].getMethodName()));*/
                
        boolean bResult = true;
        String resultMsg = IConstants.OK;
        
        try {
        	groValidator.groDeleteCheck(groVO);
        	
	    	int result = groService.deleteGro(groVO);

        	model.addAttribute(IConstants.CHECK_RESULT,result);
        	
        	if(result > 0){
            	resultMsg = getMessage("success.common.delete2", new String[]{getMessage("opr.grp")});
        	}else{
        		bResult = false;
            	resultMsg = getMessage("fail.common.delete2", new String[]{getMessage("opr.grp")});
            	resultCode = getResultCode("fail.common.delete2");
        	}
        } catch(EgovBizException e) {
        	bResult = false;
        	resultMsg = e.getMessage();	// 에러 메세지.
        	resultCode = getResultCode(e.getMessageKey());
        } catch(Exception e) {
        	//TODO 에러 처리
        	bResult = false;
        	resultMsg = e.getMessage();	// 에러 메세지.
        	resultCode = getResultCode("fail.common.msg");
        	LoggerFactory.getLogger(this.getClass()).error(System.getProperty("line.separator") + "[" + e.getStackTrace() + "] " + e.getMessage(), e);
        } finally {
        	
			model.addAttribute(IConstants.RESULT, bResult ? IConstants.OK : IConstants.ERROR);
			model.addAttribute(IConstants.RESULTMSG, resultMsg);
			/** 통합통계로그 결과코드 셋팅 */
            /*statLogParam.setResultCode(resultCode);*/
        	HttpUtil.printServiceLogEnd(bizName, bResult, resultMsg, log);// 서비스로그 끝 출력
        }
        
      	return  (HttpUtil.isAjaxRequest(request) || bResult) ? IConstants.JSONVIEW : IConstants.ERROR_PAGE;
    }

    /**
     * 권한을 메뉴를 설정한다(수정한다).
     * @param TeamMgmtVO groVO
     * @return 출력화면정보 IConstants.JSONVIEW
     * @exception Exception
     */
	@RequestName(value="grpMenuUpdate")
    @RequestMapping(value="grpMenuUpdate")
    public String authGroupMenuSetting(
    		UserGroupMgmtVO groVO,
    		MenuMgmtVO menuVO,
    		HttpServletRequest request,
    		ModelMap model)
            throws Exception {

        String bizName = "권한 메뉴 수정";
        HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력

		String resultCode = IConstants.OK_CODE;
        
		/** 통합통계로그 메뉴 셋팅 */
		/*StatLogParam statLogParam = RepositoryService.getStatLog();
		statLogParam.setSvcDepth1(depth1);
		statLogParam.setSvcDepth2(depth2);
		statLogParam.setSvcDepth3(getMessage(this.getClass().getSimpleName() + "." + Thread.currentThread().getStackTrace()[1].getMethodName()));*/
                
        boolean bResult = true;
        String resultMsg = IConstants.OK;
        
        try {
        	groValidator.groMenuCheck(groVO, menuVO);
        	
	    	
	    	UserSessionVO userSessionVO = (UserSessionVO) EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
	    	menuVO.setRegUsrId(userSessionVO.getUsrId());
        	
        	int result = menuService.setMenuGrp(menuVO);

        	model.addAttribute(IConstants.CHECK_RESULT,result);
        	
        	resultMsg = getMessage("success.common.update2", new String[]{getMessage("opr.grpMenu")});
        	/*if(result > 0){
            	resultMsg = getMessage("success.common.update2", new String[]{getMessage("opr.grpMenu")});
        	}else{
        		bResult = false;
            	resultMsg = getMessage("fail.common.update2", new String[]{getMessage("opr.grpMenu")});
            	resultCode = getResultCode("fail.common.update2");
        	}*/
        } catch(EgovBizException e) {
        	bResult = false;
        	resultMsg = e.getMessage();	// 에러 메세지.
        	resultCode = getResultCode(e.getMessageKey());
        } catch(Exception e) {
        	bResult = false;
        	resultMsg = e.getMessage();	// 에러 메세지.
        	resultCode = getResultCode("fail.common.msg");
        	LoggerFactory.getLogger(this.getClass()).error(System.getProperty("line.separator") + "[" + e.getStackTrace() + "] " + e.getMessage(), e);
        } finally {
        	
			model.addAttribute(IConstants.RESULT, bResult ? IConstants.OK : IConstants.ERROR);
			model.addAttribute(IConstants.RESULTMSG, resultMsg);
			/** 통합통계로그 결과코드 셋팅 */
            /*statLogParam.setResultCode(resultCode);*/
        	HttpUtil.printServiceLogEnd(bizName, bResult, resultMsg, log);// 서비스로그 끝 출력
        }
        
        return (HttpUtil.isAjaxRequest(request) || bResult) ? IConstants.JSONVIEW : IConstants.ERROR_PAGE;

    }
    
}
