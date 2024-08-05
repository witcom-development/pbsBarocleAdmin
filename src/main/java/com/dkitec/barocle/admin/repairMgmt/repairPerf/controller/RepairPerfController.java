package com.dkitec.barocle.admin.repairMgmt.repairPerf.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
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
import com.dkitec.barocle.admin.repairMgmt.repairPerf.service.RepairPerfService;
import com.dkitec.barocle.admin.repairMgmt.repairPerf.vo.RepairPerfVO;
import com.dkitec.barocle.admin.repairMgmt.repairPerf.vo.RepairRoundPerfStaticsVO;
import com.dkitec.barocle.admin.repairMgmt.repairPerf.vo.RepairRoundPerfVO;
import com.dkitec.barocle.admin.repairMgmt.repairWork.vo.RepairWorkVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.HttpUtil;

@Controller
@RequestCategory(value="RepairPerfController")
public class RepairPerfController extends BaseController{
	protected static Logger log = LoggerFactory.getLogger(RepairPerfController.class);

	@Resource
	private RepairPerfService repairPerfService;

	private static final String RETURN_URL = "/admin/repairMgmt/repairPerf/";
	
	@RequestMapping(value = "/getRepairPerf.do")
	@RequestName("getRepairPerf")
	public String getRepairPerf(@ModelAttribute @Valid RepairPerfVO repairPerfVO, HttpServletRequest request,ModelMap model) throws Exception {
		String targetUrl = RETURN_URL.concat("repair_perf_list");
		String bizName = "정비원 실적 조회";
		HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력
		boolean result = false;
		try {
			
				
			if(repairPerfVO.getViewFlg().equals(MODE_EXCEL)) targetUrl = RETURN_URL.concat("repair_perf_list_excel");
				
			
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			
			if(repairPerfVO.getSearchBgnDe() == null && repairPerfVO.getSearchEndDe() == null){
				
				repairPerfVO.setSearchEndDe(sdf.format(cal.getTime()));
				
				repairPerfVO.setSearchBgnDe(sdf.format(cal.getTime()));
			}
			
			if(repairPerfVO.getAdminId() == null){

				userSessionVO = (UserSessionVO) EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
				
				repairPerfVO.setAdminId(userSessionVO.getUsrId());
				
			}
			
			RepairWorkVO wVo = new RepairWorkVO();
			wVo.setAdminId(repairPerfVO.getAdminId());
			repairPerfVO.setAdminGrpName(repairPerfService.getAdminGrpName(wVo));
			
			if("정비반장".equals(repairPerfVO.getAdminGrpName()) && repairPerfVO.getCenterId() == null){
				repairPerfVO.setCenterId(repairPerfService.getInsertWrkCenterId(wVo));
			}
			
			RepairPerfVO rVO = repairPerfService.getRepairPerfCmptCnt(repairPerfVO);
			
			repairPerfVO.setRepairBikeCnt(rVO.getRepairBikeCnt());
			repairPerfVO.setRepairTermCnt(rVO.getRepairTermCnt());
			repairPerfVO.setRepairTotCnt(rVO.getRepairTotCnt());
			
			List<RepairPerfVO> perfList = repairPerfService.getMaintenWrkerPerf(repairPerfVO);
			
			model.addAttribute("searchCondition", repairPerfVO);
			model.addAttribute("wrkPerfList", perfList);
			result = true;
		} catch (CfoodException e) {
			throw new CfoodException("admin.repairMgmt.repairPerf.getRepairPerf" , e.getMessage());
		}
		
		return result ? targetUrl : ERROR_PAGE;
	}
	
	
	
	@RequestMapping(value = "/getRoundRepairPerf.do")
	@RequestName("getRepairPerf")
	public String getround_RepairPerf(@ModelAttribute @Valid RepairPerfVO repairPerfVO, HttpServletRequest request,ModelMap model) throws Exception {
		String targetUrl = RETURN_URL.concat("round_repair_perf_list");
		String bizName = "순회정비 직원 실적 조회";
		HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력
		boolean result = false;
		try {
			
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			
			if(repairPerfVO.getSearchBgnDe() == null && repairPerfVO.getSearchEndDe() == null){
				
				repairPerfVO.setSearchEndDe(sdf.format(cal.getTime()));
				
				repairPerfVO.setSearchBgnDe(sdf.format(cal.getTime()));
			}
 
			if(repairPerfVO.getAdminId() == null){
				userSessionVO = (UserSessionVO) EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
			//	repairPerfVO.setAdminId(userSessionVO.getUsrId());
				
			}
			
			switch ( userSessionVO.getUsrGrpCd()) {
				case "27" :
					repairPerfVO.setAdminId( userSessionVO.getUsrId() );
					break;
				case "28" :	
					if ( repairPerfVO.getSearchCenter() == null || "".equals(repairPerfVO.getSearchCenter()) ) {
						repairPerfVO.setSearchCenter( "N" );
					}
			}
			if(repairPerfVO.getViewFlg().equals(MODE_EXCEL)) {
				targetUrl = RETURN_URL.concat("round_repair_perf_list_excel");
				List<RepairRoundPerfStaticsVO> perfList = repairPerfService.getRoundRepairPerfCmptCnt(repairPerfVO);
				model.addAttribute("wrkPerfList", perfList);
				
				List<RepairRoundPerfVO> perfDtlList = new ArrayList<>(); 
				if ( repairPerfVO.getSearchBgnDe().equals( repairPerfVO.getSearchEndDe() ) ) {
					perfDtlList = repairPerfService.getRoundMaintenWrkerPerf(repairPerfVO);
				}	
				model.addAttribute("perfDtlList", perfDtlList);
				
			} else {
				List<RepairRoundPerfStaticsVO> perfList = repairPerfService.getRoundRepairPerfCmptCnt(repairPerfVO);
				model.addAttribute("wrkPerfList", perfList);
				
				List<RepairRoundPerfVO> perfDtlList = new ArrayList<>(); 
				if ( repairPerfVO.getSearchBgnDe().equals( repairPerfVO.getSearchEndDe() ) ) {
					perfDtlList = repairPerfService.getRoundMaintenWrkerPerf(repairPerfVO);
				}	
				model.addAttribute("perfDtlList", perfDtlList);
			}
			
			
			model.addAttribute("searchCondition", repairPerfVO);
			result = true;
		} catch (CfoodException e) {
			throw new CfoodException("admin.repairMgmt.repairPerf.getRepairPerf" , e.getMessage());
		}
		
		return result ? targetUrl : ERROR_PAGE;
	}
}
