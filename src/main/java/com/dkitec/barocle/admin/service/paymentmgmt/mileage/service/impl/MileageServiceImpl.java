package com.dkitec.barocle.admin.service.paymentmgmt.mileage.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.barocle.admin.service.paymentmgmt.mileage.service.MileageMapper;
import com.dkitec.barocle.admin.service.paymentmgmt.mileage.service.MileageService;
import com.dkitec.barocle.admin.service.paymentmgmt.mileage.vo.MileageVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

@Service("mileageService")
public class MileageServiceImpl implements MileageService {
	
	@Autowired MileageMapper mileageMapper;
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<MileageVO> getMileageHistList(MileageVO mileageVO) throws CfoodException {
		return mileageMapper.getMileageHistList(mileageVO);
	}
	 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int getMileageHistCount(MileageVO mileageVO) throws CfoodException {
		return mileageMapper.getMileageHistCount(mileageVO);
	}
	 
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int getMileageHistTotalSum(MileageVO mileageVO) throws CfoodException {
		return mileageMapper.getMileageHistTotalSum(mileageVO);
	}
}
