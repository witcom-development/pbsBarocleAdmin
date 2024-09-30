package com.dkitec.barocle.admin.customer.notice.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Iterator;
import java.util.List;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.dkitec.barocle.admin.customer.notice.service.NoticeService;
import com.dkitec.barocle.admin.customer.notice.vo.FileVO;
import com.dkitec.barocle.admin.customer.notice.vo.NoticeVO;
import com.dkitec.barocle.admin.customer.notice.vo.NoticeVO.NoticeAllVal;
import com.dkitec.barocle.admin.customer.notice.vo.NoticeVO.NoticeDeleteVal;
import com.dkitec.barocle.admin.customer.notice.vo.NoticeVO.NoticeEditVal;
import com.dkitec.barocle.admin.customer.notice.vo.NoticeVO.NoticeListVal;
import com.dkitec.barocle.admin.customer.notice.vo.NoticeVO.NoticePersistVal;
import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.admin.manage.stationmgmt.service.StationMgmtService;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.StringUtil;
import com.dkitec.barocle.util.webutil.WebUtil;
import com.dkitec.cfood.core.CfoodException;
import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
@RequestCategory(value="NoticeController")
@RequestMapping(value="/admin/customer/notice")
public class NoticeController extends BaseController {
	
	@Resource(name = "noticeService") private NoticeService noticeService;
	@Resource(name = "stationMgmtService") protected StationMgmtService stationMgmtService;
	
	protected static Logger log = LoggerFactory.getLogger(NoticeController.class);
	
	private final String[] noticeSearchParameter = {"searchValue","searchStartDate","searchEndDate"};
	
