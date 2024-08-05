package com.dkitec.barocle.admin.repairMgmt.repairWork.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
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
import com.dkitec.barocle.admin.repairMgmt.repairWork.service.RepairWorkService;
import com.dkitec.barocle.admin.repairMgmt.repairWork.vo.RepairWorkVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.DateUtil;
import com.dkitec.barocle.util.webutil.HttpUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="RepairWorkController")
public class RepairWorkController extends BaseController{
	protected static Logger log = LoggerFactory.getLogger(RepairWorkController.class);

	@Resource(name="RepairWorkService") private RepairWorkService repairWorkService;
	
	private static final String RETURN_URL = "/admin/repairMgmt/repairWork/";
	
	@RequestMapping(value = "/getMainWorkAjax.do")
	@RequestName("getMainWorkAjax")
	public String getMainWorkAjax(@ModelAttribute @Valid RepairWorkVO repairWorkVO, HttpServletRequest request,ModelMap model) throws Exception {
		String bizName = "메인화면 정비직원 당일 근태조회";
		HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력
		
		String todayDate = DateUtil.getSystemDate("yyyy-MM-dd");
		try {
			
			repairWorkVO.setSearchEndDe(todayDate);
			repairWorkVO.setSearchBgnDe(todayDate);
			RepairWorkVO workVO = repairWorkService.getMaintenWrkerAttD(repairWorkVO);
			model.addAttribute("workVO", workVO);
			
		} catch (CfoodException e) {
			throw new CfoodException("admin.repairMgmt.repairWork.getMainWork" , e.getMessage());
		}
		
		return JSONVIEW;
	}
	@RequestMapping(value = "/updateRepairWorkAjax.do")
	@RequestName("updateRepairWorkAjax")
	public String updateRepairWorkAjax(@ModelAttribute @Valid RepairWorkVO repairWorkVO, HttpServletRequest request,ModelMap model) throws Exception {
		String bizName = "정비직원 근태수정";
		HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력
		
		String todayDate = DateUtil.getSystemDate("yyyy-MM-dd");
		
		try {
			
			repairWorkVO.setWorkDate(todayDate);
			repairWorkVO.setModId(repairWorkVO.getAdminId());
			
			Date dt = new Date();
			SimpleDateFormat sDate = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			repairWorkVO.setModDttm(sDate.format(dt));
			
			repairWorkService.updateRepairWork(repairWorkVO);
			
		} catch (CfoodException e) {
			throw new CfoodException("admin.repairMgmt.repairWork.updateRepairWork" , e.getMessage());
		}
		
		return JSONVIEW;
	}
	@RequestMapping(value = "/insertRepairWorkAjax.do")
	@RequestName("insertRepairWorkAjax")
	public String insertRepairWorkAjax(@ModelAttribute @Valid RepairWorkVO repairWorkVO, HttpServletRequest request,ModelMap model) throws Exception {
		String bizName = "정비직원 근태입력";
		HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력
		
		String todayDate = DateUtil.getSystemDate("yyyy-MM-dd");
		
		try {
			
			repairWorkVO.setWorkDate(todayDate);
			repairWorkVO.setRegId(repairWorkVO.getAdminId());
			
			Date dt = new Date();
			SimpleDateFormat sDate = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			repairWorkVO.setRegDttm(sDate.format(dt));
			
			repairWorkService.insertRepairWork(repairWorkVO);
			
		} catch (CfoodException e) {
			throw new CfoodException("admin.repairMgmt.repairWork.insertRepairWork" , e.getMessage());
		}
		
		return JSONVIEW;
	}
	@RequestMapping(value = "/updateRepairWorkAprvdAjax.do")
	@RequestName("updateRepairWorkAprvdAjax")
	public String updateRepairWorkAprvdAjax(@ModelAttribute @Valid RepairWorkVO repairWorkVO, HttpServletRequest request,ModelMap model) throws Exception {
		String bizName = "정비직원 근태 승인 처리";
		HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력
		
		try {
			
			repairWorkService.updateRepairWorkAprvd(repairWorkVO);
			
		} catch (CfoodException e) {
			throw new CfoodException("admin.repairMgmt.repairWork.updateRepairWorkAprvd" , e.getMessage());
		}
		
		return JSONVIEW;
	}
	
	@RequestMapping(value = "/getRepairWork.do")
	@RequestName("getRepairWork")
	public String getRepairWork(@ModelAttribute @Valid RepairWorkVO repairWorkVO, HttpServletRequest request,ModelMap model) throws Exception {
		String targetUrl = RETURN_URL.concat("repair_work_list");
		String bizName = "정비직원 근태 정보 조회";
		HttpUtil.printServiceLogStart(bizName, log, request); // 서비스로그 시작 출력
		
		boolean result = false;
		
		try {
			
			if(repairWorkVO.getViewFlg().equals(MODE_EXCEL) || "N".equals(repairWorkVO.getSearchAprd())){//미승인 목록은 페이징처리 하지 말라는 요구사항
				
				if(repairWorkVO.getViewFlg().equals(MODE_EXCEL)){
					
					targetUrl = RETURN_URL.concat("repair_work_list_excel");
					
					//엑셀에선 사업소 검색값을 센터아이디가 아닌 센터명으로 변환.
					repairWorkVO.setSearchCenter(repairWorkService.getCenterNameWithCenterCode(repairWorkVO));
					
				}
				repairWorkVO.setPagingYn("N");
				
			}else{
				
				repairWorkVO.setPagingYn("Y");
				
			}
			
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			
			if(repairWorkVO.getSearchBgnDe() == null && repairWorkVO.getSearchEndDe() == null){
				
				repairWorkVO.setSearchEndDe(sdf.format(cal.getTime()));
				repairWorkVO.setSearchBgnDe(sdf.format(cal.getTime()));
				
			}
			
			if(repairWorkVO.getAdminId() == null){

				userSessionVO = (UserSessionVO) EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
				
				repairWorkVO.setAdminId(userSessionVO.getUsrId());
				
			}
			
			repairWorkVO.setAdminGrpName(repairWorkService.getAdminGrpName(repairWorkVO));
			
			if("정비반장".equals(repairWorkVO.getAdminGrpName()) && repairWorkVO.getCenterId() == null){
				
				repairWorkVO.setCenterId(repairWorkService.getInsertWrkCenterId(repairWorkVO));
			}
			
			int totCnt = repairWorkService.getMaintenWrkerAttCnt(repairWorkVO);
			PaginationInfo paginationInfo = getPagingInfo(repairWorkVO.getCurrentPageNo(), totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(repairWorkVO.getCurrentPageNo(), totCnt);
			
			repairWorkVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			repairWorkVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<RepairWorkVO> workList = repairWorkService.getMaintenWrkerAtt(repairWorkVO);
			
			model.addAttribute("searchCondition", repairWorkVO);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("workList", workList);
			result = true;
		} catch (CfoodException e) {
			throw new CfoodException("admin.repairMgmt.repairWork.getRepairWork" , e.getMessage());
		}
		
		return result ? targetUrl : ERROR_PAGE;
	}
}
