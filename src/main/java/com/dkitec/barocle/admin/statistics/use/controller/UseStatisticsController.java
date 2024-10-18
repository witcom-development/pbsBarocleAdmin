package com.dkitec.barocle.admin.statistics.use.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
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
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.dkitec.barocle.admin.customer.notice.vo.NoticeVO;
import com.dkitec.barocle.admin.customer.notice.vo.NoticeVO.NoticeAllVal;
import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.admin.login.vo.UserSessionVO;
import com.dkitec.barocle.admin.statistics.use.service.UseStatisticsService;
import com.dkitec.barocle.admin.statistics.use.vo.UseStatisticsBoardVO;
import com.dkitec.barocle.admin.statistics.use.vo.UseStatisticsBoardVO.UseStatisticsBoardDeleteVal;
import com.dkitec.barocle.admin.statistics.use.vo.UseStatisticsBoardVO.UseStatisticsBoardEditVal;
import com.dkitec.barocle.admin.statistics.use.vo.UseStatisticsBoardVO.UseStatisticsBoardPersistVal;
import com.dkitec.barocle.admin.statistics.use.vo.UseStatisticsVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.HttpUtil;
import com.dkitec.barocle.util.webutil.WebUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="UseStatisticsController")
public class UseStatisticsController extends BaseController {
	protected static Logger log = LoggerFactory.getLogger(UseStatisticsController.class);
	@Resource(name="useStatisticsService")
	
	private UseStatisticsService useStatisticsService;
	
	private static final String RETURN_URL = "/admin/statistics/";