	@RequestName(value="getNoticeList")
	@RequestMapping(value="/noticeList.do")
	public String getNoticeList(@Validated(NoticeListVal.class) NoticeVO noticeVO, BindingResult result, HttpServletRequest request, Model model) {
		
		/* validator check */
		if(result.hasErrors()){
			model.addAttribute("noticeView", noticeVO);
			model.addAttribute("resultError", super.setResultMessage(result));
			return "/admin/customer/notice/bor_not_list";
		}
		
		boolean bResult = false;
		String resultPage = "/admin/customer/notice/bor_not_list";
		
		try{
			// 검색어 한글 깨짐 막음
			if(noticeVO.getSearchValue() != null || "".equals(noticeVO.getSearchValue()))
				noticeVO.setSearchValue( new String(noticeVO.getSearchValue().getBytes("8859_1"), "UTF-8") );
			
			// 총 레코드 개수를 가져온다.
			noticeVO.setTotalRecordCount(noticeService.listNoticeCount(noticeVO));
			// 페이징
			PaginationInfo paginationInfo = getPagingInfo(noticeVO.getCurrentPageNo(), noticeVO.getTotalRecordCount());
			PaginationInfo paginationMobileInfo = getPagingMobileInfo(noticeVO.getCurrentPageNo(), noticeVO.getTotalRecordCount());
			noticeVO.setFirstRecordIndex(paginationInfo.getFirstRecordIndex());
			noticeVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			// 현재 화면의 정보를 지정한다.
			model.addAttribute("noticeView",noticeVO);
			// 현재 화면의 레코드 목록을 지정한다.
			model.addAttribute("noticeList",noticeService.listNotice(noticeVO));
			// 현재 화면의 검색 파라미터 값을 지정한다.
			model.addAttribute("parameterInfo",super.setGivenParameterValue(request,this.noticeSearchParameter));
			// 현재 화면에 표시되는 페이징 정보를 지정한다.
			model.addAttribute("paginationInfo",paginationInfo);
			model.addAttribute("paginationMobileInfo",paginationMobileInfo);
			
			bResult = true;		// 정상
			
		} catch (Exception e) {
			throw new CfoodException("admin.customer.notice.noticeList",e);
		}
		
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	/* NOTE : 상세/등록/수정 화면
	 * mode=null 상세
	 * mode=view,noticeSeq=x 상세
	 * mode=edit,noticeSeq=y 수정
	 * 위와 같은 값이 존재하면 해당 로직으로 처리한다.
	 */
/*	@RequestName(value="editNotice")
	@RequestMapping(value="/noticeEdit.do")
	public String editNotice(@Validated(NoticeEditVal.class) NoticeVO noticeVO, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		
		/* validator check */
/*		if(result.hasErrors()){ throw new CfoodException("admin.customer.notice.noticeEdit.bindingexception"); }
		
		boolean bResult = false;
		String resultPage = "/admin/customer/notice/bor_not_detail";
		String getPersistMode = noticeVO.getMode();
		UserSessionVO userSessionVO = (UserSessionVO) EgovSessionCookieUtil.getSessionAttribute(request, "userSessionVO");
		
		try{
			Map<String,NoticeVO> returnMap = noticeService.viewNotice(noticeVO);
			NoticeVO noticeView = new NoticeVO();	// 입력 수정 동시에 사용할 변수 선언
			
			noticeView.setMode(MODE_INSERT);	// default mode
			
			if(MODE_VIEW.equalsIgnoreCase(getPersistMode)){
				
				//model.addAttribute("prevNoticeView",(NoticeVO)returnMap.get("prevNoticeVO"));	// 이전 공지사항
				//model.addAttribute("nextNoticeView",(NoticeVO)returnMap.get("nextNoticeVO"));	// 다음 공지사항
				
			} else if(MODE_EDIT.equalsIgnoreCase(getPersistMode)&&noticeVO.getNoticeSeq()>0){
				
				noticeView = returnMap.get("returnVO");
				noticeView.setMode(MODE_UPDATE);
				resultPage = "/admin/customer/notice/bor_not_detail";

				model.addAttribute("seqNo",noticeVO.getNoticeSeq());
				model.addAttribute("daumEditorImageList", noticeService.listDaumEditorVO(noticeVO));
			}
			
			// 현재 화면를 가져온다.
			noticeView.setCurrentPageNo(noticeVO.getCurrentPageNo());
			
			// 현재 화면의 검색 파라미터 값을 지정한다.
			model.addAttribute("parameterInfo",super.setGivenParameterValue(request,this.noticeSearchParameter));
			model.addAttribute("noticeView",noticeView);		// 공지사항 내용
			model.addAttribute("usrGrpSeq", userSessionVO.getUsrGrpCd());		// 공지사항 내용
			
			bResult = true;		// 정상
			
		} catch (Exception e){
			throw new CfoodException("admin.customer.notice.noticeEdit",e);
		}
		
		return bResult ? resultPage : ERROR_PAGE;
	}
*/	
	/* NOTE : 상세/등록/수정 화면
	 * mode=null 상세
	 * mode=view,noticeSeq=x 상세
	 * mode=edit,noticeSeq=y 수정
	 * 위와 같은 값이 존재하면 해당 로직으로 처리한다.
	 */
	@RequestName(value="editNotice")
	@RequestMapping(value="/noticeEdit.do")
	public String editNotice(@Validated(NoticeEditVal.class) NoticeVO noticeVO, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		boolean bResult = false;
		String resultPage = "/admin/customer/notice/bor_not_detail";
		
		try {
			NoticeVO noticeView = new NoticeVO();	// 입력 수정 동시에 사용할 변수 선언
			List<FileVO> imgList  = new ArrayList<>();
			List<FileVO> fileList = new ArrayList<>();
			
			if(MODE_EDIT.equals(noticeVO.getMode()) && noticeVO.getNoticeSeq() > 0 ){
				// 공지 내용 조회
				noticeView = noticeService.viewNotice2(noticeVO);
				
				if( noticeView != null && noticeView.getAtchFileID() != null && noticeView.getAtchFileID().startsWith(","))
					noticeView.setAtchFileID(noticeView.getAtchFileID().replaceFirst(",", ""));
				
				if( noticeView != null && noticeView.getAtchFileID() != null && "0".compareTo(noticeView.getAtchFileID()) < 0 ) {
					
					String atchFileId = noticeView.getAtchFileID();
					String[] attachArr = atchFileId.split(",");
					
					if( attachArr.length == 0 ) {
						noticeVO.setAtchFileID(atchFileId);
						
						FileVO fileVo = noticeService.getBBSImage(noticeVO);
						
						if( fileVo != null && fileVo.getImgURL() != null ) {
						
							String fileType = (fileVo.getImgURL().toUpperCase()).substring( fileVo.getImgURL().length() -3 );
							
							switch( fileType ) {
							case "JPEG" :
							case "JPG" :
							case "PNG" :
							case "BMP" :
								imgList.add(fileVo);
								break;
							default :
								fileList.add(fileVo);
							}
						}						
					}
					
					for( String imgAttach : attachArr) {
						
						if( "".equals(imgAttach )) continue;
						
						noticeVO.setAtchFileID(imgAttach);
						
						FileVO fileVo = noticeService.getBBSImage(noticeVO);
						
						if( fileVo 				  == null ) continue;
						if( fileVo.getImgURL()  == null ) continue;
						String fileType = (fileVo.getImgURL().toUpperCase()).substring( fileVo.getImgURL().length() -3 );
						
						switch( fileType ) {
						case "JPEG" :
						case "JPG" :
						case "PNG" :
						case "BMP" :
							imgList.add(fileVo);
							break;
						default :
							fileList.add(fileVo);
						}
						
					}
					
				
				}
				
			}else{
				noticeView.setNoticeSeq(0);
			}
			
			model.addAttribute("bbsBoardVO"   , noticeView );
			model.addAttribute("bbsImgList"   , imgList );
			model.addAttribute("bbsFileList"  , fileList );
			String homeURL		=  super.propertiesService.getString("homeURL");
			model.addAttribute("homeURL"		, homeURL );
			
			bResult = true;		// 정상				
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			throw new CfoodException("fail.common.msg",e);
		}
		
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	/* NOTE : 상세/등록/수정 화면
	 * /admin/customer/notice/noticeInsert.do || /admin/customer/notice/noticeUpdate.do 와 같이 uri를 확인하여 현재 요청 모드를 설정한다.
	 */
	@RequestName(value="persistNotice")
	@RequestMapping(value="/noticeUpdate.do")
	public String persistNotice(@Validated(NoticePersistVal.class) NoticeVO noticeVO, BindingResult result, HttpServletRequest request, Model model) {
		
		/* Validator error */
		if(result.hasErrors()){
			model.addAttribute("noticeView", noticeVO);
			model.addAttribute("resultError", super.setResultMessage(result));
			return "/admin/customer/notice/bor_not_detail";
		}

		boolean bResult = false;
		String resultPage = "redirect:/admin/customer/notice/noticeEdit.do?mode=edit&noticeSeq=";
		String getPersistMode = noticeVO.getMode();
		
		/* check uri */
		String requestURI = (String)request.getRequestURI().toString();
		if(requestURI.indexOf("/noticeInsert.do")>0){ getPersistMode = MODE_INSERT; } 
		else if(requestURI.indexOf("/noticeUpdate.do")>0){ getPersistMode = MODE_UPDATE; }
		else { throw new CfoodException("admin.customer.notice.noticePersist.NullModeException"); }
		
		try{
			/* get set session */
			try{
				noticeVO.setRegID((String)EgovSessionCookieUtil.getSessionAttribute(request, "usrId"));
				noticeVO.setModID((String)EgovSessionCookieUtil.getSessionAttribute(request, "usrId"));
			} catch(Exception e){ throw new CfoodException("admin.customer.notice.noticePersist.NullSessionException",e); }
			
			NoticeVO returnVO = null;
			bResult = true;		// 정상
			
			/*
			다음 에디터에서 내용은 noticeHTMLContent에 저장되어 들어온다. noticeHTMLContent내용은 html태그가 포함되어 있다.
			NOTICE_TEXT_CONTENT AS noticeTextContent : <img>를 제외한 모든 테그를 삭제하여 저장한다.
			NOTICE_HTML_CONTENT AS noticeHTMLContent : 모든 html 태그를 포함한다.
			 */
			noticeVO.setNoticeTextContent(WebUtil.removeHTMLSpecialChars(WebUtil.replaceHTMLSpecialChars(noticeVO.getNoticeHTMLContent()), ""));
			
			/*
			noticeHTMLContent에서 img value를 모두 가녀온다. 해당 img값/값들로 TB_COM_DAUM_IMAGE 테이블에 매핑한다.
			다음 에디터는 내용을 DB에 저장하기 전에 popup창으로 이미지를 먼저 등록한다. 이 과정에서 우선적으로 이미지 파일은 서버에 업로드 되어 있고, 그 기록은 TB_COM_DAUM_IMAGE에 저장되어 있다.
			다음 에디터로 내응이 작성되고 DB에 저장이 되면 해당 내용에 대한 SEQ 값을 가져오는데, 이때 이 SEQ값을 TB_COM_DAUM_IMAGE 테이블에 저장해야한다.
			저장해야 하는 대상의 레코드는 이미지 파일명으로 찾는다.(이미지 파일명은 고유명으로 저장하게 끔 했다.)
			아래 내용은 daum editor에서 넘기는 attach_image_info 파라미터(들)의 filename을 추출해서 List객체로 리턴하고, 다시 noticeVO.ImageList에 저장한다.
			 */
			if(noticeVO.getAttach_image_info()!=null&&!"".equals(noticeVO.getAttach_image_info())){
				noticeVO.setImageList(getEditorImageList(noticeVO.getAttach_image_info()));
			}
			
			//파일 업로드 _ cms _ 20161108
			if(noticeVO.getAttach_file()!=null&&!"".equals(noticeVO.getAttach_file())){
				noticeVO.setFileList(getEditorImageList(noticeVO.getAttach_file()));
			}
			
			// 현재 모드를 확인하여 해당 persist를 실행
			//String msg = "<바로클> 자전거 반납 추천 대여소 주변에 추천 반납 대여소 확인하기.";
			String msg = "바로클 자전거";
			//String TARGET_URL = "https://www.bikeseoul.com:446/app/rent/moveRecommendReturnStation.do";
			//String resultPage = "redirect:/admin/customer/notice/noticeList.do";
			String TARGET_URL = "https://www.bikeseoul.com/main.do";
			if(MODE_INSERT.equalsIgnoreCase(getPersistMode)){
				returnVO = noticeService.insertNotice(noticeVO);
				// push 주석처리
				/*if("Y".equals( noticeVO.getPushYN() ) &&  (  noticeVO.getSiteClsCD() != null && noticeVO.getSiteClsCD().indexOf("user") > -1)) {
					//push start
					//아이폰 사용자 목록
					List<String> apnsList = new ArrayList<String>();
					//안드로이드 사용자 목록
		        	List<String> gcmList = new ArrayList<String>();
					
		        	List<PushVO> msgTargetList = noticeService.getPushTargetList();
		        	
		        	if(msgTargetList != null && msgTargetList.size() > 0) {
			        	for(PushVO target :msgTargetList) {
			            	if(target.getUsrDeviceType() != null) {
			            		if(target.getUsrDeviceType().equals(IConstants.PUSH_TYPE_APNS)){
			            			apnsList.add(target.getUsrDeviceId());
			            		} else if(target.getUsrDeviceType().equals(IConstants.PUSH_TYPE_GCM)) {
			            			gcmList.add(target.getUsrDeviceId());
			            		} 
			            	}
			            }
		        	}
		        	
					//안드로이드
		            if(gcmList != null && gcmList.size() > 0) {
		            	
			            PushVO gcmVo = new PushVO();
			            gcmVo.setPushType(IConstants.PUSH_TYPE_GCM);
			            gcmVo.setMessage(msg);
			            gcmVo.setPushLinkUrl(TARGET_URL);
			            gcmVo.setTokenList(gcmList);
		                
			            //PushSendProc.exePush(gcmVo);
		            }
		            //아이폰
		             if(apnsList != null &&  apnsList.size() > 0) {
			            PushVO apnsVo = new PushVO();
			            apnsVo.setPushType(IConstants.PUSH_TYPE_APNS);
			            apnsVo.setMessage(msg);
			            apnsVo.setPushLinkUrl(TARGET_URL);
			            apnsVo.setTokenList(apnsList);
			            //PushSendProc.exePush(apnsVo);
		            }
					
		             //testPush
		             List<String> pushList = new ArrayList<String>();
		             PushVO pushVo = new PushVO();
		             pushVo.setPushType(IConstants.PUSH_TYPE_GCM);
		             pushVo.setMessage(msg);
		             pushVo.setPushLinkUrl(TARGET_URL);
		             pushVo.setUsrSeq("841268");
		             
		             pushList.add("APA91bF2XR4YCQW1QOZSoCnqyoTYZaSXHaStIZYua5yuSc1ogXHIc0CyziDJi0rJYFRt99HQocbAtYKXpUXv0PpT4CtzRWRPFFl78_indMQlBvzplzQJ8ShmXxYqEvUMpy9Dlr6_trqb");
		             pushVo.setTokenList(pushList);
		             //PushSendProc.exePush(pushVo);
		             //일단 공지사항 쪽에 테스트만듬
		             int intResult = noticeService.insertPush(pushVo);
		             
					//push end
				}
				*/
			} else if(MODE_UPDATE.equalsIgnoreCase(getPersistMode)){
				returnVO = noticeService.updateNotice(noticeVO);
			} else bResult = false;
			
			if(bResult) resultPage += String.valueOf(returnVO.getNoticeSeq());
			
		} catch(Exception e){
			throw new CfoodException("admin.customer.notice.noticePersist",e);
		}
		
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	/* NOTE : 상세/등록/수정 화면
	 * /admin/customer/notice/noticeInsert.do || /admin/customer/notice/noticeUpdate.do 와 같이 uri를 확인하여 현재 요청 모드를 설정한다.
	 */
	@RequestName(value="noticeInsert")
	@RequestMapping(value="/noticeInsert.do")
	public String noticeInsert( NoticeVO vo, BindingResult result, HttpServletRequest request, Model model) {
		
		/* Validator error */
		if(result.hasErrors()) {
			model.addAttribute(RESULT_MESSAGE, super.setResultMessage(result));
			model.addAttribute(CHECK_RESULT, false);
			return JSONVIEW;
		}
		
		/* get set session */
		try {
			vo.setRegID((String)EgovSessionCookieUtil.getSessionAttribute(request, "usrId"));
			vo.setModID((String)EgovSessionCookieUtil.getSessionAttribute(request, "usrId"));
		} catch (Exception e){ 
			model.addAttribute(RESULT_MESSAGE, "로그인 사용자 정보 없음. 재로그인 필요");
			model.addAttribute(CHECK_RESULT, false);
			return JSONVIEW;
		}
		
		try {
			
			if( vo.getNoticeSeq() == 0 ) {
				noticeService.insertNotice(vo); 

				String getAttachNo = vo.getImgSeq();
				
				if( getAttachNo != null && !"".equals(getAttachNo) ) {	
					String[] attachArr = getAttachNo.split(",");
					
					if( attachArr.length == 0 ) {
						vo.setImgSeq(getAttachNo);
						noticeService.updateImage(vo); 
					}
					
					for( String imgAttach : attachArr) {
						vo.setImgSeq(imgAttach);
						noticeService.updateImage(vo); 
					}
				}
			} else {
				
				noticeService.updateNotice(vo);
				String getAttachNo = vo.getImgSeq();
				if( getAttachNo != null && !"".equals(getAttachNo) ) {
					String[] attachArr = getAttachNo.split(",");
					
					if( attachArr.length == 0 ) {
						vo.setImgSeq(getAttachNo);
						noticeService.updateImage(vo); 
					}
					
					for( String imgAttach : attachArr) {
						vo.setImgSeq(imgAttach);
						noticeService.updateImage(vo); 
					}
				}
			}
			
			model.addAttribute("BOARD_SEQ", vo.getNoticeSeq());
			model.addAttribute(CHECK_RESULT, true);
			return JSONVIEW;
			
			//if(bResult) resultPage += String.valueOf(returnVO.getDistSeq());
		} catch (Exception e) {
			model.addAttribute(RESULT_MESSAGE, e.getLocalizedMessage());
			model.addAttribute(CHECK_RESULT, false);
			return JSONVIEW;
		}
		
		
	}
	
	@RequestName(value="deleteNotice")
	@RequestMapping(value="/noticeDelete.do")
	public String deleteNotice(@Validated(NoticeDeleteVal.class) NoticeVO noticeVO, HttpServletRequest request, BindingResult result, Model model) {
		
		/* validator check */
		if(result.hasErrors()){
			model.addAttribute("resultError", "권한이 없습니다.");
			throw new CfoodException("admin.customer.notice.noticeDelete.bindingexception");
		}
		
		boolean bResult = false;
		String resultPage = "redirect:/admin/customer/notice/noticeList.do";
		
		try{
			/* get set session */
			try{
				noticeVO.setRegID((String)EgovSessionCookieUtil.getSessionAttribute(request, "usrId"));
				noticeVO.setModID((String)EgovSessionCookieUtil.getSessionAttribute(request, "usrId"));
			} catch(Exception e){ throw new CfoodException("admin.customer.notice.noticeDelete.NullSessionException",e); }
			
			if(noticeService.deleteNotice(noticeVO)>0){ bResult = true; }
			
		} catch(Exception e){
			throw new CfoodException("admin.customer.notice.noticeDelete",e);
		}
		
		return bResult ? resultPage : ERROR_PAGE;
	}
	
	@RequestName(value="popupNoticeCount")
	@RequestMapping(value="/noticePopupCount.do")
	public String popupNoticeCount(@ModelAttribute("noticeVO") NoticeVO noticeVO, HttpServletRequest request, Model model) {
		try {
			java.util.List<NoticeVO> listNoticeVO = noticeService.listNoticePopupCount(noticeVO);
			model.addAttribute("popupCount",listNoticeVO);
		} catch (Exception e) {
			throw new CfoodException("admin.customer.notice.popupNoticeCount",e);
		}
		return JSONVIEW;
	}
	
	@RequestName(value="popupNotice")
	@RequestMapping(value="/noticePopup.do")
	public String popupNotice(@ModelAttribute("noticeVO") NoticeVO noticeVO, HttpServletRequest request, Model model) {
		try {
			if(request.getParameter("popSeq")!=null&&!StringUtil.isEmpty((String)request.getParameter("popSeq"))){ noticeVO.setNoticeSeq(Integer.parseInt((String)request.getParameter("popSeq"))); }
			model.addAttribute("popupView",noticeService.listNoticePopup(noticeVO));
		} catch (Exception e) {
			throw new CfoodException("admin.customer.notice.popupNotice",e);
		}
		return "/admin/common/popup/pop_not_detail";
	}
	
	
	/* 파일 다운로드 
	 */
	@RequestName(value="downloadFile")
	@RequestMapping(value="/downloadFile.do")	
	public ModelAndView downloadFile(@Validated(NoticeAllVal.class) NoticeVO noticeVO, BindingResult result, HttpServletRequest request, Model model) {
		
		ModelAndView mav = new ModelAndView("filedownloadView");

		//현화면의 이름를 알려준다(notice)
		String folDer = String.valueOf(request.getParameter("currentPageName"));
		noticeVO.setaFolder(folDer);
		
		try {
			String pathZipNm= noticeService.fileDownloadList(noticeVO);
			String fileNm= noticeService.fileDownloadNm(noticeVO);
			
			mav.addObject("fileName", new File(pathZipNm));
			mav.addObject("fileNm", new File(fileNm));

		} catch (Exception e) {
			e.printStackTrace();
		}
        return mav;
	}
	
	@RequestName(value="fileUpload")
	@RequestMapping(value="/fileUpload.do")
	public String daumeditorFileUploadPersist (@Validated FileVO FileVO, BindingResult result, HttpServletRequest request, Model model)  {
		
		String currentPageName = String.valueOf(request.getParameter("currentPageName"));
		String bbsSeq          = String.valueOf(request.getParameter("noticeSeq"));
		String bbsClsCd        = "CTM_001";
		
		// currentPageName값은 현재 작성중인 페이지 메뉴와 이미지가 저장될 경로를 결정한다. 이에 currentPageName을 값은 daumeditor.properties에 정의된 daumFiledir값으로 유효성을 검사해야 한다.
		if(!"null".equalsIgnoreCase(currentPageName)&&!"".equals(currentPageName)&&propertiesService.getString("allowFileDir").indexOf(currentPageName)>=0){
			FileVO.setBbsClsCD(currentPageName);
			FileVO.setImgPath(currentPageName + "/");
			currentPageName = "/" + (String)request.getParameter("currentPageName") + "/";
		} else {
			model.addAttribute(CHECK_RESULT, "파일 업로드 기능에 실패하였습니다.");
			model.addAttribute(CHECK_RESULT, false);
			return JSONVIEW;
		}
		
		boolean bResult = false;
		String tempFileURL = "";
		
		try{
			
			// 이미지 받아오기
			MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest)request;
			multiRequest.setCharacterEncoding(propertiesService.getString("fileEncoding"));
			final Map<String, MultipartFile> files = multiRequest.getFileMap();
			
			if( files == null ) {
				model.addAttribute(CHECK_RESULT, "파일 업로드 기능에 실패하였습니다.");
				model.addAttribute(CHECK_RESULT, false);
				return JSONVIEW;
			}
			
			String fileUploadDir 	=   propertiesService.getString("fileUploadDir");
			String ctnDaumDir 		= 	propertiesService.getString("ctnDaumDir");
			
			String ctnDaumURL 		=   propertiesService.getString("ctnDaumURL");
			
			// 저장 경로 설정 및 생성
			File saveFolder = new File( fileUploadDir + ctnDaumDir+currentPageName);
			
			if (!saveFolder.exists() || saveFolder.isFile()){ saveFolder.mkdirs(); }
			
			// 저장 파일 설정
			Iterator<Map.Entry<String, MultipartFile>> itr = files.entrySet().iterator();
			tempFileURL = ctnDaumURL + ctnDaumDir + currentPageName;
			
			Map.Entry<String, MultipartFile> entry = itr.next();
			MultipartFile file = entry.getValue();
			
			if ( "".equals(file.getOriginalFilename())) {
				model.addAttribute(CHECK_RESULT, "파일명칭이 미존재합니다.");
				model.addAttribute(CHECK_RESULT, false);
				return JSONVIEW;
			}	
			
			// set new name
			String orgFileName = file.getOriginalFilename();
			int dot = orgFileName.lastIndexOf(".");
			String fileExtension = null;
			if(dot!=-1){ fileExtension = orgFileName.substring(dot); } // includes "."
			
			
			FileVO.setBbsClsCD(bbsClsCd);
			
			// 파일 설정
			String fileNameExtension = new SimpleDateFormat("yyyyMMddHHmmsss").format(Calendar.getInstance().getTime()) + fileExtension;
			// 파일 명
			String fileName = orgFileName.substring(0, dot) + fileNameExtension;
			
			// 파일 경로
			String newFileNameExe = String.valueOf(request.getParameter("currentPageName")) + "_img" + "_" + fileNameExtension;
			FileVO.setImgName(fileName);
			
			String homeURL			=  super.propertiesService.getString("homeURL");
			
			FileVO.setImgURL(homeURL + tempFileURL + newFileNameExe);
			
			String originalFilePath = fileUploadDir + ctnDaumDir + currentPageName;
			
			File newFile = new File(originalFilePath + newFileNameExe);
	    	file.transferTo(newFile);
	     
			// 파일 저장
			FileVO.setImgSize((int)file.getSize());
			
			// 파일 업데이트 (커멘트 값있을 경우 커멘트 값 업뎃 )
		
			System.out.println("bbsSeq["+bbsSeq+"]");
			if( bbsSeq != null && "0".compareTo(bbsSeq) < 0  && !"".equals(bbsSeq)  && !"null".equals(bbsSeq) ) {
				
				FileVO.setNoticeSeq( Integer.parseInt( bbsSeq) );
				// 등록한 이미지 DB에 저장 : TB_COM_DAUM_IMG
				System.out.println("FileVO================>"+FileVO);
				noticeService.bbsImage(FileVO);
				System.out.println("bbsImageeeeeeeeeeeeeeeeeeeeeeeeeeeee");
					
				NoticeVO bbsVo= new NoticeVO();
				bbsVo.setNoticeSeq( Integer.parseInt( bbsSeq));
				bbsVo.setImgSeq( FileVO.getImgSeq() + "");
				bbsVo.setModID((String)EgovSessionCookieUtil.getSessionAttribute(request, "usrId"));
				System.out.println("bbsVo================>"+bbsVo);
				noticeService.appendBbsImage(bbsVo);
					
			} else {
				model.addAttribute(CHECK_RESULT, "파일 저장에 실패했습니다.");
				model.addAttribute(CHECK_RESULT, false);
			}
			
			bResult = true;
				
		} catch (Exception e) {
			e.printStackTrace();
			
			model.addAttribute(CHECK_RESULT, e.getLocalizedMessage());
			model.addAttribute(CHECK_RESULT, false);
		} 
		
		model.addAttribute("imgSeq", FileVO.getImgSeq());
		model.addAttribute("imageurl", FileVO.getImgURL());
		model.addAttribute("imageName", FileVO.getImgName());
		model.addAttribute(CHECK_RESULT, bResult);
		
		return JSONVIEW;
	}
	
	@RequestName(value="deleteImage")
	@RequestMapping(value={"/deleteImage.do"})
	public String boardDeleteImage( NoticeVO vo, BindingResult result, HttpServletRequest request, Model model) {
 
		/* Validator error */
		if(result.hasErrors()) {
			model.addAttribute(RESULT_MESSAGE, super.setResultMessage(result));
			model.addAttribute(CHECK_RESULT, false);
			return JSONVIEW;
		}
		 
		if( vo.getNoticeSeq() == 0 ) {
			model.addAttribute(RESULT_MESSAGE, "게시판 정보가 없습니다.");
			model.addAttribute(CHECK_RESULT, false);
			return JSONVIEW;			
		}
		
		if( vo.getAtchFileID() == null || "".equals(vo.getAtchFileID())  ) {
			model.addAttribute(RESULT_MESSAGE, "이미지 정보가 없습니다.");
			model.addAttribute(CHECK_RESULT, false);
			return JSONVIEW;			
		}
		 
		try {
			fileDelete(vo);
			
			noticeService.deleteBBSImage(vo); 
			if( vo.getNoticeSeq() > 0 ) noticeService.updateBbsImage(vo); 
			
			// 파일 삭제	
			model.addAttribute(RESULT_MESSAGE, "정상적으로 삭제되었습니다.");
			model.addAttribute(CHECK_RESULT, true);
			 
			// 페이지 이동
			
		} catch (Exception e) {
			
			model.addAttribute(RESULT_MESSAGE, e.getLocalizedMessage());
			model.addAttribute(CHECK_RESULT, false);
			
			return JSONVIEW;
		}
		
		return JSONVIEW;
	}
	
	private void fileDelete(NoticeVO vo) throws Exception, IOException {
		
		// imgSeq에 , 으로 시작될 경우
		if( vo.getAtchFileID() != null && vo.getAtchFileID().startsWith(",")) vo.setAtchFileID(vo.getAtchFileID().replaceFirst(",", ""));
		
		String getAttachNo = vo.getAtchFileID();
		
		if( getAttachNo != null && !"".equals(getAttachNo)  ) {
			String[] attachArr = getAttachNo.split(",");
			if( attachArr.length == 0 ) {
				
				vo.setAtchFileID(getAttachNo);
				fileImgSeqDelete(vo);
				
			} else {
				for( String imgAttach : attachArr) {
					vo.setAtchFileID(imgAttach);
					fileImgSeqDelete(vo);
				}
			}
		}
	}
	
	private void fileImgSeqDelete(NoticeVO vo) throws Exception, IOException {
		FileVO imageVo = noticeService.getBBSImage(vo);
		String fileUrl = imageVo.getImgURL();
		String homeURL			=  super.propertiesService.getString("homeURL");
		fileUrl = fileUrl.replace(homeURL, "");
		fileUrl = fileUrl.replace("/upload", "");
		
		String fileUploadDir 	=   propertiesService.getString("fileUploadDir");
		
		String fullFilePath     = "";
		
		fullFilePath = fileUploadDir.concat(fileUrl);
		
		// 저장 경로 설정 및 생성
		Path filePath = Paths.get(fullFilePath);
		
		// 파일 삭제
		Files.delete(filePath);
	}
	
	/* NOTE : 상세/등록/수정 화면
	 * mode=null 상세
	 * mode=view,noticeSeq=x 상세
	 * mode=edit,noticeSeq=y 수정
	 * 위와 같은 값이 존재하면 해당 로직으로 처리한다.
	 */
	/*@RequestName(value="editNoticeTemplate")
	@RequestMapping(value="/noticeEditTemplate.do")
	public String editNoticeTemplate(@Validated(NoticeEditVal.class) NoticeVO noticeVO, BindingResult result, HttpServletRequest request, Model model) {
		
		 validator check 
		if(result.hasErrors()){ throw new CfoodException("admin.customer.notice.noticeEdit.bindingexception"); }
		
		boolean bResult = false;
		String resultPage = "/admin/customer/notice/bor_not_detail";
		String getPersistMode = noticeVO.getMode();
		
		try{
			Map<String,NoticeVO> returnMap = noticeService.viewNotice(noticeVO);
			NoticeVO noticeView = new NoticeVO();	// 입력 수정 동시에 사용할 변수 선언
			
			noticeView.setMode(MODE_INSERT);	// default mode
			
			if(MODE_VIEW.equalsIgnoreCase(getPersistMode)){
				//model.addAttribute("prevNoticeView",(NoticeVO)returnMap.get("prevNoticeVO"));	// 이전 공지사항
				//model.addAttribute("nextNoticeView",(NoticeVO)returnMap.get("nextNoticeVO"));	// 다음 공지사항
			} else if(MODE_EDIT.equalsIgnoreCase(getPersistMode)&&noticeVO.getNoticeSeq()>0){
				noticeView = returnMap.get("returnVO");
				noticeView.setMode(MODE_UPDATE);
				resultPage = "/admin/customer/notice/bor_not_detail";

				model.addAttribute("seqNo",noticeVO.getNoticeSeq());
				model.addAttribute("daumEditorImageList", noticeService.listDaumEditorVO(noticeVO));
			} // else MODE_WRITE;
			
			// 현재 화면를 가져온다.
			noticeView.setCurrentPageNo(noticeVO.getCurrentPageNo());
			
			// 현재 화면의 검색 파라미터 값을 지정한다.
			model.addAttribute("parameterInfo",super.setGivenParameterValue(request,this.noticeSearchParameter));
			model.addAttribute("noticeView",noticeView);		// 공지사항 내용
			
			bResult = true;		// 정상
			
		} catch (Exception e){
			throw new CfoodException("admin.customer.notice.noticeEdit",e);
		}
		
		return bResult ? resultPage : ERROR_PAGE;
	}
*/
}



