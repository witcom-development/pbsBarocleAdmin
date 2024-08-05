package com.dkitec.barocle.admin.customer.opinionboard.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.customer.daumeditor.vo.DaumEditorVO;
import com.dkitec.barocle.admin.customer.opinionboard.service.OpinionBoardMapper;
import com.dkitec.barocle.admin.customer.opinionboard.service.OpinionBoardService;
import com.dkitec.barocle.admin.customer.opinionboard.vo.OpinionBoardVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;
import com.dkitec.barocle.util.webutil.StringUtil;

@Service("opinionBoardService")
public class OpinionBoardServiceImpl implements OpinionBoardService {
	
	@Autowired OpinionBoardMapper opinionBoardMapper;
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public int listOpinionBoardCount(OpinionBoardVO opinionBoardVO) {
		return opinionBoardMapper.listOpinionBoardCount(opinionBoardVO);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public List<OpinionBoardVO> listOpinionBoard(OpinionBoardVO opinionBoardVO) {
		return opinionBoardMapper.listOpinionBoard(opinionBoardVO);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public Map<String,OpinionBoardVO> viewOpinionBoard(OpinionBoardVO opinionBoardVO) throws Exception{
		Map<String,OpinionBoardVO> returnMap = null;
		OpinionBoardVO returnVO = null;
		try{
			returnMap = new HashMap<String,OpinionBoardVO>();
			returnVO = opinionBoardMapper.viewOpinionBoard(opinionBoardVO);
			returnMap.put("returnVO", returnVO);
			//returnMap.put("prevOpinionBoardVO", (OpinionBoardVO)opinionBoardMapper.prevOpinionBoard(opinionBoardVO));
			//returnMap.put("nextOpinionBoardVO", (OpinionBoardVO)opinionBoardMapper.nextOpinionBoard(opinionBoardVO));
		} catch (Exception e){
			throw e;
		}
		return returnMap;
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public List<DaumEditorVO> listDaumEditorVO(OpinionBoardVO opinionBoardVO) {
		return opinionBoardMapper.getDaumEditorImage(opinionBoardVO);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public int getOpinionBoardReply(OpinionBoardVO opinionBoardVO) {
		return opinionBoardMapper.getOpinionBoardReply(opinionBoardVO);
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public OpinionBoardVO insertOpinionBoard(OpinionBoardVO opinionBoardVO) {
		opinionBoardVO.setUseYN("Y");
		int resultValue = opinionBoardMapper.insertOpinionBoard(opinionBoardVO);
		if(resultValue>0){
			this.updateDaumEditorImage(opinionBoardVO,false);
			// 입력이 완료되면 해당 질문의 상태를 '답변완료'(QNA_PROCESS_STUS_CD=D)로 변경한다.
			opinionBoardVO.setQnaProcessStusCD("D");
			this.setQnaProcessStusCD(opinionBoardVO);
		}
		return opinionBoardVO;
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public OpinionBoardVO updateOpinionBoard(OpinionBoardVO opinionBoardVO) {
		int resultValue = opinionBoardMapper.updateOpinionBoard(opinionBoardVO);
		if(resultValue>0){
			this.updateDaumEditorImage(opinionBoardVO,true);
			// 입력이 완료되면 해당 질문의 상태를 '답변완료'(QNA_PROCESS_STUS_CD=D)로 변경한다.
			opinionBoardVO.setQnaProcessStusCD("D");
			this.setQnaProcessStusCD(opinionBoardVO);
		}
		return opinionBoardVO;
	}
	
	private int setQnaProcessStusCD(OpinionBoardVO opinionBoardVO) {
		return opinionBoardMapper.setQnaProcessStusCD(opinionBoardVO);
	}
	
	private boolean updateDaumEditorImage(OpinionBoardVO opinionBoardVO, boolean mode) {
		// * 이미지 파일을 업로드 했다면 noticeVO.imageList에 파일명이 저장되어 있다.
		if(mode){ opinionBoardMapper.deleteDaumEditorImage(opinionBoardVO); }
		if(!StringUtil.isEmpty(opinionBoardVO.getAttach_image_info())){ opinionBoardMapper.updateDaumEditorImage(opinionBoardVO); }
		return true;
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int deleteOpinionBoard(OpinionBoardVO opinionBoardVO) {
		opinionBoardVO.setOpenYN("N");
		return opinionBoardMapper.deleteOpinionBoard(opinionBoardVO);
	}

	@Override
	public List<OpinionBoardVO> gubunList() {
		// TODO Auto-generated method stub
		return opinionBoardMapper.gubunList();
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int insertAdminInfo(OpinionBoardVO opinionBoardVO) {
		return opinionBoardMapper.insertAdminInfo(opinionBoardVO);
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int insertDeadline(OpinionBoardVO opinionBoardVO) {
		return opinionBoardMapper.insertDeadline(opinionBoardVO);
	}

}
