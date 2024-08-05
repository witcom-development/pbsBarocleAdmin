package com.dkitec.barocle.admin.customer.notice.service;

import java.util.List;
import java.util.Map;

import com.dkitec.barocle.admin.customer.daumeditor.vo.DaumEditorVO;
import com.dkitec.barocle.admin.customer.notice.vo.NoticeVO;
import com.dkitec.barocle.util.push.PushVO;

public interface NoticeService {
	
	public int listNoticeCount(NoticeVO noticeVO) throws Exception;
	
	public List<NoticeVO> listNotice(NoticeVO noticeVO) throws Exception;
	
	public Map<String,NoticeVO> viewNotice(NoticeVO noticeVO) throws Exception;
	
	public List<DaumEditorVO> listDaumEditorVO(NoticeVO noticeVO) throws Exception;
	
	public NoticeVO insertNotice(NoticeVO noticeVO) throws Exception;
	
	public NoticeVO updateNotice(NoticeVO noticeVO) throws Exception;
	
	public int deleteNotice(NoticeVO noticeVO) throws Exception;
	
	public List<NoticeVO> listNoticePopupCount(NoticeVO noticeVO) throws Exception;
	
	public NoticeVO listNoticePopup(NoticeVO noticeVO) throws Exception;

	public String fileDownloadList(NoticeVO noticeVO) throws Exception; // 파일 다운로드 리스트_cms_20161110

	public String fileDownloadNm(NoticeVO noticeVO) throws Exception; ;	// 파일명 가져오기_cms_20161114	
	
	public int insertPush(PushVO pushVO) throws Exception; ;	
	
	public List<PushVO> getPushTargetList() throws Exception;
	//public NoticeVO replyBbs(NoticeVO noticeVO) throws Exception;
	
	//public NoticeVO commentBbs(NoticeVO noticeVO) throws Exception;

}
