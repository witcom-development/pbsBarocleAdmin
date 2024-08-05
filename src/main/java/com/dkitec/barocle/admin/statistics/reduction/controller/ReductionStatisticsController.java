package com.dkitec.barocle.admin.statistics.reduction.controller;

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
import com.dkitec.barocle.admin.statistics.reduction.service.ReductionStatisticsService;
import com.dkitec.barocle.admin.statistics.reduction.vo.ReductionStatisticsVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.HttpUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="ReductionStatisticsController")
public class ReductionStatisticsController extends BaseController {
	protected static Logger log = LoggerFactory.getLogger(ReductionStatisticsController.class);
	
	@Resource(name="reductionStatisticsService") private ReductionStatisticsService reductionStatisticsService;

	private static final String RETURN_URL = "/admin/statistics/";

	@RequestMapping(value="/reduction/reductionTypeStatistics.do")
	@RequestName(value="reductionTypeStatistics")
	public String paymentTypeStatistics(@ModelAttribute @Valid ReductionStatisticsVO reductionStatisticsVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("reduction/stt_reduction_type");
		String bizName = "할인 구분별 현황";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			
			// 날짜조회 (날짜 없을경우 현 날짜로 조회)
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowDay = sdf.format(cal.getTime());
			
			cal.add(Calendar.DATE , -6);
			String nowDay2 = sdf.format(cal.getTime());
			
			if(reductionStatisticsVo.getSearchBgnDe() == null){
				reductionStatisticsVo.setSearchBgnDe(nowDay2);
			}
			if(reductionStatisticsVo.getSearchEndDe() == null){
				reductionStatisticsVo.setSearchEndDe(nowDay);
			}
			
			int totCnt = reductionStatisticsService.getReductionTypeListCnt(reductionStatisticsVo);
			
			PaginationInfo paginationInfo = getPagingInfo(reductionStatisticsVo.getCurrentPageNo(), totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(reductionStatisticsVo.getCurrentPageNo(), totCnt);

			reductionStatisticsVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			reductionStatisticsVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			reductionStatisticsVo.setPagingYn("Y");
			List<ReductionStatisticsVO> resultList = reductionStatisticsService.getReductionTypeList(reductionStatisticsVo);
			
			bResult = true;		// 정상 
			model.addAttribute("searchCondition", reductionStatisticsVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("dataList", resultList);
			
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.statistics.paymentTypeStatistics");
		}
			
		return bResult ? resultPage : ERROR_PAGE;
		
	}
	
	@RequestMapping(value="/reduction/paymentTypeStatisticsExcel.do")
	@RequestName(value="paymentTypeStatisticsExcel")
	public String paymentTypeStatisticsExcel(@ModelAttribute @Valid ReductionStatisticsVO reductionStatisticsVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("reduction/stt_reduction_type_excel");
		String bizName = "결제수단별 현황 Excel";
		HttpUtil.printServiceLogStart(bizName, log, request);
		try{
			
			// 날짜조회 (날짜 없을경우 현 날짜로 조회)
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowDay = sdf.format(cal.getTime());
			
			cal.add(Calendar.DATE , -6);
			String nowDay2 = sdf.format(cal.getTime());
			
			if(reductionStatisticsVo.getSearchBgnDe() == null){
				reductionStatisticsVo.setSearchBgnDe(nowDay2);
			}
			if(reductionStatisticsVo.getSearchEndDe() == null){
				reductionStatisticsVo.setSearchEndDe(nowDay);
			}
			
			int totCnt = reductionStatisticsService.getReductionTypeListCnt(reductionStatisticsVo);
			
			PaginationInfo paginationInfo = getPagingInfo(reductionStatisticsVo.getCurrentPageNo(), totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(reductionStatisticsVo.getCurrentPageNo(), totCnt);

			reductionStatisticsVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			reductionStatisticsVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			reductionStatisticsVo.setPagingYn("N");
			List<ReductionStatisticsVO> resultList = reductionStatisticsService.getReductionTypeList(reductionStatisticsVo);
		
			bResult = true;		// 정상 
			model.addAttribute("searchCondition", reductionStatisticsVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("dataList", resultList);
			model.addAttribute("chkYn",reductionStatisticsVo.getChkDailyTicket());
			
			
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.statistics.paymentTypeStatisticsExcel");
		}
			
		return bResult ? resultPage : ERROR_PAGE;
		
	}
	
}
