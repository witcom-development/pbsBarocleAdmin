package com.dkitec.barocle.admin.service.membermgmt.service.impl;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.dkitec.barocle.admin.service.membermgmt.service.MemberMgmtMapper;
import com.dkitec.barocle.admin.service.membermgmt.service.MemberMgmtService;
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
import com.dkitec.barocle.datasource.DataSource;
import com.dkitec.barocle.datasource.DataSourceType;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.property.EgovPropertyService;

@Service(value ="memberMgmtService")
public class MemberMgmtServiceImpl extends EgovAbstractServiceImpl implements MemberMgmtService{
	protected static Logger log = LoggerFactory.getLogger(MemberMgmtServiceImpl.class);
	
	@Autowired
	MemberMgmtMapper mapper;

	/** EgovPropertyService */
	@Resource(name = "propertiesService") protected EgovPropertyService propertiesService;

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int memberListCnt(MemberMgmtVO memberVo) {
		int result = 0;
		if(memberVo.getPaymentClsCd() == null || memberVo.getPaymentClsCd().equals("")) {
			result =  mapper.memberListCnt(memberVo);
		} else {
			result =  mapper.memberListPaymentCnt(memberVo);
		}
		
		return result;
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<MemberMgmtVO> memberList(MemberMgmtVO memberVo) {
		List<MemberMgmtVO> resultList = null;
		if(memberVo.getPaymentClsCd() == null || memberVo.getPaymentClsCd().equals("")) {
			resultList =  mapper.memberList(memberVo);
		} else {
			resultList =  mapper.memberListPayment(memberVo);
		}
		
		return resultList;
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public MemberMgmtVO getMemberInfo(MemberMgmtVO memberVo) {
		return mapper.getMemberInfo(memberVo);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public MemberMgmtVO getMemberCardInfo(MemberMgmtVO memberVo) {
		return mapper.getMemberCardInfo(memberVo);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<MemberMgmtVO> getMemberCardInfoList(MemberMgmtVO memberVo) {
		return mapper.getMemberCardInfoList(memberVo);
	}	
	
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public MemberMgmtVO getMemberAddChargeInfo(MemberMgmtVO memberVo) {
		return mapper.getMemberAddChargeInfo(memberVo);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int penaltyListCnt(MemberMgmtVO memberVo) {
		return mapper.penaltyListCnt(memberVo);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<MemberMgmtVO> penaltyList(MemberMgmtVO memberVo) {
		return mapper.penaltyList(memberVo);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public MemberMgmtVO totalPenaltyBlackList(MemberMgmtVO memberVo) {
		return mapper.totalPenaltyBlackList(memberVo);
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public void deletePenalty(MemberMgmtVO memberVo) {
		mapper.deletePenalty(memberVo);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<MemberMgmtVO> mileageList(MemberMgmtVO memberVo) {
		return mapper.mileageList(memberVo);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int mileageListCnt(MemberMgmtVO memberVo) {
		return mapper.mileageListCnt(memberVo);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public String getUseVoucher(MemberMgmtVO memberVo) {
		// TODO Auto-generated method stub
		return mapper.getUseVoucher(memberVo);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public String getRemainVoucher(MemberMgmtVO memberVo) {
		// TODO Auto-generated method stub
		return mapper.getRemainVoucher(memberVo);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public String getRentYn(MemberMgmtVO memberVo) {
		// TODO Auto-generated method stub
		return mapper.getRentYn(memberVo);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public String getRemainPayYn(MemberMgmtVO memberVo) {
		// TODO Auto-generated method stub
		return mapper.getRemainPayYn(memberVo);
	}
	
	@Override
	@Transactional(readOnly=false,propagation= Propagation.REQUIRED, rollbackFor={Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public int memberUnsubscribe(MemberMgmtVO memberVo) {
		// TODO Auto-generated method stub
		mapper.deleteMemberMileageInfo(memberVo);
		mapper.deletePenaltyPointsInfo(memberVo);
		mapper.deleteMemberCard(memberVo);
		mapper.deleteAddPayMethod(memberVo);
		mapper.deleteMemberInfo(memberVo);
		return mapper.deleteMemberDetailInfo(memberVo);
	}
	
	@Override
	@Transactional(readOnly=false,propagation= Propagation.REQUIRED, rollbackFor={Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public int deleteAddPayMethod(MemberMgmtVO memberVo) {
		return mapper.deleteAddPayMethod(memberVo);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public String getBlackListYn(MemberMgmtVO memberVo) {
		// TODO Auto-generated method stub
		return mapper.getBlackListYn(memberVo);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int memberPaymentListCnt(MemberPaymentVO paymentVo) {
		return mapper.memberPaymentListCnt(paymentVo);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<MemberPaymentVO> memberPaymentList(MemberPaymentVO memberVo) {
		return mapper.memberPaymentList(memberVo);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int memberUseListCnt(MemberPaymentVO paymentVo) {
		return mapper.memberUseListCnt(paymentVo);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<MemberPaymentVO> memberUseList(MemberPaymentVO paymentVo) {
		// TODO Auto-generated method stub
		return mapper.memberUseList(paymentVo);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int memberRefundListCnt(MemberPaymentVO paymentVo) {
		return mapper.memberRefundListCnt(paymentVo);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<MemberPaymentVO> memberRefundList(MemberPaymentVO paymentVo) {
		return mapper.memberRefundList(paymentVo);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int memberUnpaidListCnt(MemberPaymentVO paymentVo) {
		return mapper.memberUnpaidListCnt(paymentVo);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<MemberPaymentVO> memberUnpaidList(MemberPaymentVO paymentVo) {
		return mapper.memberUnpaidList(paymentVo);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int memberVoucherListCnt(MemberPaymentVO paymentVo) {
		return mapper.memberVoucherListCnt(paymentVo);
	}

	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int memberVoucherUpdateCheck(MemberPaymentVO paymentVo) {
		return mapper.memberVoucherUpdateCheck(paymentVo);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<MemberPaymentVO> memberVoucherList(MemberPaymentVO paymentVo) {
		return mapper.memberVoucherList(paymentVo);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public MemberPaymentVO getMemberVoucher(MemberPaymentVO paymentVo) {
		return mapper.getMemberVoucher(paymentVo);
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public void memberVoucherUpdate(MemberPaymentVO paymentVo) {
		mapper.memberVoucherUpdate(paymentVo);
	}

	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<UserOutMgmtVO> listUserOut(UserOutMgmtVO userOutMgmtVO) {
		return mapper.listUserOut(userOutMgmtVO);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int listUserOutCount(UserOutMgmtVO userOutMgmtVO) {
		return mapper.listUserOutCount(userOutMgmtVO);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<BlackListMgmtVO> listBlackList(BlackListMgmtVO blackListMgmtVO) {
		return mapper.listBlackList(blackListMgmtVO);
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int listBlackListCount(BlackListMgmtVO blackListMgmtVO) {
		return mapper.listBlackListCount(blackListMgmtVO);
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public boolean delBlackList(BlackListMgmtVO blackListMgmtVO) {
		return mapper.delBlackList(blackListMgmtVO) > 0 ? true : false;
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<BlackListMgmtVO> listBlackListReason() {
		return mapper.listBlackListReason();
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public boolean regBlackList(BlackListMgmtVO blackListMgmtVO) {
		return mapper.regBlackList(blackListMgmtVO) > 0 ? true : false;
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public void deletePenatyAll(BlackListMgmtVO blackListMgmtVO) {
		mapper.deletePenatyAll(blackListMgmtVO);
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.SLAVE01)
	public String getMemberUsrAuthVal(BlackListMgmtVO blackListMgmtVO) {
		return mapper.getMemberUsrAuthVal(blackListMgmtVO);
	}

	@Override
	@Transactional(readOnly=false,propagation=Propagation.REQUIRED,rollbackFor={Exception.class, SQLException.class})
	@DataSource(DataSourceType.MASTER)
	public int addSmsAllMBMpnNo(MemberMgmtVO memberVo) {
		// TODO Auto-generated method stub
		return mapper.addSmsAllMBMpnNo(memberVo);
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.SLAVE01)
	public String getBlaTypeClsCd(MemberMgmtVO memberVo) {
		// TODO Auto-generated method stub
		return mapper.getBlaTypeClsCd(memberVo);
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.SLAVE01)
	public int getTransitListCnt(TransitMgmtVO transitMgmtVO){
		return mapper.getTransitListCnt(transitMgmtVO);
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.SLAVE01)
	public List<TransitMgmtVO> getTransitList(TransitMgmtVO transitMgmtVO){
		return mapper.getTransitList(transitMgmtVO);
	}
	
	/**
	 * 서비스관리 > 회원관리 > 회원정보 > 이용권 >이용권 생성_20161010_JJH
	 */
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.SLAVE01)
	public List<VoucherMgmtVO> getVoucherType(){
		return mapper.getVoucherType();
	}
	
	/**
	 * 이용권 생성할 회원정보 조회_20161010_JJH
	 */
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.SLAVE01)
	public Map getMemberVoucherInfo(String usr_seq){
		return mapper.getMemberVoucherInfo(usr_seq);
	}
	
	/**
	 * 이용권 연장할 이용권정보 조회_20161010_JJH
	 */
	public Map getVoucherPeriodInfo(String usr_seq){
		return mapper.getVoucherPeriodInfo(usr_seq);
	}
	
	/**
	 * 이용권 생성할 회원의 이용권 존재여부 및 생성_20161011_JJH
	 */
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int creatVoucherProc(VoucherMgmtVO voucherMgmtVO){
		
		java.util.Map <String, String> returnMap = new java.util.HashMap <String, String>();
		//int isVoucherExist = mapper.getMemberVoucherExistYN(voucherMgmtVO);
		int isVoucherExist = 1;
		int isCreateYn = 0;
		String paymentClsCd = voucherMgmtVO.getPayment_cls_cd();
		
		if(!paymentClsCd.equals("BIL_008")){
			isVoucherExist = mapper.getMemberVoucherExistYN(voucherMgmtVO);
		}else{
			isVoucherExist = 0;
		}
		
		log.debug("##### MemberMgmtServiceImpl creatVoucherProc => isVoucherExist : " + isVoucherExist);
		
		if(isVoucherExist == 0)
		{
			int insPayResult = mapper.insertPaymentInfo(voucherMgmtVO);
			
			if(insPayResult == 1){
				log.debug("##### MemberMgmtServiceImpl creatVoucherProc => 결제정보 삽입완료 #####");
				returnMap = mapper.getMemberPaymentInfo(voucherMgmtVO);
				
				voucherMgmtVO.setPayment_seq(String.valueOf(returnMap.get("payment_seq")));
				voucherMgmtVO.setPayment_dttm(String.valueOf(returnMap.get("payment_dttm")));
				
				int insVouResult = mapper.insertVoucherInfo(voucherMgmtVO);
				
				if(insVouResult == 1){
					log.debug("##### MemberMgmtServiceImpl creatVoucherProc => 이용권정보 삽입완료 #####");
				}else{
					log.debug("##### MemberMgmtServiceImpl creatVoucherProc => 이용권정보 실패완료 #####");
					isCreateYn = 2;
				}
				
				if((insPayResult == 1) && (insVouResult == 1)){
					log.debug("##### MemberMgmtServiceImpl creatVoucherProc => 이용권정보, 결제정보 삽입완료 #####");
					isCreateYn = 1;
				}
					
			}else{
				log.debug("##### MemberMgmtServiceImpl creatVoucherProc => 결제정보 삽입안됨 #####");
				isCreateYn = 2;
			}
			
		}else{
			log.debug("##### MemberMgmtServiceImpl creatVoucherProc => 이미 이용권이 있어서 이용권을 생성할 수 없었어 #####");
			isCreateYn = 3;
		}
		
		return isCreateYn;
	}
	
	/**
	 * 이용권 생성할 회원의 이용권 존재여부 및 생성_20161011_JJH
	 */
	public int extendVoucherProc(VoucherMgmtVO voucherMgmtVO){
		int returnVal = mapper.updateVoucherInfo(voucherMgmtVO);
	
		return returnVal;
	}

	/**
	 * 받은 이용권 선물 내역 조회 _20161104_cms
	 */
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.SLAVE01)
	public List<CouponVO> getRecvCouponList(CouponVO couponVO) {
		// TODO Auto-generated method stub
		return mapper.getRecvCouponList(couponVO);
	}

	/**
	 * 보낸 이용권 선물 내역 조회 _20161104_cms
	 */
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.SLAVE01)
	public List<CouponVO> getSendCouponList(CouponVO couponVO) {
		// TODO Auto-generated method stub
		return mapper.getSendCouponList(couponVO);
	}
	
	/**
	 * 받은 이용권 선물 내역 count _20161104_cms
	 */
	@Override
	public int getRecvCouponListCnt(CouponVO couponVO) {
		int returnVal = mapper.getRecvCouponListCnt(couponVO);
		return returnVal;
	}

	/**
	 * 보낸 이용권 선물 내역 count _20161104_cms
	 */
	@Override
	public int getSendCouponListCnt(CouponVO couponVO) {
		int returnVal = mapper.getSendCouponListCnt(couponVO);
		return returnVal;
	}

	@Override
	public int listReturnListCount(ReturnListMgmtVO returnListMgmtVO) {
		// TODO Auto-generated method stub
		return mapper.listReturnListCount(returnListMgmtVO);
	}

	@Override
	public List<ReturnListMgmtVO> listReturnList(ReturnListMgmtVO returnListMgmtVO) {
		// TODO Auto-generated method stub
		return mapper.listReturnList(returnListMgmtVO);
	}

	@Override
	public ReturnListMgmtVO listReturnDetail(ReturnListMgmtVO returnListMgmtVO) {
		// TODO Auto-generated method stub
		return mapper.listReturnDetail(returnListMgmtVO);
	}
	
	@Override
	public int listRentSerialNumCount(RentSerialNumVO rentSerialNumVO) {
		// TODO Auto-generated method stub
		return mapper.listRentSerialNumCount(rentSerialNumVO);
	}
	
	@Override
	public List<RentSerialNumVO> listRentSerialNum(RentSerialNumVO rentSerialNumVO) {
		// TODO Auto-generated method stub
		return mapper.listRentSerialNum(rentSerialNumVO);
	}
	
	@Override
	public RentSerialNumVO listRentSerialNumDetail(RentSerialNumVO rentSerialNumVO) {
		// TODO Auto-generated method stub
		return mapper.listRentSerialNumDetail(rentSerialNumVO);
	}
	
	@Override
	public RentSerialNumVO getCancelInfo(RentSerialNumVO rentSerialNumVO) {
		// TODO Auto-generated method stub
		return mapper.getCancelInfo(rentSerialNumVO);
	}
	
	@Override
	public int setVoucherExpiry(RentSerialNumVO rentSerialNumVO) {
		// TODO Auto-generated method stub
		int result = mapper.setVoucherExpiry(rentSerialNumVO);
		if(result == 0){
			return result;
		}
		
		return mapper.setPaymentCancel(rentSerialNumVO);
	}

	@Override
	public int listMobileSmsAuthCount(MobileSmsAuthVO mobileSmsAuthVO) {
		// TODO Auto-generated method stub
		return mapper.listMobileSmsAuthCount(mobileSmsAuthVO);
	}
	
	@Override
	public List<MobileSmsAuthVO> listMobileSmsAuth(MobileSmsAuthVO mobileSmsAuthVO) {
		// TODO Auto-generated method stub
		return mapper.listMobileSmsAuth(mobileSmsAuthVO);
	}
	
	@Override
	public List<MobileSmsAuthVO> listMobileSmsAuthDetail(MobileSmsAuthVO mobileSmsAuthVO) {
		// TODO Auto-generated method stub
		return mapper.listMobileSmsAuthDetail(mobileSmsAuthVO);
	}
	
	@Override
	public int memberSaveInfo(MemberMgmtVO memberVo) {
		// TODO Auto-generated method stub
		int result = 0;
		result = mapper.memberSaveInfo(memberVo);
		
		if(memberVo.getParent_mpn_no() != "" && memberVo.getParent_mpn_no() != null){
			result = mapper.memberSaveParentInfo(memberVo);
		}
		
		return result;
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int VoucherCount(VoucherMgmtVO voucherMgmtVO) {
		return mapper.VoucherCount(voucherMgmtVO);
	}
	
	@Override
	public int expiryVoucher(VoucherMgmtVO voucherMgmtVO){	
		return mapper.expiryVoucher(voucherMgmtVO);
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public int memberCprListCnt(MemberMgmtVO memberVo) {
		int result = 0;
			result =  mapper.cprMemberListCnt(memberVo);
		
		return result;
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.SLAVE01)
	public List<MemberMgmtVO> memberCprList(MemberMgmtVO memberVo) {
		List<MemberMgmtVO> resultList = null;
			resultList =  mapper.cprMemberList(memberVo);
		
		return resultList;
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public MemberMgmtVO memberCprConfirm(MemberMgmtVO memberVo) {
		int resultValue = mapper.memberCprConfirm(memberVo);
		
		return memberVo;
	}
	
	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public String fileDownloadList(MemberMgmtVO memberVo) throws Exception {

		java.util.List<MemberMgmtVO> opinionBoardList = mapper.fileDownloadList(memberVo);
		String originalFilePath = propertiesService.getString("fileUploadDir") + propertiesService.getString("ctnDaumDir") +"/"+ memberVo.getaFolder()+"/";
		String fileNm = originalFilePath + opinionBoardList.get(0).getAttachNm();
		//fileNm = "/upload/"+fileNm.substring(46);
		
		System.out.println("fileNm ::::::: " + fileNm);
		
		return fileNm;
	}

	@Override
	@Transactional(readOnly=true)
	@DataSource(DataSourceType.MASTER)
	public String fileDownloadNm(MemberMgmtVO memberVo) throws Exception {

		java.util.List<MemberMgmtVO> opinionBoardList = mapper.fileDownloadList(memberVo);
		String fileNm = opinionBoardList.get(0).getImgName();
		System.out.println("fileNm ::::::: " + fileNm);
		return fileNm;
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int updateVoucherClsProc(MemberPaymentVO paymentVo){
		int result = 0;
		result = mapper.updatePaymentClsInfo(paymentVo);
		if(result != 0){	// 결제 테이블 수정 완료 & 이용권 테이블 수정
			mapper.updateVoucherClsInfo(paymentVo);
		}
		return result;
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.SLAVE01)
	public List<MemberPaymentVO> getRentType(){
		return mapper.getRentType();
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int updateRentClsProc(MemberPaymentVO paymentVo){
		int result = 0;
		if( !paymentVo.getReturn_station().equals("대여중")){
			result =  mapper.updateRentHistClsInfo(paymentVo);
		}else{
			result =  mapper.updateRentClsInfo(paymentVo);
		}
		return result;
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int delReserveRentProc(MemberPaymentVO paymentVo){
		int result = 0;
		
		result = mapper.insertRentCancleInfo(paymentVo);
		result = mapper.deleteRentInfo(paymentVo);
		result = mapper.updateRackInfo(paymentVo);

		return result;
	}
	
	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int insertMpnPushProc(MemberMgmtVO memberVo){
		int result = 0;
		
		result = mapper.insertMpnPushProc(memberVo);

		return result;
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int resetVoucherProc(VoucherMgmtVO voucherMgmtVO){
		
		return mapper.resetVoucherProc(voucherMgmtVO);
	}

	@Override
	@Transactional(readOnly=false)
	@DataSource(DataSourceType.MASTER)
	public int resetMemberPasswordProc(MemberMgmtVO memberVo){
		return mapper.resetMemberPasswordProc(memberVo); 
	}
}
