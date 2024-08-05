package com.dkitec.barocle.admin.service.svccouponmgmt.service;

import java.util.List;

import com.dkitec.barocle.admin.service.svccouponmgmt.vo.SvcCouponMgmtVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("svcCouponMgmtMapper")
public interface SvcCouponMgmtMapper {
	public List<SvcCouponMgmtVO> getSvcCouponList(SvcCouponMgmtVO svcCouponMgmtVO);
	public int getSvcCouponListCount(SvcCouponMgmtVO svcCouponMgmtVO);
	public int checkNewSvcCouponNo(String newCouponNo);
	public int insertSvcCoupon(SvcCouponMgmtVO svcCouponMgmtVO);
	public int deleteSvcCoupon(SvcCouponMgmtVO svcCouponMgmtVO);
	public int unUseSvcCoupon(SvcCouponMgmtVO svcCouponMgmtVO);
	public int useSvcCoupon(SvcCouponMgmtVO svcCouponMgmtVO);
	public int changeDateSvcCouponProc(SvcCouponMgmtVO svcCouponMgmtVO);
	public int insertSvcCouponPaymentInfo(SvcCouponMgmtVO svcCouponMgmtVO);
	
	public List<SvcCouponMgmtVO> getSvcCouponBuyList(SvcCouponMgmtVO svcCouponMgmtVO);
	public int getSvcCouponBuyListCount(SvcCouponMgmtVO svcCouponMgmtVO);
	public List<SvcCouponMgmtVO> getSvcCouponBuyDetailList(SvcCouponMgmtVO svcCouponMgmtVO);
	public int getSvcCouponBuyDetailListCount(SvcCouponMgmtVO svcCouponMgmtVO);	
	public List<SvcCouponMgmtVO> getSvcCouponUseList(SvcCouponMgmtVO svcCouponMgmtVO);
	public int getSvcCouponUseListCount(SvcCouponMgmtVO svcCouponMgmtVO);
	public List<SvcCouponMgmtVO> getSvcCouponStat(SvcCouponMgmtVO svcCouponMgmtVO);
	public List<SvcCouponMgmtVO> getSvcCouponDayStat(SvcCouponMgmtVO svcCouponMgmtVO);
	public List<SvcCouponMgmtVO> getSvcCouponBilStat(SvcCouponMgmtVO svcCouponMgmtVO);
	public List<SvcCouponMgmtVO> getCouponMbName(SvcCouponMgmtVO svcCouponMgmtVO);
}
