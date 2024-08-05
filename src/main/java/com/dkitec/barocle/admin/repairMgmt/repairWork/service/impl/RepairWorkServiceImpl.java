package com.dkitec.barocle.admin.repairMgmt.repairWork.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.repairMgmt.repairWork.service.RepairWorkMapper;
import com.dkitec.barocle.admin.repairMgmt.repairWork.service.RepairWorkService;
import com.dkitec.barocle.admin.repairMgmt.repairWork.vo.RepairTermVO;
import com.dkitec.barocle.admin.repairMgmt.repairWork.vo.RepairWorkVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

@Service(value="RepairWorkService")
public class RepairWorkServiceImpl implements RepairWorkService {

	@Autowired private RepairWorkMapper repairWorkMapper;
	
	
	@Override
	@Transactional(readOnly= false)
	@DataSource(DataSourceType.MASTER)
	public void insertRepairWork(RepairWorkVO repairWorkVO) {//정비원 근태 입력
		
			repairWorkVO.setCenterId(getInsertWrkCenterId(repairWorkVO));
			
			String workSeq = checkRepairWork(repairWorkVO);
			
			//등록으로 들어왔지만 request가 두번 들어왔다던지 하는 예외상황으로
			//이미 등록 되어있는지 확인하여 등록되어있다면 수정처리
			if(workSeq != null){
				
				updateRepairWork(repairWorkVO);
				
			}else if(workSeq == null){
				
				repairWorkMapper.insertRepairWork(repairWorkVO);
				repairWorkMapper.insertRepairWorkDtl(repairWorkVO);
				
			}
	}
	
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public String getAdminGrpName(RepairWorkVO repairWorkVO) {//관리자 그룹 네임 가져오기
		return repairWorkMapper.getAdminGrpName(repairWorkVO);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public String getInsertWrkCenterId(RepairWorkVO repairWorkVO) {//정비원 근태 입력시 centerId 가져오기
		return repairWorkMapper.getInsertWrkCenterId(repairWorkVO);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public List<RepairWorkVO> getMaintenWrkerAtt(RepairWorkVO repairWorkVO) {//정비원 근태 조회
		return repairWorkMapper.getMaintenWrkerAtt(repairWorkVO);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public int getMaintenWrkerAttCnt(RepairWorkVO repairWorkVO) {//정비원 근태 총 건수 
		return repairWorkMapper.getMaintenWrkerAttCnt(repairWorkVO);
	}

	@Override
	@Transactional(readOnly= false)
	@DataSource(DataSourceType.MASTER)
	public void updateRepairWorkAprvd(RepairWorkVO repairWorkVO) {//승인여부 수정
		
		if(repairWorkVO.getApprovedArr() != null){
			
			int cnt = repairWorkVO.getApprovedArr().length;
			
			for(int i = 0; i<cnt; i++){
				
				RepairWorkVO rVO = new RepairWorkVO();
				
				String workSeq = repairWorkVO.getWorkSeqArr()[i];
				String approved = repairWorkVO.getApprovedArr()[i];
				String approverId = repairWorkVO.getApproverId();
				
				rVO.setWorkSeq(workSeq);
				rVO.setApproved(approved);
				rVO.setApproverId(approverId);
				
				repairWorkMapper.updateRepairWorkAprvd(rVO);
				
			}
			
		}
		
	}

	@Override
	@Transactional(readOnly= false)
	@DataSource(DataSourceType.MASTER)	
	public void updateRepairWork(RepairWorkVO repairWorkVO) {//근태입력 수정
		String attSeq = getInsertWrkSeq(repairWorkVO);
		repairWorkVO.setWorkSeq(attSeq);
		repairWorkMapper.updateRepairWork(repairWorkVO);
		updateRepairWorkDtl(repairWorkVO);
	}
	


	@Override
	@Transactional(readOnly= false)
	@DataSource(DataSourceType.MASTER)	
	public void updateRepairWorkDtl(RepairWorkVO repairWorkVO) {//근태입력 근무 외 수정
		repairWorkMapper.updateRepairWorkDtl(repairWorkVO);
	}

	@Override
	@Transactional(readOnly= false)
	@DataSource(DataSourceType.MASTER)		
	public void insertRepairTerm(RepairTermVO repairTermVo) {//자전거 수리 페이지 - 단말기 수리등록
		repairWorkMapper.insertRepairTerm(repairTermVo);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public RepairTermVO getRepairTermInfo(String repairSeq) {//자전거 수리 페이지 - 단말기 수리조회
		return repairWorkMapper.getRepairTermInfo(repairSeq);
	}

	@Override
	@Transactional(readOnly= false)
	@DataSource(DataSourceType.MASTER)		
	public void updateRepairTerm(RepairTermVO repairTermVo) {//자전거 수리 페이지 - 단말기 수리저장
		repairWorkMapper.updateRepairTerm(repairTermVo);
		
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public RepairWorkVO getMaintenWrkerAttD(RepairWorkVO repairWorkVO) {// 정비원 당일 근태 정보 조회
		return repairWorkMapper.getMaintenWrkerAttD(repairWorkVO);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public String getInsertWrkSeq(RepairWorkVO repairWorkVO) {// 최근 workSeq 조회
		return repairWorkMapper.getInsertWrkSeq(repairWorkVO);
	}


	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public String checkRepairWork(RepairWorkVO repairWorkVO) {// 당일 workSeq 조회
		return repairWorkMapper.checkRepairWork(repairWorkVO);
	}


	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public String getCenterNameWithCenterCode(RepairWorkVO repairWorkVO) {// 엑셀용 : centerCode 로 centerName 조회
		return repairWorkMapper.getCenterNameWithCenterCode(repairWorkVO);
	}


}
