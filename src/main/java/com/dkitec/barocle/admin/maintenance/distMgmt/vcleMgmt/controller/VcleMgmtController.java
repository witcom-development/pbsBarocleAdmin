package com.dkitec.barocle.admin.maintenance.distMgmt.vcleMgmt.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.admin.login.vo.UserSessionVO;
import com.dkitec.barocle.admin.maintenance.distMgmt.vcleMgmt.service.VcleMgmtService;
import com.dkitec.barocle.admin.maintenance.distMgmt.vcleMgmt.vo.VcleMgmtVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.DateUtil;
import com.dkitec.barocle.util.webutil.HttpUtil;
import com.hazelcast.util.StringUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


@Controller
@RequestCategory("VcleMgmtController")
public class VcleMgmtController extends BaseController {
	protected static Logger log = LoggerFactory.getLogger(VcleMgmtController.class);
	private static final String RETURN_URL = "/admin/maintenance/distMgmt/vcleMgmt/";
	
	@Resource(name="vcleMgmtService") private VcleMgmtService vcleMgmtService;
	
	
	@RequestMapping(value = "/getMainDistVcleAjax.do")
	@RequestName("getMainDistVcleAjax")
	public String getMainDistVcleAjax(@ModelAttribute @Valid VcleMgmtVO vcleMgmtVO, HttpServletRequest request,ModelMap model) throws Exception {
		String bizName = "메인화면 분배원 당일 차량조회";
		HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력
		
		String todayDate = DateUtil.getSystemDate("yyyy-MM-dd");
		try {
			
			if( vcleMgmtVO.getSearchBgnDe() == null || "".equals( vcleMgmtVO.getSearchBgnDe() )) {
				vcleMgmtVO.setSearchEndDe(todayDate);
				vcleMgmtVO.setSearchBgnDe(todayDate);
			}
			
			
			VcleMgmtVO vcleVO = vcleMgmtService.getTodayDistVcle(vcleMgmtVO);
			
			userSessionVO = (UserSessionVO) EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
			
			// 분배직원
			if(userSessionVO.getTeamSeq() != null && !"".equals(userSessionVO.getTeamSeq())){
				
				String centerId = vcleMgmtService.getCenterIdByTeamSeq(userSessionVO.getTeamSeq());
				
				if("DEC_999".equals(centerId)){
				}else{
					vcleMgmtVO.setCenterId(centerId);
				}
				
			// 순회정비반	
			} else if ( "27".equals( userSessionVO.getUsrGrpCd() ) || "28".equals( userSessionVO.getUsrGrpCd() ) ) {
				vcleMgmtVO.setCenterId("DEC_013");
			}
			
			List<VcleMgmtVO> vcleInfoList = vcleMgmtService.getVcleInfoList(vcleMgmtVO);
			List<VcleMgmtVO> swkCdList = vcleMgmtService.getShiftWorkCdList();
			
			model.addAttribute("searchCarBgnDe", vcleMgmtVO.getSearchBgnDe());
			
			model.addAttribute("vcleVO", vcleVO);
			model.addAttribute("vcleInfoList", vcleInfoList);
			model.addAttribute("swkCdList", swkCdList);
			
		} catch (CfoodException e) {
			throw new CfoodException("admin.maintenance.distMgmt.vcleMgmt.getMainDistVcle" , e.getMessage());
		}
		
		return JSONVIEW;
	}
	
	
	@RequestMapping(value = "/getMainDistVcleAjaxCode.do")
	@RequestName("getMainDistVcleAjax")
	public String getMainDistVcleAjax1(@ModelAttribute @Valid VcleMgmtVO vcleMgmtVO, HttpServletRequest request,ModelMap model) throws Exception {
		String bizName = "메인화면 분배원 당일 차량조회";
		HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력
		
		String todayDate = DateUtil.getSystemDate("yyyy-MM-dd");
		try {
			
			if( vcleMgmtVO.getSearchBgnDe() == null || "".equals( vcleMgmtVO.getSearchBgnDe() )) {
				vcleMgmtVO.setSearchEndDe(todayDate);
				vcleMgmtVO.setSearchBgnDe(todayDate);
			}
			List<VcleMgmtVO> vcleInfoList = vcleMgmtService.getVcleInfoList(vcleMgmtVO);
			model.addAttribute("vcleInfoList", vcleInfoList);
			
		} catch (CfoodException e) {
			throw new CfoodException("admin.maintenance.distMgmt.vcleMgmt.getMainDistVcle" , e.getMessage());
		}
		
		return JSONVIEW;
	}
	
	
	
	@RequestMapping(value = "/getVcleInfoListAjax.do")
	@RequestName("getVcleInfoListAjax")
	public String getVcleInfoListAjax(@ModelAttribute @Valid VcleMgmtVO vcleMgmtVO, HttpServletRequest request,ModelMap model) throws Exception {
		String bizName = "차량 현황 조회";
		HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력
		
		try {
			
			userSessionVO = (UserSessionVO) EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
			
			if(userSessionVO.getTeamSeq() != null && !"".equals(userSessionVO.getTeamSeq()) && "0".compareTo(userSessionVO.getTeamSeq()) < 0  ){
				String centerId = vcleMgmtService.getCenterIdByTeamSeq(userSessionVO.getTeamSeq());
				vcleMgmtVO.setCenterId(centerId);
			}
			
			List<VcleMgmtVO> vcleInfoList = vcleMgmtService.getVcleInfoList(vcleMgmtVO);
			
			model.addAttribute("vcleInfoList", vcleInfoList);
			
		} catch (CfoodException e) {
			throw new CfoodException("admin.maintenance.distMgmt.vcleMgmt.getVcleInfoList" , e.getMessage());
		}
		
		return JSONVIEW;
	}
	
