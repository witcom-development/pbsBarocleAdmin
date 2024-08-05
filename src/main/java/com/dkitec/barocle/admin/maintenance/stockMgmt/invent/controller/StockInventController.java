/*
 * @Package Name : com.dkitec.barocle.admin.maintenance.stockMgmt.invent.controller
 * @파일명          : StockInventController.java
 * @작성일          : 2015. 6. 1.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 6. 1.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.maintenance.stockMgmt.invent.controller;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.admin.login.vo.UserSessionVO;
import com.dkitec.barocle.admin.maintenance.stockMgmt.invent.service.StockInventService;
import com.dkitec.barocle.admin.maintenance.stockMgmt.invent.vo.InventVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.base.IConstants;
import com.dkitec.barocle.util.webutil.HttpUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * @파일명          : StockInventController.java
 * @작성일          : 2015. 6. 1.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 6. 1.   |   ymshin   |  최초작성
 */
@Controller
@RequestCategory("StockInventController")
public class StockInventController extends BaseController {
	protected static Logger log = LoggerFactory.getLogger(StockInventController.class);
	private static final String RETURN_URL = "/admin/maintenance/stock/invent/";
	
	@Resource(name="stockInventService") private StockInventService stockInventService;
	@RequestMapping("/getStockInventList.do")
	@RequestName("getStockInventList")
	public String getStockInventList(@ModelAttribute InventVO inventVo, ModelMap model, HttpServletRequest request) {
		
		String bizName = "재고내역조회 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        boolean result = false;
        String resultPage = RETURN_URL.concat("inv_sta_list");
		
		try {
			/*if(bResult.hasErrors()){
				throw new CfoodException("admin.maintenance.stock.list");
			}
			*/
			if(inventVo.getViewFlg().equals(MODE_EXCEL)){
				inventVo.setPagingYn("N");
			}else{
				inventVo.setPagingYn("Y");
			}

			int totCnt = stockInventService.getStockInventListCount(inventVo);
			PaginationInfo paginationInfo = getPagingInfo(inventVo.getCurrentPageNo(), totCnt);
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(inventVo.getCurrentPageNo(), totCnt);
			inventVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			inventVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<InventVO> inventList = stockInventService.getStockInventList(inventVo);
			
			model.addAttribute("searchCondition",inventVo );
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo",paginationMobileInfo);
			model.addAttribute("inventList", inventList);
			
			if(inventVo.getViewFlg().equals(MODE_EXCEL)) {
				resultPage = RETURN_URL.concat("inv_sta_list_excel");
    		}
			
			result = true;
		} catch (Exception e) {
			throw new CfoodException("admin.maintenance.stock.list",e);
		}
		
		return result ? resultPage : ERROR_PAGE;
	}
	
	@RequestMapping("/moveStockInventEditForm.do") 
	@RequestName("moveStockInventEditForm")
	public String moveStockInventEditForm(@ModelAttribute InventVO inventVo, BindingResult bResult, ModelMap model, HttpServletRequest request){
		String bizName = "재고내역조회 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        boolean result = false;
        String resultPage = RETURN_URL.concat("inv_sta_detail");
		try {
			
			if(bResult.hasErrors()) {
				
				throw new CfoodException("admin.maintenance.stock.bind");
			} else {
				InventVO inventData = null;
				List<InventVO> history = null;
				PaginationInfo paginationInfo = null;
				PaginationInfo paginationMobileInfo = null; 
				if(inventVo.getViewFlg().equals(IConstants.CRUD_C)) {
					inventData = new InventVO();
					history = new ArrayList<InventVO>();
					paginationInfo = getPagingInfo(inventVo.getCurrentPageNo(), 0);
				} else  {
					if((inventVo.getCenterId() == null || inventVo.getCenterId().equals("")) 
							&& (inventVo.getPartCd() == null || inventVo.getPartCd().equals(""))){
						throw new CfoodException("admin.maintenance.stock.bind");
					}
					
					if(inventVo.getViewFlg().equals(MODE_EXCEL)){
						inventVo.setPagingYn("N");
					}else{
						inventVo.setPagingYn("Y");
					}
					
					inventData = stockInventService.getStockInventDetailInfo(inventVo);
					
					int totCnt = stockInventService.getStockInventHistInfoCnt(inventVo);
					paginationInfo = getPagingInfo(inventVo.getCurrentPageNo(), totCnt);
					paginationMobileInfo = getPagingMobileInfo(inventVo.getCurrentPageNo(), totCnt);
					inventVo.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
					inventVo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
					
					history = stockInventService.getStockInventHistInfo(inventVo);
				}
				model.addAttribute("invent", inventVo);
				model.addAttribute("inventData", inventData);
				model.addAttribute("history", history);
				model.addAttribute("paginationInfo", paginationInfo);
				model.addAttribute("paginationMobileInfo",paginationMobileInfo);
				if(inventVo.getViewFlg().equals(MODE_EXCEL)) {
					resultPage = RETURN_URL.concat("inv_sta_detail_excel");
	    		}
				result = true;
			}
			
		} catch (Exception e) {
			throw new CfoodException("admin.maintenance.stock.bind",e);
		}
		
		return result ? resultPage : ERROR_PAGE;
	}
	
