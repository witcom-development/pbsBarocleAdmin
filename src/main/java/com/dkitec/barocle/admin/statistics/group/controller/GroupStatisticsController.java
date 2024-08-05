package com.dkitec.barocle.admin.statistics.group.controller;

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
import com.dkitec.barocle.admin.statistics.group.service.GroupStatisticsService;
import com.dkitec.barocle.admin.statistics.group.vo.GroupStatisticsVO;
import com.dkitec.barocle.admin.statistics.join.vo.JoinStatisticsVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.HttpUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="GroupStatisticsController")
public class GroupStatisticsController extends BaseController {
	protected static Logger log = LoggerFactory.getLogger(GroupStatisticsController.class);
	@Resource(name="groupStatisticsService")
	
	private GroupStatisticsService groupStatisticsService;
	
	private static final String RETURN_URL = "/admin/statistics/";

	@RequestMapping(value="/group/groupMoveStatistics.do")
	@RequestName(value="groupMoveStatistics")
	public String groupMoveStatistics(@ModelAttribute @Valid GroupStatisticsVO groupStatisticsVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("group/stt_grp_mov");
		String bizName = "그룹간 이동 통계";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DAY_OF_MONTH, -2);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowDay = sdf.format(cal.getTime());
			
			if(groupStatisticsVo.getDateType() == null){
				groupStatisticsVo.setDateType("D");
			}
			if(groupStatisticsVo.getSearchBgnDe() == null){
				groupStatisticsVo.setSearchBgnDe(nowDay);
			}
			if(groupStatisticsVo.getSearchEndDe() == null){
				groupStatisticsVo.setSearchEndDe(nowDay);
			}
			
			int totCnt = 0;
			if(groupStatisticsVo.getDateType().equals("D")){
				totCnt = groupStatisticsService.getGroupMoveDayCnt(groupStatisticsVo);
			}else if(groupStatisticsVo.getDateType().equals("M")){
				totCnt = groupStatisticsService.getGroupMoveMonthCnt(groupStatisticsVo);
			}
			
			PaginationInfo paginationInfo = getPagingInfo(groupStatisticsVo.getCurrentPageNo(), totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(groupStatisticsVo.getCurrentPageNo(), totCnt);

			groupStatisticsVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			groupStatisticsVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

			groupStatisticsVo.setPagingYn("Y");
			List<GroupStatisticsVO> resultList = null;
			if(groupStatisticsVo.getDateType().equals("D")){
				resultList = groupStatisticsService.getGroupMoveDayList(groupStatisticsVo);
			}else if(groupStatisticsVo.getDateType().equals("M")){
				resultList = groupStatisticsService.getGroupMoveMonthList(groupStatisticsVo);
			}
			
			model.addAttribute("searchCondition", groupStatisticsVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("dataList", resultList);
			
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.statistics.groupMoveStatistics");
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestMapping(value="/group/groupMoveStatisticsExcel.do")
	@RequestName(value="groupMoveStatisticsExcel")
	public String groupMoveStatisticsExcel(@ModelAttribute @Valid GroupStatisticsVO groupStatisticsVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("group/stt_grp_mov_excel");
		String bizName = "그룹간 이동 통계 Excel";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DAY_OF_MONTH, -2);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowDay = sdf.format(cal.getTime());
			
			if(groupStatisticsVo.getDateType() == null){
				groupStatisticsVo.setDateType("D");
			}
			if(groupStatisticsVo.getSearchBgnDe() == null){
				groupStatisticsVo.setSearchBgnDe(nowDay);
			}
			if(groupStatisticsVo.getSearchEndDe() == null){
				groupStatisticsVo.setSearchEndDe(nowDay);
			}
			
			int totCnt = 0;
			if(groupStatisticsVo.getDateType().equals("D")){
				totCnt = groupStatisticsService.getGroupMoveDayCnt(groupStatisticsVo);
			}else if(groupStatisticsVo.getDateType().equals("M")){
				totCnt = groupStatisticsService.getGroupMoveMonthCnt(groupStatisticsVo);
			}
			
			PaginationInfo paginationInfo = getPagingInfo(groupStatisticsVo.getCurrentPageNo(), totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(groupStatisticsVo.getCurrentPageNo(), totCnt);

			groupStatisticsVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			groupStatisticsVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

			groupStatisticsVo.setPagingYn("N");
			List<GroupStatisticsVO> resultList = null;
			if(groupStatisticsVo.getDateType().equals("D")){
				resultList = groupStatisticsService.getGroupMoveDayList(groupStatisticsVo);
			}else if(groupStatisticsVo.getDateType().equals("M")){
				resultList = groupStatisticsService.getGroupMoveMonthList(groupStatisticsVo);
			}
			
			model.addAttribute("searchCondition", groupStatisticsVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("dataList", resultList);
			
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.statistics.groupMoveStatisticsExcel");
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
}
