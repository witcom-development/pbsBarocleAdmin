package com.dkitec.barocle.admin.system.savecarbon.vo;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.util.egov.paging.VO.PagingVO;

@Alias("saveCarbonVO")
public class SaveCarbonVO extends PagingVO implements java.io.Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -412046520796664131L;
	
	private String searchStartDate;
	private String searchEndDate;
	private String searchParameter;
	private String searchValue;
	private String usr_seq;
	private String rent_hist_seq;
	private String save_carbon_yn;
	private String mileage_reg_yn;
	private String reg_dttm;
	private String mb_id;
	private String reduce_co2;
	private String use_mi;
	private String req_reduce_carbon_dttm;
	
	private String goalCd;		//이용목적 com_cd _20170109_cms
	private String goalNm;		//이용목적 CD_DESC1 _20170109_cms
	private String meansCd;		//이용수단 com_cd _20170109_cms
	private String meansNm;		//이용수단 CD_DESC1 _20170109_cms
	
	private String carbon_seq;	//절감탄소 seq
	
	private String usingPurpose;
	private String usingMeans;
	private String regDttm;
	
	
	
	public String getCarbon_seq() {
		return carbon_seq;
	}
	public void setCarbon_seq(String carbon_seq) {
		this.carbon_seq = carbon_seq;
	}
	public String getUsingPurpose() {
		return usingPurpose;
	}
	public void setUsingPurpose(String usingPurpose) {
		this.usingPurpose = usingPurpose;
	}
	public String getUsingMeans() {
		return usingMeans;
	}
	public void setUsingMeans(String usingMeans) {
		this.usingMeans = usingMeans;
	}
	public String getRegDttm() {
		return regDttm;
	}
	public void setRegDttm(String regDttm) {
		this.regDttm = regDttm;
	}
	public String getGoalCd() {
		return goalCd;
	}
	public void setGoalCd(String goalCd) {
		this.goalCd = goalCd;
	}
	public String getGoalNm() {
		return goalNm;
	}
	public void setGoalNm(String goalNm) {
		this.goalNm = goalNm;
	}
	public String getMeansCd() {
		return meansCd;
	}
	public void setMeansCd(String meansCd) {
		this.meansCd = meansCd;
	}
	public String getMeansNm() {
		return meansNm;
	}
	public void setMeansNm(String meansNm) {
		this.meansNm = meansNm;
	}
	public String getSearchStartDate() {
		return searchStartDate;
	}
	public void setSearchStartDate(String searchStartDate) {
		this.searchStartDate = searchStartDate;
	}
	public String getSearchEndDate() {
		return searchEndDate;
	}
	public void setSearchEndDate(String searchEndDate) {
		this.searchEndDate = searchEndDate;
	}
	public String getSearchParameter() {
		return searchParameter;
	}
	public void setSearchParameter(String searchParameter) {
		this.searchParameter = searchParameter;
	}
	public String getSearchValue() {
		return searchValue;
	}
	public void setSearchValue(String searchValue) {
		this.searchValue = searchValue;
	}
	public String getUsr_seq() {
		return usr_seq;
	}
	public void setUsr_seq(String usr_seq) {
		this.usr_seq = usr_seq;
	}
	public String getRent_hist_seq() {
		return rent_hist_seq;
	}
	public void setRent_hist_seq(String rent_hist_seq) {
		this.rent_hist_seq = rent_hist_seq;
	}
	public String getSave_carbon_yn() {
		return save_carbon_yn;
	}
	public void setSave_carbon_yn(String save_carbon_yn) {
		this.save_carbon_yn = save_carbon_yn;
	}
	public String getMileage_reg_yn() {
		return mileage_reg_yn;
	}
	public void setMileage_reg_yn(String mileage_reg_yn) {
		this.mileage_reg_yn = mileage_reg_yn;
	}
	public String getReg_dttm() {
		return reg_dttm;
	}
	public void setReg_dttm(String reg_dttm) {
		this.reg_dttm = reg_dttm;
	}
	public String getMb_id() {
		return mb_id;
	}
	public void setMb_id(String mb_id) {
		this.mb_id = mb_id;
	}
	public String getReduce_co2() {
		return reduce_co2;
	}
	public void setReduce_co2(String reduce_co2) {
		this.reduce_co2 = reduce_co2;
	}	
	public String getUse_mi() {
		return use_mi;
	}
	public void setUse_mi(String use_mi) {
		this.use_mi = use_mi;
	}
	public String getReq_reduce_carbon_dttm() {
		return req_reduce_carbon_dttm;
	}
	public void setReq_reduce_carbon_dttm(String req_reduce_carbon_dttm) {
		this.req_reduce_carbon_dttm = req_reduce_carbon_dttm;
	}
	
	@Override
	public String toString() {
		return "SaveCarbonVO [searchStartDate=" + searchStartDate
				+ ", searchEndDate=" + searchEndDate + ", searchParameter="
				+ searchParameter + ", searchValue=" + searchValue
				+ ", usr_seq=" + usr_seq + ", rent_hist_seq=" + rent_hist_seq
				+ ", save_carbon_yn=" + save_carbon_yn + ", mileage_reg_yn="
				+ mileage_reg_yn + ", reg_dttm=" + reg_dttm + ", mb_id="
				+ mb_id + ", reduce_co2=" + reduce_co2 + ", use_mi=" + use_mi
				+ ", req_reduce_carbon_dttm=" + req_reduce_carbon_dttm
				+ ", goalCd=" + goalCd + ", goalNm=" + goalNm + ", meansCd="
				+ meansCd + ", meansNm=" + meansNm + ", usingPurpose="
				+ usingPurpose + ", usingMeans=" + usingMeans + ", regDttm="
				+ regDttm + "]";
	}

}