	@RequestMapping(value="/exeStockInventEdit.do")
	@RequestName("exeStockInventEdit")
	public String exeStockInventEdit(@ModelAttribute @Valid InventVO inventVo, BindingResult bResult, ModelMap model, HttpServletRequest request) throws Exception{
		
		String bizName = "재고내역조회 화면";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        int result = 0;
		String resultMessage = "저장에 성공했습니다.";
		UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request,"userSessionVO");
		String adminId = userSessionVO == null ? "test" : userSessionVO.getUsrId();
		InventVO before = null;
		int gap = 0;
		try {
			if(bResult.hasErrors()){
				for(ObjectError error : bResult.getAllErrors()){
					resultMessage = error.getDefaultMessage();
				}
			} else {
				inventVo.setModId(adminId);
				if(inventVo.getViewFlg().equals(CRUD_C)) {
					boolean isPartExist = stockInventService.isPartExist(inventVo);
					
					if(isPartExist) {
						result = stockInventService.setPartInvent(inventVo, Integer.parseInt(inventVo.getStockQunt()));
					} else {
						result = stockInventService.addNewPart(inventVo);
					}
				} else {
					
					before = stockInventService.getStockInventDetailInfo(inventVo);
					gap = Integer.parseInt(inventVo.getStockQunt()) - Integer.parseInt(before.getStockQunt()) ;
					
					result = stockInventService.setPartInvent(inventVo, gap);
				}
			}
			model.addAttribute(CHECK_RESULT, result);
			model.addAttribute(RESULT_MESSAGE, resultMessage);
		} catch (Exception e) {
			throw new CfoodException("admin.maintenance.stock.editFail",e);
		}
		
		return JSONVIEW;
	}
	
	
	@RequestMapping( value = "/stock/stockPartInventBulkUpload.do")
	@RequestName("insertStockData")
	public String insertStockData(@ModelAttribute InventVO inventVo, ModelMap model,HttpServletRequest request) throws Exception, IOException, ClassNotFoundException {
		
		MultipartFile file = inventVo.getBulkFile();
		String fName = file.getOriginalFilename();
		UserSessionVO userSessionVO = (UserSessionVO)EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
		int result = 0;
		try {
			boolean isNull = false;
			if(fName != null && !"".equals(fName)) {
				
				String[] surffix = fName.split(".");
				InventVO vo = null;
	     		List<InventVO> excelData = new ArrayList<InventVO>();
				if(surffix[1].equalsIgnoreCase("xlsx")) {
					XSSFWorkbook xssf = new XSSFWorkbook(file.getInputStream());
					for(Row row : xssf.getSheetAt(0)){
						isNull = false;
						
						if(row.getRowNum() > 1) {
							if(row.getCell(0) == null) {
								isNull = true;
							}
							if(!isNull) {
								vo = new InventVO();
								vo.setModId(userSessionVO.getUsrId());
								excelData.add(vo);
							}
						}
					}
				} else {
					HSSFWorkbook hssfWorkbook = new HSSFWorkbook(file.getInputStream());
					for(Row row : hssfWorkbook.getSheetAt(0) ) {
						isNull = false;
						if(row.getRowNum() > 1) {
							if(row.getCell(0) == null) {
								isNull = true;
							} 
							if(!isNull) {
								vo = new InventVO();
							
								excelData.add(vo);
							}
						}
					}
					
				}
				result = stockInventService.addNewPartBulk(excelData, userSessionVO.getUsrId());
			} else {
				model.addAttribute(RESULT, result);
			}
			
			model.addAttribute(RESULT, result);
			
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "";
	}
}
