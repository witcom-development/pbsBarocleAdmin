package com.dkitec.barocle.admin.repairBikeMall.manageMall.vo;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.admin.maintenance.CommonVo;

@SuppressWarnings("serial")
@Alias("manageMallVo")
public class ManageMallVo extends CommonVo implements Serializable {
	
	private String repairOursrcPriceSeq;
	private String comCd;
	private String priceYmd;
	private String price;
	private String regDttm;
	
	public String getTransDttm() {
		return transDttm;
	}
	public void setTransDttm(String transDttm) {
		this.transDttm = transDttm;
	}
	public String getTakeDttm() {
		return takeDttm;
	}
	public void setTakeDttm(String takeDttm) {
		this.takeDttm = takeDttm;
	}
	public String getCollectDttm() {
		return collectDttm;
	}
	public void setCollectDttm(String collectDttm) {
		this.collectDttm = collectDttm;
	}
	private String transDttm;
	private String takeDttm;
	private String collectDttm;
	
	
	private String partName;
	
	// 문자 전송 관련 변수 추가
	private String msg;
	private String destno;
	private String adminId;
	private String centerId;
	private String bikeRepairNum;
	private String partsRepairNum;
	private String repairPrice;
	private String months;
	
	// 월정비보고서 관련 변수
	private String takeId;
	private String takeName;
	private String centerName;
	private String centerNo;
	private String repairYear;
	private String repairMonth;
	private String totCnt;
	private String bikeCnt;
	
	private String totAmt;
	
	public String getTotAmt() {
		return totAmt;
	}
	public void setTotAmt(String totAmt) {
		this.totAmt = totAmt;
	}
	private String rec_001;
	private String rec_002;
	private String rec_003;
	private String rec_004;
	private String rec_005;
	private String rec_006;
	private String rec_007;
	private String rec_008;
	private String rec_009;
	private String rec_010;
	private String rec_011;
	private String rec_012;
	private String rec_013;
	private String rec_014;
	private String rec_015;
	private String rec_016;
	private String rec_017;
	private String rec_018;
	private String rec_019;
	private String rec_020;
	private String rec_021;
	private String rec_022;
	private String rec_023;
	private String rec_024;
	private String rec_025;
	private String rec_026;
	private String rec_027;
	private String rec_028;
	private String rec_029;
	private String rec_030;
	private String rec_031;
	private String rec_032;
	private String rec_033;
	private String rec_034;
	private String rec_035;
	private String rec_036;
	private String rec_037;
	private String rec_038;
	private String rec_039;
	private String rec_040;
	private String rec_041;

