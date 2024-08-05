package com.dkitec.barocle.admin.repairMgmt.common.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.dkitec.barocle.admin.maintenance.stockMgmt.invent.vo.InventVO;
import com.dkitec.barocle.admin.repairMgmt.common.service.RepairMgmtCommService;
import com.dkitec.barocle.admin.system.commonCodeMgmt.vo.CommonCenterVO;
import com.dkitec.barocle.admin.system.commonCodeMgmt.vo.CommonCodeVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.HttpUtil;



@Controller
@RequestCategory(value="RepairMgmtCommController")
public class RepairMgmtCommController extends BaseController{
	protected static Logger log = LoggerFactory.getLogger(RepairMgmtCommController.class);

	@Resource(name="RepairMgmtCommService") private RepairMgmtCommService repairMgmtCommService;
	
	
	@RequestMapping(value = "/getAdmComCodeAjax.do", method = RequestMethod.POST)
	@RequestName(value="getAdmComCodeAjax")
	public String getAdmComCodeAjax(@RequestParam("comUpCd") String comUpCd, HttpServletRequest request, ModelMap model) throws Exception {
		
		String bizName = "개선 수리화면 공통코드 조회";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
        try {
        	
	       	CommonCodeVO cVo = new CommonCodeVO();
	       	cVo.setComUpCd(comUpCd);
	       	
	       	List<CommonCodeVO> codeList = repairMgmtCommService.getAdmComCodeList(cVo);
	       	
    	    model.addAttribute("codeList", codeList);
    	    
			return JSONVIEW;
		} catch (Exception e) {
			throw new CfoodException("admin.repairMgmt.comm.getAdmComCodeAjax" , e.getMessage());
		}
	}
	
	@RequestMapping(value = "/getPartsStockCnt.do")
	@RequestName(value="getPartsStockCnt")
	public String getPartsStockCnt(@ModelAttribute InventVO inventVo, HttpServletRequest request, ModelMap model) throws Exception {

		String bizName = "경정비 부품 재고 조회";
        HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
        
		try {
			List<InventVO> partsStockList = repairMgmtCommService.getPartsStockCnt(inventVo);
			model.addAttribute("partsStockList", partsStockList);
			model.addAttribute(RESULT_MESSAGE, "Success");
			model.addAttribute(CHECK_RESULT, 0);
		} catch (Exception e) {
			throw new CfoodException("admin.repairMgmt.comm.getPartsStockCnt" , e.getMessage());
		}
		return JSONVIEW;
	}
	
	
	@RequestMapping(value = "/getAdmCenterCodeAjax.do", method = RequestMethod.POST)
	@RequestName(value="getAdmCenterCodeAjax")
	public String getAdmCenterCodeAjax(HttpServletRequest request, ModelMap model) throws Exception {
		
		String bizName = "정비센터 코드 조회";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		try {
			
			List<CommonCenterVO> codeList = repairMgmtCommService.getAdmCenterCodeList();
			
			model.addAttribute("centerList", codeList);
			
			return JSONVIEW;
		} catch (Exception e) {
			throw new CfoodException("admin.repairMgmt.comm.getAdmCenterCodeAjax" , e.getMessage());
		}
	}	
	
	
	
	

}
