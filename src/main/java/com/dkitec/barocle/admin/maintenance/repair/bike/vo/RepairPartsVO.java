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
package com.dkitec.barocle.admin.maintenance.repair.bike.vo;

import org.apache.ibatis.type.Alias;

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
@Alias("repairPartsVo")
public class RepairPartsVO {
    private String repairSeq;
	private String centerName;
	private String partsName;
	private String remainPartsCnt;
	private String usePartsCnt;
	private String chngType;
	private String chngCnt;
	private String modId;
	
	public String getRepairSeq() {
		return repairSeq;
	}
	public void setRepairSeq(String repairSeq) {
		this.repairSeq = repairSeq;
	}
	public String getCenterName() {
		return centerName;
	}
	public void setCenterName(String centerName) {
		this.centerName = centerName;
	}
	public String getPartsName() {
		return partsName;
	}
	public void setPartsName(String partsName) {
		this.partsName = partsName;
	}
	public String getRemainPartsCnt() {
		return remainPartsCnt;
	}
	public void setRemainPartsCnt(String remainPartsCnt) {
		this.remainPartsCnt = remainPartsCnt;
	}
	public String getUsePartsCnt() {
		return usePartsCnt;
	}
	public void setUsePartsCnt(String usePartsCnt) {
		this.usePartsCnt = usePartsCnt;
	}
	public String getChngType() {
		return chngType;
	}
	public void setChngType(String chngType) {
		this.chngType = chngType;
	}
	public String getChngCnt() {
		return chngCnt;
	}
	public void setChngCnt(String chngCnt) {
		this.chngCnt = chngCnt;
	}
	public String getModId() {
		return modId;
	}
	public void setModId(String modId) {
		this.modId = modId;
	}
}
