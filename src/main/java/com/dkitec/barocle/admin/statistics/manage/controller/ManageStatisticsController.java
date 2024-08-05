package com.dkitec.barocle.admin.statistics.manage.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Map;

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
import com.dkitec.barocle.admin.maintenance.repair.division.vo.RepairDivisionVO;
import com.dkitec.barocle.admin.statistics.manage.service.ManageStatisticsService;
import com.dkitec.barocle.admin.statistics.manage.vo.ManageStatisticsVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.HttpUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="ManageStatisticsController")
public class ManageStatisticsController extends BaseController {
	protected static Logger log = LoggerFactory.getLogger(ManageStatisticsController.class);
	@Resource(name="manageStatisticsService")
	
	private ManageStatisticsService manageStatisticsService;
	
	private static final String RETURN_URL = "/admin/statistics/";
	
	@RequestMapping(value="/manage/manageStatistics.do")
	@RequestName(value="manageStatistics")
	public String manageStatistics(@ModelAttribute @Valid ManageStatisticsVO manageStatisticsVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("manage/stt_tot_sta");
		String bizName = "운영 보고";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DAY_OF_MONTH, -2);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowDay = sdf.format(cal.getTime());
	
			if(manageStatisticsVo.getDateType() == null){
				manageStatisticsVo.setDateType("D");
			}
			if(manageStatisticsVo.getSearchBgnDe() == null){
				manageStatisticsVo.setSearchBgnDe(nowDay);
			}
			if(manageStatisticsVo.getSearchEndDe() == null){
				manageStatisticsVo.setSearchEndDe(nowDay);
			}
			List<ManageStatisticsVO> incomeList = null;
			List<ManageStatisticsVO> userjoinList = null;
			List<ManageStatisticsVO> bikeuseList = null;
			
			int period = 0;
			if(manageStatisticsVo.getDateType().equals("M") && manageStatisticsVo.getSearchBgnMt() != null){
				period = manageStatisticsService.getManageMonthPeriod(manageStatisticsVo);
			}else if(manageStatisticsVo.getDateType().equals("D") && manageStatisticsVo.getSearchBgnDe() != null){
				period = manageStatisticsService.getManageDayPeriod(manageStatisticsVo);
			}
			
			if(manageStatisticsVo.getDateType().equals("D")){
				incomeList = manageStatisticsService.getIncomeDayList(manageStatisticsVo);
				userjoinList = manageStatisticsService.getUserJoinDayList(manageStatisticsVo);
				bikeuseList = manageStatisticsService.getBikeUseDayList(manageStatisticsVo);
			}else if(manageStatisticsVo.getDateType().equals("M")){
				incomeList = manageStatisticsService.getIncomeMonthList(manageStatisticsVo);
				userjoinList = manageStatisticsService.getUserJoinMonthList(manageStatisticsVo);
				bikeuseList = manageStatisticsService.getBikeUseMonthList(manageStatisticsVo);
			}
			List<ManageStatisticsVO> timeuseList = manageStatisticsService.getTimeUseList(manageStatisticsVo);
			List<ManageStatisticsVO> highStationList = manageStatisticsService.getHighStationList(manageStatisticsVo);
			List<ManageStatisticsVO> lowStationList = manageStatisticsService.getLowStationList(manageStatisticsVo);
			
			//2020-12-18 : 시민의견
			List<ManageStatisticsVO> opinionList = manageStatisticsService.opinionList(manageStatisticsVo);
			
			System.out.println(opinionList.size());
			