	private String price_001;
	private String price_002;
	private String price_003;
	private String price_004;
	private String price_005;
	private String price_006;
	private String price_007;
	private String price_008;
	private String price_009;
	private String price_010;
	private String price_011;
	private String price_012;
	private String price_013;
	private String price_014;
	private String price_015;
	private String price_016;
	private String price_017;
	private String price_018;
	private String price_019;
	private String price_020;
	private String price_021;
	private String price_022;
	private String price_023;
	private String price_024;
	private String price_025;
	private String price_026;
	private String price_027;
	private String price_028;
	private String price_029;
	private String price_030;
	private String price_031;
	private String price_032;
	private String price_033;
	private String price_034;
	private String price_035;
	private String price_036;
	private String price_037;
	private String price_038;
	private String price_039;
	private String price_040;
	private String price_041;
	
	
	
	
	public String getCenterId() {
		return centerId;
	}
	public void setCenterId(String centerId) {
		this.centerId = centerId;
	}
	public String getBikeRepairNum() {
		return bikeRepairNum;
	}
	public void setBikeRepairNum(String bikeRepairNum) {
		this.bikeRepairNum = bikeRepairNum;
	}
	public String getPartsRepairNum() {
		return partsRepairNum;
	}
	public void setPartsRepairNum(String partsRepairNum) {
		this.partsRepairNum = partsRepairNum;
	}
	public String getRepairPrice() {
		return repairPrice;
	}
	public void setRepairPrice(String repairPrice) {
		this.repairPrice = repairPrice;
	}
	public String getMonths() {
		return months;
	}
	public void setMonths(String months) {
		this.months = months;
	}
	public String getTakeId() {
		return takeId;
	}
	public void setTakeId(String takeId) {
		this.takeId = takeId;
	}
	public String getTakeName() {
		return takeName;
	}
	public void setTakeName(String takeName) {
		this.takeName = takeName;
	}
	public String getCenterName() {
		return centerName;
	}
	public void setCenterName(String centerName) {
		this.centerName = centerName;
	}
	public String getRepairYear() {
		return repairYear;
	}
	public void setRepairYear(String repairYear) {
		this.repairYear = repairYear;
	}
	public String getRepairMonth() {
		return repairMonth;
	}
	public void setRepairMonth(String repairMonth) {
		this.repairMonth = repairMonth;
	}
	public String getRec_001() {
		return rec_001;
	}
	public void setRec_001(String rec_001) {
		this.rec_001 = rec_001;
	}
	public String getRec_002() {
		return rec_002;
	}
	public void setRec_002(String rec_002) {
		this.rec_002 = rec_002;
	}
	public String getRec_003() {
		return rec_003;
	}
	public void setRec_003(String rec_003) {
		this.rec_003 = rec_003;
	}
	public String getRec_004() {
		return rec_004;
	}
	public void setRec_004(String rec_004) {
		this.rec_004 = rec_004;
	}
	public String getRec_005() {
		return rec_005;
	}
	public void setRec_005(String rec_005) {
		this.rec_005 = rec_005;
	}
	public String getRec_006() {
		return rec_006;
	}
	public void setRec_006(String rec_006) {
		this.rec_006 = rec_006;
	}
	public String getRec_007() {
		return rec_007;
	}
	public void setRec_007(String rec_007) {
		this.rec_007 = rec_007;
	}
	public String getRec_008() {
		return rec_008;
	}
	public void setRec_008(String rec_008) {
		this.rec_008 = rec_008;
	}
	public String getRec_009() {
		return rec_009;
	}
	public void setRec_009(String rec_009) {
		this.rec_009 = rec_009;
	}
	public String getRec_010() {
		return rec_010;
	}
	public void setRec_010(String rec_010) {
		this.rec_010 = rec_010;
	}
	public String getRec_011() {
		return rec_011;
	}
	public void setRec_011(String rec_011) {
		this.rec_011 = rec_011;
	}
	public String getRec_012() {
		return rec_012;
	}
	public void setRec_012(String rec_012) {
		this.rec_012 = rec_012;
	}
	public String getRec_013() {
		return rec_013;
	}
	public void setRec_013(String rec_013) {
		this.rec_013 = rec_013;
	}
	public String getRec_014() {
		return rec_014;
	}
	public void setRec_014(String rec_014) {
		this.rec_014 = rec_014;
	}
	public String getRec_015() {
		return rec_015;
	}
	public void setRec_015(String rec_015) {
		this.rec_015 = rec_015;
	}
	public String getRec_016() {
		return rec_016;
	}
	public void setRec_016(String rec_016) {
		this.rec_016 = rec_016;
	}
	public String getRec_017() {
		return rec_017;
	}
	public void setRec_017(String rec_017) {
		this.rec_017 = rec_017;
	}
	public String getRec_018() {
		return rec_018;
	}
	public void setRec_018(String rec_018) {
		this.rec_018 = rec_018;
	}
	public String getRec_019() {
		return rec_019;
	}
	public void setRec_019(String rec_019) {
		this.rec_019 = rec_019;
	}
	public String getRec_020() {
		return rec_020;
	}
	public void setRec_020(String rec_020) {
		this.rec_020 = rec_020;
	}
	public String getRec_021() {
		return rec_021;
	}
	public void setRec_021(String rec_021) {
		this.rec_021 = rec_021;
	}
	public String getPrice_001() {
		return price_001;
	}
	public void setPrice_001(String price_001) {
		this.price_001 = price_001;
	}
	public String getPrice_002() {
		return price_002;
	}
	public void setPrice_002(String price_002) {
		this.price_002 = price_002;
	}
	public String getPrice_003() {
		return price_003;
	}
	public void setPrice_003(String price_003) {
		this.price_003 = price_003;
	}
	public String getPrice_004() {
		return price_004;
	}
	public void setPrice_004(String price_004) {
		this.price_004 = price_004;
	}
	public String getPrice_005() {
		return price_005;
	}
	public void setPrice_005(String price_005) {
		this.price_005 = price_005;
	}
	public String getPrice_006() {
		return price_006;
	}
	public void setPrice_006(String price_006) {
		this.price_006 = price_006;
	}
	public String getPrice_007() {
		return price_007;
	}
	public void setPrice_007(String price_007) {
		this.price_007 = price_007;
	}
	public String getPrice_008() {
		return price_008;
	}
	public void setPrice_008(String price_008) {
		this.price_008 = price_008;
	}
	public String getPrice_009() {
		return price_009;
	}
	public void setPrice_009(String price_009) {
		this.price_009 = price_009;
	}
	public String getPrice_010() {
		return price_010;
	}
	public void setPrice_010(String price_010) {
		this.price_010 = price_010;
	}
	public String getPrice_011() {
		return price_011;
	}
	public void setPrice_011(String price_011) {
		this.price_011 = price_011;
	}
	public String getPrice_012() {
		return price_012;
	}
	public void setPrice_012(String price_012) {
		this.price_012 = price_012;
	}
	public String getPrice_013() {
		return price_013;
	}
	public void setPrice_013(String price_013) {
		this.price_013 = price_013;
	}
	public String getPrice_014() {
		return price_014;
	}
	public void setPrice_014(String price_014) {
		this.price_014 = price_014;
	}
	public String getPrice_015() {
		return price_015;
	}
	public void setPrice_015(String price_015) {
		this.price_015 = price_015;
	}
	public String getPrice_016() {
		return price_016;
	}
	public void setPrice_016(String price_016) {
		this.price_016 = price_016;
	}
	public String getPrice_017() {
		return price_017;
	}
	public void setPrice_017(String price_017) {
		this.price_017 = price_017;
	}
	public String getPrice_018() {
		return price_018;
	}
	public void setPrice_018(String price_018) {
		this.price_018 = price_018;
	}
	public String getPrice_019() {
		return price_019;
	}
	public void setPrice_019(String price_019) {
		this.price_019 = price_019;
	}
	public String getPrice_020() {
		return price_020;
	}
	public void setPrice_020(String price_020) {
		this.price_020 = price_020;
	}
	public String getPrice_021() {
		return price_021;
	}
	public void setPrice_021(String price_021) {
		this.price_021 = price_021;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getDestno() {
		return destno;
	}
	public void setDestno(String destno) {
		this.destno = destno;
	}
	public String getAdminId() {
		return adminId;
	}
	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}
	public String getRepairOursrcPriceSeq() {
		return repairOursrcPriceSeq;
	}
	public void setRepairOursrcPriceSeq(String repairOursrcPriceSeq) {
		this.repairOursrcPriceSeq = repairOursrcPriceSeq;
	}
	public String getComCd() {
		return comCd;
	}
	public void setComCd(String comCd) {
		this.comCd = comCd;
	}
	public String getPriceYmd() {
		return priceYmd;
	}
	public void setPriceYmd(String priceYmd) {
		this.priceYmd = priceYmd;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getRegDttm() {
		return regDttm;
	}
	public void setRegDttm(String regDttm) {
		this.regDttm = regDttm;
	}
	public String getPartName() {
		return partName;
	}
	public void setPartName(String partName) {
		this.partName = partName;
	}
	public String getRec_022() {
		return rec_022;
	}
	public void setRec_022(String rec_022) {
		this.rec_022 = rec_022;
	}
	public String getRec_023() {
		return rec_023;
	}
	public void setRec_023(String rec_023) {
		this.rec_023 = rec_023;
	}
	public String getRec_024() {
		return rec_024;
	}
	public void setRec_024(String rec_024) {
		this.rec_024 = rec_024;
	}
	public String getRec_025() {
		return rec_025;
	}
	public void setRec_025(String rec_025) {
		this.rec_025 = rec_025;
	}
	public String getRec_026() {
		return rec_026;
	}
	public void setRec_026(String rec_026) {
		this.rec_026 = rec_026;
	}
	public String getRec_027() {
		return rec_027;
	}
	public void setRec_027(String rec_027) {
		this.rec_027 = rec_027;
	}
	public String getRec_028() {
		return rec_028;
	}
	public void setRec_028(String rec_028) {
		this.rec_028 = rec_028;
	}
	public String getRec_029() {
		return rec_029;
	}
	public void setRec_029(String rec_029) {
		this.rec_029 = rec_029;
	}
	public String getRec_030() {
		return rec_030;
	}
	public void setRec_030(String rec_030) {
		this.rec_030 = rec_030;
	}
	public String getRec_031() {
		return rec_031;
	}
	public void setRec_031(String rec_031) {
		this.rec_031 = rec_031;
	}
	public String getRec_032() {
		return rec_032;
	}
	public void setRec_032(String rec_032) {
		this.rec_032 = rec_032;
	}
	public String getRec_033() {
		return rec_033;
	}
	public void setRec_033(String rec_033) {
		this.rec_033 = rec_033;
	}
	public String getRec_034() {
		return rec_034;
	}
	public void setRec_034(String rec_034) {
		this.rec_034 = rec_034;
	}
	public String getRec_035() {
		return rec_035;
	}
	public void setRec_035(String rec_035) {
		this.rec_035 = rec_035;
	}
	public String getRec_036() {
		return rec_036;
	}
	public void setRec_036(String rec_036) {
		this.rec_036 = rec_036;
	}
	public String getRec_037() {
		return rec_037;
	}
	public void setRec_037(String rec_037) {
		this.rec_037 = rec_037;
	}
	public String getRec_038() {
		return rec_038;
	}
	public void setRec_038(String rec_038) {
		this.rec_038 = rec_038;
	}
	public String getRec_039() {
		return rec_039;
	}
	public void setRec_039(String rec_039) {
		this.rec_039 = rec_039;
	}
	public String getRec_040() {
		return rec_040;
	}
	public void setRec_040(String rec_040) {
		this.rec_040 = rec_040;
	}
	public String getRec_041() {
		return rec_041;
	}
	public void setRec_041(String rec_041) {
		this.rec_041 = rec_041;
	}
	public String getPrice_022() {
		return price_022;
	}
	public void setPrice_022(String price_022) {
		this.price_022 = price_022;
	}
	public String getPrice_023() {
		return price_023;
	}
	public void setPrice_023(String price_023) {
		this.price_023 = price_023;
	}
	public String getPrice_024() {
		return price_024;
	}
	public void setPrice_024(String price_024) {
		this.price_024 = price_024;
	}
	public String getPrice_025() {
		return price_025;
	}
	public void setPrice_025(String price_025) {
		this.price_025 = price_025;
	}
	public String getPrice_026() {
		return price_026;
	}
	public void setPrice_026(String price_026) {
		this.price_026 = price_026;
	}
	public String getPrice_027() {
		return price_027;
	}
	public void setPrice_027(String price_027) {
		this.price_027 = price_027;
	}
	public String getPrice_028() {
		return price_028;
	}
	public void setPrice_028(String price_028) {
		this.price_028 = price_028;
	}
	public String getPrice_029() {
		return price_029;
	}
	public void setPrice_029(String price_029) {
		this.price_029 = price_029;
	}
	public String getPrice_030() {
		return price_030;
	}
	public void setPrice_030(String price_030) {
		this.price_030 = price_030;
	}
	public String getPrice_031() {
		return price_031;
	}
	public void setPrice_031(String price_031) {
		this.price_031 = price_031;
	}
	public String getPrice_032() {
		return price_032;
	}
	public void setPrice_032(String price_032) {
		this.price_032 = price_032;
	}
	public String getPrice_033() {
		return price_033;
	}
	public void setPrice_033(String price_033) {
		this.price_033 = price_033;
	}
	public String getPrice_034() {
		return price_034;
	}
	public void setPrice_034(String price_034) {
		this.price_034 = price_034;
	}
	public String getPrice_035() {
		return price_035;
	}
	public void setPrice_035(String price_035) {
		this.price_035 = price_035;
	}
	public String getPrice_036() {
		return price_036;
	}
	public void setPrice_036(String price_036) {
		this.price_036 = price_036;
	}
	public String getPrice_037() {
		return price_037;
	}
	public void setPrice_037(String price_037) {
		this.price_037 = price_037;
	}
	public String getPrice_038() {
		return price_038;
	}
	public void setPrice_038(String price_038) {
		this.price_038 = price_038;
	}
	public String getPrice_039() {
		return price_039;
	}
	public void setPrice_039(String price_039) {
		this.price_039 = price_039;
	}
	public String getPrice_040() {
		return price_040;
	}
	public void setPrice_040(String price_040) {
		this.price_040 = price_040;
	}
	public String getPrice_041() {
		return price_041;
	}
	public void setPrice_041(String price_041) {
		this.price_041 = price_041;
	}
	public String getCenterNo() {
		return centerNo;
	}
	public void setCenterNo(String centerNo) {
		this.centerNo = centerNo;
	}
	public String getBikeCnt() {
		return bikeCnt;
	}
	public void setBikeCnt(String bikeCnt) {
		this.bikeCnt = bikeCnt;
	}
	public String getTotCnt() {
		return totCnt;
	}
	public void setTotCnt(String totCnt) {
		this.totCnt = totCnt;
	}
	

}
