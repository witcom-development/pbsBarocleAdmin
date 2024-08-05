package com.dkitec.barocle.admin.repairMgmt.repairPerf.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.repairMgmt.repairPerf.service.RepairPerfMapper;
import com.dkitec.barocle.admin.repairMgmt.repairPerf.service.RepairPerfService;
import com.dkitec.barocle.admin.repairMgmt.repairPerf.vo.RepairPerfVO;
import com.dkitec.barocle.admin.repairMgmt.repairPerf.vo.RepairRoundPerfStaticsVO;
import com.dkitec.barocle.admin.repairMgmt.repairPerf.vo.RepairRoundPerfVO;
import com.dkitec.barocle.admin.repairMgmt.repairWork.service.RepairWorkMapper;
import com.dkitec.barocle.admin.repairMgmt.repairWork.vo.RepairWorkVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

@Service(value="RepairPerfService")
public class RepairPerfServiceImpl implements RepairPerfService {

	@Autowired private RepairPerfMapper repairPerfMapper;
	
	@Autowired private RepairWorkMapper repairWorkMapper;

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)	
	public List<RepairPerfVO> getMaintenWrkerPerf(RepairPerfVO repairMgmtPerfVO) {//정비직원 수리 실적 조회
        return repairPerfMapper.getMaintenWrkerPerf(repairMgmtPerfVO);	
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)	
	public RepairPerfVO getRepairPerfCmptCnt(RepairPerfVO repairPerfVO) {//수리 실적 자전거,단말기 수리완료 개수 조회
		return repairPerfMapper.getRepairPerfCmptCnt(repairPerfVO);
	}

	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)	
	public String getAdminGrpName(RepairWorkVO wVo) {//정비원 그룹 이름 조회
		return repairWorkMapper.getAdminGrpName(wVo);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)	
	public String getInsertWrkCenterId(RepairWorkVO wVo) {//정비원 소속 사업소 아이디 조회
		return repairWorkMapper.getInsertWrkCenterId(wVo);
	}


	
	
	
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)	
	public List<RepairRoundPerfStaticsVO> getRoundRepairPerfCmptCnt(RepairPerfVO repairMgmtPerfVO) {//정비직원 수리 실적 조회
        return repairPerfMapper.getRoundRepairPerfCmptCnt(repairMgmtPerfVO);	
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)	
	public List<RepairRoundPerfVO> getRoundMaintenWrkerPerf(RepairPerfVO repairPerfVO) {//수리 실적 자전거,단말기 수리완료 개수 조회
		return repairPerfMapper.getRoundMaintenWrkerPerf(repairPerfVO);
	}
	
	

}
