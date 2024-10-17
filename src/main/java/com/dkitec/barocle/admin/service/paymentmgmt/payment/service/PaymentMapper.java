package com.dkitec.barocle.admin.service.paymentmgmt.payment.service;

import java.util.List;
import java.util.Map;

import com.dkitec.barocle.admin.service.paymentmgmt.payment.vo.PaymentStatVO;
import com.dkitec.barocle.admin.service.paymentmgmt.payment.vo.PaymentVO;
import com.dkitec.barocle.admin.service.paymentmgmt.refund.vo.RefundVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("paymentMapper")
public interface PaymentMapper {
	public List<PaymentVO> getPaymentList(PaymentVO paymentVO);
	public int getPaymentListCount(PaymentVO paymentVO);
	public String getLatestSms(PaymentVO paymentVO);
	public List<PaymentVO> getPaymentStatistics_row(PaymentVO paymentVO);
	public PaymentStatVO getPaymentStatistics_col(PaymentVO paymentVO);
	public RefundVO getRefundInfo(RefundVO refundVO);
	public int addRefund(RefundVO refundVO);
	public int setRefundStus(RefundVO refundVO);
	public PaymentVO getCancelInfo(PaymentVO paymentVO);
	public int setPaymentCancel(PaymentVO paymentVO);
	public String chkVoucherStatus(PaymentVO paymentVO);
	public int chkRentHistStatus(String paymentVO);
	public void delVoucherInfo(PaymentVO paymentVO);
	public PaymentStatVO getCancelPaymentStatistics_col(PaymentVO paymentVO);
	
	public Map<String, String> getPaymentCancelInfo(PaymentVO paymentVO);	// Paygate 결제취소 정보 가져오기_20160812_JJH
	
	public int updateVoucherInfo(RefundVO refundVO);				// 환불처리 된 이용권 정보 기간만료_20161026_JJH	
	
	public void delSendCoupon(PaymentVO paymentVO);						// 결제취소 - 보낸선물 테이블 해당 쿠폰 삭제_20161116_cms    -- 20210108 양재영수정
	public void delRecvCoupon(PaymentVO paymentVO);						// 결제취소 -  테이블 해당 쿠폰 삭제_20161116_cms           -- 20210108 양재영수정 
	
	public void udtCoupon(String couponNo);							// 환불처리 - 보낸선물 테이블 해당 쿠폰  수정_20161116_cms
	
	public PaymentVO getCouponYnChk(PaymentVO paymentVO);			// 쿠폰번호 조회및 이용권 사용 체크_cms_20161205
	
	public PaymentVO getAddPayMethod(PaymentVO paymentVO);
	
	public PaymentVO getMileChk(PaymentVO paymentVO);
	
	public int getRefundTempAmt(RefundVO paymentVO);		// 20200118
	
	public int insertAccount(RefundVO paymentVO);	// 20200118
	
	public int addPaymentInfo(PaymentVO paymentVO);
	public int setOverFeePayComplete(PaymentVO paymentVO);

}
