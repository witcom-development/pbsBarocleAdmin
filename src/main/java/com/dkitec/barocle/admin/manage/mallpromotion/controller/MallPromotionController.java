package com.dkitec.barocle.admin.manage.mallpromotion.controller;

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
import com.dkitec.barocle.admin.manage.mallpromotion.service.MallPromotionService;
import com.dkitec.barocle.admin.manage.mallpromotion.vo.MallPromotionVO;
import com.dkitec.barocle.admin.manage.mallpromotion.vo.MallPromotionVO.MallPromotionDeleteVal;
import com.dkitec.barocle.admin.manage.mallpromotion.vo.MallPromotionVO.MallPromotionEditVal;
import com.dkitec.barocle.admin.manage.mallpromotion.vo.MallPromotionVO.MallPromotionListVal;
import com.dkitec.barocle.admin.manage.mallpromotion.vo.MallPromotionVO.MallPromotionPersistVal;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.StringUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="MallPromotionController")
@RequestMapping(value="/admin/manage/mallPromotion")
public class MallPromotionController extends BaseController {
	
	@Resource(name = "mallPromotionService") private MallPromotionService mallPromotionService;
	
	protected static Logger log = LoggerFactory.getLogger(MallPromotionController.class);
	
	private final String[] mallPromotionSearchParameter = {"stationGrpName","typeClsCD","searchValue"};
	
