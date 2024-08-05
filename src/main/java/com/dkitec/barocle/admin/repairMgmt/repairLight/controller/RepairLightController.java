package com.dkitec.barocle.admin.repairMgmt.repairLight.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
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
import com.dkitec.barocle.admin.common.service.CommonPopupService;
import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.admin.login.vo.UserSessionVO;
import com.dkitec.barocle.admin.repairMgmt.repairLight.service.RepairLightService;
import com.dkitec.barocle.admin.repairMgmt.repairLight.vo.RepairLightVO;
import com.dkitec.barocle.admin.repairMgmt.repairWork.vo.RepairWorkVO;
import com.dkitec.barocle.admin.system.commonCodeMgmt.service.CommonCodeService;
import com.dkitec.barocle.admin.system.commonCodeMgmt.vo.CommonCodeVO;
import com.dkitec.barocle.admin.system.teammgmt.service.TeamMgmtService;
import com.dkitec.barocle.admin.system.teammgmt.vo.TeamMgmtVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.base.IConstants;
import com.dkitec.barocle.util.webutil.HttpUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="RepairLightController")
public class RepairLightController extends BaseController{
	protected static Logger log = LoggerFactory.getLogger(RepairLightController.class);

	@Resource
	private RepairLightService repairLightService;
	@Resource(name="commonPopupService") private CommonPopupService commonPopupService;
	@Resource(name="commonCodeService") private CommonCodeService commonCodeService;
	private static final String RETURN_URL = "/admin/repairMgmt/repairLight/";
	@Resource(name = "teamMgmtService") private TeamMgmtService teamService;

	@RequestMapping(value = "/getLightRepairBike.do")
	@RequestName("getLightRepairBike")
	public String getRepairLight(@ModelAttribute @Valid RepairLightVO repairLightVO, HttpServletRequest request,ModelMap model) throws Exception {
		String targetUrl = RETURN_URL.concat("rep_bike_light_member");
		String bizName = "수리직원 실적 조회";
		HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력
		boolean result = false;
		try {
				
			if(repairLightVO.getViewFlg().equals(MODE_EXCEL)) targetUrl = RETURN_URL.concat("rep_bike_light_member_excel");
			/*
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			
			if(repairLightVO.getSearchBgnDe() == null && repairLightVO.getSearchEndDe() == null){
				repairLightVO.setSearchEndDe(sdf.format(cal.getTime()));
				repairLightVO.setSearchBgnDe(sdf.format(cal.getTime()));
			}*/
			
			userSessionVO = (UserSessionVO) EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
			// 분배직원
			if( userSessionVO.getUsrGrpCd().equals("5")) {
				repairLightVO.setSearchAdmin(	userSessionVO.getUsrName() );
			} else if( userSessionVO.getUsrGrpCd().equals("11")) {
		        // 배송 팀 목록
				TeamMgmtVO teamVO = new TeamMgmtVO();
				teamVO.setTeamSeq(userSessionVO.getTeamSeq());
		    	TeamMgmtVO vo = teamService.getTeamInfo(teamVO);
				repairLightVO.setSearchCenter(	vo.getCenterId() );
			}
			
			CommonCodeVO cVo = new CommonCodeVO();
	    	List<CommonCodeVO> codeList = null;
	    	cVo.setComUpCd("DEC");
	    	cVo.setLang(IConstants.LANG_KR);
	    	
	    	// 배송 팀 공통코드 조회
	    	codeList = commonCodeService.getComCodeInfo(cVo);
	    	
	    	repairLightVO.setAdminGrpName( userSessionVO.getUsrGrpName() );
	    	
			model.addAttribute("searchCondition", repairLightVO);
			model.addAttribute("wrkLightList", repairLightService.getMaintenWrkerLight(repairLightVO));
			
			model.addAttribute("teamList", codeList);
			
			result = true;
			
		} catch (CfoodException e) {
			throw new CfoodException("admin.repairMgmt.repairLight.getRepairLight" , e.getMessage());
		}
		return result ? targetUrl : ERROR_PAGE;
	}
}
 
