package com.dkitec.barocle.admin.service.membermgmt.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.service.membermgmt.service.SafetyCertDiscountService;
import com.dkitec.barocle.admin.service.membermgmt.service.SafetyCertMapper;
import com.dkitec.barocle.admin.service.membermgmt.vo.SafetyCertDiscountVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

@Service("safetyCertDiscountService")
public class SafetyCertDiscountServiceImpl implements SafetyCertDiscountService {
	
	@Autowired SafetyCertMapper safetyCertMapper;

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<SafetyCertDiscountVO> getSafetyCertDiscount(SafetyCertDiscountVO sVo) throws Exception {
		return safetyCertMapper.getSafetyCertDiscount(sVo);
	}

	@Override
	public int setSafetyCertDiscount(SafetyCertDiscountVO sVo) {
		return safetyCertMapper.setSafetyCertDiscount(sVo);
	}
	
}
