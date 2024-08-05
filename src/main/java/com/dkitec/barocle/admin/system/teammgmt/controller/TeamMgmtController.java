package com.dkitec.barocle.admin.system.teammgmt.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.admin.login.vo.UserSessionVO;
import com.dkitec.barocle.admin.system.MenuMgmt.service.MenuMgmtService;
import com.dkitec.barocle.admin.system.MenuMgmt.vo.MenuMgmtVO;
import com.dkitec.barocle.admin.system.commonCodeMgmt.service.CommonCodeService;
import com.dkitec.barocle.admin.system.commonCodeMgmt.vo.CommonCodeVO;
import com.dkitec.barocle.admin.system.teammgmt.service.TeamMgmtService;
import com.dkitec.barocle.admin.system.teammgmt.validator.TeamMgmtValidator;
import com.dkitec.barocle.admin.system.teammgmt.vo.TeamMgmtVO;
import com.dkitec.barocle.admin.system.usermgmt.service.UserMgmtService;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.base.IConstants;
import com.dkitec.barocle.util.webutil.HttpUtil;
import com.dkitec.barocle.util.webutil.StringUtil;

import egovframework.rte.fdl.cmmn.exception.EgovBizException;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="TeamMgmtController")
@RequestMapping(value="/admin/system/teamMgmt")
public class TeamMgmtController extends BaseController {
	

	@Resource(name = "teamMgmtService") private TeamMgmtService teamService;

    @Resource(name = "commonCodeService") private CommonCodeService codeService;

    @Resource(name = "menuMgmtService") private MenuMgmtService  menuService;

    @Resource(name = "teamMgmtValidator") private TeamMgmtValidator teamValidator;
    
	protected static Logger log = LoggerFactory.getLogger(TeamMgmtController.class);
    
	
	
