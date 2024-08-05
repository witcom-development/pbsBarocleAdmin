package com.dkitec.barocle.admin.service.membermgmt.service;

import java.util.List;
import java.util.Map;

import com.dkitec.barocle.admin.service.membermgmt.vo.BlackListMgmtVO;
import com.dkitec.barocle.admin.service.membermgmt.vo.CouponVO;
import com.dkitec.barocle.admin.service.membermgmt.vo.MemberMgmtVO;
import com.dkitec.barocle.admin.service.membermgmt.vo.MemberPaymentVO;
import com.dkitec.barocle.admin.service.membermgmt.vo.MobileSmsAuthVO;
import com.dkitec.barocle.admin.service.membermgmt.vo.RentSerialNumVO;
import com.dkitec.barocle.admin.service.membermgmt.vo.ReturnListMgmtVO;
import com.dkitec.barocle.admin.service.membermgmt.vo.TransitMgmtVO;
import com.dkitec.barocle.admin.service.membermgmt.vo.UserOutMgmtVO;
import com.dkitec.barocle.admin.service.membermgmt.vo.VoucherMgmtVO;

public interface MemberMgmtService {

	public int memberListCnt(MemberMgmtVO memberVo);

	public List<MemberMgmtVO> memberList(MemberMgmtVO memberVo);

	public MemberMgmtVO getMemberInfo(MemberMgmtVO memberVo);

	public MemberMgmtVO getMemberCardInfo(MemberMgmtVO memberVo);

	public List<MemberMgmtVO> getMemberCardInfoList(MemberMgmtVO memberVo);	
	
	public MemberMgmtVO getMemberAddChargeInfo(MemberMgmtVO memberVo);

	public int penaltyListCnt(MemberMgmtVO memberVo);

	public List<MemberMgmtVO> penaltyList(MemberMgmtVO memberVo);

	public MemberMgmtVO totalPenaltyBlackList(MemberMgmtVO memberVo);

	public void deletePenalty(MemberMgmtVO memberVo);

	public List<MemberMgmtVO> mileageList(MemberMgmtVO memberVo);

	public int mileageListCnt(MemberMgmtVO memberVo);

	String getUseVoucher(MemberMgmtVO memberVo);
	
	String getRemainVoucher(MemberMgmtVO memberVo);

	String getRentYn(MemberMgmtVO memberVo);
	
	String getRemainPayYn(MemberMgmtVO memberVo);
	
	String getBlackListYn(MemberMgmtVO memberVo);
	
	public int memberUnsubscribe(MemberMgmtVO memberVo);
	
	public int deleteAddPayMethod(MemberMgmtVO memberVo);

	public int memberPaymentListCnt(MemberPaymentVO paymentVo);

	public List<MemberPaymentVO> memberPaymentList(MemberPaymentVO paymentVo);

	public int memberUseListCnt(MemberPaymentVO paymentVo);

	public List<MemberPaymentVO> memberUseList(MemberPaymentVO paymentVo);

	public int memberRefundListCnt(MemberPaymentVO paymentVo);

	public List<MemberPaymentVO> memberRefundList(MemberPaymentVO paymentVo);
	
	public int memberUnpaidListCnt(MemberPaymentVO paymentVo);
	
	public List<MemberPaymentVO> memberUnpaidList(MemberPaymentVO paymentVo);

	public int memberVoucherListCnt(MemberPaymentVO paymentVo);
	
	public int memberVoucherUpdateCheck(MemberPaymentVO paymentVo);

	public List<MemberPaymentVO> memberVoucherList(MemberPaymentVO paymentVo);

	public MemberPaymentVO getMemberVoucher(MemberPaymentVO paymentVo);

	public void memberVoucherUpdate(MemberPaymentVO paymentVo);

	public List<UserOutMgmtVO> listUserOut(UserOutMgmtVO userOutMgmtVO);
	public int listUserOutCount(UserOutMgmtVO userOutMgmtVO);
	
	public List<BlackListMgmtVO> listBlackList(BlackListMgmtVO blackListMgmtVO);
	public int listBlackListCount(BlackListMgmtVO blackListMgmtVO);
	public boolean delBlackList(BlackListMgmtVO blackListMgmtVO);
	public List<BlackListMgmtVO> listBlackListReason();
	public boolean regBlackList(BlackListMgmtVO blackListMgmtVO);

	public void deletePenatyAll(BlackListMgmtVO blackListMgmtVO);

