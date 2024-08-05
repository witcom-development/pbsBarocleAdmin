package com.dkitec.barocle.admin.service.paymentmgmt.refundReq.vo;

import java.io.Serializable;
import java.math.BigInteger;

import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.apache.ibatis.type.Alias;
import org.springframework.web.multipart.MultipartFile;

import com.dkitec.barocle.base.IConstants;
import com.dkitec.barocle.util.egov.paging.VO.PagingVO;

@Alias("refundReqVO")
public class RefundReqVO extends PagingVO implements Serializable {
	
	private static final long serialVersionUID = -7667618860454003376L;
	
	private String lang = IConstants.LANG_KR;
	private String excelFlg;
	private MultipartFile bulkFile;
	private String viewFlg = IConstants.MODE_LIST;
	
	@Size(max=10, message="상태코드 형식이 아닙니다.")
	@Pattern(regexp="^[A-Z]*_[0-9]{3}$" , message="공통코드 형식이 아닙니다.")
	private String paymentClsCd;
	private String paymentClsCdName;
	@Size(max=10, message="상태코드 형식이 아닙니다.")
	@Pattern(regexp="^[A-Z]*_[0-9]{3}$" , message="공통코드 형식이 아닙니다.")
	private String paymentStusCd;
	private String paymentStusCdName;
	private String paymentConfmNo;
	private String usrMpnNo;
	private String mbId;
	private BigInteger refundHistSeq;
	private BigInteger paymentSeq;
	private String paymentDttm;
	private String refundDttm;
	private int refundAmt;
	private int refundComssnAmt;
	private int totAmt;
	private String refundReason;
	private String refundAdminId;
	private String refundAdminName;
	private String usrMainId;
	private String cancelDttm;
	private String cancelReasonDesc;
	private int searchCount;
	private int searchTotAmt;
	private int searchRefundTotAmt;
	private String mb_id_excel;
	private String paymentMethodCd;
	private String refndAmt;
	private String mileagePaymentAmt;
	private String acnutBank;
	private String acnutNo;
	private String acnutNm;
	
	/** 페이징 여부 */
    @Pattern(regexp="Y|N" , message="잘못된 형식입니다.")
	private String pagingYn;
	private String startDttm;
	private String endDttm;
	private String searchType;
	
	private String couponNo;	//선물한 쿠폰 NO
	private String useYn;		//이용권 사용 유무

	private BigInteger usrSeq;
	private String paymentMethodCdName;
	
	private String fistStrDttm;	// 이용개시일
	
	public String getFistStrDttm() {
		return fistStrDttm;
	}
	public void setFistStrDttm(String fistStrDttm) {
		this.fistStrDttm = fistStrDttm;
	}
	private String acnutUsrName;	
	
	public String getAcnutUsrName() {
		return acnutUsrName;
	}
	public void setAcnutUsrName(String acnutUsrName) {
		this.acnutUsrName = acnutUsrName;
	}

	private String bankList; 	// 계좌번호
	
	public String getBankList() {
		return bankList;
	}
	public void setBankList(String bankList) {
		this.bankList = bankList;
	}
	
	
	public String getAcnutBank() {
		return acnutBank;
	}
	public void setAcnutBank(String acnutBank) {
		this.acnutBank = acnutBank;
	}
	public String getAcnutNo() {
		return acnutNo;
	}
	public void setAcnutNo(String acnutNo) {
		this.acnutNo = acnutNo;
	}
	public BigInteger getUsrSeq() {
		return usrSeq;
	}
	public void setUsrSeq(BigInteger usrSeq) {
		this.usrSeq = usrSeq;
	}
	public String getPaymentMethodCdName() {
		return paymentMethodCdName;
	}
	public void setPaymentMethodCdName(String paymentMethodCdName) {
		this.paymentMethodCdName = paymentMethodCdName;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public String getCouponNo() {
		return couponNo;
	}
	public void setCouponNo(String couponNo) {
		this.couponNo = couponNo;
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
	public BigInteger getRefundHistSeq() {
		return refundHistSeq;
	}
	public void setRefundHistSeq(BigInteger refundHistSeq) {
		this.refundHistSeq = refundHistSeq;
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
	public String getRefundDttm() {
		return refundDttm;
	}
	public void setRefundDttm(String refundDttm) {
		this.refundDttm = refundDttm;
	}
	public int getRefundAmt() {
		return refundAmt;
	}
	public void setRefundAmt(int refundAmt) {
		this.refundAmt = refundAmt;
	}
	public int getRefundComssnAmt() {
		return refundComssnAmt;
	}
	public void setRefundComssnAmt(int refundComssnAmt) {
		this.refundComssnAmt = refundComssnAmt;
	}
	public int getTotAmt() {
		return totAmt;
	}
	public void setTotAmt(int totAmt) {
		this.totAmt = totAmt;
	}
	public String getRefundReason() {
		return refundReason;
	}
	public void setRefundReason(String refundReason) {
		this.refundReason = refundReason;
	}
	public String getRefundAdminId() {
		return refundAdminId;
	}
	public void setRefundAdminId(String refundAdminId) {
		this.refundAdminId = refundAdminId;
	}
	public String getRefundAdminName() {
		return refundAdminName;
	}
	public void setRefundAdminName(String refundAdminName) {
		this.refundAdminName = refundAdminName;
	}
	public String getPagingYn() {
		return pagingYn;
	}
	public void setPagingYn(String pagingYn) {
		this.pagingYn = pagingYn;
	}
	public String getStartDttm() {
		return startDttm;
	}
	public void setStartDttm(String startDttm) {
		this.startDttm = startDttm;
	}
	public String getEndDttm() {
		return endDttm;
	}
	public void setEndDttm(String endDttm) {
		this.endDttm = endDttm;
	}
	public String getUsrMainId() {
		return usrMainId;
	}
	public void setUsrMainId(String usrMainId) {
		this.usrMainId = usrMainId;
	}
	public String getCancelDttm() {
		return cancelDttm;
	}
	public void setCancelDttm(String cancelDttm) {
		this.cancelDttm = cancelDttm;
	}
	public String getCancelReasonDesc() {
		return cancelReasonDesc;
	}
	public void setCancelReasonDesc(String cancelReasonDesc) {
		this.cancelReasonDesc = cancelReasonDesc;
	}
	public int getSearchCount() {
		return searchCount;
	}
	public void setSearchCount(int searchCount) {
		this.searchCount = searchCount;
	}
	public int getSearchTotAmt() {
		return searchTotAmt;
	}
	public void setSearchTotAmt(int searchTotAmt) {
		this.searchTotAmt = searchTotAmt;
	}
	public int getSearchRefundTotAmt() {
		return searchRefundTotAmt;
	}
	public void setSearchRefundTotAmt(int searchRefundTotAmt) {
		this.searchRefundTotAmt = searchRefundTotAmt;
	}
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public String getPaymentMethodCd() {
		return paymentMethodCd;
	}
	public void setPaymentMethodCd(String paymentMethodCd) {
		this.paymentMethodCd = paymentMethodCd;
	}
	public String getRefndAmt() {
		return refndAmt;
	}
	public void setRefndAmt(String refndAmt) {
		this.refndAmt = refndAmt;
	}
	public String getMileagePaymentAmt() {
		return mileagePaymentAmt;
	}
	public void setMileagePaymentAmt(String mileagePaymentAmt) {
		this.mileagePaymentAmt = mileagePaymentAmt;
	}
	public String getAcnutNm() {
		return acnutNm;
	}
	public void setAcnutNm(String acnutNm) {
		this.acnutNm = acnutNm;
	}
	
}
