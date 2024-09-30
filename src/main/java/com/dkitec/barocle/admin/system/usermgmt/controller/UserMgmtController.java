/*
 * Copyright 2008-2009 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.dkitec.barocle.admin.system.usermgmt.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import com.dkitec.barocle.admin.common.vo.TroubleReportVO;
import com.dkitec.barocle.admin.login.security.encoder.Sha512PasswordEncoder;
import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.admin.login.vo.UserSessionVO;
import com.dkitec.barocle.admin.manage.center.service.CenterService;
import com.dkitec.barocle.admin.manage.center.vo.CenterVO;
import com.dkitec.barocle.admin.manage.stationgroup.service.StationGroupMgmtService;
import com.dkitec.barocle.admin.manage.stationgroup.vo.StationGroupMgmtVO;
import com.dkitec.barocle.admin.system.commonCodeMgmt.service.CommonCodeService;
import com.dkitec.barocle.admin.system.commonCodeMgmt.vo.CommonCodeVO;
import com.dkitec.barocle.admin.system.commonCodeMgmt.vo.CommonStationVO;
import com.dkitec.barocle.admin.system.teammgmt.vo.TeamMgmtVO;
import com.dkitec.barocle.admin.system.usergroupmgmt.service.UserGroupMgmtService;
import com.dkitec.barocle.admin.system.usergroupmgmt.vo.UserGroupMgmtVO;
import com.dkitec.barocle.admin.system.usermgmt.service.UserMgmtService;
import com.dkitec.barocle.admin.system.usermgmt.validator.UserMgmtValidator;
import com.dkitec.barocle.admin.system.usermgmt.vo.UserMgmtVO;
import com.dkitec.barocle.admin.manage.relocationcar.service.RelocationCarService;
import com.dkitec.barocle.base.IConstants;
import com.dkitec.barocle.datasource.AES256anicar;
import com.dkitec.barocle.util.encrypt.Sha512;
import com.dkitec.barocle.util.webutil.HttpUtil;
import com.dkitec.barocle.base.IConstants;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="UserMgmtController")
@RequestMapping(value="/admin/system/userMgmt")
public class UserMgmtController{

	/** Service */
    @Resource(name = "userMgmtService") private UserMgmtService usrService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

	@Resource(name = "userGroupMgmtService") private UserGroupMgmtService groService;
	@Resource(name = "stationGroupMgmtService") protected StationGroupMgmtService stationGroupMgmtService;
	@Resource(name = "centerService") 
	protected CenterService centerService;
	@Resource(name = "userMgmtValidator") private UserMgmtValidator usrValidator;
	
	@Resource(name = "commonCodeService") private CommonCodeService codeService;
	
	//관리자 등록 시 재배치 차량정보 가져오기_20160714_JJH_START
	@Resource(name = "relocationCarService") protected RelocationCarService relocationCarService;
	//관리자 등록 시 재배치 차량정보 가져오기_20160714_JJH_END
	
	protected static Logger log = LoggerFactory.getLogger(UserMgmtController.class);
	
	
    /**
	 * 운영자 - 목록화면
	 * @param model
	 * @return  "/adm/usr/usr_list"
	 * @exception Exception
	 */
	@RequestName(value="userList")
    @RequestMapping(value="userList")
    public String usrList(
    		HttpServletRequest request,
    		UserMgmtVO usrVO,
    		ModelMap model)
            throws Exception {

        String bizName = "운영자 관리 목록 조회";
        HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력

        boolean bResult = true;
        String resultMsg = IConstants.OK;
        
        try {
	        	
	    	usrVO.setRecordCountPerPage(propertiesService.getInt("pageUnit"));
	    	usrVO.setPageSize(propertiesService.getInt("pageSize"));
	    	
	    	/** pageing setting */
	    	PaginationInfo paginationInfo = new PaginationInfo();
	    	PaginationInfo paginationMobileInfo = new PaginationInfo();
	    	
			paginationInfo.setCurrentPageNo(usrVO.getCurrentPageNo());
			paginationMobileInfo.setCurrentPageNo(usrVO.getCurrentPageNo());
			
			paginationInfo.setRecordCountPerPage(usrVO.getPageSize());
			paginationInfo.setPageSize(usrVO.getRecordCountPerPage());
			
			paginationMobileInfo.setRecordCountPerPage(usrVO.getPageSize());
			paginationMobileInfo.setPageSize(propertiesService.getInt("pageMobileSize"));
			
			usrVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			usrVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
	
			int totCnt = usrService.getAdminManagerCount(usrVO);
			paginationInfo.setTotalRecordCount(totCnt);
			paginationMobileInfo.setTotalRecordCount(totCnt);
			
	        List<UserMgmtVO> usrList = usrService.getAdminManagerList(usrVO);
	        model.addAttribute("usrList", usrList);
	        model.addAttribute("paginationInfo", paginationInfo);
	        model.addAttribute("paginationMobileInfo", paginationMobileInfo);
	    	model.addAttribute("searchFrm", usrVO);
	    	model.addAttribute("usrList", usrList);
			
	    	//GROUP CODE LIST
	    	List<UserGroupMgmtVO> groNameList = groService.getGroupNameList(null);
	        model.addAttribute("groNameList", groNameList);

        } catch(Exception e) {
        	//TODO 에러 처리
        	bResult = false;
        	resultMsg = e.getMessage();	// 에러 메세지.
        	new CfoodException("admin.system.user.userList");
        } finally {
        	
			model.addAttribute(IConstants.RESULT, bResult ? IConstants.OK : IConstants.ERROR);
			model.addAttribute(IConstants.RESULTMSG, resultMsg);
			
        }

        return bResult ? "/admin/system/user/sys_adm_list" : IConstants.ERROR_PAGE;

    } 

    /**
	 * 운영자 - 등록 화면
	 * @param model
	 * @return  "/adm/usr/usr_list"
	 * @exception Exception
	 */
	@RequestName(value="usrInsertForm")
    @RequestMapping(value="usrInsertForm")
    public String usrInsertForm(
    		HttpServletRequest request,
    		UserMgmtVO usrVO,
    		ModelMap model)
            throws Exception {

        String bizName = "운영자 관리 등록 폼";
        HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력

        boolean bResult = true;
        String resultMsg = IConstants.OK;
        
        try {

	    	//CODE LIST
	    	List<UserGroupMgmtVO> groCodeList = groService.getGroupNameList(null);
	        model.addAttribute("groCodeList", groCodeList);
	        
	        //유인아파트 목록
	        List<StationGroupMgmtVO> group = stationGroupMgmtService.getHumanStationGroupNameList(null);
	        
	        // 아파트 목록
	        List<UserMgmtVO> aptList = usrService.getAptGrpList();
	        
	        //재배치 차량 목록_20160714_JJH
	        java.util.List<java.util.Map> returnMap = relocationCarService.getRelocateCarList();
	        model.addAttribute("relocateCarList", returnMap);
	        
	        //센터 목록
//	        CenterVO centerVo = new CenterVO();
//	        centerVo.setFirstRecordIndex(0);
//	        centerVo.setRecordCountPerPage(1000);
//	        List<CenterVO> center = centerService.listCenter(centerVo);
	        
	        // 배송 팀 목록
	        CommonCodeVO cVo = new CommonCodeVO();
	     	List<CommonCodeVO> codeList = null;
	     	cVo.setComUpCd("DEC");
	     	cVo.setLang(IConstants.LANG_KR);
	     	    	
	     	// 배송 팀 공통코드 조회
	     	codeList = codeService.getComCodeInfo(cVo);
	     	
	     	model.addAttribute("centerList", codeList);
//	        model.addAttribute("center", center);
	     	model.addAttribute("aptList", aptList);
	        model.addAttribute("group", group);
	        model.addAttribute("searchFrm", usrVO);
	        model.addAttribute("inputFrm", new UserMgmtVO());
	        
        } catch(Exception e) {
        	bResult = false;
        	resultMsg = e.getMessage();	// 에러 메세지.
        	new CfoodException("admin.system.user.usrInsertForm");
        } finally {
        	
			model.addAttribute(IConstants.RESULT, bResult ? IConstants.OK : IConstants.ERROR);
			model.addAttribute(IConstants.RESULTMSG, resultMsg);
			
			/*statLogParam.setResultCode(resultCode);*/
        	HttpUtil.printServiceLogEnd(bizName, bResult, resultMsg, log);// 서비스로그 끝 출력
        }

        return bResult ? "/admin/system/user/sys_adm_detail" : IConstants.ERROR_PAGE;

    } 

    /**
	 * 아이디 체크.
	 * @param MemberVO - 아이디 중복을 체크할 값이 들어있는 VO
	 * @param model
	 * @return IConstants.JSONVIEW
	 * @exception Exception
	 */
	@RequestName(value="idCheckAjax")
    @RequestMapping(value="idCheckAjax")
    public String idCheckAjax(
    		HttpServletRequest request,
    		UserMgmtVO usrVO,
    		ModelMap model)
            throws Exception {

//        String bizName = "사용자(운영, 사업, 제휴 공통 사용)관리 등록 폼";

        boolean bResult = true;
        String resultMsg = IConstants.OK;
        
        int result = 0;
        
        log.debug(usrVO.getUsrId());
        
        try {

        	log.debug("1");
        	usrValidator.usrIdCheck(usrVO);
        	log.debug("2");

        	result = usrService.usrIdCheck(usrVO);
        	log.debug("3");
        	
        	log.debug(result+"");
	
        	model.addAttribute(IConstants.CHECK_RESULT,result);
        	
        	
        } catch(Exception e) {
        	bResult = false;
        	new CfoodException("admin.system.user.idCheckAjax");
        	
        } finally {
        	/** Set result */
        	model.addAttribute(IConstants.RESULT, bResult ? IConstants.OK : IConstants.ERROR);
        	model.addAttribute(IConstants.RESULTMSG, resultMsg);

        }
    	return (HttpUtil.isAjaxRequest(request) || bResult) ? IConstants.JSONVIEW : IConstants.ERROR_PAGE;

    } 
   

    /**
     * 운영자 상세 화면로 이동한다.
     * @param TeamMgmtVO groVO
     * @return 출력화면정보 "/adm/gro/gro_modify"
     * @exception Exception
     */
	@RequestName(value="userInfo")
    @RequestMapping(value="userInfo")
    public String usrInfo(
    		HttpServletRequest request,
    		UserMgmtVO usrVO,
    		ModelMap model)
            throws Exception {

        String bizName = "운영자 관리 상세조회";
        HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력
        
        UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
 		usrVO.setMod_Id(userSessionVO.getUsrId());

        boolean bResult = true;
        String resultMsg = IConstants.OK;
        
        try {

        	usrValidator.usrInfoCheck(usrVO);
        	
	        UserMgmtVO usrInfo = usrService.getUsrInfo(usrVO);
	        
	        List<UserMgmtVO> adminUseList = usrService.getAdminUseList(usrVO);
	        
	    	//CODE LIST
	    	List<UserGroupMgmtVO> groCodeList = groService.getGroupNameList(null);
	        model.addAttribute("groCodeList", groCodeList);
	        List<StationGroupMgmtVO> group = stationGroupMgmtService.getHumanStationGroupNameList(null);
	        
	        //재배치 차량 목록_20160714_JJH
	        java.util.List<java.util.Map> returnMap = relocationCarService.getRelocateCarList();
	        model.addAttribute("relocateCarList", returnMap);
	        
	        //센터 목록
	        CenterVO centerVo = new CenterVO();
	        centerVo.setFirstRecordIndex(0);
	        centerVo.setRecordCountPerPage(1000);
	        List<CenterVO> center = centerService.listCenter(centerVo);
	        
	        // 배송 팀 목록
			CommonCodeVO cVo = new CommonCodeVO();
	    	List<CommonCodeVO> codeList = null;
	    	cVo.setComUpCd("DEC");
	    	cVo.setLang(IConstants.LANG_KR);
	    	
	    	// 배송 팀 공통코드 조회
	    	codeList = codeService.getComCodeInfo(cVo);
	        
	    	model.addAttribute("centerList", codeList);
	        model.addAttribute("group", group);
	        model.addAttribute("center", center);
	        model.addAttribute("searchFrm", usrVO);
	        model.addAttribute("inputFrm", usrInfo);
	        model.addAttribute("adminUseList", adminUseList);
	        
        } catch(Exception e) {
        	e.printStackTrace();
        	bResult = false;
        	new CfoodException("admin.system.user.userInfo");
        } finally {
        	/** Set result */
        	model.addAttribute(IConstants.RESULT, bResult ? IConstants.OK : IConstants.ERROR);
        	model.addAttribute(IConstants.RESULTMSG, resultMsg);

        }

        return bResult ? "/admin/system/user/sys_adm_detail" : IConstants.ERROR_PAGE;

    }

    /**
     * 운영자를 등록 한다.
     * @param TeamMgmtVO groVO
     * @return 출력화면정보 Const.JSONVIEW
     * @exception Exception
     */
	@RequestName(value="userInsert")
    @RequestMapping(value="userInsert")
    public String usrInsert(
    		HttpServletRequest request,
    		@Valid UserMgmtVO usrVO,
    		BindingResult bindingResult,
    		ModelMap model)
            throws Exception {

        String bizName = "운영자 관리 등록";
        HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력
        
        
        UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
 		usrVO.setCre_Id(userSessionVO.getUsrId());
		
   
        boolean bResult = true;
        String resultMsg = IConstants.OK;
        
        try {
	
	    	

	    	//CODE LIST
//	    	List<UserGroupMgmtVO> groCodeList = groService.getGroupNameList(null);
	        
	    	//usrValidator.usrInsertCheck(usrVO, groCodeList);
	    	
	    	/*if(bindingResult.hasErrors()) {
				for(FieldError fe : bindingResult.getFieldErrors()) {
					throw new CfoodException( "fail.input.param.error", fe.getDefaultMessage());
				}
			}*/
	    	
	    	log.debug(usrVO.getPhoneNo());
	    	log.debug(AES256anicar.encrypt(usrVO.getPhoneNo()));
	    	
//	    	Sha512PasswordEncoder sh = new Sha512PasswordEncoder();
//    		usrVO.setEncPwd(sh.encode(new StringBuffer(usrVO.getEncPwd())));
//	    	usrVO.setEncPwd(Sha512.getDigest(usrVO.getEncPwd()));
//	    	usrVO.setEmail(AES256anicar.encrypt(usrVO.getEmail()));
//	    	usrVO.setPhoneNo(AES256anicar.encrypt(usrVO.getPhoneNo()));
//	    	usrVO.setMpnNo(AES256anicar.encrypt(usrVO.getMpnNo()));
	    	
	    	log.debug("##### usrVo ##### => " + usrVO.toString());
	    	
	    	int result = usrService.insertUsr(usrVO);

	    	log.debug("########"+result );
        	model.addAttribute(IConstants.CHECK_RESULT,result);
        	
        	if(result > 0){
            	resultMsg = "성공";
        	}else{
            	resultMsg = "실패";
        	}

        } catch(Exception e) {
        	bResult = false;
        	new CfoodException("admin.system.user.userInsert");
        } finally {
        	/** Set result */
        	model.addAttribute(IConstants.RESULT, bResult ? IConstants.OK : IConstants.ERROR);
        	model.addAttribute(IConstants.RESULTMSG, resultMsg);
        	
        }
    	
    	return (HttpUtil.isAjaxRequest(request) || bResult) ? IConstants.JSONVIEW : IConstants.ERROR_PAGE;

    }

    /**
     * 운영자를 수정 한다.
     * @param TeamMgmtVO groVO
     * @return 출력화면정보 Const.JSONVIEW
     * @exception Exception
     */
	@RequestName(value="userUpdate")
    @RequestMapping(value="userUpdate")
    public String usrUpdate(
    		HttpServletRequest request,
    		@Valid UserMgmtVO usrVO,
    		BindingResult bindingResult,
    		ModelMap model)
            throws Exception {

        String bizName = "운영자 관리 수정";
        HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력

    
        boolean bResult = true;
        String resultMsg = IConstants.OK;
        
        try {
	
//        	UserSessionVO userSessionVO = (UserSessionVO) EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");

	    	//CODE LIST
	    	List<UserGroupMgmtVO> groCodeList = groService.getGroupNameList(null);
	    	model.addAttribute("group", groCodeList);
	    	    	
	    	int result = usrService.updateUsr(usrVO);
            
	    	UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
	 		usrVO.setMod_Id(userSessionVO.getUsrId());
	 		
	    	if(result > 0){
	    		if(!usrVO.getUseYn().equals(usrVO.getPreUseYn())){
	    			usrService.insertUsrHistory(usrVO);
	    		}
	    	}
	    	
	    	
        	model.addAttribute(IConstants.CHECK_RESULT,result);
        	
        	if(result > 0){
            	resultMsg = "성공";
        	}else{
            	resultMsg ="실패";
        	}

        } catch(Exception e) {
        	e.printStackTrace();
        	bResult = false;
        	new CfoodException("admin.system.user.userUpdate");
        } finally {
        	/** Set result */
        	model.addAttribute(IConstants.RESULT, bResult ? IConstants.OK : IConstants.ERROR);
        	model.addAttribute(IConstants.RESULTMSG, resultMsg);

        }
    	
    	return (HttpUtil.isAjaxRequest(request) || bResult) ? IConstants.JSONVIEW : IConstants.ERROR_PAGE;

    }
	
	
	@RequestName(value="cardCheckAjax")
    @RequestMapping(value="cardCheckAjax")
    public String cardCheckAjax(
    		HttpServletRequest request,
    		UserMgmtVO usrVO,
    		ModelMap model)
            throws Exception {


        boolean bResult = true;
        String resultMsg = IConstants.OK;
        
        String result = "OK";
        
        log.debug(usrVO.getUsrId());
        
        try {
        	resultMsg = usrService.cardNumCheck(usrVO);
        	log.debug("result : {}", result);
        	
        } catch(Exception e) {
        	bResult = false;
        	new CfoodException("admin.system.user.cardCheckAjax");
        	
        } finally {
        	/** Set result */
        	model.addAttribute(IConstants.RESULT, bResult ? IConstants.OK : IConstants.ERROR);
        	model.addAttribute(IConstants.RESULTMSG, resultMsg);

        }
    	return (HttpUtil.isAjaxRequest(request) || bResult) ? IConstants.JSONVIEW : IConstants.ERROR_PAGE;
    }
	@RequestName("getSmsAllAdminMpnNo")
	@RequestMapping("/getSmsAllAdminMpnNo.do")
	 public String getSmsAllAdminMpnNo(HttpServletRequest request,UserMgmtVO usrVO,ModelMap model) throws Exception {
	        log.debug("*********************관리자용 sms************************************");
	        List<UserMgmtVO> adminSmsList = null;
	        try {
	        	adminSmsList = 	usrService.getAdminAllSmsList(usrVO);
	        } catch(Exception e) {
	        	new CfoodException("admin.system.user.cardCheckAjax");
	        }
	        /** Set result */
        	model.addAttribute("smsList", adminSmsList);
        	
	    	return "/admin/common/popup/pop_sms_pro";
	    }
	
	/**
	 * 관리자 삭제_20161026_JJH
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/deleteAdminAjax.do")
	@RequestName("deleteAdminAjax")
	public String deleteAdminAjax(ModelMap model, HttpServletRequest request){
		String bizName = "관리자 삭제 Ajax";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		log.debug("#### deleteAdminAjax => " + request.getParameter("adminID"));
		
		int result = 0;
		result = usrService.deleteAdminAjax(String.valueOf(request.getParameter("adminID")));
		
		model.addAttribute("result", result);
		
		return IConstants.JSONVIEW;
	}
	
	/**
	 * 센터별 팀 조회_20181205
	 * @param model
	 * @param request
	 * @return
	 * @throws Exception 
	 */
	@RequestName(value="srchTeamList")
	@RequestMapping(value="/srchTeamList.do")
	public String srchTeamList(TeamMgmtVO teamVo, BindingResult result, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		List<TeamMgmtVO> team = null;
		
		team = usrService.teamList(teamVo);
		
		model.put("teamList", team);		
		
		return IConstants.JSONVIEW;
	}
}
