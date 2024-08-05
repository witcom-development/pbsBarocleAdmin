package com.dkitec.barocle.admin.service.paymentmgmt.payment.vo;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.util.egov.paging.VO.PagingVO;

@Alias("paymentStatVO")
public class PaymentStatVO extends PagingVO implements Serializable {

	static final long serialVersionUID = -667346209445497937L;
	
	private String lang;
	
	private String totAmt;
	private String bil001Tot;
	private String bil002Tot;
	private String bil003Tot;
	private String bil004Tot;
	private String bil005Tot;
	private String regularTot;
	private String bil006Tot;
	private String bil007Tot;
	private String bil008Tot;
	private String bil009Tot;
	private String bil010Tot;
	private String etcTot;
	
	private String bil001TotCancel;
	private String bil002TotCancel;
	private String bil003TotCancel;
	private String bil004TotCancel;
	private String bil005TotCancel;
	private String regularTotCancel;
	private String bil006TotCancel;
	private String bil007TotCancel;
	private String bil008TotCancel;
	private String bil009TotCancel;
	private String bil010TotCancel;
	private String totAmtCancel;
    private String etcTotCancel;	
	/*건수*/
    private String bil001TotCnt;
    private String bil002TotCnt;
    private String bil003TotCnt;
    private String bil004TotCnt;
    private String bil005TotCnt;
    private String bil006TotCnt;
    private String bil007TotCnt;
    private String bil008TotCnt;
    private String bil009TotCnt;
    private String bil010TotCnt;
    private String bil001TotCancelCnt;
    private String bil002TotCancelCnt;
    private String bil003TotCancelCnt;
    private String bil004TotCancelCnt;
    private String bil005TotCancelCnt;
    private String bil006TotCancelCnt;
    private String bil007TotCancelCnt;
    private String bil008TotCancelCnt;
    private String bil009TotCancelCnt;
    private String bil010TotCancelCnt;
    /*초과*/
    private String bil001TotOverFee;
    private String bil002TotOverFee;
    private String bil003TotOverFee;
    private String bil004TotOverFee;
    private String bil005TotOverFee;
    private String bil006TotOverFee;
    private String bil007TotOverFee;
    private String bil008TotOverFee;
    private String bil009TotOverFee;
    private String bil010TotOverFee;
    private String regularTotOverFee;
    private String totAmtOverFee;
    private String totAmtCancelOverFee;
    /*마일리지*/
    private String bil001TotMileage;
    private String bil002TotMileage;
    private String bil003TotMileage;
    private String bil004TotMileage;
    private String bil005TotMileage;
    private String bil006TotMileage;
    
    private String bil001TotCancelMileage;
    private String bil002TotCancelMileage;
    private String bil003TotCancelMileage;
    private String bil004TotCancelMileage;
    private String bil005TotCancelMileage;
    private String bil006TotCancelMileage;
    
    private String bil001TotCancelOverFee;
    private String bil002TotCancelOverFee;
    private String bil003TotCancelOverFee;
    private String bil004TotCancelOverFee;
    private String bil005TotCancelOverFee;
    private String bil006TotCancelOverFee;
    private String bil007TotCancelOverFee;
    private String bil008TotCancelOverFee;
    private String bil009TotCancelOverFee;
    private String bil010TotCancelOverFee;

