package com.dkitec.barocle.admin.customer.opinionboard.controller;

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
import org.springframework.web.bind.annotation.RequestMapping;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.dkitec.barocle.admin.customer.opinionboard.vo.OpinionBoardVO;
import com.dkitec.barocle.admin.customer.opinionboard.vo.OpinionBoardVO.OpinionBoardDeleteVal;
import com.dkitec.barocle.admin.customer.opinionboard.vo.OpinionBoardVO.OpinionBoardEditVal;
import com.dkitec.barocle.admin.customer.opinionboard.vo.OpinionBoardVO.OpinionBoardListVal;
import com.dkitec.barocle.admin.customer.opinionboard.vo.OpinionBoardVO.OpinionBoardPersistVal;
import com.dkitec.barocle.admin.customer.opinionboard.service.OpinionBoardService;
import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.HttpUtil;
import com.dkitec.barocle.util.webutil.WebUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="OpinionBoardController")
@RequestMapping(value="/admin/customer/opinionBoard")
public class OpinionBoardController extends BaseController {
	
	@Resource(name = "opinionBoardService") private OpinionBoardService opinionBoardService;
	
	protected static Logger log = LoggerFactory.getLogger(OpinionBoardController.class);
	
	private final String[] opinionBoardSearchParameter = {"searchValue","searchStartDate","searchEndDate","qnaProcessStusCD", "comCd"};
	
