package com.dkitec.barocle.admin.customer.faq.controller;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

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
import org.springframework.web.bind.annotation.RequestParam;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.dkitec.barocle.admin.customer.faq.vo.CategoryVO;
import com.dkitec.barocle.admin.customer.faq.vo.CategoryVO.CategoryPersistVal;
import com.dkitec.barocle.admin.customer.faq.vo.FaqVO;
import com.dkitec.barocle.admin.customer.faq.vo.FaqVO.FaqDeleteVal;
import com.dkitec.barocle.admin.customer.faq.vo.FaqVO.FaqEditVal;
import com.dkitec.barocle.admin.customer.faq.vo.FaqVO.FaqListVal;
import com.dkitec.barocle.admin.customer.faq.vo.FaqVO.FaqPersistVal;
import com.dkitec.barocle.admin.customer.faq.service.FaqService;
import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.base.IConstants;
import com.dkitec.barocle.util.webutil.StringUtil;
import com.dkitec.barocle.util.webutil.WebUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="FaqController")
@RequestMapping(value="/admin/customer/faq")
public class FaqController extends BaseController {
	
	@Resource(name = "faqService") private FaqService faqService;
	
	protected static Logger log = LoggerFactory.getLogger(FaqController.class);
	
	private final String[] faqSearchParameter = {"cateCD","searchValue"};
	
