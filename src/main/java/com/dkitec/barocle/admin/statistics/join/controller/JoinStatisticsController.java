package com.dkitec.barocle.admin.statistics.join.controller;

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
import com.dkitec.barocle.admin.statistics.join.service.JoinStatisticsService;
import com.dkitec.barocle.admin.statistics.join.vo.JoinStatisticsVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.HttpUtil;

@Controller
@RequestCategory(value="JoinStatisticsController")
public class JoinStatisticsController extends BaseController {
	protected static Logger log = LoggerFactory.getLogger(JoinStatisticsController.class);
	@Resource(name="joinStatisticsService")
	
	private JoinStatisticsService joinStatisticsService;
	
	private static final String RETURN_URL = "/admin/statistics/";

	@RequestMapping(value="/join/joinStatistics.do")
	@RequestName(value="joinStatistics")
	public String joinStatistics(@ModelAttribute @Valid JoinStatisticsVO joinStatisticsVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("join/stt_mem_jon");
		String bizName = "회원가입 통계";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DAY_OF_MONTH, -2);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowDay = sdf.format(cal.getTime());
			
			if(joinStatisticsVo.getSearchBgnDe() == null){
				joinStatisticsVo.setSearchBgnDe(nowDay);
			}
			if(joinStatisticsVo.getSearchEndDe() == null){
				joinStatisticsVo.setSearchEndDe(nowDay);
			}
			
			List<JoinStatisticsVO> resultList = joinStatisticsService.getMemJoinList(joinStatisticsVo);
			
			//List<JoinStatisticsVO> miniBikeList = joinStatisticsService.getUseMiniBikeList(joinStatisticsVo);
			
			model.addAttribute("searchCondition", joinStatisticsVo);
			model.addAttribute("memjoinList", resultList);
			//model.addAttribute("miniBikeList", miniBikeList);
			
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.statistics.joinStatistics");
		}
		
		/* 10월8일 지원 작업 S */
		// 회원가입현황 목록
		List<JoinStatisticsVO> memjoinList = joinStatisticsService.getMemJoinList(joinStatisticsVo);
		
		model.addAttribute("memjoinList", memjoinList);
		/* 10월8일 지원 작업 E */
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestMapping(value="/join/joinStatisticsExcel.do")
	@RequestName(value="joinStatisticsExcel")
	public String joinStatisticsExcel(@ModelAttribute @Valid JoinStatisticsVO joinStatisticsVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("join/stt_mem_jon_excel");
		String bizName = "회원가입 통계 Excel";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DAY_OF_MONTH, -2);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowDay = sdf.format(cal.getTime());
			
			if(joinStatisticsVo.getSearchBgnDe() == null){
				joinStatisticsVo.setSearchBgnDe(nowDay);
			}
			if(joinStatisticsVo.getSearchEndDe() == null){
				joinStatisticsVo.setSearchEndDe(nowDay);
			}
			
			List<JoinStatisticsVO> resultList = joinStatisticsService.getMemJoinList(joinStatisticsVo);
			
			//List<JoinStatisticsVO> miniBikeList = joinStatisticsService.getUseMiniBikeList(joinStatisticsVo);
			
			model.addAttribute("searchCondition", joinStatisticsVo);
			model.addAttribute("memjoinList", resultList);
			//model.addAttribute("miniBikeList", miniBikeList);
			
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.statistics.joinStatisticsExcel");
		}
		
		/* 10월8일 지원 작업 S */
		// 회원가입현황 목록
		List<JoinStatisticsVO> memjoinList = joinStatisticsService.getMemJoinList(joinStatisticsVo);
		
		model.addAttribute("memjoinList", memjoinList);
		/* 10월8일 지원 작업 E */
			
		return bResult ? resultPage : ERROR_PAGE;
	}
}
