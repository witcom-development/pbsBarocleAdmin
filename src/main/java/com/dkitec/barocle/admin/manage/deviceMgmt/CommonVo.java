/*
 * @Package Name : com.dkitec.barocle.admin.manage.common
 * @파일명          : FileVo.java
 * @작성일          : 2015. 4. 17.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 17.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.manage.deviceMgmt;

import java.io.Serializable;

import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.springframework.web.multipart.MultipartFile;

import com.dkitec.barocle.base.IConstants;
import com.dkitec.barocle.util.egov.paging.VO.PagingVO;
import com.dkitec.barocle.util.validator.annotation.IsDate;

/**
 * @파일명          : FileVo.java
 * @작성일          : 2015. 4. 17.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 4. 17.   |   ymshin   |  최초작성
 */
@SuppressWarnings("serial")
public class CommonVo extends PagingVO implements Serializable {

	private String excelFlg;
	private MultipartFile bulkFile;
	private String viewFlg = IConstants.MODE_LIST;
	/** 검색단어 */
	private String searchType;
	private String searchWord;
	private String searchTypeName;
	/** 검색시작일 */
	@IsDate
    private String searchBgnDe;
    /** 검색종료일 */
	@IsDate
    private String searchEndDe;
    /** 정렬 조건[DSP_ORD,REG_DATE] default:REG_DATE */
    private String orderTerm;
    private String pagingYn = IConstants.Y;
	private String centerId;
	private String stationGrpSeq;
	private String stationGrpName;
	private String stationId;
	private String stationName;
	private String centerName;
	private String locateClsCd;
	private String locateId;
    private String lang = IConstants.LANG_KR;
	private String rglChkSearch;
	private String lastChkRemainDay;
	private String stationGrpId;

	
	public String getLastChkRemainDay() {
		return lastChkRemainDay;
	}
	public void setLastChkRemainDay(String lastChkRemainDay) {
		this.lastChkRemainDay = lastChkRemainDay;
	}
	public String getRglChkSearch() {
		return rglChkSearch;
	}
	public void setRglChkSearch(String rglChkSearch) {
		this.rglChkSearch = rglChkSearch;
	}
	public String getCenterName() {
		return centerName;
	}
	public void setCenterName(String centerName) {
		this.centerName = centerName;
	}
	public String getStationGrpSeq() {
		return stationGrpSeq;
	}
	public void setStationGrpSeq(String stationGrpSeq) {
		this.stationGrpSeq = stationGrpSeq;
	}
	public String getStationGrpName() {
		return stationGrpName;
	}
	public void setStationGrpName(String stationGrpName) {
		this.stationGrpName = stationGrpName;
	}
	public String getStationId() {
		return stationId;
	}
	public void setStationId(String stationId) {
		this.stationId = stationId;
	}
	public String getStationName() {
		return stationName;
	}
	public void setStationName(String stationName) {
		this.stationName = stationName;
	}
	public String getLang() {
		return lang;
	}
	public void setLang(String lang) {
		this.lang = lang;
	}
	public String getCenterId() {
		return centerId;
	}
	public void setCenterId(String centerId) {
		this.centerId = centerId;
	}
	public String getLocateClsCd() {
		return locateClsCd;
	}
	public void setLocateClsCd(String locateClsCd) {
		this.locateClsCd = locateClsCd;
	}
	public String getLocateId() {
		return locateId;
	}
	public void setLocateId(String locateId) {
		this.locateId = locateId;
	}
	public String getExcelFlg() {
		return excelFlg;
	}
	public void setExcelFlg(String excelFlg) {
		this.excelFlg = excelFlg;
	}
	public MultipartFile getBulkFile() {
		return bulkFile;
	}
	public void setBulkFile(MultipartFile bulkFile) {
		this.bulkFile = bulkFile;
	}
	
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public String getSearchWord() {
		return searchWord;
	}
	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}
	public String getSearchTypeName() {
		return searchTypeName;
	}
	public void setSearchTypeName(String searchTypeName) {
		this.searchTypeName = searchTypeName;
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
	public String getViewFlg() {
		return viewFlg;
	}
	public void setViewFlg(String viewFlg) {
		this.viewFlg = viewFlg;
	}
	public String getStationGrpId() {
		return stationGrpId;
	}
	public void setStationGrpId(String stationGrpId) {
		this.stationGrpId = stationGrpId;
	}
	
	
	
}
