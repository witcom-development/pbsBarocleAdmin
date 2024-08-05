package com.dkitec.barocle.admin.service.push.service;

import java.util.List;

import com.dkitec.barocle.admin.service.push.vo.PushUserInfoVO;

public interface PushUserInfoService {

	 
	/*
	 * 장기 미반납 리스트
	 */
	public PushUserInfoVO getUserInfo(PushUserInfoVO pushUserInfoVO);
	public List<PushUserInfoVO> getPushSuccessList(PushUserInfoVO pushUserInfoVO);
	public List<PushUserInfoVO> getPushFailList(PushUserInfoVO pushUserInfoVO);
 
}
