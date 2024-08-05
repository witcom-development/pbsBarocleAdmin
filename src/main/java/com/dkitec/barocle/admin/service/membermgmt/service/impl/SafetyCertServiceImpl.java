package com.dkitec.barocle.admin.service.membermgmt.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.barocle.admin.service.membermgmt.service.SafetyCertMapper;
import com.dkitec.barocle.admin.service.membermgmt.service.SafetyCertService;
import com.dkitec.barocle.admin.service.membermgmt.vo.MemberMgmtVO;
import com.dkitec.barocle.admin.service.membermgmt.vo.SafetyCertInfoVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

@Service("safetyCertService")
public class SafetyCertServiceImpl implements SafetyCertService {
	
	@Autowired SafetyCertMapper safetyCertMapper;
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public SafetyCertInfoVO getCertInfo(SafetyCertInfoVO safetyCertVO) throws CfoodException {
		return safetyCertMapper.getCertInfo(safetyCertVO);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE02)
	public int smsSendListCnt(MemberMgmtVO memberVo) {
		return safetyCertMapper.smsSendListCnt(memberVo);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE02)
	public List<MemberMgmtVO> smsSendList(MemberMgmtVO memberMgmtVO) {
		// TODO Auto-generated method stub
		List<MemberMgmtVO> resultList = safetyCertMapper.smsSendList(memberMgmtVO);
		return resultList;
	}
	
}
