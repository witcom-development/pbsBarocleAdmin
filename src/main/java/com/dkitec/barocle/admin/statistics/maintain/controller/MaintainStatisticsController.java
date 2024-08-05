package com.dkitec.barocle.admin.statistics.maintain.controller;

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
import com.dkitec.barocle.admin.statistics.maintain.service.MaintainStatisticsService;
import com.dkitec.barocle.admin.statistics.maintain.vo.MaintainStatisticsVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.HttpUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="MaintainStatisticsController")
public class MaintainStatisticsController extends BaseController {
	protected static Logger log = LoggerFactory.getLogger(MaintainStatisticsController.class);
	@Resource(name="maintainStatisticsService")
	
	private MaintainStatisticsService maintainStatisticsService;
	
	private static final String RETURN_URL = "/admin/statistics/";
	
	@RequestMapping(value="/maintain/errorStatistics.do")
	@RequestName(value="errorStatistics")
	public String errorStatistics(@ModelAttribute @Valid MaintainStatisticsVO maintainStatisticsVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("maintain/stt_err_stat");
		String bizName = "장애 통계";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DAY_OF_MONTH, -2);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowDay = sdf.format(cal.getTime());

			if(maintainStatisticsVo.getDateType() == null){
				maintainStatisticsVo.setDateType("D");
			}
			if(maintainStatisticsVo.getSearchBgnDe() == null){
				maintainStatisticsVo.setSearchBgnDe(nowDay);
			}
			if(maintainStatisticsVo.getSearchEndDe() == null){
				maintainStatisticsVo.setSearchEndDe(nowDay);
			}
			if(maintainStatisticsVo.getDeviceType() == null){
				maintainStatisticsVo.setDeviceType("DEV_001");
			}
					
			int totCnt = 0;
			
			if(maintainStatisticsVo.getDateType().equals("D")){
				totCnt = maintainStatisticsService.getFaultDayCnt(maintainStatisticsVo);
			}else if(maintainStatisticsVo.getDateType().equals("M")){
				totCnt = maintainStatisticsService.getFaultMonthCnt(maintainStatisticsVo);
			}else if(maintainStatisticsVo.getDateType().equals("Y")){
				totCnt = maintainStatisticsService.getFaultYearCnt(maintainStatisticsVo);
			}
			
