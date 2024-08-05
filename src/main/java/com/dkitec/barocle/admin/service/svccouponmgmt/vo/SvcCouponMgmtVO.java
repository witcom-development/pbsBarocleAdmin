package com.dkitec.barocle.admin.service.svccouponmgmt.vo;

import java.io.Serializable;
import java.math.BigInteger;
import java.util.List;

import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.apache.ibatis.type.Alias;
import org.springframework.web.multipart.MultipartFile;

import com.dkitec.barocle.base.IConstants;
import com.dkitec.barocle.util.egov.paging.VO.PagingVO;

@Alias("svcCouponMgmtVO")
public class SvcCouponMgmtVO extends PagingVO implements Serializable {

	static final long serialVersionUID = 4248341030462539893L;
	
	private String lang = IConstants.LANG_KR;
	
	private String viewFlg = IConstants.MODE_LIST;
	
	private String couponNo;
	
	private String usrSeq;
	
	private String useUsrSeq;
	
	private String paymentClsCd;
	
	private String paymentSeq;
	
	private String paymentDttm;
	
	private String couponStrDttm;
	
	private String couponEndDttm;
	
	private String partyUseCnt;
	
	private String couponUseYn;
	
	private String couponDelYn;
	
	private String extendReasonDesc;
	
	private String extendAdminId;
	
	private String extendDttm;
	
	private String paymentChnnlCd;
	
	private String couponName;
	
	private String couponRegisYn;
	
	private String couponSeq;
	
	private String adminId;
	
	/** 페이징 여부 */
    @Pattern(regexp="Y|N" , message="잘못된 형식입니다.")
	private String pagingYn;
    
    private List<String> svcCouponCountList;
    
    private List<String> paymentClsCdList;
    
    private String paymentClsCdName;
    
    private List<String> svcCouponSeqList;
    
    private String paymentMethodCd;
    
    private String paymentMethodCdName;
    
    private String couponDelYnName;
    
    private String couponUseYnName;
    
    private String mbName;
    
    private String couponSeqCnt;
    private String couponRegisCnt;
    private String couponUseCnt;
    
    private String useDttm;
    private String mbId;
    
    private String searchRegisStartDate;
    private String searchRegisEndDate;
    
    private String usrSearchType;
    private String usrSearchKey;
    
    
    private String cnt;
    private String regisCnt;
    private String useCnt;
    private String regisPer;
    private String usePer;
    private String totAmt;
    
    private String bilCnt006;
    private String bilCnt001;
    private String bilCnt002;
    private String bilCnt003;
    private String bilCnt004;
    private String bilCnt005;
    private String bilCnt016;
    private String bilCnt011;
    private String bilCnt012;
    private String bilCnt013;
    private String bilCnt014;
    private String bilCnt015;
    private String bilEtcCnt;
    private String daySearchType;
    

	public String getLang() {
		return lang;
	}


	public void setLang(String lang) {
		this.lang = lang;
	}


	public String getViewFlg() {
		return viewFlg;
	}


	public void setViewFlg(String viewFlg) {
		this.viewFlg = viewFlg;
	}


	public String getCouponNo() {
		return couponNo;
	}


	public void setCouponNo(String couponNo) {
		this.couponNo = couponNo;
	}


	public String getUsrSeq() {
		return usrSeq;
	}


	public void setUsrSeq(String usrSeq) {
		this.usrSeq = usrSeq;
	}


	public String getUseUsrSeq() {
		return useUsrSeq;
	}


	public void setUseUsrSeq(String useUsrSeq) {
		this.useUsrSeq = useUsrSeq;
	}


	public String getPaymentClsCd() {
		return paymentClsCd;
	}


	public void setPaymentClsCd(String paymentClsCd) {
		this.paymentClsCd = paymentClsCd;
	}


	public String getPaymentSeq() {
		return paymentSeq;
	}


	public void setPaymentSeq(String paymentSeq) {
		this.paymentSeq = paymentSeq;
	}


	public String getPaymentDttm() {
		return paymentDttm;
	}


	public void setPaymentDttm(String paymentDttm) {
		this.paymentDttm = paymentDttm;
	}


	public String getCouponStrDttm() {
		return couponStrDttm;
	}


	public void setCouponStrDttm(String couponStrDttm) {
		this.couponStrDttm = couponStrDttm;
	}


	public String getCouponEndDttm() {
		return couponEndDttm;
	}


	public void setCouponEndDttm(String couponEndDttm) {
		this.couponEndDttm = couponEndDttm;
	}


