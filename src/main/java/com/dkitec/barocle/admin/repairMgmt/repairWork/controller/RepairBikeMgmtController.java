package com.dkitec.barocle.admin.repairMgmt.repairWork.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.admin.login.vo.UserSessionVO;
import com.dkitec.barocle.admin.maintenance.repair.bike.service.RepairBikeService;
import com.dkitec.barocle.admin.maintenance.repair.bike.vo.RepairBikeVO;
import com.dkitec.barocle.admin.repairMgmt.repairPerf.service.RepairPerfService;
import com.dkitec.barocle.admin.repairMgmt.repairWork.service.RepairWorkService;
import com.dkitec.barocle.admin.repairMgmt.repairWork.vo.RepairTermVO;
import com.dkitec.barocle.admin.repairMgmt.repairWork.vo.RepairWorkVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.HttpUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="RepairBikeMgmtController")
public class RepairBikeMgmtController extends BaseController {
	protected static Logger log = LoggerFactory.getLogger(RepairBikeMgmtController.class);
	
	@Resource(name="repairBikeService") private RepairBikeService repairBikeService;	//기존 서비스 사용
	
	@Resource(name="RepairWorkService") private RepairWorkService repairWorkService;
	@Resource(name="RepairPerfService") private RepairPerfService repairPerfService;
	
	
	private static final String RETURN_URL = "/admin/repairMgmt/repairWork/";
	
	
	@RequestMapping(value = "/getCheckMntncAdminAjax.do")
	@RequestName(value="getCheckMntncAdminAjax")
	public String getCheckMntncAdminAjax(@ModelAttribute RepairBikeVO repairBikeVo, HttpServletRequest request, ModelMap model) throws Exception {
		
		String bizName = "정비직원 근태등록 확인";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		try {
			
			boolean result = false;
			
			if(repairBikeVo.getAdminId() == null){

				userSessionVO = (UserSessionVO) EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
				
				repairBikeVo.setAdminId(userSessionVO.getUsrId());
				
			}
			
			RepairWorkVO wVo = new RepairWorkVO();
			wVo.setAdminId(repairBikeVo.getAdminId());
			String grpName = repairPerfService.getAdminGrpName(wVo);
			
			if("정비".equals(grpName) || "정비반장".equals(grpName)){
				
				wVo = repairWorkService.getMaintenWrkerAttD(wVo);
				
				if(wVo.getWorkSeq() != null){
					
					result = true;
					
				}else{
					
					result = false;
					
				}
				
			}else{
				
				result = true;
				
			}
			
			if(result){
				
				model.addAttribute(RESULT_MESSAGE, "Success");
				model.addAttribute(CHECK_RESULT, 0);
				
			}else{
				
				model.addAttribute(RESULT_MESSAGE, "Fail");
				model.addAttribute(CHECK_RESULT, -1);
				
			}
			
			return JSONVIEW;
		} catch (Exception e) {
			throw new CfoodException("admin.system.maintenance.getCheckMntncAdminAjax" , e.getMessage());
		}
	}
	
	@RequestMapping(value = "/getRepairCmptDttmAjax.do")
	@RequestName(value="getRepairCmptDttmAjax")
	public String getRepairCmptDttmAjax(@ModelAttribute RepairBikeVO repairBikeVo, HttpServletRequest request, ModelMap model) throws Exception {
		
		String bizName = "해당 자전거 최근 수리완료 시간 조회";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		try {
			
			String lastDttm = repairBikeService.getRepairCmptDttm(repairBikeVo);
			
			model.addAttribute("lastDttm", lastDttm);
			model.addAttribute(RESULT_MESSAGE, "Success");
			model.addAttribute(CHECK_RESULT, 0);
			return JSONVIEW;
		} catch (Exception e) {
			throw new CfoodException("admin.system.maintenance.getRepairCmptDttmAjax" , e.getMessage());
		}
	}
	