	/**
	 * 공통 리턴화면 
	 * @param methodName
	 * @return
	 */
	protected String getReturnUrl(String methodName) {
		return "/admin/system/teamMgmt/" + methodName;
	}
	
	
    /**
     * 권한목록를 조회한다.
     * @param TeamMgmtVO teamVO
     * @return 출력화면정보 "/admin/system/team/sys_team_list"
     * @exception Exception
     */
	@RequestName(value="teamList")
    @RequestMapping(value="/teamList.do")
    public String selectTeamList(
    		@ModelAttribute("searchVO") TeamMgmtVO teamVO,
    		HttpServletRequest request,
    		ModelMap model)
            throws Exception {

        String bizName = "팀 목록 조회";
        HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력
        
		String resultCode = IConstants.OK_CODE;
		
                
        boolean bResult = true;
        String resultMsg = IConstants.OK;
        
        try {

        	teamVO.setRecordCountPerPage(propertiesService.getInt("pageUnit"));
        	teamVO.setPageSize(propertiesService.getInt("pageSize"));
        	/** pageing setting */
        	PaginationInfo paginationInfo = new PaginationInfo();
        	PaginationInfo paginationMobileInfo = new PaginationInfo();
        	
    		paginationInfo.setCurrentPageNo(teamVO.getCurrentPageNo());
    		paginationMobileInfo.setCurrentPageNo(teamVO.getCurrentPageNo());
    		
    		paginationInfo.setPageSize(teamVO.getRecordCountPerPage());
    		paginationInfo.setRecordCountPerPage(teamVO.getPageSize());
    		
    		paginationMobileInfo.setRecordCountPerPage(teamVO.getPageSize());
    		paginationMobileInfo.setPageSize(propertiesService.getInt("pageMobileSize"));
    		
    		teamVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
    		teamVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
    		int totCnt = teamService.getTeamCount(teamVO);
    		
    		paginationInfo.setTotalRecordCount(totCnt);
    		paginationMobileInfo.setTotalRecordCount(totCnt);
    		
        	List<TeamMgmtVO> teamList = teamService.getTeamList(teamVO);
    		
            model.addAttribute("paginationInfo", paginationInfo);
            model.addAttribute("paginationMobileInfo", paginationMobileInfo);
            
        	model.addAttribute("searchFrm", teamVO);
        	
        	model.addAttribute("teamList", teamList);

        	CommonCodeVO cVo = new CommonCodeVO();
        	List<CommonCodeVO> codeList = null;
        	cVo.setComUpCd("DEC");
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
        log.debug(getReturnUrl("sys_team_list"));
        return  getReturnUrl("sys_team_list") ;

    }

    /**
     * 팀 등록 화면로 이동한다.
     * @param TeamMgmtVO teamVO
     * @return 출력화면정보 "/admin/system/team/sys_team_detail"
     * @exception Exception
     */
	@RequestName(value="teamInsertForm")
    @RequestMapping(value="/teamInsertForm.do")
    public String teamInsertForm(
    		TeamMgmtVO teamVO,
    		HttpServletRequest request,
    		ModelMap model)
            throws Exception {

        String bizName = "팀 등록 화면";
        HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력

		String resultCode = IConstants.OK_CODE;
        
        boolean bResult = true;
        String resultMsg = IConstants.OK;
        
        try {
        	
        	CommonCodeVO cVo = new CommonCodeVO();
        	List<CommonCodeVO> codeList = null;
        	cVo.setComUpCd("DEC");
        	cVo.setLang(IConstants.LANG_KR);
        	
        	// 배송 팀 공통코드 조회
        	codeList = codeService.getComCodeInfo(cVo);
        	
        	// 팀 공통코드 조회
        	List<CommonCodeVO> teamList = null;
        	cVo.setComUpCd("TEAM");
        	teamList = codeService.getComCodeInfo(cVo);
        	
     	
        	model.addAttribute("type", IConstants.CRUD_C);
        	model.addAttribute("centerList", codeList);
        	model.addAttribute("teamList", teamList);
	    	model.addAttribute("searchFrm", teamVO);
	    	model.addAttribute("inputFrm", new TeamMgmtVO());
	    	
	    	
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
        
        return bResult ? "/admin/system/teamMgmt/sys_team_detail" : IConstants.ERROR_PAGE;

    }

    /**
     * 팀 상세 화면로 이동한다.
     * @param TeamMgmtVO teamVO
     * @return 출력화면정보 "/admin/system/team/sys_team_detail"
     * @exception Exception
     */
	@RequestName(value="teamInfo")
    @RequestMapping(value="teamInfo")
    public String teamInfo(
    		TeamMgmtVO teamVO,
    		HttpServletRequest request,
    		ModelMap model)
            throws Exception {

        String bizName = "팀 상세 화면";
        HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력

		String resultCode = IConstants.OK_CODE;
        
        
		//추가 : 2017.03.06_세션 가져오기
	    UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
		
        boolean bResult = true;
        String resultMsg = IConstants.OK;
        
        try {
        	teamValidator.teamInfoCheck(teamVO);
        	
        	CommonCodeVO cVo = new CommonCodeVO();
        	List<CommonCodeVO> codeList = null;
        	cVo.setComUpCd("DEC");
        	cVo.setLang(IConstants.LANG_KR);
        	
        	// 배송 센터 공통코드 조회
        	codeList = codeService.getComCodeInfo(cVo);
        	
        	// 팀 공통코드 조회
        	List<CommonCodeVO> teamList = null;
        	cVo.setComUpCd("TEAM");
        	teamList = codeService.getComCodeInfo(cVo);
        	
        	model.addAttribute("sessionUsrGrpCd", userSessionVO.getUsrGrpCd());//추가 : 2017.03.07_JHN
        	model.addAttribute("userSessionVO", userSessionVO);//추가 : 2017.03.27_JHN
        	model.addAttribute("centerList", codeList);
        	model.addAttribute("teamList", teamList);
	    	model.addAttribute("searchVO", teamVO);
	    	model.addAttribute("teamVO", teamVO);
	
	    	model.addAttribute("searchFrm", teamVO);
	    	model.addAttribute("inputFrm", teamService.getTeamInfo(teamVO));
	    	model.addAttribute("type", IConstants.CRUD_U);
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
        
        return bResult ? "/admin/system/teamMgmt/sys_team_detail" : IConstants.ERROR_PAGE;

    }

    /**
     * 권한을 등록 한다.
     * @param TeamMgmtVO teamVO
     * @return 출력화면정보 IConstants.JSONVIEW
     * @exception Exception
     */
	@RequestName(value="teamInsert")
    @RequestMapping(value="teamInsert")
    public String teamInsert(
    		@Valid TeamMgmtVO teamVO,
    		BindingResult bindingResult,
    		HttpServletRequest request,
    		ModelMap model)
            throws Exception {

        String bizName = "팀 등록";
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
        	teamVO.setCreId(userSessionVO.getUsrId());
        	
        	teamValidator.teamInsertCheck(teamVO);
        	
        	if(bindingResult.hasErrors()) {
				for(FieldError fe : bindingResult.getFieldErrors()) {
					throw new EgovBizException(messageSource, "fail.input.param.error", new Object[] {fe.getDefaultMessage()}, new Exception());
				}
			}
        	
        	// 중복 체크
        	TeamMgmtVO rsteamVO = teamService.getTeamInfo(teamVO);
        	if(rsteamVO != null) {
        		bResult = false;
        		resultMsg = getMessage("fail.duplicated.team", new String[]{"팀 중복"});
        		resultCode = getResultCode("fail.duplicated.team");
        	} else {
        		int result = teamService.insertTeam(teamVO);

            	model.addAttribute(IConstants.CHECK_RESULT,result);
            	
            	if(result > 0){
                	resultMsg = getMessage("success.common.insert2", new String[]{getMessage("opr.team")});
            	}else{
            		bResult = false;
                	resultMsg = getMessage("fail.common.insert2", new String[]{getMessage("opr.team")});
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
     * @param TeamMgmtVO teamVO
     * @return 출력화면정보 IConstants.JSONVIEW
     * @exception Exception
     */
	@RequestName(value="teamUpdate")
    @RequestMapping(value="teamUpdate")
    public String teamUpdate(
    		@Valid TeamMgmtVO teamVO,
    		BindingResult bindingResult,
    		HttpServletRequest request,
    		ModelMap model)
            throws Exception {

        String bizName = "팀 수정";
        HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력

		String resultCode = IConstants.OK_CODE;
        
		boolean bResult = true;
        String resultMsg = IConstants.OK;
        log.debug("#########"+ teamVO);
        try {
        	
        	UserSessionVO userSessionVO = (UserSessionVO) EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
        	teamVO.setModId(userSessionVO.getUsrId());
        	
        	
        	teamValidator.teamUpdateCheck(teamVO);
        	
        	if(bindingResult.hasErrors()) {
				for(FieldError fe : bindingResult.getFieldErrors()) {
					throw new EgovBizException(messageSource, "fail.input.param.error", new Object[] {fe.getDefaultMessage()}, new Exception());
				}
			}
        	
	    	int result = teamService.updateTeam(teamVO);

        	model.addAttribute(IConstants.CHECK_RESULT,result);
        	
        	if(result > 0){
            	resultMsg = getMessage("success.common.update2", new String[]{getMessage("opr.team")});
        	}else{
        		bResult = false;
            	resultMsg = getMessage("fail.common.update2", new String[]{getMessage("opr.team")});
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
     * 팀을 삭제 한다.
     * @param TeamMgmtVO teamVO
     * @return 출력화면정보 IConstants.JSONVIEW
     * @exception Exception
     */
	@RequestName(value="teamDelete")
    @RequestMapping(value="teamDelete")
    public String teamDelete(
    		TeamMgmtVO teamVO,
    		HttpServletRequest request,
    		ModelMap model)
            throws Exception {

        String bizName = "팀 삭제";
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
        	//teamValidator.teamDeleteCheck(teamVO);
        	
	    	int result = teamService.deleteTeam(teamVO);

        	model.addAttribute(IConstants.CHECK_RESULT,result);
        	
        	if(result > 0){
            	resultMsg = getMessage("success.common.delete2", new String[]{getMessage("opr.team")});
        	}else{
        		bResult = false;
            	resultMsg = getMessage("fail.common.delete2", new String[]{getMessage("opr.team")});
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

}
