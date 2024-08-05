package com.dkitec.barocle.admin.customer.opinionboard.service;

import java.util.List;

import com.dkitec.barocle.admin.customer.daumeditor.vo.DaumEditorVO;
import com.dkitec.barocle.admin.customer.opinionboard.vo.OpinionBoardVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("opinionBoardMapper")
public interface OpinionBoardMapper {
	
	public int listOpinionBoardCount(OpinionBoardVO opinionBoardVO);
	
	public List<OpinionBoardVO> listOpinionBoard(OpinionBoardVO opinionBoardVO);
	
	public OpinionBoardVO viewOpinionBoard(OpinionBoardVO opinionBoardVO);
	
	public List<DaumEditorVO> getDaumEditorImage(OpinionBoardVO opinionBoardVO);
	
	public OpinionBoardVO prevOpinionBoard(OpinionBoardVO opinionBoardVO);
	
	public OpinionBoardVO nextOpinionBoard(OpinionBoardVO opinionBoardVO);
	
	public int getOpinionBoardReply(OpinionBoardVO opinionBoardVO);
	
	public int setQnaProcessStusCD(OpinionBoardVO opinionBoardVO);
	
	public int insertOpinionBoard(OpinionBoardVO opinionBoardVO);
	
	public int updateOpinionBoard(OpinionBoardVO opinionBoardVO);
	
	public int deleteDaumEditorImage(OpinionBoardVO opinionBoardVO);
	
	public int updateDaumEditorImage(OpinionBoardVO opinionBoardVO);
	
	public int deleteOpinionBoard(OpinionBoardVO opinionBoardVO);

	public List<OpinionBoardVO> gubunList();					// 시민의견수렴 구분 list _cms _ 20161222
	
	public int insertAdminInfo(OpinionBoardVO opinionBoardVO);	// 담당자 등록 180828

	public int insertDeadline(OpinionBoardVO opinionBoardVO);	// 답변기한 수정등록 20200914
}
