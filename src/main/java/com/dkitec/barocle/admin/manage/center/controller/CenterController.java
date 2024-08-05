package com.dkitec.barocle.admin.manage.center.controller;

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
import com.dkitec.barocle.admin.manage.center.service.CenterService;
import com.dkitec.barocle.admin.manage.center.vo.CenterVO;
import com.dkitec.barocle.admin.manage.center.vo.CenterVO.CenterDeleteVal;
import com.dkitec.barocle.admin.manage.center.vo.CenterVO.CenterEditVal;
import com.dkitec.barocle.admin.manage.center.vo.CenterVO.CenterListVal;
import com.dkitec.barocle.admin.manage.center.vo.CenterVO.CenterPersistVal;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.StringUtil;
import com.dkitec.barocle.util.webutil.WebUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="CenterController")
@RequestMapping(value="/admin/manage/center")
public class CenterController extends BaseController {
	
	@Resource(name = "centerService") private CenterService centerService;
	
	protected static Logger log = LoggerFactory.getLogger(CenterController.class);
	
	private final String[] centerSearchParameter = {"","searchValue"};
	
	@RequestName(value="getCenterList")
	@RequestMapping(value="/centerList.do")
	public String getCenterList(@Validated(CenterListVal.class) CenterVO centerVO, BindingResult result, HttpServletRequest request, Model model) {

		/* Validator error */
		if(result.hasErrors()){
			model.addAttribute("centerView",centerVO);
			model.addAttribute("resultError",super.setResultMessage(result));
			return "/admin/manage/center/opr_cen_list";
		}
		
		boolean bResult = false;
		String resultPage = "/admin/manage/center/opr_cen_list";
		
		try{
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
			throw new CfoodException("admin.manage.center.centerList",e);
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestName(value="editCenter")
	@RequestMapping(value="/centerEdit.do")
	public String editCenter(@Validated(CenterEditVal.class) CenterVO centerVO, BindingResult result, HttpServletRequest request, Model model) {
		
		/* Validator error */
		if(result.hasErrors()){ throw new CfoodException("admin.manage.center.centerEdit.validator"); }
		
		boolean bResult = false;
		String resultPage = "/admin/manage/center/opr_cen_detail";
		
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
			throw new CfoodException("admin.manage.center.centerEdit",e);
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestName(value="persistCenter")
	@RequestMapping(value={"/centerInsert.do","/centerUpdate.do"})
	public String persistCenter(@Validated(CenterPersistVal.class) CenterVO centerVO, BindingResult result, HttpServletRequest request, Model model) {
		
		/* Validator error */
		if(result.hasErrors()){
			model.addAttribute("centerView",centerVO);
			model.addAttribute("resultError",super.setResultMessage(result));
			return "/admin/manage/center/opr_cen_detail";
		}
		String getPersistMode = centerVO.getMode();
		
		/* check uri */
		String requestURI = (String)request.getRequestURI().toString();
		if(requestURI.indexOf("/centerInsert.do")>0){ getPersistMode = MODE_INSERT; } 
		else if(requestURI.indexOf("/centerUpdate.do")>0){ getPersistMode = MODE_UPDATE; }
		else { throw new CfoodException("admin.manage.center.centerPersist.NullModeException"); }
		
		try{
			/* get set session */
			try{
				centerVO.setRegID((String)EgovSessionCookieUtil.getSessionAttribute(request, "usrId"));
				centerVO.setModID((String)EgovSessionCookieUtil.getSessionAttribute(request, "usrId"));
			} catch(Exception e) { throw new CfoodException("admin.manage.center.centerPersist.NullSessionException",e); }
			
			CenterVO returnVO = null;
			
			// ST : 전화번호 병합
			centerVO.setCenterTelNO(centerVO.getCenterTelNO1() + "-" + centerVO.getCenterTelNO2() + "-" + centerVO.getCenterTelNO3());
			// ED : 전화번호 병합
			
			// ST : 운영시간 병합
			if(!StringUtil.isEmpty(centerVO.getOprStrTime1())&&!StringUtil.isEmpty(centerVO.getOprStrTime2())){
				centerVO.setOprStrTime(WebUtil.getTimeMin(centerVO.getOprStrTime1())+":"+WebUtil.getTimeMin(centerVO.getOprStrTime2()));
			}
			if(!StringUtil.isEmpty(centerVO.getOprEndTime1())&&!StringUtil.isEmpty(centerVO.getOprEndTime2())){
				centerVO.setOprEndTime(WebUtil.getTimeMin(centerVO.getOprEndTime1())+":"+WebUtil.getTimeMin(centerVO.getOprEndTime2()));
			}
			// ED : 운영시간 병학
			
			if(MODE_INSERT.equalsIgnoreCase(getPersistMode)){
				returnVO = centerService.insertCenter(centerVO);
				model.addAttribute(RESULT_MESSAGE, "Success");
			} else if(MODE_UPDATE.equalsIgnoreCase(getPersistMode)){
				returnVO = centerService.updateCenter(centerVO);
				model.addAttribute(RESULT_MESSAGE, "Success");
			} else model.addAttribute(RESULT_MESSAGE, "Fail");;
			
			model.addAttribute("centerId", returnVO.getCenterID());
			model.addAttribute(CHECK_RESULT, 0);
		} catch (Exception e) {
			throw new CfoodException("admin.manage.center.centerPersist",e);
		}
			
		return JSONVIEW;
	}
	
	@RequestName(value="deleteCenter")
	@RequestMapping(value="/centerDelete.do")
	public String deleteCenter(@Validated(CenterDeleteVal.class) CenterVO centerVO, BindingResult result, HttpServletRequest request, Model model) {
		
		/* Validator error */
		if(result.hasErrors()){ throw new CfoodException("admin.manage.center.centerDelete.validator"); }
		
		boolean bResult = false;
		String resultPage = "redirect:/admin/manage/center/centerList.do";
		
		try{
			/* get set session */
			try{
				centerVO.setModID((String)EgovSessionCookieUtil.getSessionAttribute(request, "usrId"));
			} catch(Exception e) { throw new CfoodException("admin.manage.center.centerDelete.NullSessionException",e); }
			
			if((centerService.deleteCenter(centerVO))>0){ bResult = true; }
		} catch (Exception e) {
			throw new CfoodException("admin.manage.center.centerDelete",e);
		}
			
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestName(value="getDistrictCD")
	@RequestMapping(value="/getSysCode.do")
	public String getDistrictCD(HttpServletRequest request, HttpServletResponse response, Model model) {
		try{
			java.util.Map<String,String> parameterMap = new java.util.HashMap<String,String>();
			if(!StringUtil.isEmpty(request.getParameter("sysCode"))){
				parameterMap.put("sysCode",(String)request.getParameter("sysCode"));
			} else throw new CfoodException("admin.manage.center.getDistrictCD.NullParameterValue");
			if(!StringUtil.isEmpty(request.getParameter("mLang"))){
				parameterMap.put("mLang",(String)request.getParameter("mLang"));
			} else { parameterMap.put("mLang",LANG_KR); }
			model.addAttribute("dataList",centerService.getSysCode(parameterMap));
		} catch (Exception e){
			throw new CfoodException("admin.manage.center.getDistrictCD",e);
		}
		return JSONVIEW;
	}

}
