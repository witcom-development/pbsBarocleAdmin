package com.dkitec.barocle.admin.customer.opinionboard.service;

import java.util.List;
import java.util.Map;

import com.dkitec.barocle.admin.customer.daumeditor.vo.DaumEditorVO;
import com.dkitec.barocle.admin.customer.opinionboard.vo.OpinionBoardVO;

public interface OpinionBoardService {
	
	public int listOpinionBoardCount(OpinionBoardVO opinionBoardVO);
	
	public java.util.List<OpinionBoardVO> listOpinionBoard(OpinionBoardVO opinionBoardVO);
	
	public Map<String,OpinionBoardVO> viewOpinionBoard(OpinionBoardVO opinionBoardVO) throws Exception;
	
	public List<DaumEditorVO> listDaumEditorVO(OpinionBoardVO opinionBoardVO);
	
	public int getOpinionBoardReply(OpinionBoardVO opinionBoardVO);
	
	public OpinionBoardVO insertOpinionBoard(OpinionBoardVO opinionBoardVO);
	
	public OpinionBoardVO updateOpinionBoard(OpinionBoardVO opinionBoardVO);
	
	public int deleteOpinionBoard(OpinionBoardVO opinionBoardVO);

	public java.util.List<OpinionBoardVO> gubunList();				// 시민의견수렴 구분 list _cms _ 20161222
	
	public int insertAdminInfo(OpinionBoardVO opinionBoardVO);	// 담당자 등록 180828

	public int insertDeadline(OpinionBoardVO opinionBoardVO);	// 답변기한 수정등록 20200914
}
