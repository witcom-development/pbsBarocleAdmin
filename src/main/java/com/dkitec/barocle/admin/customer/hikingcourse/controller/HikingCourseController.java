package com.dkitec.barocle.admin.customer.hikingcourse.controller;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

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
import com.dkitec.barocle.admin.customer.faq.vo.CategoryVO;
import com.dkitec.barocle.admin.customer.hikingcourse.vo.HikingCourseVO;
import com.dkitec.barocle.admin.customer.hikingcourse.vo.HikingCourseVO.HikingCourseDeleteVal;
import com.dkitec.barocle.admin.customer.hikingcourse.vo.HikingCourseVO.HikingCourseEditVal;
import com.dkitec.barocle.admin.customer.hikingcourse.vo.HikingCourseVO.HikingCourseListVal;
import com.dkitec.barocle.admin.customer.hikingcourse.vo.HikingCourseVO.HikingCoursePersistVal;
import com.dkitec.barocle.admin.customer.hikingcourse.service.HikingCourseService;
import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.WebUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="HikingCourseController")
@RequestMapping(value="/admin/customer/hikingCourse")
public class HikingCourseController extends BaseController {
	
	@Resource(name = "hikingCourseService") private HikingCourseService hikingCourseService;
	
	protected static Logger log = LoggerFactory.getLogger(HikingCourseController.class);
	
	private final String[] hikingCourseSearchParameter = {"districtCD","searchValue"};
	
