package com.dkitec.barocle.admin.maintenance.repair.division.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.dkitec.barocle.admin.login.vo.UserSessionVO;
import com.dkitec.barocle.admin.maintenance.repair.division.service.RepairDivisionService;
import com.dkitec.barocle.admin.maintenance.repair.division.vo.RepairDivisionVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.HttpUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="RepairDivisionController")
public class RepairDivisionController extends BaseController {
	protected static Logger log = LoggerFactory.getLogger(RepairDivisionController.class);
	@Resource(name="repairDivisionService")
	
	private RepairDivisionService repairDivisionService;
	
	private static final String RETURN_URL = "/admin/maintenance/repair/lock/";

	@RequestMapping(value="/repairDivision.do")
	@RequestName(value="repairDivision")
	public String repairDivision(@ModelAttribute @Valid RepairDivisionVO repairDivisionVo, BindingResult result, HttpServletRequest request, ModelMap model) throws Exception {
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("rep_division");
		String bizName = "수리구분 카테고리 관리";
		HttpUtil.printServiceLogStart(bizName, log, request);

		try{
			repairDivisionVo.setPagingYn("Y");

			String tapNo = String.valueOf(request.getParameter("btnChk"));
			
			String chk = String.valueOf(repairDivisionVo.getBtn_chk());
			
			//자전거
			if(chk.equals("1") || "1".equals(chk) || "1".equals(tapNo)){
				model.addAttribute("btnChk", "1");
				repairDivisionVo.setComUpCd("REB"); 
			//무선AP
			}else if(chk.equals("2") || "2".equals(chk)|| "2".equals(tapNo)){
				model.addAttribute("btnChk", "2");
				repairDivisionVo.setComUpCd("REA"); 
			//거치대
			}else if(chk.equals("3") || "3".equals(chk)|| "3".equals(tapNo)){
				model.addAttribute("btnChk", "3");
				repairDivisionVo.setComUpCd("REL"); 
			}else{
				model.addAttribute("btnChk", "1");
				repairDivisionVo.setComUpCd("REB"); 
			}
			
			//등록된 수리구분 코드수를 조회
			int totCnt = repairDivisionService.getCodeListCnt(repairDivisionVo);
			PaginationInfo paginationInfo = getPagingInfo(repairDivisionVo.getCurrentPageNo(), totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(repairDivisionVo.getCurrentPageNo(), totCnt);
			
			repairDivisionVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			repairDivisionVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<RepairDivisionVO> resultList = repairDivisionService.getCodeList(repairDivisionVo);
					
			model.addAttribute("searchCondition", repairDivisionVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("RepairDivisionList", resultList);
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.maintenance.rep_division");
		}
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	
	
	@RequestMapping(value="/repairUdtDivision.do")
	@RequestName(value="repairUdtDivision")
	public String repairUdtDivision(@ModelAttribute @Valid RepairDivisionVO repairDivisionVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		
		boolean bResult = false;
		
		String resultPage = "redirect:/repairDivision.do";
		
		String bizName = "수리구분 수정";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			repairDivisionVo.setPagingYn("Y");
			
			String chk = repairDivisionVo.getBtn_chk();
			
			UserSessionVO userSessionVO = (UserSessionVO)(request.getSession()).getAttribute("userSessionVO");
			
			repairDivisionVo.setAdminId(String.valueOf(userSessionVO.getUsrId()));
			
			int divisionResultCnt= repairDivisionService.getDivisionUdt(repairDivisionVo);
			
			if(divisionResultCnt > 0){
				resultPage = "redirect:/divisionEditUdt.do";
				model.addAttribute("comCd", repairDivisionVo.getComCd());
			}

			model.addAttribute("searchCondition", repairDivisionVo);
			model.addAttribute("currentPageNo", repairDivisionVo.getCurrentPageNo());
			model.addAttribute("btnChk", chk);
			model.addAttribute("returnCnt", divisionResultCnt);
			
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.maintenance.rep_division");
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	
	@RequestMapping(value="/repairAddDivision.do")
	@RequestName(value="repairAddDivision")
	public String repairAddDivision(@ModelAttribute @Valid RepairDivisionVO repairDivisionVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		
		boolean bResult = false;
		
		String resultPage = "redirect:/repairDivision.do";
		
		String bizName = "수리구분 저장";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			repairDivisionVo.setPagingYn("Y");
			
			String chk = repairDivisionVo.getBtn_chk();
			
			UserSessionVO userSessionVO = (UserSessionVO)(request.getSession()).getAttribute("userSessionVO");
			
			repairDivisionVo.setAdminId(String.valueOf(userSessionVO.getUsrId()));
			
			//자전거
			if(chk.equals("1") || "1".equals(chk)){
				model.addAttribute("btnChk", "1");
				repairDivisionVo.setComUpCd("REB"); 
			//무선AP
			}else if(chk.equals("2") || "2".equals(chk)){
				model.addAttribute("btnChk", "2");
				repairDivisionVo.setComUpCd("REA"); 
			//거치대
			}else if(chk.equals("3") || "3".equals(chk)){
				model.addAttribute("btnChk", "3");
				repairDivisionVo.setComUpCd("REL"); 
			}else{
				model.addAttribute("btnChk", "1");
				repairDivisionVo.setComUpCd("REB"); 
			}
			
			int divisionResultCnt= repairDivisionService.getDivisionAdd(repairDivisionVo);
			
			if(divisionResultCnt > 0){
				resultPage = "redirect:/divisionEditAdd.do";
				model.addAttribute("comCd", repairDivisionVo.getComCd());
			}

			model.addAttribute("searchCondition", repairDivisionVo);
			model.addAttribute("currentPageNo", repairDivisionVo.getCurrentPageNo());
			model.addAttribute("btnChk", chk);
			model.addAttribute("returnCnt", divisionResultCnt);
			
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.maintenance.rep_division");
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	
	@RequestMapping(value="/divisionEditAdd.do")
	@RequestName(value="divisionEditAdd")
	public String divisionEditAdd(@ModelAttribute @Valid RepairDivisionVO repairDivisionVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("rep_division_add");
		String bizName = "수리구분 등록 화면";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			repairDivisionVo.setPagingYn("Y");

			PaginationInfo paginationInfo = getPagingInfo(repairDivisionVo.getCurrentPageNo(), 5);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(repairDivisionVo.getCurrentPageNo(), 5);
			
			repairDivisionVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			repairDivisionVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			String tapNo = String.valueOf(request.getParameter("btnChk"));
			
			String chk = String.valueOf(repairDivisionVo.getBtn_chk());
			
			//자전거
			if(chk.equals("1") || "1".equals(chk) || "1".equals(tapNo)){
				model.addAttribute("btnChk", "1");
				repairDivisionVo.setComUpCd("REB"); 
			//무선AP
			}else if(chk.equals("2") || "2".equals(chk)|| "2".equals(tapNo)){
				model.addAttribute("btnChk", "2");
				repairDivisionVo.setComUpCd("REA"); 
			//거치대
			}else if(chk.equals("3") || "3".equals(chk)|| "3".equals(tapNo)){
				model.addAttribute("btnChk", "3");
				repairDivisionVo.setComUpCd("REL"); 
			}else{
				model.addAttribute("btnChk", "1");
				repairDivisionVo.setComUpCd("REB"); 
			}
					
			model.addAttribute("searchCondition", repairDivisionVo);
			//model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("returnCnt", request.getParameter("returnCnt"));

			
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.maintenance.rep_division");
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}

	
	@RequestMapping(value="/divisionEditUdt.do")
	@RequestName(value="divisionEditUdt")
	public String divisionEditUdt(@ModelAttribute @Valid RepairDivisionVO repairDivisionVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("rep_division_udt");
		String bizName = "거치대 장애관리 화면";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			repairDivisionVo.setPagingYn("Y");
			
			String chk = repairDivisionVo.getBtn_chk();

			//자전거
			if(chk == null || chk.equals("1") || "1".equals(chk)){
				model.addAttribute("btnChk", "1");
				repairDivisionVo.setComUpCd("REB"); 
			//무선AP
			}else if(chk.equals("2") || "2".equals(chk)){
				model.addAttribute("btnChk", "2");
				repairDivisionVo.setComUpCd("REA"); 
			//거치대
			}else if(chk.equals("3") || "3".equals(chk)){
				model.addAttribute("btnChk", "3");
				repairDivisionVo.setComUpCd("REL"); 
			}
			
			RepairDivisionVO divisionResult= repairDivisionService.getDivisionUdtList(repairDivisionVo);

			model.addAttribute("searchCondition", repairDivisionVo);
			model.addAttribute("currentPageNo", repairDivisionVo.getCurrentPageNo());
			
			model.addAttribute("udtDspOrd", divisionResult.getDspOrd());
			model.addAttribute("udtCodeNm1", divisionResult.getCodeNm1());
			model.addAttribute("udtCodeNm2", divisionResult.getCodeNm2());
			model.addAttribute("udtCodeNm3", divisionResult.getCodeNm3());
			model.addAttribute("udtCodeNm4", divisionResult.getCodeNm4());
			model.addAttribute("udtCdDesc1", divisionResult.getCdDesc1());
			model.addAttribute("udtAddVal1", divisionResult.getAddVal1());
			model.addAttribute("udtAddVal2", divisionResult.getAddVal2());
			model.addAttribute("udtAddVal3", divisionResult.getAddVal3());
			model.addAttribute("udtUseYn", divisionResult.getUseYn());
			model.addAttribute("comCd", divisionResult.getComCd());
			model.addAttribute("comUpCd", divisionResult.getComUpCd());
			
			model.addAttribute("returnCnt", request.getParameter("returnCnt"));
			
			
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.maintenance.rep_division");
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	
	@RequestMapping(value="/divisionEditDel.do")
	@RequestName(value="divisionEditDel")
	public String divisionEditDel(@ModelAttribute @Valid RepairDivisionVO repairDivisionVo, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		
		boolean bResult = false;
		
		String resultPage = "redirect:/repairDivision.do";

		try{
			if(repairDivisionVo.getComCdArr() != null){
				String[] comArr = repairDivisionVo.getComCdArr().split(",");
				String comString = "";
				if(comArr.length > 1){
					for (int i = 0; i < comArr.length; i++) {
						comString = comArr[i];
						repairDivisionVo.setComCd(comString);
						
						repairDivisionService.getDivisionDel(repairDivisionVo);
					}
				}else{
					comString = comArr[0];
					repairDivisionVo.setComCd(comString);
					
					repairDivisionService.getDivisionDel(repairDivisionVo);
				}
			}
			
			String bizName = "수리구분 삭제";
			HttpUtil.printServiceLogStart(bizName, log, request);
			
			repairDivisionVo.setPagingYn("Y");
			
			String chk = repairDivisionVo.getBtn_chk();

			model.addAttribute("searchCondition", repairDivisionVo);
			//model.addAttribute("currentPageNo", repairDivisionVo.getCurrentPageNo());
			model.addAttribute("btnChk", chk);
			
			bResult = true;		// 정상
		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.maintenance.rep_division");
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	
}
