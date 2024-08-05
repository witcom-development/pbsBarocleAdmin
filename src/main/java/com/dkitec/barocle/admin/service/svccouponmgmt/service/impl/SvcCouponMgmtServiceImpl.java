package com.dkitec.barocle.admin.service.svccouponmgmt.service.impl;

import java.sql.SQLException;
import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.barocle.admin.service.svccouponmgmt.service.SvcCouponMgmtMapper;
import com.dkitec.barocle.admin.service.svccouponmgmt.service.SvcCouponMgmtService;
import com.dkitec.barocle.admin.service.svccouponmgmt.vo.SvcCouponMgmtVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

@Service("svcCouponMgmtService")
public class SvcCouponMgmtServiceImpl implements SvcCouponMgmtService {

	@Autowired SvcCouponMgmtMapper svcCouponMgmtMapper;
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<SvcCouponMgmtVO> getSvcCouponList(SvcCouponMgmtVO svcCouponMgmtVO) throws CfoodException {
		return svcCouponMgmtMapper.getSvcCouponList(svcCouponMgmtVO);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int getSvcCouponListCount(SvcCouponMgmtVO svcCouponMgmtVO) throws CfoodException {
		return svcCouponMgmtMapper.getSvcCouponListCount(svcCouponMgmtVO);
	}

	@Override
	@Transactional(readOnly= false, propagation = Propagation.REQUIRED, rollbackFor = {Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public boolean addSvcCouponProc(SvcCouponMgmtVO svcCouponMgmtVO) {
	//쿠폰 등록
		int couponCnt = 0 ; 
		if(svcCouponMgmtVO.getSvcCouponCountList() != null) {
			SvcCouponMgmtVO addSvcCouponVO = null;
			
			int result = svcCouponMgmtMapper.insertSvcCouponPaymentInfo(svcCouponMgmtVO);
			
			for(int i=0;i<svcCouponMgmtVO.getPaymentClsCdList().size();i++) {
				addSvcCouponVO = new SvcCouponMgmtVO();
				addSvcCouponVO.setPaymentClsCd(svcCouponMgmtVO.getPaymentClsCdList().get(i));
				addSvcCouponVO.setCouponName(svcCouponMgmtVO.getCouponName());
				addSvcCouponVO.setPartyUseCnt(svcCouponMgmtVO.getPartyUseCnt());
				
				addSvcCouponVO.setUsrSeq(svcCouponMgmtVO.getUsrSeq());
				addSvcCouponVO.setPaymentSeq(svcCouponMgmtVO.getPaymentSeq());
				
				couponCnt = Integer.parseInt(svcCouponMgmtVO.getSvcCouponCountList().get(i));
				
				for(int j=0;j<couponCnt;j++) {
					//random
					Random random = new Random();
					String newCouponNo = "";
					newCouponNo = (char)((int)(Math.random()*26)+97)+ Integer.toString(random.nextInt(10)) + Integer.toString(random.nextInt(10)) + Integer.toString(random.nextInt(10))
						+ (char)((int)(Math.random()*26)+97)+ Integer.toString(random.nextInt(10)) + Integer.toString(random.nextInt(10)) + Integer.toString(random.nextInt(10))
						+ (char)((int)(Math.random()*26)+97)+ Integer.toString(random.nextInt(10)) + Integer.toString(random.nextInt(10)) + Integer.toString(random.nextInt(10));
					
					
					
					while (svcCouponMgmtMapper.checkNewSvcCouponNo(newCouponNo) > 0) {
						newCouponNo = (char)((int)(Math.random()*26)+97)+ Integer.toString(random.nextInt(10)) + Integer.toString(random.nextInt(10)) + Integer.toString(random.nextInt(10))
						+ (char)((int)(Math.random()*26)+97)+ Integer.toString(random.nextInt(10)) + Integer.toString(random.nextInt(10)) + Integer.toString(random.nextInt(10))
						+ (char)((int)(Math.random()*26)+97)+ Integer.toString(random.nextInt(10)) + Integer.toString(random.nextInt(10)) + Integer.toString(random.nextInt(10));
					}
					
					addSvcCouponVO.setCouponNo(newCouponNo);
					
					if(svcCouponMgmtMapper.insertSvcCoupon(addSvcCouponVO) == 0)
					return false;
				}
			}
		}

		return true;
	}
	
	@Override
	@Transactional(readOnly= false, propagation = Propagation.REQUIRED, rollbackFor = {Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public boolean delSvcCouponProc(SvcCouponMgmtVO svcCouponMgmtVO) {
	//쿠폰 등록
		if(svcCouponMgmtVO.getSvcCouponSeqList() != null) {
			SvcCouponMgmtVO delSvcCouponVO = null;
			for(int i=0;i<svcCouponMgmtVO.getSvcCouponSeqList().size();i++) {
				delSvcCouponVO = new SvcCouponMgmtVO();
				delSvcCouponVO.setCouponSeq(svcCouponMgmtVO.getSvcCouponSeqList().get(i));
				
				if(svcCouponMgmtMapper.deleteSvcCoupon(delSvcCouponVO) == 0)
					return false;
				
			}
		}

		return true;
	}
	
	@Override
	@Transactional(readOnly= false, propagation = Propagation.REQUIRED, rollbackFor = {Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public boolean unUseSvcCouponProc(SvcCouponMgmtVO svcCouponMgmtVO) {
	//쿠폰 등록
		if(svcCouponMgmtVO.getSvcCouponSeqList() != null) {
			SvcCouponMgmtVO unUseSvcCouponVO = null;
			for(int i=0;i<svcCouponMgmtVO.getSvcCouponSeqList().size();i++) {
				unUseSvcCouponVO = new SvcCouponMgmtVO();
				unUseSvcCouponVO.setCouponSeq(svcCouponMgmtVO.getSvcCouponSeqList().get(i));
				
				if(svcCouponMgmtMapper.unUseSvcCoupon(unUseSvcCouponVO) == 0)
					return false;
				
			}
		}

		return true;
	}
	
	@Override
	@Transactional(readOnly= false, propagation = Propagation.REQUIRED, rollbackFor = {Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public boolean useSvcCouponProc(SvcCouponMgmtVO svcCouponMgmtVO) {
	//쿠폰 등록
		if(svcCouponMgmtVO.getSvcCouponSeqList() != null) {
			SvcCouponMgmtVO useSvcCouponVO = null;
			for(int i=0;i<svcCouponMgmtVO.getSvcCouponSeqList().size();i++) {
				useSvcCouponVO = new SvcCouponMgmtVO();
				useSvcCouponVO.setCouponSeq(svcCouponMgmtVO.getSvcCouponSeqList().get(i));
				
				if(svcCouponMgmtMapper.useSvcCoupon(useSvcCouponVO) == 0)
					return false;
				
			}
		}

		return true;
	}
	
	@Override
	@Transactional(readOnly= false, propagation = Propagation.REQUIRED, rollbackFor = {Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public boolean changeDateSvcCouponProc(SvcCouponMgmtVO svcCouponMgmtVO) {
	//쿠폰 등록
		if(svcCouponMgmtVO.getSvcCouponSeqList() != null) {
			SvcCouponMgmtVO useSvcCouponVO = null;
			for(int i=0;i<svcCouponMgmtVO.getSvcCouponSeqList().size();i++) {
				useSvcCouponVO = new SvcCouponMgmtVO();
				useSvcCouponVO.setCouponSeq(svcCouponMgmtVO.getSvcCouponSeqList().get(i));
				useSvcCouponVO.setCouponEndDttm(svcCouponMgmtVO.getCouponEndDttm());
				useSvcCouponVO.setExtendAdminId(svcCouponMgmtVO.getExtendAdminId());
				useSvcCouponVO.setExtendReasonDesc(svcCouponMgmtVO.getExtendReasonDesc());
				
				if(svcCouponMgmtMapper.changeDateSvcCouponProc(useSvcCouponVO) == 0)
					return false;
				
			}
		}

		return true;
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<SvcCouponMgmtVO> getSvcCouponBuyList(SvcCouponMgmtVO svcCouponMgmtVO) throws CfoodException {
		return svcCouponMgmtMapper.getSvcCouponBuyList(svcCouponMgmtVO);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int getSvcCouponBuyListCount(SvcCouponMgmtVO svcCouponMgmtVO) throws CfoodException {
		return svcCouponMgmtMapper.getSvcCouponBuyListCount(svcCouponMgmtVO);
	}
	

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<SvcCouponMgmtVO> getSvcCouponBuyDetailList(SvcCouponMgmtVO svcCouponMgmtVO) throws CfoodException {
		return svcCouponMgmtMapper.getSvcCouponBuyDetailList(svcCouponMgmtVO);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int getSvcCouponBuyDetailListCount(SvcCouponMgmtVO svcCouponMgmtVO) throws CfoodException {
		return svcCouponMgmtMapper.getSvcCouponBuyDetailListCount(svcCouponMgmtVO);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<SvcCouponMgmtVO> getSvcCouponUseList(SvcCouponMgmtVO svcCouponMgmtVO) throws CfoodException {
		return svcCouponMgmtMapper.getSvcCouponUseList(svcCouponMgmtVO);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int getSvcCouponUseListCount(SvcCouponMgmtVO svcCouponMgmtVO) throws CfoodException {
		return svcCouponMgmtMapper.getSvcCouponUseListCount(svcCouponMgmtVO);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<SvcCouponMgmtVO> getSvcCouponStat(SvcCouponMgmtVO svcCouponMgmtVO) throws CfoodException {
		return svcCouponMgmtMapper.getSvcCouponStat(svcCouponMgmtVO);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<SvcCouponMgmtVO> getSvcCouponDayStat(SvcCouponMgmtVO svcCouponMgmtVO) throws CfoodException {
		return svcCouponMgmtMapper.getSvcCouponDayStat(svcCouponMgmtVO);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<SvcCouponMgmtVO> getSvcCouponBilStat(SvcCouponMgmtVO svcCouponMgmtVO) throws CfoodException {
		return svcCouponMgmtMapper.getSvcCouponBilStat(svcCouponMgmtVO);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<SvcCouponMgmtVO> getCouponMbName(SvcCouponMgmtVO svcCouponMgmtVO) throws CfoodException {
		return svcCouponMgmtMapper.getCouponMbName(svcCouponMgmtVO);
	}
}	
