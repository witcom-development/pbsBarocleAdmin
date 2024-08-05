package com.dkitec.barocle.admin.customer.donor.controller;

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
import com.dkitec.barocle.admin.customer.donor.vo.DonorVO;
import com.dkitec.barocle.admin.customer.donor.vo.DonorVO.DonorDeleteVal;
import com.dkitec.barocle.admin.customer.donor.vo.DonorVO.DonorEditVal;
import com.dkitec.barocle.admin.customer.donor.vo.DonorVO.DonorListVal;
import com.dkitec.barocle.admin.customer.donor.vo.DonorVO.DonorPersistVal;
import com.dkitec.barocle.admin.customer.donor.service.DonorService;
import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.WebUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="DonorController")
@RequestMapping(value="/admin/customer/donor")
public class DonorController extends BaseController {
	
	@Resource(name = "donorService") private DonorService donorService;
	
	protected static Logger log = LoggerFactory.getLogger(DonorController.class);
	
	private final String[] donorSearchParameter = {"searchValue"};
	
	@RequestName(value="donorList")
	@RequestMapping(value="/donorList.do")
	public String getDonorList(@Validated(DonorListVal.class) DonorVO donorVO, BindingResult result, HttpServletRequest request, Model model) {
		
		/* validator check */
		if(result.hasErrors()){
			model.addAttribute("donorView", donorVO);
			model.addAttribute("resultError", this.setResultMessage(result));
			return "/admin/customer/donor/bor_don_list";
		}
		
		boolean bResult = false;
		String resultPage = "/admin/customer/donor/bor_don_list";
		
		try{
			// 총 레코드 개수를 가져온다.
			donorVO.setTotalRecordCount(donorService.listDonorCount(donorVO));
			// 페이징
			PaginationInfo paginationInfo = getPagingInfo(donorVO.getCurrentPageNo(), donorVO.getTotalRecordCount());
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(donorVO.getCurrentPageNo(), donorVO.getTotalRecordCount());
			donorVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			donorVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			// 현재 화면의 정보를 지정한다.
			model.addAttribute("donorView", donorVO);
			// 현재 화면의 레코드 목록을 지정한다.
			model.addAttribute("donorList",donorService.listDonor(donorVO));
			// 현재 화면의 검색 파라미터 값을 지정한다.
			model.addAttribute("parameterInfo",super.setGivenParameterValue(request,this.donorSearchParameter));
			// 현재 화면에 표시되는 페이징 정보를 지정한다.
			model.addAttribute("paginationInfo",paginationInfo);
			model.addAttribute("paginationMobileInfo",paginationMobileInfo);
						
			bResult = true;		// 정상
			
		} catch (Exception e) {
			throw new CfoodException("admin.customer.donor.donorList",e);
		}
		
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestName(value="editDonor")
	@RequestMapping(value="/donorEdit.do")
	public String editDonor(@Validated(DonorEditVal.class) DonorVO donorVO, BindingResult result, HttpServletRequest request, Model model) {
		
		/* validator check */
		if(result.hasErrors()){ throw new CfoodException("admin.customer.donor.donorEdit.bindingexception"); }
		
		boolean bResult = false;
		String resultPage = "/admin/customer/donor/bor_don_detail";
		String getPersistMode = donorVO.getMode();
		
		try{
			Map<String,DonorVO> returnMap = donorService.viewDonor(donorVO);
			DonorVO donorView = new DonorVO();
			
			donorView.setMode(MODE_INSERT);		// default mode
			
			if(MODE_VIEW.equalsIgnoreCase(getPersistMode)){
				//model.addAttribute("prevDonorView",(DonorVO)returnMap.get("prevDonorVO"));	// 이전 공지사항
				//model.addAttribute("nextDonorView",(DonorVO)returnMap.get("nextDonorVO"));	// 다음 공지사항
			} else if(MODE_EDIT.equalsIgnoreCase(getPersistMode)){
				donorView = returnMap.get("returnVO");
				donorView.setMode(MODE_UPDATE);
				resultPage = "/admin/customer/donor/bor_don_detail";
				model.addAttribute("daumEditorImageList", donorService.listDaumEditorVO(donorVO));
			} else bResult = false;
			
			// 현재 화면를 가져온다.
			donorView.setCurrentPageNo(donorVO.getCurrentPageNo());
			
			// 현재 화면의 검색 파라미터 값을 지정한다.
			model.addAttribute("parameterInfo",super.setGivenParameterValue(request,this.donorSearchParameter));
			model.addAttribute("donorView",donorView);		// 공지사항 내용
			
			bResult = true;		// 정상
			
		} catch (Exception e){
			throw new CfoodException("admin.customer.donor.donorEdit",e);
		}
		
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestName(value="persistDonor")
	@RequestMapping(value={"/donorInsert.do","/donorUpdate.do"})
	public String persistDonor(@Validated(DonorPersistVal.class) DonorVO donorVO, BindingResult result, HttpServletRequest request, Model model) {
		
		/* Validator error */
		if(result.hasErrors()){
			model.addAttribute("donorView", donorVO);
			model.addAttribute("resultError", this.setResultMessage(result));
			return "/admin/customer/donor/bor_don_detail";
		}
		
		boolean bResult = false;
		String resultPage = "redirect:/admin/customer/donor/donorEdit.do?mode=edit&donorSeq=";
		String getPersistMode = donorVO.getMode();
		
		/* check uri */
		String requestURI = (String)request.getRequestURI().toString();
		if(requestURI.indexOf("/donorInsert.do")>0){ getPersistMode = MODE_INSERT; } 
		else if(requestURI.indexOf("/donorUpdate.do")>0){ getPersistMode = MODE_UPDATE; }
		else { throw new CfoodException("admin.customer.donor.donorPersist.NullModeException"); }
		
		try{
			/* get set session */
			try{
				donorVO.setRegID((String)EgovSessionCookieUtil.getSessionAttribute(request, "usrId"));
				donorVO.setModID((String)EgovSessionCookieUtil.getSessionAttribute(request, "usrId"));
			} catch(Exception e) { throw new CfoodException("admin.customer.donor.donorPersist.NullSessionException",e); }
			
			DonorVO returnVO = null;
			bResult = true;		// 정상
			
			/*
			다음 에디터에서 내용은 donorHTMLContent에 저장되어 들어온다. donorHTMLContent내용은 html태그가 포함되어 있다.
			NOTICE_TEXT_CONTENT AS donorTextContent : <img>를 제외한 모든 테그를 삭제하여 저장한다.
			NOTICE_HTML_CONTENT AS donorHTMLContent : 모든 html 태그를 포함한다.
			 */
			donorVO.setDonorTextContent(WebUtil.removeHTMLSpecialChars(WebUtil.replaceHTMLSpecialChars(donorVO.getDonorHTMLContent()), ""));
			
			/*
			 donorHTMLContent에서 img value를 모두 가녀온다.  해당 img값/값들로 TB_COM_DAUM_IMAGE 테이블에 매핑한다.
			 다음 에디터는 내용을 DB에 저장하기 전에 popup창으로 이미지를 먼저 등록한다. 이 과정에서 우선적으로 이미지 파일은 서버에 업로드 되어 있고, 그 기록은 TB_COM_DAUM_IMAGE에 저장되어 있다.
			 다음 에디터로 내응이 작성되고 DB에 저장이 되면 해당 내용에 대한 SEQ 값을 가져오는데, 이때 이 SEQ값을 TB_COM_DAUM_IMAGE 테이블에 저장해야한다.
			 저장해야 하는 대상의 레코드는 이미지 파일명으로 찾는다.(이미지 파일명은 고유명으로 저장하게 끔 했다.)
			 아래 내용은 daum editor에서 넘기는 attach_image_info 파라미터(들)의 filename을 추출해서 List객체로 리턴하고, 다시 donorVO.ImageList에 저장한다.
			 */
			if(donorVO.getAttach_image_info()!=null&&!"".equals(donorVO.getAttach_image_info())){
				donorVO.setImageList(getEditorImageList(donorVO.getAttach_image_info()));
			}
			
			// 현재 모드를 확인하여 해당 persist를 실행
			if(MODE_INSERT.equalsIgnoreCase(getPersistMode)){
				returnVO = donorService.insertDonor(donorVO);
			} else if(MODE_UPDATE.equalsIgnoreCase(getPersistMode)){
				returnVO = donorService.updateDonor(donorVO);
			} else bResult = false;
			
			if(bResult) resultPage += String.valueOf(returnVO.getDonorSeq());
			
		} catch(Exception e){
			throw new CfoodException("admin.customer.donor.donorPersist",e);
		}
		
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestName(value="deleteDonor")
	@RequestMapping(value="/donorDelete.do")
	public String deleteDonor(@Validated(DonorDeleteVal.class) DonorVO donorVO, BindingResult result, HttpServletRequest request, Model model) {
		
		/* validator check */
		if(result.hasErrors()){
			model.addAttribute("resultError", "권한이 없습니다.");
			throw new CfoodException("admin.customer.donor.donorDelete.bindingexception");
		}
		
		boolean bResult = false;
		String resultPage = "redirect:/admin/customer/donor/donorList.do";
		
		try{
			/* get set session */
			try{
				donorVO.setModID((String)EgovSessionCookieUtil.getSessionAttribute(request, "usrId"));
			} catch(Exception ce) { throw new CfoodException("admin.customer.donor.donorDelete.NullSessionException"); }
			
			if(donorService.deleteDonor(donorVO)>0){ bResult = true; }
			
		} catch(Exception e){
			throw new CfoodException("admin.customer.donor.donorDelete",e);
		}
		
		return bResult ? resultPage : ERROR_PAGE;
	}
	
}
