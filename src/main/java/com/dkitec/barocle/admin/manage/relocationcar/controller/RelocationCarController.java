package com.dkitec.barocle.admin.manage.relocationcar.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.admin.manage.relocationcar.service.RelocationCarService;
import com.dkitec.barocle.admin.manage.relocationcar.vo.RelocationCarVO;
import com.dkitec.barocle.admin.manage.relocationcar.vo.RelocationCarVO.RelocationCarDeleteVal;
import com.dkitec.barocle.admin.manage.relocationcar.vo.RelocationCarVO.RelocationCarEditVal;
import com.dkitec.barocle.admin.manage.relocationcar.vo.RelocationCarVO.RelocationCarListVal;
import com.dkitec.barocle.admin.manage.relocationcar.vo.RelocationCarVO.RelocationCarPersistVal;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.StringUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="RelocationCarController")
@RequestMapping(value="/admin/manage/relocationCar")
public class RelocationCarController extends BaseController {
	
	@Resource(name = "relocationCarService") private RelocationCarService relocationCarService;
	
	protected static Logger log = LoggerFactory.getLogger(RelocationCarController.class);
	
	private final String[] relocationCarSearchParameter = {"","searchValue"};
	
	@RequestName(value="getCenterList")
	@RequestMapping(value="/getCenterList.do")
	public String getCenterList(HttpServletRequest request, HttpServletResponse response, Model model) {
		try{
			String centerClsCD = (String)request.getParameter("centerClsCD");
			if(StringUtil.isEmpty(centerClsCD)) throw new CfoodException("admin.manage.relocationcar.relocationCarCenterClsCD.NullParameterValue");
			model.addAttribute("dataList",relocationCarService.getCenterList(centerClsCD));
		} catch (Exception e){
			throw new CfoodException("admin.manage.relocationcar.relocationCarCenterClsCD",e);
		}
		return JSONVIEW;
	}
	
	@RequestName(value="getTeamList")
	@RequestMapping(value="/getTeamList.do")
	public String getTeamList(HttpServletRequest request, HttpServletResponse response, Model model) {
		try{
			model.addAttribute("dataList",relocationCarService.getTeamList());
		} catch (Exception e){
			throw new CfoodException("admin.manage.relocationcar.relocationCarCenterClsCD",e);
		}
		return JSONVIEW;
	}
	
