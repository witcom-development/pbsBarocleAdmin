package com.dkitec.barocle.admin.statistics.rent.controller;

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
import com.dkitec.barocle.admin.statistics.rent.service.RentStatisticsService;
import com.dkitec.barocle.admin.statistics.rent.vo.RentStatisticsVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.HttpUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="RentStatisticsController")
public class RentStatisticsController extends BaseController {
	protected static Logger log = LoggerFactory.getLogger(RentStatisticsController.class);
	@Resource(name="rentStatisticsService")
	
	private RentStatisticsService rentStatisticsService;
	
	private static final String RETURN_URL = "/admin/statistics/";
	
	@RequestMapping(value="/rent/rentStatistics.do")
	@RequestName(value="rentStatistics")
	public String rentStatistics(@ModelAttribute @Valid RentStatisticsVO rentStatisticsVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("rent/stt_bike_bike");
		String bizName = "대여 통계";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DAY_OF_MONTH, -2);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowDay = sdf.format(cal.getTime());

			if(rentStatisticsVo.getDateType() == null){
				rentStatisticsVo.setDateType("D");
			}
			if(rentStatisticsVo.getSearchBgnDe() == null){
				rentStatisticsVo.setSearchBgnDe(nowDay);
			}
			if(rentStatisticsVo.getSearchEndDe() == null){
				rentStatisticsVo.setSearchEndDe(nowDay);
			}
					
