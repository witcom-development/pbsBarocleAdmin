package com.dkitec.barocle.admin.board.distribute.service;

import java.util.List;

import com.dkitec.barocle.admin.board.distribute.vo.DistributeBoardVO;
import com.dkitec.barocle.admin.customer.daumeditor.vo.DaumEditorVO;
import com.dkitec.barocle.util.push.PushVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("distributeMapper")
public interface DistributeBoardMapper {
	
	public int listDistributeCount(DistributeBoardVO distributeBoardVO);

	public List<DistributeBoardVO> listDistribute(DistributeBoardVO distributeBoardVO);
	
	
	
	public List<DistributeBoardVO> listDistributeBunBae();
	

	public DistributeBoardVO viewDistribute(DistributeBoardVO distributeBoardVO);

	public List<DaumEditorVO> getDaumEditorImage(DistributeBoardVO distributeBoardVO);
	
	public DistributeBoardVO prevDistribute(DistributeBoardVO distributeBoardVO);
	
	public DistributeBoardVO nextDistribute(DistributeBoardVO distributeBoardVO);
	
	public int insertDistribute(DistributeBoardVO distributeBoardVO);

	public int updateDistribute(DistributeBoardVO distributeBoardVO);

	public int deleteDaumEditorImage(DistributeBoardVO distributeBoardVO);

	public int updateDaumEditorImage(DistributeBoardVO distributeBoardVO);

	public int deleteDistribute(DistributeBoardVO distributeBoardVO);
	
	public List<DistributeBoardVO> listDistributePopupCount(DistributeBoardVO distributeBoardVO);
	
	public DistributeBoardVO listDistributePopup(DistributeBoardVO distributeBoardVO);

	public List<DistributeBoardVO> fileDownloadList(DistributeBoardVO distributeBoardVO); //파일 다운로드 조회
	
	public int insertPush(PushVO pushVO);
	
	public List<PushVO> getPushTargetList();

	public List<DistributeBoardVO> listBoardPopupCount(DistributeBoardVO distributeBoardVO);

	public Object listBoardPopup(DistributeBoardVO distributeBoardVO);
	
	public int updateReadcntViewDistribute(DistributeBoardVO distributeBoardVO);
}
