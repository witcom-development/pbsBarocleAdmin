/*
 * @Package Name : com.dkitec.barocle.admin.maintenance.stockMgmt.invent.vo
 * @파일명          : InventVO.java
 * @작성일          : 2015. 6. 1.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 6. 1.   |   ymshin   |  최초작성
 */ 
package com.dkitec.barocle.admin.maintenance.stockMgmt.invent.vo;

import java.io.Serializable;

import javax.validation.constraints.Pattern;

import org.apache.ibatis.type.Alias;
import org.springframework.web.multipart.MultipartFile;

import com.dkitec.barocle.admin.manage.deviceMgmt.CommonVo;
import com.dkitec.barocle.base.IConstants;
import com.dkitec.barocle.util.egov.paging.VO.PagingVO;
import com.dkitec.barocle.util.validator.annotation.CheckValue;
import com.dkitec.barocle.util.validator.annotation.IsStringNotNullNumeric;

/**
 * @파일명          : InventVO.java
 * @작성일          : 2015. 6. 1.
 * @작성자          : ymshin
 * @수정내용
 * -------------------------------------------------------------
 *      수정일      |      수정자      |              수정내용
 * -------------------------------------------------------------
 *    2015. 6. 1.   |   ymshin   |  최초작성
 */
@SuppressWarnings("serial")
@Alias("inventVo")
public class InventVO extends CommonVo implements Serializable/* extends PagingVO*/{
    
	@Pattern(regexp="^[A-Z]*[0-9]*$", message="형식이 일치하지 않습니다.")
	private String centerId;
	private String centerName;
	@Pattern(regexp="^[A-Z]*_[0-9]*$", message="형식이 일치하지 않습니다.")
	private String partCd;
	private String partName;
	private String stockQunt;
	@IsStringNotNullNumeric(message="숫자 형식이어야 합니다.")
	private String partQunt;
	private String useClsCd;
	private String useClsCdName;
	private String modReasonDesc;
	private String modId;
	private String modDttm;
	private String lang = IConstants.LANG_KR;
	/*private String viewFlg = IConstants.MODE_LIST;*/
	private String excelFlg;
	private MultipartFile bulkFile;
	
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
	/*public String getViewFlg() {
		return viewFlg;
	}
	public void setViewFlg(String viewFlg) {
		this.viewFlg = viewFlg;
	}*/
	public String getCenterId() {
		return centerId;
	}
	public void setCenterId(String centerId) {
		this.centerId = centerId;
	}
	public String getCenterName() {
		return centerName;
	}
	public void setCenterName(String centerName) {
		this.centerName = centerName;
	}
	public String getPartCd() {
		return partCd;
	}
	public void setPartCd(String partCd) {
		this.partCd = partCd;
	}
	public String getPartName() {
		return partName;
	}
	public void setPartName(String partName) {
		this.partName = partName;
	}
	public String getStockQunt() {
		return stockQunt;
	}
	public void setStockQunt(String stockQunt) {
		this.stockQunt = stockQunt;
	}
	public String getUseClsCd() {
		return useClsCd;
	}
	public void setUseClsCd(String useClsCd) {
		this.useClsCd = useClsCd;
	}
	
	public String getUseClsCdName() {
		return useClsCdName;
	}
	public void setUseClsCdName(String useClsCdName) {
		this.useClsCdName = useClsCdName;
	}
	public String getModId() {
		return modId;
	}
	public void setModId(String modId) {
		this.modId = modId;
	}
	public String getModDttm() {
		return modDttm;
	}
	public void setModDttm(String modDttm) {
		this.modDttm = modDttm;
	}
	public String getLang() {
		return lang;
	}
	public void setLang(String lang) {
		this.lang = lang;
	}
	public String getPartQunt() {
		return partQunt;
	}
	public void setPartQunt(String partQunt) {
		this.partQunt = partQunt;
	}
	public String getModReasonDesc() {
		return modReasonDesc;
	}
	public void setModReasonDesc(String modReasonDesc) {
		this.modReasonDesc = modReasonDesc;
	}
	
}
