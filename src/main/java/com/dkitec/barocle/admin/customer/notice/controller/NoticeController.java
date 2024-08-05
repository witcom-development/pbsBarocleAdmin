package com.dkitec.barocle.admin.customer.notice.controller;

import java.io.File;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
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
import org.springframework.web.servlet.ModelAndView;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.cfood.core.web.annotation.RequestCategory;
import com.dkitec.cfood.core.web.annotation.RequestName;
import com.dkitec.barocle.admin.customer.notice.service.NoticeService;
import com.dkitec.barocle.admin.customer.notice.vo.NoticeVO;
import com.dkitec.barocle.admin.customer.notice.vo.NoticeVO.NoticeAllVal;
import com.dkitec.barocle.admin.customer.notice.vo.NoticeVO.NoticeDeleteVal;
import com.dkitec.barocle.admin.customer.notice.vo.NoticeVO.NoticeEditVal;
import com.dkitec.barocle.admin.customer.notice.vo.NoticeVO.NoticeListVal;
import com.dkitec.barocle.admin.customer.notice.vo.NoticeVO.NoticePersistVal;
import com.dkitec.barocle.admin.login.security.filter.EgovSessionCookieUtil;
import com.dkitec.barocle.admin.login.vo.UserSessionVO;
import com.dkitec.barocle.admin.manage.stationgroup.vo.StationGroupMgmtVO;
import com.dkitec.barocle.admin.manage.stationmgmt.service.StationMgmtService;
import com.dkitec.barocle.admin.manage.stationmgmt.vo.StationMgmtVO;
import com.dkitec.barocle.base.BaseController;
import com.dkitec.barocle.util.webutil.StringUtil;
import com.dkitec.barocle.util.webutil.WebUtil;

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
	@RequestName(value="editNotice")
	@RequestMapping(value="/noticeEdit.do")
	public String editNotice(@Validated(NoticeEditVal.class) NoticeVO noticeVO, BindingResult result, HttpServletRequest request, Model model) throws Exception {
		
		/* validator check */
		if(result.hasErrors()){ throw new CfoodException("admin.customer.notice.noticeEdit.bindingexception"); }
		
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
			//} else if(getPersistMode.equalsIgnoreCase("templateStation")) {
			/*else if("templateStation".equalsIgnoreCase(getPersistMode)) {	
				
				StationGroupMgmtVO stationVo = new StationGroupMgmtVO();
				stationVo.setStation_id(noticeVO.getNoticeStationId());
				
				List<StationMgmtVO> stationVoResList = stationMgmtService.getStationNameInfo(stationVo);
				
				for (int i=0;i<stationVoResList.size();i++){
					
					if(stationVoResList.get(i).getLang_cls_cd().equals("LAG_001")){
						
						noticeView.setNoticeTitle(stationVoResList.get(i).getStation_name()+" 임시 폐쇄 안내");
						DateFormat sdFormat = new SimpleDateFormat("yyyy-MM-dd");
						Date nowDate = new Date();
						
						//2020-10-30 : 날짜가 없을 시 현재날짜로
						String tempDate = "";
						String tempDate1 = "";
						
						if(noticeVO.getPostStrDttm() != null && noticeVO.getPostEndDttm() != null){
							
							tempDate = sdFormat.format(noticeVO.getPostStrDttm());
							tempDate1 = sdFormat.format(noticeVO.getPostEndDttm());
							
						}else if(noticeVO.getPostStrDttm() != null && noticeVO.getPostEndDttm() == null){
							
							tempDate = sdFormat.format(noticeVO.getPostStrDttm());
							
						}else{
							
							tempDate = sdFormat.format(nowDate);
							tempDate1 = sdFormat.format(nowDate);
							
						}
						
						noticeView.setNoticeTextContent("안녕하세요? \n"
								+"아파트 자전거 바로클입니다. \n"
                                +"\n"
                                +"\n"
                                +"아래 대여소를 임시 폐쇄하오니 \n"
                                +"이용에 착오 없으시길 바랍니다. \n"
                                +"\n"
                                +"\n"
                                +"임시폐쇄대여소 : "+stationVoResList.get(i).getStation_name()+"\n"
								+"사용중단기간 :"+tempDate+"~"+tempDate1+"마감시까지\n"
								+"사용중단사유 :\n"
								+"\n"
								+"\n"
								+"이용에 불편드려 죄송합니다.\n"
								+"※ 불편사항 또는 문의사항 연락처 : 02-542-7781 \n");
						
						noticeView.setNoticeHTMLContent("안녕하세요? \n"
								+"아파트 자전거 바로클입니다. <br>"
                                +"<br>"
                                +"<br>"
                                +"아래 대여소를 임시 폐쇄하오니 <br>"
                                +"이용에 착오 없으시길 바랍니다. <br>"
                                +"<br>"
                                +"<br>"
                                +"임시폐쇄대여소 : "+stationVoResList.get(i).getStation_name()+"<br>"
								+"사용중단기간 :"+tempDate+"~"+tempDate1+"마감시까지<br>"
								+"사용중단사유 : <br>"
								+"<br>"
								+"<br>"
								+"이용에 불편드려 죄송합니다.<br>"
								+"※ 불편사항 또는 문의사항 연락처 : 02-542-7781 <br>");
						
					}
					
				}
				
				noticeView.setSiteClsCD("admin");
				noticeView.setPostStrDttm(noticeVO.getPostStrDttm());
				noticeView.setPostEndDttm(noticeVO.getPostEndDttm());
				
			}*/
			
			// else MODE_WRITE;
			
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
	
	/* NOTE : 상세/등록/수정 화면
	 * /admin/customer/notice/noticeInsert.do || /admin/customer/notice/noticeUpdate.do 와 같이 uri를 확인하여 현재 요청 모드를 설정한다.
	 */
	@RequestName(value="persistNotice")
	@RequestMapping(value={"/noticeInsert.do","/noticeUpdate.do"})
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



