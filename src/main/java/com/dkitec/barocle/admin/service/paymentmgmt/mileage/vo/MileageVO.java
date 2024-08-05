package com.dkitec.barocle.admin.service.paymentmgmt.mileage.vo;

import java.io.Serializable;
import java.math.BigInteger;

import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.apache.ibatis.type.Alias;
import org.springframework.web.multipart.MultipartFile;

import com.dkitec.barocle.base.IConstants;
import com.dkitec.barocle.util.egov.paging.VO.PagingVO;

@Alias("mileageVO")
public class MileageVO extends PagingVO implements Serializable {

	static final long serialVersionUID = -6748447875196694939L;
	
	private String lang = IConstants.LANG_KR;
	private String viewFlg = IConstants.MODE_LIST;
	
	private String regDttm;
	private String usrSeq;
	private String userId;
	private String mileageClsCd;
	private String mileagePoint;
	private String searchStrDate;
	private String searchEndDate;
    private String rentDttm;
    private String viewType;
    private String mbCardSeq;
    
	public String getRentDttm() {
		return rentDttm;
	}

	public void setRentDttm(String rentDttm) {
		this.rentDttm = rentDttm;
	}

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
	
	public String getRegDttm() {
		return regDttm;
	}

	public void setRegDttm(String regDttm) {
		this.regDttm = regDttm;
	}

	public String getUsrSeq() {
		return usrSeq;
	}

	public void setUsrSeq(String usrSeq) {
		this.usrSeq = usrSeq;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getMileageClsCd() {
		return mileageClsCd;
	}

	public void setMileageClsCd(String mileageClsCd) {
		this.mileageClsCd = mileageClsCd;
	}

	public String getMileagePoint() {
		return mileagePoint;
	}

	public void setMileagePoint(String mileagePoint) {
		this.mileagePoint = mileagePoint;
	}

	public String getPagingYn() {
		return pagingYn;
	}

	public void setPagingYn(String pagingYn) {
		this.pagingYn = pagingYn;
	}

	public String getSearchStrDate() {
		return searchStrDate;
	}

	public void setSearchStrDate(String searchStrDate) {
		this.searchStrDate = searchStrDate;
	}

	public String getSearchEndDate() {
		return searchEndDate;
	}

	public void setSearchEndDate(String searchEndDate) {
		this.searchEndDate = searchEndDate;
	}

	public String getViewType() {
		return viewType;
	}

	public void setViewType(String viewType) {
		this.viewType = viewType;
	}

	public String getMbCardSeq() {
		return mbCardSeq;
	}

	public void setMbCardSeq(String mbCardSeq) {
		this.mbCardSeq = mbCardSeq;
	}
	
	
}
