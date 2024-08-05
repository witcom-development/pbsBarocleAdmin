package com.dkitec.barocle.admin.service.paymentmgmt.overpayment.vo;

import java.io.Serializable;
import java.math.BigInteger;

import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.apache.ibatis.type.Alias;
import org.springframework.web.multipart.MultipartFile;

import com.dkitec.barocle.base.IConstants;
import com.dkitec.barocle.util.egov.paging.VO.PagingVO;

@Alias("overPaymentVO")
public class OverPaymentVO extends PagingVO implements Serializable {

	static final long serialVersionUID = 4248341030462539893L;
	
	private String lang = IConstants.LANG_KR;
	private String excelFlg;
	private MultipartFile bulkFile;
	private String viewFlg = IConstants.MODE_LIST;
	
	private String usrMpnNo;
	private String mbId;
	private String usrMainId;
	private String rentStationId;
	private String rentStationName;
	private String returnStationId;
	private String returnStationName;
	private int useMi;
	private BigInteger rentHistSeq;
	private String rentDttm;
	private int overMi;
	private int overFee;
	private BigInteger paymentSeq;
	private String paymentDttm;
	@Size(max=10, message="상태코드 형식이 아닙니다.")
	@Pattern(regexp="^[A-Z]*_[0-9]{3}$" , message="공통코드 형식이 아닙니다.")
	private String overFeeProcessClsCd;
	private String overFeeProcessClsCdName;
	private int paymentAttCnt;
	private String processReasonDesc;
	@Size(max=10, message="상태코드 형식이 아닙니다.")
	@Pattern(regexp="^[A-Z]*_[0-9]{3}$" , message="공통코드 형식이 아닙니다.")
	private String paymentClsCd;
	private String paymentClsCdName;
	@Size(max=10, message="상태코드 형식이 아닙니다.")
	@Pattern(regexp="^[A-Z]*_[0-9]{3}$" , message="공통코드 형식이 아닙니다.")
	private String paymentMethodCd;
	private String paymentMethodCdName;
	private String returnDttm;
	private String rentBikeId;
	
	/** 페이징 여부 */
    @Pattern(regexp="Y|N" , message="잘못된 형식입니다.")
	private String pagingYn;
	private String startPaymentDttm;
	private String endPaymentDttm;
	private String usrSearchType;
	private String usrSearchKey;
	private String mb_id_excel;
	
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
	public String getUsrMainId() {
		return usrMainId;
	}
	public void setUsrMainId(String usrMainId) {
		this.usrMainId = usrMainId;
	}
	public String getRentStationId() {
		return rentStationId;
	}
	public void setRentStationId(String rentStationId) {
		this.rentStationId = rentStationId;
	}
	public String getRentStationName() {
		return rentStationName;
	}
	public void setRentStationName(String rentStationName) {
		this.rentStationName = rentStationName;
	}
	public String getReturnStationId() {
		return returnStationId;
	}
	public void setReturnStationId(String returnStationId) {
		this.returnStationId = returnStationId;
	}
	public String getReturnStationName() {
		return returnStationName;
	}
	public void setReturnStationName(String returnStationName) {
		this.returnStationName = returnStationName;
	}
	public int getUseMi() {
		return useMi;
	}
	public void setUseMi(int useMi) {
		this.useMi = useMi;
	}
	public BigInteger getRentHistSeq() {
		return rentHistSeq;
	}
	public void setRentHistSeq(BigInteger rentHistSeq) {
		this.rentHistSeq = rentHistSeq;
	}
	public String getRentDttm() {
		return rentDttm;
	}
	public void setRentDttm(String rentDttm) {
		this.rentDttm = rentDttm;
	}
	public int getOverMi() {
		return overMi;
	}
	public void setOverMi(int overMi) {
		this.overMi = overMi;
	}
	public int getOverFee() {
		return overFee;
	}
	public void setOverFee(int overFee) {
		this.overFee = overFee;
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
	public String getOverFeeProcessClsCd() {
		return overFeeProcessClsCd;
	}
	public void setOverFeeProcessClsCd(String overFeeProcessClsCd) {
		this.overFeeProcessClsCd = overFeeProcessClsCd;
	}
	public String getOverFeeProcessClsCdName() {
		return overFeeProcessClsCdName;
	}
	public void setOverFeeProcessClsCdName(String overFeeProcessClsCdName) {
		this.overFeeProcessClsCdName = overFeeProcessClsCdName;
	}
	public int getPaymentAttCnt() {
		return paymentAttCnt;
	}
	public void setPaymentAttCnt(int paymentAttCnt) {
		this.paymentAttCnt = paymentAttCnt;
	}
	public String getProcessReasonDesc() {
		return processReasonDesc;
	}
	public void setProcessReasonDesc(String processReasonDesc) {
		this.processReasonDesc = processReasonDesc;
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
	public String getUsrSearchType() {
		return usrSearchType;
	}
	public void setUsrSearchType(String usrSearchType) {
		this.usrSearchType = usrSearchType;
	}
	public String getUsrSearchKey() {
		return usrSearchKey;
	}
	public void setUsrSearchKey(String usrSearchKey) {
		this.usrSearchKey = usrSearchKey;
	}
	public String getReturnDttm() {
		return returnDttm;
	}
	public void setReturnDttm(String returnDttm) {
		this.returnDttm = returnDttm;
	}
	public String getRentBikeId() {
		return rentBikeId;
	}
	public void setRentBikeId(String rentBikeId) {
		this.rentBikeId = rentBikeId;
	}
}
