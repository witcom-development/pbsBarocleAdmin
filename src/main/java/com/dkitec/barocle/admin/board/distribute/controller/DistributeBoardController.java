package com.dkitec.barocle.admin.board.distribute.controller;

import java.io.File;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.dkitec.barocle.admin.board.distribute.service.DistributeBoardService;
import com.dkitec.barocle.admin.board.distribute.vo.DistributeBoardVO;
import com.dkitec.barocle.admin.board.distribute.vo.DistributeBoardVO.DistBoardAllVal;
import com.dkitec.barocle.admin.board.distribute.vo.DistributeBoardVO.DistBoardDeleteVal;
import com.dkitec.barocle.admin.board.distribute.vo.DistributeBoardVO.DistBoardEditVal;
import com.dkitec.barocle.admin.board.distribute.vo.DistributeBoardVO.DistBoardListVal;
import com.dkitec.barocle.admin.board.distribute.vo.DistributeBoardVO.DistBoardPersistVal;
import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.StringUtil;
import com.dkitec.barocle.util.webutil.WebUtil;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="DistributeController")
@RequestMapping(value="/admin/board/distribute")
public class DistributeBoardController extends BaseController { 
//NoticeController 참고
	@Resource(name = "distributeBoardService") private DistributeBoardService distributeBoardService;
	
	protected static Logger log = LoggerFactory.getLogger(DistributeBoardController.class);
	
	private final String[] distributeSearchParameter = {"searchValue","searchStartDate","searchEndDate"};
		
	@RequestName(value="getDistBoardList")
	@RequestMapping(value="/distBoardList.do") 
	public String getDistBoardList(@Validated(DistBoardListVal.class) DistributeBoardVO distributeBoardVO,
	BindingResult result, HttpServletRequest request, Model model) {
		/* validator check */
		if(result.hasErrors()) {
			model.addAttribute("distributeBoardView", distributeBoardVO);
			model.addAttribute("resultError", super.setResultMessage(result));
			return "/admin/board/distribute/bor_dist_list";
		}
		
		boolean bResult = false;
		String resultPage ="/admin/board/distribute/bor_dist_list";
		
		try {
			// 총 레코드 개수를 가져온다.
			distributeBoardVO.setTotalRecordCount(distributeBoardService.listDistributeCount(distributeBoardVO));
			// 페이징
			PaginationInfo paginationInfo = getPagingInfo(distributeBoardVO.getCurrentPageNo(), distributeBoardVO.getTotalRecordCount());
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(distributeBoardVO.getCurrentPageNo(), distributeBoardVO.getTotalRecordCount());
			distributeBoardVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			distributeBoardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			// 현재 화면의 정보를 지정한다.
			model.addAttribute("distributeBoardView", distributeBoardVO);
			// 현재 화면의 레코드 목록을 지정한다.
			model.addAttribute("distBoardList", distributeBoardService.listDistribute(distributeBoardVO));
			// 현재 화면의 검색 파라미터 값을 지정한다.
			model.addAttribute("parameterInfo",super.setGivenParameterValue(request,this.distributeSearchParameter));
			// 현재 화면에 표시되는 페이징 정보를 지정한다.
			model.addAttribute("paginationInfo",paginationInfo);
			model.addAttribute("paginationMobileInfo",paginationMobileInfo);
			
			bResult = true;		// 정상
		} catch(Exception e) {
			e.printStackTrace();
			throw new CfoodException("admin.board.distribute.distBoardList",e);
		}
		return bResult ? resultPage : ERROR_PAGE; 
	}
		
