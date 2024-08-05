package com.dkitec.barocle.admin.service.membermgmt.vo;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.util.egov.paging.VO.PagingVO;

@Alias("returnListMgmtVO")
public class ReturnListMgmtVO extends PagingVO implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 9132511254258876632L;
	
	
	private String recommend_seq;
	private String usr_id;
	private String tel_no;
	private String mileage_yn;
	private String station_nm;
	private String return_dttm;
	private String reg_dttm;
	
	private String usrSeq;
	private String usrId;
	private String recommend_station;
	private String station_max_val;
	private String return_rank;
	private String stationNm;
	private String returnDttm;
	private String mileageYn;
	
	private String searchParameter2;
	private String recommendSeq;
	
	private String searchValue;
	private String searchParameter;
	
	private String searchStartDate;
	private String searchEndDate;
	
	private String page;
	private String pageNo;
	
	//추가
	private String mileagePoint;
	private String todayAccumulateMileagePoint;
	private String dayMaxMileagePoint;
	
	
	
	public String getPageNo() {
		return pageNo;
	}
	public void setPageNo(String pageNo) {
		this.pageNo = pageNo;
	}
	public String getPage() {
		return page;
	}
	public void setPage(String page) {
		this.page = page;
	}
	public String getSearchValue() {
		return searchValue;
	}
	public void setSearchValue(String searchValue) {
		this.searchValue = searchValue;
	}
	public String getSearchParameter() {
		return searchParameter;
	}
	public void setSearchParameter(String searchParameter) {
		this.searchParameter = searchParameter;
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
	public String getRecommendSeq() {
		return recommendSeq;
	}
	public void setRecommendSeq(String recommendSeq) {
		this.recommendSeq = recommendSeq;
	}
	public String getSearchParameter2() {
		return searchParameter2;
	}
	public void setSearchParameter2(String searchParameter2) {
		this.searchParameter2 = searchParameter2;
	}
	public String getUsrSeq() {
		return usrSeq;
	}
	public void setUsrSeq(String usrSeq) {
		this.usrSeq = usrSeq;
	}
	public String getUsrId() {
		return usrId;
	}
	public void setUsrId(String usrId) {
		this.usrId = usrId;
	}
	public String getRecommend_station() {
		return recommend_station;
	}
	public void setRecommend_station(String recommend_station) {
		this.recommend_station = recommend_station;
	}
	public String getStation_max_val() {
		return station_max_val;
	}
	public void setStation_max_val(String station_max_val) {
		this.station_max_val = station_max_val;
	}
	public String getReturn_rank() {
		return return_rank;
	}
	public void setReturn_rank(String return_rank) {
		this.return_rank = return_rank;
	}
	public String getStationNm() {
		return stationNm;
	}
	public void setStationNm(String stationNm) {
		this.stationNm = stationNm;
	}
	public String getReturnDttm() {
		return returnDttm;
	}
	public void setReturnDttm(String returnDttm) {
		this.returnDttm = returnDttm;
	}
	public String getMileageYn() {
		return mileageYn;
	}
	public void setMileageYn(String mileageYn) {
		this.mileageYn = mileageYn;
	}
	public String getRecommend_seq() {
		return recommend_seq;
	}
	public void setRecommend_seq(String recommend_seq) {
		this.recommend_seq = recommend_seq;
	}
	public String getUsr_id() {
		return usr_id;
	}
	public void setUsr_id(String usr_id) {
		this.usr_id = usr_id;
	}
	public String getTel_no() {
		return tel_no;
	}
	public void setTel_no(String tel_no) {
		this.tel_no = tel_no;
	}
	public String getMileage_yn() {
		return mileage_yn;
	}
	public void setMileage_yn(String mileage_yn) {
		this.mileage_yn = mileage_yn;
	}
	public String getStation_nm() {
		return station_nm;
	}
	public void setStation_nm(String station_nm) {
		this.station_nm = station_nm;
	}
	public String getReturn_dttm() {
		return return_dttm;
	}
	public void setReturn_dttm(String return_dttm) {
		this.return_dttm = return_dttm;
	}
	public String getReg_dttm() {
		return reg_dttm;
	}
	public void setReg_dttm(String reg_dttm) {
		this.reg_dttm = reg_dttm;
	}
	public String getMileagePoint() {
		return mileagePoint;
	}
	public void setMileagePoint(String mileagePoint) {
		this.mileagePoint = mileagePoint;
	}
	public String getTodayAccumulateMileagePoint() {
		return todayAccumulateMileagePoint;
	}
	public void setTodayAccumulateMileagePoint(
			String todayAccumulateMileagePoint) {
		this.todayAccumulateMileagePoint = todayAccumulateMileagePoint;
	}
	public String getDayMaxMileagePoint() {
		return dayMaxMileagePoint;
	}
	public void setDayMaxMileagePoint(String dayMaxMileagePoint) {
		this.dayMaxMileagePoint = dayMaxMileagePoint;
	}
	@Override
	public String toString() {
		return "ReturnListMgmtVO [recommend_seq=" + recommend_seq + ", usr_id="
				+ usr_id + ", tel_no=" + tel_no + ", mileage_yn=" + mileage_yn
				+ ", station_nm=" + station_nm + ", return_dttm=" + return_dttm
				+ ", reg_dttm=" + reg_dttm + ", usrId=" + usrId
				+ ", recommend_station=" + recommend_station
				+ ", station_max_val=" + station_max_val + ", return_rank="
				+ return_rank + ", stationNm=" + stationNm + ", returnDttm="
				+ returnDttm + ", mileageYn=" + mileageYn + ", mileagePoint=" + mileagePoint + ", todayAccumulateMileagePoint=" + todayAccumulateMileagePoint + ", dayMaxMileagePoint=" + dayMaxMileagePoint
				+ ", searchParameter2=" + searchParameter2 + ", recommendSeq="
				+ recommendSeq + ", searchValue=" + searchValue
				+ ", searchParameter=" + searchParameter + ", searchStartDate="
				+ searchStartDate + ", searchEndDate=" + searchEndDate + "]";
	}
	
	
	
	
}
