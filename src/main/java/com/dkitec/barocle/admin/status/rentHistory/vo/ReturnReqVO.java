/*
 * @Package Name : com.dkitec.barocle.admin.manage.deviceMgmt.bike.vo
 * @파일명          : BikeRentalVO.java
 * @작성일          : 2015. 4. 21.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 21.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.status.rentHistory.vo;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.admin.manage.deviceMgmt.CommonVo;
import com.dkitec.barocle.util.validator.annotation.IsDate;
import com.dkitec.barocle.util.validator.annotation.IsStringNotNullNumeric;

/**
 * @파일명          : ReturnReqVO.java
 * @작성일          : 2015. 4. 21.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 21.   |   ymshin   |  최초작성
 */
@Alias("returnReqVO")
public class ReturnReqVO extends CommonVo implements Serializable {

	/**
	 * @location : com.dkitec.barocle.admin.manage.deviceMgmt.bike.vo.serialVersionUID
	 * @writeDay : 2015. 5. 14.
	 * @Todo  :
	 */ 
	private static final long serialVersionUID = 1L;
	@IsDate(message="형식 오류")
	private String regDttm;
    private String bikeId;
    private String bikeNo;
    private String xpos;
    private String ypos;
    private String bikeStusCd;
    private String stationId;
    private String stationGrpSeq;
    private String remoteReturnSeq;
    private String remoteStationName;
    
	public String getRegDttm() {
		return regDttm;
	}
	public void setRegDttm(String regDttm) {
		this.regDttm = regDttm;
	}
	public String getBikeId() {
		return bikeId;
	}
	public void setBikeId(String bikeId) {
		this.bikeId = bikeId;
	}
	public String getBikeNo() {
		return bikeNo;
	}
	public void setBikeNo(String bikeNo) {
		this.bikeNo = bikeNo;
	}
	public String getXpos() {
		return xpos;
	}
	public void setXpos(String xpos) {
		this.xpos = xpos;
	}
	public String getYpos() {
		return ypos;
	}
	public void setYpos(String ypos) {
		this.ypos = ypos;
	}
	public String getBikeStusCd() {
		return bikeStusCd;
	}
	public void setBikeStusCd(String bikeStusCd) {
		this.bikeStusCd = bikeStusCd;
	}
	public String getStationId() {
		return stationId;
	}
	public void setStationId(String stationId) {
		this.stationId = stationId;
	}
	
	public String getStationGrpSeq() {
		return stationGrpSeq;
	}
	public void setStationGrpSeq(String stationGrpSeq) {
		this.stationGrpSeq = stationGrpSeq;
	}
	public String getRemoteStationName() {
		return remoteStationName;
	}
	public void setRemoteStationName(String remoteStationName) {
		this.remoteStationName = remoteStationName;
	}
	public String getRemoteReturnSeq() {
		return remoteReturnSeq;
	}
	public void setRemoteReturnSeq(String remoteReturnSeq) {
		this.remoteReturnSeq = remoteReturnSeq;
	}
	@Override
	public String toString() {
		return "ReturnReqVO [regDttm=" + regDttm + ", bikeId=" + bikeId + ", bikeNo=" + bikeNo
				+ ", xpos=" + xpos + ", ypos=" + ypos + ", bikeStusCd=" + bikeStusCd
				 + ", stationId=" + stationId + ", stationGrpSeq=" + stationGrpSeq
				 + ", remoteStationName=" + remoteStationName + ", remoteReturnSeq=" + remoteReturnSeq
				+ "]";
	}
	
}
