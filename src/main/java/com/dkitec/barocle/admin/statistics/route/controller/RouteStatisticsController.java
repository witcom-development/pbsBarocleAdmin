package com.dkitec.barocle.admin.statistics.route.controller;

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
import com.dkitec.barocle.admin.statistics.route.service.RouteStatisticsService;
import com.dkitec.barocle.admin.statistics.route.vo.RouteStatisticsVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.HttpUtil;

@Controller
@RequestCategory(value="RouteStatisticsController")
public class RouteStatisticsController extends BaseController {
	protected static Logger log = LoggerFactory.getLogger(RouteStatisticsController.class);
	@Resource(name="routeStatisticsService")
	
	private RouteStatisticsService routeStatisticsService;
	
	private static final String RETURN_URL = "/admin/statistics/";

	@RequestMapping(value="/route/routeStatistics.do")
	@RequestName(value="routeStatistics")
	public String routeStatistics(@ModelAttribute @Valid RouteStatisticsVO routeStatisticsVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("route/stt_bike_mov");
		String bizName = "주요 이동경로";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowDay = sdf.format(cal.getTime());

			if(routeStatisticsVo.getSearchBgnDe() == null){
				routeStatisticsVo.setSearchBgnDe(nowDay);
			}
			
			if(routeStatisticsVo.getSearchEndDe() == null){
				routeStatisticsVo.setSearchEndDe(nowDay);
			}

			model.addAttribute("naverMapApiKey",super.propertiesService.getString("naverMapApiKey"));
			model.addAttribute("searchCondition", routeStatisticsVo);
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.statistics.routeStatistics");
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestMapping(value="/route/getRouteData.do")
	@RequestName(value="getRouteData")
	public String getRouteData(@ModelAttribute @Valid RouteStatisticsVO routeStatisticsVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		String bizName = "주요 이동경로 데이터";
		HttpUtil.printServiceLogStart(bizName, log, request);

		if(!(routeStatisticsVo.getSearchBikeNo().equals("") || routeStatisticsVo.getSearchBikeNo().equals(null))){
			if(Integer.parseInt(routeStatisticsVo.getSearchBikeNo()) < 10){
				routeStatisticsVo.setSearchBikeNo("BRC-0000"+routeStatisticsVo.getSearchBikeNo());
			}else if(Integer.parseInt(routeStatisticsVo.getSearchBikeNo()) > 9 && Integer.parseInt(routeStatisticsVo.getSearchBikeNo()) < 100){
				routeStatisticsVo.setSearchBikeNo("BRC-000"+routeStatisticsVo.getSearchBikeNo());
			}else if(Integer.parseInt(routeStatisticsVo.getSearchBikeNo()) > 99 && Integer.parseInt(routeStatisticsVo.getSearchBikeNo()) < 1000){
				routeStatisticsVo.setSearchBikeNo("BRC-00"+routeStatisticsVo.getSearchBikeNo());
			}else if(Integer.parseInt(routeStatisticsVo.getSearchBikeNo()) > 999 && Integer.parseInt(routeStatisticsVo.getSearchBikeNo()) < 10000){
				routeStatisticsVo.setSearchBikeNo("BRC-0"+routeStatisticsVo.getSearchBikeNo());
			}else{
				routeStatisticsVo.setSearchBikeNo("BRC-"+routeStatisticsVo.getSearchBikeNo());
			}
		}
		

		try{
			List<RouteStatisticsVO> resultList = routeStatisticsService.getRouteDataList(routeStatisticsVo);
			model.addAttribute("dataList", resultList);
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.statistics.getRouteData");
		}
		model.addAttribute(RESULT_MESSAGE, "Success");
		model.addAttribute(CHECK_RESULT, 0);
		return JSONVIEW;
	}
}