	public String getMemberUsrAuthVal(BlackListMgmtVO blackListMgmtVO);

	public int addSmsAllMBMpnNo(MemberMgmtVO memberVo);

	public String getBlaTypeClsCd(MemberMgmtVO memberVo);
	
	public int getTransitListCnt(TransitMgmtVO transitMgmtVO);
	
	public List<TransitMgmtVO> getTransitList(TransitMgmtVO transitMgmtVO);
	
	public List<VoucherMgmtVO> getVoucherType();	//	서비스관리 > 회원관리 > 회원정보 > 이용권 >이용권 생성_20161010_JJH
	
	public Map getMemberVoucherInfo(String usr_seq);	//	이용권 연장할 이용권정보 조회_20161010_JJH
	
	public Map getVoucherPeriodInfo(String usr_seq);	//	이용권 생성할 회원정보 조회_20161010_JJH
	
	public int creatVoucherProc(VoucherMgmtVO voucherMgmtVO);	// 이용권 생성할 회원의 이용권 존재여부 및 생성_20161011_JJH
	
	public int extendVoucherProc(VoucherMgmtVO voucherMgmtVO);	// 이용권 생성할 회원의 이용권 존재여부 및 생성_20161011_JJH

	public List<CouponVO> getRecvCouponList(CouponVO couponVO);	// 받은 이용권 선물 내역 조회 _20161104_cms

	public List<CouponVO> getSendCouponList(CouponVO couponVO);	// 보낸 이용권 선물 내역 조회 _20161104_cms

	public int getRecvCouponListCnt(CouponVO couponVO);			// 받은 이용권 선물 내역 count _20161104_cms

	public int getSendCouponListCnt(CouponVO couponVO);			// 보낸 이용권 선물 내역 count _20161104_cms

	public int listReturnListCount(ReturnListMgmtVO returnListMgmtVO);					// 추천반납 대여소 _20170116_cms

	public List<ReturnListMgmtVO> listReturnList(ReturnListMgmtVO returnListMgmtVO);	// 추천반납 대여소 _20170116_cms

	public ReturnListMgmtVO listReturnDetail(ReturnListMgmtVO returnListMgmtVO);	// 추천반납 대여소 상세정보_20170116

	public int listRentSerialNumCount(RentSerialNumVO rentSerialNumVO);

	public List<RentSerialNumVO> listRentSerialNum(RentSerialNumVO rentSerialNumVO);

	public RentSerialNumVO listRentSerialNumDetail(RentSerialNumVO rentSerialNumVO);

	public RentSerialNumVO getCancelInfo(RentSerialNumVO rentSerialNumVO);

	public int setVoucherExpiry(RentSerialNumVO voucherExpiryParam);

	public int listMobileSmsAuthCount(MobileSmsAuthVO mobileSmsAuthVO);

	public List<MobileSmsAuthVO> listMobileSmsAuthDetail(
			MobileSmsAuthVO mobileSmsAuthVO);

	public List<MobileSmsAuthVO> listMobileSmsAuth(
			MobileSmsAuthVO mobileSmsAuthVO);
	
	public int memberSaveInfo(MemberMgmtVO memberVo);
	
	public int VoucherCount(VoucherMgmtVO voucherMgmtVO);
	
	public int expiryVoucher(VoucherMgmtVO voucherMgmtVO);	// 이용권 강제정지
	
	public int memberCprListCnt(MemberMgmtVO memberVo); //법인회원 카운드

	public List<MemberMgmtVO> memberCprList(MemberMgmtVO memberVo); //법인회원 목록
	
	public MemberMgmtVO memberCprConfirm(MemberMgmtVO memberVo);	// 법인회원 승인
	
	public String fileDownloadList(MemberMgmtVO memberVo) throws Exception;

	public String fileDownloadNm(MemberMgmtVO memberVo) throws Exception;
	
	public int updateVoucherClsProc(MemberPaymentVO paymentVo);
	
	public List<MemberPaymentVO> getRentType();
	
	public int updateRentClsProc(MemberPaymentVO paymentVo);
	
	public int delReserveRentProc(MemberPaymentVO paymentVo);
	
	public int insertMpnPushProc(MemberMgmtVO memberVo);
	
	public int resetVoucherProc(VoucherMgmtVO voucherMgmtVO);// 이용권 초기화
	
	public int resetMemberPasswordProc(MemberMgmtVO memberVo);// 이용자 비밀번호 초기화
}
