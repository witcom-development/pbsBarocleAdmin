package com.dkitec.barocle.admin.statistics.zeropay.controller;

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
import com.dkitec.barocle.admin.statistics.zeropay.service.ZeropayStatisticsService;
import com.dkitec.barocle.admin.statistics.zeropay.vo.ZeropayStatisticsVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.HttpUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="ZeropayStatisticsController")
public class ZeropayStatisticsController extends BaseController {
	protected static Logger log = LoggerFactory.getLogger(ZeropayStatisticsController.class);
	
	@Resource(name="zeropayStatisticsService") private ZeropayStatisticsService zeropayStatisticsService;

	private static final String RETURN_URL = "/admin/statistics/";

	@RequestMapping(value="/zeropay/ticketStatistics.do")
	@RequestName(value="ticketStatistics")
	public String zeropayStatistics(@ModelAttribute @Valid ZeropayStatisticsVO zeropayStatisticsVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("zeropay/stt_zpay_ticket");
		String bizName = "이용권별 현황";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			// 날짜조회 (날짜 없을경우 현 날짜로 조회)	++ 빈값일 경우 제로페이 오픈일(2019.09.26)로 변경 2020.02.03
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowDay = sdf.format(cal.getTime());
			
			//cal.add(Calendar.DATE , -6);
			//String nowDay2 = sdf.format(cal.getTime());
			
			if(zeropayStatisticsVo.getSearchBgnDe() == null){
				zeropayStatisticsVo.setSearchBgnDe("2019-09-26");
			}
			if(zeropayStatisticsVo.getSearchEndDe() == null){
				zeropayStatisticsVo.setSearchEndDe(nowDay);
			}
			
			int totCnt = zeropayStatisticsService.getTicketListCnt(zeropayStatisticsVo);
			//System.out.println("totCnt>>>> "+totCnt);
			
			PaginationInfo paginationInfo = getPagingInfo(zeropayStatisticsVo.getCurrentPageNo(), totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(zeropayStatisticsVo.getCurrentPageNo(), totCnt);

			zeropayStatisticsVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			zeropayStatisticsVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			zeropayStatisticsVo.setPagingYn("Y");
			List<ZeropayStatisticsVO> resultList = zeropayStatisticsService.getTicketList(zeropayStatisticsVo);
			
			/*
			 * for (ZeropayStatisticsVO vo : resultList) {
			 * System.out.println("####resultList = "+vo.getTicketDate()
			 * +" "+vo.getTicketCnt()+" "+vo.getTicket_1day()+" "+vo.getTicket_7day()+" "+vo
			 * .getTicket_30day()+" "+vo.getTicket_180day()+vo.getTicket_365day()
			 * +" "+vo.getTotPmtPrice()+" "+vo.getTicketPmt_1day()+" "+vo.getTicketPmt_7day(
			 * )+" "+vo
			 * .getTicketPmt_30day()+" "+vo.getTicketPmt_180day()+vo.getTicketPmt_365day());
			 * }
			 */
			
			bResult = true;		// 정상 
			model.addAttribute("searchCondition", zeropayStatisticsVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("dataList", resultList);
			
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.statistics.zerpayStatistics");
		}
			
		return bResult ? resultPage : ERROR_PAGE;
		
	}
	
	
	@RequestMapping(value="/zeropay/ticketStatisticsExcel.do")
	@RequestName(value="ticketStatisticsExcel")
	public String ticketStatisticsExcel(@ModelAttribute @Valid ZeropayStatisticsVO zeropayStatisticsVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("zeropay/stt_zpay_ticket_excel");
		String bizName = "이용권별 현황 Excel";
		HttpUtil.printServiceLogStart(bizName, log, request);
		try{
			// 날짜조회 (날짜 없을경우 현 날짜로 조회)	++ 빈값일 경우 제로페이 오픈일(2019.09.26)로 변경 2020.02.03
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowDay = sdf.format(cal.getTime());
			
			//cal.add(Calendar.DATE , -6);
			//String nowDay2 = sdf.format(cal.getTime());
			
			if(zeropayStatisticsVo.getSearchBgnDe() == null){
				zeropayStatisticsVo.setSearchBgnDe("2019-09-26");
			}
			if(zeropayStatisticsVo.getSearchEndDe() == null){
				zeropayStatisticsVo.setSearchEndDe(nowDay);
			}
			
			int totCnt = zeropayStatisticsService.getTicketListCnt(zeropayStatisticsVo);
			
			PaginationInfo paginationInfo = getPagingInfo(zeropayStatisticsVo.getCurrentPageNo(), totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(zeropayStatisticsVo.getCurrentPageNo(), totCnt);

			zeropayStatisticsVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			zeropayStatisticsVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			zeropayStatisticsVo.setPagingYn("N");
			
			List<ZeropayStatisticsVO> resultList = zeropayStatisticsService.getTicketList(zeropayStatisticsVo);
			
			/*
			 * for (ZeropayStatisticsVO vo : resultList) {
			 * System.out.println("####resultList = "+vo.getTicketDate()
			 * +" "+vo.getTicketCnt()+" "+vo.getTicket_1day()+" "+vo.getTicket_7day()+" "+vo
			 * .getTicket_30day()+" "+vo.getTicket_180day()+vo.getTicket_365day() ); }
			 */
			
			bResult = true;		// 정상 
			model.addAttribute("searchCondition", zeropayStatisticsVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("dataList", resultList);
			
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.statistics.ticketStatisticsExcel");
		}
			
		return bResult ? resultPage : ERROR_PAGE;
		
	}
	
	
	@RequestMapping(value="/zeropay/dailyTicketStatistics.do")
	@RequestName(value="dailyTicketStatistics")
	public String dailyTicketStatistics(@ModelAttribute @Valid ZeropayStatisticsVO zeropayStatisticsVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("zeropay/stt_zpay_dailyTicketPmt");
		String bizName = "일일권 결제 현황";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			// 날짜조회 (날짜 없을경우 현 날짜로 조회)	++ 빈값일 경우 제로페이 오픈일(2019.09.26)로 변경 2020.02.03
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowDay = sdf.format(cal.getTime());
			
			//cal.add(Calendar.DATE , -6);
			//String nowDay2 = sdf.format(cal.getTime());
			
			if(zeropayStatisticsVo.getSearchBgnDe() == null){
				zeropayStatisticsVo.setSearchBgnDe("2019-09-26");
			}
			if(zeropayStatisticsVo.getSearchEndDe() == null){
				zeropayStatisticsVo.setSearchEndDe(nowDay);
			}
			
			int totCnt = zeropayStatisticsService.getDailyTicketPmtListCnt(zeropayStatisticsVo);
			System.out.println("totCnt>>>> "+totCnt);
			
			PaginationInfo paginationInfo = getPagingInfo(zeropayStatisticsVo.getCurrentPageNo(), totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(zeropayStatisticsVo.getCurrentPageNo(), totCnt);

			zeropayStatisticsVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			zeropayStatisticsVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			zeropayStatisticsVo.setPagingYn("Y");
			List<ZeropayStatisticsVO> resultList = zeropayStatisticsService.getDailyTicketPmtList(zeropayStatisticsVo);
			
			/*
			 * for (ZeropayStatisticsVO vo : resultList) {
			 * System.out.println("####resultList = "+vo.getTicketDate()
			 * +" "+vo.getTicketCnt()+" "+vo.getTotPmtPrice()+" "+vo.getMember_1h()+" "+vo.
			 * getMemberPmt_1h()+" "+vo. getMember_2h()+" "+vo.getMemberPmt_2h()
			 * +" "+vo.getNonMember_1h()+" "+vo.getNonMemberPmt_1h()+" "+vo.getNonMember_2h(
			 * )+" "+vo. getNonMemberPmt_2h()+" "+vo.getForeigner_24h()
			 * +" "+vo.getForeignerPmt_24h()); }
			 */
			
			bResult = true;		// 정상 
			model.addAttribute("searchCondition", zeropayStatisticsVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("dataList", resultList);
			
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.statistics.dailyTicketStatistics");
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestMapping(value="/zeropay/dailyTicketStatisticsExcel.do")
	@RequestName(value="dailyTicketStatisticsExcel")
	public String dailyTicketStatisticsExcel(@ModelAttribute @Valid ZeropayStatisticsVO zeropayStatisticsVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("zeropay/stt_zpay_dailyTicketPmt_excel");
		String bizName = "일일권 결제 현황 Excel";
		HttpUtil.printServiceLogStart(bizName, log, request);
		try{
			
			// 날짜조회 (날짜 없을경우 현 날짜로 조회)	++ 빈값일 경우 제로페이 오픈일(2019.09.26)로 변경 2020.02.03
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowDay = sdf.format(cal.getTime());
			
			//cal.add(Calendar.DATE , -6);
			//String nowDay2 = sdf.format(cal.getTime());
			
			if(zeropayStatisticsVo.getSearchBgnDe() == null){
				zeropayStatisticsVo.setSearchBgnDe("2019-09-26");
			}
			if(zeropayStatisticsVo.getSearchEndDe() == null){
				zeropayStatisticsVo.setSearchEndDe(nowDay);
			}
			
			int totCnt = zeropayStatisticsService.getDailyTicketPmtListCnt(zeropayStatisticsVo);
			
			PaginationInfo paginationInfo = getPagingInfo(zeropayStatisticsVo.getCurrentPageNo(), totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(zeropayStatisticsVo.getCurrentPageNo(), totCnt);

			zeropayStatisticsVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			zeropayStatisticsVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			zeropayStatisticsVo.setPagingYn("N");
			
			List<ZeropayStatisticsVO> resultList = zeropayStatisticsService.getDailyTicketPmtList(zeropayStatisticsVo);
			
			/*
			 * for (ZeropayStatisticsVO vo : resultList) {
			 * System.out.println("####resultList = "+vo.getTicketDate()
			 * +" "+vo.getTicketCnt()+" "+vo.getMember_1h()+" "+vo.getMember_2h()+" "+vo.
			 * getNonMember_1h()+" "+vo.getNonMember_2h() ); }
			 */
			
			bResult = true;		// 정상 
			model.addAttribute("searchCondition", zeropayStatisticsVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("dataList", resultList);
			
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.statistics.dailyTicketStatisticsExcel");
		}
			
		return bResult ? resultPage : ERROR_PAGE;
		
	}
	
	@RequestMapping(value="/zeropay/paymentTypeStatistics.do")
	@RequestName(value="paymentTypeStatistics")
	public String paymentTypeStatistics(@ModelAttribute @Valid ZeropayStatisticsVO zeropayStatisticsVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("zeropay/stt_zpay_paymentType");
		String bizName = "결제수단별 현황";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			
			// 날짜조회 (날짜 없을경우 현 날짜로 조회)	++ 빈값일 경우 제로페이 오픈일(2019.09.26)로 변경 2020.02.03
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowDay = sdf.format(cal.getTime());
			
			//cal.add(Calendar.DATE , -6);
			//String nowDay2 = sdf.format(cal.getTime());
			
			if(zeropayStatisticsVo.getSearchBgnDe() == null){
				zeropayStatisticsVo.setSearchBgnDe("2019-09-26");
			}
			if(zeropayStatisticsVo.getSearchEndDe() == null){
				zeropayStatisticsVo.setSearchEndDe(nowDay);
			}
			
			int totCnt = zeropayStatisticsService.getPaymentTypeListCnt(zeropayStatisticsVo);
			/*
			 * System.out.println("totCnt>>> "+totCnt);
			 * System.out.println("getChkTicket>>> "+zeropayStatisticsVo.getChkTicket());
			 */
			PaginationInfo paginationInfo = getPagingInfo(zeropayStatisticsVo.getCurrentPageNo(), totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(zeropayStatisticsVo.getCurrentPageNo(), totCnt);

			zeropayStatisticsVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			zeropayStatisticsVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			zeropayStatisticsVo.setPagingYn("Y");
			List<ZeropayStatisticsVO> resultList = zeropayStatisticsService.getPaymentTypeList(zeropayStatisticsVo);
			
			/*
			 * System.out.println("###일일권만 조회 유무"+zeropayStatisticsVo.getChkDailyTicket());
			 * for (ZeropayStatisticsVO vo : resultList) {
			 * System.out.println("####resultList = "+vo.getPmtDate() +" "+vo.getPmtWeek()
			 * +" "+vo.getTotPmtCnt()+" "+vo.getTotPmtPrice()+" "+vo.
			 * getZeropayPmt_priceRatio()
			 * +" "+vo.getZeropayPmt_priceRatio()+" "+vo.getZeropayPmt_cnt()+" "+vo.
			 * getZeropayPmt_ratio()+" "+vo.getCreditPmt_price()+" "+vo.
			 * getCreditPmt_cnt()+" "+vo.getCreditPmt_ratio()+" "+vo.getPhonePmt_price()+" "
			 * +vo.getPhonePmt_cnt()+" "+vo.getPhonePmt_ratio()+" "+vo.getKakaoPmt_price()
			 * +" "
			 * +vo.getKakaoPmt_cnt()+" "+vo.getKakaoPmt_ratio()+" "+vo.getPaycoPmt_price()
			 * +" "+vo.getPaycoPmt_cnt()+" "+vo.getPaycoPmt_ratio()); }
			 */
			
			bResult = true;		// 정상 
			model.addAttribute("searchCondition", zeropayStatisticsVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("dataList", resultList);
			
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.statistics.paymentTypeStatistics");
		}
			
		return bResult ? resultPage : ERROR_PAGE;
		
	}
	
	@RequestMapping(value="/zeropay/paymentTypeStatisticsExcel.do")
	@RequestName(value="paymentTypeStatisticsExcel")
	public String paymentTypeStatisticsExcel(@ModelAttribute @Valid ZeropayStatisticsVO zeropayStatisticsVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("zeropay/stt_zpay_paymentType_excel");
		String bizName = "결제수단별 현황 Excel";
		HttpUtil.printServiceLogStart(bizName, log, request);
		try{
			
			// 날짜조회 (날짜 없을경우 현 날짜로 조회)	++ 빈값일 경우 제로페이 오픈일(2019.09.26)로 변경 2020.02.03
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowDay = sdf.format(cal.getTime());
			
			//cal.add(Calendar.DATE , -6);
			//String nowDay2 = sdf.format(cal.getTime());
			
			if(zeropayStatisticsVo.getSearchBgnDe() == null){
				zeropayStatisticsVo.setSearchBgnDe("2019-09-26");
			}
			if(zeropayStatisticsVo.getSearchEndDe() == null){
				zeropayStatisticsVo.setSearchEndDe(nowDay);
			}
			
			int totCnt = zeropayStatisticsService.getPaymentTypeListCnt(zeropayStatisticsVo);
			
			PaginationInfo paginationInfo = getPagingInfo(zeropayStatisticsVo.getCurrentPageNo(), totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(zeropayStatisticsVo.getCurrentPageNo(), totCnt);

			zeropayStatisticsVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			zeropayStatisticsVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			zeropayStatisticsVo.setPagingYn("N");
			List<ZeropayStatisticsVO> resultList = zeropayStatisticsService.getPaymentTypeList(zeropayStatisticsVo);
		
			/*
			 * for (ZeropayStatisticsVO vo : resultList) {
			 * System.out.println("####resultList = "+vo.getPmtDate()
			 * +" "+vo.getTotPmtCnt()+" "+vo.getTotPmtPrice()+" "+vo.getZeropayPmt_price()
			 * +" "+vo.getZeropayPmt_priceRatio()+" "+vo.getZeropayPmt_cnt()+" "+vo.
			 * getZeropayPmt_priceRatio()+" "+vo.getCreditPmt_cnt()+" "+vo.
			 * getCreditPmt_ratio()+" "+vo.getPhonePmt_cnt()+" "+vo.getPhonePmt_ratio()+" "
			 * +vo.getKakaoPmt_cnt()+" "+vo.getKakaoPmt_ratio()+" "+vo.getPaycoPmt_cnt()+" "
			 * +vo.getPaycoPmt_ratio()+" "+vo.getOtherPmt_cnt()+" "+vo.getOtherPmt_ratio());
			 * }
			 */
			
			bResult = true;		// 정상 
			model.addAttribute("searchCondition", zeropayStatisticsVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("dataList", resultList);
			model.addAttribute("chkYn",zeropayStatisticsVo.getChkDailyTicket());
			
			
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.statistics.paymentTypeStatisticsExcel");
		}
			
		return bResult ? resultPage : ERROR_PAGE;
		
	}
	
	
	
	@RequestMapping(value="/zeropay/seasonTicketStatistics.do")
	@RequestName(value="seasonTicketStatistics")
	public String seasonTicketStatistics(@ModelAttribute @Valid ZeropayStatisticsVO zeropayStatisticsVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("zeropay/stt_zpay_seasonTicketPmt");
		String bizName = "정기권 결제 현황";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			// 날짜조회 (날짜 없을경우 현 날짜로 조회)	++ 빈값일 경우 제로페이 오픈일(2019.09.26)로 변경 2020.02.03
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowDay = sdf.format(cal.getTime());
			
			//cal.add(Calendar.DATE , -6);
			//String nowDay2 = sdf.format(cal.getTime());
			
			if(zeropayStatisticsVo.getSearchBgnDe() == null){
				zeropayStatisticsVo.setSearchBgnDe("2019-09-26");
			}
			if(zeropayStatisticsVo.getSearchEndDe() == null){
				zeropayStatisticsVo.setSearchEndDe(nowDay);
			}
			
			int totCnt = zeropayStatisticsService.getSeasonTicketPmtListCnt(zeropayStatisticsVo);
			/*
			 * System.out.println("totCnt>>>> "+totCnt);
			 * System.out.println("getChkTicket>>> "+zeropayStatisticsVo.getChkTicket());
			 */
			PaginationInfo paginationInfo = getPagingInfo(zeropayStatisticsVo.getCurrentPageNo(), totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(zeropayStatisticsVo.getCurrentPageNo(), totCnt);

			zeropayStatisticsVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			zeropayStatisticsVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			zeropayStatisticsVo.setPagingYn("Y");
			List<ZeropayStatisticsVO> resultList = zeropayStatisticsService.getSeasonTicketPmtList(zeropayStatisticsVo);
			
			
			/*
			 * for (ZeropayStatisticsVO vo : resultList) {
			 * System.out.println("####resultList = "+vo.getTicketDate()
			 * +" "+vo.getTicketCnt()+" "+vo.getTotPmtPrice()+" "+vo.getTicket_7day_1h()+" "
			 * +vo. getTicketPmt_7day_1h()+" "+vo.
			 * getTicket_7day_2h()+" "+vo.getTicketPmt_7day_2h()
			 * +" "+vo.getTicket_30day_1h()+" "+vo.getTicketPmt_30day_1h()+" "+vo.
			 * getTicket_30day_2h( )+" "+vo.
			 * getTicketPmt_30day_2h()+" "+vo.getTicket_180day_1h()
			 * +" "+vo.getTicketPmt_180day_1h()); }
			 */
			 
			
			bResult = true;		// 정상 
			model.addAttribute("searchCondition", zeropayStatisticsVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("dataList", resultList);
			
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.statistics.seasonTicketStatistics");
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestMapping(value="/zeropay/seasonTicketStatisticsExcel.do")
	@RequestName(value="seasonTicketStatisticsExcel")
	public String seasonTicketStatisticsExcel(@ModelAttribute @Valid ZeropayStatisticsVO zeropayStatisticsVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("zeropay/stt_zpay_seasonTicketPmt_excel");
		String bizName = "정기권 결제 현황 Excel";
		HttpUtil.printServiceLogStart(bizName, log, request);
		try{
			
			// 날짜조회 (날짜 없을경우 현 날짜로 조회)	++ 빈값일 경우 제로페이 오픈일(2019.09.26)로 변경 2020.02.03
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowDay = sdf.format(cal.getTime());
			
			//cal.add(Calendar.DATE , -6);
			//String nowDay2 = sdf.format(cal.getTime());
			
			if(zeropayStatisticsVo.getSearchBgnDe() == null){
				zeropayStatisticsVo.setSearchBgnDe("2019-09-26");
			}
			if(zeropayStatisticsVo.getSearchEndDe() == null){
				zeropayStatisticsVo.setSearchEndDe(nowDay);
			}
			
			int totCnt = zeropayStatisticsService.getSeasonTicketPmtListCnt(zeropayStatisticsVo);
			
			PaginationInfo paginationInfo = getPagingInfo(zeropayStatisticsVo.getCurrentPageNo(), totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(zeropayStatisticsVo.getCurrentPageNo(), totCnt);

			zeropayStatisticsVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			zeropayStatisticsVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			zeropayStatisticsVo.setPagingYn("N");
			
			List<ZeropayStatisticsVO> resultList = zeropayStatisticsService.getSeasonTicketPmtList(zeropayStatisticsVo);
			
			/*
			 * for (ZeropayStatisticsVO vo : resultList) {
			 * System.out.println("####resultList = "+vo.getTicketDate()
			 * +" "+vo.getTicketCnt()+" "+vo.getMember_1h()+" "+vo.getMember_2h()+" "+vo.
			 * getNonMember_1h()+" "+vo.getNonMember_2h() ); }
			 */
			
			bResult = true;		// 정상 
			model.addAttribute("searchCondition", zeropayStatisticsVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("dataList", resultList);
			
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.statistics.seasonTicketStatisticsExcel");
		}
			
		return bResult ? resultPage : ERROR_PAGE;
		
	}
	
	
}
