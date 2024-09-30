package com.dkitec.barocle.admin.customer.notice.service;

import java.util.List;

import com.dkitec.barocle.admin.customer.daumeditor.vo.DaumEditorVO;
import com.dkitec.barocle.admin.customer.notice.vo.FileVO;
import com.dkitec.barocle.admin.customer.notice.vo.NoticeVO;
import com.dkitec.barocle.util.push.PushVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("noticeMapper")
public interface NoticeMapper {
	
	public int listNoticeCount(NoticeVO noticeVO);
	
	public List<NoticeVO> listNotice(NoticeVO noticeVO);
	
	public NoticeVO viewNotice(NoticeVO noticeVO);
	
	public NoticeVO viewNotice2(NoticeVO noticeVO);
	
	public List<DaumEditorVO> getDaumEditorImage(NoticeVO noticeVO);
	
	public NoticeVO prevNotice(NoticeVO noticeVO);
	
	public NoticeVO nextNotice(NoticeVO noticeVO);
	
	public int insertNotice(NoticeVO noticeVO);
	
	public int updateNotice(NoticeVO noticeVO);
	
	public int deleteDaumEditorImage(NoticeVO noticeVO);
	
	public int updateDaumEditorImage(NoticeVO noticeVO);
	
	public int deleteNotice(NoticeVO noticeVO);
	
	public List<NoticeVO> listNoticePopupCount(NoticeVO noticeVO);
	
	public NoticeVO listNoticePopup(NoticeVO noticeVO);

	public List<NoticeVO> fileDownloadList(NoticeVO noticeVO);	//파일 다운로드 조회 _cms_20161110

	public int insertPush(PushVO pushVO);
	
	public List<PushVO> getPushTargetList();
	
	public FileVO getBBSImage(NoticeVO vo);
	
	public int updateImage(NoticeVO noticeVO);
	
	public int bbsImage(FileVO FileVO);
	
	public int appendBbsImage(NoticeVO vo);
	public int deleteBBSImage(NoticeVO vo);
	public int updateBbsImage(NoticeVO vo);
	
}
