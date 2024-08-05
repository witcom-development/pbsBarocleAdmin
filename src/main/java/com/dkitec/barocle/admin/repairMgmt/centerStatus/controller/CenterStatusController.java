package com.dkitec.barocle.admin.repairMgmt.centerStatus.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.admin.login.vo.UserSessionVO;
import com.dkitec.barocle.admin.repairMgmt.centerStatus.service.CenterStatusService;
import com.dkitec.barocle.admin.repairMgmt.centerStatus.vo.CenterStatusVO;
import com.dkitec.barocle.admin.repairMgmt.mgmtStat.vo.MgmtStatVO;
import com.dkitec.barocle.admin.repairMgmt.repairPerf.service.RepairPerfService;
import com.dkitec.barocle.admin.repairMgmt.repairPerf.vo.RepairPerfVO;
import com.dkitec.barocle.admin.repairMgmt.repairWork.service.RepairWorkService;
import com.dkitec.barocle.admin.repairMgmt.repairWork.vo.RepairWorkVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.HttpUtil;

@Controller
@RequestCategory(value="CenterStatusController")
public class CenterStatusController extends BaseController{
	protected static Logger log = LoggerFactory.getLogger(CenterStatusController.class);

	@Resource(name="CenterStatusService") private CenterStatusService centerStatusService;
	@Resource(name="RepairWorkService") private RepairWorkService repairWorkService;

	@Resource
	private RepairPerfService repairPerfService;
	
	private static final String RETURN_URL = "/admin/repairMgmt/centerStatus/";
	
	@RequestMapping(value = "/getCenterStatus.do")
	@RequestName("getCenterStatus")
	public String getCenterStatus(@ModelAttribute @Valid CenterStatusVO centerStatusVO, HttpServletRequest request,ModelMap model) throws Exception {
		String targetUrl = RETURN_URL.concat("center_status_list");
		String bizName = "사업소 현황 조회";
		HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력
		boolean result = false;
		try {
			
			if(centerStatusVO.getViewFlg().equals(MODE_EXCEL)) targetUrl = RETURN_URL.concat("center_status_list_excel");
			
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			
			if(centerStatusVO.getSearchBgnDe() == null && centerStatusVO.getSearchEndDe() == null){
				centerStatusVO.setSearchEndDe(sdf.format(cal.getTime()));
				//cal.add(Calendar.DAY_OF_MONTH, -6);   -> 20200904 매번 바꾸기 불편하다고함
				centerStatusVO.setSearchBgnDe(sdf.format(cal.getTime()));
			}
			
			RepairWorkVO rVo = new RepairWorkVO();	
			userSessionVO = (UserSessionVO) EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
			rVo.setAdminId(userSessionVO.getUsrId());
			
			centerStatusVO.setAdminGrpName(repairWorkService.getAdminGrpName(rVo));
			
			
			// 20210203
			RepairPerfVO repairPerfVO = new RepairPerfVO();
			repairPerfVO.setAdminGrpName("정비반장");
			repairPerfVO.setSearchBgnDe(centerStatusVO.getSearchBgnDe());
			repairPerfVO.setSearchEndDe(centerStatusVO.getSearchEndDe());
			repairPerfVO.setSearchCenter(centerStatusVO.getSearchCenter());
			repairPerfVO.setCenterId(centerStatusVO.getSearchCenter());
			List<RepairPerfVO> perfList = repairPerfService.getMaintenWrkerPerf(repairPerfVO);
			model.addAttribute("wrkPerfList", perfList);

			
			if("정비반장".equals(centerStatusVO.getAdminGrpName()) && centerStatusVO.getCenterId() == null){
				
				centerStatusVO.setCenterId(repairWorkService.getInsertWrkCenterId(rVo));
				
			}else if("관리운영그룹".equals(centerStatusVO.getAdminGrpName()) && centerStatusVO.getSearchCenter() == null){
				
				centerStatusVO.setSearchCenter(repairWorkService.getInsertWrkCenterId(rVo));
			}
			
			CenterStatusVO statusVO = centerStatusService.getCenterStatus(centerStatusVO);
			statusVO.setWorkAdminList(centerStatusService.getAdminsStatus(centerStatusVO));
			
			
			model.addAttribute("searchCondition", centerStatusVO);
			
			
			model.addAttribute("statusVO",statusVO);
			
		
			String dec = "";
			List<CenterStatusVO> list  = centerStatusService.getEtcDesc(centerStatusVO);
			
			
			if( list.size() > 0 ) {
				dec = list.get(0).getEtcDesc();
			}
		 
			
			model.addAttribute("etcText", dec );
			model.addAttribute("adminId", userSessionVO.getUsrId() );
			
			result = true;
		} catch (CfoodException e) {
			throw new CfoodException("admin.repairMgmt.centerStatus.getCenterStatus" , e.getMessage());
		}
		
		return result ? targetUrl : ERROR_PAGE;
	}
	
	
	@RequestName(value="insertEtcDesc")
	@RequestMapping(value="/insertEtcDescAjax.do"  )

	public String regBlackListAjax(CenterStatusVO centerStatusVO, BindingResult bResult, ModelMap model, HttpServletRequest request) throws UnsupportedEncodingException {
		
		String bizName = "기타사항 등록";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		// centerStatusVO.setEtcDesc( URLDecoder.decode(centerStatusVO.getEtcDesc(), "UTF-8") );
 
		System.out.println( centerStatusVO.getEtcDesc() );
		
		int isSuccess = centerStatusService.insertEtcDesc(centerStatusVO);
		model.addAttribute("isSuccess", String.valueOf(isSuccess));
		
		return JSONVIEW;
		
	}
}
