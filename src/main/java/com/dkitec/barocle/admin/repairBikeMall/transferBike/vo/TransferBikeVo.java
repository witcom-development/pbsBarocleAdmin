package com.dkitec.barocle.admin.repairBikeMall.transferBike.vo;

import java.io.Serializable;
import java.util.List;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.admin.maintenance.CommonVo;

@SuppressWarnings("serial")
@Alias("transferBikeVo")
public class TransferBikeVo extends CommonVo implements Serializable {
	
	// 테이블 컬럼 기준 생성 start
	private String repairOursrcSeq;
	private String equipmentId;
	private String equipmentClsCd;
	private String readClsCd;
	private String regDttm;
	private String adminId;
	private String modDttm;
	private String modId;
	private String transId;
	private String transYn;
	private String transDttm;
	private String takeId;
	private String takeYn;
	private String takeDttm;
	private String brokenStatusCd;
	private String pictureFilename;
	private String repairYn;
	private String repairDttm;
	// end
	
	private String bikeNo;
	private String adminName;
	private String brokenType;
	private String centerName;
	private String centerId;	//센터(점포) ID
	private String districtCd;  //점포 지역구
	private String brokenCnt;
	
	private String partsData; //부품 json
	private String discountRate; 
	private String[] brokenStatusCdList;
	
	private String repairOutsrcMainSeq;

	private String pageYn;
	private String collectYn;
	private String collectDttm;
	private String chkYn;
	
	// 당일 금월 구분값
	private String flag;
	
	private String userId;
	
	public String getChkYn() {
		return chkYn;
	}
	public void setChkYn(String chkYn) {
		this.chkYn = chkYn;
	}
	
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}
	
	public String getPageYn() {
		return pageYn;
	}
	public void setPageYn(String pageYn) {
		this.pageYn = pageYn;
	}
	public String getCollectYn() {
		return collectYn;
	}
	public void setCollectYn(String collectYn) {
		this.collectYn = collectYn;
	}
	public String getCollectDttm() {
		return collectDttm;
	}
	public void setCollectDttm(String collectDttm) {
		this.collectDttm = collectDttm;
	}
	
	public String getBrokenCnt() {
		return brokenCnt;
	}
	public void setBrokenCnt(String brokenCnt) {
		this.brokenCnt = brokenCnt;
	}
	public String getBikeNo() {
		return bikeNo;
	}
	public void setBikeNo(String bikeNo) {
		this.bikeNo = bikeNo;
	}
	public String getAdminName() {
		return adminName;
	}
	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}
	public String getBrokenType() {
		return brokenType;
	}
	public void setBrokenType(String brokenType) {
		this.brokenType = brokenType;
	}
	public String getCenterName() {
		return centerName;
	}
	public void setCenterName(String centerName) {
		this.centerName = centerName;
	}
	public String getRepairOursrcSeq() {
		return repairOursrcSeq;
	}
	public void setRepairOursrcSeq(String repairOursrcSeq) {
		this.repairOursrcSeq = repairOursrcSeq;
	}
	public String getEquipmentId() {
		return equipmentId;
	}
	public void setEquipmentId(String equipmentId) {
		this.equipmentId = equipmentId;
	}
	public String getEquipmentClsCd() {
		return equipmentClsCd;
	}
	public void setEquipmentClsCd(String equipmentClsCd) {
		this.equipmentClsCd = equipmentClsCd;
	}
	public String getReadClsCd() {
		return readClsCd;
	}
	public void setReadClsCd(String readClsCd) {
		this.readClsCd = readClsCd;
	}
	public String getRegDttm() {
		return regDttm;
	}
	public void setRegDttm(String regDttm) {
		this.regDttm = regDttm;
	}
	public String getAdminId() {
		return adminId;
	}
	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}
	public String getModDttm() {
		return modDttm;
	}
	public void setModDttm(String modDttm) {
		this.modDttm = modDttm;
	}
	public String getModId() {
		return modId;
	}
	public void setModId(String modId) {
		this.modId = modId;
	}
	public String getTransId() {
		return transId;
	}
	public void setTransId(String transId) {
		this.transId = transId;
	}
	public String getTransYn() {
		return transYn;
	}
	public void setTransYn(String transYn) {
		this.transYn = transYn;
	}
	public String getTransDttm() {
		return transDttm;
	}
	public void setTransDttm(String transDttm) {
		this.transDttm = transDttm;
	}
	public String getTakeId() {
		return takeId;
	}
	public void setTakeId(String takeId) {
		this.takeId = takeId;
	}
	public String getTakeYn() {
		return takeYn;
	}
	public void setTakeYn(String takeYn) {
		this.takeYn = takeYn;
	}
	public String getTakeDttm() {
		return takeDttm;
	}
	public void setTakeDttm(String takeDttm) {
		this.takeDttm = takeDttm;
	}
	public String getBrokenStatusCd() {
		return brokenStatusCd;
	}
	public void setBrokenStatusCd(String brokenStatusCd) {
		this.brokenStatusCd = brokenStatusCd;
	}
	public String getPictureFilename() {
		return pictureFilename;
	}
	public void setPictureFilename(String pictureFilename) {
		this.pictureFilename = pictureFilename;
	}
	public String getRepairYn() {
		return repairYn;
	}
	public void setRepairYn(String repairYn) {
		this.repairYn = repairYn;
	}
	public String getRepairDttm() {
		return repairDttm;
	}
	public void setRepairDttm(String repairDttm) {
		this.repairDttm = repairDttm;
	}
	public String getCenterId() {
		return centerId;
	}
	public void setCenterId(String centerId) {
		this.centerId = centerId;
	}
	public String getDistrictCd() {
		return districtCd;
	}
	public void setDistrictCd(String districtCd) {
		this.districtCd = districtCd;
	}
	public String getPartsData() {
		return partsData;
	}
	public void setPartsData(String partsData) {
		this.partsData = partsData;
	}
	public String getRepairOutsrcMainSeq() {
		return repairOutsrcMainSeq;
	}
	public void setRepairOutsrcMainSeq(String repairOutsrcMainSeq) {
		this.repairOutsrcMainSeq = repairOutsrcMainSeq;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getDiscountRate() {
		return discountRate;
	}
	public void setDiscountRate(String discountRate) {
		this.discountRate = discountRate;
	}
	public String[] getBrokenStatusCdList() {
		return brokenStatusCdList;
	}
	public void setBrokenStatusCdList(String[] brokenStatusCdList) {
		this.brokenStatusCdList = brokenStatusCdList;
	}

	
}
