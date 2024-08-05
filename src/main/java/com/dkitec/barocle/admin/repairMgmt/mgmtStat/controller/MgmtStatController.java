package com.dkitec.barocle.admin.repairMgmt.mgmtStat.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.dkitec.barocle.admin.login.service.LoginService;
import com.dkitec.barocle.admin.repairMgmt.mgmtStat.service.MgmtStatService;
import com.dkitec.barocle.admin.repairMgmt.mgmtStat.vo.MgmtStatVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.HttpUtil;

@Controller
@RequestCategory(value="MgmtStatController")
public class MgmtStatController extends BaseController{
	protected static Logger log = LoggerFactory.getLogger(MgmtStatController.class);

	@Resource
	private MgmtStatService mgmtStatService;
	@Resource(name = "loginService") private LoginService loginService;	

	private static final String RETURN_URL = "/admin/repairMgmt/mgmtStat/";
	
	@RequestMapping(value = "/getMgmtStat.do")
	@RequestName("getMgmtStat")
	public String getMgmtStat(@ModelAttribute MgmtStatVO mgmtStatVO,@RequestParam(required = false) String pTempPwd, HttpServletRequest request,HttpServletResponse response,ModelMap model) throws Exception {
		String targetUrl = RETURN_URL.concat("mgmt_stat_list");
		String bizName = "관리팀 통계 조회";
		HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력
		
		boolean result = false;
		try {
			
				if(mgmtStatVO.getViewFlg().equals(MODE_EXCEL)) targetUrl = RETURN_URL.concat("mgmt_stat_list_excel");

				MgmtStatVO returnVO = new MgmtStatVO();

				Calendar cal = Calendar.getInstance();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				
				if(mgmtStatVO.getSearchBgnDe() == null && mgmtStatVO.getSearchEndDe() == null){
					
					if(pTempPwd != null) cal.add(Calendar.DATE, -1);
					
					mgmtStatVO.setSearchEndDe(sdf.format(cal.getTime()));
					
					mgmtStatVO.setSearchBgnDe(sdf.format(cal.getTime()));
					
					returnVO.setSearchEndDe(sdf.format(cal.getTime()));
					returnVO.setSearchBgnDe(sdf.format(cal.getTime()));
				} else {
					returnVO.setSearchEndDe(mgmtStatVO.getSearchEndDate());
					returnVO.setSearchBgnDe(mgmtStatVO.getSearchBgnDe());
				}
				
				
				returnVO.setAdminStatusList(mgmtStatService.getMgmtRepairAdminStatus(mgmtStatVO));
				returnVO.setRepairStatusList(mgmtStatService.getMgmtRepairStatus(mgmtStatVO));
				model.addAttribute("searchCondition", mgmtStatVO);
				model.addAttribute("mgmtStatVO", returnVO);
				result = true;
		} catch (CfoodException e) {
			throw new CfoodException("admin.repairMgmt.mgmtStat.getMgmtStat" , e.getMessage());
		}
		
		return result ? targetUrl : ERROR_PAGE;
	}
}
