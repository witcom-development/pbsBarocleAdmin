package com.dkitec.barocle.admin.service.push.vo;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.util.egov.paging.VO.PagingVO;

@SuppressWarnings("serial")
@Alias("pushUserInfoVO")
public class PushUserInfoVO extends PagingVO implements Serializable {
 
	public String getUSERSEQNO() {
		return USERSEQNO;
	}
	public void setUSERSEQNO(String uSERSEQNO) {
		USERSEQNO = uSERSEQNO;
	}
	public String getPUSHKEY() {
		return PUSHKEY;
	}
	public void setPUSHKEY(String pUSHKEY) {
		PUSHKEY = pUSHKEY;
	}
	public String getPSID() {
		return PSID;
	}
	public void setPSID(String pSID) {
		PSID = pSID;
	}
	public String getPNSID() {
		return PNSID;
	}
	public void setPNSID(String pNSID) {
		PNSID = pNSID;
	}
	public String getDEVICEID() {
		return DEVICEID;
	}
	public void setDEVICEID(String dEVICEID) {
		DEVICEID = dEVICEID;
	}
	public String getCUID() {
		return CUID;
	}
	public void setCUID(String cUID) {
		CUID = cUID;
	}
	public String getCNAME() {
		return CNAME;
	}
	public void setCNAME(String cNAME) {
		CNAME = cNAME;
	}
	public String getAPPID() {
		return APPID;
	}
	public void setAPPID(String aPPID) {
		APPID = aPPID;
	}
	public String getPHONENO() {
		return PHONENO;
	}
	public void setPHONENO(String pHONENO) {
		PHONENO = pHONENO;
	}
	public String getOS_VER() {
		return OS_VER;
	}
	public void setOS_VER(String oS_VER) {
		OS_VER = oS_VER;
	}
	public String getDEVICE_MD() {
		return DEVICE_MD;
	}
	public void setDEVICE_MD(String dEVICE_MD) {
		DEVICE_MD = dEVICE_MD;
	}
	public String getAPP_VER() {
		return APP_VER;
	}
	public void setAPP_VER(String aPP_VER) {
		APP_VER = aPP_VER;
	}
	public String getAPNS_MODE() {
		return APNS_MODE;
	}
	public void setAPNS_MODE(String aPNS_MODE) {
		APNS_MODE = aPNS_MODE;
	}
	public String getUPNSID() {
		return UPNSID;
	}
	public void setUPNSID(String uPNSID) {
		UPNSID = uPNSID;
	}
	public String getORGUPNSID() {
		return ORGUPNSID;
	}
	public void setORGUPNSID(String oRGUPNSID) {
		ORGUPNSID = oRGUPNSID;
	}
	public String getREGDATE() {
		return REGDATE;
	}
	public void setREGDATE(String rEGDATE) {
		REGDATE = rEGDATE;
	}
	public String getMODDATE() {
		return MODDATE;
	}
	public void setMODDATE(String mODDATE) {
		MODDATE = mODDATE;
	}
	private String USERSEQNO;
	private String PUSHKEY;
	private String PSID;
	private String PNSID;
	private String DEVICEID;
	private String CUID;
	private String CNAME;
	private String APPID;
	private String PHONENO;
	private String OS_VER;
	private String DEVICE_MD;
	private String APP_VER;
	private String APNS_MODE;
	private String UPNSID;
	private String ORGUPNSID;
	private String REGDATE;
	private String MODDATE;
	
	// PUSH MESSAGE
	private String REVDATE;
	public String getREVDATE() {
		return REVDATE;
	}
	public void setREVDATE(String rEVDATE) {
		REVDATE = rEVDATE;
	}
	public String getREADDATE() {
		return READDATE;
	}
	public void setREADDATE(String rEADDATE) {
		READDATE = rEADDATE;
	}
	public String getSUB_TITLE() {
		return SUB_TITLE;
	}
	public void setSUB_TITLE(String sUB_TITLE) {
		SUB_TITLE = sUB_TITLE;
	}
	public String getMESSAGE() {
		return MESSAGE;
	}
	public void setMESSAGE(String mESSAGE) {
		MESSAGE = mESSAGE;
	}
	public String getSTATUS() {
		return STATUS;
	}
	public void setSTATUS(String sTATUS) {
		STATUS = sTATUS;
	}
	private String READDATE;
	private String SUB_TITLE;
	private String MESSAGE;
	private String STATUS;
	private String RESULTMSG;
	public String getRESULTMSG() {
		return RESULTMSG;
	}
	public void setRESULTMSG(String rESULTMSG) {
		RESULTMSG = rESULTMSG;
	}
	
}