			int totCnt = 0;
			if(rentStatisticsVo.getDateType().equals("D")){
				totCnt = rentStatisticsService.getRentDayCnt(rentStatisticsVo);
			}else if(rentStatisticsVo.getDateType().equals("M")){
				totCnt = rentStatisticsService.getRentMonthCnt(rentStatisticsVo);
			}
			PaginationInfo paginationInfo = getPagingInfo(rentStatisticsVo.getCurrentPageNo(), totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(rentStatisticsVo.getCurrentPageNo(), totCnt);
			
			rentStatisticsVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			rentStatisticsVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			rentStatisticsVo.setPagingYn("Y");
			List<RentStatisticsVO> resultList = null;
			if(rentStatisticsVo.getDateType().equals("D")){
				resultList = rentStatisticsService.getRentDayList(rentStatisticsVo);
			}else if(rentStatisticsVo.getDateType().equals("M")){
				resultList = rentStatisticsService.getRentMonthList(rentStatisticsVo);
			}

			model.addAttribute("searchCondition", rentStatisticsVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("dataList", resultList);
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.statistics.rentStatistics");
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestMapping(value="/rent/rentStatisticsExcel.do")
	@RequestName(value="rentStatisticsExcel")
	public String rentStatisticsExcel(@ModelAttribute @Valid RentStatisticsVO rentStatisticsVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("rent/stt_bike_bike_excel");
		String bizName = "대여 통계 Excel";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DAY_OF_MONTH, -2);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowDay = sdf.format(cal.getTime());

			if(rentStatisticsVo.getDateType() == null){
				rentStatisticsVo.setDateType("D");
			}
			if(rentStatisticsVo.getSearchBgnDe() == null){
				rentStatisticsVo.setSearchBgnDe(nowDay);
			}
			if(rentStatisticsVo.getSearchEndDe() == null){
				rentStatisticsVo.setSearchEndDe(nowDay);
			}
					
			int totCnt = 0;
			if(rentStatisticsVo.getDateType().equals("D")){
				totCnt = rentStatisticsService.getRentDayCnt(rentStatisticsVo);
			}else if(rentStatisticsVo.getDateType().equals("M")){
				totCnt = rentStatisticsService.getRentMonthCnt(rentStatisticsVo);
			}
			PaginationInfo paginationInfo = getPagingInfo(rentStatisticsVo.getCurrentPageNo(), totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(rentStatisticsVo.getCurrentPageNo(), totCnt);
			
			rentStatisticsVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			rentStatisticsVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			rentStatisticsVo.setPagingYn("N");
			List<RentStatisticsVO> resultList = null;
			if(rentStatisticsVo.getDateType().equals("D")){
				resultList = rentStatisticsService.getRentDayList(rentStatisticsVo);
			}else if(rentStatisticsVo.getDateType().equals("M")){
				resultList = rentStatisticsService.getRentMonthList(rentStatisticsVo);
			}

			model.addAttribute("searchCondition", rentStatisticsVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("dataList", resultList);
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.statistics.rentStatisticsExcel");
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestMapping(value="/rent/returnStatistics.do")
	@RequestName(value="returnStatistics")
	public String returnStatistics(@ModelAttribute @Valid RentStatisticsVO rentStatisticsVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("rent/stt_bike_return");
		String bizName = "반납 통계";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DAY_OF_MONTH, -2);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowDay = sdf.format(cal.getTime());

			if(rentStatisticsVo.getDateType() == null){
				rentStatisticsVo.setDateType("D");
			}
			if(rentStatisticsVo.getSearchBgnDe() == null){
				rentStatisticsVo.setSearchBgnDe(nowDay);
			}
			if(rentStatisticsVo.getSearchEndDe() == null){
				rentStatisticsVo.setSearchEndDe(nowDay);
			}
					
			int totCnt = 0;
			if(rentStatisticsVo.getDateType().equals("D")){
				totCnt = rentStatisticsService.getReturnDayCnt(rentStatisticsVo);
			}else if(rentStatisticsVo.getDateType().equals("M")){
				totCnt = rentStatisticsService.getReturnMonthCnt(rentStatisticsVo);
			}
			PaginationInfo paginationInfo = getPagingInfo(rentStatisticsVo.getCurrentPageNo(), totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(rentStatisticsVo.getCurrentPageNo(), totCnt);
			
			rentStatisticsVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			rentStatisticsVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			rentStatisticsVo.setPagingYn("Y");
			List<RentStatisticsVO> resultList = null;
			if(rentStatisticsVo.getDateType().equals("D")){
				resultList = rentStatisticsService.getReturnDayList(rentStatisticsVo);
			}else if(rentStatisticsVo.getDateType().equals("M")){
				resultList = rentStatisticsService.getReturnMonthList(rentStatisticsVo);
			}

			model.addAttribute("searchCondition", rentStatisticsVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("dataList", resultList);
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.statistics.returnStatistics");
		}
		
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestMapping(value="/rent/returnStatisticsExcel.do")
	@RequestName(value="returnStatisticsExcel")
	public String returnStatisticsExcel(@ModelAttribute @Valid RentStatisticsVO rentStatisticsVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("rent/stt_bike_return_excel");
		String bizName = "반납 통계";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DAY_OF_MONTH, -2);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowDay = sdf.format(cal.getTime());

			if(rentStatisticsVo.getDateType() == null){
				rentStatisticsVo.setDateType("D");
			}
			if(rentStatisticsVo.getSearchBgnDe() == null){
				rentStatisticsVo.setSearchBgnDe(nowDay);
			}
			if(rentStatisticsVo.getSearchEndDe() == null){
				rentStatisticsVo.setSearchEndDe(nowDay);
			}
					
			int totCnt = 0;
			if(rentStatisticsVo.getDateType().equals("D")){
				totCnt = rentStatisticsService.getReturnDayCnt(rentStatisticsVo);
			}else if(rentStatisticsVo.getDateType().equals("M")){
				totCnt = rentStatisticsService.getReturnMonthCnt(rentStatisticsVo);
			}
			PaginationInfo paginationInfo = getPagingInfo(rentStatisticsVo.getCurrentPageNo(), totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(rentStatisticsVo.getCurrentPageNo(), totCnt);
			
			rentStatisticsVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			rentStatisticsVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			rentStatisticsVo.setPagingYn("N");
			List<RentStatisticsVO> resultList = null;
			if(rentStatisticsVo.getDateType().equals("D")){
				resultList = rentStatisticsService.getReturnDayList(rentStatisticsVo);
			}else if(rentStatisticsVo.getDateType().equals("M")){
				resultList = rentStatisticsService.getReturnMonthList(rentStatisticsVo);
			}

			model.addAttribute("searchCondition", rentStatisticsVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("dataList", resultList);
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.statistics.returnStatisticsExcel");
		}
		
		return bResult ? resultPage : ERROR_PAGE;
	}
}