	@RequestName(value="getHikingCourseList")
	@RequestMapping(value="/hikingCourseList.do")
	public String getHikingCourseList(@Validated(HikingCourseListVal.class) HikingCourseVO hikingCourseVO, BindingResult result, HttpServletRequest request, Model model) {
		
		/* validator check */
		if(result.hasErrors()){
			model.addAttribute("hikingCourseView", hikingCourseVO);
			model.addAttribute("resultError", this.setResultMessage(result));
			return "/admin/customer/hikingCourse/bor_hik_list";
		}
		
		boolean bResult = false;
		String resultPage = "/admin/customer/hikingCourse/bor_hik_list";
		
		try{
			// 총 레코드 개수를 가져온다.
			hikingCourseVO.setTotalRecordCount(hikingCourseService.listHikingCourseCount(hikingCourseVO));
			// 페이징
			PaginationInfo paginationInfo = getPagingInfo(hikingCourseVO.getCurrentPageNo(), hikingCourseVO.getTotalRecordCount());
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(hikingCourseVO.getCurrentPageNo(), hikingCourseVO.getTotalRecordCount());
			hikingCourseVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			hikingCourseVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			// 현재 화면의 정보를 지정한다.
			model.addAttribute("hikingCourseView", hikingCourseVO);
			// 현재 화면의 레코드 목록을 지정한다.
			model.addAttribute("hikingCourseList",hikingCourseService.listHikingCourse(hikingCourseVO));
			// 현재 화면의 검색 파라미터 값을 지정한다.
			model.addAttribute("parameterInfo",super.setGivenParameterValue(request,this.hikingCourseSearchParameter));
			// 현재 화면에 표시되는 페이징 정보를 지정한다.
			model.addAttribute("paginationInfo",paginationInfo);
			model.addAttribute("paginationMobileInfo",paginationMobileInfo);
			// 자치구 목록
			model.addAttribute("categoryList",hikingCourseService.listHikingCourseCategory(new CategoryVO(),"GUG"));
						
			bResult = true;		// 정상
			
		} catch (Exception e) {
			throw new CfoodException("admin.customer.hikingcourse.hikingCourseList",e);
		}
		
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestName(value="editHikingCourse")
	@RequestMapping(value="/hikingCourseEdit.do")
	public String editHikingCourse(@Validated(HikingCourseEditVal.class) HikingCourseVO hikingCourseVO, BindingResult result, HttpServletRequest request, Model model) {
		
		/* validator check */
		if(result.hasErrors()){ throw new CfoodException("admin.customer.hikingcourse.hikingCourseEdit.bindingexception"); }
		
		boolean bResult = false;
		String resultPage = "/admin/customer/hikingCourse/bor_hik_detail";
		String getPersistMode = hikingCourseVO.getMode();
		
		try{
			Map<String,HikingCourseVO> returnMap = hikingCourseService.viewHikingCourse(hikingCourseVO);
			HikingCourseVO hikingCourseView = new HikingCourseVO();
			
			hikingCourseView.setMode(MODE_INSERT);		// default mode
			
			if(MODE_VIEW.equalsIgnoreCase(getPersistMode)){
				//model.addAttribute("prevHikingCourseView",(HikingCourseVO)returnMap.get("prevHikingCourseVO"));	// 이전 공지사항
				//model.addAttribute("nextHikingCourseView",(HikingCourseVO)returnMap.get("nextHikingCourseVO"));	// 다음 공지사항
			} else if(MODE_EDIT.equalsIgnoreCase(getPersistMode)){
				hikingCourseView = returnMap.get("returnVO");
				hikingCourseView.setMode(MODE_UPDATE);
				resultPage = "/admin/customer/hikingCourse/bor_hik_detail";
				model.addAttribute("daumEditorImageList", hikingCourseService.listDaumEditorVO(hikingCourseVO));
			} else bResult = false;
			
			// 현재 화면를 가져온다.
			hikingCourseView.setCurrentPageNo(hikingCourseVO.getCurrentPageNo());
			
			// 현재 화면의 검색 파라미터 값을 지정한다.
			model.addAttribute("parameterInfo",super.setGivenParameterValue(request,this.hikingCourseSearchParameter));
			model.addAttribute("hikingCourseView",hikingCourseView);		// 공지사항 내용
			
			// 자치구 목록
			model.addAttribute("categoryList",hikingCourseService.listHikingCourseCategory(new CategoryVO(),"GUG"));
			
			bResult = true;		// 정상
			
		} catch (Exception e){
			throw new CfoodException("admin.customer.hikingcourse.hikingCourseEdit",e);
		}
		
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestName(value="persistHikingCourse")
	@RequestMapping(value={"/hikingCourseInsert.do","/hikingCourseUpdate.do"})
	public String persistHikingCourse(@Validated(HikingCoursePersistVal.class) HikingCourseVO hikingCourseVO, BindingResult result, HttpServletRequest request, Model model) {
		
		/* Validator error */
		if(result.hasErrors()){
			model.addAttribute("hikingCourseView", hikingCourseVO);
			model.addAttribute("categoryList",hikingCourseService.listHikingCourseCategory(new CategoryVO(),"GUG"));
			model.addAttribute("resultError", this.setResultMessage(result));
			return "/admin/customer/hikingCourse/bor_hik_detail";
		}
		
		boolean bResult = false;
		String resultPage = "redirect:/admin/customer/hikingCourse/hikingCourseEdit.do?mode=edit&hikingCourseSeq=";
		String getPersistMode = hikingCourseVO.getMode();
		
		/* check uri */
		String requestURI = (String)request.getRequestURI().toString();
		if(requestURI.indexOf("/hikingCourseInsert.do")>0){ getPersistMode = MODE_INSERT; } 
		else if(requestURI.indexOf("/hikingCourseUpdate.do")>0){ getPersistMode = MODE_UPDATE; }
		else { throw new CfoodException("admin.customer.hikingcourse.hikingCoursePersist.NullModeException"); }
		
		try{
			/* get set session */
			try{
				hikingCourseVO.setRegID((String)EgovSessionCookieUtil.getSessionAttribute(request, "usrId"));
				hikingCourseVO.setModID((String)EgovSessionCookieUtil.getSessionAttribute(request, "usrId"));
			} catch(Exception e) { throw new CfoodException("admin.customer.hikingcourse.hikingCoursePersist.NullSessionException",e); }
			
			HikingCourseVO returnVO = null;
			bResult = true;		// 정상
			
			/*
			다음 에디터에서 내용은 hikingCourseHTMLContent에 저장되어 들어온다. hikingCourseHTMLContent내용은 html태그가 포함되어 있다.
			NOTICE_TEXT_CONTENT AS hikingCourseTextContent : <img>를 제외한 모든 테그를 삭제하여 저장한다.
			NOTICE_HTML_CONTENT AS hikingCourseHTMLContent : 모든 html 태그를 포함한다.
			 */
			hikingCourseVO.setHikingCourseTextContent(WebUtil.removeHTMLSpecialChars(WebUtil.replaceHTMLSpecialChars(hikingCourseVO.getHikingCourseHTMLContent()), ""));
			
			/*
			 hikingCourseHTMLContent에서 img value를 모두 가녀온다.  해당 img값/값들로 TB_COM_DAUM_IMAGE 테이블에 매핑한다.
			 다음 에디터는 내용을 DB에 저장하기 전에 popup창으로 이미지를 먼저 등록한다. 이 과정에서 우선적으로 이미지 파일은 서버에 업로드 되어 있고, 그 기록은 TB_COM_DAUM_IMAGE에 저장되어 있다.
			 다음 에디터로 내응이 작성되고 DB에 저장이 되면 해당 내용에 대한 SEQ 값을 가져오는데, 이때 이 SEQ값을 TB_COM_DAUM_IMAGE 테이블에 저장해야한다.
			 저장해야 하는 대상의 레코드는 이미지 파일명으로 찾는다.(이미지 파일명은 고유명으로 저장하게 끔 했다.)
			 아래 내용은 daum editor에서 넘기는 attach_image_info 파라미터(들)의 filename을 추출해서 List객체로 리턴하고, 다시 hikingCourseVO.ImageList에 저장한다.
			 */
			if(hikingCourseVO.getAttach_image_info()!=null&&!"".equals(hikingCourseVO.getAttach_image_info())){
				hikingCourseVO.setImageList(getEditorImageList(hikingCourseVO.getAttach_image_info()));
			}
			
			// 현재 모드를 확인하여 해당 persist를 실행
			if(MODE_INSERT.equalsIgnoreCase(getPersistMode)){
				returnVO = hikingCourseService.insertHikingCourse(hikingCourseVO);
			} else if(MODE_UPDATE.equalsIgnoreCase(getPersistMode)){
				returnVO = hikingCourseService.updateHikingCourse(hikingCourseVO);
			} else bResult = false;
			
			if(bResult) resultPage += String.valueOf(returnVO.getHikingCourseSeq());
			
		} catch(Exception e){
			throw new CfoodException("admin.customer.hikingcourse.hikingCoursePersist",e);
		}
		
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestName(value="deleteHikingCourse")
	@RequestMapping(value="/hikingCourseDelete.do")
	public String deleteHikingCourse(@Validated(HikingCourseDeleteVal.class) HikingCourseVO hikingCourseVO, BindingResult result, HttpServletRequest request, Model model) {
		
		/* validator check */
		if(result.hasErrors()){
			model.addAttribute("resultError", "권한이 없습니다.");
			throw new CfoodException("admin.customer.hikingcourse.hikingCourseDelete.bindingexception");
		}
		
		boolean bResult = false;
		String resultPage = "redirect:/admin/customer/hikingCourse/hikingCourseList.do";
		
		try{
			/* get set session */
			try{
				hikingCourseVO.setModID((String)EgovSessionCookieUtil.getSessionAttribute(request, "usrId"));
			} catch(Exception ce) { throw new CfoodException("admin.customer.hikingcourse.hikingCourseDelete.NullSessionException"); }
			
			if(hikingCourseService.deleteHikingCourse(hikingCourseVO)>0){ bResult = true; }
			
		} catch(Exception e){
			throw new CfoodException("admin.customer.hikingcourse.hikingCourseDelete",e);
		}
		
		return bResult ? resultPage : ERROR_PAGE;
	}
	
}
