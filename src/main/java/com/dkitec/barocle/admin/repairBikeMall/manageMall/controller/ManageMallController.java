package com.dkitec.barocle.admin.repairBikeMall.manageMall.controller;

import java.util.ArrayList;
import java.util.Calendar;
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
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.admin.login.vo.UserSessionVO;
import com.dkitec.barocle.admin.manage.center.service.CenterService;
import com.dkitec.barocle.admin.manage.center.vo.CenterVO;
import com.dkitec.barocle.admin.manage.center.vo.CenterVO.CenterEditVal;
import com.dkitec.barocle.admin.manage.center.vo.CenterVO.CenterListVal;
import com.dkitec.barocle.admin.repairBikeMall.manageMall.service.ManageMallService;
import com.dkitec.barocle.admin.repairBikeMall.manageMall.vo.ManageMallVo;
import com.dkitec.barocle.admin.repairBikeMall.transferBike.service.TransferBikeService;
import com.dkitec.barocle.admin.repairBikeMall.transferBike.vo.TransferBikeVo;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.sms.SmsSender;
import com.dkitec.barocle.util.sms.vo.SmsMessageVO;
import com.dkitec.barocle.util.webutil.HttpUtil;
import com.dkitec.barocle.util.webutil.StringUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="ManageMallController")
public class ManageMallController  extends BaseController {

	@Resource(name="transferBikeService") private TransferBikeService transferBikeService;
	@Resource(name = "centerService") private CenterService centerService;
	@Resource(name = "manageMallService") private ManageMallService manageMallService;
	
	protected static Logger log = LoggerFactory.getLogger(ManageMallController.class);
	private final String[] centerSearchParameter = {"","searchValue"};
	
	@RequestName(value="getManageBikeMallList")
	@RequestMapping(value="/getManageBikeMallList.do")
	public String getManageBikeMallList(@Validated(CenterListVal.class) CenterVO centerVO, BindingResult result, HttpServletRequest request, Model model) {
		/* Validator error */
		if(result.hasErrors()){
			model.addAttribute("centerView",centerVO);
			model.addAttribute("resultError",super.setResultMessage(result));
			return "/admin/repairBikeMall/manageMall/opr_cen_list";
		}
		
		boolean bResult = false;
		String resultPage = "/admin/repairBikeMall/manageMall/opr_cen_list";
		
		try{
			// 센터구분이 없을 경우 바로클포만 조회해서 가져오도록 한다.
			if(centerVO.getCenterClsCD() == null || centerVO.getCenterClsCD() == "")
				centerVO.setCenterClsCD("CEN_003");
			// 총 레코드 개수를 가져온다.
			centerVO.setTotalRecordCount(centerService.listCenterCount(centerVO));
			// 페이징
			PaginationInfo paginationInfo = getPagingInfo(centerVO.getCurrentPageNo(), centerVO.getTotalRecordCount());
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(centerVO.getCurrentPageNo(), centerVO.getTotalRecordCount());
			centerVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			centerVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			// 현재 화면의 정보를 지정한다.
			model.addAttribute("centerView",centerVO);
			// 현재 화면에 표시되는 레코드 목록을 가져온다.
			model.addAttribute("centerList", centerService.listCenter(centerVO));
			// 현재 화면의 검색 파라미터 값을 지정한다.
			model.addAttribute("parameterInfo",super.setGivenParameterValue(request,this.centerSearchParameter));
			// 현재 화면에 표시되는 페이징 점보를 리턴한다.
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo",paginationMobileInfo);
			
			bResult = true;		// 정상
		} catch (Exception e) {
			throw new CfoodException("admin.manage.center.centerList",e.getMessage());
		}
			
		return bResult ? resultPage : ERROR_PAGE;
		
	}
	
