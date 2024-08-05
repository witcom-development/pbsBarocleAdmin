package com.dkitec.barocle.admin.service.paymentmgmt.payment.service;

import java.util.List;
import java.util.Map;

import com.dkitec.cfood.core.CfoodException;
import com.dkitec.barocle.admin.service.paymentmgmt.payment.vo.PaymentStatVO;
import com.dkitec.barocle.admin.service.paymentmgmt.payment.vo.PaymentVO;
import com.dkitec.barocle.admin.service.paymentmgmt.refund.vo.RefundVO;

public interface PaymentService {
	public List<PaymentVO> getPaymentList(PaymentVO paymentVO) throws CfoodException;
	public int getPaymentListCount(PaymentVO paymentVO) throws CfoodException;
	public String getLatestSms(PaymentVO paymentVO) throws CfoodException;
	public List<PaymentVO> getPaymentStatistics_row(PaymentVO paymentVO) throws CfoodException;
	public PaymentStatVO getPaymentStatistics_col(PaymentVO paymentVO) throws CfoodException;
	public RefundVO getRefundInfo(RefundVO refundVO) throws CfoodException;
	public int addRefund(RefundVO refundVO) throws CfoodException;
	public int setRefundStus(RefundVO refundVO) throws CfoodException;
	public PaymentVO getCancelInfo(PaymentVO paymentVO) throws CfoodException;
	public int setPaymentCancel(PaymentVO paymentVO) throws CfoodException;
	public String chkVoucherStatus(PaymentVO paymentVO);
	public int chkRentHistStatus(String voucher);
	public void delVoucherInfo(PaymentVO paymentVO);
	public PaymentStatVO getCancelPaymentStatistics_col(PaymentVO paymentVO);
	
	public Map<String, String> getPaymentCancelInfo(PaymentVO paymentVO);	//Paygate 결제취소 정보 가져오기_20160812_JJH
	public int updateVoucherInfo(RefundVO refundVO);				//환불 시 이용권정보 update_20161026_JJH
	public void delCoupon(PaymentVO paymentVO);							//받은 선물 존재시 사용안했다면 delete_20161115_cms
	public void udtCoupon(String couponNo);							//받은 선물 존재시 _20161115_cms
	public PaymentVO getCouponYnChk(PaymentVO paymentVO);			//쿠폰번호 조회및 이용권 사용 체크_cms_20161205
	public PaymentVO getAddPayMethod(PaymentVO paymentVO);			//탈퇴시 payco,kakao billingkey 삭제 ydw_201902
	
	public PaymentVO getMileChk(PaymentVO paymentVO);			// 마일리지 금액 조회
	public int addMileageUse(PaymentVO paymentVO);				// 결제된 마일리지 복구
	
	public int getRefundTempAmt(RefundVO paymentVO) throws CfoodException;  //20200118 
	
	public int insertAccount(RefundVO paymentVO);  //20200118 회원 정보 입력
}
