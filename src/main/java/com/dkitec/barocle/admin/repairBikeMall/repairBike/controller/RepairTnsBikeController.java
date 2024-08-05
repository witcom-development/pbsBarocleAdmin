package com.dkitec.barocle.admin.repairBikeMall.repairBike.controller;

import java.util.ArrayList;
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
import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.admin.login.vo.UserSessionVO;
import com.dkitec.barocle.admin.repairBikeMall.repairBike.service.RepairTnsBikeService;
import com.dkitec.barocle.admin.repairBikeMall.repairBike.vo.RepairTnsBikeVo;
import com.dkitec.barocle.admin.repairBikeMall.transferBike.controller.TransferBikeController;
import com.dkitec.barocle.admin.repairBikeMall.transferBike.service.TransferBikeService;
import com.dkitec.barocle.admin.repairBikeMall.transferBike.vo.TransferBikeVo;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.sms.SmsSender;
import com.dkitec.barocle.util.sms.vo.SmsMessageVO;
import com.dkitec.barocle.util.webutil.HttpUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="RepairTnsBikeController")
public class RepairTnsBikeController extends BaseController {
	protected static Logger log = LoggerFactory.getLogger(TransferBikeController.class);
	
	@Resource(name="repairTnsBikeService") private RepairTnsBikeService repairTnsBikeService;
	@Resource(name="transferBikeService") private TransferBikeService transferBikeService;
	
