package com.dkitec.barocle.admin.repairBikeMall.repairBike.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.repairBikeMall.repairBike.service.RepairTnsBikeMapper;
import com.dkitec.barocle.admin.repairBikeMall.repairBike.service.RepairTnsBikeService;
import com.dkitec.barocle.admin.repairBikeMall.repairBike.vo.RepairTnsBikeVo;
import com.dkitec.barocle.admin.repairBikeMall.transferBike.vo.TransferBikeVo;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;
import com.dkitec.barocle.util.sms.vo.SmsMessageVO;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service(value="repairTnsBikeService")
public class RepairTnsBikeServiceImpl  extends EgovAbstractServiceImpl implements RepairTnsBikeService {
	
	@Autowired private RepairTnsBikeMapper repairTnsBikeMapper;
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public List<TransferBikeVo> getRepairTnsBikeList(TransferBikeVo transferBikeVo) {
		// TODO Auto-generated method stub
		return repairTnsBikeMapper.getRepairTnsBikeList(transferBikeVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public int getRepairTnsBikeListCount(TransferBikeVo transferBikeVo) {
		// TODO Auto-generated method stub
		return repairTnsBikeMapper.getRepairTnsBikeListCount(transferBikeVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public int updateRepairTnsBikeYn(TransferBikeVo transferBikeVo) {
		// TODO Auto-generated method stub
		int result = 0;
		// INFO 테이블 수리 완료 처리
		result = repairTnsBikeMapper.updateRepairBikeInfoYn(transferBikeVo);
		// 각각 부품들 수리완료 처리
		result = repairTnsBikeMapper.updateRepairBikePartYn(transferBikeVo);
		return result;
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public List<RepairTnsBikeVo> getbikeMallReportList(RepairTnsBikeVo repairTnsBikeVo) {
		// TODO Auto-generated method stub
		return repairTnsBikeMapper.getbikeMallReportList(repairTnsBikeVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public int getbikeMallReportListCount(RepairTnsBikeVo repairTnsBikeVo) {
		// TODO Auto-generated method stub
		return repairTnsBikeMapper.getbikeMallReportListCount(repairTnsBikeVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public List<SmsMessageVO> getAdminPhoneNoList(RepairTnsBikeVo repairTnsBikeVo) {
		// TODO Auto-generated method stub
		return repairTnsBikeMapper.getAdminPhoneNoList(repairTnsBikeVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public int getRepairBikeCount(TransferBikeVo transferBikeVo) {
		// TODO Auto-generated method stub
		return repairTnsBikeMapper.getRepairBikeCount(transferBikeVo);
	}

}