    private String etcTotOverFee;
    private String etcTotCancelOverFee;
    private String regularTotMileage;
    private String regularTotCancelMileage;
    private String regularTotCancelOverFee;
    private String totAmtMileage;
    private String totAmtCancelMileage;
	public String getLang() {
		return lang;
	}
	public void setLang(String lang) {
		this.lang = lang;
	}
	public String getTotAmt() {
		return totAmt;
	}
	public void setTotAmt(String totAmt) {
		this.totAmt = totAmt;
	}
	public String getBil001Tot() {
		return bil001Tot;
	}
	public void setBil001Tot(String bil001Tot) {
		this.bil001Tot = bil001Tot;
	}
	public String getBil002Tot() {
		return bil002Tot;
	}
	public void setBil002Tot(String bil002Tot) {
		this.bil002Tot = bil002Tot;
	}
	public String getBil003Tot() {
		return bil003Tot;
	}
	public void setBil003Tot(String bil003Tot) {
		this.bil003Tot = bil003Tot;
	}
	public String getBil004Tot() {
		return bil004Tot;
	}
	public void setBil004Tot(String bil004Tot) {
		this.bil004Tot = bil004Tot;
	}
	public String getBil005Tot() {
		return bil005Tot;
	}
	public void setBil005Tot(String bil005Tot) {
		this.bil005Tot = bil005Tot;
	}
	public String getRegularTot() {
		return regularTot;
	}
	public void setRegularTot(String regularTot) {
		this.regularTot = regularTot;
	}
	public String getBil006Tot() {
		return bil006Tot;
	}
	public void setBil006Tot(String bil006Tot) {
		this.bil006Tot = bil006Tot;
	}
	public String getBil007Tot() {
		return bil007Tot;
	}
	public void setBil007Tot(String bil007Tot) {
		this.bil007Tot = bil007Tot;
	}
	public String getBil008Tot() {
		return bil008Tot;
	}
	public void setBil008Tot(String bil008Tot) {
		this.bil008Tot = bil008Tot;
	}
	public String getBil009Tot() {
		return bil009Tot;
	}
	public void setBil009Tot(String bil009Tot) {
		this.bil009Tot = bil009Tot;
	}
	public String getBil010Tot() {
		return bil010Tot;
	}
	public void setBil010Tot(String bil010Tot) {
		this.bil010Tot = bil010Tot;
	}
	public String getEtcTot() {
		return etcTot;
	}
	public void setEtcTot(String etcTot) {
		this.etcTot = etcTot;
	}
	public String getBil001TotCancel() {
		return bil001TotCancel;
	}
	public void setBil001TotCancel(String bil001TotCancel) {
		this.bil001TotCancel = bil001TotCancel;
	}
	public String getBil002TotCancel() {
		return bil002TotCancel;
	}
	public void setBil002TotCancel(String bil002TotCancel) {
		this.bil002TotCancel = bil002TotCancel;
	}
	public String getBil003TotCancel() {
		return bil003TotCancel;
	}
	public void setBil003TotCancel(String bil003TotCancel) {
		this.bil003TotCancel = bil003TotCancel;
	}
	public String getBil004TotCancel() {
		return bil004TotCancel;
	}
	public void setBil004TotCancel(String bil004TotCancel) {
		this.bil004TotCancel = bil004TotCancel;
	}
	public String getBil005TotCancel() {
		return bil005TotCancel;
	}
	public void setBil005TotCancel(String bil005TotCancel) {
		this.bil005TotCancel = bil005TotCancel;
	}
	public String getRegularTotCancel() {
		return regularTotCancel;
	}
	public void setRegularTotCancel(String regularTotCancel) {
		this.regularTotCancel = regularTotCancel;
	}
	public String getBil006TotCancel() {
		return bil006TotCancel;
	}
	public void setBil006TotCancel(String bil006TotCancel) {
		this.bil006TotCancel = bil006TotCancel;
	}
	public String getBil007TotCancel() {
		return bil007TotCancel;
	}
	public void setBil007TotCancel(String bil007TotCancel) {
		this.bil007TotCancel = bil007TotCancel;
	}
	public String getBil008TotCancel() {
		return bil008TotCancel;
	}
	public void setBil008TotCancel(String bil008TotCancel) {
		this.bil008TotCancel = bil008TotCancel;
	}
	public String getBil009TotCancel() {
		return bil009TotCancel;
	}
	public void setBil009TotCancel(String bil009TotCancel) {
		this.bil009TotCancel = bil009TotCancel;
	}
	public String getBil010TotCancel() {
		return bil010TotCancel;
	}
	public void setBil010TotCancel(String bil010TotCancel) {
		this.bil010TotCancel = bil010TotCancel;
	}
	public String getTotAmtCancel() {
		return totAmtCancel;
	}
	public void setTotAmtCancel(String totAmtCancel) {
		this.totAmtCancel = totAmtCancel;
	}
	public String getEtcTotCancel() {
		return etcTotCancel;
	}
	public void setEtcTotCancel(String etcTotCancel) {
		this.etcTotCancel = etcTotCancel;
	}
	public String getBil001TotCnt() {
		return bil001TotCnt;
	}
	public void setBil001TotCnt(String bil001TotCnt) {
		this.bil001TotCnt = bil001TotCnt;
	}
	public String getBil002TotCnt() {
		return bil002TotCnt;
	}
	public void setBil002TotCnt(String bil002TotCnt) {
		this.bil002TotCnt = bil002TotCnt;
	}
	public String getBil003TotCnt() {
		return bil003TotCnt;
	}
	public void setBil003TotCnt(String bil003TotCnt) {
		this.bil003TotCnt = bil003TotCnt;
	}
	public String getBil004TotCnt() {
		return bil004TotCnt;
	}
	public void setBil004TotCnt(String bil004TotCnt) {
		this.bil004TotCnt = bil004TotCnt;
	}
	public String getBil005TotCnt() {
		return bil005TotCnt;
	}
	public void setBil005TotCnt(String bil005TotCnt) {
		this.bil005TotCnt = bil005TotCnt;
	}
	public String getBil006TotCnt() {
		return bil006TotCnt;
	}
	public void setBil006TotCnt(String bil006TotCnt) {
		this.bil006TotCnt = bil006TotCnt;
	}
	public String getBil007TotCnt() {
		return bil007TotCnt;
	}
	public void setBil007TotCnt(String bil007TotCnt) {
		this.bil007TotCnt = bil007TotCnt;
	}
	public String getBil008TotCnt() {
		return bil008TotCnt;
	}
	public void setBil008TotCnt(String bil008TotCnt) {
		this.bil008TotCnt = bil008TotCnt;
	}
	public String getBil009TotCnt() {
		return bil009TotCnt;
	}
	public void setBil009TotCnt(String bil009TotCnt) {
		this.bil009TotCnt = bil009TotCnt;
	}
	public String getBil010TotCnt() {
		return bil010TotCnt;
	}
	public void setBil010TotCnt(String bil010TotCnt) {
		this.bil010TotCnt = bil010TotCnt;
	}
	public String getBil001TotCancelCnt() {
		return bil001TotCancelCnt;
	}
	public void setBil001TotCancelCnt(String bil001TotCancelCnt) {
		this.bil001TotCancelCnt = bil001TotCancelCnt;
	}
	public String getBil002TotCancelCnt() {
		return bil002TotCancelCnt;
	}
	public void setBil002TotCancelCnt(String bil002TotCancelCnt) {
		this.bil002TotCancelCnt = bil002TotCancelCnt;
	}
	public String getBil003TotCancelCnt() {
		return bil003TotCancelCnt;
	}
	public void setBil003TotCancelCnt(String bil003TotCancelCnt) {
		this.bil003TotCancelCnt = bil003TotCancelCnt;
	}
	public String getBil004TotCancelCnt() {
		return bil004TotCancelCnt;
	}
	public void setBil004TotCancelCnt(String bil004TotCancelCnt) {
		this.bil004TotCancelCnt = bil004TotCancelCnt;
	}
	public String getBil005TotCancelCnt() {
		return bil005TotCancelCnt;
	}
	public void setBil005TotCancelCnt(String bil005TotCancelCnt) {
		this.bil005TotCancelCnt = bil005TotCancelCnt;
	}
	public String getBil006TotCancelCnt() {
		return bil006TotCancelCnt;
	}
	public void setBil006TotCancelCnt(String bil006TotCancelCnt) {
		this.bil006TotCancelCnt = bil006TotCancelCnt;
	}
	public String getBil007TotCancelCnt() {
		return bil007TotCancelCnt;
	}
	public void setBil007TotCancelCnt(String bil007TotCancelCnt) {
		this.bil007TotCancelCnt = bil007TotCancelCnt;
	}
	public String getBil008TotCancelCnt() {
		return bil008TotCancelCnt;
	}
	public void setBil008TotCancelCnt(String bil008TotCancelCnt) {
		this.bil008TotCancelCnt = bil008TotCancelCnt;
	}
	public String getBil009TotCancelCnt() {
		return bil009TotCancelCnt;
	}
	public void setBil009TotCancelCnt(String bil009TotCancelCnt) {
		this.bil009TotCancelCnt = bil009TotCancelCnt;
	}
	public String getBil010TotCancelCnt() {
		return bil010TotCancelCnt;
	}
	public void setBil010TotCancelCnt(String bil010TotCancelCnt) {
		this.bil010TotCancelCnt = bil010TotCancelCnt;
	}
	public String getBil001TotOverFee() {
		return bil001TotOverFee;
	}
	public void setBil001TotOverFee(String bil001TotOverFee) {
		this.bil001TotOverFee = bil001TotOverFee;
	}
	public String getBil002TotOverFee() {
		return bil002TotOverFee;
	}
	public void setBil002TotOverFee(String bil002TotOverFee) {
		this.bil002TotOverFee = bil002TotOverFee;
	}
	public String getBil003TotOverFee() {
		return bil003TotOverFee;
	}
	public void setBil003TotOverFee(String bil003TotOverFee) {
		this.bil003TotOverFee = bil003TotOverFee;
	}
	public String getBil004TotOverFee() {
		return bil004TotOverFee;
	}
	public void setBil004TotOverFee(String bil004TotOverFee) {
		this.bil004TotOverFee = bil004TotOverFee;
	}
	public String getBil005TotOverFee() {
		return bil005TotOverFee;
	}
	public void setBil005TotOverFee(String bil005TotOverFee) {
		this.bil005TotOverFee = bil005TotOverFee;
	}
	public String getBil006TotOverFee() {
		return bil006TotOverFee;
	}
	public void setBil006TotOverFee(String bil006TotOverFee) {
		this.bil006TotOverFee = bil006TotOverFee;
	}
	public String getBil007TotOverFee() {
		return bil007TotOverFee;
	}
	public void setBil007TotOverFee(String bil007TotOverFee) {
		this.bil007TotOverFee = bil007TotOverFee;
	}
	public String getBil008TotOverFee() {
		return bil008TotOverFee;
	}
	public void setBil008TotOverFee(String bil008TotOverFee) {
		this.bil008TotOverFee = bil008TotOverFee;
	}
	public String getBil009TotOverFee() {
		return bil009TotOverFee;
	}
	public void setBil009TotOverFee(String bil009TotOverFee) {
		this.bil009TotOverFee = bil009TotOverFee;
	}
	public String getBil010TotOverFee() {
		return bil010TotOverFee;
	}
	public void setBil010TotOverFee(String bil010TotOverFee) {
		this.bil010TotOverFee = bil010TotOverFee;
	}
	public String getRegularTotOverFee() {
		return regularTotOverFee;
	}
	public void setRegularTotOverFee(String regularTotOverFee) {
		this.regularTotOverFee = regularTotOverFee;
	}
	public String getTotAmtOverFee() {
		return totAmtOverFee;
	}
	public void setTotAmtOverFee(String totAmtOverFee) {
		this.totAmtOverFee = totAmtOverFee;
	}
	public String getTotAmtCancelOverFee() {
		return totAmtCancelOverFee;
	}
	public void setTotAmtCancelOverFee(String totAmtCancelOverFee) {
		this.totAmtCancelOverFee = totAmtCancelOverFee;
	}
	public String getBil001TotMileage() {
		return bil001TotMileage;
	}
	public void setBil001TotMileage(String bil001TotMileage) {
		this.bil001TotMileage = bil001TotMileage;
	}
	public String getBil002TotMileage() {
		return bil002TotMileage;
	}
	public void setBil002TotMileage(String bil002TotMileage) {
		this.bil002TotMileage = bil002TotMileage;
	}
	public String getBil003TotMileage() {
		return bil003TotMileage;
	}
	public void setBil003TotMileage(String bil003TotMileage) {
		this.bil003TotMileage = bil003TotMileage;
	}
	public String getBil004TotMileage() {
		return bil004TotMileage;
	}
	public void setBil004TotMileage(String bil004TotMileage) {
		this.bil004TotMileage = bil004TotMileage;
	}
	public String getBil005TotMileage() {
		return bil005TotMileage;
	}
	public void setBil005TotMileage(String bil005TotMileage) {
		this.bil005TotMileage = bil005TotMileage;
	}
	public String getBil006TotMileage() {
		return bil006TotMileage;
	}
	public void setBil006TotMileage(String bil006TotMileage) {
		this.bil006TotMileage = bil006TotMileage;
	}
	public String getBil001TotCancelMileage() {
		return bil001TotCancelMileage;
	}
	public void setBil001TotCancelMileage(String bil001TotCancelMileage) {
		this.bil001TotCancelMileage = bil001TotCancelMileage;
	}
	public String getBil002TotCancelMileage() {
		return bil002TotCancelMileage;
	}
	public void setBil002TotCancelMileage(String bil002TotCancelMileage) {
		this.bil002TotCancelMileage = bil002TotCancelMileage;
	}
	public String getBil003TotCancelMileage() {
		return bil003TotCancelMileage;
	}
	public void setBil003TotCancelMileage(String bil003TotCancelMileage) {
		this.bil003TotCancelMileage = bil003TotCancelMileage;
	}
	public String getBil004TotCancelMileage() {
		return bil004TotCancelMileage;
	}
	public void setBil004TotCancelMileage(String bil004TotCancelMileage) {
		this.bil004TotCancelMileage = bil004TotCancelMileage;
	}
	public String getBil005TotCancelMileage() {
		return bil005TotCancelMileage;
	}
	public void setBil005TotCancelMileage(String bil005TotCancelMileage) {
		this.bil005TotCancelMileage = bil005TotCancelMileage;
	}
	public String getBil006TotCancelMileage() {
		return bil006TotCancelMileage;
	}
	public void setBil006TotCancelMileage(String bil006TotCancelMileage) {
		this.bil006TotCancelMileage = bil006TotCancelMileage;
	}
	public String getBil001TotCancelOverFee() {
		return bil001TotCancelOverFee;
	}
	public void setBil001TotCancelOverFee(String bil001TotCancelOverFee) {
		this.bil001TotCancelOverFee = bil001TotCancelOverFee;
	}
	public String getBil002TotCancelOverFee() {
		return bil002TotCancelOverFee;
	}
	public void setBil002TotCancelOverFee(String bil002TotCancelOverFee) {
		this.bil002TotCancelOverFee = bil002TotCancelOverFee;
	}
	public String getBil003TotCancelOverFee() {
		return bil003TotCancelOverFee;
	}
	public void setBil003TotCancelOverFee(String bil003TotCancelOverFee) {
		this.bil003TotCancelOverFee = bil003TotCancelOverFee;
	}
	public String getBil004TotCancelOverFee() {
		return bil004TotCancelOverFee;
	}
	public void setBil004TotCancelOverFee(String bil004TotCancelOverFee) {
		this.bil004TotCancelOverFee = bil004TotCancelOverFee;
	}
	public String getBil005TotCancelOverFee() {
		return bil005TotCancelOverFee;
	}
	public void setBil005TotCancelOverFee(String bil005TotCancelOverFee) {
		this.bil005TotCancelOverFee = bil005TotCancelOverFee;
	}
	public String getBil006TotCancelOverFee() {
		return bil006TotCancelOverFee;
	}
	public void setBil006TotCancelOverFee(String bil006TotCancelOverFee) {
		this.bil006TotCancelOverFee = bil006TotCancelOverFee;
	}
	public String getBil007TotCancelOverFee() {
		return bil007TotCancelOverFee;
	}
	public void setBil007TotCancelOverFee(String bil007TotCancelOverFee) {
		this.bil007TotCancelOverFee = bil007TotCancelOverFee;
	}
	public String getBil008TotCancelOverFee() {
		return bil008TotCancelOverFee;
	}
	public void setBil008TotCancelOverFee(String bil008TotCancelOverFee) {
		this.bil008TotCancelOverFee = bil008TotCancelOverFee;
	}
	public String getBil009TotCancelOverFee() {
		return bil009TotCancelOverFee;
	}
	public void setBil009TotCancelOverFee(String bil009TotCancelOverFee) {
		this.bil009TotCancelOverFee = bil009TotCancelOverFee;
	}
	public String getBil010TotCancelOverFee() {
		return bil010TotCancelOverFee;
	}
	public void setBil010TotCancelOverFee(String bil010TotCancelOverFee) {
		this.bil010TotCancelOverFee = bil010TotCancelOverFee;
	}
	public String getEtcTotOverFee() {
		return etcTotOverFee;
	}
	public void setEtcTotOverFee(String etcTotOverFee) {
		this.etcTotOverFee = etcTotOverFee;
	}
	public String getEtcTotCancelOverFee() {
		return etcTotCancelOverFee;
	}
	public void setEtcTotCancelOverFee(String etcTotCancelOverFee) {
		this.etcTotCancelOverFee = etcTotCancelOverFee;
	}
	public String getRegularTotMileage() {
		return regularTotMileage;
	}
	public void setRegularTotMileage(String regularTotMileage) {
		this.regularTotMileage = regularTotMileage;
	}
	public String getRegularTotCancelMileage() {
		return regularTotCancelMileage;
	}
	public void setRegularTotCancelMileage(String regularTotCancelMileage) {
		this.regularTotCancelMileage = regularTotCancelMileage;
	}
	public String getRegularTotCancelOverFee() {
		return regularTotCancelOverFee;
	}
	public void setRegularTotCancelOverFee(String regularTotCancelOverFee) {
		this.regularTotCancelOverFee = regularTotCancelOverFee;
	}
	public String getTotAmtMileage() {
		return totAmtMileage;
	}
	public void setTotAmtMileage(String totAmtMileage) {
		this.totAmtMileage = totAmtMileage;
	}
	public String getTotAmtCancelMileage() {
		return totAmtCancelMileage;
	}
	public void setTotAmtCancelMileage(String totAmtCancelMileage) {
		this.totAmtCancelMileage = totAmtCancelMileage;
	}
	
}
