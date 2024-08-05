package com.dkitec.barocle.admin.service.push.service;

import java.util.List;

import com.dkitec.barocle.admin.service.push.vo.PushUserInfoVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("pushUserInfoMapper")
public interface PushUserInfoMapper {
/*
	public List<MemberMgmtVO> pushSendList(MemberMgmtVO memberMgmtVO);
	public int pushUserInfoVO(MemberMgmtVO memberVo);
	*/
	
	public PushUserInfoVO getUserInfo(PushUserInfoVO pushUserInfoVO);

	public List<PushUserInfoVO> getPushSuccessList(PushUserInfoVO pushUserInfoVO);
	public List<PushUserInfoVO> getPushFailList(PushUserInfoVO pushUserInfoVO);
	
	
}
