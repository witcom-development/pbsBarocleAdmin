/*
 * @Package Name : com.dkitec.barocle.admin.status.rentHistory.controller
 * @파일명		  : RentHistoryController.java
 * @작성일		  : 2015. 5. 14.
 * @작성자		  : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *	  수정일	  |	  수정자	  |			  수정내용
 * -------------------------------------------------------------
 *	2015. 5. 14.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.status.rentHistory.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.dkitec.barocle.admin.status.rentHistory.service.RentHistoryService;
import com.dkitec.barocle.admin.status.rentHistory.vo.PenaltyVO;
import com.dkitec.barocle.admin.status.rentStatus.vo.BikeRentalVO;
import com.dkitec.barocle.admin.system.commonCodeMgmt.vo.CommonCodeVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.HttpUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * @파일명		  : RentHistoryController.java
 * @작성일		  : 2015. 5. 14.
 * @작성자		  : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *	  수정일	  |	  수정자	  |			  수정내용
 * -------------------------------------------------------------
 *	2015. 5. 14.   |   ymshin   |  최초작성
 */
@Controller
@RequestCategory(value="RentHistoryController")
public class RentHistoryController extends BaseController {
	protected static Logger log = LoggerFactory.getLogger(RentHistoryController.class);
	private static final String RETURN_URL = "/admin/status/rentHistory/";
	
	@Resource(name="rentHistoryService") private RentHistoryService rentHistoryService;
	
	@RequestMapping("/getRentHistoryList.do")
	@RequestName("getRentHistory")
	public String getRentHistory(@ModelAttribute BikeRentalVO rentalVo, ModelMap model, HttpServletRequest request) {
		
		String bizName = "대여이력 목록 화면";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		String targetView = RETURN_URL.concat("pre_rent_his");
		boolean result = false;
		
		log.debug("##### getRentHistory ==> " + rentalVo.toString());
		try {
			//TODO : 로그인한 사용자의 locale정보로 설정.user정보에 같이
			rentalVo.setPageYn("Y"); //페이징 처리 여부
			if(rentalVo.getViewFlg().equals(MODE_EXCEL)) {
				rentalVo.setPageYn("N"); //페이징 처리 여부
				targetView = RETURN_URL.concat("pre_rent_his_excel");
			}
			int totCnt = rentHistoryService.getRentHistoryAllCnt(rentalVo);
			PaginationInfo paginationInfo = getPagingInfo(rentalVo.getCurrentPageNo(), totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(rentalVo.getCurrentPageNo(), totCnt);
			rentalVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			rentalVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<CommonCodeVO> resultList = rentHistoryService.getRentHistoryList(rentalVo);
			
			model.addAttribute("searchCondition",rentalVo );
			model.addAttribute("rentList", resultList);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo", paginationMobileInfo);
			result = true;
		} catch(CfoodException e) {
			throw new CfoodException(getMessage("fail.common.msg"));
		}
		
		return result ? targetView : ERROR_PAGE;
	}
	
	@RequestMapping(value="/moveRentHistoryDetail.do")
	@RequestName("moveRentHistoryDetail")
	public String moveRentHistoryDetail(@ModelAttribute @Valid BikeRentalVO rentalVo, BindingResult bResult, ModelMap model, HttpServletRequest request) {
		
		String bizName = "대여이력 상세 화면";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		boolean result = false;
		try {
			
			BikeRentalVO rentInfo = rentHistoryService.getRentHistInfoDetail(rentalVo);
			if(rentInfo != null){
				List<PenaltyVO> penalty =  rentHistoryService.getPenaltyList(rentInfo);
				int pTot = 0;
				for(PenaltyVO pVo : penalty) {
					pTot += Integer.parseInt( pVo.getPenaltyPoint());
				}
				rentInfo.setPenaltyTot(String.valueOf(pTot));
				rentInfo.setPenaltyList(penalty);
				
			}
			model.addAttribute("rentInfo", rentInfo);
			model.addAttribute("menuType", "history");
			result = true;
		} catch (CfoodException e) {
			throw new CfoodException(getMessage("fail.common.msg"));
		}
		
		return result ? RETURN_URL.concat("pre_rent_detail") : ERROR_PAGE;
	}
	
	@RequestMapping(value="/getPenaltyInfo.do")
	@RequestName("getPenaltyInfo")
	public String getPenaltyInfo(@ModelAttribute @Valid BikeRentalVO rentalVo, BindingResult bResult, ModelMap model, HttpServletRequest request) {
	 	String bizName = "대여이력 상세 화면";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		List<PenaltyVO> penaltyList = null;
		try {
			
			if(bResult.hasErrors()) {
				
			} else {
				penaltyList =  rentHistoryService.getPenaltyList(rentalVo);
			}
			
		} catch (CfoodException e) {
			throw new CfoodException(getMessage("fail.common.msg"));
		}
		
		model.addAttribute("penaltyList", penaltyList);

		return JSONVIEW;
		
	}
}
