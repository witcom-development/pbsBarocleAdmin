package com.dkitec.barocle.admin.service.push.service.impl;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.service.push.service.PushUserInfoMapper;
import com.dkitec.barocle.admin.service.push.service.PushUserInfoService;
import com.dkitec.barocle.admin.service.push.vo.PushUserInfoVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("pushUserInfoService")	
public class PushUserInfoServiceImpl extends EgovAbstractServiceImpl implements  PushUserInfoService {
	protected static Logger log = LoggerFactory.getLogger(PushUserInfoServiceImpl.class);


/*	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.PUSH)
	public int pushSendListCnt(MemberMgmtVO memberVo) {
		// TODO Auto-generated method stub
		return policyMgmtMapper.pushSendListCnt(memberVo);
	}
*/

	@Autowired private PushUserInfoMapper pushUserInfoMapper;
	
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.PUSH)
	public PushUserInfoVO getUserInfo(PushUserInfoVO pushUserInfoVO) {
		// TODO Auto-generated method stub
		return pushUserInfoMapper.getUserInfo(pushUserInfoVO);
		}


	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.PUSH)	
	public List<PushUserInfoVO> getPushSuccessList(PushUserInfoVO pushUserInfoVO) {
		// TODO Auto-generated method stub
		return pushUserInfoMapper.getPushSuccessList(pushUserInfoVO);
	}
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.PUSH)	
	public List<PushUserInfoVO> getPushFailList(PushUserInfoVO pushUserInfoVO) {
		// TODO Auto-generated method stub
		return pushUserInfoMapper.getPushFailList(pushUserInfoVO);
	}

}
