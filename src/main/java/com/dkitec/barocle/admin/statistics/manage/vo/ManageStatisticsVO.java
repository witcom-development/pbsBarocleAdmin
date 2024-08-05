package com.dkitec.barocle.admin.statistics.manage.vo;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.admin.manage.deviceMgmt.CommonVo;

@SuppressWarnings("serial")
@Alias("manageStatisticsVo")
public class ManageStatisticsVO extends CommonVo implements Serializable {
	private String dateType;
	private String searchBgnMt;
	private String searchEndMt;
	private String usrType;
	private String payAmt;
	private String sexCd;
	private String totCnt;
	private String useCnt;
	private String moveDist;
	private String useMi;
	private String useCnt00;
	private String useCnt01;
	private String useCnt02;
	private String useCnt03;
	private String useCnt04;
	private String useCnt05;
	private String useCnt06;
	private String useCnt07;
	private String useCnt08;
	private String useCnt09;
	private String useCnt10;
	private String useCnt11;
	private String useCnt12;
	private String useCnt13;
	private String useCnt14;
	private String useCnt15;
	private String useCnt16;
	private String useCnt17;
	private String useCnt18;
	private String useCnt19;
	private String useCnt20;
	private String useCnt21;
	private String useCnt22;
	private String useCnt23;
	private String useCntTotal;
	private String stationId;
	private String stationGrpName;
	private String stationName;
	private String rentCnt;
	private String returnCnt;
	
	private String bikeDt;		//자전거 운영현황(날짜)_cms_20161129
	private String bikeCnt;		//자전거 운영현황(운영자전거 카운팅)_cms_20161129
	
	private String days;		// 자전거 배터리 정보_조회기간_20170111_cms
	private String years;		// 자전거 배터리 정보_년도조회_20170111_cms
	private String bikeNo;		// 자전거 번호 _20170113_cms
	
	//시민의견
	private String opinionCnt;	//신규등록 개수
	private String processCnt;	//처리 개수
	private String opinionMCnt; //신규등록 월계
	private String processMCnt;	//처리 개수 월계
	