	public String getPartyUseCnt() {
		return partyUseCnt;
	}


	public void setPartyUseCnt(String partyUseCnt) {
		this.partyUseCnt = partyUseCnt;
	}


	public String getCouponUseYn() {
		return couponUseYn;
	}


	public void setCouponUseYn(String couponUseYn) {
		this.couponUseYn = couponUseYn;
	}


	public String getCouponDelYn() {
		return couponDelYn;
	}


	public void setCouponDelYn(String couponDelYn) {
		this.couponDelYn = couponDelYn;
	}


	public String getExtendReasonDesc() {
		return extendReasonDesc;
	}


	public void setExtendReasonDesc(String extendReasonDesc) {
		this.extendReasonDesc = extendReasonDesc;
	}


	public String getExtendAdminId() {
		return extendAdminId;
	}


	public void setExtendAdminId(String extendAdminId) {
		this.extendAdminId = extendAdminId;
	}


	public String getExtendDttm() {
		return extendDttm;
	}


	public void setExtendDttm(String extendDttm) {
		this.extendDttm = extendDttm;
	}


	public String getPaymentChnnlCd() {
		return paymentChnnlCd;
	}


	public void setPaymentChnnlCd(String paymentChnnlCd) {
		this.paymentChnnlCd = paymentChnnlCd;
	}


	public String getCouponName() {
		return couponName;
	}


	public void setCouponName(String couponName) {
		this.couponName = couponName;
	}


	public String getCouponRegisYn() {
		return couponRegisYn;
	}


	public void setCouponRegisYn(String couponRegisYn) {
		this.couponRegisYn = couponRegisYn;
	}


	public String getPagingYn() {
		return pagingYn;
	}


	public void setPagingYn(String pagingYn) {
		this.pagingYn = pagingYn;
	}


	public List<String> getSvcCouponCountList() {
		return svcCouponCountList;
	}


	public void setSvcCouponCountList(List<String> svcCouponCountList) {
		this.svcCouponCountList = svcCouponCountList;
	}


	public List<String> getPaymentClsCdList() {
		return paymentClsCdList;
	}


	public void setPaymentClsCdList(List<String> paymentClsCdList) {
		this.paymentClsCdList = paymentClsCdList;
	}


	public String getPaymentClsCdName() {
		return paymentClsCdName;
	}


	public void setPaymentClsCdName(String paymentClsCdName) {
		this.paymentClsCdName = paymentClsCdName;
	}


	public String getCouponSeq() {
		return couponSeq;
	}


	public void setCouponSeq(String couponSeq) {
		this.couponSeq = couponSeq;
	}


	public List<String> getSvcCouponSeqList() {
		return svcCouponSeqList;
	}


	public void setSvcCouponSeqList(List<String> svcCouponSeqList) {
		this.svcCouponSeqList = svcCouponSeqList;
	}


	public String getPaymentMethodCd() {
		return paymentMethodCd;
	}


	public void setPaymentMethodCd(String paymentMethodCd) {
		this.paymentMethodCd = paymentMethodCd;
	}


	public String getPaymentMethodCdName() {
		return paymentMethodCdName;
	}


	public void setPaymentMethodCdName(String paymentMethodCdName) {
		this.paymentMethodCdName = paymentMethodCdName;
	}


	public String getCouponDelYnName() {
		return couponDelYnName;
	}


	public void setCouponDelYnName(String couponDelYnName) {
		this.couponDelYnName = couponDelYnName;
	}


	public String getCouponUseYnName() {
		return couponUseYnName;
	}


	public void setCouponUseYnName(String couponUseYnName) {
		this.couponUseYnName = couponUseYnName;
	}


	public String getMbName() {
		return mbName;
	}


	public void setMbName(String mbName) {
		this.mbName = mbName;
	}


