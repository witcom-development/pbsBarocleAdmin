package com.dkitec.barocle.admin.service.paymentmgmt.reduction.vo;

import java.io.Serializable;
import java.math.BigInteger;

import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.apache.ibatis.type.Alias;
import org.springframework.web.multipart.MultipartFile;

import com.dkitec.barocle.base.IConstants;
import com.dkitec.barocle.util.egov.paging.VO.PagingVO;

@Alias("reductionVO")
public class ReductionVO extends PagingVO implements Serializable {

	static final long serialVersionUID = 4248341030462539893L;
	
	private String lang = IConstants.LANG_KR;
	
	private String viewFlg = IConstants.MODE_LIST;
	
	private String reductionHistSeq;
	private String transactionUniqueId;
	@Size(max=10, message="상태코드 형식이 아닙니다.")
	@Pattern(regexp="^[A-Z]*_[0-9]{3}$" , message="공통코드 형식이 아닙니다.")
	private String reductionType;
	
	private BigInteger usrSeq;
	private String tgtrRrn;
	private String tgtrNm;
	private String fctYn;
	private String oprnYn;
	private String cnt;
	private String resultYn;
	private String regDttm;
	
	private String startReductionDttm;
	private String endReductionDttm;
	
	private String usrSearchKey;
	private String usrSearchType;
	
	/** 페이징 여부 */
    @Pattern(regexp="Y|N" , message="잘못된 형식입니다.")
	private String pagingYn;


	public String getLang() {
		return lang;
	}


	public void setLang(String lang) {
		this.lang = lang;
	}


	public String getViewFlg() {
		return viewFlg;
	}


	public void setViewFlg(String viewFlg) {
		this.viewFlg = viewFlg;
	}


	public String getReductionHistSeq() {
		return reductionHistSeq;
	}


	public void setReductionHistSeq(String reductionHistSeq) {
		this.reductionHistSeq = reductionHistSeq;
	}


	public String getTransactionUniqueId() {
		return transactionUniqueId;
	}


	public void setTransactionUniqueId(String transactionUniqueId) {
		this.transactionUniqueId = transactionUniqueId;
	}


	public String getReductionType() {
		return reductionType;
	}


	public void setReductionType(String reductionType) {
		this.reductionType = reductionType;
	}


	public BigInteger getUsrSeq() {
		return usrSeq;
	}


	public void setUsrSeq(BigInteger usrSeq) {
		this.usrSeq = usrSeq;
	}


	public String getTgtrRrn() {
		return tgtrRrn;
	}


	public void setTgtrRrn(String tgtrRrn) {
		this.tgtrRrn = tgtrRrn;
	}


	public String getTgtrNm() {
		return tgtrNm;
	}


	public void setTgtrNm(String tgtrNm) {
		this.tgtrNm = tgtrNm;
	}


	public String getFctYn() {
		return fctYn;
	}


	public void setFctYn(String fctYn) {
		this.fctYn = fctYn;
	}


	public String getOprnYn() {
		return oprnYn;
	}


	public void setOprnYn(String oprnYn) {
		this.oprnYn = oprnYn;
	}


	public String getCnt() {
		return cnt;
	}


	public void setCnt(String cnt) {
		this.cnt = cnt;
	}


	public String getResultYn() {
		return resultYn;
	}


	public void setResultYn(String resultYn) {
		this.resultYn = resultYn;
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


	public String getStartReductionDttm() {
		return startReductionDttm;
	}


	public void setStartReductionDttm(String startReductionDttm) {
		this.startReductionDttm = startReductionDttm;
	}


	public String getEndReductionDttm() {
		return endReductionDttm;
	}


	public void setEndReductionDttm(String endReductionDttm) {
		this.endReductionDttm = endReductionDttm;
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
