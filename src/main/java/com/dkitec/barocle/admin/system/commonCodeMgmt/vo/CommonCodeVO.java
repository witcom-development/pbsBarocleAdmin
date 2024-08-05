/*
 * @Package Name : com.dkitec.barocle.admin.system.commonCodeMgmt.vo
 * @파일명          : CommonCodeVO.java
 * @작성일          : 2015. 4. 8.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 8.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.system.commonCodeMgmt.vo;

import java.util.List;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.apache.ibatis.type.Alias;

import com.dkitec.barocle.base.IConstants;
import com.dkitec.barocle.util.egov.paging.VO.PagingVO;
import com.dkitec.barocle.util.validator.annotation.CheckValue;
import com.dkitec.barocle.util.validator.annotation.IsDate;
import com.dkitec.barocle.util.validator.annotation.IsStringNumeric;

/**
 * @파일명          : CommonCodeVO.java
 * @작성일          : 2015. 4. 8.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 8.   |   ymshin   |  최초작성
 */
@Alias(value="commonCodeVo")
public class CommonCodeVO extends PagingVO{

	/**
	 * @location : com.dkitec.barocle.admin.system.commonCodeMgmt.vo.serialVersionUID
	 * @writeDay : 2015. 4. 27.
	 * @Todo  :
	 */ 
	private static final long serialVersionUID = -6398212948352724078L;
	/** 공통코드 */
	
	@Size(max='7', message="최상위 코드는 3자리여야 합니다.")
	@CheckValue(message="코드는 빈 값일 수 없습니다.")
	private String comCd;
	/** 상위공통코드 */
	
	@Size(max='3', message="최상위 코드는 3자리 까지여야 합니다.")
	@Pattern(regexp="^\\[A-Za-Z]*{3}$", message="영어 3자리입니다.")
	private String comUpCd;
	/** 공통코드명 */
	private String comCdName;
	private String comCdNameKo;
	private String comCdNameEn;
	private String comCdNameZh;
	private String comCdNameJa;
	/** 코드설명1 */
	private String cdDesc1;
	/** 코드설명2 */
	private String cdDesc2;
	/** 그룹FIX */
	private String grpFix;
	/** 등록일 */
	private String regDttm;
	private String regId;
	/** 표시여부 */
	@Size(max='1', message="표시 여부는 Y또는 N입니다.")
	@Pattern(regexp="Y|N" , message="표시 여부는 Y또는 N입니다")
	private String useYn;
	/** 화면표시순서 */
	@Size(max='3', message="순서는 숫자 3자리까지 입니다.")
	@Pattern(regexp="^[0-9]*{3}" , message="순서는 숫자 3자리까지 입니다")
	private String dspOrd;
	/** 화면표시순서 */
	private String pageIndex;
	
	/** 화면표시순서 */
	private String addVal1;
	private String addVal2;
	private String addVal3;
	
	private String viewFlg;
	private String crudFlg;
	private String lang = IConstants.LANG_KR;
	
	/** 검색단어 */
	
	private String searchWord;
	/** 검색시작일 */
	@Size(max=10, message="")
	@IsDate
    private String searchBgnDe;
    /** 검색종료일 */
	@Size(max=10, message="")
	@IsDate
    private String searchEndDe;
    
    /** 정렬 조건[DSP_ORD,REG_DATE] default:REG_DATE */
    private String orderTerm;
    /** 페이징 여부 */
    private String pagingYn= IConstants.Y;
    
    private List<CommonCodeVO> codeList;
    private List<CommonCodeVO> langList;
    
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
	public String getComCdName() {
		return comCdName;
	}
	public void setComCdName(String comCdName) {
		this.comCdName = comCdName;
	}
	public String getCdDesc1() {
		return cdDesc1;
	}
	public void setCdDesc1(String cdDesc1) {
		this.cdDesc1 = cdDesc1;
	}
	public String getCdDesc2() {
		return cdDesc2;
	}
	public void setCdDesc2(String cdDesc2) {
		this.cdDesc2 = cdDesc2;
	}
	public String getGrpFix() {
		return grpFix;
	}
	public void setGrpFix(String grpFix) {
		this.grpFix = grpFix;
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
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public String getDspOrd() {
		return dspOrd;
	}
	public void setDspOrd(String dspOrd) {
		this.dspOrd = dspOrd;
	}
		public String getSearchWord() {
		return searchWord;
	}
	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}
		public String getSearchBgnDe() {
		return searchBgnDe;
	}
	public void setSearchBgnDe(String searchBgnDe) {
		this.searchBgnDe = searchBgnDe;
	}
	public String getSearchEndDe() {
		return searchEndDe;
	}
	public void setSearchEndDe(String searchEndDe) {
		this.searchEndDe = searchEndDe;
	}
	public String getOrderTerm() {
		return orderTerm;
	}
	public void setOrderTerm(String orderTerm) {
		this.orderTerm = orderTerm;
	}
	public String getPagingYn() {
		return pagingYn;
	}
	public void setPagingYn(String pagingYn) {
		this.pagingYn = pagingYn;
	}
	public List<CommonCodeVO> getCodeList() {
		return codeList;
	}
	public void setCodeList(List<CommonCodeVO> codeList) {
		this.codeList = codeList;
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
	public String getViewFlg() {
		return viewFlg;
	}
	public void setViewFlg(String viewFlg) {
		this.viewFlg = viewFlg;
	}
	public String getCrudFlg() {
		return crudFlg;
	}
	public void setCrudFlg(String crudFlg) {
		this.crudFlg = crudFlg;
	}
	public String getLang() {
		return lang;
	}
	public void setLang(String lang) {
		this.lang = lang;
	}
	public String getPageIndex() {
		return pageIndex;
	}
	public String getComCdNameKo() {
		return comCdNameKo;
	}
	public void setComCdNameKo(String comCdNameKo) {
		this.comCdNameKo = comCdNameKo;
	}
	
	public String getComCdNameEn() {
		return comCdNameEn;
	}
	public void setComCdNameEn(String comCdNameEn) {
		this.comCdNameEn = comCdNameEn;
	}
	public String getComCdNameZh() {
		return comCdNameZh;
	}
	public void setComCdNameZh(String comCdNameZh) {
		this.comCdNameZh = comCdNameZh;
	}
	public String getComCdNameJa() {
		return comCdNameJa;
	}
	public void setComCdNameJa(String comCdNameJa) {
		this.comCdNameJa = comCdNameJa;
	}
	public void setPageIndex(String pageIndex) {
		this.pageIndex = pageIndex;
	}
	public List<CommonCodeVO> getLangList() {
		return langList;
	}
	public void setLangList(List<CommonCodeVO> langList) {
		this.langList = langList;
	}
    
}
