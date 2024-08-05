package com.dkitec.barocle.logging.vo;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

@Alias("menuCdVO")
public class MenuCdVO implements Serializable {
	
	private static final long serialVersionUID = -1222056788753988937L;
	
	private String menuCD;
	private String menuName;
	private String upMenu;
	private int menuLevel;
	private String menuDetailCD;
	private String linkImg;
	private String menuImg;
	private String srcLink;
	private int menuOrd;
	private String menuDesc;
	private String hiddenYN;
	private String regID;
	private java.util.Date regDttm;
	
	private int menuURLSeq;
	//private String menuCD;
	private String menuURL;
	private String menuCRUD;
	
	public String getMenuCD() {
		return menuCD;
	}
	public void setMenuCD(String menuCD) {
		this.menuCD = menuCD;
	}
	public String getMenuName() {
		return menuName;
	}
	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}
	public String getUpMenu() {
		return upMenu;
	}
	public void setUpMenu(String upMenu) {
		this.upMenu = upMenu;
	}
	public int getMenuLevel() {
		return menuLevel;
	}
	public void setMenuLevel(int menuLevel) {
		this.menuLevel = menuLevel;
	}
	public String getMenuDetailCD() {
		return menuDetailCD;
	}
	public void setMenuDetailCD(String menuDetailCD) {
		this.menuDetailCD = menuDetailCD;
	}
	public String getLinkImg() {
		return linkImg;
	}
	public void setLinkImg(String linkImg) {
		this.linkImg = linkImg;
	}
	public String getMenuImg() {
		return menuImg;
	}
	public void setMenuImg(String menuImg) {
		this.menuImg = menuImg;
	}
	public String getSrcLink() {
		return srcLink;
	}
	public void setSrcLink(String srcLink) {
		this.srcLink = srcLink;
	}
	public int getMenuOrd() {
		return menuOrd;
	}
	public void setMenuOrd(int menuOrd) {
		this.menuOrd = menuOrd;
	}
	public String getMenuDesc() {
		return menuDesc;
	}
	public void setMenuDesc(String menuDesc) {
		this.menuDesc = menuDesc;
	}
	public String getHiddenYN() {
		return hiddenYN;
	}
	public void setHiddenYN(String hiddenYN) {
		this.hiddenYN = hiddenYN;
	}
	public String getRegID() {
		return regID;
	}
	public void setRegID(String regID) {
		this.regID = regID;
	}
	public java.util.Date getRegDttm() {
		return regDttm;
	}
	public void setRegDttm(java.util.Date regDttm) {
		this.regDttm = regDttm;
	}
	public int getMenuURLSeq() {
		return menuURLSeq;
	}
	public void setMenuURLSeq(int menuURLSeq) {
		this.menuURLSeq = menuURLSeq;
	}
	public String getMenuURL() {
		return menuURL;
	}
	public void setMenuURL(String menuURL) {
		this.menuURL = menuURL;
	}
	public String getMenuCRUD() {
		return menuCRUD;
	}
	public void setMenuCRUD(String menuCRUD) {
		this.menuCRUD = menuCRUD;
	}
	
	@Override
	public String toString() {
		return "MenuCdVO [menuCD=" + menuCD + ", menuName=" + menuName
				+ ", upMenu=" + upMenu + ", menuLevel=" + menuLevel
				+ ", menuDetailCD=" + menuDetailCD + ", linkImg=" + linkImg
				+ ", menuImg=" + menuImg + ", srcLink=" + srcLink
				+ ", menuOrd=" + menuOrd + ", menuDesc=" + menuDesc
				+ ", hiddenYN=" + hiddenYN + ", regID=" + regID + ", regDttm="
				+ regDttm + ", menuURLSeq=" + menuURLSeq + ", menuURL="
				+ menuURL + ", menuCRUD=" + menuCRUD + ", getClass()="
				+ getClass() + ", hashCode()=" + hashCode() + ", toString()="
				+ super.toString() + "]";
	}

}