			int stateCodeCnt = maintainStatisticsService.getFaultStateCnt(maintainStatisticsVo);
			PaginationInfo paginationInfo = getPagingInfo(maintainStatisticsVo.getCurrentPageNo(), stateCodeCnt, stateCodeCnt, totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(maintainStatisticsVo.getCurrentPageNo(), totCnt);
			
			maintainStatisticsVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			maintainStatisticsVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			maintainStatisticsVo.setPagingYn("Y");
			List<MaintainStatisticsVO> resultList = null;
			
			if(maintainStatisticsVo.getDateType().equals("D")){
				resultList = maintainStatisticsService.getFaultDayList(maintainStatisticsVo);
			}else if(maintainStatisticsVo.getDateType().equals("M")){
				resultList = maintainStatisticsService.getFaultMonthList(maintainStatisticsVo);
			}else if(maintainStatisticsVo.getDateType().equals("Y")){
				resultList = maintainStatisticsService.getFaultYearList(maintainStatisticsVo);
			}
			
			model.addAttribute("searchCondition", maintainStatisticsVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("stateCodeCnt", stateCodeCnt);
			model.addAttribute("dataList", resultList);
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.statistics.errorStatistics");
		}

		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestMapping(value="/maintain/errorStatisticsExcel.do")
	@RequestName(value="errorStatisticsExcel")
	public String errorStatisticsExcel(@ModelAttribute @Valid MaintainStatisticsVO maintainStatisticsVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("maintain/stt_err_stat_excel");
		String bizName = "장애 통계 Excel";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DAY_OF_MONTH, -2);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowDay = sdf.format(cal.getTime());

			if(maintainStatisticsVo.getDateType() == null){
				maintainStatisticsVo.setDateType("D");
			}
			if(maintainStatisticsVo.getSearchBgnDe() == null){
				maintainStatisticsVo.setSearchBgnDe(nowDay);
			}
			if(maintainStatisticsVo.getSearchEndDe() == null){
				maintainStatisticsVo.setSearchEndDe(nowDay);
			}
			if(maintainStatisticsVo.getDeviceType() == null){
				maintainStatisticsVo.setDeviceType("DEV_001");
			}
					
			int totCnt = 0;
			
			if(maintainStatisticsVo.getDateType().equals("D")){
				totCnt = maintainStatisticsService.getFaultDayCnt(maintainStatisticsVo);
			}else if(maintainStatisticsVo.getDateType().equals("M")){
				totCnt = maintainStatisticsService.getFaultMonthCnt(maintainStatisticsVo);
			}else if(maintainStatisticsVo.getDateType().equals("Y")){
				totCnt = maintainStatisticsService.getFaultYearCnt(maintainStatisticsVo);
			}
			
			int stateCodeCnt = maintainStatisticsService.getFaultStateCnt(maintainStatisticsVo);
			PaginationInfo paginationInfo = getPagingInfo(maintainStatisticsVo.getCurrentPageNo(), stateCodeCnt, stateCodeCnt, totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(maintainStatisticsVo.getCurrentPageNo(), totCnt);
			
			maintainStatisticsVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			maintainStatisticsVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			maintainStatisticsVo.setPagingYn("N");
			List<MaintainStatisticsVO> resultList = null;
			
			if(maintainStatisticsVo.getDateType().equals("D")){
				resultList = maintainStatisticsService.getFaultDayList(maintainStatisticsVo);
			}else if(maintainStatisticsVo.getDateType().equals("M")){
				resultList = maintainStatisticsService.getFaultMonthList(maintainStatisticsVo);
			}else if(maintainStatisticsVo.getDateType().equals("Y")){
				resultList = maintainStatisticsService.getFaultYearList(maintainStatisticsVo);
			}

			model.addAttribute("searchCondition", maintainStatisticsVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("stateCodeCnt", stateCodeCnt);
			model.addAttribute("dataList", resultList);
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.statistics.errorStatistics");
		}

		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestMapping(value="/maintain/repairStatistics.do")
	@RequestName(value="repairStatistics")
	public String repairStatistics(@ModelAttribute @Valid MaintainStatisticsVO maintainStatisticsVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("maintain/stt_err_rpr");
		String bizName = "수리 통계";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DAY_OF_MONTH, -2);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowDay = sdf.format(cal.getTime());

			if(maintainStatisticsVo.getDateType() == null){
				maintainStatisticsVo.setDateType("D");
			}
			if(maintainStatisticsVo.getSearchBgnDe() == null){
				maintainStatisticsVo.setSearchBgnDe(nowDay);
			}
			if(maintainStatisticsVo.getSearchEndDe() == null){
				maintainStatisticsVo.setSearchEndDe(nowDay);
			}
			if(maintainStatisticsVo.getDeviceType() == null){
				maintainStatisticsVo.setDeviceType("DEV_001");
			}
					
			int totCnt = 0;
			
			if(maintainStatisticsVo.getDateType().equals("D")){
				totCnt = maintainStatisticsService.getRepairDayCnt(maintainStatisticsVo);
			}else if(maintainStatisticsVo.getDateType().equals("M")){
				totCnt = maintainStatisticsService.getRepairMonthCnt(maintainStatisticsVo);
			}else if(maintainStatisticsVo.getDateType().equals("Y")){
				totCnt = maintainStatisticsService.getRepairYearCnt(maintainStatisticsVo);
			}
			
			int stateCodeCnt = maintainStatisticsService.getRepairStateCnt(maintainStatisticsVo);
			PaginationInfo paginationInfo = getPagingInfo(maintainStatisticsVo.getCurrentPageNo(), stateCodeCnt, stateCodeCnt, totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(maintainStatisticsVo.getCurrentPageNo(), totCnt);
			
			maintainStatisticsVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			maintainStatisticsVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

			maintainStatisticsVo.setPagingYn("Y");
			List<MaintainStatisticsVO> resultList = null;
			
			if(maintainStatisticsVo.getDateType().equals("D")){
				resultList = maintainStatisticsService.getRepairDayList(maintainStatisticsVo);
			}else if(maintainStatisticsVo.getDateType().equals("M")){
				resultList = maintainStatisticsService.getRepairMonthList(maintainStatisticsVo);
			}else if(maintainStatisticsVo.getDateType().equals("Y")){
				resultList = maintainStatisticsService.getRepairYearList(maintainStatisticsVo);
			}

			model.addAttribute("searchCondition", maintainStatisticsVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("stateCodeCnt", stateCodeCnt);
			model.addAttribute("dataList", resultList);
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.statistics.repairStatistics");
		}
		
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestMapping(value="/maintain/repairStatisticsExcel.do")
	@RequestName(value="repairStatisticsExcel")
	public String repairStatisticsExcel(@ModelAttribute @Valid MaintainStatisticsVO maintainStatisticsVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("maintain/stt_err_rpr_excel");
		String bizName = "수리 통계 Excel";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DAY_OF_MONTH, -2);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowDay = sdf.format(cal.getTime());

			if(maintainStatisticsVo.getDateType() == null){
				maintainStatisticsVo.setDateType("D");
			}
			if(maintainStatisticsVo.getSearchBgnDe() == null){
				maintainStatisticsVo.setSearchBgnDe(nowDay);
			}
			if(maintainStatisticsVo.getSearchEndDe() == null){
				maintainStatisticsVo.setSearchEndDe(nowDay);
			}
			if(maintainStatisticsVo.getDeviceType() == null){
				maintainStatisticsVo.setDeviceType("DEV_001");
			}
					
			int totCnt = 0;
			
			if(maintainStatisticsVo.getDateType().equals("D")){
				totCnt = maintainStatisticsService.getRepairDayCnt(maintainStatisticsVo);
			}else if(maintainStatisticsVo.getDateType().equals("M")){
				totCnt = maintainStatisticsService.getRepairMonthCnt(maintainStatisticsVo);
			}else if(maintainStatisticsVo.getDateType().equals("Y")){
				totCnt = maintainStatisticsService.getRepairYearCnt(maintainStatisticsVo);
			}


			int stateCodeCnt = maintainStatisticsService.getRepairStateCnt(maintainStatisticsVo);
			PaginationInfo paginationInfo = getPagingInfo(maintainStatisticsVo.getCurrentPageNo(), stateCodeCnt, stateCodeCnt, totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(maintainStatisticsVo.getCurrentPageNo(), totCnt);
			
			maintainStatisticsVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			maintainStatisticsVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

			maintainStatisticsVo.setPagingYn("N");
			List<MaintainStatisticsVO> resultList = null;
			
			if(maintainStatisticsVo.getDateType().equals("D")){
				resultList = maintainStatisticsService.getRepairDayList(maintainStatisticsVo);
			}else if(maintainStatisticsVo.getDateType().equals("M")){
				resultList = maintainStatisticsService.getRepairMonthList(maintainStatisticsVo);
			}else if(maintainStatisticsVo.getDateType().equals("Y")){
				resultList = maintainStatisticsService.getRepairYearList(maintainStatisticsVo);
			}
			
			model.addAttribute("searchCondition", maintainStatisticsVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("stateCodeCnt", stateCodeCnt);
			model.addAttribute("dataList", resultList);
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.statistics.repairStatisticsExcel");
		}
		
		return bResult ? resultPage : ERROR_PAGE;
	}
}
