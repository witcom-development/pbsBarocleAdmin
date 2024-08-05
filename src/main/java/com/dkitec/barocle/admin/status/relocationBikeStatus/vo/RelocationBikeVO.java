/*
 * @Package Name : com.dkitec.barocle.admin.status.relocationBikeStatus.vo
 * @파일명          : RelocationBikeVO.java
 * @작성일          : 2015. 5. 21.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 5. 21.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.status.relocationBikeStatus.vo;

import org.apache.ibatis.type.Alias;

/**
 * @파일명          : RelocationBikeVO.java
 * @작성일          : 2015. 5. 21.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 5. 21.   |   ymshin   |  최초작성
 */
@Alias("relocaBikeVo")
public class RelocationBikeVO {

	private String carModlName;
	private String carNo;
	private String nowLocLatitude;
	private String nowLocLongitude;
	private String locInfoModDttm;
	
	
	public String getCarModlName() {
		return carModlName;
	}
	public void setCarModlName(String carModlName) {
		this.carModlName = carModlName;
	}
	public String getCarNo() {
		return carNo;
	}
	public void setCarNo(String carNo) {
		this.carNo = carNo;
	}
	public String getNowLocLatitude() {
		return nowLocLatitude;
	}
	public void setNowLocLatitude(String nowLocLatitude) {
		this.nowLocLatitude = nowLocLatitude;
	}
	public String getNowLocLongitude() {
		return nowLocLongitude;
	}
	public void setNowLocLongitude(String nowLocLongitude) {
		this.nowLocLongitude = nowLocLongitude;
	}
	public String getLocInfoModDttm() {
		return locInfoModDttm;
	}
	public void setLocInfoModDttm(String locInfoModDttm) {
		this.locInfoModDttm = locInfoModDttm;
	}
	
}
