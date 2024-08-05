package com.dkitec.barocle.admin.service.svccouponmgmt.service;

import java.util.List;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.barocle.admin.service.svccouponmgmt.vo.SvcCouponMgmtVO;

public interface SvcCouponMgmtService {
	public List<SvcCouponMgmtVO> getSvcCouponList(SvcCouponMgmtVO svcCouponMgmtVO) throws CfoodException;
	public int getSvcCouponListCount(SvcCouponMgmtVO svcCouponMgmtVO) throws CfoodException;
	public boolean addSvcCouponProc(SvcCouponMgmtVO svcCouponMgmtVO);
	public boolean delSvcCouponProc(SvcCouponMgmtVO svcCouponMgmtVO);
	public boolean unUseSvcCouponProc(SvcCouponMgmtVO svcCouponMgmtVO);
	public boolean useSvcCouponProc(SvcCouponMgmtVO svcCouponMgmtVO);
	public boolean changeDateSvcCouponProc(SvcCouponMgmtVO svcCouponMgmtVO);
	public List<SvcCouponMgmtVO> getSvcCouponBuyList(SvcCouponMgmtVO svcCouponMgmtVO) throws CfoodException;
	public int getSvcCouponBuyListCount(SvcCouponMgmtVO svcCouponMgmtVO) throws CfoodException;
	public List<SvcCouponMgmtVO> getSvcCouponBuyDetailList(SvcCouponMgmtVO svcCouponMgmtVO) throws CfoodException;
	public int getSvcCouponBuyDetailListCount(SvcCouponMgmtVO svcCouponMgmtVO) throws CfoodException;
	public List<SvcCouponMgmtVO> getSvcCouponUseList(SvcCouponMgmtVO svcCouponMgmtVO) throws CfoodException;
	public int getSvcCouponUseListCount(SvcCouponMgmtVO svcCouponMgmtVO) throws CfoodException;
	public List<SvcCouponMgmtVO> getSvcCouponStat(SvcCouponMgmtVO svcCouponMgmtVO) throws CfoodException;
	public List<SvcCouponMgmtVO> getSvcCouponDayStat(SvcCouponMgmtVO svcCouponMgmtVO) throws CfoodException;
	public List<SvcCouponMgmtVO> getSvcCouponBilStat(SvcCouponMgmtVO svcCouponMgmtVO) throws CfoodException;
	public List<SvcCouponMgmtVO> getCouponMbName(SvcCouponMgmtVO svcCouponMgmtVO) throws CfoodException;
	
}
