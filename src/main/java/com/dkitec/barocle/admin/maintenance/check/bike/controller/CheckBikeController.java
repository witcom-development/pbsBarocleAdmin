package com.dkitec.barocle.admin.maintenance.check.bike.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.admin.login.vo.UserSessionVO;
import com.dkitec.barocle.admin.maintenance.check.bike.service.CheckBikeService;
import com.dkitec.barocle.admin.maintenance.check.bike.vo.CheckBikeVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.HttpUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="CheckBikeController")
public class CheckBikeController extends BaseController {
	protected static Logger log = LoggerFactory.getLogger(CheckBikeController.class);
	@Resource(name="checkBikeService")
	
	private CheckBikeService checkBikeService;
	
	private static final String RETURN_URL = "/admin/maintenance/check/bike/";

	@RequestMapping(value="/checkBikeList.do")
	@RequestName(value="getCheckBikeList")
	public String getCheckBikeList(@ModelAttribute @Valid CheckBikeVO checkBikeVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("che_bike_list");
		String bizName = "자전거 점검관리 화면";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			
			if(checkBikeVo.getViewFlg().equals(MODE_EXCEL)){
				checkBikeVo.setPagingYn("N");
			}else{
				checkBikeVo.setPagingYn("Y");
			}
			
			/*checkBikeVo.setPagingYn("Y");*/
			
			if(checkBikeVo.getChkType() == null){
				checkBikeVo.setChkType("S");
			}
			
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			
			if(checkBikeVo.getSearchBgnDe() == null && checkBikeVo.getSearchEndDe() == null){
				checkBikeVo.setSearchEndDe(sdf.format(cal.getTime()));
				cal.add(Calendar.DAY_OF_MONTH, -6);
				checkBikeVo.setSearchBgnDe(sdf.format(cal.getTime()));
			}
			
			int totCnt = checkBikeService.getCheckBikeListCount(checkBikeVo);
			PaginationInfo paginationInfo = getPagingInfo(checkBikeVo.getCurrentPageNo(), totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(checkBikeVo.getCurrentPageNo(), totCnt);
			
			checkBikeVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			checkBikeVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<CheckBikeVO> resultList = checkBikeService.getCheckBikeList(checkBikeVo);
					
			model.addAttribute("searchCondition", checkBikeVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("CheckBikeList", resultList);
			
			if(checkBikeVo.getViewFlg().equals(MODE_EXCEL)) {
				resultPage = RETURN_URL.concat("che_bike_list_excel");
    		}
			
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.maintenance.che_bike_list");
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}

	@RequestMapping(value="/exeBikeSelectCheck.do")
	@RequestName(value="exeBikeSelectCheck")
	public String exeBikeSelectCheck(@ModelAttribute @Valid CheckBikeVO checkBikeVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		
		String bizName = "자전거 선택점검";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        
        try {
        	UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
            if(userSessionVO == null){
            	throw new CfoodException(getMessage("error.invalidSession"));
            }
            checkBikeVo.setModId(userSessionVO.getUsrId());
            
			checkBikeService.exeBikeSelectCheck(checkBikeVo);
            
			model.addAttribute(RESULT_MESSAGE, "Success");
			model.addAttribute(CHECK_RESULT, 0);
		} catch (Exception e) {
			throw new CfoodException("admin.system.maintenance.exeBikeSelectCheck");
		}
		return JSONVIEW;
	}
	
	@RequestMapping(value="/exeBikeAllCheck.do")
	@RequestName(value="exeBikeAllCheck")
	public String exeBikeAllCheck(@ModelAttribute @Valid CheckBikeVO checkBikeVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		
		String bizName = "자전거 전체점검";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			checkBikeVo.setPagingYn("N");
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			if(checkBikeVo.getSearchBgnDe() == null && checkBikeVo.getSearchEndDe() == null){
				checkBikeVo.setSearchEndDe(sdf.format(cal.getTime()));
				cal.add(Calendar.DAY_OF_MONTH, -6);
				checkBikeVo.setSearchBgnDe(sdf.format(cal.getTime()));
			}
			
			List<CheckBikeVO> resultList = checkBikeService.getCheckBikeList(checkBikeVo);
			
			UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
			if(userSessionVO == null){
				throw new CfoodException(getMessage("error.invalidSession"));
			}
			
			checkBikeVo.setModId(userSessionVO.getUsrId());
			checkBikeService.exeBikeAllCheck(checkBikeVo, resultList);

			model.addAttribute(RESULT_MESSAGE, "Success");
			model.addAttribute(CHECK_RESULT, 0);
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.maintenance.exeBikeAllCheck");
		}

		return JSONVIEW;
	}
}