	@RequestMapping(value="/use/userStatistics.do")
	@RequestName(value="userStatistics")
	public String userStatistics(@ModelAttribute @Valid UseStatisticsVO useStatisticsVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("use/stt_ctn_use");
		String bizName = "이용자별 통계";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			Calendar cal = Calendar.getInstance();
			//cal.add(Calendar.DAY_OF_MONTH, -2);			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowDay = sdf.format(cal.getTime());
			cal.add(Calendar.DATE, -7);
			String beforeDay = sdf.format(cal.getTime());

			if(useStatisticsVo.getDateType() == null){
				useStatisticsVo.setDateType("D");
			}
			if(useStatisticsVo.getSearchBgnDe() == null){
				useStatisticsVo.setSearchBgnDe(nowDay);
			}
			if(useStatisticsVo.getSearchEndDe() == null){
				useStatisticsVo.setSearchEndDe(nowDay);
			}
			//2018-10-05 주석처리
			int totCnt = 0; // useStatisticsService.getUseMemberCnt(useStatisticsVo);
			PaginationInfo paginationInfo = getPagingInfo(useStatisticsVo.getCurrentPageNo(), totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(useStatisticsVo.getCurrentPageNo(), totCnt);
			
			useStatisticsVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			useStatisticsVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

			useStatisticsVo.setPagingYn("Y");
			//2018-10-05 주석처리
			// 코로나 관련 내용으로 변경
			List<UseStatisticsVO> resultList =  useStatisticsService.getUseMemberList(useStatisticsVo);
			
			model.addAttribute("searchCondition", useStatisticsVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("dataList", resultList);
			
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.statistics.userStatistics");
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestMapping(value="/use/userStatisticsExcel.do")
	@RequestName(value="userStatisticsExcel")
	public String userStatisticsExcel(@ModelAttribute @Valid UseStatisticsVO useStatisticsVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("use/stt_ctn_use_excel");
		String bizName = "이용자별 통계 Excel";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DAY_OF_MONTH, -2);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowDay = sdf.format(cal.getTime());

			if(useStatisticsVo.getDateType() == null){
				useStatisticsVo.setDateType("D");
			}
			if(useStatisticsVo.getSearchBgnDe() == null){
				useStatisticsVo.setSearchBgnDe(nowDay);
			}
			if(useStatisticsVo.getSearchEndDe() == null){
				useStatisticsVo.setSearchEndDe(nowDay);
			}
			//2018-10-05 주석처리
			int totCnt = 0; // useStatisticsService.getUseMemberCnt(useStatisticsVo);
			PaginationInfo paginationInfo = getPagingInfo(useStatisticsVo.getCurrentPageNo(), totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(useStatisticsVo.getCurrentPageNo(), totCnt);
			
			useStatisticsVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			useStatisticsVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

			useStatisticsVo.setPagingYn("N");
			//2018-10-05 주석처리
			List<UseStatisticsVO> resultList = useStatisticsService.getUseMemberList(useStatisticsVo);
			
			model.addAttribute("searchCondition", useStatisticsVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("dataList", resultList);
			
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.statistics.userStatisticsExcel");
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestMapping(value="/use/timeStatistics.do")
	@RequestName(value="timeStatistics")
	public String timeStatistics(@ModelAttribute @Valid UseStatisticsVO useStatisticsVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("use/stt_ctn_stm");
		String bizName = "시간대별 통계";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			String tempRentType = "";
			
			if(useStatisticsVo.getRentType() != null){
				tempRentType = useStatisticsVo.getRentType();
				String[] rentType = useStatisticsVo.getRentType().split(",");
				/*String tempString = "";
				if(rentType.length > 1){
					for (int i = 0; i < rentType.length; i++) {
						if(i == 0){
							tempString = rentType[i];
						}else{
							tempString = tempString + "'" + rentType[i];
						}
					}
					useStatisticsVo.setRentType(tempString);
				}*/
				if(rentType.length > 0){
					ArrayList<String> rentTypeArray = new ArrayList<String>();
					for (String string : rentType) {
						rentTypeArray.add(string);
					}
					useStatisticsVo.setRentTypeArray(rentTypeArray);
				}
			}
			
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DAY_OF_MONTH, -2);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowDay = sdf.format(cal.getTime());

			if(useStatisticsVo.getSearchBgnDe() == null){
				useStatisticsVo.setSearchBgnDe(nowDay);
			}
			if(useStatisticsVo.getSearchEndDe() == null){
				useStatisticsVo.setSearchEndDe(nowDay);
			}
					
			int totCnt = useStatisticsService.getUseHourlyCnt(useStatisticsVo);
			PaginationInfo paginationInfo = getPagingInfo(useStatisticsVo.getCurrentPageNo(), totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(useStatisticsVo.getCurrentPageNo(), totCnt);
			
			useStatisticsVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			useStatisticsVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

			useStatisticsVo.setPagingYn("Y");
			List<UseStatisticsVO> resultList = useStatisticsService.getUseHourlyList(useStatisticsVo);

			useStatisticsVo.setRentType(tempRentType);
			
			model.addAttribute("searchCondition", useStatisticsVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("dataList", resultList);
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.statistics.timeStatistics");
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestMapping(value="/use/timeStatisticsExcel.do")
	@RequestName(value="timeStatisticsExcel")
	public String timeStatisticsExcel(@ModelAttribute @Valid UseStatisticsVO useStatisticsVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("use/stt_ctn_stm_excel");
		String bizName = "시간대별 통계 Excel";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			String tempRentType = "";
			
			if(useStatisticsVo.getRentType() != null){
				tempRentType = useStatisticsVo.getRentType();
				String[] rentType = useStatisticsVo.getRentType().split(",");
				/*String tempString = "";
				if(rentType.length > 1){
					for (int i = 0; i < rentType.length; i++) {
						if(i == 0){
							tempString = rentType[i];
						}else{
							tempString = tempString + "'" + rentType[i];
						}
					}
					useStatisticsVo.setRentType(tempString);
				}*/
				if(rentType.length > 0){
					ArrayList<String> rentTypeArray = new ArrayList<String>();
					for (String string : rentType) {
						rentTypeArray.add(string);
					}
					useStatisticsVo.setRentTypeArray(rentTypeArray);
				}
			}
			
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DAY_OF_MONTH, -2);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowDay = sdf.format(cal.getTime());

			if(useStatisticsVo.getSearchBgnDe() == null){
				useStatisticsVo.setSearchBgnDe(nowDay);
			}
			if(useStatisticsVo.getSearchEndDe() == null){
				useStatisticsVo.setSearchEndDe(nowDay);
			}
					
			int totCnt = useStatisticsService.getUseHourlyCnt(useStatisticsVo);
			PaginationInfo paginationInfo = getPagingInfo(useStatisticsVo.getCurrentPageNo(), totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(useStatisticsVo.getCurrentPageNo(), totCnt);
			
			useStatisticsVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			useStatisticsVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

			useStatisticsVo.setPagingYn("N");
			List<UseStatisticsVO> resultList = useStatisticsService.getUseHourlyList(useStatisticsVo);

			useStatisticsVo.setRentType(tempRentType);
			
			model.addAttribute("searchCondition", useStatisticsVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("dataList", resultList);
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.statistics.timeStatisticsExcel");
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestMapping(value="/use/ageStatistics.do")
	@RequestName(value="ageStatistics")
	public String ageStatistics(@ModelAttribute @Valid UseStatisticsVO useStatisticsVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("use/stt_ctn_age");
		String bizName = "연령대별 통계";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DAY_OF_MONTH, -2);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowDay = sdf.format(cal.getTime());

			if(useStatisticsVo.getSearchBgnDe() == null){
				useStatisticsVo.setSearchBgnDe(nowDay);
			}
			if(useStatisticsVo.getSearchEndDe() == null){
				useStatisticsVo.setSearchEndDe(nowDay);
			}
			   
			List<UseStatisticsVO> resultList = useStatisticsService.getUseAgeGroupList(useStatisticsVo);
			
			
			setTot(resultList); 
			
			model.addAttribute("searchCondition", useStatisticsVo);
			model.addAttribute("dataList", resultList);
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.statistics.ageStatistics");
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}

	private void setTot(List<UseStatisticsVO> resultList ) {
		UseStatisticsVO newVo  = new UseStatisticsVO();
		UseStatisticsVO newVo1 = new UseStatisticsVO();
		UseStatisticsVO newVo2 = new UseStatisticsVO();
		
		for( UseStatisticsVO  vo: resultList ) {
			
			if ("일반".equals(vo.getBikeType())) {
				newVo.setAge1( newVo.getAge1() + vo.getAge1() );
				newVo.setAge2( newVo.getAge2() + vo.getAge2() );
				newVo.setAge3( newVo.getAge3() + vo.getAge3() );
				newVo.setAge4( newVo.getAge4() + vo.getAge4() );
				newVo.setAge5( newVo.getAge5() + vo.getAge5() );
				newVo.setAge6( newVo.getAge6() + vo.getAge6() );
				newVo.setAge7( newVo.getAge7() + vo.getAge7() );
				newVo.setAge8( newVo.getAge8() + vo.getAge8() );
				newVo.setAgeTotal( newVo.getAgeTotal() + vo.getAgeTotal() );
			// 새싹
			} else {
				newVo1.setAge1( newVo1.getAge1() + vo.getAge1() );
				newVo1.setAge2( newVo1.getAge2() + vo.getAge2() );
				newVo1.setAge3( newVo1.getAge3() + vo.getAge3() );
				newVo1.setAge4( newVo1.getAge4() + vo.getAge4() );
				newVo1.setAge5( newVo1.getAge5() + vo.getAge5() );
				newVo1.setAge6( newVo1.getAge6() + vo.getAge6() );
				newVo1.setAge7( newVo1.getAge7() + vo.getAge7() );
				newVo1.setAge8( newVo1.getAge8() + vo.getAge8() );
				newVo1.setAgeTotal( newVo1.getAgeTotal() + vo.getAgeTotal() );
			}
			
		}
		
		newVo2.setAge1( newVo1.getAge1() + newVo.getAge1() );
		newVo2.setAge2( newVo1.getAge2() + newVo.getAge2() );
		newVo2.setAge3( newVo1.getAge3() + newVo.getAge3() );
		newVo2.setAge4( newVo1.getAge4() + newVo.getAge4() );
		newVo2.setAge5( newVo1.getAge5() + newVo.getAge5() );
		newVo2.setAge6( newVo1.getAge6() + newVo.getAge6() );
		newVo2.setAge7( newVo1.getAge7() + newVo.getAge7() );
		newVo2.setAge8( newVo1.getAge8() + newVo.getAge8() );
		newVo2.setAgeTotal( newVo1.getAgeTotal() + newVo.getAgeTotal() );
		    
		
		newVo.setBikeType("일반");
		newVo.setSexCd("합계");
		newVo1.setBikeType("새싹");
		newVo1.setSexCd("합계");
		newVo2.setBikeType("전체");
		
		resultList.add(newVo);
		resultList.add(newVo1);
		resultList.add(newVo2);
	}
	
	@RequestMapping(value="/use/ageStatisticsExcel.do")
	@RequestName(value="ageStatisticsExcel")
	public String ageStatisticsExcel(@ModelAttribute @Valid UseStatisticsVO useStatisticsVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("use/stt_ctn_age_excel");
		String bizName = "연령대별 통계 Excel";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			String tempRentType = "";
			
			if(useStatisticsVo.getRentType() != null){
				tempRentType = useStatisticsVo.getRentType();
				String[] rentType = useStatisticsVo.getRentType().split(",");
				/*String tempString = "";
				if(rentType.length > 1){
					for (int i = 0; i < rentType.length; i++) {
						if(i == 0){
							tempString = rentType[i];
						}else{
							tempString = tempString + "'" + rentType[i];
						}
					}
					useStatisticsVo.setRentType(tempString);
				}*/
				if(rentType.length > 0){
					ArrayList<String> rentTypeArray = new ArrayList<String>();
					for (String string : rentType) {
						rentTypeArray.add(string);
					}
					useStatisticsVo.setRentTypeArray(rentTypeArray);
				}
			}
			
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DAY_OF_MONTH, -2);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowDay = sdf.format(cal.getTime());

			if(useStatisticsVo.getSearchBgnDe() == null){
				useStatisticsVo.setSearchBgnDe(nowDay);
			}
			if(useStatisticsVo.getSearchEndDe() == null){
				useStatisticsVo.setSearchEndDe(nowDay);
			}
					
			int totCnt = useStatisticsService.getUseAgeGroupCnt(useStatisticsVo);
			PaginationInfo paginationInfo = getPagingInfo(useStatisticsVo.getCurrentPageNo(), totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(useStatisticsVo.getCurrentPageNo(), totCnt);
			
			useStatisticsVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			useStatisticsVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

			useStatisticsVo.setPagingYn("N");
			List<UseStatisticsVO> resultList = useStatisticsService.getUseAgeGroupList(useStatisticsVo);

			useStatisticsVo.setRentType(tempRentType);
			
			model.addAttribute("searchCondition", useStatisticsVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("dataList", resultList);
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.statistics.ageStatisticsExcel");
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestMapping(value="/use/ranStatistics.do")
	@RequestName(value="ranStatistics")
	public String ranStatistics(@ModelAttribute @Valid UseStatisticsVO useStatisticsVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("use/stt_ctn_ran");
		String bizName = "운동량/탄소량 통계";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			String tempRentType = "";
			
			if(useStatisticsVo.getRentType() != null){
				tempRentType = useStatisticsVo.getRentType();
				String[] rentType = useStatisticsVo.getRentType().split(",");
				/*String tempString = "";
				if(rentType.length > 1){
					for (int i = 0; i < rentType.length; i++) {
						if(i == 0){
							tempString = rentType[i];
						}else{
							tempString = tempString + "'" + rentType[i];
						}
					}
					useStatisticsVo.setRentType(tempString);
				}*/
				if(rentType.length > 0){
					ArrayList<String> rentTypeArray = new ArrayList<String>();
					for (String string : rentType) {
						rentTypeArray.add(string);
					}
					useStatisticsVo.setRentTypeArray(rentTypeArray);
				}
			}
			
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DAY_OF_MONTH, -2);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowDay = sdf.format(cal.getTime());

			if(useStatisticsVo.getDateType() == null){
				useStatisticsVo.setDateType("D");
			}
			if(useStatisticsVo.getSearchBgnDe() == null){
				useStatisticsVo.setSearchBgnDe(nowDay);
			}
			if(useStatisticsVo.getSearchEndDe() == null){
				useStatisticsVo.setSearchEndDe(nowDay);
			}
					
			int totCnt = 0;
			
			if(useStatisticsVo.getDateType().equals("D")){
				totCnt = useStatisticsService.getUseRanDayCnt(useStatisticsVo);
			}else if(useStatisticsVo.getDateType().equals("W")){
				totCnt = useStatisticsService.getUseRanWeekCnt(useStatisticsVo);
			}else if(useStatisticsVo.getDateType().equals("M")){
				totCnt = useStatisticsService.getUseRanMonthCnt(useStatisticsVo);
			}
			
			PaginationInfo paginationInfo = getPagingInfo(useStatisticsVo.getCurrentPageNo(), 10, 10, totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(useStatisticsVo.getCurrentPageNo(), totCnt);
			
			useStatisticsVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			useStatisticsVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

			useStatisticsVo.setPagingYn("Y");
			List<UseStatisticsVO> resultList = null;
			
			if(useStatisticsVo.getDateType().equals("D")){
				resultList = useStatisticsService.getUseRanDayList(useStatisticsVo);
			}else if(useStatisticsVo.getDateType().equals("W")){
				resultList = useStatisticsService.getUseRanWeekList(useStatisticsVo);
			}else if(useStatisticsVo.getDateType().equals("M")){
				resultList = useStatisticsService.getUseRanMonthList(useStatisticsVo);
			}

			useStatisticsVo.setRentType(tempRentType);
			
			model.addAttribute("searchCondition", useStatisticsVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("dataList", resultList);
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.statistics.ranStatistics");
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestMapping(value="/use/ranStatisticsExcel.do")
	@RequestName(value="ranStatisticsExcel")
	public String ranStatisticsExcel(@ModelAttribute @Valid UseStatisticsVO useStatisticsVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("use/stt_ctn_ran_excel");
		String bizName = "운동량/탄소량 통계 Excel";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			String tempRentType = "";
			
			if(useStatisticsVo.getRentType() != null){
				tempRentType = useStatisticsVo.getRentType();
				String[] rentType = useStatisticsVo.getRentType().split(",");
				/*String tempString = "";
				if(rentType.length > 1){
					for (int i = 0; i < rentType.length; i++) {
						if(i == 0){
							tempString = rentType[i];
						}else{
							tempString = tempString + "'" + rentType[i];
						}
					}
					useStatisticsVo.setRentType(tempString);
				}*/
				if(rentType.length > 0){
					ArrayList<String> rentTypeArray = new ArrayList<String>();
					for (String string : rentType) {
						rentTypeArray.add(string);
					}
					useStatisticsVo.setRentTypeArray(rentTypeArray);
				}
			}
			
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DAY_OF_MONTH, -2);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowDay = sdf.format(cal.getTime());

			if(useStatisticsVo.getDateType() == null){
				useStatisticsVo.setDateType("D");
			}
			if(useStatisticsVo.getSearchBgnDe() == null){
				useStatisticsVo.setSearchBgnDe(nowDay);
			}
			if(useStatisticsVo.getSearchEndDe() == null){
				useStatisticsVo.setSearchEndDe(nowDay);
			}
					
			int totCnt = 0;
			
			if(useStatisticsVo.getDateType().equals("D")){
				totCnt = useStatisticsService.getUseRanDayCnt(useStatisticsVo);
			}else if(useStatisticsVo.getDateType().equals("W")){
				totCnt = useStatisticsService.getUseRanWeekCnt(useStatisticsVo);
			}else if(useStatisticsVo.getDateType().equals("M")){
				totCnt = useStatisticsService.getUseRanMonthCnt(useStatisticsVo);
			}
			
			PaginationInfo paginationInfo = getPagingInfo(useStatisticsVo.getCurrentPageNo(), 10, 10, totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(useStatisticsVo.getCurrentPageNo(), totCnt);
			
			useStatisticsVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			useStatisticsVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

			useStatisticsVo.setPagingYn("N");
			List<UseStatisticsVO> resultList = null;
			
			if(useStatisticsVo.getDateType().equals("D")){
				resultList = useStatisticsService.getUseRanDayList(useStatisticsVo);
			}else if(useStatisticsVo.getDateType().equals("W")){
				resultList = useStatisticsService.getUseRanWeekList(useStatisticsVo);
			}else if(useStatisticsVo.getDateType().equals("M")){
				resultList = useStatisticsService.getUseRanMonthList(useStatisticsVo);
			}

			useStatisticsVo.setRentType(tempRentType);
			
			model.addAttribute("searchCondition", useStatisticsVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("dataList", resultList);
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.statistics.ranStatistics");
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestMapping(value="/use/foreignStatistics.do")
	@RequestName(value="foreignStatistics")
	public String foreignStatistics(@ModelAttribute @Valid UseStatisticsVO useStatisticsVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("use/stt_ctn_foreign");
		String bizName = "외국관광객 통계";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DAY_OF_MONTH, -2);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowDay = sdf.format(cal.getTime());

			if(useStatisticsVo.getDateType() == null){
				useStatisticsVo.setDateType("D");
			}
			if(useStatisticsVo.getSearchBgnDe() == null){
				useStatisticsVo.setSearchBgnDe(nowDay);
			}
			if(useStatisticsVo.getSearchEndDe() == null){
				useStatisticsVo.setSearchEndDe(nowDay);
			}
					
			int totCnt = 0;
			if(useStatisticsVo.getDateType().equals("D")){
				totCnt = useStatisticsService.getUseForeignDayCnt(useStatisticsVo);
			}else if(useStatisticsVo.getDateType().equals("M")){
				totCnt = useStatisticsService.getUseForeignMonthCnt(useStatisticsVo);
			}
			PaginationInfo paginationInfo = getPagingInfo(useStatisticsVo.getCurrentPageNo(), totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(useStatisticsVo.getCurrentPageNo(), totCnt);
			
			useStatisticsVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			useStatisticsVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

			useStatisticsVo.setPagingYn("Y");
			List<UseStatisticsVO> resultList = null;
			if(useStatisticsVo.getDateType().equals("D")){
				resultList = useStatisticsService.getUseForeignDayList(useStatisticsVo);
			}else if(useStatisticsVo.getDateType().equals("M")){
				resultList = useStatisticsService.getUseForeignMonthList(useStatisticsVo);
			}

			model.addAttribute("searchCondition", useStatisticsVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("dataList", resultList);
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.statistics.foreignStatistics");
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestMapping(value="/use/foreignStatisticsExcel.do")
	@RequestName(value="foreignStatisticsExcel")
	public String foreignStatisticsExcel(@ModelAttribute @Valid UseStatisticsVO useStatisticsVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("use/stt_ctn_foreign_excel");
		String bizName = "외국관광객 통계 Excel";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DAY_OF_MONTH, -2);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowDay = sdf.format(cal.getTime());

			if(useStatisticsVo.getDateType() == null){
				useStatisticsVo.setDateType("D");
			}
			if(useStatisticsVo.getSearchBgnDe() == null){
				useStatisticsVo.setSearchBgnDe(nowDay);
			}
			if(useStatisticsVo.getSearchEndDe() == null){
				useStatisticsVo.setSearchEndDe(nowDay);
			}
					
			int totCnt = 0;
			if(useStatisticsVo.getDateType().equals("D")){
				totCnt = useStatisticsService.getUseForeignDayCnt(useStatisticsVo);
			}else if(useStatisticsVo.getDateType().equals("M")){
				totCnt = useStatisticsService.getUseForeignMonthCnt(useStatisticsVo);
			}
			PaginationInfo paginationInfo = getPagingInfo(useStatisticsVo.getCurrentPageNo(), totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(useStatisticsVo.getCurrentPageNo(), totCnt);
			
			useStatisticsVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			useStatisticsVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

			useStatisticsVo.setPagingYn("N");
			List<UseStatisticsVO> resultList = null;
			if(useStatisticsVo.getDateType().equals("D")){
				resultList = useStatisticsService.getUseForeignDayList(useStatisticsVo);
			}else if(useStatisticsVo.getDateType().equals("M")){
				resultList = useStatisticsService.getUseForeignMonthList(useStatisticsVo);
			}

			model.addAttribute("searchCondition", useStatisticsVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("dataList", resultList);
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.statistics.foreignStatisticsExcel");
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	

	
	private final String[] useStatisticsBoardSearchParameter = {"searchValue","searchStartDate","searchEndDate"};
	/**
	 * 월간 운영 현황 
	 * 
	 * @param useStatisticsBoardVO
	 * @param result
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/use/useStatisticsBoard.do")
	@RequestName(value="useStatisticsBoard")
	public String useStatisticsBoard(@ModelAttribute @Valid UseStatisticsBoardVO useStatisticsBoardVO, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("use/stt_ctn_use_board");
		
		String bizName = "월간운영현황";
		HttpUtil.printServiceLogStart(bizName, log, request);
		System.out.println("=======================================> useStatisticsBoard : 월간운영현황 ");

		/* validator check */
		if(result.hasErrors()){
			model.addAttribute("useStatisticsBoardView", useStatisticsBoardVO);
			model.addAttribute("resultError", super.setResultMessage(result));
			return RETURN_URL.concat("use/stt_ctn_use_board");
		}
		
		try{

			// 총 레코드 개수를 가져온다.
			useStatisticsBoardVO.setTotalRecordCount(useStatisticsService.listUseStatisticsBoardCount(useStatisticsBoardVO));
			
			// 페이징
			PaginationInfo paginationInfo = getPagingInfo(useStatisticsBoardVO.getCurrentPageNo(), useStatisticsBoardVO.getTotalRecordCount());
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(useStatisticsBoardVO.getCurrentPageNo(), useStatisticsBoardVO.getTotalRecordCount());
			useStatisticsBoardVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			useStatisticsBoardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			// 현재 화면의 정보를 지정한다.
			model.addAttribute("useStatisticsBoardView",useStatisticsBoardVO);
			// 현재 화면의 레코드 목록을 지정한다.
			model.addAttribute("useStatisticsBoardList",useStatisticsService.listUseStatisticsBoard(useStatisticsBoardVO));
			
			// 현재 화면의 검색 파라미터 값을 지정한다.
			model.addAttribute("parameterInfo",super.setGivenParameterValue(request,this.useStatisticsBoardSearchParameter));
			
			// 현재 화면에 표시되는 페이징 정보를 지정한다.
			model.addAttribute("paginationInfo",paginationInfo);
			model.addAttribute("paginationMobileInfo",paginationMobileInfo);
			
			bResult = true;		// 정상

		} catch (CfoodException ce) {
			throw new CfoodException("admin.use.static.useStatisticsBoard");
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	
	// /use/useStatisticsBoardEdit.do
	/* NOTE : 상세/등록/수정 화면
	 * mode=null 상세
	 * mode=view,noticeSeq=x 상세
	 * mode=edit,noticeSeq=y 수정
	 * 위와 같은 값이 존재하면 해당 로직으로 처리한다.
	 */
	@RequestMapping(value="/use/useStatisticsBoardEdit.do")
	@RequestName(value="useStatisticsBoardEdit")	
	public String useStatisticsBoardEdit(@Validated(UseStatisticsBoardEditVal.class) UseStatisticsBoardVO useStatisticsBoardVO, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		
		System.out.println("=======================================> useStatisticsBoardEdit : START ");
		/* validator check */
		if(result.hasErrors()){ throw new CfoodException("admin.use.static.useStatisticsBoardEdit.bindingexception"); }
		
		boolean bResult = false;
		
		String resultPage = RETURN_URL.concat("use/stt_ctn_use_board_detail");
		
		String getPersistMode = useStatisticsBoardVO.getMode();
		UserSessionVO userSessionVO = (UserSessionVO) EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");

		try{
			
			Map<String, UseStatisticsBoardVO> returnMap = useStatisticsService.viewUseStatisticsBoard(useStatisticsBoardVO);
			UseStatisticsBoardVO useStatisticsBoardView = new UseStatisticsBoardVO();	// 입력 수정 동시에 사용할 변수 선언
			useStatisticsBoardView.setMode(MODE_INSERT);	// default mode

			if(MODE_VIEW.equalsIgnoreCase(getPersistMode)){
				
			} else if(MODE_EDIT.equalsIgnoreCase(getPersistMode) && useStatisticsBoardVO.getStaticSeq()>0){
				
				useStatisticsBoardView = returnMap.get("returnVO");
				useStatisticsBoardView.setMode(MODE_UPDATE);
				resultPage = RETURN_URL.concat("use/stt_ctn_use_board_detail");

				model.addAttribute("seqNo",useStatisticsBoardVO.getStaticSeq());
				model.addAttribute("daumEditorImageList", useStatisticsService.listDaumEditorVO(useStatisticsBoardVO));
				
			}
			// 현재 화면를 가져온다.
			useStatisticsBoardView.setCurrentPageNo(useStatisticsBoardVO.getCurrentPageNo());
			
			// 현재 화면의 검색 파라미터 값을 지정한다.
			model.addAttribute("parameterInfo",super.setGivenParameterValue(request,this.useStatisticsBoardSearchParameter));
			
			model.addAttribute("useStatisticsBoardView",useStatisticsBoardView);		// 공지사항 내용
			model.addAttribute("usrGrpSeq", userSessionVO.getUsrGrpCd());		// 공지사항 내용
			
			bResult = true;		// 정상
			
		} catch (Exception e){
			throw new CfoodException("admin.use.static.useStatisticsBoardEdit",e);
		}
		
		return bResult ? resultPage : ERROR_PAGE;
	}
	
		
	@RequestName(value="persistUseStatisticsBoard")
	@RequestMapping(value={"/use/useStatisticsBoardInsert.do", "/use/useStatisticsBoardUpdate.do"})
	public String persistUseStatisticsBoard(@Validated(UseStatisticsBoardPersistVal.class) UseStatisticsBoardVO useStatisticsBoardVO, BindingResult result, HttpServletRequest request, Model model) {
		
		/* Validator error */
		if(result.hasErrors()){
			model.addAttribute("useStatisticsBoardView", useStatisticsBoardVO);
			model.addAttribute("resultError", super.setResultMessage(result));
			return RETURN_URL.concat("use/stt_ctn_use_board_detail");
		}

		boolean bResult = false;
		String resultPage = "redirect:/use/useStatisticsBoardEdit.do?mode=edit&staticSeq=";
		String getPersistMode = useStatisticsBoardVO.getMode();
		
		/* check uri */
		String requestURI = (String)request.getRequestURI().toString();

		if(requestURI.indexOf("/use/useStatisticsBoardInsert.do") > -1){ getPersistMode = MODE_INSERT; } 
		else if(requestURI.indexOf("/use/useStatisticsBoardUpdate.do") > -1){ getPersistMode = MODE_UPDATE; }
		else { throw new CfoodException("admin.use.static.useStatisticsBoardPersist.NullModeException"); }

		try{
			/* get set session */
			try{
				useStatisticsBoardVO.setRegID((String)EgovSessionCookieUtil.getSessionAttribute(request, "usrId"));
				useStatisticsBoardVO.setModID((String)EgovSessionCookieUtil.getSessionAttribute(request, "usrId"));
			} catch(Exception e){ throw new CfoodException("admin.use.statuc.useStatisticsBoardPersist.NullSessionException",e); }
			
			UseStatisticsBoardVO returnVO = null;
			bResult = true;		// 정상
			
			/*
			다음 에디터에서 내용은 staticHTMLContent에 저장되어 들어온다. staticHTMLContent내용은 html태그가 포함되어 있다.
			STATIC_TEXT_CONTENT AS staticTEXTContent : <img>를 제외한 모든 테그를 삭제하여 저장한다.
			STATIC_HTML_CONTENT AS staticHTMLContent : 모든 html 태그를 포함한다.
			 */
			useStatisticsBoardVO.setStaticTEXTContent(WebUtil.removeHTMLSpecialChars(WebUtil.replaceHTMLSpecialChars(useStatisticsBoardVO.getStaticHTMLContent()), ""));
			/*
			staticHTMLContent에서 img value를 모두 가녀온다. 해당 img값/값들로 TB_COM_DAUM_IMAGE 테이블에 매핑한다.
			다음 에디터는 내용을 DB에 저장하기 전에 popup창으로 이미지를 먼저 등록한다. 이 과정에서 우선적으로 이미지 파일은 서버에 업로드 되어 있고, 그 기록은 TB_COM_DAUM_IMAGE에 저장되어 있다.
			다음 에디터로 내응이 작성되고 DB에 저장이 되면 해당 내용에 대한 SEQ 값을 가져오는데, 이때 이 SEQ값을 TB_COM_DAUM_IMAGE 테이블에 저장해야한다.
			*/
			
			//파일 업로드
			if(useStatisticsBoardVO.getAttach_file()!=null&&!"".equals(useStatisticsBoardVO.getAttach_file())){
				useStatisticsBoardVO.setFileList(getEditorImageList(useStatisticsBoardVO.getAttach_file()));
			}
			
			// 현재 모드를 확인하여 해당 persist를 실행
			//String msg = "<바로클> 자전거 반납 추천 대여소 주변에 추천 반납 대여소 확인하기.";
			String msg = "바로클 자전거";
			String TARGET_URL = "https://www.bikeseoul.com/main.do";
			
			if(MODE_INSERT.equalsIgnoreCase(getPersistMode)){
				returnVO = useStatisticsService.insertUseStatisticsBoard(useStatisticsBoardVO);
			} else if(MODE_UPDATE.equalsIgnoreCase(getPersistMode)){
				returnVO = useStatisticsService.updateUseStatisticsBoard(useStatisticsBoardVO);
			} else bResult = false;
			
			if(bResult) resultPage += String.valueOf(returnVO.getStaticSeq());
			
		} catch(Exception e){
			throw new CfoodException("admin.use.static.useStatisticsBoardPersist",e);
		}
		
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	
	
	@RequestName(value="useStatisticsBoardDelete")
	@RequestMapping(value="/use/useStatisticsBoardDelete.do")
	public String deleteUseStatisticsBoard(@Validated(UseStatisticsBoardDeleteVal.class) UseStatisticsBoardVO useStatisticsBoardVO, HttpServletRequest request, BindingResult result, Model model) {
		
		/* validator check */
		if(result.hasErrors()){
			model.addAttribute("resultError", "권한이 없습니다.");
			throw new CfoodException("admin.use.static.useStatisticsBoardDelete.bindingexception");
		}
		
		boolean bResult = false;
		String resultPage = "redirect:/use/useStatisticsBoard.do";
		
		try{
			/* get set session */
			try{
				useStatisticsBoardVO.setRegID((String)EgovSessionCookieUtil.getSessionAttribute(request, "usrId"));
				useStatisticsBoardVO.setModID((String)EgovSessionCookieUtil.getSessionAttribute(request, "usrId"));
			} catch(Exception e){ throw new CfoodException("admin.use.static.useStatisticsBoardDelete.NullSessionException",e); }
			
			if(useStatisticsService.deleteUseStatisticsBoard(useStatisticsBoardVO)>0){ bResult = true; }
			
		} catch(Exception e){
			throw new CfoodException("admin.use.static.useStatisticsBoardDelete",e);
		}
		
		return bResult ? resultPage : ERROR_PAGE;
	}
	

	/* 파일 다운로드 
	 */
	@RequestName(value="downloadFileStatic")
	@RequestMapping(value="/use/downloadFileStatic.do")	
	public ModelAndView downloadFileStatic(@Validated(NoticeAllVal.class) UseStatisticsBoardVO useStatisticsBoardVO, BindingResult result, HttpServletRequest request, Model model) {
		
		ModelAndView mav = new ModelAndView("filedownloadView");

		String folDer = String.valueOf(request.getParameter("currentPageName"));
		useStatisticsBoardVO.setaFolder(folDer);
		
		try {
			String pathZipNm= useStatisticsService.staticFileDownloadList(useStatisticsBoardVO);
			String fileNm= useStatisticsService.staticFileDownloadNm(useStatisticsBoardVO);
			
			mav.addObject("fileName", new File(pathZipNm));
			mav.addObject("fileNm", new File(fileNm));

		} catch (Exception e) {
			e.printStackTrace();
		}
        return mav;
	}
	
	
	
	
	
	
	
	
}
