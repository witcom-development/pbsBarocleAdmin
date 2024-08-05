package com.dkitec.barocle.admin.customer.photogallery.controller;

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
import com.dkitec.barocle.admin.customer.photogallery.vo.PhotoGalleryVO;
import com.dkitec.barocle.admin.customer.photogallery.vo.PhotoGalleryVO.PhotoGalleryDeleteVal;
import com.dkitec.barocle.admin.customer.photogallery.vo.PhotoGalleryVO.PhotoGalleryEditVal;
import com.dkitec.barocle.admin.customer.photogallery.vo.PhotoGalleryVO.PhotoGalleryListVal;
import com.dkitec.barocle.admin.customer.photogallery.vo.PhotoGalleryVO.PhotoGalleryPersistVal;
import com.dkitec.barocle.admin.customer.photogallery.service.PhotoGalleryService;
import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.WebUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="PhotoGalleryController")
@RequestMapping(value="/admin/customer/photoGallery")
public class PhotoGalleryController extends BaseController {
	
	@Resource(name = "photoGalleryService") private PhotoGalleryService photoGalleryService;
	
	protected static Logger log = LoggerFactory.getLogger(PhotoGalleryController.class);
	
	private final String[] photoGallerySearchParameter = {"searchValue","searchStartDate","searchEndDate"};
	
