package com.dkitec.barocle.admin.maintenance.inspect.station.vo;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.admin.manage.deviceMgmt.CommonVo;
import com.dkitec.barocle.base.IConstants;

@SuppressWarnings("serial")
@Alias("inspectStationVo")
public class InspectStationVO extends CommonVo implements Serializable {

    /** 페이징 여부 */
    @Pattern(regexp="Y|N" , message="잘못된 형식입니다.")
    private String pagingYn;
    private String stationId;
    private String stationNm;
    private String bikeCnt;
    private String falutCnt;
    private String stationUseYn;
    
	public String getPagingYn() {
		return pagingYn;
	}
	public void setPagingYn(String pagingYn) {
		this.pagingYn = pagingYn;
	}
	public String getStationId() {
		return stationId;
	}
	public void setStationId(String stationId) {
		this.stationId = stationId;
	}
	public String getStationNm() {
		return stationNm;
	}
	public void setStationNm(String stationNm) {
		this.stationNm = stationNm;
	}
	public String getBikeCnt() {
		return bikeCnt;
	}
	public void setBikeCnt(String bikeCnt) {
		this.bikeCnt = bikeCnt;
	}
	public String getFalutCnt() {
		return falutCnt;
	}
	public void setFalutCnt(String falutCnt) {
		this.falutCnt = falutCnt;
	}
	public String getStationUseYn() {
		return stationUseYn;
	}
	public void setStationUseYn(String stationUseYn) {
		this.stationUseYn = stationUseYn;
	}
    
}
