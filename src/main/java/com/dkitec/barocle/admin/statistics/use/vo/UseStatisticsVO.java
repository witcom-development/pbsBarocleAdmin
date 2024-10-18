package com.dkitec.barocle.admin.statistics.use.vo;

import java.io.Serializable;
import java.util.ArrayList;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.admin.manage.deviceMgmt.CommonVo;

@SuppressWarnings("serial")
@Alias("useStatisticsVo")
public class UseStatisticsVO extends CommonVo implements Serializable {
	
	
	public String getBikeType() {
		return bikeType;
	}
	public void setBikeType(String bikeType) {
		this.bikeType = bikeType;
	}
	public String getSexCd() {
		return sexCd;
	}
	public void setSexCd(String sexCd) {
		this.sexCd = sexCd;
	}
	 
	public int getAge1() {
		return age1;
	}
	public void setAge1(int age1) {
		this.age1 = age1;
	}
	public int getAge2() {
		return age2;
	}
	public void setAge2(int age2) {
		this.age2 = age2;
	}
	public int getAge3() {
		return age3;
	}
	public void setAge3(int age3) {
		this.age3 = age3;
	}
	public int getAge4() {
		return age4;
	}
	public void setAge4(int age4) {
		this.age4 = age4;
	}
	public int getAge5() {
		return age5;
	}
	public void setAge5(int age5) {
		this.age5 = age5;
	}
	public int getAge6() {
		return age6;
	}
	public void setAge6(int age6) {
		this.age6 = age6;
	}
	public int getAge7() {
		return age7;
	}
	public void setAge7(int age7) {
		this.age7 = age7;
	}
	public int getAge8() {
		return age8;
	}
	public void setAge8(int age8) {
		this.age8 = age8;
	}
	public void setAgeTotal(int ageTotal) {
		this.ageTotal = ageTotal;
	}

	private String bikeType;
	private String sexCd;
	private int age1;
	private int age2;
	private int age3;
	private int age4;
	private int age5;
	private int age6;
	private int age7;
	private int age8;
	private int ageTotal;
	
	
	
	
	
	public int getAgeTotal() {
		return ageTotal;
	} 
	
	private String dateType;
	private String sortType;
	private String searchBgnMt;
	private String searchEndMt;
	
	private String paymentType;
	private String userType;
	private String userId;
	private String userGender;
	private String userMob;
	private String rentCnt;
	private String returnCnt;
	
	private String comCd;
	private String mLangComCd;
	private String useCntSum;
	private String useCntAvg;
	private String moveDistSum;
	private String moveDistAvg;
	private String useMinuteSum;
	private String useMinuteAvg;
	
	private String stationGrp;
	private String stationGrpName;
	private String stationId;
	private String stationName;
	private String rentDttm;
	private String rentType;
	private ArrayList<String> rentTypeArray;
	private String useCntTime00;
	private String useCntTime01;
	private String useCntTime02;
	private String useCntTime03;
	private String useCntTime04;
	private String useCntTime05;
	private String useCntTime06;
	private String useCntTime07;
	private String useCntTime08;
	private String useCntTime09;
	private String useCntTime10;
	private String useCntTime11;
	private String useCntTime12;
	private String useCntTime13;
	private String useCntTime14;
	private String useCntTime15;
	private String useCntTime16;
	private String useCntTime17;
	private String useCntTime18;
	private String useCntTime19;
	private String useCntTime20;
	private String useCntTime21;
	private String useCntTime22;
	private String useCntTime23;
	private String useCntTimeTotal;

	private String useCntAgeM_10;
	private String useCntAgeF_10;
	private String useCntAgeM_20;
	private String useCntAgeF_20;
	private String useCntAgeM_30;
	private String useCntAgeF_30;
	private String useCntAgeM_40;
	private String useCntAgeF_40;
	private String useCntAgeM_50;
	private String useCntAgeF_50;
	private String useCntAgeM_60;
	private String useCntAgeF_60;
	private String useCntAgeM_70;
	private String useCntAgeF_70;
	private String useCntAgeTotal;
	
