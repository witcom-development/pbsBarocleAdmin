package com.dkitec.barocle.admin.system.appversion.controller;

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
import com.dkitec.barocle.admin.customer.faq.vo.CategoryVO;
import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.admin.system.appversion.service.AppVersionService;
import com.dkitec.barocle.admin.system.appversion.vo.AppVersionVO;
import com.dkitec.barocle.admin.system.appversion.vo.AppVersionVO.AppVersionDeleteVal;
import com.dkitec.barocle.admin.system.appversion.vo.AppVersionVO.AppVersionEditVal;
import com.dkitec.barocle.admin.system.appversion.vo.AppVersionVO.AppVersionInsertVal;
import com.dkitec.barocle.admin.system.appversion.vo.AppVersionVO.AppVersionListVal;
import com.dkitec.barocle.admin.system.appversion.vo.AppVersionVO.AppVersionUpdateVal;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.StringUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="AppVersionController")
@RequestMapping(value="/admin/system/appVersion")
public class AppVersionController extends BaseController {
	
	@Resource(name = "appVersionService") private AppVersionService appVersionService;
	
	protected static Logger log = LoggerFactory.getLogger(AppVersionController.class);
	
	private final String[] appVersionSearchParameter = {"osClsCD","updateClsCD"};
	
	private static final String[] gubunList = {"OSS","UDT"};
	
