package com.dkitec.barocle.admin.maintenance.robReport.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.dkitec.barocle.admin.maintenance.robReport.service.RobReportService;
import com.dkitec.barocle.admin.maintenance.robReport.vo.RobReportVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.HttpUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@Controller
@RequestCategory("RobReportController")
public class RobReportController extends BaseController {
	protected static Logger log = LoggerFactory.getLogger(RobReportController.class);
	private static final String RETURN_URL = "/admin/maintenance/rob/";
	
	@Resource(name="robReportService") private RobReportService robReportService;
	@RequestMapping("/getRobReportList.do")
	@RequestName("getRobReportList")
	public String getRobReportList(@ModelAttribute RobReportVO robReportVo, ModelMap model, HttpServletRequest request) {
		
		String bizName = "도난보고 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        boolean result = false;
        String resultPage = RETURN_URL.concat("rob_rpt_list");
		
		try {
			if(robReportVo.getViewFlg().equals(MODE_EXCEL)){
				robReportVo.setPagingYn("N");
			}else{
				robReportVo.setPagingYn("Y");
			}
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			// 날짜 기본값 당일로 변경 2019.10.08
			if(robReportVo.getSearchBgnDe() == null && robReportVo.getSearchEndDe() == null){
				robReportVo.setSearchEndDe(sdf.format(cal.getTime()));
				//cal.add(Calendar.DAY_OF_MONTH, -6);
				robReportVo.setSearchBgnDe(sdf.format(cal.getTime()));
			}
			
			int totCnt = robReportService.getRobReportListCount(robReportVo);
			PaginationInfo paginationInfo = getPagingInfo(robReportVo.getCurrentPageNo(), totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(robReportVo.getCurrentPageNo(), totCnt);
			robReportVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			robReportVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<RobReportVO> robReportList = robReportService.getRobReportList(robReportVo);
			
			model.addAttribute("searchCondition",robReportVo );
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo",paginationMobileInfo);
			model.addAttribute("robReportList", robReportList);
			
			if(robReportVo.getViewFlg().equals(MODE_EXCEL)) {
				resultPage = RETURN_URL.concat("rob_rpt_list_excel");
    		}
			
			result = true;
		} catch (Exception e) {
			throw new CfoodException("admin.maintenance.rob.getRobReportList",e);
		}
		
		return result ? resultPage : ERROR_PAGE;
	}
	
}
