package com.dkitec.barocle.admin.maintenance.repair.division.vo;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.admin.maintenance.CommonVo;
import com.dkitec.barocle.util.egov.paging.VO.PagingVO;
import com.dkitec.barocle.util.validator.annotation.SearchDate;

@SuppressWarnings("serial")
@Alias("repairDivisionVo")
@SearchDate(groups=PagingVO.SearchDateValidator.class)
public class RepairDivisionVO extends CommonVo implements Serializable {

	private String comCd;
    private String comUpCd;
    private String useYn;
    private String regDttm;
    private String regId;
    private String mlangComCdName;
    private String btn_chk;

    private String dspOrd;
    private String codeNm1;
    private String codeNm2;
    private String codeNm3;
    private String codeNm4;
    private String cdDesc1;
    private String addVal1;
    private String addVal2;
    private String addVal3;
    
    private String chgDesc;
    
    private String adminId;
    private String chgCodeNm;
    
    private String cnt1;
    private String cnt2;
    private String cnt3;
    
    private String comCdArr;

    
    
	public String getComCdArr() {
		return comCdArr;
	}

	public void setComCdArr(String comCdArr) {
		this.comCdArr = comCdArr;
	}

	public String getChgCodeNm() {
		return chgCodeNm;
	}

	public void setChgCodeNm(String chgCodeNm) {
		this.chgCodeNm = chgCodeNm;
	}

	public String getCnt1() {
		return cnt1;
	}

	public void setCnt1(String cnt1) {
		this.cnt1 = cnt1;
	}

	public String getCnt2() {
		return cnt2;
	}

	public void setCnt2(String cnt2) {
		this.cnt2 = cnt2;
	}

	public String getCnt3() {
		return cnt3;
	}

	public void setCnt3(String cnt3) {
		this.cnt3 = cnt3;
	}

	public String getAdminId() {
		return adminId;
	}

	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}

	public String getChgDesc() {
		return chgDesc;
	}

	public void setChgDesc(String chgDesc) {
		this.chgDesc = chgDesc;
	}

	public String getDspOrd() {
		return dspOrd;
	}

	public void setDspOrd(String dspOrd) {
		this.dspOrd = dspOrd;
	}

	public String getCodeNm1() {
		return codeNm1;
	}

	public void setCodeNm1(String codeNm1) {
		this.codeNm1 = codeNm1;
	}

	public String getCodeNm2() {
		return codeNm2;
	}

	public void setCodeNm2(String codeNm2) {
		this.codeNm2 = codeNm2;
	}

	public String getCodeNm3() {
		return codeNm3;
	}

	public void setCodeNm3(String codeNm3) {
		this.codeNm3 = codeNm3;
	}

	public String getCodeNm4() {
		return codeNm4;
	}

	public void setCodeNm4(String codeNm4) {
		this.codeNm4 = codeNm4;
	}

	public String getCdDesc1() {
		return cdDesc1;
	}

	public void setCdDesc1(String cdDesc1) {
		this.cdDesc1 = cdDesc1;
	}

	public String getAddVal1() {
		return addVal1;
	}

	public void setAddVal1(String addVal1) {
		this.addVal1 = addVal1;
	}

	public String getAddVal2() {
		return addVal2;
	}

	public void setAddVal2(String addVal2) {
		this.addVal2 = addVal2;
	}

	public String getAddVal3() {
		return addVal3;
	}

	public void setAddVal3(String addVal3) {
		this.addVal3 = addVal3;
	}

	public String getBtn_chk() {
		return btn_chk;
	}

	public void setBtn_chk(String btn_chk) {
		this.btn_chk = btn_chk;
	}

	public String getComCd() {
		return comCd;
	}

	public void setComCd(String comCd) {
		this.comCd = comCd;
	}

	public String getComUpCd() {
		return comUpCd;
	}

	public void setComUpCd(String comUpCd) {
		this.comUpCd = comUpCd;
	}

	public String getUseYn() {
		return useYn;
	}

	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}

	public String getRegDttm() {
		return regDttm;
	}

	public void setRegDttm(String regDttm) {
		this.regDttm = regDttm;
	}

	public String getRegId() {
		return regId;
	}

	public void setRegId(String regId) {
		this.regId = regId;
	}

	public String getMlangComCdName() {
		return mlangComCdName;
	}

	public void setMlangComCdName(String mlangComCdName) {
		this.mlangComCdName = mlangComCdName;
	}
	
   
    
}
