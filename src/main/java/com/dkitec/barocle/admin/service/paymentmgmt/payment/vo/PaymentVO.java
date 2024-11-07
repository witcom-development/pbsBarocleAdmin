package com.dkitec.barocle.admin.service.paymentmgmt.payment.vo;

import java.io.Serializable;
import java.math.BigInteger;

import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.apache.ibatis.type.Alias;
import org.springframework.web.multipart.MultipartFile;

import com.dkitec.barocle.base.IConstants;
import com.dkitec.barocle.util.egov.paging.VO.PagingVO;

@Alias("paymentVO")
public class PaymentVO extends PagingVO implements Serializable {

	static final long serialVersionUID = 3064077814040837376L;
	
	private String lang = IConstants.LANG_KR;
	private String excelFlg;
	private MultipartFile bulkFile;
	private String viewFlg = IConstants.MODE_LIST;
	
	private BigInteger paymentSeq;
	private String paymentDttm;
	private BigInteger usrSeq;
	@Size(max=10, message="상태코드 형식이 아닙니다.")
	@Pattern(regexp="^[A-Z]*_[0-9]{3}$" , message="공통코드 형식이 아닙니다.")
	private String paymentClsCd;
	private String paymentClsCdName;
	@Size(max=10, message="상태코드 형식이 아닙니다.")
	@Pattern(regexp="^[A-Z]*_[0-9]{3}$" , message="공통코드 형식이 아닙니다.")
	private String paymentMethodCd;
	private String paymentMethodCdName;
	@Size(max=10, message="상태코드 형식이 아닙니다.")
	@Pattern(regexp="^[A-Z]*_[0-9]{3}$" , message="공통코드 형식이 아닙니다.")
	private String paymentStusCd;
	private String paymentStusCdName;
	private String mbSerialNo;
	private String paymentConfmNo;
	private String paymentConfmDttm;
	private String paymentConfmPaytype;
	private String paymentReqDttm;
	private int totAmt;
	private int mileagePaymentAmt;
	private int rentOverFeeSum;
	private String cancelDttm;
	@Size(max=10, message="상태코드 형식이 아닙니다.")
	@Pattern(regexp="^[A-Z]*_[0-9]{3}$" , message="공통코드 형식이 아닙니다.")
	private String cancelRsltCd;
	private String cancelReasonDesc;
	private String cancelAdminId;
	private String cancelAdminName;
	private String usrMpnNo;
	private String mbId;
	private String usrMainId;
	private String paymentClsCdType;
	private String mb_id_excel;
	/** 페이징 여부 */
    @Pattern(regexp="Y|N" , message="잘못된 형식입니다.")
	private String pagingYn;
	private String startPaymentDttm;
	private String endPaymentDttm;
	private String paymentConfmNoSeacrhKey;
	private String usrSearchType;
	private String usrSearchKey;
	
	private String useYn;				//결제상태
	private String couponNo;			//이용권번호
	
	// 2018-09-14
	private String usrClsCd;
	private String mbCardNo;
	
	// 결제요약 조회여부
	private String isSearchGb;
	
	//결제키 
	private String billingKey;
	private String billingCertifyKey;
	
	private String resultCD;
	private int rentHistSeq;
	private String processReasonDesc;
	
	private String stationGrpName;
	private String stationGrpSeq;
	
	
	public String getStationGrpName() {
		return stationGrpName;
	}
	public void setStationGrpName(String stationGrpName) {
		this.stationGrpName = stationGrpName;
	}
	public String getStationGrpSeq() {
		return stationGrpSeq;
	}
	public void setStationGrpSeq(String stationGrpSeq) {
		this.stationGrpSeq = stationGrpSeq;
	}
	public String getProcessReasonDesc() {
		return processReasonDesc;
	}
	public void setProcessReasonDesc(String processReasonDesc) {
		this.processReasonDesc = processReasonDesc;
	}
	public int getRentHistSeq() {
		return rentHistSeq;
	}
	public void setRentHistSeq(int rentHistSeq) {
		this.rentHistSeq = rentHistSeq;
	}
	public String getResultCD() {
		return resultCD;
	}
	public void setResultCD(String resultCD) {
		this.resultCD = resultCD;
	}
	public String getMbSerialNo() {
		return mbSerialNo;
	}
	public void setMbSerialNo(String mbSerialNo) {
		this.mbSerialNo = mbSerialNo;
	}
	public String getPaymentConfmPaytype() {
		return paymentConfmPaytype;
	}
	public void setPaymentConfmPaytype(String paymentConfmPaytype) {
		this.paymentConfmPaytype = paymentConfmPaytype;
	}
	public String getIsSearchGb() {
		return isSearchGb;
	}
	public void setIsSearchGb(String isSearchGb) {
		this.isSearchGb = isSearchGb;
	}
	public String getMbCardNo() {
		return mbCardNo;
	}
	public void setMbCardNo(String mbCardNo) {
		this.mbCardNo = mbCardNo;
	}
	public String getusrClsCd() {
		return usrClsCd;
	}
	public void setusrClsCd(String usrClsCd) {
		this.usrClsCd = usrClsCd;
	}
	
	
	
