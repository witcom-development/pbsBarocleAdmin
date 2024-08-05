package com.dkitec.barocle.admin.repairMgmt.repairLight.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.repairMgmt.repairLight.service.RepairLightMapper;
import com.dkitec.barocle.admin.repairMgmt.repairLight.service.RepairLightService;
import com.dkitec.barocle.admin.repairMgmt.repairLight.vo.RepairLightVO;
import com.dkitec.barocle.admin.repairMgmt.repairWork.service.RepairWorkMapper;
import com.dkitec.barocle.admin.repairMgmt.repairWork.vo.RepairWorkVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

@Service(value="RepairLightService")
public class RepairLightServiceImpl implements RepairLightService {

	@Autowired private RepairLightMapper repairLightMapper;
	
	@Autowired private RepairWorkMapper repairWorkMapper;

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)	
	public List<RepairLightVO> getMaintenWrkerLight(RepairLightVO repairMgmtLightVO) {//정비직원 수리 실적 조회
        return repairLightMapper.getMaintenWrkerLight(repairMgmtLightVO);	
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


	
	

}
