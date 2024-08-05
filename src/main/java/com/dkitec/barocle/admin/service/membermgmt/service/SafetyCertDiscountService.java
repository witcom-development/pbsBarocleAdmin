package com.dkitec.barocle.admin.service.membermgmt.service;

import java.util.List;

import com.dkitec.barocle.admin.service.membermgmt.vo.SafetyCertDiscountVO;


public interface SafetyCertDiscountService {
	
//	public String getCertYn(String usrSeq) throws Exception;
//	public SafetyCertInfoVO getCertInfo(SafetyCertInfoVO safetyCertInfoVO) throws Exception;
	public List<SafetyCertDiscountVO> getSafetyCertDiscount(SafetyCertDiscountVO sVo) throws Exception;

	public int setSafetyCertDiscount(SafetyCertDiscountVO sVo);
	
}