	@RequestMapping(value = "/getBikeEntrsAjax.do")
	@RequestName(value="getBikeEntrsAjax")
	public String getBikeEntrsAjax(@ModelAttribute RepairBikeVO repairBikeVo, HttpServletRequest request, ModelMap model) throws Exception {
		
		String bizName = "자전거 납품처 조회";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		try {
			
			String entrpsName = repairBikeService.getBikeEntrsName(repairBikeVo);
			
			model.addAttribute("entrpsName", entrpsName);
			model.addAttribute(RESULT_MESSAGE, "Success");
			model.addAttribute(CHECK_RESULT, 0);
			return JSONVIEW;
		} catch (Exception e) {
			throw new CfoodException("admin.system.maintenance.getBikeEntrsAjax" , e.getMessage());
		}
	}
	
	@RequestMapping(value = "/getAdminCenterIdAjax.do")
	@RequestName(value="getAdminCenterIdAjax")
	public String getAdminCenterIdAjax(@ModelAttribute RepairBikeVO repairBikeVo, HttpServletRequest request, ModelMap model) throws Exception {

		String bizName = "관리자 소속 사업소 아이디 조회";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        
        try {
			
			String centerId = repairBikeService.getAdminCenterId(repairBikeVo);
			
			model.addAttribute("centerId", centerId);
			model.addAttribute(RESULT_MESSAGE, "Success");
			model.addAttribute(CHECK_RESULT, 0);
			return JSONVIEW;
		} catch (Exception e) {
			throw new CfoodException("admin.system.maintenance.updateRepairBikeAjax" , e.getMessage());
		}
	}
	
	@RequestMapping(value = "/updateRepairTermAjax.do", method = RequestMethod.POST)
	@RequestName(value="updateRepairTermAjax")
	public String updateRepairTermAjax(@ModelAttribute RepairTermVO repairTermVo, HttpServletRequest request, ModelMap model) throws Exception {
		
		String bizName = "개선 수리화면 단말기 수리저장";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		try {
			
			if( repairTermVo.getTermCenterId() == null || "".equals(repairTermVo.getTermCenterId())){//2020-10-15 : 가끔 centerId가 들어오지 않는 경우를 대비
				
				RepairBikeVO rVo = new RepairBikeVO();
				rVo.setAdminId(repairTermVo.getTermAdminId());
				
				String centerId = repairBikeService.getAdminCenterId(rVo);
				
				repairTermVo.setTermCenterId(centerId);
				
			}
			
			repairWorkService.updateRepairTerm(repairTermVo);
			
			model.addAttribute(RESULT_MESSAGE, "Success");
			model.addAttribute(CHECK_RESULT, 0);
			
			return JSONVIEW;
		} catch (Exception e) {
			throw new CfoodException("admin.system.maintenance.updateRepairTermAjax" , e.getMessage());
		}
	}
	