	@RequestMapping(value = "/getDistVcleList.do")
	@RequestName("getDistVcleList")
	public String getDistVcleList(@ModelAttribute @Valid VcleMgmtVO vcleMgmtVO, HttpServletRequest request,ModelMap model) throws Exception {
		String bizName = "분배원 차량조회";
		HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력
		
		String todayDate = DateUtil.getSystemDate("yyyy-MM-dd");
		try {
			
			if( ( vcleMgmtVO.getSearchBgnDe() == null || "".equals(vcleMgmtVO.getSearchBgnDe()) ) && ( vcleMgmtVO.getSearchEndDe() == null || "".equals(vcleMgmtVO.getSearchEndDe()) ) ){
				
				vcleMgmtVO.setSearchEndDe(todayDate);
				vcleMgmtVO.setSearchBgnDe(todayDate);
				
			}
			
			int totCnt = vcleMgmtService.getDistVcleListCnt(vcleMgmtVO);
			PaginationInfo paginationInfo = getPagingInfo(vcleMgmtVO.getCurrentPageNo(), totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(vcleMgmtVO.getCurrentPageNo(), totCnt);
			
			vcleMgmtVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			vcleMgmtVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<VcleMgmtVO> vcleList = vcleMgmtService.getDistVcleList(vcleMgmtVO);
			
			List<VcleMgmtVO> vcleInfoList = vcleMgmtService.getVcleInfoList(vcleMgmtVO);
			
			model.addAttribute("searchCondition", vcleMgmtVO);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("vcleList", vcleList);
			model.addAttribute("vcleInfoList", vcleInfoList);
			
			
		} catch (CfoodException e) {
			throw new CfoodException("admin.maintenance.distMgmt.vcleMgmt.getDistVcleList" , e.getMessage());
		}
		
		return RETURN_URL.concat("vcle_mgmt_list");
	}
	
	
	

	@RequestMapping(value = "/getRoundVcleList.do")
	@RequestName("getDistVcleList")
	public String getRoundVcleList(@ModelAttribute @Valid VcleMgmtVO vcleMgmtVO, HttpServletRequest request,ModelMap model) throws Exception {
		String bizName = "순회 정비원 차량조회";
		HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력
		
		String todayDate = DateUtil.getSystemDate("yyyy-MM-dd");
		try {
			
			if( ( vcleMgmtVO.getSearchBgnDe() == null || "".equals(vcleMgmtVO.getSearchBgnDe()) ) && ( vcleMgmtVO.getSearchEndDe() == null || "".equals(vcleMgmtVO.getSearchEndDe()) ) ){
				
				vcleMgmtVO.setSearchEndDe(todayDate);
				vcleMgmtVO.setSearchBgnDe(todayDate);
				
			}
			
			int totCnt = vcleMgmtService.getRoundVcleListCnt(vcleMgmtVO);
			PaginationInfo paginationInfo = getPagingInfo(vcleMgmtVO.getCurrentPageNo(), totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(vcleMgmtVO.getCurrentPageNo(), totCnt);
			
			vcleMgmtVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			vcleMgmtVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<VcleMgmtVO> vcleList = vcleMgmtService.getRoundVcleList(vcleMgmtVO);
			
			List<VcleMgmtVO> vcleInfoList = new ArrayList<>();	// vcleMgmtService.getRoundInfoList(vcleMgmtVO);
			
			model.addAttribute("searchCondition", vcleMgmtVO);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("vcleList", vcleList);
			model.addAttribute("vcleInfoList", vcleInfoList);
			
			
		} catch (CfoodException e) {
			throw new CfoodException("admin.maintenance.distMgmt.vcleMgmt.getDistVcleList" , e.getMessage());
		}
		
		return RETURN_URL.concat("round_mgmt_list");
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	@RequestMapping(value = "/updateDistVcleAjax.do")
	@RequestName("updateDistVcleAjax")
	public String updateDistVcleAjax(@ModelAttribute @Valid VcleMgmtVO vcleMgmtVO, HttpServletRequest request,ModelMap model) throws Exception {
		insertDistVcleAjax( vcleMgmtVO,  request, model);
		return JSONVIEW;
	}
	
	@RequestMapping(value = "/insertDistVcleAjax.do")
	@RequestName("insertDistVcleAjax")
	public String insertDistVcleAjax(@ModelAttribute @Valid VcleMgmtVO vcleMgmtVO, HttpServletRequest request,ModelMap model) throws Exception {
		String bizName = "분배원 차량 등록";
		HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력
		
		UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
        if(userSessionVO == null){
        	throw new CfoodException(getMessage("error.invalidSession"));
        }
		
		try {
		
			// 20210524 사용자 정보 없을 경우 session id 
			if( StringUtil.isNullOrEmpty(vcleMgmtVO.getAdminId())) {
				vcleMgmtVO.setRegId(userSessionVO.getUsrId());
				vcleMgmtVO.setAdminId(userSessionVO.getUsrId());
			} else {
				vcleMgmtVO.setRegId(vcleMgmtVO.getAdminId());
			}
			
			  vcleMgmtService.insertDistVcleAll(vcleMgmtVO);
			
			
		} catch (CfoodException e) {
			
			model.addAttribute("IS_SUCC", false);
			// throw new CfoodException("admin.maintenance.distMgmt.vcleMgmt.insertDistVcle" , e.getMessage());
			
		}
		
		model.addAttribute("IS_SUCC", true);
		
		return JSONVIEW;
	}
	
	
	public static void main(String[] args) {
		System.out.println( StringUtil.isNullOrEmpty(null) );

	}
	
}