	@RequestMapping(value="/transRepairBikeList.do")
	@RequestName(value="transRepairBikeList")
	public String transRepairBikeList(@ModelAttribute @Valid TransferBikeVo transferBikeVo, BindingResult result, HttpServletRequest request, Model model) throws Exception{
		boolean bResult = true;
		String resultPage = "/admin/repairBikeMall/repairBike/repair_bik_mall_list";
		String bizName = "바로클포 수리내역증빙 목록 화면";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
            if(userSessionVO == null){
            	throw new CfoodException(getMessage("error.invalidSession"));
            }
            
            // 점주 계정 로그인 시 본인 내역만 확인 할 수 있도록 설정
            if(userSessionVO.getUsrGrpCd().equals("21")){
            	transferBikeVo.setAdminId(userSessionVO.getUsrId());
            }
			
			int totCnt = repairTnsBikeService.getRepairTnsBikeListCount(transferBikeVo);
			PaginationInfo paginationInfo = getPagingInfo(transferBikeVo.getCurrentPageNo(), 15, 15, totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(transferBikeVo.getCurrentPageNo(), 15, 15, totCnt);
			
			transferBikeVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			transferBikeVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<TransferBikeVo> resultList = repairTnsBikeService.getRepairTnsBikeList(transferBikeVo);
			List<TransferBikeVo> bikeMallList = transferBikeService.getBikeMallList(transferBikeVo);
			
			// 금일, 금월 수리완료된 건 조회
			transferBikeVo.setFlag("D");
			int todayRepair = repairTnsBikeService.getRepairBikeCount(transferBikeVo);
			transferBikeVo.setFlag("M");
			int monthRepair = repairTnsBikeService.getRepairBikeCount(transferBikeVo);
			//
			
			model.addAttribute("todayRepairCnt", todayRepair);
			model.addAttribute("monthRepairCnt", monthRepair);
			model.addAttribute("searchCondition", transferBikeVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("RepairBikeList", resultList);
			model.addAttribute("bikeMallList", bikeMallList);
			model.addAttribute("bikeMallAdmin", userSessionVO);
			
		} catch (CfoodException ce) {
			throw new CfoodException("admin.repairBikeMall.repairBike.repair_bik_mall_list", ce.getMessage());
		}
		
		return bResult? resultPage : ERROR_PAGE;
	}
	
	@RequestMapping(value="/updateRepairTnsBikeAjax.do")
	@RequestName(value="updateRepairTnsBikeAjax")
	public String updateRepairTnsBikeAjax(@ModelAttribute TransferBikeVo transferBikeVo, HttpServletRequest request, ModelMap model) throws Exception{
		
		String bizName = "바로클포 수리완료 처리";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		try {
			repairTnsBikeService.updateRepairTnsBikeYn(transferBikeVo);
			model.addAttribute(RESULT_MESSAGE, "Success");
			model.addAttribute(CHECK_RESULT, 0);
		} catch (Exception e) {
			throw new CfoodException("admin.repairBikeMall.repairBike.updateRepairTnsBike", e.getMessage());
		}
		
		return JSONVIEW;
	}
	
	@RequestMapping(value="/bikeMallReport.do")
	@RequestName(value="bikeMallReport")
	public String bikeMallReport(@ModelAttribute @Valid RepairTnsBikeVo repairTnsBikeVo, BindingResult result, HttpServletRequest request, Model model) throws Exception{
		boolean bResult = true;
		String resultPage = "/admin/repairBikeMall/repairBike/bik_mall_rep_list";
		String bizName = "바로클포 점포별 월 정비 보고서 목록 화면";
		HttpUtil.printServiceLogStart(bizName, log, request);
		TransferBikeVo transferBikeVo = null;
		
		try{
			UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
            if(userSessionVO == null){
            	throw new CfoodException(getMessage("error.invalidSession"));
            }
            
            // 점주 계정 로그인 시 본인 내역만 확인 할 수 있도록 설정
            if(userSessionVO.getUsrGrpCd().equals("21")){
            	repairTnsBikeVo.setAdminId(userSessionVO.getUsrId());
            } else if(userSessionVO.getUsrGrpCd().equals("3")){ 
            	repairTnsBikeVo.setAdminId(null);
            } else { 
            	repairTnsBikeVo.setAdminId(null);
            }
            
			int totCnt = repairTnsBikeService.getbikeMallReportListCount(repairTnsBikeVo);
			
			PaginationInfo paginationInfo = getPagingInfo(repairTnsBikeVo.getCurrentPageNo(), 10, 10, totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(repairTnsBikeVo.getCurrentPageNo(), 10, 10, totCnt);
			
			repairTnsBikeVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			repairTnsBikeVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<RepairTnsBikeVo> resultList = repairTnsBikeService.getbikeMallReportList(repairTnsBikeVo);
			List<TransferBikeVo> bikeMallList = transferBikeService.getBikeMallList(transferBikeVo);
			
			model.addAttribute("searchCondition", repairTnsBikeVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("ReportMallList", resultList);
			model.addAttribute("bikeMallList", bikeMallList);
			model.addAttribute("bikeMallAdmin", userSessionVO);
			
		} catch (CfoodException ce) {
			throw new CfoodException("admin.repairBikeMall.repairBike.bik_mall_rep_list", ce.getMessage());
		}
		
		return bResult? resultPage : ERROR_PAGE;
	}
	
	@RequestMapping(value="/sendPickUpMessage.do")
	@RequestName(value="sendPickUpMessage")
	public String sendPickUpMessage(@ModelAttribute RepairTnsBikeVo repairTnsBikeVo, HttpServletRequest request, ModelMap model) throws Exception{
		
		String bizName = "바로클포 자전거 회수요청";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		List<SmsMessageVO> smsInfo = new ArrayList<SmsMessageVO>();
		List<SmsMessageVO> smsMsgList = new ArrayList<SmsMessageVO>();
		SmsMessageVO smsMsgVo = null;
		boolean result = false;
		
		try {
			UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
            if(userSessionVO == null){
            	throw new CfoodException(getMessage("error.invalidSession"));
            }
            
			// 문자 받을 관리자 정보 가져오기 ++ 자치구 구분으로 강북/강남 담당자 구분
//            Integer gu = Integer.parseInt(repairTnsBikeVo.getDistrictCd());
//            if(gu < 15){	// 강북 담당자
//            	repairTnsBikeVo.setAdminId("ppampu");
//            	smsInfo = repairTnsBikeService.getAdminPhoneNoList(repairTnsBikeVo);
//            }else{			// 강남 담당자
//            	repairTnsBikeVo.setAdminId("lkic1118");
//            	smsInfo = repairTnsBikeService.getAdminPhoneNoList(repairTnsBikeVo);
//            }
            
            String phoneNumber ="";
            
            switch( repairTnsBikeVo.getDistrictCd() ) {
             
            case "GUG_016"	:		// 강서구
            case "GUG_015"	:		// 양천구
            	phoneNumber = "010-4169-0182";
            break;
            
            case "GUG_017" :		// 구로구
            case "GUG_018" :		// 금천구
            	phoneNumber = "010-4187-0182";
            break; 
            case "GUG_019" :		// 영등포구
            	phoneNumber = "010-9157-2290";
            break;
            case "GUG_021" :		// 관악
            case "GUG_022" :		// 서초구
            case "GUG_027" :		// 강남구
            	phoneNumber = "010-9465-0182";
            break;
             
            case "GUG_024" :		// 송파
            case "GUG_025" :		// 강동
            	phoneNumber = "010-9025-9614";
            break;
            
            case "GUG_026" :		// 강북
            case "GUG_011" :		// 노원
            case "GUG_010" :		// 도봉
            	phoneNumber = "010-9408-0182";
            break;
            
            case "GUG_013" :		// 서대문
            	phoneNumber = "010-2060-1277";
            break;     
            case "GUG_008" :		// 성북
            case "GUG_003" :		// 용산
            	phoneNumber = "010-7122-8431";
            break;             
            
            case "GUG_014" :		// 마포
            case "GUG_012" :		// 은평
            	phoneNumber = "010-2060-1277";
            break; 
            
            case "GUG_005" :		// 광진
            case "GUG_006" :		// 동대문
            	phoneNumber = "010-9301-0182";
            break; 
            
            case "GUG_004" :		// 성동
            	phoneNumber = "010-7122-8431";
            break; 
            case "GUG_007" :		// 중랑
            	phoneNumber = "010-9301-0182";
            break; 
 
            
            }
            
           
            smsMsgVo = new SmsMessageVO();
			smsMsgVo.setDestno(phoneNumber);
			smsMsgVo.setMsg(repairTnsBikeVo.getMsg());
			smsMsgVo.setSenderId(userSessionVO.getUsrId());
			smsMsgList.add(smsMsgVo);
			
			//sms 전송 테이블 insert
			SmsSender.sender(smsMsgList);
			
			//sms history 테이블 이력
			SmsSender.senderHistory(smsMsgList);
			
			model.addAttribute(RESULT_MESSAGE, "Success");
			result = true;
		 
			
		} catch (Exception e) {
			throw new CfoodException("admin.repairBikeMall.repairBike.updateRepairTnsBike", e.getMessage());
		}
		model.addAttribute(CHECK_RESULT, result);
		
		return JSONVIEW;
	}

}
