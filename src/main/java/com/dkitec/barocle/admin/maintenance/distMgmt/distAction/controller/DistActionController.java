package com.dkitec.barocle.admin.maintenance.distMgmt.distAction.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.admin.login.vo.UserSessionVO;
import com.dkitec.barocle.admin.maintenance.distMgmt.distAction.service.DistActionService;
import com.dkitec.barocle.admin.maintenance.distMgmt.distAction.vo.DistActionListVO;
import com.dkitec.barocle.admin.maintenance.distMgmt.distAction.vo.DistActionVO;
import com.dkitec.barocle.admin.maintenance.distMgmt.distributionDiary.service.DistributionDiaryService;
import com.dkitec.barocle.admin.maintenance.distMgmt.distributionDiary.vo.DistCoWorkVO;
import com.dkitec.barocle.admin.maintenance.distMgmt.vcleMgmt.vo.VcleMgmtVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.DateUtil;
import com.dkitec.barocle.util.webutil.HttpUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@Controller
@RequestCategory("DistActionController")
public class DistActionController extends BaseController {
	protected static Logger log = LoggerFactory.getLogger(DistActionController.class);
	
	@Resource(name="distActionService") private DistActionService distActionService;
	
	
	@RequestMapping(value = "/distActionInsertAjax.do")
	@RequestName("distActionInsertAjax")
	public String distActionInsertAjax(@ModelAttribute @Valid DistActionVO distActionVO, HttpServletRequest request,ModelMap model) throws Exception {
		String bizName = "분배원 작업행위 처리";
		HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력
		
		String todayDate = DateUtil.getSystemDate("yyyy-MM-dd");
		try {
			
			distActionVO.setSearchEndDe(todayDate);
			distActionVO.setSearchBgnDe(todayDate);
			
			UserSessionVO userSessionVO = (UserSessionVO) EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
			distActionVO.setAdminId(userSessionVO.getUsrId());
			System.out.println( distActionVO.toString() );
			model.addAttribute(RESULT_MESSAGE, distActionService.distActionInsert(distActionVO));
			
		} catch (CfoodException e) {
			throw new CfoodException("admin.maintenance.distMgmt.distAction.distActionInsert" , e.getMessage());
		}
		
		return JSONVIEW;
	}
	
	@RequestMapping("/distActionSelectList.do")
	@RequestName("distActionSelectList")
	public String distActionSelectList(@ModelAttribute DistActionListVO vo, ModelMap model, HttpServletRequest request) {
		
		String bizName = "공동근무 화면 이동";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        boolean result = false;
        String resultPage = "/admin/maintenance/distMgmt/distributionDiary/dist_action_list";
        UserSessionVO userSessionVO = null;  
        
        if(vo.getViewFlg().equals(MODE_EXCEL)) resultPage = "/admin/maintenance/distMgmt/distributionDiary/dist_action_list_excel";
        
		try {
			userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		if(vo.getSearchBgnDe() == null || "".equals(vo.getSearchBgnDe())){
			
			String todayDate = DateUtil.getSystemDate("yyyy-MM-dd");
			
			vo.setSearchBgnDe(todayDate);
			vo.setSearchEndDe(todayDate);
		}	
        
		try {
			int totCnt = distActionService.distActionListCnt(vo);
			PaginationInfo paginationInfo = getPagingInfo(vo.getCurrentPageNo(), totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(vo.getCurrentPageNo(), totCnt);
			
			vo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			vo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<DistActionListVO> list = distActionService.distActionSelect(vo);
			
			
			model.addAttribute("searchCondition", vo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("dsList", list);
			result = true;
		} catch (Exception e) {
			throw new CfoodException("admin.maintenance.distMgmt.distAction.distActionSelectList",e.getMessage());
		}
		
		return result ? resultPage : ERROR_PAGE;
	}
}