	@RequestMapping(value = "/insertRepairTermAjax.do", method = RequestMethod.POST)
	@RequestName(value="insertRepairTermAjax")
	public String insertRepairTermAjax(@ModelAttribute RepairTermVO repairTermVo, HttpServletRequest request, ModelMap model) throws Exception {
		
		String bizName = "개선 수리화면 단말기 수리등록";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		try {
			
			if( repairTermVo.getTermCenterId() == null || "".equals(repairTermVo.getTermCenterId()) ){//2020-10-15 : 가끔 centerId가 들어오지 않는 경우를 대비
				
				RepairBikeVO rVo = new RepairBikeVO();
				rVo.setAdminId(repairTermVo.getTermAdminId());
				
				String centerId = repairBikeService.getAdminCenterId(rVo);
				
				repairTermVo.setTermCenterId(centerId);
				
			}
			
			repairWorkService.insertRepairTerm(repairTermVo);
			
			String termSeq = "";
			if(repairTermVo.getTermSeq() != null) termSeq = repairTermVo.getTermSeq();
			
			model.addAttribute("termSeq",termSeq);
			model.addAttribute(RESULT_MESSAGE, "Success");
			model.addAttribute(CHECK_RESULT, 0);
			return JSONVIEW;
		} catch (Exception e) {
			throw new CfoodException("admin.system.maintenance.insertRepairTermAjax" , e.getMessage());
		}
	}
	
	
	@RequestMapping(value="/repairBikeMgmtList.do")
	@RequestName(value="getRepairBikeMgmtList")
	public String getRepairBikeMgmtList(@ModelAttribute @Valid RepairBikeVO repairBikeVo, BindingResult result, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		
		boolean bResult = false;
		String resultPage = RETURN_URL.concat("rep_bik_list_mgmt");
		String bizName = "자전거 수리관리 화면";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			
			UserSessionVO userSessionVO = (UserSessionVO) EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
			
			if("batReplExc".equals(repairBikeVo.getViewFlg())){
				
				List<RepairBikeVO> batReplaceList = repairBikeService.getBatReplaceList(repairBikeVo);
				model.addAttribute("batReplaceList",batReplaceList);
				
				resultPage = RETURN_URL.concat("bat_rep_list_excel");
				
			}else{
			
				if(repairBikeVo.getViewFlg().equals(MODE_EXCEL)){
					repairBikeVo.setPagingYn("N");
				}else{
					repairBikeVo.setPagingYn("Y");
				}
	
				int totCnt = repairBikeService.getRepairBikeListCount(repairBikeVo);
				PaginationInfo paginationInfo = getPagingInfo(repairBikeVo.getCurrentPageNo(), 10,10, totCnt);
				PaginationInfo paginationMobileInfo = getPagingMobileInfo(repairBikeVo.getCurrentPageNo(), 10,10, totCnt);
				
				repairBikeVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
				repairBikeVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
				List<RepairBikeVO> resultList = repairBikeService.getRepairBikeList(repairBikeVo);
						
				model.addAttribute("userSessionVO", userSessionVO);
				model.addAttribute("searchCondition", repairBikeVo);
				model.addAttribute("paginationInfo", paginationInfo);
				model.addAttribute("paginationMobileInfo", paginationMobileInfo);
				model.addAttribute("RepairBikeList", resultList);
				
				if(repairBikeVo.getViewFlg().equals(MODE_EXCEL)) {
					resultPage = RETURN_URL.concat("inv_sta_list_excel");
	    		}
			
			}
			bResult = true;		// 정상
			
		} catch (CfoodException ce) {
			throw new CfoodException("admin.repairMgmt.repairWork.rep_bik_list_mgmt" , ce.getMessage());
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestMapping(value = "/moveRepairBikeEditMgmtForm.do")
	@RequestName(value="moveRepairBikeEditMgmtForm")
	public String moveRepairBikeEditMgmtForm(@ModelAttribute RepairBikeVO repairBikeVo, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {

		String bizName = "자전거 수리 등록,수정 화면 이동";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        
        RepairBikeVO resultVo = null;
        RepairTermVO termVO = null;
		boolean result = false;
		try {
			
			
			if(repairBikeVo.getViewFlg().equals(CRUD_C)) {
				resultVo = new RepairBikeVO();
				resultVo.setBikeStatusComCd(repairBikeVo.getBikeStatusComCd());
				resultVo.setBikeStatusName(repairBikeVo.getBikeStatusName());
				
				termVO = new RepairTermVO();
			
			 // 2021-05-31 정비관리 팝업에서 Direct 연결	
			 } else	if(repairBikeVo.getViewFlg().equals("P")) {

					resultVo = new RepairBikeVO();
					resultVo.setBikeStatusComCd(repairBikeVo.getBikeStatusComCd());
					resultVo.setBikeStatusName(repairBikeVo.getBikeStatusName());
					//TODO
					resultVo.setBikeId(repairBikeVo.getBikeId());
					resultVo.setBikeNo(repairBikeVo.getDivisionValue());
					 
					repairBikeVo.setViewFlg("C");
					termVO = new RepairTermVO();
				 
			 } else {
				
				resultVo = repairBikeService.getRepairBikeInfo(repairBikeVo);
				resultVo.setRepairCodeList(repairBikeService.getRepairCodeList(resultVo.getRepairSeq()));

				termVO = repairWorkService.getRepairTermInfo(resultVo.getRepairSeq());
			}
			model.addAttribute("repairBikeInfo"        , resultVo);
			model.addAttribute("repairBike"          , repairBikeVo);
			model.addAttribute("repairTermInfo"        , termVO);
			result = true;
		} catch (Exception e) {
			throw new CfoodException("admin.repairMgmt.repairWork.rep_bik_detail_mgmt" , e.getMessage());
		}
		
		return result ? RETURN_URL.concat("rep_bik_detail_mgmt") : ERROR_PAGE;
	}
}
