package com.dkitec.barocle.admin.system.MenuMgmt.vo;

import org.apache.ibatis.type.Alias;

@Alias("menuOpenHistVO")
public class MenuOpenHistVO {

	public void MenuOpenHist() {
	}	
	
	public String getADMIN_ID() {
		return ADMIN_ID;
	}
	public void setADMIN_ID(String aDMIN_ID) {
		ADMIN_ID = aDMIN_ID;
	}
	public String getMENU_URL() {
		return MENU_URL;
	}
	public void setMENU_URL(String mENU_URL) {
		MENU_URL = mENU_URL;
	}
	public String getMENU_DESC() {
		return MENU_DESC;
	}
	public void setMENU_DESC(String mENU_DESC) {
		MENU_DESC = mENU_DESC;
	}
	public String getADMIN_IP() {
		return ADMIN_IP;
	}
	
	public void setADMIN_IP(String aDMIN_IP) {
		ADMIN_IP = aDMIN_IP;
	}
	
	private String ADMIN_ID;
	private String MENU_URL;
	private String MENU_DESC; 
	private String ADMIN_IP;

}