	@RequestName(value="getAppVersionList")
	@RequestMapping(value="/appVersionList.do")
	public String getAppVersionList(@Validated(AppVersionListVal.class) AppVersionVO appVersionVO, BindingResult result, HttpServletRequest request, Model model) {
		
		/* Validator error */
		if(result.hasErrors()){
			model.addAttribute("appVersionView",appVersionVO);
			model.addAttribute("resultError",super.setResultMessage(result));
			return "/admin/system/appVersion/sys_ver_list";
		}
		
		boolean bResult = false;
		String resultPage = "/admin/system/appVersion/sys_ver_list";
		
		try{
			// 총 레코드 개수를 가져온다.
			appVersionVO.setTotalRecordCount(appVersionService.listAppVersionCount(appVersionVO));
			// 페이징
			PaginationInfo paginationInfo = getPagingInfo(appVersionVO.getCurrentPageNo(), appVersionVO.getTotalRecordCount());
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(appVersionVO.getCurrentPageNo(), appVersionVO.getTotalRecordCount());
			appVersionVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			appVersionVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			// 구분 코드
			setAppVersionCode(appVersionVO);
			// 현재 화면의 정보를 지정한다.
			model.addAttribute("appVersionView",appVersionVO);
			// 현재 화면에 표시되는 레코드 목록을 가져온다.
			model.addAttribute("appVersionList", appVersionService.listAppVersion(appVersionVO));
			// 현재 화면의 검색 파라미터 값을 지정한다.
			model.addAttribute("parameterInfo",super.setGivenParameterValue(request,this.appVersionSearchParameter));
			// 현재 화면에 표시되는 페이징 점보를 리턴한다.
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo",paginationMobileInfo);
			
			bResult = true;		// 정상
		} catch (Exception e) {
			throw new CfoodException("admin.system.appversion.appVersionList",e);
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestName(value="editAppVersion")
	@RequestMapping(value="/appVersionEdit.do")
	public String editAppVersion(@Validated(AppVersionEditVal.class) AppVersionVO appVersionVO, BindingResult result, HttpServletRequest request, Model model) {
		
		/* Validator error */
		if(result.hasErrors()){ throw new CfoodException("admin.system.appversion.appversionEdit.bindingexception"); }
		
		boolean bResult = false;
		String resultPage = "/admin/system/appVersion/sys_ver_detail";
		
		try{
			AppVersionVO resultVO = new AppVersionVO();
			
			if(appVersionVO.getAppSeq()>0){	//* appVerInfo>0 ? edit | write
				resultVO = (AppVersionVO)appVersionService.viewAppVersion(appVersionVO);
				resultVO.setMode("update");
			} else {
				resultVO.setMode("insert");
			}
			
			// 현재 화면를 가져온다.
			resultVO.setCurrentPageNo(appVersionVO.getCurrentPageNo());
			
			// 구분 코드
			setAppVersionCode(resultVO);
			// 현재 화면의 검색 파라미터 값을 지정한다.
			model.addAttribute("parameterInfo",super.setGivenParameterValue(request,this.appVersionSearchParameter));
			model.addAttribute("appVersionView",resultVO);
			
			bResult = true;		// 정상
			
		} catch (Exception e) {
			throw new CfoodException("admin.system.appversion.appVersionEdit",e);
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestName(value="insertAppVersion")
	@RequestMapping(value="/appVersionInsert.do")
	public String insertAppVersion(@Validated(AppVersionInsertVal.class) AppVersionVO appVersionVO, BindingResult result, HttpServletRequest request, Model model) {
		
		/* Validator error */
		if(result.hasErrors()){
			model.addAttribute("appVersionView",appVersionVO);
			model.addAttribute("resultError",super.setResultMessage(result));
			return "/admin/system/appVersion/sys_ver_detail";
		}
		
		boolean bResult = false;
		String resultPage = "redirect:/admin/system/appVersion/appVersionEdit.do?mode=edit&appSeq=";
		
		try{
			/* get set session */
			try{
				appVersionVO.setAdminID((String)EgovSessionCookieUtil.getSessionAttribute(request, "usrId"));
				appVersionVO.setAdminName((String)EgovSessionCookieUtil.getSessionAttribute(request, "usrName"));
			} catch(Exception e) {
				throw new CfoodException("admin.system.appversion.appVersionInsert.NullSessionException",e);
			}
			
			AppVersionVO returnVO = null;
			
			bResult = true;		// 정상
			
			if(MODE_INSERT.equalsIgnoreCase(appVersionVO.getMode())){
				// 강제 입력 변경
				appVersionVO.setOsClsCD("OSS_001");
				appVersionVO.setUpdateClsCD("UDT_001");
				returnVO = appVersionService.insertAppVersion(appVersionVO);
			} else bResult = false;
			
			if(bResult){ resultPage += String.valueOf(returnVO.getAppSeq()); }
			
		} catch (Exception e) {
			throw new CfoodException("admin.system.appversion.appVersionInsert",e);
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestName(value="updateAppVersion")
	@RequestMapping(value="/appVersionUpdate.do")
	public String updateAppVersion(@Validated(AppVersionUpdateVal.class) AppVersionVO appVersionVO, BindingResult result, HttpServletRequest request, Model model) {
		
		/* Validator error */
		if(result.hasErrors()){
			model.addAttribute("appVersionView",appVersionVO);
			model.addAttribute("resultError",super.setResultMessage(result));
			return "/admin/system/appVersion/sys_ver_detail";
		}
		
		boolean bResult = false;
		String resultPage = "redirect:/admin/system/appVersion/appVersionEdit.do?mode=edit&appSeq=";
		
		try{
			/* get set session */
			try{
				appVersionVO.setAdminID((String)EgovSessionCookieUtil.getSessionAttribute(request, "usrId"));
				appVersionVO.setAdminName((String)EgovSessionCookieUtil.getSessionAttribute(request, "usrName"));
			} catch(Exception e) {
				throw new CfoodException("admin.system.appversion.appVersionUpdate.NullSessionException",e);
			}
			
			AppVersionVO returnVO = null;
			
			bResult = true;		// 정상
			
			if(MODE_UPDATE.equalsIgnoreCase(appVersionVO.getMode())){
				returnVO = appVersionService.updateAppVersion(appVersionVO);
			} else bResult = false;
			
			if(bResult){ resultPage += String.valueOf(returnVO.getAppSeq()); }
			
		} catch (Exception e) {
			throw new CfoodException("admin.system.appversion.appVersionUpdate",e);
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestName(value="deleteAppVersion")
	@RequestMapping(value="/appVersionDelete.do")
	public String deleteAppVersion(@Validated(AppVersionDeleteVal.class) AppVersionVO appVersionVO, BindingResult result, Model model) {
		
		/* Validator error */
		if(result.hasErrors()){
			model.addAttribute("resultError", "권한이 없습니다.");
			throw new CfoodException("admin.system.appversion.appVersionDelete.bindingexception");
		}
		
		boolean bResult = false;
		String resultPage = "redirect:/admin/system/appVersion/appVersionList.do";
		
		try{
			if((appVersionService.deleteAppVersion(appVersionVO))>0){ bResult = true; }
		} catch (Exception e) {
			throw new CfoodException("admin.system.appversion.appVersionDelete",e);
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestName(value="confirmAppVersion")
	@RequestMapping(value="/appVersionConfirm.do")
	public String confirmAppVersion(HttpServletRequest request, Model model) {
		AppVersionVO appVersionVO = new AppVersionVO();
		if(request.getParameter("appVerInfo")!=null&&!StringUtil.isEmpty((String)request.getParameter("appVerInfo"))){
			appVersionVO.setAppVerInfo((String)request.getParameter("appVerInfo"));
			appVersionVO = appVersionService.confirmAppVersion(appVersionVO);
		}
		String str1 = appVersionVO.getAppVerInfo();
		String str2 = (String)request.getParameter("appVerInfo");
		model.addAttribute("appVerInfoReturn",str2.compareTo(str1));	// return 1 if str2 is newer version
		return JSONVIEW;
	}
	
	private void setAppVersionCode(AppVersionVO appVersionVO) {
		CategoryVO categoryVO = new CategoryVO();
		int count = 0;
		for(String gubun : gubunList){
			categoryVO.setComUpCD(gubun);
			java.util.List<CategoryVO> categoryListOSS = appVersionService.getSysComCD(categoryVO);
			switch (count){
				case 0 : appVersionVO.setCodeOSS(categoryListOSS);
				case 1 : appVersionVO.setCodeUDT(categoryListOSS);
			}
			count++;
		}
	}

}