	@RequestName(value="editBikeMall")
	@RequestMapping(value="/editBikeMall.do")
	public String editBikeMall(@Validated(CenterEditVal.class) CenterVO centerVO, BindingResult result, HttpServletRequest request, Model model) {
		
		/* Validator error */
		if(result.hasErrors()){ throw new CfoodException("admin.manage.center.centerEdit.validator"); }
		
		boolean bResult = false;
		String resultPage = "/admin/repairBikeMall/manageMall/opr_cen_detail";
		
		try{
			CenterVO returnVO = null;
			if(!StringUtil.isEmpty(centerVO.getCenterID())){	//* centerSeq>0 ? edit | write
				returnVO = (CenterVO)centerService.viewCenter(centerVO);
				// ST : 전화번호 분리
				if(!StringUtil.isEmpty(returnVO.getCenterTelNO())){
					String[] centerTelNO = (returnVO.getCenterTelNO()).split("-");
					if(!StringUtil.isEmpty(centerTelNO)&&centerTelNO.length>=3){
						returnVO.setCenterTelNO1(centerTelNO[0]);
						returnVO.setCenterTelNO2(centerTelNO[1]);
						returnVO.setCenterTelNO3(centerTelNO[2]);
					}
				}
				// ED : 전화번호 분리
				// ST : 운영시간 분리
				String tempOprStrTime = returnVO.getOprStrTime();
				if(!StringUtil.isEmpty(tempOprStrTime)&&tempOprStrTime.length()>=5&&tempOprStrTime.indexOf(":")>-1){
					String[] oprStrTime = tempOprStrTime.split(":");
					returnVO.setOprStrTime1(oprStrTime[0]);
					returnVO.setOprStrTime2(oprStrTime[1]);
				}
				String tempOprEndTime = returnVO.getOprEndTime();
				if(!StringUtil.isEmpty(tempOprEndTime)&&tempOprEndTime.length()>=5&&tempOprEndTime.indexOf(":")>-1){
					String[] oprEndTime = tempOprEndTime.split(":");
					returnVO.setOprEndTime1(oprEndTime[0]);
					returnVO.setOprEndTime2(oprEndTime[1]);
				}
				// ED : 운영시간 분리
				returnVO.setMode("update");
			} else {
				returnVO = new CenterVO();
				returnVO.setMode("insert");
			}
			// 현재 화면를 가져온다.
			returnVO.setCurrentPageNo(centerVO.getCurrentPageNo());
			// 현재 화면의 검색 파라미터 값을 지정한다.
			model.addAttribute("parameterInfo",super.setGivenParameterValue(request,this.centerSearchParameter));
			model.addAttribute("centerView",returnVO);
						
			bResult = true;		// 정상
		} catch (Exception e) {
			throw new CfoodException("admin.manage.center.centerEdit",e.getMessage());
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestMapping(value="/repairPartPriceList.do")
	@RequestName(value="repairPartPriceList")
	public String repairPartPriceList(@ModelAttribute @Valid ManageMallVo manageMallVo, BindingResult result, HttpServletRequest request, Model model) throws Exception{
		boolean bResult = true;
		String resultPage = "/admin/repairBikeMall/repairPart/rep_part_list";
		String bizName = "바로클포 수리단가관리 목록 화면";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			
			int totCnt = manageMallService.getRepairPartPriceListCount(manageMallVo);
			PaginationInfo paginationInfo = getPagingInfo(manageMallVo.getCurrentPageNo(), 10, 10, totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(manageMallVo.getCurrentPageNo(), 10, 10, totCnt);
			
			manageMallVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			manageMallVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<ManageMallVo> resultList = manageMallService.getRepairPartPriceList(manageMallVo);
			
			model.addAttribute("searchCondition", manageMallVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("RepairPartList", resultList);
			
		} catch (CfoodException ce) {
			throw new CfoodException("admin.repairBikeMall.manageMall.rep_part_list",ce.getMessage());
		}
		
		return bResult? resultPage : ERROR_PAGE;
	}
	
	@RequestMapping(value="/movePartPriceEditForm.do", method = RequestMethod.POST)
	@RequestName("movePartPriceEditForm")
	public String movePartPriceEditForm (@ModelAttribute ManageMallVo manageMallVo,HttpServletRequest request,ModelMap model) throws Exception {
    	
    	String bizName = "바로클포 수리단가관리 등록 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        boolean result = false;
        String resultPage = "/admin/repairBikeMall/repairPart/rep_part_detail";
    	//String admin = userSessionVO == null ? "test" :userSessionVO.getUsrId();
        ManageMallVo reseultVo = null;
    	
        try {
        	if(manageMallVo.getViewFlg().equals(CRUD_U)) {
        		reseultVo = manageMallService.getRepairPartPriceDetl(manageMallVo);
        	}
        	model.addAttribute("partVo", manageMallVo);
    		model.addAttribute("partView", reseultVo);
        	result = true;
        }  catch(Exception e) {
        	throw new CfoodException(getMessage("fail.common.msg"),e.getMessage());
        }
        
    	return result ? resultPage : ERROR_PAGE;
	}
	
	@RequestMapping(value="/exePartPriceAjax.do")
	@RequestName(value="exePartPriceAjax")
	public String exePartPriceAjax(@ModelAttribute ManageMallVo manageMallVo, HttpServletRequest request, ModelMap model) throws Exception{
		String bizName = "바로클포 수리단가 관리 등록";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		try {
			if(manageMallVo.getViewFlg().equals(CRUD_C)){
				manageMallService.addPartPrice(manageMallVo);
			}else{
				manageMallService.updatePartPrice(manageMallVo);
			}			
			model.addAttribute(RESULT_MESSAGE, "Success");
			model.addAttribute(CHECK_RESULT, 0);
		} catch (Exception e) {
			throw new CfoodException("admin.repairBikeMall.manageMall.exePartPriceAjax",e.getMessage());
		}
		
		return JSONVIEW;
	}
	
	@RequestMapping(value="/bikeMallReportAdmin.do")
	@RequestName(value="bikeMallReportAdmin")
	public String bikeMallReportAdmin(@ModelAttribute @Valid ManageMallVo manageMallVo, BindingResult result, HttpServletRequest request, Model model) throws Exception{
		boolean bResult = true;
		String resultPage = "/admin/repairBikeMall/manageMall/bik_mall_rep_admin_list";
		String bizName = "바로클포  월 정비 보고서 목록 화면";
		HttpUtil.printServiceLogStart(bizName, log, request);
		TransferBikeVo transferBikeVo = null;
		
		try{
			int totCnt = manageMallService.getbikeMallReportListCount(manageMallVo);
			PaginationInfo paginationInfo = getPagingInfo(manageMallVo.getCurrentPageNo(), 10, 10, totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(manageMallVo.getCurrentPageNo(), 10, 10, totCnt);
			
			manageMallVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			manageMallVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<ManageMallVo> resultList = manageMallService.getbikeMallReportList(manageMallVo);
			//List<RepairTnsBikeVo> resultList = repairTnsBikeService.getbikeMallReportList(repairTnsBikeVo);
			List<TransferBikeVo> bikeMallList = transferBikeService.getBikeMallList(transferBikeVo);
			
			model.addAttribute("searchCondition", manageMallVo);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			model.addAttribute("ReportMallList", resultList);
			model.addAttribute("bikeMallList", bikeMallList);
			model.addAttribute("bikeMallAdmin", userSessionVO);
			
		} catch (CfoodException ce) {
			throw new CfoodException("admin.repairBikeMall.manageMall.bik_mall_rep_list",ce.getMessage());
		}
		
		return bResult? resultPage : ERROR_PAGE;
	}
	
	@RequestMapping(value="/sendRepMonthReport.do")
	@RequestName(value="sendRepMonthReport")
	public String sendRepMonthReport(@ModelAttribute ManageMallVo manageMallVo, HttpServletRequest request, ModelMap model) throws Exception{
		String bizName = "바로클포 월정비 내역 통보";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		List<SmsMessageVO> smsMsgList = new ArrayList<SmsMessageVO>();
		SmsMessageVO smsMsgVo = null;
		
		try {
			UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
            if(userSessionVO == null){
            	throw new CfoodException(getMessage("error.invalidSession"));
            }

			smsMsgVo = new SmsMessageVO();
			
            smsMsgVo.setSenderId(userSessionVO.getUsrId());
			smsMsgVo.setDestno(manageMallVo.getDestno());
			smsMsgVo.setMsg(manageMallVo.getMsg());
			
			smsMsgList.add(smsMsgVo);
			
			//sms 전송 테이블 insert
			SmsSender.sender(smsMsgList);

			//sms history 테이블 이력
			SmsSender.senderHistory(smsMsgList);
			
			// 수리내역 통보 이력 저장
			manageMallService.addRepMonthSmsHist(manageMallVo);
			
			model.addAttribute(RESULT_MESSAGE, "Success");
            
		} catch (Exception e) {
			throw new CfoodException("admin.repairBikeMall.manageMall.sendRepMonthReport", e.getMessage());
		}
		
		return JSONVIEW;
	}
	
	@RequestMapping(value="/bikeMallReportExcel.do")
	@RequestName(value="bikeMallReportExcel")
	public String bikeMallReportExcel(@ModelAttribute @Valid ManageMallVo manageMallVo, BindingResult result, HttpServletRequest request, Model model) throws Exception{
		boolean bResult = true;
		String resultPage = "/admin/repairBikeMall/manageMall/bik_mall_rep_list_excel";
		String bizName = "바로클포  월 정비 보고서 엑셀";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			ManageMallVo resultInfo = manageMallService.getbikeMallReportExcel(manageMallVo);
			
			
			
			
			model.addAttribute("searchCondition", manageMallVo);
			model.addAttribute("ReportMallList", resultInfo);
			
		} catch (CfoodException ce) {
			throw new CfoodException("admin.repairBikeMall.manageMall.bik_mall_rep_list", ce.getMessage());
		}
		
		return bResult? resultPage : ERROR_PAGE;
	}
	
	@RequestMapping(value="/bikeMallReportPDF.do")
	@RequestName(value="bikeMallReportExcel")
	public String bikeMallReportPDF(@ModelAttribute @Valid ManageMallVo manageMallVo, BindingResult result, HttpServletRequest request, Model model) throws Exception{
		boolean bResult = true;
		String bizName = "바로클포  월 정비 보고서 PDF";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			ManageMallVo resultInfo = manageMallService.getbikeMallReportExcel(manageMallVo);
			
			int tot = Integer.parseInt( resultInfo.getPrice_001().replace( ".00", "" )) +
					  Integer.parseInt( resultInfo.getPrice_002().replace( ".00", "" )) +
					  Integer.parseInt( resultInfo.getPrice_003().replace( ".00", "" )) +
					  Integer.parseInt( resultInfo.getPrice_004().replace( ".00", "" )) +
					  Integer.parseInt( resultInfo.getPrice_005().replace( ".00", "" )) +
					  Integer.parseInt( resultInfo.getPrice_006().replace( ".00", "" )) +
					  Integer.parseInt( resultInfo.getPrice_007().replace( ".00", "" )) +
					  Integer.parseInt( resultInfo.getPrice_008().replace( ".00", "" )) +
					  Integer.parseInt( resultInfo.getPrice_009().replace( ".00", "" )) +
					  Integer.parseInt( resultInfo.getPrice_010().replace( ".00", "" )) +
					  Integer.parseInt( resultInfo.getPrice_011().replace( ".00", "" )) +
					  Integer.parseInt( resultInfo.getPrice_012().replace( ".00", "" )) +
					  Integer.parseInt( resultInfo.getPrice_013().replace( ".00", "" )) +
					  Integer.parseInt( resultInfo.getPrice_014().replace( ".00", "" )) +
					  Integer.parseInt( resultInfo.getPrice_015().replace( ".00", "" )) +
					  Integer.parseInt( resultInfo.getPrice_016().replace( ".00", "" )) +
					  Integer.parseInt( resultInfo.getPrice_017().replace( ".00", "" )) +
					  Integer.parseInt( resultInfo.getPrice_018().replace( ".00", "" )) +
					  Integer.parseInt( resultInfo.getPrice_019().replace( ".00", "" )) +
					  Integer.parseInt( resultInfo.getPrice_020().replace( ".00", "" )) +
					  Integer.parseInt( resultInfo.getPrice_021().replace( ".00", "" )) +
					  Integer.parseInt( resultInfo.getPrice_022().replace( ".00", "" )) +
					  Integer.parseInt( resultInfo.getPrice_023().replace( ".00", "" )) +
					  Integer.parseInt( resultInfo.getPrice_024().replace( ".00", "" )) +
					  Integer.parseInt( resultInfo.getPrice_025().replace( ".00", "" )) +
					  Integer.parseInt( resultInfo.getPrice_026().replace( ".00", "" )) +
					  Integer.parseInt( resultInfo.getPrice_027().replace( ".00", "" )) +
					  Integer.parseInt( resultInfo.getPrice_028().replace( ".00", "" )) +
					  Integer.parseInt( resultInfo.getPrice_029().replace( ".00", "" )) +
					  Integer.parseInt( resultInfo.getPrice_030().replace( ".00", "" )) +
					  Integer.parseInt( resultInfo.getPrice_031().replace( ".00", "" )) +
					  Integer.parseInt( resultInfo.getPrice_032().replace( ".00", "" )) +
					  Integer.parseInt( resultInfo.getPrice_033().replace( ".00", "" )) +
					  Integer.parseInt( resultInfo.getPrice_034().replace( ".00", "" )) +
					  Integer.parseInt( resultInfo.getPrice_035().replace( ".00", "" )) +
					  Integer.parseInt( resultInfo.getPrice_036().replace( ".00", "" )) +
					  Integer.parseInt( resultInfo.getPrice_037().replace( ".00", "" )) +
					  Integer.parseInt( resultInfo.getPrice_038().replace( ".00", "" )) +
					  Integer.parseInt( resultInfo.getPrice_039().replace( ".00", "" )) +
					  Integer.parseInt( resultInfo.getPrice_040().replace( ".00", "" )) +
					  Integer.parseInt( resultInfo.getPrice_041().replace( ".00", "" ));
			
			resultInfo.setTotAmt(tot +"");
			
			model.addAttribute("searchCondition", manageMallVo);
			model.addAttribute("ReportMallList", resultInfo);
			
		} catch (CfoodException ce) {
			throw new CfoodException("admin.repairBikeMall.manageMall.bik_mall_rep_list", ce.getMessage());
		}
		
		return JSONVIEW;
	}
	
	@RequestMapping(value="/bikeMallReportBikeExcel.do")
	@RequestName(value="bikeMallReportExcel")
	public String bikeMallReportBikeExcel(@ModelAttribute @Valid ManageMallVo manageMallVo, BindingResult result, HttpServletRequest request, Model model) throws Exception{
		boolean bResult = true;
		String resultPage = "/admin/repairBikeMall/manageMall/bik_mall_rep_bike_list_excel_admin";
		String bizName = "바로클포  월 정비 보고서 엑셀";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			List<ManageMallVo> resultInfo = manageMallService.bikeMallReportBikeExcel(manageMallVo);
			
			model.addAttribute("statMonth", manageMallVo.getRepairMonth());
			model.addAttribute("searchCondition", manageMallVo);
			model.addAttribute("ReportMallList", resultInfo);
			
		} catch (CfoodException ce) {
			throw new CfoodException("admin.repairBikeMall.manageMall.bik_mall_rep_list", ce.getMessage());
		}
		
		return bResult? resultPage : ERROR_PAGE;
	}
	
	
	@RequestMapping(value="/bikeMallReportExcelAdmin.do")
	@RequestName(value="bikeMallReportExcelAdmin")
	public String bikeMallReportExcelAdmin(@ModelAttribute @Valid ManageMallVo manageMallVo, BindingResult result, HttpServletRequest request, Model model) throws Exception{
		boolean bResult = true;
		String resultPage = "/admin/repairBikeMall/manageMall/bik_mall_rep_list_excel_admin";
		String bizName = "바로클포  월 정비 보고서 엑셀";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			List<ManageMallVo> resultInfo = manageMallService.bikeMallReportExcelAdmin(manageMallVo);
			
			String statMonth = "";
			
			if ( manageMallVo.getSearchBgnDe() == "" || manageMallVo.getSearchBgnDe() == null ) {
				Calendar cal = Calendar.getInstance();
				int nowYear = cal.get(Calendar.YEAR);
				int nowMonth = cal.get(Calendar.MONTH) + 1;
				
				statMonth = nowYear + "-" + nowMonth;
			} else {
				statMonth = manageMallVo.getSearchBgnDe().substring(0,7);
			}
			
			model.addAttribute("statMonth", statMonth);
			model.addAttribute("searchCondition", manageMallVo);
			model.addAttribute("ReportMallList", resultInfo);
			
		} catch (CfoodException ce) {
			throw new CfoodException("admin.repairBikeMall.manageMall.bik_mall_rep_list_excel_admin", ce.getMessage());
		}
		
		return bResult? resultPage : ERROR_PAGE;
	}
}