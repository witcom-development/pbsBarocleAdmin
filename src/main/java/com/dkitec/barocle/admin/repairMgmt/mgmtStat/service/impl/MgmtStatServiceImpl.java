package com.dkitec.barocle.admin.repairMgmt.mgmtStat.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.repairMgmt.mgmtStat.service.MgmtStatMapper;
import com.dkitec.barocle.admin.repairMgmt.mgmtStat.service.MgmtStatService;
import com.dkitec.barocle.admin.repairMgmt.mgmtStat.vo.MgmtStatVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

@Service("MgmtStatService")
public class MgmtStatServiceImpl implements MgmtStatService {
	
	@Autowired private MgmtStatMapper mgmtStatMapper;

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)	
	public List<MgmtStatVO> getMgmtRepairAdminStatus(MgmtStatVO mgmtStatVO) {//정비인원 현황
		
		List<MgmtStatVO> rList = mgmtStatMapper.getMgmtRepairAdminStatus(mgmtStatVO);
		
		return rList;
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)	
	public MgmtStatVO getMgmtBikeRepairStatus(MgmtStatVO mgmtStatVO) {//자전거 정비 현황(자전거 수리완료 개수)
		return mgmtStatMapper.getMgmtBikeRepairStatus(mgmtStatVO);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)		
	public List<MgmtStatVO> getMgmtRepairStatus(MgmtStatVO mgmtStatVO) {//정비현황(건) 조회(일,월,평균 제외)
		return mgmtStatMapper.getMgmtRepairStatus(mgmtStatVO);
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)			
	public List<MgmtStatVO> getMgmtRepairStatusCnt(MgmtStatVO mgmtStatVO) {//정비현황 조회(일,월,평균)
		
		List<MgmtStatVO> rList = new ArrayList<>();
		rList.add(mgmtStatMapper.getMgmtRepairStatusDCnt(mgmtStatVO));
		rList.add(mgmtStatMapper.getMgmtRepairStatusMCnt(mgmtStatVO));
		rList.add(mgmtStatMapper.getMgmtRepairStatusCnt(mgmtStatVO));
		return rList;
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)	
	public List<MgmtStatVO> getMgmtRepairStatusCenter(MgmtStatVO mgmtStatVO) {//자전거 정비 현황( 사업소현황 조회 )
		return mgmtStatMapper.getMgmtRepairStatusCenter(mgmtStatVO);
	}

}
