package com.dkitec.barocle.admin.maintenance.relocation.controller;

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
import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.admin.login.vo.UserSessionVO;
import com.dkitec.barocle.admin.maintenance.relocation.service.RelocationService;
import com.dkitec.barocle.admin.maintenance.relocation.vo.RelocationVO;
import com.dkitec.barocle.admin.maintenance.relocation.vo.RelocationWorkArrangeCallVO;
import com.dkitec.barocle.admin.maintenance.relocation.vo.RelocationWorkArrangeResultVO;
import com.dkitec.barocle.admin.maintenance.relocation.vo.RelocationWorkOrderVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.HttpUtil;
import com.dkitec.barocle.util.webutil.StringUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="RelocationController")
public class RelocationController extends BaseController {
	protected static Logger log = LoggerFactory.getLogger(RelocationController.class);
	@Resource(name="relocationService")
	
	private RelocationService relocationService;
	
	private static final String RETURN_URL = "/admin/maintenance/relocation/";

	@RequestMapping(value="/relocationNeedList.do")
	@RequestName(value="getRelocationNeedList")
	public String getRelocationNeedList(@ModelAttribute @Valid RelocationVO relocationVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("target/loc_need_list");
		String bizName = "재배치 대상 화면";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			relocationVo.setPagingYn("Y");

			/*if(relocationVo.getMode() != null && relocationVo.getMode().equals("excel")){
				resultPage = RETURN_URL.concat("target/loc_need_list_excel");
				relocationVo.setPagingYn("N");
			}*/
			if(relocationVo.getViewFlg().equals(MODE_EXCEL)) {
				resultPage = RETURN_URL.concat("target/loc_need_list_excel");
				relocationVo.setPagingYn("N");
    		}
			
			int totCnt = relocationService.getRelocationNeedListCount(relocationVo);
			PaginationInfo paginationInfo = getPagingInfo(relocationVo.getCurrentPageNo(), totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(relocationVo.getCurrentPageNo(), totCnt);
			
			relocationVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			relocationVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<RelocationVO> resultList = relocationService.getRelocationNeedList(relocationVo);
					
			model.addAttribute("searchCondition", relocationVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("RelocationNeedList", resultList);
			
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.maintenance.relocation.target.loc_need_list");
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestMapping(value="/relocationStateList.do")
	@RequestName(value="getRelocationStateList")
	public String getRelocationStateList(@ModelAttribute @Valid RelocationVO relocationVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("result/loc_state_list");
		String bizName = "재배치 내역 화면";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			if(relocationVo.getAdminType() == null){
				relocationVo.setAdminType("ADM_005");
			}
			relocationVo.setPagingYn("Y");
			int totCnt = relocationService.getRelocationStateListCount(relocationVo);
			PaginationInfo paginationInfo = getPagingInfo(relocationVo.getCurrentPageNo(), totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(relocationVo.getCurrentPageNo(), totCnt);
			
			relocationVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			relocationVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			
			List<RelocationVO> resultList = relocationService.getRelocationStateList(relocationVo);
					
			model.addAttribute("searchCondition", relocationVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("RelocationStateList", resultList);
			
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.maintenance.relocation.result.loc_state_list");
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}

	
	@RequestMapping(value="/relocationStateDetail.do")
	@RequestName(value="relocationStateDetail")
	public String getRelocationStateDetail(@ModelAttribute @Valid RelocationVO relocationVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("result/loc_state_detail");
		String bizName = "재배치 내역 상세";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			relocationVo.setPagingYn("Y");

			if(relocationVo.getViewFlg().equals(MODE_EXCEL)) {
				resultPage = RETURN_URL.concat("result/loc_state_detail_excel");
				relocationVo.setPagingYn("N");
    		}
			
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			if(relocationVo.getSearchBgnDe() == null && relocationVo.getSearchEndDe() == null){
				relocationVo.setSearchEndDe(sdf.format(cal.getTime()));
				cal.add(Calendar.DAY_OF_MONTH, -1);
				relocationVo.setSearchBgnDe(sdf.format(cal.getTime()));
			}
			
			// 20210813 
			if( "".equals( StringUtil.isNullToStr(relocationVo.getViewType() ))) {
				relocationVo.setViewType("move");
			}
			
			int totCnt = relocationService.getRelocationStateDetailCount(relocationVo);
			PaginationInfo paginationInfo = getPagingInfo(relocationVo.getCurrentPageNo(), 10, 10, totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(relocationVo.getCurrentPageNo(), totCnt);
			
			relocationVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			relocationVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<RelocationVO> resultList = relocationService.getRelocationStateDetail(relocationVo);
			
			model.addAttribute("searchCondition", relocationVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("RelocationStateDetail", resultList);
			
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.maintenance.relocation.result.loc_state_detail");
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestMapping(value="/relocationStateBike.do")
	@RequestName(value="relocationStateBike")
	public String getRelocationStateBike(@ModelAttribute @Valid RelocationVO relocationVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("result/loc_state_bike");
		String bizName = "재배치 내역 상세 - 자전거";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			relocationVo.setPagingYn("Y");

			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			
			if(relocationVo.getSearchBgnDe() == null && relocationVo.getSearchEndDe() == null){
				relocationVo.setSearchEndDe(sdf.format(cal.getTime()));
				cal.add(Calendar.DAY_OF_MONTH, 0);
				relocationVo.setSearchBgnDe(sdf.format(cal.getTime()));
			}
			
			int totCnt = relocationService.getRelocationStateBikeCount(relocationVo);
			PaginationInfo paginationInfo = getPagingInfo(relocationVo.getCurrentPageNo(), 10, 10, totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(relocationVo.getCurrentPageNo(), totCnt);
			
			relocationVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			relocationVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<RelocationVO> resultList = relocationService.getRelocationStateBike(relocationVo);
					
			model.addAttribute("searchCondition", relocationVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("RelocationStateDetail", resultList);
			
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.maintenance.relocation.result.relocationStateBike");
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	
	
	
	@RequestMapping(value="/relocationStateStationMap.do")
	@RequestName(value="relocationStateStationMap")
	public String relocationStateStationMap(@ModelAttribute @Valid RelocationVO relocationVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("result/loc_state_stationMap");
		String bizName = "재배치 내역 상세 - 대여소";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			relocationVo.setPagingYn("Y");

			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			
			if(relocationVo.getSearchBgnDe() == null && relocationVo.getSearchEndDe() == null){
				relocationVo.setSearchEndDe(sdf.format(cal.getTime()));
				cal.add(Calendar.DAY_OF_MONTH, 0);
				relocationVo.setSearchBgnDe(sdf.format(cal.getTime()));
			}
			model.addAttribute("searchCondition", relocationVo);
			
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.maintenance.relocation.result.relocationStateBike");
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	

	@RequestMapping(value="/relocationStateStationMapAjax.do")
	@RequestName(value="relocationStateStationMapAjax")
	public String relocationStateStationMapAjax(@ModelAttribute @Valid RelocationVO relocationVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		 
		try{
			model.addAttribute("dsList", relocationService.getRelocationStateStationMap(relocationVo));
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.maintenance.relocation.result.relocationStateBike");
		}
		return JSONVIEW;
	}
	

	
	@RequestMapping(value="/relocationStateStationMapExcel.do")
	@RequestName(value="relocationStateStationMapExcel")
	public String relocationStateStationMapExcel(@ModelAttribute @Valid RelocationVO relocationVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("result/loc_state_stationMap_excel");
		String bizName = "재배치 내역 상세 - 자전거";
		HttpUtil.printServiceLogStart(bizName, log, request);
		try{
			model.addAttribute("dsList", relocationService.getRelocationStateStationMap(relocationVo));
		} catch (CfoodException ce) {
			return "ERROR";
		}	
			
		return resultPage;
	}
	
	
	@RequestMapping(value="/relocationStateStation.do")
	@RequestName(value="relocationStateBike")
	public String getRelocationStateStation(@ModelAttribute @Valid RelocationVO relocationVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("result/loc_state_station");
		String bizName = "재배치 내역 상세 - 대여소";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			relocationVo.setPagingYn("Y");

			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			
			if(relocationVo.getSearchBgnDe() == null && relocationVo.getSearchEndDe() == null){
				relocationVo.setSearchEndDe(sdf.format(cal.getTime()));
				cal.add(Calendar.DAY_OF_MONTH, 0);
				relocationVo.setSearchBgnDe(sdf.format(cal.getTime()));
			}
			
			int totCnt = relocationService.getRelocationStateStationCount(relocationVo);
			PaginationInfo paginationInfo = getPagingInfo(relocationVo.getCurrentPageNo(), 10, 10, totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(relocationVo.getCurrentPageNo(), totCnt);
			
			relocationVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			relocationVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<RelocationVO> resultList = relocationService.getRelocationStateStation(relocationVo);
					
			model.addAttribute("searchCondition", relocationVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("RelocationStateDetail", resultList);
			
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.maintenance.relocation.result.relocationStateBike");
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	
	
	
	@RequestMapping(value="/relocationStateBikeExcel.do")
	@RequestName(value="relocationStateBikeExcel")
	public String getRelocationStateBikeExcel(@ModelAttribute @Valid RelocationVO relocationVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("result/loc_state_bike_excel");
		String bizName = "재배치 내역 상세 - 자전거";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			relocationVo.setPagingYn("N");

			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			
			if(relocationVo.getSearchBgnDe() == null && relocationVo.getSearchEndDe() == null){
				relocationVo.setSearchEndDe(sdf.format(cal.getTime()));
				cal.add(Calendar.DAY_OF_MONTH, 0);
				relocationVo.setSearchBgnDe(sdf.format(cal.getTime()));
			}
			
			int totCnt = relocationService.getRelocationStateBikeCount(relocationVo);
			
			List<RelocationVO> resultList = relocationService.getRelocationStateBike(relocationVo);
			PaginationInfo paginationInfo = getPagingInfo(relocationVo.getCurrentPageNo(), 10, 10, totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(relocationVo.getCurrentPageNo(), totCnt);
			
			relocationVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			relocationVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			model.addAttribute("searchCondition", relocationVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("RelocationStateDetail", resultList);
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.maintenance.relocation.result.relocationStateBikeExcel");
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	
	
	
	@RequestMapping(value="/getRelocationWorkOrder.do")
	@RequestName(value="getRelocationWorkOrder")
	public String getRelocationWorkOrder(@ModelAttribute @Valid RelocationWorkOrderVO relocationVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("result/loc_work_order");
		String bizName = "재배치 내역 상세 - 대여소";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			relocationVo.setPagingYn("Y");

			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			
			if(relocationVo.getViewFlg().equals(MODE_EXCEL)) {
				resultPage = RETURN_URL.concat("result/loc_work_order_excel");
				relocationVo.setPagingYn("N");
    		}
			
			if(relocationVo.getSearchBgnDe() == null && relocationVo.getSearchEndDe() == null){
				relocationVo.setSearchEndDe(sdf.format(cal.getTime()));
				cal.add(Calendar.DAY_OF_MONTH, 0);
				relocationVo.setSearchBgnDe(sdf.format(cal.getTime()));
			}
			
			int totCnt = relocationService.getRelocationWorkOrderCount(relocationVo);
			PaginationInfo paginationInfo = getPagingInfo(relocationVo.getCurrentPageNo(), 10, 10, totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(relocationVo.getCurrentPageNo(), totCnt);
			
			relocationVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			relocationVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<RelocationWorkOrderVO> resultList = relocationService.getRelocationWorkOrder(relocationVo);
					
			model.addAttribute("searchCondition", relocationVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("RelocationStateDetail", resultList);
			
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.maintenance.relocation.result.relocationStateBike");
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	
	@RequestMapping(value="/getRelocationWorkMap.do")
	@RequestName(value="getRelocationWorkMap")
	public String getRelocationWorkMap(@ModelAttribute @Valid RelocationWorkArrangeCallVO vo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("result/loc_work_map");
		String bizName = "재배치 내역 상세 - 대여소";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			
			if(vo.getSearchBgnDe() == null && vo.getSearchEndDe() == null){
				vo.setSearchEndDe(sdf.format(cal.getTime()));
				cal.add(Calendar.DAY_OF_MONTH, 0);
				vo.setSearchBgnDe(sdf.format(cal.getTime()));
			}
			
			List<RelocationWorkArrangeCallVO> resultList = relocationService.getRelocationArrangeCall(vo);
					
			model.addAttribute("searchCondition", vo);
			model.addAttribute("dsList", resultList);
			
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.maintenance.relocation.result.getRelocationWorkMap");
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestMapping(value="/getRelocationArrangeResult.do")
	@RequestName(value="getRelocationArrangeResult")
	public String getRelocationArrangeResult(@ModelAttribute @Valid RelocationWorkArrangeResultVO vo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		 
		boolean bResult = false;		// 정상
		
		try{
			List<RelocationWorkArrangeResultVO> resultList = relocationService.getRelocationArrangeResult(vo);
			bResult = true;		// 정상
			model.addAttribute("dsList", resultList);
			model.addAttribute("bResult", bResult);
		} catch (CfoodException ce) {
			model.addAttribute("bResult", bResult);
		}
			
		return JSONVIEW;
	}
	
	@RequestMapping(value="/insertRelocationArrangeCall.do")
	@RequestName(value="insertRelocationArrangeCall")
	public String insertRelocationArrangeCall(@ModelAttribute @Valid RelocationWorkArrangeCallVO vo, BindingResult result, HttpServletRequest request, Model model) throws Exception {	 
		boolean bResult = false;		// 정상
		UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
		vo.setTeam_seq( userSessionVO.getTeamSeq() );
		if ( "0".equals(userSessionVO.getTeamSeq())) {
			vo.setTeam_seq( "25" );
		}
		vo.setReq_admin_id( userSessionVO.getUsrId() );
		try{
			bResult = true;		// 정상
			relocationService.insertRelocationArrangeCall(vo);
			model.addAttribute("bResult", bResult);
		} catch (CfoodException ce) {
			model.addAttribute("bResult", bResult);
		}
		
		return JSONVIEW;
	}
	
}