			model.addAttribute("searchCondition", manageStatisticsVo);
			model.addAttribute("incomeList", incomeList);
			model.addAttribute("userjoinList", userjoinList);
			model.addAttribute("bikeuseList", bikeuseList);
			model.addAttribute("timeuseList", timeuseList);
			model.addAttribute("highStationList", highStationList);
			model.addAttribute("lowStationList", lowStationList);
			model.addAttribute("period", period);
			model.addAttribute("opinionList", opinionList);
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.statistics.manageStatistics");
		}
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestMapping(value="/manage/manageStatisticsExcel.do")
	@RequestName(value="manageStatisticsExcel")
	public String manageStatisticsExcel(@ModelAttribute @Valid ManageStatisticsVO manageStatisticsVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("manage/stt_tot_sta_excel");
		String bizName = "운영 보고 Excel";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DAY_OF_MONTH, -2);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowDay = sdf.format(cal.getTime());
	
			if(manageStatisticsVo.getDateType() == null){
				manageStatisticsVo.setDateType("D");
			}
			if(manageStatisticsVo.getSearchBgnDe() == null){
				manageStatisticsVo.setSearchBgnDe(nowDay);
			}
			if(manageStatisticsVo.getSearchEndDe() == null){
				manageStatisticsVo.setSearchEndDe(nowDay);
			}
			List<ManageStatisticsVO> incomeList = null;
			List<ManageStatisticsVO> userjoinList = null;
			List<ManageStatisticsVO> bikeuseList = null;
			
			int period = 0;
			if(manageStatisticsVo.getDateType().equals("M") && manageStatisticsVo.getSearchBgnMt() != null){
				period = manageStatisticsService.getManageMonthPeriod(manageStatisticsVo);
			}else if(manageStatisticsVo.getDateType().equals("D") && manageStatisticsVo.getSearchBgnDe() != null){
				period = manageStatisticsService.getManageDayPeriod(manageStatisticsVo);
			}
			
			if(manageStatisticsVo.getDateType().equals("D")){
				incomeList = manageStatisticsService.getIncomeDayList(manageStatisticsVo);
				userjoinList = manageStatisticsService.getUserJoinDayList(manageStatisticsVo);
				bikeuseList = manageStatisticsService.getBikeUseDayList(manageStatisticsVo);
			}else if(manageStatisticsVo.getDateType().equals("M")){
				incomeList = manageStatisticsService.getIncomeMonthList(manageStatisticsVo);
				userjoinList = manageStatisticsService.getUserJoinMonthList(manageStatisticsVo);
				bikeuseList = manageStatisticsService.getBikeUseMonthList(manageStatisticsVo);
			}
			List<ManageStatisticsVO> timeuseList = manageStatisticsService.getTimeUseList(manageStatisticsVo);
			List<ManageStatisticsVO> highStationList = manageStatisticsService.getHighStationList(manageStatisticsVo);
			List<ManageStatisticsVO> lowStationList = manageStatisticsService.getLowStationList(manageStatisticsVo);
			
			model.addAttribute("searchCondition", manageStatisticsVo);
			model.addAttribute("incomeList", incomeList);
			model.addAttribute("userjoinList", userjoinList);
			model.addAttribute("bikeuseList", bikeuseList);
			model.addAttribute("timeuseList", timeuseList);
			model.addAttribute("highStationList", highStationList);
			model.addAttribute("lowStationList", lowStationList);
			model.addAttribute("period", period);
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.statistics.manageStatistics");
		}
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestMapping(value="/manage/manageBike.do")
	@RequestName(value="manageBike")
	public String manageBike(@ModelAttribute @Valid ManageStatisticsVO manageStatisticsVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {

		boolean bResult = false;
		String resultPage = RETURN_URL.concat("manage/stt_bike_sta");
		String bizName = "최대 운영 자전거";
		HttpUtil.printServiceLogStart(bizName, log, request);

		try{
			// 날짜조회 (날짜 없을경우 현 날짜로 조회)
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowDay = sdf.format(cal.getTime());
			
			cal.add(Calendar.MONTH , -1);
			String nowDay2 = sdf.format(cal.getTime());
			
			if(manageStatisticsVo.getSearchBgnDe() == null){
				manageStatisticsVo.setSearchBgnDe(nowDay2);
			}
			if(manageStatisticsVo.getSearchEndDe() == null){
				manageStatisticsVo.setSearchEndDe(nowDay);
			}
			
			//등록된 최대운영 자건거수 조회
			int totCnt = manageStatisticsService.getBikeListCnt(manageStatisticsVo);
			
			PaginationInfo paginationInfo = getPagingInfo(manageStatisticsVo.getCurrentPageNo(), 30, 30, totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(manageStatisticsVo.getCurrentPageNo(), totCnt);
			
			manageStatisticsVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			manageStatisticsVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<RepairDivisionVO> resultList = manageStatisticsService.getBikeList(manageStatisticsVo);
			
			
					
			model.addAttribute("searchCondition", manageStatisticsVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("bikeList", resultList);
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.maintenance.rep_division");
		}
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestMapping(value="/manage/bikeBatterySta.do")
	@RequestName(value="bikeBatterySta")
	public String bikeBatterySta(@ModelAttribute @Valid ManageStatisticsVO manageStatisticsVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {

		boolean bResult = false;
		String resultPage = RETURN_URL.concat("manage/stt_bike_battery_sta");
		String bizName = "자전거 배터리 정보";
		HttpUtil.printServiceLogStart(bizName, log, request);

		try{
			// 날짜조회 (날짜 없을경우 현 날짜로 조회)
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowDay = sdf.format(cal.getTime());
			
			//default 한달전 부터 현재일 조회
			cal.add(Calendar.MONTH , -1);
			String nowDay2 = sdf.format(cal.getTime());
			
			if(manageStatisticsVo.getSearchBgnDe() == null){
				manageStatisticsVo.setSearchBgnDe(nowDay2);
			}
			if(manageStatisticsVo.getSearchEndDe() == null){
				manageStatisticsVo.setSearchEndDe(nowDay);
			}

			String s1 = manageStatisticsVo.getSearchBgnDe().replace("-", "").replace("-", "");
			String s2 = manageStatisticsVo.getSearchEndDe().replace("-", "").replace("-", "");
			
			DateFormat df = new SimpleDateFormat("yyyyMMdd");
			
			Date d1 = df.parse( s1 );
			Date d2 = df.parse( s2 );
			
			Calendar c1 = Calendar.getInstance();
			Calendar c2 = Calendar.getInstance();
			
			c1.setTime( d1 );
			c2.setTime( d2 );

			SimpleDateFormat sdf2 = new SimpleDateFormat("MMdd");
			SimpleDateFormat sdf3 = new SimpleDateFormat("yyyy");
			
			String days = ""; 
			String daysNm = "";
			int years;
			String years2 = "";
			
			years = Integer.parseInt(sdf3.format(c1.getTime()));
			years2 = "'"+sdf3.format(c1.getTime())+"',";
			
			while( c1.compareTo( c2 ) !=1 ){
				
				//조회년도 조회
				if(Integer.parseInt(sdf3.format(c1.getTime())) != years){
					years2 += "'" + sdf3.format(c1.getTime())+"'"+",";
					years += 1;
				}
				
				//조회 년도/월/일 조회
				days +=  "IFNULL(MAX(CASE WHEN REG_YEAR="+sdf3.format(c1.getTime())+" THEN (SELECT CD_DESC1 FROM TB_SYS_COM_CD WHERE COM_CD =  DATE_"+sdf2.format(c1.getTime())+") END ),'-') AS BK"+sdf3.format(c1.getTime())+"_"+sdf2.format(c1.getTime())+ ",";
				//days +=  "IFNULL(MAX(CASE WHEN REG_YEAR="+sdf3.format(c1.getTime())+" THEN DATE_"+sdf2.format(c1.getTime())+" END ),'-') AS BK"+index+ ",";
				
				//조회 년월일명
				daysNm += "BK"+sdf3.format(c1.getTime()) +"_"+ sdf2.format(c1.getTime()) +",";
				c1.add(Calendar.DATE, 1);
				
			}
			
			days = "(SELECT BIKE_NO FROM TB_OPR_BIKE WHERE BIKE_ID = TSBB.BIKE_ID) AS BIKE_ID, "+days;
			daysNm = "BIKE_ID," + daysNm;
			
			daysNm = daysNm.substring(0, daysNm.length()-1);
			
			manageStatisticsVo.setDays(days.substring(0, days.length()-1));
			manageStatisticsVo.setYears(years2.substring(0, years2.length()-1));
			
			//등록된 최대운영 자건거수 조회
			int totCnt = manageStatisticsService.getBikeBatteryListCnt(manageStatisticsVo);
			
			PaginationInfo paginationInfo = getPagingInfo(manageStatisticsVo.getCurrentPageNo(), totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(manageStatisticsVo.getCurrentPageNo(), totCnt);
			
			manageStatisticsVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			manageStatisticsVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			ArrayList<Map<String,String>>  resultList = manageStatisticsService.getBikeBatteryList(manageStatisticsVo);
		
			Collection<String> returnList1 = null;
			Collection<String> returnList2 = null;
			Collection<String> returnList3 = null;
			Collection<String> returnList4 = null;
			Collection<String> returnList5 = null;

            if(resultList.size() == 1){
            	returnList1 = resultList.get(0).values();
            	
            	model.addAttribute("returnList1", returnList1);
            }else if(resultList.size() == 2){
            	returnList1 = resultList.get(0).values();
            	returnList2 = resultList.get(1).values();
            	
            	model.addAttribute("returnList1", returnList1);
    			model.addAttribute("returnList2", returnList2);
            }else if(resultList.size() == 3){
            	returnList1 = resultList.get(0).values();
            	returnList2 = resultList.get(1).values();
                returnList3 = resultList.get(2).values();
                
                model.addAttribute("returnList1", returnList1);
    			model.addAttribute("returnList2", returnList2);
    			model.addAttribute("returnList3", returnList3);
            }else if(resultList.size() == 4){
            	returnList1 = resultList.get(0).values();
            	returnList2 = resultList.get(1).values();
                returnList3 = resultList.get(2).values();
                returnList4 = resultList.get(3).values();
                
                model.addAttribute("returnList1", returnList1);
    			model.addAttribute("returnList2", returnList2);
    			model.addAttribute("returnList3", returnList3);
    			model.addAttribute("returnList4", returnList4);
            }else if(resultList.size() == 5){
            	returnList1 = resultList.get(0).values();
                returnList2 = resultList.get(1).values();
                returnList3 = resultList.get(2).values();
                returnList4 = resultList.get(3).values();
                returnList5 = resultList.get(4).values();
                
                model.addAttribute("returnList1", returnList1);
    			model.addAttribute("returnList2", returnList2);
    			model.addAttribute("returnList3", returnList3);
    			model.addAttribute("returnList4", returnList4);
    			model.addAttribute("returnList5", returnList5);
            }
            
			model.addAttribute("searchCondition", manageStatisticsVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("ArrDay", daysNm);
			model.addAttribute("resultList", resultList);

			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.maintenance.rep_division");
		}
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	
	@RequestMapping(value="/manage/bikeBatteryStaExcel.do")
	@RequestName(value="bikeBatteryStaExcel")
	public String bikeBatteryStaExcel(@ModelAttribute @Valid ManageStatisticsVO manageStatisticsVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {

		boolean bResult = false;
		String resultPage = RETURN_URL.concat("manage/stt_bike_battery_sta_excel");
		String bizName = "자전거 배터리 정보";
		HttpUtil.printServiceLogStart(bizName, log, request);

		try{
			// 날짜조회 (날짜 없을경우 현 날짜로 조회)
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowDay = sdf.format(cal.getTime());
			
			//default 한달전 부터 현재일 조회
			cal.add(Calendar.MONTH , -1);
			String nowDay2 = sdf.format(cal.getTime());
			
			if(manageStatisticsVo.getSearchBgnDe() == null){
				manageStatisticsVo.setSearchBgnDe(nowDay2);
			}
			if(manageStatisticsVo.getSearchEndDe() == null){
				manageStatisticsVo.setSearchEndDe(nowDay);
			}

			String s1 = manageStatisticsVo.getSearchBgnDe().replace("-", "").replace("-", "");
			String s2 = manageStatisticsVo.getSearchEndDe().replace("-", "").replace("-", "");
			
			DateFormat df = new SimpleDateFormat("yyyyMMdd");
			
			Date d1 = df.parse( s1 );
			Date d2 = df.parse( s2 );
			
			Calendar c1 = Calendar.getInstance();
			Calendar c2 = Calendar.getInstance();
			
			c1.setTime( d1 );
			c2.setTime( d2 );

			SimpleDateFormat sdf2 = new SimpleDateFormat("MMdd");
			SimpleDateFormat sdf3 = new SimpleDateFormat("yyyy");
			
			String days = ""; 
			String daysNm = "";
			int years;
			String years2 = "";
			
			years = Integer.parseInt(sdf3.format(c1.getTime()));
			years2 = "'"+sdf3.format(c1.getTime())+"',";
			
			while( c1.compareTo( c2 ) !=1 ){
				
				//조회년도 조회
				if(Integer.parseInt(sdf3.format(c1.getTime())) != years){
					years2 += "'" + sdf3.format(c1.getTime())+"'"+",";
					years += 1;
				}
				
				//조회 년도/월/일 조회
				days +=  "IFNULL(MAX(CASE WHEN REG_YEAR="+sdf3.format(c1.getTime())+" THEN (SELECT CD_DESC1 FROM TB_SYS_COM_CD WHERE COM_CD =  DATE_"+sdf2.format(c1.getTime())+") END ),'-') AS BK"+sdf3.format(c1.getTime())+"_"+sdf2.format(c1.getTime())+ ",";
				//days +=  "IFNULL(MAX(CASE WHEN REG_YEAR="+sdf3.format(c1.getTime())+" THEN DATE_"+sdf2.format(c1.getTime())+" END ),'-') AS BK"+index+ ",";
				
				//조회 년월일명
				daysNm += "BK"+sdf3.format(c1.getTime()) +"_"+ sdf2.format(c1.getTime()) +",";
				c1.add(Calendar.DATE, 1);
				
			}
			
			days = "(SELECT BIKE_NO FROM TB_OPR_BIKE WHERE BIKE_ID = TSBB.BIKE_ID) AS BIKE_ID, "+days;
			daysNm = "BIKE_ID," + daysNm;
			
			daysNm = daysNm.substring(0, daysNm.length()-1);
			
			manageStatisticsVo.setDays(days.substring(0, days.length()-1));
			manageStatisticsVo.setYears(years2.substring(0, years2.length()-1));
			
			//등록된 최대운영 자건거수 조회
			int totCnt = manageStatisticsService.getBikeBatteryListCnt(manageStatisticsVo);

			ArrayList<Map<String,String>>  resultList = manageStatisticsService.getBikeBatteryExcelList(manageStatisticsVo);
		
			Collection<String> returnList1 = null;

			//ArrayList<String>  parameterMap = null;
			ArrayList<String>  parameterMap = new ArrayList<String>();

            for(int i=0; i<resultList.size(); i++){
            	returnList1 =  resultList.get(i).values();
            	parameterMap.add(returnList1+"");
            }

			model.addAttribute("parameterMap", parameterMap);
			model.addAttribute("searchCondition", manageStatisticsVo);
			model.addAttribute("ArrDay", daysNm);
			model.addAttribute("totCnt", totCnt);
			model.addAttribute("resultList", resultList);

			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.maintenance.rep_division");
		}
		return bResult ? resultPage : ERROR_PAGE;
	}
	
}
