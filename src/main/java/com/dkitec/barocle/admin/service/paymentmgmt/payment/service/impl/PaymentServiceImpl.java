package com.dkitec.barocle.admin.service.paymentmgmt.payment.service.impl;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.barocle.admin.common.service.CommonPopupMapper;
import com.dkitec.barocle.admin.service.paymentmgmt.mileage.vo.MileageVO;
import com.dkitec.barocle.admin.service.paymentmgmt.payment.service.PaymentMapper;
import com.dkitec.barocle.admin.service.paymentmgmt.payment.service.PaymentService;
import com.dkitec.barocle.admin.service.paymentmgmt.payment.vo.PaymentStatVO;
import com.dkitec.barocle.admin.service.paymentmgmt.payment.vo.PaymentVO;
import com.dkitec.barocle.admin.service.paymentmgmt.refund.vo.RefundVO;
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

@Service("paymentService")
public class PaymentServiceImpl implements PaymentService {
	protected static Logger log = LoggerFactory.getLogger(PaymentServiceImpl.class);
	
	@Autowired PaymentMapper paymentMapper;
	
	@Autowired private CommonPopupMapper commonPopupMapper;
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<PaymentVO> getPaymentList(PaymentVO paymentVO) throws CfoodException {
		return paymentMapper.getPaymentList(paymentVO);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int getPaymentListCount(PaymentVO paymentVO) throws CfoodException {
		return paymentMapper.getPaymentListCount(paymentVO);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public String getLatestSms(PaymentVO paymentVO) throws CfoodException {
		return paymentMapper.getLatestSms(paymentVO);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<PaymentVO> getPaymentStatistics_row(PaymentVO paymentVO) throws CfoodException {
		return paymentMapper.getPaymentStatistics_row(paymentVO);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public PaymentStatVO getPaymentStatistics_col(PaymentVO paymentVO) throws CfoodException {
		return paymentMapper.getPaymentStatistics_col(paymentVO);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public RefundVO getRefundInfo(RefundVO refundVO) throws CfoodException {
		return paymentMapper.getRefundInfo(refundVO);
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int addRefund(RefundVO refundVO) throws CfoodException {
		MileageVO mileageVo = new MileageVO();
		int result = 0;
		String mileageAmt = refundVO.getMileageAmt();
		if(!mileageAmt.equals("null") && !mileageAmt.equals("0")){
		mileageVo.setUsrSeq(refundVO.getUsrSeq());
		mileageVo.setMileageClsCd("MIG_002");
		mileageVo.setMileagePoint(mileageAmt);
		mileageVo.setUserId(refundVO.getRefundAdminId());
		//addMileageImpose
		result = commonPopupMapper.addMileageImpose(mileageVo);
		}
		return paymentMapper.addRefund(refundVO);
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int setRefundStus(RefundVO refundVO) throws CfoodException {
		return paymentMapper.setRefundStus(refundVO);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public PaymentVO getCancelInfo(PaymentVO paymentVO) throws CfoodException {
		return paymentMapper.getCancelInfo(paymentVO);
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int setPaymentCancel(PaymentVO paymentVO) throws CfoodException {
		return paymentMapper.setPaymentCancel(paymentVO);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public String chkVoucherStatus(PaymentVO paymentVO) {
		// TODO Auto-generated method stub
		return paymentMapper.chkVoucherStatus(paymentVO);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int chkRentHistStatus(String paymentVO) {
		// TODO Auto-generated method stub
		return  paymentMapper.chkRentHistStatus(paymentVO);
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public void delVoucherInfo(PaymentVO paymentVO) {
		// TODO Auto-generated method stub
		 paymentMapper.delVoucherInfo(paymentVO);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public PaymentStatVO getCancelPaymentStatistics_col(PaymentVO paymentVO) {
		// TODO Auto-generated method stub
		return  paymentMapper.getCancelPaymentStatistics_col(paymentVO);
	}
	
	/**
	 * Paygate 결제취소 정보 가져오기_20160812_JJH
	 */
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public Map<String, String> getPaymentCancelInfo(PaymentVO paymentVO){
		return paymentMapper.getPaymentCancelInfo(paymentVO);
	}
	
	/**
	 * 환불 시 이용권정보 만료_20161026_JJH
	 */
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int updateVoucherInfo(RefundVO refundVO){
		return paymentMapper.updateVoucherInfo(refundVO);
	}

	/**
	 * 결제취소 - 받은 선물 존재시 사용안했다면 delete_20161115_cms
	 */
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public void delCoupon(PaymentVO paymentVO) {
		log.debug("##### PaymentServiceImpl in~!! #####");
		// receive 먼저 진행
		paymentMapper.delRecvCoupon(paymentVO);
		// 이후 send 진행
		paymentMapper.delSendCoupon(paymentVO);
	}

	/**
	 * 환불처리 - 받은 선물 존재시 사용안했다면 update_20161116_cms
	 */
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public void udtCoupon(String couponNo) {
		
		paymentMapper.udtCoupon(couponNo);
	}

	/**
	 * 쿠폰번호 조회및 이용권 사용 체크_cms_20161205
	 */
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public PaymentVO getCouponYnChk(PaymentVO paymentVO) {
		// TODO Auto-generated method stub
		return paymentMapper.getCouponYnChk(paymentVO);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public PaymentVO getAddPayMethod(PaymentVO paymentVO) {
		return paymentMapper.getAddPayMethod(paymentVO);
	}
	
	/**
	 * 취소 쿠폰 마일리지 사용 조회
	 */
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public PaymentVO getMileChk(PaymentVO paymentVO) throws CfoodException {
		return paymentMapper.getCancelInfo(paymentVO);
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int addMileageUse(PaymentVO paymentVO) throws CfoodException {
		MileageVO mileageVo = new MileageVO();
		String mileageAmt = Integer.toString(paymentVO.getMileagePaymentAmt());
		mileageVo.setUsrSeq(paymentVO.getUsrSeq().toString());
		mileageVo.setMileageClsCd("MIG_002");
		mileageVo.setMileagePoint(mileageAmt);
		mileageVo.setUserId(paymentVO.getCancelAdminId());
		
		return commonPopupMapper.addMileageImpose(mileageVo);
	}
	
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public int getRefundTempAmt(RefundVO paymentVO) throws CfoodException {
		return paymentMapper.getRefundTempAmt(paymentVO);
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int insertAccount(RefundVO paymentVO)  {
		return paymentMapper.insertAccount(paymentVO);
	}
}