	public String getDays() {
		return days;
	}
	public void setDays(String days) {
		this.days = days;
	}
	public String getYears() {
		return years;
	}
	public void setYears(String years) {
		this.years = years;
	}
	public String getBikeNo() {
		return bikeNo;
	}
	public void setBikeNo(String bikeNo) {
		this.bikeNo = bikeNo;
	}
	public String getBikeDt() {
		return bikeDt;
	}
	public void setBikeDt(String bikeDt) {
		this.bikeDt = bikeDt;
	}
	public String getBikeCnt() {
		return bikeCnt;
	}
	public void setBikeCnt(String bikeCnt) {
		this.bikeCnt = bikeCnt;
	}
	public String getDateType() {
		return dateType;
	}
	public void setDateType(String dateType) {
		this.dateType = dateType;
	}
	public String getSearchBgnMt() {
		return searchBgnMt;
	}
	public void setSearchBgnMt(String searchBgnMt) {
		this.searchBgnMt = searchBgnMt;
	}
	public String getSearchEndMt() {
		return searchEndMt;
	}
	public void setSearchEndMt(String searchEndMt) {
		this.searchEndMt = searchEndMt;
	}
	public String getUsrType() {
		return usrType;
	}
	public void setUsrType(String usrType) {
		this.usrType = usrType;
	}
	public String getPayAmt() {
		return payAmt;
	}
	public void setPayAmt(String payAmt) {
		this.payAmt = payAmt;
	}
	public String getSexCd() {
		return sexCd;
	}
	public void setSexCd(String sexCd) {
		this.sexCd = sexCd;
	}
	public String getTotCnt() {
		return totCnt;
	}
	public void setTotCnt(String totCnt) {
		this.totCnt = totCnt;
	}
	public String getUseCnt() {
		return useCnt;
	}
	public void setUseCnt(String useCnt) {
		this.useCnt = useCnt;
	}
	public String getMoveDist() {
		return moveDist;
	}
	public void setMoveDist(String moveDist) {
		this.moveDist = moveDist;
	}
	public String getUseMi() {
		return useMi;
	}
	public void setUseMi(String useMi) {
		this.useMi = useMi;
	}
	public String getUseCnt00() {
		return useCnt00;
	}
	public void setUseCnt00(String useCnt00) {
		this.useCnt00 = useCnt00;
	}
	public String getUseCnt01() {
		return useCnt01;
	}
	public void setUseCnt01(String useCnt01) {
		this.useCnt01 = useCnt01;
	}
	public String getUseCnt02() {
		return useCnt02;
	}
	public void setUseCnt02(String useCnt02) {
		this.useCnt02 = useCnt02;
	}
	public String getUseCnt03() {
		return useCnt03;
	}
	public void setUseCnt03(String useCnt03) {
		this.useCnt03 = useCnt03;
	}
	public String getUseCnt04() {
		return useCnt04;
	}
	public void setUseCnt04(String useCnt04) {
		this.useCnt04 = useCnt04;
	}
	public String getUseCnt05() {
		return useCnt05;
	}
	public void setUseCnt05(String useCnt05) {
		this.useCnt05 = useCnt05;
	}
	public String getUseCnt06() {
		return useCnt06;
	}
	public void setUseCnt06(String useCnt06) {
		this.useCnt06 = useCnt06;
	}
	public String getUseCnt07() {
		return useCnt07;
	}
	public void setUseCnt07(String useCnt07) {
		this.useCnt07 = useCnt07;
	}
	public String getUseCnt08() {
		return useCnt08;
	}
	public void setUseCnt08(String useCnt08) {
		this.useCnt08 = useCnt08;
	}
	public String getUseCnt09() {
		return useCnt09;
	}
	public void setUseCnt09(String useCnt09) {
		this.useCnt09 = useCnt09;
	}
	public String getUseCnt10() {
		return useCnt10;
	}
	public void setUseCnt10(String useCnt10) {
		this.useCnt10 = useCnt10;
	}
	public String getUseCnt11() {
		return useCnt11;
	}
	public void setUseCnt11(String useCnt11) {
		this.useCnt11 = useCnt11;
	}
	public String getUseCnt12() {
		return useCnt12;
	}
	public void setUseCnt12(String useCnt12) {
		this.useCnt12 = useCnt12;
	}
	public String getUseCnt13() {
		return useCnt13;
	}
	public void setUseCnt13(String useCnt13) {
		this.useCnt13 = useCnt13;
	}
	public String getUseCnt14() {
		return useCnt14;
	}
	public void setUseCnt14(String useCnt14) {
		this.useCnt14 = useCnt14;
	}
	public String getUseCnt15() {
		return useCnt15;
	}
	public void setUseCnt15(String useCnt15) {
		this.useCnt15 = useCnt15;
	}
	public String getUseCnt16() {
		return useCnt16;
	}
	public void setUseCnt16(String useCnt16) {
		this.useCnt16 = useCnt16;
	}
	public String getUseCnt17() {
		return useCnt17;
	}
	public void setUseCnt17(String useCnt17) {
		this.useCnt17 = useCnt17;
	}
	public String getUseCnt18() {
		return useCnt18;
	}
	public void setUseCnt18(String useCnt18) {
		this.useCnt18 = useCnt18;
	}
	public String getUseCnt19() {
		return useCnt19;
	}
	public void setUseCnt19(String useCnt19) {
		this.useCnt19 = useCnt19;
	}
	public String getUseCnt20() {
		return useCnt20;
	}
	public void setUseCnt20(String useCnt20) {
		this.useCnt20 = useCnt20;
	}
	public String getUseCnt21() {
		return useCnt21;
	}
	public void setUseCnt21(String useCnt21) {
		this.useCnt21 = useCnt21;
	}
	public String getUseCnt22() {
		return useCnt22;
	}
	public void setUseCnt22(String useCnt22) {
		this.useCnt22 = useCnt22;
	}
	public String getUseCnt23() {
		return useCnt23;
	}
	public void setUseCnt23(String useCnt23) {
		this.useCnt23 = useCnt23;
	}
	public String getUseCntTotal() {
		return useCntTotal;
	}
	public void setUseCntTotal(String useCntTotal) {
		this.useCntTotal = useCntTotal;
	}
	public String getStationId() {
		return stationId;
	}
	public void setStationId(String stationId) {
		this.stationId = stationId;
	}
	public String getStationGrpName() {
		return stationGrpName;
	}
	public void setStationGrpName(String stationGrpName) {
		this.stationGrpName = stationGrpName;
	}
	public String getStationName() {
		return stationName;
	}
	public void setStationName(String stationName) {
		this.stationName = stationName;
	}
	public String getRentCnt() {
		return rentCnt;
	}
	public void setRentCnt(String rentCnt) {
		this.rentCnt = rentCnt;
	}
	public String getReturnCnt() {
		return returnCnt;
	}
	public void setReturnCnt(String returnCnt) {
		this.returnCnt = returnCnt;
	}
	public String getOpinionCnt() {
		return opinionCnt;
	}
	public void setOpinionCnt(String opinionCnt) {
		this.opinionCnt = opinionCnt;
	}
	public String getProcessCnt() {
		return processCnt;
	}
	public void setProcessCnt(String processCnt) {
		this.processCnt = processCnt;
	}
	public String getOpinionMCnt() {
		return opinionMCnt;
	}
	public void setOpinionMCnt(String opinionMCnt) {
		this.opinionMCnt = opinionMCnt;
	}
	public String getProcessMCnt() {
		return processMCnt;
	}
	public void setProcessMCnt(String processMCnt) {
		this.processMCnt = processMCnt;
	}
}
