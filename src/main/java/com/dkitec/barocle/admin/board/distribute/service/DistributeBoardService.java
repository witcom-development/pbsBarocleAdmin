package com.dkitec.barocle.admin.board.distribute.service;

import java.util.List;
import java.util.Map;

import com.dkitec.barocle.admin.board.distribute.vo.DistributeBoardVO;
import com.dkitec.barocle.admin.customer.daumeditor.vo.DaumEditorVO;
import com.dkitec.barocle.util.push.PushVO;

public interface DistributeBoardService {

	public int listDistributeCount(DistributeBoardVO distributeBoardVO) throws Exception;
	
	public List<DistributeBoardVO> listDistribute(DistributeBoardVO distributeBoardVO) throws Exception;
	
	public Map<String, DistributeBoardVO> viewDistribute(DistributeBoardVO distributeBoardVO) throws Exception;
	
	public List<DaumEditorVO> listDaumEditorVO(DistributeBoardVO distributeBoardVO) throws Exception;
	
	public DistributeBoardVO insertDistribute(DistributeBoardVO distributeBoardVO) throws Exception;
	
	public DistributeBoardVO updateDistribute(DistributeBoardVO distributeBoardVO) throws Exception;
	
	public int deleteDistribute(DistributeBoardVO distributeBoardVO) throws Exception;
	
	public List<DistributeBoardVO> listDistributePopupCount(DistributeBoardVO distributeBoardVO) throws Exception;
	
	public DistributeBoardVO listDistributePopup(DistributeBoardVO distributeBoardVO) throws Exception;
	
	public String fileDownloadList(DistributeBoardVO distributeBoardVO) throws Exception; // 파일 다운로드 리스트
	
	public String fileDownloadNm(DistributeBoardVO distributeBoardVO) throws Exception; // 파일명 가져오기
	
	public int insertPush(PushVO pushVO) throws Exception;
	
	public List<PushVO> getPushTargetList() throws Exception;

	public List<DistributeBoardVO> listBoardPopupCount(DistributeBoardVO distributeBoardVO);

	public Object listBoardPopup(DistributeBoardVO distributeBoardVO);
	
	
	public List<DistributeBoardVO> listDistributeBunBae() throws Exception;
}
