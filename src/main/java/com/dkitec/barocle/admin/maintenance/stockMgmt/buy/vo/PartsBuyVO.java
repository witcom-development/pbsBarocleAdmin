/*
 * @Package Name : com.dkitec.barocle.admin.maintenance.stockMgmt.buy.vo
 * @파일명          : PartsBuyVO.java
 * @작성일          : 2015. 6. 1.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 6. 1.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.maintenance.stockMgmt.buy.vo;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.Pattern;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.admin.manage.deviceMgmt.CommonVo;
import com.dkitec.barocle.base.IConstants;
import com.dkitec.barocle.util.egov.paging.VO.PagingVO;
import com.dkitec.barocle.util.validator.annotation.IsDate;
import com.dkitec.barocle.util.validator.annotation.IsMobile;
import com.dkitec.barocle.util.validator.annotation.IsStringNotNullNumeric;

/**
 * @파일명          : PartsBuyVO.java
 * @작성일          : 2015. 6. 1.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 6. 1.   |   ymshin   |  최초작성
 */
@SuppressWarnings("serial")
@Alias("partsBuyVo")
public class PartsBuyVO extends CommonVo implements Serializable /*extends PagingVO*/ {

	@IsStringNotNullNumeric(message="숫자 형식이어야 합니다.")
	private String partBuySeq;
	private String buyerName;
	private String buyerMpnNo;
	@IsDate
	private String buyDate;
	private String buyCmpyName;
	private String cmpyBusinessNo;
	private String cmpyTelNo;
	private String totBuyPrce;
	private String partBuyDesc;
	@IsStringNotNullNumeric(message="숫자 형식이어야 합니다.")
	private String buyQunt;
	@Pattern(regexp="^[A-Z]*_[0-9]*$", message="형식이 일치하지 않습니다.")
	private String partCd;
	private String partCdName;
	private String lang = IConstants.LANG_KR;
	/*private String viewFlg = IConstants.MODE_LIST;*/
	private String partUnitPrce;
	
	private List<PartsBuyVO> partBuyList;
	
	public List<PartsBuyVO> getPartBuyList() {
		return partBuyList;
	}
	public void setPartBuyList(List<PartsBuyVO> partBuyList) {
		this.partBuyList = partBuyList;
	}
	public String getPartBuySeq() {
		return partBuySeq;
	}
	public void setPartBuySeq(String partBuySeq) {
		this.partBuySeq = partBuySeq;
	}
	public String getBuyerName() {
		return buyerName;
	}
	public void setBuyerName(String buyerName) {
		this.buyerName = buyerName;
	}
	public String getBuyerMpnNo() {
		return buyerMpnNo;
	}
	public void setBuyerMpnNo(String buyerMpnNo) {
		this.buyerMpnNo = buyerMpnNo;
	}
	public String getBuyDate() {
		return buyDate;
	}
	public void setBuyDate(String buyDate) {
		this.buyDate = buyDate;
	}
	public String getBuyCmpyName() {
		return buyCmpyName;
	}
	public void setBuyCmpyName(String buyCmpyName) {
		this.buyCmpyName = buyCmpyName;
	}
	public String getCmpyBusinessNo() {
		return cmpyBusinessNo;
	}
	public void setCmpyBusinessNo(String cmpyBusinessNo) {
		this.cmpyBusinessNo = cmpyBusinessNo;
	}
	public String getCmpyTelNo() {
		return cmpyTelNo;
	}
	public void setCmpyTelNo(String cmpyTelNo) {
		this.cmpyTelNo = cmpyTelNo;
	}
	public String getTotBuyPrce() {
		return totBuyPrce;
	}
	public void setTotBuyPrce(String totBuyPrce) {
		this.totBuyPrce = totBuyPrce;
	}
	public String getPartBuyDesc() {
		return partBuyDesc;
	}
	public void setPartBuyDesc(String partBuyDesc) {
		this.partBuyDesc = partBuyDesc;
	}
	public String getBuyQunt() {
		return buyQunt;
	}
	public void setBuyQunt(String buyQunt) {
		this.buyQunt = buyQunt;
	}
	public String getPartCd() {
		return partCd;
	}
	public void setPartCd(String partCd) {
		this.partCd = partCd;
	}
	public String getPartCdName() {
		return partCdName;
	}
	public void setPartCdName(String partCdName) {
		this.partCdName = partCdName;
	}
	public String getLang() {
		return lang;
	}
	public void setLang(String lang) {
		this.lang = lang;
	}
	/*public String getViewFlg() {
		return viewFlg;
	}
	public void setViewFlg(String viewFlg) {
		this.viewFlg = viewFlg;
	}*/
	public String getPartUnitPrce() {
		return partUnitPrce;
	}
	public void setPartUnitPrce(String partUnitPrce) {
		this.partUnitPrce = partUnitPrce;
	}
	
}
