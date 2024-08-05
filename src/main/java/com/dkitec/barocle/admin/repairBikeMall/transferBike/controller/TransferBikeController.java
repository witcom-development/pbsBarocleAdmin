package com.dkitec.barocle.admin.repairBikeMall.transferBike.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.json.JSONArray;
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
import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.admin.login.vo.UserSessionVO;
import com.dkitec.barocle.admin.maintenance.repair.bike.vo.RepairPartsVO;
import com.dkitec.barocle.admin.repairBikeMall.transferBike.service.TransferBikeService;
import com.dkitec.barocle.admin.repairBikeMall.transferBike.vo.TransferBikeVo;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.HttpUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="TransferBikeController")
public class TransferBikeController extends BaseController {
	protected static Logger log = LoggerFactory.getLogger(TransferBikeController.class);
	
	@Resource(name="transferBikeService") private TransferBikeService transferBikeService;
	
	@RequestMapping(value="/transRepairBikeMallList.do")
	@RequestName(value="transRepairBikeMallList")
	public String transRepairBikeMallList(@ModelAttribute @Valid TransferBikeVo transferBikeVo, BindingResult result, HttpServletRequest request, Model model) throws Exception{
		boolean bResult = true;
		String resultPage = "/admin/repairBikeMall/transferBike/trans_bik_mall_list";
		String bizName = "바로클포 수리요청 등록현황 화면";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
            if(userSessionVO == null){
            	throw new CfoodException(getMessage("error.invalidSession"));
            }
            
            // 점주 계정 로그인 시 본인 내역만 확인 할 수 있도록 설정
            if(userSessionVO.getUsrGrpCd() == "21"){
            	transferBikeVo.setAdminId(userSessionVO.getUsrId());
            }
            
			int totCnt = transferBikeService.getTransferBikeListCount(transferBikeVo);
			PaginationInfo paginationInfo = getPagingInfo(transferBikeVo.getCurrentPageNo(), 15, 15, totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(transferBikeVo.getCurrentPageNo(), 15, 15, totCnt);
			
			transferBikeVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			transferBikeVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<TransferBikeVo> resultList = transferBikeService.getTransferBikeList(transferBikeVo);
			List<TransferBikeVo> bikeMallList = transferBikeService.getBikeMallList(transferBikeVo);
			
			
			model.addAttribute("searchCondition", transferBikeVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("RepairBikeList", resultList);
			model.addAttribute("bikeMallList", bikeMallList);
			model.addAttribute("searchUser", userSessionVO);
			//model.addAttribute("bikeMallAdmin", userSessionVO);
			
		} catch (CfoodException ce) {
			throw new CfoodException("admin.repairBikeMall.transferBike.trans_bik_mall_list", ce.getMessage());
		}
		
		return bResult? resultPage : ERROR_PAGE;
	}
	
	@RequestMapping(value = "/moveTransferBikeEditForm.do")
	@RequestName(value="moveTransferBikeEditForm")
	public String moveTransferBikeEditForm(@ModelAttribute TransferBikeVo transferBikeVo, HttpServletRequest request, ModelMap model) throws Exception {

		String bizName = "바로클포 수리요청 등록 화면 이동";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		String resultPage = "/admin/repairBikeMall/transferBike/trans_bik_mall_detail";
        TransferBikeVo resultVo = null;
        List<TransferBikeVo> resultList = null;
		boolean result = false;
		
		UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
        if(userSessionVO == null){
        	throw new CfoodException(getMessage("error.invalidSession"));
        }
        
		try {
			if(transferBikeVo.getViewFlg().equals("U")){	// 수정화면으로 이동해야 할 경우
				// 상단 점포 정보
				resultVo = transferBikeService.getTransferBikeInfo(transferBikeVo);
				// 수리부위 정보 목록
				resultList = transferBikeService.getTransferBikeDetail(transferBikeVo);
				model.addAttribute("mallInfoView", resultVo);
				model.addAttribute("repairBikeList", resultList);
			}
			// 점포 목록 가져오기
			List<TransferBikeVo> mallList = transferBikeService.getBikeMallList(transferBikeVo);
			model.addAttribute("transferInfo", transferBikeVo);
			model.addAttribute("transferUserInfo", userSessionVO);
			model.addAttribute("transferMall", mallList);
			result = true;
			
		} catch (Exception e) {
			throw new CfoodException("admin.repairBikeMall.transferBike.trans_bik_mall_detail", e.getMessage());
		}
		
		return result ? resultPage : ERROR_PAGE;
	}
	
	@RequestMapping(value="/checkTransferBikeList.do")
	@RequestName(value="checkTransferBikeList")
	public String checkTransferBikeList(@ModelAttribute @Valid TransferBikeVo transferBikeVo, BindingResult result, HttpServletRequest request, Model model) throws Exception{
		boolean bResult = true;
		String resultPage = "/admin/repairBikeMall/checkTransfer/chk_trans_bik_list";
		String bizName = "바로클포 수리요청 현황조회 화면";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
            if(userSessionVO == null){
            	throw new CfoodException(getMessage("error.invalidSession"));
            }
            
            // 점주 계정 로그인 시 본인 내역만 확인 할 수 있도록 설정
            if(userSessionVO.getUsrGrpCd().equals("21")){
            	transferBikeVo.setTakeId(userSessionVO.getUsrId());
            }
            
			transferBikeVo.setPageYn("Y");
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			
			if(transferBikeVo.getSearchBgnDe() == null && transferBikeVo.getSearchEndDe() == null){
				transferBikeVo.setSearchEndDe(sdf.format(cal.getTime()));
				cal.add(Calendar.DAY_OF_MONTH, -30);
				transferBikeVo.setSearchBgnDe(sdf.format(cal.getTime()));
			}
			int totCnt = transferBikeService.getCheckTransferListCount(transferBikeVo);

			PaginationInfo paginationInfo = getPagingInfo(transferBikeVo.getCurrentPageNo(), 15, 15, totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(transferBikeVo.getCurrentPageNo(), 15, 15, totCnt);
			//PaginationInfo paginationInfo = getPagingInfo(transferBikeVo.getCurrentPageNo(), totCnt);
			//PaginationInfo paginationMobileInfo = getPagingMobileInfo(transferBikeVo.getCurrentPageNo(), totCnt);
			
			transferBikeVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			transferBikeVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<TransferBikeVo> resultList = transferBikeService.getCheckTransferList(transferBikeVo);
			List<TransferBikeVo> bikeMallList = transferBikeService.getBikeMallList(transferBikeVo);
			
			model.addAttribute("searchCondition", transferBikeVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("TransferBikeList", resultList);
			model.addAttribute("bikeMallList", bikeMallList);
			model.addAttribute("bikeMallAdmin", userSessionVO);
			
		} catch (CfoodException ce) {
			throw new CfoodException("admin.repairBikeMall.transferBike.chk_trans_bik_list", ce.getMessage());
		}
		
		return bResult? resultPage : ERROR_PAGE;
	}
	
	@RequestMapping(value="/checkTransferBikeAjax.do")
	@RequestName(value="checkTransferBikeAjax")
	public String checkTransferBikeAjax(@ModelAttribute TransferBikeVo transferBikeVo, HttpServletRequest request, ModelMap model) throws Exception{
		
		String bizName = "바로클포 인수(인계)확인";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		try {
			UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
            if(userSessionVO == null){
            	throw new CfoodException(getMessage("error.invalidSession"));
            }else{
            	transferBikeVo.setTransId(userSessionVO.getUsrId());
            }
            transferBikeService.updateTransferYn(transferBikeVo);
			model.addAttribute(RESULT_MESSAGE, "Success");
			model.addAttribute(CHECK_RESULT, 0);
		} catch (Exception e) {
			throw new CfoodException("admin.repairBikeMall.transferBike.checkTransferBike", e.getMessage());
		}
		
		return JSONVIEW;
	}
	
	/**
	 * @param transferBikeVo
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/addTransferBikeAjax.do")
	@RequestName(value="addTransferBikeAjax")
	public String addTransferBikeAjax(@ModelAttribute TransferBikeVo transferBikeVo, HttpServletRequest request, ModelMap model) throws Exception{
		
		String bizName = "바로클포 등록";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		String resultSeq = "";
		
		try {
			UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
            if(userSessionVO == null){
            	throw new CfoodException(getMessage("error.invalidSession"));
            }else{
            	transferBikeVo.setAdminId(userSessionVO.getUsrId());
            }
            
            // 할인율 임시 적용
            transferBikeVo.setDiscountRate("0.60");
            
            resultSeq = transferBikeService.addTransferBike(transferBikeVo);
            model.addAttribute("resultSeq", resultSeq);
			model.addAttribute(RESULT_MESSAGE, "Success");
			model.addAttribute(CHECK_RESULT, 0);
		} catch (Exception e) {
			throw new CfoodException("admin.repairBikeMall.transferBike.checkTransferBike", e.getMessage());
		}
		
		return JSONVIEW;
	}
	
	// 점포명-지역구별 센터 
	@RequestMapping(value="/addTransferBikeMallAjax.do")
	@RequestName(value="addTransferBikeMallAjax")
	public String addTraBikeAjax(@ModelAttribute TransferBikeVo transferBikeVo, HttpServletRequest request, ModelMap model) throws Exception{
		
		String bizName = "바로클포 지역구별 센터 선택";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		try {
			UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
            if(userSessionVO == null){
            	throw new CfoodException(getMessage("error.invalidSession"));
            }else{
            	transferBikeVo.setAdminId(userSessionVO.getUsrId());
            }
            
            List<TransferBikeVo> bikeMallList = transferBikeService.getBikeMallList(transferBikeVo);
            model.addAttribute("bikeMallList", bikeMallList);
			
            model.addAttribute(RESULT_MESSAGE, "Success");
			model.addAttribute(CHECK_RESULT, 0);
			
		} catch (Exception e) {
			throw new CfoodException("admin.repairBikeMall.transferBike.checkTransferBike", e.getMessage());
		}
		
		return JSONVIEW;
	}
	
	@RequestMapping(value = "/exeTransferBikeExcel.do")
	@RequestName(value="exeTransferBikeExcel")
	public String exeTransferBikeExcel(@ModelAttribute TransferBikeVo transferBikeVo, BindingResult bResult ,HttpServletRequest request, ModelMap model) throws Exception {
		String bizName = "자전거 수리요청 인수인계증 출력";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		String resultPage = "/admin/repairBikeMall/transferBike/trans_bik_mall_excel";
		boolean result = true;

		List<TransferBikeVo> resultList = null;
		TransferBikeVo transInfo = null;
		
		try {
			UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
            if(userSessionVO == null){
            	throw new CfoodException(getMessage("error.invalidSession"));
            }else{
            	transInfo = transferBikeService.getTransInfo(transferBikeVo);
            	transInfo.setAdminId(userSessionVO.getUsrName());
            }
            resultList = transferBikeService.getTransferBikeListExcel(transferBikeVo);
            
		} catch (Exception e) {
			throw new CfoodException("admin.repairBikeMall.transferBike.checkTransferBike", e.getMessage());
		}
		
		model.addAttribute("userSessionVO", userSessionVO);
		model.addAttribute("TransferBikeVo", transInfo);
		model.addAttribute("TransBikeList", resultList);
		
		return result? resultPage : ERROR_PAGE;
	}

	@RequestMapping(value = "/moveBrokenParts.do")
	@RequestName(value="moveBrokenParts")
	public String moveBrokenParts(@ModelAttribute TransferBikeVo transferBikeVo, BindingResult bResult ,HttpServletRequest request, ModelMap model) throws Exception {
		String bizName = "자전거 고장 내용 팝업";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		String targetUrl = "/admin/common/popup/pop_broken_view";
		boolean result = false;
		List<TransferBikeVo> selectList = null;
		
		try {
			selectList = transferBikeService.getBrokenInfo(transferBikeVo);
            
            List<TransferBikeVo> resultList = new ArrayList<>();
            List<TransferBikeVo> codeList = new ArrayList<>();
            for( TransferBikeVo vo :  selectList ) {
            	
            	if ("Y".equals(vo.getChkYn()) ) {
            		resultList.add(vo);
            	} else {
            		codeList.add(vo);
            	}
            	// 2021 05 13 추가
            	if ("Y".equals(vo.getRepairYn())) {
            		transferBikeVo.setRepairYn("Y");
            		transferBikeVo.setRepairDttm( vo.getRepairDttm() );
            	}
            }
            
            model.addAttribute("brokenInfo", transferBikeVo);
    		model.addAttribute("brokenList", resultList);
    		model.addAttribute("codeList"  , codeList);
    		
            result = true;
		} catch (Exception e) {
			throw new CfoodException(getMessage("fail.common.msg"), e.getMessage());
		}
		
		return result? targetUrl : ERROR_PAGE;
	}
	
	@RequestMapping(value = "/updateBrokenPartsAjax.do")
	@RequestName(value="updateBrokenPartsAjax")
	public String updateBrokenPartsAjax(@ModelAttribute TransferBikeVo transferBikeVo, HttpServletRequest request, ModelMap model) throws Exception{
		String bizName = "바로클포 고장부위 수정";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		try {
			UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
            if(userSessionVO == null){
            	throw new CfoodException(getMessage("error.invalidSession"));
            }else{
            	transferBikeVo.setAdminId(userSessionVO.getUsrId());
            }
            
            // 할인율 임시 적용
            transferBikeVo.setDiscountRate("0.60");
            
            transferBikeService.updateBrokenInfo(transferBikeVo);
			model.addAttribute(RESULT_MESSAGE, "Success");
			model.addAttribute(CHECK_RESULT, 0);
		} catch (Exception e) {
			throw new CfoodException("admin.repairBikeMall.manageMall.exeBrokenPartAjax", e.getMessage());
		}
		
		return JSONVIEW;
	}
	
	@RequestMapping(value="/checkRepairBikeList.do")
	@RequestName(value="checkRepairBikeList")
	public String checkRepairBikeList(@ModelAttribute @Valid TransferBikeVo transferBikeVo, BindingResult result, HttpServletRequest request, Model model) throws Exception{
		boolean bResult = true;
		String resultPage = "/admin/repairBikeMall/checkTransfer/chk_repair_bik_list";
		String bizName = "바로클포 자전거 검수현황 화면";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			
			int totCnt = transferBikeService.getCheckRepairBikeListCount(transferBikeVo);
			PaginationInfo paginationInfo = getPagingInfo(transferBikeVo.getCurrentPageNo(), 15, 15, totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(transferBikeVo.getCurrentPageNo(), 15, 15, totCnt);
			
			transferBikeVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			transferBikeVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<TransferBikeVo> resultList = transferBikeService.getCheckRepairBikeList(transferBikeVo);
			List<TransferBikeVo> bikeMallList = transferBikeService.getBikeMallList(transferBikeVo);
			
			model.addAttribute("searchCondition", transferBikeVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("RepairBikeList", resultList);
			model.addAttribute("bikeMallList", bikeMallList);
			
		} catch (CfoodException ce) {
			throw new CfoodException("admin.repairBikeMall.transferBike.chk_repair_bik_list", ce.getMessage());
		}
		
		return bResult? resultPage : ERROR_PAGE;
	}
	
	@RequestMapping(value="/checkRepairBikeAjax.do")
	@RequestName(value="checkRepairBikeAjax")
	public String checkRepairBikeAjax(@ModelAttribute TransferBikeVo transferBikeVo, HttpServletRequest request, ModelMap model) throws Exception{
		
		String bizName = "바로클포 검수확인";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		try {
			UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
            if(userSessionVO == null){
            	throw new CfoodException(getMessage("error.invalidSession"));
            }else{
            	transferBikeVo.setTransId(userSessionVO.getUsrId());
            }
            transferBikeService.updateCollectYn(transferBikeVo);
			model.addAttribute(RESULT_MESSAGE, "Success");
			model.addAttribute(CHECK_RESULT, 0);
		} catch (Exception e) {
			throw new CfoodException("admin.repairBikeMall.transferBike.checkRepairBike", e.getMessage());
		}
		
		return JSONVIEW;
	}
	
	@RequestMapping(value="/validationTransferBikeAjax.do")
	@RequestName(value="validationTransferBikeAjax")
	public String validationTransferBikeAjax(@ModelAttribute TransferBikeVo transferBikeVo, HttpServletRequest request, ModelMap model) throws Exception{
		
		String bizName = "바로클포 자전거 번호 검증";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		int result = 0;
		
		try {
			UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
            if(userSessionVO == null){
            	throw new CfoodException(getMessage("error.invalidSession"));
            }else{
            	transferBikeVo.setAdminId(userSessionVO.getUsrId());
            }
            
            result = transferBikeService.validationTransferBike(transferBikeVo);
            model.addAttribute("result", result);
			model.addAttribute(RESULT_MESSAGE, "Success");
			model.addAttribute(CHECK_RESULT, 0);
		} catch (Exception e) {
			throw new CfoodException("admin.repairBikeMall.transferBike.checkTransferBike", e.getMessage());
		}
		
		return JSONVIEW;
	}
}
