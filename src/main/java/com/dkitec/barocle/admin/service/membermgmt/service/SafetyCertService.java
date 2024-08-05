package com.dkitec.barocle.admin.service.membermgmt.service;

import java.util.List;

import com.dkitec.barocle.admin.service.membermgmt.vo.MemberMgmtVO;
import com.dkitec.barocle.admin.service.membermgmt.vo.SafetyCertInfoVO;


public interface SafetyCertService {
	
	public SafetyCertInfoVO getCertInfo(SafetyCertInfoVO safetyCertInfoVO) throws Exception;

	int smsSendListCnt(MemberMgmtVO memberVo);

	List<MemberMgmtVO> smsSendList(MemberMgmtVO memberMgmtVO);
	
}