	public String getAdminId() {
		return adminId;
	}


	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}


	public String getCouponSeqCnt() {
		return couponSeqCnt;
	}


	public void setCouponSeqCnt(String couponSeqCnt) {
		this.couponSeqCnt = couponSeqCnt;
	}


	public String getCouponRegisCnt() {
		return couponRegisCnt;
	}


	public void setCouponRegisCnt(String couponRegisCnt) {
		this.couponRegisCnt = couponRegisCnt;
	}


	public String getCouponUseCnt() {
		return couponUseCnt;
	}


	public void setCouponUseCnt(String couponUseCnt) {
		this.couponUseCnt = couponUseCnt;
	}


	public String getUseDttm() {
		return useDttm;
	}


	public void setUseDttm(String useDttm) {
		this.useDttm = useDttm;
	}


	public String getMbId() {
		return mbId;
	}


	public void setMbId(String mbId) {
		this.mbId = mbId;
	}


	public String getSearchRegisStartDate() {
		return searchRegisStartDate;
	}


	public void setSearchRegisStartDate(String searchRegisStartDate) {
		this.searchRegisStartDate = searchRegisStartDate;
	}


	public String getSearchRegisEndDate() {
		return searchRegisEndDate;
	}


	public void setSearchRegisEndDate(String searchRegisEndDate) {
		this.searchRegisEndDate = searchRegisEndDate;
	}


	public String getUsrSearchType() {
		return usrSearchType;
	}


	public void setUsrSearchType(String usrSearchType) {
		this.usrSearchType = usrSearchType;
	}


	public String getUsrSearchKey() {
		return usrSearchKey;
	}


	public void setUsrSearchKey(String usrSearchKey) {
		this.usrSearchKey = usrSearchKey;
	}


	public String getCnt() {
		return cnt;
	}


	public void setCnt(String cnt) {
		this.cnt = cnt;
	}


	public String getRegisCnt() {
		return regisCnt;
	}


	public void setRegisCnt(String regisCnt) {
		this.regisCnt = regisCnt;
	}


	public String getUseCnt() {
		return useCnt;
	}


	public void setUseCnt(String useCnt) {
		this.useCnt = useCnt;
	}


	public String getRegisPer() {
		return regisPer;
	}


	public void setRegisPer(String regisPer) {
		this.regisPer = regisPer;
	}


	public String getUsePer() {
		return usePer;
	}


	public void setUsePer(String usePer) {
		this.usePer = usePer;
	}


	public String getTotAmt() {
		return totAmt;
	}


	public void setTotAmt(String totAmt) {
		this.totAmt = totAmt;
	}


	public String getBilCnt006() {
		return bilCnt006;
	}


	public void setBilCnt006(String bilCnt006) {
		this.bilCnt006 = bilCnt006;
	}


	public String getBilCnt001() {
		return bilCnt001;
	}


	public void setBilCnt001(String bilCnt001) {
		this.bilCnt001 = bilCnt001;
	}


	public String getBilCnt002() {
		return bilCnt002;
	}


	public void setBilCnt002(String bilCnt002) {
		this.bilCnt002 = bilCnt002;
	}


	public String getBilCnt003() {
		return bilCnt003;
	}


	public void setBilCnt003(String bilCnt003) {
		this.bilCnt003 = bilCnt003;
	}


	public String getBilCnt004() {
		return bilCnt004;
	}


	public void setBilCnt004(String bilCnt004) {
		this.bilCnt004 = bilCnt004;
	}


	public String getBilCnt005() {
		return bilCnt005;
	}


	public void setBilCnt005(String bilCnt005) {
		this.bilCnt005 = bilCnt005;
	}


	public String getBilCnt016() {
		return bilCnt016;
	}


	public void setBilCnt016(String bilCnt016) {
		this.bilCnt016 = bilCnt016;
	}


	public String getBilCnt011() {
		return bilCnt011;
	}


	public void setBilCnt011(String bilCnt011) {
		this.bilCnt011 = bilCnt011;
	}


	public String getBilCnt012() {
		return bilCnt012;
	}


	public void setBilCnt012(String bilCnt012) {
		this.bilCnt012 = bilCnt012;
	}


	public String getBilCnt013() {
		return bilCnt013;
	}


	public void setBilCnt013(String bilCnt013) {
		this.bilCnt013 = bilCnt013;
	}


	public String getBilCnt014() {
		return bilCnt014;
	}


	public void setBilCnt014(String bilCnt014) {
		this.bilCnt014 = bilCnt014;
	}


	public String getBilCnt015() {
		return bilCnt015;
	}


	public void setBilCnt015(String bilCnt015) {
		this.bilCnt015 = bilCnt015;
	}


	public String getBilEtcCnt() {
		return bilEtcCnt;
	}


	public void setBilEtcCnt(String bilEtcCnt) {
		this.bilEtcCnt = bilEtcCnt;
	}


	public String getDaySearchType() {
		return daySearchType;
	}


	public void setDaySearchType(String daySearchType) {
		this.daySearchType = daySearchType;
	}

	
	
    
	
	
	
}