	public String getCouponNo() {
		return couponNo;
	}
	public void setCouponNo(String couponNo) {
		this.couponNo = couponNo;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public String getMb_id_excel() {
		return mb_id_excel;
	}
	public void setMb_id_excel(String mb_id_excel) {
		this.mb_id_excel = mb_id_excel;
	}
	public String getLang() {
		return lang;
	}
	public void setLang(String lang) {
		this.lang = lang;
	}
	public String getExcelFlg() {
		return excelFlg;
	}
	public void setExcelFlg(String excelFlg) {
		this.excelFlg = excelFlg;
	}
	public MultipartFile getBulkFile() {
		return bulkFile;
	}
	public void setBulkFile(MultipartFile bulkFile) {
		this.bulkFile = bulkFile;
	}
	public String getViewFlg() {
		return viewFlg;
	}
	public void setViewFlg(String viewFlg) {
		this.viewFlg = viewFlg;
	}
	public BigInteger getPaymentSeq() {
		return paymentSeq;
	}
	public void setPaymentSeq(BigInteger paymentSeq) {
		this.paymentSeq = paymentSeq;
	}
	public String getPaymentDttm() {
		return paymentDttm;
	}
	public void setPaymentDttm(String paymentDttm) {
		this.paymentDttm = paymentDttm;
	}
	public BigInteger getUsrSeq() {
		return usrSeq;
	}
	public void setUsrSeq(BigInteger usrSeq) {
		this.usrSeq = usrSeq;
	}
	public String getPaymentClsCd() {
		return paymentClsCd;
	}
	public void setPaymentClsCd(String paymentClsCd) {
		this.paymentClsCd = paymentClsCd;
	}
	public String getPaymentClsCdName() {
		return paymentClsCdName;
	}
	public void setPaymentClsCdName(String paymentClsCdName) {
		this.paymentClsCdName = paymentClsCdName;
	}
	public String getPaymentMethodCd() {
		return paymentMethodCd;
	}
	public void setPaymentMethodCd(String paymentMethodCd) {
		this.paymentMethodCd = paymentMethodCd;
	}
	public String getPaymentMethodCdName() {
		return paymentMethodCdName;
	}
	public void setPaymentMethodCdName(String paymentMethodCdName) {
		this.paymentMethodCdName = paymentMethodCdName;
	}
	public String getPaymentStusCd() {
		return paymentStusCd;
	}
	public void setPaymentStusCd(String paymentStusCd) {
		this.paymentStusCd = paymentStusCd;
	}
	public String getPaymentStusCdName() {
		return paymentStusCdName;
	}
	public void setPaymentStusCdName(String paymentStusCdName) {
		this.paymentStusCdName = paymentStusCdName;
	}
	public String getPaymentConfmNo() {
		return paymentConfmNo;
	}
	public void setPaymentConfmNo(String paymentConfmNo) {
		this.paymentConfmNo = paymentConfmNo;
	}
	public String getPaymentConfmDttm() {
		return paymentConfmDttm;
	}
	public void setPaymentConfmDttm(String paymentConfmDttm) {
		this.paymentConfmDttm = paymentConfmDttm;
	}
	public String getPaymentReqDttm() {
		return paymentReqDttm;
	}
	public void setPaymentReqDttm(String paymentReqDttm) {
		this.paymentReqDttm = paymentReqDttm;
	}
	public int getTotAmt() {
		return totAmt;
	}
	public void setTotAmt(int totAmt) {
		this.totAmt = totAmt;
	}
	public int getMileagePaymentAmt() {
		return mileagePaymentAmt;
	}
	public void setMileagePaymentAmt(int mileagePaymentAmt) {
		this.mileagePaymentAmt = mileagePaymentAmt;
	}
	public int getRentOverFeeSum() {
		return rentOverFeeSum;
	}
	public void setRentOverFeeSum(int rentOverFeeSum) {
		this.rentOverFeeSum = rentOverFeeSum;
	}
	public String getCancelDttm() {
		return cancelDttm;
	}
	public void setCancelDttm(String cancelDttm) {
		this.cancelDttm = cancelDttm;
	}
	public String getCancelRsltCd() {
		return cancelRsltCd;
	}
	public void setCancelRsltCd(String cancelRsltCd) {
		this.cancelRsltCd = cancelRsltCd;
	}
	public String getCancelReasonDesc() {
		return cancelReasonDesc;
	}
	public void setCancelReasonDesc(String cancelReasonDesc) {
		this.cancelReasonDesc = cancelReasonDesc;
	}
	public String getCancelAdminId() {
		return cancelAdminId;
	}
	public void setCancelAdminId(String cancelAdminId) {
		this.cancelAdminId = cancelAdminId;
	}
	public String getUsrMpnNo() {
		return usrMpnNo;
	}
	public void setUsrMpnNo(String usrMpnNo) {
		this.usrMpnNo = usrMpnNo;
	}
	public String getMbId() {
		return mbId;
	}
	public void setMbId(String mbId) {
		this.mbId = mbId;
	}
	public String getStartPaymentDttm() {
		return startPaymentDttm;
	}
	public void setStartPaymentDttm(String startPaymentDttm) {
		this.startPaymentDttm = startPaymentDttm;
	}
	public String getEndPaymentDttm() {
		return endPaymentDttm;
	}
	public void setEndPaymentDttm(String endPaymentDttm) {
		this.endPaymentDttm = endPaymentDttm;
	}
	public String getPaymentConfmNoSeacrhKey() {
		return paymentConfmNoSeacrhKey;
	}
	public void setPaymentConfmNoSeacrhKey(String paymentConfmNoSeacrhKey) {
		this.paymentConfmNoSeacrhKey = paymentConfmNoSeacrhKey;
	}
	public String getUsrSearchKey() {
		return usrSearchKey;
	}
	public void setUsrSearchKey(String usrSearchKey) {
		this.usrSearchKey = usrSearchKey;
	}
	public String getPagingYn() {
		return pagingYn;
	}
	public void setPagingYn(String pagingYn) {
		this.pagingYn = pagingYn;
	}
	public String getPaymentClsCdType() {
		return paymentClsCdType;
	}
	public void setPaymentClsCdType(String paymentClsCdType) {
		this.paymentClsCdType = paymentClsCdType;
	}
	public String getUsrSearchType() {
		return usrSearchType;
	}
	public void setUsrSearchType(String usrSearchType) {
		this.usrSearchType = usrSearchType;
	}
	public String getUsrMainId() {
		return usrMainId;
	}
	public void setUsrMainId(String usrMainId) {
		this.usrMainId = usrMainId;
	}
	public String getCancelAdminName() {
		return cancelAdminName;
	}
	public void setCancelAdminName(String cancelAdminName) {
		this.cancelAdminName = cancelAdminName;
	}
	@Override
	public String toString() {
		return "PaymentVO [lang=" + lang + ", excelFlg=" + excelFlg
				+ ", bulkFile=" + bulkFile + ", viewFlg=" + viewFlg
				+ ", paymentSeq=" + paymentSeq + ", paymentDttm=" + paymentDttm
				+ ", usrSeq=" + usrSeq + ", paymentClsCd=" + paymentClsCd
				+ ", paymentClsCdName=" + paymentClsCdName
				+ ", paymentMethodCd=" + paymentMethodCd
				+ ", paymentMethodCdName=" + paymentMethodCdName
				+ ", paymentStusCd=" + paymentStusCd + ", paymentStusCdName="
				+ paymentStusCdName + ", paymentConfmNo=" + paymentConfmNo
				+ ", paymentConfmDttm=" + paymentConfmDttm
				+ ", paymentReqDttm=" + paymentReqDttm + ", totAmt=" + totAmt
				+ ", mileagePaymentAmt=" + mileagePaymentAmt
				+ ", rentOverFeeSum=" + rentOverFeeSum + ", cancelDttm="
				+ cancelDttm + ", cancelRsltCd=" + cancelRsltCd
				+ ", cancelReasonDesc=" + cancelReasonDesc + ", cancelAdminId="
				+ cancelAdminId + ", cancelAdminName=" + cancelAdminName
				+ ", usrMpnNo=" + usrMpnNo + ", mbId=" + mbId + ", usrMainId="
				+ usrMainId + ", paymentClsCdType=" + paymentClsCdType
				+ ", mb_id_excel=" + mb_id_excel + ", pagingYn=" + pagingYn
				+ ", startPaymentDttm=" + startPaymentDttm
				+ ", endPaymentDttm=" + endPaymentDttm
				+ ", paymentConfmNoSeacrhKey=" + paymentConfmNoSeacrhKey
				+ ", usrSearchType=" + usrSearchType + ", usrSearchKey="
				+ usrSearchKey 
				+ ", isSerchGb =" + isSearchGb + 
				", mbSerialNo =" + mbSerialNo + 
				", paymentConfmPaytype =" + paymentConfmPaytype + 
				"]";
	}
	
	public String getBillingKey() {
		return billingKey;
	}
	public void setBillingKey(String billingKey) {
		this.billingKey = billingKey;
	}
	public String getBillingCertifyKey() {
		return billingCertifyKey;
	}
	public void setBillingCertifyKey(String billingCertifyKey) {
		this.billingCertifyKey = billingCertifyKey;
	}
	
	
}