	/* NOTE : 상세/등록/수정 화면
	 * mode=null 상세
	 * mode=view,distSeq=x 상세
	 * mode=edit,distSeq=y 수정
	 * 위와 같은 값이 존재하면 해당 로직으로 처리한다.
	 */
	@RequestName(value="editDistBoard")
	@RequestMapping(value="/distBoardEdit.do")
	public String editDistBoard(@Validated(DistBoardEditVal.class) DistributeBoardVO distributeBoardVO, BindingResult result, HttpServletRequest request, Model model) {
	
		/* validator check */
		if(result.hasErrors()){ throw new CfoodException("admin.board.distribute.distBoardEdit.bindingexception"); }
		
		boolean bResult = false;
		String resultPage = "/admin/board/distribute/bor_dist_detail";
		String getPersistMode = distributeBoardVO.getMode();
		
		try {
			Map<String, DistributeBoardVO> returnMap = distributeBoardService.viewDistribute(distributeBoardVO);
			
			DistributeBoardVO distributeBoardView = new DistributeBoardVO(); // 입력 수정 동시에 사용할 변수 선언
			distributeBoardView.setMode(MODE_INSERT); // default mode
			if(MODE_VIEW.equalsIgnoreCase(getPersistMode)) {
				//model.addAttribute("prevNoticeView",(NoticeVO)returnMap.get("prevNoticeVO"));	// 이전 공지사항
				//model.addAttribute("nextNoticeView",(NoticeVO)returnMap.get("nextNoticeVO"));	// 다음 공지사항
			} else if(MODE_EDIT.equalsIgnoreCase(getPersistMode)&&distributeBoardVO.getDistSeq()>0) {
				distributeBoardView = returnMap.get("returnVO");
				distributeBoardView.setMode(MODE_UPDATE);
				resultPage = "/admin/board/distribute/bor_dist_detail";
				model.addAttribute("seqNo", distributeBoardVO.getDistSeq());
				model.addAttribute("daumEditorImageList", distributeBoardService.listDaumEditorVO(distributeBoardVO));
			} // else MODE_WRITE;
			// 현재 화면를 가져온다.
			distributeBoardView.setCurrentPageNo(distributeBoardVO.getCurrentPageNo());
			distributeBoardView.setDistSeq(distributeBoardVO.getDistSeq());
			// 현재 화면의 검색 파라미터 값을 지정한다.
			model.addAttribute("parameterInfo", super.setGivenParameterValue(request,this.distributeSearchParameter));
			model.addAttribute("distributeBoardView", distributeBoardView);
			bResult = true;		// 정상
			System.out.println("bResult : " + bResult);
		} catch (Exception e) {
			e.printStackTrace();
			throw new CfoodException("admin.board.distribute.distBoardEdit",e);
		}
		System.out.println("resultPage : " + resultPage);
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	/* NOTE : 상세/등록/수정 화면
	 * /admin/board/distribute/distBoardInsert.do || /admin/board/distribute/distBoardUpdate.do 와 같이 uri를 확인하여 현재 요청 모드를 설정한다.
	 */
	@RequestName(value="persistDistBoard")
	@RequestMapping(value={"/distBoardInsert.do","/distBoardUpdate.do"})
	public String persistDistBoard(@Validated(DistBoardPersistVal.class) DistributeBoardVO distributeBoardVO, BindingResult result, HttpServletRequest request, Model model) {
		/* Validator error */
		if(result.hasErrors()) {
			model.addAttribute("distributeBoardView", distributeBoardVO);
			model.addAttribute("resultError", super.setResultMessage(result));
			return "/admin/board/distribute/bor_dist_detail";
		}
		boolean bResult = false;
		
		//String resultPage = "redirect:/admin/board/distribute/distBoardEdit.do?mode=edit&distSeq=";
		String resultFlag = distributeBoardVO.getCateCD();
		String resultPage ="";
			if(resultFlag.equals("B")) {
				resultPage = "redirect:/admin/board/distribute/getBunBoardList.do";
			} else if(resultFlag.equals("S")) {
				resultPage = "redirect:/admin/board/distribute/getSangBoardList.do";
			} else if(resultFlag.equals("J")) {
				resultPage = "redirect:/admin/board/distribute/getJengBoardList.do";
			} else {
				resultPage = "redirect:/admin/board/distribute/distBoardList.do";
			}
		
		String getPersistMode = distributeBoardVO.getMode();
		/* check uri */
		String requestURI = (String)request.getRequestURI().toString();
		if(requestURI.indexOf("/distBoardInsert.do")>0){
			getPersistMode = MODE_INSERT; }
		else if(requestURI.indexOf("/distBoardUpdate.do")>0){
			getPersistMode = MODE_UPDATE; }
		else { 
			throw new CfoodException("admin.board.distribute.distBoardPersist.NullModeException"); }
		
		try {
			/* get set session */
			try {
				distributeBoardVO.setRegID((String)EgovSessionCookieUtil.getSessionAttribute(request, "usrId"));
				distributeBoardVO.setModID((String)EgovSessionCookieUtil.getSessionAttribute(request, "usrId"));
				if ( distributeBoardVO.getMainDistYN() == null ) {
					distributeBoardVO.setMainDistYN("N");	
				}
				
			} catch (Exception e){ 
				e.printStackTrace();
				throw new CfoodException("admin.board.distribute.distBoardPersist.NullSessionException",e); 
			}
			
			DistributeBoardVO returnVO = null;
			bResult = true;		// 정상
			/*
			다음 에디터에서 내용은 noticeHTMLContent에 저장되어 들어온다. noticeHTMLContent내용은 html태그가 포함되어 있다.
			NOTICE_TEXT_CONTENT AS noticeTextContent : <img>를 제외한 모든 테그를 삭제하여 저장한다.
			NOTICE_HTML_CONTENT AS noticeHTMLContent : 모든 html 태그를 포함한다.
			 */
			distributeBoardVO.setDistTextContent(WebUtil.removeHTMLSpecialChars(WebUtil.replaceHTMLSpecialChars(distributeBoardVO.getDistHTMLContent()), ""));
			
			/*
			noticeHTMLContent에서 img value를 모두 가녀온다. 해당 img값/값들로 TB_COM_DAUM_IMAGE 테이블에 매핑한다.
			다음 에디터는 내용을 DB에 저장하기 전에 popup창으로 이미지를 먼저 등록한다. 이 과정에서 우선적으로 이미지 파일은 서버에 업로드 되어 있고, 그 기록은 TB_COM_DAUM_IMAGE에 저장되어 있다.
			다음 에디터로 내응이 작성되고 DB에 저장이 되면 해당 내용에 대한 SEQ 값을 가져오는데, 이때 이 SEQ값을 TB_COM_DAUM_IMAGE 테이블에 저장해야한다.
			저장해야 하는 대상의 레코드는 이미지 파일명으로 찾는다.(이미지 파일명은 고유명으로 저장하게 끔 했다.)
			아래 내용은 daum editor에서 넘기는 attach_image_info 파라미터(들)의 filename을 추출해서 List객체로 리턴하고, 다시 noticeVO.ImageList에 저장한다.
			 */
			if(distributeBoardVO.getAttach_image_info()!=null&&!"".equals(distributeBoardVO.getAttach_image_info())) {
				distributeBoardVO.setImageList(getEditorImageList(distributeBoardVO.getAttach_image_info()));
			}
			
			//파일 업로드
			if(distributeBoardVO.getAttach_file()!=null&&!"".equals(distributeBoardVO.getAttach_file())) {
				distributeBoardVO.setFileList(getEditorImageList(distributeBoardVO.getAttach_file()));
			}
			
			// 현재 모드를 확인하여 해당 persist를 실행
			//String msg = "<바로클> 자전거 반납 추천 대여소 주변에 추천 반납 대여소 확인하기.";
			String msg = "바로클 자전거";
			//String TARGET_URL = "https://www.bikeseoul.com:446/app/rent/moveRecommendReturnStation.do";
			//String resultPage = "redirect:/admin/customer/notice/noticeList.do";
			String TARGET_URL = "https://www.bikeseoul.com/main.do";
			if(MODE_INSERT.equalsIgnoreCase(getPersistMode)) {
				returnVO = distributeBoardService.insertDistribute(distributeBoardVO);
			} else if(MODE_UPDATE.equalsIgnoreCase(getPersistMode)) {
				returnVO = distributeBoardService.updateDistribute(distributeBoardVO);
			} else bResult = false;
			
			//if(bResult) resultPage += String.valueOf(returnVO.getDistSeq());
		} catch (Exception e) {
			e.printStackTrace();
			throw new CfoodException("admin.board.distribute.distBoardPersist",e);
		}
		
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestName(value="deleteDistBoard")
	@RequestMapping(value="/distBoardDelete.do")
	public String deleteDistBoard(@Validated(DistBoardDeleteVal.class) DistributeBoardVO distributeBoardVO, BindingResult result, HttpServletRequest request, Model model) {
		
		/* validator check */
		if(result.hasErrors()){
			model.addAttribute("resultError", "권한이 없습니다.");
			throw new CfoodException("admin.board.distribute.distBoardDelete.bindingexception");
		}
		boolean bResult = false;
		String resultPage = "redirect:/admin/board/distribute/distBoardList.do";
		
		try {
			/* get set session */
			try {
				distributeBoardVO.setRegID((String)EgovSessionCookieUtil.getSessionAttribute(request, "usrId"));
				distributeBoardVO.setModID((String)EgovSessionCookieUtil.getSessionAttribute(request, "usrId"));
			} catch(Exception e){
				e.printStackTrace();
				throw new CfoodException("admin.board.distribute.distBoardDelete.NullSessionException",e); 
			}
			
			if(distributeBoardService.deleteDistribute(distributeBoardVO) > 0) {
				bResult = true;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new CfoodException("admin.board.distribute.distBoardDelete",e);
		}
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestName(value="popupDistBoardCount")
	@RequestMapping(value="/distBoardPopupCount.do")
	public String popupDistBoardCount(@ModelAttribute("distributeBoardVO") DistributeBoardVO distributeBoardVO, HttpServletRequest request, Model model) {
		try {
			java.util.List<DistributeBoardVO> listDistributeBoardVO = distributeBoardService.listDistributePopupCount(distributeBoardVO);
			model.addAttribute("popupCount",listDistributeBoardVO);
		} catch (Exception e) {
			throw new CfoodException("admin.board.distribute.popupDistBoardCount",e);
		}
		return JSONVIEW;
	}
	
	@RequestName(value="popupDistBoard")
	@RequestMapping(value="/distBoardPopup.do")
	public String popupNotice(@ModelAttribute("distributeBoardVO") DistributeBoardVO distributeBoardVO, HttpServletRequest request, Model model) {
		try {
			if(request.getParameter("popSeq")!=null&&!StringUtil.isEmpty((String)request.getParameter("popSeq"))){ distributeBoardVO.setDistSeq(Integer.parseInt((String)request.getParameter("popSeq"))); }
			model.addAttribute("popupView",distributeBoardService.listDistributePopup(distributeBoardVO));
		} catch (Exception e) {
			throw new CfoodException("admin.board.distribute.popupDistBoard",e);
		}
		return "/admin/common/popup/pop_bor_detail";
	}
	
	/* 파일 다운로드 
	 */
	@RequestName(value="downloadFile")
	@RequestMapping(value="/downloadFile.do")
	public ModelAndView downloadFile(@Validated(DistBoardAllVal.class) DistributeBoardVO distributeBoardVO, BindingResult result, HttpServletRequest request, Model model) {
		
		ModelAndView mav = new ModelAndView("filedownloadView");
		
		//현화면의 이름를 알려준다(distribute)
		String folDer = String.valueOf(request.getParameter("currentPageName"));
		distributeBoardVO.setaFolder(folDer);
		
		try {
			String pathZipNm= distributeBoardService.fileDownloadList(distributeBoardVO);
			String fileNm= distributeBoardService.fileDownloadNm(distributeBoardVO);
			
			mav.addObject("fileName", new File(pathZipNm));
			mav.addObject("fileNm", new File(fileNm));
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	
	/* 분배원 게시판 */
	@RequestName(value="getBunBoardList")
	@RequestMapping(value="/getBunBoardList.do") 
	public String getBunBoardList(@Validated(DistBoardListVal.class) DistributeBoardVO distributeBoardVO,
	BindingResult result, HttpServletRequest request, Model model) {
		/* validator check */
		if(result.hasErrors()) {
			model.addAttribute("distributeBoardView", distributeBoardVO);
			model.addAttribute("resultError", super.setResultMessage(result));
			return "/admin/board/distribute/bor_bun_list";
		}
		
		boolean bResult = false;
		String resultPage = "/admin/board/distribute/bor_bun_list";
		
		String strTemp = distributeBoardVO.getCateCD();
		if ( StringUtil.isEmpty(strTemp) ) {
			if( strTemp == null || strTemp.trim().equals("") ){
				strTemp = "0";
			}
			distributeBoardVO.setCateCD("B");
	    }
				
		try {
			// 총 레코드 개수를 가져온다.
			distributeBoardVO.setTotalRecordCount(distributeBoardService.listDistributeCount(distributeBoardVO));
			// 페이징
			PaginationInfo paginationInfo = getPagingInfo(distributeBoardVO.getCurrentPageNo(), distributeBoardVO.getTotalRecordCount());
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(distributeBoardVO.getCurrentPageNo(), distributeBoardVO.getTotalRecordCount());
			distributeBoardVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			distributeBoardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			// 현재 화면의 정보를 지정한다.
			model.addAttribute("distributeBoardView", distributeBoardVO);
			// 현재 화면의 레코드 목록을 지정한다.
			model.addAttribute("distBoardList", distributeBoardService.listDistribute(distributeBoardVO));
			// 현재 화면의 검색 파라미터 값을 지정한다.
			model.addAttribute("parameterInfo",super.setGivenParameterValue(request,this.distributeSearchParameter));
			// 현재 화면에 표시되는 페이징 정보를 지정한다.
			model.addAttribute("paginationInfo",paginationInfo);
			model.addAttribute("paginationMobileInfo",paginationMobileInfo);
			
			bResult = true;		// 정상
		} catch(Exception e) {
			e.printStackTrace();
			throw new CfoodException("admin.board.distribute.getBunBoardList",e);
		}
		System.out.println("bResult : " + bResult);
		System.out.println("resultPage : " + resultPage);
		return bResult ? resultPage : ERROR_PAGE; 
	}
	
	/* 상담원 게시판 */
	@RequestName(value="getSangBoardList")
	@RequestMapping(value="/getSangBoardList.do") 
	public String getSangBoardList(@Validated(DistBoardListVal.class) DistributeBoardVO distributeBoardVO,
	BindingResult result, HttpServletRequest request, Model model) {
		/* validator check */
		if(result.hasErrors()) {
			model.addAttribute("distributeBoardView", distributeBoardVO);
			model.addAttribute("resultError", super.setResultMessage(result));
			return "/admin/board/distribute/bor_sang_list";
		}
		
		boolean bResult = false;
		String resultPage = "/admin/board/distribute/bor_sang_list";
		
		String strTemp = distributeBoardVO.getCateCD();
		if ( StringUtil.isEmpty(strTemp) ) {
			if( strTemp == null || strTemp.trim().equals("") ){
				strTemp = "0";
			}
			distributeBoardVO.setCateCD("S");
	    }
				
		try {
			// 총 레코드 개수를 가져온다.
			distributeBoardVO.setTotalRecordCount(distributeBoardService.listDistributeCount(distributeBoardVO));
			// 페이징
			PaginationInfo paginationInfo = getPagingInfo(distributeBoardVO.getCurrentPageNo(), distributeBoardVO.getTotalRecordCount());
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(distributeBoardVO.getCurrentPageNo(), distributeBoardVO.getTotalRecordCount());
			distributeBoardVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			distributeBoardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			// 현재 화면의 정보를 지정한다.
			model.addAttribute("distributeBoardView", distributeBoardVO);
			// 현재 화면의 레코드 목록을 지정한다.
			model.addAttribute("distBoardList", distributeBoardService.listDistribute(distributeBoardVO));
			// 현재 화면의 검색 파라미터 값을 지정한다.
			model.addAttribute("parameterInfo",super.setGivenParameterValue(request,this.distributeSearchParameter));
			// 현재 화면에 표시되는 페이징 정보를 지정한다.
			model.addAttribute("paginationInfo",paginationInfo);
			model.addAttribute("paginationMobileInfo",paginationMobileInfo);
			
			bResult = true;		// 정상
		} catch(Exception e) {
			e.printStackTrace();
			throw new CfoodException("admin.board.distribute.getSangBoardList",e);
		}
		System.out.println("bResult : " + bResult);
		System.out.println("resultPage : " + resultPage);
		return bResult ? resultPage : ERROR_PAGE; 
	}
	
	/* 정비원 게시판 */
	@RequestName(value="getJengBoardList")
	@RequestMapping(value="/getJengBoardList.do") 
	public String getJengBoardList(@Validated(DistBoardListVal.class) DistributeBoardVO distributeBoardVO,
	BindingResult result, HttpServletRequest request, Model model) {
		/* validator check */
		if(result.hasErrors()) {
			model.addAttribute("distributeBoardView", distributeBoardVO);
			model.addAttribute("resultError", super.setResultMessage(result));
			return "/admin/board/distribute/bor_jeng_list";
		}
		
		boolean bResult = false;
		String resultPage = "/admin/board/distribute/bor_jeng_list";
		
		String strTemp = distributeBoardVO.getCateCD();
		if ( StringUtil.isEmpty(strTemp) ) {
			if( strTemp == null || strTemp.trim().equals("") ){
				strTemp = "0";
			}
			distributeBoardVO.setCateCD("J");
	    }
				
		try {
			// 총 레코드 개수를 가져온다.
			distributeBoardVO.setTotalRecordCount(distributeBoardService.listDistributeCount(distributeBoardVO));
			// 페이징
			PaginationInfo paginationInfo = getPagingInfo(distributeBoardVO.getCurrentPageNo(), distributeBoardVO.getTotalRecordCount());
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(distributeBoardVO.getCurrentPageNo(), distributeBoardVO.getTotalRecordCount());
			distributeBoardVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			distributeBoardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			// 현재 화면의 정보를 지정한다.
			model.addAttribute("distributeBoardView", distributeBoardVO);
			// 현재 화면의 레코드 목록을 지정한다.
			model.addAttribute("distBoardList", distributeBoardService.listDistribute(distributeBoardVO));
			// 현재 화면의 검색 파라미터 값을 지정한다.
			model.addAttribute("parameterInfo",super.setGivenParameterValue(request,this.distributeSearchParameter));
			// 현재 화면에 표시되는 페이징 정보를 지정한다.
			model.addAttribute("paginationInfo",paginationInfo);
			model.addAttribute("paginationMobileInfo",paginationMobileInfo);
			
			bResult = true;		// 정상
		} catch(Exception e) {
			e.printStackTrace();
			throw new CfoodException("admin.board.distribute.getJengBoardList",e);
		}
		System.out.println("bResult : " + bResult);
		System.out.println("resultPage : " + resultPage);
		return bResult ? resultPage : ERROR_PAGE; 
	}
	
	
	
	/* NOTE : 상담원 상세/등록/수정 화면
	 * mode=null 상세
	 * mode=view,distSeq=x 상세
	 * mode=edit,distSeq=y 수정
	 * 위와 같은 값이 존재하면 해당 로직으로 처리한다.
	 */
	@RequestName(value="sangBoardEdit")
	@RequestMapping(value="/sangBoardEdit.do")
	public String sangBoardEdit(@Validated(DistBoardEditVal.class) DistributeBoardVO distributeBoardVO, BindingResult result, HttpServletRequest request, Model model) {
	
		/* validator check */
		if(result.hasErrors()){ throw new CfoodException("admin.board.distribute.sangBoardEdit.bindingexception"); }
		
		boolean bResult = false;
		String resultPage = "/admin/board/distribute/bor_sang_detail";
		String getPersistMode = distributeBoardVO.getMode();
		try {
			Map<String, DistributeBoardVO> returnMap = distributeBoardService.viewDistribute(distributeBoardVO);
			DistributeBoardVO distributeBoardView = new DistributeBoardVO(); // 입력 수정 동시에 사용할 변수 선언
			distributeBoardView.setMode(MODE_INSERT); // default mode
			if(MODE_VIEW.equalsIgnoreCase(getPersistMode)) {
				//model.addAttribute("prevNoticeView",(NoticeVO)returnMap.get("prevNoticeVO"));	// 이전 공지사항
				//model.addAttribute("nextNoticeView",(NoticeVO)returnMap.get("nextNoticeVO"));	// 다음 공지사항
			} else if(MODE_EDIT.equalsIgnoreCase(getPersistMode)&&distributeBoardVO.getDistSeq()>0) {
				distributeBoardView = returnMap.get("returnVO");
				distributeBoardView.setMode(MODE_UPDATE);
				resultPage = "/admin/board/distribute/bor_sang_detail";
				model.addAttribute("seqNo", distributeBoardVO.getDistSeq());
				model.addAttribute("daumEditorImageList", distributeBoardService.listDaumEditorVO(distributeBoardVO));
			} // else MODE_WRITE;
			// 현재 화면를 가져온다.
			distributeBoardView.setCurrentPageNo(distributeBoardVO.getCurrentPageNo());
			distributeBoardView.setDistSeq(distributeBoardVO.getDistSeq());
			// 현재 화면의 검색 파라미터 값을 지정한다.
			model.addAttribute("parameterInfo", super.setGivenParameterValue(request,this.distributeSearchParameter));
			model.addAttribute("distributeBoardView", distributeBoardView);
			bResult = true;		// 정상
			System.out.println("bResult : " + bResult);
		} catch (Exception e) {
			e.printStackTrace();
			throw new CfoodException("admin.board.distribute.sangBoardEdit",e);
		}
		System.out.println("resultPage : " + resultPage);
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	
	/* NOTE : 분배원 상세/등록/수정 화면
	 * mode=null 상세
	 * mode=view,distSeq=x 상세
	 * mode=edit,distSeq=y 수정
	 * 위와 같은 값이 존재하면 해당 로직으로 처리한다.
	 */
	@RequestName(value="bunBoardEdit")
	@RequestMapping(value="/bunBoardEdit.do")
	public String bunBoardEdit(@Validated(DistBoardEditVal.class) DistributeBoardVO distributeBoardVO, BindingResult result, HttpServletRequest request, Model model) {
	
		/* validator check */
		if(result.hasErrors()){ throw new CfoodException("admin.board.distribute.bunBoardEdit.bindingexception"); }
		
		boolean bResult = false;
		String resultPage = "/admin/board/distribute/bor_bun_detail";
		String getPersistMode = distributeBoardVO.getMode();
		try {
			Map<String, DistributeBoardVO> returnMap = distributeBoardService.viewDistribute(distributeBoardVO);
			DistributeBoardVO distributeBoardView = new DistributeBoardVO(); // 입력 수정 동시에 사용할 변수 선언
			distributeBoardView.setMode(MODE_INSERT); // default mode
			if(MODE_VIEW.equalsIgnoreCase(getPersistMode)) {
				//model.addAttribute("prevNoticeView",(NoticeVO)returnMap.get("prevNoticeVO"));	// 이전 공지사항
				//model.addAttribute("nextNoticeView",(NoticeVO)returnMap.get("nextNoticeVO"));	// 다음 공지사항
			} else if(MODE_EDIT.equalsIgnoreCase(getPersistMode)&&distributeBoardVO.getDistSeq()>0) {
				distributeBoardView = returnMap.get("returnVO");
				distributeBoardView.setMode(MODE_UPDATE);
				resultPage = "/admin/board/distribute/bor_bun_detail";
				model.addAttribute("seqNo", distributeBoardVO.getDistSeq());
				model.addAttribute("daumEditorImageList", distributeBoardService.listDaumEditorVO(distributeBoardVO));
			} // else MODE_WRITE;
			// 현재 화면를 가져온다.
			distributeBoardView.setCurrentPageNo(distributeBoardVO.getCurrentPageNo());
			distributeBoardView.setDistSeq(distributeBoardVO.getDistSeq());
			// 현재 화면의 검색 파라미터 값을 지정한다.
			model.addAttribute("parameterInfo", super.setGivenParameterValue(request,this.distributeSearchParameter));
			model.addAttribute("distributeBoardView", distributeBoardView);
			bResult = true;		// 정상
			System.out.println("bResult : " + bResult);
		} catch (Exception e) {
			e.printStackTrace();
			throw new CfoodException("admin.board.distribute.bunBoardEdit",e);
		}
		System.out.println("resultPage : " + resultPage);
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	/* NOTE : 정비원 상세/등록/수정 화면
	 * mode=null 상세
	 * mode=view,distSeq=x 상세
	 * mode=edit,distSeq=y 수정
	 * 위와 같은 값이 존재하면 해당 로직으로 처리한다.
	 */
	@RequestName(value="jengBoardEdit")
	@RequestMapping(value="/jengBoardEdit.do")
	public String jengBoardEdit(@Validated(DistBoardEditVal.class) DistributeBoardVO distributeBoardVO, BindingResult result, HttpServletRequest request, Model model) {
	
		/* validator check */
		if(result.hasErrors()){ throw new CfoodException("admin.board.distribute.jengBoardEdit.bindingexception"); }
		
		boolean bResult = false;
		String resultPage = "/admin/board/distribute/bor_jeng_detail";
		String getPersistMode = distributeBoardVO.getMode();
		try {
			Map<String, DistributeBoardVO> returnMap = distributeBoardService.viewDistribute(distributeBoardVO);
			DistributeBoardVO distributeBoardView = new DistributeBoardVO(); // 입력 수정 동시에 사용할 변수 선언
			distributeBoardView.setMode(MODE_INSERT); // default mode
			if(MODE_VIEW.equalsIgnoreCase(getPersistMode)) {
				//model.addAttribute("prevNoticeView",(NoticeVO)returnMap.get("prevNoticeVO"));	// 이전 공지사항
				//model.addAttribute("nextNoticeView",(NoticeVO)returnMap.get("nextNoticeVO"));	// 다음 공지사항
			} else if(MODE_EDIT.equalsIgnoreCase(getPersistMode)&&distributeBoardVO.getDistSeq()>0) {
				distributeBoardView = returnMap.get("returnVO");
				distributeBoardView.setMode(MODE_UPDATE);
				resultPage = "/admin/board/distribute/bor_jeng_detail";
				model.addAttribute("seqNo", distributeBoardVO.getDistSeq());
				model.addAttribute("daumEditorImageList", distributeBoardService.listDaumEditorVO(distributeBoardVO));
			} // else MODE_WRITE;
			// 현재 화면를 가져온다.
			distributeBoardView.setCurrentPageNo(distributeBoardVO.getCurrentPageNo());
			distributeBoardView.setDistSeq(distributeBoardVO.getDistSeq());
			// 현재 화면의 검색 파라미터 값을 지정한다.
			model.addAttribute("parameterInfo", super.setGivenParameterValue(request,this.distributeSearchParameter));
			model.addAttribute("distributeBoardView", distributeBoardView);
			bResult = true;		// 정상
			System.out.println("bResult : " + bResult);
		} catch (Exception e) {
			e.printStackTrace();
			throw new CfoodException("admin.board.distribute.jengBoardEdit",e);
		}
		System.out.println("resultPage : " + resultPage);
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestName(value="popupBoardCount")
	@RequestMapping(value="/boardPopupCount.do")
	public String boardPopupCount(@ModelAttribute("distributeBoardVO") DistributeBoardVO distributeBoardVO, HttpServletRequest request, Model model) {
		try {
			java.util.List<DistributeBoardVO> listBoardVO = distributeBoardService.listBoardPopupCount(distributeBoardVO);
			model.addAttribute("popupCount",listBoardVO);
		} catch (Exception e) {
			throw new CfoodException("admin.customer.notice.boardPopupCount",e);
		}
		return JSONVIEW;
	}
	
	@RequestName(value="popupBoard")
	@RequestMapping(value="/boardPopup.do")
	public String boardPopup(@ModelAttribute("distributeBoardVO") DistributeBoardVO distributeBoardVO, HttpServletRequest request, Model model) {
		try {
			if(request.getParameter("popSeq")!=null&&!StringUtil.isEmpty((String)request.getParameter("popSeq"))){ distributeBoardVO.setDistSeq(Integer.parseInt((String)request.getParameter("popSeq"))); }
			model.addAttribute("popupView",distributeBoardService.listBoardPopup(distributeBoardVO));
		} catch (Exception e) {
			throw new CfoodException("admin.customer.notice.boardPopup",e);
		}
		return "/admin/common/popup/pop_bor_detail";
	}
	
}