	@RequestName(value="getRelocationCarList")
	@RequestMapping(value="/relocationCarList.do")
	public String getRelocationCarList(@Validated(RelocationCarListVal.class) RelocationCarVO relocationCarVO, BindingResult result, HttpServletRequest request, Model model) {

		/* Validator error */
		if(result.hasErrors()){
			model.addAttribute("relocationCarView",relocationCarVO);
			model.addAttribute("resultError",super.setResultMessage(result));
			return "/admin/manage/relocationCar/opr_car_list";
		}
		
		boolean bResult = false;
		String resultPage = "/admin/manage/relocationCar/opr_car_list";
		
		try{
			// 총 레코드 개수를 가져온다.
			relocationCarVO.setTotalRecordCount(relocationCarService.listRelocationCarCount(relocationCarVO));
			// 페이징
			PaginationInfo paginationInfo = getPagingInfo(relocationCarVO.getCurrentPageNo(), relocationCarVO.getTotalRecordCount());
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(relocationCarVO.getCurrentPageNo(), relocationCarVO.getTotalRecordCount());
			relocationCarVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			relocationCarVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			// 현재 화면의 정보를 지정한다.
			model.addAttribute("relocationCarView",relocationCarVO);
			// 현재 화면에 표시되는 레코드 목록을 가져온다.
			model.addAttribute("relocationCarList", relocationCarService.listRelocationCar(relocationCarVO));
			// 현재 화면의 검색 파라미터 값을 지정한다.
			model.addAttribute("parameterInfo",super.setGivenParameterValue(request,this.relocationCarSearchParameter));
			// 현재 화면에 표시되는 페이징 점보를 리턴한다.
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paginationMobileInfo",paginationMobileInfo);
			
			bResult = true;		// 정상
		} catch (Exception e) {
			throw new CfoodException("admin.manage.relocationcar.relocationCarList",e);
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestName(value="editRelocationCar")
	@RequestMapping(value="/relocationCarEdit.do")
	public String editRelocationCar(@Validated(RelocationCarEditVal.class) RelocationCarVO relocationCarVO, BindingResult result, HttpServletRequest request, Model model) {
		
		/* Validator error */
		if(result.hasErrors()){ throw new CfoodException("admin.system.relocationcar.relocationCarEdit.validator"); }
		
		boolean bResult = false;
		String resultPage = "/admin/manage/relocationCar/opr_car_detail";
		
		try{
			RelocationCarVO returnVO = null;
			if(!StringUtil.isEmpty(relocationCarVO.getRelocateCarID())){	//* relocationCarSeq>0 ? edit | write
				returnVO = (RelocationCarVO)relocationCarService.viewRelocationCar(relocationCarVO);
				returnVO.setMode("update");
			} else {
				returnVO = new RelocationCarVO();
				returnVO.setMode("insert");
			}
			// 현재 화면를 가져온다.
			returnVO.setCurrentPageNo(relocationCarVO.getCurrentPageNo());
			// 현재 화면의 검색 파라미터 값을 지정한다.
			model.addAttribute("parameterInfo",super.setGivenParameterValue(request,this.relocationCarSearchParameter));
			model.addAttribute("relocationCarView",returnVO);
			
			bResult = true;		// 정상
		} catch (Exception e) {
			throw new CfoodException("admin.manage.relocationcar.relocationCarEdit",e);
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestName(value="persistRelocationCar")
	@RequestMapping(value={"/relocationCarInsert.do","/relocationCarUpdate.do"})
	public String persistRelocationCar(@Validated(RelocationCarPersistVal.class) RelocationCarVO relocationCarVO, BindingResult result, HttpServletRequest request, Model model) {
		
		/* Validator error */
		if(result.hasErrors()){
			model.addAttribute("relocationCarView",relocationCarVO);
			model.addAttribute("resultError",super.setResultMessage(result));
			return "/admin/manage/relocationCar/opr_car_detail";
		}
		String getPersistMode = relocationCarVO.getMode();
		
		try{
			/* get set session */
			try{
				relocationCarVO.setRegID((String)EgovSessionCookieUtil.getSessionAttribute(request, "usrId"));
				relocationCarVO.setModID((String)EgovSessionCookieUtil.getSessionAttribute(request, "usrId"));
			} catch(Exception e) { throw new CfoodException("admin.manage.relocationcar.relocationCarPersist.NullSessionException",e); }
			
			RelocationCarVO returnVO = null;
			
			// 차량 연식 병합
			relocationCarVO.setCarModlyyYYMM(relocationCarVO.getCarModlyyYYMM1()+relocationCarVO.getCarModlyyYYMM2());
			
			if(MODE_INSERT.equalsIgnoreCase(getPersistMode)){
				returnVO = relocationCarService.insertRelocationCar(relocationCarVO);
				model.addAttribute(RESULT_MESSAGE, "Success");
			} else if(MODE_UPDATE.equalsIgnoreCase(getPersistMode)){
				returnVO = relocationCarService.updateRelocationCar(relocationCarVO);
				model.addAttribute(RESULT_MESSAGE, "Success");
			} else model.addAttribute(RESULT_MESSAGE, "Fail");;
			
			model.addAttribute("relocateCarId", returnVO.getRelocateCarID());
			model.addAttribute(CHECK_RESULT, 0);
		} catch (Exception e) {
			throw new CfoodException("admin.manage.relocationcar.relocationCarPersist",e);
		}
			
		return JSONVIEW;
	}
	
	@RequestName(value="deleteRelocationCar")
	@RequestMapping(value="/relocationCarDelete.do")
	public String deleteRelocationCar(@Validated(RelocationCarDeleteVal.class) RelocationCarVO relocationCarVO, BindingResult result, HttpServletRequest request, Model model) {
		
		/* Validator error */
		if(result.hasErrors()){ throw new CfoodException("admin.manage.relocationcar.relocationCarDelete.validator"); }
		
		boolean bResult = false;
		String resultPage = "redirect:/admin/manage/relocationCar/relocationCarList.do";
		
		try{
			/* get set session */
			try{
				relocationCarVO.setModID((String)EgovSessionCookieUtil.getSessionAttribute(request, "usrId"));
			} catch(Exception e) { throw new CfoodException("admin.manage.relocationcar.relocationCarDelete.NullSessionException",e); }
			
			if((relocationCarService.deleteRelocationCar(relocationCarVO))>0){ bResult = true; }
		} catch (Exception e) {
			throw new CfoodException("admin.manage.relocationcar.relocationCarDelete");
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestName(value="gpsDupCheck")
	@RequestMapping(value="/gpsDupCheck.do")
	public String gpsDupCheck(HttpServletRequest request, Model model) {
		RelocationCarVO relocationCarVO = new RelocationCarVO();
		if(request.getParameter("gpsDup")!=null&&!StringUtil.isEmpty((String)request.getParameter("gpsDup"))){ relocationCarVO.setgPSTerminalSerialNO((String)request.getParameter("gpsDup")); }
		model.addAttribute("gpsCount",relocationCarService.countGPSDuplication(relocationCarVO));
		return JSONVIEW;
	}

}
