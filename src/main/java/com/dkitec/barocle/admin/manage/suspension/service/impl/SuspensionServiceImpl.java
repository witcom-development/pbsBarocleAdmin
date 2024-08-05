package com.dkitec.barocle.admin.manage.suspension.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.barocle.admin.manage.suspension.vo.SuspensionVO;
import com.dkitec.barocle.admin.manage.suspension.vo.VoucherHistVO;
import com.dkitec.barocle.admin.manage.suspension.vo.VoucherVO;
import com.dkitec.barocle.admin.manage.suspension.service.SuspensionMapper;
import com.dkitec.barocle.admin.manage.suspension.service.SuspensionService;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

@Service("suspensionService")
public class SuspensionServiceImpl implements SuspensionService {
	
	@Autowired SuspensionMapper suspensionMapper;
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public int listSuspensionCount(SuspensionVO suspensionVO) {
		return suspensionMapper.listSuspensionCount(suspensionVO);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public java.util.List<SuspensionVO> listSuspension(SuspensionVO suspensionVO) {
		return suspensionMapper.listSuspension(suspensionVO);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public SuspensionVO viewSuspension(SuspensionVO suspensionVO) {
		return suspensionMapper.viewSuspension(suspensionVO);
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public SuspensionVO insertSuspension(SuspensionVO suspensionVO) {
		// 등록 가능한 데이터인지 확인하다.
		// TB_OPR_DELAY에 겹치는 날짜가 없어야 한다.
		if(this.getDuplicateCount(suspensionVO)<=0){
			@SuppressWarnings("unused") int resultValue = suspensionMapper.insertSuspension(suspensionVO);	// TB_OPR_DELAY 저장
			insertVoucherHist(suspensionVO);	// 이용권 기록 등록
			if("Y".equalsIgnoreCase(suspensionVO.getTicketChngYN())){ insertVoucher(suspensionVO); }	// 이용권 수정
		} else throw new CfoodException("com.dkitec.barocle.admin.manage.suspension.service.insertSuspensionException");
		return suspensionVO;
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public SuspensionVO updateSuspension(SuspensionVO suspensionVO) {
		// 등록 가능한 데이터인지 확인하다.
		// !!! TB_OPR_DELAY에 겹치는 날짜가 없고, 기존 데이터의 suspensionVO.getTicketChngYN() 값이 'N'이면  수정이 가능하다.
		if(this.getDuplicateCount(suspensionVO)<=0&&"N".equalsIgnoreCase((viewSuspension(suspensionVO)).getTicketChngYN())){
			@SuppressWarnings("unused") int resultModify = suspensionMapper.updateSuspension(suspensionVO);	// TB_OPR_DELAY 수정
			if("Y".equalsIgnoreCase(suspensionVO.getTicketChngYN())){ updateVoucher(suspensionVO); }	// 이용권 수정
		} else throw new CfoodException("com.dkitec.barocle.admin.manage.suspension.service.updateSuspensionException");
		return suspensionVO;
	}
	
	/**
	 * 등록/수정한 가능한 운휴인지 학인한다. 검사는 입력한 날짜와 1일이라도 중복된 날짜의 개수를  suspensionVO.getDelaySeq로 리턴한다.
	 */
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int getDuplicateCount(SuspensionVO suspensionVO) {
		// service에서 update 가능한 조건이지 확인한다. 운휴일이 다른 날과 중복된 날이 없고 정기권 일관 변경(ticketChngYN)이 'N'으로 설정 되어 있으면 수정이 가능하다.
		return suspensionMapper.getDuplicateCount(suspensionVO);
	}
	
	/**
	 * 운휴관리에서 날짜를 등록하고 이용과 종료 일자와 수정과 운휴 기록을 등록한다.
	 * @param suspensionVO
	 */
	public void insertVoucher(SuspensionVO suspensionVO) {
		// 1. update할 대상의 회원권 목록을 가져온다. 가져올 때 중복일자(DATE_DIFF)와 새로운 종료 일자(NEW_VOUCHER_END_DTTM)를 계산해서 가져온다.
		java.util.List<VoucherVO> voucherHistList =  suspensionMapper.getVoucherList(suspensionVO);
		if(voucherHistList!=null&&voucherHistList.size()>0){
			for(VoucherVO voucherVO : voucherHistList){
				// 1-1. (각 레코드에 대해서...) TB_SBC_VOUCHER 테이블을 수정한다. 해당 로직에서는 VOUCHER_END_DTTM을 NEW_VOUCHER_END_DTTM 값으로 수정만 하면 된다.
				suspensionMapper.updateVoucher(voucherVO);
			}
		}
	}
	
	public void insertVoucherHist(SuspensionVO suspensionVO) {
		// 1. update할 대상의 회원권 목록을 가져온다. 가져올 때 중복일자(DATE_DIFF)와 새로운 종료 일자(NEW_VOUCHER_END_DTTM)를 계산해서 가져온다.
		java.util.List<VoucherVO> voucherHistList =  suspensionMapper.getVoucherList(suspensionVO);
		if(voucherHistList!=null&&voucherHistList.size()>0){
			VoucherHistVO voucherHistVO = null;
			for(VoucherVO voucherVO : voucherHistList){
				// 1-2. (해당 레코드에 대해서...) TB_SVC_VOUCHER_DELAY_HIST 테이블에 등록한다.
				voucherHistVO = new VoucherHistVO();
				voucherHistVO.setVoucherSeq(voucherVO.getVoucherSeq());
				voucherHistVO.setDelaySeq(suspensionVO.getDelaySeq());	// set DELAY_SEQ
				voucherHistVO.setDelayDdCnt(voucherVO.getDateDiff());
				voucherHistVO.setVoucherStrDttm(voucherVO.getVoucherStrDttm());
				voucherHistVO.setVoucherEndDttm(voucherVO.getVoucherEndDttm());
				suspensionMapper.insertVoucherHist(voucherHistVO);
				voucherHistVO = null;
			}
		}
	}
	
	/**
	 * 운휴관리에서 날짜를 수정하고 이용과 종료 일자와 수정과 운휴 기록을 등록한다.
	 * @param suspensionVO
	 */
	public void updateVoucher(SuspensionVO suspensionVO) {
		// 1. update할 대상의 회원권 목록을 가져온다. 가져올 때 중복일자(DATE_DIFF)와 새로운 종료 일자(NEW_VOUCHER_END_DTTM)를 계산해서 가져온다.
		java.util.List<VoucherVO> voucherHistList =  suspensionMapper.getVoucherList(suspensionVO);
		if(voucherHistList!=null&&voucherHistList.size()>0){
			VoucherHistVO voucherHistVO = null;
			for(VoucherVO voucherVO : voucherHistList){
				// 1-1. (각 레코드에 대해서...) TB_SBC_VOUCHER 테이블을 수정한다. 해당 로직에서는 VOUCHER_END_DTTM을 NEW_VOUCHER_END_DTTM 값으로 수정만 하면 된다.
				suspensionMapper.updateVoucher(voucherVO);
				// 1-2. (해당 레코드에 대해서...) TB_SVC_VOUCHER_DELAY_HIST 테이블에 등록한다.
				voucherHistVO = new VoucherHistVO();
				voucherHistVO.setVoucherSeq(voucherVO.getVoucherSeq());
				voucherHistVO.setDelaySeq(suspensionVO.getDelaySeq());	// set DELAY_SEQ
				voucherHistVO.setDelayDdCnt(voucherVO.getDateDiff());
				voucherHistVO.setVoucherStrDttm(voucherVO.getVoucherStrDttm());
				voucherHistVO.setVoucherEndDttm(voucherVO.getVoucherEndDttm());
				suspensionMapper.updateVoucherHist(voucherHistVO);
				voucherHistVO = null;
			}
		}
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int deleteSuspension(SuspensionVO suspensionVO) {
		return suspensionMapper.deleteSuspension(suspensionVO);
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int countSuspensionValid(SuspensionVO suspensionVO) {
		return suspensionMapper.getDuplicateCount(suspensionVO);
	}

}
