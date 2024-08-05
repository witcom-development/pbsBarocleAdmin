/*
 * @Package Name : com.dkitec.barocle.admin.system.commonCodeMgmt.vo
 * @파일명          : CommonStationVO.java
 * @작성일          : 2015. 4. 20.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 20.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.system.commonCodeMgmt.vo;

import java.io.Serializable;
import java.util.List;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.admin.manage.deviceMgmt.arm.vo.ArmVO;
import com.dkitec.barocle.base.IConstants;

/**
 * @파일명          : CommonStationVO.java
 * @작성일          : 2015. 4. 20.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 20.   |   ymshin   |  최초작성
 */
@SuppressWarnings("serial")
@Alias("commonStationVO")
public class CommonStationVO implements Serializable {

	private String stationNo;
	private String stationName;
	private String stationId;
	private String lang = IConstants.LANG_KR;
	
	private List<CommonStationVO> stationList;
	
	public String getStationNo() {
		return stationNo;
	}

	public void setStationNo(String stationNo) {
		this.stationNo = stationNo;
	}

	public String getStationName() {
		return stationName;
	}

	public void setStationName(String stationName) {
		this.stationName = stationName;
	}

	public String getStationId() {
		return stationId;
	}

	public void setStationId(String stationId) {
		this.stationId = stationId;
	}

	public List<CommonStationVO> getStationList() {
		return stationList;
	}

	public void setStationList(List<CommonStationVO> stationList) {
		this.stationList = stationList;
	}

	public String getLang() {
		return lang;
	}

	public void setLang(String lang) {
		this.lang = lang;
	}
	
}