	private String statisticsDate;
	private String useCntAgeMvm_10;
	private String useCntAgeCo2_10;
	private String useCntAgeMvm_20;
	private String useCntAgeCo2_20;
	private String useCntAgeMvm_30;
	private String useCntAgeCo2_30;
	private String useCntAgeMvm_40;
	private String useCntAgeCo2_40;
	private String useCntAgeMvm_50;
	private String useCntAgeCo2_50;
	private String useCntAgeMvm_60;
	private String useCntAgeCo2_60;
	private String useCntAgeMvm_70;
	private String useCntAgeCo2_70;
	private String useCntAgeMvm_Total;
	private String useCntAgeCo2_Total;
	
	public String getDateType() {
		return dateType;
	}
	public void setDateType(String dateType) {
		this.dateType = dateType;
	}
	public String getSortType() {
		return sortType;
	}
	public void setSortType(String sortType) {
		this.sortType = sortType;
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
	public String getPaymentType() {
		return paymentType;
	}
	public void setPaymentType(String paymentType) {
		this.paymentType = paymentType;
	}
	public String getUserType() {
		return userType;
	}
	public void setUserType(String userType) {
		this.userType = userType;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserGender() {
		return userGender;
	}
	public void setUserGender(String userGender) {
		this.userGender = userGender;
	}
	public String getUserMob() {
		return userMob;
	}
	public void setUserMob(String userMob) {
		this.userMob = userMob;
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
	public String getComCd() {
		return comCd;
	}
	public void setComCd(String comCd) {
		this.comCd = comCd;
	}
	public String getmLangComCd() {
		return mLangComCd;
	}
	public void setmLangComCd(String mLangComCd) {
		this.mLangComCd = mLangComCd;
	}
	public String getUseCntSum() {
		return useCntSum;
	}
	public void setUseCntSum(String useCntSum) {
		this.useCntSum = useCntSum;
	}
	public String getUseCntAvg() {
		return useCntAvg;
	}
	public void setUseCntAvg(String useCntAvg) {
		this.useCntAvg = useCntAvg;
	}
	public String getMoveDistSum() {
		return moveDistSum;
	}
	public void setMoveDistSum(String moveDistSum) {
		this.moveDistSum = moveDistSum;
	}
	public String getMoveDistAvg() {
		return moveDistAvg;
	}
	public void setMoveDistAvg(String moveDistAvg) {
		this.moveDistAvg = moveDistAvg;
	}
	public String getUseMinuteSum() {
		return useMinuteSum;
	}
	public void setUseMinuteSum(String useMinuteSum) {
		this.useMinuteSum = useMinuteSum;
	}
	public String getUseMinuteAvg() {
		return useMinuteAvg;
	}
	public void setUseMinuteAvg(String useMinuteAvg) {
		this.useMinuteAvg = useMinuteAvg;
	}
	public String getStationGrp() {
		return stationGrp;
	}
	public void setStationGrp(String stationGrp) {
		this.stationGrp = stationGrp;
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
	public String getRentDttm() {
		return rentDttm;
	}
	public void setRentDttm(String rentDttm) {
		this.rentDttm = rentDttm;
	}
	public String getRentType() {
		return rentType;
	}
	public void setRentType(String rentType) {
		this.rentType = rentType;
	}
	public String getUseCntTime00() {
		return useCntTime00;
	}
	public void setUseCntTime00(String useCntTime00) {
		this.useCntTime00 = useCntTime00;
	}
	public String getUseCntTime01() {
		return useCntTime01;
	}
	public void setUseCntTime01(String useCntTime01) {
		this.useCntTime01 = useCntTime01;
	}
	public String getUseCntTime02() {
		return useCntTime02;
	}
	public void setUseCntTime02(String useCntTime02) {
		this.useCntTime02 = useCntTime02;
	}
	public String getUseCntTime03() {
		return useCntTime03;
	}
	public void setUseCntTime03(String useCntTime03) {
		this.useCntTime03 = useCntTime03;
	}
	public String getUseCntTime04() {
		return useCntTime04;
	}
	public void setUseCntTime04(String useCntTime04) {
		this.useCntTime04 = useCntTime04;
	}
	public String getUseCntTime05() {
		return useCntTime05;
	}
	public void setUseCntTime05(String useCntTime05) {
		this.useCntTime05 = useCntTime05;
	}
	public String getUseCntTime06() {
		return useCntTime06;
	}
	public void setUseCntTime06(String useCntTime06) {
		this.useCntTime06 = useCntTime06;
	}
	public String getUseCntTime07() {
		return useCntTime07;
	}
	public void setUseCntTime07(String useCntTime07) {
		this.useCntTime07 = useCntTime07;
	}
	public String getUseCntTime08() {
		return useCntTime08;
	}
	public void setUseCntTime08(String useCntTime08) {
		this.useCntTime08 = useCntTime08;
	}
	public String getUseCntTime09() {
		return useCntTime09;
	}
	public void setUseCntTime09(String useCntTime09) {
		this.useCntTime09 = useCntTime09;
	}
	public String getUseCntTime10() {
		return useCntTime10;
	}
	public void setUseCntTime10(String useCntTime10) {
		this.useCntTime10 = useCntTime10;
	}
	public String getUseCntTime11() {
		return useCntTime11;
	}
	public void setUseCntTime11(String useCntTime11) {
		this.useCntTime11 = useCntTime11;
	}
	public String getUseCntTime12() {
		return useCntTime12;
	}
	public void setUseCntTime12(String useCntTime12) {
		this.useCntTime12 = useCntTime12;
	}
	public String getUseCntTime13() {
		return useCntTime13;
	}
	public void setUseCntTime13(String useCntTime13) {
		this.useCntTime13 = useCntTime13;
	}
	public String getUseCntTime14() {
		return useCntTime14;
	}
	public void setUseCntTime14(String useCntTime14) {
		this.useCntTime14 = useCntTime14;
	}
	public String getUseCntTime15() {
		return useCntTime15;
	}
	public void setUseCntTime15(String useCntTime15) {
		this.useCntTime15 = useCntTime15;
	}
	public String getUseCntTime16() {
		return useCntTime16;
	}
	public void setUseCntTime16(String useCntTime16) {
		this.useCntTime16 = useCntTime16;
	}
	public String getUseCntTime17() {
		return useCntTime17;
	}
	public void setUseCntTime17(String useCntTime17) {
		this.useCntTime17 = useCntTime17;
	}
	public String getUseCntTime18() {
		return useCntTime18;
	}
	public void setUseCntTime18(String useCntTime18) {
		this.useCntTime18 = useCntTime18;
	}
	public String getUseCntTime19() {
		return useCntTime19;
	}
	public void setUseCntTime19(String useCntTime19) {
		this.useCntTime19 = useCntTime19;
	}
	public String getUseCntTime20() {
		return useCntTime20;
	}
	public void setUseCntTime20(String useCntTime20) {
		this.useCntTime20 = useCntTime20;
	}
	public String getUseCntTime21() {
		return useCntTime21;
	}
	public void setUseCntTime21(String useCntTime21) {
		this.useCntTime21 = useCntTime21;
	}
	public String getUseCntTime22() {
		return useCntTime22;
	}
	public void setUseCntTime22(String useCntTime22) {
		this.useCntTime22 = useCntTime22;
	}
	public String getUseCntTime23() {
		return useCntTime23;
	}
	public void setUseCntTime23(String useCntTime23) {
		this.useCntTime23 = useCntTime23;
	}
	public String getUseCntTimeTotal() {
		return useCntTimeTotal;
	}
	public void setUseCntTimeTotal(String useCntTimeTotal) {
		this.useCntTimeTotal = useCntTimeTotal;
	}
	public String getUseCntAgeM_10() {
		return useCntAgeM_10;
	}
	public void setUseCntAgeM_10(String useCntAgeM_10) {
		this.useCntAgeM_10 = useCntAgeM_10;
	}
	public String getUseCntAgeF_10() {
		return useCntAgeF_10;
	}
	public void setUseCntAgeF_10(String useCntAgeF_10) {
		this.useCntAgeF_10 = useCntAgeF_10;
	}
	public String getUseCntAgeM_20() {
		return useCntAgeM_20;
	}
	public void setUseCntAgeM_20(String useCntAgeM_20) {
		this.useCntAgeM_20 = useCntAgeM_20;
	}
	public String getUseCntAgeF_20() {
		return useCntAgeF_20;
	}
	public void setUseCntAgeF_20(String useCntAgeF_20) {
		this.useCntAgeF_20 = useCntAgeF_20;
	}
	public String getUseCntAgeM_30() {
		return useCntAgeM_30;
	}
	public void setUseCntAgeM_30(String useCntAgeM_30) {
		this.useCntAgeM_30 = useCntAgeM_30;
	}
	public String getUseCntAgeF_30() {
		return useCntAgeF_30;
	}
	public void setUseCntAgeF_30(String useCntAgeF_30) {
		this.useCntAgeF_30 = useCntAgeF_30;
	}
	public String getUseCntAgeM_40() {
		return useCntAgeM_40;
	}
	public void setUseCntAgeM_40(String useCntAgeM_40) {
		this.useCntAgeM_40 = useCntAgeM_40;
	}
	public String getUseCntAgeF_40() {
		return useCntAgeF_40;
	}
	public void setUseCntAgeF_40(String useCntAgeF_40) {
		this.useCntAgeF_40 = useCntAgeF_40;
	}
	public String getUseCntAgeM_50() {
		return useCntAgeM_50;
	}
	public void setUseCntAgeM_50(String useCntAgeM_50) {
		this.useCntAgeM_50 = useCntAgeM_50;
	}
	public String getUseCntAgeF_50() {
		return useCntAgeF_50;
	}
	public void setUseCntAgeF_50(String useCntAgeF_50) {
		this.useCntAgeF_50 = useCntAgeF_50;
	}
	public String getUseCntAgeM_60() {
		return useCntAgeM_60;
	}
	public void setUseCntAgeM_60(String useCntAgeM_60) {
		this.useCntAgeM_60 = useCntAgeM_60;
	}
	public String getUseCntAgeF_60() {
		return useCntAgeF_60;
	}
	public void setUseCntAgeF_60(String useCntAgeF_60) {
		this.useCntAgeF_60 = useCntAgeF_60;
	}
	public String getUseCntAgeM_70() {
		return useCntAgeM_70;
	}
	public void setUseCntAgeM_70(String useCntAgeM_70) {
		this.useCntAgeM_70 = useCntAgeM_70;
	}
	public String getUseCntAgeF_70() {
		return useCntAgeF_70;
	}
	public void setUseCntAgeF_70(String useCntAgeF_70) {
		this.useCntAgeF_70 = useCntAgeF_70;
	}
	public String getUseCntAgeTotal() {
		return useCntAgeTotal;
	}
	public void setUseCntAgeTotal(String useCntAgeTotal) {
		this.useCntAgeTotal = useCntAgeTotal;
	}
	public String getStatisticsDate() {
		return statisticsDate;
	}
	public void setStatisticsDate(String statisticsDate) {
		this.statisticsDate = statisticsDate;
	}
	public String getUseCntAgeMvm_10() {
		return useCntAgeMvm_10;
	}
	public void setUseCntAgeMvm_10(String useCntAgeMvm_10) {
		this.useCntAgeMvm_10 = useCntAgeMvm_10;
	}
	public String getUseCntAgeCo2_10() {
		return useCntAgeCo2_10;
	}
	public void setUseCntAgeCo2_10(String useCntAgeCo2_10) {
		this.useCntAgeCo2_10 = useCntAgeCo2_10;
	}
	public String getUseCntAgeMvm_20() {
		return useCntAgeMvm_20;
	}
	public void setUseCntAgeMvm_20(String useCntAgeMvm_20) {
		this.useCntAgeMvm_20 = useCntAgeMvm_20;
	}
	public String getUseCntAgeCo2_20() {
		return useCntAgeCo2_20;
	}
	public void setUseCntAgeCo2_20(String useCntAgeCo2_20) {
		this.useCntAgeCo2_20 = useCntAgeCo2_20;
	}
	public String getUseCntAgeMvm_30() {
		return useCntAgeMvm_30;
	}
	public void setUseCntAgeMvm_30(String useCntAgeMvm_30) {
		this.useCntAgeMvm_30 = useCntAgeMvm_30;
	}
	public String getUseCntAgeCo2_30() {
		return useCntAgeCo2_30;
	}
	public void setUseCntAgeCo2_30(String useCntAgeCo2_30) {
		this.useCntAgeCo2_30 = useCntAgeCo2_30;
	}
	public String getUseCntAgeMvm_40() {
		return useCntAgeMvm_40;
	}
	public void setUseCntAgeMvm_40(String useCntAgeMvm_40) {
		this.useCntAgeMvm_40 = useCntAgeMvm_40;
	}
	public String getUseCntAgeCo2_40() {
		return useCntAgeCo2_40;
	}
	public void setUseCntAgeCo2_40(String useCntAgeCo2_40) {
		this.useCntAgeCo2_40 = useCntAgeCo2_40;
	}
	public String getUseCntAgeMvm_50() {
		return useCntAgeMvm_50;
	}
	public void setUseCntAgeMvm_50(String useCntAgeMvm_50) {
		this.useCntAgeMvm_50 = useCntAgeMvm_50;
	}
	public String getUseCntAgeCo2_50() {
		return useCntAgeCo2_50;
	}
	public void setUseCntAgeCo2_50(String useCntAgeCo2_50) {
		this.useCntAgeCo2_50 = useCntAgeCo2_50;
	}
	public String getUseCntAgeMvm_60() {
		return useCntAgeMvm_60;
	}
	public void setUseCntAgeMvm_60(String useCntAgeMvm_60) {
		this.useCntAgeMvm_60 = useCntAgeMvm_60;
	}
	public String getUseCntAgeCo2_60() {
		return useCntAgeCo2_60;
	}
	public void setUseCntAgeCo2_60(String useCntAgeCo2_60) {
		this.useCntAgeCo2_60 = useCntAgeCo2_60;
	}
	public String getUseCntAgeMvm_70() {
		return useCntAgeMvm_70;
	}
	public void setUseCntAgeMvm_70(String useCntAgeMvm_70) {
		this.useCntAgeMvm_70 = useCntAgeMvm_70;
	}
	public String getUseCntAgeCo2_70() {
		return useCntAgeCo2_70;
	}
	public void setUseCntAgeCo2_70(String useCntAgeCo2_70) {
		this.useCntAgeCo2_70 = useCntAgeCo2_70;
	}
	public String getUseCntAgeMvm_Total() {
		return useCntAgeMvm_Total;
	}
	public void setUseCntAgeMvm_Total(String useCntAgeMvm_Total) {
		this.useCntAgeMvm_Total = useCntAgeMvm_Total;
	}
	public String getUseCntAgeCo2_Total() {
		return useCntAgeCo2_Total;
	}
	public void setUseCntAgeCo2_Total(String useCntAgeCo2_Total) {
		this.useCntAgeCo2_Total = useCntAgeCo2_Total;
	}
	public ArrayList<String> getRentTypeArray() {
		return rentTypeArray;
	}
	public void setRentTypeArray(ArrayList<String> rentTypeArray) {
		this.rentTypeArray = rentTypeArray;
	}
	
	// 이용자별 통계변수
	private String getUseMember_date;
	private String getUseMember_1;
	private String getUseMember_2;
	private String getUseMember_3;


	public String getGetUseMember_date() {
		return getUseMember_date;
	}
	public void setGetUseMember_date(String getUseMember_date) {
		this.getUseMember_date = getUseMember_date;
	}
	public String getGetUseMember_1() {
		return getUseMember_1;
	}
	public void setGetUseMember_1(String getUseMember_1) {
		this.getUseMember_1 = getUseMember_1;
	}
	public String getGetUseMember_2() {
		return getUseMember_2;
	}
	public void setGetUseMember_2(String getUseMember_2) {
		this.getUseMember_2 = getUseMember_2;
	}
	public String getGetUseMember_3() {
		return getUseMember_3;
	}
	public void setGetUseMember_3(String getUseMember_3) {
		this.getUseMember_3 = getUseMember_3;
	}
	
	
}