	@RequestName(value="getOpinionBoardList")
	@RequestMapping(value="/opinionBoardList.do")
	public String getOpinionBoardList(@Validated(OpinionBoardListVal.class) OpinionBoardVO opinionBoardVO, BindingResult result, HttpServletRequest request, Model model) {
		
		/* validator check */
		if(result.hasErrors()){
			model.addAttribute("opinionBoardView", opinionBoardVO);
			model.addAttribute("resultError", this.setResultMessage(result));
			return "/admin/customer/opinionBoard/bor_opi_list";
		}
		
		boolean bResult = false;
		String resultPage = "/admin/customer/opinionBoard/bor_opi_list";
		
		try{
			// 총 레코드 개수를 가져온다.
			opinionBoardVO.setTotalRecordCount(opinionBoardService.listOpinionBoardCount(opinionBoardVO));
			// 페이징
			PaginationInfo paginationInfo = getPagingInfo(opinionBoardVO.getCurrentPageNo(), 15,15, opinionBoardVO.getTotalRecordCount());
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(opinionBoardVO.getCurrentPageNo(), opinionBoardVO.getTotalRecordCount());
			opinionBoardVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			opinionBoardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			//시민의견수렴 구분값
			model.addAttribute("gubun",opinionBoardService.gubunList());
			// 현재 화면의 정보를 지정한다.
			model.addAttribute("opinionBoardView", opinionBoardVO);
			// 현재 화면의 레코드 목록을 지정한다.
			model.addAttribute("opinionBoardList",opinionBoardService.listOpinionBoard(opinionBoardVO));
			// 현재 화면의 검색 파라미터 값을 지정한다.
			model.addAttribute("parameterInfo",super.setGivenParameterValue(request,this.opinionBoardSearchParameter));
			// 현재 화면에 표시되는 페이징 정보를 지정한다.
			model.addAttribute("paginationInfo",paginationInfo);
			model.addAttribute("paginationMobileInfo",paginationMobileInfo);
			
			bResult = true;		// 정상
			
		} catch (Exception e) {
			throw new CfoodException("admin.customer.opinionboard.opinionBoardList",e);
		}
		
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestName(value="editOpinionBoard")
	@RequestMapping(value="/opinionBoardEdit.do")
	public String editOpinionBoard(@Validated(OpinionBoardEditVal.class) OpinionBoardVO opinionBoardVO, BindingResult result, HttpServletRequest request, Model model) {
		
		/* validator check */
		if(result.hasErrors()){ throw new CfoodException("admin.customer.opinionboard.opinionBoardEdit.bindingexception"); }
		
		boolean bResult = false;
		String resultPage = "/admin/customer/opinionBoard/bor_opi_detail";
		String getPersistMode = opinionBoardVO.getMode();
		String homeURL			=  super.propertiesService.getString("homeURL");
		
		try{
			Map<String,OpinionBoardVO> returnMap = opinionBoardService.viewOpinionBoard(opinionBoardVO);
			OpinionBoardVO opinionBoardView = new OpinionBoardVO();
			
			opinionBoardView.setMode(MODE_INSERT);
			
			if(MODE_VIEW.equalsIgnoreCase(getPersistMode)){
				//model.addAttribute("prevOpinionBoardView",(OpinionBoardVO)returnMap.get("prevOpinionBoardVO"));	// 이전 공지사항
				//model.addAttribute("nextOpinionBoardView",(OpinionBoardVO)returnMap.get("nextOpinionBoardVO"));	// 다음 공지사항
			}
			if(MODE_EDIT.equalsIgnoreCase(getPersistMode)){
				opinionBoardView = returnMap.get("returnVO");
				opinionBoardView.setMode(MODE_UPDATE);
				resultPage = "/admin/customer/opinionBoard/bor_opi_detail";
				model.addAttribute("daumEditorImageList", opinionBoardService.listDaumEditorVO(opinionBoardVO));
			} else bResult = false;
			
			// 현재 화면를 가져온다.
			opinionBoardView.setCurrentPageNo(opinionBoardVO.getCurrentPageNo());
			
			//시민의견수렴 구분값
			model.addAttribute("gubun",opinionBoardService.gubunList());
			
			// 현재 화면의 검색 파라미터 값을 지정한다.
			model.addAttribute("parameterInfo",super.setGivenParameterValue(request,this.opinionBoardSearchParameter));
			model.addAttribute("opinionBoardView",opinionBoardView);		// 공지사항 내용
			model.addAttribute("homeURL", homeURL);
			
			bResult = true;		// 정상
			
		} catch (Exception e){
			throw new CfoodException("admin.customer.opinionboard.opinionBoardEdit",e);
		}
		
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestName(value="persistOpinionBoard")
	@RequestMapping(value={"/opinionBoardInsert.do","/opinionBoardUpdate.do"})
	public String persistOpinionBoard(@Validated(OpinionBoardPersistVal.class) OpinionBoardVO opinionBoardVO, BindingResult result, HttpServletRequest request, Model model) {
		
		/* Validator error */
		if(result.hasErrors()){
			model.addAttribute("opinionBoardView", opinionBoardVO);
			model.addAttribute("resultError", this.setResultMessage(result));
			return "/admin/customer/opinionBoard/bor_opi_detail";
		}
		
		boolean bResult = false;
		String resultPage = "redirect:/admin/customer/opinionBoard/opinionBoardEdit.do?mode=edit&qnaSeq=";
		String getPersistMode = opinionBoardVO.getMode();
		
		/* check uri */
		String requestURI = (String)request.getRequestURI().toString();
		if(requestURI.indexOf("/opinionBoardInsert.do")>0){
			getPersistMode = MODE_INSERT; 
			} 
		else if(requestURI.indexOf("/opinionBoardUpdate.do")>0){
			getPersistMode = MODE_UPDATE; 
			}
		else { 
			throw new CfoodException("admin.customer.opinionboard.opinionboardPersist.NullModeException");
			}
		
		try{
			/* get set session */
			try{
				opinionBoardVO.setRegID((String)EgovSessionCookieUtil.getSessionAttribute(request, "usrId"));
				opinionBoardVO.setModID((String)EgovSessionCookieUtil.getSessionAttribute(request, "usrId"));
			} catch(Exception e){ throw new CfoodException("admin.customer.opinionboard.opinionBoardPersist.NullSessionException",e); }
			
			OpinionBoardVO returnVO = null;
			bResult = true;		// 정상
			
			/*
			다음 에디터에서 내용은 answerHTMLContent에 저장되어 들어온다. answerHTMLContent내용은 html태그가 포함되어 있다.
			NOTICE_TEXT_CONTENT AS opinionBoardTextContent : <img>를 제외한 모든 테그를 삭제하여 저장한다.
			NOTICE_HTML_CONTENT AS opinionBoardHTMLContent : 모든 html 태그를 포함한다.
			 */
			opinionBoardVO.setAnswerTextContent(WebUtil.removeHTMLSpecialChars(WebUtil.replaceHTMLSpecialChars(opinionBoardVO.getAnswerHTMLContent()), ""));
			
			/*
			 answerHTMLContent에서 img value를 모두 가녀온다.  해당 img값/값들로 TB_COM_DAUM_IMAGE 테이블에 매핑한다.
			 다음 에디터는 내용을 DB에 저장하기 전에 popup창으로 이미지를 먼저 등록한다. 이 과정에서 우선적으로 이미지 파일은 서버에 업로드 되어 있고, 그 기록은 TB_COM_DAUM_IMAGE에 저장되어 있다.
			 다음 에디터로 내응이 작성되고 DB에 저장이 되면 해당 내용에 대한 SEQ 값을 가져오는데, 이때 이 SEQ값을 TB_COM_DAUM_IMAGE 테이블에 저장해야한다.
			 저장해야 하는 대상의 레코드는 이미지 파일명으로 찾는다.(이미지 파일명은 고유명으로 저장하게 끔 했다.)
			 아래 내용은 daum editor에서 넘기는 attach_image_info 파라미터(들)의 filename을 추출해서 List객체로 리턴하고, 다시 opinionBoardVO.ImageList에 저장한다.
			 */
			if(opinionBoardVO.getAttach_image_info()!=null&&!"".equals(opinionBoardVO.getAttach_image_info())){
				opinionBoardVO.setImageList(getEditorImageList(opinionBoardVO.getAttach_image_info()));
			}
			
			// 현재 qnaSeq를 가지고 TB_COM_QNA_INFO_REPLY에 존재하는지 확인한다. 존재하면 QNA_ANSWER_SEQ값을 가지고 와서 update를하고 그렇지 않으면 insert한다.
			if((int)opinionBoardService.getOpinionBoardReply(opinionBoardVO)>0){ getPersistMode = MODE_UPDATE; } 
			else getPersistMode = MODE_INSERT;
			
			// 현재 모드를 확인하여 해당 persist를 실행
			if(MODE_INSERT.equalsIgnoreCase(getPersistMode)){
				returnVO = opinionBoardService.insertOpinionBoard(opinionBoardVO);
			} else if(MODE_UPDATE.equalsIgnoreCase(getPersistMode)){
				returnVO = opinionBoardService.updateOpinionBoard(opinionBoardVO);
			} else bResult = false;
			
			if(bResult) resultPage += String.valueOf(returnVO.getQnaSeq());
			
		} catch(Exception e){
			throw new CfoodException("admin.customer.opinionboard.opinionBoardPersist",e);
		}
		
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestName(value="deleteOpinionBoard")
	@RequestMapping(value="/opinionBoardDelete.do")
	public String deleteOpinionBoard(@Validated(OpinionBoardDeleteVal.class) OpinionBoardVO opinionBoardVO, HttpServletRequest request, BindingResult result, Model model) {
		
		/* validator check */
		if(result.hasErrors()){
			model.addAttribute("resultError", "권한이 없습니다.");
			throw new CfoodException("admin.customer.opinionboard.opinionBoardDelete.bindingexception");
		}
		
		boolean bResult = false;
		String resultPage = "redirect:/admin/customer/opinionBoard/opinionBoardList.do";
		
		try{
			/* get set session */
			try{
				opinionBoardVO.setModID((String)EgovSessionCookieUtil.getSessionAttribute(request, "usrId"));
			} catch(Exception e){ 
				throw new CfoodException("admin.customer.opinionboard.opinionBoardDelete.NullSessionException",e); 
			}
			
			if(opinionBoardService.deleteOpinionBoard(opinionBoardVO)>0){ 
				bResult = true; 
			}
			
		} catch(Exception e){
			throw new CfoodException("admin.customer.opinionboard.opinionBoardDelete",e);
		}
		
		return bResult ? resultPage : ERROR_PAGE;
	}
	// 담당자 등록
	@RequestName(value="regAdminAjax")
	@RequestMapping(value="/regAdminAjax.do")
	public String regAdminAjax(@Validated(OpinionBoardDeleteVal.class) OpinionBoardVO opinionBoardVO, BindingResult bResult, ModelMap model, HttpServletRequest request) {
		
		String bizName = "담당자 등록";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		model.addAttribute(RESULT_MESSAGE, "fail");
		
		if(opinionBoardService.insertAdminInfo(opinionBoardVO)>0){
			model.addAttribute(RESULT_MESSAGE, "Success");
			model.addAttribute(CHECK_RESULT, 0);
		}		
		
		return JSONVIEW;
		
	}
	//답변기한 수정 등록 
	@RequestName(value="deadlineAjax")
	@RequestMapping(value="/deadlineAjax.do")
	public String deadlineAjax(@Validated(OpinionBoardDeleteVal.class) OpinionBoardVO opinionBoardVO, BindingResult bResult, ModelMap model, HttpServletRequest request) {
		
		String bizName = "답변기한 수정";
		HttpUtil.printServiceLogStart(bizName, log, request);	// 서비스로그 시작 출력
		
		model.addAttribute(RESULT_MESSAGE, "fail");
		
		if(opinionBoardService.insertDeadline(opinionBoardVO)>0){
			model.addAttribute(RESULT_MESSAGE, "Success");
			model.addAttribute(CHECK_RESULT, 0);
		}		
		
		return JSONVIEW;
		
	}
	
}