	@RequestName(value="getPhotoGalleryList")
	@RequestMapping(value="/photoGalleryList.do")
	public String getPhotoGalleryList(@Validated(PhotoGalleryListVal.class) PhotoGalleryVO photoGalleryVO, BindingResult result, HttpServletRequest request, Model model) {
		
		/* validator check */
		if(result.hasErrors()){
			model.addAttribute("photoGalleryView", photoGalleryVO);
			model.addAttribute("resultError", super.setResultMessage(result));
			return "/admin/customer/photoGallery/bor_pho_list";
		}
		
		boolean bResult = false;
		String resultPage = "/admin/customer/photoGallery/bor_pho_list";
		
		try{
			// 총 레코드 개수를 가져온다.
			photoGalleryVO.setTotalRecordCount(photoGalleryService.listPhotoGalleryCount(photoGalleryVO));
			// 페이징
			PaginationInfo paginationInfo = getPagingInfo(photoGalleryVO.getCurrentPageNo(), super.propertiesService.getInt("pglrRcrdSize"), super.propertiesService.getInt("pglrPgSize"), photoGalleryVO.getTotalRecordCount());
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(photoGalleryVO.getCurrentPageNo(), photoGalleryVO.getTotalRecordCount());
			photoGalleryVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			photoGalleryVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			// 현재 화면의 정보를 지정한다.
			model.addAttribute("photoGalleryView", photoGalleryVO);
			// 현재 화면의 레코드 목록을 지정한다.
			model.addAttribute("photoGalleryList",photoGalleryService.listPhotoGallery(photoGalleryVO));
			// 현재 화면의 검색 파라미터 값을 지정한다.
			model.addAttribute("parameterInfo",super.setGivenParameterValue(request,this.photoGallerySearchParameter));
			// 현재 화면에 표시되는 페이징 정보를 지정한다.
			model.addAttribute("paginationInfo",paginationInfo);
			model.addAttribute("paginationMobileInfo",paginationMobileInfo);
			
			bResult = true;		// 정상
			
		} catch (Exception e) {
			throw new CfoodException("admin.customer.photogallery.photoGalleryList",e);
		}
		
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestName(value="editPhotoGallery")
	@RequestMapping(value="/photoGalleryEdit.do")
	public String editPhotoGallery(@Validated(PhotoGalleryEditVal.class) PhotoGalleryVO photoGalleryVO, BindingResult result, HttpServletRequest request, Model model) {
		
		/* validator check */
		if(result.hasErrors()){ throw new CfoodException("admin.customer.photogallery.photoGalleryEdit.bindingexception"); }
		
		boolean bResult = false;
		String resultPage = "/admin/customer/photoGallery/bor_pho_detail";
		String getPersistMode = photoGalleryVO.getMode();
		
		try{
			Map<String,PhotoGalleryVO> returnMap = photoGalleryService.viewPhotoGallery(photoGalleryVO);
			PhotoGalleryVO photoGalleryView = new PhotoGalleryVO();
			
			photoGalleryView.setMode(MODE_INSERT);		// default mode
			
			if(MODE_VIEW.equalsIgnoreCase(getPersistMode)){
				//model.addAttribute("prevPhotoGalleryView",(PhotoGalleryVO)returnMap.get("prevPhotoGalleryVO"));	// 이전 공지사항
				//model.addAttribute("nextPhotoGalleryView",(PhotoGalleryVO)returnMap.get("nextPhotoGalleryVO"));	// 다음 공지사항
			} else if(MODE_EDIT.equalsIgnoreCase(getPersistMode)){
				photoGalleryView = returnMap.get("returnVO");
				photoGalleryView.setMode(MODE_UPDATE);
				resultPage = "/admin/customer/photoGallery/bor_pho_detail";
				model.addAttribute("daumEditorImageList", photoGalleryService.listDaumEditorVO(photoGalleryVO));
			} else bResult = false;
			
			// 현재 화면를 가져온다.
			photoGalleryView.setCurrentPageNo(photoGalleryVO.getCurrentPageNo());
			
			// 현재 화면의 검색 파라미터 값을 지정한다.
			model.addAttribute("parameterInfo",super.setGivenParameterValue(request,this.photoGallerySearchParameter));
			model.addAttribute("photoGalleryView",photoGalleryView);		// 공지사항 내용
			
			bResult = true;		// 정상
			
		} catch (Exception e){
			throw new CfoodException("admin.customer.photogallery.photoGalleryEdit",e);
		}
		
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestName(value="persistPhotoGallery")
	@RequestMapping(value={"/photoGalleryInsert.do","/photoGalleryUpdate.do"})
	public String persistPhotoGallery(@Validated(PhotoGalleryPersistVal.class) PhotoGalleryVO photoGalleryVO, BindingResult result, HttpServletRequest request, Model model) {
		
		/* Validator error */
		if(result.hasErrors()){
			model.addAttribute("photoGalleryView", photoGalleryVO);
			model.addAttribute("resultError", super.setResultMessage(result));
			return "/admin/customer/photoGallery/bor_pho_detail";
		}
		
		boolean bResult = false;
		String resultPage = "redirect:/admin/customer/photoGallery/photoGalleryEdit.do?mode=edit&photoGallerySeq=";
		String getPersistMode = photoGalleryVO.getMode();
		
		/* check uri */
		String requestURI = (String)request.getRequestURI().toString();
		if(requestURI.indexOf("/photoGalleryInsert.do")>0){ getPersistMode = MODE_INSERT; } 
		else if(requestURI.indexOf("/photoGalleryUpdate.do")>0){ getPersistMode = MODE_UPDATE; }
		else { throw new CfoodException("admin.customer.photogallery.photogalleryPersist.NullModeException"); }
		
		try{
			/* get set session */
			try{
				photoGalleryVO.setRegID((String)EgovSessionCookieUtil.getSessionAttribute(request, "usrId"));
				photoGalleryVO.setModID((String)EgovSessionCookieUtil.getSessionAttribute(request, "usrId"));
			} catch(Exception e){ throw new CfoodException("admin.customer.photogallery.photogalleryPersist.NullSessionException",e); }
			
			
			PhotoGalleryVO returnVO = null;
			bResult = true;		// 정상
			
			/*
			다음 에디터에서 내용은 galleryHTMLContent에 저장되어 들어온다. galleryHTMLContent내용은 html태그가 포함되어 있다.
			NOTICE_TEXT_CONTENT AS photoGalleryTextContent : <img>를 제외한 모든 테그를 삭제하여 저장한다.
			NOTICE_HTML_CONTENT AS photoGalleryHTMLContent : 모든 html 태그를 포함한다.
			 */
			photoGalleryVO.setGalleryTextContent(WebUtil.removeHTMLSpecialChars(WebUtil.replaceHTMLSpecialChars(photoGalleryVO.getGalleryHTMLContent()), ""));
			
			/*
			 galleryHTMLContent에서 img value를 모두 가녀온다.  해당 img값/값들로 TB_COM_DAUM_IMAGE 테이블에 매핑한다.
			 다음 에디터는 내용을 DB에 저장하기 전에 popup창으로 이미지를 먼저 등록한다. 이 과정에서 우선적으로 이미지 파일은 서버에 업로드 되어 있고, 그 기록은 TB_COM_DAUM_IMAGE에 저장되어 있다.
			 다음 에디터로 내응이 작성되고 DB에 저장이 되면 해당 내용에 대한 SEQ 값을 가져오는데, 이때 이 SEQ값을 TB_COM_DAUM_IMAGE 테이블에 저장해야한다.
			 저장해야 하는 대상의 레코드는 이미지 파일명으로 찾는다.(이미지 파일명은 고유명으로 저장하게 끔 했다.)
			 아래 내용은 daum editor에서 넘기는 attach_image_info 파라미터(들)의 filename을 추출해서 List객체로 리턴하고, 다시 photoGalleryVO.ImageList에 저장한다.
			 */
			if(photoGalleryVO.getAttach_image_info()!=null&&!"".equals(photoGalleryVO.getAttach_image_info())){
				photoGalleryVO.setImageList(getEditorImageList(photoGalleryVO.getAttach_image_info()));
			}
			
			// 현재 모드를 확인하여 해당 persist를 실행
			if(MODE_INSERT.equalsIgnoreCase(getPersistMode)){
				returnVO = photoGalleryService.insertPhotoGallery(photoGalleryVO);
			} else if(MODE_UPDATE.equalsIgnoreCase(getPersistMode)){
				returnVO = photoGalleryService.updatePhotoGallery(photoGalleryVO);
			} else bResult = false;
			
			if(bResult) resultPage += String.valueOf(returnVO.getPhotoGallerySeq());
			
		} catch(Exception e){
			throw new CfoodException("admin.customer.photogallery.photoGalleryPersist",e);
		}
		
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestName(value="deletePhotoGallery")
	@RequestMapping(value="/photoGalleryDelete.do")
	public String deletePhotoGallery(@Validated(PhotoGalleryDeleteVal.class) PhotoGalleryVO photoGalleryVO, BindingResult result, HttpServletRequest request, Model model) {
		
		/* validator check */
		if(result.hasErrors()){
			model.addAttribute("resultError", "권한이 없습니다.");
			throw new CfoodException("admin.customer.photogallery.photoGalleryDelete.bindingexception");
		}
		
		boolean bResult = false;
		String resultPage = "redirect:/admin/customer/photoGallery/photoGalleryList.do";
		
		try{
			/* get set session */
			try{
				photoGalleryVO.setModID((String)EgovSessionCookieUtil.getSessionAttribute(request, "usrId"));
			} catch(Exception e){ throw new CfoodException("admin.customer.photogallery.photogalleryDelete.NullSessionException",e); }
			
			if(photoGalleryService.deletePhotoGallery(photoGalleryVO)>0){ bResult = true; }
			
		} catch(Exception e){
			throw new CfoodException("admin.customer.photogallery.photoGalleryDelete",e);
		}
		
		return bResult ? resultPage : ERROR_PAGE;
	}
	
}
