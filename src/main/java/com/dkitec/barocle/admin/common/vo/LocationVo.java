package com.dkitec.barocle.admin.common.vo;

import org.apache.ibatis.type.Alias;

@Alias("locationVo")
public class LocationVo {
	private String latitude;
	private String longitude;
	
	public String getLatitude() {
		return latitude;
	}
	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	public String getLongitude() {
		return longitude;
	}
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
}
