package com.dkitec.barocle.admin.statistics.admlogin.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.mybatis.spring.SqlSessionFactoryBean;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.dkitec.barocle.admin.statistics.admlogin.service.AdmloginStatisticsService;
import com.dkitec.barocle.admin.statistics.admlogin.vo.AdmloginStatisticsVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.datasource.ContextHolder;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;
import com.dkitec.barocle.util.webutil.HttpUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="AdmloginStatisticsController")
public class AdmloginStatisticsController extends BaseController {
	protected static Logger log = LoggerFactory.getLogger(AdmloginStatisticsController.class);
	@Resource(name="admloginStatisticsService")
	
	private AdmloginStatisticsService admloginStatisticsService;
	
	private static final String RETURN_URL = "/admin/statistics/";

	// 접속해야할 DB 설정 
	private DataSourceType DB_CONNECT;	
	
	@RequestMapping(value="/admlogin/adminLoginStatistics.do")
	@RequestName(value="adminLoginStatistics")
	public String adminLoginStatistics(@ModelAttribute @Valid AdmloginStatisticsVO admloginStatisticsVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("admlogin/stt_bike_adm");
		String bizName = "운영자 접속 현황";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		
		String dbType = (String) request.getParameter("dbType");
		if (dbType == null) dbType = "M";
		
		System.out.println("--------------------------------------------------------------");
		System.out.println("-------------------- DB 접속 테스트 START  -------------------");
		System.out.println("--------------------------------------------------------------");
		
//		ContextHolder contextHolder = new ContextHolder();
//		if ("M".equals(dbType)) {
//			DB_CONNECT = DataSourceType.MASTER;
//		} else {
//			DB_CONNECT = DataSourceType.SLAVE01;	
//		}
//		contextHolder.setDataSourceType(DB_CONNECT);

		//LocalContainerEntityManagerFactoryBean emfb = new LocalContainerEntityManagerFactoryBean();
		//emfb.setDataSource(dataSource);
		//SqlSessionFactoryBean bean = new SqlSessionFactoryBean();		
		//bean.setDataSource("staticsDataSource");

		try{
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowDay = sdf.format(cal.getTime());

			if(admloginStatisticsVo.getSearchBgnDe() == null){
				admloginStatisticsVo.setSearchBgnDe(nowDay);
			}
			if(admloginStatisticsVo.getSearchEndDe() == null){
				admloginStatisticsVo.setSearchEndDe(nowDay);
			}

			int totCnt = admloginStatisticsService.getAdminLoginCnt(admloginStatisticsVo);
			PaginationInfo paginationInfo = getPagingInfo(admloginStatisticsVo.getCurrentPageNo(), totCnt);
			
			admloginStatisticsVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			admloginStatisticsVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			// 운영자 접속 현황 총 목록
			admloginStatisticsVo.setPagingYn("Y");
			List<AdmloginStatisticsVO> dataList = admloginStatisticsService.getAdminLoginList(admloginStatisticsVo);

			model.addAttribute("searchCondition", admloginStatisticsVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("dataList", dataList);
			/* 10월8일 지원 작업 E */
			
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.statistics.adminLoginStatistics");
		}
		
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestMapping(value="/admlogin/adminLoginStatisticsExcel.do")
	@RequestName(value="adminLoginStatisticsExcel")
	public String adminLoginStatisticsExcel(@ModelAttribute @Valid AdmloginStatisticsVO admloginStatisticsVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("admlogin/stt_bike_adm_excel");
		String bizName = "운영자 접속 현황 Excel";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowDay = sdf.format(cal.getTime());

			if(admloginStatisticsVo.getSearchBgnDe() == null){
				admloginStatisticsVo.setSearchBgnDe(nowDay);
			}
			if(admloginStatisticsVo.getSearchEndDe() == null){
				admloginStatisticsVo.setSearchEndDe(nowDay);
			}
			
			// 운영자 접속 현황 총 목록

			admloginStatisticsVo.setPagingYn("N");
			List<AdmloginStatisticsVO> dataList = admloginStatisticsService.getAdminLoginList(admloginStatisticsVo);

			model.addAttribute("searchCondition", admloginStatisticsVo);
			model.addAttribute("dataList", dataList);
			
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.statistics.adminLoginStatistics");
		}
		

		return bResult ? resultPage : ERROR_PAGE;
	}
	
}
