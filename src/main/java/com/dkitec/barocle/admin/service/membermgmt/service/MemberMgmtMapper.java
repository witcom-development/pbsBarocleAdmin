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

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("memberMgmtMapper")
public interface MemberMgmtMapper {

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
	
	int deleteMemberMileageInfo(MemberMgmtVO memberVo);
	
	int deletePenaltyPointsInfo(MemberMgmtVO memberVo);
	
	int deleteMemberCard(MemberMgmtVO memberVo);
	
	int deleteAddPayMethod(MemberMgmtVO memberVo);
	
	int deleteMemberInfo(MemberMgmtVO memberVo);
	
	int deleteMemberDetailInfo(MemberMgmtVO memberVo);	
	
	public int memberPaymentListCnt(MemberPaymentVO paymentVo);

	public List<MemberPaymentVO> memberPaymentList(MemberPaymentVO memberVo);

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
	
	public int delBlackList(BlackListMgmtVO blackListMgmtVO);
	
	public List<BlackListMgmtVO> listBlackListReason();
	
	public int regBlackList(BlackListMgmtVO blackListMgmtVO);

	public void deletePenatyAll(BlackListMgmtVO blackListMgmtVO);

	public String getMemberUsrAuthVal(BlackListMgmtVO blackListMgmtVO);

	public int addSmsAllMBMpnNo(MemberMgmtVO memberVo);

	public List<MemberMgmtVO> memberListPayment(MemberMgmtVO memberVo);

	public int memberListPaymentCnt(MemberMgmtVO memberVo);

	public String getBlaTypeClsCd(MemberMgmtVO memberVo);
	
	public int getTransitListCnt(TransitMgmtVO transitMgmtVo);
	
	public List<TransitMgmtVO> getTransitList(TransitMgmtVO transitMgmtVo);
	
	public List<VoucherMgmtVO> getVoucherType();	// 서비스관리 > 회원관리 > 회원정보 > 이용권 >이용권 생성_20161010_JJH
	
	public Map getMemberVoucherInfo(String usr_seq);	// 이용권 생성할 회원정보 조회_20161010_JJH
	
	public Map getVoucherPeriodInfo(String usr_seq); 	// 이용권 연장할 이용권정보 조회_20161010_JJH
	
	public int getMemberVoucherExistYN(VoucherMgmtVO voucherMgmtVO);	// 이용권 생성할 회원의 이용권 존재여부 및 생성_20161011_JJH
	
	public int insertPaymentInfo(VoucherMgmtVO voucherMgmtVO);	// 관리자에 의한 이용권 생성 (결제정보 삽입)_20161011_JJH
	
	public int insertVoucherInfo(VoucherMgmtVO voucherMgmtVO);	// 관리자에 의한 이용권 생성 (이용권정보 삽입)_20161011_JJH
	
	public int updateVoucherInfo(VoucherMgmtVO voucherMgmtVO);	// 관리자에 의한 이용권 연장 (이용권정보 업데이트)_20161011_JJH
	
	public java.util.Map getMemberPaymentInfo(VoucherMgmtVO voucherMgmtVO);	// 관리자에 의한 이용권 연장 (이용권정보 업데이트)_20161011_JJH

	public List<CouponVO> getRecvCouponList(CouponVO couponVO);		//받은 이용권 선물 내역 조회 _20161104_cms
	
	public List<CouponVO> getSendCouponList(CouponVO couponVO);		//보낸 이용권 선물 내역 조회 _20161104_cms

	public int getRecvCouponListCnt(CouponVO couponVO);				//받은 이용권 선물 내역 count _20161104_cms

	public int getSendCouponListCnt(CouponVO couponVO);				//보낸 이용권 선물 내역 count _20161104_cms

	public int listReturnListCount(ReturnListMgmtVO returnListMgmtVO);					// 추천반납대여소_20170116_cms

	public List<ReturnListMgmtVO> listReturnList(ReturnListMgmtVO returnListMgmtVO);	// 추천반납대여소_20170116_cms

	public ReturnListMgmtVO listReturnDetail(ReturnListMgmtVO returnListMgmtVO);	// 추천반납대여소 상세정보_20170116_cms

	public int listRentSerialNumCount(RentSerialNumVO rentSerialNumVO);

	public List<RentSerialNumVO> listRentSerialNum(RentSerialNumVO rentSerialNumVO);

	public RentSerialNumVO listRentSerialNumDetail(RentSerialNumVO rentSerialNumVO);

	public RentSerialNumVO getCancelInfo(RentSerialNumVO rentSerialNumVO);

	public int setVoucherExpiry(RentSerialNumVO rentSerialNumVO);

	public int setPaymentCancel(RentSerialNumVO rentSerialNumVO);

	public int listMobileSmsAuthCount(MobileSmsAuthVO mobileSmsAuthVO);

	public List<MobileSmsAuthVO> listMobileSmsAuth(
			MobileSmsAuthVO mobileSmsAuthVO);

	public List<MobileSmsAuthVO> listMobileSmsAuthDetail(
			MobileSmsAuthVO mobileSmsAuthVO);
	
	public int memberSaveInfo(MemberMgmtVO memberVo);
	
	public int memberSaveParentInfo(MemberMgmtVO memberVo);
	
	public int VoucherCount(VoucherMgmtVO voucherMgmtVO);
	
	public int expiryVoucher(VoucherMgmtVO voucherMgmtVO);	// 이용권 강제정지
	
	public int memberCprListCnt(MemberMgmtVO memberVo);

	public List<MemberMgmtVO> memberCprList(MemberMgmtVO memberVo);
	
	public int cprMemberListCnt(MemberMgmtVO memberVo);

	public List<MemberMgmtVO> cprMemberList(MemberMgmtVO memberVo);
	
	public int memberCprConfirm(MemberMgmtVO memberVo);
	
	public List<MemberMgmtVO> fileDownloadList(MemberMgmtVO noticeVO);	//파일 다운로드 조회 _cms_20161110
	
	public int updatePaymentClsInfo(MemberPaymentVO paymentVo);
	
	public int updateVoucherClsInfo(MemberPaymentVO paymentVo);
	
	public List<MemberPaymentVO> getRentType();
	
	public int updateRentClsInfo(MemberPaymentVO paymentVo);
	
	public int updateRentHistClsInfo(MemberPaymentVO paymentVo);
	
	public int insertRentCancleInfo(MemberPaymentVO paymentVo);
	public int deleteRentInfo(MemberPaymentVO paymentVo);
	public int updateRackInfo(MemberPaymentVO paymentVo);
	
	public int insertMpnPushProc(MemberMgmtVO memberVo);
	
	public int resetVoucherProc(VoucherMgmtVO voucherMgmtVO); // 이용권 초기화
	
	public int resetMemberPasswordProc(MemberMgmtVO memberVo); // 비밀번호 초기화
}
