package com.dkitec.barocle.admin.service.paymentmgmt.nonpayment.vo;

import java.io.Serializable;
import java.math.BigInteger;
import java.util.List;

import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.apache.ibatis.type.Alias;
import org.springframework.web.multipart.MultipartFile;

import com.dkitec.barocle.base.IConstants;
import com.dkitec.barocle.util.egov.paging.VO.PagingVO;

@Alias("nonPaymentVO")
public class NonPaymentVO extends PagingVO implements Serializable {

	static final long serialVersionUID = -2256194743310628602L;
	
	private String lang = IConstants.LANG_KR;
	private String excelFlg;
	private MultipartFile bulkFile;
	private String viewFlg = IConstants.MODE_LIST;
	
	private BigInteger usrSeq;
	private String usrMainId;
	@Size(max=10, message="상태코드 형식이 아닙니다.")
	@Pattern(regexp="^[A-Z]*_[0-9]{3}$" , message="공통코드 형식이 아닙니다.")
	private String usrClsCd;
	private String usrClsCdName;
	private String rentStationId;
	private String rentStationName;
	private String returnStationId;
	private String returnStationName;
	private String useMi;
	private BigInteger rentHistSeq;
	private String rentDttm;
	private String returnDttm;
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
	private String paymentMethodCd;
	private String paymentMethodCdName;
	private String rentBikeId;
	
	private String stationGrpSeq;
	private String stationGrpName;
	private String stationId;
	private String stationName;
	private List<String> stationIdList;
	private List<NonPaymentVO> nonPayList;
	private String adminId;
	private String mb_id_excel;
	
	/** 페이징 여부 */
    @Pattern(regexp="Y|N" , message="잘못된 형식입니다.")
	private String pagingYn;
	private String startDttm;
	private String endDttm;
	private String usrSearchKey;
	private String usrSearchType;
	
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
	public BigInteger getUsrSeq() {
		return usrSeq;
	}
	public void setUsrSeq(BigInteger usrSeq) {
		this.usrSeq = usrSeq;
	}
	public String getUsrMainId() {
		return usrMainId;
	}
	public void setUsrMainId(String usrMainId) {
		this.usrMainId = usrMainId;
	}
	public String getUsrClsCd() {
		return usrClsCd;
	}
	public void setUsrClsCd(String usrClsCd) {
		this.usrClsCd = usrClsCd;
	}
	public String getUsrClsCdName() {
		return usrClsCdName;
	}
	public void setUsrClsCdName(String usrClsCdName) {
		this.usrClsCdName = usrClsCdName;
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
	public String getUseMi() {
		return useMi;
	}
	public void setUseMi(String useMi) {
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
	public String getReturnDttm() {
		return returnDttm;
	}
	public void setReturnDttm(String returnDttm) {
		this.returnDttm = returnDttm;
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
	public String getStationGrpSeq() {
		return stationGrpSeq;
	}
	public void setStationGrpSeq(String stationGrpSeq) {
		this.stationGrpSeq = stationGrpSeq;
	}
	public String getStationGrpName() {
		return stationGrpName;
	}
	public void setStationGrpName(String stationGrpName) {
		this.stationGrpName = stationGrpName;
	}
	public String getStationId() {
		return stationId;
	}
	public void setStationId(String stationId) {
		this.stationId = stationId;
	}
	public String getStationName() {
		return stationName;
	}
	public void setStationName(String stationName) {
		this.stationName = stationName;
	}
	public List<String> getStationIdList() {
		return stationIdList;
	}
	public void setStationIdList(List<String> stationIdList) {
		this.stationIdList = stationIdList;
	}
	public List<NonPaymentVO> getNonPayList() {
		return nonPayList;
	}
	public void setNonPayList(List<NonPaymentVO> nonPayList) {
		this.nonPayList = nonPayList;
	}
	public String getAdminId() {
		return adminId;
	}
	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}
	public String getRentBikeId() {
		return rentBikeId;
	}
	public void setRentBikeId(String rentBikeId) {
		this.rentBikeId = rentBikeId;
	}
	public String getUsrSearchKey() {
		return usrSearchKey;
	}
	public void setUsrSearchKey(String usrSearchKey) {
		this.usrSearchKey = usrSearchKey;
	}
	public String getUsrSearchType() {
		return usrSearchType;
	}
	public void setUsrSearchType(String usrSearchType) {
		this.usrSearchType = usrSearchType;
	}
	
}
