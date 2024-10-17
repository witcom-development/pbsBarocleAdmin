package com.dkitec.barocle.admin.service.paymentmgmt.failpayment.vo;

import java.io.Serializable;
import java.math.BigInteger;

import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.apache.ibatis.type.Alias;
import org.springframework.web.multipart.MultipartFile;

import com.dkitec.barocle.base.IConstants;
import com.dkitec.barocle.util.egov.paging.VO.PagingVO;

@Alias("failPaymentVO")
public class FailPaymentVO extends PagingVO implements Serializable {

	static final long serialVersionUID = 5291079674660901318L;
	
	private String lang = IConstants.LANG_KR;
	private String excelFlg;
	private MultipartFile bulkFile;
	private String viewFlg = IConstants.MODE_LIST;
	
	private BigInteger paymentFailHistSeq;
	private BigInteger usrSeq;
	private String rentDttm;
	private BigInteger rentHistSeq;
	private String paymentDttm;
	@Size(max=10, message="상태코드 형식이 아닙니다.")
	@Pattern(regexp="^[A-Z]*_[0-9]{3}$" , message="공통코드 형식이 아닙니다.")
	private String paymentMethodCd;
	private String paymentMethodCdName;
	@Size(max=10, message="상태코드 형식이 아닙니다.")
	@Pattern(regexp="^[A-Z]*_[0-9]{3}$" , message="공통코드 형식이 아닙니다.")
	private String paymentClsCd;
	private String paymentClsCdName;
	private String cardNo;
	private String mpnNo;
	@Size(max=10, message="상태코드 형식이 아닙니다.")
	@Pattern(regexp="^[A-Z]*_[0-9]{3}$" , message="공통코드 형식이 아닙니다.")
	private String telecomClsCd;
	private String telecomClsCdName;
	private int paymentAmt;
	private String errCd;
	private String errMsg;
	private String clientInfo;
	private String threadName;
	private String processYn;
	private String svcTypeCd;
	private String birthDate;
	private String sexCd;
	private String regDttm;
	
	/** 페이징 여부 */
    @Pattern(regexp="Y|N" , message="잘못된 형식입니다.")
	private String pagingYn;
	private String startPaymentDttm;
	private String endPaymentDttm;
	
	public BigInteger getUsrSeq() {
		return usrSeq;
	}
	public void setUsrSeq(BigInteger usrSeq) {
		this.usrSeq = usrSeq;
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
	public BigInteger getPaymentFailHistSeq() {
		return paymentFailHistSeq;
	}
	public void setPaymentFailHistSeq(BigInteger paymentFailHistSeq) {
		this.paymentFailHistSeq = paymentFailHistSeq;
	}
	public String getRentDttm() {
		return rentDttm;
	}
	public void setRentDttm(String rentDttm) {
		this.rentDttm = rentDttm;
	}
	public BigInteger getRentHistSeq() {
		return rentHistSeq;
	}
	public void setRentHistSeq(BigInteger rentHistSeq) {
		this.rentHistSeq = rentHistSeq;
	}
	public String getPaymentDttm() {
		return paymentDttm;
	}
	public void setPaymentDttm(String paymentDttm) {
		this.paymentDttm = paymentDttm;
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
	public String getCardNo() {
		return cardNo;
	}
	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}
	public String getMpnNo() {
		return mpnNo;
	}
	public void setMpnNo(String mpnNo) {
		this.mpnNo = mpnNo;
	}
	public String getTelecomClsCd() {
		return telecomClsCd;
	}
	public void setTelecomClsCd(String telecomClsCd) {
		this.telecomClsCd = telecomClsCd;
	}
	public String getTelecomClsCdName() {
		return telecomClsCdName;
	}
	public void setTelecomClsCdName(String telecomClsCdName) {
		this.telecomClsCdName = telecomClsCdName;
	}
	public int getPaymentAmt() {
		return paymentAmt;
	}
	public void setPaymentAmt(int paymentAmt) {
		this.paymentAmt = paymentAmt;
	}
	public String getErrCd() {
		return errCd;
	}
	public void setErrCd(String errCd) {
		this.errCd = errCd;
	}
	public String getErrMsg() {
		return errMsg;
	}
	public void setErrMsg(String errMsg) {
		this.errMsg = errMsg;
	}
	public String getClientInfo() {
		return clientInfo;
	}
	public void setClientInfo(String clientInfo) {
		this.clientInfo = clientInfo;
	}
	public String getThreadName() {
		return threadName;
	}
	public void setThreadName(String threadName) {
		this.threadName = threadName;
	}
	public String getProcessYn() {
		return processYn;
	}
	public void setProcessYn(String processYn) {
		this.processYn = processYn;
	}
	public String getSvcTypeCd() {
		return svcTypeCd;
	}
	public void setSvcTypeCd(String svcTypeCd) {
		this.svcTypeCd = svcTypeCd;
	}
	public String getBirthDate() {
		return birthDate;
	}
	public void setBirthDate(String birthDate) {
		this.birthDate = birthDate;
	}
	public String getSexCd() {
		return sexCd;
	}
	public void setSexCd(String sexCd) {
		this.sexCd = sexCd;
	}
	public String getRegDttm() {
		return regDttm;
	}
	public void setRegDttm(String regDttm) {
		this.regDttm = regDttm;
	}
	public String getPagingYn() {
		return pagingYn;
	}
	public void setPagingYn(String pagingYn) {
		this.pagingYn = pagingYn;
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
}