	@RequestName(value="getMallPromotionList")
	@RequestMapping(value="/mallPromotionList.do")
	public String getMallPromotionList(@Validated(MallPromotionListVal.class) MallPromotionVO mallPromotionVO, BindingResult result, HttpServletRequest request, Model model) {
		
		/* set lang */
		mallPromotionVO.setmLang(LANG_KR);
		
		/* Validator error */
		if(result.hasErrors()){
			model.addAttribute("mallPromotionView",mallPromotionVO);
			model.addAttribute("resultError",super.setResultMessage(result));
			return "/admin/manage/mallPromotion/opr_sto_list";
		}
		
		boolean bResult = false;
		String resultPage = "/admin/manage/mallPromotion/opr_sto_list";
		
		try{
			// 총 레코드 개수를 가져온다.
			mallPromotionVO.setTotalRecordCount(mallPromotionService.listMallPromotionCount(mallPromotionVO));
			// 페이징
			PaginationInfo paginationInfo = getPagingInfo(mallPromotionVO.getCurrentPageNo(), mallPromotionVO.getTotalRecordCount());
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(mallPromotionVO.getCurrentPageNo(), mallPromotionVO.getTotalRecordCount());
			mallPromotionVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			mallPromotionVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			// 현재 화면의 정보를 지정한다.
			model.addAttribute("mallPromotionView",mallPromotionVO);
			// 현재 화면에 표시되는 레코드 목록을 가져온다.
			model.addAttribute("mallPromotionList",mallPromotionService.listMallPromotion(mallPromotionVO));
			// 현재 화면의 검색 파라미터 값을 지정한다.
			model.addAttribute("parameterInfo",super.setGivenParameterValue(request,this.mallPromotionSearchParameter));
			// 현재 화면에 표시되는 페이징 점보를 리턴한다.
			model.addAttribute("paginationInfo",paginationInfo);
			model.addAttribute("paginationMobileInfo",paginationMobileInfo);
			
			bResult = true;		// 정상
		} catch (Exception e) {
			throw new CfoodException("admin.manage.mallpromotion.mallPromotionList",e);
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestName(value="editMallPromotion")
	@RequestMapping(value="/mallPromotionEdit.do")
	public String editMallPromotion(@Validated(MallPromotionEditVal.class) MallPromotionVO mallPromotionVO, BindingResult result, HttpServletRequest request, Model model) {
		
		/* set lang */
		mallPromotionVO.setmLang(LANG_KR);
		
		/* Validator error */
		if(result.hasErrors()){ throw new CfoodException("admin.manage.mallpromotion.mallPromotionEdit.validator"); }
		
		boolean bResult = false;
		String resultPage = "/admin/manage/mallPromotion/opr_sto_detail";
		
		try{
			MallPromotionVO returnVO = null;
			if(mallPromotionVO.getShopADSeq()>0){	//* mallPromotionSeq>0 ? edit | write
				returnVO = (MallPromotionVO)mallPromotionService.viewMallPromotion(mallPromotionVO);
				// ST : 전화번호 분리
				if(!StringUtil.isEmpty(returnVO.getShopTelNO())){
					String[] shopTelNO = (returnVO.getShopTelNO()).split("-");
					if(!StringUtil.isEmpty(shopTelNO)&&shopTelNO.length>=3){
						returnVO.setShopTelNO1(shopTelNO[0]);
						returnVO.setShopTelNO2(shopTelNO[1]);
						returnVO.setShopTelNO3(shopTelNO[2]);
					}
				}
				// ED : 전화번호 분리
				returnVO.setMode("update");
			} else {
				returnVO = new MallPromotionVO();
				returnVO.setMode("insert");
			}
			// 현재 화면를 가져온다.
			returnVO.setCurrentPageNo(mallPromotionVO.getCurrentPageNo());
			// 현재 화면의 검색 파라미터 값을 지정한다.
			model.addAttribute("parameterInfo",super.setGivenParameterValue(request,this.mallPromotionSearchParameter));
			model.addAttribute("mallPromotionView",returnVO);
			
			bResult = true;		// 정상
		} catch (Exception e) {
			throw new CfoodException("admin.manage.mallpromotion.mallPromotionEdit",e);
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestName(value="persistMallPromotion")
	@RequestMapping(value={"/mallPromotionInsert.do","/mallPromotionUpdate.do"})
	public String persistMallPromotion(@Validated(MallPromotionPersistVal.class) MallPromotionVO mallPromotionVO, BindingResult result, HttpServletRequest request, Model model) {
		
		/* set lang */
		mallPromotionVO.setmLang(LANG_KR);
		
		/* Validator error */
		if(result.hasErrors()){
			model.addAttribute("mallPromotionView",mallPromotionVO);
			model.addAttribute("resultError",super.setResultMessage(result));
			return "/admin/manage/mallPromotion/opr_sto_detail";
		}
		String getPersistMode = mallPromotionVO.getMode();
		
		
		/* check uri */
		String requestURI = (String)request.getRequestURI().toString();
		if(requestURI.indexOf("/mallPromotionInsert.do")>0){ getPersistMode = MODE_INSERT; } 
		else if(requestURI.indexOf("/mallPromotionUpdate.do")>0){ getPersistMode = MODE_UPDATE; }
		else { throw new CfoodException("admin.manage.mallpromotion.mallPromotionPersist.NullModeException"); }
		
		try{
			/* get set session */
			try{
				mallPromotionVO.setRegID((String)EgovSessionCookieUtil.getSessionAttribute(request, "usrId"));
				mallPromotionVO.setModID((String)EgovSessionCookieUtil.getSessionAttribute(request, "usrId"));
			} catch(Exception e) { throw new CfoodException("admin.manage.mallpromotion.mallPromotionPersist.NullSessionException",e); }
			
			MallPromotionVO returnVO = null;
			
			// ST : 전화번호 병합
			mallPromotionVO.setShopTelNO(mallPromotionVO.getShopTelNO1() + "-" + mallPromotionVO.getShopTelNO2() + "-" + mallPromotionVO.getShopTelNO3());
			// ED : 전화번호 병합
			
			if(MODE_INSERT.equalsIgnoreCase(getPersistMode)){
				returnVO = mallPromotionService.insertMallPromotion(mallPromotionVO);
				model.addAttribute(RESULT_MESSAGE, "Success");
			} else if(MODE_UPDATE.equalsIgnoreCase(getPersistMode)){
				returnVO = mallPromotionService.updateMallPromotion(mallPromotionVO);
				model.addAttribute(RESULT_MESSAGE, "Success");
			} else model.addAttribute(RESULT_MESSAGE, "Fail");;
			
			model.addAttribute("shopADSeq", returnVO.getShopADSeq());
			model.addAttribute(CHECK_RESULT, 0);
		} catch (Exception e) {
			throw new CfoodException("admin.manage.mallpromotion.mallPromotionPersist",e);
		}
			
		return JSONVIEW;
	}
	
	@RequestName(value="deleteMallPromotion")
	@RequestMapping(value="/mallPromotionDelete.do")
	public String deleteMallPromotion(@Validated(MallPromotionDeleteVal.class) MallPromotionVO mallPromotionVO, BindingResult result, HttpServletRequest request, Model model) {
		
		/* set lang */
		mallPromotionVO.setmLang(LANG_KR);
		
		/* Validator error */
		if(result.hasErrors()){ throw new CfoodException("admin.manage.mallpromotion.mallPromotionDelete.validator"); }
		
		boolean bResult = false;
		String resultPage = "redirect:/admin/manage/mallPromotion/mallPromotionList.do";
		
		try{
			/* get set session */
			try{
				mallPromotionVO.setModID((String)EgovSessionCookieUtil.getSessionAttribute(request, "usrId"));
			} catch(Exception e) { throw new CfoodException("admin.manage.mallpromotion.mallPromotionDelete.NullSessionException",e); }
			
			if((mallPromotionService.deleteMallPromotion(mallPromotionVO))>0){ bResult = true; }
		} catch (Exception e) {
			throw new CfoodException("admin.manage.mallpromotion.mallPromotionDelete",e);
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestName(value="getStationGroup")
	@RequestMapping(value="/getStationGroup.do")
	public String getStationGroup(HttpServletRequest request, HttpServletResponse response, Model model) {
		try{
			String mLang = "";
			if(!StringUtil.isEmpty(request.getParameter("mLang"))){
				mLang = (String)request.getParameter("mLang");
			} else { mLang = LANG_KR; }
			if(StringUtil.isEmpty(mLang)) throw new CfoodException("admin.manage.mallpromotion.getStationGroup.NullParameterValue");
			model.addAttribute("dataList",mallPromotionService.getStationGroup(mLang));
		} catch (Exception e){
			throw new CfoodException("admin.manage.mallpromotion.getStationGroup",e);
		}
		return JSONVIEW;
	}
	
	@RequestName(value="getStation")
	@RequestMapping(value="/getStationID.do")
	public String getStation(HttpServletRequest request, HttpServletResponse response, Model model) {
		try{
			java.util.Map<String,String> parameterMap = new java.util.HashMap<String,String>();
			if(!StringUtil.isEmpty(request.getParameter("stationGrpSeq"))){
				parameterMap.put("stationGrpSeq",(String)request.getParameter("stationGrpSeq"));
			} else throw new CfoodException("admin.manage.mallpromotion.getStation.NullParameterValue");
			if(!StringUtil.isEmpty(request.getParameter("mLang"))){
				parameterMap.put("mLang",(String)request.getParameter("mLang"));
			} else { parameterMap.put("mLang",LANG_KR); }
			model.addAttribute("dataList",mallPromotionService.getStationID(parameterMap));
		} catch (Exception e){
			throw new CfoodException("admin.manage.mallpromotion.getStation",e);
		}
		return JSONVIEW;
	}
	
}
