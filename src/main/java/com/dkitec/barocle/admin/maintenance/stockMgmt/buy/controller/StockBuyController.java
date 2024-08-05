/*
 * @Package Name : com.dkitec.barocle.admin.maintenance.stockMgmt.buy.controller
 * @파일명          : StockBuyController.java
 * @작성일          : 2015. 6. 1.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 6. 1.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.maintenance.stockMgmt.buy.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.dkitec.barocle.admin.maintenance.stockMgmt.buy.service.StockBuyService;
import com.dkitec.barocle.admin.maintenance.stockMgmt.buy.vo.PartsBuyVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.HttpUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * @파일명          : StockBuyController.java
 * @작성일          : 2015. 6. 1.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 6. 1.   |   ymshin   |  최초작성
 */
@Controller
@RequestCategory(value="StockBuyController")
public class StockBuyController extends BaseController {
	protected static Logger log = LoggerFactory.getLogger(StockBuyController.class);
	
	private static final String RETURN_URL = "/admin/maintenance/stock/buy/";
	
	@Resource(name="stockBuyService") private StockBuyService stockBuyService;
	
	@RequestMapping("/getBuyPartsList.do")
	@RequestName("getBuyPartsList")
	public String getBuyPartsList(@ModelAttribute PartsBuyVO partsBuyVo, BindingResult bindingResult, ModelMap model, HttpServletRequest request ){
		String bizName = "재고 관리 구매내역조회 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        boolean result = false;
        String resultPage = RETURN_URL.concat("inv_buy_list");
		try {
			if(partsBuyVo.getViewFlg().equals(MODE_EXCEL)){
				partsBuyVo.setPagingYn("N");
			}else{
				partsBuyVo.setPagingYn("Y");
			}
			
			int totCnt = stockBuyService.getStockBuyListCount(partsBuyVo);
			
			PaginationInfo paginationInfo = getPagingInfo(partsBuyVo.getCurrentPageNo(), totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(partsBuyVo.getCurrentPageNo(), totCnt);
			partsBuyVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			partsBuyVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<PartsBuyVO> buyList = stockBuyService.getBuyPartsList(partsBuyVo);

			model.addAttribute("searchCondition",partsBuyVo );
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo",paginationMobileInfo);
			model.addAttribute("buyList", buyList);
			if(partsBuyVo.getViewFlg().equals(MODE_EXCEL)) {
				resultPage = RETURN_URL.concat("inv_buy_list_excel");
    		}
			result =true;
			
		} catch (Exception e) {
			throw new CfoodException("admin.maintenance.stock.list",e);
		}
		return result ? resultPage : ERROR_PAGE;
	}
	
	
	@RequestMapping(value="/moveStockBuyDetailInfo.do")
	@RequestName("moveStockBuyDetailInfo")
	public String moveStockBuyDetailInfo(@ModelAttribute PartsBuyVO partsBuyVo, BindingResult bindingResult, ModelMap model, HttpServletRequest request ){
		String bizName = "재고 관리 구매내역 등록 상세 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        boolean result = false;
        String resultPage = RETURN_URL.concat("inv_buy_detail");
        List<PartsBuyVO> partList = null;
        try {
            PartsBuyVO partData = null;
           
        	if(partsBuyVo.getViewFlg().equals(CRUD_C)) {
        		partData = new PartsBuyVO();
        	} else {
        		partData = stockBuyService.getStockBuyDetailInfo(partsBuyVo);
        	}
        	
        	model.addAttribute("part", partsBuyVo);
        	model.addAttribute("partData", partData);
        	
        	if(partsBuyVo.getViewFlg().equals(MODE_EXCEL)) {
        		partList = stockBuyService.getStockBuyPartList(partsBuyVo);
        		model.addAttribute("partList", partList);
				resultPage = RETURN_URL.concat("inv_buy_detail_excel");
    		}
        	
        	result = true;
        } catch (Exception e) {
			throw new CfoodException("admin.maintenance.stock.list",e);
        }
		return result ? resultPage : ERROR_PAGE;
	}
	
	@RequestMapping(value="/getStockBuyPartList.do")
	@RequestName("getStockBuyPartList")
	public String getStockBuyPartList(@ModelAttribute @Valid PartsBuyVO partsBuyVo, BindingResult bindingResult, ModelMap model, HttpServletRequest request) {
		String bizName = "재고 관리 구매내역 등록 상세 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        boolean result = false;
        List<PartsBuyVO> partList = null;
        String resultMessage = "";
        try {
        	if(bindingResult.hasErrors()){
        		for(ObjectError error : bindingResult.getAllErrors()){
					resultMessage = error.getDefaultMessage();
				}
        	} else {
        		partList = stockBuyService.getStockBuyPartList(partsBuyVo);
        		result = true;
        	}
        } catch (Exception e) {
			throw new CfoodException("admin.maintenance.stock.list",e);
        }
        model.addAttribute(CHECK_RESULT, result);
        model.addAttribute(RESULT_MESSAGE, resultMessage);
        model.addAttribute("partList", partList);
		return JSONVIEW;
	}
	
	@RequestMapping(value="/exeStockBuyDataEdit.do")
	@RequestName("exeStockBuyDataEdit")
	public String exeStockBuyDataEdit(@ModelAttribute @Valid PartsBuyVO partsBuyVo, BindingResult bindingResult, ModelMap model, HttpServletRequest request) {
		
		String bizName = "재고 관리 구매내역 등록 상세 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		int result = 0;
		String resultMessage = "저장이 성공했습니다";
		try {
			if(bindingResult.hasErrors()){
				for(ObjectError error : bindingResult.getAllErrors()){
					resultMessage = error.getDefaultMessage();
				}
			} else {
				if(partsBuyVo.getViewFlg().equals(CRUD_C)){
					result = stockBuyService.addStockBuyData(partsBuyVo);
				} else if(partsBuyVo.getViewFlg().equals(CRUD_U)) {
					result = stockBuyService.setStockBuyData(partsBuyVo);
				} else {
					resultMessage = "삭제에 성공했습니다";
					result = stockBuyService.delStockBuyData(partsBuyVo);
				}
			}
			
		} catch (Exception e) {
			throw new CfoodException("admin.maintenance.stock.list",e);
		}
		
		model.addAttribute(CHECK_RESULT, result);
        model.addAttribute(RESULT_MESSAGE, resultMessage);
		return JSONVIEW;
	}
}
