package com.dkitec.barocle.admin.repairMgmt.common.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.maintenance.stockMgmt.invent.vo.InventVO;
import com.dkitec.barocle.admin.repairMgmt.common.service.RepairMgmtCommMapper;
import com.dkitec.barocle.admin.repairMgmt.common.service.RepairMgmtCommService;
import com.dkitec.barocle.admin.system.commonCodeMgmt.vo.CommonCenterVO;
import com.dkitec.barocle.admin.system.commonCodeMgmt.vo.CommonCodeVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;


@Service(value="RepairMgmtCommService")
public class RepairMgmtCommServiceImpl implements RepairMgmtCommService{

	@Autowired private RepairMgmtCommMapper repairMgmtCommMapper;
	
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public List<CommonCodeVO> getAdmComCodeList(CommonCodeVO cVo) {//공통코드 조회
		return repairMgmtCommMapper.getAdmComCodeList(cVo);
	}
	
	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)
	public List<CommonCenterVO> getAdmCenterCodeList() {//정비 사업소 코드 조회
		return repairMgmtCommMapper.getAdmCenterCodeList();
	}

	@Override
	@Transactional(readOnly= true)
	@DataSource(DataSourceType.SLAVE01)	
	public List<InventVO> getPartsStockCnt(InventVO inventVo) {//자전거 경정비 재고 조회
		return repairMgmtCommMapper.getPartsStockCnt(inventVo);
	}
}
