package com.dkitec.barocle.admin.customer.survey.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

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
import com.dkitec.barocle.admin.customer.survey.service.SurveyService;
import com.dkitec.barocle.admin.customer.survey.vo.SurveyQestVO;
import com.dkitec.barocle.admin.customer.survey.vo.SurveyVO;
import com.dkitec.barocle.admin.customer.survey.vo.SurveyVO.SurveyDeleteVal;
import com.dkitec.barocle.admin.customer.survey.vo.SurveyVO.SurveyEditVal;
import com.dkitec.barocle.admin.customer.survey.vo.SurveyVO.SurveyListVal;
import com.dkitec.barocle.admin.customer.survey.vo.SurveyVO.SurveyPersistVal;
import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.DateUtil;
import com.dkitec.barocle.util.webutil.HttpUtil;
import com.dkitec.barocle.util.webutil.WebUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="SurveyController")
@RequestMapping(value="/admin/customer/survey")
public class SurveyController extends BaseController {
	
	@Resource(name = "surveyService") private SurveyService surveyService;
	
	protected static Logger log = LoggerFactory.getLogger(SurveyController.class);
	
	private final String[] surveySearchParameter = {"searchValue","searchStartDate","searchEndDate"};
	
	/*
	 * NOTE : !!!
	 * TB_COM_QESTNR_INFO에 QUSTNR_STR_DTTM&&QUSTNR_STR_DTTM 값들이 NULL 이면 해상 설문 조사를 사용 안함으로 정의한다.
	 * TB_COM_QESTNR_INFO의 하위 테이블 TB_COM_QUSTNR_QESITM에 QESTN_ORD 값이 0이면 해당 질문을 사용 안함으로 정의한다.
	 * TB_COM_QUSTNR_QESITM의 하위 테이블 TB_COM_QUSTNR_ITEM에 ITEM_ORD 값이 0이면 해당 항목을 사용 안함으로 정의한다.
	 */
	@RequestName(value="getSurveyList")
	@RequestMapping(value="/surveyList.do")
	public String getSurveyList(@Validated(SurveyListVal.class) SurveyVO surveyVO, BindingResult result, HttpServletRequest request, Model model) {
		
		/* validator check */
		if(result.hasErrors()){
			model.addAttribute("surveyView", surveyVO);
			model.addAttribute("resultError", super.setResultMessage(result));
			return "/admin/customer/survey/bor_sur_list";
		}
		
		boolean bResult = false;
		String resultPage = "/admin/customer/survey/bor_sur_list";
		
		try{
			// 총 레코드 개수를 가져온다.
			surveyVO.setTotalRecordCount(surveyService.listSurveyCount(surveyVO));
			// 페이징
			PaginationInfo paginationInfo = getPagingInfo(surveyVO.getCurrentPageNo(), surveyVO.getTotalRecordCount());
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(surveyVO.getCurrentPageNo(), surveyVO.getTotalRecordCount());
			surveyVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			surveyVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			// 현재 화면의 정보를 지정한다.
			model.addAttribute("surveyView", surveyVO);
			// 현재 화면의 레코드 목록을 지정한다.
			model.addAttribute("surveyList",surveyService.listSurvey(surveyVO));
			// 현재 화면의 검색 파라미터 값을 지정한다.
			model.addAttribute("parameterInfo",super.setGivenParameterValue(request,this.surveySearchParameter));
			// 현재 화면에 표시되는 페이징 정보를 지정한다.
			model.addAttribute("paginationInfo",paginationInfo);
			model.addAttribute("paginationMobileInfo",paginationMobileInfo);
			
			// 오늘 날짜
			model.addAttribute("getTodayDate",DateUtil.getSystemDate("yyyyMMdd"));
			
			bResult = true;		// 정상
			
		} catch (Exception e) {
			throw new CfoodException("admin.customer.survey.surveyList",e);
		}
		
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestName(value="editSurvey")
	@RequestMapping(value="surveyEdit.do")
	public String editSurvey(@Validated(SurveyEditVal.class) SurveyVO surveyVO, BindingResult result, HttpServletRequest request, Model model) {
		
		if(result.hasErrors()){ throw new CfoodException("admin.customer.survey.surveyEdit.bindingexception"); }
		
		boolean bResult = false;
		String resultPage = "/admin/customer/survey/bor_sur_detail";
		String getPersistMode = surveyVO.getMode();
		
		try{
			SurveyVO surveyView = new SurveyVO();
			
			surveyView.setMode(MODE_INSERT);	// default mode
			
			if(MODE_EDIT.equalsIgnoreCase(getPersistMode)){
				surveyView = surveyService.viewSurvey(surveyVO);
				surveyView.setMode(MODE_UPDATE);
				// survey results
				model.addAttribute("surveyResultList",surveyService.viewSurveyResult(surveyVO));
				/*daum_editor start*/
				model.addAttribute("daumEditorImageList", surveyService.listDaumEditorVO(surveyVO));
				/*daum_editor end*/
			} else if(MODE_EXCEL.equalsIgnoreCase(getPersistMode)){
				resultPage = "/admin/customer/survey/bor_sur_detail_excel";
				surveyView.setMode(MODE_EXCEL);
				
				surveyView = surveyService.viewSurvey(surveyVO);
//				List<SurveyVO> resultList = surveyService.getEtcList(surveyVO);
				
				model.addAttribute("surveyResultListExcel",surveyService.viewSurveyResultExcel(surveyVO));
//				model.addAttribute("resultList", resultList);
			} else bResult = false;
			
			// 현재 화면를 가져온다.
			surveyView.setCurrentPageNo(surveyVO.getCurrentPageNo());
			
			// 현재 화면의 검색 파라미터 값을 지정한다.
			model.addAttribute("parameterInfo",super.setGivenParameterValue(request, this.surveySearchParameter));
			model.addAttribute("surveyView",surveyView);
			
			bResult = true;
			
		} catch(Exception e){
			throw new CfoodException("admin.customer.survey.surveyEdit",e);
		}
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestName(value="persistSurvey")
	@RequestMapping(value={"/surveyInsert.do","/surveyUpdate.do"})
	public String persistSurvey(@Validated(SurveyPersistVal.class) SurveyVO surveyVO, BindingResult result, HttpServletRequest request, Model model) {
		
		/* Validator error */
		if(result.hasErrors()){
			// @validated 에러는 처리하지 않는다. jsp에서 이미 각 질문과 질문의 항목을 depth list로 받아오기 때문에 공백이 생긴다.
		}
		
		boolean bResult = false;
		//String resultPage = "redirect:/admin/customer/survey/surveyEdit.do?mode=edit&currentPageNo="+surveyVO.getCurrentPageNo()+"&qustnrSeq=";
		String resultPage = "redirect:/admin/customer/survey/surveyList.do";
		
		String getPersistMode = surveyVO.getMode();
		
		/* check uri */
		String requestURI = (String)request.getRequestURI().toString();
		if(requestURI.indexOf("/surveyInsert.do")>0){ getPersistMode = MODE_INSERT; } 
		else if(requestURI.indexOf("/surveyUpdate.do")>0){ getPersistMode = MODE_UPDATE; }
		else { throw new CfoodException("admin.customer.survey.surveyPersist.NullModeException"); }
		
		
		
		
		try{
			/* get set session */
			try{
				surveyVO.setRegID((String)EgovSessionCookieUtil.getSessionAttribute(request, "usrId"));
				surveyVO.setModID((String)EgovSessionCookieUtil.getSessionAttribute(request, "usrId"));
			} catch(Exception e){ throw new CfoodException("admin.customer.survey.surveyPersist.NullSessionException",e); }
			
			SurveyVO returnVO = null;
			bResult = true;

			/*daum_editor start*/
			/*
			다음 에디터에서 내용은 donorHTMLContent에 저장되어 들어온다. donorHTMLContent내용은 html태그가 포함되어 있다.
			NOTICE_TEXT_CONTENT AS donorTextContent : <img>를 제외한 모든 테그를 삭제하여 저장한다.
			NOTICE_HTML_CONTENT AS donorHTMLContent : 모든 html 태그를 포함한다.
			 */
			// 비고 내용
			surveyVO.setBorHTMLContent(surveyVO.getQustnrWritngGuideContent());
			
			surveyVO.setBorTextContent(WebUtil.removeHTMLSpecialChars(WebUtil.replaceHTMLSpecialChars(surveyVO.getBorHTMLContent()), ""));
			
			/*
			 donorHTMLContent에서 img value를 모두 가녀온다.  해당 img값/값들로 TB_COM_DAUM_IMAGE 테이블에 매핑한다.
			 다음 에디터는 내용을 DB에 저장하기 전에 popup창으로 이미지를 먼저 등록한다. 이 과정에서 우선적으로 이미지 파일은 서버에 업로드 되어 있고, 그 기록은 TB_COM_DAUM_IMAGE에 저장되어 있다.
			 다음 에디터로 내응이 작성되고 DB에 저장이 되면 해당 내용에 대한 SEQ 값을 가져오는데, 이때 이 SEQ값을 TB_COM_DAUM_IMAGE 테이블에 저장해야한다.
			 저장해야 하는 대상의 레코드는 이미지 파일명으로 찾는다.(이미지 파일명은 고유명으로 저장하게 끔 했다.)
			 아래 내용은 daum editor에서 넘기는 attach_image_info 파라미터(들)의 filename을 추출해서 List객체로 리턴하고, 다시 donorVO.ImageList에 저장한다.
			 */
			if(surveyVO.getAttach_image_info()!=null&&!"".equals(surveyVO.getAttach_image_info())){
				surveyVO.setImageList(getEditorImageList(surveyVO.getAttach_image_info()));
			}
			/*daum_editor end*/

			if(MODE_INSERT.equalsIgnoreCase(getPersistMode)){
				returnVO = surveyService.insertSurvey(surveyVO);
			} else if(MODE_UPDATE.equalsIgnoreCase(getPersistMode)){
				returnVO = surveyService.updateSurvey(surveyVO);
			} else bResult = false;
			
			//if(bResult) resultPage += String.valueOf(returnVO.getQustnrSeq());
			
		} catch(Exception e){
			throw new CfoodException("admin.customer.survey.surveyPersist",e);
		}
		
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestName(value="deleteSurvey")
	@RequestMapping(value="/surveyDelete.do")
	public String deleteSurvey(@Validated(SurveyDeleteVal.class) SurveyVO surveyVO, BindingResult result, HttpServletRequest request, Model model) {
		
		/* Validator error */
		if(result.hasErrors()){
			// @validated 에러는 처리하지 않는다. jsp에서 이미 각 질문과 질문의 항목을 depth list로 받아오기 때문에 공백이 생긴다.
		}
		
		boolean bResult = false;
		String resultPage = "redirect:/admin/customer/survey/surveyList.do";
		
		try{
			/* get set session */
			try{
				surveyVO.setModID((String)EgovSessionCookieUtil.getSessionAttribute(request, "usrId"));
			} catch(Exception e){ throw new CfoodException("admin.customer.survey.surveyDelete.NullSessionException",e); }
			
			if(surveyService.deleteSurvey(surveyVO)>0){ bResult = true; }
			
		} catch(Exception e){
			throw new CfoodException("admin.customer.survey.surveyDelete",e);
		}
		
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestName(value="etcPop")
	@RequestMapping(value="/etcPop.do")
	public String etcPop(@Valid SurveyVO surveyVO, HttpServletRequest request, Model model)throws Exception  {

		String bizName = "모바일 설문 상세 기타의견";
		HttpUtil.printServiceLogStart(bizName, log, request);
		
		try{
			
			List<SurveyVO> resultList = surveyService.getEtcList(surveyVO);

			model.addAttribute("resultList", resultList);

		} catch (CfoodException ce) {
			throw new CfoodException("admin.system.maintenance.che_bike_list");
		}
		return "/admin/common/popup/pop_item";
	}
	
	
	
	@RequestName(value="surveyChk")
	@RequestMapping(value = "/surveyChk.do")
	public String surveyChk(@Validated(SurveyPersistVal.class) SurveyVO surveyVO, BindingResult result, HttpServletRequest request, Model model) {
		try {
			List<SurveyQestVO> listSurveyQestVO = surveyVO.getSurveyQestVO();
			for(int i=0; i<listSurveyQestVO.size(); i++){
				if(listSurveyQestVO.get(i).getQestnContent() == null || listSurveyQestVO.get(i).getQestnContent() == ""){
					model.addAttribute("returnContent","NOT");
					break;
				}else{
					model.addAttribute("returnContent","OK");
				}

				if(listSurveyQestVO.get(i).getSurveyQestItemVO().get(0).getItemContent() == null || listSurveyQestVO.get(i).getSurveyQestItemVO().get(0).getItemContent() == ""){
					model.addAttribute("returnItemContent","NOT");
					break;
				}else{
					model.addAttribute("returnItemContent","OK");
				}
			}

			model.addAttribute(RESULT_MESSAGE, "Success");
			model.addAttribute(CHECK_RESULT, 0);

		} catch (Exception e) {
			throw new CfoodException("admin.common.controller.surveyChk");
		}
		return JSONVIEW;
	}
	
}