	@RequestName(value="getFaqList")
	@RequestMapping(value="/faqList.do")
	public String getFaqList(@Validated(FaqListVal.class) FaqVO faqVO, BindingResult result, HttpServletRequest request, Model model) {
		
		/* validator check */
		if(result.hasErrors()){
			model.addAttribute("faqView", faqVO);
			model.addAttribute("resultError", super.setResultMessage(result));
			return "/admin/customer/faq/bor_faq_list";
		}
		
		boolean bResult = false;
		String resultPage = "/admin/customer/faq/bor_faq_list";
		
		try{
			// 총 레코드 개수를 가져온다.
			faqVO.setTotalRecordCount(faqService.listFaqCount(faqVO));
			// 페이징
			PaginationInfo paginationInfo = getPagingInfo(faqVO.getCurrentPageNo(), faqVO.getTotalRecordCount());
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(faqVO.getCurrentPageNo(), faqVO.getTotalRecordCount());
			faqVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			faqVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			// 현재 화면의 정보를 지정한다.
			model.addAttribute("faqView", faqVO);
			// 현재 화면의 레코드 목록을 지정한다.
			model.addAttribute("faqList",faqService.listFaq(faqVO));
			// 현재 화면의 검색 파라미터 값을 지정한다.
			model.addAttribute("parameterInfo",super.setGivenParameterValue(request,this.faqSearchParameter));
			// 현재 화면에 표시되는 페이징 정보를 지정한다.
			model.addAttribute("paginationInfo",paginationInfo);
			model.addAttribute("paginationMobileInfo",paginationMobileInfo);
			// 카테고리 목록
			model.addAttribute("categoryList",faqService.listFaqCategory(new CategoryVO(),"FAQ"));
			
			bResult = true;		// 정상
			
		} catch (Exception e) {
			throw new CfoodException("admin.customer.faq.faqList",e);
		}
		
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestName(value="editFaq")
	@RequestMapping(value="/faqEdit.do")
	public String editFaq(@Validated(FaqEditVal.class) FaqVO faqVO, BindingResult result, HttpServletRequest request, Model model) {
		
		/* validator check */
		if(result.hasErrors()){ throw new CfoodException("admin.customer.faq.faqEdit.bindingexception"); }
		
		boolean bResult = false;
		String resultPage = "/admin/customer/faq/bor_faq_detail";
		String getPersistMode = faqVO.getMode();
		
		try{
			Map<String,FaqVO> returnMap = faqService.viewFaq(faqVO);
			
			FaqVO faqView = new FaqVO();
			
			faqView.setMode(MODE_INSERT);
			
			if(MODE_VIEW.equalsIgnoreCase(getPersistMode)){
				//model.addAttribute("prevFaqView",(FaqVO)returnMap.get("prevFaqVO"));	// 이전 공지사항
				//model.addAttribute("nextFaqView",(FaqVO)returnMap.get("nextFaqVO"));	// 다음 공지사항
			} else if(MODE_EDIT.equalsIgnoreCase(getPersistMode)){
				faqView = returnMap.get("returnVO");
				faqView.setMode(MODE_UPDATE);
				resultPage = "/admin/customer/faq/bor_faq_detail";
				model.addAttribute("daumEditorImageList", faqService.listDaumEditorVO(faqVO));
			} else bResult = false;
			
			// 현재 화면를 가져온다.
			faqView.setCurrentPageNo(faqVO.getCurrentPageNo());
			
			// 현재 화면의 검색 파라미터 값을 지정한다.
			model.addAttribute("parameterInfo",super.setGivenParameterValue(request,this.faqSearchParameter));
			model.addAttribute("faqView",faqView);		// 공지사항 내용
			
			// 카테고리 목록
			model.addAttribute("categoryList",faqService.listFaqCategory(new CategoryVO(),"FAQ"));
						
			bResult = true;		// 정상
			
		} catch (Exception e){
			throw new CfoodException("admin.customer.faq.faqEdit",e);
		}
		
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestName(value="persistFaq")
	@RequestMapping(value={"/faqInsert.do","faqUpdate.do"})
	public String persistFaq(@Validated(FaqPersistVal.class) FaqVO faqVO, BindingResult result, HttpServletRequest request, Model model) {
		
		/* Validator error */
		if(result.hasErrors()){
			model.addAttribute("faqView", faqVO);
			try {
				model.addAttribute("categoryList",faqService.listFaqCategory(new CategoryVO(),"FAQ"));
			} catch (Exception e) { throw new CfoodException("admin.customer.faq.faqPersist.bindingexception",e); }
			model.addAttribute("resultError", super.setResultMessage(result));
			return "/admin/customer/faq/bor_faq_detail";
		}
		
		boolean bResult = false;
		String resultPage = "redirect:/admin/customer/faq/faqEdit.do?mode=edit&faqSeq=";
		String getPersistMode = faqVO.getMode();
		
		/* check uri */
		String requestURI = (String)request.getRequestURI().toString();
		if(requestURI.indexOf("/faqInsert.do")>0){ getPersistMode = MODE_INSERT; } 
		else if(requestURI.indexOf("/faqUpdate.do")>0){ getPersistMode = MODE_UPDATE; }
		else { throw new CfoodException("admin.customer.faq.faqPersist.NullModeException"); }
		
		try{
			/* get set session */
			try{
				faqVO.setRegID((String)EgovSessionCookieUtil.getSessionAttribute(request, "usrId"));
				faqVO.setModID((String)EgovSessionCookieUtil.getSessionAttribute(request, "usrId"));
			} catch(Exception e) { throw new CfoodException("admin.customer.faq.faqPersist.NullSessionException",e); }
			
			FaqVO returnVO = null;
			bResult = true;		// 정상
			
			/*
			다음 에디터에서 내용은 answerHTMLContent에 저장되어 들어온다. answerHTMLContent내용은 html태그가 포함되어 있다.
			NOTICE_TEXT_CONTENT AS faqTextContent : <img>를 제외한 모든 테그를 삭제하여 저장한다.
			NOTICE_HTML_CONTENT AS faqHTMLContent : 모든 html 태그를 포함한다.
			 */
			faqVO.setAnswerTextContent(WebUtil.removeHTMLSpecialChars(WebUtil.replaceHTMLSpecialChars(faqVO.getAnswerHTMLContent()), ""));
			
			/*
			answerHTMLContent에서 img value를 모두 가녀온다. 해당 img값/값들로 TB_COM_DAUM_IMAGE 테이블에 매핑한다.
			다음 에디터는 내용을 DB에 저장하기 전에 popup창으로 이미지를 먼저 등록한다. 이 과정에서 우선적으로 이미지 파일은 서버에 업로드 되어 있고, 그 기록은 TB_COM_DAUM_IMAGE에 저장되어 있다.
			다음 에디터로 내응이 작성되고 DB에 저장이 되면 해당 내용에 대한 SEQ 값을 가져오는데, 이때 이 SEQ값을 TB_COM_DAUM_IMAGE 테이블에 저장해야한다.
			저장해야 하는 대상의 레코드는 이미지 파일명으로 찾는다.(이미지 파일명은 고유명으로 저장하게 끔 했다.)
			아래 내용은 daum editor에서 넘기는 attach_image_info 파라미터(들)의 filename을 추출해서 List객체로 리턴하고, 다시 faqVO.ImageList에 저장한다.
			 */
			if(faqVO.getAttach_image_info()!=null&&!"".equals(faqVO.getAttach_image_info())){
				faqVO.setImageList(getEditorImageList(faqVO.getAttach_image_info()));
			}
			
			faqVO.setQestnContent(faqVO.getQestnTitle());
			
			/*
			FAQ는 각 카테고리 마다 출력순서(qestnOrder)가 존재한다. 기본 출력 순서는 해당 카테고리의 마지막 순서이다.
			이 출력순서는 관리자 임의로 수정이 가능한데, 해당 컨텐츠의 출력순서를 정상적으로 반영할려면 해당 카테고리의 모든 출력순서를 재정의 해야 한다.
			주의 : 각 카테고리(ex> FAQ_001, FAQ_002...)마다 순서가 존재하며 이는 서로 독립적이다.
			 */
			// 해당 로직은 service단에서 처리한다!!!!
			
			// 현재 모드를 확인하여 해당 persist를 실행
			if(MODE_INSERT.equalsIgnoreCase(getPersistMode)){
				returnVO = faqService.insertFaq(faqVO);
			} else if(MODE_UPDATE.equalsIgnoreCase(getPersistMode)){
				returnVO = faqService.updateFaq(faqVO);
			} else bResult = false;
			
			if(bResult) resultPage += String.valueOf(returnVO.getFaqSeq());
			
		} catch(Exception e){
			throw new CfoodException("admin.customer.faq.faqPersist",e);
		}
		
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestName(value="deleteFaq")
	@RequestMapping(value="/faqDelete.do")
	public String deleteFaq(@Validated(FaqDeleteVal.class) FaqVO faqVO, BindingResult result, HttpServletRequest request, Model model) {
		
		/* validator check */
		if(result.hasErrors()){
			model.addAttribute("resultError", "권한이 없습니다.");
			throw new CfoodException("admin.customer.faq.faqDelete.bindingexception");
		}
		
		boolean bResult = false;
		String resultPage = "redirect:/admin/customer/faq/faqList.do";
		
		try{
			/* get set session */
			try{
				faqVO.setModID((String)EgovSessionCookieUtil.getSessionAttribute(request, "usrId"));
			} catch(Exception e) {
				throw new CfoodException("admin.customer.faq.faqDelete.NullSessionException",e);
			}
			
			if(faqService.deleteFaq(faqVO)>0){ bResult = true; }
			
		} catch(Exception e){
			throw new CfoodException("admin.customer.faq.faqDelete",e);
		}
		
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestName(value="getFaqCategoryInfo")
	@RequestMapping(value="/faqCategoryInfo.do", method=RequestMethod.GET)
	public String getFaqCategoryInfo(@RequestParam("cateCD") String cateCD, Model model) {
		Map<String,String> returnMap = null;
		try{
			returnMap = faqService.getFaqCategoryInfo(cateCD);
			model.addAttribute("totalCount", String.valueOf(returnMap.get("totalCount")));
			model.addAttribute("nextCount", String.valueOf(returnMap.get("nextCount")));
		} catch (Exception e){
			throw new CfoodException("admin.customer.faq.getFaqCategoryInfo",e);
		}
		return JSONVIEW;
	}
	
	@RequestName("getCategoryPopUp")
	@RequestMapping(value="/getCategoryPopUp.do")
	public String getCategoryPopUp(HttpServletRequest request, Model model) {
		return "/admin/common/popup/pop_cate_list";
	}
	
	@RequestName("getCategorySelectionList")
	@RequestMapping(value="/getCategorySelectionList.do")
	public String getCategorySelectionList(@ModelAttribute CategoryVO categoryVO, HttpServletRequest request, Model model) {
		try{
			// 다국어 언어 설정
			if(!StringUtil.isEmpty(request.getParameter("mLang"))){
				categoryVO.setLangClsCD((String)request.getParameter("mLang"));
			} else { categoryVO.setLangClsCD(LANG_KR); }
			model.addAttribute("dataList",faqService.getCategorySelectionList(categoryVO));
		} catch (Exception e){
			throw new CfoodException("admin.customer.faq.getCategorySelectionList",e);
		}
		return IConstants.JSONVIEW;
	}
	
	@RequestName("getCategorySelectedList")
	@RequestMapping(value="/getCategorySelectedList.do")
	public String getCategorySelectedList(@ModelAttribute CategoryVO categoryVO, HttpServletRequest request, ModelMap model) {
		try{
			categoryVO.setComUpCD("FAQ");
			// 다국어 언어 설정
			if(!StringUtil.isEmpty(request.getParameter("mLang"))){
				categoryVO.setLangClsCD((String)request.getParameter("mLang"));
			} else { categoryVO.setLangClsCD(LANG_KR); }
			model.addAttribute("dataList",faqService.getCategorySelectedList(categoryVO));
		} catch (Exception e){
			throw new CfoodException("admin.customer.faq.getCategorySelectedList",e);
		}
		return IConstants.JSONVIEW;
	}
	
	@RequestName("persistCategory")
	@RequestMapping(value="/persistCategory.do")
	public String persistCategory(@Validated(CategoryPersistVal.class) CategoryVO categoryVO, @RequestParam("mode") String mode, HttpServletRequest request, Model model) {
		try{
			String result = "등록하였습니다.";
			// 다국어 언어 설정
			if(!StringUtil.isEmpty(request.getParameter("mLang"))){
				categoryVO.setLangClsCD((String)request.getParameter("mLang"));
			} else { categoryVO.setLangClsCD(LANG_KR); }
			
			categoryVO.setRegID((String)EgovSessionCookieUtil.getSessionAttribute(request, "usrId"));
			categoryVO.setCdDesc1(categoryVO.getmLangComCDName());
			// insert ? update
			if(MODE_INSERT.equals(mode)){
				faqService.insertCategory(categoryVO);
			} else if (MODE_UPDATE.equals(mode)){
				faqService.updateCategory(categoryVO);
				result = "수정하였습니다";
			} else {
				//throw new CfoodException("admin.customer.faq.persistCategory.NullModeException");
				result = "실패하였습니다.";
			}
			model.addAttribute("resultMessage",result);
		} catch (Exception e){
			e.printStackTrace();
			throw new CfoodException("admin.customer.faq.persistCategory",e);
		}
		return IConstants.JSONVIEW;
	}
	
}
